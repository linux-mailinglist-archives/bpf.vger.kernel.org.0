Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837906457D5
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 11:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLGK2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 05:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLGK1d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 05:27:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480D18B;
        Wed,  7 Dec 2022 02:27:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so27419309wrr.8;
        Wed, 07 Dec 2022 02:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldf8d0n8Tv+nxCdjhSi8ttPgMXIPCUcaARiXNvFu6fE=;
        b=lxjn8UcJk4Jy9HLpjX1IpUjkWGmVMtSnrrXAFbPazaYWybsnjO/6BcPCm9T7w/ZNFM
         5u0/EHaaeX/iExvC8auih09G4F+hxkmRj9obcRKqI0HhBaLmI1nIboUuc2vamkxgHA2i
         xQHk7Q5WhTa3070+jDNWGBr8MuOV+Nz49xW+xC8eioJrCHDnLX+XdF2uoQZITJD1jrL+
         sCewO8qdtTwdj9frCAsPt7ao0+jHJMRq1s3pioNYICLlSBMdsN77CG+pkO0umTGEI8BU
         2KJcSwjNM3PKMCqZeyTzVl9/4jsugBO9m85kQxI2oocR6rlEwmoh7GiFT/ar0XbAuXmg
         rhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldf8d0n8Tv+nxCdjhSi8ttPgMXIPCUcaARiXNvFu6fE=;
        b=yE+4+d+BgBDJuDm0OfhhDY3YFawHtrjSljz3BDXKMri2HSo19RKATFGV9gP17Jt5hR
         Ao5dpqtQwXW4tRAsAutq9j5kzciiaQDMDcmBgi55168bZcAZqt6OOOC0sb/KieY01Bma
         V6lCWp4z5Cbs1nhM4n/3wd+O4NWxT/eQM6YqsMvtPE+T7qVIEupOABVl/X5iGje6iLax
         qlNCV3JUFDfQoaf0dS+Nnofe02H5BiObVXg3ORF7jdVUM1A5idtl0D2wWpx4mqQPfBhw
         kGSvvwIsc03jA51xihEH8WBtpHqOepLQUT0LfeI5A1OaLlPIoVW1N0BOxA1ugaPMwYv/
         lT8w==
X-Gm-Message-State: ANoB5pnLxRAmFwQ2Neqvz93KHAOhoKQ1bzLUu6S7Rp5Dh1THs5P8WO1o
        vKLLtHUcACNgWsbr4iXn49zTlUD/k7nfuA==
X-Google-Smtp-Source: AA0mqf6tD/drvEoieA0U8UXlvHBpQmATNwbD+x61hxsbPonp1nv6Nj2JGic9F1cCy6JT/DvkmwUHZA==
X-Received: by 2002:a5d:4f92:0:b0:242:1845:8097 with SMTP id d18-20020a5d4f92000000b0024218458097mr26032286wru.666.1670408850086;
        Wed, 07 Dec 2022 02:27:30 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b95c:6432:1154:81bb])
        by smtp.gmail.com with ESMTPSA id d1-20020adff841000000b002420d51e581sm18649195wrq.67.2022.12.07.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:27:29 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v3] docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE
Date:   Wed,  7 Dec 2022 10:27:21 +0000
Message-Id: <20221207102721.33378-1-donald.hunter@gmail.com>
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
v2 -> v3:
- Fix void * return, reported by Yonghong Song
- Add tracing programs to API note, reported by Yonghong Song
v1 -> v2:
- Fix bpf_sk_storage_* function signatures, reported by Yonghong Song
- Fix NULL return on failure, reported by Yonghong Song

 Documentation/bpf/map_sk_storage.rst | 142 +++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/bpf/map_sk_storage.rst

diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
new file mode 100644
index 000000000000..955b287bb7de
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
+   void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
+
+Socket-local storage can be retrieved using the ``bpf_sk_storage_get()`` helper. The helper gets
+the storage from ``sk`` that is identified by ``map``.  If the
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then ``bpf_sk_storage_get()`` will create the
+storage for ``sk`` if it does not already exist. ``value`` can be used together with
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it will be zero
+initialized. Returns a pointer to the storage on success, or ``NULL`` in case of failure.
+
+.. note::
+   - ``sk`` is a kernel ``struct sock`` pointer for LSM or tracing programs.
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

