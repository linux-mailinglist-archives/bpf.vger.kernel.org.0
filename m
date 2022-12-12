Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4C64A653
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiLLRyz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 12:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiLLRyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 12:54:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB3F10B56
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 09:54:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5512C33751;
        Mon, 12 Dec 2022 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670867688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9RULU3jvNc+fakwFEuO4Iexvj40ypXnl0PPUO1Dc4Q=;
        b=D+iQIUAEvQvlb0gDWlz36PY39dgojNmtSFZP/ML/DyXNq1DQ8SVFUPKyPQ6iJ6S/nteSX2
        0pAGrnBYrAYmwy9s5OVomIwgivDsqexi+t8CqhKbqzwi4TBGYQtrJXp62ZzSNJTXcrGVv5
        3wZ5IwRQM9jDdFFzwwWE9pmvu5EcqNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670867688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9RULU3jvNc+fakwFEuO4Iexvj40ypXnl0PPUO1Dc4Q=;
        b=aTRaE1YD/KE0BA7aobtJbeNvZwot4DWkL+kKf3LTtrC5wDHQtlDbxB1a+p83SoQIG5SMtA
        IZ/2eAYbNZrQ+nCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EB27138F3;
        Mon, 12 Dec 2022 17:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JpirAuhql2MUMQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 12 Dec 2022 17:54:48 +0000
Message-ID: <c43d8d42-ecb1-a044-eb9a-b68d5808562a@suse.cz>
Date:   Mon, 12 Dec 2022 18:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH bpf-next 0/9] mm, bpf: Add BPF into /proc/meminfo
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org
References: <20221212003711.24977-1-laoar.shao@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221212003711.24977-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/12/22 01:37, Yafang Shao wrote:
> Currently there's no way to get BPF memory usage, while we can only
> estimate the usage by bpftool or memcg, both of which are not reliable.
> 
> - bpftool
>   `bpftool {map,prog} show` can show us the memlock of each map and
>   prog, but the memlock is vary from the real memory size. The memlock
>   of a bpf object is approximately
>   `round_up(key_size + value_size, 8) * max_entries`,
>   so 1) it can't apply to the non-preallocated bpf map which may
>   increase or decrease the real memory size dynamically. 2) the element
>   size of some bpf map is not `key_size + value_size`, for example the
>   element size of htab is
>   `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
>   That said the differece between these two values may be very great if
>   the key_size and value_size is small. For example in my verifaction,
>   the size of memlock and real memory of a preallocated hash map are,
> 
>   $ grep BPF /proc/meminfo
>   BPF:             1026048 B <<< the size of preallocated memalloc pool
> 
>   (create hash map)
> 
>   $ bpftool map show
>   3: hash  name count_map  flags 0x0
>           key 4B  value 4B  max_entries 1048576  memlock 8388608B
> 
>   $ grep BPF /proc/meminfo
>   BPF:            84919344 B
>  
>   So the real memory size is $((84919344 - 1026048)) which is 83893296
>   bytes while the memlock is only 8388608 bytes.
> 
> - memcg  
>   With memcg we only know that the BPF memory usage is less than
>   memory.usage_in_bytes (or memory.current in v2). Furthermore, we only 
>   know that the BPF memory usage is less than $MemTotal if the BPF
>   object is charged into root memcg :)
> 
> So we need a way to get the BPF memory usage especially there will be
> more and more bpf programs running on the production environment. The
> memory usage of BPF memory is not trivial, which deserves a new item in
> /proc/meminfo.
> 
> This patchset introduce a solution to calculate the BPF memory usage.
> This solution is similar to how memory is charged into memcg, so it is
> easy to understand. It counts three types of memory usage -
>  - page
>    via kmalloc, vmalloc, kmem_cache_alloc or alloc pages directly and
>    their families.
>    When a page is allocated, we will count its size and mark the head
>    page, and then check the head page at page freeing.
>  - slab
>    via kmalloc, kmem_cache_alloc and their families.
>    When a slab object is allocated, we will mark this object in this
>    slab and check it at slab object freeing. That said we need extra memory
>    to store the information of each object in a slab.
>  - percpu 
>    via alloc_percpu and its family.
>    When a percpu area is allocated, we will mark this area in this
>    percpu chunk and check it at percpu area freeing. That said we need
>    extra memory to store the information of each area in a percpu chunk.
> 
> So we only need to annotate the allcation to add the BPF memory size,
> and the sub of the BPF memory size will be handled automatically at
> freeing. We can annotate it in irq, softirq or process context. To avoid
> counting the nested allcations, for example the percpu backing allocator,
> we reuse the __GFP_ACCOUNT to filter them out. __GFP_ACCOUNT also make
> the count consistent with memcg accounting. 

So you can't easily annotate the freeing places as well, to avoid the whole
tracking infrastructure? I thought there was a patchset for a whole
bfp-specific memory allocator, where accounting would be implemented
naturally, I would imagine.

> To store the information of a slab or a page, we need to create a new
> member in struct page, but we can do it in page extension which can
> avoid changing the size of struct page. So a new page extension
> active_vm is introduced. Each page and each slab which is allocated as
> BPF memory will have a struct active_vm. The reason it is named as
> active_vm is that we can extend it to other areas easily, for example in
> the future we may use it to count other memory usage. 
> 
> The new page extension active_vm can be disabled via CONFIG_ACTIVE_VM at
> compile time or kernel parameter `active_vm=` at runtime.

The issue with page_ext is the extra memory usage, so it was rather intended
for debugging features that can be always compiled in, but only enabled at
runtime when debugging is needed. The overhead is only paid when enabled.
That's at least the case of page_owner and page_table_check. The 32bit
page_idle is rather an oddity that could have instead stayed 64-bit only.

But this is proposing a page_ext functionality supposed to be enabled at all
times in production, with the goal of improved accounting. Not an on-demand
debugging. I'm afraid the costs will outweight the benefits.

Just a quick thought, in case the bpf accounting really can't be handled
without marking pages and slab objects - since memcg already has hooks there
without need of page_ext, couldn't it be done by extending the memcg infra
instead?

> Below is the result of this patchset,
> 
> $ grep BPF /proc/meminfo
> BPF:                1002 kB
> 
> Currently only bpf map is supported, and only slub in supported.
> 
> Future works:
> - support bpf prog
> - not sure if it needs to support slab
>   (it seems slab will be deprecated)
> - support per-map memory usage
> - support per-memcg memory usage
> 
> Yafang Shao (9):
>   mm: Introduce active vm item
>   mm: Allow using active vm in all contexts
>   mm: percpu: Account active vm for percpu
>   mm: slab: Account active vm for slab
>   mm: Account active vm for page
>   bpf: Introduce new helpers bpf_ringbuf_pages_{alloc,free}
>   bpf: Use bpf_map_kzalloc in arraymap
>   bpf: Use bpf_map_kvcalloc in bpf_local_storage
>   bpf: Use active vm to account bpf map memory usage
> 
>  fs/proc/meminfo.c              |   3 +
>  include/linux/active_vm.h      |  73 ++++++++++++
>  include/linux/bpf.h            |   8 ++
>  include/linux/page_ext.h       |   1 +
>  include/linux/sched.h          |   5 +
>  kernel/bpf/arraymap.c          |  16 +--
>  kernel/bpf/bpf_local_storage.c |   4 +-
>  kernel/bpf/memalloc.c          |   5 +
>  kernel/bpf/ringbuf.c           |  75 ++++++++----
>  kernel/bpf/syscall.c           |  40 ++++++-
>  kernel/fork.c                  |   4 +
>  mm/Kconfig                     |   8 ++
>  mm/Makefile                    |   1 +
>  mm/active_vm.c                 | 203 +++++++++++++++++++++++++++++++++
>  mm/active_vm.h                 |  74 ++++++++++++
>  mm/page_alloc.c                |  14 +++
>  mm/page_ext.c                  |   4 +
>  mm/percpu-internal.h           |   3 +
>  mm/percpu.c                    |  43 +++++++
>  mm/slab.h                      |   7 ++
>  mm/slub.c                      |   2 +
>  21 files changed, 557 insertions(+), 36 deletions(-)
>  create mode 100644 include/linux/active_vm.h
>  create mode 100644 mm/active_vm.c
>  create mode 100644 mm/active_vm.h
> 

