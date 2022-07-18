Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15905782EF
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiGRNAF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiGRNAA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 09:00:00 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531F3A456;
        Mon, 18 Jul 2022 05:59:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r14so16954925wrg.1;
        Mon, 18 Jul 2022 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35j6pZtwPJBz9qjk/U84BLhshetw3HmW5KMow/VpuRs=;
        b=EC22c+kOxMDhTAcdt/ouQFa6BGCjNefQZygODSOrRxdhmmV0a+9ypFMOm+lOOcScLf
         v5NdRu/b84GzD+oeuMZeELDEJXlrCG6LTVqYxCwDef6gPuoyW7jH0eV458W9UP4WVuDi
         Tf2JvcOv4LdVNehCNdKowacGT/iIk+6L8abYIxlpjqITwobq/I13/1PycI7xakr7YG3v
         Duf/vufFqs0TLUWScqbiddykBqx7xHiwGpTn/V1totSBStLq5nsaibJhaBdrYsTBRxoy
         AoBhvAqsHGF9mgHdR/MDs4ElnsDE+oxHFpqZXSnOzISZZsim0tzphYmvcteUccXMpiQb
         uZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=35j6pZtwPJBz9qjk/U84BLhshetw3HmW5KMow/VpuRs=;
        b=kEJaxe1k6pn2jB2mrGKgqg5Frja4f0vnMlNRehUz+1nLfvOC/4e7jujxvgSrh9aip7
         jCufJP3pdFDvKJmBwv5ICZyPAELf6A1lVNdhqN75Mi8F5IhO9pX5ROpstRjV2AHeYNZ8
         SDmRB6HRXYirq7/i3vkcyL9nbRXAQf0O4vdWI8mDjEHi3t1llSKfz4KRxXxng1wngkVX
         sHRTAblUKAJFkPjSK4M/Fps1A9cpFpJO+51fptXDn439gmdQGfK6dOh86uFt/1UUaXcy
         0QWUkyfEDLvhxGwGoDDcBC1rwyJas7PkJ90DHHJGFYZNTq9BVORRX71dHSxXZhmPXRwY
         l5Pg==
X-Gm-Message-State: AJIora+zaewBWB+h+Rz9goKV1fuOYLtyc7qb9hIUCW9jSG1HxkBQ2lIt
        hZdGipRJ6MquMkXhcNdzdaG6LYKtXXk=
X-Google-Smtp-Source: AGRyM1ueDoMiTvWdyPv33TJg7xfhSvHaWx1RTEkr/tbQf8QuZPZqWeFWKNnIKLk6QFi2CqfdojhL+g==
X-Received: by 2002:a05:6000:1841:b0:21d:b6ca:2e19 with SMTP id c1-20020a056000184100b0021db6ca2e19mr23263458wri.599.1658149171410;
        Mon, 18 Jul 2022 05:59:31 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0039c5ab7167dsm18878363wmq.48.2022.07.18.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 05:59:30 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, sdf@google.com, yhs@fb.com,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v3] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Date:   Mon, 18 Jul 2022 13:58:47 +0100
Message-Id: <20220718125847.1390-1-donald.hunter@gmail.com>
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

Add documentation for BPF_MAP_TYPE_HASH including kernel version
introduced, usage and examples. Document BPF_MAP_TYPE_PERCPU_HASH,
BPF_MAP_TYPE_LRU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH variations.

Note that this file is included in the BPF documentation by the glob in
Documentation/bpf/maps.rst

v3:
Fix typos reported by Stanislav Fomichev and Yonghong Song.
Add note about iteration and deletion as requested by Yonghong Song.

v2:
Describe memory allocation semantics as suggested by Stanislav Fomichev.
Fix u64 typo reported by Stanislav Fomichev.
Cut down usage examples to only show usage in context.
Updated patch description to follow style recommendation, reported by
Bagas Sanjaya.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_hash.rst | 186 +++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 Documentation/bpf/map_hash.rst

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
new file mode 100644
index 000000000000..b1d6562f36ae
--- /dev/null
+++ b/Documentation/bpf/map_hash.rst
@@ -0,0 +1,186 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
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
+allowing for composite keys and values.
+
+The kernel is responsible for allocating and freeing key/value pairs, up
+to the max_entries limit that you specify. Hash maps use pre-allocation
+of hash table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be
+used to disable pre-allocation when it is too memory expensive.
+
+``BPF_MAP_TYPE_PERCPU_HASH`` provides a separate value slot per
+CPU. The per-cpu values are stored internally in an array.
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
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
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
+Concurrency
+-----------
+
+Values stored in ``BPF_MAP_TYPE_HASH`` can be accessed concurrently by
+programs running on different CPUs.  Since Kernel version 5.1, the BPF
+infrastructure provides ``struct bpf_spin_lock`` to synchronise access.
+See ``tools/testing/selftests/bpf/progs/test_spin_lock.c``.
+
+Userspace
+---------
+
+.. c:function::
+   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
+
+In userspace, it is possible to iterate through the keys of a hash using
+the ``bpf_map_get_next_key()`` function. The first key can be fetched by
+calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
+``NULL``. Subsequent calls will fetch the next key that follows the
+current key. ``bpf_map_get_next_key()`` returns 0 on success, -ENOENT if
+cur_key is the last key in the hash, or negative error in case of
+failure.
+
+Note that if ``cur_key`` gets deleted then ``bpf_map_get_next_key()``
+will instead return the *first* key in the hash table which is
+undesirable. It is recommended to use batched lookup if there is going
+to be key deletion intermixed with ``bpf_map_get_next_key()``.
+
+Examples
+========
+
+Please see the ``tools/testing/selftests/bpf`` directory for functional
+examples.  The code snippets below demonstrates API usage.
+
+This example shows how to declare an LRU Hash with a struct key and a
+struct value.
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
+This example shows how to create or update hash values using atomic
+instructions:
+
+.. code-block:: c
+
+    static inline void (__u32 srcip, int bytes)
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
+Userspace walking the map elements from the map declared above:
+
+.. code-block:: c
+
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    static void walk_hash_elements(int map_fd)
+    {
+            struct key *cur_key = NULL;
+            struct key next_key;
+            int next;
+            do {
+                    // error checking omitted
+                    next = bpf_map_get_next_key(stats_fd, cur_key, &next_key);
+                    if (next == -ENOENT)
+                            break;
+
+                    struct in_addr src_addr = {
+                            .s_addr = next_key.srcip
+                    };
+                    struct value value;
+                    int ret = bpf_map_lookup_elem(stats_fd, &next_key, &value);
+
+                    // Use key and value here
+
+                    cur_key = &next_key;
+            } while (next == 0);
+    }
-- 
2.35.1

