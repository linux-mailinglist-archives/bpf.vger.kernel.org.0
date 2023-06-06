Return-Path: <bpf+bounces-1919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B925723A68
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 09:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E5D1C20E68
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 07:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFA3261E8;
	Tue,  6 Jun 2023 07:49:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260B611C
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 07:49:25 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F01999
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 00:49:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f73617a292so27056555e9.2
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686037741; x=1688629741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YST36F3T2a0EYS5JoFcBh6dF0NZBbp01SiQzk4kVoOI=;
        b=YQ1P1UWEd1OxboSuhPt3FAxF1lJHfo54dG7KEpPdoz6VHnGdoIAYHwVK4hd2mwxMpD
         sMzW/A3Kj2zcofTeey8rW63981upvNMmcXGG6XAo4J2LwZYmmW1/AzzaDPfj/tkOqEZr
         /ijenkIB6Iu1gL+CCYoqLcZPsu9CQ/jzIySaqAoXJ2H2nV2ar0oSscc1QLJ+DnHcdzTC
         zTQjJSSst+YByfMxsQ72k3iOvZLmymJDhHhCjwU1obR6+HBrwAJNR+kr1PmMVldfh5T6
         n+8aYUszoQnaQpuReWSihj/9B9ZPri/y3tAoIOhVwyuFtZ8tLP5m+ArmhTx9AzWvFnNM
         MOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037741; x=1688629741;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YST36F3T2a0EYS5JoFcBh6dF0NZBbp01SiQzk4kVoOI=;
        b=gopHUBfQh2rb7ENWaxeZjuXA+AFUIXupNSMlQRlLtZ4S+lUn7m2lgcAkLskp6DKV43
         5YJYm/7eW602vNL6bQuD8IJw+ugXX90af40q6hHf5/o7tiIcgHO2wZEEaa2IDqqvAhoI
         Wv6uDa0HoPNQWnufD83tBcFfQWc4AHnJqio6Bjh6JS+sBZyjLUI5xxUB1k7KCmN9rYUd
         EGnmVSkrQYWblcgLncqFN3lerlk5/1te0+iizTpatCsRpAvwJ3k+Bxt2HFdLdy6DR9+M
         2SaXR5vIcLpDd9FPm+mWmP1MDTppccdlf4/ty7/LEvZQpFfM5D1rONA8ierIshPy+vJN
         iH7g==
X-Gm-Message-State: AC+VfDwlawyt+NIesfmz1D89gsu+T21jiSYrZ3EV6yq5MSMXCGjdMMGf
	PCXVqrmGlkdV/eUad/L3tP4rirOqCdoa/DGzNuZDpA==
X-Google-Smtp-Source: ACHHUZ45Zl/dp8uJkFxRr4XbGk5apY6lbPnvwFnfAxCoDFVhTntXJXqJzHPp5Au/9i0d+cD3jn5dqA==
X-Received: by 2002:adf:f9d0:0:b0:30a:f399:4b1 with SMTP id w16-20020adff9d0000000b0030af39904b1mr1184895wrr.49.1686037740823;
        Tue, 06 Jun 2023 00:49:00 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600010c900b0030ae87bd3e3sm11810053wrx.18.2023.06.06.00.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:49:00 -0700 (PDT)
Date: Tue, 6 Jun 2023 07:49:47 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZH7lGyo61gb/4lve@zh-lab-node-5>
References: <20230531110511.64612-1-aspsk@isovalent.com>
 <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
 <ZHhJUN7kQuScZW2e@zh-lab-node-5>
 <CAADnVQ+67FF=JsxTDxoo2XL8zSh5Y3xptGee8vBj8OwP3b=aew@mail.gmail.com>
 <ZHjhBFLLnUcSy9Tt@zh-lab-node-5>
 <CAADnVQLXFyhACfZP3bze8PUa43Fnc-Nn_PDGYX2vOq3i8FqKbA@mail.gmail.com>
 <CAADnVQ+FzCiQLbFaJihr8tuJXxjFNZqYs75cyhSDjds8nYBj4A@mail.gmail.com>
 <ZHn64W6ggfTyzW/U@zh-lab-node-5>
 <CAADnVQLn2hxXPXbmPXMn4G6=jCBd6Xmty7RO2bY+S-GiS8NJ6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLn2hxXPXbmPXMn4G6=jCBd6Xmty7RO2bY+S-GiS8NJ6w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 02, 2023 at 09:23:11AM -0700, Alexei Starovoitov wrote:
> On Fri, Jun 2, 2023 at 7:20 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On Thu, Jun 01, 2023 at 05:40:10PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Jun 1, 2023 at 11:24 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Jun 1, 2023 at 11:17 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > >
> > > > > > LRU logic doesn't kick in until the map is full.
> > > > >
> > > > > In fact, it can: a reproducable example is in the self-test from this patch
> > > > > series. In the test N threads try to insert random values for keys 1..3000
> > > > > simultaneously. As the result, the map may contain any number of elements,
> > > > > typically 100 to 1000 (never full 3000, which is also less than the map size).
> > > > > So a user can't really even closely estimate the number of elements in the LRU
> > > > > map based on the number of updates (with unique keys). A per-cpu counter
> > > > > inc/dec'ed from the kernel side would solve this.
> > > >
> > > > That's odd and unexpected.
> > > > Definitely something to investigate and fix in the LRU map.
> > > >
> > > > Pls cc Martin in the future.
> > > >
> > > > > > If your LRU map is not full you shouldn't be using LRU in the first place.
> > > > >
> > > > > This makes sense, yes, especially that LRU evictions may happen randomly,
> > > > > without a map being full. I will step back with this patch until we investigate
> > > > > if we can replace LRUs with hashes.
> > > > >
> > > > > Thanks for the comments!
> > >
> > > Thinking about it more...
> > > since you're proposing to use percpu counter unconditionally for prealloc
> > > and percpu_counter_add_batch() logic is batched,
> > > it could actually be acceptable if it's paired with non-api access.
> > > Like another patch can add generic kfunc to do __percpu_counter_sum()
> > > and in the 3rd patch kernel/bpf/preload/iterators/iterators.bpf.c
> > > for maps can be extended to print the element count, so the user can have
> > > convenient 'cat /sys/fs/bpf/maps.debug' way to debug maps.
> > >
> > > But additional logic of percpu_counter_add_batch() might get in the way
> > > of debugging eventually.
> > > If we want to have stats then we can have normal per-cpu u32 in basic
> > > struct bpf_map that most maps, except array, will inc/dec on update/delete.
> > > kfunc to iterate over percpu is still necessary.
> > > This way we will be able to see not only number of elements, but detect
> > > bad usage when one cpu is only adding and another cpu is deleting elements.
> > > And other cpu misbalance.
> >
> > This looks for me like two different things: one is a kfunc to get the current
> > counter (e.g., bpf_map_elements_count), the other is a kfunc to dump some more
> > detailed stats (e.g., per-cpu values or more).
> >
> > My patch, slightly modified, addresses the first goal: most maps of interest
> > already have a counter in some form (sometimes just atomic_t or u64+lock). If
> > we add a percpu (non-batch) counter for pre-allocated hashmaps, then it's done:
> > the new kfunc can get the counter based on the map type.
> >
> > If/when there's need to provide per-cpu statistics of elements or some more
> > sophisticated statistics, this can be done without changing the api of the
> > bpf_map_elements_count() kfunc.
> >
> > Would this work?
> 
> No, because bpf_map_elements_count() as a building block is too big
> and too specific. Nothing else can be made out of it, but counting
> elements.
> "for_each_cpu in per-cpu variable" would be generic that is usable beyond
> this particular use case of stats collection.

Thanks. I will prepare a v2 with a "no-uapi percpu" version.

