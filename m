Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E45A875A
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiHaUNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiHaUNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 16:13:09 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CCEF9F9
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 13:13:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e195so6914110iof.1
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XExJH8KYgaSSaE3UxubyGHLrA3z5C5BBr/Zu+HEXR6k=;
        b=JPVE5ONnpLdPSNQrMB6q56hPL8DtQ8ohNOVztSqWEgqmJ2bb/PRAb7n7vMn7fUn0/5
         yM/3sxvxHK4KLDMUOguE2DwVhFmbcQmpaiOvzl5MbL/86IehTv53U4FmxmaxY5Mheh6h
         E5rG//gpP0cia2ubLe+j3W6gGdgWMoRZH4JtmCQCwPxTOEF7Qo0TJS0QzUUsStscJ4xq
         UeDVHJPCxh/8PzO1JCWlZAX2uvO9SpZ2huvU6ryRVCBigsLygU8MnaiLCvCYZVybJKxA
         tMh9teMmaVb0Su7MnoFfr0FE04GqwlT/hUQ9RMkIZxlaxdIInuYpTUmhmj9f0DLIBScL
         KA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XExJH8KYgaSSaE3UxubyGHLrA3z5C5BBr/Zu+HEXR6k=;
        b=XWfPr7+c4QucGMnjdun74A5EZWAiCA4nHxukl7C1iseyDkFuoFfUtwH1IYshTfm6mL
         HGJUjp2Ynr+958loBHfLNMYrCsS/DIRozbpJjPhkCFTfV2C3eZfHEsIH2ipUdq7yb1Zt
         Sd55JQhFlkjdhHvDnyFAoY0qagjauYJBSg3IODSS+U2/pyVBeJi5iEJ2Tx97TX8h4WzR
         c4wkrsRmIZmQANmjlfFZi9b1GzMLCKOl4B+McwuolZQI5bI/HL4uPlmGR8haLuAtVgB5
         H3rOzbpi2640IEPIwCgRnLgr9rK7YXF3I8cfuYgTUfVfpPyboYQSY7LN01zbUXyKY0kD
         qh5Q==
X-Gm-Message-State: ACgBeo1EWXzeS5sDqNd9k5zZ8w94jANTq7qXgpO8dTi8wywy4pcT5ayZ
        MOf49b9u64lWEf9bFYTcYxZnzttWNvNRAmcfR44=
X-Google-Smtp-Source: AA6agR5xSYYYwKL2LdkUDL1GQVOL9z/VkzwjVXQFk266FiJl5Q9s28aeZGkxdjNkeCMiT6JlQjEcJwd8ON82BeBAFEw=
X-Received: by 2002:a05:6638:2388:b0:34a:e033:396b with SMTP id
 q8-20020a056638238800b0034ae033396bmr4121988jat.93.1661976785909; Wed, 31 Aug
 2022 13:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLXji_sK8rURTeJJzoM4E40iXNKeEwfK-bB-CMUZcz90Q@mail.gmail.com>
 <CAP01T746jPM1r=fSVJBG-iW=pQAW8JAzLzocnB_GDkb3HKZ+Aw@mail.gmail.com>
 <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
 <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com> <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com> <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com> <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
In-Reply-To: <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 31 Aug 2022 22:12:28 +0200
Message-ID: <CAP01T74DmLywK30a9_9mK6wcXA_u9CuycHfPcGQ-LVCxYz_y5A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Wed, 31 Aug 2022 at 20:57, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 31, 2022 at 05:38:15PM +0000, Delyan Kratunov wrote:
> >
> > Overall, this design (or maybe the way it's presented here) conflates a few ideas.
> >
> > 1) The extensions to expose and customize map's internal element allocator are fine
> > independently of even this patchset.
> >
> > 2) The idea that kptrs in a map need to have a statically identifiable allocator is
> > taken as an axiom, and then expanded to its extreme (single allocator per map as
> > opposed to the smarter verifier schemes). I still contest that this is not the case
> > and the runtime overhead it avoids is paid back in bad developer experience multiple
> > times over.
> >
> > 3) The idea that allocators can be merged between elements and kptrs is independent
> > of the static requirements. If the map's internal allocator is exposed per 1), we can
> > still use it to allocate kptrs but not require that all kptrs in a map are from the
> > same allocator.
> >
> > Going this coarse in the API is easy for us but fundamentally more limiting for
> > developers. It's not hard to imagine situations where the verifier dependency
> > tracking or runtime lifetime tracking would allow for pinned maps to be retained but
> > this scheme would require new maps entirely. (Any situation where you just refactored
> > the implicit allocator out to share it, for example)
> >
> > I also don't think that simplicity for us (a one time implementation cost +
> > continuous maintenance cost) trumps over long term developer experience (a much
> > bigger implementation cost over a much bigger time span).
>
> It feels we're thinking about scope and use cases for the allocator quite
> differently and what you're seeing as 'limiting developer choices' to me looks
> like 'not a limiting issue at all'. To me the allocator is one

I went over the proposal multiple times, just to make sure I
understood it properly, but I still can't see this working ideally for
the inner map case, even if we ignore the rest of the things for a
moment.
But maybe you prefer to just forbid them there? Please correct me if I'm wrong.

You won't be able to know the allocator statically for inner maps (and
hence not be able to enforce the kptr_xchg requirement to be from the
same allocator as map). To know it, we will have to force all
inner_maps to use the same allocator, either the one specified for
inner map fd, or the one in map-in-map definition, or elsewhere. But
to be able to know it statically the information will have to come
from map-in-map somehow.

That seems like a very weird limitation just to use local kptrs, and
doesn't even make sense for map-in-map use cases IMO.
And unless I'm missing something there isn't an easy way to
accommodate it in the 'statically known allocator' proposal, because
such inner_map allocators (and inner_maps) are themselves not static.

> jemalloc/tcmalloc instance. One user space application with multiple threads,
> lots of maps and code is using exactly one such allocator. The allocator
> manages all the memory of user space process. In bpf land we don't have a bpf
> process. We don't have a bpf name space either.  A loose analogy would be a set
> of programs and maps managed by one user space agent. The bpf allocator would
> manage all the memory of these maps and programs and provide a "memory namespace"
> for this set of programs. Another user space agent with its own programs
> would never want to share the same allocator. In user space a chunk of memory
> could be mmap-ed between different process to share the data, but you would never
> put a tcmalloc over such memory to be an allocator for different processes.
>

But just saying "would never" or "should never" doesn't work right?
Hyrum's law and all.

libbpf style "bpf package" deployments may not be the only consumers
of this infra in the future. So designing around this specific idea
that people will never or shouldn't dynamically share their allocator
objects between maps which don't share the same allocator seems
destined to only serve us in the short run IMO.

People may come up with cases where they are passing ownership of
objects between such bpf packages, and after coming up with multiple
examples before it doesn't seem likely static dependencies will be
able to capture such dynamic runtime relationships, e.g. static
dependencies don't even work in the inner_map case without more
restrictions.

> More below.
>
> > So far, my ranked choice vote is:
> >
> > 1) maximum flexibility and runtime live object counts (with exposed allocators, I
> > like the merging)
> > 2) medium flexibility with per-field allocator tracking in the verifier and the
> > ability to lose the association once programs are unloaded and values are gone. This
> > also works better with exposed allocators since they are implicitly pinned and would
> > be usable to store values in another map.
> > 3) minimum flexibility with static whole-map kptr allocators
>
> The option 1 flexibility is necessary when allocator is seen as a private pool
> of objects of given size. Like kernel's kmem_cache instance.
> I don't think we quite there yet.
> There is a need to "preallocate this object from sleepable context,
> so the prog has a guaranteed chunk of memory to use in restricted context",
> but, arguably, it's not a job of bpf allocator. bpf prog can allocate an object,
> stash it into kptr, and use it later.

At least if not adding support for it all now, I think this kind of
flexibility in option 1 needs to be given some more consideration, as
in whether this proposal to encode things statically would be able to
accommodate such cases in the future. To me it seems pretty hard (and
unless I missed something, it already won't work for inner_maps case
without requiring all to use the same allocator).

We might actually be able to do a hybrid of the options by utilizing
the statically known allocator info to acquire references and runtime
object counts, which may help eliminate/delay the actual cost we pay
for it - the atomic upgrade, when initial reference goes away.

So I think I lean towards option 1 as well, and then the same order as
Delyan. It seems to cover all kinds of corner cases (allocator known
vs unknown, normal vs inner maps, etc.) we've been going over in this
thread, and would also be future proof in terms of permitting
unforeseen patterns of usage.

> So option 3 doesn't feel less flexible to me. imo the whole-map-allocator is
> more than we need. Ideally it would be easy to specifiy one single
> allocator for all maps and progs in a set of .c files. Sort-of a bpf package.
> In other words one bpf allocator per bpf "namespace" is more than enough.
> Program authors shouldn't be creating allocators left and right. All these
> free lists will waste memory.
> btw I've added an extra patch to bpf_mem_alloc series:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=memalloc&id=6a586327a270272780bdad7446259bbe62574db1
> that removes kmem_cache usage.
> Turned out (hindsight 20/20) kmem_cache for each bpf map was a bad idea.
> When free_lists are not shared they will similarly waste memory.
> In user space the C code just does malloc() and the memory is isolated per process.
> Ideally in bpf world the programs would just do:
> bpf_mem_alloc(btf_type_id_local(struct foo));
> without specifying an allocator, but that would require one global allocator
> for all bpf programs in the kernel which is probably not a direction we should go ?
> So the programs have to specify an allocator to use in bpf_mem_alloc(),
> but it should be one for all progs, maps in a bpf-package/set/namespace.|

But "all progs" doesn't mean all of them are running in the same
context and having the same kinds of memory allocation requirements,
right? While having too many allocators is also bad, having just one
single one per package would also be limiting. A bpf object/package is
very different from a userspace process. So the analogy doesn't
exactly fit IMO.



> If it's easy for programs to specify a bunch of allocators, like one for each program,
> or one for each btf_type_id the bpf kernel infra would be required to merge
> these allocators from day one. (The profileration of kmem_cache-s in the past
> forced merging of them). By restricting bpf program choices with allocator-per-map
> (this option 3) we're not only making the kernel side to do less work
> (no run-time ref counts, no merging is required today), we're also pushing
> bpf progs to use memory concious choices.
> Having said all that maybe one global allocator is not such a bad idea.
