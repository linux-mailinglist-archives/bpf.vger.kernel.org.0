Return-Path: <bpf+bounces-67641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D2B46625
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C816D4C6
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C1F286420;
	Fri,  5 Sep 2025 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AsvpR/nI"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4A22129B
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109026; cv=none; b=SGQft7L5Av9i3/X3WdctZBr+17wrMlH9shodBEny4TdO4dIF86Az5IAC9RoFs8iLQk0ZErklfYryVMSVENFVBGNNcHsCisMsmzeWiS2F2JpZYJBlyjIh+xYhCzR8p+N9dFlvMFMmefae46CpNdx0T8o6WEwWac1JmcpBImZ8sHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109026; c=relaxed/simple;
	bh=S/UWDnpTMWsqhx4sgrCQxMtbVj0rwQvQhDuX/DmBFNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4KbzUnAut8qJS1EZYkwBJDuyeS+CvFewujUU5tQO+Wc+gYSj4UhZuQaHHp3cK764lu2BVexoz4qPsLpdWhwepNJMu6Iq8SFxlZiMKu+ViK67X1HFtn+lpwF+QzCjoTc7hLBfqJ8g2mtZraVfHPS+UorsUpK9G+ghWfv+dw49j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AsvpR/nI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 14:50:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757109022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i+4lbkYAVJItZbl2lUeNDlNahLiQUZCJiaL54ViPkiY=;
	b=AsvpR/nIzurNpoIFa6XwntMf4OD07BIqdrNjj5pHASfxQjM6hDQZxoKF+RNqMmjRn+bwxD
	QavQmwYEnsXt2x7J0YcXG8R67lsjb9n5gKD4blTaP7+Qk9IW5ox/72XJLYPBLhcvy0J3Vq
	6nEtKlfioHa8Yera73WK9RMGQRYsHEE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <6bcjnhdsbyfmlua2x7olz6w3gheejfatnrtn5qu7ls5svegrok@zeatti7whrnq>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <87y0qsa95d.fsf@linux.dev>
 <mai3ndkvqrpkfpblkazbyejvpkizrp7dh22374tpkmepfji32o@3troawzsuvqe>
 <87ecska85y.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecska85y.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 02:42:01PM -0700, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
> > On Fri, Sep 05, 2025 at 02:20:46PM -0700, Roman Gushchin wrote:
> >> Shakeel Butt <shakeel.butt@linux.dev> writes:
> >> 
> >> > Generally memcg charging is allowed from all the contexts including NMI
> >> > where even spinning on spinlock can cause locking issues. However one
> >> > call chain was missed during the addition of memcg charging from any
> >> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> >> > cgroup_file_notify().
> >> >
> >> > The possible function call tree under cgroup_file_notify() can acquire
> >> > many different spin locks in spinning mode. Some of them are
> >> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> >> > just skip cgroup_file_notify() from memcg charging if the context does
> >> > not allow spinning.
> >> 
> >> Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
> >> like a bit deal, but OOM events can be way more important.
> >> 
> >> Should we instead preserve the event (e.g. as a pending_event_mask) and
> >> raise it on the next occasion / from a different context?
> >>
> >
> > Thanks for the review. For now only MAX can happen in non-spinning
> > context. All others only happen in process context. Maybe with BPF OOM,
> > OOM might be possible in a different context (is that what you are
> > thinking?). I think we can add the complexity of preserving the event
> > when the actual need arise.
> 
> No, I haven't thought about any particular use case, just a bit
> worried about silently dropping some events. It might be not an issue
> now, but might be easy to miss a moment when it becomes a problem.
> 

Only the notification can be dropped and not the event (i.e. we are
still incrementing the counters). Also for MAX only but I got your
point.

> So in my opinion using some delayed delivery mechanism is better
> than just dropping these events.

Let me see how doing this irq_work looks like and will update here.

