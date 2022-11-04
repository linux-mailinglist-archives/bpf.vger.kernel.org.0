Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0961938B
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 10:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKDJbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDJbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 05:31:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1A72655E;
        Fri,  4 Nov 2022 02:31:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h193so3884444pgc.10;
        Fri, 04 Nov 2022 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFugYYD0BR8hWyBRF4DKWEpDwNwTVF4Yxa7IWquEXJ4=;
        b=KIUkIiCYoWIFXnawtI9t/7B8BBplMPyLCetFJ9mK+2mI6lzrPhjf5SYdaiOqYqQrnN
         GMwVTIUs0r6528mtxJ0h8FlD8trC1agoBLpjclO9L0NLm1CIDCEl7XBypabi9QnLRnda
         t3sEtHqq/QseoFdIVwLmL6ONBkZO5XapLbDQrpDQhCFetTp+zhYZ9/fAxb8GCJDLm1Po
         y7+Y57NBuf8Xyifc5/JxefeJa1F6f6wKbzBfc3MB1M5ZrHezBrGGDyStvyUfFi7pn+aV
         j+ak1Kf0kPZKd9yH0mbTvCjlZLRxzr73sK4e0hZieWEXY+JkXNUBnDjbNz7CcR6Q+wun
         mMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFugYYD0BR8hWyBRF4DKWEpDwNwTVF4Yxa7IWquEXJ4=;
        b=5WjlQKtLUvOA+3o/ixJZOqGxaOEAdhrOMdfIzs9WGoGFUHcrC+ZBAzn6kIA7i5GhIP
         IIxPheymyV9PJrh8HoNXsUmWwggWCw3YyFZbIwJDTYXaGXE05M2IDEUx4PLmNRY9Tg+S
         orvZjSmoKkep0HXrkVL4OMlxB6lHn4zMN2gSX/odjNRGsNX8h02spYrSpphHzm9iXl2T
         WBxMc/AA8nBuX8YbjwskPrFDeGKbWrH/nEvqSxvPqGQFT+La0M4Kr3XCOa13//mYUgKG
         EUbZVsqg1rMBqRFd91y0RhdF5Zn3iSTgom3DUFwcXvsYLCUjHCKZk7luVBEaRdrqbP/p
         dMsA==
X-Gm-Message-State: ACrzQf0q32Qx8ybRWpETrkkPfO1bYg17O2uDzzzdNh2CdjTLzaXK5jn/
        4GlrfB9EDFLRIMlr9vPhYfk=
X-Google-Smtp-Source: AMsMyM7GrYlstaszFAsFUeDSF1MKxyp1tmcLADtVROUAt9PkVyYVUOK+wK/YvtFh2QDgGvoBvChRkA==
X-Received: by 2002:a05:6a00:1ac6:b0:56d:ad2c:e803 with SMTP id f6-20020a056a001ac600b0056dad2ce803mr21029480pfv.59.1667554265648;
        Fri, 04 Nov 2022 02:31:05 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id w188-20020a627bc5000000b005672daedc8fsm2245142pfc.81.2022.11.04.02.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 02:31:05 -0700 (PDT)
Message-ID: <101ab00c-5fa7-c3ee-63bd-f235e7c4d398@gmail.com>
Date:   Fri, 4 Nov 2022 16:31:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add LRU internals description and
 graph
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev
References: <20221103205010.3266865-1-joe@isovalent.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221103205010.3266865-1-joe@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/4/22 03:50, Joe Stringer wrote:
> +An LRU hashmap type consists of two properties: Firstly, it is a hash map and
> +hence is indexable by key for constant time lookups. Secondly, when at map
> +capacity, map updates will trigger eviction of old entries based on the age of
> +the elements in a set of lists. Each of these properties may be either global
> +or per-CPU, depending on the map type and flags used to create the map:
> +
> +.. flat-table:: Comparison of map properties by map type (x-axis) and flags
> +   (y-axis)
> +
> +   * -
> +     - ``BPF_MAP_TYPE_LRU_HASH``
> +     - ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +
> +   * - ``BPF_NO_COMMON_LRU``
> +     - Per-CPU LRU, global map
> +     - Per-CPU LRU, per-cpu map
> +
> +   * - ``!BPF_NO_COMMON_LRU``
> +     - Global LRU, global map
> +     - Global LRU, per-cpu map
> +

Shouldn't the table be written in reST table syntax instead?

> +The commit message for LRU map support provides a general overview of the
> +underlying LRU algorithm used for entry eviction when the table is full:
> +
> +::
> +
> +    commit 3a08c2fd763450a927d1130de078d6f9e74944fb
> +    Author: Martin KaFai Lau <kafai@fb.com>
> +    Date:   Fri Nov 11 10:55:06 2016 -0800
> +
> +        bpf: LRU List
> +
> +        Introduce bpf_lru_list which will provide LRU capability to
> +        the bpf_htab in the later patch.
> +
> +        * General Thoughts:
> +        1. Target use case.  Read is more often than update.
> +           (i.e. bpf_lookup_elem() is more often than bpf_update_elem()).
> +           If bpf_prog does a bpf_lookup_elem() first and then an in-place
> +           update, it still counts as a read operation to the LRU list concern.
> +        2. It may be useful to think of it as a LRU cache
> +        3. Optimize the read case
> +           3.1 No lock in read case
> +           3.2 The LRU maintenance is only done during bpf_update_elem()
> +        4. If there is a percpu LRU list, it will lose the system-wise LRU
> +           property.  A completely isolated percpu LRU list has the best
> +           performance but the memory utilization is not ideal considering
> +           the work load may be imbalance.
> +        5. Hence, this patch starts the LRU implementation with a global LRU
> +           list with batched operations before accessing the global LRU list.
> +           As a LRU cache, #read >> #update/#insert operations, it will work well.
> +        6. There is a local list (for each cpu) which is named
> +           'struct bpf_lru_locallist'.  This local list is not used to sort
> +           the LRU property.  Instead, the local list is to batch enough
> +           operations before acquiring the lock of the global LRU list.  More
> +           details on this later.
> +        7. In the later patch, it allows a percpu LRU list by specifying a
> +           map-attribute for scalability reason and for use cases that need to
> +           prepare for the worst (and pathological) case like DoS attack.
> +           The percpu LRU list is completely isolated from each other and the
> +           LRU nodes (including free nodes) cannot be moved across the list.  The
> +           following description is for the global LRU list but mostly applicable
> +           to the percpu LRU list also.
> +
> +        * Global LRU List:
> +        1. It has three sub-lists: active-list, inactive-list and free-list.
> +        2. The two list idea, active and inactive, is borrowed from the
> +           page cache.
> +        3. All nodes are pre-allocated and all sit at the free-list (of the
> +           global LRU list) at the beginning.  The pre-allocation reasoning
> +           is similar to the existing BPF_MAP_TYPE_HASH.  However,
> +           opting-out prealloc (BPF_F_NO_PREALLOC) is not supported in
> +           the LRU map.
> +
> +        * Active/Inactive List (of the global LRU list):
> +        1. The active list, as its name says it, maintains the active set of
> +           the nodes.  We can think of it as the working set or more frequently
> +           accessed nodes.  The access frequency is approximated by a ref-bit.
> +           The ref-bit is set during the bpf_lookup_elem().
> +        2. The inactive list, as its name also says it, maintains a less
> +           active set of nodes.  They are the candidates to be removed
> +           from the bpf_htab when we are running out of free nodes.
> +        3. The ordering of these two lists is acting as a rough clock.
> +           The tail of the inactive list is the older nodes and
> +           should be released first if the bpf_htab needs free element.
> +
> +        * Rotating the Active/Inactive List (of the global LRU list):
> +        1. It is the basic operation to maintain the LRU property of
> +           the global list.
> +        2. The active list is only rotated when the inactive list is running
> +           low.  This idea is similar to the current page cache.
> +           Inactive running low is currently defined as
> +           "# of inactive < # of active".
> +        3. The active list rotation always starts from the tail.  It moves
> +           node without ref-bit set to the head of the inactive list.
> +           It moves node with ref-bit set back to the head of the active
> +           list and then clears its ref-bit.
> +        4. The inactive rotation is pretty simply.
> +           It walks the inactive list and moves the nodes back to the head of
> +           active list if its ref-bit is set. The ref-bit is cleared after moving
> +           to the active list.
> +           If the node does not have ref-bit set, it just leave it as it is
> +           because it is already in the inactive list.
> +
> +        * Shrinking the Inactive List (of the global LRU list):
> +        1. Shrinking is the operation to get free nodes when the bpf_htab is
> +           full.
> +        2. It usually only shrinks the inactive list to get free nodes.
> +        3. During shrinking, it will walk the inactive list from the tail,
> +           delete the nodes without ref-bit set from bpf_htab.
> +        4. If no free node found after step (3), it will forcefully get
> +           one node from the tail of inactive or active list.  Forcefully is
> +           in the sense that it ignores the ref-bit.
> +
> +        * Local List:
> +        1. Each CPU has a 'struct bpf_lru_locallist'.  The purpose is to
> +           batch enough operations before acquiring the lock of the
> +           global LRU.
> +        2. A local list has two sub-lists, free-list and pending-list.
> +        3. During bpf_update_elem(), it will try to get from the free-list
> +           of (the current CPU local list).
> +        4. If the local free-list is empty, it will acquire from the
> +           global LRU list.  The global LRU list can either satisfy it
> +           by its global free-list or by shrinking the global inactive
> +           list.  Since we have acquired the global LRU list lock,
> +           it will try to get at most LOCAL_FREE_TARGET elements
> +           to the local free list.
> +        5. When a new element is added to the bpf_htab, it will
> +           first sit at the pending-list (of the local list) first.
> +           The pending-list will be flushed to the global LRU list
> +           when it needs to acquire free nodes from the global list
> +           next time.
> +
> +        * Lock Consideration:
> +        The LRU list has a lock (lru_lock).  Each bucket of htab has a
> +        lock (buck_lock).  If both locks need to be acquired together,
> +        the lock order is always lru_lock -> buck_lock and this only
> +        happens in the bpf_lru_list.c logic.
> +
> +        In hashtab.c, both locks are not acquired together (i.e. one
> +        lock is always released first before acquiring another lock).
> +
> +        Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> +        Acked-by: Alexei Starovoitov <ast@kernel.org>
> +        Signed-off-by: David S. Miller <davem@davemloft.net>
> +

What about just writing the pointer ("See commit 3a08c2fd7634 ("bpf: LRU List")")
instead?

> +Notably, there are various steps that the update algorithm attempts in order to
> +enforce the LRU property which have increasing impacts on other CPUs involved
> +in the operations:
> +
> +- Attempt to use CPU-local state to batch operations
> +- Attempt to fetch free nodes from global lists
> +- Attempt to pull any node from a global list and remove it from the hashmap
> +- Attempt to pull any node from any CPU's list and remove it from the hashmap
> +

Better say "... other CPUs involved in the following operation attempts:"

> +Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_HASH``
> +may fail to insert the entry into the map if other CPUs are heavily contending
> +on the global hashmap lock.
> +
> +This algorithm is described visually in the following diagram:
> +
> +.. kernel-figure::  map_lru_hash_update.dot
> +   :alt:    Diagram outlining the LRU eviction steps taken during map update
> +
> +   LRU hash eviction during map update for ``BPF_MAP_TYPE_LRU_HASH`` and
> +   variants
> +
<snipped>...
> +
> +The dot file source for the above diagram is uses internal kernel function
> +names for the node names in order to make the corresponding logic easier to
> +find. See ``Documentation/bpf/map_lru_hash_update.dot`` for more details.

Since it references the same figure, just say "See the figure above for more
details".

Otherwise LGTM, thanks.

-- 
An old man doll... just what I always wanted! - Clara

