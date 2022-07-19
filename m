Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6C579885
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiGSLay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiGSLay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 07:30:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE5D60CA
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 04:30:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0D3A3510A;
        Tue, 19 Jul 2022 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658230251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEeCCLSta3HcRHaPk6iGTZCTxTMRWXyTHqEYQ05Ux9w=;
        b=CVeCxGYYUGLBzabGk0Qenp6GKA/EIm671QkK9E8AKYbh4yLJY9CWEkKLyii4XtALul/0JP
        Z1qQmhICaixrcdJzX727B+/FUBmszeOirlXsIWPYhbiiltq6C2XA2FB+LqaqjaoTC/YfrD
        iy8wPkjA0tjzeXUDx0MateWjxmj73vI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 81FEA2C141;
        Tue, 19 Jul 2022 11:30:50 +0000 (UTC)
Date:   Tue, 19 Jul 2022 13:30:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
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
Subject: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5] bpf:
 BPF specific memory allocator.)
Message-ID: <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
References: <20220708215536.pqclxdqvtrfll2y4@google.com>
 <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
 <20220710073213.bkkdweiqrlnr35sv@google.com>
 <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon 18-07-22 10:55:59, Yosry Ahmed wrote:
> On Tue, Jul 12, 2022 at 7:39 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Tue, Jul 12, 2022 at 11:52:11AM +0200, Michal Hocko wrote:
> > > On Tue 12-07-22 16:39:48, Yafang Shao wrote:
> > > > On Tue, Jul 12, 2022 at 3:40 PM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > > Roman already sent reparenting fix:
> > > > > > https://patchwork.kernel.org/project/netdevbpf/patch/20220711162827.184743-1-roman.gushchin@linux.dev/
> > > > >
> > > > > Reparenting is nice but not a silver bullet. Consider a shallow
> > > > > hierarchy where the charging happens in the first level under the root
> > > > > memcg. Reparenting to the root is just pushing everything under the
> > > > > system resources category.
> > > > >
> > > >
> > > > Agreed. That's why I don't like reparenting.
> > > > Reparenting just reparent the charged pages and then redirect the new
> > > > charge, but can't reparents the 'limit' of the original memcg.
> > > > So it is a risk if the original memcg is still being charged. We have
> > > > to forbid the destruction of the original memcg.
> >
> > I agree, I also don't like reparenting for !kmem case. For kmem (and *maybe*
> > bpf maps is an exception), I don't think there is a better choice.
> >
> > > yes, I was toying with an idea like that. I guess we really want a
> > > measure to keep cgroups around if they are bound to a resource which is
> > > sticky itself. I am not sure how many other resources like BPF (aka
> > > module like) we already do charge for memcg but considering the
> > > potential memory consumption just reparenting will not help in general
> > > case I am afraid.
> >
> > Well, then we have to make these objects a first-class citizens in cgroup API,
> > like processes. E.g. introduce cgroup.bpf.maps, cgroup.mounts.tmpfs etc.
> > I easily can see some value here, but it's a big API change.
> >
> > With the current approach when a bpf map pins a memory cgroup of the creator
> > process (which I think is completely transparent for most bpf users), I don't
> > think preventing the deletion of a such cgroup is possible. It will break too
> > many things.
> >
> > But honestly I don't see why userspace can't handle it. If there is a cgroup which
> > contains shared bpf maps, why would it delete it? It's a weird use case, I don't
> > think we have to optimize for it. Also, we do a ton of optimizations for live
> > cgroups (e.g. css refcounting being percpu) which are not working for a deleted
> > cgroup. So noone really should expect any properties from dying cgroups.
> >
> 
> Just a random thought here, and I can easily be wrong (and this can
> easily be the wrong thread for this), but if we introduce a more
> generic concept to generally tie a resource explicitly to a cgroup
> (tmpfs, bpf maps, etc) using cgroupfs interfaces, and then prevent the
> cgroup from being deleted unless the resource is freed or moved to a
> different cgroup?

My understanding is that Tejun would prefer a user space defined policy
by a proper layering. And I would tend to agree that this is less prone
to corner cases.

Anyway, how would you envision such an interface?

> This would be optional, so the current status quo is maintainable, but
> also gives flexibility to admins to assign resources to cgroups to
> make sure nothing is ( unaccounted / accounted to a zombie memcg /
> reparented to an unrelated parent ). This might be too fine-grained to
> be practical but I just thought it might be useful. We will also need
> to define an OOM behavior for such resources. Things like bpf maps
> will be unreclaimable, but tmpfs memory can be swapped out.

Keep in mind that the swap is a shared resource in itself. So tmpfs is
essentially a sticky resource as well. A tmpfs file is not bound to any
proces life time the same way BPF program is. You might need less
priviledges to remove a file but in principle they are consuming
resources without any explicit owner.
-- 
Michal Hocko
SUSE Labs
