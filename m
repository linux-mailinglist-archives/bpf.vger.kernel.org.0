Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A744619453
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 11:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiKDKUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 06:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiKDKUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 06:20:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA523F;
        Fri,  4 Nov 2022 03:20:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so6414327wrw.2;
        Fri, 04 Nov 2022 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6P8xxdGWubsmXrylRSzncfWm/SKD8aRP3wQQ4UiL6hI=;
        b=n/r2ULB3Fyty+hwEg7z6CRvCbq8QI1ODnk/0bZfnnUbIMGmRRliuzQoKOzOFKCS8+G
         8fAGsscJKZwXTd9s5yxEvKwjMTbP1E7q454TSAxO4dxsNxsfOz6XMcmXo/ZUe1frymXN
         LHa6ZQzV/HKXM8T1NJK/QzIrbWfAcMi0SAJDSyzvJWUvPTksU6dWU6KAIxEqDLzERH/P
         h0+8s5q32vKbMLUCvzpOt38lLz8+LbrrOUZE+6P/Pk1EO5EIdJbNZ5qemtQNKTXDtcVr
         hidL+NlGXLbzVsJHReBtkHXawadTULcFYYLGjVJfEhtSU2CEFoKjOAI20DLFw02LlKu8
         18Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P8xxdGWubsmXrylRSzncfWm/SKD8aRP3wQQ4UiL6hI=;
        b=KPpYKv/iCSY/r2jDZRlJobMr8HtFH8TfPlqL6zFdNXv10FsEeJXg8EjIP3hO/DlS3V
         Zg21kobtT9SRPQMuAGd59H1KEVnqzN/DQgawNaTdEv4A+Ce4HRXDfLJEDgqvMXJbgowW
         ZYcFXzAbEvUXo46ZPefiZVZAI55YJoQfzJRZaO+ttvJ1Uypqom8I+jSgelQuw136xaMR
         UQsKq9JHhlb3NAQ78y18hOfIZEIo5+O9FtxDbQ5J0DiClbppeDjTIlhmBV8QUsvEzeTJ
         dE1pOs7pVlX9XdhLEclg/H4JBcwE6CzfiwLqUJfKs3wokBPPxPj2TWCzq2P2BHrWHB+3
         0hAQ==
X-Gm-Message-State: ACrzQf2RhLhDysI5Z+11f12nwB4v7CfY86pDdms4iTSD/O+e0++GLKGu
        zTeuOhPyYK5g/ARyl7RLN7OtxGBwEmik7w==
X-Google-Smtp-Source: AMsMyM6kmdIVZ8e+xXiNC3fmreH0pC43qtKWiOp0laBnpdZw0Vns8T571zt4KquZXcBhhwzlyI2HnQ==
X-Received: by 2002:a5d:4887:0:b0:226:ed34:7bbd with SMTP id g7-20020a5d4887000000b00226ed347bbdmr21079930wrq.561.1667557207079;
        Fri, 04 Nov 2022 03:20:07 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:69c4:31e5:f2b8:3146])
        by smtp.gmail.com with ESMTPSA id bj4-20020a0560001e0400b002322bff5b3bsm3846262wrb.54.2022.11.04.03.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 03:20:06 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maryam Tahhan <mtahhan@redhat.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2] docs/bpf: document BPF ARRAY_OF_MAPS and HASH_OF_MAPS
Date:   Fri,  4 Nov 2022 10:19:28 +0000
Message-Id: <20221104101928.9479-1-donald.hunter@gmail.com>
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

Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
including usage and examples.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
v1 -> v2:
- Fix formatting nits
- Tidy up code snippets as suggested by Maryam Tahhan
---
 Documentation/bpf/map_of_maps.rst | 129 ++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/bpf/map_of_maps.rst

diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_maps.rst
new file mode 100644
index 000000000000..d5a09bc669a3
--- /dev/null
+++ b/Documentation/bpf/map_of_maps.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+========================================================
+BPF_MAP_TYPE_ARRAY_OF_MAPS and BPF_MAP_TYPE_HASH_OF_MAPS
+========================================================
+
+.. note::
+   - ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` were
+     introduced in kernel version 4.12
+
+``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` provide general
+purpose support for map in map storage. One level of nesting is supported, where
+an outer map contains instances of a single type of inner map, for example
+``array_of_maps->sock_map``.
+
+When creating an outer map, an inner map instance is used to initialize the
+metadata that the outer map holds about its inner maps. This inner map has a
+separate lifetime from the outer map and can be deleted after the outer map has
+been created.
+
+The outer map supports element update and delete from user space using the
+syscall API. A BPF program is only allowed to do element lookup in the outer
+map.
+
+.. note::
+   - Multi-level nesting is not supported.
+   - Any BPF map type can be used as an inner map, except for
+     ``BPF_MAP_TYPE_PROG_ARRAY``.
+   - A BPF program cannot update or delete outer map entries.
+
+Array of Maps
+-------------
+
+For ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` the key is an unsigned 32-bit integer index
+into the array. The array is a fixed size with ``max_entries`` elements that are
+zero initialized when created.
+
+Hash of Maps
+------------
+
+For ``BPF_MAP_TYPE_HASH_OF_MAPS`` the key type can be chosen when defining the
+map.
+
+The kernel is responsible for allocating and freeing key/value pairs, up
+to the max_entries limit that you specify. Hash maps use pre-allocation
+of hash table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be
+used to disable pre-allocation when it is too memory expensive.
+
+Usage
+=====
+
+Kernel BPF
+----------
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+Inner maps can be retrieved using the ``bpf_map_lookup_elem()`` helper. This
+helper returns a pointer to the inner map, or ``NULL`` if no entry was found.
+
+Examples
+========
+
+Kernel BPF
+----------
+
+This snippet shows how to create an array of devmaps in a BPF program. Note that
+the outer array can only be modified from user space using the syscall API.
+
+.. code-block:: c
+
+    struct inner_map {
+            __uint(type, BPF_MAP_TYPE_DEVMAP);
+            __uint(max_entries, 32);
+            __type(key, __u32);
+            __type(value, __u32);
+    } inner_map SEC(".maps");
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+            __uint(max_entries, 32);
+            __type(key, __u32);
+            __type(value, __u32);
+            __array(values, struct inner_map);
+    } outer_map SEC(".maps");
+
+User Space
+----------
+
+This snippet shows how to create an array based outer map:
+
+.. code-block:: c
+
+    int create_outer_array(int inner_fd) {
+            int fd;
+
+            LIBBPF_OPTS(bpf_map_create_opts, opts);
+            opts.inner_map_fd = inner_fd;
+            fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS,
+                                "example_array",       /* name */
+                                sizeof(__u32),         /* key size */
+                                sizeof(__u32),         /* value size */
+                                256,                   /* max entries */
+                                &opts);                /* create opts */
+            return fd;
+    }
+
+
+This snippet shows how to add an inner map to an outer map:
+
+.. code-block:: c
+
+    int add_devmap(int outer_fd, int index, const char *name) {
+            int fd;
+
+            fd = bpf_map_create(BPF_MAP_TYPE_DEVMAP, name,
+                                sizeof(__u32), sizeof(__u32), 256, NULL);
+            if (fd < 0)
+                    return fd;
+
+            return bpf_map_update_elem(outer_fd, &index, &fd, BPF_NOEXIST);
+    }
+
+References
+==========
+
+- https://lore.kernel.org/netdev/20170322170035.923581-3-kafai@fb.com/
+- https://lore.kernel.org/netdev/20170322170035.923581-4-kafai@fb.com/
-- 
2.35.1

