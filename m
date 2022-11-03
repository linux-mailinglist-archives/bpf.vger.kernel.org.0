Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0A618817
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKCS76 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 14:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKCS7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 14:59:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC91B9F8
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Df/5Jd4LtL064HDmqF1pPzcpMKgBg+DvFuaOIIuNgC0=; b=3osOA/J6sr+eBBlhgbf3GMmK9A
        e2JjTAUCj51VXwS9UkiT7AIVQzTpLXUN9InHbOQIAXH5BhuSIZ11xZep+K9I5gG3oP0lDbQnIeLgU
        Y/ACUpR74YfrVYZuwETnVhtg+IdnGfnIqWoYcftX17dGsrhFURXOYpbJdkKyhMzbaN8PrPiWzUDEB
        T6hBLeo8q19kqi4ylkH1CpQyVigq91X914MjQh5WoUwEXU4e9Wu2T9HHujxmLnzbdirsKOPU3+71m
        deU0khNTuFlD4T9zjDz3kN1Zq27aZ60Ur+I7GlDXCILno1hhEgZh0KLZAH6huP/sg8q/BxyR9SGCk
        5iF4iErg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqfRN-001N4h-1o; Thu, 03 Nov 2022 18:59:49 +0000
Date:   Thu, 3 Nov 2022 11:59:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, zhengjun.xing@linux.intel.com,
        kbusch@kernel.org, p.raghav@samsung.com, dave@stgolabs.net,
        vbabka@suse.cz, mgorman@suse.de, willy@infradead.org,
        torvalds@linux-foundation.org, a.manzanares@samsung.com
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Message-ID: <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
References: <20221031222541.1773452-1-song@kernel.org>
 <20221031222541.1773452-2-song@kernel.org>
 <Y2MAR0aj+jcq+15H@bombadil.infradead.org>
 <Y2Pjnd3mxA9fTlox@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Pjnd3mxA9fTlox@kernel.org>
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

On Thu, Nov 03, 2022 at 05:51:57PM +0200, Mike Rapoport wrote:
> Hi Luis,
> 
> Thanks for looping me in.
> 
> On Wed, Nov 02, 2022 at 04:41:59PM -0700, Luis Chamberlain wrote:
> > On Mon, Oct 31, 2022 at 03:25:37PM -0700, Song Liu wrote:
> > > vmalloc_exec is used to allocate memory to host dynamic kernel text
> > > (modules, BPF programs, etc.) with huge pages. This is similar to the
> > > proposal by Peter in [1].
> > 
> > This is allg reat but we need to clarify *why* we would go through the
> > trouble.  So if folks are not to excited about this series, that's
> > probably why. IMHO it lacks substance for rationale, **and** implies a few
> > gains without any *clear* performance metrics. I have 0 experience with
> > mm so I'd like other's feedback on my this -- I'm just trying to do
> > decipher rationale from prior "bpf prog pack" efforts.
> > 
> > I'm sensing that the cables in messaging are a bit crossed here and we need
> > to provide a bit better full picture for rationale and this is being
> > completely missed and this work is being undersold.  If my assessment is
> > accurate though, the bpf prog pack strategy with sharing huge pages may prove
> > useful long term for other things than just modules / ftrace / kprobes.
> > 
> > I was surprised to see this entire patch series upgrade from RFC to proper
> > PATCH form now completely fails to mention any of the original motivations
> > behind the "BPF prog pack", which you are doing a true heroic effort to try to
> > generalize as the problem is hard. Let me try to help with that. The rationale
> > for the old BPF prog pack is documented as follows:
> > 
> > * Most BPF programs are pretty small. Allocating a hole page for each
> > * program is sometime a waste. Many small bpf program also adds pressure
> > * to instruction TLB. To solve this issue, we introduce a BPF program pack
> > * allocator. The prog_pack allocator uses HPAGE_PMD_SIZE page (2MB on x86)
> > * to host BPF programs.
> > 
> > Previously you have also stated in earlier versions of this patch set:
> > 
> >   "Most BPF programs are small, but they consume a page each. For systems
> >    with busy traffic and many BPF programs, this could also add significant
> >    pressure to instruction TLB. High iTLB pressure usually causes slow down
> >    for the whole system, which includes visible performance
> >    degradation for production workloads."
> > 
> > So it is implied here that one of the benefits is to help reduce iTLB misses.
> > But that's it. We have no visible numbers to look at and for what... But
> > reducing iTLB misses doesn't always have a complete direct correlation
> > with improving things, but if the code change is small enough it obviously
> > makes sense to apply. If the change is a bit more intrusive, as in this
> > patch series a bit more rationale should be provided.
> > 
> > Other than the "performance aspects" of your patchset, the *main* reason
> > I am engaged and like it is it reduces the nasty mess of semantics on
> > dealing with special permissions on pages which we see in modules and a
> > few other places which today completely open code it. That proves error
> > prone and I'm glad to see efforts to generalize that nastiness. So
> > please ensure this is added as part of the documented rationale. Even
> > if the iTLB miss ratio improvement is not astronomical I believe that
> > the gains in sanity on improving semantics on special pages and sharing code
> > make it well worthwhile. The iTLB miss ratio improvement is just a small
> > cherry on top.
> > 
> > Going back to performance aspects, when Linus had poked for more details
> > about this your have elaborated further:
> > 
> >   "we have seen direct map fragmentation causing visible
> >    performance drop for our major services. This is the shadow 
> >    production benchmark, so it is not possible to run it out of 
> >    our data centers. Tracing showed that BPF program was the top 
> >    trigger of these direct map splits."
> > 
> > And the only other metric we have is:
> > 
> >   "For our web service production benchmark, bpf_prog_pack on 4kB pages
> >    gives 0.5% to 0.7% more throughput than not using bpf_prog_pack."
> > 
> > These metrics are completely arbitrary and opaque to us. We need
> > something tangible and reproducible and I have been suggesting that
> > from early on...
> > 
> > I'm under the impression that the real missed, undocumented, major value-add
> > here is that the old "BPF prog pack" strategy helps to reduce the direct map
> > fragmentation caused by heavy use of the eBPF JIT programs and this in
> > turn helps your overall random system performance (regardless of what
> > it is you do). As I see it then the eBPF prog pack is just one strategy to
> > try to mitigate memory fragmentation on the direct map caused by the the eBPF
> > JIT programs, so the "slow down" your team has obvserved should be due to the
> > eventual fragmentation caused on the direct map *while* eBPF programs
> > get heavily used.
> 
> I believe that while the eBPF prog pack is helpful in mitigation of the
> direct map fragmentation caused by the eBPF JIT programs, the same strategy
> of allocating a large page, splitting its PMD entry and then reusing the
> memory for smaller allocations can be (and should be) generalized to other
> use cases that require non-default permissions in the page table.  Most
> prominent use cases are those that allocate memory for code, but the same
> approach is relevant for other cases, like secretmem or page table
> protection with PKS.
> 
> A while ago I've suggested to handle such caching of large pages at the
> page allocator level, but when we discussed it at LSF/MM/BPF, prevailing
> opinion was that added value does not justify changes to the page
> allocator and it was suggested to handle such caching elsewhere. 

I saw that on the lwn coverage.

> I had to put this project on a backburner for $VARIOUS_REASONS, but I still
> think that we need a generic allocator for memory with non-default
> permissions in the direct map and that code allocation should build on that
> allocator.

It seems this generalization of the bpf prog pack to possibly be used
for modules / kprobes / ftrace is a small step in that direction.

> All that said, the direct map fragmentation problem is currently relevant
> only to x86 because it's the only architecture that supports splitting of
> the large pages in the direct map.

I was thinking even more long term too, using this as a proof of concept. If
this practice in general helps with fragmentation, could it be used for
experimetnation with compound pages later, as a way to reduce possible
fragmentation.

> > Mike Rapoport had presented about the Direct map fragmentation problem
> > at Plumbers 2021 [0], and clearly mentioned modules / BPF / ftrace /
> > kprobes as possible sources for this. Then Xing Zhengjun's 2021 performance
> > evaluation on whether using 2M/1G pages aggressively for the kernel direct map
> > help performance [1] ends up generally recommending huge pages. The work by Xing
> > though was about using huge pages *alone*, not using a strategy such as in the
> > "bpf prog pack" to share one 2 MiB huge page for *all* small eBPF programs,
> > and that I think is the real golden nugget here.
> > 
> > I contend therefore that the theoretical reduction of iTLB misses by using
> > huge pages for "bpf prog pack" is not what gets your systems to perform
> > somehow better. It should be simply that it reduces fragmentation and
> > *this* generally can help with performance long term. If this is accurate
> > then let's please separate the two aspects to this.
> 
> The direct map fragmentation is the reason for higher TLB miss rate, both
> for iTLB and dTLB.

OK so then whatever benchmark is running in tandem as eBPF JIT is hammered
should *also* be measured with perf for iTLB and dTLB. ie, the patch can
provide such results as a justifications.

> Whenever a large page in the direct map is split, all
> kernel accesses via the direct map will use small pages which requires
> dealing with 512 page table entries instead of one for 2M range.
> 
> Since small pages in the direct map are never collapsed back to large
> pages, long living system that heavily uses eBPF programs will have its
> direct map severely fragmented, higher TLB miss rate and worse overall
> performance. 

Shouldn't compaction help with those situations?

> > There's two aspects to what I would like to see from a performance
> > perspective then actually mentioned in the commit logs:
> > 
> > 1) iTLB miss loss ratio with "bpf prog pack" or this generalized solution
> >    Vs not using it at all:
> 
> ... 
>  
> > 2) Estimate in reduction on direct map fragmentation by using the "bpf
> >    prog pack" or this generalized solution:
> > 
> >    For this I'd expect a benchmark similar to the workload you guys
> >    run or something memory intensive, as eBPF JITs are heavily used,
> >    and after a certain amount of time somehow compute how fragmented
> >    memory is. The only sensible thing I can think to measure memory
> >    fragmentation is to look at the memory compaction index
> >    /sys/kernel/debug/extfrag/extfrag_index , but I highly welcome other's
> >    ideas as I'm a mm n00b.
> 
> The direct map fragmentation can be tracked with 
> 
> 	grep DirectMap /proc/meminfo
> 	grep direct_map /proc/vmstat
> 
> and by looking at /sys/kernel/debug/page_tables/kernel

Thanks!

  Luis
