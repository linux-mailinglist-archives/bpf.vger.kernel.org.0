Return-Path: <bpf+bounces-68877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D11B87939
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 03:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A583A7E84
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 01:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C821C194;
	Fri, 19 Sep 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjY9hrsJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C891DB92A
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244409; cv=none; b=k1/M7bB5Gi6jlphFdOZIQjZNHosM9QXdedR/7Dn5c5DXwwQHesqQJ7H3U9BMgMzaTaWcp4x5Tjz3eHGsjERm0be2hMBfY8ZVi3siuylUliKYddeYHoUeu5kG8sf6S7RP455cFbz524vmNwI0r4o8ylgpijYnekOc8TsJ+32p/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244409; c=relaxed/simple;
	bh=NVCINHnu5XyfIfTH/bt86LXIAcWVL7rBMtyraEGrHC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHPzs/9QBEEX5WAIpwNDhz+ULSWBAFgqnyVSXOrfNLMH9jr8sR3KJjUksfhoMXOM81CL+wuNURvZglfqQkPGzfD7prkS2Nbqn2g0RxXtRT2fhthYB1cSK0SYOn7V1XWraRR0qTddnQGW1vf2qaBNediC9BfBfo91w+T+nOyq17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjY9hrsJ; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-ea5d856ac28so969237276.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758244406; x=1758849206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaDUMudIdIoXqVSWD7aQteCIRPR13lkKvGy+vWqzuRs=;
        b=PjY9hrsJpWRZjxUKvfRPzJ0MAMN9MBU9Xx/35oozjr7wXcKJmWZzKgDNVNECOaJ3S4
         yPstgd2eTT1np2B7TzMwTU1aPdTiBPdGoA28Fb80BMXXTKgaswPWS0zzIepfUTfee88h
         qs5jw/5yHVlPoNjArPh9RMrgUiCE2FvuARw7/sK8wOuK5Sl7wn2BdKExDIvVTHnEqZPe
         jj69BjUBjGDWQK+tXFrDRmcwdBjak1SSQTTVkcOH2uImgMXlaspS+pY4TicYPj6VUs6v
         w1nhVAyRmDVw0iSfQ/gohVPSP1yviZZgn+TBagrxGwgWgIJKtQHa07cgSGk7TN6XKkQW
         IYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758244406; x=1758849206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaDUMudIdIoXqVSWD7aQteCIRPR13lkKvGy+vWqzuRs=;
        b=mWKGPU9rWoIk5BSdXR+AdgE/6g60JLBPyVczaGnVr265HcZbrPLTMsL1iRIT8WCKGZ
         WIiMH6oejqNIxPExsn9J6M3T4mq2veq9l9AaicFo4bWn7710ZIuvKQ62HrvPfE409mJ8
         8GFePvFOTTFMFkqkR57F19TCFM2dv09SS1teK6xhrzyV16Co82SA7aFYJbK32Uwlhbxl
         fuTOJ6o6upx+2rW07PvKNE/VjXlnKG6N5J5WXzKwt4ndEeprml9PVZf0h/t2g6RV1iTV
         8M1FQkS7xrUjv/lgQ3NL8xVPfi6U6xzJRBKm4WamRD2sPr3HoaLsGruj5yZDDwDP8yDI
         6M7A==
X-Forwarded-Encrypted: i=1; AJvYcCW6ICEXtvd+Qj2BFq0N/Bzz6Y/P+MvAuDFij+yQyzmlrUKkq30wTU5t/hr5n2pHwanE1Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQXYgIkKfaL6WTII+CR20zzw/sYwJYnRDA0yYvPhujdVXyLhZ
	rxNkESIbIvjhxbcnwsGudajbHV2VB6sAA/uXv8fHw+wHa+DKCT2RFYAb7+qElSEceZEtNTE65JM
	9rGI2TyTGGXw50K8MfdX06zKpDqPxyuY=
X-Gm-Gg: ASbGncv/M1piQJlLaVy9BW6nlANAb5ROsOXgtqM49mElND2lFSkOVjhCXIOn0JiyLgR
	O5h1lZJNXI4/7vCjpOjMkkOSH9cjDkuae0EYbGPt7JfUt5p5fSE5B7P+efXXbAPEyVtusbLoe5O
	3LPPezMbDFCzyO3eR36LLEfwGd35WhqTJ1vASjOpurtDad51DUsWoIW3wP9Oe2phkQfH1rdAlXM
	Ca9zECY0GSaFmGG/tcKuJc42A==
X-Google-Smtp-Source: AGHT+IEumflFqxMIDelqzF9utD7SHQtq+byoVXjwm9PjmcKO8ElbCCJANIQDmAQLixQbUCfi+eavIP+X7gcIDmKJF5k=
X-Received: by 2002:a05:690c:39c:b0:732:39a:8218 with SMTP id
 00721157ae682-73d32a37511mr14712097b3.20.1758244406202; Thu, 18 Sep 2025
 18:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918120939.1706585-1-dongml2@chinatelecom.cn>
 <20250918130543.GM3245006@noisy.programming.kicks-ass.net>
 <CADxym3ae8NGRt70rVO8ZyHa3BvWhczUkRs=dVn=rTRMVzrU9tA@mail.gmail.com>
 <CAADnVQ+hOdOpCR6s_GyO_7xxehCPBHSttidia38P5xFie6yjnw@mail.gmail.com>
 <20250918165935.GB3409427@noisy.programming.kicks-ass.net> <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
In-Reply-To: <CAADnVQLP6-s_dtGpEcnFaVJfDW12rTOS2qk5k0Fyvn=4Gn7gBw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 19 Sep 2025 09:13:15 +0800
X-Gm-Features: AS18NWAZ9aDs6021Mx5sft0htLC24LyiQ02L56VQS2hwJXPhGzNa1P40F0wX_NM
Message-ID: <CADxym3Z6Ed5xjDMvh4ChRvrw_aLidkGrkgbK+076Exfmp=m3SA@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: make is_endbr() notrace
To: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 18, 2025 at 9:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Sep 18, 2025 at 09:02:31AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Sep 18, 2025 at 6:32???AM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
> > > >
> > > > On Thu, Sep 18, 2025 at 9:05???PM Peter Zijlstra <peterz@infradead.=
org> wrote:
> > > > >
> > > > > On Thu, Sep 18, 2025 at 08:09:39PM +0800, Menglong Dong wrote:
> > > > > > is_endbr() is called in __ftrace_return_to_handler -> fprobe_re=
turn ->
> > > > > > kprobe_multi_link_exit_handler -> is_endbr.
> > > > > >
> > > > > > It is not protected by the "bpf_prog_active", so it can't be tr=
aced by
> > > > > > kprobe-multi, which can cause recurring and panic the kernel. F=
ix it by
> > > > > > make it notrace.
> > > > >
> > > > > This is very much a riddle wrapped in an enigma. Notably
> > > > > kprobe_multi_link_exit_handler() does not call is_endbr(). Nor is=
 that
> > > > > cryptic next line sufficient to explain why its a problem.
> > > > >
> > > > > I suspect the is_endbr() you did mean is the one in
> > > > > arch_ftrace_get_symaddr(), but who knows.
> > > >
> > > > Yeah, I mean
> > > > kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
> > > > arch_ftrace_get_symaddr -> is_endbr
> > > > actually. And CONFIG_X86_KERNEL_IBT is enabled of course.
> > >
> > > All this makes sense to me.
> >
> > As written down, I'm still clueless.

Ok, let me describe the problem in deetail.

First of all, it has nothing to do with kprobe. The bpf program of type
kprobe-multi based on fprobe, and fprobe base on fgraph. So it's all
about the ftrace, which means __fentry__.

Second, let me explain the recur detection of the kprobe-multi. Let's
take the is_endbr() for example. When it is hooked by the bpf program
of type kretprobe-multi, following calling chain will happen:

  is_endbr -> __ftrace_return_to_handler -> fprobe_return ->
  kprobe_multi_link_exit_handler -> ftrace_get_entry_ip ->
  arch_ftrace_get_symaddr -> is_endbr

Look, is_endbr() is called again during the ftrace handler, so it will
trigger the ftrace handler(__ftrace_return_to_handler) again, which
causes recurrence.

Such recurrence can be detected. In kprobe_multi_link_prog_run(),
the percpu various "bpf_prog_active" will be increased by 1 before we
run the bpf progs, and decrease by 1 after the bpf progs finish. If the
kprobe_multi_link_prog_run() is triggered again during bpf progs run,
it will check if bpf_prog_active is zero, and return directly if it is not.
Therefore, recurrence can't happen within the "bpf_prog_active" protection.

However, the calling to is_endbr() is not within that scope, which makes
the recurrence happen.

Hope I described it clearly =F0=9F=98=89

Thanks!
Menglong Dong

> >
> > > __noendbr bool is_endbr(u32 *val) needs "notrace",
> > > since it's in alternative.c and won't get inlined (unless LTO+luck).
> >
> > notrace don't help with kprobes in general, only with __fentry__ sites.
>
> Are you sure ? Last time I checked "notrace" prevents kprobing
> anywhere in that function.

