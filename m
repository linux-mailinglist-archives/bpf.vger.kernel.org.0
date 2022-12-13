Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3B264B7EB
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 15:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiLMO5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 09:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbiLMO47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 09:56:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2E6379;
        Tue, 13 Dec 2022 06:56:58 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id l10so2291474plb.8;
        Tue, 13 Dec 2022 06:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kuc4nUgO/XR9/IXR1IzCd2vTu1wAL/qMjW/mLLbmkGc=;
        b=RrmKZVM4DTmK68kBoKwpnqT5fT6a+1ei0i+9pcHm4Y+cQ6tFbr7At3lqFX/Icu5syp
         lhopjPWl3gtV41Bncc6CU2dib/KKWyZLsgr33J60ZqRyneDLpa51o/m7tE4E9l2U40NS
         81yTNjRrQNCy+sRgOgRmVV6ouQeWzBcewWzim0DW638skjvf+aLKvymdDtUsDkKJ5GsD
         2atnpsiKPqTLe835f6RIL+DU6yyp9qLo+5duuOLRTiEZOnvuXHY7SdJEunwNQJo/ITYl
         qxTRLzce2YVzByweQlvhiRiw1IgBfHpkN7XjVitsmcowndoiqdv6nxFt1S6Wo+7PGVF4
         5hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kuc4nUgO/XR9/IXR1IzCd2vTu1wAL/qMjW/mLLbmkGc=;
        b=5LSpS4zFbEPqfnVHtfAULLGvFfrVDnvxsdDZeQqDlphJZz9PUl03pETY5kKjSZyCPS
         tPRBd7efrPklWN8wAd3qA8R2oZb38ztS0G3ZHKp2IKCiBO9eTwgA4bLtmsiZ9d9VxnKK
         NKDLMocVfJp5K17nUvzLx2I9wT4HTxsa8nwV1X2DLxhTwXM15Vej4UgoMnQPUWSErkIu
         ++prPA1TPuq+f4RSdTPDpWgdywHaHAUZFx+dxnrBGS0dDt6fdXtO/qEZh0c24zosJ3vN
         vxOjujaJS/LhPX7xWClY0wRq2nBGw/BRi8FqIOmrWkQOOeiNuj6syWAKlk7sZPBzQ1Qe
         0nlg==
X-Gm-Message-State: ANoB5pkJ3mdVy6TabQeMGnRHGbXgHrr0nQyoDYQMBsA/jaM8KOEt+Dlh
        bIH5ye0pDorHVjKxFDGgYUo=
X-Google-Smtp-Source: AA0mqf6g2cjc5+IZgzWap0jf6DlXtUAS3dfGI+3GOaE7ypcRhl+1saQte0QPwcFhrvzxoJynzD6vLA==
X-Received: by 2002:a17:902:f54b:b0:188:5e99:d84f with SMTP id h11-20020a170902f54b00b001885e99d84fmr29273515plf.42.1670943418265;
        Tue, 13 Dec 2022 06:56:58 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902ea0c00b00189ac5a2340sm8570908plg.124.2022.12.13.06.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:56:57 -0800 (PST)
Date:   Tue, 13 Dec 2022 23:56:49 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        linux-mm@kvack.org, bpf@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 0/9] mm, bpf: Add BPF into /proc/meminfo
Message-ID: <Y5iSsdDmXhC5nxuM@hyeyoo>
References: <20221212003711.24977-1-laoar.shao@gmail.com>
 <c43d8d42-ecb1-a044-eb9a-b68d5808562a@suse.cz>
 <CALOAHbC7xWFAYz0qc1XpREbw8=nAquFNTi5k4TA02UQ_7w5k0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbC7xWFAYz0qc1XpREbw8=nAquFNTi5k4TA02UQ_7w5k0A@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 07:52:42PM +0800, Yafang Shao wrote:
> On Tue, Dec 13, 2022 at 1:54 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 12/12/22 01:37, Yafang Shao wrote:
> > > Currently there's no way to get BPF memory usage, while we can only
> > > estimate the usage by bpftool or memcg, both of which are not reliable.
> > >
> > > - bpftool
> > >   `bpftool {map,prog} show` can show us the memlock of each map and
> > >   prog, but the memlock is vary from the real memory size. The memlock
> > >   of a bpf object is approximately
> > >   `round_up(key_size + value_size, 8) * max_entries`,
> > >   so 1) it can't apply to the non-preallocated bpf map which may
> > >   increase or decrease the real memory size dynamically. 2) the element
> > >   size of some bpf map is not `key_size + value_size`, for example the
> > >   element size of htab is
> > >   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
> > >   That said the differece between these two values may be very great if
> > >   the key_size and value_size is small. For example in my verifaction,
> > >   the size of memlock and real memory of a preallocated hash map are,
> > >
> > >   $ grep BPF /proc/meminfo
> > >   BPF:             1026048 B <<< the size of preallocated memalloc pool
> > >
> > >   (create hash map)
> > >
> > >   $ bpftool map show
> > >   3: hash  name count_map  flags 0x0
> > >           key 4B  value 4B  max_entries 1048576  memlock 8388608B
> > >
> > >   $ grep BPF /proc/meminfo
> > >   BPF:            84919344 B
> > >
> > >   So the real memory size is $((84919344 - 1026048)) which is 83893296
> > >   bytes while the memlock is only 8388608 bytes.
> > >
> > > - memcg
> > >   With memcg we only know that the BPF memory usage is less than
> > >   memory.usage_in_bytes (or memory.current in v2). Furthermore, we only
> > >   know that the BPF memory usage is less than $MemTotal if the BPF
> > >   object is charged into root memcg :)
> > >
> > > So we need a way to get the BPF memory usage especially there will be
> > > more and more bpf programs running on the production environment. The
> > > memory usage of BPF memory is not trivial, which deserves a new item in
> > > /proc/meminfo.
> > >
> > > This patchset introduce a solution to calculate the BPF memory usage.
> > > This solution is similar to how memory is charged into memcg, so it is
> > > easy to understand. It counts three types of memory usage -
> > >  - page
> > >    via kmalloc, vmalloc, kmem_cache_alloc or alloc pages directly and
> > >    their families.
> > >    When a page is allocated, we will count its size and mark the head
> > >    page, and then check the head page at page freeing.
> > >  - slab
> > >    via kmalloc, kmem_cache_alloc and their families.
> > >    When a slab object is allocated, we will mark this object in this
> > >    slab and check it at slab object freeing. That said we need extra memory
> > >    to store the information of each object in a slab.
> > >  - percpu
> > >    via alloc_percpu and its family.
> > >    When a percpu area is allocated, we will mark this area in this
> > >    percpu chunk and check it at percpu area freeing. That said we need
> > >    extra memory to store the information of each area in a percpu chunk.
> > >
> > > So we only need to annotate the allcation to add the BPF memory size,
> > > and the sub of the BPF memory size will be handled automatically at
> > > freeing. We can annotate it in irq, softirq or process context. To avoid
> > > counting the nested allcations, for example the percpu backing allocator,
> > > we reuse the __GFP_ACCOUNT to filter them out. __GFP_ACCOUNT also make
> > > the count consistent with memcg accounting.
> >
> > So you can't easily annotate the freeing places as well, to avoid the whole
> > tracking infrastructure?
> 
> The trouble is kfree_rcu().  for example,
>     old_item = active_vm_item_set(ACTIVE_VM_BPF);
>     kfree_rcu();
>     active_vm_item_set(old_item);
> If we want to pass the ACTIVE_VM_BPF into the deferred rcu context, we
> will change lots of code in the RCU subsystem. I'm not sure if it is
> worth it.

(+Cc rcu folks)

IMO adding new kfree_rcu() varient for BPF that accounts BPF memory
usage would be much less churn :)
 
> 
> >  I thought there was a patchset for a whole
> > bfp-specific memory allocator, where accounting would be implemented
> > naturally, I would imagine.
> >
> 
> I posted a patchset[1] which annotates both allocating and freeing
> several months ago.
> But unfortunately after more investigation and verification I found
> the deferred freeing context is a problem, which can't be resolved
> easily.
> That's why I finally decided to annotate allocating only.
> 
> [1]. https://lore.kernel.org/linux-mm/20220921170002.29557-1-laoar.shao@gmail.com/
> 
> > > To store the information of a slab or a page, we need to create a new
> > > member in struct page, but we can do it in page extension which can
> > > avoid changing the size of struct page. So a new page extension
> > > active_vm is introduced. Each page and each slab which is allocated as
> > > BPF memory will have a struct active_vm. The reason it is named as
> > > active_vm is that we can extend it to other areas easily, for example in
> > > the future we may use it to count other memory usage.
> > >
> > > The new page extension active_vm can be disabled via CONFIG_ACTIVE_VM at
> > > compile time or kernel parameter `active_vm=` at runtime.
> >
> > The issue with page_ext is the extra memory usage, so it was rather intended
> > for debugging features that can be always compiled in, but only enabled at
> > runtime when debugging is needed. The overhead is only paid when enabled.
> > That's at least the case of page_owner and page_table_check. The 32bit
> > page_idle is rather an oddity that could have instead stayed 64-bit only.
> >
> 
> Right, it seems currently page_ext is for debugging purposes only.
> 
> > But this is proposing a page_ext functionality supposed to be enabled at all
> > times in production, with the goal of improved accounting. Not an on-demand
> > debugging. I'm afraid the costs will outweight the benefits.
> >
> 
> The memory overhead of this new page extension is (8/4096), which is
> 0.2% of total memory. Not too big to be acceptable.

It's generally unacceptable to increase sizeof(struct page)
(nor enabling page_ext by default, and that's the why page_ext is for
debugging purposes only)

> If the user really
> thinks this overhead is not accepted, he can set "active_vm=off" to
> disable it.

I'd say many people won't welcome adding 0.2% of total memory by default
to get BPF memory usage. 

> To reduce the memory overhead further, I have a bold idea.
> Actually we don't need to allocate such a page extension for every
> page,  while we only need to allocate it if the user needs to access
> it. That said it seems that we can allocate some kind of page
> extensions dynamically rather than preallocate at booting, but I
> haven't investigated it deeply to check if it can work. What do you
> think?
> 
> > Just a quick thought, in case the bpf accounting really can't be handled
> > without marking pages and slab objects - since memcg already has hooks there
> > without need of page_ext, couldn't it be done by extending the memcg infra
> > instead?
> >
> 
> We need to make sure the accounting of BPF memory usage is still
> workable even without memcg, see also the previous discussion[2].
> 
> [2]. https://lore.kernel.org/linux-mm/Yy53cgcwx+hTll4R@slm.duckdns.org/

-- 
Thanks,
Hyeonggon
