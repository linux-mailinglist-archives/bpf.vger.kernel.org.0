Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274FE64C738
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 11:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiLNKen (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 05:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbiLNKen (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 05:34:43 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3DC218AB;
        Wed, 14 Dec 2022 02:34:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x28so9686540lfn.6;
        Wed, 14 Dec 2022 02:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h6afrxHUvdkV/mzg7EptWsl16ivR6bivvnvyqT2M6HE=;
        b=h7q1jqaa1e25PAr0VwqRqIBRZFbN86rIt8qfPFOXeumjVfOyjVDNZZ0VO+N7KJJWMe
         0qLb9Zi1aI8VOlBbmmPK0rFHSG2FWwXOKJ7R4FhUYmnNyBeBrpUHnB3FdyM4giPRo8Wi
         iX/uxvq9RzjTed3yPigUUF5dxc5H/gf2M7hga6mYe+GBNVQ2UjAhGyRfgwZDJTZhYPog
         fMIhdjuVrIQTmDcj8ZdZdjIvz9PDP1YzaDVf/XwoBT0H/6eTz6ClaQSb7WYht7dhATFu
         vimR1KkbAzU6e4rgVFcY2oj37aYinPClZcPlOl6LvvZ0NY2UhfFONT6oFznC8TDT9znB
         SPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6afrxHUvdkV/mzg7EptWsl16ivR6bivvnvyqT2M6HE=;
        b=LULjfh7nGTeWx94EYwyndRjNZMH6Op8mlppzPYFZswc1+o6qI8EhsxiRrXmqmX2teY
         Ot03uKgvhRC94dIMGoj1mh8mXwBkBuk0k3rIjahbs4VSd5yu0bO8YQYxxihbsNjo0GFS
         B4TvbsbOydoYufpMxRoJtL/4f1dnrWPn8AqRdZLxBNy6eC3keLzsiopDdJLf1rEqFyFx
         f/eqySy9qhEBZDLqwjJRezt/s7eDXD3v0Digae+wen4dcRUof0TTDToC/nLxXVKOG1yO
         xKeCdo6x5N4c+cV16zNM3iduYUGnEz8MvkJm1ZugnbcOJBvuKxTo6taZWjgwKK51jnQi
         9m2w==
X-Gm-Message-State: ANoB5plfk6lkd7Yuz2ErfD3gAdISQshA/yb+pVqEZMp5U2gc+8/vL9m8
        h5i7//KkG+CAGQQMJlm4SUmJOFwBfeXr+V7bOU0=
X-Google-Smtp-Source: AA0mqf5PuzPPd0C5zmgYr3JCgyQl50U2D888LJXYRBEk4U32R4r8AV/uYXvhjctb8dVmI1U9yL1FKKz/3jS+97SXCl8=
X-Received: by 2002:a05:6512:2590:b0:4b6:ea91:85f5 with SMTP id
 bf16-20020a056512259000b004b6ea9185f5mr572705lfb.307.1671014079440; Wed, 14
 Dec 2022 02:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20221212003711.24977-1-laoar.shao@gmail.com> <c43d8d42-ecb1-a044-eb9a-b68d5808562a@suse.cz>
 <CALOAHbC7xWFAYz0qc1XpREbw8=nAquFNTi5k4TA02UQ_7w5k0A@mail.gmail.com> <Y5iSsdDmXhC5nxuM@hyeyoo>
In-Reply-To: <Y5iSsdDmXhC5nxuM@hyeyoo>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 14 Dec 2022 18:34:03 +0800
Message-ID: <CALOAHbAO9CXGbE6HQN7z3xnnvLghTTc6B9ZKHHkW9K79Di==nQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] mm, bpf: Add BPF into /proc/meminfo
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        linux-mm@kvack.org, bpf@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 10:56 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Tue, Dec 13, 2022 at 07:52:42PM +0800, Yafang Shao wrote:
> > On Tue, Dec 13, 2022 at 1:54 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >
> > > On 12/12/22 01:37, Yafang Shao wrote:
> > > > Currently there's no way to get BPF memory usage, while we can only
> > > > estimate the usage by bpftool or memcg, both of which are not reliable.
> > > >
> > > > - bpftool
> > > >   `bpftool {map,prog} show` can show us the memlock of each map and
> > > >   prog, but the memlock is vary from the real memory size. The memlock
> > > >   of a bpf object is approximately
> > > >   `round_up(key_size + value_size, 8) * max_entries`,
> > > >   so 1) it can't apply to the non-preallocated bpf map which may
> > > >   increase or decrease the real memory size dynamically. 2) the element
> > > >   size of some bpf map is not `key_size + value_size`, for example the
> > > >   element size of htab is
> > > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > > >   That said the differece between these two values may be very great if
> > > >   the key_size and value_size is small. For example in my verifaction,
> > > >   the size of memlock and real memory of a preallocated hash map are,
> > > >
> > > >   $ grep BPF /proc/meminfo
> > > >   BPF:             1026048 B <<< the size of preallocated memalloc pool
> > > >
> > > >   (create hash map)
> > > >
> > > >   $ bpftool map show
> > > >   3: hash  name count_map  flags 0x0
> > > >           key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > > >
> > > >   $ grep BPF /proc/meminfo
> > > >   BPF:            84919344 B
> > > >
> > > >   So the real memory size is $((84919344 - 1026048)) which is 83893296
> > > >   bytes while the memlock is only 8388608 bytes.
> > > >
> > > > - memcg
> > > >   With memcg we only know that the BPF memory usage is less than
> > > >   memory.usage_in_bytes (or memory.current in v2). Furthermore, we only
> > > >   know that the BPF memory usage is less than $MemTotal if the BPF
> > > >   object is charged into root memcg :)
> > > >
> > > > So we need a way to get the BPF memory usage especially there will be
> > > > more and more bpf programs running on the production environment. The
> > > > memory usage of BPF memory is not trivial, which deserves a new item in
> > > > /proc/meminfo.
> > > >
> > > > This patchset introduce a solution to calculate the BPF memory usage.
> > > > This solution is similar to how memory is charged into memcg, so it is
> > > > easy to understand. It counts three types of memory usage -
> > > >  - page
> > > >    via kmalloc, vmalloc, kmem_cache_alloc or alloc pages directly and
> > > >    their families.
> > > >    When a page is allocated, we will count its size and mark the head
> > > >    page, and then check the head page at page freeing.
> > > >  - slab
> > > >    via kmalloc, kmem_cache_alloc and their families.
> > > >    When a slab object is allocated, we will mark this object in this
> > > >    slab and check it at slab object freeing. That said we need extra memory
> > > >    to store the information of each object in a slab.
> > > >  - percpu
> > > >    via alloc_percpu and its family.
> > > >    When a percpu area is allocated, we will mark this area in this
> > > >    percpu chunk and check it at percpu area freeing. That said we need
> > > >    extra memory to store the information of each area in a percpu chunk.
> > > >
> > > > So we only need to annotate the allcation to add the BPF memory size,
> > > > and the sub of the BPF memory size will be handled automatically at
> > > > freeing. We can annotate it in irq, softirq or process context. To avoid
> > > > counting the nested allcations, for example the percpu backing allocator,
> > > > we reuse the __GFP_ACCOUNT to filter them out. __GFP_ACCOUNT also make
> > > > the count consistent with memcg accounting.
> > >
> > > So you can't easily annotate the freeing places as well, to avoid the whole
> > > tracking infrastructure?
> >
> > The trouble is kfree_rcu().  for example,
> >     old_item = active_vm_item_set(ACTIVE_VM_BPF);
> >     kfree_rcu();
> >     active_vm_item_set(old_item);
> > If we want to pass the ACTIVE_VM_BPF into the deferred rcu context, we
> > will change lots of code in the RCU subsystem. I'm not sure if it is
> > worth it.
>
> (+Cc rcu folks)
>
> IMO adding new kfree_rcu() varient for BPF that accounts BPF memory
> usage would be much less churn :)
>

Besides the kfree_rcu(), there is another deferred freeing, for
example, the vfree_deferred(), but vfree_deferred() can be handled
easily.
Once we do it this way, the BPF memory usage accounting will be a
burden of all newly introduced deferred freeing.
For example, if the MM guys optimize the memory freeing code in the
future without noticing this BPF accounting, it will be broken easily.
So in the long run, the restrictions should be as less as possible.

> >
> > >  I thought there was a patchset for a whole
> > > bfp-specific memory allocator, where accounting would be implemented
> > > naturally, I would imagine.
> > >
> >
> > I posted a patchset[1] which annotates both allocating and freeing
> > several months ago.
> > But unfortunately after more investigation and verification I found
> > the deferred freeing context is a problem, which can't be resolved
> > easily.
> > That's why I finally decided to annotate allocating only.
> >
> > [1]. https://lore.kernel.org/linux-mm/20220921170002.29557-1-laoar.shao@gmail.com/
> >
> > > > To store the information of a slab or a page, we need to create a new
> > > > member in struct page, but we can do it in page extension which can
> > > > avoid changing the size of struct page. So a new page extension
> > > > active_vm is introduced. Each page and each slab which is allocated as
> > > > BPF memory will have a struct active_vm. The reason it is named as
> > > > active_vm is that we can extend it to other areas easily, for example in
> > > > the future we may use it to count other memory usage.
> > > >
> > > > The new page extension active_vm can be disabled via CONFIG_ACTIVE_VM at
> > > > compile time or kernel parameter `active_vm=` at runtime.
> > >
> > > The issue with page_ext is the extra memory usage, so it was rather intended
> > > for debugging features that can be always compiled in, but only enabled at
> > > runtime when debugging is needed. The overhead is only paid when enabled.
> > > That's at least the case of page_owner and page_table_check. The 32bit
> > > page_idle is rather an oddity that could have instead stayed 64-bit only.
> > >
> >
> > Right, it seems currently page_ext is for debugging purposes only.
> >
> > > But this is proposing a page_ext functionality supposed to be enabled at all
> > > times in production, with the goal of improved accounting. Not an on-demand
> > > debugging. I'm afraid the costs will outweight the benefits.
> > >
> >
> > The memory overhead of this new page extension is (8/4096), which is
> > 0.2% of total memory. Not too big to be acceptable.
>
> It's generally unacceptable to increase sizeof(struct page)
> (nor enabling page_ext by default, and that's the why page_ext is for
> debugging purposes only)
>

Then we can disable page_ext by default. The user who wants to use it
can pass "active_vm=on".

> > If the user really
> > thinks this overhead is not accepted, he can set "active_vm=off" to
> > disable it.
>
> I'd say many people won't welcome adding 0.2% of total memory by default
> to get BPF memory usage.
>

This 0.2% of total memory can be reduced significantly by introducing
dynamical page ext. so it is not a problem which will last forever.
We can optimize the memory overhead step by step to make it be
accepted by more and more people.

-- 
Regards
Yafang
