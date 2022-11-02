Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD81F61620A
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiKBLul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKBLuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD028725
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667389780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LW6MOnU6mlfcCxH+G3H9xQRaq19jciK+WKOGYbqCWSU=;
        b=ffY0KPODDGW60yrzsW8Qvfb2x3UPCR3jwzrieDG2zpiXT9Onc8oBtcuoXHMO6662lSgE6K
        TMfOOz1TScyi2BssoyQaJPieGuvx2N6AakrRRDQ8odZ+jJSS2gJalMb4Qatcxt6XmgxG2W
        IHDU6LLb5XtuSoitX3gMQd0QPAyJJSY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-395-CMs5Gj38NvSc55-4boMSiQ-1; Wed, 02 Nov 2022 07:49:40 -0400
X-MC-Unique: CMs5Gj38NvSc55-4boMSiQ-1
Received: by mail-qv1-f72.google.com with SMTP id ob9-20020a0562142f8900b004bba5363ad9so9442253qvb.8
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 04:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW6MOnU6mlfcCxH+G3H9xQRaq19jciK+WKOGYbqCWSU=;
        b=gSK8it/8fwLDhSDsZP9QUyQJNALEs7oxL3WUYi9CG46qQEpX5PS9Yqqj1L3iGGoEoI
         ReaKVcnFVKspXWnYDnD+epcF5EGfjl6F/ZEUShwBs8r22rbjP/k/G+z7WAiQUW/ueAOB
         XtwBSkSVOlsxvJSwqAxGziL4EqZdW33VEoIByFXPrWOTTqSL/yeRK5GBPIEUf1sDz8Xf
         40N/uuhAefy+BbYvL3ixga/20U9GolwPrOw32DG5SLyU15lQZwGpygivkhXi0Ix5Chxv
         i65z9X9v5y2cRIT6t+MjVy1IueK8QTKp5r5W9MGvk6ZxLjnAj5+V8PUaW0YJKe7XEfhc
         6veg==
X-Gm-Message-State: ACrzQf2gsizF8I4g9pJHD8REobsoDgTGKW2VouIld8J3MNQ3HRPNCiFJ
        2OWLMnx87PCJndSGXxsR6rTRdAniCNJNlecsNoD9DoISN7eNhSV86LYqVjiTNqnkP9za7RVrbx1
        a5VhcaNbgNePkkF/ObLVEZ/ujYxUgOHBYlEyor4HBGoS7mWy52xYx472jd5LQrtQ=
X-Received: by 2002:a05:620a:91d:b0:6fa:442d:9a72 with SMTP id v29-20020a05620a091d00b006fa442d9a72mr7035162qkv.487.1667389779254;
        Wed, 02 Nov 2022 04:49:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6D357WNkXQsA8F1Qf+1depCIhRZduzzilE2kN0d/zLKKeF+biT1yrpskbjJybuEEVhju25Qg==
X-Received: by 2002:a05:620a:91d:b0:6fa:442d:9a72 with SMTP id v29-20020a05620a091d00b006fa442d9a72mr7035151qkv.487.1667389778964;
        Wed, 02 Nov 2022 04:49:38 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a400600b006ee8874f5fasm7784855qko.53.2022.11.02.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:49:38 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com,
        Maryam Tahhan <mtahhan@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_CPUMAP
Date:   Wed,  2 Nov 2022 08:44:16 -0400
Message-Id: <20221102124416.2820268-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102124416.2820268-1-mtahhan@redhat.com>
References: <20221102124416.2820268-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 Documentation/bpf/map_cpumap.rst | 140 +++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/bpf/map_cpumap.rst

diff --git a/Documentation/bpf/map_cpumap.rst b/Documentation/bpf/map_cpumap.rst
new file mode 100644
index 000000000000..23320fb61bf7
--- /dev/null
+++ b/Documentation/bpf/map_cpumap.rst
@@ -0,0 +1,140 @@
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
+``BPF_MAP_TYPE_CPUMAP`` is primarily used as a backend map for the XDP BPF
+helpers ``bpf_redirect_map()`` and ``XDP_REDIRECT`` action. This map type redirects raw
+XDP frames to another CPU.
+
+A CPUMAP is a scalability and isolation mechanism that allows the steering of packets
+to dedicated CPUs for processing. An example use-case for this map type is software
+based Receive Side Scaling (RSS).
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
+receives raw``xdp_frame`` objects.
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
+The following code snippet shows how to declare a BPF_MAP_TYPE_CPUMAP called
+cpu_map and how to redirect packets to a remote CPU using a round robin scheme.
+
+.. code-block:: c
+
+   struct {
+        __uint(type, BPF_MAP_TYPE_CPUMAP);
+        __type(key, u32);
+        __type(value, struct bpf_cpumap_val);
+        __uint(max_entries, 12);
+    } cpu_map SEC(".maps");
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __type(key, u32);
+        __type(value, u32);
+        __uint(max_entries, 12);
+    } cpus_available SEC(".maps");
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+        __type(key, u32);
+        __type(value, u32);
+        __uint(max_entries, 1);
+       } cpus_iterator SEC(".maps");
+
+    SEC("xdp")
+    int  xdp_redir_cpu_round_robin(struct xdp_md *ctx)
+    {
+        u32 key = 0;
+        u32 cpu_dest = 0;
+        u32 *cpu_selected, *cpu_iterator;
+        u32 cpu_idx;
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
+References
+===========
+
+- https://elixir.bootlin.com/linux/v6.0.1/source/kernel/bpf/cpumap.c
+- https://developers.redhat.com/blog/2021/05/13/receive-side-scaling-rss-with-ebpf-and-cpumap#redirecting_into_a_cpumap
-- 
2.35.3

