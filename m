Return-Path: <bpf+bounces-16157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C37FDCF1
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729D72829F2
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855443AC2E;
	Wed, 29 Nov 2023 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh12OXq6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB218F
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:23:52 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a06e59384b6so897819866b.1
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701275030; x=1701879830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT64LmGqyy73nSmEY85Zsnr9PlbyDFvsQIp5LI/PhCM=;
        b=Wh12OXq6yXIQ8oL4rOAF1Yd3AW97GeO0qWTWIuInQjhbLK9o2vx68F46NVxmg34x0/
         wz+DJrnv1B2zO+QYeKT/66xSNA898zV3M/UIMxSXH72ym1XPqnchHPidl4TVidQb0bfA
         KvibjHF3Z0bM4WvkV87vIVsPvLDsowW3knh6y2xxu9VfOHqjBNY6nUALn1/TTjjqDRLg
         FiookpOlm5S+zqxx4XMVMR9cuO+W+rUtK+OSei7o1LLznMliWWJ2L1I4u4qCjXAR1Gu5
         FyGpakX9nSQVvTvyHV1PrNVVGb1lxUjHIt/1fxYCza6L4pPbTxqV0C0dMrHqRudYUJZy
         nbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275030; x=1701879830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT64LmGqyy73nSmEY85Zsnr9PlbyDFvsQIp5LI/PhCM=;
        b=EiaK2uNB+otNZQbpkwdAogZAV3qV7gDxWKd2vxsim7f+nhIVy3LS2JrSMO+Z3sBJMi
         PArQHdse0Qqh/rxtzfuQsI2NPSmINnKdb7Nvl6IVXWATLjCUdRPTttgL8/3lbKXfnDY6
         p05RjYYl54neEWC5Z1XezrLOLYS9SMBIQlevGils2IBnXXPRrZ09NJ7XGHm7SLGiJHV0
         I/uZzNNvUKIHhhPDVqaE0HUB8aq27MXFwRRhXf8LK863MgAsHb2D74IPT+OuKKra0gol
         Q1xbjCVvPBNqA/LJ2jYTh0JnXajl2mcZqOXH4jVmVozfcVcUcj7jtI99O7ogtgFgQ3Si
         ofWw==
X-Gm-Message-State: AOJu0YzCsRFwbaJxduYs5nssGTNEyTTic7R0fiCAJA82zeIOoy51dRhr
	z3ZL0fPTx3F5VEQ53N4CHy92i7D4iM0WnkZIoEE=
X-Google-Smtp-Source: AGHT+IH7FhfqjW9XZ4Hb9peTQTKFh5sBBKIOKYFdUps1uacHK1wxuBfQuCBCSIs9NrvraQ6XdfCQkFroI6bx+wrfJl8=
X-Received: by 2002:a17:906:114b:b0:9c3:e158:316a with SMTP id
 i11-20020a170906114b00b009c3e158316amr13594617eja.68.1701275030516; Wed, 29
 Nov 2023 08:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003620.1049610-1-andrii@kernel.org> <20231129003620.1049610-4-andrii@kernel.org>
 <carufygwn5mf27v5y336tout32yokzoqhfaot2skxgn7s54rxb@qp3qicqilpcz>
In-Reply-To: <carufygwn5mf27v5y336tout32yokzoqhfaot2skxgn7s54rxb@qp3qicqilpcz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Nov 2023 08:23:38 -0800
Message-ID: <CAEf4BzbUjsW0JfMwZQQYETafs=6yD=cs23W_PJ6=H90YMZudyQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: enforce exact retval range on
 subprog/callback exit
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 2:56=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Tue, Nov 28, 2023 at 04:36:13PM -0800, Andrii Nakryiko wrote:
> > Instead of relying on potentially imprecise tnum representation of
> > expected return value range for callbacks and subprogs, validate that
> > umin/umax range satisfy exact expected range of return values.
> >
> > E.g., if callback would need to return [0, 2] range, tnum can't
> > represent this precisely and instead will allow [0, 3] range. By
> > checking umin/umax range, we can make sure that subprog/callback indeed
> > returns only valid [0, 2] range.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h |  7 ++++++-
> >  kernel/bpf/verifier.c        | 40 ++++++++++++++++++++++++++----------
> >  2 files changed, 35 insertions(+), 12 deletions(-)
>
> ...
>
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9560,6 +9565,19 @@ static bool in_rbtree_lock_required_cb(struct bp=
f_verifier_env *env)
> >       return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> >  }
> >
> > +static bool retval_range_within(struct bpf_retval_range range, const s=
truct bpf_reg_state *reg)
> > +{
> > +     return range.minval <=3D reg->umin_value && reg->umax_value <=3D =
range.maxval;
> > +}
> > +
> > +static struct tnum retval_range_as_tnum(struct bpf_retval_range range)
> > +{
> > +     if (range.minval =3D=3D range.maxval)
> > +             return tnum_const(range.minval);
> > +     else
> > +             return tnum_range(range.minval, range.maxval);
> > +}
>
> Nit: find it slightly strange to have retval_range_as_tnum() added here
> (patch 3), only to be removed again in the patch 5. As far as I can see
> patch 4 doesn't require this, and it is only used once.
>
> Perhaps just replace its use below with tnum_range() instead? (Not
> pretty, but will be removed anyway).
>

I do this to delay the refactoring of verbose_invalid_scalar() which
is used by another piece of logic which I refactor in a separate
patch. If I don't do this temporary retval_range_as_tnum() helper, I
might need to update some more tests that expect exact var_off value
in logs, and I didn't want to do it. Given it's a trivial helper, it
feels like it's not a big deal to keep it for a patch or two before
completing the refactoring.



> > @@ -9597,7 +9612,10 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
> >               if (err)
> >                       return err;
> >
> > -             if (!tnum_in(range, r0->var_off)) {
> > +             /* enforce R0 return value range */
> > +             if (!retval_range_within(callee->callback_ret_range, r0))=
 {
> > +                     struct tnum range =3D retval_range_as_tnum(callee=
->callback_ret_range);

