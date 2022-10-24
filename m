Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7260BE35
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 01:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJXXJW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiJXXI5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 19:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE8293092
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666646958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcc9Sl5VWnSbLa3wj196AJrJmz0s6R/mrqufXCIozGw=;
        b=f32mRqaiDLMWAU7PmjBoDnh9/ewbMLDJY3mwEcYZ6fmmLU9+VvHkZYkIU2gzrP6TNlAJqp
        AHMF8eRvezE9g/Yn4a489FzOQ/eFA1tTOm0niA5clR6mKWLH8/LCCh+4b2YzC3VbA545h8
        8tinR8pjbliLyzaxnW8wwbkoIzgjQKg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-sqT1sX9OP8SJe_UokZzxHw-1; Mon, 24 Oct 2022 07:48:42 -0400
X-MC-Unique: sqT1sX9OP8SJe_UokZzxHw-1
Received: by mail-qv1-f69.google.com with SMTP id c6-20020ad44306000000b004bb8352cb4cso281525qvs.14
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 04:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcc9Sl5VWnSbLa3wj196AJrJmz0s6R/mrqufXCIozGw=;
        b=Hn25cVnt9zBv7SV+FcIpZIACMt4Pog8kR3kelGDu/0/YrD58CX/HLD1C8JWF6OAsNL
         ZxOTsUoKFUZZcW5jnFtcCH6FHvWd4HI3WQ8iMz2yI/0UoJzvm50RQnZMscv66wSOHlwx
         MlkSzka/iNzelGp/8ba3Nnii+7AnvsCyAaA285aenXwn3I29/8nBRj2CnoDwZ3kYAaEd
         JdtY8aYq73mMZPo4H2sfmM8MLCkRlcM+ScFyBd+SFdJbeg3aBwvtmoNLrJNR8XFbB+7s
         5mENOu3MmeBwaRPkBxo/A2YYltGNpQveAxx1amzYq0oVoC0AZmM39HeZZ+l7Me2s+OrO
         SkFg==
X-Gm-Message-State: ACrzQf3bDlYOK/5lF4Hsc0hAEsr1KAUte6D5m5v/hUNLagEZIF9w2C+J
        Rz4biiNpUz5mxrN8o7a0OnN3db/TVm6MC+rEDXNEykj6uelysG+bDXQVTXYvyNKSl4ERFjbOxFn
        td7h/s2dKIVmMUoKiZ9h0zTI12A0066nlMh+TRljtldix/ajQzvzduCrGDC0+HhU=
X-Received: by 2002:a05:622a:8cf:b0:39c:dc9b:b3d4 with SMTP id i15-20020a05622a08cf00b0039cdc9bb3d4mr27187080qte.41.1666612121269;
        Mon, 24 Oct 2022 04:48:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4wWNlbK8kiLw+TCAOwXLHhnIqkGp9iFae8JoBf4IYnBsVj9PLSY0/ko1X91ulVAffKrMrmmw==
X-Received: by 2002:a05:622a:8cf:b0:39c:dc9b:b3d4 with SMTP id i15-20020a05622a08cf00b0039cdc9bb3d4mr27187052qte.41.1666612120847;
        Mon, 24 Oct 2022 04:48:40 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a13af00b006ee949b8051sm14653564qki.51.2022.10.24.04.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:48:40 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH bpf-next v5 1/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Mon, 24 Oct 2022 08:43:41 -0400
Message-Id: <20221024124341.2157865-2-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221024124341.2157865-1-mtahhan@redhat.com>
References: <20221024124341.2157865-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 203 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  45 +++++++
 3 files changed, 249 insertions(+)
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
index 000000000000..1c6025ea5fdc
--- /dev/null
+++ b/Documentation/bpf/map_devmap.rst
@@ -0,0 +1,203 @@
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
index 000000000000..ff49a0698707
--- /dev/null
+++ b/Documentation/bpf/redirect.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+============
+XDP_REDIRECT
+============
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
+XDP_REDIRECT is a three-step process, implemented as follows:
+
+1. The ``bpf_redirect()`` and ``bpf_redirect_map()`` helpers will lookup the
+   target of the redirect (from the supported map types) and store it (along with
+   some other metadata) in a per-CPU ``struct bpf_redirect_info``.
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
+References
+===========
+
+- https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4106
-- 
2.35.3

