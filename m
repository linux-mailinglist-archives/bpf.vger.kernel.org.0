Return-Path: <bpf+bounces-74607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C2C5FD32
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FAD3BA86F
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD391C3BE0;
	Sat, 15 Nov 2025 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu3mQKB4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7A17BEBF
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169790; cv=none; b=coPWCZCJakdaZO+IniSiqhM7xVHPWwj4bF1zzNY+BLFAwwTMjTl6Ws8bFpJTJtYNwBeN2uvTTX63yIxcDqWye8cZx1eXPtKr9iqPpRuD/bELliqIrlacasjAM+qRjOhFohpHq422fJ9DNVwYV6rwWwQZqI207lEqUY/FfmIQJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169790; c=relaxed/simple;
	bh=R3ZDTlr6tfLrD5iVRfPvktDfqD3CtgC5Rov2Fyg2+v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDo5AmGqtU5megf5/y58+CXT81vYzhyz7L6WUygYXEVQWJZTb8CI84nVb1F3boaPMxU0fi/WB8zhAGoKkCcQXKNmQ281WWiEKHEEQYV9G/k5DVpKyvY2MM6FsC6l9QnVE3VKqTgoIqMXJ4/NJ+yv5OZm4uDlPZK+oTpsfAIPLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu3mQKB4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b32a5494dso1505603f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763169784; x=1763774584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwTaaCznhjM8kP8FNhh6L/YLs7Me3AXIgoZIVOEXGxk=;
        b=Gu3mQKB456iU+xR8H1D+u+YSt+yFCvC6Rf9cD0DtSXMql2ZG+NHrR+/MQCdDtfXAWD
         5pgjhlRsfy/rLu11lrknvpPVu7vehxMj/c7mWdX/zmYvuUb6/4UvE6p3cyfqs5V6TTUO
         03XRHohcMwrFFo7ppI6F6UgAfEI0iUz5hR57qQBo0eHZIn/h/tlw4szAUVfyePPpVtrS
         liw5EMStUgAgdFwgz6B6GFDYtIJxnc46JLto8CiAnfyHzFwHgTZQ+B6HrwXrGxXuQIKt
         iCR50If3PavhkkwV59HFAt0bEpox8GursXEigdU7HVeDId3h5/2cBdoOP07u6UINDQcl
         OFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763169784; x=1763774584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwTaaCznhjM8kP8FNhh6L/YLs7Me3AXIgoZIVOEXGxk=;
        b=NPvqCNtucylMsGMzKLUXWQI4HZdIPvFkcdW9PsC4AcAOMcOvl3qbgEFywprPnvCVGi
         zW8aq/eXto+pDKhhQhvhZap1fEogBm4F8chfeqgsPkrlZDNLrhst79eUDz8t3gCUC1bv
         EEIZRNXyjLV9vQfmTdhftThTm/oxjHu0mcymXk76QSFi60Suk76nmB43tDlXa8/HWNmC
         aH1gzlpkw/1oCPFR48BeJAwTzr8JQac/qSXU3wJmE0YXs3RdfIJXByXBkR7vVzh4VXBm
         c9PhFV6J/Wy0TPlTJNUDIND9pRdwCCoLs6Zuu6j3ibWvvFva/7oMcC3H1LWf3Kb2AFv4
         dr0g==
X-Gm-Message-State: AOJu0Ywtjgi1SHVzqtXpzYwmDw74D2hnG0TSLlkCDn0nmN3fcsF1aez2
	214N505jCucrhXMiTY+TtArzqjYZ8OCt2GFGNoiEDSdYGglEoRAtlgvRYkXNCpXF2Mf6kwfsb0f
	uUsr3FOGrAMmImIRXDBM9Jk8+SbnA7fo=
X-Gm-Gg: ASbGncsJI7dALXIfzvzpDxtaxqdGRdjO7Qit8cFIBX04HeF+sHma9ti0nS6raFXbMBA
	0V7am+faztQiJAdzr4pWC29+EUwkPdSuF6bPsSGdSqol359hPXm5iAiHvIjxWtu6NnuwOojHcNq
	WQ4efWXO6AtnFOynzobWqmpuL53aPDAEs3MVPPMmrvse59as4a8ilkBSzR+G3Cyl3RZKorq9XAe
	Lf+saRZfFDL1DJhZJMConYY4w/kXRkhaRpwISx71ddhgaJT1qTmxFfvNDxtlMpwH8gYkkYY0+YY
	fVxr+Y+xmPju8dLVNHoOw6LipQSYElAMmnAXArI=
X-Google-Smtp-Source: AGHT+IGNZl/HRxGUNRQhN1f9LWaqHiT5l6NTJj2NXzgBiOpjKUM2v93fHrF6RWjCti32K4Wtb3PWLLNT/UPIWy+z+1E=
X-Received: by 2002:a05:6000:2506:b0:42b:3268:bfc0 with SMTP id
 ffacd0b85a97d-42b59374c7amr4108820f8f.49.1763169784238; Fri, 14 Nov 2025
 17:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com> <7843b2f823e180f2641585f36dbef5f6a00766ff.camel@gmail.com>
In-Reply-To: <7843b2f823e180f2641585f36dbef5f6a00766ff.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 17:22:53 -0800
X-Gm-Features: AWmQ_bk1g_2oYKizmL1Nt2-WCKIQKXvrXj-RVZsX4ENwuYISoaaNUKiY-3xnhSI
Message-ID: <CAADnVQKkrbwr0M+0Kp5v+X1DG=3YaK3Y5birirG4uaqz_KaLXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in
 the verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Hao Sun <sunhao.th@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:
>
> [...]
>
> > +static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf=
_insn *insn,
> > +                           struct bpf_reg_state *dst_reg)
> > +{
> > +     struct bpf_verifier_state *branch;
> > +     struct bpf_reg_state *regs;
> > +     bool alu32;
> > +
> > +     if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D 0=
)
> > +             alu32 =3D false;
> > +     else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_val=
ue =3D=3D 0)
> > +             alu32 =3D true;
> > +     else
> > +             return 0;
> > +
> > +     branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, fals=
e);
> > +     if (IS_ERR(branch))
> > +             return PTR_ERR(branch);
> > +
> > +     regs =3D branch->frame[branch->curframe]->regs;
> > +     __mark_reg_known(&regs[insn->dst_reg], 0);
>
> I was unable to prepare a working example for this, but consider the
> following case:
> - arsh operation is not 31 or 63,
> - but it so happens that 32-bit range is [-1,0], while upper 4 bytes
>   range is not.
>
> Is it possible to get to such arrangement after arsh?

The way arsh is handled now, it's not possible.
32-bit arsh clears upper 32-bit (as all 32-bit alu-s).
64-bit arsh is doing:
        /* Its not easy to operate on alu32 bounds here because it depends
         * on bits being shifted in from upper 32-bits. Take easy way out
         * and mark unbounded so we can recalculate later from tnum.
         */
        __mark_reg32_unbounded(dst_reg);

so not a concern today, but...

> If it is, it looks like 0 case should follow same logic as -1 case and
> conditionally do either __mark_reg32_known() or __mark_reg_known(),
> wdyt?

will do it anyway. just for consistency at least.

btw there is zero veristat difference on meta progs and
one scx prog went from 14 insns to 16 :)
For schedule_stop_trace() prog llvm generated this pattern:
w0 s>>=3D 0x1f
w0 &=3D -0x16
it didn't affect the outcome.

Interestingly how latest cilium's bpf_wiregard.o
loads fine without this patch compiled with -O1 and -O2,
though this "s>>=3D31 &=3D const" pattern is there in assembly
in 29 places with -O1 and in 22 places with -O2.

So it looks to me that this push_stack() approach is a safe bet.
It doesn't happen that often in production progs.

