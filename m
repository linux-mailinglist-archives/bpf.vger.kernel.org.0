Return-Path: <bpf+bounces-68285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58AB55AB8
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 02:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120551C81D91
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988F2629C;
	Sat, 13 Sep 2025 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n9lG8fkF"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33272606
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723611; cv=none; b=hSJgeuWZNIw2MXw/+8HfUVBHaHf/zgBzN9atsRQZcgo+o2n/HXSJRkgKDlQV5PUhqDsMyLNsABlub/GwU4dn8CGMFwgq/xUSR/Pmf/Apw5EJUP/w6uOBDw9czKR6u1/IwYUlNGQyupyW+XBW+hR20F/kHIZBWgHd8KnwOKJAntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723611; c=relaxed/simple;
	bh=y0wjLLTyFqnMuxHaQxIjxCPZHhSC2a5BZztTRkIqPu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcdDAmd52PXBWIlQdD+uMoOAEt2A1O/NP2xqmj5xqGOPEIxci7ctc6kb8BudZnwMXD49IewPX0PnQL5NCu6SJgcHxrLS6HTP6AbA+OogChkKq50Xs7BjNAVRG7cmsWuzBsqBfGu67TPSJtKBpVoXJcT18nDZY1an1xD6XsfGPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n9lG8fkF; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 17:33:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757723606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGB/lzbCpaHo9dgOu5gbU38UbtCr6Cc9U5CcwPrl1Ok=;
	b=n9lG8fkFNXoTKbDC7ZUJQ9i1eG/XGvvWRmoHOWaWnQHdcdhEoE2EBr6cKDXBS07gSuzIXA
	no/l2Op9fYR8dV01si3tFhJo9nqZImcg/Yx2OYDrVg1g2n7I/OOuxR2x71IXJLVulgHZKZ
	8FNOV/Nge6b5aPNstaF+wNnNDXw52Ic=
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
Message-ID: <rfwbbfu4364xwgrjs7ygucm6ch5g7xvdsdhxi52mfeuew3stgi@tfzlxg3kek3x>
References: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
 <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
 <CAADnVQJu-mU-Px0FvHqZdTTP+x8ROTXaqHKSXdeS7Gc4LV9zsQ@mail.gmail.com>
 <shfysi62hb5g7lo44mw4htwxdsdljcp3usu2wvsjpd2a57vvid@tuhj63dixxpn>
 <CAADnVQ+eD7p4i0B9Q2T-OS_n=AqcrrvYZGY57QOOqKEof6SkDQ@mail.gmail.com>
 <lv2tkehyh4pihbczb7ghvbkkl4l75ksdx2xjtxf2r7lgzam76h@ekkrlady2et3>
 <CAADnVQLX_mi9WLygRxwp5PtBFG7L_sqm9sL93ejENWqVO3ar7g@mail.gmail.com>
 <e7nh3cxyhmlxds4b2ko36gnxbdfclcxu3eae5irvrd2m6qzqoj@gor7vopfe47z>
 <CAADnVQJuAo5K417ZZ77AA1LM5uZr5O2v1dRrEEue-v39zGVyVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJuAo5K417ZZ77AA1LM5uZr5O2v1dRrEEue-v39zGVyVw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 12, 2025 at 05:07:59PM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 12, 2025 at 5:02 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Sep 12, 2025 at 02:59:08PM -0700, Alexei Starovoitov wrote:
> > > On Fri, Sep 12, 2025 at 2:44 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Fri, Sep 12, 2025 at 02:31:47PM -0700, Alexei Starovoitov wrote:
> > > > > On Fri, Sep 12, 2025 at 2:29 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > > > >
> > > > > > On Fri, Sep 12, 2025 at 02:24:26PM -0700, Alexei Starovoitov wrote:
> > > > > > > On Fri, Sep 12, 2025 at 2:03 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Sep 12, 2025 at 12:27 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > > > > > > >
> > > > > > > > > +Suren, Roman
> > > > > > > > >
> > > > > > > > > On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> > > > > > > > > > From: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > > >
> > > > > > > > > > Since the combination of valid upper bits in slab->obj_exts with
> > > > > > > > > > OBJEXTS_ALLOC_FAIL bit can never happen,
> > > > > > > > > > use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> > > > > > > > > > instead of (1ull << 2) to free up bit 2.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > > > > > >
> > > > > > > > > Are we low on bits that we need to do this or is this good to have
> > > > > > > > > optimization but not required?
> > > > > > > >
> > > > > > > > That's a good question. After this change MEMCG_DATA_OBJEXTS and
> > > > > > > > OBJEXTS_ALLOC_FAIL will have the same value and they are used with the
> > > > > > > > same field (page->memcg_data and slab->obj_exts are aliases). Even if
> > > > > > > > page_memcg_data_flags can never be used for slab pages I think
> > > > > > > > overlapping these bits is not a good idea and creates additional
> > > > > > > > risks. Unless there is a good reason to do this I would advise against
> > > > > > > > it.
> > > > > > >
> > > > > > > Completely disagree. You both missed the long discussion
> > > > > > > during v4. The other alternative was to increase alignment
> > > > > > > and waste memory. Saving the bit is obviously cleaner.
> > > > > > > The next patch is using the saved bit.
> > > > > >
> > > > > > I will check out that discussion and it would be good to summarize that
> > > > > > in the commit message.
> > > > >
> > > > > Disgaree. It's not a job of a small commit to summarize all options
> > > > > that were discussed on the list. That's what the cover letter is for
> > > > > and there there are links to all previous threads.
> > > >
> > > > Currently the commit message is only telling what the patch is doing and
> > > > is missing the 'why' part and I think adding the 'why' part would make it
> > > > better for future readers i.e. less effort to find why this is being
> > > > done this way. (Anyways this is just a nit from me)
> > >
> > > I think 'why' here is obvious. Free the bit to use it later.
> > > From time to time people add a sentence like
> > > "this bit will be used in the next patch",
> > > but I never do this and sometimes remove it from other people's
> > > commits, since "in the next patch" is plenty ambiguous and not helpful.
> >
> > Yes, the part about the freed bit being used in later patch was clear.
> > The part about if we really need it was not obvious and if I understand
> > the discussion at [1] (relevant text below), it was not required but
> > good to have.
> > ```
> >         > I was going to say "add a new flag to enum objext_flags",
> >         > but all lower 3 bits of slab->obj_exts pointer are already in use? oh...
> >         >
> >         > Maybe need a magic trick to add one more flag,
> >         > like always align the size with 16?
> >         >
> >         > In practice that should not lead to increase in memory consumption
> >         > anyway because most of the kmalloc-* sizes are already at least
> >         > 16 bytes aligned.
> >
> >         Yes. That's an option, but I think we can do better.
> >         OBJEXTS_ALLOC_FAIL doesn't need to consume the bit.
> > ```
> >
> > Anyways no objection from me but Harry had a followup request [2]:
> > ```
> >         This will work, but it would be helpful to add a comment clarifying that
> >         when bit 0 is set with valid upper bits, it indicates
> >         MEMCG_DATA_OBJEXTS, but when the upper bits are all zero, it indicates
> >         OBJEXTS_ALLOC_FAIL.
> >
> >         When someone looks at the code without checking history it might not
> >         be obvious at first glance.
> > ```
> >
> > I think the above requested comment would be really useful.
> 
> ... and that comment was added. pretty much verbatim copy paste
> of the above. Don't you see it in the patch?

Haha it seems I am blind, yup it is there.

> 
> > Suren is
> > fixing the condition of VM_BUG_ON_PAGE() in slab_obj_exts(). With this
> > patch, I think, that condition will need to be changed again.
> 
> That's orthogonal and I'm not convinced it's correct.
> slab_obj_exts() is doing the right thing. afaict.

Currently we have 

VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS))

but it should be (before your patch) something like:

VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS | OBJEXTS_ALLOC_FAIL)))

After your patch, hmmm, the previous one would be right again and the
newer one will be the same as the previous due to aliasing. This patch
doesn't need to touch that VM_BUG. Older kernels will need to move to
the second condition though.

