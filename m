Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF0667A2A
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjALQBJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjALQAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:42 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAE2203B
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:34 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id jr10so9499890qtb.7
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+b4oZC4k/u0MuI+eBhb5GDAbvtZlveaanBpbCBZGLuk=;
        b=gH+YZsuYyNPgyszOqubkRLCS29SIJOB9PrQx1tS+xlG3QyAJ3bLTTWBPampZXiuPqs
         KTjA5w3a6VtPl+bBdFurqalw8lyuxjz2A4sG9yff/uDc0KPTelAtNFUbVSWtgycVq3QP
         ETITTnKP1toA9/o1j6NBt8NBf3hWk/pPK+Xbs3dnttA7wutvGvRjhvoiBOFTxKUyinsL
         ZQzRD5nVGXI+QwkacI52G8jp09+KNKkVBdoJQKTHBZ+Ba0gFhaMYPjze8kqNsDHZdRaS
         z2pSWMd+FbmGdTAJDgAgYGgXPSczYqXuIialaR265GI33BGLZMCQYdpezEEJ7gEamKHw
         leqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b4oZC4k/u0MuI+eBhb5GDAbvtZlveaanBpbCBZGLuk=;
        b=hiS5Ejc4L5wkmlaBi/Mi3aQ8/7Qb8rMs2yvQkJVgGtWybh48JKqA19ukdGk6WWcNkB
         nvQg6bkg0NYQ20PdavCkgduKCS/b8H6c5ixbpwI5povW7gfxJgjoaMyawUYGPV9azHzi
         Er++FadDiEP44MIZMmJrngKGRju5x54gXsxOdU0rbse9Rq4cAqWdj/25tfvDR4yxMgVh
         dxLrzwcDbrK3irG+z4JL9qTs3jCvJguF0R+WivPeggldeWUic8wW+2X2i1ewq1coqqeB
         P6h5XFGiGyD3gDf2BKKdpG0xslpqww/thhUsAPSMLnYQMfy2sEj+t6+KZrx3zOtAdeHY
         uItQ==
X-Gm-Message-State: AFqh2krM7vbg7ocLI7EBnnFDxXd4Ss8kjhLS8gIEva/MkDRvcq0mcKAt
        Zv5VGuVsKg2FvCN7QgYCJI0=
X-Google-Smtp-Source: AMrXdXtGvY5tQVEkBtICluE5ihHdcXFG1vx0FJ6hV+iSciT1RQdYmWKrihwzvymSMNTVc073jfMhtA==
X-Received: by 2002:a05:622a:1f10:b0:3a9:7782:fd7f with SMTP id ca16-20020a05622a1f1000b003a97782fd7fmr105567367qtb.21.1673538813262;
        Thu, 12 Jan 2023 07:53:33 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:32 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 00/11] mm, bpf: Add BPF into /proc/meminfo 
Date:   Thu, 12 Jan 2023 15:53:15 +0000
Message-Id: <20230112155326.26902-1-laoar.shao@gmail.com>
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
  BPF:                 350 kB  <<< the size of preallocated memalloc pool

  (create hash map)

  $ bpftool map show
  41549: hash  name count_map  flags 0x0
        key 4B  value 4B  max_entries 1048576  memlock 8388608B

  $ grep BPF /proc/meminfo
  BPF:               82284 kB
 
  So the real memory size is $((82284 - 350)) which is 81934 kB 
  while the memlock is only 8192 kB. 

- memcg  
  With memcg we only know that the BPF memory usage is less than
  memory.kmem.usage_in_bytes (or memory.current in v2). Furthermore, we
  only know that the BPF memory usage is less than $MemTotal if the BPF
  object is charged into root memcg :)

So we need a way to get the BPF memory usage especially there will be
more and more bpf programs running on the production environment. The
memory usage of BPF memory is not trivial, which deserves a new item in
/proc/meminfo.

There're some ways to calculate the BPF memory usage. They all have pros
and cons.

- Option 1: Annotate BPF memory allocation only
  It is how I implemented in RFC v1. You can look into the detail and
  discussion on it via the link below[1]. 
  - pros
    We only need to annotate the BPF memory allocation, and then we can
    find these allocated memory in the free path automatically. So it is
    very easy to use, and we don't need to worry about the stat leak.
  - cons
    We must store the information of these allocated memory, in
    particular the allocated slab objects. So it takes extra memory. If
    we introduce a new member into struct page or add this member into
    page_ext, it will take at least 0.2% of the total memory on 64bit
    system, that is not acceptible.
    One way to reduce this memory overhead is to introduce dynamic page
    extension, but it will take great effort and it may not worth it.

- Option 2: Annotate both allocation and free
  It is similar to how I implemented in an earlier version[2].
  - pros
    There's almost no memory overhead.
  - cons    
    All the memory allocation and free must use the BPF helpers, but
    can't use the generic helpers like kfree/vfree/percpu_free. So if
    the user forget to use the helpers we introduced to allocate or
    free BPF memory, there will be stat leak.
    It is not easy to annotate some derferred allocation, in particular
    the kfree_rcu(). So the user have to use call_rcu() instead of
    kfree_rcu(). Another risk is that if we introduce other deferred
    free helpers in the future, this BPF statistic may break easily.
    
- Option 3: Calculate the memory size via the pointer
  It is how I implement in this patchset.    
  After allocating some BPF memory, we get the full size from the
  pointer and add it; Before freeing the BPF memory, we get the full
  size from the pointer and sub it.
  - pros    
    No memory overhead.    
    No code churn in MM core allocation and free path.
    The impementation is quite clear and easy to maintain.
  - cons
    The calculation is not embedded in the MM allocation/free path, so
    there will be some redundant code to execute to get the size via
    pointer.    
    BPF memory allocation and free must use the helpers we introduced,
    otherwise there will be stat leak.

I perfer the option 3. Its cons can be justified.    
- bpf_map_free should be paired with bpf_map_alloc, that's reasonable.
- Regarding the possible extra cpu cycles it may take, the user should
  not allocate and free memory in the critical path if it is latency
  sensitive. 

[1]. https://lwn.net/Articles/917647/
[2]. https://lore.kernel.org/linux-mm/20220921170002.29557-1-laoar.shao@gmail.com/

v1->v2: don't use page_ext (Vlastimil, Hyeonggon)

Yafang Shao (11):
  mm: percpu: count memcg relevant memory only when kmemcg is enabled
  mm: percpu: introduce percpu_size()
  mm: slab: rename obj_full_size()
  mm: slab: introduce ksize_full()
  mm: vmalloc: introduce vsize()
  mm: util: introduce kvsize()
  bpf: introduce new helpers bpf_ringbuf_pages_{alloc,free}
  bpf: use bpf_map_kzalloc in arraymap
  bpf: use bpf_map_kvcalloc in bpf_local_storage
  bpf: add and use bpf map free helpers
  bpf: introduce bpf memory statistics

 fs/proc/meminfo.c              |   4 ++
 include/linux/bpf.h            | 115 +++++++++++++++++++++++++++++++++++++++--
 include/linux/percpu.h         |   1 +
 include/linux/slab.h           |  10 ++++
 include/linux/vmalloc.h        |  15 ++++++
 kernel/bpf/arraymap.c          |  20 +++----
 kernel/bpf/bpf_cgrp_storage.c  |   2 +-
 kernel/bpf/bpf_inode_storage.c |   2 +-
 kernel/bpf/bpf_local_storage.c |  24 ++++-----
 kernel/bpf/bpf_task_storage.c  |   2 +-
 kernel/bpf/cpumap.c            |  13 +++--
 kernel/bpf/devmap.c            |  10 ++--
 kernel/bpf/hashtab.c           |   8 +--
 kernel/bpf/helpers.c           |   2 +-
 kernel/bpf/local_storage.c     |  12 ++---
 kernel/bpf/lpm_trie.c          |  14 ++---
 kernel/bpf/memalloc.c          |  19 ++++++-
 kernel/bpf/ringbuf.c           |  75 ++++++++++++++++++---------
 kernel/bpf/syscall.c           |  54 ++++++++++++++++++-
 mm/percpu-internal.h           |   4 +-
 mm/percpu.c                    |  35 +++++++++++++
 mm/slab.h                      |  19 ++++---
 mm/slab_common.c               |  52 +++++++++++++------
 mm/slob.c                      |   2 +-
 mm/util.c                      |  15 ++++++
 net/core/bpf_sk_storage.c      |   4 +-
 net/core/sock_map.c            |   2 +-
 net/xdp/xskmap.c               |   2 +-
 28 files changed, 422 insertions(+), 115 deletions(-)

-- 
1.8.3.1

