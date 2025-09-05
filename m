Return-Path: <bpf+bounces-67610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFCAB46498
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F4A7C88B6
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FE9287257;
	Fri,  5 Sep 2025 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GwuKnZ1Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C21F4262
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104369; cv=none; b=bQUlSVGB7eN+1w75ByfQvlzFyWlz5kp0KHb6VWpiTqum4SaYX9h8edZ4/CBYSRutDbS0+ODLFb0bAUQrbGMIIZLUKvxnTBQjUz7g6MCOztsq/GL/CvWuAU9odW0yP/IOIdL4a5Z4S7IARm+wE/XNcnTlZNzXXRCj98uuxO4xkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104369; c=relaxed/simple;
	bh=NE2mVgB82DGcXKRvSa5YWr/lEhbNODLAdptLViTw5CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9hS4/Z/5+sFg4+oq9l+Do4OOxziytPN9QLAdnYYmA4K1hrxMYWlajwrP6gSsn5ejb8fTTnQul5nM+7imZM13Td2hOyaW56V73cslNIE/MypbYhdDBvteFmW1NNykxABYnugwi1+71EOG/W85PwFtrgqcv2k4VdCyGKWzJYQxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GwuKnZ1Q; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 13:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757104364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyfEn8B+c0G43yV3f15K2IB4WQxXM7vj7uTX34Cb+1g=;
	b=GwuKnZ1QSCPTMJoMoIiY7p23MG0pZ33rT0JAp3AsQt8zRfdUdyaEzZtwz1eHBeC+um7ySV
	XOsxLQxP8FYjFNTZAX19Nfljswk51y5K2V9ZrOXnl/jcjR4sFhJl0u2CgHHZukammG7N8Z
	Ictuh1klL4pPWTS9PyRS07vIU94be+c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Peilin Ye <yepeilin@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in
 __bpf_async_init()
Message-ID: <xx5wmuwyg7a4ck744hbgr74m5lpuuwjeh2l66gat5322huvtbm@zy5wexffh4r3>
References: <20250905061919.439648-1-yepeilin@google.com>
 <CAADnVQKAd-jubdQ9ja=xhTqahs+2bk2a+8VUTj1bnLpueow0Lg@mail.gmail.com>
 <qwrl5ivlaou2qqbrj4wh2vi4uqmeny2zyfidkjizkyyzta3uo3@z6bjemb7om6y>
 <aLs2sV72B98i3i1Q@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLs2sV72B98i3i1Q@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 07:14:57PM +0000, Peilin Ye wrote:
> On Fri, Sep 05, 2025 at 10:31:07AM -0700, Shakeel Butt wrote:
> > On Fri, Sep 05, 2025 at 08:18:25AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Sep 4, 2025 at 11:20 PM Peilin Ye <yepeilin@google.com> wrote:
> > > > As pointed out by Kumar, we can use bpf_mem_alloc() and friends for
> > > > bpf_hrtimer and bpf_work, to skip memcg accounting.
> > > 
> > > This is a short term workaround that we shouldn't take.
> > > Long term bpf_mem_alloc() will use kmalloc_nolock() and
> > > memcg accounting that was already made to work from any context
> > > except that the path of memcg_memory_event() wasn't converted.
> > > 
> > > Shakeel,
> > > 
> > > Any suggestions how memcg_memory_event()->cgroup_file_notify()
> > > can be fixed?
> > > Can we just trylock and skip the event?
> > 
> > Will !gfpflags_allow_spinning(gfp_mask) be able to detect such call
> > chains? If yes, then we can change memcg_memory_event() to skip calls to
> > cgroup_file_notify() if spinning is not allowed.
> 
> I tried the below diff, but unfortunately __bpf_async_init() calls
> bpf_map_kmalloc_node() with GFP_ATOMIC, so gfpflags_allow_spinning()
> would return true.  I'll try the trylock-and-skip approach.

Trylock approach will not work as there are multiple locks in this
codepath. Better to use __GFP_HIGH instead of GFP_ATOMIC in
__bpf_async_init().


