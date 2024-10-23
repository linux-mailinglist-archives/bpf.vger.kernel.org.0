Return-Path: <bpf+bounces-42954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77BA9AD56D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 22:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99143283CA1
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8121D1E94;
	Wed, 23 Oct 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Py1OhwvW"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566E154BE0;
	Wed, 23 Oct 2024 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714783; cv=none; b=ei8P8EbpaWkycDehGSNQtckiq1XRG6Z9KzggmSjdHqc/rbcNWjazaMzXSGIZj4qE9lanbiB6kTdbcEg1rUBdZZ/A2OxPzSxqagNbhu2KEwl1oe/aOTzSz74hI6kQ4OnPD0s4vQiQgBgafgmuS1hCX5/o9TBVg9HSK7+oXisLMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714783; c=relaxed/simple;
	bh=k4zgi7ADGbP7fHp1ScwtsTYntJRkDIf7wPLtnykDbQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8kdZ37RKB1kDCGr6jKx+i0k/KVzsh2pbukrJuS5fxmLdpvcv+u8zbOQkWTFg8vkbSmwa3YLtW7PFAmn9yn5AxOlip97NcYkoK3/dJ70S2h11R+9ecH/vX2UdhiX0dj2cK0dzgnnubxt7udLpNAV1Op+ZFS+XTG8suKKrjMIdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Py1OhwvW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=of227XLmHd8FYYCg1pBSuLeRhCaRju7tALA9fDpypmA=; b=Py1OhwvW4ueY4slOZp3sscv9gK
	y7QUmoHNAOeOl5MXOLzWHR1oWy1sPEi+kOssDp8jwPZj2NQeGE2tj8A2veknyg+0wcvLwP2SQCuCk
	4f3X64qWbya6Zn8DUIUvWlVPOZrDubNcE6MXyTdyTOd9jvZsjuimOA37YdBcNBwGxhOdrLslN4SNK
	fN+ioTO3/XYEq3wxVzaHcdcbDkJG0LDGKw7exMwYqKyl/u0/4qMml/3aydbJG6phMF5QmieScik4A
	KG+NoHdQMk5lkmwsWIucw1Pz614cmkT7Uv0Uhf4GtYx4p/YyGB0VUFzkAqjTHEcdenU3iJicWp9O9
	ma2s9d0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3hp8-00000008Xve-2Uon;
	Wed, 23 Oct 2024 20:19:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EFC4830073F; Wed, 23 Oct 2024 22:19:17 +0200 (CEST)
Date: Wed, 23 Oct 2024 22:19:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com,
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev,
	hannes@cmpxchg.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 4/4] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <20241023201917.GG11151@noisy.programming.kicks-ass.net>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-5-andrii@kernel.org>
 <20241023192236.GB11151@noisy.programming.kicks-ass.net>
 <CAEf4Bza7+DraKrNoG3ebUaZUvmk3HN+cT8TgtnThkp_XGPf6AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza7+DraKrNoG3ebUaZUvmk3HN+cT8TgtnThkp_XGPf6AA@mail.gmail.com>

On Wed, Oct 23, 2024 at 01:02:53PM -0700, Andrii Nakryiko wrote:

> > > +      * but can't be freed from under us, so it's safe to read fields from
> > > +      * it, even if the values are some garbage values; ultimately
> > > +      * find_uprobe_rcu() + mmap_lock_speculation_end() check will ensure
> > > +      * that whatever we speculatively found is correct
> > > +      */
> > > +     vm_file = READ_ONCE(vma->vm_file);
> > > +     if (!vm_file)
> > > +             return NULL;
> > > +
> > > +     vm_pgoff = data_race(vma->vm_pgoff);
> > > +     vm_start = data_race(vma->vm_start);
> > > +     vm_inode = data_race(vm_file->f_inode);
> >
> > So... seqcount has kcsan annotations other than data_race(). I suppose
> > this works, but it all feels like a bad copy with random changes.
> 
> I'm not sure what this means... Do I need to change anything? Drop
> data_race()? Use READ_ONCE()? Do nothing?

Keep for now. I've ranted at 1/n a bit, but unless the response is:
yeah, obviously this should be seqcount (unlikely) this is something
that can be fixed later (*sigh* always later... this todo list is a
problem).

