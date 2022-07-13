Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE3573EA6
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiGMVQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiGMVQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 17:16:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F71B7B6;
        Wed, 13 Jul 2022 14:16:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f2so17208549wrr.6;
        Wed, 13 Jul 2022 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ade7ObTi+FJbpe8M3g1zL7/iq3MRsltHVz+uLnKawkY=;
        b=Cp5JxwMI6rXF0UwWrr4cETLExEO97I8vjw7cDra1IgW9kTme5cXOmnL0jskHzcwN5Z
         /ikPWJobLIu8RzDZxGeef7MB/iWuZSSFSrcuzB01WF7scCfUEdB0PLxXTH8VyWs8qOH2
         XOxGrA7G+/X+PaK1RrBGG0Wzg8gGyFQ+iC+xk/4VvQnZRgpuB2OV9E98ZYC/JfshR8kb
         YpjxGUllgldmBO9wim6URy4A2/clGwg+7+LxJmecmg74prAse/O12t9TljYd+oOVwzdl
         oFpNlgrai5LBrbXiWHwbkaKpZ2Bj8B+OWhAcz+UmH/WNz2Udc/kFyDHY1LEz3x3mfVlc
         aZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ade7ObTi+FJbpe8M3g1zL7/iq3MRsltHVz+uLnKawkY=;
        b=ity1kFHl95PlTAXGYy3JWhbt/vS73zrcIVVn/qIj0/jbP37edPWbKoxCUKG9Cl2ExD
         UJQ+R9UT1BcEH0hliO/mxcolqae6Js2VJimt4mUCdW2Rd5BQo+LyRPgRG+MTFCJdfnTR
         Z0zgVoAAZbp0FaVgiWSWoXODYVOSSHCF5GK+vC5p/s3wSRAn7eAu/2eHVN1XoZvurY9y
         Rp0fPDO2b2rEAtk31Auekb6QZ/cFrm7+4niCINtbu8x8XR4svwoBoW1sjKLoeOTNJRDt
         J3WpDxA5QOcQ/gvMf6p24m6uEs+rsa84XSfWFZTBJAQZufw5BdVzdE3efxz2pp+z5Deb
         qIuw==
X-Gm-Message-State: AJIora/Tmq875ZQ2vT3yxDeKT9eQGCjNsexFl4LVEdHmFRtlvT9zQGmj
        sMn+Xy/U5yc/IJLesoaod1xZIi86iP+NvQ==
X-Google-Smtp-Source: AGRyM1tVjzgZGV90TCTospvui4ZLKY31Y9gXgZOMGVRHx4N/Ek+NIoL8+cdLhfoVLyJKOiRctCfJHg==
X-Received: by 2002:a05:6000:1681:b0:21d:85a7:4ed with SMTP id y1-20020a056000168100b0021d85a704edmr5026044wrd.345.1657746983668;
        Wed, 13 Jul 2022 14:16:23 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1d4b:d2ed:e4a9:507e])
        by smtp.gmail.com with ESMTPSA id f11-20020adfe90b000000b0021d7b41255esm11875182wrm.98.2022.07.13.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:16:23 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Date:   Wed, 13 Jul 2022 22:16:12 +0100
Message-Id: <20220713211612.84782-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds documentation for BPF_MAP_TYPE_HASH including kernel
version introduced, usage and examples. It also documents
BPF_MAP_TYPE_PERCPU_HASH, BPF_MAP_TYPE_LRU_HASH and
BPF_MAP_TYPE_LRU_PERCPU_HASH which are similar.

Note that this file is included in the BPF documentation by the glob in
Documentation/bpf/maps.rst

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_hash.rst | 176 +++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/bpf/map_hash.rst

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
new file mode 100644
index 000000000000..991452e70cc9
--- /dev/null
+++ b/Documentation/bpf/map_hash.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2021 Red Hat, Inc.
+
+===============================================
+BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
+===============================================
+
+.. note::
+   - ``BPF_MAP_TYPE_HASH`` was introduced in kernel version 3.19
+   - ``BPF_MAP_TYPE_PERCPU_HASH`` was introduced in version 4.6
+   - Both ``BPF_MAP_TYPE_LRU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
+     were introduced in version 4.10
+
+``BPF_MAP_TYPE_HASH`` and ``BPF_MAP_TYPE_PERCPU_HASH`` provide general
+purpose hash map storage. Both the key and the value can be structs,
+allowing for composite keys and values. The maximum number of entries is
+defined in max_entries and is limited to 2^32. The kernel is responsible
+for allocating and freeing key/value pairs, up to the max_entries limit
+that you specify. ``BPF_MAP_TYPE_PERCPU_HASH`` provides a separate hash
+table per CPU.
+
+Values stored in ``BPF_MAP_TYPE_HASH`` can be accessed concurrently by
+programs running on different CPUs.  Since Kernel version 5.1, the BPF
+infrastructure provides ``struct bpf_spin_lock`` to synchronize access.
+
+The ``BPF_MAP_TYPE_LRU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
+variants add LRU semantics to their respective hash tables. An LRU hash
+will automatically evict the least recently used entries when the hash
+table reaches capacity. An LRU hash maintains an internal LRU list that
+is used to select elements for eviction. This internal LRU list is
+shared across CPUs but it is possible to request a per CPU LRU list with
+the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.
+
+Usage
+=====
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u60 flags)
+
+Hash entries can be added or updated using the ``bpf_map_update_elem()``
+helper. This helper replaces existing elements atomically. The ``flags``
+parameter can be used to control the update behaviour:
+
+- ``BPF_ANY`` will create a new element or update an existing element
+- ``BPF_NOTEXIST`` will create a new element only if one did not already
+  exist
+- ``BPF_EXIST`` will update an existing element
+
+``bpf_map_update_elem()`` returns 0 on success, or negative error in
+case of failure.
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+Hash entries can be retrieved using the ``bpf_map_lookup_elem()``
+helper. This helper returns a pointer to the value associated with
+``key``, or ``NULL`` if no entry was found.
+
+.. c:function::
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+Hash entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case
+of failure.
+
+Per CPU Hashes
+--------------
+
+For ``BPF_MAP_TYPE_PERCPU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
+the ``bpf_map_update_elem()`` and ``bpf_map_lookup_elem()`` helpers
+automatically access the hash slot for the current CPU.
+
+.. c:function::
+   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
+
+The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the
+value in the hash slot for a specific CPU. Returns value associated with
+``key`` on ``cpu`` , or ``NULL`` if no entry was found or ``cpu`` is
+invalid.
+
+Userspace
+---------
+
+.. c:function::
+   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
+
+In userspace, is possible to iterate through the keys of a hash using
+the ``bpf_map_get_next_key()`` function. The first key can be fetched by
+calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
+``NULL``. Subsequent calls will fetch the next key that follows the
+current key. ``bpf_map_get_next_key()`` returns 0 on success, -ENOENT if
+cur_key is the last key in the hash, or negative error in case of
+failure.
+
+Examples
+========
+
+Please see the ``tools/testing/selftests/bpf`` directory for functional
+examples.  This sample code demonstrates API usage.
+
+Kernel
+------
+
+.. code-block:: c
+
+    #include <linux/bpf.h>
+    #include <bpf/bpf_helpers.h>
+
+    struct key {
+        __u32 srcip;
+    };
+
+    struct value {
+        __u64 packets;
+        __u64 bytes;
+    };
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_LRU_HASH);
+            __uint(max_entries, 32);
+            __type(key, struct key);
+            __type(value, struct value);
+    } packet_stats SEC(".maps");
+
+    static inline void count_by_srcip(__u32 srcip, int bytes)
+    {
+            struct key key = {
+                    .srcip = srcip
+            };
+            struct value *value = bpf_map_lookup_elem(&packet_stats, &key);
+            if (value) {
+                    __sync_fetch_and_add(&value->packets, 1);
+                    __sync_fetch_and_add(&value->bytes, bytes);
+            } else {
+                    struct value newval = { 1, bytes };
+                    bpf_map_update_elem(&packet_stats, &key, &newval, BPF_NOEXIST);
+            }
+    }
+
+Userspace
+---------
+
+.. code-block:: c
+
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    static void print_values(int map_fd)
+    {
+            struct key *cur_key = NULL;
+            struct key next_key;
+            int next;
+            do {
+                    next = bpf_map_get_next_key(stats_fd, cur_key, &next_key);
+                    if (next == -ENOENT)
+                            break;
+                    if (next < 0) {
+                            fprintf(stderr, "bpf_map_get_next_key %d returned %s\n", stats_fd, strerror(-next));
+                            break;
+                    }
+
+                    struct in_addr src_addr = {
+                            .s_addr = next_key.srcip
+                    };
+                    char *src_ip = inet_ntoa(src_addr);
+
+                    struct value value;
+                    int ret = bpf_map_lookup_elem(stats_fd, &next_key, &value);
+                    if (ret < 0) {
+                            fprintf(stderr, "Failed to lookup elem with key %s: %s\n", src_ip, strerror(-ret));
+                            break;
+                    }
+                    printf("%s: %lld packets, %lld bytes\n", src_ip, value.packets, value.bytes);
+                    cur_key = &next_key;
+            } while (next == 0);
+    }
-- 
2.35.1

