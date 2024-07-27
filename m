Return-Path: <bpf+bounces-35798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC6393DD24
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 05:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4E71F24345
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E14688;
	Sat, 27 Jul 2024 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="doskXc/x"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCD197;
	Sat, 27 Jul 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722051960; cv=none; b=ZCy8c2N4q05hoCaVKMMc8U4oyQKvU8qpi/ZQzWJI6ZqhFoYZFSghkj8/aRriKVQRA1VHXcwAUkTtPYn3tlwl9r/E/RESJKWF9E76LWFIPhltpf6yI5V/Pngt1jyIcMyA7R1R1V8DfbzWQ2T618Vg4dNpe1BhqszQlzdJquni9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722051960; c=relaxed/simple;
	bh=+6aRiZHMY2UwD1ptIzZl2dlB05/JayzoKzX0xOcUvZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP28I6PtQzs0cYP2JPOfo5O1AhTXv03ei7S/s+o5tHxlxAmOVR6EUEfcQRPYeNeMu0wd6BXH4al7EkPGgS6smscsETMCCb4nAQGHYDS1F8My6HBR+hS3dM7lF+5/SjRnrPZMVkrAKdKWIYr4DI2Y1kEEbNyxUVN78SVoMi58Esc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=doskXc/x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Iwm9lv3I5imfKYFcLqJtJ/Iu0ZLj1yI4POD9Lw39XuI=; b=doskXc/xybEr0BE1ibQySiEGLN
	oMctDTJOwrit8ua2vRfXqlxXRD1gj+61yc6Ig6PAzVNU9rZgwFkxATHTSGKhLZqT22knFwf8RUnhI
	Qx+U/oRATfvUxksFm/DgNmFXOsUzcZjkFlrjMImTtZGg0xDqSdYX0JGr0dxzkdLgOAVXXbyYWci/K
	86BsDIFizCUwR4YDgEANTX2HkAN7U9eL8kM1pZ3NgMVVsDaF4ZzsPVVCYftrUeYOEIUfUUXdR2h1i
	FLzjYhnFh44w1mxsDjvQzZqx+bTZICnSYZDCMG0FO82MnRkOrGw1//s+guZs9MI7RIdQIpFNh5My9
	raHuj0cg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXYNV-0000000AyMm-0crs;
	Sat, 27 Jul 2024 03:45:53 +0000
Date: Sat, 27 Jul 2024 04:45:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <ZqRtcZHWFfUf6dfi@casper.infradead.org>
References: <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net>
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>

On Fri, Jul 26, 2024 at 06:29:44PM -0700, Suren Baghdasaryan wrote:
> On Fri, Jul 26, 2024 at 5:20 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jul 22, 2024 at 12:09 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Wed, Jul 10, 2024 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
> > > >
> > > > > If it were an actual sequence count, I could make it work, but sadly,
> > > > > not. Also, vma_end_write() seems to be missing :-( If anything it could
> > > > > be used to lockdep annotate the thing.
> > >
> > > Thanks Matthew for forwarding me this discussion!
> > >
> > > > >
> > > > > Mooo.. I need to stare more at this to see if perhaps it can be made to
> > > > > work, but so far, no joy :/
> > > >
> > > > See, this is what I want, except I can't close the race against VMA
> > > > modification because of that crazy locking scheme :/
> > >
> > > Happy to explain more about this crazy locking scheme. The catch is
> > > that we can write-lock a VMA only while holding mmap_lock for write
> > > and we unlock all write-locked VMAs together when we drop that
> > > mmap_lock:
> > >
> > > mmap_write_lock(mm);
> > > vma_start_write(vma1);
> > > vma_start_write(vma2);
> > > ...
> > > mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all locked vmas
> > >
> > > This is done because oftentimes we need to lock multiple VMAs when
> > > modifying the address space (vma merge/split) and unlocking them
> > > individually would be more expensive than unlocking them in bulk by
> > > incrementing mm->mm_lock_seq.
> > >
> > > >
> > > >
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -2146,11 +2146,58 @@ static int is_trap_at_addr(struct mm_str
> > > >         return is_trap_insn(&opcode);
> > > >  }
> > > >
> > > > -static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
> > > > +#ifndef CONFIG_PER_VMA_LOCK
> > > > +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> > > > +{
> > > > +       return NULL;
> > > > +}
> > > > +#else
> > >
> > > IIUC your code below, you want to get vma->vm_file without locking the
> > > VMA. I think under RCU that would have been possible if vma->vm_file
> > > were RCU-safe, which it's not (we had discussions with Paul and
> > > Matthew about that in
> > > https://lore.kernel.org/all/CAJuCfpHW2=Zu+CHXL+5fjWxGk=CVix=C66ra+DmXgn6r3+fsXg@mail.gmail.com/).
> > > Otherwise you could store the value of vma->vm_lock_seq before
> > > comparing it with mm->mm_lock_seq, then do get_file(vma->file) and
> > > then compare your locally stored vm_lock_seq against vma->vm_lock_seq
> > > to see if VMA got locked for modification after we got the file. So,
> > > unless I miss some other race, I think the VMA locking sequence does
> > > not preclude you from implementing __find_active_uprobe() but
> > > accessing vma->vm_file would be unsafe without some kind of locking.
> >
> > Hey Suren!
> >
> > I've haven't yet dug properly into this, but from quick checking
> > around I think for the hot path (where this all matters), we really
> > only want to get vma's underlying inode. vm_file itself is just a
> > means to that end. If there is some clever way to do
> > vma->vm_file->f_inode under RCU and without mmap_read_lock, that would
> > be good enough, I think.
> 
> Hi Andrii,
> Sorry, I'm not aware of any other way to get the inode from vma. Maybe
> Matthew with his FS background can find a way?

Hum.  What if we added SLAB_TYPESAFE_BY_RCU to files_cachep?  That way
we could do:

	inode = NULL;
	rcu_read_lock();
	vma = find_vma(mm, address);
	if (!vma)
		goto unlock;
	file = READ_ONCE(vma->vm_file);
	if (!file)
		goto unlock;
	inode = file->f_inode;
	if (file != READ_ONCE(vma->vm_file))
		inode = NULL;
unlock:
	rcu_read_unlock();

	if (inode)
		return inode;
	mmap_read_lock();
	vma = find_vma(mm, address);
	...

I think this would be safe because 'vma' will not be reused while we
hold the read lock, and while 'file' might be reused, whatever f_inode
points to won't be used if vm_file is no longer what it once was.

On the other hand, it's quarter to midnight on Friday, and I have a
terrible virus that I'm struggling through, so not ideal circumstances
for me to be reasoning about RCU guarantees.

