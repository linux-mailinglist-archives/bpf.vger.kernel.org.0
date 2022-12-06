Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529DA64419B
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 11:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiLFK4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 05:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiLFK4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 05:56:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC897646;
        Tue,  6 Dec 2022 02:56:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q7so22904396wrr.8;
        Tue, 06 Dec 2022 02:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVlIS9HqoRWgdQRFba7pm/vsCW9bALpjGInH8aBIHBA=;
        b=CskNLxD8s+73CC1mfx9c8D3nXRfqWSmuai6glVwbjQfHP4nGjdWj3oiMMY16W2spQv
         WpfX1ywKRj7d9jbreITzNtC7zk5qUVY96crdjO97GZ70yTZcbRV7i7rREnmz5/rcBLxJ
         /RISbHYGmzMr1ktzQCs8rANL5vvI+NKGQqJ0nYg6uUg9P8qd0bq87A0Y4fLdvtHFeR8E
         frOHpUOW13CwBkMv+D51TC/fbXxJGe0X8BVh3fWiGS6AIXqb6hDbnfAaqD9SjCPWcHMg
         2hjK/WlZwRRr0Oi8KxNkGajvY4oW1dr6wpKoPO8TkJ39nqaPAnwlvNDJibQHwhFCTiS+
         yb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVlIS9HqoRWgdQRFba7pm/vsCW9bALpjGInH8aBIHBA=;
        b=WaLiCKDM8BKbJxcS51Yy2IV3hDWQpjPYMC3vVRp5BFW5nr2O56KoDAw/HfgMJHO9zp
         4JyD+/BBrM85x7DVgcdy56D1Gnx+pMzycD+wyi2H7sp0Sx0LOtUdAyBJ+ruJtC1Et7Cr
         AOlLeTDEibvJhBRME2r1XtUcqkqsEQHOwu27jSRfScxvR175zhTKEMSNx4aoBTjI1erZ
         PxQObOxrvEsY6zzIFb6BCTEn4CR7/0M7SrhuoA4gf5D3At03B3mCmTFunjPeu1/y1LPX
         Tz73THpxSUDeS6Ckwq1oUVpyyUnrD1pYpxmoOnWW5JLp717RVsLcExbIRKUzpvfIpyDz
         BtFA==
X-Gm-Message-State: ANoB5pn37lZ7+l20cazI6gbZfOBn9QaMVEvrZccTuCKvcvVTM/7wpFR0
        141VwelCJudH2U+KC9Q+m6BEeMt/1PvZug==
X-Google-Smtp-Source: AA0mqf7jyV+yrsnMNmCtiT26cXnXi2i/lekuy4Aj5Re7IGRjhmmPFgnURj0AuchUaXQGClfYzJX7yg==
X-Received: by 2002:a5d:67ca:0:b0:242:7174:c82f with SMTP id n10-20020a5d67ca000000b002427174c82fmr3166399wrw.259.1670324175094;
        Tue, 06 Dec 2022 02:56:15 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:98f:4f05:72a0:75f0])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b00241bd7a7165sm15997055wrr.82.2022.12.06.02.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:56:14 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v2] docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE
Date:   Tue,  6 Dec 2022 10:55:52 +0000
Message-Id: <20221206105552.74372-1-donald.hunter@gmail.com>
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
v1 -> v2:
- Fix bpf_sk_storage_* function signatures, reported by Yonghong Song
- Fix NULL return on failure, reported by Yonghong Song

Documentation/bpf/map_sk_storage.rst | 142 +++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/bpf/map_sk_storage.rst

diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
new file mode 100644
index 000000000000..38b385c53da9
--- /dev/null
+++ b/Documentation/bpf/map_sk_storage.rst
@@ -0,0 +1,142 @@
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
+   long bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
+
+Socket-local storage can be retrieved using the ``bpf_sk_storage_get()`` helper. The helper gets
+the storage from ``sk`` that is identified by ``map``.  If the
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then ``bpf_sk_storage_get()`` will create the
+storage for ``sk`` if it does not already exist. ``value`` can be used together with
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it will be zero
+initialized. Returns a pointer to the storage on success, or ``NULL`` in case of failure.
+
+.. note::
+   - ``sk`` is a kernel ``struct sock`` pointer for LSM program.
+   - ``sk`` is a ``struct bpf_sock`` pointer for other program types.
+
+bpf_sk_storage_delete()
+~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
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
+                                         BPF_LOCAL_STORAGE_GET_F_CREATE);
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

