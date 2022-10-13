Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9C5FD7AC
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 12:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJMKQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJMKQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 06:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1DFEA6AE
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665656163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyOh5IE5da6lzhgTjUAARlUOlXyArSrFTePf4CQIznI=;
        b=Ifr5pASYLzJC1Bf4y251ZB/Dzg+N/Hn1NLY2xQ2bOlx2VXfgbb+Ndb5ptxk4b798O5nOa8
        y5Yf1Fwdykb3XtrZCszzVXtRF2b5dRxFzpJk11wwme9Gqna/QFk5xe1MB/+Z7ovtD38pIk
        B8UKiUjO4amMO1azRCI9U97J1N5CP3k=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-LH9Mkv9gMXG3ILoebfX_Bg-1; Thu, 13 Oct 2022 06:16:02 -0400
X-MC-Unique: LH9Mkv9gMXG3ILoebfX_Bg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-132e28ef8faso907203fac.0
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 03:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyOh5IE5da6lzhgTjUAARlUOlXyArSrFTePf4CQIznI=;
        b=HhKeZSjvWQs6OX7/gcU80hdDU4MxGbqtWvyy011OtZgZu0bHRy/Z+HhETbQGVGkOp2
         9nWNm+x+Lb/MNf9tWx5/daH7yoAsu0SXJAyh1axa9Kz99k5eTEZezqCjBz4L+FASeRn0
         ut5Hb2SiCNPjqRCbtzD6lEwnMO6Nmt+sKpZ0HcI2EoPyI1d6N3jVqAjyGUoyXHqKF0zr
         1DnSoF2m0oUsoyDWjTkPaL8+8H3WP9a0E87LA/h2xZiIJltoxWe7QLNsayj+RWf3JwVH
         bF6RxOWgwASjiSRS/B/Pv8NGdwcIF4zsfp+M7mY8r8d+IXtqPn/+xfGEhSkrVUjTrqVe
         Hiyg==
X-Gm-Message-State: ACrzQf1Y1KfYfKZReme6qP1DXZKWP58LOyfGqBfCHImyMP4kD4cCkw8A
        Ob0ik533mOhcMBkFC/WpdwwkW243q4x53VAeBiQCbQc1EUcNZDoQ0/LI4hDiVWDZMsWurbRa6km
        V7uHjr9d1iptNQrS6Kpicyupeodj8/9t1RlMc1HiA/LEg+BWPvCkWl3EzkAdQvc4=
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id k16-20020a0568080e9000b0034549f2a112mr4282889oil.7.1665656161267;
        Thu, 13 Oct 2022 03:16:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM787W3E+iseBE3MbhxdvuNVMEUfi7cpcQQ0u01921AkDHI0tmAn8dW8UjlKa99DEMdM+oLd4Q==
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id k16-20020a0568080e9000b0034549f2a112mr4282871oil.7.1665656160834;
        Thu, 13 Oct 2022 03:16:00 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id f187-20020aca38c4000000b00354732338desm5034605oia.17.2022.10.13.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 03:16:00 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v2 1/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Thu, 13 Oct 2022 07:11:29 -0400
Message-Id: <20221013111129.401325-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221013111129.401325-1-mtahhan@redhat.com>
References: <20221013111129.401325-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_DEVMAP and
BPF_MAP_TYPE_DEVMAP_HASH including kernel version
introduced, usage and examples.

Add documentation that describes XDP_REDIRECT.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 192 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  46 ++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 1b50de1983ee..1088d44634d6 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -29,6 +29,7 @@ that goes into great technical depth about the BPF Architecture.
    clang-notes
    linux-notes
    other
+   redirect
 
 .. only::  subproject and html
 
diff --git a/Documentation/bpf/map_devmap.rst b/Documentation/bpf/map_devmap.rst
new file mode 100644
index 000000000000..bdba55640f4c
--- /dev/null
+++ b/Documentation/bpf/map_devmap.rst
@@ -0,0 +1,192 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+=================================================
+BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_DEVMAP_HASH
+=================================================
+
+.. note::
+   - ``BPF_MAP_TYPE_DEVMAP`` was introduced in kernel version 4.14
+   - ``BPF_MAP_TYPE_DEVMAP_HASH`` was introduced in kernel version 5.4
+
+``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` are BPF maps primarily
+used as backend maps for the XDP BPF helper call ``bpf_redirect_map()``.
+``BPF_MAP_TYPE_DEVMAP`` is backed by an array that uses the key as
+the index to lookup a reference to a net device. While ``BPF_MAP_TYPE_DEVMAP_HASH``
+is backed by a hash table that uses the ``ifindex`` as the key to lookup a reference
+to a net device. The user provides either <``key``/ ``ifindex``> or
+<``key``/ ``struct bpf_devmap_val``> pairs to update the maps with new net devices.
+
+.. note::
+    While ``BPF_MAP_TYPE_DEVMAP_HASH`` allows for densely packing the net devices
+    it comes at the cost of a hash of the key when performing a look up.
+
+The setup and packet enqueue/send code is shared between the two types of
+devmap; only the lookup and insertion is different.
+
+Usage
+=====
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
+
+ Net device entries can be added or updated using the ``bpf_map_update_elem()``
+ helper. This helper replaces existing elements atomically. The ``value`` parameter
+ can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
+ compatibility.
+
+.. note::
+    The maps can only be updated from user space and not from a BPF program.
+
+ .. code-block:: c
+
+    struct bpf_devmap_val {
+        __u32 ifindex;   /* device index */
+        union {
+            int   fd;  /* prog fd on map write */
+            __u32 id;  /* prog id on map read */
+        } bpf_prog;
+    };
+
+ DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
+ to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
+ access to both Rx device and Tx device. The  program associated with the ``fd``
+ must have type XDP with expected attach type ``xdp_devmap``.
+ When a program is associated with a device index, the program is run on an
+ ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
+ of how to attach/use xdp_devmap progs can be found in the kernel selftests:
+
+ - test_xdp_with_devmap_helpers_
+ - xdp_devmap_attach_
+
+.. _xdp_devmap_attach: https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c
+.. _test_xdp_with_devmap_helpers: https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+ net device entries can be retrieved using the ``bpf_map_lookup_elem()``
+ helper.
+
+.. c:function::
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+ net device entries can be deleted using the ``bpf_map_delete_elem()``
+ helper. This helper will return 0 on success, or negative error in case of
+ failure.
+
+.. c:function::
+     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+
+ Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
+ For ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` this map contains
+ references to net devices (for forwarding packets through other ports).
+
+ The lower two bits of *flags* are used as the return code if the map lookup
+ fails. This is so that the return value can be one of the XDP program return
+ codes up to ``XDP_TX``, as chosen by the caller. The higher bits of ``flags``
+ can be set to ``BPF_F_BROADCAST`` or ``BPF_F_EXCLUDE_INGRESS`` as defined
+ below.
+
+ With ``BPF_F_BROADCAST`` the packet will be broadcast to all the interfaces
+ in the map, with ``BPF_F_EXCLUDE_INGRESS`` the ingress interface will be excluded
+ from the broadcast.
+
+ This helper will return ``XDP_REDIRECT`` on success, or the value of the two
+ lower bits of the *flags* argument if the map lookup fails.
+
+ More information about redirection can be found :doc:`redirect`
+
+Examples
+========
+
+Kernel BPF
+----------
+
+The following code snippet shows how to declare a ``BPF_MAP_TYPE_DEVMAP``
+called tx_port.
+
+.. code-block:: c
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_DEVMAP);
+        __type(key, __u32);
+        __type(value, __u32);
+        __uint(max_entries, 256);
+    } tx_port SEC(".maps");
+
+The following code snippet shows how to declare a ``BPF_MAP_TYPE_DEVMAP_HASH``
+called forward_map.
+
+.. code-block:: c
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
+        __type(key, __u32);
+        __type(value, struct bpf_devmap_val);
+        __uint(max_entries, 32);
+    } forward_map SEC(".maps");
+
+.. note::
+
+    The value type in the DEVMAP above is a ``struct bpf_devmap_val``
+
+The following code snippet shows a simple xdp_redirect_map program. This program
+would work with a user space program that populates the devmap ``tx_port`` based
+on ingress ifindexes. The BPF program (below) is redirecting packets using the
+ingress ifindex as the ``key``.
+
+.. code-block:: c
+
+    SEC("xdp")
+    int xdp_redirect_map_func(struct xdp_md *ctx)
+    {
+        int index = ctx->ingress_ifindex;
+
+        return bpf_redirect_map(&tx_port, index, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
+    }
+
+
+User space
+----------
+
+The following code snippet shows how to update a devmap called ``tx_port``.
+
+.. code-block:: c
+
+    int update_devmap(int ifindex, int redirect_ifindex)
+    {
+        int ret = -1;
+
+        ret = bpf_map_update_elem(bpf_map__fd(tx_port), &ifindex, &redirect_ifindex, 0);
+        if (ret < 0) {
+            fprintf(stderr, "Failed to update devmap_ value: %s\n",
+                strerror(errno));
+        }
+
+        return ret;
+    }
+
+The following code snippet shows how to update a hash_devmap called ``forward_map``.
+
+.. code-block:: c
+
+    int update_devmap(int ifindex, int redirect_ifindex)
+    {
+        struct bpf_devmap_val devmap_val = { .ifindex = redirect_ifindex };
+        int ret = -1;
+
+        ret = bpf_map_update_elem(bpf_map__fd(forward_map), &ifindex, &devmap_val, 0);
+        if (ret < 0) {
+            fprintf(stderr, "Failed to update devmap_ value: %s\n",
+                strerror(errno));
+        }
+        return ret;
+    }
+
+References
+===========
+
+- https://lwn.net/Articles/728146/
+- https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=6f9d451ab1a33728adb72d7ff66a7b374d665176
+- https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
diff --git a/Documentation/bpf/redirect.rst b/Documentation/bpf/redirect.rst
new file mode 100644
index 000000000000..5a0377a67ff0
--- /dev/null
+++ b/Documentation/bpf/redirect.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+============
+XDP_REDIRECT
+============
+
+XDP_REDIRECT works by a three-step process, implemented as follows:
+
+1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will lookup the
+   target of the redirect and store it (along with some other metadata) in a
+   per-CPU ``struct bpf_redirect_info``. This is where the maps above come into
+   play.
+
+2. When the program returns the ``XDP_REDIRECT`` return code, the driver will
+   call ``xdp_do_redirect()`` which will use the information in ``struct
+   bpf_redirect_info`` to actually enqueue the frame into a map type-specific
+   bulk queue structure.
+
+3. Before exiting its NAPI poll loop, the driver will call ``xdp_do_flush()``,
+   which will flush all the different bulk queues, thus completing the
+   redirect.
+
+Pointers to the map entries will be kept around for this whole sequence of
+steps, protected by RCU. However, there is no top-level ``rcu_read_lock()`` in
+the core code; instead, the RCU protection relies on everything happening
+inside a single NAPI poll sequence.
+
+.. note::
+    Not all drivers support transmitting frames after a redirect, and for
+    those that do, not all of them support non-linear frames. Non-linear xdp
+    bufs/frames are bufs/frames that contain more than one fragment.
+
+XDP_REDIRECT works with the following map types:
+
+- BPF_MAP_TYPE_DEVMAP
+- BPF_MAP_TYPE_DEVMAP_HASH
+- BPF_MAP_TYPE_CPUMAP
+- BPF_MAP_TYPE_XSKMAP
+
+For more information on these maps, please see the specific map documentation.
+
+References
+===========
+
+- https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
-- 
2.35.3

