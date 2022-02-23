Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF34C1FBE
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 00:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiBWXej (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 18:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244813AbiBWXei (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 18:34:38 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524D59A5C
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 15:34:09 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id r7so790666iot.3
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cDzisl8JoEk0cnz7FmrCyJPQJXAEbjDzC6fanfW7IaQ=;
        b=RGT0YzLhOm0ijkCyB9bqPiHehEi+/dHUZXhmApeU4XS+2/bz3bdhPIjnbvi1YWilw+
         3MMs17IMJj67p+YfhE4rcJcTgxEql+IHdvOrBOmwSNluRKEMhzrGYoprd/BlSLR9cV+W
         2At1GnZ+aSUfnwHXbltiySi4a+s+9d0Uz7UogOMOexZcK+EF1jBn9dgyHr+V1/dxcWEg
         eEaghR9prPb7jNTW3uHXVMd/XF1fHLXQ8yuyzmtE24It2HMaWiH9HTlkVhQznL5uQQPb
         CTvpbVwc7K93tYv0QEQeeZAyM3H0fE3VtZRxbaYh92DXu1NLhx37s39K41+vFoM1zrXC
         UWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cDzisl8JoEk0cnz7FmrCyJPQJXAEbjDzC6fanfW7IaQ=;
        b=uikERswNpFgGRwcpVmoWV2DvbI6qlJfilxqV8guk/6licSSyHo9Uu9wu3k/vJ3AuJc
         rIvGJoTec20Pp6475JeLwKxBMR8rB7t+n+Ncp/8LAfXMg5sevyAL/IH5QEex3+G/KTZq
         rxC3DgPFQz1EFqsHbkCeVIAM7ZEl2BSqAEIzdM8eOFYnWgHUq66Uz8xWPhUGHGWoWq/v
         mtwlQ0jeNneQ5u5x8S6XW+1jK3xpwGMC+mYnbZhf9LCwtIaVb7yHakrGi3bXkaf+c9Rl
         h+QIdQawVZ4prRPevWUsnS8ejmRZXBhKfcSbGYydUSWoUDXy7Z5hOyWstQO0aa149i5s
         mcOA==
X-Gm-Message-State: AOAM531+sVNrHP2M2CeGgq2uqtTyh9ltBzEsnRqOEKIMU/wFWWafVhC1
        SxA9VVi4fhAAsR1jIiyVUDJOCAoZzRQUTfDetYnkNDUyZ+Y=
X-Google-Smtp-Source: ABdhPJwYQAuGir80JPtQR1jcwnexCZLKflygUxfIuSqBnveY9juDp08mSm3Ni/6L8SKV0CipJbaNs1qXEuA82efeWqY=
X-Received: by 2002:a05:6638:22c3:b0:30a:2226:e601 with SMTP id
 j3-20020a05663822c300b0030a2226e601mr1566641jat.237.1645659249132; Wed, 23
 Feb 2022 15:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20220223020645.1169905-1-mykolal@fb.com> <CAEf4BzZ=_p7qxRZr3tWJ8rAb3pM1ynd20Tsq7YoH_302xghzgA@mail.gmail.com>
 <CAEf4BzZduzFZwZsdUrECo_60ecONDH-RDxgsD4JZKaHR2KweLg@mail.gmail.com> <C3B22201-85AE-4F39-9F76-B4F832AF3B1E@fb.com>
In-Reply-To: <C3B22201-85AE-4F39-9F76-B4F832AF3B1E@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 15:33:58 -0800
Message-ID: <CAEf4Bza6L1rRWi9qQKj0nKYcT5wUg441HNmU758H8A9mCo5LmQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] Small BPF verifier log improvements
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Wed, Feb 23, 2022 at 3:25 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
>
> > On Feb 23, 2022, at 1:52 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> >
> > On Tue, Feb 22, 2022 at 8:23 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Tue, Feb 22, 2022 at 6:07 PM Mykola Lysenko <mykolal@fb.com> wrote:
> >>>
> >>> In particular:
> >>> 1) remove output of inv for scalars
> >>> 2) remove _value suffixes for umin/umax/s32_min/etc (except map_value=
)
> >>> 3) remove output of id=3D0
> >>> 4) remove output of ref_obj_id=3D0
> >>>
> >>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> >>> ---
> >>
> >> LGTM, thanks.
> >>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Actually seems like you missed updating some tests, please take a look:
> >
> >  [0] https://github.com/kernel-patches/bpf/runs/5297754845?check_suite_=
focus=3Dtrue
>
> Great catch! Thanks.
>
> Reviewing failed test logs I realized that while print_verifier_state wor=
ks as expected and makes output tidier, my change did broke error messages.
>
> For example, my change turned
> ______________________
> R2 invalid mem access =E2=80=98inv=E2=80=99
> ______________________
> into
> ______________________
> R2 invalid mem access =E2=80=98=E2=80=99
> ______________________
>
> Removing inv in this case does not make sense. We should either leave inv=
 here, or substitute it with something more obvious, like =E2=80=99scalar=
=E2=80=99.
>
> Thoughts?

Yeah, scalar here would make most sense in this context. Would it be
possible to use "scalar" in this error message, but still have empty
string output in register state?

>
>
> >
> >>
> >>> kernel/bpf/verifier.c                         |  59 ++---
> >>> .../testing/selftests/bpf/prog_tests/align.c  | 218 +++++++++--------=
-
> >>> .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
> >>> 3 files changed, 143 insertions(+), 138 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index d7473fee247c..91154806715d 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>> @@ -539,7 +539,7 @@ static const char *reg_type_str(struct bpf_verifi=
er_env *env,
> >>>        char postfix[16] =3D {0}, prefix[32] =3D {0};
> >>>        static const char * const str[] =3D {
> >>>                [NOT_INIT]              =3D "?",
> >>> -               [SCALAR_VALUE]          =3D "inv",
> >>> +               [SCALAR_VALUE]          =3D "",
> >>>                [PTR_TO_CTX]            =3D "ctx",
> >>>                [CONST_PTR_TO_MAP]      =3D "map_ptr",
> >>>                [PTR_TO_MAP_VALUE]      =3D "map_value",
> >>> @@ -693,66 +693,71 @@ static void print_verifier_state(struct bpf_ver=
ifier_env *env,
> >>>                        /* reg->off should be 0 for SCALAR_VALUE */
> >>>                        verbose(env, "%lld", reg->var_off.value + reg-=
>off);
> >>>                } else {
> >>> +                       const char *sep =3D "";
> >>> +
> >>>                        if (base_type(t) =3D=3D PTR_TO_BTF_ID ||
> >>>                            base_type(t) =3D=3D PTR_TO_PERCPU_BTF_ID)
> >>>                                verbose(env, "%s", kernel_type_name(re=
g->btf, reg->btf_id));
> >>> -                       verbose(env, "(id=3D%d", reg->id);
> >>> -                       if (reg_type_may_be_refcounted_or_null(t))
> >>> -                               verbose(env, ",ref_obj_id=3D%d", reg-=
>ref_obj_id);
> >>> +                       verbose(env, "(");
> >>> +
> >>> +/*
> >>> + * _a stands for append, was shortened to avoid multiline statements=
 below. this macro is used to
> >>> + * output a comma separated list of attributes
> >>> + */
> >>> +#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS=
__); sep =3D ","; })
> >>
> >> it's a very local macro so it probably doesn't matter all that much,
> >> but a bit more readable name could be verbose_attr() or even just
> >> log_attr(). I'll leave it up to Alexei and Daniel to decide if they'd
> >> like to change it.
> >>
> >>> +
> >>> +                       if (reg->id)
> >>> +                               verbose_a("id=3D%d", reg->id);
> >>> +                       if (reg_type_may_be_refcounted_or_null(t) && =
reg->ref_obj_id)
> >>> +                               verbose_a("ref_obj_id=3D%d", reg->ref=
_obj_id);
> >>>                        if (t !=3D SCALAR_VALUE)
> >>> -                               verbose(env, ",off=3D%d", reg->off);
> >>> +                               verbose_a("off=3D%d", reg->off);
> >>>                        if (type_is_pkt_pointer(t))
> >>> -                               verbose(env, ",r=3D%d", reg->range);
> >>> +                               verbose_a("r=3D%d", reg->range);
> >>>                        else if (base_type(t) =3D=3D CONST_PTR_TO_MAP =
||
> >>>                                 base_type(t) =3D=3D PTR_TO_MAP_KEY ||
> >>>                                 base_type(t) =3D=3D PTR_TO_MAP_VALUE)
> >>> -                               verbose(env, ",ks=3D%d,vs=3D%d",
> >>> -                                       reg->map_ptr->key_size,
> >>> -                                       reg->map_ptr->value_size);
> >>> +                               verbose_a("ks=3D%d,vs=3D%d",
> >>> +                                         reg->map_ptr->key_size,
> >>> +                                         reg->map_ptr->value_size);
> >>>                        if (tnum_is_const(reg->var_off)) {
> >>>                                /* Typically an immediate SCALAR_VALUE=
, but
> >>>                                 * could be a pointer whose offset is =
too big
> >>>                                 * for reg->off
> >>>                                 */
> >>> -                               verbose(env, ",imm=3D%llx", reg->var_=
off.value);
> >>> +                               verbose_a("imm=3D%llx", reg->var_off.=
value);
> >>>                        } else {
> >>>                                if (reg->smin_value !=3D reg->umin_val=
ue &&
> >>>                                    reg->smin_value !=3D S64_MIN)
> >>> -                                       verbose(env, ",smin_value=3D%=
lld",
> >>> -                                               (long long)reg->smin_=
value);
> >>> +                                       verbose_a("smin=3D%lld", (lon=
g long)reg->smin_value);
> >>>                                if (reg->smax_value !=3D reg->umax_val=
ue &&
> >>>                                    reg->smax_value !=3D S64_MAX)
> >>> -                                       verbose(env, ",smax_value=3D%=
lld",
> >>> -                                               (long long)reg->smax_=
value);
> >>> +                                       verbose_a("smax=3D%lld", (lon=
g long)reg->smax_value);
> >>>                                if (reg->umin_value !=3D 0)
> >>> -                                       verbose(env, ",umin_value=3D%=
llu",
> >>> -                                               (unsigned long long)r=
eg->umin_value);
> >>> +                                       verbose_a("umin=3D%llu", (uns=
igned long long)reg->umin_value);
> >>>                                if (reg->umax_value !=3D U64_MAX)
> >>> -                                       verbose(env, ",umax_value=3D%=
llu",
> >>> -                                               (unsigned long long)r=
eg->umax_value);
> >>> +                                       verbose_a("umax=3D%llu", (uns=
igned long long)reg->umax_value);
> >>>                                if (!tnum_is_unknown(reg->var_off)) {
> >>>                                        char tn_buf[48];
> >>>
> >>>                                        tnum_strn(tn_buf, sizeof(tn_bu=
f), reg->var_off);
> >>> -                                       verbose(env, ",var_off=3D%s",=
 tn_buf);
> >>> +                                       verbose_a("var_off=3D%s", tn_=
buf);
> >>>                                }
> >>>                                if (reg->s32_min_value !=3D reg->smin_=
value &&
> >>>                                    reg->s32_min_value !=3D S32_MIN)
> >>> -                                       verbose(env, ",s32_min_value=
=3D%d",
> >>> -                                               (int)(reg->s32_min_va=
lue));
> >>> +                                       verbose_a("s32_min=3D%d", (in=
t)(reg->s32_min_value));
> >>>                                if (reg->s32_max_value !=3D reg->smax_=
value &&
> >>>                                    reg->s32_max_value !=3D S32_MAX)
> >>> -                                       verbose(env, ",s32_max_value=
=3D%d",
> >>> -                                               (int)(reg->s32_max_va=
lue));
> >>> +                                       verbose_a("s32_max=3D%d", (in=
t)(reg->s32_max_value));
> >>>                                if (reg->u32_min_value !=3D reg->umin_=
value &&
> >>>                                    reg->u32_min_value !=3D U32_MIN)
> >>> -                                       verbose(env, ",u32_min_value=
=3D%d",
> >>> -                                               (int)(reg->u32_min_va=
lue));
> >>> +                                       verbose_a("u32_min=3D%d", (in=
t)(reg->u32_min_value));
> >>>                                if (reg->u32_max_value !=3D reg->umax_=
value &&
> >>>                                    reg->u32_max_value !=3D U32_MAX)
> >>> -                                       verbose(env, ",u32_max_value=
=3D%d",
> >>> -                                               (int)(reg->u32_max_va=
lue));
> >>> +                                       verbose_a("u32_max=3D%d", (in=
t)(reg->u32_max_value));
> >>>                        }
> >>> +#undef verbose_a
> >>> +
> >>>                        verbose(env, ")");
> >>>                }
> >>>        }
> >>
> >> [...]
>
