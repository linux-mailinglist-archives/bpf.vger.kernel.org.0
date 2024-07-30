Return-Path: <bpf+bounces-36066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B23941379
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 15:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C629B28B8C
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE5619FA68;
	Tue, 30 Jul 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gi5hdVhm"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5C173;
	Tue, 30 Jul 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347176; cv=none; b=GmvMWSIbXYGPRwimpdjC14B49P+h23O2/VR/zlX6Gpxn1lxtXzoC4JD8xPdCc5BJ3OTsXVqFWDCemwjb92qRJJgkybKPVXum9nEpn4+MaZAgZ6urQ4dOi1fHRn+hmENKmrmG82RegKo+QYa+D25e9zFtnUU+koPJ/DhPI8kZH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347176; c=relaxed/simple;
	bh=kPKAW/PMUqlp0aXtylPpwRqwlYdmFo85OGJYcqN5WLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBAIbLV4ClNGDQIS4cB/8wIye1pe0d/ZKvrfd6ZuH1VaJViHim7Ea+koEQisUXwemwZ2T2oaopPHop9xT+psjeIXxaq9gP0nVs2Rw1ih+sNvSm5+WvNdWtyr/OrVFDE9yvALBPXzW19CtzCTBqSnJ6DRVLJupjNxvm5WI05eKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gi5hdVhm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=y4B8Bibf3cMg8sJe0NMBWovQbOHW1Vbl/sWae146Sjc=; b=gi5hdVhmspWihcRoGl/873CpaW
	xZWsAW97z560SkAr3fU5a9q9VRUs9+0X0hRw0bN9snPf04IQbxXbcVZvul7qpBru9Vr0k5iW/v5lS
	GDFzEplX9C0MZNaWZit+ZeLSOXprY9FRRRs7c6mWzM9vabWtLyyxtoI2hBXxDlvir6aFTN1ShB53Y
	tvmGha60bA/AbHSJEbdf3t8nojcsnnTS+OausvNRAUzqNhNOxKMvqysGahi+mMMCVaSLjGWpH1UoR
	Bi9DGXquIWQHztVyrkwvjAFZfD/nNQGyH/3WVOIQfyFSq6/fBaLEZztCshc/mn6YURwkvoxNyGQaP
	+q7BKcrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnB0-000000050pu-18wA;
	Tue, 30 Jul 2024 13:46:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35DB33003EA; Tue, 30 Jul 2024 15:46:05 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:46:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240730134605.GO33588@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net>
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>

On Mon, Jul 22, 2024 at 12:09:21PM -0700, Suren Baghdasaryan wrote:
> On Wed, Jul 10, 2024 at 2:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
> >
> > > If it were an actual sequence count, I could make it work, but sadly,
> > > not. Also, vma_end_write() seems to be missing :-( If anything it could
> > > be used to lockdep annotate the thing.
> 
> Thanks Matthew for forwarding me this discussion!
> 
> > >
> > > Mooo.. I need to stare more at this to see if perhaps it can be made to
> > > work, but so far, no joy :/
> >
> > See, this is what I want, except I can't close the race against VMA
> > modification because of that crazy locking scheme :/
> 
> Happy to explain more about this crazy locking scheme. The catch is
> that we can write-lock a VMA only while holding mmap_lock for write
> and we unlock all write-locked VMAs together when we drop that
> mmap_lock:
> 
> mmap_write_lock(mm);
> vma_start_write(vma1);
> vma_start_write(vma2);
> ...
> mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all locked vmas
> 
> This is done because oftentimes we need to lock multiple VMAs when
> modifying the address space (vma merge/split) and unlocking them
> individually would be more expensive than unlocking them in bulk by
> incrementing mm->mm_lock_seq.

Right, but you can do that without having it quite this insane.

You can still make mm_lock_seq a proper seqcount, and still have
vma_end_write() -- even if its an empty stub only used for validation.

That is, something like the below, which adds a light barrier, ensures
that mm_lock_seq is a proper sequence count.

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index de9dc20b01ba..daa19d1a3022 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -104,6 +104,8 @@ static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq+1);
+	smp_wmb();
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 

With the above addition we could write (although I think we still need
the RCU_SLAB thing on files_cachep):

static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
{
	struct mm_struct *mm = current->mm;
	struct uprobe *uprobe = NULL;
	struct vm_area_struct *vma;
	struct inode *inode;
	loff_t offset;
	int seq;

	guard(rcu)();

	seq = READ_ONCE(mm->mm_lock_seq);
	smp_rmb();
	do {
		vma = find_vma(mm, bp_vaddr);
		if (!vma)
			return NULL;

		if (!valid_vma(vma, false))
			return NULL;

		inode = file_inode(vma->vm_file);
		offset = vaddr_to_offset(vma, bp_vaddr);

	} while (smp_rmb(), seq != READ_ONCE(mm->mm_lock_seq));

	return find_uprobe(inode, offset);
}


