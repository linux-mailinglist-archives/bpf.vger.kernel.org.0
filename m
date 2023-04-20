Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849B66E86B0
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDTAno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDTAnn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:43:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262A2D42;
        Wed, 19 Apr 2023 17:43:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5051abd03a7so384642a12.2;
        Wed, 19 Apr 2023 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681951417; x=1684543417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5aAdRJlAiwxnbAriqN3MTimbQ3RjpLC3Gmmt10yCig=;
        b=Nqy3TpI8hpmPokS4SGlb7RcHKu4gbxbpf9stV6jqIQTrELLP5pD+4yAXrUSbvf3Xq6
         5mrE3Ma7Kxfo4HjlzQmLKUMOq7PuO1xjcq0bYNN2QvIqTybeFSHHDOhCwayoxIKU2Deh
         GoMezkQnOtyh8bj8CcfjH02T3DP91abyMuZxcA8atfoWi3P53l+z3Z3/uZDqEyeyjgld
         wKXpG7DefP3C0RU5+MLKK35tN04kE1w4cT+Qs6svk3J11Z1h6LYaJAkkKBvTgoboL6a4
         hf3/LA8qztUDCO3cZl0dlUvbqSxxMFJxh1lrBwiN8iPtaYIXHaPztyJjU/OqtbVTmXKi
         +ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951417; x=1684543417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5aAdRJlAiwxnbAriqN3MTimbQ3RjpLC3Gmmt10yCig=;
        b=TNItVUpqCcA9r71u9VA2zpHUx3UMAT8J6WKHy27TIpprFmnKFufDCC/poNf8RWz+2K
         gqZm0lPeyXCfmlxzC6weCp9G1dNURkTxk81tuMq/2BY/3lnJjQ2J0rylQJ9hVa5/iAEQ
         IOIZtAH2wbH/35AF7iEeOdXnjGnjDGIqjxvzriMlF5ZR8q0QXxaUcSI5U0TEQkOUHGyn
         e0lS/SO9O3W8YPdFPwUog0xQUw48aS8XrZ3SBget9wQEXH/7RXQJYIXbOqHSz+18Tj8E
         QbNifS1u6cHo4ndlrvGxdVERpcF6G1Gx/WEyWm9V/tDwOnqLfkHoJY0Ow90v5ukDck5A
         /gQw==
X-Gm-Message-State: AAQBX9ebfeEuvc7Owm9fyTRQ27Ei5KI6nLZlDnPrKWCXs+IRQEvPJWJD
        BNMwypDP/yeiyTt7oETJ/GJ9gKod+d5POZ3LB/0=
X-Google-Smtp-Source: AKy350bsiml96VWsHLFGs1EYCgDUmxYrmHStWuecCdq62esfm7p4e6eUN4mttsEITUVV3hR6GO5SDND/wvi9FmsRn3k=
X-Received: by 2002:aa7:c58c:0:b0:500:2cc6:36da with SMTP id
 g12-20020aa7c58c000000b005002cc636damr8392768edq.19.1681951417459; Wed, 19
 Apr 2023 17:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <ZD2fNzhzFRHmywRv@eg>
In-Reply-To: <ZD2fNzhzFRHmywRv@eg>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Apr 2023 17:43:25 -0700
Message-ID: <CAEf4Bzba8ae6RBErrJZK7vN3exu50U0FUGOe0gLFebDfXuFe7A@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Improve version handling when attaching uprobe
To:     Espen Grindhaug <espen.grindhaug@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cc Alan, can you please take a look, as you've worked on this code previous=
ly

On Mon, Apr 17, 2023 at 12:34=E2=80=AFPM Espen Grindhaug
<espen.grindhaug@gmail.com> wrote:
>
> This change fixes the handling of versions in elf_find_func_offset.
> In the previous implementation, we incorrectly assumed that the
> version information would be present in the string found in the
> string table.
>
> We now look up the correct version string in the version symbol
> table before constructing the full name and then comparing.
>
> This patch adds support for both name@version and name@@version to
> match output of the various elf parsers.
>
> Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
> ---

Espen, can you please also add a test to exercise this logic? We can
probably reuse urandom_read_lib and make sure we have versioned
symbols in it, and then try to attach to specific version or
something.

>  tools/lib/bpf/libbpf.c | 148 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 129 insertions(+), 19 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 49cd304ae3bc..ef5e11ce6241 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10620,31 +10620,94 @@ static int perf_event_uprobe_open_legacy(const =
char *probe_name, bool retprobe,
>  }
>
>  /* Return next ELF section of sh_type after scn, or first of that type i=
f scn is NULL. */
> -static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn=
 *scn)
> +static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn=
 *scn, size_t *idx)
>  {
>         while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
>                 GElf_Shdr sh;
>
>                 if (!gelf_getshdr(scn, &sh))
>                         continue;
> -               if (sh.sh_type =3D=3D sh_type)
> +               if (sh.sh_type =3D=3D sh_type) {
> +                       if (idx)
> +                               *idx =3D sh.sh_link;
>                         return scn;
> +               }
> +       }
> +       return NULL;
> +}
> +
> +static Elf_Data *elf_find_data_by_type(Elf *elf, int sh_type, size_t *id=
x)
> +{
> +       Elf_Scn *scn =3D elf_find_next_scn_by_type(elf, sh_type, NULL, id=
x);
> +
> +       if (scn)
> +               return elf_getdata(scn, NULL);
> +
> +       return NULL;
> +}
> +
> +static Elf64_Verdef *elf_verdef_by_offset(Elf_Data *data, size_t offset)
> +{
> +       if (offset + sizeof(Elf64_Verdef) > data->d_size)
> +               return NULL;
> +
> +       return (Elf64_Verdef *)((char *) data->d_buf + offset);
> +}
> +
> +static Elf64_Versym *elf_versym_by_idx(Elf_Data *data, size_t idx)
> +{
> +       if (idx >=3D data->d_size / sizeof(Elf64_Versym))
> +               return NULL;
> +
> +       return (Elf64_Versym *)(data->d_buf + idx * sizeof(Elf64_Versym))=
;
> +}
> +
> +static Elf64_Verdaux *elf_verdaux_by_offset(Elf_Data *data, size_t offse=
t)
> +{
> +       if (offset + sizeof(Elf64_Verdaux) > data->d_size)
> +               return NULL;
> +
> +       return (Elf64_Verdaux *)((char *) data->d_buf + offset);
> +}
> +
> +#define ELF_VERSYM_HIDDEN 0x8000
> +#define ELF_VERSYM_IDX_MASK 0x7fff
> +
> +static Elf64_Verdaux *elf_get_verdaux_by_versym(Elf_Data *verdef_data, E=
lf64_Versym *versym)
> +{
> +       size_t offset =3D 0;
> +
> +       while (offset + sizeof(Elf64_Verdef) <=3D verdef_data->d_size) {
> +               Elf64_Verdef *verdef =3D elf_verdef_by_offset(verdef_data=
, offset);
> +
> +               if (!verdef)
> +                       break;
> +
> +               if (verdef->vd_ndx =3D=3D (*versym & ELF_VERSYM_IDX_MASK)=
)
> +                       return elf_verdaux_by_offset(verdef_data, offset =
+ verdef->vd_aux);
> +
> +               if (verdef->vd_next =3D=3D 0)
> +                       break;
> +
> +               offset +=3D verdef->vd_next;
>         }
>         return NULL;
>  }
>
>  /* Find offset of function name in the provided ELF object. "binary_path=
" is
>   * the path to the ELF binary represented by "elf", and only used for er=
ror
> - * reporting matters. "name" matches symbol name or name@@LIB for librar=
y
> - * functions.
> + * reporting matters. "name" matches symbol name, name@LIB or name@@LIB =
for
> + * library functions.
>   */
>  static long elf_find_func_offset(Elf *elf, const char *binary_path, cons=
t char *name)
>  {
>         int i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
>         bool is_shared_lib, is_name_qualified;
>         long ret =3D -ENOENT;
> -       size_t name_len;
>         GElf_Ehdr ehdr;
> +       Elf_Data *versym_data =3D NULL;
> +       Elf_Data *verdef_data =3D NULL;
> +       size_t verdef_stridx =3D 0;
>
>         if (!gelf_getehdr(elf, &ehdr)) {
>                 pr_warn("elf: failed to get ehdr from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
> @@ -10654,9 +10717,12 @@ static long elf_find_func_offset(Elf *elf, const=
 char *binary_path, const char *
>         /* for shared lib case, we do not need to calculate relative offs=
et */
>         is_shared_lib =3D ehdr.e_type =3D=3D ET_DYN;
>
> -       name_len =3D strlen(name);
> -       /* Does name specify "@@LIB"? */
> -       is_name_qualified =3D strstr(name, "@@") !=3D NULL;
> +       /* Does name specify "@@LIB" or "@LIB"? */
> +       is_name_qualified =3D strstr(name, "@") !=3D NULL;
> +
> +       /* Extract version definition and version symbol table */
> +       versym_data =3D elf_find_data_by_type(elf, SHT_GNU_versym, NULL);
> +       verdef_data =3D elf_find_data_by_type(elf, SHT_GNU_verdef, &verde=
f_stridx);
>
>         /* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is=
 used because if
>          * a binary is stripped, it may only have SHT_DYNSYM, and a fully=
-statically
> @@ -10671,10 +10737,10 @@ static long elf_find_func_offset(Elf *elf, cons=
t char *binary_path, const char *
>                 const char *sname;
>                 GElf_Shdr sh;
>
> -               scn =3D elf_find_next_scn_by_type(elf, sh_types[i], NULL)=
;
> +               scn =3D elf_find_next_scn_by_type(elf, sh_types[i], NULL,=
 NULL);
>                 if (!scn) {
>                         pr_debug("elf: failed to find symbol table ELF se=
ctions in '%s'\n",
> -                                binary_path);
> +                               binary_path);
>                         continue;
>                 }
>                 if (!gelf_getshdr(scn, &sh))
> @@ -10705,16 +10771,60 @@ static long elf_find_func_offset(Elf *elf, cons=
t char *binary_path, const char *
>                         if (!sname)
>                                 continue;
>
> -                       curr_bind =3D GELF_ST_BIND(sym.st_info);
> +                       if (is_name_qualified) {
> +                               Elf64_Versym *versym;
> +                               Elf64_Verdaux *verdaux;
> +                               int res;
> +                               char full_name[256];
>
> -                       /* User can specify func, func@@LIB or func@@LIB_=
VERSION. */
> -                       if (strncmp(sname, name, name_len) !=3D 0)
> -                               continue;
> -                       /* ...but we don't want a search for "foo" to mat=
ch 'foo2" also, so any
> -                        * additional characters in sname should be of th=
e form "@@LIB".
> -                        */
> -                       if (!is_name_qualified && sname[name_len] !=3D '\=
0' && sname[name_len] !=3D '@')
> -                               continue;
> +                               /* check that name at least starts with s=
name before building
> +                                * the full name
> +                                */
> +                               if (strncmp(name, sname, strlen(sname)) !=
=3D 0)
> +                                       continue;
> +
> +                               if (!versym_data || !verdef_data) {
> +                                       pr_warn("elf: failed to find vers=
ion definition or version symbol table in '%s'\n",
> +                                               binary_path);
> +                                       break;
> +                               }
> +
> +                               versym =3D elf_versym_by_idx(versym_data,=
 idx);
> +                               if (!versym) {
> +                                       pr_warn("elf: failed to lookup ve=
rsym for '%s' in '%s'\n",
> +                                               sname, binary_path);
> +                                       continue;
> +                               }
> +
> +                               verdaux =3D elf_get_verdaux_by_versym(ver=
def_data, versym);
> +                               if (!verdaux) {
> +                                       pr_warn("elf: failed to lookup ve=
rdaux for '%s' in '%s'\n",
> +                                               sname, binary_path);
> +                                       continue;
> +                               }
> +
> +                               res =3D snprintf(full_name, sizeof(full_n=
ame),
> +                                              (*versym & ELF_VERSYM_HIDD=
EN) ? "%s@%s" :
> +                                                                   "%s@@=
%s",
> +                                              sname,
> +                                              elf_strptr(elf, verdef_str=
idx,
> +                                                         verdaux->vda_na=
me));
> +
> +                               if (res < 0 || res >=3D sizeof(full_name)=
) {
> +                                       pr_warn("elf: failed to build ful=
l name for '%s' in '%s'\n",
> +                                               sname, binary_path);
> +                                       continue;
> +                               }
> +
> +                               if (strcmp(full_name, name) !=3D 0)
> +                                       continue;
> +                       } else {
> +                               /* If name is not qualified, we want to m=
atch the symbol name */
> +                               if (strcmp(sname, name) !=3D 0)
> +                                       continue;
> +                       }
> +
> +                       curr_bind =3D GELF_ST_BIND(sym.st_info);
>
>                         if (ret >=3D 0) {
>                                 /* handle multiple matches */
> --
> 2.34.1
>
