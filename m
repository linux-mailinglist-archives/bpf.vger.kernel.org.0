Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9484572B5E
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 04:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiGMCjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 22:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGMCjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 22:39:12 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DD7435D
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 19:39:11 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:39:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657679950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zf80XZEaZtqk7AVq5EEeCqFQwvbUG56hYMzo/FstPo0=;
        b=qRlUM/ob500PR9fOwc5P/Ti8NN+557hQQZo+tWCi3BYGOPrxowmdXFY2ksfTiMfcfaXQoe
        OX6Y5QRzl/xVgv463nZsGdpTqvF+GmyrQSFGNbqnupqRc4agp6ADleT7YaKNaF0E9OP++q
        k+S1ORW0w9pyHKzz+5g4bNl+Mxpb6rE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <Ys4wRqCWrV1WeeWp@castle>
References: <Ysg0GyvqUe0od2NN@dhcp22.suse.cz>
 <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 11:52:11AM +0200, Michal Hocko wrote:
> On Tue 12-07-22 16:39:48, Yafang Shao wrote:
> > On Tue, Jul 12, 2022 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > Roman already sent reparenting fix:
> > > > https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/
> > >
> > > Reparenting is nice but not a silver bullet. Consider a shallow
> > > hierarchy where the charging happens in the first level under the root
> > > memcg. Reparenting to the root is just pushing everything under the
> > > system resources category.
> > >
> > 
> > Agreed. That's why I don't like reparenting.
> > Reparenting just reparent the charged pages and then redirect the new
> > charge, but can't reparents the 'limit' of the original memcg.
> > So it is a risk if the original memcg is still being charged. We have
> > to forbid the destruction of the original memcg.

I agree, I also don't like reparenting for !kmem case. For kmem (and *maybe*
bpf maps is an exception), I don't think there is a better choice.

> yes, I was toying with an idea like that. I guess we really want a
> measure to keep cgroups around if they are bound to a resource which is
> sticky itself. I am not sure how many other resources like BPF (aka
> module like) we already do charge for memcg but considering the
> potential memory consumption just reparenting will not help in general
> case I am afraid.

Well, then we have to make these objects a first-class citizens in cgroup API,
like processes. E.g. introduce cgroup.bpf.maps, cgroup.mounts.tmpfs etc.
I easily can see some value here, but it's a big API change.

With the current approach when a bpf map pins a memory cgroup of the creator
process (which I think is completely transparent for most bpf users), I don't
think preventing the deletion of a such cgroup is possible. It will break too
many things.

But honestly I don't see why userspace can't handle it. If there is a cgroup which
contains shared bpf maps, why would it delete it? It's a weird use case, I don't
think we have to optimize for it. Also, we do a ton of optimizations for live
cgroups (e.g. css refcounting being percpu) which are not working for a deleted
cgroup. So noone really should expect any properties from dying cgroups.

Thanks!
