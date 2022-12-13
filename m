Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3764B481
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiLMLxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiLMLxW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:53:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB61EAEC
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 03:53:20 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a19so3086694ljk.0
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 03:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i6IFpnMTfmRr3kFmgbjHtFr+GF79ljZTaif9Ph+5OO4=;
        b=FqQLpsoyitz+DpFlktyuljXToLIJSfdd29qWJj0/ZMurgTjOvIDJapsR2/Y5NctGJl
         WEeLqcKfmNh5formF/PDRxt1NiMWAtpHN/HZXqsGJxQtP4RU3eZbONk71ZgCDMGVCF9f
         9AZnAyzzFPfmfw6ngVkHdHM+9P9XimRkJyDkl+rDnZBAk/mRFqBHm5/rW/OLIYkDrz04
         pTHo6vV/qw4vDT5oCpfOExkfM9um34m1WMvMCMq7dM8zyiR7x+Rufcz6OgRseirgmyBQ
         s2iY9hwVUkm426jas3IUybgiQ81PfLkeWokY3YCNWVC6HSfOFUKYG5rofk5ZDKziQ5x2
         psZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6IFpnMTfmRr3kFmgbjHtFr+GF79ljZTaif9Ph+5OO4=;
        b=8ABW4j1BFkrxPZbJJfDpiipz2/PtvekjAXDPksgBebMNYBVdZjEgjhYMkM8XaQ9c8i
         B6PdA++dypYCuPOsJiHOs30LBphBNfo5relz2+juhIB0BDBHMI7y8D6ata0XA3JA0XuR
         H4e/4oHHtaVRdwS/7cIEnfSKrEIwTpDLL1BEhjpYaQlwd9c+5HjTHDUXiVfKkLIy3ycQ
         Av3u5S2kWwEvHuhvElu72EqPpV4ow6nKa0M2Q7Jbx6G/ed5zXN3Sx+b7b3iGkDQVbPUD
         g/G5BAm8rI/PVrAjkVU6w6AnJXBuIf8nAbppfHMjRZtlhCwnggflhbM3TUK2G1/TVyk2
         KMZQ==
X-Gm-Message-State: ANoB5pnH0YuAGdX5PCpN3oWSj+7NCD62LniD8Nww3bCqdg+kILtv4Ejy
        WsSROBNg5WiPBpfXo1t+HKwgkrEr5QeQipz9hkGFguvwsRU=
X-Google-Smtp-Source: AA0mqf5c2uhfDyzRJn9HqplZJE2TB77aI6sgkYqA/4CDC6bEA160LEvTM3CT1MDN+1PeK6BtAdreJbGyVskPdSbrhRA=
X-Received: by 2002:a05:651c:2328:b0:27a:eae:9ecc with SMTP id
 bi40-20020a05651c232800b0027a0eae9eccmr5003213ljb.248.1670932398702; Tue, 13
 Dec 2022 03:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20221212003711.24977-1-laoar.shao@gmail.com> <c43d8d42-ecb1-a044-eb9a-b68d5808562a@suse.cz>
In-Reply-To: <c43d8d42-ecb1-a044-eb9a-b68d5808562a@suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 13 Dec 2022 19:52:42 +0800
Message-ID: <CALOAHbC7xWFAYz0qc1XpREbw8=nAquFNTi5k4TA02UQ_7w5k0A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/9] mm, bpf: Add BPF into /proc/meminfo
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        bpf@vger.kernel.org
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

On Tue, Dec 13, 2022 at 1:54 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 12/12/22 01:37, Yafang Shao wrote:
> > Currently there's no way to get BPF memory usage, while we can only
> > estimate the usage by bpftool or memcg, both of which are not reliable.
> >
> > - bpftool
> >   `bpftool {map,prog} show` can show us the memlock of each map and
> >   prog, but the memlock is vary from the real memory size. The memlock
> >   of a bpf object is approximately
> >   `round_up(key_size + value_size, 8) * max_entries`,
> >   so 1) it can't apply to the non-preallocated bpf map which may
> >   increase or decrease the real memory size dynamically. 2) the element
> >   size of some bpf map is not `key_size + value_size`, for example the
> >   element size of htab is
> >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> >   That said the differece between these two values may be very great if
> >   the key_size and value_size is small. For example in my verifaction,
> >   the size of memlock and real memory of a preallocated hash map are,
> >
> >   $ grep BPF /proc/meminfo
> >   BPF:             1026048 B <<< the size of preallocated memalloc pool
> >
> >   (create hash map)
> >
> >   $ bpftool map show
> >   3: hash  name count_map  flags 0x0
> >           key 4B  value 4B  max_entries 1048576  memlock 8388608B
> >
> >   $ grep BPF /proc/meminfo
> >   BPF:            84919344 B
> >
> >   So the real memory size is $((84919344 - 1026048)) which is 83893296
> >   bytes while the memlock is only 8388608 bytes.
> >
> > - memcg
> >   With memcg we only know that the BPF memory usage is less than
> >   memory.usage_in_bytes (or memory.current in v2). Furthermore, we only
> >   know that the BPF memory usage is less than $MemTotal if the BPF
> >   object is charged into root memcg :)
> >
> > So we need a way to get the BPF memory usage especially there will be
> > more and more bpf programs running on the production environment. The
> > memory usage of BPF memory is not trivial, which deserves a new item in
> > /proc/meminfo.
> >
> > This patchset introduce a solution to calculate the BPF memory usage.
> > This solution is similar to how memory is charged into memcg, so it is
> > easy to understand. It counts three types of memory usage -
> >  - page
> >    via kmalloc, vmalloc, kmem_cache_alloc or alloc pages directly and
> >    their families.
> >    When a page is allocated, we will count its size and mark the head
> >    page, and then check the head page at page freeing.
> >  - slab
> >    via kmalloc, kmem_cache_alloc and their families.
> >    When a slab object is allocated, we will mark this object in this
> >    slab and check it at slab object freeing. That said we need extra memory
> >    to store the information of each object in a slab.
> >  - percpu
> >    via alloc_percpu and its family.
> >    When a percpu area is allocated, we will mark this area in this
> >    percpu chunk and check it at percpu area freeing. That said we need
> >    extra memory to store the information of each area in a percpu chunk.
> >
> > So we only need to annotate the allcation to add the BPF memory size,
> > and the sub of the BPF memory size will be handled automatically at
> > freeing. We can annotate it in irq, softirq or process context. To avoid
> > counting the nested allcations, for example the percpu backing allocator,
> > we reuse the __GFP_ACCOUNT to filter them out. __GFP_ACCOUNT also make
> > the count consistent with memcg accounting.
>
> So you can't easily annotate the freeing places as well, to avoid the whole
> tracking infrastructure?

The trouble is kfree_rcu().  for example,
    old_item = active_vm_item_set(ACTIVE_VM_BPF);
    kfree_rcu();
    active_vm_item_set(old_item);
If we want to pass the ACTIVE_VM_BPF into the deferred rcu context, we
will change lots of code in the RCU subsystem. I'm not sure if it is
worth it.

>  I thought there was a patchset for a whole
> bfp-specific memory allocator, where accounting would be implemented
> naturally, I would imagine.
>

I posted a patchset[1] which annotates both allocating and freeing
several months ago.
But unfortunately after more investigation and verification I found
the deferred freeing context is a problem, which can't be resolved
easily.
That's why I finally decided to annotate allocating only.

[1]. https://lore.kernel.org/linux-mm/20220921170002.29557-1-laoar.shao@gmail.com/

> > To store the information of a slab or a page, we need to create a new
> > member in struct page, but we can do it in page extension which can
> > avoid changing the size of struct page. So a new page extension
> > active_vm is introduced. Each page and each slab which is allocated as
> > BPF memory will have a struct active_vm. The reason it is named as
> > active_vm is that we can extend it to other areas easily, for example in
> > the future we may use it to count other memory usage.
> >
> > The new page extension active_vm can be disabled via CONFIG_ACTIVE_VM at
> > compile time or kernel parameter `active_vm=` at runtime.
>
> The issue with page_ext is the extra memory usage, so it was rather intended
> for debugging features that can be always compiled in, but only enabled at
> runtime when debugging is needed. The overhead is only paid when enabled.
> That's at least the case of page_owner and page_table_check. The 32bit
> page_idle is rather an oddity that could have instead stayed 64-bit only.
>

Right, it seems currently page_ext is for debugging purposes only.

> But this is proposing a page_ext functionality supposed to be enabled at all
> times in production, with the goal of improved accounting. Not an on-demand
> debugging. I'm afraid the costs will outweight the benefits.
>

The memory overhead of this new page extension is (8/4096), which is
0.2% of total memory. Not too big to be acceptable. If the user really
thinks this overhead is not accepted, he can set "active_vm=off" to
disable it.

To reduce the memory overhead further, I have a bold idea.
Actually we don't need to allocate such a page extension for every
page,  while we only need to allocate it if the user needs to access
it. That said it seems that we can allocate some kind of page
extensions dynamically rather than preallocate at booting, but I
haven't investigated it deeply to check if it can work. What do you
think?

> Just a quick thought, in case the bpf accounting really can't be handled
> without marking pages and slab objects - since memcg already has hooks there
> without need of page_ext, couldn't it be done by extending the memcg infra
> instead?
>

We need to make sure the accounting of BPF memory usage is still
workable even without memcg, see also the previous discussion[2].

[2]. https://lore.kernel.org/linux-mm/Yy53cgcwx+hTll4R@slm.duckdns.org/

-- 
Regards
Yafang
