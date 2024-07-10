Return-Path: <bpf+bounces-34370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21A92CE04
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 11:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1841C219F8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1A18F2EF;
	Wed, 10 Jul 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="betFNRsC"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E959160;
	Wed, 10 Jul 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603001; cv=none; b=PQhQzm31XsVrMW5Uk0QALCKnzJrbfh6ls+vQJZPgHJhd6RIPcC7p9xJeZVypB2QXKikJ9is/AoY3I26iOGzIOEvoAJW6aUybUb0wUSBDwXmHbRXyUJaDyMZYEdFLXv85sfasdoJr/nKDqZIa0azHU4/4PEpLF6dNm0/3XsPKWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603001; c=relaxed/simple;
	bh=bA7KVUJvi38Y0Hh2xT5n55OKZxlKLiORsdhJCsdZu1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIcn3yZP5zyeAIDJtJ+fe2tedgAtOLAIcPTGFYVMVeu8S6XlK8sC3ywl64pthjXL+iQzC8TVi0BI0CMbS3W9EjEo1Aq0wM8VUzhHbW4DWdUvLpHXO/f8E6mYaAAnjHdoUIxLgO/w6UW7opgQ+5PrlPbO+ABJvR9z0jUWFUx1DgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=betFNRsC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JPliClW6JnRbEV8cOEjjeV2jC/W7ip0o4p0b+/xDw58=; b=betFNRsCwlkGFJU2MXHbcmoV4s
	r0bDVakb5qP7xg5LA+lhYSSN4QOhozdWpfUizdVih1PhlY/R/oDgBp5QM9dZnnlKYfiXsx3OGQu0y
	SvO1oOYonOu8Q3WWB9xcaiZiWjTh3b6a1Dzlssi0KHiDNeioRtxtHe5UjPZMD86dMHBWDFeqKbzoI
	GGc0V8SZobTeq9U5Rade69IuE8V4oQ2RfgaZv8egsQfDaoZf2IFXNJobiW2mSmHEUA8CPzOFHxMSU
	aI6g0t73ScDyXPTzufSIsbh14WeJAanwZQLl/1EgHlf59y0Ynxpm1arImtRR6Z5i4i6HCRQLAZiGK
	WforoHiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRTRA-00000000sq2-2ET2;
	Wed, 10 Jul 2024 09:16:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2F87300694; Wed, 10 Jul 2024 11:16:31 +0200 (CEST)
Date: Wed, 10 Jul 2024 11:16:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240710091631.GT27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1hBFS7c_J-Yx-7@casper.infradead.org>

On Tue, Jul 09, 2024 at 05:10:44PM +0100, Matthew Wilcox wrote:

> Probably best to start with lock_vma_under_rcu() in mm/memory.c.

So close and yet so far :/ 

> > > > Specifically, how feasible would it be to get a simple RCU based
> > > > find_vma() version sorted these days?
> > > 
> > > Liam's and Willy's Maple Tree work, combined with Suren's per-VMA locking
> > > combined with some of Vlastimil's slab work is pushing in that direction.
> > > I believe that things are getting pretty close.
> > 
> > So I fundamentally do not believe in per-VMA locking. Specifically for
> > this case that would be trading one hot line for another. I tried
> > telling people that, but it doesn't seem to stick :/
> 
> SRCU also had its own performance problems, so we've got problems one
> way or the other.  The per-VMA lock probably doesn't work quite the way
> you think it does, but it absoutely can be a hot cacheline.
> 
> I did propose a store-free variant at LSFMM 2022 and again at 2023,
> but was voted down.  https://lwn.net/Articles/932298/

That seems to be lacking much details. Anyway, page-tables are sorta RCU
freed -- per GUP fast requirements. Making it actually RCU isn't
hard, just increases the delay.

> I don't think the door is completely closed to a migration to that,
> but it's a harder sell than what we've got.  Of course, data helps ...

Current 'problem' is a heavily multi-threaded application using uprobes.
Executable is typically one VMA (per DSO) and all the probes will live
in that one VMA. Then have all the CPUs concurrently hit probes, and
they're all hammering the same VMA in order to translate
{mm,vaddr}->{inode,offset}.

After fixing a ton of uprobe things, Andrii is seeing 45% of CPU time
spend in mmap_rwsem:

  https://lkml.kernel.org/r/CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com

Given it's all typically one VMA, anything per VMA is not going to help
much.

Anyway, back to this PER_VMA_LOCK code, it took me a fair while to
digest because it lacks a coherent comment. It took me extra time
because I assumed (silly me) that _seq would mean an actual sequence
count.

If it were an actual sequence count, I could make it work, but sadly,
not. Also, vma_end_write() seems to be missing :-( If anything it could
be used to lockdep annotate the thing.

Mooo.. I need to stare more at this to see if perhaps it can be made to
work, but so far, no joy :/

