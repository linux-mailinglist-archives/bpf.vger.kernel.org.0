Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB28A619E62
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 18:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKDRV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiKDRVq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 13:21:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1D6419AF;
        Fri,  4 Nov 2022 10:21:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso5836195wme.5;
        Fri, 04 Nov 2022 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOInBYVzDZac+KDePX2kVcNu+q9nqQaZrkWgQZxFA4g=;
        b=Re82PwXIvaJBZnaOckelD+CHhqaBZml7jWNsTrFgxf242Kr118Rz3zTSedab64VcIC
         gSfTFBJ8imMEePJ3iglE97BobubMItbbSrmJz1P9EYnUJzNhHQ8yWhGY96eaDYjZTEpu
         b0eppY8+VYLmv5qb5ekva1IZ7N/faUZVdllA0ZMSNv7P8trvZzmhTGZntXCEn5U25Vhw
         wIz79ZhcQJgtbPqc6ZnWFR+qZicGrjL32TM4U3XitukqKkSvvDJVdCOuADxTFuHTbA3A
         176c1keAbKjZhH2bloh/MEmOxfr72dlBai4HXiLUw59HH5Cqj4CrZsdJPffGUVLEx663
         JhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOInBYVzDZac+KDePX2kVcNu+q9nqQaZrkWgQZxFA4g=;
        b=orAYdTQykdydDyZ3qVLFM2W9K1Uh2IxvKDye/QWO6RZqzJTaJmKAihi+o8Z0ldOnGG
         cASvZ7r0yNhDD05GmaAY9IQSoG2VFPjE6cqwIrDgGOUx0u1SGvXdRAbuI0suqQ9a40ec
         Tqt4waqJLMtiqnrFTVAxMB4uiCQwMyr05Wt4i1kyGscvcxsKde0C7IaXvn9bu1jONar4
         YlnKlitMPcvhvgLfAPICUM4Ysp1AnNzAstsM4X++Cxa8SOviZycIW5p7cWmnYLHlV6qA
         8jBPu3U1blX1obDnOg1HKSlJVEy266DmK49uonSjomY0tMM1h/447/nGvAZiS/PKxKwJ
         BCZw==
X-Gm-Message-State: ACrzQf0+WC+UepCVRB2cz51Zv7GoLazfEPAruvzm/acNvA7Ns5UnHaVj
        8+Ulh6eJG2xGOZr3bLy4SL6QiacyahY2Bw==
X-Google-Smtp-Source: AMsMyM4U36fZTHrWxTe9svX2AbpYgO0gptdLAlDBmWolFBl4fMaUHQhyqtp3YIc7WW4iMegSOvbfoQ==
X-Received: by 2002:a1c:ed0e:0:b0:3cf:6b2b:f1db with SMTP id l14-20020a1ced0e000000b003cf6b2bf1dbmr22072632wmh.117.1667582503854;
        Fri, 04 Nov 2022 10:21:43 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9545:7faf:600a:f150])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d65c6000000b00236cb3fec8fsm4689021wrw.9.2022.11.04.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:21:43 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] docs/bpf: Document BPF map types QUEUE and STACK
Date:   Fri,  4 Nov 2022 17:21:40 +0000
Message-Id: <20221104172140.19762-1-donald.hunter@gmail.com>
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
 Documentation/bpf/map_queue_stack.rst | 119 ++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/bpf/map_queue_stack.rst

diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
new file mode 100644
index 000000000000..a27e7f573869
--- /dev/null
+++ b/Documentation/bpf/map_queue_stack.rst
@@ -0,0 +1,119 @@
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
+``bpf_map_push_elem()`` helper. If ``flags`` is set to ``BPF_EXIST``
+then, when the queue or stack is full, the oldest element will be
+removed to make room for ``value`` to be added. Returns ``0`` on
+success, or negative error in case of failure.
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
+``NULL`` and ``flags`` must be set to ``BPF_ANY``. Returns ``0`` on
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
+This snippet shows how to use libbpf to create a queue from userspace:
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
+                                  0);             /* create options */
+    }
+
+
+References
+==========
+
+https://lwn.net/ml/netdev/153986858555.9127.14517764371945179514.stgit@kernel/
-- 
2.35.1

