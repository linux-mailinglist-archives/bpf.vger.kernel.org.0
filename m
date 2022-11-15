Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB552629B41
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 14:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKON4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 08:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKON4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 08:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13EE5D
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668520520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eFdL4nhZRxMMTeHllh9QF7/l1CzlEg0rGyJT8FZeWSI=;
        b=Hf3Nga5w9q4t6ngzl4EeHxArzxe6ZluTJSO3pCmWUSK6VZH2nW4Hp5+KkZzBKwctKoqUix
        RTNaHhBHF0OLad5fNckzN/VLPeMATb/JVYHFR1JHJ4VLtYUuwNtCPA+zWv1V6cJ5lZkUXR
        eSHo0139JXjH/6qIrTT0vv1D7lXB4Dw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-02VCrFUxNueRtwit18lqTA-1; Tue, 15 Nov 2022 08:55:19 -0500
X-MC-Unique: 02VCrFUxNueRtwit18lqTA-1
Received: by mail-qk1-f197.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso13709722qkb.19
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 05:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFdL4nhZRxMMTeHllh9QF7/l1CzlEg0rGyJT8FZeWSI=;
        b=wmrAmrWhHn4gDYE3uCnxEcPf32aK/emoqnfswU7/25qpvFrihsUaHYSI5JaQHxX1sP
         KbJXni/qwCQUOb+Ars2/sneZ5UPgod2U4gnY7fqbFsuju2XxUxyQVOvbvjU9bGMvXecr
         bOJnFC7HQB+xGZvBpVlGIV1QfUZOMo2XD76VOV9qZDKYQuVKQL5UsTHI6bmEhfN9BPHb
         50GYJvsLzPqvatE225D1B8V/+6oNyaNzdHw7Spek/RlSzG9GLAoGmcL1ydZtwsYN9jW3
         v9j2sCoi3hR8gg4Tb8wFov9J/Ig7pc9PvQBzRsoJoWmXDTlJfr17jLsoLaMIMUzquqCY
         DKTA==
X-Gm-Message-State: ANoB5plQEslwzNGvJEoylti8vOQFiL0ru1I8cYMWM5OOvhokeno6Dzkx
        jdELj3ZwY/l1hx1jQyJEhi5GzE3sAti91nBlkQ0GuLo6Wu+eBDShTr8AWomI3cXg3az/F06BDoE
        JgSkgLLcfBoi+K7LgdxzW5q3qed0Q+GV6ywocU5a+V9bqo9VSFVhV26ev3ZxNl+w=
X-Received: by 2002:a05:6214:380e:b0:4b4:5d18:40 with SMTP id ns14-20020a056214380e00b004b45d180040mr16797403qvb.67.1668520518546;
        Tue, 15 Nov 2022 05:55:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5CvXlLjd9TkkphnHGxRR4FS12ghCq4c1gxroMaVHLHc+iPXYHgQaxNbC9O3WDZa7bd3Gy0ug==
X-Received: by 2002:a05:6214:380e:b0:4b4:5d18:40 with SMTP id ns14-20020a056214380e00b004b45d180040mr16797369qvb.67.1668520518085;
        Tue, 15 Nov 2022 05:55:18 -0800 (PST)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a44ce00b006fb7c42e73asm3723682qkp.21.2022.11.15.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:55:17 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        bagasdotme@gmail.com, Maryam Tahhan <mtahhan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v9 1/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Tue, 15 Nov 2022 09:49:21 -0500
Message-Id: <20221115144921.165483-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

v8->v9:
- Unqouted XDP_REDIRECT reference.

v7->v8:
- Updated multicast to use description suggested by Toke Høiland-Jørgensen.

v6-v7:
- Got rid of unnecessary initializations in examples.

v5->v6:
- Separate Kernel BPF and userspace functions for devmaps.
- Include some packet/tracepoint debug info in the redirect
  documentation.

v4->v5:
- Remove unused 'index' variable in example.

v3->v4:
- Prepend supported map section for XDP_REDIRECT documentation.

v2->v3:
- Fixed indentations in usage section to exclude non note text.
- Replace links to selftest with actual paths.

v1->v2:
- Separate xdp_redirect documentation to its own file.
- Clean up and simplify examples and usage function descriptions.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 222 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  81 +++++++++++
 net/core/filter.c                |   8 +-
 4 files changed, 310 insertions(+), 2 deletions(-)
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
index 000000000000..f64da348dbfe
--- /dev/null
+++ b/Documentation/bpf/map_devmap.rst
@@ -0,0 +1,222 @@
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
+    - The broadcast feature can also be used to implement multicast forwarding:
+      simply create multiple DEVMAPs, each one corresponding to a single multicast group.
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
+        int ret;
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
+        int ret;
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
index 000000000000..2fa2b0b05004
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
+Silent packet drops for XDP_REDIRECT can be debugged using:
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
2.38.1

