Return-Path: <bpf+bounces-71162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18EBE596A
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 23:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DEFA4F2D35
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A972DE6F4;
	Thu, 16 Oct 2025 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QI7yFZUL"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6703346BF
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651215; cv=none; b=pXBgG+DoWLgvvMtS26cRgFlK8PkRl/Ie+LL49iGqSJeWZUUmDBGLFilMalUNKE28nphXGb4EZ4Yzj1nxJ/nJl0E9zyOrHS1tqS3AzwfP9mdQPB/xYgdPopmAekwshOYOL0kaBTnD7IQDt8myPsbypa9Oy4h+rp1AH1CyKimDgIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651215; c=relaxed/simple;
	bh=ShzEHhvRN9Hyrx6YO23642Wi67Uyk24QHDEa5OKiIHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHnbMFnVNeol/5gaJ0n5UKYmw6k0S7EnZoQthsbZqqPUATfcDqGAXRfulFJBtD5BIkGUdBJ1Bk3x4GI6qsNy2cSqeGULqKrNqmEGjH3J+EUbnaBDyvAPWtDVIezu5vBBe9MlQh9zIO+x/a4FJD5EmNLAf7fRXGGIrVa/iQhaJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QI7yFZUL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 16 Oct 2025 14:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760651209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkuq0diY9vaT6tq2SP6xrkoviZaDvOA/a1Ps0zDLmMg=;
	b=QI7yFZULs1Vhqw7z3l9QG55v/OhOJVIP+BgzwKWNhF/q8oXT3LQYhUVzYs0g5kkuaQbl9l
	ptUEteT43Z8Lhw/etIbwfBxcSzA0+g04/4m8wbmayyvuBJgN+abkDgamGn/IgaigaRrftX
	787IZuEV1PEIQwd1byWCt+WLW6nd/k4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
Message-ID: <du2nfgtz7isd2y4v6dkz6nvb2zqzgh5ox3whu7rteoay4fv4w2@qdebbb5thlwx>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
 <188b00961e374aeec9b1aac53cb25416e502ef67.camel@gmail.com>
 <CAEf4BzYoA_T2zM7+ED88PMe2VNpybrduFObUB83QegGewB2O5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYoA_T2zM7+ED88PMe2VNpybrduFObUB83QegGewB2O5A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 16, 2025 at 01:29:02PM -0700, Andrii Nakryiko wrote:
> On Wed, Oct 15, 2025 at 2:57 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > >
> > > Introducing selftests for validating file-backed dynptr works as
> > > expected.
> > >  * validate implementation supports dynptr slice and read operations
> > >  * validate destructors should be paired with initializers
> > >  * validate sleepable progs can page in.
> > >
> > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > ---
> >
> > I get the following error report when running this test on top of [1].
> >
> > [1] 48a97ffc6c82 ("bpf: Consistently use bpf_rcu_lock_held() everywhere")
> >
> > ---
> >
> > [   11.790725] ============================================
> > [   11.790999] WARNING: possible recursive locking detected
> > [   11.791195] 6.17.0-gbfd75250bee0 #1 Tainted: G           OE
> > [   11.791418] --------------------------------------------
> > [   11.791446] test_progs/153 is trying to acquire lock:
> > [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault (mm/memory.c:7081 (discriminator 4))
> > [   11.791446]
> > [   11.791446] but task is already holding lock:
> > [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/task_iter.c:751)
> > [   11.791446]
> > [   11.791446] other info that might help us debug this:
> > [   11.791446]  Possible unsafe locking scenario:
> > [   11.791446]
> > [   11.791446]        CPU0
> > [   11.791446]        ----
> > [   11.791446]   lock(&mm->mmap_lock);
> > [   11.791446]   lock(&mm->mmap_lock);
> > [   11.791446]
> > [   11.791446]  *** DEADLOCK ***
> > [   11.791446]
> > [   11.791446]  May be due to missing lock nesting notation
> > [   11.791446]
> > [   11.791446] 2 locks held by test_progs/153:
> > [   11.791446]  #0: ffffffff85a73be0 (rcu_read_lock_trace){....}-{0:0}, at: bpf_task_work_callback (./include/linux/rcupdate.h:331 (discriminator 1) ./include/linux/rcupdate_trace.h:58 (discriminator 1) ./include/linux/rcupdate_trace.h:102 (discriminator 1) kernel/bpf/helpers.c:4101 (discriminator 1))
> > [   11.791446]  #1: ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/task_iter.c:751)
> > [   11.791446]
> > [   11.791446] stack backtrace:
> > [   11.791446] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> > [   11.791446] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-4.el9 04/01/2014
> > [   11.791446] Call Trace:
> > [   11.791446]  <TASK>
> > [   11.791446]  dump_stack_lvl (lib/dump_stack.c:122)
> > [   11.791446]  print_deadlock_bug.cold (kernel/locking/lockdep.c:3044)
> > [   11.791446]  __lock_acquire (kernel/locking/lockdep.c:3897 kernel/locking/lockdep.c:5237)
> > [   11.791446]  ? __pfx___up_read (kernel/locking/rwsem.c:1350)
> > [   11.791446]  lock_acquire (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5870 kernel/locking/lockdep.c:5825)
> > [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
> > [   11.791446]  ? __pfx___might_resched (kernel/sched/core.c:8880)
> > [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> > [   11.791446]  __might_fault (mm/memory.c:7081 (discriminator 7))
> 
> cc'ing some mm folks for help
> 
> Is it a lockdep implementation detail that __might_fault is taking
> mmap_lock, or __might_fault is asserting that when fault is allowed,
> something (presumably kernel's page fault handler) might take
> mmap_lock? It's not clear to me.

It's the later i.e. current might take its mmap_lock.

> 
> bpf_find_vma() clearly is holding mmap_lock, so if that's unsafe, we'd
> have to make sure that bpf_find_vma() cannot be called in a sleepable
> BPF program.
> 

Sorry I am not sure about sleepable part but the issue is that this path
is leading to copy_from_user while holding mmap_lock which is not
allowed as it may cause a fault (acquire and release mmap_lock). We
don't support nested mmap read lock. (Suren can correct me if I missed
something).

You can use copy_from_user_nofault() instead but expect occasional
-EFAULT.

> 
> 
> > [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
> > [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
> > [   11.791446]  _copy_from_user (./include/linux/instrumented.h:129 ./include/linux/uaccess.h:177 lib/usercopy.c:18)
> > [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> > [   11.791446]  bpf_copy_from_user (kernel/bpf/helpers.c:664 (discriminator 1) kernel/bpf/helpers.c:659 (discriminator 1))
> > [   11.791446]  bpf_prog_1791842c6dbe7a9d_validate_file_read+0xeb/0x1c3
> > [   11.791446]  ? 0xffffffffc000098c
> > [   11.791446]  bpf_find_vma (kernel/bpf/task_iter.c:780 kernel/bpf/task_iter.c:751)

