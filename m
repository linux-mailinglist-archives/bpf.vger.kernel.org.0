Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D057824E
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiGRM1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiGRM1R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 08:27:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA426114
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 05:27:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DBF3B209F6;
        Mon, 18 Jul 2022 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658147233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWG69MBMtbPs10PORBmWiw+O9epLyQ5nVwzywqBkahs=;
        b=u7h7Df5+NOyt2ToHarG143mDlL+iaghJFNVDhhi68GQ+wIdI+gayQxM40xh7s83Pi8TZag
        6jKNBHsffX8VHKfaaZ5YJMWM0bb5A5IXBfcKj5KBhaIPgutnzxCTku/Ml/oL60AxVFLqeP
        OJUTF+Irrt6Ci30f6t8ijmJzjjd49l4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D0E892C141;
        Mon, 18 Jul 2022 12:27:12 +0000 (UTC)
Date:   Mon, 18 Jul 2022 14:27:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YtVRoGD1AlMt0tI5@dhcp22.suse.cz>
References: <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <20220712184018.i3cisffxr7k3aei7@MacBook-Pro-3.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712184018.i3cisffxr7k3aei7@MacBook-Pro-3.local.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue 12-07-22 11:40:18, Alexei Starovoitov wrote:
> On Tue, Jul 12, 2022 at 09:40:13AM +0200, Michal Hocko wrote:
> > On Mon 11-07-22 21:39:14, Alexei Starovoitov wrote:
> > > On Mon, Jul 11, 2022 at 02:15:07PM +0200, Michal Hocko wrote:
> > > > On Sun 10-07-22 07:32:13, Shakeel Butt wrote:
> > > > > On Sat, Jul 09, 2022 at 10:26:23PM -0700, Alexei Starovoitov wrote:
> > > > > > On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > > [...]
> > > > > > >
> > > > > > > Most probably Michal's comment was on free objects sitting in the caches
> > > > > > > (also pointed out by Yosry). Should we drain them on memory pressure /
> > > > > > > OOM or should we ignore them as the amount of memory is not significant?
> > > > > > 
> > > > > > Are you suggesting to design a shrinker for 0.01% of the memory
> > > > > > consumed by bpf?
> > > > > 
> > > > > No, just claim that the memory sitting on such caches is insignificant.
> > > > 
> > > > yes, that is not really clear from the patch description. Earlier you
> > > > have said that the memory consumed might go into GBs. If that is a
> > > > memory that is actively used and not really reclaimable then bad luck.
> > > > There are other users like that in the kernel and this is not a new
> > > > problem. I think it would really help to add a counter to describe both
> > > > the overall memory claimed by the bpf allocator and actively used
> > > > portion of it. If you use our standard vmstat infrastructure then we can
> > > > easily show that information in the OOM report.
> > > 
> > > OOM report can potentially be extended with info about bpf consumed
> > > memory, but it's not clear whether it will help OOM analysis.
> > 
> > If GBs of memory can be sitting there then it is surely an interesting
> > information to have when seeing OOM. One of the big shortcomings of the
> > OOM analysis is unaccounted memory.
> > 
> > > bpftool map show
> > > prints all map data already.
> > > Some devs use bpf to inspect bpf maps for finer details in run-time.
> > > drgn scripts pull that data from crash dumps.
> > > There is no need for new counters.
> > > The idea of bpf specific counters/limits was rejected by memcg folks.
> > 
> > I would argue that integration into vmstat is useful not only for oom
> > analysis but also for regular health check scripts watching /proc/vmstat
> > content. I do not think most of those generic tools are BPF aware. So
> > unless there is a good reason to not account this memory there then I
> > would vote for adding them. They are cheap and easy to integrate.
> 
> We've seen enough performance issues with such counters.

Not sure we are talking about the same thing. These counters are used by
the page allocator as well (e.g. PGALLOC, PGFREE) without a noticeable
overhead.

> So, no, they are not cheap.
> Remember bpf has to be optimized for all cases.
> Some of them process millions of packets per second.
> Others do millions of map update/delete per second which means
> millions of alloc/free.

I thought the whole point is to allocate from a different context than
the one where the memory is used.

In any case, these were my few cents to help with "usual pains when OOM
is hit". I can see you are not much into discussing in more details so
I won't burn much more of our time here.

Let me just reiterate that OOM reports with a large part of the
consumption outside of usual counters are a PITA and essentially
undebuggable without a local reproducer which can get pretty tricky with
custom eBPF programs running on the affected system you do not have
access to. So I believe that large in-kernel memory consumers should
be accounted somewhere so it is at least clear where one should look
for. If numbers tell that the accounting is prohibitely expensive than
it would be great to have an estimation at least.

Thanks

-- 
Michal Hocko
SUSE Labs
