Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196E56AAF90
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjCEMqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:25 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A0CA0F
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:23 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w4so582040ilv.0
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LGRZ1VSckZPMvOige+WggFclATVFF/187e+r1tXNzE=;
        b=REpR+exVazn9yAmMNX8I3j/gHV3DeVbgDK55i9MyzcTs4nIXTUgX5oYJ+yz1VUZd99
         R6ieNP2qMCU/XSP827Rn+eiiH/HNJnlrn4bThmgw3SfrdT+yxFczBlgT0nbcbq+RGtuu
         dxIsWM9axUUlf7SVYkUWlff6GzcwIY9kqahILxVTMsoTljE3sDp9ZyZeB2rAyXnrtAW4
         JkLt6N12TGfGnsUhkFh/YCLgFhdWiVj38phByPfbXgeafwYHIbtT9RUvhmfuHX7m5gd0
         bAkRcgpKSyM946YlS7rka8mc+PRFRmHOmnq3V4TWgwOC9AYrkGydnfl7p3L/NvKpItph
         RBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LGRZ1VSckZPMvOige+WggFclATVFF/187e+r1tXNzE=;
        b=Y/6utf1yqX/HmGmuxQVfSkFtHmS4nSX8gdJ6Qc4YBkUmd2X9dV4JOr4kwdUv2sVE+v
         07nupakQCfRtUV/rmrFXu7Lmog1n3t7/JaT3p6EfS2KzGDZ8W/oavixp2qSHyWODmRCa
         o0KhCmpR2MJO4vBOmu1pnlN8l1VaJkDqsBfD04p9SXIv9plezoziHiGjxzNNQNM+8kgH
         EqqLPIUYM1184eieXOzXHtE2kW8GKKG1SsruVmkja/erdUJF0sLxZ4o2ht9rrsP0b3mK
         QdfUcleaL7dTCeetC/z4589kQqp5ViBDpdYdbifVWpFq9CCDZmtkXEgvLinMY7aiXITG
         GMUA==
X-Gm-Message-State: AO0yUKWzliN8pMNqTNT1APboQFkMorH8XZ1NchIriP00Pem+vd7WJKp/
        ikOjkMwArCmtt8j9OfkYWOs=
X-Google-Smtp-Source: AK7set8c5+yiBYoahcesvBfeDhWDO20luLMC9Wal01oiKU2ma67JOUkk4a6iD9ZgvzxBIefRi3ee5g==
X-Received: by 2002:a05:6e02:1447:b0:318:89e6:6a3f with SMTP id p7-20020a056e02144700b0031889e66a3fmr7921204ilo.10.1678020382837;
        Sun, 05 Mar 2023 04:46:22 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:22 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 00/18] bpf: bpf memory usage 
Date:   Sun,  5 Mar 2023 12:45:57 +0000
Message-Id: <20230305124615.12358-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Currently we can't get bpf memory usage reliably either from memcg or
from bpftool.

In memcg, there's not a 'bpf' item in memory.stat, but only 'kernel',
'sock', 'vmalloc' and 'percpu' which may related to bpf memory. With
these items we still can't get the bpf memory usage, because bpf memory
usage may far less than the kmem in a memcg, for example, the dentry may
consume lots of kmem.

bpftool now shows the bpf memory footprint, which is difference with bpf
memory usage. The difference can be quite great in some cases, for example,

- non-preallocated bpf map
  The non-preallocated bpf map memory usage is dynamically changed. The
  allocated elements count can be from 0 to the max entries. But the
  memory footprint in bpftool only shows a fixed number.

- bpf metadata consumes more memory than bpf element
  In some corner cases, the bpf metadata can consumes a lot more memory
  than bpf element consumes. For example, it can happen when the element
  size is quite small.

- some maps don't have key, value or max_entries
  For example the key_size and value_size of ringbuf is 0, so its
  memlock is always 0.

We need a way to show the bpf memory usage especially there will be more
and more bpf programs running on the production environment and thus the
bpf memory usage is not trivial.

This patchset introduces a new map ops ->map_mem_usage to calculate the
memory usage. Note that we don't intend to make the memory usage 100%
accurate, while our goal is to make sure there is only a small difference
between what bpftool reports and the real memory. That small difference
can be ignored compared to the total usage.  That is enough to monitor
the bpf memory usage. For example, the user can rely on this value to
monitor the trend of bpf memory usage, compare the difference in bpf
memory usage between different bpf program versions, figure out which
maps consume large memory, and etc.

This patchset implements the bpf memory usage for all maps, and yet there's
still work to do. We don't want to introduce runtime overhead in the
element update and delete path, but we have to do it for some
non-preallocated maps,
- devmap, xskmap
  When we update or delete an element, it will allocate or free memory.
  In order to track this dynamic memory, we have to track the count in
  element update and delete path. 

- cpumap
  The element size of each cpumap element is not determinated. If we
  want to track the usage, we have to count the size of all elements in
  the element update and delete path. So I just put it aside currently.

- local_storage, bpf_local_storage
  When we attach or detach a cgroup, it will allocate or free memory. If
  we want to track the dynamic memory, we also need to do something in
  the update and delete path. So I just put it aside currently.

- offload map
  The element update and delete of offload map is via the netdev dev_ops,
  in which it may dynamically allocate or free memory, but this dynamic
  memory isn't counted in offload map memory usage currently.

The result of each map can be found in the individual patch.

We may also need to track per-container bpf memory usage, that will be
addressed by a different patchset.

Changes:
v3->v4: code improvement on ringbuf (Andrii)
        use READ_ONCE() to read lpm_trie (Tao) 
        explain why we can't get bpf memory usage from memcg.
v2->v3: check callback at map creation time and avoid warning (Alexei)
        fix build error under CONFIG_BPF=n (lkp@intel.com)
v1->v2: calculate the memory usage within bpf (Alexei)
- [v1] bpf, mm: bpf memory usage
  https://lwn.net/Articles/921991/
- [RFC PATCH v2] mm, bpf: Add BPF into /proc/meminfo
  https://lwn.net/Articles/919848/
- [RFC PATCH v1] mm, bpf: Add BPF into /proc/meminfo
  https://lwn.net/Articles/917647/ 
- [RFC PATCH] bpf, mm: Add a new item bpf into memory.stat
  https://lore.kernel.org/bpf/20220921170002.29557-1-laoar.shao@gmail].com/

Yafang Shao (18):
  bpf: add new map ops ->map_mem_usage
  bpf: lpm_trie memory usage
  bpf: hashtab memory usage
  bpf: arraymap memory usage
  bpf: stackmap memory usage
  bpf: reuseport_array memory usage
  bpf: ringbuf memory usage
  bpf: bloom_filter memory usage
  bpf: cpumap memory usage
  bpf: devmap memory usage
  bpf: queue_stack_maps memory usage
  bpf: bpf_struct_ops memory usage
  bpf: local_storage memory usage
  bpf, net: bpf_local_storage memory usage
  bpf, net: sock_map memory usage
  bpf, net: xskmap memory usage
  bpf: offload map memory usage
  bpf: enforce all maps having memory usage callback

 include/linux/bpf.h               |  8 ++++++++
 include/linux/bpf_local_storage.h |  1 +
 include/net/xdp_sock.h            |  1 +
 kernel/bpf/arraymap.c             | 28 +++++++++++++++++++++++++
 kernel/bpf/bloom_filter.c         | 12 +++++++++++
 kernel/bpf/bpf_cgrp_storage.c     |  1 +
 kernel/bpf/bpf_inode_storage.c    |  1 +
 kernel/bpf/bpf_local_storage.c    | 10 +++++++++
 kernel/bpf/bpf_struct_ops.c       | 16 +++++++++++++++
 kernel/bpf/bpf_task_storage.c     |  1 +
 kernel/bpf/cpumap.c               | 10 +++++++++
 kernel/bpf/devmap.c               | 26 +++++++++++++++++++++--
 kernel/bpf/hashtab.c              | 43 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/local_storage.c        |  7 +++++++
 kernel/bpf/lpm_trie.c             | 11 ++++++++++
 kernel/bpf/offload.c              |  6 ++++++
 kernel/bpf/queue_stack_maps.c     | 10 +++++++++
 kernel/bpf/reuseport_array.c      |  8 ++++++++
 kernel/bpf/ringbuf.c              | 20 +++++++++++++++++-
 kernel/bpf/stackmap.c             | 14 +++++++++++++
 kernel/bpf/syscall.c              | 20 ++++++++----------
 net/core/bpf_sk_storage.c         |  1 +
 net/core/sock_map.c               | 20 ++++++++++++++++++
 net/xdp/xskmap.c                  | 13 ++++++++++++
 24 files changed, 273 insertions(+), 15 deletions(-)

-- 
1.8.3.1

