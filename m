Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9275860DE88
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiJZKCp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZKCp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 06:02:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25052D752;
        Wed, 26 Oct 2022 03:02:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a14so22656729wru.5;
        Wed, 26 Oct 2022 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVpJP2G232YzJan8ctsofYi/4ncJIo4/PSfjZAJDSTY=;
        b=R2L5kL4Y33qiTCWRGheBoktUNkZ24o4/vH4CpCbcHF47iNPeICYH/cmvfcqpt4qKwM
         rZaEl1mjHPxG9MbrBi9/AuH5Yum5a1QeVR6K0cFSHzNGQUuCvtavv0P6+STwkCBCM7HE
         p4uqxPRM4rG1+UOOPuo4UtQeaFTkYPttgXexs5ClKAXutBAWY6J0vcZmIB0VNeKJUnID
         80jaWx6gT4gl3RwXLmjIMrYnFMxJyPlH5FyFzEgb6qH6qcrF28aeXU7UIAethdVlm46z
         LLP787OOBl7PzmIxjDHpuzKiSD1yWaf3wFOwlw4lND8ohKrdZj9UoRKXXVqPzaBV5iSL
         sCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVpJP2G232YzJan8ctsofYi/4ncJIo4/PSfjZAJDSTY=;
        b=ByJsLM6WvKIkidNxboF6cEJgbV9vr4c4iss8CBKOM2RSybuSQ+eh7IZ3FfL1eyl6en
         N3CV+Y6p3bs82HF62tsk6Y8gbrDKdvXzSvKRN8VPDLUFrsh0iNSvFb7lqacRgWEqwlUf
         /c+YiNDQ6y9M8nGKJkXPdOQgVTEj2r070wvi1XamwCGiuUiuBGM9dV658alcUVtc0qKp
         IZr9qT/nnAXSJpPTAbD3K5REW71b9/izRMCXv+12Bi7pQhNArUnzRSm0mAPhW6nalVil
         o30CZvk5p/gsefE3juhns/WTfCgIPzghr3YlNSp0F1qsa/e7sZQ3wRnd8OldGvfT0tSt
         0paw==
X-Gm-Message-State: ACrzQf1NTR1ySJxN7NtLsh3LfUjAKnvUZm/URIwNutXykhKnvv00JTkk
        i4H7BqT6PkvfZrg0DRGMDBRruAcuSBmBrQ==
X-Google-Smtp-Source: AMsMyM6+u+qq9wwXX7w+Dr6FU6phxomipB3qqwajl/KEumrWIzyDEslKiLTcPw2uqUDi1RCa0L+kMw==
X-Received: by 2002:adf:e3cc:0:b0:235:95b1:2124 with SMTP id k12-20020adfe3cc000000b0023595b12124mr22707170wrm.693.1666778558807;
        Wed, 26 Oct 2022 03:02:38 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:d0eb:e336:b451:acd2])
        by smtp.gmail.com with ESMTPSA id j24-20020a05600c1c1800b003b49ab8ff53sm1530352wms.8.2022.10.26.03.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 03:02:38 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] Document BPF_MAP_TYPE_LPM_TRIE
Date:   Wed, 26 Oct 2022 11:02:32 +0100
Message-Id: <20221026100232.49181-1-donald.hunter@gmail.com>
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

Add documentation for BPF_MAP_TYPE_LPM_TRIE including kernel
BPF helper usage, userspace usage and examples.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_lpm_trie.rst | 179 +++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 Documentation/bpf/map_lpm_trie.rst

diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
new file mode 100644
index 000000000000..d57c967d11d0
--- /dev/null
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -0,0 +1,179 @@
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
+``-ENOENT`` if cur_key is the last key in the hash, or negative error in
+case of failure.
+
+``bpf_map_get_next_key()`` will iterate through the LPM trie elements
+from leftmost leaf first. This means that iteration will return more
+specific keys before less specific ones.
+
+Examples
+========
+
+Please see ``tools/samples/bpf/xdp_router_ipv4_user.c`` and
+``xdp_router_ipv4.bpf.c`` for a functional example. The code snippets
+below demonstrates API usage.
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
+The following snippet shows how to insert an IPv4 prefix entry into an LPM trie:
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
+The following snippet shows a userspace program walking through LPM trie
+entries:
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

