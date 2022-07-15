Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B52757628E
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 15:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiGONIy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGONIx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 09:08:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F581A068;
        Fri, 15 Jul 2022 06:08:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so2981633wmb.5;
        Fri, 15 Jul 2022 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYgfbeT3AOiPJqgP9+9rxrV1tnpt3pvl84n2UHgsXMI=;
        b=XVje0ejPbcAL+KwKdx5cXFr/A7pbpdXinmQIKQCIt9AB5hsvfM8lzomt3pQ5jN80jY
         728ydrKr/B5t3BQF3b+ZeUwZSbMF4cPyyrjyLXla46lSCHa1ThJJ1DJtsKF28O7sNFxK
         J2XY2n9vI0YvCvq0M38oQyQ6GhaCllLy/aPavO0riwcxxg5YnMEEj72PSHFVDgdUvV/O
         4SvYzihS08r/9NT+2jv0QBrOULBalO7aR3UCg6hTSYC2DqVMyWoUjGkxTfcbVpy4aeF0
         DXrcsvK29Mh/JBjYldyXFe+AvhVZVQ895BN0y0t9IoVMzY+/SgRDKA/LqDQ132M1hzmJ
         Hc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYgfbeT3AOiPJqgP9+9rxrV1tnpt3pvl84n2UHgsXMI=;
        b=HT1IyvOGyiQFD/sMtdCgJ/mW52eX7echQMs9t1JDmU/TnewZnuukq+uqToJnwTGq5I
         /RuqTUcSLVBCdcmMV5VHdYocAEImPgep2ElryKrde3I/gZSKTKmlbdSXTXN5eB01fVpx
         SaC7Y5OsIa8Q6QNkcr7jKj6chtwZDNdfayqc3GCmes3ddvxNYEO3V3g1OSCkhW6d4DE8
         PrcR1Ins1wdGYxInS2fmS7EPZpOWzNuwN6yATT8+E20k5gZtE++86USjHdAbKopDUDVe
         LjCxsiu0WBQlzKMapHMxfviBjNj0L+67NKlT/d4RRz8sLXlYbIUfmas/5sYzd/pHnFbP
         QnHg==
X-Gm-Message-State: AJIora9Y72XvOtChYsghKdR3yJ8ZmZSlhT7BSV7D6P01P85fYiyGtwda
        2FK21sJ4W+LsQRI1JxYAGjqExHuozZRzURdn
X-Google-Smtp-Source: AGRyM1vXxNxqDcKYmx8cG+QwBlydjA7UBFxqgq09cUrygtx/1Z7lvjL/rYGQTEHYSxKhEwUVj651CQ==
X-Received: by 2002:a05:600c:3ba0:b0:3a2:ddc4:e0d5 with SMTP id n32-20020a05600c3ba000b003a2ddc4e0d5mr20708458wms.159.1657890528577;
        Fri, 15 Jul 2022 06:08:48 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7cd7:ddd5:b3c7:3e26])
        by smtp.gmail.com with ESMTPSA id c6-20020a7bc006000000b003a02f957245sm8664968wmb.26.2022.07.15.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 06:08:48 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, sdf@google.com,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v2] bpf, docs: document BPF_MAP_TYPE_HASH and variants
Date:   Fri, 15 Jul 2022 14:08:26 +0100
Message-Id: <20220715130826.31632-1-donald.hunter@gmail.com>
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

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_hash.rst | 181 +++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/bpf/map_hash.rst

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
new file mode 100644
index 000000000000..d9e33152dae5
--- /dev/null
+++ b/Documentation/bpf/map_hash.rst
@@ -0,0 +1,181 @@
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
+used to disable pre-allocation when it is to memory expensive.
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
+infrastructure provides ``struct bpf_spin_lock`` to synchronize access.
+See ``tools/testing/selftests/bpf/progs/test_spin_lock.c``.
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
+examples.  The sample code below demonstrates API usage.
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

