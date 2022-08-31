Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D65A8796
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiHaUiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 16:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiHaUiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 16:38:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ECDE3427
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 13:38:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u22so15188329plq.12
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=m835Cdlao6Y/uCATxVDguiUQICmUcN+5heQIBkece5k=;
        b=OUb78otg8npEqcUwjS6trMljJdmVMZRYgzKS6i9TXXPHZXkPkz7VVO3LlM4D/3+fqK
         dZkmYgItQ0PO6wD5AGeikihGqvqJTzjhwYCEZ0P6/1vebmSpbaXKHVjD1FCU7xtquNmq
         zQ55js2sqk/DWm9MnBCe8esnS3XUMkkVKadR7J0eBZwfB+sxz8zBcy19kwbHPQlI5TYO
         GDyNn+7VQITI90CIBap6F3ODB+UsrHwRPmH5ikpj+ttIiheDGsy/IygYOhm5ljDeEYWv
         WjHXxg7jRf2TLvpTjyqs2t/puBrY2UdRxQ5Qe8FgrcIW2m+URN/vjYySSjG5bJqlgwqa
         83vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=m835Cdlao6Y/uCATxVDguiUQICmUcN+5heQIBkece5k=;
        b=ifVaVMzGgw28HJIfeb6aoMqKG/3fEYXaJQlIikkfAxH82PQkeUG4tNFrXoVsPkrroU
         kDv89BG9Y23xfwmaQVX2i/Z0bSVOtgv0hyt5kEGb1qHE29kO8r+5HQ3pcVDDJz3jw59X
         //1wh4H/cJey+mDSz45SRwyfMCQilS8ChN5ptVejSA+AsKsAWOWHfPL6cOUbggywE5ov
         TECwU3O84wL1ctoQ6rTWkUPGyRYRow/4QeXLTw8VK21RtcikeQfVu5sMQWII5ymsnsO8
         Nh4RBv0eJHgPHo+V0r5AzaDduJVGhOzLZfnaQ3fHwBCSi2lJHmkeAoNA7aMlACVWFcdC
         vOuA==
X-Gm-Message-State: ACgBeo0Zak2HDmwoRW57XG4UK7jvP18Hk4MnsZFJnW/DLPr5qLyw4Ib3
        EaJdShJO/WDn6DJ/KSu1xR4=
X-Google-Smtp-Source: AA6agR5omwbVAKj5hU0MxppNdlxdTj3wUS+bN69B+i2R15z+Y+KOS7cJnI8QUGm3jcnBNOf75G3JEw==
X-Received: by 2002:a17:90a:1b6e:b0:1f5:1902:af92 with SMTP id q101-20020a17090a1b6e00b001f51902af92mr5099671pjq.238.1661978294120;
        Wed, 31 Aug 2022 13:38:14 -0700 (PDT)
Received: from MacBook-Pro-4.local.dhcp.thefacebook.com ([2620:10d:c090:500::2f0d])
        by smtp.gmail.com with ESMTPSA id c73-20020a621c4c000000b00536779d43e7sm11610917pfc.201.2022.08.31.13.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:38:13 -0700 (PDT)
Date:   Wed, 31 Aug 2022 13:38:11 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>, "tj@kernel.org" <tj@kernel.org>,
        "joannelkoong@gmail.com" <joannelkoong@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator,
 UAPI in particular
Message-ID: <20220831203811.znkj26df3bftyx33@MacBook-Pro-4.local.dhcp.thefacebook.com>
References: <CAADnVQKAG80STa=iHTBT8NpQWBw=3Hs8nRwq6Vy=zOLjP8YHqw@mail.gmail.com>
 <1e05c903cc12d3dd9e53cb96698a18d12d8c6927.camel@fb.com>
 <CAADnVQJUTybKJQ=2jR4UjjC_8yom_B7cWAOGEWDDRcoJSZJ7AQ@mail.gmail.com>
 <CAP01T76N+6cRMNM=hEKwVkhrjSv5cuzp7F-uT3WEa710Ry5Tdg@mail.gmail.com>
 <CAADnVQLZaJmNyvQKvzG0ezfgPO9P+zG+WKk0cfdEgT3cqF3dZw@mail.gmail.com>
 <73ec48e4c4956d97744b17d77d61392f7227b78d.camel@fb.com>
 <20220831015247.lf3quucbhg53dxts@macbook-pro-4.dhcp.thefacebook.com>
 <094a932af88d5e0a7e0ceb895ec9b2ad640a4f71.camel@fb.com>
 <20220831185710.pngpynntwvjrmm6g@MacBook-Pro-4.local.dhcp.thefacebook.com>
 <CAP01T74DmLywK30a9_9mK6wcXA_u9CuycHfPcGQ-LVCxYz_y5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74DmLywK30a9_9mK6wcXA_u9CuycHfPcGQ-LVCxYz_y5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 31, 2022 at 10:12:28PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Wed, 31 Aug 2022 at 20:57, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Aug 31, 2022 at 05:38:15PM +0000, Delyan Kratunov wrote:
> > >
> > > Overall, this design (or maybe the way it's presented here) conflates a few ideas.
> > >
> > > 1) The extensions to expose and customize map's internal element allocator are fine
> > > independently of even this patchset.
> > >
> > > 2) The idea that kptrs in a map need to have a statically identifiable allocator is
> > > taken as an axiom, and then expanded to its extreme (single allocator per map as
> > > opposed to the smarter verifier schemes). I still contest that this is not the case
> > > and the runtime overhead it avoids is paid back in bad developer experience multiple
> > > times over.
> > >
> > > 3) The idea that allocators can be merged between elements and kptrs is independent
> > > of the static requirements. If the map's internal allocator is exposed per 1), we can
> > > still use it to allocate kptrs but not require that all kptrs in a map are from the
> > > same allocator.
> > >
> > > Going this coarse in the API is easy for us but fundamentally more limiting for
> > > developers. It's not hard to imagine situations where the verifier dependency
> > > tracking or runtime lifetime tracking would allow for pinned maps to be retained but
> > > this scheme would require new maps entirely. (Any situation where you just refactored
> > > the implicit allocator out to share it, for example)
> > >
> > > I also don't think that simplicity for us (a one time implementation cost +
> > > continuous maintenance cost) trumps over long term developer experience (a much
> > > bigger implementation cost over a much bigger time span).
> >
> > It feels we're thinking about scope and use cases for the allocator quite
> > differently and what you're seeing as 'limiting developer choices' to me looks
> > like 'not a limiting issue at all'. To me the allocator is one
> 
> I went over the proposal multiple times, just to make sure I
> understood it properly, but I still can't see this working ideally for
> the inner map case, even if we ignore the rest of the things for a
> moment.
> But maybe you prefer to just forbid them there? Please correct me if I'm wrong.
> 
> You won't be able to know the allocator statically for inner maps (and
> hence not be able to enforce the kptr_xchg requirement to be from the
> same allocator as map). To know it, we will have to force all
> inner_maps to use the same allocator, 

Of course. That's the idea. I don't see a practical use case to use
different allocators in different inner maps.

> either the one specified for
> inner map fd, or the one in map-in-map definition, or elsewhere. But
> to be able to know it statically the information will have to come
> from map-in-map somehow.
> 
> That seems like a very weird limitation just to use local kptrs, and
> doesn't even make sense for map-in-map use cases IMO.
> And unless I'm missing something there isn't an easy way to
> accommodate it in the 'statically known allocator' proposal, because
> such inner_map allocators (and inner_maps) are themselves not static.

It doesn't look difficult. The inner map template has to be defined in the outer map.
All inner maps must fit this template. Currently it requires key/value
to be exactly the same. We used to enforce max_entries too, but it was relaxed later.
The same allocator for all inner maps would be a part of the requirement.
Easy to enforce and easy for progs to comply.
It doesn't look limiting or weird to me.

> > jemalloc/tcmalloc instance. One user space application with multiple threads,
> > lots of maps and code is using exactly one such allocator. The allocator
> > manages all the memory of user space process. In bpf land we don't have a bpf
> > process. We don't have a bpf name space either.  A loose analogy would be a set
> > of programs and maps managed by one user space agent. The bpf allocator would
> > manage all the memory of these maps and programs and provide a "memory namespace"
> > for this set of programs. Another user space agent with its own programs
> > would never want to share the same allocator. In user space a chunk of memory
> > could be mmap-ed between different process to share the data, but you would never
> > put a tcmalloc over such memory to be an allocator for different processes.
> >
> 
> But just saying "would never" or "should never" doesn't work right?
> Hyrum's law and all.

Agree to disagree. Vanilla C allows null pointer dereferences too.
BPF C doesn't.

> libbpf style "bpf package" deployments may not be the only consumers
> of this infra in the future. So designing around this specific idea
> that people will never or shouldn't dynamically share their allocator
> objects between maps which don't share the same allocator seems
> destined to only serve us in the short run IMO.
> 
> People may come up with cases where they are passing ownership of
> objects between such bpf packages, and after coming up with multiple
> examples before it doesn't seem likely static dependencies will be
> able to capture such dynamic runtime relationships, e.g. static
> dependencies don't even work in the inner_map case without more
> restrictions.

The maps are such shared objects.
They are shared between bpf programs and between progs and user space.
Not proposing anything new here.
An allocator connected to a map preserves this sharing ability.

> 
> > More below.
> >
> > > So far, my ranked choice vote is:
> > >
> > > 1) maximum flexibility and runtime live object counts (with exposed allocators, I
> > > like the merging)
> > > 2) medium flexibility with per-field allocator tracking in the verifier and the
> > > ability to lose the association once programs are unloaded and values are gone. This
> > > also works better with exposed allocators since they are implicitly pinned and would
> > > be usable to store values in another map.
> > > 3) minimum flexibility with static whole-map kptr allocators
> >
> > The option 1 flexibility is necessary when allocator is seen as a private pool
> > of objects of given size. Like kernel's kmem_cache instance.
> > I don't think we quite there yet.
> > There is a need to "preallocate this object from sleepable context,
> > so the prog has a guaranteed chunk of memory to use in restricted context",
> > but, arguably, it's not a job of bpf allocator. bpf prog can allocate an object,
> > stash it into kptr, and use it later.
> 
> At least if not adding support for it all now, I think this kind of
> flexibility in option 1 needs to be given some more consideration, as
> in whether this proposal to encode things statically would be able to
> accommodate such cases in the future. To me it seems pretty hard (and
> unless I missed something, it already won't work for inner_maps case
> without requiring all to use the same allocator).

What use case are we walking about?
So far I hear 'ohh it will be limiting', but nothing concrete.

> 
> We might actually be able to do a hybrid of the options by utilizing
> the statically known allocator info to acquire references and runtime
> object counts, which may help eliminate/delay the actual cost we pay
> for it - the atomic upgrade, when initial reference goes away.
> 
> So I think I lean towards option 1 as well, and then the same order as
> Delyan. It seems to cover all kinds of corner cases (allocator known
> vs unknown, normal vs inner maps, etc.) we've been going over in this
> thread, and would also be future proof in terms of permitting
> unforeseen patterns of usage.

These "unforeseen patterns" sounds as "lets overdesign now because we
cannot predict the future".

> > So option 3 doesn't feel less flexible to me. imo the whole-map-allocator is
> > more than we need. Ideally it would be easy to specifiy one single
> > allocator for all maps and progs in a set of .c files. Sort-of a bpf package.
> > In other words one bpf allocator per bpf "namespace" is more than enough.
> > Program authors shouldn't be creating allocators left and right. All these
> > free lists will waste memory.
> > btw I've added an extra patch to bpf_mem_alloc series:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=memalloc&id=6a586327a270272780bdad7446259bbe62574db1
> > that removes kmem_cache usage.
> > Turned out (hindsight 20/20) kmem_cache for each bpf map was a bad idea.
> > When free_lists are not shared they will similarly waste memory.
> > In user space the C code just does malloc() and the memory is isolated per process.
> > Ideally in bpf world the programs would just do:
> > bpf_mem_alloc(btf_type_id_local(struct foo));
> > without specifying an allocator, but that would require one global allocator
> > for all bpf programs in the kernel which is probably not a direction we should go ?
> > So the programs have to specify an allocator to use in bpf_mem_alloc(),
> > but it should be one for all progs, maps in a bpf-package/set/namespace.|
> 
> But "all progs" doesn't mean all of them are running in the same
> context and having the same kinds of memory allocation requirements,
> right? While having too many allocators is also bad, having just one
> single one per package would also be limiting. A bpf object/package is
> very different from a userspace process. So the analogy doesn't
> exactly fit IMO.

It's not exact fit, for sure.
bpf progs are more analogous to kernel modules.
The modules just do kmalloc.
The more we discuss the more I'm leaning towards the same model as well:
Just one global allocator for all bpf progs.
