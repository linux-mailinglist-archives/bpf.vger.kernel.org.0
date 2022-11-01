Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54106149DA
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKALuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKALtj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 07:49:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23061A238;
        Tue,  1 Nov 2022 04:45:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h9so19804896wrt.0;
        Tue, 01 Nov 2022 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgVvXV1TqlbopSpUav8X32PWApDTlkADJpb+ZwiYlZs=;
        b=o/AwFUfLh1ZseZxhtt/4cXKhcOoE0pxANbWi6XHJLFCkYz0gRTZ5Ca2PlCO4PbsIqR
         0k4LVmkTF8xMMSJgH3qESTE7TTfiZw/WbMh+O8uqXjmVTf3LRFWIdTv9e5wR8W5/LHkT
         GWoOHChf0BUwxtfPxxChj3Vb2gen3rGhpRGbndbbZcIRS79hcTPZhIxsPY0QM+eYbJuX
         Z3pqD4/eE/szE0vRxx4ZRDYUUCidO+w5GjZvyr5uL0bYN2FzJ4ynG31ES2rnyOtT+E57
         olvjY3QJ9CCo1ZI33iyI+UsdaPHjrhaQG6ICAmeDheUGQoehNjdp1YyKXbs5phgU/tEx
         kEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgVvXV1TqlbopSpUav8X32PWApDTlkADJpb+ZwiYlZs=;
        b=hxvND7S1OM3gKLIROVfDL/E46jRv9y3AQZZR0RkTcSDB7lPRL32LQIe/1XJpv373GP
         M/5z4cNrT7hIF9KOl7M5XAXW5y7eMg36/dQaNWtefWY5zh/S9bDtitJcwsNwS8ew4J/E
         YgfxKsQDqzX4gZMpAKzTYR7eBj5uoSkEG2I7Xrr0AzsKMWwaRIQUFh4M3FIWDLPa6P+J
         YIUdXmDp2o9MMPfbMdj96LhK8h+Z7H48SijTaoe18rU/Z9G9DRJwygy6d6SWFqPKlbgO
         QPkOxkh/V0avx2w6uZCt1Jv1ihH8LzMiKuXfGS0imhXzRoJsfo7sS9feTsORBMK8DO2k
         QJ0A==
X-Gm-Message-State: ACrzQf27prUXI6ILzHR9ETBKzudF17H9BRKKtQ1yHdV4akdvvz7M6LOv
        vlFE9eWkoksdr4Kqi5srL1yJAE9DIO/4nQ==
X-Google-Smtp-Source: AMsMyM6TFAcFRaHoCGSQO3O+0lnQzz3aZQ4jdeUJ4jZ53hAAlm0tjAy/NX8n+BNjeVllviQqdIG5Rw==
X-Received: by 2002:a5d:5b18:0:b0:236:c174:e99c with SMTP id bx24-20020a5d5b18000000b00236c174e99cmr8085214wrb.10.1667303148905;
        Tue, 01 Nov 2022 04:45:48 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1575:dcd7:a83c:38b])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm10279291wmb.40.2022.11.01.04.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:45:48 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2 1/1] Document BPF_MAP_TYPE_LPM_TRIE
Date:   Tue,  1 Nov 2022 11:45:42 +0000
Message-Id: <20221101114542.24481-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101114542.24481-1-donald.hunter@gmail.com>
References: <20221101114542.24481-1-donald.hunter@gmail.com>
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

Add documentation for BPF_MAP_TYPE_LPM_TRIE including kernel
BPF helper usage, userspace usage and examples.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_lpm_trie.rst | 181 +++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/bpf/map_lpm_trie.rst

diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
new file mode 100644
index 000000000000..31be1aa7ba2c
--- /dev/null
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -0,0 +1,181 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+=====================
+BPF_MAP_TYPE_LPM_TRIE
+=====================
+
+.. note::
+   - ``BPF_MAP_TYPE_LPM_TRIE`` was introduced in kernel version 4.11
+
+``BPF_MAP_TYPE_LPM_TRIE`` provides a longest prefix match algorithm that
+can be used to match IP addresses to a stored set of prefixes.
+Internally, data is stored in an unbalanced trie of nodes that uses
+``prefixlen,data`` pairs as its keys. The ``data`` is interpreted in
+network byte order, i.e. big endian, so ``data[0]`` stores the most
+significant byte.
+
+LPM tries may be created with a maximum prefix length that is a multiple
+of 8, in the range from 8 to 2048. The key used for lookup and update
+operations is a ``struct bpf_lpm_trie_key``, extended by
+``max_prefixlen/8`` bytes.
+
+- For IPv4 addresses the data length is 4 bytes
+- For IPv6 addresses the data length is 16 bytes
+
+The value type stored in the LPM trie can be any user defined type.
+
+.. note::
+   When creating a map of type ``BPF_MAP_TYPE_LPM_TRIE`` you must set the
+   ``BPF_F_NO_PREALLOC`` flag.
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
+The longest prefix entry for a given data value can be found using the
+``bpf_map_lookup_elem()`` helper. This helper returns a pointer to the
+value associated with the longest matching ``key``, or ``NULL`` if no
+entry was found.
+
+The ``key`` should have ``prefixlen`` set to ``max_prefixlen`` when
+performing longest prefix lookups. For example, when searching for the
+longest prefix match for an IPv4 address, ``prefixlen`` should be set to
+``32``.
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
+
+Prefix entries can be added or updated using the ``bpf_map_update_elem()``
+helper. This helper replaces existing elements atomically.
+
+``bpf_map_update_elem()`` returns ``0`` on success, or negative error in
+case of failure.
+
+ .. note::
+    The flags parameter must be one of BPF_ANY, BPF_NOEXIST or BPF_EXIST,
+    but the value is ignored, giving BPF_ANY semantics.
+
+.. c:function::
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+Prefix entries can be deleted using the ``bpf_map_delete_elem()``
+helper. This helper will return 0 on success, or negative error in case
+of failure.
+
+Userspace
+---------
+
+Access from userspace uses libbpf APIs with the same names as above, with
+the map identified by ``fd``.
+
+.. c:function::
+   int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
+
+A userspace program can iterate through the entries in an LPM trie using
+libbpf's ``bpf_map_get_next_key()`` function. The first key can be
+fetched by calling ``bpf_map_get_next_key()`` with ``cur_key`` set to
+``NULL``. Subsequent calls will fetch the next key that follows the
+current key. ``bpf_map_get_next_key()`` returns ``0`` on success,
+``-ENOENT`` if ``cur_key`` is the last key in the trie, or negative
+error in case of failure.
+
+``bpf_map_get_next_key()`` will iterate through the LPM trie elements
+from leftmost leaf first. This means that iteration will return more
+specific keys before less specific ones.
+
+Examples
+========
+
+Please see ``tools/testing/selftests/bpf/test_lpm_map.c`` for examples
+of LPM trie usage from userspace. The code snippets below demonstrate
+API usage.
+
+Kernel BPF
+----------
+
+The following BPF code snippet shows how to declare a new LPM trie for IPv4
+address prefixes:
+
+.. code-block:: c
+
+    #include <linux/bpf.h>
+    #include <bpf/bpf_helpers.h>
+
+    struct ipv4_lpm_key {
+            __u32 prefixlen;
+            __u32 data;
+    };
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_LPM_TRIE);
+            __type(key, struct ipv4_lpm_key);
+            __type(value, __u32);
+            __uint(map_flags, BPF_F_NO_PREALLOC);
+            __uint(max_entries, 255);
+    } ipv4_lpm_map SEC(".maps");
+
+The following BPF code snippet shows how to lookup by IPv4 address:
+
+.. code-block:: c
+
+    void *lookup(__u32 ipaddr)
+    {
+            struct ipv4_lpm_key key = {
+                    .prefixlen = 32,
+                    .data = ipaddr
+            };
+
+            return bpf_map_lookup_elem(&ipv4_lpm_map, &key);
+    }
+
+Userspace
+---------
+
+The following snippet shows how to insert an IPv4 prefix entry into an
+LPM trie:
+
+.. code-block:: c
+
+    int add_prefix_entry(int lpm_fd, __u32 addr, __u32 prefixlen, struct value *value)
+    {
+            struct ipv4_lpm_key ipv4_key = {
+                    .prefixlen = prefixlen,
+                    .data = addr
+            };
+            return bpf_map_update_elem(lpm_fd, &ipv4_key, value, BPF_ANY);
+    }
+
+The following snippet shows a userspace program walking through the entries
+of an LPM trie:
+
+
+.. code-block:: c
+
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    void iterate_lpm_trie(int map_fd)
+    {
+            struct ipv4_lpm_key *cur_key = NULL;
+            struct ipv4_lpm_key next_key;
+            struct value value;
+            int err;
+
+            for (;;) {
+                    err = bpf_map_get_next_key(map_fd, cur_key, &next_key);
+                    if (err)
+                            break;
+
+                    bpf_map_lookup_elem(map_fd, &next_key, &value);
+
+                    /* Use key and value here */
+
+                    cur_key = &next_key;
+            }
+    }
-- 
2.35.1

