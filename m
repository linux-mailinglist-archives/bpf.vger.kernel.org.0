Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD961F813
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiKGP6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 10:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGP6i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 10:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09C91C41C
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 07:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667836667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEDHSiQfEsVOOyMmBMn/yu0YrnjduEAKKpeayMVYAW0=;
        b=CXPTeesH9m+4v+j4+86K64FUfFvUIYuzSkCo1jq8NLH9tcRzVYNkKVrfoIfmrGkCtO0yWz
        +jUPZfEvMMFBJSlRnsQfTTDXlQT/lyAoT5Ya1InuykfloVqCUov2uq39LzeqshrsPQFU4k
        OASZKObFvDyMXO37Ix4dIxli/91kS+w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-382-GQTgUqqCOruFFCkT7mQh6w-1; Mon, 07 Nov 2022 10:57:46 -0500
X-MC-Unique: GQTgUqqCOruFFCkT7mQh6w-1
Received: by mail-qt1-f198.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso8384087qtx.15
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 07:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEDHSiQfEsVOOyMmBMn/yu0YrnjduEAKKpeayMVYAW0=;
        b=x8k9EYJQOFr0mJtRN09c54ijw2woPlVWe4HBsLRvS3Xs2NmRJDdB4Dugi6JvaCK5jh
         sYYuJgkwwucvYuwOUmlAGVsqQTVISDmRW46B3zcthNIgFBMGcUNNaA+1Qv1T8RtLYZbY
         U1W+2/6i8DwkwkK28PYpSPas+XOz5bAA/N4jeMMEqW6ZEnydN6hyer/ju0jQ2fKhfhkx
         dzhOAb2rEC9OsHsuoRjb55Gc9nf7rzRoWRTbe8Yjb3bMxRfIGfQyU1VBoexilvJfJokE
         rnXKHqM3Gl+PhzU8XY9vhnZHmC+s039KPbpFpbMsLYdfHZE01hyTMIi18tz4NzDP/cvB
         tSkw==
X-Gm-Message-State: ANoB5pmEKSafVQU+iMic7uEpawSJzGdcmtWolY/xzKUhwkaDhtoadEo0
        BI27MRjpQJnSXyrZbCvSela5ETSWYatsUyigENL8cJ9tf4HUCNgKDBqPwNJFaxz7AEWXMy/RIKm
        TFmuN+GOYDuR1u01ED6ym8m+lwzEjDPg12O+MfgR+t9Q4T6ifFiUwgfnG+u03mUk=
X-Received: by 2002:a05:6214:d61:b0:4c1:d4e5:bdd6 with SMTP id 1-20020a0562140d6100b004c1d4e5bdd6mr16128076qvs.66.1667836665393;
        Mon, 07 Nov 2022 07:57:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf695Ec4RQM82splyY2m0PsMi7c9MwZAEeaU8nROjKYXJqUXuJun326KaNphlfX5Cue98FpHoQ==
X-Received: by 2002:a05:6214:d61:b0:4c1:d4e5:bdd6 with SMTP id 1-20020a0562140d6100b004c1d4e5bdd6mr16128042qvs.66.1667836665039;
        Mon, 07 Nov 2022 07:57:45 -0800 (PST)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id q16-20020ac84510000000b00398df095cf5sm6248889qtn.34.2022.11.07.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:57:44 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        Maryam Tahhan <mtahhan@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v3 1/1] docs: BPF_MAP_TYPE_CPUMAP
Date:   Mon,  7 Nov 2022 11:52:07 -0500
Message-Id: <20221107165207.2682075-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221107165207.2682075-1-mtahhan@redhat.com>
References: <20221107165207.2682075-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_CPUMAP including
kernel version introduced, usage and examples.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/bpf/map_cpumap.rst | 166 +++++++++++++++++++++++++++++++
 kernel/bpf/cpumap.c              |   9 +-
 2 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/bpf/map_cpumap.rst

diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
new file mode 100644
index 000000000000..eaf57b38cafd
--- /dev/null
+++ b/Documentation/bpf/map_cpumap.rst
@@ -0,0 +1,166 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+===================
+BPF_MAP_TYPE_CPUMAP
+===================
+
+.. note::
+   - ``BPF_MAP_TYPE_CPUMAP`` was introduced in kernel version 4.15
+
+.. kernel-doc:: kernel/bpf/cpumap.c
+ :doc: cpu map
+
+An example use-case for this map type is software based Receive Side Scaling (RSS).
+
+The CPUMAP represents the CPUs in the system indexed as the map-key, and the
+map-value is the config setting (per CPUMAP entry). Each CPUMAP entry has a dedicated
+kernel thread bound to the given CPU to represent the remote CPU execution unit.
+
+Starting from Linux kernel version 5.9 the CPUMAP can run a second XDP program
+on the remote CPU. This allows an XDP program to split its processing across
+multiple CPUs. For example, a scenario where the initial CPU (that sees/receives
+the packets) needs to do minimal packet processing and the remote CPU (to which
+the packet is directed) can afford to spend more cycles processing the frame. The
+initial CPU is where the XDP redirect program is executed. The remote CPU
+receives raw ``xdp_frame`` objects.
+
+Usage
+=====
+
+Kernel BPF
+----------
+.. c:function::
+     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+
+ Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
+ For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
+
+ The lower two bits of ``flags`` are used as the return code if the map lookup
+ fails. This is so that the return value can be one of the XDP program return
+ codes up to ``XDP_TX``, as chosen by the caller.
+
+Userspace
+---------
+.. note::
+    CPUMAP entries can only be updated/looked up/deleted from user space and not
+    from an eBPF program. Trying to call these functions from a kernel eBPF
+    program will result in the program failing to load and a verifier warning.
+
+.. c:function::
+    int bpf_map_update_elem(int fd, const void *key, const void *value,
+                   __u64 flags);
+
+ CPU entries can be added or updated using the ``bpf_map_update_elem()``
+ helper. This helper replaces existing elements atomically. The ``value`` parameter
+ can be ``struct bpf_cpumap_val``.
+
+ .. code-block:: c
+
+    struct bpf_cpumap_val {
+        __u32 qsize;  /* queue size to remote target CPU */
+        union {
+            int   fd; /* prog fd on map write */
+            __u32 id; /* prog id on map read */
+        } bpf_prog;
+    };
+
+ The flags argument can be one of the following:
+  - BPF_ANY: Create a new element or update an existing element.
+  - BPF_NOEXIST: Create a new element only if it did not exist.
+  - BPF_EXIST: Update an existing element.
+
+.. c:function::
+    int bpf_map_lookup_elem(int fd, const void *key, void *value);
+
+ CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
+ helper.
+
+.. c:function::
+    int bpf_map_delete_elem(int fd, const void *key);
+
+ CPU entries can be deleted using the ``bpf_map_delete_elem()``
+ helper. This helper will return 0 on success, or negative error in case of
+ failure.
+
+Examples
+========
+Kernel
+------
+
+The following code snippet shows how to declare a ``BPF_MAP_TYPE_CPUMAP`` called
+``cpu_map`` and how to redirect packets to a remote CPU using a round robin scheme.
+
+.. code-block:: c
+
+   struct {
+        __uint(type, BPF_MAP_TYPE_CPUMAP);
+        __type(key, __u32);
+        __type(value, struct bpf_cpumap_val);
+        __uint(max_entries, 12);
+    } cpu_map SEC(".maps");
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __type(key, __u32);
+        __type(value, __u32);
+        __uint(max_entries, 12);
+    } cpus_available SEC(".maps");
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+        __type(key, __u32);
+        __type(value, __u32);
+        __uint(max_entries, 1);
+    } cpus_iterator SEC(".maps");
+
+    SEC("xdp")
+    int  xdp_redir_cpu_round_robin(struct xdp_md *ctx)
+    {
+        __u32 key = 0;
+        __u32 cpu_dest = 0;
+        __u32 *cpu_selected, *cpu_iterator;
+        __u32 cpu_idx;
+
+        cpu_iterator = bpf_map_lookup_elem(&cpus_iterator, &key);
+        if (!cpu_iterator)
+            return XDP_ABORTED;
+        cpu_idx = *cpu_iterator;
+
+        *cpu_iterator += 1;
+        if (*cpu_iterator == bpf_num_possible_cpus())
+            *cpu_iterator = 0;
+
+        cpu_selected = bpf_map_lookup_elem(&cpus_available, &cpu_idx);
+        if (!cpu_selected)
+            return XDP_ABORTED;
+        cpu_dest = *cpu_selected;
+
+        if (cpu_dest >= bpf_num_possible_cpus())
+            return XDP_ABORTED;
+
+        return bpf_redirect_map(&cpu_map, cpu_dest, 0);
+    }
+
+Userspace
+---------
+
+The following code snippet shows how to dynamically set the max_entries for a
+CPUMAP to the max number of cpus available on the system.
+
+.. code-block:: c
+
+    int set_max_cpu_entries(struct bpf_map *cpu_map)
+    {
+        if (bpf_map__set_max_entries(cpu_map, libbpf_num_possible_cpus()) < 0) {
+            fprintf(stderr, "Failed to set max entries for cpu_map map: %s",
+                strerror(errno));
+            return -1;
+        }
+        return 0;
+    }
+
+References
+===========
+
+- https://developers.redhat.com/blog/2021/05/13/receive-side-scaling-rss-with-ebpf-and-cpumap#redirecting_into_a_cpumap
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index b5ba34ddd4b6..9747550c9088 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -4,13 +4,16 @@
  * Copyright (c) 2017 Jesper Dangaard Brouer, Red Hat Inc.
  */
 
-/* The 'cpumap' is primarily used as a backend map for XDP BPF helper
+/**
+ * DOC: cpu map
+ * The 'cpumap' is primarily used as a backend map for XDP BPF helper
  * call bpf_redirect_map() and XDP_REDIRECT action, like 'devmap'.
  *
- * Unlike devmap which redirects XDP frames out another NIC device,
+ * Unlike devmap which redirects XDP frames out to another NIC device,
  * this map type redirects raw XDP frames to another CPU.  The remote
  * CPU will do SKB-allocation and call the normal network stack.
- *
+ */
+/*
  * This is a scalability and isolation mechanism, that allow
  * separating the early driver network XDP layer, from the rest of the
  * netstack, and assigning dedicated CPUs for this stage.  This
-- 
2.35.3

