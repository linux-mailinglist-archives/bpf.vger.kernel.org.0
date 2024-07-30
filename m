Return-Path: <bpf+bounces-36064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E49412D3
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 15:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EAB1C22FED
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5B919E7E4;
	Tue, 30 Jul 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LJL2kMHO"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F821E49B;
	Tue, 30 Jul 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345069; cv=none; b=lcQ87KbhWFJw5a2fTaqZNrRayzlgjE62auw6QfECpNzxmeMS+4RmkrNdD/BNziytn+tf8qekNXAmh28IKRYPYS/co/CwVLxr5IJIiYTFhHwceWYM7iBbgB47ZPz+uMwshNqo7tBHMas6sI6lUq3jVRL4jcyLSgqbd72ja2256ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345069; c=relaxed/simple;
	bh=K2x5EglQKatf9dcU11Rc9v3JGRi4qjW1IWQ9qCLLVVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4YZkHqkF4p+wUP77xAVFKdoOjmiovb0/Y/M66WK+WuE5+MuWAAR2V/CGnTb/WfNz8rAQ7elFCEUyZFCXHZgMt342lik0oLLqCXUYXj9ccDhPgzNos4FXKA8tvxYNjLfX3VUfxdHV0K4RYIaNF8GtfbdQ9es7NRXrHVEZ2G2exQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LJL2kMHO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EVDK/OaFXFsyGttM4quqPk1ly/vVJNWfUU+CUfaWAFU=; b=LJL2kMHOs1hjqYV3Cpiba5WA6K
	1GZ/865dCjW4aP2aXL9B9zb+CJNguraTl7ErxRSUUufWNJtfNAS0J/QvZX9zjzhByJpIhWVCU3gcR
	AKr97PXHYKXcKcS5gR5/wcMaqVM1pAd21fDVk0giWUWmdEntpWZm798Wo0zOX1WqpCBJMXukuCc1o
	qMh5LC5XGTnT3bffvbEH8gWQIgttSC903prSNlhk93s5fJVxbEuTvH2TBgwJ+/W+1uTv63/EE/Ewk
	ypujiELcEtrJjhtthiSOYhQ8wEQAC7zkX+ju9tASsdC5j/6pSrnt5BCtADvashBSz/yzWIA6LgGxC
	l0+E4rEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYmd1-0000000EiNH-2mam;
	Tue, 30 Jul 2024 13:10:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0E993003EA; Tue, 30 Jul 2024 15:10:58 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:10:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240730131058.GN33588@noisy.programming.kicks-ass.net>
References: <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net>
 <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
 <ZqRtcZHWFfUf6dfi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqRtcZHWFfUf6dfi@casper.infradead.org>

On Sat, Jul 27, 2024 at 04:45:53AM +0100, Matthew Wilcox wrote:

> Hum.  What if we added SLAB_TYPESAFE_BY_RCU to files_cachep?  That way
> we could do:
> 
> 	inode = NULL;
> 	rcu_read_lock();
> 	vma = find_vma(mm, address);
> 	if (!vma)
> 		goto unlock;
> 	file = READ_ONCE(vma->vm_file);
> 	if (!file)
> 		goto unlock;
> 	inode = file->f_inode;
> 	if (file != READ_ONCE(vma->vm_file))
> 		inode = NULL;

remove_vma() does not clear vm_file, nor do I think we ever re-assign
this field after it is set on creation.

That is, I'm struggling to see what this would do. AFAICT this can still
happen:

	rcu_read_lock();
	vma = find_vma();
					remove_vma()
					  fput(vma->vm_file);
								dup_fd)
								  newf = kmem_cache_alloc(...)
								  newf->f_inode = blah

	file = READ_ONCE(vma->vm_file);
	inode = file->f_inode; // blah
	if (file != READ_ONCE(vma->vm_file)) // still match


> unlock:
> 	rcu_read_unlock();
> 
> 	if (inode)
> 		return inode;
> 	mmap_read_lock();
> 	vma = find_vma(mm, address);
> 	...
> 
> I think this would be safe because 'vma' will not be reused while we
> hold the read lock, and while 'file' might be reused, whatever f_inode
> points to won't be used if vm_file is no longer what it once was.


Also, we need vaddr_to_offset() which needs additional serialization
against vma_lock.

