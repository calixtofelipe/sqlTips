htDar previlegio a usuario 
grant execute on utl_file to <user>
execute blob_to_file('DIR_ANEXO','AD_ANEXOFIN','NOME','IMAGEM');

create or replace procedure blob_to_file (p_diretorio varchar,
                                          p_tabela    varchar,
                                          p_col_nome  varchar,
                                          p_col_blob  varchar) is
     type cur_blob_type is ref cursor;
     cur_blob      cur_blob_type;
     v_open_mode   varchar2(2) := 'wb';
     v_tamlinha    number := 32000;
     v_buffer      raw(32000);
     v_posicao     number := 1;
     v_arquivo     utl_file.file_type;
     v_imagem      blob;
     v_nome        varchar2(100);
     v_len         number;
     v_aux_len     number;
  begin
     open cur_blob for
      'select '||p_col_blob||' col_blob,'||p_col_nome||' nome_blob,
       dbms_lob.getlength('||p_col_blob||') tamanho from '||p_tabela||'';
     loop
         fetch cur_blob into v_imagem, v_nome, v_len;
         exit when cur_blob%notfound;
         v_arquivo := utl_file.fopen (upper(p_diretorio),v_nome,v_open_mode,32760);
         dbms_output.put_line('Finalizada a leitura de '||
                              to_char(v_len)||
                              ' bytes'||
                              ' para o arquivo: '||
                              v_nome);
         v_posicao := 1;
         v_tamlinha := 32000;
         v_aux_len := v_len;
         if v_len < 32760
         then
            utl_file.put_raw (v_arquivo, v_imagem);
            dbms_output.put_line('Finalizada a leitura de '||
                                 to_char(v_posicao)||
                                 ' bytes'||
                                 ' para o arquivo: '||
                                 v_nome);
            utl_file.fflush (v_arquivo);
         else
            v_posicao := 1;
            while v_posicao < v_len and v_tamlinha > 0
            loop
               dbms_lob.read (v_imagem,v_tamlinha,v_posicao,v_buffer);
               utl_file.put_raw (v_arquivo, v_buffer);
               dbms_output.put_line('Finalizada a leitura de '||
                                    to_char(v_posicao)||
                                    ' bytes'||
                                    ' para o arquivo: '||
                                    v_nome);
               utl_file.fflush (v_arquivo);
               v_posicao := v_posicao + v_tamlinha;
               v_aux_len := v_aux_len - v_tamlinha;
               if v_aux_len < 32000
               then
                  v_tamlinha := v_aux_len;
               end if;
            end loop;
         end if;
         utl_file.fclose (v_arquivo);
         dbms_output.put_line ('Arquivo criado em disco com sucesso');
     end loop;
  end;
  /
