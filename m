Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D9620D27
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 11:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiKHKWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 05:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiKHKWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 05:22:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AA1E0D3;
        Tue,  8 Nov 2022 02:22:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so3347220wmi.3;
        Tue, 08 Nov 2022 02:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jv4scRgKtBySLGDgjJWwuwFVamakxMKqAypSIGD624=;
        b=DNZ4ybWF+SH+0/5zdj6u9V88M8Wz04xwjb0Wa7WJuWRH5Lpi4qFekvvfB+NPDs4UD4
         e8G/J96FqYFIw/FWK6iI0bKcY+fs5Y5mTqIMyI4wBB3Rjj16XKIAWL2w8ceD0vSO/v5O
         jY23S2JgpML77g7eLbvVN1hKRbHoPu/CAE/Vu4SnlFWIctLKGmcudpxUFuUX+/BXMPUf
         NCc7bqif8bbwYHK0SrvvEC2JCd8AmWcUcszVoG+gRuNYly2rakiClLHHtxP2Fa+YoLEl
         aXtJaxobpsLMSD0+FIOmXaPdwe7oCenj+QiaP/luto5KgC5gk3fQp1rJl42FWxtpLuSa
         M3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jv4scRgKtBySLGDgjJWwuwFVamakxMKqAypSIGD624=;
        b=cbIqkoHOQH4qAdyTnmUysImRxmXOt0+5cnufKG+UNc7NBDz5Y/lDJGyBVVDTUWmjo6
         Hrkc6Dyi2YV2J3jdz/sHNjjS/NRK1jfW3mG4xdDmUU4ysEIwrQ30EMFJVuSi1AJevu5e
         QsUe1EO0KMejkxDqOsSB4SU6lfQCU+fIzB/ARyxhtGXSRF0bUJNSlFt1LqdnezsmPQJC
         lusToifQ9BT85uihf0x23YPA4d9ues6jNdbZuJQJbHKNvgc/5PY3ElQRaKSAEhYdF0FP
         AlTm6ff+aF9QCUI8sNd18oCbobX92+SkE1x64/x9vNTm4gLtqgMzSpz2h7++FUk3EnyF
         HI+w==
X-Gm-Message-State: ANoB5pkQsilc0OgOs/CW2Y04OeU3pFoaOoj9kSUdWfgwuJbXNe9ym0dE
        qYFzhXPo8fau601K/dtPBbjfehdqF7jvnQ==
X-Google-Smtp-Source: AA0mqf4ml7Ki+y1+0C13ItGrDjNZPA+6rQO6+VL8LKIcapHQiQ540wENZhbEPdOxBYNTS2IJgTrZyA==
X-Received: by 2002:a1c:3bd4:0:b0:3cf:b2ac:bd91 with SMTP id i203-20020a1c3bd4000000b003cfb2acbd91mr4548927wma.128.1667902938881;
        Tue, 08 Nov 2022 02:22:18 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:550:1196:18a3:8071])
        by smtp.gmail.com with ESMTPSA id p15-20020adfce0f000000b0022cbf4cda62sm11776801wrn.27.2022.11.08.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 02:22:18 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        Donald Hunter <donald.hunter@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next v4] docs/bpf: document BPF ARRAY_OF_MAPS and HASH_OF_MAPS
Date:   Tue,  8 Nov 2022 10:22:15 +0000
Message-Id: <20221108102215.47297-1-donald.hunter@gmail.com>
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
v3 -> v4:
- Fix typo in filename, as reported by Yonghong Song
- Add lookup to list of ops, as reported by Yonghong Song
- Clean up declaration in example, as reported by Yonghong Song

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
index 000000000000..07212b9227a9
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
+The outer map supports element lookup, update and delete from user space using
+the syscall API. A BPF program is only allowed to do element lookup in the outer
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
+See ``progs/test_btf_map_in_map.c`` in ``tools/testing/selftests/bpf`` for more
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
+            LIBBPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd = inner_fd);
+            int fd;
+
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

