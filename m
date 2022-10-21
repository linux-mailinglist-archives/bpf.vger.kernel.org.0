Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079BC607272
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 10:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJUIgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 04:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJUIgP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 04:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E324CC91
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666341343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tbFeBX32l+yge7/Aih1kg+kLlJEAu6ZHtL5mIDt4umE=;
        b=iZQNDc0/hsnRjmnLOc3JPG/qqWZ2rF8L8svaYl2FL0c1d1BHFZ5gavA6Z1OPftfTy+f2mF
        cKQxcUY4guznU3OY1+BK964gb42awIdogkzIItVGTvg9FtS8gIxxLWz/ng77SoPyoiNqzy
        YtTnaUZ7eEyw/+xwxYMwDu2D61Weqtc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-SOHFJjgqMKukFoJv9mS0bA-1; Fri, 21 Oct 2022 04:35:41 -0400
X-MC-Unique: SOHFJjgqMKukFoJv9mS0bA-1
Received: by mail-qv1-f69.google.com with SMTP id q20-20020ad44354000000b004afb5a0d33cso1789489qvs.12
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 01:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbFeBX32l+yge7/Aih1kg+kLlJEAu6ZHtL5mIDt4umE=;
        b=HHPJZK87kHqsvnK3uVxsLk4k4JovU/Oidm0zx+4RaxCHhp6lMGfGa1mcCvrn0l/Jd1
         lQY3UwyzutUiCUpqvZ2QG82I5pgWPvWrsiqHmXK909EieMaAVP5eHtAJJCAqoV9uo/4Y
         UYaLGqIpxSg3rQA1quegxYeyifragtK2RTA65KBB+G0mEihZoL8ccuoLiba7Rf688voP
         Z5CIsEkCaScNEGxVGpeLcL/snpgJe9PORf7+616w2HyDd1y/ri6Hy1mzNmb5YWnKTqUa
         t4sbZcFCEk/bf4CfSVZI7ebGQNu5U69OTfhGBWHlPJWia6UPyP6koBvDBRkoncpzyCj9
         CrPw==
X-Gm-Message-State: ACrzQf1O0/DrdHF8dihYTDaVNYCXqc46wfrJNc+DrVzEsiLiH5NecSPP
        F5onmsKmKxCcnHhM12SODwuAjhE1W0fJv1IM7dU9juX2DcxQb8G0wkze4d7vQYN/92EKqtjgEXN
        oKa5NOAfExeRdCringAfI/FoqXY7yZ19meO4/Nctw320wMac7ChxETjRG2hnfX0Q=
X-Received: by 2002:a05:622a:1015:b0:39c:be69:bf2d with SMTP id d21-20020a05622a101500b0039cbe69bf2dmr15775620qte.85.1666341340595;
        Fri, 21 Oct 2022 01:35:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7SJEz9an/JHrJkcQgSTe2mAkdY80/iaHsDALyyjropkfe4mxW3DCsvB3LxY6yWUMy5NivL6A==
X-Received: by 2002:a05:622a:1015:b0:39c:be69:bf2d with SMTP id d21-20020a05622a101500b0039cbe69bf2dmr15775591qte.85.1666341340102;
        Fri, 21 Oct 2022 01:35:40 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id cb23-20020a05622a1f9700b0039cc22a2c49sm7693863qtb.47.2022.10.21.01.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:35:39 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v1 1/1] docs: BPF_MAP_TYPE_CPUMAP
Date:   Fri, 21 Oct 2022 05:30:50 -0400
Message-Id: <20221021093050.2711300-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/bpf/map_cpumap.rst

diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
new file mode 100644
index 000000000000..63e203f5a5da
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
+``BPF_MAP_TYPE_CPUMAP`` is primarily used as a backend map for the XDP BPF helpers
+``bpf_redirect_map()`` and ``XDP_REDIRECT`` action. This map type redirects raw
+XDP frames to another CPU.
+
+A CPUMAP is a scalability and isolation mechanism, that allows separating the driver
+network XDP layer, from the rest of the network stack, and assigning dedicated
+CPUs for this stage. An example use case for this map type is software based Receive
+Side Scaling (RSS) at the XDP layer.
+
+The CPUMAP represents the CPUs in the system indexed as the map-key, and the
+map-value is the config setting (per CPUMAP entry). Each CPUMAP entry has a dedicated
+kernel thread bound to the given CPU to represent the remote CPU execution unit.
+
+The CPUMAP entry represents a multi-producer single-consumer (MPSC) queue
+(implemented via ``ptr_ring`` in the kernel). The single consumer is the CPUMAP
+``kthread`` that can access the ``ptr_ring`` queue without taking any lock. It also
+tries to bulk dequeue eight xdp_frame objects, as they represent one cache line.
+The multi-producers can be RX IRQ line CPUs queuing up packets simultaneously for
+the remote CPU. To avoid queue lock contention for each producer CPU, there is a
+small eight-object queue to generate bulk enqueueing into the cross-CPU queue.
+This careful queue usage means that each cache line transfers eight frames across
+the CPUs.
+
+.. note::
+
+    XDP packets getting XDP redirected to another CPU, will maximum be stored/queued
+    for one ``driver ->poll()`` call. Queueing the frame and the flush operation
+    are guaranteed to happen on same CPU. Thus, ``cpu_map_flush`` operation can deduce
+    via ``this_cpu_ptr()`` which queue in bpf_cpu_map_entry contains packets.
+
+Usage
+=====
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
+
+ CPU entries can be added or updated using the ``bpf_map_update_elem()``
+ helper. This helper replaces existing elements atomically. The ``value`` parameter
+ can be ``struct bpf_cpumap_val``.
+
+ .. note::
+    The maps can only be updated from user space and not from a BPF program.
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
+ Starting from Linux kernel version 5.9 the CPUMAP can run a second XDP program
+ on the remote CPU. This helps with scalability as the receive CPU should spend
+ as few cycles as possible processing packets. The remote CPU (to which the packet is
+ directed) can afford to spend more cycles processing the frame. For example, packets
+ are received on a CPU to which the IRQ of the NIC RX queue is steered. This CPU
+ is the one that initially sees the packets. This is where the XDP redirect program
+ is executed. Because the objective is to scale the CPU usage across multiple CPUs,
+ the eBPF program should use as few cycles as possible on this initial CPU; just
+ enough to determine which remote CPU to send the packet to, and then move the
+ packet to a remote CPU for continued processing. The remote CPUMAP ``kthread``
+ receives raw XDP frame (``xdp_frame``) objects. If the frames are to be passed
+ to the networking stack, the SKB objects are allocated by the remote CPU, and
+ the SKBs are passed to the networking stack.
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+ CPU entries can be retrieved using the ``bpf_map_lookup_elem()``
+ helper.
+
+.. c:function::
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+ CPU entries can be deleted using the ``bpf_map_delete_elem()``
+ helper. This helper will return 0 on success, or negative error in case of
+ failure.
+
+.. c:function::
+     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+
+ Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
+ For ``BPF_MAP_TYPE_CPUMAP`` this map contains references to CPUs.
+
+ The lower two bits of *flags* are used as the return code if the map lookup
+ fails. This is so that the return value can be one of the XDP program return
+ codes up to ``XDP_TX``, as chosen by the caller.
+
+Examples
+========
+Kernel
+------
+
+The following code snippet shows how to declare a BPF_MAP_TYPE_CPUMAP called cpu_map.
+
+.. code-block:: c
+
+   struct {
+        __uint(type, BPF_MAP_TYPE_CPUMAP);
+        __type(key, u32);
+        __type(value, struct bpf_cpumap_val);
+    } cpu_map SEC(".maps");
+
+The following code snippet shows how to redirect packets to a remote CPU.
+
+.. code-block:: c
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __type(key, u32);
+        __type(value, u32);
+    } cpus_available SEC(".maps"); /* Map populated by user space program as selectable redirect CPUs*/
+
+    SEC("xdp")
+    int  xdp_redir_cpu(struct xdp_md *ctx)
+    {
+        u32 key = bpf_get_smp_processor_id();
+        u32 *cpu_selected;
+        u32 cpu_dest = 0;
+
+        cpu_selected = bpf_map_lookup_elem(&cpus_available, &key);
+        if (!cpu_selected)
+            return XDP_ABORTED;
+        cpu_dest = *cpu_selected;
+
+        if (cpu_dest >= bpf_num_possible_cpus()) {
+            return XDP_ABORTED;
+        }
+        return bpf_redirect_map(&cpu_map, cpu_dest, 0);
+    }
+
+User Space
+----------
+
+The following code snippet shows how to update a CPUMAP called cpumap.
+
+.. code-block:: c
+
+    static int create_cpu_entry(__u32 cpu, struct bpf_cpumap_val *value)
+    {
+        int ret;
+
+        ret = bpf_map_update_elem(bpf_map__fd(cpu_map), &cpu, value, 0);
+        if (ret < 0)
+            fprintf(stderr, "Create CPU entry failed: %s\n", strerror(errno));
+
+        return ret;
+    }
+
+References
+===========
+
+- https://elixir.bootlin.com/linux/v6.0.1/source/kernel/bpf/cpumap.c
+- https://developers.redhat.com/blog/2021/05/13/receive-side-scaling-rss-with-ebpf-and-cpumap#redirecting_into_a_cpumap
-- 
2.35.3

