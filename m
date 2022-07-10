Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419456CD3E
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 07:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiGJF0i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 01:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGJF0h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 01:26:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF111821
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 22:26:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y8so2835112eda.3
        for <bpf@vger.kernel.org>; Sat, 09 Jul 2022 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDVEfSp7j7rrH6uZySTOAMFaVch8GzcV2oP+h15+4f8=;
        b=cxn6WxpddW8a//WEA6pE7C12C6F1ERJGrv0bGni1Ph1kWPMES/xL1TWmq7DejugUZF
         241NzEoIOoa6ImSMZ0i0PrcwcEm6mnrfUlabKrxgEeEXotYB7LxqDk9pujLFGVZ9v94Y
         VGpvoS0UycRf5bipul0BEVAFxsgISSmOVGloc/qqWZUjKYwEk5tu7szZOf1XsVlnbyUj
         Ohc7dnbGreDWxkM2C5CcAtW0cRgu4PDLwqVtV5igFl1FslPpIqpDlvxH9ytt37b11Iwl
         YIOeNbJy9vyZk5vKLmmwPnkiufvD3jET+L2fCR7I3ED+es3SdFD+z1HkI4/5rhZn6g4Z
         40wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDVEfSp7j7rrH6uZySTOAMFaVch8GzcV2oP+h15+4f8=;
        b=UCm6Wbt5rpzqcut0hqNcETkmQMoqhdeH9fjTUx9c3I/aT3RwQXdwss/bAnYvXF2fxw
         V49LSg+s7CqBrkVQEayjq8NJq3GwIBeUt6OdIWXQHACAVGh9QHn7716uIp/Q8q8jgUtI
         yubOK674fIiRUvnLfWq9IP69ydNic9PgxLMkwAA6QIYBzO1hTg2LLnBNSd14ckAHbSJb
         8S/wNkDjPHG6quoj1eSILg15mfDcWDkXQ+UNUzHOr1JPmSj6Oidw/j5QBr3lx4qFh1a0
         fOZBCoNUNlTez5JUVj0fa+d0VY9RWzb8Jf6in29hEJ0OrxgIyAXKgkSNh50iQv/sXQ9I
         +WkA==
X-Gm-Message-State: AJIora9ecCowcBMTiCLbpDPILSm4sSEN7+cjtkg+M3xVDeFlfmhtLPXK
        cSkScrM4plmsPrC1a4NE1UCbbUR1pbjtuGATqeRETX8Q
X-Google-Smtp-Source: AGRyM1uxxeQCHWO9HmlkE9+gADlTr7tNhUBrS31ALVHHvHblk78pqvMPm3x6PZDQqR/csmlv9AKRVKTUaz5FeCsPgo0=
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id
 n11-20020a05640205cb00b00434eb48754fmr16293468edx.421.1657430794424; Sat, 09
 Jul 2022 22:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
 <YrlWLLDdvDlH0C6J@infradead.org> <YsNOzwNztBsBcv7Q@casper.infradead.org>
 <20220706175034.y4hw5gfbswxya36z@MacBook-Pro-3.local> <YsXMmBf9Xsp61I0m@casper.infradead.org>
 <20220706180525.ozkxnbifgd4vzxym@MacBook-Pro-3.local.dhcp.thefacebook.com>
 <Ysg0GyvqUe0od2NN@dhcp22.suse.cz> <20220708174858.6gl2ag3asmoimpoe@macbook-pro-3.dhcp.thefacebook.com>
 <20220708215536.pqclxdqvtrfll2y4@google.com>
In-Reply-To: <20220708215536.pqclxdqvtrfll2y4@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 9 Jul 2022 22:26:23 -0700
Message-ID: <CAADnVQL5ZQDqMGULJLDwT9xRTihdDvo6GvwxdEOtSAs8EwE78A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 8, 2022 at 2:55 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Jul 08, 2022 at 10:48:58AM -0700, Alexei Starovoitov wrote:
> > On Fri, Jul 08, 2022 at 03:41:47PM +0200, Michal Hocko wrote:
> > > On Wed 06-07-22 11:05:25, Alexei Starovoitov wrote:
> > > > On Wed, Jul 06, 2022 at 06:55:36PM +0100, Matthew Wilcox wrote:
> > > [...]
> > > > > For example, I assume that a BPF program
> > > > > has a fairly tight limit on how much memory it can cause to be allocated.
> > > > > Right?
> > > >
> > > > No. It's constrained by memcg limits only. It can allocate gigabytes.
> > >
> > > I have very briefly had a look at the core allocator parts (please note
> > > that my understanding of BPF is really close to zero so I might be
> > > missing a lot of implicit stuff). So by constrained by memcg you mean
> > > __GFP_ACCOUNT done from the allocation context (irq_work). The complete
> > > gfp mask is GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_ACCOUNT
> > > which means this allocation is not allowed to sleep and GFP_ATOMIC
> > > implies __GFP_HIGH to say that access to memory reserves is allowed.
> > > Memcg charging code interprets this that the hard limit can be breached
> > > under assumption that these are rare and will be compensated in some
> > > way. The bulk allocator implemented here, however, doesn't reflect that
> > > and continues allocating as it sees a success so the breach of the limit
> > > is only bound by the number of objects to be allocated. If those can be
> > > really large then this is a clear problem and __GFP_HIGH usage is not
> > > really appropriate.
> >
> > That was a copy paste from the networking stack. See kmalloc_reserve().
> > Not sure whether it's a bug there or not.
>
> kmalloc_reserve() is good. Most of calls to kmalloc_reserve() are for
> skbs and we don't use __GFP_ACCOUNT for skbs. Actually skbs are charged
> to memcg through a separate interface (i.e. mem_cgroup_charge_skmem())
>
> > In a separate thread we've agreed to convert all of bpf allocations
> > to GFP_NOWAIT. For this patch set I've already fixed it in my branch.
> >
> > > Also, I do not see any tracking of the overall memory sitting in these
> > > pools and I think this would be really appropriate. As there doesn't
> > > seem to be any reclaim mechanism implemented this can hide quite some
> > > unreachable memory.
> > >
> > > Finally it is not really clear to what kind of entity is the life time
> > > of these caches bound to. Let's say the system goes OOM, is any process
> > > responsible for it and a clean up would be done if it gets killed?
> >
> > We've been asking these questions for years and have been trying to
> > come up with a solution.
> > bpf progs are not analogous to user space processes.
> > There are bpf progs that function completely without user space component.
> > bpf progs are pretty close to be full featured kernel modules with
> > the difference that bpf progs are safe, portable and users have
> > full visibility into them (source code, line info, type info, etc)
> > They are not binary blobs unlike kernel modules.
> > But from OOM perspective they're pretty much like .ko-s.
> > Which kernel module would you force unload when system is OOMing ?
> > Force unloading ko-s will likely crash the system.
> > Force unloading bpf progs maybe equally bad. The system won't crash,
> > but it may be a sorrow state. The bpf could have been doing security
> > enforcement or network firewall or providing key insights to critical
> > user space components like systemd or health check daemon.
> > We've been discussing ideas on how to rank and auto cleanup
> > the system state when progs have to be unloaded. Some sort of
> > destructor mechanism. Fingers crossed we will have it eventually.
> > bpf infra keeps track of everything, of course.
> > Technically we can detach, unpin and unload everything and all memory
> > will be returned back to the system.
> > Anyhow not a new problem. Orthogonal to this patch set.
> > bpf progs have been doing memory allocation from day one. 8 years ago.
> > This patch set is trying to make it 100% safe.
> > Currently it's 99% safe.
>
> Most probably Michal's comment was on free objects sitting in the caches
> (also pointed out by Yosry). Should we drain them on memory pressure /
> OOM or should we ignore them as the amount of memory is not significant?

Are you suggesting to design a shrinker for 0.01% of the memory
consumed by bpf?
And such drain would help... how?
