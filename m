Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A26A63540E
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 10:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiKWJBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 04:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiKWJBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 04:01:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A51ECCE8
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669194049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E6EIJ5w+PIWfz/dZ3wzqsgofUxnU4yeG1t+4ayq90mM=;
        b=Pxlfd6iO9qWs8p3ZK9HEWtPpUfwNhfEQBd73CLfDDRSz8zGMvX91QgnUZTEtSTOYOxPLZK
        hW+wWmnFu2cLl/NR6Xgw3OOXT3D/c4TXfvz0jpwoQoJowTNg55fXziGS+p4V0xSkL9xSsN
        QhmDljIovf/THELGIiDwA4ChVPlbQP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-84-RElBYvLUO3mz1DjIkKvIqA-1; Wed, 23 Nov 2022 04:00:48 -0500
X-MC-Unique: RElBYvLUO3mz1DjIkKvIqA-1
Received: by mail-wm1-f71.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so567066wme.8
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6EIJ5w+PIWfz/dZ3wzqsgofUxnU4yeG1t+4ayq90mM=;
        b=hp6woVU/98zCg/k++1fnwTNC5pkxNkN0sVH38QNHe4vMkOMlyPK7dla9YBsP29l2uL
         1Jd3iyNfMoJL5c11nGBwi06Nrx8W771ZfbQXiw9m464Bm0qKRTyVeNYRW6pYgKxGSTnJ
         z3TdFD2b92V2SgK3EY27mlsEhjqmU+l9znEX6b/BsHPpsVu8C9kIVWH4A8OXG0RZyh7I
         7HDIKIABwh6uH7RyLE4yPPxChIY4Q6066T2mkgExLwG7vw4TFBt3zDSJKEj0fjL6IcaL
         LSfVUvD08no14ODQ6H0UoJrAo6OuIdvsgdG7ubmQpK14OCBAIc8xywqET5aZICi96dyW
         C6KQ==
X-Gm-Message-State: ANoB5pmfZNw/Wx2GupnMuRd9bqHimFZAsmj4haqWHiQixGpclZ55IeAq
        O7N62DAH3RpKe7rVHxPmbHtYxjuT/P0CGg2uVdOPFK3I0EZiQi5otExN9YGsJie/v+cwVF4E0Qk
        5VpxEQAOI2S1XQOWBh03OSUfcYJSHg6TDYdGtUW8Er9Z+qO3sILmYUjrTLac18xw=
X-Received: by 2002:a7b:c00a:0:b0:3cf:e8f0:ad11 with SMTP id c10-20020a7bc00a000000b003cfe8f0ad11mr23181586wmb.65.1669194046984;
        Wed, 23 Nov 2022 01:00:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4zOjgsuRGPiS63Tp8xZsHmidooWDTcdbUcP1B+oIto3jBpIOtS2Y8FrHWBSGgwpNTU2W5NaQ==
X-Received: by 2002:a7b:c00a:0:b0:3cf:e8f0:ad11 with SMTP id c10-20020a7bc00a000000b003cfe8f0ad11mr23181534wmb.65.1669194046374;
        Wed, 23 Nov 2022 01:00:46 -0800 (PST)
Received: from localhost.localdomain ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5949000000b0022e344a63c7sm15947773wri.92.2022.11.23.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:00:45 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        magnus.karlsson@gmail.com, akiyks@gmail.com,
        Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v5 1/1] docs: BPF_MAP_TYPE_XSKMAP
Date:   Wed, 23 Nov 2022 09:00:43 +0000
Message-Id: <20221123090043.83945-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
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
v5:
- Fixed references to user space

v4:
- Add more details about AF_XDP sockets and where to find
  relevant info.
- Fixup typos.
- Remove ``c:function::`` block directives.
- Replace spaces with tabs in code blocks.

v3:
- Fixed duplicate function warnings from Sphinx >= 3.3.

v2:
- Fixed typos + incorrect return type references.
- Adjusted examples to use __u32 and fixed references to key_size.
- Changed `AF_XDP socket` references to XSK.
- Added note re map key and value size.
---
 Documentation/bpf/map_xskmap.rst | 192 +++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)
 create mode 100644 Documentation/bpf/map_xskmap.rst

diff --git a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
new file mode 100644
index 000000000000..7093b8208451
--- /dev/null
+++ b/Documentation/bpf/map_xskmap.rst
@@ -0,0 +1,192 @@
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
+This map type redirects raw XDP frames to `AF_XDP`_ sockets (XSKs), a new type of
+address family in the kernel that allows redirection of frames from a driver to
+user space without having to traverse the full network stack. An AF_XDP socket
+binds to a single netdev queue. A mapping of XSKs to queues is shown below:
+
+.. code-block:: none
+
+    +---------------------------------------------------+
+    |     xsk A      |     xsk B       |      xsk C     |<---+ User space
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
+    |  | BPF     |-- redirect -->+-------------+-------------+
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
+Typically an XSKMAP is created per netdev. This map contains an array of XSK File
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
+bpf_redirect_map()
+^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+
+Redirect the packet to the endpoint referenced by ``map`` at index ``key``.
+For ``BPF_MAP_TYPE_XSKMAP`` this map contains references to XSK FDs
+for sockets attached to a netdev's queues.
+
+.. note::
+    If the map is empty at an index, the packet is dropped. This means that it is
+    necessary to have an XDP program loaded with at least one XSK in the
+    XSKMAP to be able to get any traffic to user space through the socket.
+
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+XSK entry references of type ``struct xdp_sock *`` can be retrieved using the
+``bpf_map_lookup_elem()`` helper.
+
+User space
+----------
+.. note::
+    XSK entries can only be updated/deleted from user space and not from
+    a BPF program. Trying to call these functions from a kernel BPF program will
+    result in the program failing to load and a verifier warning.
+
+bpf_map_update_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+	int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
+
+XSK entries can be added or updated using the ``bpf_map_update_elem()``
+helper. The ``key`` parameter is equal to the queue_id of the queue the XSK
+is attaching to. And the ``value`` parameter is the FD value of that socket.
+
+Under the hood, the XSKMAP update function uses the XSK FD value to retrieve the
+associated ``struct xdp_sock`` instance.
+
+The flags argument can be one of the following:
+
+- BPF_ANY: Create a new element or update an existing element.
+- BPF_NOEXIST: Create a new element only if it did not exist.
+- BPF_EXIST: Update an existing element.
+
+bpf_map_lookup_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    int bpf_map_lookup_elem(int fd, const void *key, void *value)
+
+Returns ``struct xdp_sock *`` or negative error in case of failure.
+
+bpf_map_delete_elem()
+^^^^^^^^^^^^^^^^^^^^^
+.. code-block:: c
+
+    int bpf_map_delete_elem(int fd, const void *key)
+
+XSK entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case of
+failure.
+
+.. note::
+    When `libxdp`_ deletes an XSK it also removes the associated socket
+    entry from the XSKMAP.
+
+Examples
+========
+Kernel
+------
+
+The following code snippet shows how to declare a ``BPF_MAP_TYPE_XSKMAP`` called
+``xsks_map`` and how to redirect packets to an XSK.
+
+.. code-block:: c
+
+	struct {
+		__uint(type, BPF_MAP_TYPE_XSKMAP);
+		__type(key, __u32);
+		__type(value, __u32);
+		__uint(max_entries, 64);
+	} xsks_map SEC(".maps");
+
+
+	SEC("xdp")
+	int xsk_redir_prog(struct xdp_md *ctx)
+	{
+		__u32 index = ctx->rx_queue_index;
+
+		if (bpf_map_lookup_elem(&xsks_map, &index))
+			return bpf_redirect_map(&xsks_map, index, 0);
+		return XDP_PASS;
+	}
+
+User space
+----------
+
+The following code snippet shows how to update an XSKMAP with an XSK entry.
+
+.. code-block:: c
+
+	int update_xsks_map(struct bpf_map *xsks_map, int queue_id, int xsk_fd)
+	{
+		int ret;
+
+		ret = bpf_map_update_elem(bpf_map__fd(xsks_map), &queue_id, &xsk_fd, 0);
+		if (ret < 0)
+			fprintf(stderr, "Failed to update xsks_map: %s\n", strerror(errno));
+
+		return ret;
+	}
+
+For an example on how create AF_XDP sockets, please see the AF_XDP-example and
+AF_XDP-forwarding programs in the `bpf-examples`_ directory in the `libxdp`_ repository.
+For a detailed explaination of the AF_XDP interface please see:
+
+- `libxdp-readme`_.
+- `AF_XDP`_ kernel documentation.
+
+.. note::
+    The most comprehensive resource for using XSKMAPs and AF_XDP is `libxdp`_.
+
+.. _libxdp: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp
+.. _AF_XDP: https://www.kernel.org/doc/html/latest/networking/af_xdp.html
+.. _bpf-examples: https://github.com/xdp-project/bpf-examples
+.. _libxdp-readme: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp#using-af_xdp-sockets
-- 
2.34.1

