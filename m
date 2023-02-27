Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6A6A45E4
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjB0PUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjB0PUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:20:47 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B869227A3
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z2so7029378plf.12
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIIpM1zQRE6ftDzyEWSrMOVlqMJdzawkbjz0JFw80k8=;
        b=OvGGjMh91mDIe1ZLUypKqXwZQKmqo+RqV/wHlrjvQJCW7vJ7KiwV+6ns3voAG0nISf
         FiaB4OZ6CAd5l9IXTGEYrqNI1LT/89hSfVEe+MwoF/X0i/Y3cElJi/jNJcpzReVoOQzA
         sFS7XRJ0io2IEo30W37B0WEpZefRO6SvkST9fBE4YC2xAPYba9GhQO3BXXYbyzhXtUj+
         ChILrKDz9CnleSKeZS+sueFgDuHGZPLLYH/aYovTqIlFXRBpZzIn5UNMXjEn+GVX5f16
         9yK8YByMzu8xw/t2STz/CzLr/W6LmnVqi/6GOP4njxY7h6CoaPrZumunvsFhpyiLfcoQ
         b9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIIpM1zQRE6ftDzyEWSrMOVlqMJdzawkbjz0JFw80k8=;
        b=MghdrYq6CrW3DVOGvRdpIA0hAWjDu6Eo0DA2i7Ja0CoJn54Zzpk8v3GIvXU2sZ8Lnq
         2ZpM6ytnnIJ4B1XTbIrNNcWQU52tiwFdfsfgjLNVdC3i6Ac90HbCm/NRZDnkTpU6wA1X
         EwSUxzMuVNIaZbeWbgRVWBYkfpK0CG4i0jsNWEq27ehj+cMyk3Z9kUSJMZf6a538QkfX
         ijvuaMFL1AYrgPezrcf/EzlAIoTzOYDFyK9ad0sqGO7509OUr33xBve/ra6Jhs4VytO+
         bPZLgLxLVUyvD5gGJvCfvJ56ODMYInRVZTjiJ1jn4trUTLPMgDiw1S/STd/CxVy1MO9p
         w9Pg==
X-Gm-Message-State: AO0yUKViYLP9J/XmE0XJsT8j8vg2orrABWRlvdzLsbR1EE9Cu+sPDBhD
        NNxpXvvlQmTai22+KjNjq2w=
X-Google-Smtp-Source: AK7set+hTVDXjswgEsKy7K324tPBmX5S6PkKTQ3hnXyLYuJYBMhBvoJpm08fiTe/wn5kvL0XuEpdTA==
X-Received: by 2002:a05:6a20:a010:b0:cb:df6c:b801 with SMTP id p16-20020a056a20a01000b000cbdf6cb801mr19712631pzj.36.1677511244895;
        Mon, 27 Feb 2023 07:20:44 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:20:44 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 00/18] bpf: bpf memory usage 
Date:   Mon, 27 Feb 2023 15:20:14 +0000
Message-Id: <20230227152032.12359-1-laoar.shao@gmail.com>
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

Changes:
v2->v3: check callback at map creation time and avoid warning (Alexei)
        fix build error under CONFIG_BPF=n (lkp@intel.com)
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

