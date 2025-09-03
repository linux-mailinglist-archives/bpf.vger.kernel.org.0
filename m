Return-Path: <bpf+bounces-67347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C259B42B6A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 22:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29071168E9A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 20:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93822E7BBD;
	Wed,  3 Sep 2025 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhzOnAED"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626B19DF4F;
	Wed,  3 Sep 2025 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932976; cv=none; b=PYJ2+wT8Uzz6M9oAl+nDgbgzdU26Q/iC7XKOErUDSiIfTLC5adt+uHkGCe+p4s8mE59AXsfqQtu3bTeS8Op27+hKIU6DMVf6/6+DWUkQpdOR2bfxM835/CZug6Pqa3WYQoztfMhHiO02PxUDoi/1XT1pM6K85/QEBq/QWk496uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932976; c=relaxed/simple;
	bh=ti8kGfqTFinSvWu6KM15T9eOmf8ttReBSeY/peBVjaU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRj/NBbEf2QOEBicFCuc/YXrXLcQ/OU1ugurmVreY7v2yxDhT4wgTT2buwV/gwY9I9Z5mFHMTq+LAatn0uaxSgZJWUmY8mA2+QmHI43yPWQ+2Sg56QBYNhU7YQnm8A/83xk5u0DUG2Ip0YRrnkokuAX5DWEe/Xk/jchg4ole1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhzOnAED; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b046f6fb2a9so50318366b.2;
        Wed, 03 Sep 2025 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756932973; x=1757537773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vOGEnDz7yfB6/0Ke1iGbkBPRzwGoApbnovtwkmVLD6E=;
        b=NhzOnAEDC+tVsXG9IUT9EXcvIsTmGVqRa5wAKNGvb5p8sh49j+X1wFi9uK2fQg6LRN
         BDH4SecFexHEKvEypZfGVlRGEduCTi24j0HBzU0OOsCxga3UffJ84sP/TT0E7MHYAxD9
         WUyMVcGTwNZKIHf2FZlizSo7fNAuNFfJjJ23UZWutzQBNE02ieExc/2Sc4rJi617Kcgx
         pWj/LbsWtTlQiekkoYEWWfhpAU/8QNMWOXNf+yuZDFMCflrHnVzQ8V+0RXtDpeYSZ3FX
         xIjHHcTqGkdNLT3mvZrsNaFqYMt9bKcDq+hrBBacBnkJUgLsQttQw7SUhIhq8X46W861
         2/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932973; x=1757537773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOGEnDz7yfB6/0Ke1iGbkBPRzwGoApbnovtwkmVLD6E=;
        b=LRx3SylxF1hij1Ytvrqg55NFfJo3tMJWnmU2yF9z0GnPvGPeK8l9zZ1xLLw+0DSg6/
         Rq8R83YorzEfOFhEPokw7RPQksxSboP2GBDwD0jAQVR9+hWLhAEy/kYSHNn38mKq/PB9
         Zd0Y9cJMdqYPus0e/mtUpVeBvzRfzzMKCSoHBC6L7Uk7uFEto3ohJ8ER9e0Y35sZ4Mxr
         NFj3WW46gREunyRb78ueHQ87LYLDERdDDi2Cb7fXNXs3K/gnam2uGeh96VM9o7RckWMp
         EVPqLaRXB5IZ8V40WhywhulGCJhyDDVzMZCS5jsP9qNl5iI60VZ5+sfpXmrasw9H4AJq
         tWDg==
X-Forwarded-Encrypted: i=1; AJvYcCUZj5ZDl/8BrUOP2uXZFEKzni7oXlACQQDQg96Ush2Cx+ihH0Ph1tw3m55M1OWmC4dp4bshRfDWZbMEz+7rDH4ah32h@vger.kernel.org, AJvYcCUqdWAsEsD4h4riC7s0QRNRkmPpSXY4HQJiNFNv4o/KuHlnSrl4mPQOWBxk8pikhMBtNfKEIs01MTwj48a2@vger.kernel.org, AJvYcCWDvxhqL8Y5Lbm+MpQ0Y9hwDKg2Zx3hY355oF4kKfPtcCasl/QE2bR22zyWz9+ksWjvxVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEhfPlUz1bfksvZ5ofhlbOrgKgvELCjBrPTQ7Le96nE9GN3HH
	P9oe6+1HRdoq/XHNEadzvaffS3K64zckowWzbdiik/iXQlg+l9TywTWL
X-Gm-Gg: ASbGnctVJFSPib/gKjl1w4rtgxw3qNklsMsdmO0JrCn48n3ICIjWzB0eXeYT1RB+aa3
	5xD2q3jO6oTqXMA400ADGlhEDrmubjqvB3UhS3BP1jlT/dZdFkfU32A1snUDKF52Ulfv9hSZtm/
	lxvfG4pGcS4fw2vQ+MZMFKdN4Qa+DwKY8sBoeBzAGVJNbBXo35QjE5g//+58e15RN9sk513xJtU
	0TXv7Fx3i8YgnvnhXnL6Bh0zvNXpISnIOQKxtcOmPy5CQS1GueewUH05AwSoe0luQJCM2JCt+pK
	aYyzcPnYsbHi+yq2Q1VbEtvKLgDVde/+2d38sy6MCCCF2CkkwpvTGU1jdUNN3xCUdAzfv1pDKTa
	pD9ry3lL6ZoHGRVTNfiMyFw==
X-Google-Smtp-Source: AGHT+IGxj3EYSn9g70UJcitqjjh3vMgPrNkqAxlNU9KucqBXLhMmO8pisfLhiHHKk8J7jZKRj7AZtA==
X-Received: by 2002:a17:906:3650:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b0422527e7dmr1128472066b.12.1756932972738;
        Wed, 03 Sep 2025 13:56:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413ee67a3sm1017610166b.24.2025.09.03.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:56:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Sep 2025 22:56:10 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <aLirakTXlr4p2Z7K@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>

On Wed, Sep 03, 2025 at 11:24:31AM -0700, Andrii Nakryiko wrote:
> On Sun, Jul 20, 2025 at 4:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new uprobe syscall that calls uprobe handlers for given
> > 'breakpoint' address.
> >
> > The idea is that the 'breakpoint' address calls the user space
> > trampoline which executes the uprobe syscall.
> >
> > The syscall handler reads the return address of the initial call
> > to retrieve the original 'breakpoint' address. With this address
> > we find the related uprobe object and call its consumers.
> >
> > Adding the arch_uprobe_trampoline_mapping function that provides
> > uprobe trampoline mapping. This mapping is backed with one global
> > page initialized at __init time and shared by the all the mapping
> > instances.
> >
> > We do not allow to execute uprobe syscall if the caller is not
> > from uprobe trampoline mapping.
> >
> > The uprobe syscall ensures the consumer (bpf program) sees registers
> > values in the state before the trampoline was called.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> >  arch/x86/kernel/uprobes.c              | 139 +++++++++++++++++++++++++
> >  include/linux/syscalls.h               |   2 +
> >  include/linux/uprobes.h                |   1 +
> >  kernel/events/uprobes.c                |  17 +++
> >  kernel/sys_ni.c                        |   1 +
> >  6 files changed, 161 insertions(+)
> >
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index cfb5ca41e30d..9fd1291e7bdf 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -345,6 +345,7 @@
> >  333    common  io_pgetevents           sys_io_pgetevents
> >  334    common  rseq                    sys_rseq
> >  335    common  uretprobe               sys_uretprobe
> > +336    common  uprobe                  sys_uprobe
> >  # don't use numbers 387 through 423, add new calls after the last
> >  # 'common' entry
> >  424    common  pidfd_send_signal       sys_pidfd_send_signal
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 6c4dcbdd0c3c..d18e1ae59901 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -752,6 +752,145 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
> >         hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
> >                 destroy_uprobe_trampoline(tramp);
> >  }
> > +
> > +static bool __in_uprobe_trampoline(unsigned long ip)
> > +{
> > +       struct vm_area_struct *vma = vma_lookup(current->mm, ip);
> > +
> > +       return vma && vma_is_special_mapping(vma, &tramp_mapping);
> > +}
> > +
> > +static bool in_uprobe_trampoline(unsigned long ip)
> > +{
> > +       struct mm_struct *mm = current->mm;
> > +       bool found, retry = true;
> > +       unsigned int seq;
> > +
> > +       rcu_read_lock();
> > +       if (mmap_lock_speculate_try_begin(mm, &seq)) {
> > +               found = __in_uprobe_trampoline(ip);
> > +               retry = mmap_lock_speculate_retry(mm, seq);
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       if (retry) {
> > +               mmap_read_lock(mm);
> > +               found = __in_uprobe_trampoline(ip);
> > +               mmap_read_unlock(mm);
> > +       }
> > +       return found;
> > +}
> > +
> > +/*
> > + * See uprobe syscall trampoline; the call to the trampoline will push
> > + * the return address on the stack, the trampoline itself then pushes
> > + * cx, r11 and ax.
> > + */
> > +struct uprobe_syscall_args {
> > +       unsigned long ax;
> > +       unsigned long r11;
> > +       unsigned long cx;
> > +       unsigned long retaddr;
> > +};
> > +
> > +SYSCALL_DEFINE0(uprobe)
> > +{
> > +       struct pt_regs *regs = task_pt_regs(current);
> > +       struct uprobe_syscall_args args;
> > +       unsigned long ip, sp;
> > +       int err;
> > +
> > +       /* Allow execution only from uprobe trampolines. */
> > +       if (!in_uprobe_trampoline(regs->ip))
> > +               goto sigill;
> 
> Hey Jiri,
> 
> So I've been thinking what's the simplest and most reliable way to
> feature-detect support for this sys_uprobe (e.g., for libbpf to know
> whether we should attach at nop5 vs nop1), and clearly that would be
> to try to call uprobe() syscall not from trampoline, and expect some
> error code.
> 
> How bad would it be to change this part to return some unique-enough
> error code (-ENXIO, -EDOM, whatever).
> 
> Is there any reason not to do this? Security-wise it will be just fine, right?

good question.. maybe :) the sys_uprobe sigill error path followed the
uprobe logic when things go bad, seem like good idea to be strict

I understand it'd make the detection code simpler, but it could just
just fork and check for sigill, right?

jirka


> 
> > +
> > +       err = copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
> > +       if (err)
> > +               goto sigill;
> > +
> > +       ip = regs->ip;
> > +
> 
> [...]

