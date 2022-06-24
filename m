Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F155A354
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiFXVJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiFXVJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:09:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289185D0A
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:09:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so7057007ejj.12
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a4MKYpdyRMJLVPpfxqaOjQ1EVoFkjCVAEA+uvcvIRhs=;
        b=go2PMtqmHeX3SvA3vIdUh8yjsn7lcb5pAXjPZHh+UTXyfWYF+DOhOLXdHTvb1HRL0A
         n5tpHzDWd5qun/qrG1o/Um2/WLIgEEc5ZnIfKYMh+bov9JYnQc4iFOoyXiQ7DD2RxU9A
         iP4gfWlrQZdcm1T3TkDMc+PiEsohd3BV4BeBO6nmH2uE0gLqB8tv8y3fMYQpeTDspf+n
         zpq3orgTT8ad7eU4n78gLS/NLCkLiXeh28LZ2dvUeMljxnk2dEQpmHiSwVCYIClGxtRg
         cEbUw7F9cAQULVf0hxUWdtsUozZ3AE0Ha8gbYv2/5BmSYif3vK00q39bk8OJdY53/KNb
         25xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a4MKYpdyRMJLVPpfxqaOjQ1EVoFkjCVAEA+uvcvIRhs=;
        b=HQVNTwYfl6jqECixni7NBw0Vg78dGiFsZjbzswjhiPftPsHocsvZYPy/XlwRXW6SUf
         SXYylmsu+1wwEF25pWU1J5HL0S64mauqRgLRFMYH+HCcUT7/jBxoUu5Npilnmj6ZaC/Q
         YaPG603WNjQ6XS+wUMmNxXbCQxI0AvdFSrv9kAejJxxoTLc+KvK8VG+2EXU0XeeFDzaz
         5ZgQzqrd5nUiyGvMLAdudKor3M9lFpt3zEFeeAUICJox34K489ZXuNaVjVGpO1aIGjcu
         dQcP8YDaLprsr6R14GTkEWIzERnQEpzrHJGJkxWbW1y4lk+1hrYzMktcqAIPIJfY9uYS
         gGog==
X-Gm-Message-State: AJIora+NHHhyvlhe00S99yogrILH5W95wjMsCZ7ygiIY9wgSJdOqp4xn
        hR1DjY5ktQJ23MHqsP1Kh9V4oczyF1cvN67QlyU=
X-Google-Smtp-Source: AGRyM1uP696bZW/nn5pYm6pnvsSbnf4cwSgemWncetbocuB3LI1y0d0fFZDQEc0UyEW5tP0p/gXyth+8dMPlAtVOGqg=
X-Received: by 2002:a17:906:58ca:b0:722:f12b:a0e4 with SMTP id
 e10-20020a17090658ca00b00722f12ba0e4mr913763ejs.545.1656104985151; Fri, 24
 Jun 2022 14:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220620231713.2143355-1-deso@posteo.net> <20220620231713.2143355-4-deso@posteo.net>
 <CAJnrk1YL9E2GJN+8Gnr9Db=yAHDOm2nwLb_LUQTEuStkm1jHEg@mail.gmail.com> <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
In-Reply-To: <20220622172224.4curfsv7h7gfjwh5@muellerd-fedora-MJ0AC3F3>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 24 Jun 2022 14:09:33 -0700
Message-ID: <CAEf4BzbyU-W8a3fzZoy7DDb=DtqdfGM2U3YpgYaS+EqHWZ0qag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add type match support
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jun 22, 2022 at 10:22 AM Daniel M=C3=BCller <deso@posteo.net> wrote=
:
>
> On Tue, Jun 21, 2022 at 12:41:22PM -0700, Joanne Koong wrote:
> >  On Mon, Jun 20, 2022 at 4:25 PM Daniel M=C3=BCller <deso@posteo.net> w=
rote:
> > >
> > > This change implements the kernel side of the "type matches" support.
> > > Please refer to the next change ("libbpf: Add type match support") fo=
r
> > > more details on the relation. This one is first in the stack because
> > > the follow-on libbpf changes depend on it.
> > >
> > > Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> > > ---
> > >  include/linux/btf.h |   5 +
> > >  kernel/bpf/btf.c    | 267 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 272 insertions(+)
> > >
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index 1bfed7..7376934 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -242,6 +242,11 @@ static inline u8 btf_int_offset(const struct btf=
_type *t)
> > >         return BTF_INT_OFFSET(*(u32 *)(t + 1));
> > >  }
> > >
> > > +static inline u8 btf_int_bits(const struct btf_type *t)
> > > +{
> > > +       return BTF_INT_BITS(*(__u32 *)(t + 1));
> > nit: u32 here instead of __u32
>
> Ah yeah, changed!
>
> > > +}
> > > +
> > >  static inline u8 btf_int_encoding(const struct btf_type *t)
> > >  {
> > >         return BTF_INT_ENCODING(*(u32 *)(t + 1));
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index f08037..3790b4 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -7524,6 +7524,273 @@ int bpf_core_types_are_compat(const struct bt=
f *local_btf, __u32 local_id,
> > >                                            MAX_TYPES_ARE_COMPAT_DEPTH=
);
> > >  }
> > >
> > > +#define MAX_TYPES_MATCH_DEPTH 2
> > > +
> > > +static bool bpf_core_names_match(const struct btf *local_btf, u32 lo=
cal_id,
> > > +                                const struct btf *targ_btf, u32 targ=
_id)
> > > +{
> > > +       const struct btf_type *local_t, *targ_t;
> > > +       const char *local_n, *targ_n;
> > > +       size_t local_len, targ_len;
> > > +
> > > +       local_t =3D btf_type_by_id(local_btf, local_id);
> > > +       targ_t =3D btf_type_by_id(targ_btf, targ_id);
> > > +       local_n =3D btf_str_by_offset(local_btf, local_t->name_off);
> > > +       targ_n =3D btf_str_by_offset(targ_btf, targ_t->name_off);
> > > +       local_len =3D bpf_core_essential_name_len(local_n);
> > > +       targ_len =3D bpf_core_essential_name_len(targ_n);
> > nit: i personally think this would be a little visually easier to read
> > if there was a line space between targ_t and local_n, and between
> > targ_n and local_len
>
> Will add spaces as you suggest. I've also changed the signature to pass i=
n the
> actual btf_type pointer directly, which is trivially available at the cal=
l site.
> That makes the block a bit shorter.
>
> > > +
> > > +       return local_len =3D=3D targ_len && strncmp(local_n, targ_n, =
local_len) =3D=3D 0;
> > Does calling "return !strcmp(local_n, targ_n);" do the same thing here?
>
> I think it does. Changed. Thanks!

No, it doesn't. task_struct___kernel and task_struct___libbpf will
have same local_len and targ_len and should be considered a name
match, but strcmp() will return false. That strncmp() is there for a
very good reason.

And as an aside, it's very much personal preference, but I find
!strcmp() form very disruptive to reason about, so with all the string
apis returning 0 on match I prefere =3D=3D 0 explicitly. Let's keep that
convention as is.

>
> > > +}
> > > +
> > > +static int bpf_core_enums_match(const struct btf *local_btf, const s=
truct btf_type *local_t,
> > I find the return values a bit confusing here.  The convention in
> > linux is to return 0 for the success case. Maybe I'm totally missing
> > something here, but is there a reason this doesn't just return a
> > boolean?
>
> I basically took bpf_core_types_are_compat() as the guiding function for =
the
> signature, because bpf_core_enums_match() is used in the same contexts al=
ongside
> it. The reason it uses int, from what I can tell, is because it merges er=
ror
> returns in there as well (-EINVAL). Given that we do the same, I think we=
 should
> stick to the same signature as well.

Yes, it's a boolean function that can fail, so it has to return int.

>
> > > +                               const struct btf *targ_btf, const str=
uct btf_type *targ_t)
> > > +{
> > > +       u16 local_vlen =3D btf_vlen(local_t);
> > > +       u16 targ_vlen =3D btf_vlen(targ_t);
> > > +       int i, j;
> > > +
> > > +       if (local_t->size !=3D targ_t->size)
> > > +               return 0;
> > > +
> > > +       if (local_vlen > targ_vlen)
> > > +               return 0;
> > > +
> > > +       /* iterate over the local enum's variants and make sure each =
has
> > > +        * a symbolic name correspondent in the target
> > > +        */
> > > +       for (i =3D 0; i < local_vlen; i++) {
> > > +               bool matched =3D false;
> > > +               const char *local_n;
> > > +               __u32 local_n_off;
> > nit: u32 instead of __u32 :)
>
> As per discussion with Alexei I have deduplicated this function (between =
kernel
> and userspace) and moved it into relo_core.c. Unfortunately, this file in=
sists
> on usage of __32 (for better or worse):
>
>   xxxx:yyy:zz: error: attempt to use poisoned "u32"
>

right, libbpf can't use u32, it's a kernel-only alias

> > > +               size_t local_len;
> > > +
> > > +               local_n_off =3D btf_is_enum(local_t) ? btf_type_enum(=
local_t)[i].name_off :
> > > +                                                    btf_type_enum64(=
local_t)[i].name_off;
> > > +
> > > +               local_n =3D btf_name_by_offset(local_btf, local_n_off=
);
> > > +               local_len =3D bpf_core_essential_name_len(local_n);
> > > +
> > > +               for (j =3D 0; j < targ_vlen; j++) {
> > > +                       const char *targ_n;
> > > +                       __u32 targ_n_off;
> > > +                       size_t targ_len;
> > > +
> > > +                       targ_n_off =3D btf_is_enum(targ_t) ? btf_type=
_enum(targ_t)[j].name_off :
> > > +                                                          btf_type_e=
num64(targ_t)[j].name_off;
> > > +                       targ_n =3D btf_name_by_offset(targ_btf, targ_=
n_off);
> > > +
> > > +                       if (str_is_empty(targ_n))
> > > +                               continue;
> > > +
> > > +                       targ_len =3D bpf_core_essential_name_len(targ=
_n);
> > > +
> > > +                       if (local_len =3D=3D targ_len && strncmp(loca=
l_n, targ_n, local_len) =3D=3D 0) {
> > same question here - does strcmp suffice?
>
> I believe it does. Changed.

see above, it doesn't

>
> > > +                               matched =3D true;
> > > +                               break;
> > > +                       }
> > > +               }
> > > +
> > > +               if (!matched)
> > > +                       return 0;
> > > +       }
> > > +       return 1;
> > > +}
> > > +

[...]

> > > +       case BTF_KIND_FUNC_PROTO: {
> > > +               struct btf_param *local_p =3D btf_params(local_t);
> > > +               struct btf_param *targ_p =3D btf_params(targ_t);
> > > +               u16 local_vlen =3D btf_vlen(local_t);
> > > +               u16 targ_vlen =3D btf_vlen(targ_t);
> > > +               int i, err;
> > > +
> > > +               if (local_k !=3D btf_kind(targ_t))
> > > +                       return 0;
> > > +
> > > +               if (local_vlen !=3D targ_vlen)
> > > +                       return 0;
> > > +
> > > +               for (i =3D 0; i < local_vlen; i++, local_p++, targ_p+=
+) {
> > > +                       err =3D __bpf_core_types_match(local_btf, loc=
al_p->type, targ_btf,
> > > +                                                    targ_p->type, le=
vel - 1);
> > > +                       if (err <=3D 0)
> > > +                               return err;
> > > +               }
> > > +
> > > +               /* tail recurse for return type check */
> > > +               local_id =3D local_t->type;
> > > +               targ_id =3D targ_t->type;
> > > +               goto recur;
> > > +       }
> > > +       default:
> > Do BTF_KIND_FLOAT and BTF_KIND_TYPEDEF need to be checked as well?
>
> Lack of BTF_KIND_TYPEDEF is a good question. I don't know why it's missin=
g from
> bpf_core_types_are_compat() as well, which I took as a template. I will d=
o some
> testing to better understand if we can hit this case or whether there is =
some
> magic going on that would have resolved typedefs already at this point (w=
hich is
> my suspicion).
> My understanding why we don't cover floats is because we do not allow flo=
ating
> point operations in kernel code (right?).

FLOAT is an omission, we need to add it (kernel types do have floats).
But TYPEDEF (as well as CONST/VOLATILE/RESTRICT) will be skipped by
btf_type_skip_modifiers(), so we should never see them in this switch.

>
> > > +               return 0;
> > > +       }
> > > +}
> > > +
> > > +int bpf_core_types_match(const struct btf *local_btf, u32 local_id,
> > > +                        const struct btf *targ_btf, u32 targ_id)
> > > +{
> > > +       return __bpf_core_types_match(local_btf, local_id,
> > > +                                     targ_btf, targ_id,
> > > +                                     MAX_TYPES_MATCH_DEPTH);
> > > +}
> > Also, btw, thanks for the thorough cover letter - its high-level
> > overview made it easier to understand the patches
>
> Thanks!
>
> Daniel
