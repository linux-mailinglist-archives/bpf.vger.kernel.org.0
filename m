Return-Path: <bpf+bounces-78791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2ED1BDF4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFB63027CE3
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804302222A9;
	Wed, 14 Jan 2026 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhc4kwXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EB21B191
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768352134; cv=none; b=IBjSrt51PQ5+ltGOp2WZRVPNdBZwAjGEPSlPkO3ogWlyUdvcPgfw9fFVf/vHCnBMu2LfpdiADE0otNRU4Wi4dcmf13HCeyuvAIIOJcwKHdilPf0gANJpTcewDHEpoCDFRSDzUnOoRh4YjTeBakgjMEfwzATyNda1O5bzS+tZGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768352134; c=relaxed/simple;
	bh=A5lNNa5LclWeOXlyu55YLb3ROboqOx9mWRjgL/e5NAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmVm1s1XEeabbIv3W7KZ0EMg1z4W8QRi2S3lbP9L7rh3V6fNoOuuUGWbudOwVFh3Z+Piul8iKl1jZXelinjs1fT8nkdKiyZNkAEZ4vDe0q3/Via71W+79nL79BC7fqU3jmmeXYkCa0dr7iWOoTE8Hv+ylDK+MwT+/P94lVzqtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhc4kwXU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbc305882so4426255f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768352131; x=1768956931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oYQZhp7slQJfitrbSZtcH8c6t2q5WuQfLBVE8cEK/4=;
        b=Rhc4kwXUs+en/+zJhTRyiEkTY74FPp74QHjywGxQprJ1VY7MzkiahJzW08eRSqVdXx
         VVXtS5KuVVhHZJcJSzKrJTn14RCIq2rIR4B+oAA3FDipC7/6f4bcPFMF9+tTRMyYt1Eg
         JceaPUEDZsMo/KZs49NAOXJm/6NrV0Re2qUQyTE1UMHUtSLzcgI/a7zyhRQcwHINFUaC
         pG4mrKTkwNEktZUwElByufcTBbOU96lAwTDDWWoNurJidMAXY/1Qqcuqa9/qIFZ9+RC2
         bw8cCI1CY3Ls8mTttI2RfStPcXRVQa7IRS//XBpV2pSqM3+ebC7ENjrO9HgFOxyFkUGF
         Es/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768352131; x=1768956931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3oYQZhp7slQJfitrbSZtcH8c6t2q5WuQfLBVE8cEK/4=;
        b=gxL56PSXrL6hdBbQ2g3WklzX7XrAGjs684oeUHYu7pYOzdkUR/Gfdxx6yFIGnLkIwX
         8o1Yk+UVTwT4ZKFnCZvRYpKSv2cqrb+l2dRuqRp8DnSqIvGEm3EKDX1FVT06VPXKkLjK
         iAfQQq2qX5+qgE+GYI/V+o4uvRf9pdZtkvuEVhM+Shcko3zeDuHYoLh374l5ISrxQMul
         fxmD1oe9j37VdlGSAuMOUMNKiY5IaX+HJ+Fs9lHNqqOiPgctyqmk+uJ5G/6NlEMLYwKG
         Xb80K+QUGyEtwHn2ybe0z9yCBR2ZOT/7QZHKaaaRiAESB4Dmk1VoH4/fB/8UqznDGJzR
         3MqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr8dB/GWzpZCwHQG12FHP/r8WRABRnr4puDeOa8IgADzmd+JmIj6cwygWzVfokGm6dqZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+KUZVqVEMmbHGcEWi3kq6xEGpdVSGl4ObrwSnMrMXv+2xmjcQ
	fHo1k1bh1G5+Ghvd+z9+wiH8cku2vzuO1p1bchVsbNN6H5VCmzAiRNGXdIW6zcViou2RVUdsixy
	5TetptcnnXsfMmMYCW7LKK4L/Uo6bdxY=
X-Gm-Gg: AY/fxX576jc3VKiFGEC3zg3Sxptrr+sepAVMtlxABvlfkAets6fOOkdeXMJID4qkZcZ
	oKXxAuBO2geZ9ovif+73SOrWH5GMAJAwHGuiMsim7yOI9MuS/BGeFnoZoXxESlJyKpCFrYjoXcs
	MoKIuQNzsnq3myGYaRi2AszkJXw3+bTZUG2miP3rOtIWz9R87J64n9rXoTpiWU+KO3y3dtqpNFy
	77cSRcKfvJyfNFxRRi4LEyE19marFD5ziFO7zgj0KDlLGIz3rG5QEbfZ2oup5OxxZ7T7PwnBnmG
	bMViB2OdLBHUV8s+uQ7oGiKJbZ4lplsaivq2TrQ=
X-Received: by 2002:a05:6000:2303:b0:431:752:672b with SMTP id
 ffacd0b85a97d-4342d5b1738mr328303f8f.14.1768352130862; Tue, 13 Jan 2026
 16:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-4-ihor.solodrai@linux.dev> <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
 <93ecdc25-aa5e-485b-8ff4-a9db3b585861@linux.dev> <c7e2a776-52f9-46ad-8422-3a9202bbd9f1@linux.dev>
In-Reply-To: <c7e2a776-52f9-46ad-8422-3a9202bbd9f1@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 16:55:19 -0800
X-Gm-Features: AZwV_QhCzsIYiFSU9FG_3aoIq8uD6CZR4LYkXkB8jEMHKtnpgVl7w-Izz3rAlpk
Message-ID: <CAADnVQLizVA16Q-wVMd5-00YSPZtyuu7Exn9B8c_r1rn2cztkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 3:48=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 1/13/26 2:03 PM, Ihor Solodrai wrote:
> > On 1/13/26 12:39 PM, Eduard Zingerman wrote:
> >> On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
> >>>
> >>
> >> [...]
> >>
> >>> @@ -14303,6 +14358,17 @@ static int check_kfunc_call(struct bpf_verif=
ier_env *env, struct bpf_insn *insn,
> >>>     for (i =3D 0; i < nargs; i++) {
> >>>             u32 regno =3D i + 1;
> >>>
> >>> +           /*
> >>> +            * Implicit kfunc arguments are set after main verificati=
on pass.
> >>> +            * For correct tracking of zero-extensions we have to res=
et subreg_def for such
> >>> +            * args. Otherwise mark_btf_func_reg_size() will be inspe=
cting subreg_def of regs
> >>> +            * from an earlier (irrelevant) point in the program, whi=
ch may lead to an error
> >>> +            * in opt_subreg_zext_lo32_rnd_hi32().
> >>> +            */
> >>> +           if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
> >>> +                           && is_kfunc_arg_implicit(desc_btf, &args[=
i])))
> >>> +                   regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> >>> +
> >>
> >> Did you try doing this in `mark_reg_not_init()`?
> >> This function is called for R1-R5 some time prior this hunk.
> >
> >> Did you try doing this in `mark_reg_not_init()`?
> >
> > Just tried, it doesn't work because REG0 is considered a caller saved
> > register, and so it breaks the zext tracking:
> >
> >         #define CALLER_SAVED_REGS 6
> >         static const int caller_saved[CALLER_SAVED_REGS] =3D {
> >            BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_R=
EG_5
> >         };
> >
> >         [...]
> >
> >       for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> >               mark_reg_not_init(env, regs, caller_saved[i]);
> >
> > CI run for the diff below (on top of this series):
> > https://github.com/kernel-patches/bpf/actions/runs/20972520708
> >
> >
> > [...]
> >
> > ---
> >
> > Resetting all reg args appears to be working however (see below).
> > CI: https://github.com/kernel-patches/bpf/actions/runs/20973490221
> >
>
> A follow up after a chat with Eduard.
>
> This change in check_kfunc_call() appears to be working:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 092003cc7841..ff743335111c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13958,8 +13958,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                 regs =3D branch->frame[branch->curframe]->regs;
>
>                 /* Clear r0-r5 registers in forked state */
> -               for (i =3D 0; i < CALLER_SAVED_REGS; i++)
> -                       mark_reg_not_init(env, regs, caller_saved[i]);
> +               for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
> +                       u32 regno =3D caller_saved[i];
> +                       mark_reg_not_init(env, regs, regno);
> +                       regs[regno].subreg_def =3D DEF_NOT_SUBREG;
> +               }
>
>                 mark_reg_unknown(env, regs, BPF_REG_0);
>                 err =3D __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_E=
RRNO, -1);
>
> https://github.com/kernel-patches/bpf/actions/runs/20975419422
>
> Apparently, doing .subreg_def =3D DEF_NOT_SUBREG in mark_reg_not_init()
> breaks zero-extension tracking somewhere else.  But this is not
> directly relevant to the series.
>
> Eduard, Alexei, any concerns with this diff? Should I send a separate
> patch?

This is odd. Clear it only for res_spin_lock() processing?!
Should be around lines 14149 instead?

First, need to investigate why clearing it in mark_reg_not_init()
breaks things.
That's what clear_caller_saved_regs() is doing already.
Maybe these two loops in check_kfunc_call() should be doing
clear_caller_saved_regs() instead...
Needs proper investigation.

