Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA957B64B
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 14:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiGTM1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 08:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGTM1B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 08:27:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CA474EB
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 05:27:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 501F12073D;
        Wed, 20 Jul 2022 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658320019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCjM+U4btn2hFbEhlDJAN0XtxAvoC02J52EYR1r3quA=;
        b=Fa2MtZ39CZxDiZriXHGmS2WGkOLuQjz2pfbG20IeYYKejTIRGC+lbGxkrpzNqtel1RUux0
        FcHMxzZ3sv/eAr1y/nWT7EG7G3YQCg4wCg1G+lQtwR6G1pzL2Q3guv6pvwo4yDYbpAbUMh
        mhufBOCOcd6ziidndxCd7WCw21Vk9Uc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6B9F42C141;
        Wed, 20 Jul 2022 12:26:55 +0000 (UTC)
Date:   Wed, 20 Jul 2022 14:26:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
Message-ID: <Ytf0i5ZRdUyxE+NY@dhcp22.suse.cz>
References: <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
 <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue 19-07-22 11:46:41, Mina Almasry wrote:
[...]
> An interface like cgroup.sticky.[bpf/tmpfs/..] would work for us
> similar to tmpfs memcg= mount option. I would maybe rename it to
> cgroup.charge_for.[bpf/tmpfs/etc] or something.
> 
> With regards to OOM, my proposal on this patchset is to return ENOSPC
> to the caller if we hit the limit of the remote memcg and there is
> nothing to kill:
> https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@google.com/

That would imply SIGBUS on the #PF path. Is this really the way how we
want to tell userspace that something they are not aware of like a limit
in a completely different resource domain has triggered?

> There is some precedent to doing this in the kernel. If a hugetlb
> allocation hits the hugetlb_cgroup limit, we return ENOSPC to the
> caller (and SIGBUS in the charge path). The reason there being that we
> don't support oom-kill or reclaim or swap for hugetlb pages.

Following hugetlb is not really a great idea because hugetlb has always
been quite special and its users are aware of that. The same doesn't
really apply to other resources like tmpfs.
 
> I think it is also reasonable to prevent removing the memcg if there
> is cgroup.charge_for.[bpf/tmpfs/etc] still alive. Currently we prevent
> removing the memcg if there are tasks attached. So we can also prevent
> removing the memcg if there are bpf/tmpfs charge sources pending.

I can imagine some way of keeping cgroups active even without tasks but
so far I haven't really seen a good way how to achieve that.

cgroup.sticky.[bpf/tmpfs/..] interface is really weird if you ask me.
For one thing I have hard time imagine how to identify those resources.
tmpfs by path is really strange because the same mount point can be
referenced through many paths. Not the mention the path can be
remounted/redirected to anything after the configurion which would just
lead to a lot of confusion.

Exposing internal ids is also far from great. It would also put an
additional burden on the kernel implementation to ensure there is no
overlap in resources among different cgroups.  Also how many of those
sticky resources do we want to grow?

To me this have way too many red flags that it sounds like an interface
which would break really easily.

The more I think about that the more I agree with Tejun that corner
cases are just waiting to jump out at us. 
-- 
Michal Hocko
SUSE Labs
