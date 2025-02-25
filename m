Return-Path: <bpf+bounces-52507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530AEA440F9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CF37A6B34
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53145269830;
	Tue, 25 Feb 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c45E3FOn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27026772D;
	Tue, 25 Feb 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490544; cv=none; b=nu+9S6+yCPW/4pg/DLunl4Tdxy7raZQL54rKeqoaJdHw9bgtcfaipsgtWNTmr5JUbgMlY8ZD7oHnYkrRud5nPHZM3Fbt/GZtqWvgTysfb5hfRBdDy8bZeW80jX4PwkTqtgPmkpR+Xs4T9Au0pFHJkwVgLSaBetg1o8AvazH+juQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490544; c=relaxed/simple;
	bh=ucXOOXen6EfBi1st8qEzQiNdZQ9t1hTv+Day5P0J/ko=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3XoDrau+bMdkWIbEoqaBJPiFurHElEg4zvIvf3QfiZx5ETJePY1uwcDI1Zi66I2mc1xPPmSsiUcG0CLvORgwXKuyEaf3pvskPLwUA7cbXPxyU5jJ1/bSbiBpnHqeo6qdaow2BqyPh71k0r7ArPNs+yszdnYDv+YGE0azCihyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c45E3FOn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so4058609f8f.0;
        Tue, 25 Feb 2025 05:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740490540; x=1741095340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tnPmEicx+PRAtzm6pe4Eno9ZF32qRgxFaSmqT4meCGw=;
        b=c45E3FOn7uIwmzIAun9trZ3S+jvnEcc5Yt0tc5++jIknqFnCQSyQUxTiF176WYfXAg
         kTYAjAKsckLHMuJASup+Cvtc/cu9H+mrNgWZDZPGCq0eEvOjAqCHr2KLzGXt3FITHquY
         G2/fRJhp5XTrFX5szkcP3cg3csnQl5b6kT7hoe6iYMwREvOFA0F8xdUPMYVRdT2CNvmH
         hIvUMNyQ0k5sWw1tzrMF2g67gdkWz4JeijesSOCbOrEtSn6MLU4bb4huEqSu3LWo0Elf
         rSsoQPtDkZLF0zsrWlVFEDGetzPyO+td82OhmCmInxwHco8ZZWNQSGqFRpf44cGvuXFm
         KHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490540; x=1741095340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tnPmEicx+PRAtzm6pe4Eno9ZF32qRgxFaSmqT4meCGw=;
        b=ZyJq/PeOexZMCUmr3HWdtLf8YbTJbp5LqO11Ez/2vh1pT+KEqvjlLry9PgfwXtA2jO
         IpdgdOA/Cm2gmp9cG5CeGuBT16T6AgBWeHNHi4gfhTr6/4Pfq0IVfEEjZwH7w6KZR7w8
         bocGCshzKPC1Ffj6eecv8aKBYrFcEDpk2m8Zc9tjfJcKKypUizzlzyh6U4ktJMj7QBKT
         iYKUOMYcnNjNbkfQcu5buModQpiWqrv/5k5mqgCHyRx+8tT9mWDWCq5sA/D9wyhNd6RY
         l8KG4aozHWP/8rT22KprARinmpqe3tg3m8j8Sj18RJNv9ADlRICs8s0NuRcMUlqe7LQ2
         wPEg==
X-Forwarded-Encrypted: i=1; AJvYcCUmA7AHSkxuwjCYIGBsghL9ejM+Z03G5nSkqkbt8jl91Wn1C5f4htVro+BhWDR+TNx4nPs=@vger.kernel.org, AJvYcCVyJQvnXVyQY58RFcMp/rfQ/LKO6BHRhSKvCMJWXpwvGZe5Yi4g5vabXKDImKIz4+aNdjJO/2Wg060n0wPv@vger.kernel.org, AJvYcCX3LHig6HX84PwxddqatUW6u4oo4Dsc5PIUjlf72OlqI4LsDikn5iRmYBfmH4X88FRXAwTNtpHZqgq4SoeUyqzoE4bR@vger.kernel.org
X-Gm-Message-State: AOJu0YxftJHv2DEye53ZCv77rS+f+PDVln7i6peyGcYla5DanzSC+kTO
	67EjvcXdVjn1POz1MJKMPt82I77Q7hoejgFmjlJlG9oUZz+/rIff
X-Gm-Gg: ASbGncueQ1ulaxMQxMiMQGhZEgDR0d7sI6lMO76UfMSZqwRPh/Oj0sHa4CJ//y+a9MC
	2EETSGcK/Ey6t/FQQhucZ0QbF9LTd3gddKZntF2a24xJac8l/gIQCCG1453v9M82VTO3rcqrhWv
	TpFmRGjl6cmdAhmfl+6Z0kIo0p9ocjlhX0FkIUH4So5syErmwGJK8dsRvHw71iv4uz1TO+SNg2e
	UR5t1dsgfHrDW2wfC9wytQJZk3dJoqi4d/VFNoFUCSUWUCLyWkDTyO1q2/ms7MKsWEA1kqmpoqC
	PzFIoe6qXqotGkkr6Qs=
X-Google-Smtp-Source: AGHT+IHycTtTcXq7MrkPyPlqMfLwfA3JqA0emRZEu9JW7bvsTOpXwu9WBSiB5eInJrlK4691Xip5Mg==
X-Received: by 2002:a5d:6d8f:0:b0:38f:2111:f5ac with SMTP id ffacd0b85a97d-38f707b0941mr14871078f8f.31.1740490539972;
        Tue, 25 Feb 2025 05:35:39 -0800 (PST)
Received: from krava ([2a00:102a:5013:7b7d:132e:7dd4:845b:548e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c992sm2294723f8f.27.2025.02.25.05.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:35:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 25 Feb 2025 14:35:36 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv2 08/18] uprobes/x86: Add uprobe syscall to speed up
 uprobe
Message-ID: <Z73HDU5IZ5NV3BtM@krava>
References: <20250224140151.667679-1-jolsa@kernel.org>
 <20250224140151.667679-9-jolsa@kernel.org>
 <CAADnVQJ_-7cB3OaeFWaupcq0fRPh3uP62HBGxq0QbyZsx3aHqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ_-7cB3OaeFWaupcq0fRPh3uP62HBGxq0QbyZsx3aHqA@mail.gmail.com>

On Mon, Feb 24, 2025 at 11:22:42AM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 24, 2025 at 6:08 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > +SYSCALL_DEFINE0(uprobe)
> > +{
> > +       struct pt_regs *regs = task_pt_regs(current);
> > +       unsigned long bp_vaddr;
> > +       int err;
> > +
> > +       err = copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3*8, sizeof(bp_vaddr));
> > +       if (err) {
> > +               force_sig(SIGILL);
> > +               return -1;
> > +       }
> > +
> > +       /* Allow execution only from uprobe trampolines. */
> > +       if (!in_uprobe_trampoline(regs->ip)) {
> > +               force_sig(SIGILL);
> > +               return -1;
> > +       }
> > +
> > +       handle_syscall_uprobe(regs, bp_vaddr - 5);
> > +       return 0;
> > +}
> > +
> > +asm (
> > +       ".pushsection .rodata\n"
> > +       ".balign " __stringify(PAGE_SIZE) "\n"
> > +       "uprobe_trampoline_entry:\n"
> > +       "endbr64\n"
> 
> why endbr is there?
> The trampoline is called with a direct call.

ok, that's wrong, will remove that

> 
> > +       "push %rcx\n"
> > +       "push %r11\n"
> > +       "push %rax\n"
> > +       "movq $" __stringify(__NR_uprobe) ", %rax\n"
> 
> To avoid introducing a new syscall for a very similar operation
> can we disambiguate uprobe vs uretprobe via %rdi or
> some other way?
> imo not too late to change uretprobe api.
> Maybe it was discussed already.

yes, I recall discussing that early during uretprobe work with the decision to
have separate syscalls for each uprobe and uretprobe.. however wrt recent seccomp
changes, it might be easier just to add argument to uretprobe syscall to handle
uprobe

too bad it's not the other way around.. uprobe syscall with argument to do uretprobe
would sound better

> 
> > +       "syscall\n"
> > +       "pop %rax\n"
> > +       "pop %r11\n"
> > +       "pop %rcx\n"
> > +       "ret\n"
> 
> In later patches I see nop5 is replaced with a call to
> uprobe_trampoline_entry, but which part saves
> rdi and other regs?
> Compiler doesn't automatically spill/fill around USDT's nop/nop5.
> Selftest is doing:
> +__naked noinline void uprobe_test(void)
> so just lucky ?

if you mean registers that would carry usdt arguments, ebpf programs
access those based on assembler operand string stored in usdt record:

  stapsdt              0x00000048       NT_STAPSDT (SystemTap probe descriptors)
    Provider: test
    Name: usdt3
    Location: 0x0000000000712f2f, Base: 0x0000000002f516b0, Semaphore: 0x0000000003348ec2
->  Arguments: -4@-1192(%rbp) -8@-1200(%rbp) 8@%rax

it's up to bpf program to know which register(+offset) to access, libbpf have all
this logic hidden behind usdt_manager_attach_usdt and bpf_usdt_arg bpf call

the trampoline only saves rcx/r11/rax, because they are changed by syscall instruction

but actually I forgot to load these saved values (of rcx/r11/rax) and rsp into regs that
are passed to ebpf program, (like we do in uretprobe syscall) will fix that in next version

I'll add tests for optimized usdt with more arguments

thanks,
jirka

