Return-Path: <bpf+bounces-3467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E5573E4FC
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 18:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CE01C20429
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA311CB0;
	Mon, 26 Jun 2023 16:28:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118311C90
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 16:28:35 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E068730CF
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 09:28:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98bcc533490so420854666b.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687796888; x=1690388888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b8sVgwcFMixS4QjaZV6QC5lTkLvbHHRKL0LWeobirjU=;
        b=Rwlcqq+jraOIILEHMaO1ETUqjpAak8CKZ0JdZbzXR73jvVEfULzP8B6w5QOrz0cpKo
         8jcjYsR05yiE4vdGUjIVDBymbvpD3jlym+dxRkT88JHNSCxIqIyS6f8gwE5GHeXnuJp/
         1hCVfLqVmLso8CYSBYVnzcnuu7BAtFpeJ6iEH3Fpf9+iDSyJnZpdqJhXMU/OYouhiA59
         2i2lol34LBdfE2aUJwXDtBV96rUXY6JPg5cdz8uiZc0UnNxcrUzykuYQtlh/GjY/f9th
         s+h0FbMpfhXszeMWHyDRqOq56Rwl0FshM6qKFGaQsGSxso8pNJ9TWNsEAMPZTUbTrams
         KBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796888; x=1690388888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8sVgwcFMixS4QjaZV6QC5lTkLvbHHRKL0LWeobirjU=;
        b=HvBehmxdintb7/bu0sw7vJ5p1fpmIQXiKVAINgkF7R96bISHkPC0DUHtxUNZUzzgeA
         893Lez3DF5EVVjpxm2Zmar991YRSCaTlCKor/w+swACn1MRHfG3P2akaJGP/YI+B8Ho7
         FNedMXsDiO8v11H5Qi5aOr+d75CdUaA3vxjHqUvMG/5eZ+JxkOcGxxsD7mRbER60Ur4h
         bPVHzH2e1+/NsbW+MhXdmVVRE3hFzdfDcPT+1fD04OzKZEpoPVFVrY3fBnMgNLMXeO7E
         R9GV+Xsp29HHzeztAVCSWXmVCUkEK7zeop98KBKBjYyamBlbZoSbmjzKQKFfmAbk3djU
         Lo/g==
X-Gm-Message-State: AC+VfDysZ/xf35cJZGmZlAIGDf69oEr0ahlNkEz6x9zk9vUXnnq9sypG
	ARIGZ2dP/+HZUzaad5w4y2noeqlE0qz3RVytzEvkvw==
X-Google-Smtp-Source: ACHHUZ4c7B34oD2/auDTj7qAJk1GJCbYAHqjYILHylEfr8vajSbghWm6XOAcwxlQV64rKV9Uvsw90w==
X-Received: by 2002:a17:907:c1b:b0:991:fd87:c6fd with SMTP id ga27-20020a1709070c1b00b00991fd87c6fdmr409788ejc.23.1687796888047;
        Mon, 26 Jun 2023 09:28:08 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906578b00b0098e34446464sm2275299ejq.25.2023.06.26.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:28:07 -0700 (PDT)
Date: Mon, 26 Jun 2023 16:29:16 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
	Joe Stringer <joe@isovalent.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZJm83NTmkogNd3JP@zh-lab-node-5>
References: <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
 <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
 <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
 <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
 <CAADnVQ+FzCiQLbFaJihr8tuJXxjFNZqYs75cyhSDjds8nYBj4A@mail.gmail.com>
 <ZHn64W6ggfTyzW/U@zh-lab-node-5>
 <CAADnVQLn2hxXPXbmPXMn4G6=jCBd6Xmty7RO2bY+S-GiS8NJ6w@mail.gmail.com>
 <6496320f40706_7b3662086f@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6496320f40706_7b3662086f@john.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 05:00:15PM -0700, John Fastabend wrote:
> Alexei Starovoitov wrote:
> > On Fri, Jun 2, 2023 at 7:20 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > >
> > > On Thu, Jun 01, 2023 at 05:40:10PM -0700, Alexei Starovoitov wrote:
> > > > On Thu, Jun 1, 2023 at 11:24 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jun 1, 2023 at 11:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > > >
> > > > > > > LRU logic doesn't kick in until the map is full.
> > > > > >
> > > > > > In fact, it can: a reproducable example is in the self-test from this patch
> > > > > > series. In the test N threads try to insert random values for keys 1..3000
> > > > > > simultaneously. As the result, the map may contain any number of elements,
> > > > > > typically 100 to 1000 (never full 3000, which is also less than the map size).
> > > > > > So a user can't really even closely estimate the number of elements in the LRU
> > > > > > map based on the number of updates (with unique keys). A per-cpu counter
> > > > > > inc/dec'ed from the kernel side would solve this.
> > > > >
> > > > > That's odd and unexpected.
> > > > > Definitely something to investigate and fix in the LRU map.
> > > > >
> > > > > Pls cc Martin in the future.
> > > > >
> > > > > > > If your LRU map is not full you shouldn't be using LRU in the first place.
> > > > > >
> > > > > > This makes sense, yes, especially that LRU evictions may happen randomly,
> > > > > > without a map being full. I will step back with this patch until we investigate
> > > > > > if we can replace LRUs with hashes.
> > > > > >
> > > > > > Thanks for the comments!
> > > >
> > > > Thinking about it more...
> > > > since you're proposing to use percpu counter unconditionally for prealloc
> > > > and percpu_counter_add_batch() logic is batched,
> > > > it could actually be acceptable if it's paired with non-api access.
> > > > Like another patch can add generic kfunc to do __percpu_counter_sum()
> > > > and in the 3rd patch kernel/bpf/preload/iterators/iterators.bpf.c
> > > > for maps can be extended to print the element count, so the user can have
> > > > convenient 'cat /sys/fs/bpf/maps.debug' way to debug maps.
> > > >
> > > > But additional logic of percpu_counter_add_batch() might get in the way
> > > > of debugging eventually.
> > > > If we want to have stats then we can have normal per-cpu u32 in basic
> > > > struct bpf_map that most maps, except array, will inc/dec on update/delete.
> > > > kfunc to iterate over percpu is still necessary.
> > > > This way we will be able to see not only number of elements, but detect
> > > > bad usage when one cpu is only adding and another cpu is deleting elements.
> > > > And other cpu misbalance.
> > >
> > > This looks for me like two different things: one is a kfunc to get the current
> > > counter (e.g., bpf_map_elements_count), the other is a kfunc to dump some more
> > > detailed stats (e.g., per-cpu values or more).
> > >
> > > My patch, slightly modified, addresses the first goal: most maps of interest
> > > already have a counter in some form (sometimes just atomic_t or u64+lock). If
> > > we add a percpu (non-batch) counter for pre-allocated hashmaps, then it's done:
> > > the new kfunc can get the counter based on the map type.
> > >
> > > If/when there's need to provide per-cpu statistics of elements or some more
> > > sophisticated statistics, this can be done without changing the api of the
> > > bpf_map_elements_count() kfunc.
> > >
> > > Would this work?
> > 
> > No, because bpf_map_elements_count() as a building block is too big
> > and too specific. Nothing else can be made out of it, but counting
> > elements.
> > "for_each_cpu in per-cpu variable" would be generic that is usable beyond
> > this particular use case of stats collection.
> 
> Without much thought, could you hook the eviction logic in LRU to know
> when the evict happens and even more details about what was evicted so
> we could debug the random case where we evict something in a conntrack
> table and then later it comes back to life and sends some data like a
> long living UDP session.
> 
> For example in the cases where you build an LRU map because in 99%
> cases no evictions happen and the LRU is just there as a backstop
> you might even generate events to userspace to let it know evicts
> are in progress and they should do something about it.

Yes, one can trace evictions, as the destructor function for lru_list is
noinline. An example here: https://github.com/aspsk/bcc/tree/aspsk/lrusnoop

One problem with evictions and LRU is that evictions can [currently] happen at
random times even if map is nearly emptee, see a new map test from this series
and also https://lore.kernel.org/bpf/ZHjhBFLLnUcSy9Tt@zh-lab-node-5/ So for LRU
we really need to invest more time. For hashtabs and other maps the
bpf_map_sum_elem_count is in any case quite useful.

> Thanks,
> John

