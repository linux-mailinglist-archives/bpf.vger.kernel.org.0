Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78B5A861F
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 20:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiHaS5Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiHaS5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 14:57:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F971998
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 11:57:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so13114101plb.2
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=M32XVkCpgPHTKJtQKsoq41/TkkNzAt3eZw8fskIsdmc=;
        b=pmgjkAy9BDFOniFkwbgTQAb1fBAXuJ1ciJ+8CAJTkKcJL1ZqSpgxsYMcyPJDuLfs9I
         C1uxbhz9sHQGeZK7C2SSg8BJ8/v2XM3JLmFKYzmVR1fpP4cRkMTlGKVvJjQ+aqOfqUWG
         Vvw5ooNvXXiT2F47fYxYPl9no4onwn5lPIl+FjucQ5AL7CEA+GHsX/H6DDI7prTbER0O
         ZYsYb+RdspejDGzq2nQCCFktmh9b+WuvtNNp+/P1AkPhsI9XUAe6k0iHEjp5FCTSMJvP
         aCtra4yrcDn00U0ua64WEMIid+4UiHrvM21uHO9FLfvz8wmrAAvXMGXKaZboIQK7/sVL
         qcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=M32XVkCpgPHTKJtQKsoq41/TkkNzAt3eZw8fskIsdmc=;
        b=1EWQzGruhVA61E2WR+nnDMqg8FhNX+7IBEQkX4HE1OdJFHrkfzzyLGugkmWifIBtiv
         Bi1HqaEWld8x0D1C5bd8VVPXl/9CWsPFNElVBrKZlaoXd8dqgjamJMXeZfgBt8d1/xra
         WSjC4dSe3pU7CqReuOSOgaFDGjUpnvaNDkKqyIg6bWWFUxEl1MugfBj+LPVjLXIrYh/6
         h74HEOMsE5CPJCdknFwYcvW7zr3eNBpDKRTA7HwN+dw4oAImItWNhV8fjD7sB/TXUR1w
         6vlZg93pngV+31cpFfOycLeoQZbaH4Iy/+bocT+N3OVL9/AmwTctBXkYqBW6qrgMy9Rw
         hm6Q==
X-Gm-Message-State: ACgBeo1ubFNWR9uydg4Hwx05jbc8ZBKalo2VLNuedS18CwAm6BCxfgyc
        jiSPYbV1zh0nePZUnz1egxUPj8rXZCQ=
X-Google-Smtp-Source: AA6agR4XVVkCQ+2neH6McT9xFz+b0jcBlFzdh+r4IH7bbwS7aOQivzmAs3eJX8sYTN7ID7CFvMj6bA==
X-Received: by 2002:a17:902:8643:b0:172:e067:d7ac with SMTP id y3-20020a170902864300b00172e067d7acmr27221500plt.164.1661972234282;
        Wed, 31 Aug 2022 11:57:14 -0700 (PDT)
Received: from MacBook-Pro-4.local.dhcp.thefacebook.com ([2620:10d:c090:500::2f0d])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902a50700b0016db43e5212sm9614024plq.175.2022.08.31.11.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:57:13 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:57:10 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        "memxor@gmail.com" <memxor@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Message-ID: <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
References: <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
 <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
 <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
 <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com>
 <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com>
 <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 31, 2022 at 05:38:15PM +0000, Delyan Kratunov wrote:
> 
> Overall, this design (or maybe the way it's presented here) conflates a few ideas.
> 
> 1) The extensions to expose and customize map's internal element allocator are fine
> independently of even this patchset.
> 
> 2) The idea that kptrs in a map need to have a statically identifiable allocator is
> taken as an axiom, and then expanded to its extreme (single allocator per map as
> opposed to the smarter verifier schemes). I still contest that this is not the case
> and the runtime overhead it avoids is paid back in bad developer experience multiple
> times over.
> 
> 3) The idea that allocators can be merged between elements and kptrs is independent
> of the static requirements. If the map's internal allocator is exposed per 1), we can
> still use it to allocate kptrs but not require that all kptrs in a map are from the
> same allocator.
> 
> Going this coarse in the API is easy for us but fundamentally more limiting for
> developers. It's not hard to imagine situations where the verifier dependency
> tracking or runtime lifetime tracking would allow for pinned maps to be retained but
> this scheme would require new maps entirely. (Any situation where you just refactored
> the implicit allocator out to share it, for example)
> 
> I also don't think that simplicity for us (a one time implementation cost +
> continuous maintenance cost) trumps over long term developer experience (a much
> bigger implementation cost over a much bigger time span).

It feels we're thinking about scope and use cases for the allocator quite
differently and what you're seeing as 'limiting developer choices' to me looks
like 'not a limiting issue at all'. To me the allocator is one
jemalloc/tcmalloc instance. One user space application with multiple threads,
lots of maps and code is using exactly one such allocator. The allocator
manages all the memory of user space process. In bpf land we don't have a bpf
process. We don't have a bpf name space either.  A loose analogy would be a set
of programs and maps managed by one user space agent. The bpf allocator would
manage all the memory of these maps and programs and provide a "memory namespace"
for this set of programs. Another user space agent with its own programs
would never want to share the same allocator. In user space a chunk of memory
could be mmap-ed between different process to share the data, but you would never
put a tcmalloc over such memory to be an allocator for different processes.

More below.

> So far, my ranked choice vote is:
> 
> 1) maximum flexibility and runtime live object counts (with exposed allocators, I
> like the merging)
> 2) medium flexibility with per-field allocator tracking in the verifier and the
> ability to lose the association once programs are unloaded and values are gone. This
> also works better with exposed allocators since they are implicitly pinned and would
> be usable to store values in another map.
> 3) minimum flexibility with static whole-map kptr allocators

The option 1 flexibility is necessary when allocator is seen as a private pool
of objects of given size. Like kernel's kmem_cache instance.
I don't think we quite there yet.
There is a need to "preallocate this object from sleepable context,
so the prog has a guaranteed chunk of memory to use in restricted context",
but, arguably, it's not a job of bpf allocator. bpf prog can allocate an object,
stash it into kptr, and use it later.
So option 3 doesn't feel less flexible to me. imo the whole-map-allocator is
more than we need. Ideally it would be easy to specifiy one single
allocator for all maps and progs in a set of .c files. Sort-of a bpf package.
In other words one bpf allocator per bpf "namespace" is more than enough.
Program authors shouldn't be creating allocators left and right. All these
free lists will waste memory.
btw I've added an extra patch to bpf_mem_alloc series:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=memalloc&id=6a586327a270272780bdad7446259bbe62574db1
that removes kmem_cache usage.
Turned out (hindsight 20/20) kmem_cache for each bpf map was a bad idea.
When free_lists are not shared they will similarly waste memory.
In user space the C code just does malloc() and the memory is isolated per process.
Ideally in bpf world the programs would just do:
bpf_mem_alloc(btf_type_id_local(struct foo));
without specifying an allocator, but that would require one global allocator
for all bpf programs in the kernel which is probably not a direction we should go ?
So the programs have to specify an allocator to use in bpf_mem_alloc(),
but it should be one for all progs, maps in a bpf-package/set/namespace.
If it's easy for programs to specify a bunch of allocators, like one for each program,
or one for each btf_type_id the bpf kernel infra would be required to merge
these allocators from day one. (The profileration of kmem_cache-s in the past
forced merging of them). By restricting bpf program choices with allocator-per-map
(this option 3) we're not only making the kernel side to do less work
(no run-time ref counts, no merging is required today), we're also pushing
bpf progs to use memory concious choices.
Having said all that maybe one global allocator is not such a bad idea.
