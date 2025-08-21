Return-Path: <bpf+bounces-66141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F8B2EA87
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 03:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10A13B220D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 01:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9520FAA4;
	Thu, 21 Aug 2025 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9XvoMgm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9B205E25
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739298; cv=none; b=JY1c0UaLTo4wgtOiC0jxk3TCwJkGpQVRIq31hsxC/hIRCnpJ7/XuIC1erCkq8FhxIuddOVvobAzq6CX96ajKESsxEAwQzD+XZ5hLWEWQQ8hdWqMVmX6uRSTsVKq9LSmwUupa71E2ZuwkXeXF8HkwIzBAZHgFr1NOiqUP+oUygGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739298; c=relaxed/simple;
	bh=8kNKgRZzXVRCrGmGZF4xSCWdkTEchJVyRhBl18+3IUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSUM/wn9Mzxq2vREyUtIDqQMMwK20J4y6puq1O1BKZoe5rHRK31Zux2RvQa+1DTGolt5hFpwDstEMhNlr4oX2Xa71rNjHop4ne1v1HmiQK6CCW508DXEKYnt5qn4u2YOY6K3MPOAaWiwzISEk7KYi1m8VWHZtd2gJtFaXY3dH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9XvoMgm; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-43772640ee3so144738b6e.2
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 18:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755739296; x=1756344096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbSzbdY3kHTaOmK1pPvMC+SmbvGcvig5ysbbwipvqs8=;
        b=P9XvoMgmnV0LqdtI4fSM0Zrj7tDNY0t7cEWVWOLgLrcsIfYKDX0qKlKw2TN0NFA6/5
         GJJodcIajDSCzkTkEX6e4smB6KK/NFGEjzFfVw9QV5QNYEUP37SPRID/Q+/U/f12xO1D
         9OsUGYYFHEF/9fqTyvJFAVlsy6xdEX3UTnsF3OLBGhm0c1mxIJRpiWjXT94nUpFqYsIG
         GhaMZwnDbQr8Eewxv0KhfG4uNSkC0mAem1HvYKvu4pEBM88vchn6qGSRHewYyu3fUKuN
         FxZivxpPG6QICiyjfJR8A2TXIgmdL7wtybcD9PYmVh19D3ro7U3oUoGQjYmCgkZmqWEH
         cw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755739296; x=1756344096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbSzbdY3kHTaOmK1pPvMC+SmbvGcvig5ysbbwipvqs8=;
        b=tF3LA92KU38guncggbrQ5Ao0EMI/T6O9LwxP0f/mSbYNQQLrN+Qmr8pUkMI3FmFaaD
         8YwqkGQYU7mTqT/59MDs5KR6pld/i0AO9MargOo3wL6ewgJBx3v59CFahfcyL9p+2uFh
         RLQK3WXQDepbin7f2ZRnMriQhF0M9LAh0yomtBdDIy5UhR+F5KYC/oUBjJ7UxzjYo1iZ
         8COrMb3251LtBQ6ft5dp2LNKt4fsIOxR4YkYM43a7S/u+4uQTFG5z0WDPMqnWObj53az
         vz46t3dctprdg+WctUjm0+MxUGDNR3wz637hJ5Kx4CYx20TBJs7HDJoPHQZRM1H5kPIm
         KvHA==
X-Forwarded-Encrypted: i=1; AJvYcCVjdk4kSG4sGQY8aCa/ZjPYO0tBO4/uT4cXEyU5LIy3nEngX8m68HkK+C//XGbx9TdnDUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqHsXVNlRWx5VxjS3VrwPV57NUPVw5j1cmnB8ywhoJ6eKNoss
	197HUQiI5uzjLPjfor4aGP3y/mTN5uaeW5jxSvq670+nwgfj9Txd2FkRxpgT9I77v+1mm7P2Bs6
	ZDR1aZRpNbjbDSKX1D1GYbZqNN/2nOu0=
X-Gm-Gg: ASbGncvlq+Tg+GvfKuutnJSxHT6uSyWOV96lTrwrdjctC/ZSNUZ5mYZz/IOWYGGjAlp
	xTfkLdG1iTapJkgyKOZXvErzozCSAkiZM/buYgSW9BXlUuVM2OqXukrUiokPG8/gfPK/GcHsGk3
	59QB7yP6T+E0mElycwS4KdAZHzhuwmokYMKipd49jwIRJPfkSUp5POjD0nDdjZxPpwoMaSW7DfA
	kK8Eg==
X-Google-Smtp-Source: AGHT+IGPdk1Um7OyVh9GcThP/ox/UyRFOB3NcTp3LXTomORTnPG0fbhENbKRoMtDPq0FDVVcR3h54vgTDOafGAGRFvw=
X-Received: by 2002:a05:6808:179d:b0:437:761b:dd0 with SMTP id
 5614622812f47-4377d802f3fmr196751b6e.47.1755739295741; Wed, 20 Aug 2025
 18:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820103956.394955-1-hengqi.chen@gmail.com> <0cf37a7c-2e14-58f2-1a1e-9311b2e65d4a@loongson.cn>
In-Reply-To: <0cf37a7c-2e14-58f2-1a1e-9311b2e65d4a@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 21 Aug 2025 09:21:24 +0800
X-Gm-Features: Ac12FXxSSqb94RTO7WN1zCcydpJt3k4giY5F3rzM_IA743satsIiNLNsW-aWXVc
Message-ID: <CAEyhmHTZC66cKazOf=fJ6WxSU1R=rpcd86uPwqOvpEBZ=97ULQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Sign extend struct ops return values properly
To: Jinyang He <hejinyang@loongson.cn>
Cc: chenhuacai@kernel.org, yangtiezhu@loongson.cn, jianghaoran@kylinos.cn, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	vincent.mc.li@gmail.com, bpf@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:49=E2=80=AFAM Jinyang He <hejinyang@loongson.cn> =
wrote:
>
> On 2025-08-20 18:39, Hengqi Chen wrote:
>
> > The ns_bpf_qdisc selftest triggers a kernel panic:
> >
> [...]
> >
> > +/*
> > + * Sign-extend the register if necessary
> > + */
> > +static int sign_extend(struct jit_ctx *ctx, int r, u8 size)
> > +{
> > +     switch (size) {
> > +     case 1:
> > +             emit_insn(ctx, sllid, r, r, 56);
> > +             emit_insn(ctx, sraid, r, r, 56);
> > +             return 0;
> > +     case 2:
> > +             emit_insn(ctx, sllid, r, r, 48);
> > +             emit_insn(ctx, sraid, r, r, 48);
> > +             return 0;
> Hi, Hengqi,
>
> For sign-extend char or short, we can use `ext.w.b` or `ext.w.h`.
>

Great. Will do.

>
> > +     case 4:
> > +             emit_insn(ctx, addiw, r, r, 0);
> > +             return 0;
> > +     case 8:
> > +             return 0;
> > +     default:
> > +             return -1;
> > +     }
> > +}
> > +
> >   static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct =
bpf_tramp_image *im,
> >                                        const struct btf_func_model *m, =
struct bpf_tramp_links *tlinks,
> >                                        void *func_addr, u32 flags)
> > @@ -1602,8 +1628,8 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
> >       }
> >
> >       for (i =3D 0; i < fentry->nr_links; i++) {
> > -             ret =3D invoke_bpf_prog(ctx, fentry->links[i], args_off, =
retval_off,
> > -                                   run_ctx_off, flags & BPF_TRAMP_F_RE=
T_FENTRY_RET);
> > +             ret =3D invoke_bpf_prog(ctx, fentry->links[i], m, args_of=
f, retval_off,
> > +                           run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY=
_RET);
> >               if (ret)
> >                       return ret;
> >       }
> > @@ -1612,7 +1638,7 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
> >               if (!branches)
> >                       return -ENOMEM;
> >
> > -             invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off, r=
un_ctx_off, branches);
> > +             invoke_bpf_mod_ret(ctx, fmod_ret, m, args_off, retval_off=
, run_ctx_off, branches);
> >       }
> >
> >       if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > @@ -1638,7 +1664,8 @@ static int __arch_prepare_bpf_trampoline(struct j=
it_ctx *ctx, struct bpf_tramp_i
> >       }
> >
> >       for (i =3D 0; i < fexit->nr_links; i++) {
> > -             ret =3D invoke_bpf_prog(ctx, fexit->links[i], args_off, r=
etval_off, run_ctx_off, false);
> > +             ret =3D invoke_bpf_prog(ctx, fexit->links[i], m, args_off=
,
> > +                                   retval_off, run_ctx_off, false);
> >               if (ret)
> >                       goto out;
> >       }
> > @@ -1657,6 +1684,12 @@ static int __arch_prepare_bpf_trampoline(struct =
jit_ctx *ctx, struct bpf_tramp_i
> >       if (save_ret) {
> >               emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -=
retval_off);
> >               emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, =
-(retval_off - 8));
> > +             if (is_struct_ops) {
> > +                     move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]=
);
> > +                     ret =3D sign_extend(ctx, LOONGARCH_GPR_A0, m->ret=
_size);
> > +                     if (ret)
> > +                             goto out;
> > +             }
> >       }
> >
> >       emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off=
);
>

