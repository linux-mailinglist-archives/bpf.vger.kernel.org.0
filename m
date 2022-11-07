Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAF61F720
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 16:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiKGPGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 10:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiKGPGB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 10:06:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D01DF39;
        Mon,  7 Nov 2022 07:05:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z14so16657673wrn.7;
        Mon, 07 Nov 2022 07:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOUyX+5t3Oc0VEE6J+TI+W/CMcjoBAnDvck1cxjm4EA=;
        b=M4XtBzfd1DVEY52/0oAsykt3iQrV8N4bxQ3u6dD3DXLoBKbYZLhxtmiedOuCh6jjPY
         A05ebY/AUBzKGinlCDIgB7xAtvekKfiCcv2RTBkP6lQi4tPOA+EDq9mg9+DSBA/THOOR
         lAnPkTeGUfOGS2azBnoH0yH3Bh0lr93VptDYrPTRw4N49jAL0SI4xiyHCgyAlmuBssy4
         jAnV1jBTtBP1ymr3IQONPjSC1oDyw7tz03MhJXS3UmbfCOYQfNoJD0GgrGES0uUrP9fl
         Gy0NQbqC4YWQALMfWpoTqOXoPquVBVI7SLELiqATTQy8D4WbIq5bwbG44JpY/0OjNShc
         6FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOUyX+5t3Oc0VEE6J+TI+W/CMcjoBAnDvck1cxjm4EA=;
        b=ERlt7/OVDiaFT5LtTv8ujqPWf84SYqYReReJW2VnLLZWEOj2cXod5uH6sCH4kU1ECZ
         Qj3LBnYZ3Z+pCWSHcO8bxyDL2OLCLji+MaZ8QzaKVoqqlSEoVxkQK7S61jOFQjb8wB5f
         3/lCz1QsARCVFhLfmH6+mJSi7fzq/a+YX1wEHhpS8rw2Ds/XlHOsyauWG2sY76actVDc
         9iIUHUNlLjm717cG8s7uH2EvgMaMIcwg3Wg29lqR+rkv6oWM4lyXlOiYFe8qHIKdG3dn
         VnBBsplfb+QzuH6fLuA2BS833SCtckcO5ag9AFcf6xJ4GNN1dcI7az6YTpgETxksJhqQ
         3woQ==
X-Gm-Message-State: ACrzQf2W/5KlJmIyXuT7fmBDV1aIAdksabZ8nIwrDKERXmTvBoqLiBsV
        EWFhIkVlUCPTRRVn5rFuc/nYL5Zk4c+QCg==
X-Google-Smtp-Source: AMsMyM4/FwMYdfa/fjyhcG4rBYLqIc03qjacNwxxTqguN/oBeFRhHYFuLq4r8Fr71+7d1FBT3Klh1A==
X-Received: by 2002:adf:e484:0:b0:236:6a2e:154e with SMTP id i4-20020adfe484000000b002366a2e154emr31554346wrm.664.1667833556044;
        Mon, 07 Nov 2022 07:05:56 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:550:1196:18a3:8071])
        by smtp.gmail.com with ESMTPSA id bg17-20020a05600c3c9100b003cfaae07f68sm3884987wmb.17.2022.11.07.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:05:55 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2] docs/bpf: Document BPF map types QUEUE and STACK
Date:   Mon,  7 Nov 2022 15:05:50 +0000
Message-Id: <20221107150550.94855-1-donald.hunter@gmail.com>
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
v1 -> v2:
- Mention "libbpf's low-level API", as reported by Andrii Nakryiko
- Replace 0 with NULL in code snippet, as reported by Andrii Nakryiko
---
 Documentation/bpf/map_queue_stack.rst | 120 ++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/bpf/map_queue_stack.rst

diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
new file mode 100644
index 000000000000..6325648bf0c7
--- /dev/null
+++ b/Documentation/bpf/map_queue_stack.rst
@@ -0,0 +1,120 @@
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

