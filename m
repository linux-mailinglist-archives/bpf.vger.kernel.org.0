Return-Path: <bpf+bounces-67634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E76B465A6
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67361AA7C0E
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60C52F6162;
	Fri,  5 Sep 2025 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UiHjw1EN"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D882F532C
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108111; cv=none; b=ThEQ0LQ7lH6hJnGvsg3PSTgdhR0jclkHzZoENiSLFtfBlLNNjc9BvC1sLsNFda8/16B7SOXWbUbIWfr3EEvh3xu/EICYyjDLjtRNGV0tCxjexQnVGitZ3p4uA/nel0mvQOBHpA+XPM2z0GXpBQ+qx8NzvPPNG5EH1jMgBN15IOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108111; c=relaxed/simple;
	bh=07WhRPfjDzBxE91dbsApcppdmWq3kRPaYngaONK3BNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrHSa8OmVBoFLJWiXCOlTc5txtV4WGMS+XQXhXVqRpX9RMhN8Ise5E9l1KjZ9/7IOGXyEj/uT4kNocKKPDYxgcKBuMsaoRiL+l5E2Ygrcrv2IIC1/+1SffbHVaDk8EaKjNGL31M1vL2bVxLRnkuAMqQ5jam4RknqBiHI47HVaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UiHjw1EN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 14:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757108107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jrQKavBU+8BmecuzRiyEZQztOguoe+vmV+LZaMwWF5I=;
	b=UiHjw1EN6zSseiXPwP5jOU+PMDzIc5lDRuJklr0LtbxbOnKRv0OBc74hK64Q7ZYoIvXBaO
	Wq623BrT+QGhpDBcPFFbmUD1vf/VtKJXe0/D/S08x24NNwQ8Rcs0a9N0q+UI1Z5a+LddBJ
	+imMdsHZoN3p2RWEu0H8/Rrt9ZN4kkQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <uattgslnbiit2yhz5hzh6g7mc4g4nnbkqospnjuqikzliskyo4@z5i66op4jhdp>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <87y0qsa95d.fsf@linux.dev>
 <aLtVTo-Egnqdjxi2@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLtVTo-Egnqdjxi2@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 11:25:34AM -1000, Tejun Heo wrote:
> On Fri, Sep 05, 2025 at 02:20:46PM -0700, Roman Gushchin wrote:
> > Shakeel Butt <shakeel.butt@linux.dev> writes:
> > 
> > > Generally memcg charging is allowed from all the contexts including NMI
> > > where even spinning on spinlock can cause locking issues. However one
> > > call chain was missed during the addition of memcg charging from any
> > > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > > cgroup_file_notify().
> > >
> > > The possible function call tree under cgroup_file_notify() can acquire
> > > many different spin locks in spinning mode. Some of them are
> > > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > > just skip cgroup_file_notify() from memcg charging if the context does
> > > not allow spinning.
> > 
> > Hmm, what about OOM events? Losing something like MEMCG_LOW doesn't look
> > like a bit deal, but OOM events can be way more important.
> > 
> > Should we instead preserve the event (e.g. as a pending_event_mask) and
> > raise it on the next occasion / from a different context?
> 
> Maybe punt with an irq_work?

Oh good suggestion, I will check irq_work as well. Though I think that
can be a followup work.

