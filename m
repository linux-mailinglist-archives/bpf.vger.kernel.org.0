Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890DD5F9D82
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 13:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiJJLWJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 07:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiJJLWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 07:22:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239FF6E88C;
        Mon, 10 Oct 2022 04:22:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a10so16496484wrm.12;
        Mon, 10 Oct 2022 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkapbSOT+6/fphvbAmDdm2HCzoT7orT+K/+StPXsIRQ=;
        b=Y24H15o8za9OSatPy3nYWkXP58JY80ts9bmGmEBegfjxs1gVYg+AK3xXUhqz427akf
         BJPwV1WPtcVgjWQATbLCGDBHcxEI9aIM4fgVeCMq2NQxqKdh/4Dwp2TNXzeevNDQ6Ukk
         tXoleEJCAdCJOiG1nd2BTPQvBzXGcYXf30nBGXwKqIiqIuC0Ipnxn9srQtHiJ8im/+Vi
         VJF51Kaj5ZKmWXqeUl7AYEstDFo2ZwP2T3bVjcMF1TWiAxa+hWZzO753sEHh+deD6w0O
         C3N+NKI44CxifDjqEn2Ui12D81UM2fK6uhY97pM1O4grxKH1mKMuKxOXD5Ag+H8uqXMw
         +dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkapbSOT+6/fphvbAmDdm2HCzoT7orT+K/+StPXsIRQ=;
        b=rF0NESvuZ5PqXtRVDtXjBMzcO5IQ8m/CaoCwBGM8SI2COHUjo9gAC69PDiI9gI6rrv
         JHiUC8sLyWFZM2O6Nl7gU+kquW2ZMQL/glEd0GC60435sAENzwpoD7fC9MdzlTf/1YJ9
         fiDonFKZt5O9R0vDWb3i4yQaMkph1vVBxm8UPQP2C8OB9HlQ3u8/rXFEmy9A9UqVz82P
         rJR2oBnLO/NyMGIDgW6ASDBjbSPdZ4wVM+m7QjXjyv5CykVuRKMFYZPbatKBlvLvjF/O
         2ZWiKwccI2z2uQTriwSnHe038n4ceqhVRqad3XEu1E7VTWBR6tnheXQ8Ep/g2cZf/qbO
         XzQA==
X-Gm-Message-State: ACrzQf227HrAOvIb4aZzPiIwHviHJPecb25fmJ83xY2ssEBAM36Rkxa1
        iFfJCnqfX6vA4OMJ629MUbeE7JiSmws=
X-Google-Smtp-Source: AMsMyM70mzf9LQpF1vwNXBHB/f2J0JhP4cBSOobpjJL8/dIVTsAaJCd16JQtIobrT2tq1N0ehnD7VQ==
X-Received: by 2002:a05:6000:1817:b0:22e:397a:75ff with SMTP id m23-20020a056000181700b0022e397a75ffmr11168464wrh.567.1665400920874;
        Mon, 10 Oct 2022 04:22:00 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:5977:1129:cb7:b9ae])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c1c8700b003c5b790582fsm5824574wms.36.2022.10.10.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 04:21:59 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] bpf, docs: document BPF_MAP_TYPE_ARRAY_OF_MAPS and *_HASH_OF_MAPS
Date:   Mon, 10 Oct 2022 12:21:54 +0100
Message-Id: <20221010112154.39494-1-donald.hunter@gmail.com>
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
 Documentation/bpf/map_of_maps.rst | 145 ++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/bpf/map_of_maps.rst

diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_maps.rst
new file mode 100644
index 000000000000..16fcda8720de
--- /dev/null
+++ b/Documentation/bpf/map_of_maps.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+========================================================
+BPF_MAP_TYPE_ARRAY_OF_MAPS and BPF_MAP_TYPE_HASH_OF_MAPS
+========================================================
+
+.. note::
+   - ``BPF_MAP_TYPE_ARRAY_OF_MAPS`` and ``BPF_MAP_TYPE_HASH_OF_MAPS`` were
+     introduced in kernel version 4.12.
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
+into the array. The array is a fixed size with `max_entries` elements that are
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
+    struct redirect_map {
+            __uint(type, BPF_MAP_TYPE_DEVMAP);
+            __uint(max_entries, 32);
+            __type(key, enum skb_drop_reason);
+            __type(value, __u64);
+    } redirect_map SEC(".maps");
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+            __uint(max_entries, 2);
+            __uint(key_size, sizeof(int));
+            __uint(value_size, sizeof(int));
+            __array(values, struct redirect_map);
+    } outer_map SEC(".maps");
+
+This snippet shows how to lookup an outer map to retrieve an inner map.
+
+.. code-block:: c
+
+    SEC("xdp")
+    int redirect_by_priority(struct xdp_md *ctx) {
+            struct bpf_map *devmap;
+            int action = XDP_PASS;
+            int index = 0;
+
+            devmap = bpf_map_lookup_elem(&outer_arr, &index);
+            if (!devmap)
+                    return XDP_PASS;
+
+            /* use inner devmap here */
+
+            return action;
+    }
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
+            int fd, ret;
+
+            fd = bpf_map_create(BPF_MAP_TYPE_DEVMAP, name,
+                                sizeof(__u32), sizeof(__u32), 256, NULL);
+            if (fd < 0)
+                    return fd;
+
+            ret = bpf_map_update_elem(outer_fd, &index, &fd, BPF_NOEXIST);
+            return ret;
+    }
+
+References
+==========
+
+- https://lore.kernel.org/netdev/20170322170035.923581-3-kafai@fb.com/
+- https://lore.kernel.org/netdev/20170322170035.923581-4-kafai@fb.com/
-- 
2.35.1

