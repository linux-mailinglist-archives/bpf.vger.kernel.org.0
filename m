Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF0649766
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiLLAhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLLAhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:37:38 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F3E0
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:36 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m4so10433473pls.4
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl+8JeOvA32brFH/uRfy1HKXKi8XMOI7J+Z36Dk9y70=;
        b=d7JMhWWpGbGWUmkANpu3QQnFhH6/6lzeroesGNjvkpTFi4yuTDbACwmGgNbV/ao9dS
         Gq12Hoa+tPGCSDHsUkaHt1bg7oJ3lvlAJtycXytsSUD4JdT+GaEN9bYwKBrizGck5TpG
         w1CY/ND/YBTC5DvUkupuvz0H5mF8ROtyfLR3dzytOE60X7zBct1GZv8rfBEuYi0lR0dO
         3C5Wa5QmNyPnnpnq0R9pEYVtAP2ryZNhVbwE4hAwNqtDSfbeD/XZ0YRklKWu4ydyQNf8
         O3vwD79GZc3bWuUKnJmJHL97PvTdIiYVTqPKymlAQM2q3P0mRUuaWu9R8xt5gtRNWE5S
         gdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hl+8JeOvA32brFH/uRfy1HKXKi8XMOI7J+Z36Dk9y70=;
        b=dq0RxO7qdJhWTAvHmdGPOwp8bFPCQgr8ZLMyH1cuheSesxFEVVRRKQWR6iPfwFEzGO
         Pm75FrOG3WOyjyj1nCjT2HJ4BzzelpHiW3IgmqrlytZxGnwVhpUD4Dlt442yeE9/LhRE
         /tsiM3Fqq8lxLudOLfkvYSxMrlI695BfhlS32ht0ABkw4YEPQGCvPKdQXIXEuxf4HsRP
         dhrFyQ1YaoG+LYQcySj9Nelz4uSg6/4VWptnW48LqZR6C9MukL0iUOCCwTExMIiwIXpW
         d31xmnDBF94UHelbjbzYKvmyu+x02UKPvef1BS+0Vm0ZDU/fGUu9gfs9ZhJfFSZM6mHo
         7rIA==
X-Gm-Message-State: ANoB5plDKpq9YwuWEmy7Y1A2cDka6cPD9ZAmUU5QfEtFwbe5XbBFQtJd
        RdA++PaxchkxAz+vDM9WvfCmtKspfO15uQQFsv8=
X-Google-Smtp-Source: AA0mqf5BPM+NqwKp3zAHO4204wVrI7RSFS+Vbopkd7XcvO9m2lDEqwT1CjeEu5VdM3mBTVOe1yqHPg==
X-Received: by 2002:a17:902:b198:b0:189:fa12:c98a with SMTP id s24-20020a170902b19800b00189fa12c98amr16321147plr.66.1670805455863;
        Sun, 11 Dec 2022 16:37:35 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:37:35 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 0/9] mm, bpf: Add BPF into /proc/meminfo
Date:   Mon, 12 Dec 2022 00:37:02 +0000
Message-Id: <20221212003711.24977-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently there's no way to get BPF memory usage, while we can only
estimate the usage by bpftool or memcg, both of which are not reliable.

- bpftool
  `bpftool {map,prog} show` can show us the memlock of each map and
  prog, but the memlock is vary from the real memory size. The memlock
  of a bpf object is approximately
  `round_up(key_size + value_size, 8) * max_entries`,
  so 1) it can't apply to the non-preallocated bpf map which may
  increase or decrease the real memory size dynamically. 2) the element
  size of some bpf map is not `key_size + value_size`, for example the
  element size of htab is
  `sizeof(struct htab_elem) + round_up(key_size, 8) + round_up(value_size, 8)`
  That said the differece between these two values may be very great if
  the key_size and value_size is small. For example in my verifaction,
  the size of memlock and real memory of a preallocated hash map are,

  $ grep BPF /proc/meminfo
  BPF:             1026048 B <<< the size of preallocated memalloc pool

  (create hash map)

  $ bpftool map show
  3: hash  name count_map  flags 0x0
          key 4B  value 4B  max_entries 1048576  memlock 8388608B

  $ grep BPF /proc/meminfo
  BPF:            84919344 B
 
  So the real memory size is $((84919344 - 1026048)) which is 83893296
  bytes while the memlock is only 8388608 bytes.

- memcg  
  With memcg we only know that the BPF memory usage is less than
  memory.usage_in_bytes (or memory.current in v2). Furthermore, we only 
  know that the BPF memory usage is less than $MemTotal if the BPF
  object is charged into root memcg :)

So we need a way to get the BPF memory usage especially there will be
more and more bpf programs running on the production environment. The
memory usage of BPF memory is not trivial, which deserves a new item in
/proc/meminfo.

This patchset introduce a solution to calculate the BPF memory usage.
This solution is similar to how memory is charged into memcg, so it is
easy to understand. It counts three types of memory usage -
 - page
   via kmalloc, vmalloc, kmem_cache_alloc or alloc pages directly and
   their families.
   When a page is allocated, we will count its size and mark the head
   page, and then check the head page at page freeing.
 - slab
   via kmalloc, kmem_cache_alloc and their families.
   When a slab object is allocated, we will mark this object in this
   slab and check it at slab object freeing. That said we need extra memory
   to store the information of each object in a slab.
 - percpu 
   via alloc_percpu and its family.
   When a percpu area is allocated, we will mark this area in this
   percpu chunk and check it at percpu area freeing. That said we need
   extra memory to store the information of each area in a percpu chunk.

So we only need to annotate the allcation to add the BPF memory size,
and the sub of the BPF memory size will be handled automatically at
freeing. We can annotate it in irq, softirq or process context. To avoid
counting the nested allcations, for example the percpu backing allocator,
we reuse the __GFP_ACCOUNT to filter them out. __GFP_ACCOUNT also make
the count consistent with memcg accounting. 

To store the information of a slab or a page, we need to create a new
member in struct page, but we can do it in page extension which can
avoid changing the size of struct page. So a new page extension
active_vm is introduced. Each page and each slab which is allocated as
BPF memory will have a struct active_vm. The reason it is named as
active_vm is that we can extend it to other areas easily, for example in
the future we may use it to count other memory usage. 

The new page extension active_vm can be disabled via CONFIG_ACTIVE_VM at
compile time or kernel parameter `active_vm=` at runtime.

Below is the result of this patchset,

$ grep BPF /proc/meminfo
BPF:                1002 kB

Currently only bpf map is supported, and only slub in supported.

Future works:
- support bpf prog
- not sure if it needs to support slab
  (it seems slab will be deprecated)
- support per-map memory usage
- support per-memcg memory usage

Yafang Shao (9):
  mm: Introduce active vm item
  mm: Allow using active vm in all contexts
  mm: percpu: Account active vm for percpu
  mm: slab: Account active vm for slab
  mm: Account active vm for page
  bpf: Introduce new helpers bpf_ringbuf_pages_{alloc,free}
  bpf: Use bpf_map_kzalloc in arraymap
  bpf: Use bpf_map_kvcalloc in bpf_local_storage
  bpf: Use active vm to account bpf map memory usage

 fs/proc/meminfo.c              |   3 +
 include/linux/active_vm.h      |  73 ++++++++++++
 include/linux/bpf.h            |   8 ++
 include/linux/page_ext.h       |   1 +
 include/linux/sched.h          |   5 +
 kernel/bpf/arraymap.c          |  16 +--
 kernel/bpf/bpf_local_storage.c |   4 +-
 kernel/bpf/memalloc.c          |   5 +
 kernel/bpf/ringbuf.c           |  75 ++++++++----
 kernel/bpf/syscall.c           |  40 ++++++-
 kernel/fork.c                  |   4 +
 mm/Kconfig                     |   8 ++
 mm/Makefile                    |   1 +
 mm/active_vm.c                 | 203 +++++++++++++++++++++++++++++++++
 mm/active_vm.h                 |  74 ++++++++++++
 mm/page_alloc.c                |  14 +++
 mm/page_ext.c                  |   4 +
 mm/percpu-internal.h           |   3 +
 mm/percpu.c                    |  43 +++++++
 mm/slab.h                      |   7 ++
 mm/slub.c                      |   2 +
 21 files changed, 557 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/active_vm.h
 create mode 100644 mm/active_vm.c
 create mode 100644 mm/active_vm.h

-- 
2.30.1 (Apple Git-130)

