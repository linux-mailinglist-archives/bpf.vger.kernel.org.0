Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF456C2D1
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiGHUOd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiGHUOc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 16:14:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C024F18
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 13:14:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o4so31921939wrh.3
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lrp7KZxWmFlFtxCCrcoVbLJIOY0LO9e4z7L5GiyJ+4=;
        b=SDt/23BtJu5iHF14giz3QTuBSW5MgTJOTSH4eGLDV/iG3jJ4w78m+XvEBZ6zSiM9lR
         vCZY7waOxz4n2vyNPy16BwchTvXeRs0pYaM5ncAIWTVvenOJ6ZrjamDfeDFLGoQdcH3r
         6Y7KDbRyEZz2fXLLWU15YAfsARGGE6aTBwt5sv7F4DXR5Im1Sqy2BUXYKNQ7j7a6T8XE
         uvv+jKUxC/gwQczya3fWpK7oVMsf/3YuqEDoHMh2TK26M3L9fS/Du4n46dpptt0UunKL
         VmGQNiicgmuRLbHKyL4feEk+DynH81CCZlPN4ik2ne3zyKv8bvxPVEOe+BRa2O92nxaB
         2d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lrp7KZxWmFlFtxCCrcoVbLJIOY0LO9e4z7L5GiyJ+4=;
        b=7eJ1DCQ8raRo6vLBiqPuILLxmRGnZci0j/KoyetIgtjyuUMU+zqcGW214oJnPUBH//
         pL85Iq1v2zqH0SMeVPxV9JbE3Zz0Hgzsb0OX1IZR5TMlS85gmJNg6398Ez8fAe1VPC11
         7hgEv/6EDcKdjytmA9BLFccQaCZrsQZdvxVsxtyZ1ViMaAN3fpeaqA1hrh3FtRtJBrAe
         9HRzVhNXZIoup5/9HQaQSKDVvLIA2a7EuWt0ry/mWUBK04UwYK2yWbgkntd1C1LckjSP
         FKEKiSx4GuGGumKw+1MVatpXW6IemduzY9HXo7SvMZiYj60RzaWzbmSBscuhI9zu9ra0
         JJ4w==
X-Gm-Message-State: AJIora/wAa00SxLrUJ/ltkn7LzFM07oN6Y3tg9yHg/Wahv2tZF+Pp/Q8
        8yomK2ko4/A89T3mvvb8Zj4pn7qmww9FnRaiKp4Tvg==
X-Google-Smtp-Source: AGRyM1uPg2Vv0NJVF9Fa/lGyzMhnhz9eclYnaJtA7FDjUVK7yhE6fda1M2nB53t5K2BfkZgKoQLi0oI+EGi6f6wc8oo=
X-Received: by 2002:a05:6000:a1e:b0:21b:8c8d:3cb5 with SMTP id
 co30-20020a0560000a1e00b0021b8c8d3cb5mr5000863wrb.372.1657311269476; Fri, 08
 Jul 2022 13:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org> <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local> <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 8 Jul 2022 13:13:53 -0700
Message-ID: <CAJD7tkZ5mh87uO7jZg3hySe1sjFfHsE4xSSg_2SmzpPmwVcMDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, davem@davemloft.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Linux-MM <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 8, 2022 at 10:49 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
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
>

I think part of Michal's concern here is about memory sitting in
caches that is not yet used by any bpf allocation. I honestly didn't
look at the patches, so I don't know, but if the amount of cached
memory in the bpf allocator is significant then maybe it's worth
reclaiming it on memory pressure? Just thinking out loud.
