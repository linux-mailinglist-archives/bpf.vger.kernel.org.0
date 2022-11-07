Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F93F61F49F
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 14:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiKGNsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 08:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKGNst (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 08:48:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0A1B1C1;
        Mon,  7 Nov 2022 05:48:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o4so16310919wrq.6;
        Mon, 07 Nov 2022 05:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrUyRGzwE2ra16JuFmiYoijJKLT6LRaYNEIkUv8jxGc=;
        b=YYI1hnetdP6OmFZwGJk4mhjMc40VULbuk5jWaMguvr01Slbr4wiLy7x3EgjEEcfeWZ
         M7t8/Zzch/lICelcpBhFq9hB1D0ry3et/sZ/UcCuXxewlsVa19HyyXxzVv2th/hAmuGV
         27NVyps0+BgQgVcm4pM1Ijo70HWDH97hrNMP0VeBfYRZTD3Gyi7poKF7u+kdraeQ0SGU
         miSXlBJD7m5DUaaV+YGyVbJ2mMDkmNnJaNFTCG9n0Nt+4Lo09c0LDcsvF8R9VzNl8ZV9
         kwA5k/xieQGt4vAlkx+YoBFiFnoFaeSZW4hX0PH2uZhxcqeTtIKczBigEGWzwcnNy5Mw
         0VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrUyRGzwE2ra16JuFmiYoijJKLT6LRaYNEIkUv8jxGc=;
        b=CJTlGPU0elaaZu1Hq+bg97twCijV1T4mpOgdZ4Y2n86pwmRHWZ+dyAjs0ysA8Tla/B
         i8ym77sqbJJSi1DnZNQaqjWqHFUf1QE94JMDj7ZWdba8gkJndf9AbIgFr5F1GyT8JdPr
         EHJ/Y3nb41tYZ9n2ofRR6OVe57EB0l7T14KB2h6NID/DXrpKUyzEMbwD6Vcrk7CT4ecm
         ccEXuDa8LSHUhPrB+NccH0Q0214E5hR0+/d9MLLmuQSnl31FP8BXgWa1jAknw4uZOtWz
         9L2xxlll7tfcx5XzWzxaitTIK1guatrhADk/vedVO0OrqRuXua3UMZROg9BUC8meiARQ
         R6bg==
X-Gm-Message-State: ACrzQf2rE+KERixmsfvumKf1G417trxfOPCoeJJtM/JL54vXJE1UvhBc
        4HMtr4qZaBp/TGDXLePU1lPlqjVngpNtWQ==
X-Google-Smtp-Source: AMsMyM5uzEBl2o9U1yFezMAlIGgYgVNM3K41WHriM+gNssdy1c660NjenqwNcOsfm0zsmzV7zgMCRw==
X-Received: by 2002:adf:ed4a:0:b0:236:aef1:9c75 with SMTP id u10-20020adfed4a000000b00236aef19c75mr31432407wro.258.1667828925431;
        Mon, 07 Nov 2022 05:48:45 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:5c58:5d45:1992:a386])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c168800b003cf47fdead5sm8140396wmn.30.2022.11.07.05.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:48:44 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maryam Tahhan <mtahhan@redhat.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next v3] docs/bpf: document BPF ARRAY_OF_MAPS and HASH_OF_MAPS
Date:   Mon,  7 Nov 2022 13:48:40 +0000
Message-Id: <20221107134840.92633-1-donald.hunter@gmail.com>
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
v2 -> v3:
- Update BPF example to show declarative initialisation, as
  suggested by Andrii Nakryiko
- Use LIBBPF_OPTS inline initialisation, as suggested by
  Andrii Nakryiko
- Fix duplicate label warning,
Reported-by: kernel test robot <lkp@intel.com>

v1 -> v2:
- Fix formatting nits
- Tidy up code snippets as suggested by Maryam Tahhan
---
 Documentation/bpf/map_of_maps.rst | 126 ++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/bpf/map_of_maps.rst

diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_maps.rst
new file mode 100644
index 000000000000..63e41b06a91d
--- /dev/null
+++ b/Documentation/bpf/map_of_maps.rst
@@ -0,0 +1,126 @@
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
+For ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` the key is an unsigned 32-bit integer index
+into the array. The array is a fixed size with ``max_entries`` elements that are
+zero initialized when created.
+
+For ``BPF_MAP_TYPE_HASH_OF_MAPS`` the key type can be chosen when defining the
+map. The kernel is responsible for allocating and freeing key/value pairs, up to
+the max_entries limit that you specify. Hash maps use pre-allocation of hash
+table elements by default. The ``BPF_F_NO_PREALLOC`` flag can be used to disable
+pre-allocation when it is too memory expensive.
+
+Usage
+=====
+
+Kernel BPF Helper
+-----------------
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
+Kernel BPF Example
+------------------
+
+This snippet shows how to create and initialise an array of devmaps in a BPF
+program. Note that the outer array can only be modified from user space using
+the syscall API.
+
+.. code-block:: c
+
+    struct inner_map {
+            __uint(type, BPF_MAP_TYPE_DEVMAP);
+            __uint(max_entries, 10);
+            __type(key, __u32);
+            __type(value, __u32);
+    } inner_map1 SEC(".maps"), inner_map2 SEC(".maps");
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+            __uint(max_entries, 2);
+            __type(key, __u32);
+            __array(values, struct inner_map);
+    } outer_map SEC(".maps") = {
+            .values = { &inner_map1,
+                        &inner_map2 }
+    };
+
+See ``progs/test_bpf_map_in_map.c`` in ``tools/testing/selftests/bpf`` for more
+examples of declarative initialisation of outer maps.
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
+            LIBBPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd = inner_fd);
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
+            return bpf_map_update_elem(outer_fd, &index, &fd, BPF_ANY);
+    }
+
+References
+==========
+
+- https://lore.kernel.org/netdev/20170322170035.923581-3-kafai@fb.com/
+- https://lore.kernel.org/netdev/20170322170035.923581-4-kafai@fb.com/
-- 
2.35.1

