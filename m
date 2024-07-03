Return-Path: <bpf+bounces-33732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D12992550C
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07878287BD6
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD51139CEE;
	Wed,  3 Jul 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQLtn8Yf"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B438F58;
	Wed,  3 Jul 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719994067; cv=none; b=R496aLozU4cXRP1U6/aass5HWZKuTtH/iWcinptcrO/loXC7OQy9IM8GomvmwQ3uEFOUb4gPmWtoQh+e6ps3uHsRtB/fHr6iEwJPRSXKD3fZyWEiEdXWt1KGishpGTfaD3192Pm9QGFewSW5xDGuy0AbPfb1rsO39isHcpZKxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719994067; c=relaxed/simple;
	bh=KyqTjn6WT05y5IoZrnQUEQv8SGKwyaQZr89FfZHgFpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3jz0y5sDITmxORZkrxFsQs2ZreXcNsmzfRthK2DYEU5gRA5DHiDGr9ojmpCZUmrWlU8g6HK6EkgDLH3Yxav7AvqmW1OpCqAn8fdCQogXD8CPcpQHoWIWEIpJn7dEmutoO8lihQnQ3vwUziRtg3Qj/s1P2aorp+RAnFSjvcOTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQLtn8Yf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rejidQU7WVRgyJL0A+KUb+DOrT1j848Y6IbnkUIm8zw=; b=nQLtn8YfbtyVRB5tMp8tMj/Z0T
	rzZC2qYfnZDUtD/WiqCvM8DMsrVfiO7mQrejasmZPf+SU9MOANc8Qcs+KujbDRvBtPJ9wWNPrkWtN
	VPpGEi9cf1WucfXEojRe0JPawDhQwfVcnJTeL7gpOnEXb3/DPIbTwoKnwWLS86nsaxnWx+U3BwIr7
	0zyFEsoIOqv8eO3m+CgksKTkjmVO7pHyclcvWd6hmVU8El68vmUe8WuPqD18+h/i5LaQwBmMRJcDe
	gdufRmiEip/6GuEEm6cFBocD7mFQg81L89kYuMMLewMBG0yagjFC+JW0I8KjBQSWvKRfAsCLWvb+g
	vhSBPhnA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOv1f-00000001cLm-41bX;
	Wed, 03 Jul 2024 08:07:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 083613006B7; Wed,  3 Jul 2024 10:07:37 +0200 (CEST)
Date: Wed, 3 Jul 2024 10:07:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240703080736.GL11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
 <CAEf4BzZuEicv3DkYA8HYG10QnBURK4SFddhTbA06=eOKQr82PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZuEicv3DkYA8HYG10QnBURK4SFddhTbA06=eOKQr82PA@mail.gmail.com>

On Tue, Jul 02, 2024 at 09:47:41PM -0700, Andrii Nakryiko wrote:

> > As you noted, that percpu-rwsem write side is quite insane. And you're
> > creating this batch complexity to mitigate that.
> 
> 
> Note that batch API is needed regardless of percpu RW semaphore or
> not. As I mentioned, once uprobes_treelock is mitigated one way or the
> other, the next one is uprobe->register_rwsem. For scalability, we
> need to get rid of it and preferably not add any locking at all. So
> tentatively I'd like to have lockless RCU-protected iteration over
> uprobe->consumers list and call consumer->handler(). This means that
> on uprobes_unregister we'd need synchronize_rcu (for whatever RCU
> flavor we end up using), to ensure that we don't free uprobe_consumer
> memory from under handle_swbp() while it is actually triggering
> consumers.
> 
> So, without batched unregistration we'll be back to the same problem
> I'm solving here: doing synchronize_rcu() for each attached uprobe one
> by one is prohibitively slow. We went through this exercise with
> ftrace/kprobes already and fixed it with batched APIs. Doing that for
> uprobes seems unavoidable as well.

I'm not immediately seeing how you need that terrible refcount stuff for
the batching though. If all you need is group a few unregisters together
in order to share a sync_rcu() that seems way overkill.

You seem to have muddled the order of things, which makes the actual
reason for doing things utterly unclear.

