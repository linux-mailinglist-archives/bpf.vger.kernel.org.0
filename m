Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3897567D03
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 06:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiGFERM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 00:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGFERL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 00:17:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A71F609
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 21:17:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so24869471ejj.12
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 21:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XE8tHSjY/CmKRfsRs80s8gvW3eVtselnO3o2194pSC0=;
        b=dLAC/cAOH0WidMxcWrjfIfnpS5EVwjUtK38pjvGeirWZLaCrtWUITm2ds03D4tAMgb
         yqR/L3vlLSsRRCZSlcp37V5NUVFZHwvgXUX3hg88pTK+iGJNlokuoX3DO2udRZNtDu/Z
         EqswlaAJFEjo/1cFb1IaGLyAhNgTri3P8Ue5b21Pl4hSASH3CNUK1jX21cM+y7nHiOBc
         Nuh6PqeRbThknF3oDLwYtilV4AZFVpopYB1Z+1TvB6eDaMdLMBaiKY0YdPLvLBZCtTfr
         /mGufIT7fe0m/nZ16n/pdqUX1rkDjfPeSzftNhrmUHIx2Rn2KZkuQtiV3Ob5lOYKZXGY
         yM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XE8tHSjY/CmKRfsRs80s8gvW3eVtselnO3o2194pSC0=;
        b=iGR0OzXqfi7mDuJSbVsUPAVZcEKf1obwETLERCyvPu26TNrocZRDjeOjKSnC+TjtX3
         wlqRRSp7pv8SaZNtFxSLeWQyxieMxtPh5CkRc90NW9KByXzvef36tcdhhrjqODHGp/uo
         8qKbLRdWCHhWsqPi+84eopmWExoiuV/D/Ks3RfQ1g+lj+QyUHZprrNuywYe0Jxao1dZE
         s5y8S0AF6ng3fk0EKaHWG+PRMeV+25V1Se5xqYXFqGGf4QK6c84pY/LUxKkduavnOTFo
         P+stzOCIjX+mToeQo/NiN5VFQuw6CKljK7NuBhXgqqvfDNys7Cw+B+Zau+SYkDFGcevg
         rSQQ==
X-Gm-Message-State: AJIora9O7lCMibGqqmSGwnEFf3rB+Yp7bZnpFP3zoka12ts8DegTA/O3
        aykn7drV9pudDipEcALx+ef2OS2O3tBdjg1j7U0=
X-Google-Smtp-Source: AGRyM1uhMWa9hazCYZ9Vb2V2TAWTvcTuQFFO+dvI6IOyRsqeurfifNMJXbN7uxh+YU0xRk8qzW1/Lx9nTS7a+/2rQcU=
X-Received: by 2002:a17:907:6e05:b0:72a:a141:962 with SMTP id
 sd5-20020a1709076e0500b0072aa1410962mr20614488ejc.545.1657081024938; Tue, 05
 Jul 2022 21:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220628160127.607834-1-deso@posteo.net> <20220628160127.607834-5-deso@posteo.net>
In-Reply-To: <20220628160127.607834-5-deso@posteo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 21:16:53 -0700
Message-ID: <CAEf4BzaOES9F_pAF_QX+xbQvEitEbBfmQQO8HaH3DFS4Lq_hbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/10] libbpf: Add type match support
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

On Tue, Jun 28, 2022 at 9:02 AM Daniel M=C3=BCller <deso@posteo.net> wrote:
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
>  tools/lib/bpf/relo_core.c | 268 ++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/relo_core.h |   2 +
>  2 files changed, 270 insertions(+)
>

[...]

> +static int bpf_core_composites_match(const struct btf *local_btf, const =
struct btf_type *local_t,
> +                                    const struct btf *targ_btf, const st=
ruct btf_type *targ_t,
> +                                    bool behind_ptr, int level)
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
> +               const struct btf_member *targ_m =3D btf_members(targ_t);
> +               bool matched =3D false;
> +
> +               for (j =3D 0; j < targ_vlen; j++, targ_m++) {
> +                       if (!bpf_core_names_match(local_btf, local_m->nam=
e_off, targ_btf,
> +                                                 targ_m->name_off))
> +                               continue;
> +
> +                       err =3D __bpf_core_types_match(local_btf, local_m=
->type, targ_btf,
> +                                                    targ_m->type, behind=
_ptr, level - 1);
> +                       if (err > 0) {

this seems a bit too permissive, if we get an error, we should error
out instead of ignoring this. I left this for a follow up, though

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
> +/* Check that two types "match".
> + *
> + * The matching relation is defined as follows:
> + * - modifiers and typedefs are stripped (and, hence, effectively ignore=
d)
> + * - generally speaking types need to be of same kind (struct vs. struct=
, union
> + *   vs. union, etc.)
> + *   - exceptions are struct/union behind a pointer which could also mat=
ch a
> + *     forward declaration of a struct or union, respectively, and enum =
vs.
> + *     enum64 (see below)
> + * Then, depending on type:
> + * - integers:
> + *   - match if size and signedness match
> + * - arrays & pointers:
> + *   - target types are recursively matched
> + * - structs & unions:
> + *   - local members need to exist in target with the same name
> + *   - for each member we recursively check match unless it is already b=
ehind a
> + *     pointer, in which case we only check matching names and compatibl=
e kind
> + * - enums:
> + *   - local variants have to have a match in target by symbolic name (b=
ut not
> + *     numeric value)
> + *   - size has to match (but enum may match enum64 and vice versa)
> + * - function pointers:
> + *   - number and position of arguments in local type has to match targe=
t
> + *   - for each argument and the return value we recursively check match
> + */
> +int __bpf_core_types_match(const struct btf *local_btf, __u32 local_id, =
const struct btf *targ_btf,
> +                          __u32 targ_id, bool behind_ptr, int level)
> +{
> +       const struct btf_type *local_t, *targ_t;
> +       int depth =3D 32; /* max recursion depth */
> +       __u16 local_k;
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
> +       local_t =3D skip_mods_and_typedefs(local_btf, local_id, &local_id=
);
> +       targ_t =3D skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
> +       if (!local_t || !targ_t)
> +               return -EINVAL;
> +
> +       if (!bpf_core_names_match(local_btf, local_t->name_off, targ_btf,=
 targ_t->name_off))
> +               return 0;

so the location of this check bothers me

Think about the case when we have on one side

typedef struct { /* something */ } abc;

and this on the other side:

typedef struct { /* something */ } def;

As this is written right now, we'll just ignore "abc" and "def" names,
which seems wrong. I haven't touched this part, but let's think what
to do about that and have a follow up patch.

> +
> +       local_k =3D btf_kind(local_t);
> +
> +       switch (local_k) {

[...]

> +
> +               return bpf_core_enums_match(local_btf, local_t, targ_btf,=
 targ_t);
> +       case BTF_KIND_STRUCT:
> +       case BTF_KIND_UNION: {
> +               __u16 targ_k =3D btf_kind(targ_t);

you use targ_k almost in every case, so it would be cleaner to just
calculated right next to local_k, IMO (so that's what I did when
applying)

> +
> +               if (behind_ptr) {
> +                       bool targ_f =3D BTF_INFO_KFLAG(targ_t->info);

[...]

> +
> +               local_sgn =3D btf_int_encoding(local_t) & BTF_INT_SIGNED;
> +               targ_sgn =3D btf_int_encoding(targ_t) & BTF_INT_SIGNED;
> +
> +               return btf_int_bits(local_t) =3D=3D btf_int_bits(targ_t) =
&& local_sgn =3D=3D targ_sgn;

nit: should probably be local_t->size =3D=3D targ_t->size instead of
btf_int_bits() (which is kind of deprecated)



> +       }
> +       case BTF_KIND_PTR:
> +               if (local_k !=3D btf_kind(targ_t))
> +                       return 0;
> +
> +               behind_ptr =3D true;
> +
> +               local_id =3D local_t->type;
> +               targ_id =3D targ_t->type;
> +               goto recur;

[...]
