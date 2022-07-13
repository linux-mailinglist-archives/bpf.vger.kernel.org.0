Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45451572B4B
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 04:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiGMC1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiGMC1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 22:27:43 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA818C9101
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 19:27:40 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:27:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657679257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+H3JbmgR9nzDmYyIZDpk3Exe35EXBhIWXcF/NhhLnk=;
        b=i3dK+DXONC7Oj/CnBtm8OHCzp3iDTdpdQkfjC17Jnk6SL89Z3d19NsnZmebhJtLunmq3F2
        YpUnfL+iMilG/zrQEonILYCF87EWql9i0cf3rmkXUZCXYnuZe3/dcetXRX/e+jSNfM6Ktz
        pNY+GrMA7scn5H40JMshAhH2PUQ3SM8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <Ys4tkFkBZ+jEyCk9@castle>
References: <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 09:40:13AM +0200, Michal Hocko wrote:
> On Mon 11-07-22 21:39:14, Alexei Starovoitov wrote:
> > On Mon, Jul 11, 2022 at 02:15:07PM +0200, Michal Hocko wrote:
> > > On Sun 10-07-22 07:32:13, Shakeel Butt wrote:
> > > > On Sat, Jul 09, 2022 at 10:26:23PM -0700, Alexei Starovoitov wrote:
> > > > > On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
> > > > [...]
> > > > > >
> > > > > > Most probably Michal's comment was on free objects sitting in the caches
> > > > > > (also pointed out by Yosry). Should we drain them on memory pressure /
> > > > > > OOM or should we ignore them as the amount of memory is not significant?
> > > > > 
> > > > > Are you suggesting to design a shrinker for 0.01% of the memory
> > > > > consumed by bpf?
> > > > 
> > > > No, just claim that the memory sitting on such caches is insignificant.
> > > 
> > > yes, that is not really clear from the patch description. Earlier you
> > > have said that the memory consumed might go into GBs. If that is a
> > > memory that is actively used and not really reclaimable then bad luck.
> > > There are other users like that in the kernel and this is not a new
> > > problem. I think it would really help to add a counter to describe both
> > > the overall memory claimed by the bpf allocator and actively used
> > > portion of it. If you use our standard vmstat infrastructure then we can
> > > easily show that information in the OOM report.
> > 
> > OOM report can potentially be extended with info about bpf consumed
> > memory, but it's not clear whether it will help OOM analysis.
> 
> If GBs of memory can be sitting there then it is surely an interesting
> information to have when seeing OOM. One of the big shortcomings of the
> OOM analysis is unaccounted memory.
> 
> > bpftool map show
> > prints all map data already.
> > Some devs use bpf to inspect bpf maps for finer details in run-time.
> > drgn scripts pull that data from crash dumps.
> > There is no need for new counters.
> > The idea of bpf specific counters/limits was rejected by memcg folks.
> 
> I would argue that integration into vmstat is useful not only for oom
> analysis but also for regular health check scripts watching /proc/vmstat
> content. I do not think most of those generic tools are BPF aware. So
> unless there is a good reason to not account this memory there then I
> would vote for adding them. They are cheap and easy to integrate.
>  
> > > OK, thanks for the clarification. There is still one thing that is not
> > > really clear to me. Without a proper ownership bound to any process why
> > > is it desired/helpful to account the memory to a memcg?
> > 
> > The first step is to have a limit. memcg provides it.
> 
> I am sorry but this doesn't really explain it. Could you elaborate
> please? Is the limit supposed to protect against adversaries? Or is it
> just to prevent from accidental runaways? Is it purely for accounting
> purposes?
> 
> > > We have discussed something similar in a different email thread and I
> > > still didn't manage to find time to put all the parts together. But if
> > > the initiator (or however you call the process which loads the program)
> > > exits then this might be the last process in the specific cgroup and so
> > > it can be offlined and mostly invisible to an admin.
> > 
> > Roman already sent reparenting fix:
> > https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/

Just to be clear:
for the actual memory which is backing up bpf maps (slabs, percpu or vmallocs)
reparenting was implemented several years ago. Nothing is changing here.

This patch only adds reparenting to the map->memcg pointer (by replacing it
to an objcg), which affects *new* allocations which are happening after
the deletion of the cgroup. This would help to reduce the number of dying cgroups,
but unlikely significantly, this is why it hasn't been implemented from scratch.

Thanks!
