Return-Path: <bpf+bounces-67398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B5FB43545
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EFB18833C2
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F279C2C11F5;
	Thu,  4 Sep 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOdbtJe2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC42C11DA;
	Thu,  4 Sep 2025 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973611; cv=none; b=TdxAW8M93sVeYuL2HefeRPdFdHsLvTsM9F/6U1s+6RUKsLA9ij8WLCRpd0Ra2WNqhWdBFVYD1YCxZwUvvlTNj7ODC6NCSFUa65YfVBayhChsEpPIC3tx36BXbg/rUYrkzbpgh7oF3IRBcxB/6VgHS73cRq/5tMIJksXHPrJJdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973611; c=relaxed/simple;
	bh=XRpCUoD4UAjouJyJFRmHopRdWaXs20rEUHQAUKtu5po=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYuLKefq2IwLwERrj4G9v9FHqmFdvFB9htK8+InaV8b09Xw3XwYjZTizN/LCOV1//Mq8IMsAfDQHtD0VE9g99IezP6Zc9+2T2+iT+Pfdqho7N2de3/qkkm+vwybfc21fq/I4Oy8wZSdfdiujUz3M15ao0XpPxpCcMjgw7fvVWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOdbtJe2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61e8fe26614so1296082a12.1;
        Thu, 04 Sep 2025 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756973608; x=1757578408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gk2IkarqCdhrMgqm5sGbGYy9DmoyWdUrUsjr7Ufc8Vs=;
        b=ZOdbtJe2pYevHin6nGBniOuCuAu2VpENlgvrRwwK91jYu5+PGB81JohPEprTGFV88X
         iNmEp1abnBox8v3hi5YhJrfUBZgy5V4di/8IdDFB+fugt+QAvyso3sD6PLjhRFFNOohH
         gL2UImzUBtR+4Rtxglo4vN5aRCbqBQKhqsyUtl9U4R+kmfpSUkpOZcOQzd4pWs/SZAub
         T8Hdc/ccy2MlVdKjrxRN38MJTqYlgG8d7UdPC/9PiF+TuECNpXNMU8Jzl/KYUx5gp9F2
         rFA2zvro1kt8fvTpw80SFMRlG88Z+kmihlTHBwTy8SPRXP0mzZ39Ae1iu5SxkQVBy9pP
         UHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973608; x=1757578408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk2IkarqCdhrMgqm5sGbGYy9DmoyWdUrUsjr7Ufc8Vs=;
        b=P51lNQiz6n7c2/2wW7dQUQs2WlXsLhDAHchPsNX55Z08kSagvGs82wQQlVoXa4XLY8
         f3xzD3dX+gEqY837Vkxd16IBe66khQF5ZKkbqCiynsZAEjxDf8gYRIqhVMAgKIG9PZS8
         PUihAjhsyAzo7goSiwGDzqwPI+mdwTOE3h2xp8OyUmo/i0GpGJqNRZ0cmAEtJ1HtzGKj
         wfWHI1zIeckBM2ubc3Y4eX8vI760bu4jGEjCfJrN3e/W3ECldtGOGfS4qTC3raHf9Azd
         7lX9KZtzBySVJWmO78ZOFa4lSHR0raczgzJwGUnsU9IpEnbT+Vu1Cxs1xPVYdwS145FH
         92rw==
X-Forwarded-Encrypted: i=1; AJvYcCVoCFAwlZhMWXZ/7LYwfSMUYsXlk4KRYXZQq/eVSHzslCvh87k93yWh9QPzp+uvKbY7vKY=@vger.kernel.org, AJvYcCXGrkhd/Pu9rZtdlqMTgbSiuDsfg0v4PKUrYJtkKKULtzUFePhaKsnu0Duv9Sn6/geYcRwz5Hrw6DIbC+lviRUSwOlj@vger.kernel.org, AJvYcCXVjNyeINa6ONHhuEJ6E4prVLFTuS/QWfmP75KJw02dc6zAmO5MUOJAm38G7FvIOl7zauT4SEyrwTfUfOkk@vger.kernel.org
X-Gm-Message-State: AOJu0YxHm+1TuVxret4XNWUa3jsU3GpzxRiZsw5ujszj4tqodiNfgJ86
	Rm28HXuwM+xxgwyl7h/Od0nKIZVqKQyvehLDmw0syY0B8XzMY2BMhqMI
X-Gm-Gg: ASbGncug++9N4RUjlFXDznw3QcGYQtMtDxhZu1IxDiRMUIb5SG/609amfZ5oMIV/GvI
	4Q17gNQ1brl0d0XnXof80ag5ZlhImPQx7VKYQRbSJxX566DFdpLqN3mtg9uQo/haf1lVCOq6agc
	TOuD8icjWMtnYH1SuKIadaPCNr8owxUodNIwlnoorK0xYr9TE2i0ttDftIyktfdgEw03v0n+tLy
	b6y6VixMkjnoMlkL1jC25frOD2x8xf56xzCvCzNTfJvo3KaiIp5X3lpD2KHe65XyEKTU8/pOdSB
	Y2ObbB+h3r4waXAWRhOw0dLHXP5P8eUEgfEDv2/dOtTmOrVAGjcQ+L8jEPI/gyofwrOi//vZrk6
	+rw08tdnwZH4=
X-Google-Smtp-Source: AGHT+IG8xmaXEuDZOpVGSHKr/SMcqcydkRBn5cWfzP30z/Rkh8zQfFp53MFYNBJNfBHq+RQqRtjVwQ==
X-Received: by 2002:a05:6402:51ca:b0:61e:8fe5:31c4 with SMTP id 4fb4d7f45d1cf-61e8fe533bcmr13056099a12.8.1756973607740;
        Thu, 04 Sep 2025 01:13:27 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc575b94sm13117992a12.53.2025.09.04.01.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:13:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Sep 2025 10:13:25 +0200
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
Message-ID: <aLlKJWRs5etuvFuK@krava>
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

wrt nop5/nop1.. so the idea is to have USDT macro emit both nop1,nop5
and store some info about that in the usdt's elf note, right?

libbpf will read usdt record and in case it has both nop1/nop5 and if
the sys_uprobe is detected, we will adjust usdt address to nop1 or nop5

I recall you said you might have an idea where to store this flag
in elf note.. or are we bumping the usdt's elf note n_type ?

thanks,
jirka


> to try to call uprobe() syscall not from trampoline, and expect some
> error code.
> 
> How bad would it be to change this part to return some unique-enough
> error code (-ENXIO, -EDOM, whatever).
> 
> Is there any reason not to do this? Security-wise it will be just fine, right?
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

