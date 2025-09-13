Return-Path: <bpf+bounces-68281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EAFB55A80
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 02:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563127A36A5
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F2C28F4;
	Sat, 13 Sep 2025 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kteSnbAB"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393474A3C
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757721728; cv=none; b=ZuG7CQL9YlIS8jgvIpYvCIkgpKPGdlH+lLYbcRN5gZ8kWenRjhW8kvgiB2rkU5YseN70cUBBRA7lEu8Mgs6duQJQu0MS/gigNP+eE5KuVqNjmZCkWBy4VKvt4GatvBHP6Eymf/+itTEEUffAadXxqGWOAUjIDxMlJcxgY0tqK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757721728; c=relaxed/simple;
	bh=2IOls+5ihE/wpDfGelo+iaCbrrFYTVgu11uZx6OhzTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYaFoD/faQvyZuD/bIAGPUdk/U1FP5wd/OV0qYTOPK/SipKBUjWRtP0NjZmdvybpnHRcMxExrctOqFwEpsPkp8CZzhJZ5HyEZg2dt2NFbZJ1mHHrRvmHjTP4UMlYrpQuskCBSf6ovhEJOAvUG8++Ew4wfGyrDmgJQXLjXYsr3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kteSnbAB; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 17:01:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757721723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1V4E7beL3tEQcs5f1ZIdNtN51ThW+D+Dg6V3YUAVog=;
	b=kteSnbABvHadBqke0lEmhPuZhA3Nws7R0djm5uvx197+4I4lR/J3g13H82QcB++JKyBXvg
	/JudcGo/uA1xMk7pNur6IzYVR8jQy0Qf580r7nupFsPOcs7wO5vpfsW9JOCGorZzhrt8N8
	aiS/QToB6TQvnULaHZddJvc8QtfEVS4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
Message-ID: <e7nh3cxyhmlxds4b2ko36gnxbdfclcxu3eae5irvrd2m6qzqoj@gor7vopfe47z>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com>
 <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
 <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
 <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com>
 <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
 <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 12, 2025 at 02:59:08PM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 12, 2025 at 2:44 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Sep 12, 2025 at 02:31:47PM -0700, Alexei Starovoitov wrote:
> > > On Fri, Sep 12, 2025 at 2:29 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Fri, Sep 12, 2025 at 02:24:26PM -0700, Alexei Starovoitov wrote:
> > > > > On Fri, Sep 12, 2025 at 2:03 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 12, 2025 at 12:27 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > > > > >
> > > > > > > +Suren, Roman
> > > > > > >
> > > > > > > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> > > > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > > >
> > > > > > > > Since the combination of valid upper bits in slab->obj_exts with
> > > > > > > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > > > > > > use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> > > > > > > > instead of (1ull << 2) to free up bit 2.
> > > > > > > >
> > > > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > >
> > > > > > > Are we low on bits that we need to do this or is this good to have
> > > > > > > optimization but not required?
> > > > > >
> > > > > > That's a good question. After this change MEMCG_DATA_OBJEXTS and
> > > > > > OBJEXTS_ALLOC_FAIL will have the same value and they are used with the
> > > > > > same field (page->memcg_data and slab->obj_exts are aliases). Even if
> > > > > > page_memcg_data_flags can never be used for slab pages I think
> > > > > > overlapping these bits is not a good idea and creates additional
> > > > > > risks. Unless there is a good reason to do this I would advise against
> > > > > > it.
> > > > >
> > > > > Completely disagree. You both missed the long discussion
> > > > > during v4. The other alternative was to increase alignment
> > > > > and waste memory. Saving the bit is obviously cleaner.
> > > > > The next patch is using the saved bit.
> > > >
> > > > I will check out that discussion and it would be good to summarize that
> > > > in the commit message.
> > >
> > > Disgaree. It's not a job of a small commit to summarize all options
> > > that were discussed on the list. That's what the cover letter is for
> > > and there there are links to all previous threads.
> >
> > Currently the commit message is only telling what the patch is doing and
> > is missing the 'why' part and I think adding the 'why' part would make it
> > better for future readers i.e. less effort to find why this is being
> > done this way. (Anyways this is just a nit from me)
> 
> I think 'why' here is obvious. Free the bit to use it later.
> From time to time people add a sentence like
> "this bit will be used in the next patch",
> but I never do this and sometimes remove it from other people's
> commits, since "in the next patch" is plenty ambiguous and not helpful.

Yes, the part about the freed bit being used in later patch was clear.
The part about if we really need it was not obvious and if I understand
the discussion at [1] (relevant text below), it was not required but
good to have.
```
	> I was going to say "add a new flag to enum objext_flags",
	> but all lower 3 bits of slab->obj_exts pointer are already in use? oh...
	>
	> Maybe need a magic trick to add one more flag,
	> like always align the size with 16?
	>
	> In practice that should not lead to increase in memory consumption
	> anyway because most of the kmalloc-* sizes are already at least
	> 16 bytes aligned.

	Yes. That's an option, but I think we can do better.
	OBJEXTS_ALLOC_FAIL doesn't need to consume the bit.
```

Anyways no objection from me but Harry had a followup request [2]:
```
	This will work, but it would be helpful to add a comment clarifying that
	when bit 0 is set with valid upper bits, it indicates
	MEMCG_DATA_OBJEXTS, but when the upper bits are all zero, it indicates
	OBJEXTS_ALLOC_FAIL.

	When someone looks at the code without checking history it might not
	be obvious at first glance.
```

I think the above requested comment would be really useful. Suren is
fixing the condition of VM_BUG_ON_PAGE() in slab_obj_exts(). With this
patch, I think, that condition will need to be changed again.

[1] https://lore.kernel.org/all/CAADnVQLrTJ7hu0Au-XzBu9=GUKHeobnvULsjZtYO3JHHd75MTA@mail.gmail.com/
[2] https://lore.kernel.org/all/aJtZrgcylnWgfR9r@hyeyoo/

