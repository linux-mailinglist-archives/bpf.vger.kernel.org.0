Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779E56C20C
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbiGHVzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 17:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiGHVzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 17:55:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDDF2B251
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 14:55:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r6-20020a5b06c6000000b006693f6a6d67so16724084ybq.7
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KTcMDJIWF7maQXKusrmUSDyrUm3bNQKSsaTD9FZyhVo=;
        b=Url6xAqmGVyxaGjlRTUrF9phR12iTaqlJWEzoG69laThxIE1WCDlBSWrGbXiqt6otT
         SDt0fTPtdpAs55TSiCVROsmTQLhkqIA4Za0BTVUuXZRYfE3cxeCwu5khduZgQVcZJT5k
         1uM1qJoJlEcE25710S7Jui7GVKsmgUI08tmhfO133LFU5zJB+mFrcV10CxmyBNdDEwqC
         BpCR8AQ8XkzdR/YWkaV4vjbO9MLjMGJtX8sH2/5BuiIfK6v2r7FQgrcB/+rWNhUyfSM5
         DwONximW1fiH0EtRdAnFlYnPngA3SBRV6WuVRVvvH+ebBSc3pUM7hHGuCKCMbXY2Fcr+
         eKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KTcMDJIWF7maQXKusrmUSDyrUm3bNQKSsaTD9FZyhVo=;
        b=vYl4vVWP6Bc+s6mobLT96ceYmJA7kd5rPsTIxuqxu+NZCHG0YyUCIHvj5VgXtgSJ09
         wE/dp8LzXtRgcahFzG9mtEWsYm1R1k4OApYZF2cBvrgFUX7KWl7h+vl0SVhaaocX7pCa
         txmQIuChH/nPhijZ8adDvK4X7YVvl8PlRgFa0qJZvYDHsseNL5WdCiEIWIG8YhK4NKqY
         AwWToDjBkSQRCT3ea08bgIrn2Q+I12f1G6CdIApL/83XlJXg1AVoGhA1Hyr+tpjUAKDZ
         xrBBu8GDZW4Wg3j9gJ5JzB2Ag+2NtoQP8kmDcGqpz5CsIZqtnyH50/09WQOg0YO3zaXz
         k1Jg==
X-Gm-Message-State: AJIora8fPkgWVB1nhgGR5dvb2YX3o6dAsoHxdwEpetqGtwQAHE7MkpTr
        QtIZJ08PMsUK/QHmdYM4Lso5IgzZ+Jr9eg==
X-Google-Smtp-Source: AGRyM1somxke5cd59gI0MGLidzR4nzR4e0KlSKmNXY0RMr2FB0Q3YkA7ars8LWkkqwa8vMzedqr/X8/auq7hpg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a0d:e249:0:b0:31c:82a2:e31e with SMTP id
 l70-20020a0de249000000b0031c82a2e31emr6620087ywe.342.1657317339422; Fri, 08
 Jul 2022 14:55:39 -0700 (PDT)
Date:   Fri, 8 Jul 2022 21:55:36 +0000
In-Reply-To: <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
Message-Id: <20220708215536.pqclxdqvtrfll2y4@google.com>
Mime-Version: 1.0
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org> <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local> <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
From:   Shakeel Butt <shakeelb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 08, 2022 at 10:48:58AM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 08, 2022 at 03:41:47PM +0200, Michal Hocko wrote:
> > On Wed 06-07-22 11:05:25, Alexei Starovoitov wrote:
> > > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > [...]
> > > > For example, I assume that a BPF program
> > > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > > Right?
> > > 
> > > No. It's constrained by memcg limits only. It can allocate gigabytes.
> >  
> > I have very briefly had a look at the core allocator parts (please note
> > that my understanding of BPF is really close to zero so I might be
> > missing a lot of implicit stuff). So by constrained by memcg you mean
> > __GFP_ACCOUNT done from the allocation context (irq_work). The complete
> > gfp mask is GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_ACCOUNT
> > which means this allocation is not allowed to sleep and GFP_ATOMIC
> > implies __GFP_HIGH to say that access to memory reserves is allowed.
> > Memcg charging code interprets this that the hard limit can be breached
> > under assumption that these are rare and will be compensated in some
> > way. The bulk allocator implemented here, however, doesn't reflect that
> > and continues allocating as it sees a success so the breach of the limit
> > is only bound by the number of objects to be allocated. If those can be
> > really large then this is a clear problem and __GFP_HIGH usage is not
> > really appropriate.
> 
> That was a copy paste from the networking stack. See kmalloc_reserve().
> Not sure whether it's a bug there or not.

kmalloc_reserve() is good. Most of calls to kmalloc_reserve() are for
skbs and we don't use __GFP_ACCOUNT for skbs. Actually skbs are charged
to memcg through a separate interface (i.e. mem_cgroup_charge_skmem())

> In a separate thread we've agreed to convert all of bpf allocations
> to GFP_NOWAIT. For this patch set I've already fixed it in my branch.
> 
> > Also, I do not see any tracking of the overall memory sitting in these
> > pools and I think this would be really appropriate. As there doesn't
> > seem to be any reclaim mechanism implemented this can hide quite some
> > unreachable memory.
> > 
> > Finally it is not really clear to what kind of entity is the life time
> > of these caches bound to. Let's say the system goes OOM, is any process
> > responsible for it and a clean up would be done if it gets killed?
> 
> We've been asking these questions for years and have been trying to
> come up with a solution.
> bpf progs are not analogous to user space processes. 
> There are bpf progs that function completely without user space component.
> bpf progs are pretty close to be full featured kernel modules with
> the difference that bpf progs are safe, portable and users have
> full visibility into them (source code, line info, type info, etc)
> They are not binary blobs unlike kernel modules.
> But from OOM perspective they're pretty much like .ko-s.
> Which kernel module would you force unload when system is OOMing ?
> Force unloading ko-s will likely crash the system.
> Force unloading bpf progs maybe equally bad. The system won't crash,
> but it may be a sorrow state. The bpf could have been doing security
> enforcement or network firewall or providing key insights to critical
> user space components like systemd or health check daemon.
> We've been discussing ideas on how to rank and auto cleanup
> the system state when progs have to be unloaded. Some sort of
> destructor mechanism. Fingers crossed we will have it eventually.
> bpf infra keeps track of everything, of course.
> Technically we can detach, unpin and unload everything and all memory
> will be returned back to the system.
> Anyhow not a new problem. Orthogonal to this patch set.
> bpf progs have been doing memory allocation from day one. 8 years ago.
> This patch set is trying to make it 100% safe.
> Currently it's 99% safe.

Most probably Michal's comment was on free objects sitting in the caches
(also pointed out by Yosry). Should we drain them on memory pressure /
OOM or should we ignore them as the amount of memory is not significant?
