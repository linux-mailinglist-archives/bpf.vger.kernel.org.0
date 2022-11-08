Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD356219D8
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 17:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiKHQzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 11:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiKHQzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 11:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ABD22538
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667926456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yT5CT3CE8cx3Cmdsmk9ITCoXgAwEgNVGTFZhVA9hU1U=;
        b=cZK7m/qcQTZCDaKIfOGBtxq7sl4nsFuj3AUF2ANTKiatGHObNhi022uUvXKl3g2FBi1/Xm
        tqlyg4U5S7W7OHPE/L0kN8oURlkF2hBZeQY6byoiWvjwEyuH69g+ug9KzUUrXU7mQpKBhW
        N1XQvLSFdfeg9R3brPSsc3TtaaUi6is=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-bcc_eMN1M3S04-cgCdSFCw-1; Tue, 08 Nov 2022 11:54:15 -0500
X-MC-Unique: bcc_eMN1M3S04-cgCdSFCw-1
Received: by mail-qv1-f69.google.com with SMTP id z18-20020a0cfed2000000b004bc28af6f7dso9973038qvs.4
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 08:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT5CT3CE8cx3Cmdsmk9ITCoXgAwEgNVGTFZhVA9hU1U=;
        b=Xj2aVyaKmWFFS3g35Qrh4ClPPz3Fgmu/pr8Rb8npaWAHm7TUkzqauDbnyT1MtFR597
         caYAcUOUwpmSNnNQEiFTaNzkoPUHabOKkJeNon4+gNtCLhdd0vpmBdhlCnsn5ILUIj6R
         cOQGEPMFr8q59WB2JIGPcGBl6KlClWyuS5G/oTUQjCfoIwP4IB87hWva1D3+QfFN0Svo
         Tq09RucHzfKRYlD+3mMoHVP+uGVJDF9WsxynasMY8HyopGlsQB8jDikV7IA69QSyFiMg
         pWo1/tZh5G2fle6/X+Wh0VQjbBiSig2DUWmJpxIycqzfgsyu4XWDFLQKHrqiO5hNbDo7
         CXlw==
X-Gm-Message-State: ACrzQf2WMKzxlGDCx2K95w1RQ3jRnH4LvNt+g8CjdtMs0d4TwYtcfmod
        FJ5iPIjoLIYX7dNuJpWG91SBsdgj4kQ1HkpNY8R45gPCbnOWLe9lj+NGxXSZbpzeGKUjLfR1Pvp
        qca7LJJRDTTuk9ssf7Zo5AYx7oPUExbhKtBdwM+AD6z2+OP+fccltZAb9IN4GxII=
X-Received: by 2002:a05:6214:19ea:b0:4bc:1388:8d7c with SMTP id q10-20020a05621419ea00b004bc13888d7cmr36370597qvc.84.1667926454340;
        Tue, 08 Nov 2022 08:54:14 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7gflIR+WWnr2ezFkR+zPceQbz3P0QSlD23uYIniu7OIiXNyTtLDp7SN4h+TplfU/5oshzHjA==
X-Received: by 2002:a05:6214:19ea:b0:4bc:1388:8d7c with SMTP id q10-20020a05621419ea00b004bc13888d7cmr36370567qvc.84.1667926453930;
        Tue, 08 Nov 2022 08:54:13 -0800 (PST)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id h18-20020ac85852000000b003a57eb7f212sm7444579qth.10.2022.11.08.08.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 08:54:13 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v6 1/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Tue,  8 Nov 2022 12:48:33 -0500
Message-Id: <20221108174833.1106947-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221108174833.1106947-1-mtahhan@redhat.com>
References: <20221108174833.1106947-1-mtahhan@redhat.com>
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

Add documentation for BPF_MAP_TYPE_DEVMAP and
BPF_MAP_TYPE_DEVMAP_HASH including kernel version
introduced, usage and examples.

Add documentation that describes XDP_REDIRECT.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
---
 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 221 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  81 +++++++++++
 net/core/filter.c                |   8 +-
 4 files changed, 309 insertions(+), 2 deletions(-)
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
index 000000000000..77a7a10ee1b6
--- /dev/null
+++ b/Documentation/bpf/map_devmap.rst
@@ -0,0 +1,221 @@
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
+is backed by a hash table that uses a key to lookup a reference to a net device.
+The user provides either <``key``/ ``ifindex``> or <``key``/ ``struct bpf_devmap_val``>
+pairs to update the maps with new net devices.
+
+.. note::
+    - The key to a hash map doesn't have to be an ``ifindex``.
+    - While ``BPF_MAP_TYPE_DEVMAP_HASH`` allows for densely packing the net devices
+      it comes at the cost of a hash of the key when performing a look up.
+
+The setup and packet enqueue/send code is shared between the two types of
+devmap; only the lookup and insertion is different.
+
+Usage
+=====
+Kernel BPF
+----------
+.. c:function::
+     long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+
+Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
+For ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` this map contains
+references to net devices (for forwarding packets through other ports).
+
+The lower two bits of *flags* are used as the return code if the map lookup
+fails. This is so that the return value can be one of the XDP program return
+codes up to ``XDP_TX``, as chosen by the caller. The higher bits of ``flags``
+can be set to ``BPF_F_BROADCAST`` or ``BPF_F_EXCLUDE_INGRESS`` as defined
+below.
+
+With ``BPF_F_BROADCAST`` the packet will be broadcast to all the interfaces
+in the map, with ``BPF_F_EXCLUDE_INGRESS`` the ingress interface will be excluded
+from the broadcast.
+
+.. note::
+    - The key is ignored if BPF_F_BROADCAST is set.
+    - Multicast can also be achieved using multiple DEVMAPs.
+
+This helper will return ``XDP_REDIRECT`` on success, or the value of the two
+lower bits of the ``flags`` argument if the map lookup fails.
+
+More information about redirection can be found :doc:`redirect`
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
+helper.
+
+Userspace
+---------
+.. note::
+    DEVMAP entries can only be updated/deleted from user space and not
+    from an eBPF program. Trying to call these functions from a kernel eBPF
+    program will result in the program failing to load and a verifier warning.
+
+.. c:function::
+   int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags);
+
+ Net device entries can be added or updated using the ``bpf_map_update_elem()``
+ helper. This helper replaces existing elements atomically. The ``value`` parameter
+ can be ``struct bpf_devmap_val`` or a simple ``int ifindex`` for backwards
+ compatibility.
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
+ The ``flags`` argument can be one of the following:
+
+  - ``BPF_ANY``: Create a new element or update an existing element.
+  - ``BPF_NOEXIST``: Create a new element only if it did not exist.
+  - ``BPF_EXIST``: Update an existing element.
+
+ DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
+ to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
+ access to both Rx device and Tx device. The  program associated with the ``fd``
+ must have type XDP with expected attach type ``xdp_devmap``.
+ When a program is associated with a device index, the program is run on an
+ ``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
+ of how to attach/use xdp_devmap progs can be found in the kernel selftests:
+
+ - ``tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c``
+ - ``tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c``
+
+.. c:function::
+   int bpf_map_lookup_elem(int fd, const void *key, void *value);
+
+ Net device entries can be retrieved using the ``bpf_map_lookup_elem()``
+ helper.
+
+.. c:function::
+   int bpf_map_delete_elem(int fd, const void *key);
+
+ Net device entries can be deleted using the ``bpf_map_delete_elem()``
+ helper. This helper will return 0 on success, or negative error in case of
+ failure.
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
+would work with a user space program that populates the devmap ``forward_map`` based
+on ingress ifindexes. The BPF program (below) is redirecting packets using the
+ingress ``ifindex`` as the ``key``.
+
+.. code-block:: c
+
+    SEC("xdp")
+    int xdp_redirect_map_func(struct xdp_md *ctx)
+    {
+        int index = ctx->ingress_ifindex;
+
+        return bpf_redirect_map(&forward_map, index, 0);
+    }
+
+The following code snippet shows a BPF program that is broadcasting packets to
+all the interfaces in the ``tx_port`` devmap.
+
+.. code-block:: c
+
+    SEC("xdp")
+    int xdp_redirect_map_func(struct xdp_md *ctx)
+    {
+        return bpf_redirect_map(&tx_port, 0, BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS);
+    }
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
index 000000000000..9440a913c185
--- /dev/null
+++ b/Documentation/bpf/redirect.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+========
+Redirect
+========
+XDP_REDIRECT
+############
+Supported maps
+--------------
+
+XDP_REDIRECT works with the following map types:
+
+- ``BPF_MAP_TYPE_DEVMAP``
+- ``BPF_MAP_TYPE_DEVMAP_HASH``
+- ``BPF_MAP_TYPE_CPUMAP``
+- ``BPF_MAP_TYPE_XSKMAP``
+
+For more information on these maps, please see the specific map documentation.
+
+Process
+-------
+
+.. kernel-doc:: net/core/filter.c
+   :doc: xdp redirect
+
+.. note::
+    Not all drivers support transmitting frames after a redirect, and for
+    those that do, not all of them support non-linear frames. Non-linear xdp
+    bufs/frames are bufs/frames that contain more than one fragment.
+
+Debugging packet drops
+----------------------
+Silent packet drops for ``XDP_REDIRECT`` can be debugged using:
+
+- bpf_trace
+- perf_record
+
+bpf_trace
+^^^^^^^^^
+The following bpftrace command can be used to capture and count all XDP tracepoints:
+
+.. code-block:: none
+
+    sudo bpftrace -e 'tracepoint:xdp:* { @cnt[probe] = count(); }'
+    Attaching 12 probes...
+    ^C
+
+    @cnt[tracepoint:xdp:mem_connect]: 18
+    @cnt[tracepoint:xdp:mem_disconnect]: 18
+    @cnt[tracepoint:xdp:xdp_exception]: 19605
+    @cnt[tracepoint:xdp:xdp_devmap_xmit]: 1393604
+    @cnt[tracepoint:xdp:xdp_redirect]: 22292200
+
+.. note::
+    The various xdp tracepoints can be found in ``source/include/trace/events/xdp.h``
+
+The following bpftrace command can be used to extract the ``ERRNO`` being returned as
+part of the err parameter:
+
+.. code-block:: none
+
+    sudo bpftrace -e \
+    'tracepoint:xdp:xdp_redirect*_err {@redir_errno[-args->err] = count();}
+    tracepoint:xdp:xdp_devmap_xmit {@devmap_errno[-args->err] = count();}'
+
+perf record
+^^^^^^^^^^^
+The perf tool also supports recording tracepoints:
+
+.. code-block:: none
+
+    perf record -a -e xdp:xdp_redirect_err \
+        -e xdp:xdp_redirect_map_err \
+        -e xdp:xdp_exception \
+        -e xdp:xdp_devmap_xmit
+
+References
+===========
+
+- https://github.com/xdp-project/xdp-tutorial/tree/master/tracing02-xdp-monitor
diff --git a/net/core/filter.c b/net/core/filter.c
index bb0136e7a8e4..d582cb025f4c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4104,7 +4104,10 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
-/* XDP_REDIRECT works by a three-step process, implemented in the functions
+/**
+ * DOC: xdp redirect
+ *
+ * XDP_REDIRECT works by a three-step process, implemented in the functions
  * below:
  *
  * 1. The bpf_redirect() and bpf_redirect_map() helpers will lookup the target
@@ -4119,7 +4122,8 @@ static const struct bpf_func_proto bpf_xdp_adjust_meta_proto = {
  * 3. Before exiting its NAPI poll loop, the driver will call xdp_do_flush(),
  *    which will flush all the different bulk queues, thus completing the
  *    redirect.
- *
+ */
+/*
  * Pointers to the map entries will be kept around for this whole sequence of
  * steps, protected by RCU. However, there is no top-level rcu_read_lock() in
  * the core code; instead, the RCU protection relies on everything happening
-- 
2.35.3

