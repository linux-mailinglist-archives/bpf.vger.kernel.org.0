Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8C55A3BE
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiFXVjO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiFXVjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:39:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFCD87B56
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:39:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c13so5171726eds.10
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oiXIqBbsbwx29Jr67d4QTZ21Bgj9h6e88PisGVFmk0o=;
        b=SqrfI4qIxbG+RdNW2ClGrRj3S4WG+1k1BUwmtZSnqfYwtcHBTXfS1rBX1LeKvCDkJJ
         iUdD0dmaHlFxFcXOT9hearCjGkTXQcjfg460bTTK0KUyeEDb9Q5fkNODkjwDvAhBT873
         x4IsGBhd0O+hyySlt2swIi79WizpTFwmEjheI3hgXEkOt3G73d9CG1aBsGbRe9yP9pLe
         VjG/z9tbeh/iGR23nyFX3bRJHZGDUyTEL95bpDAYXjCrZqKzAGUwvENMvITBPuvxv+65
         kUgmi8hGENs7yd5lNKwC8S0hhJebQrwGaBxEplOVAvt/IolCVeTx14FxH+qQpbCXSrYA
         G6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oiXIqBbsbwx29Jr67d4QTZ21Bgj9h6e88PisGVFmk0o=;
        b=Cs8wL+Qvmnq5dzciDLNaRns64NldyjO2qA59Tcwg/i9ggOxWqMwNKsNJDKrWf0Taeh
         LEvPbop6h4lH3ouifxLw4ZV1ffu2cp8SAJchegWRe6U9XzyLxUu0biS6j/228RRqVKsb
         OfdO4iW4cQ2Cd3m6E+I5yxoNiyqlevugKL2smQL9wsq9QVHSLcQm5ZPiORcsHWYnulDF
         bY7Ybnnh1xD2U+vPmfEsef/RhYhF8aoxpu5ISYB8x8Ig/nZKGZCwnckHey0FYH/gyOtx
         IKOPVPgd8EgnjNfZOpNVQP1iBXIYxrkCdudNsx+X+ZYNaV10y25HQvw/eAVmQWampiNc
         lx+w==
X-Gm-Message-State: AJIora+/rjIW1mgsbG01ljaHcx65pk76cIDAEqgsNcKdDHDNQToDjVpg
        d2C2LZE4TyUofB9e0kDu+4iq4cQmv7YKNZH6CJw=
X-Google-Smtp-Source: AGRyM1tyRwrHLdTQYg915ieRALCTn5P9XwiI5HSWo2xt+nVJm0Q2x0BYY0xmv3CgBpfyY8u5xjr6g/1Jo0Pc5HpvL4E=
X-Received: by 2002:a05:6402:4408:b0:435:9ed2:9be with SMTP id
 y8-20020a056402440800b004359ed209bemr1405504eda.81.1656106751393; Fri, 24 Jun
 2022 14:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220623212205.2805002-1-deso@posteo.net> <20220623212205.2805002-5-deso@posteo.net>
In-Reply-To: <20220623212205.2805002-5-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 14:39:00 -0700
Message-ID: <CAEf4BzZA43SMt1_ex6LzLHWO2=P_G=YJbocejyEP2WU2atRHQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] libbpf: Add type match support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Thu, Jun 23, 2022 at 2:22 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This patch adds support for the proposed type match relation to
> relo_core where it is shared between userspace and kernel. A bit more
> plumbing is necessary and will arrive with subsequent changes to
> actually use it -- this patch only introduces the main matching
> algorithm.
>
> The matching relation is defined as follows (copy from source):
> - modifiers and typedefs are stripped (and, hence, effectively ignored)
> - generally speaking types need to be of same kind (struct vs. struct, un=
ion
>   vs. union, etc.)
>   - exceptions are struct/union behind a pointer which could also match a
>     forward declaration of a struct or union, respectively, and enum vs.
>     enum64 (see below)
> Then, depending on type:
> - integers:
>   - match if size and signedness match
> - arrays & pointers:
>   - target types are recursively matched
> - structs & unions:
>   - local members need to exist in target with the same name
>   - for each member we recursively check match unless it is already behin=
d a
>     pointer, in which case we only check matching names and compatible ki=
nd
> - enums:
>   - local variants have to have a match in target by symbolic name (but n=
ot
>     numeric value)
>   - size has to match (but enum may match enum64 and vice versa)
> - function pointers:
>   - number and position of arguments in local type has to match target
>   - for each argument and the return value we recursively check match
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> ---
>  tools/lib/bpf/relo_core.c | 276 ++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/relo_core.h |   2 +
>  2 files changed, 278 insertions(+)
>
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 6ad3c3..bc5b060 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1330,3 +1330,279 @@ int bpf_core_calc_relo_insn(const char *prog_name=
,
>
>         return 0;
>  }
> +
> +static bool bpf_core_names_match(const struct btf *local_btf, const stru=
ct btf_type *local_t,
> +                                const struct btf *targ_btf, const struct=
 btf_type *targ_t)
> +{
> +       const char *local_n, *targ_n;
> +
> +       local_n =3D btf__name_by_offset(local_btf, local_t->name_off);
> +       targ_n =3D btf__name_by_offset(targ_btf, targ_t->name_off);
> +
> +       return !strncmp(local_n, targ_n, bpf_core_essential_name_len(loca=
l_n));
> +}
> +

we have similar check in existing code in at least two other places
(search for strncmp in relo_core.c). But it doesn't always work with
btf_type, it sometimes is field name, sometimes is part of core_spec.

so it's confusing that we have this helper used in *one* place, and
other places open-code this logic. We can probably have a helper, but
it will have to be taking const char * arguments and doing
bpf_core_essential_name_len() for both


> +static int bpf_core_enums_match(const struct btf *local_btf, const struc=
t btf_type *local_t,
> +                               const struct btf *targ_btf, const struct =
btf_type *targ_t)
> +{
> +       __u16 local_vlen =3D btf_vlen(local_t);
> +       __u16 targ_vlen =3D btf_vlen(targ_t);
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
> +               size_t local_len;
> +
> +               local_n_off =3D btf_is_enum(local_t) ? btf_enum(local_t)[=
i].name_off :
> +                                                    btf_enum64(local_t)[=
i].name_off;
> +
> +               local_n =3D btf__name_by_offset(local_btf, local_n_off);
> +               local_len =3D bpf_core_essential_name_len(local_n);
> +
> +               for (j =3D 0; j < targ_vlen; j++) {
> +                       const char *targ_n;
> +                       __u32 targ_n_off;
> +
> +                       targ_n_off =3D btf_is_enum(targ_t) ? btf_enum(tar=
g_t)[j].name_off :
> +                                                          btf_enum64(tar=
g_t)[j].name_off;
> +                       targ_n =3D btf__name_by_offset(targ_btf, targ_n_o=
ff);
> +
> +                       if (str_is_empty(targ_n))
> +                               continue;
> +
> +                       if (!strncmp(local_n, targ_n, local_len)) {

and here you open-code name check instead of using your helper ;) but
also shouldn't you calculate "essential name len" for target enum as
well?.. otherwise local whatever___abc will match whatever123, which
won't be right

and I'm not hard-core enough to easily understand !strncmp() (as I
also mentioned in another email), I think explicit =3D=3D 0 is easier to
follow for str[n]cmp() APIs.

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
> +static int bpf_core_composites_match(const struct btf *local_btf, const =
struct btf_type *local_t,
> +                                    const struct btf *targ_btf, const st=
ruct btf_type *targ_t,
> +                                    int level)
> +{
> +       const struct btf_member *local_m =3D btf_members(local_t);
> +       __u16 local_vlen =3D btf_vlen(local_t);
> +       __u16 targ_vlen =3D btf_vlen(targ_t);
> +       int i, j, err;
> +
> +       if (local_vlen > targ_vlen)
> +               return 0;
> +
> +       /* check that all local members have a match in the target */
> +       for (i =3D 0; i < local_vlen; i++, local_m++) {
> +               const char *local_n =3D btf__name_by_offset(local_btf, lo=
cal_m->name_off);
> +               const struct btf_member *targ_m =3D btf_members(targ_t);
> +               bool matched =3D false;
> +
> +               for (j =3D 0; j < targ_vlen; j++, targ_m++) {
> +                       const char *targ_n =3D btf__name_by_offset(targ_b=
tf, targ_m->name_off);
> +
> +                       if (str_is_empty(targ_n))
> +                               continue;
> +
> +                       if (strcmp(local_n, targ_n) !=3D 0)
> +                               continue;

let's have the essential_len logic used consistently for all these
field and type name checks?

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

[...]

> +       depth--;
> +       if (depth < 0)
> +               return -EINVAL;
> +
> +       prev_local_t =3D local_t;
> +
> +       local_t =3D skip_mods_and_typedefs(local_btf, local_id, &local_id=
);
> +       targ_t =3D skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
> +       if (!local_t || !targ_t)
> +               return -EINVAL;
> +
> +       if (!bpf_core_names_match(local_btf, local_t, targ_btf, targ_t))
> +               return 0;
> +
> +       local_k =3D btf_kind(local_t);
> +
> +       switch (local_k) {
> +       case BTF_KIND_UNKN:
> +               return local_k =3D=3D btf_kind(targ_t);
> +       case BTF_KIND_FWD: {
> +               bool local_f =3D BTF_INFO_KFLAG(local_t->info);
> +               __u16 targ_k =3D btf_kind(targ_t);
> +
> +               if (btf_is_ptr(prev_local_t)) {

this doesn't work in general, you can have PTR -> CONST -> FWD, you
need to just remember that you saw PTR in the chain of types

> +                       if (local_k =3D=3D targ_k)
> +                               return local_f =3D=3D BTF_INFO_KFLAG(targ=
_t->info);
> +
> +                       /* for forward declarations kflag dictates whethe=
r the
> +                        * target is a struct (0) or union (1)
> +                        */
> +                       return (targ_k =3D=3D BTF_KIND_STRUCT && !local_f=
) ||
> +                              (targ_k =3D=3D BTF_KIND_UNION && local_f);
> +               } else {
> +                       if (local_k !=3D targ_k)
> +                               return 0;
> +
> +                       /* match if the forward declaration is for the sa=
me kind */
> +                       return local_f =3D=3D BTF_INFO_KFLAG(targ_t->info=
);
> +               }
> +       }

[...]
