Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE586172FB
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 00:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKBXpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 19:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBXpA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 19:45:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCF15806
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RJHcaTwqpPDY7DjngAQr5c7flkwc7s46DLffSo3e5bA=; b=h0aufXQEuervLZxZL9tt9LNbGn
        ov0vhZ3q2XDEQtY8EqSoSPpk36PXLfaKPeShF2nTAYPQ3NZXf97H1lj+XHtOOzHi9IbVENOsIBIzz
        z3Dub1Kf7kUOywF9EX/EAuM+ROEFVMTwZGFyO7k8YE1jZ2WzgIQ5QtUuOnwCF5K2TyQg0WbsdBYd5
        m9mpAzhVgASAnCFBK+zPCAoujGlBOW7bPrHIEH5YMQni2dPb7KvWWDVRSceuYWClz65PrJvuhT8Ka
        A1ItvKCZzUqjDAA2hfy5Ccx4navZdvhyKIKJiJkNmF+Nv9lD3LATQsn7/FuS/2LEu6Vc4yuwcsaoe
        xs0xeYFA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqNMt-00F5Rn-GP; Wed, 02 Nov 2022 23:41:59 +0000
Date:   Wed, 2 Nov 2022 16:41:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, dave.hansen@intel.com, rppt@kernel.org,
        zhengjun.xing@linux.intel.com, kbusch@kernel.org,
        p.raghav@samsung.com, dave@stgolabs.net, vbabka@suse.cz,
        mgorman@suse.de, willy@infradead.org,
        torvalds@linux-foundation.org, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031222541.1773452-2-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 03:25:37PM -0700, Song Liu wrote:
> vmalloc_exec is used to allocate memory to host dynamic kernel text
> (modules, BPF programs, etc.) with huge pages. This is similar to the
> proposal by Peter in [1].

This is allg reat but we need to clarify *why* we would go through the
trouble.  So if folks are not to excited about this series, that's
probably why. IMHO it lacks substance for rationale, **and** implies a few
gains without any *clear* performance metrics. I have 0 experience with
mm so I'd like other's feedback on my this -- I'm just trying to do
decipher rationale from prior "bpf prog pack" efforts.

I'm sensing that the cables in messaging are a bit crossed here and we need
to provide a bit better full picture for rationale and this is being
completely missed and this work is being undersold.  If my assessment is
accurate though, the bpf prog pack strategy with sharing huge pages may prove
useful long term for other things than just modules / ftrace / kprobes.

I was surprised to see this entire patch series upgrade from RFC to proper
PATCH form now completely fails to mention any of the original motivations
behind the "BPF prog pack", which you are doing a true heroic effort to try to
generalize as the problem is hard. Let me try to help with that. The rationale
for the old BPF prog pack is documented as follows:

* Most BPF programs are pretty small. Allocating a hole page for each
* program is sometime a waste. Many small bpf program also adds pressure
* to instruction TLB. To solve this issue, we introduce a BPF program pack
* allocator. The prog_pack allocator uses HPAGE_PMD_SIZE page (2MB on x86)
* to host BPF programs.

Previously you have also stated in earlier versions of this patch set:

  "Most BPF programs are small, but they consume a page each. For systems
   with busy traffic and many BPF programs, this could also add significant
   pressure to instruction TLB. High iTLB pressure usually causes slow down
   for the whole system, which includes visible performance
   degradation for production workloads."

So it is implied here that one of the benefits is to help reduce iTLB misses.
But that's it. We have no visible numbers to look at and for what... But
reducing iTLB misses doesn't always have a complete direct correlation
with improving things, but if the code change is small enough it obviously
makes sense to apply. If the change is a bit more intrusive, as in this
patch series a bit more rationale should be provided.

Other than the "performance aspects" of your patchset, the *main* reason
I am engaged and like it is it reduces the nasty mess of semantics on
dealing with special permissions on pages which we see in modules and a
few other places which today completely open code it. That proves error
prone and I'm glad to see efforts to generalize that nastiness. So
please ensure this is added as part of the documented rationale. Even
if the iTLB miss ratio improvement is not astronomical I believe that
the gains in sanity on improving semantics on special pages and sharing code
make it well worthwhile. The iTLB miss ratio improvement is just a small
cherry on top.

Going back to performance aspects, when Linus had poked for more details
about this your have elaborated further:

  "we have seen direct map fragmentation causing visible
   performance drop for our major services. This is the shadow 
   production benchmark, so it is not possible to run it out of 
   our data centers. Tracing showed that BPF program was the top 
   trigger of these direct map splits."

And the only other metric we have is:

  "For our web service production benchmark, bpf_prog_pack on 4kB pages
   gives 0.5% to 0.7% more throughput than not using bpf_prog_pack."

These metrics are completely arbitrary and opaque to us. We need
something tangible and reproducible and I have been suggesting that
from early on...

I'm under the impression that the real missed, undocumented, major value-add
here is that the old "BPF prog pack" strategy helps to reduce the direct map
fragmentation caused by heavy use of the eBPF JIT programs and this in
turn helps your overall random system performance (regardless of what
it is you do). As I see it then the eBPF prog pack is just one strategy to
try to mitigate memory fragmentation on the direct map caused by the the eBPF
JIT programs, so the "slow down" your team has obvserved should be due to the
eventual fragmentation caused on the direct map *while* eBPF programs
get heavily used.

Mike Rapoport had presented about the Direct map fragmentation problem
at Plumbers 2021 [0], and clearly mentioned modules / BPF / ftrace /
kprobes as possible sources for this. Then Xing Zhengjun's 2021 performance
evaluation on whether using 2M/1G pages aggressively for the kernel direct map
help performance [1] ends up generally recommending huge pages. The work by Xing
though was about using huge pages *alone*, not using a strategy such as in the
"bpf prog pack" to share one 2 MiB huge page for *all* small eBPF programs,
and that I think is the real golden nugget here.

I contend therefore that the theoretical reduction of iTLB misses by using
huge pages for "bpf prog pack" is not what gets your systems to perform
somehow better. It should be simply that it reduces fragmentation and
*this* generally can help with performance long term. If this is accurate
then let's please separate the two aspects to this.

There's two aspects to what I would like to see from a performance
perspective then actually mentioned in the commit logs:

1) iTLB miss loss ratio with "bpf prog pack" or this generalized solution
   Vs not using it at all:

   I'd tried the below but didn't see much difference:

   perf stat --repeat 10 -e dTLB-loads,dTLB-load-misses,dTLB-stores,dTLB-stores-misses,iTLB-loads,iTLB-load-misses,page-faults \
   	--pre 'modprobe -r test_bpf' \-- modprobe test_bpf

   This is likely that the system I have might have a huge cache and I
   was not contending it with another heavy memory intensive workload.
   So it may be worthy to run something like the above *as* some other
   memory intensive benchark kicks gear in a loop. Another reason too
   may be that test_bpf runs tests sequentially instead of in parallel,
   and so it would be good to get ebpf folks's feedback as to an idea
   of what other things could be done to really eBPF JIT the hell out of
   a system. It is why I had suggested long ago maybe a custom new
   selftest which stresses the hell out of only eBPF JIT and had given
   an example multithreaded selftest.

   If we ever get modules support, I was hoping to see if something like
   the below (if the fs module .text section does end up shared) *may*
   have reduce iTLB miss ratio.

   perf stat --repeat 10 -e dTLB-loads,dTLB-load-misses,dTLB-stores,dTLB-stores-misses,iTLB-loads,iTLB-load-misses,page-faults \
	--pre 'make -s mrproper defconfig' \-- make -s -j$(nproc) bzImage

   Maybe something as simple as systemd-analyze may show time reduction
   if iTLB miss ratio is reduced by sharing most module code in a huge
   page.

2) Estimate in reduction on direct map fragmentation by using the "bpf
   prog pack" or this generalized solution:

   For this I'd expect a benchmark similar to the workload you guys
   run or something memory intensive, as eBPF JITs are heavily used,
   and after a certain amount of time somehow compute how fragmented
   memory is. The only sensible thing I can think to measure memory
   fragmentation is to look at the memory compaction index
   /sys/kernel/debug/extfrag/extfrag_index , but I highly welcome other's
   ideas as I'm a mm n00b.

[0] https://lpc.events/event/11/contributions/1127/attachments/922/1792/LPC21%20Direct%20map%20management%20.pdf
[1] https://lore.kernel.org/linux-mm/213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com/

> +static void move_vmap_to_free_text_tree(void *addr)
> +{
> +	struct vmap_area *va;
> +
> +	/* remove from vmap_area_root */
> +	spin_lock(&vmap_area_lock);
> +	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
> +	if (WARN_ON_ONCE(!va)) {

This seems to be hopeful but we purposely are allowing for the allocated
memory to be used elsewhere are we not? Can you trigger the WARN_ON_ONCE()
with stress-ng as described in commit 82dd23e84be3e ("mm/vmalloc.c:
preload a CPU with one object for split purpose") while using eBPF JIT
or loading/unloading a module in a loop?

> +void *vmalloc_exec(unsigned long size, unsigned long align)
> +{
> +	struct vmap_area *va, *tmp;
> +	unsigned long addr;
> +	enum fit_type type;
> +	int ret;
> +
> +	va = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, NUMA_NO_NODE);
> +	if (unlikely(!va))
> +		return NULL;
> +
> +again:
> +	preload_this_cpu_lock(&free_text_area_lock, GFP_KERNEL, NUMA_NO_NODE);
> +	tmp = find_vmap_lowest_match(&free_text_area_root, size, align, 1, false);
> +
> +	if (!tmp) {
> +		unsigned long alloc_size;
> +		void *ptr;
> +
> +		spin_unlock(&free_text_area_lock);
> +
> +		/*
> +		 * Not enough continuous space in free_text_area_root, try
> +		 * allocate more memory. The memory is first added to
> +		 * vmap_area_root, and then moved to free_text_area_root.
> +		 */
> +		alloc_size = roundup(size, PMD_SIZE * num_online_nodes());
> +		ptr = __vmalloc_node_range(alloc_size, PMD_SIZE, VMALLOC_EXEC_START,
> +					   VMALLOC_EXEC_END, GFP_KERNEL, PAGE_KERNEL,
> +					   VM_ALLOW_HUGE_VMAP | VM_NO_GUARD,
> +					   NUMA_NO_NODE, __builtin_return_address(0));

I thought Peter had suggested keeping the guard?

Once you get modules going you may want to update the comment about
modules on __vmalloc_node_range().

  Luis
