Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D80578509
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiGRONn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGRONk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 10:13:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF727FFF
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 07:13:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F314533CFA;
        Mon, 18 Jul 2022 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658153616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Op5MBj9BJf4R8av8QSxiYS2XjeRSFgLubMjLAKL6O8k=;
        b=AODiV9Y1aeA/xOSckULSkAEillhxb1/kpdQtn18FXdbHGL1q6X+Ab/myog4omDJUj/59jz
        /rMRHLteFbcLsCO3zbbykRMHmEBwYZNo1eIR+lS6f2coA7KtPdKkNHAeldVwkToFrm9DOA
        1pfyrsuF1LxLMAJvjXqUhExwGIfd8BE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D910C2C161;
        Mon, 18 Jul 2022 14:13:31 +0000 (UTC)
Date:   Mon, 18 Jul 2022 16:13:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
Message-ID: <YtVqi3IqnYpE3R46@dhcp22.suse.cz>
References: <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <Ys2gNCAyYGX3XVMm@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2gNCAyYGX3XVMm@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue 12-07-22 06:24:20, Tejun Heo wrote:
> Hello, Michal.
> 
> On Tue, Jul 12, 2022 at 11:52:11AM +0200, Michal Hocko wrote:
> > > Agreed. That's why I don't like reparenting.
> > > Reparenting just reparent the charged pages and then redirect the new
> > > charge, but can't reparents the 'limit' of the original memcg.
> > > So it is a risk if the original memcg is still being charged. We have
> > > to forbid the destruction of the original memcg.
> > 
> > yes, I was toying with an idea like that. I guess we really want a
> > measure to keep cgroups around if they are bound to a resource which is
> > sticky itself. I am not sure how many other resources like BPF (aka
> > module like) we already do charge for memcg but considering the
> > potential memory consumption just reparenting will not help in general
> > case I am afraid.
> 
> I think the solution here is an extra cgroup layering to represent
> persistent resource tracking. In systemd-speak, a service should have a
> cgroup representing a persistent service type and a cgroup representing the
> current running instance. This way, the user (or system agent) can clearly
> distinguish all resources that have ever been attributed to the service and
> the resources that are accounted to the current instance while also giving
> visibility into residual resources for services that are no longer running.

Just to make sure I follow what you mean here. You are suggesting that
the cgroup manager would ensure that there will be a parent responsible
for the resource and that cgroup will not go away as long as there are
resources (well modulo admin interferese which is not really interesting
usecase).

I do agree that this approach would be easier from the kernel
perspective. It is also more error prone because some resources might be
so runtime specific that it is hard to predict and configure them in
advance. My thinking about "sticky" cgroups was based on the reference
count of approach when the kernel knows that the resource requires some
sort of tear down which is not process life scoped and would take a
reference on the cgroup to keep it alive. I can see a concern that this
can get quite subtle in many cases though.

> This gives userspace control over what to track for how long and also fits
> what the kernel can do in terms of resource tracking. If we try to do
> something smart from kernel side, there are cases which are inherently
> insolvable. e.g. if a service instance creates tmpfs / shmem / whawtever and
> leaves it pinned one way or another and then exits, and there's no one who
> actively accessed it afterwards, there is no userland visible entity we can
> reasonably attribute that memory to other than the parent cgroup.

yeah, tmpfs would be another example which is even more complex because
a single file can "belong" to different memcgs.
-- 
Michal Hocko
SUSE Labs
