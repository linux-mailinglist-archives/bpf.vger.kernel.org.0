Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFD0649E9D
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 13:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiLLMY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 07:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiLLMYz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 07:24:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1C5583;
        Mon, 12 Dec 2022 04:24:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so5005081wmh.0;
        Mon, 12 Dec 2022 04:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ixs5N2khRg8fKX67dpAyhfXfluvpw3rq81sA0oxApXQ=;
        b=W++k1jq5AW5NQ/CnTgGd/K6G2riAxH8Dx1cit6KhDLoHco/Wsvn0xRh7owyzRHThuf
         zdAedtb7iUpx5FmzgeVVazNBvDaIaHlEidp/daXoACOOmcEdIytQ7JZEGiOpwdCqbfff
         cuOqh+fe/gyhVLFfmMRhnVvl7FeH2fb0M1VvPjtv3l9Vdjo9USHLBcZ5gkrx8eD1C45J
         qVvpXuWDws3JKJ0RJymjmCUuutdfJ15XwQvW0QnTjeR0laNR6TvkheV5aw0iZX9oztX0
         QJWtvyDF63Hj4CbLsA7kHQ8wjSFj0w+2+szJWF6O/uV2dQLej8O/sd+bBxbDi2sY+FdO
         8Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixs5N2khRg8fKX67dpAyhfXfluvpw3rq81sA0oxApXQ=;
        b=r3vJjtxxfPMAN3BKM0aqj6jgs2jwb2ECOzj4TTQlFpA/H2LgglJpNEnQ7OOpp1njn0
         smB8wzdX5iy4qHc5fbcy6SMOzUGrRxRH0ZKSuV/fMd/uc0CpZOPcCB4Vzm7LKOZt4CZi
         aCBpesVin+L3DOidjJBZYc8WdF7XH88Pufsl9PjxkZHWjmgtErYsyWIKkaezn9RTGctD
         QAl1bajGPCxRk6UX0V5oe6kmaWn1ZCW8IYttOLduVZLFyOBJ7Mfhg45rWtjNUfbBjCdW
         66XvvS1D5rbMURBjHJ9Zdh1G0ic8Q3a73+MPnv6k1T0K+DBJGy2oXIPUE5XhZXwcBkyz
         bjGg==
X-Gm-Message-State: ANoB5pn5i1Br+uxPJQ4MwWT+JYJ9/InTHknAXmVToeJpyJGUswYlaUgs
        4ogUnmgdoG2tzPX8nb7UpWx6jPNVf2nwaA==
X-Google-Smtp-Source: AA0mqf4o9Cai53YxEGx0GUAWeqwGhD2C9/ybolnlspuj5JOqwDUJbGHOJNZm4DsZhnNSzLrB8q1NUg==
X-Received: by 2002:a05:600c:3ac8:b0:3c6:e63e:89c5 with SMTP id d8-20020a05600c3ac800b003c6e63e89c5mr12444303wms.33.1670847891637;
        Mon, 12 Dec 2022 04:24:51 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:f1ca:f257:9b2b:4489])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003cf54b77bfesm9450187wmq.28.2022.12.12.04.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:24:50 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] docs/bpf: Add docs for BPF_PROG_TYPE_XDP
Date:   Mon, 12 Dec 2022 12:24:00 +0000
Message-Id: <20221212122400.64415-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document XDP programs (BPF_PROG_TYPE_XDP) and the XDP data path.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/prog_xdp.rst | 176 +++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/bpf/prog_xdp.rst

diff --git a/Documentation/bpf/prog_xdp.rst b/Documentation/bpf/prog_xdp.rst
new file mode 100644
index 000000000000..69b001a6c7d2
--- /dev/null
+++ b/Documentation/bpf/prog_xdp.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+================
+XDP BPF Programs
+================
+
+XDP (eXpress Data Path) is a fast path in the kernel network stack. XDP allows
+for packet processing by BPF programs before the packets traverse the L4-L7
+network stack. Programs of type ``BPF_PROG_TYPE_XDP`` are attached to the XDP
+hook of a specific interface in one of three modes:
+
+- ``SKB_MODE`` - The hook point is in the generic net device
+- ``DRV_MODE`` - The hook point is in the driver for the interface
+- ``HW_MODE`` - The BPF program is offloaded to the NIC
+
+The BPF program attached to an interface's XDP hook gets called for each L2
+frame that is received on the interface. The program is passed a ``struct xdp_md
+*ctx`` which gives access to the L2 data frame as well as some essential
+metadata for the frame:
+
+.. code-block:: c
+
+    struct xdp_md {
+            __u32 data;
+            __u32 data_end;
+            __u32 data_meta;
+
+            __u32 ingress_ifindex; /* rxq->dev->ifindex */
+            __u32 rx_queue_index;  /* rxq->queue_index  */
+            __u32 egress_ifindex;  /* txq->dev->ifindex */
+    };
+
+The BPF program can read and modify the frame before deciding what action should
+be taken for the packet. The program returns one of the following action values
+in order to tell the driver or net device how to process the packet (details in
+:ref:`xdp_packet_actions`):
+
+- ``XDP_DROP`` - Drop the packet without any further processing
+- ``XDP_PASS`` - Pass the packet to the kernel network stack for further
+  processing
+- ``XDP_TX`` - Transmit the packet out of the same interface
+- ``XDP_REDIRECT`` - Redirect the packet to a specific destination
+- ``XDP_ABORTED`` - Drop the packet and notify an exception state
+
+There are many BPF helper functions available to XDP programs for accessing and
+modifying packet data, for interacting with the kernel networking stack and for
+using BPF maps. `bpf-helpers(7)`_ describes the helpers available to XDP
+programs.
+
+The `libxdp`_ library provides functions for attaching XDP programs to network
+interfaces and for using ``AF_XDP`` sockets.
+
+XDP Modes
+=========
+
+SKB Mode
+--------
+
+An XDP program attached in SKB mode gets executed by the kernel network stack
+*after* the driver has created a ``struct sk_buff`` (SKB) and passed it to the
+networking stack. SKB mode is also referred to as *generic* mode and is always
+available, whether or not the driver is XDP-enabled. An XDP program in SKB mode
+is run by the netdev before classifiers or ``tc`` BPF programs are run.
+
+Driver Mode
+-----------
+
+An XDP program attached in driver mode gets executed by the network driver for
+an interface *before* the driver creates a ``struct sk_buff`` (SKB) for the
+incoming packet. The XDP program runs immediately after the driver receives the
+packet. This gives the XDP program an opportunity to entirely avoid the cost of
+SKB creation and kernel network stack processing.
+
+Driver mode requires the driver to be XDP-enabled so is not always available.
+
+Hardware Mode
+-------------
+
+Some devices may support hardware offload of BPF programs, which they do in a
+hardware specific way.
+
+.. _xdp_packet_actions:
+
+XDP Packet Actions
+==================
+
+XDP_DROP
+--------
+
+The ``XDP_DROP`` action tells the driver or netdev to drop the XDP frame without
+any further processing.
+
+XDP_PASS
+--------
+
+The ``XDP_PASS`` action tells the driver to convert the XDP frame into an SKB
+and the driver or netdev to pass the SKB on to the kernel network stack for
+normal processing.
+
+XDP_TX
+------
+
+The ``XDP_TX`` action tells the driver or netdev to transmit the XDP frame out
+of the associated interface.
+
+XDP_REDIRECT
+------------
+
+The ``XDP_REDIRECT`` action tells the driver to redirect the packet for further
+processing. There are several types of redirect available to the XDP program:
+
+- Redirect to another device by ifindex
+- Redirect to another device using a devmap
+- Redirect into an ``AF_XDP`` socket using an xskmap
+- Redirect to another CPU using a cpumap, before delivering to the network stack
+
+The ``bpf_redirect()`` and ``bpf_redirect_map()`` helper functions are used
+to set up the desired redirect destination before returning ``XDP_REDIRECT`` to
+the driver.
+
+.. code-block:: c
+
+    long bpf_redirect(u32 ifindex, u64 flags)
+
+The ``bpf_redirect()`` helper function redirects the packet to the net device
+identified by ``ifindex``.
+
+.. code-block:: c
+
+    long bpf_redirect_map(struct bpf_map *map, u32 key, u64 flags)
+
+The ``bpf_redirect_map()`` helper function redirects the packet to the
+destination referenced by ``map`` at index ``key``. The type of destination
+depends on the type ``map`` that is used:
+
+- ``BPF_MAP_TYPE_DEVMAP`` and ``BPF_MAP_TYPE_DEVMAP_HASH`` redirects the packet
+  to another net device
+- ``BPF_MAP_TYPE_CPUMAP`` redirects the packet processing to a specific CPU
+- ``BPF_MAP_TYPE_XSKMAP`` redirects the packet to an ``AF_XDP`` socket. See
+  ../networking/af_xdp.rst for more information.
+
+Detailed behaviour of ``bpf_redirect()`` and ``bpf_redirect_map()`` is described
+in `bpf-helpers(7)`_. ``XDP_REDIRECT`` is described in more detail in
+redirect.rst.
+
+XDP_ABORTED
+-----------
+
+The ``XDP_ABORTED`` action tells the driver that the BPF program exited in an
+exception state. The driver will drop the packet in the same way as if the BPF
+program returned ``XDP_DROP`` but the ``trace_xdp_exception`` trace point is also
+triggered.
+
+Examples
+========
+
+An example XDP program that uses ``XDP_REDIRECT`` can be found in
+`tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c`_ and the
+corresponding user space code in
+`tools/testing/selftests/bpf/xdp_redirect_multi.c`_
+
+References
+==========
+
+- https://github.com/xdp-project/xdp-tools
+- https://github.com/xdp-project/xdp-tutorial
+- https://docs.cilium.io/en/latest/bpf/progtypes
+
+.. Links
+.. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
+.. _libxdp: https://github.com/xdp-project/xdp-tools/tree/master/lib/libxdp
+.. _tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
+.. _tools/testing/selftests/bpf/xdp_redirect_multi.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/xdp_redirect_multi.c
-- 
2.38.1

