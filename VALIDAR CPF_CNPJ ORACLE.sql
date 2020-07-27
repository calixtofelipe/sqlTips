CREATE OR REPLACE FUNCTION VALIDA_CPF_CNPJ(V_CPF_CNPJ VARCHAR2) RETURN BOOLEAN IS
  TYPE ARRAY_DV IS VARRAY(2) OF PLS_INTEGER;
  V_ARRAY_DV ARRAY_DV := ARRAY_DV(0, 0);
  CPF_DIGIT  CONSTANT PLS_INTEGER := 11;
  CNPJ_DIGIT CONSTANT PLS_INTEGER := 14; 
  IS_CPF       BOOLEAN;
  IS_CNPJ      BOOLEAN;
  V_CPF_NUMBER VARCHAR2(20);
  TOTAL        NUMBER := 0;
  COEFICIENTE  NUMBER := 0;
  DV1    NUMBER := 0;
  DV2    NUMBER := 0;
  DIGITO NUMBER := 0;
  J      INTEGER;
  I      INTEGER;
BEGIN
  IF V_CPF_CNPJ IS NULL THEN
    RETURN FALSE;
  END IF; 

  IS_CNPJ := (LENGTH(V_CPF_NUMBER) = CNPJ_DIGIT);
  IF (IS_CPF OR IS_CNPJ) THEN
    TOTAL := 0;
  ELSE
    RETURN FALSE;
  END IF;

  DV1 := TO_NUMBER(SUBSTR(V_CPF_NUMBER, LENGTH(V_CPF_NUMBER) - 1, 1));
  DV2 := TO_NUMBER(SUBSTR(V_CPF_NUMBER, LENGTH(V_CPF_NUMBER), 1)); 
  V_ARRAY_DV(1) := 0;
  V_ARRAY_DV(2) := 0; 

  FOR J IN 1 .. 2
  LOOP
    TOTAL := 0;
    COEFICIENTE := 2;
    FOR I IN REVERSE 1 .. ((LENGTH(V_CPF_NUMBER) - 3) + J)
    LOOP
      DIGITO := TO_NUMBER(SUBSTR(V_CPF_NUMBER, I, 1));
      TOTAL := TOTAL + (DIGITO * COEFICIENTE);   
      COEFICIENTE := COEFICIENTE + 1;
      IF (COEFICIENTE > 9) AND IS_CNPJ THEN
        COEFICIENTE := 2;
      END IF;   
    END LOOP; --for i
    V_ARRAY_DV(J) := 11 - MOD(TOTAL, 11);
    IF (V_ARRAY_DV(J) >= 10) THEN
      V_ARRAY_DV(J) := 0;
    END IF; 
  END LOOP; --for j in 1..2

  RETURN(DV1 = V_ARRAY_DV(1)) AND(DV2 = V_ARRAY_DV(2)); 
END VALIDA_CPF_CNPJ;


select cpf, cast(dig1 || dig2 as varchar2(2)) dv
  from dual
model dimension by (1 as x)
measures (lpad(111222333, 9, '0') as cpf, 0 as m1, 0 as dig1, 0 as m2, 0 as dig2, cast(null as varchar2(10)) as cpfdv)
rules iterate (10)
(  m1[1] = m1[1] + (nvl(substr(cpf[1], iteration_number + 1, 1), 0) * (10 - iteration_number)),
  dig1[1] = case when mod(m1[1], 11) < 2 then 0 else 11 - mod(m1[1], 11) end,
cpfdv[1] = cpf[1] || dig1[1],
    m2[1] = m2[1] + (nvl(substr(cpfdv[1], iteration_number + 1, 1), 0) * (11 - iteration_number)),
  dig2[1] = case when mod(m2[1], 11) < 2 then 0 else 11 - mod(m2[1], 11) end); 