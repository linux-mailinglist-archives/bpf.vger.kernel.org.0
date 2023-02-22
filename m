Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FB969EC72
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBVBqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBVBqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A032E5A
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 16so3583506pfl.8
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KC86z8SlEmj7xlf6rCqTarsSzuNpqXxXeQY8QGrMFVk=;
        b=R0xJDT9fn5IM5H/ot8IxgL58OLfzPYMLCoC4uPGVY9DeiqRSwGPsTFPhvWmCosElEC
         f6vUDPkc7ACua/4FSehslfeZTJGwvI5aatSIUAR/TIMyXPuuoXSWUB6/D0zlucUNpCD7
         Ns6Rrj66Vvn/6G8ksDYL8yuIh+9DUGcszMFg1YZi6iGN+fbFP3A/b2BHalXRDVOA432A
         Q+bpMwpjJw5MaEsRpVjMaq24CHz9d4xADxoIrYOkQGizf7xELIvmavtEmq34afQqlhQE
         KFOdKRdjpRKLabdgHC1w6sDzzPk0JKJwLq0urc0FryAD73wH0v7eaDrAHAreRM8hc++n
         JhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KC86z8SlEmj7xlf6rCqTarsSzuNpqXxXeQY8QGrMFVk=;
        b=reiO7TiaEjvy6MJZ7/3R8MUL4hRRmEeoZnMTxrbr8IkS3IN9M9J94n47HCQcFQusAM
         9olxSrXmkmBFe4CUYmfyWUcrFE82+kJ/YPJ34fhOWatXTJ/O46QPNdTWassjZpi0vrY7
         HcSQsOOKhUQV0Ko9jBB7pckYwD674LEas5DkO1Dikchd8310bD7fuJc7G857ZQA4rQW+
         l3nU354e3Yh/S3iamnTipdyho0PiPZdOn3W/VVChTn4CgfUBC4b11lCCPX/dWGbya6UY
         x3bVovi2puhGEZYud8UqEfnvPR6nHJ8qA1gwntCpVhvpOPObQd2QSXcf1hIf6XXUmcup
         vtBw==
X-Gm-Message-State: AO0yUKUsOTodKNKF63OhsFIJFGBXy4oZwLo90oycTJHvp1DRVRTDDTMK
        OwHIQ91mLoua1lkU0QJnIT0=
X-Google-Smtp-Source: AK7set8fqb7OyWFZMzZC2awfNdS5/JR0ThP+SibwqtMlsqphgHavWAT/UM2TK/QsKzAli56fSJBDTQ==
X-Received: by 2002:a05:6a00:4205:b0:5a8:c038:f4e7 with SMTP id cd5-20020a056a00420500b005a8c038f4e7mr5496442pfb.1.1677030383246;
        Tue, 21 Feb 2023 17:46:23 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:22 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 00/18] bpf: bpf memory usage 
Date:   Wed, 22 Feb 2023 01:45:35 +0000
Message-Id: <20230222014553.47744-1-laoar.shao@gmail.com>
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

Currently we can't get bpf memory usage reliably. bpftool now shows the
bpf memory footprint, which is difference with bpf memory usage. The
difference can be quite great in some cases, for example,

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
map consume large memory, and etc.

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

Changes:
v1->v2: calculate the memory usage within bpf (Alexei)
- [v1] bpf, mm: bpf memory usage
  https://lwn.net/Articles/921991/
- [RFC PATCH v2] mm, bpf: Add BPF into /proc/meminfo
  https://lwn.net/Articles/919848/
- [RFC PATCH v1] mm, bpf: Add BPF into /proc/meminfo
  https://lwn.net/Articles/917647/ 

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
 kernel/bpf/ringbuf.c              | 19 +++++++++++++++++
 kernel/bpf/stackmap.c             | 14 +++++++++++++
 kernel/bpf/syscall.c              | 20 ++++++++----------
 net/core/bpf_sk_storage.c         |  1 +
 net/core/sock_map.c               | 20 ++++++++++++++++++
 net/xdp/xskmap.c                  | 13 ++++++++++++
 24 files changed, 273 insertions(+), 14 deletions(-)

-- 
1.8.3.1

