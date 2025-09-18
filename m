Return-Path: <bpf+bounces-68803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23204B85DD8
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66D3D7B7E73
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D0314B7C;
	Thu, 18 Sep 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDG9y9Nk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4C314A62
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211367; cv=none; b=dHLIFrTqpKiV4Yequ9+AsRBhc6i7in8PDaeV5diYcvA1OC/RWq4JyuTjN9krH00S97FYZxJ7czzjdiAEGZBxHmC35ovjud3or2jbrKuKL89H6KGgz3Fmgv5fv/jiYHScssLp06e2ggoqOqyzvqv+5IexvRa4zH08RMdLvTiFsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211367; c=relaxed/simple;
	bh=LrZKUAO3ywnk+gBp3Su47n15fOX6/zrjj2N+0HVPaMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUk3o9Mr2pTPmnlSLkOUT1XG60qb3DLxfU8REytAhcNmS/woPPx5Bxowkt/ejziMNywjp55HiBOV7OAkO+9EgLBH5arbSOKq3ZSosqZfiStKghBxqZToDyQvlykh9SQBxWcdJttlHEvxj1iO2NCxk2jP7kaiE/nFK3q+tzEuMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDG9y9Nk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3dae49b117bso832722f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758211365; x=1758816165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrZKUAO3ywnk+gBp3Su47n15fOX6/zrjj2N+0HVPaMo=;
        b=NDG9y9NkPIGcHw4oX4VbvDEYIfXxz4zWHCkICmLjuVwP0DImZUEX15D/qmMAe7XJM2
         dIadezZvkotqKyb1CuTOdbYmDxMaOGsyUi1sTKJ9ytmZczSim1QIcwY3Ybj7JqJGdZz0
         IQmjK1fnKWXeAl61wMWMkxHyat9BmuAMy+LJ1a7nTTSP/Ep2z+j7CsqcPbVVttxKAA8s
         okYLfTd6l0tFbdAqSV+kX8R300NxUXtXKXiKvpmNrUP8Mptvjob6UCsbs5gC49uD6Q1A
         USxvZa85CSezID/SeSFeDGKhg8b9oB4sI2QD8UlnUz+W3UZNdzilyyIe86nGbyBYxfQz
         v7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211365; x=1758816165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrZKUAO3ywnk+gBp3Su47n15fOX6/zrjj2N+0HVPaMo=;
        b=SnfKaKg9c+UWaCL2PIj1xvMajGBXsB+aBtkvFS8skoToISbIlvSMWZENB3H5H9xSdy
         YVNcLWIef/4R5vyiEwRz8HkX4B8l9lKQRB8+X0qR+aCGinUbgVe9/P3zl1a2EOYKZjLn
         rvCpje2BVsr9/6ksWh/alLURJl2JTyXPwLt+m/zJ8k6Ady9bekqHbvgESRPXLVRAKiMj
         syASQLJW14Xq1JYQKD9MifeLJ+ypAL4GLJn1eZaaQbCzGWAEjLqRXpVrsT0LFxuCzOxs
         JoUlKYerow39uRdWsBjmCrlPH2xz9ylbBEiE5nGv9pontvKC3HXO/xqIneymbJJfJFT9
         ux+w==
X-Forwarded-Encrypted: i=1; AJvYcCV20qLCNk9LJl6Q8u/SDkGfQL9Nn/oA4o0luNoqCgXIzVnSp9I7khn4TvrXPXk5fNnrZKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkq0+g0Ma7g19IMCqI14cPdvGQ/6aG+QuJBOXRs90EwyZfUbT
	/N5EjHsGu6gF9DetcALGSQ2/QFYKcpXO6Z7Ytp6dUJ4J5OfN2cBFIfEqIf6h5/vSPBPzAqysRQ/
	kOospgXyTxahMDmi2La9UPuVpb9JPblY=
X-Gm-Gg: ASbGncsmooxVR6JY6e4vS+gAws3hT15f3wIeUOtIjfjR00X0y0wvZrD2s7cWmTs0aDO
	SixlKfbtuik4zXx4eTHQ0993CZN4r6aI0hhLx4m2WAfl/3rzgkrnLOP8VhPtbgOpjFIbuMPdpws
	zA+opP7S5oiUKisfMpa7Xv2Hvdwh20I3/MYqqMvK0i/GoXiEma+jWv4uYlrjVqCmgQlnG3BBQ5l
	I+pH5QCoMXg9Ze8UdQ4mBjMHdqRx2u63dH1ajL/tqhoqJkfsyAY
X-Google-Smtp-Source: AGHT+IF/FFBWHRcVTs/+LtBreJEZsaWSmiKBNwb88aF2dIpnUD5x8xfpMpZDRdW+2m9r9+Ji/KaDPmYDlZ8eMY10ixQ=
X-Received: by 2002:a05:6000:2211:b0:3e7:6454:85a4 with SMTP id
 ffacd0b85a97d-3ecdfa16fe7mr5495324f8f.33.1758211364535; Thu, 18 Sep 2025
 09:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net> <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
In-Reply-To: <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 09:02:31 -0700
X-Gm-Features: AS18NWB-ppdSVkapCREEP3Ua9UP5H5-ayQEppp8cCj2htLk07k5VBgjq7znNbDg
Message-ID: <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:32=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Thu, Sep 18, 2025 at 9:05=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_return -=
>
> > > kprobe_multi_link_exit_handler -> is_endbr.
> > >
> > > It is not protected by the "bpf_prog_active", so it can't be traced b=
y
> > > kprobe-multi, which can cause recurring and panic the kernel. Fix it =
by
> > > make it notrace.
> >
> > This is very much a riddle wrapped in an enigma. Notably
> > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is that
> > cryptic next line sufficient to explain why its a problem.
> >
> > I suspect the is_endbr() you did mean is the one in
> > arch_ftrace_get_symaddr(), but who knows.
>
> Yeah, I mean
> kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> arch_ftrace_get_symaddr -> is_endbr
> actually. And CONFIG_X86_KERNEL_IBT is enabled of course.

All this makes sense to me.
__noendbr bool is_endbr(u32 *val) needs "notrace",
since it's in alternative.c and won't get inlined (unless LTO+luck).

