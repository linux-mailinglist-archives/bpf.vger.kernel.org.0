Return-Path: <bpf+bounces-1348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C44713223
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 05:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510112819F7
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 03:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67739E;
	Sat, 27 May 2023 03:20:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096E389
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 03:19:59 +0000 (UTC)
X-Greylist: delayed 17394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 20:19:58 PDT
Received: from out-54.mta0.migadu.com (out-54.mta0.migadu.com [IPv6:2001:41d0:1004:224b::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2EE1
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 20:19:57 -0700 (PDT)
Date: Fri, 26 May 2023 23:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685157595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zC6ZNRAMXSTd1zjJb1ou+NimilKWTlR9ciflQq7y0Bw=;
	b=oWx2NpJvKxrzV3oXwp2njxlTCvxR3WH88zCPvD2fyst1ulzM9qe96PAlVTOQETHCG81FGd
	rMVp8WLbEw6k0SPHd08q8Y611MvjKz8NUXREJBkL3JBxYqI+6GLH6qHyDUE0mMfEXCca0D
	3yNNaKHa1oS6rPQunUyGJMxDV6Hcgig=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
	rppt@kernel.org
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
Message-ID: <ZHF21CSxyjQy9C7F@moria.home.lan>
References: <20230526051529.3387103-1-song@kernel.org>
 <20230526051529.3387103-2-song@kernel.org>
 <ZHEy5SkFwI+dZjOC@moria.home.lan>
 <CAPhsuW5nbXozvBs1X7q_u=eTY0U=Ep32n1bM8bxR6h9UEU3AxQ@mail.gmail.com>
 <ZHFDO/95KMXRdOWI@moria.home.lan>
 <CAPhsuW5CTANR_B57w5n3HvdDjvHXOCSGTDc=a4s+JR0pKCAOcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5CTANR_B57w5n3HvdDjvHXOCSGTDc=a4s+JR0pKCAOcw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 05:03:18PM -0700, Song Liu wrote:
> On Fri, May 26, 2023 at 4:39 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> [...]
> 
> >
> > But it should be an internal implementation detail, I don't think we
> > want the external interface tied to vmalloc -
> >
> > > These two APIs allow the core code work with all archs. They won't break
> > > sub-page allocations. (not all archs will have sub-page allocations)
> >
> > So yes, text_poke() doesn't work on all architectures, and we need a
> > fallback.
> >
> > But if the fallback needs to go the unprotect/protect route, I think we
> > need to put that in the helper, and not expose it. Part of what people
> > are wanting is to limit or eliminate pages that are RWX, so we
> > definitely shouldn't be creating new interfaces to flipping page
> > permissions: that should be pushed down to as low a level as possible.
> >
> > E.g., with my jitalloc_update(), a more complete version would look like
> >
> > void jitalloc_update(void *dst, void *src, size_t len)
> > {
> >         if (text_poke_available) {
> >                 text_poke(...);
> >         } else {
> >                 unprotect();
> >                 memcpy();
> >                 protect();
> >         }
> > }
> 
> I think this doesn't work for sub page allocation?

Perhaps I elided too much - it does if you add a single lock. You can't
do that if it's not a common helper.

> At the end of all this, we will have modules running from huge pages, data
> and text. It will give significant performance benefit when some key driver
> cannot be compiled into the kernel.

Yeah, I've seen the numbers for the perf impact of running as a module
due to the extra TLB overhead - but Mike's recent data was showing that
this doesn't matter nearly as much as data as it does for text.

> > Also - module_memory_fill_type(), module_memory_invalidate_type() - I
> > know these are for BPF, but could you explain why we need them in the
> > external interface here? Could they perhaps be small helpers in the bpf
> > code that use something like jitalloc_update()?
> 
> These are used by all users, not just BPF. 1/3 uses them in
> kernel/module/main.c. I didn't use them in 3/3 as it is arch code, but I can
> use them instead of text_poke_* (and that is probably better code style).
> As I am writing the email, I think I should use it in ftrace.c (2/3) to avoid
> the __weak function.

Ok. Could we make it clearer why they're needed and what they're for?

I know bpf fills in invalid instructions initially; I didn't read
through enough code to find the "why", and let's document that to save
other people the same effort.

And do they really need to be callbacks in mod_alloc_params...?

Do we need the other things in mod_alloc_params/vmalloc_params?
 - your granularity field says it's for specifying PAGE/PMD size: we
   definitely do not want that. We've had way too much code along the
   lines of "implement hugepages for x", we need to stop doing that.
   It's an internal mm/ detail.

 - vmalloc_params: we need gfp_t and pgprot_t, but those should be
   normal arguments. start/end/vm_flags? They seem like historical
   module baggage, can we get rid of them?

> > > OTOH, jit_alloc (as-is) solves a subset of the problem (only the text).
> > > We can probably use it (with some updates) instead of the vmap_area
> > > based allocator. But I guess we need to align the direction first.
> >
> > Let's see if we can get tglx to chime in again, since he was pretty
> > vocal in the last discussion.
> >
> > It's also good practice to try to summarize all the relevant "whys" from
> > the discussion that went into a feature and put that in at least the
> > commit message - or even better, header file comments.
> >
> > Also, organization: the module code is a huge mess, let's _please_ do
> > split this out and think about organization a bit more, not add to the
> > mess :)
> 
> I don't really think module code is very messy at the moment. If
> necessary, we can put module_alloc_type related code in a
> separate file.

Hey, it's been organized since I last looked at it :) But I tihink this
belongs in mm/, not module code.

