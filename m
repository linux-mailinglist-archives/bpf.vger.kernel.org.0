Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C176075FD
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 13:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJULU6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 07:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJULU4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 07:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C9823AB7B
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666351252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sb0BcC4/5Ac0WvTflqwfXKqR5u/K/9BOgUPKvfz3eHU=;
        b=bHJqREV9VwgKLoI4BVHXxfMAQHfiDz3Lt/ADoZy9H9HucrMli+iXRtYFOpWMtJbXxAY2ud
        OEg8T7Eqp6Uw43tj837diq7lguAkHfGhqH4guWjYZX1At4eUCP/PcnAlE60YHnQ/j3eWxE
        wNSPzNwO3mZZP++c/UgRtjv2szSCd0c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-nmlx0sXqMrab-wejjuG6_A-1; Fri, 21 Oct 2022 07:20:52 -0400
X-MC-Unique: nmlx0sXqMrab-wejjuG6_A-1
Received: by mail-qk1-f200.google.com with SMTP id de21-20020a05620a371500b006eed31abb72so3240314qkb.6
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 04:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sb0BcC4/5Ac0WvTflqwfXKqR5u/K/9BOgUPKvfz3eHU=;
        b=1U36z1uvbByM+nrp9HKfHTKKfC4zkUwHVrz8DezaCQIyojWQrdBP/ZldFgTHrBrroK
         WodQzd9RJ01JiOA8LFEZOKbYLIuB577rYmlbqzxf0euCNXcB7VJWW/G71LpXfB+mUbuR
         r3UlGZKlxC+hJbUK+H3n5iflU1kb50DrxFNvr/Bo7hXQTEb39K8G5dymuuCRpZNfN8qv
         QdbYrqGExiTK9TRe3q1NNJNMbxEr5WPuuvjhDhTUsL87zTcEoec8Sw23TXzrVidykhoN
         EO054Rzun1GbSDLW3H6i/UnPlViV/+df7sZ9ejGjQyWUnB+EE+AsaTXSBnz9jDY6H/Kc
         Sk5g==
X-Gm-Message-State: ACrzQf3lyPNH9hWMpQGEywH61isQIl3Zw4bi4QLICz1D/1ALRcYBL0OV
        N4rKEbpQPNtWYiFQep/jduwQBob463tPLf8u6PFhnTJM3ftCn6UQyBBBhxvPfJXtBlfb7bzksG2
        /3hOmYv95iB/CkcRirxH/rG9WQx4qEl8bmav3IIFSedX4PU93ax+OryugQJI3AjM=
X-Received: by 2002:a05:620a:2b83:b0:6ee:bbcd:5360 with SMTP id dz3-20020a05620a2b8300b006eebbcd5360mr13251752qkb.584.1666351251256;
        Fri, 21 Oct 2022 04:20:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VNHeCF7YxiajeVvYbucTJasS/84NN2QhN9o1FjpAdEJdubFtXcMtEsmldmEVLOXoobJBpaQ==
X-Received: by 2002:a05:620a:2b83:b0:6ee:bbcd:5360 with SMTP id dz3-20020a05620a2b8300b006eebbcd5360mr13251731qkb.584.1666351250803;
        Fri, 21 Oct 2022 04:20:50 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id c25-20020ac81119000000b003996aa171b9sm7766604qtj.97.2022.10.21.04.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 04:20:50 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v3 1/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Fri, 21 Oct 2022 08:15:57 -0400
Message-Id: <20221021121557.3486894-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221021121557.3486894-1-mtahhan@redhat.com>
References: <20221021121557.3486894-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
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
 Documentation/bpf/map_devmap.rst | 205 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  41 +++++++
 3 files changed, 247 insertions(+)
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
index 000000000000..5072ea6086e4
--- /dev/null
+++ b/Documentation/bpf/map_devmap.rst
@@ -0,0 +1,205 @@
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
+.. code-block:: c
+
+    struct bpf_devmap_val {
+        __u32 ifindex;   /* device index */
+        union {
+            int   fd;  /* prog fd on map write */
+            __u32 id;  /* prog id on map read */
+        } bpf_prog;
+    };
+
+DEVMAPs can associate a program with a device entry by adding a ``bpf_prog.fd``
+to ``struct bpf_devmap_val``. Programs are run after ``XDP_REDIRECT`` and have
+access to both Rx device and Tx device. The  program associated with the ``fd``
+must have type XDP with expected attach type ``xdp_devmap``.
+When a program is associated with a device index, the program is run on an
+``XDP_REDIRECT`` and before the buffer is added to the per-cpu queue. Examples
+of how to attach/use xdp_devmap progs can be found in the kernel selftests:
+
+- ``tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c``
+- ``tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c``
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+net device entries can be retrieved using the ``bpf_map_lookup_elem()``
+helper.
+
+.. c:function::
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+net device entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case of
+failure.
+
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
+    The key is ignored if BPF_F_BROADCAST is set.
+
+This helper will return ``XDP_REDIRECT`` on success, or the value of the two
+lower bits of the *flags* argument if the map lookup fails.
+
+More information about redirection can be found :doc:`redirect`
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
+        int index = ctx->ingress_ifindex;
+
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
index 000000000000..9f66bae7982e
--- /dev/null
+++ b/Documentation/bpf/redirect.rst
@@ -0,0 +1,41 @@
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

