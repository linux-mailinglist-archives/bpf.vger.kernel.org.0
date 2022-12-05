Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6E1642CA3
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 17:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLEQQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 11:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLEQQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 11:16:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B4273F;
        Mon,  5 Dec 2022 08:16:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n16-20020a05600c3b9000b003d08febff59so5392114wms.3;
        Mon, 05 Dec 2022 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+qxFvyZ68J9KkefVwXjrljIu6tiSqfHk3mjKfN4Iac=;
        b=GGWV9fd2ancmpFmA0TvgcQQs+y+bSwSwALBh6QfnIG1lWBhxRVNT6VFFSLO838pdKz
         nMQfhhSsADV1SaEnixyZLhShsn7Lc+Wj+/yt+tdjwKfREB0D6IR48LftCds/mNXq7pkz
         HFnjinE7aqdGMujWaxr6A4qqV0L3b5gT4Eg7dGL0sqOjh2cgbVGVOYcNec59u32mUhhY
         V/FsgZ+/eiKJD2dKQqfSukiYcA6FY1aNRD4zXqM4AZWZsx8hIZVCRASASMQLKTTh7G4e
         5hB042VMzNvMY/UIqpdbRNEDv4Dsk1V/QWc53raZ8TaR8QGt4bovi3G8JcOtc8JyiPHv
         vVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+qxFvyZ68J9KkefVwXjrljIu6tiSqfHk3mjKfN4Iac=;
        b=rgMSwk44kZYNGWxY/DAf4XbUs7Z4vS8aC8CjpbAi3RsxafBideBOv0JrHCK4z49lzm
         bxZ7uiLOie8mIIcZ3qZK0ZtIm7952zVLHO0XNQodsuy7XcY7c2VxDow0XxBmq02T6qU2
         areLoVoHtgsnM/yb+ZCBpHDq1r1grk6YubE/aJJJSxlLEciTBI/2fu9TU/fkJHbvg913
         1JqwYx6RJldoO0n7iGJutIJMuMCxHs4A9TQjotxAK+Z3CpfEFUCOlSpoyTGtgY4Fmp21
         QoXpWDcBgYqSibrFcM3h0d/VQPVe49nN2R2pBdP6GXIQWf2iY+FhMTfY2HbzKnOn3LPo
         xSCA==
X-Gm-Message-State: ANoB5pmYyc3GlhgJ7D43SD2M74fqnGeEVXODLoVrF4T3WE14MWe4OziR
        QFegUetRBxZ4fIAZWcASFWW8mHe91GwyyQ==
X-Google-Smtp-Source: AA0mqf5Eib78dyLVR/PyQDZI9I2hHs0cb0L1bgLFPBl/2gNVo77npFgvV+R64FDUZWE3izQn1DuXeQ==
X-Received: by 2002:a1c:f616:0:b0:3cf:b1c2:c911 with SMTP id w22-20020a1cf616000000b003cfb1c2c911mr52264123wmc.16.1670256967928;
        Mon, 05 Dec 2022 08:16:07 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:8553:ec6:7ede:322a])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003c6c182bef9sm30333831wmq.36.2022.12.05.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:16:07 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE
Date:   Mon,  5 Dec 2022 16:15:55 +0000
Message-Id: <20221205161555.34943-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
kernel version introduced, usage and examples.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_sk_storage.rst | 138 +++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/bpf/map_sk_storage.rst

diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
new file mode 100644
index 000000000000..abb0c60ec5a4
--- /dev/null
+++ b/Documentation/bpf/map_sk_storage.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+=======================
+BPF_MAP_TYPE_SK_STORAGE
+=======================
+
+.. note::
+   - ``BPF_MAP_TYPE_SK_STORAGE`` was introduced in kernel version 5.2
+
+``BPF_MAP_TYPE_SK_STORAGE`` is used to provide socket-local storage for BPF programs. A map of
+type ``BPF_MAP_TYPE_SK_STORAGE`` declares the type of storage to be provided and acts as the
+handle for accessing the socket-local storage from a BPF program. The key type must be ``int``
+and ``max_entries`` must be set to ``0``.
+
+The ``BPF_F_NO_PREALLOC`` must be used when creating a map for socket-local storage. The kernel
+is responsible for allocating storage for a socket when requested and for freeing the storage
+when either the map or the socket is deleted.
+
+Usage
+=====
+
+Kernel BPF
+----------
+
+bpf_sk_storage_get()
+~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   long bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
+
+Socket-local storage can be retrieved using the ``bpf_sk_storage_get()`` helper. The helper gets
+the storage from ``sk`` that is identified by ``map``.  If the
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then ``bpf_sk_storage_get()`` will create the
+storage for ``sk`` if it does not already exist. ``value`` can be used together with
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it will be zero
+initialized. Returns a pointer to the storage on success, or ``0`` in case of failure.
+
+bpf_sk_storage_delete()
+~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   long bpf_sk_storage_delete(struct bpf_map *map, struct bpf_sock *sk)
+
+Socket-local storage can be deleted using the ``bpf_sk_storage_delete()`` helper. The helper
+deletes the storage from ``sk`` that is identified by ``map``. Returns ``0`` on success, or negative
+error in case of failure.
+
+User space
+----------
+
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_update_elem(int map_fd, const void *key, const void *value, __u64 flags)
+
+Socket-local storage with type identified by ``map_fd`` for the socket identified by ``key`` can
+be added or updated using the ``bpf_map_update_elem()`` libbpf function. ``key`` must be a
+pointer to a valid ``fd`` in the user space program. The ``flags`` parameter can be used to
+control the update behaviour:
+
+- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
+- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
+  exist
+- ``BPF_EXIST`` will update existing storage for ``fd``
+
+Returns ``0`` on success, or negative error in case of failure.
+
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_lookup_elem(int map_fd, const void *key, void *value)
+
+Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be
+retrieved using the ``bpf_map_lookup_elem()`` libbpf function. ``key`` must be a pointer to a
+valid ``fd`` in the user space program. Returns ``0`` on success, or negative error in case of
+failure.
+
+bpf_map_delete_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_delete_elem (int map_fd, const void *key)
+
+Socket-local storage for the socket identified by ``key`` belonging to ``map_fd`` can be deleted
+using the ``bpf_map_delete_elem()`` libbpf function. Returns ``0`` on success, or negative error
+in case of failure.
+
+Examples
+========
+
+Kernel BPF
+----------
+
+This snippet shows how to declare socket-local storage in a BPF program:
+
+.. code-block:: c
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_SK_STORAGE);
+            __uint(map_flags, BPF_F_NO_PREALLOC);
+            __type(key, int);
+            __type(value, struct my_storage);
+    } socket_storage SEC(".maps");
+
+This snippet shows how to retrieve socket-local storage in a BPF program:
+
+.. code-block:: c
+
+    SEC("sockops")
+    int _sockops(struct bpf_sock_ops *ctx)
+    {
+            struct my_storage *storage;
+            struct bpf_sock *sk;
+
+            sk = ctx->sk;
+            if (!sk)
+                    return 1;
+
+            storage = bpf_sk_storage_get(&socket_storage, sk, 0,
+                                         BPF_SK_STORAGE_GET_F_CREATE);
+            if (!storage)
+                    return 1;
+
+            /* Use 'storage' here */
+    }
+
+References
+==========
+
+https://lwn.net/ml/netdev/20190426171103.61892-1-kafai@fb.com/
-- 
2.38.1

