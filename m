Return-Path: <bpf+bounces-16236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E37FE946
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 07:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80EBB20E1A
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5445715AED;
	Thu, 30 Nov 2023 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4ARx+q3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E25A3
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 22:41:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bc22c836bso901196e87.0
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 22:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701326512; x=1701931312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5YbB4y8X5Gsw7QofaXjop6RL11N8m4TdjLoLhFlr5Y=;
        b=M4ARx+q3dMIoem2EQWLTwYpIRD8NTIH5P/Jh0nWPrrcwj0mq4D1DC3wc59xHMjf2RX
         +p52CfI+TJvvzG9Nj8iT9qt5cMPloSeU0V6g6/L1QEBy4GlYEqxWTFK7sGBjS4pxAGV/
         hCttAee09dGNWeGJSiaN3UEz4LBtBtzpApHvbYnMgHeIaEw88gkfH9nqltzhJCZ/qJ4p
         sNdRmizZ2+1tfrxdE5oIvDQC8sxBN7qOu5Ht4qHdl92BzmGh6Zrw+Cnzr1SCCQXS8N3w
         yYcPP465el2nutgKU0AmV5IXBC8Rh0kj/wAFIM7d33VqylBuP9dOAeRnkNDLD81fAxDb
         OrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701326512; x=1701931312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5YbB4y8X5Gsw7QofaXjop6RL11N8m4TdjLoLhFlr5Y=;
        b=CYzZAriAT7t/d9uoyGv5k21sGcp3pEQCQmDAxJQUgQbhcuJHfCE+Uf1pN9oO8FMC0N
         mJCSaH+C57mkVKjCiPMaF6SnEe+bhgUmRo1/F12tCxozqU77+cfxH8FrRAwEiD3klAfw
         Iy92wkMD1yFVg7wjjdbOd4tV3MxcnnWKtEg4/U0wPnXGB6Tm4hle0i5lHo2Tbow9WJFP
         +jKUwD5PKS6I5tLQj66DUB6SXhT9vS4q9NySk0ERFi5j0PDKqBYVEWrtufyr3HGhe1OJ
         iG8J6duMdDfaVC8JN6+0i84VwO3LL6nadcDte+Y/oUdCXdyuogXHWGMZBDERjQUHOhkq
         NYGg==
X-Gm-Message-State: AOJu0Yzx3MUAlvqWLnWpKBzi9sdwfUD6fOjmdS2po+D97/yE1Ng8Z3ZP
	M3jYwU4OTbWM1dSszB1g6N+3QLmjfgbulYsioXVBlDqi
X-Google-Smtp-Source: AGHT+IGJUSH+6wzMUOd5MhCgiR7QI8jU/jnlTT0uUK3EQMx8ZT+rB74zdrMcxEUFgyNlxRiEprtDL90o+ZD3+AysVtk=
X-Received: by 2002:a05:6512:2203:b0:50b:d0e3:c95b with SMTP id
 h3-20020a056512220300b0050bd0e3c95bmr326568lfu.15.1701326512225; Wed, 29 Nov
 2023 22:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003620.1049610-1-andrii@kernel.org> <20231129003620.1049610-4-andrii@kernel.org>
 <carufygwn5mf27v5y336tout32yokzoqhfaot2skxgn7s54rxb@qp3qicqilpcz>
 <CAEf4BzbUjsW0JfMwZQQYETafs=6yD=cs23W_PJ6=H90YMZudyQ@mail.gmail.com> <ZWgcW2RCDW9hoOVI@u94a>
In-Reply-To: <ZWgcW2RCDW9hoOVI@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Nov 2023 22:41:39 -0800
Message-ID: <CAEf4BzZXPqfPouShM2UcpX3NEyM425ePZV_kS6vrUmXFtY4d0A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: enforce exact retval range on
 subprog/callback exit
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 9:23=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Wed, Nov 29, 2023 at 08:23:38AM -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 29, 2023 at 2:56=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse=
.com> wrote:
> > > On Tue, Nov 28, 2023 at 04:36:13PM -0800, Andrii Nakryiko wrote:
> > > > Instead of relying on potentially imprecise tnum representation of
> > > > expected return value range for callbacks and subprogs, validate th=
at
> > > > umin/umax range satisfy exact expected range of return values.
> > > >
> > > > E.g., if callback would need to return [0, 2] range, tnum can't
> > > > represent this precisely and instead will allow [0, 3] range. By
> > > > checking umin/umax range, we can make sure that subprog/callback in=
deed
> > > > returns only valid [0, 2] range.
> > > >
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/bpf_verifier.h |  7 ++++++-
> > > >  kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++------=
----
> > > >  2 files changed, 35 insertions(+), 12 deletions(-)
> > >
> > > ...
> > >
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -9560,6 +9565,19 @@ static bool in_rbtree_lock_required_cb(struc=
t bpf_verifier_env *env)
> > > >       return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> > > >  }
> > > >
> > > > +static bool retval_range_within(struct bpf_retval_range range, con=
st struct bpf_reg_state *reg)
> > > > +{
> > > > +     return range.minval <=3D reg->umin_value && reg->umax_value <=
=3D range.maxval;
> > > > +}
> > > > +
> > > > +static struct tnum retval_range_as_tnum(struct bpf_retval_range ra=
nge)
> > > > +{
> > > > +     if (range.minval =3D=3D range.maxval)
> > > > +             return tnum_const(range.minval);
> > > > +     else
> > > > +             return tnum_range(range.minval, range.maxval);
> > > > +}
> > >
> > > Nit: find it slightly strange to have retval_range_as_tnum() added he=
re
> > > (patch 3), only to be removed again in the patch 5. As far as I can s=
ee
> > > patch 4 doesn't require this, and it is only used once.
> > >
> > > Perhaps just replace its use below with tnum_range() instead? (Not
> > > pretty, but will be removed anyway).
> >
> > I do this to delay the refactoring of verbose_invalid_scalar() which
> > is used by another piece of logic which I refactor in a separate
> > patch. If I don't do this temporary retval_range_as_tnum() helper, I
> > might need to update some more tests that expect exact var_off value
> > in logs, and I didn't want to do it. Given it's a trivial helper, it
> > feels like it's not a big deal to keep it for a patch or two before
> > completing the refactoring.
>
> Replace retval_range_as_tnum(callee->callback_ret_range) with
>
>   tnum_range(callee->callback_ret_range.minval,
>              callee->callback_ret_range.maxval)
>
> and the verbose_invalid_scalar() signature stays the same; also no var_of=
f
> changes because it is just manual inline of retval_range_as_tnum(), as
> tnum_range(n, n) =3D=3D tnum_const(n).

I tried it locally, and I don't have to adjust any new tests, so I'll
inline tnum_range() as you suggested, thanks.


>
> Agree it really is not a big deal, so I won't insist on it.
>
> > > > @@ -9597,7 +9612,10 @@ static int prepare_func_exit(struct bpf_veri=
fier_env *env, int *insn_idx)
> > > >               if (err)
> > > >                       return err;
> > > >
> > > > -             if (!tnum_in(range, r0->var_off)) {
> > > > +             /* enforce R0 return value range */
> > > > +             if (!retval_range_within(callee->callback_ret_range, =
r0)) {
> > > > +                     struct tnum range =3D retval_range_as_tnum(ca=
llee->callback_ret_range);

