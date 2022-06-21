Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D52C553AB7
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351199AbiFUTlg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 15:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348473AbiFUTlf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 15:41:35 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB596157
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 12:41:34 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id s1so7201137vkl.3
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JSx/Z7UuDVspHgcw7nI7XB9P3bW+N9r4foMzAYckQm4=;
        b=ID5ZP8iEVlOe4J3hi2e53A57E6H3CMhc8L9YulsnmPdNIO/uvu23nxZl69osig/cKW
         FY2iWID7QGtQwPhXh/vwdybrPb0FRi6MXWD/qvD/0KR3jfNGTs2AwSyTe131vSfAbp22
         2JlhLY6p8S6upoqaD3w9XbwWo7iFRXornfodxku3ydh1/pRoEYJFHxkTBNxKPQvIJsjc
         wL8gFJnQGUE3ovK1TfeKTcx+3infoc8XkmT84IX1S9zTka7Xk8K7fEAIS6z94gM4VPOx
         z8U6iRJha+4quvwnTm66Gx49KDd5LGqXSUXVzEZppT0BASgf0YobVkYwhZQV7Zk7YdWE
         D/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JSx/Z7UuDVspHgcw7nI7XB9P3bW+N9r4foMzAYckQm4=;
        b=v1VsIg1uZm9JgeLa0n1uOZ+hyMsBa1z5NzfZVsURzEDqnaULObk566iCrohOlCSIe1
         WXW6jIcfMrLu7BNw8QD+lDkvvgiiSaRlYklXlUpGPXfHmnCKAYsB0+64RNMd6qTtwjNm
         PQtfCe1knKKVHb7aWcDpxTNXGW46tJqmcFG37LQyYE08C2xwlGiFQP6fYOwV4GxyKM+F
         l9nXak4sMLqopjaLeEPgKeFmMJupCrttfx50HgDCVqMNLkzDw1y59cN7K8m9SebY19Sj
         MjCze8HPy98zCbPDUsxJKaLQbtQpzYn/cxIn2qie3dBnH44a7LsrETilEfUDKKZiIoCy
         +Dvw==
X-Gm-Message-State: AJIora9ZrVP+NlsvxVU4wqEYOQP8x3qbcijdoLuPAq0s30loIUoykTPO
        6l6OrlEuOQsATNPQZwS6XS4S9zbpjQBPcnvb3jk=
X-Google-Smtp-Source: AGRyM1vOZRNvu/ak3yqI2FLZIquRU1ixind0A27uQ2nS94PDrye4P5pC8+bHvs7JDcNC5usPWLRrnkuL09pZyERxH+Q=
X-Received: by 2002:a05:6122:1399:b0:36c:51b4:57b5 with SMTP id
 m25-20020a056122139900b0036c51b457b5mr3401562vkp.25.1655840493850; Tue, 21
 Jun 2022 12:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220620231713.2143355-1-deso@posteo.net> <20220620231713.2143355-4-deso@posteo.net>
In-Reply-To: <20220620231713.2143355-4-deso@posteo.net>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 21 Jun 2022 12:41:22 -0700
Message-ID: <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add type match support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

 On Mon, Jun 20, 2022 at 4:25 PM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> This change implements the kernel side of the "type matches" support.
> Please refer to the next change ("libbpf: Add type match support") for
> more details on the relation. This one is first in the stack because
> the follow-on libbpf changes depend on it.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  include/linux/btf.h |   5 +
>  kernel/bpf/btf.c    | 267 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 272 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 1bfed7..7376934 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -242,6 +242,11 @@ static inline u8 btf_int_offset(const struct btf_typ=
e *t)
>         return BTF_INT_OFFSET(*(u32 *)(t + 1));
>  }
>
> +static inline u8 btf_int_bits(const struct btf_type *t)
> +{
> +       return BTF_INT_BITS(*(__u32 *)(t + 1));
nit: u32 here instead of __u32
> +}
> +
>  static inline u8 btf_int_encoding(const struct btf_type *t)
>  {
>         return BTF_INT_ENCODING(*(u32 *)(t + 1));
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f08037..3790b4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7524,6 +7524,273 @@ int bpf_core_types_are_compat(const struct btf *l=
ocal_btf, __u32 local_id,
>                                            MAX_TYPES_ARE_COMPAT_DEPTH);
>  }
>
> +#define MAX_TYPES_MATCH_DEPTH 2
> +
> +static bool bpf_core_names_match(const struct btf *local_btf, u32 local_=
id,
> +                                const struct btf *targ_btf, u32 targ_id)
> +{
> +       const struct btf_type *local_t, *targ_t;
> +       const char *local_n, *targ_n;
> +       size_t local_len, targ_len;
> +
> +       local_t =3D btf_type_by_id(local_btf, local_id);
> +       targ_t =3D btf_type_by_id(targ_btf, targ_id);
> +       local_n =3D btf_str_by_offset(local_btf, local_t->name_off);
> +       targ_n =3D btf_str_by_offset(targ_btf, targ_t->name_off);
> +       local_len =3D bpf_core_essential_name_len(local_n);
> +       targ_len =3D bpf_core_essential_name_len(targ_n);
nit: i personally think this would be a little visually easier to read
if there was a line space between targ_t and local_n, and between
targ_n and local_len
> +
> +       return local_len =3D=3D targ_len && strncmp(local_n, targ_n, loca=
l_len) =3D=3D 0;
Does calling "return !strcmp(local_n, targ_n);" do the same thing here?
> +}
> +
> +static int bpf_core_enums_match(const struct btf *local_btf, const struc=
t btf_type *local_t,
I find the return values a bit confusing here.  The convention in
linux is to return 0 for the success case. Maybe I'm totally missing
something here, but is there a reason this doesn't just return a
boolean?
> +                               const struct btf *targ_btf, const struct =
btf_type *targ_t)
> +{
> +       u16 local_vlen =3D btf_vlen(local_t);
> +       u16 targ_vlen =3D btf_vlen(targ_t);
> +       int i, j;
> +
> +       if (local_t->size !=3D targ_t->size)
> +               return 0;
> +
> +       if (local_vlen > targ_vlen)
> +               return 0;
> +
> +       /* iterate over the local enum's variants and make sure each has
> +        * a symbolic name correspondent in the target
> +        */
> +       for (i =3D 0; i < local_vlen; i++) {
> +               bool matched =3D false;
> +               const char *local_n;
> +               __u32 local_n_off;
nit: u32 instead of __u32 :)
> +               size_t local_len;
> +
> +               local_n_off =3D btf_is_enum(local_t) ? btf_type_enum(loca=
l_t)[i].name_off :
> +                                                    btf_type_enum64(loca=
l_t)[i].name_off;
> +
> +               local_n =3D btf_name_by_offset(local_btf, local_n_off);
> +               local_len =3D bpf_core_essential_name_len(local_n);
> +
> +               for (j =3D 0; j < targ_vlen; j++) {
> +                       const char *targ_n;
> +                       __u32 targ_n_off;
> +                       size_t targ_len;
> +
> +                       targ_n_off =3D btf_is_enum(targ_t) ? btf_type_enu=
m(targ_t)[j].name_off :
> +                                                          btf_type_enum6=
4(targ_t)[j].name_off;
> +                       targ_n =3D btf_name_by_offset(targ_btf, targ_n_of=
f);
> +
> +                       if (str_is_empty(targ_n))
> +                               continue;
> +
> +                       targ_len =3D bpf_core_essential_name_len(targ_n);
> +
> +                       if (local_len =3D=3D targ_len && strncmp(local_n,=
 targ_n, local_len) =3D=3D 0) {
same question here - does strcmp suffice?
> +                               matched =3D true;
> +                               break;
> +                       }
> +               }
> +
> +               if (!matched)
> +                       return 0;
> +       }
> +       return 1;
> +}
> +
> +static int __bpf_core_types_match(const struct btf *local_btf, u32 local=
_id,
> +                                 const struct btf *targ_btf, u32 targ_id=
, int level);
> +
> +static int bpf_core_composites_match(const struct btf *local_btf, const =
struct btf_type *local_t,
Same question here - is there a reason this doesn't use a boolean as
its return value?

> +                                    const struct btf *targ_btf, const st=
ruct btf_type *targ_t,
> +                                    int level)
> +{
> +       /* check that all local members have a match in the target */
> +       const struct btf_member *local_m =3D btf_members(local_t);
> +       u16 local_vlen =3D btf_vlen(local_t);
> +       u16 targ_vlen =3D btf_vlen(targ_t);
> +       int i, j, err;
> +
> +       if (local_vlen > targ_vlen)
> +               return 0;
> +
> +       for (i =3D 0; i < local_vlen; i++, local_m++) {
> +               const char *local_n =3D btf_name_by_offset(local_btf, loc=
al_m->name_off);
> +               const struct btf_member *targ_m =3D btf_members(targ_t);
> +               bool matched =3D false;
> +
> +               for (j =3D 0; j < targ_vlen; j++, targ_m++) {
> +                       const char *targ_n =3D btf_name_by_offset(targ_bt=
f, targ_m->name_off);
> +
> +                       if (str_is_empty(targ_n))
> +                               continue;
> +
> +                       if (strcmp(local_n, targ_n) !=3D 0)
> +                               continue;
> +
> +                       err =3D __bpf_core_types_match(local_btf, local_m=
->type, targ_btf,
> +                                                    targ_m->type, level =
- 1);
> +                       if (err > 0) {
> +                               matched =3D true;
> +                               break;
> +                       }
> +               }
> +
> +               if (!matched)
> +                       return 0;
> +       }
> +       return 1;
> +}
> +
> +static int __bpf_core_types_match(const struct btf *local_btf, u32 local=
_id,
I personally think it's cleaner (though more verbose) if a boolean
return arg is passed in to denote whether there's a match, instead of
returning error, 0 for not a match, and 1 for a match
> +                                 const struct btf *targ_btf, u32 targ_id=
, int level)
> +{
> +       const struct btf_type *local_t, *targ_t, *prev_local_t;
> +       int depth =3D 32; /* max recursion depth */
> +       __u16 local_k;
nit: u16 and elsewhere in this function
> +
> +       if (level <=3D 0)
> +               return -EINVAL;
> +
> +       local_t =3D btf_type_by_id(local_btf, local_id);
> +       targ_t =3D btf_type_by_id(targ_btf, targ_id);
> +
> +recur:
> +       depth--;
> +       if (depth < 0)
> +               return -EINVAL;
> +
> +       prev_local_t =3D local_t;
> +
> +       local_t =3D btf_type_skip_modifiers(local_btf, local_id, &local_i=
d);
> +       targ_t =3D btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
> +       if (!local_t || !targ_t)
> +               return -EINVAL;
> +
> +       if (!bpf_core_names_match(local_btf, local_id, targ_btf, targ_id)=
)
> +               return 0;
> +
> +       local_k =3D btf_kind(local_t);
> +
> +       switch (local_k) {
> +       case BTF_KIND_UNKN:
> +               return local_k =3D=3D btf_kind(targ_t);
> +       case BTF_KIND_FWD: {
> +               bool local_f =3D btf_type_kflag(local_t);
> +               __u16 targ_k =3D btf_kind(targ_t);
> +
> +               if (btf_is_ptr(prev_local_t)) {
> +                       if (local_k =3D=3D targ_k)
> +                               return local_f =3D=3D btf_type_kflag(loca=
l_t);
> +
> +                       return (targ_k =3D=3D BTF_KIND_STRUCT && !local_f=
) ||
> +                              (targ_k =3D=3D BTF_KIND_UNION && local_f);
I think it'd be helpful if a comment was included here that the kind
flag for BTF_KIND_FWD is 0 for struct and 1 for union
> +               } else {
> +                       if (local_k !=3D targ_k)
> +                               return 0;
> +
> +                       /* match if the forward declaration is for the sa=
me kind */
> +                       return local_f =3D=3D btf_type_kflag(local_t);
> +               }
> +       }
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
> +               if (!btf_is_any_enum(targ_t))
> +                       return 0;
> +
> +               return bpf_core_enums_match(local_btf, local_t, targ_btf,=
 targ_t);
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION: {
> +               __u16 targ_k =3D btf_kind(targ_t);
> +
> +               if (btf_is_ptr(prev_local_t)) {
> +                       bool targ_f =3D btf_type_kflag(local_t);
Did you mean btf_type_kflag(targ_t)?
> +
> +                       if (local_k =3D=3D targ_k)
> +                               return 1;
Why don't we need to check if bpf_core_composites_match() in this case?
> +
> +                       if (targ_k !=3D BTF_KIND_FWD)
> +                               return 0;
Can there be the case where targ_k is a BTF_KIND_PTR to the same struct/uni=
on?
> +
> +                       return (local_k =3D=3D BTF_KIND_UNION) =3D=3D tar=
g_f;
> +               } else {
> +                       if (local_k !=3D targ_k)
> +                               return 0;
> +
> +                       return bpf_core_composites_match(local_btf, local=
_t, targ_btf, targ_t,
> +                                                        level);
> +               }
> +       }
> +       case BTF_KIND_INT: {
> +               __u8 local_sgn;
> +               __u8 targ_sgn;
> +
> +               if (local_k !=3D btf_kind(targ_t))
> +                       return 0;
> +
> +               local_sgn =3D btf_int_encoding(local_t) & BTF_INT_SIGNED;
> +               targ_sgn =3D btf_int_encoding(targ_t) & BTF_INT_SIGNED;
> +
> +               return btf_int_bits(local_t) =3D=3D btf_int_bits(targ_t) =
&& local_sgn =3D=3D targ_sgn;
> +       }
> +       case BTF_KIND_PTR:
> +               if (local_k !=3D btf_kind(targ_t))
> +                       return 0;
> +
> +               local_id =3D local_t->type;
> +               targ_id =3D targ_t->type;
> +               goto recur;
> +       case BTF_KIND_ARRAY: {
> +               const struct btf_array *local_array =3D btf_type_array(lo=
cal_t);
> +               const struct btf_array *targ_array =3D btf_type_array(tar=
g_t);
> +
> +               if (local_k !=3D btf_kind(targ_t))
> +                       return 0;
> +
> +               if (local_array->nelems !=3D targ_array->nelems)
> +                       return 0;
> +
> +               local_id =3D local_array->type;
> +               targ_id =3D targ_array->type;
> +               goto recur;
> +       }
> +       case BTF_KIND_FUNC_PROTO: {
> +               struct btf_param *local_p =3D btf_params(local_t);
> +               struct btf_param *targ_p =3D btf_params(targ_t);
> +               u16 local_vlen =3D btf_vlen(local_t);
> +               u16 targ_vlen =3D btf_vlen(targ_t);
> +               int i, err;
> +
> +               if (local_k !=3D btf_kind(targ_t))
> +                       return 0;
> +
> +               if (local_vlen !=3D targ_vlen)
> +                       return 0;
> +
> +               for (i =3D 0; i < local_vlen; i++, local_p++, targ_p++) {
> +                       err =3D __bpf_core_types_match(local_btf, local_p=
->type, targ_btf,
> +                                                    targ_p->type, level =
- 1);
> +                       if (err <=3D 0)
> +                               return err;
> +               }
> +
> +               /* tail recurse for return type check */
> +               local_id =3D local_t->type;
> +               targ_id =3D targ_t->type;
> +               goto recur;
> +       }
> +       default:
Do BTF_KIND_FLOAT and BTF_KIND_TYPEDEF need to be checked as well?
> +               return 0;
> +       }
> +}
> +
> +int bpf_core_types_match(const struct btf *local_btf, u32 local_id,
> +                        const struct btf *targ_btf, u32 targ_id)
> +{
> +       return __bpf_core_types_match(local_btf, local_id,
> +                                     targ_btf, targ_id,
> +                                     MAX_TYPES_MATCH_DEPTH);
> +}
Also, btw, thanks for the thorough cover letter - its high-level
overview made it easier to understand the patches
> +
>  static bool bpf_core_is_flavor_sep(const char *s)
>  {
>         /* check X___Y name pattern, where X and Y are not underscores */
> --
> 2.30.2
>
