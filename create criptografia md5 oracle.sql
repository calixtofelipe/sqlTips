select standard_hash('foo', 'MD5') from dual;

select rawtohex(
    DBMS_CRYPTO.Hash (
        UTL_I18N.STRING_TO_RAW ('foo', 'AL32UTF8'),
        2)
    ) from dual;