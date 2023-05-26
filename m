Return-Path: <bpf+bounces-1343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E91713093
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 01:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD8E2819F9
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4FD2D25E;
	Fri, 26 May 2023 23:46:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5BB2A9EF
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 23:46:11 +0000 (UTC)
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 May 2023 16:45:52 PDT
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [IPv6:2001:41d0:203:375::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45581E50
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 16:45:52 -0700 (PDT)
Date: Fri, 26 May 2023 19:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685144385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pmmu2l8SGWACfif5XIKHsHxMzv+ce/4e1/BfTEw4BM=;
	b=ukQmXpei8AxbBkklcOc7JJjEsmeitSCac4BJKuAMh8TeKC2hAS47SrZ0PL71rpMf4M7DLZ
	iIWCyVyoZHJIFRzS2PMOmMv1aFkeoqw7JLIQRVWjKWMPpGqmW3/8pDXH4lnJNZuFXZ1wnw
	qxS/DXuyGMhBP/f+4NahZunW2ipB3oc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mcgrof@kernel.org,
	peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
	rppt@kernel.org
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
Message-ID: <ZHFDO/95KMXRdOWI@moria.home.lan>
References: <20230526051529.3387103-1-song@kernel.org>
 <20230526051529.3387103-2-song@kernel.org>
 <ZHEy5SkFwI+dZjOC@moria.home.lan>
 <CAPhsuW5nbXozvBs1X7q_u=eTY0U=Ep32n1bM8bxR6h9UEU3AxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5nbXozvBs1X7q_u=eTY0U=Ep32n1bM8bxR6h9UEU3AxQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 04:09:01PM -0700, Song Liu wrote:
> On Fri, May 26, 2023 at 3:30 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, May 25, 2023 at 10:15:27PM -0700, Song Liu wrote:
> > > Introduce memory type aware module_alloc_type, which provides a unified
> > > allocator for all different archs. This work was discussed in [1].
> > >
> > > Each arch can configure the allocator to do the following:
> > >
> > >    1. Specify module_vaddr and module_end
> > >    2. Random module start address for KASLR
> > >    3. kasan_alloc_module_shadow()
> > >    4. kasan_reset_tag()
> > >    5. Preferred and secondary module address ranges
> > >
> > > enum mod_alloc_params_flags are used to control the behavior of
> > > module_alloc_type. Specifically: MOD_ALLOC_FALLBACK let module_alloc_type
> > > fallback to existing module_alloc. MOD_ALLOC_SET_MEMORY let
> > > module_alloc_type to protect the memory before returning to the user.
> > >
> > > module_allocator_init() call is added to start_kernel() to initialize
> > > module_alloc_type.
> > >
> >
> > ...
> >
> > > +/**
> > > + * struct vmalloc_params - Parameters to call __vmalloc_node_range()
> > > + * @start:          Address space range start
> > > + * @end:            Address space range end
> > > + * @gfp_mask:       The gfp_t mask used for this range
> > > + * @pgprot:         The page protection for this range
> > > + * @vm_flags        The vm_flag used for this range
> > > + */
> > > +struct vmalloc_params {
> > > +     unsigned long   start;
> > > +     unsigned long   end;
> > > +     gfp_t           gfp_mask;
> > > +     pgprot_t        pgprot;
> > > +     unsigned long   vm_flags;
> > > +};
> > > +
> > > +/**
> > > + * struct mod_alloc_params - Parameters for module allocation type
> > > + * @flags:          Properties in mod_alloc_params_flags
> > > + * @granularity:    The allocation granularity (PAGE/PMD) in bytes
> > > + * @alignment:      The allocation alignment requirement
> > > + * @vmp:            Parameters used to call vmalloc
> > > + * @fill:           Function to fill allocated space. If NULL, use memcpy()
> > > + * @invalidate:     Function to invalidate memory space.
> > > + *
> > > + * If @granularity > @alignment the allocation can reuse free space in
> > > + * previously allocated pages. If they are the same, then fresh pages
> > > + * have to be allocated.
> > > + */
> > > +struct mod_alloc_params {
> > > +     unsigned int            flags;
> > > +     unsigned int            granularity;
> > > +     unsigned int            alignment;
> > > +     struct vmalloc_params   vmp[MOD_MAX_ADDR_SPACES];
> > > +     void *                  (*fill)(void *dst, const void *src, size_t len);
> > > +     void *                  (*invalidate)(void *ptr, size_t len);
> > > +};
> > > +
> > > +struct mod_type_allocator {
> > > +     struct mod_alloc_params params;
> > > +};
> > > +
> > > +struct mod_allocators {
> > > +     struct mod_type_allocator *types[MOD_MEM_NUM_TYPES];
> > > +};
> > > +
> > > +void *module_alloc_type(size_t size, enum mod_mem_type type);
> > > +void module_memfree_type(void *ptr, enum mod_mem_type type);
> > > +void module_memory_fill_type(void *dst, void *src, size_t len, enum mod_mem_type type);
> > > +void module_memory_invalidate_type(void *ptr, size_t len, enum mod_mem_type type);
> > > +void module_memory_protect(void *ptr, size_t len, enum mod_mem_type type);
> > > +void module_memory_unprotect(void *ptr, size_t len, enum mod_mem_type type);
> > > +void module_memory_force_protect(void *ptr, size_t len, enum mod_mem_type type);
> > > +void module_memory_force_unprotect(void *ptr, size_t len, enum mod_mem_type type);
> > > +void module_alloc_type_init(struct mod_allocators *allocators);
> >
> > This is a pretty big and complicated interface, and I haven't been able
> > to find any reasoning or justification for why it's needed.
> >
> > Why is this going in module.h? Don't do that, this is supposed to be a
> > general purpose allocator for executable memory so start a new file.
> 
> The goal of this work is to build a memory allocator for modules, text,
> rw data, and ro data. So it is not the same as execmem_alloc or jitalloc.
> 
> >
> > What is vmalloc_params doing here? Why is it needed? Can we just get rid
> > of it?
> 
> We need it to have an interface for all archs. They are all using different
> variations of vmalloc for module_alloc.

But it should be an internal implementation detail, I don't think we
want the external interface tied to vmalloc - 

> These two APIs allow the core code work with all archs. They won't break
> sub-page allocations. (not all archs will have sub-page allocations)

So yes, text_poke() doesn't work on all architectures, and we need a
fallback.

But if the fallback needs to go the unprotect/protect route, I think we
need to put that in the helper, and not expose it. Part of what people
are wanting is to limit or eliminate pages that are RWX, so we
definitely shouldn't be creating new interfaces to flipping page
permissions: that should be pushed down to as low a level as possible.

E.g., with my jitalloc_update(), a more complete version would look like

void jitalloc_update(void *dst, void *src, size_t len)
{
	if (text_poke_available) {
		text_poke(...);
	} else {
		unprotect();
		memcpy();
		protect();
	}
}

See? We provide a simpler, safer interface, and this also lets us handle
multiple threads racing to update/flip permissions on the same page in a
single place (e.g. with sticking a lock somewhere in the jitalloc
structures).

Or ideally, we'd have a kmap_local() variant that actually creates a new
mapping on all architectures, and we'd just use that to do the update
without any arch-dependent code - if we get that, having this helper
means we'll only have to change a single place later.

> 
> OTOH, the "force" version of the two APIs should be removed later. In this
> set, we only need them for arch_prepare_bpf_trampoline(). I plan to remove
> this limitation for x86 soon.
> 
> >
> > The text_poke() abstraction works; the exposed interface should look
> > like that.
> >
> > Please kill MOD_ALLOC_SET_MEMORY, and _only_ return memory that is
> > read-only. You should be able to kill mod_alloc_params entirely.
> >
> > Our other memory allocators don't expose kasan - why does this one?
> > Again, that looks wrong.
> >
> > I would like to see something much simpler (that doesn't encode awkward
> > assumptions from module and bpf!): please look at the code I sketched
> > out below and tell me why this interface won't work - or if it can, go
> > with _that_.
> 
> I think we need to align the goal here. PS: we did align the goal about
> 6 months ago when I proposed the execmem_alloc() set.

Yeah, I know what it feels like to get yanked around by different
reviewers who see and join in the discussion at different times. Sorry :)

Having a rational/design doc in the header file would help a _lot_. 

> My current goal is to build an allocator for all the use cases of modules,
> text, data, rodata, etc. Then the same allocator can be used by other
> dynamic kernel text: bpf, ftrace, kprobe, bcachefs, etc.

This must have been part of the previous discussion since you started
with execmem_alloc(), but I did scan through that and I'm still not
seeing the justification for why this needs to handle non-text
allocations.

If I had to hazard a guess it would be because of tglx wanting to solve
tlb fragmentation for modules, but to me that doesn't sound like a good
enough reason and it looks like we're ending up with a messy "try to be
all things to all people" interface as a result :/

Do we _really_ need that?

Mike was just saying at LSF that direct map fragmentation turned out to
be a non issue for performance for non-text, so maybe we don't.

Also - module_memory_fill_type(), module_memory_invalidate_type() - I
know these are for BPF, but could you explain why we need them in the
external interface here? Could they perhaps be small helpers in the bpf
code that use something like jitalloc_update()?

> OTOH, jit_alloc (as-is) solves a subset of the problem (only the text).
> We can probably use it (with some updates) instead of the vmap_area
> based allocator. But I guess we need to align the direction first.

Let's see if we can get tglx to chime in again, since he was pretty
vocal in the last discussion.

It's also good practice to try to summarize all the relevant "whys" from
the discussion that went into a feature and put that in at least the
commit message - or even better, header file comments.

Also, organization: the module code is a huge mess, let's _please_ do
split this out and think about organization a bit more, not add to the
mess :)

Cheers,
Kent

