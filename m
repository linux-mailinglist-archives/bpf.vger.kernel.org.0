Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1862DEA7
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiKQOso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 09:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiKQOsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 09:48:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403C64546
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668696447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BPcjTCAkDZiUNNJDjXg6Uw2BjOdtcP/Vh8oJTRYt/tM=;
        b=g0uGtAHk7h6op0gRTUyx+U7EWt0HEgGP++arC0Qyzamh6UjNHOn/RHZzIv4IqUGE4CYtaz
        unBM3qCU+d3VUTJu1cHlhGDQCY2G1DsBGqNadL7J+LOqXOYhEzTfIA3uBarw1hjHVP6tvE
        1sAN5aeQcC8A0sJp1GlebqeMAbjaCK0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-oaxf7hEJPveaAg3JpDhcng-1; Thu, 17 Nov 2022 09:47:26 -0500
X-MC-Unique: oaxf7hEJPveaAg3JpDhcng-1
Received: by mail-qt1-f197.google.com with SMTP id gc12-20020a05622a59cc00b003a5444280e1so1828619qtb.13
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPcjTCAkDZiUNNJDjXg6Uw2BjOdtcP/Vh8oJTRYt/tM=;
        b=3U6AWa6nvaU5msFu7oaElN1zSK+PGkDF+pHWHaLEih9rGA6HYdOJ9eLfwXXIyisu0+
         pWBK6+uQKXmGEYaT9M3bX5JfLfTbV3zJbD8arm0Ne9i/S9pGuKH98qZFcm1ce8JV4gqD
         9VXxchzsFvVxLaebYaI5oXkQBoqv1Z/pboQdBrdYQYTCMmsu0WmpVXDJFaSQtsjoDdkp
         242l7ccMlbfEVgeAY1llyYccrfcoLLVXXForSbJEdNL9bR8MIR7wVWj6kwHMG0UY1K3x
         mU7F8dTj2nRSsIDt1VYMGc55b0chnwduc9FfeRMVvBLxBiLwCuMspsAex4T2vOG9/7Cg
         O8HA==
X-Gm-Message-State: ANoB5pmKQ1aLzaV0qXzjkCDhYdYjg03UMYC/wmHbp3rbViq9jQle4zXP
        ktzVKTvTcl2n/EIbGr69kRDUDF7MF5xreOvfLjFP5TQ/G8HjdWTAxfAXDi+Uk3vpqWWWxznGJwI
        /0me1T9K9w3iKmqAjLHXg7emfMs4/nKamyn5++O86U2LAximxMSuV4MYMQ6tRqc4=
X-Received: by 2002:a0c:8051:0:b0:4bb:6c84:62bc with SMTP id 75-20020a0c8051000000b004bb6c8462bcmr2664237qva.80.1668696445406;
        Thu, 17 Nov 2022 06:47:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4+ooNIrNxHzEP8UphiXOR2RBI49QhmDJsm6ZhSpIFjYdZ+r1l44Hchf02OVaHnqLpc+yCEZA==
X-Received: by 2002:a0c:8051:0:b0:4bb:6c84:62bc with SMTP id 75-20020a0c8051000000b004bb6c8462bcmr2664206qva.80.1668696445049;
        Thu, 17 Nov 2022 06:47:25 -0800 (PST)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id bm3-20020a05620a198300b006ecfb2c86d3sm534058qkb.130.2022.11.17.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:47:24 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        magnus.karlsson@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_XSKMAP
Date:   Thu, 17 Nov 2022 10:44:46 -0500
Message-Id: <20221117154446.3684330-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.38.1
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

Add documentation for BPF_MAP_TYPE_XSKMAP
including kernel version introduced, usage
and examples.

Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

---
v2:
- Fixed typos + incorrect return type references.
- Adjusted examples to use __u32 and fixed references to key_size.
- Changed `AF_XDP socket` references to XSK.
- Added note re map key and value size.
---
 Documentation/bpf/map_xskmap.rst | 167 +++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/bpf/map_xskmap.rst

diff --git a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
new file mode 100644
index 000000000000..4fd2f58aa629
--- /dev/null
+++ b/Documentation/bpf/map_xskmap.rst
@@ -0,0 +1,167 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+===================
+BPF_MAP_TYPE_XSKMAP
+===================
+
+.. note::
+   - ``BPF_MAP_TYPE_XSKMAP`` was introduced in kernel version 4.18
+
+The ``BPF_MAP_TYPE_XSKMAP`` is used as a backend map for XDP BPF helper
+call ``bpf_redirect_map()`` and ``XDP_REDIRECT`` action, like 'devmap' and 'cpumap'.
+This map type redirects raw XDP frames to AF_XDP sockets (XSKs). An AF_XDP socket
+binds to a single netdev queue. A mapping of XSKs to queues is shown below:
+
+.. code-block:: none
+
+    +---------------------------------------------------+
+    |     xsk A      |     xsk B       |      xsk C     |<---+ Userspace
+    =========================================================|==========
+    |    Queue 0     |     Queue 1     |     Queue 2    |    |  Kernel
+    +---------------------------------------------------+    |
+    |                  Netdev eth0                      |    |
+    +---------------------------------------------------+    |
+    |                            +=============+        |    |
+    |                            | key |  xsk  |        |    |
+    |  +---------+               +=============+        |    |
+    |  |         |               |  0  | xsk A |        |    |
+    |  |         |               +-------------+        |    |
+    |  |         |               |  1  | xsk B |        |    |
+    |  | eBPF    |-- redirect -->+-------------+-------------+
+    |  | prog    |               |  2  | xsk C |        |
+    |  |         |               +-------------+        |
+    |  |         |                                      |
+    |  |         |                                      |
+    |  +---------+                                      |
+    |                                                   |
+    +---------------------------------------------------+
+
+.. note::
+    An AF_XDP socket that is bound to a certain <netdev/queue_id> will *only*
+    accept XDP frames from that <netdev/queue_id>. If an XDP program tries to redirect
+    from a <netdev/queue_id> other than what the socket is bound to, the frame will
+    not be received on the socket.
+
+Typically a XSKMAP is created per netdev. This map contains an array of XSK File
+Descriptors (FDs). The number of array elements is typically set or adjusted using
+the ``max_entries`` map parameter. For AF_XDP ``max_entries`` is equal to the number
+of queues supported by the netdev.
+
+.. note::
+    Both the map key and map value size must be 4 bytes.
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
+ For ``BPF_MAP_TYPE_XSKMAP`` this map contains references to XSK FDs
+ for sockets attached to a netdev's queues.
+
+ .. note::
+    If the map is empty at an index, the packet is dropped. This means that it is
+    necessary to have an XDP program loaded with at least one XSK in the
+    XSKMAP to be able to get any traffic to user space through the socket.
+
+.. c:function::
+    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+ XSK entry references of type ``struct xdp_sock *`` can be retrieved using the
+ ``bpf_map_lookup_elem()`` helper.
+
+Userspace
+---------
+.. note::
+    XSK entries can only be updated/deleted from user space and not from
+    an eBPF program. Trying to call these functions from a kernel eBPF program will
+    result in the program failing to load and a verifier warning.
+
+.. c:function::
+	int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
+
+ XSK entries can be added or updated using the ``bpf_map_update_elem()``
+ helper. The ``key`` parameter is equal to the queue_id of the queue the XSK
+ is attaching to. And the ``value`` parameter is the FD value of that socket.
+
+ Under the hood, the XSKMAP update function uses the XSK FD value to retrieve the
+ associated ``struct xdp_sock`` instance.
+
+ The flags argument can be one of the following:
+
+  - BPF_ANY: Create a new element or update an existing element.
+  - BPF_NOEXIST: Create a new element only if it did not exist.
+  - BPF_EXIST: Update an existing element.
+
+.. c:function::
+    int bpf_map_lookup_elem(int fd, const void *key, void *value)
+
+  Returns ``struct xdp_sock *`` or negative error in case of failure.
+
+.. c:function::
+    int bpf_map_delete_elem(int fd, const void *key)
+
+ XSK entries can be deleted using the ``bpf_map_delete_elem()``
+ helper. This helper will return 0 on success, or negative error in case of
+ failure.
+
+.. note::
+    When `libxdp`_ deletes a XSK it also removes the associated socket
+    entry from the XSKMAP.
+
+Examples
+========
+Kernel
+------
+
+The following code snippet shows how to declare a ``BPF_MAP_TYPE_XSKMAP`` called
+``xsks_map`` and how to redirect packets to a XSK.
+
+.. code-block:: c
+
+   struct {
+        __uint(type, BPF_MAP_TYPE_XSKMAP);
+        __type(key, __u32);
+        __type(value, __u32);
+        __uint(max_entries, 64);
+    } xsks_map SEC(".maps");
+
+
+    SEC("xdp")
+    int xsk_redir_prog(struct xdp_md *ctx)
+    {
+        __u32 index = ctx->rx_queue_index;
+
+        if (bpf_map_lookup_elem(&xsks_map, &index))
+            return bpf_redirect_map(&xsks_map, index, 0);
+        return XDP_PASS;
+    }
+
+Userspace
+---------
+
+The following code snippet shows how to update a XSKMAP with a XSK entry.
+
+.. code-block:: c
+
+    int update_xsks_map(struct bpf_map *xsks_map, int queue_id, int xsk_fd)
+    {
+        int ret;
+
+        ret = bpf_map_update_elem(bpf_map__fd(xsks_map), &queue_id, &xsk_fd, 0);
+        if (ret < 0) {
+            fprintf(stderr, "Failed to update xsks_map: %s\n",
+                strerror(errno));
+        }
+
+        return ret;
+    }
+
+.. note::
+    The most comprehensive resource for using XSKMAPs is `libxdp`_.
+
+.. _libxdp: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp
-- 
2.38.1

