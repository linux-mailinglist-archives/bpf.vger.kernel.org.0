Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E85620C4B
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 10:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiKHJd3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 04:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiKHJdW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 04:33:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459C13CF8;
        Tue,  8 Nov 2022 01:33:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o4so20017174wrq.6;
        Tue, 08 Nov 2022 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7UigtKd2aguDxATVCZnnJd8IJSjFzIX4+jHHQBRFMk=;
        b=QxgS68RxhsQ6TVao4eR6NpwQP5cAXCVH1iBWneiNCURADthk/U1ktVJlh5jgFuNXwQ
         rRWGgLrQpxA110dLy+xBoDDbrbBoXK10pyUYb15KzV2BGCfHZg58sxz+rpeJcIokpmuC
         oaOTmPbakl0Dlcwb8bS0Aixp8kge1V8ZZ7J7Bz4oV3Kfjx/VRyCy8slg20i+19wJzE3x
         +0cIKOws6NJHrkJEKjFqUctnzmVgyGTW4YavYQLr1Rotpcebi1InWCZ6GF/Pq1mBc4aF
         sJ03AqTve6oneg9XZ5P1r/UbbqF6jDvDWyfrUfQgG4F0AtSqvvqi4gYUP0fIY7b0RzL6
         bVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7UigtKd2aguDxATVCZnnJd8IJSjFzIX4+jHHQBRFMk=;
        b=b3h7tzAaKD92uWzvD2SkDuyfl2THE8KY56igHwMuOfLaDrrHliNATZMp6D3R9VPowa
         P1cNbAOTIg4WxJX4zHuwpVtMhqYYXwCnut6o4yXiHTftD6xS2d/i6LU8k6yzGFkt/vRN
         p7zd4NrGXosar+cziAkog8Oo6HML6Q9Nh59q1sWtoP65vk1vxPvD0nb7PiwpOUQi+pj6
         dxOcbv74iJjlXupYvbGSEevE0HosAHnNXAnF4mOuv+iBzzHA7ZPX5iynCUMndXbLJwbY
         uJS3wEoYG2CAVv4bdzGY7NHj3P5U1nOQHg7Aca52N7kMAtBwm1ucScJ92DvJZARR4Tg9
         afhQ==
X-Gm-Message-State: ACrzQf3jxlTN6sbzwGueo3QKiiyWlx45IVHr09ZAE4NPA7KsqJpFUvxC
        IDy7wnz2ZMsuKvpn6CEEAJahs/L3SY/Fnw==
X-Google-Smtp-Source: AMsMyM7o/SyT/6t2FI5Ce3LZBx3CEpAL6kH81c3fQVxiYl4jO9P25e555vS8yS+ytManC5BIGf6OEg==
X-Received: by 2002:a5d:584e:0:b0:236:6f0f:9d8 with SMTP id i14-20020a5d584e000000b002366f0f09d8mr34750605wrf.701.1667899998329;
        Tue, 08 Nov 2022 01:33:18 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:550:1196:18a3:8071])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003b3307fb98fsm10340929wmi.24.2022.11.08.01.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:33:17 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v3] docs/bpf: Document BPF map types QUEUE and STACK
Date:   Tue,  8 Nov 2022 09:33:14 +0000
Message-Id: <20221108093314.44851-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Add documentation for BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK,
including usage and examples.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
v2 -> v3:
- Add BPF_EXIST to valid flags as reported by Yonghong Song
- Clarify valid flags for bpf_map_push_elem

v1 -> v2:
- Mention "libbpf's low-level API", as reported by Andrii Nakryiko
- Replace 0 with NULL in code snippet, as reported by Andrii Nakryiko
---
 Documentation/bpf/map_queue_stack.rst | 122 ++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/bpf/map_queue_stack.rst

diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
new file mode 100644
index 000000000000..f20e31a647b9
--- /dev/null
+++ b/Documentation/bpf/map_queue_stack.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+=========================================
+BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK
+=========================================
+
+.. note::
+   - ``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` were introduced
+     in kernel version 4.20
+
+``BPF_MAP_TYPE_QUEUE`` provides FIFO storage and ``BPF_MAP_TYPE_STACK``
+provides LIFO storage for BPF programs. These maps support peek, pop and
+push operations that are exposed to BPF programs through the respective
+helpers. These operations are exposed to userspace applications using
+the existing ``bpf`` syscall in the following way:
+
+- ``BPF_MAP_LOOKUP_ELEM`` -> peek
+- ``BPF_MAP_LOOKUP_AND_DELETE_ELEM`` -> pop
+- ``BPF_MAP_UPDATE_ELEM`` -> push
+
+``BPF_MAP_TYPE_QUEUE`` and ``BPF_MAP_TYPE_STACK`` do not support
+``BPF_F_NO_PREALLOC``.
+
+Usage
+=====
+
+Kernel BPF
+----------
+
+.. c:function::
+   long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
+
+An element ``value`` can be added to a queue or stack using the
+``bpf_map_push_elem`` helper. The ``flags`` parameter must be set to
+``BPF_ANY`` or ``BPF_EXIST``. If ``flags`` is set to ``BPF_EXIST`` then,
+when the queue or stack is full, the oldest element will be removed to
+make room for ``value`` to be added. Returns ``0`` on success, or
+negative error in case of failure.
+
+.. c:function::
+   long bpf_map_peek_elem(struct bpf_map *map, void *value)
+
+This helper fetches an element ``value`` from a queue or stack without
+removing it. Returns ``0`` on success, or negative error in case of
+failure.
+
+.. c:function::
+   long bpf_map_pop_elem(struct bpf_map *map, void *value)
+
+This helper removes an element into ``value`` from a queue or
+stack. Returns ``0`` on success, or negative error in case of failure.
+
+
+Userspace
+---------
+
+.. c:function::
+   int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
+
+A userspace program can push ``value`` onto a queue or stack using libbpf's
+``bpf_map_update_elem`` function. The ``key`` parameter must be set to
+``NULL`` and ``flags`` must be set to ``BPF_ANY`` or ``BPF_EXIST``, with the
+same semantics as the ``bpf_map_push_elem`` kernel helper. Returns ``0`` on
+success, or negative error in case of failure.
+
+.. c:function::
+   int bpf_map_lookup_elem (int fd, const void *key, void *value)
+
+A userspace program can peek at the ``value`` at the head of a queue or stack
+using the libbpf ``bpf_map_lookup_elem`` function. The ``key`` parameter must be
+set to ``NULL``.  Returns ``0`` on success, or negative error in case of
+failure.
+
+.. c:function::
+   int bpf_map_lookup_and_delete_elem (int fd, const void *key, void *value)
+
+A userspace program can pop a ``value`` from the head of a queue or stack using
+the libbpf ``bpf_map_lookup_and_delete_elem`` function. The ``key`` parameter
+must be set to ``NULL``. Returns ``0`` on success, or negative error in case of
+failure.
+
+Examples
+========
+
+Kernel BPF
+----------
+
+This snippet shows how to declare a queue in a BPF program:
+
+.. code-block:: c
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_QUEUE);
+            __type(value, __u32);
+            __uint(max_entries, 10);
+    } queue SEC(".maps");
+
+
+Userspace
+---------
+
+This snippet shows how to use libbpf's low-level API to create a queue from
+userspace:
+
+.. code-block:: c
+
+    int create_queue()
+    {
+            return bpf_map_create(BPF_MAP_TYPE_QUEUE,
+                                  "sample_queue", /* name */
+                                  0,              /* key size, must be zero */
+                                  sizeof(__u32),  /* value size */
+                                  10,             /* max entries */
+                                  NULL);          /* create options */
+    }
+
+
+References
+==========
+
+https://lwn.net/ml/netdev/153986858555.9127.14517764371945179514.stgit@kernel/
-- 
2.35.1

