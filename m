Return-Path: <bpf+bounces-68835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD816B86539
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4BB3AFCEE
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926F284886;
	Thu, 18 Sep 2025 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDheYGbp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B52820CB
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218048; cv=none; b=WcRnhoP1C0k/2GvrAzCH7158zIshKhJIN0yQgNUBGWbZ0LzXnfcOvubZgQePfsi03cCoGkgfL53y4b4hZI0vC0WAnI5yKFcd4pqJVcLsqo/nNJZEBNcnDW5AZk0gABhjbm5r82jQ3KIyZwlteZrm0GbhLIhWWwki4VDTSJnRJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218048; c=relaxed/simple;
	bh=zBmeDJokNLQXp8RYGcPbjJ9WEW7sezS1c2BqhSqfsKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRMYWtVjmTQAyhTDw/8gFsw1myh8um6hH88h2mw7FknGCjxo7t6+Cx3hUs0kD5onTNtQ5o0gLuB4FqDXR3IlkRzpbDOFZSFw/BBK0GFD0vlV1wwonMxIu4hpFrdsJi8eyesAsVWHbr2af/lSr+aBPlnu7rWQ136VgdtxjFF1+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDheYGbp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso852830f8f.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218045; x=1758822845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBmeDJokNLQXp8RYGcPbjJ9WEW7sezS1c2BqhSqfsKU=;
        b=MDheYGbphmnmQlC/31zqeNUO85hnoDnGvPbmIwfVHTqlc9sJR0CpY8bSCc4Lo8Ezy8
         2RBaQKViwsyHt4HTfVrClDiy4XVJO+H/X2mQ2c3oLl5ch/TLFJwSdeXB8Q56QKUSgyCH
         vIWlRrNTXKmIyGjoEdEw2tgvl0pQE7008vwPka4zPU+6yaEERvqWl0Oh4fDPTA72ocTe
         7coG0QzqEs2Fr4xRYl/DuDrOj7sopTOg8fm5DFZdWjPTgw0Gl7C+kpfxINSfgLvXHZ1Y
         tOeNybBK2eB1z3d94VeRnaDKV2RjpmQmDaKjy/3M6Utq/f5Pdqf3pduvSGD+cGj3G1NH
         QXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218045; x=1758822845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBmeDJokNLQXp8RYGcPbjJ9WEW7sezS1c2BqhSqfsKU=;
        b=m7ql2kti9xxQ7QnY3PzOpa0wXbH32pw2Z7Dl8gwHtYXwGxKdYnbuuRVIO6ID0cbBaj
         SfKieAePe92vZNnoPk8Drsrqeft0bpmqFg2IffnMrHiIlFM8bBPeHIZz1F1DdHkPDCws
         H33g2KcmJm7Cnzz0bLr7t5PIoMsbb8EMnkpSYhn1oLHr2oXegmATJcYgAQCdYN6yqzOm
         SsjlAKzIHAXIufqvGMRakyT//UGK6I+Gz//Bjhg+EsHfVnmzzLLAD6M3dV6h8X4iaPiA
         zZE9fSqryrpNqgJtp+zHJt2tvYlsTtH2Z4Pb13L1pHQ5ikyq8F8xZhUo5da3gy3sED4O
         IfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuS2fQ8kii+QPl+f7W4WOp5mPcbcWVTssyXrhPpv3jyplB0n81JIkzw508v1c0rRY4gzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnlf43rV1VrfhwtaHfYH0ZkU93vGTvbPz7ouc05IO8prnnD6i
	RD7attNcDTX+ab3UBpcNV4oM+cHMG8Fcs05s/Kw3zPQ9yfMGzjt2JLOHaT9XXshsqKN7sL163XL
	601w0xg22k27lCKTcXrWcFkv0ymchpd0=
X-Gm-Gg: ASbGncs0O236ZMoVgZ2VZvUvnyX7AV14sHqcMrf1uGO0nQee348ogKx4l6afeM15N3q
	V0TGGauKGbMZWefGTX8Xk6D2lHKQ1sRR9qAzi989NnmPTDo3L7u3+u+idCV9/gR9MisEf28VTzt
	KwMhUbJYTy9Z4i0e/xdy/T1PJ6q2ueihs7OERBw294V09fA+EO/sdR2HaEpbd8EiMlenloLpO/a
	epVGDlfl3CX8qAfmcMUDm+q/yQAk8b+I4dehHc+Gg==
X-Google-Smtp-Source: AGHT+IH3g1hib5RZjruPeL0g+q1AnwX7TjOn6ttwoWWeo1TMSgAIRtPgT543+gE79wYZjWrKyfpzEcQx1jXvR5GSC1A=
X-Received: by 2002:a05:6000:1789:b0:3ee:154e:4f9 with SMTP id
 ffacd0b85a97d-3ee7d0c8af1mr191670f8f.20.1758218044443; Thu, 18 Sep 2025
 10:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
 <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com> <20250918165935.GB3409427@noisy.programming.kicks-ass.net>
In-Reply-To: <20250918165935.GB3409427@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 10:53:51 -0700
X-Gm-Features: AS18NWDkaHp-pjH2K4r_CAiTEfd3U6JL0GsQiWcLpfpyDR9kUwo2oqVemfqnrKA
Message-ID: <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Peter Zijlstra <peterz@infradead.org>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Sep 18, 2025 at 09:02:31AM -0700, Alexei Starovoitov wrote:
> > On Thu, Sep 18, 2025 at 6:32???AM Menglong Dong <menglong8.dong@gmail.c=
om> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 9:05???PM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_retu=
rn ->
> > > > > kprobe_multi_link_exit_handler -> is_endbr.
> > > > >
> > > > > It is not protected by the "bpf_prog_active", so it can't be trac=
ed by
> > > > > kprobe-multi, which can cause recurring and panic the kernel. Fix=
 it by
> > > > > make it notrace.
> > > >
> > > > This is very much a riddle wrapped in an enigma. Notably
> > > > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is t=
hat
> > > > cryptic next line sufficient to explain why its a problem.
> > > >
> > > > I suspect the is_endbr() you did mean is the one in
> > > > arch_ftrace_get_symaddr(), but who knows.
> > >
> > > Yeah, I mean
> > > kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> > > arch_ftrace_get_symaddr -> is_endbr
> > > actually. And CONFIG_X86_KERNEL_IBT is enabled of course.
> >
> > All this makes sense to me.
>
> As written down, I'm still clueless.
>
> > __noendbr bool is_endbr(u32 *val) needs "notrace",
> > since it's in alternative.c and won't get inlined (unless LTO+luck).
>
> notrace don't help with kprobes in general, only with __fentry__ sites.

Are you sure ? Last time I checked "notrace" prevents kprobing
anywhere in that function.

