Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109264818B
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 12:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLILYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 06:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLILYN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 06:24:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9C67235;
        Fri,  9 Dec 2022 03:24:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5756005wmb.0;
        Fri, 09 Dec 2022 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IhybnMAirMpwasI4k5OijgVj9rfZZaM80xqCzvQmMuI=;
        b=H1CVfzkdTojKkj8z0tWgXgXiKmGc3kyUYUeRXLChJm0xLSoSrLwuXwGkklyrXACgF6
         SEKCqNGz/e8iJeyLnn4HyPoM5svhNLNlQsHLWtgJu/Uz3rLoSEb/UQmyxOemP2mh3KBd
         Pg2dYYhR61X49bzSjpazI+JmzBbfRwzruw2ts+TksytDsADAdXkrcz7y30KW4N67B2ZR
         1RftQ+RelL9+kQKYFWD4gvLP71re58kYd7JkdLClLBdICQD1dH+hEmbPC0MWEJOE4ma9
         D4colfBzkpzFkHH7WfP+fCznU/aejjwHDWsHf8ljeOXd7VEZFzJQ275qVieY7qE7SqQm
         qpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhybnMAirMpwasI4k5OijgVj9rfZZaM80xqCzvQmMuI=;
        b=4l/sOXYnIy6B+BI9SgM9a/S+8w8XLBl2QV8ozT/swcdpFDFqu4ZLzL5iWLsJGVKkPL
         7mBnHodw25oysx3Wazghxp73so1fJs/uNrvX2UpriWQzS3WWKryAzEzTsiZk4V3Ubraa
         g+BUEI3PqRweobGFY69tjs9wH372MxdQn+CXkVHZ5OpnWF0kmkZy0devPgenQSAZS5XP
         K5SxHhe9ZHYd3tcwe42S5bv9SmjMaMp3AGMUUPVoKGNjTMIRSSBTrwKtGWgxNYUNF8NR
         4FvnIeukhFadzWRQ0fBkpFVl2AEOEPKPDPoyjQomJz4ACr0BreXTvlMz/+39ak+5YMfV
         HaTA==
X-Gm-Message-State: ANoB5plJZ4dHdM6kCqJFfWYQGcK7G8WEkEOcldUAgLEokNQyjYe7pRGu
        f6G7bYn6mf7AbRkEI+WQrmIqEQryK2m73w==
X-Google-Smtp-Source: AA0mqf5NYuuDPXfeHaCinG9Pg6WMUc+TJMaqhUwX9SOKv3zOjPwJthjIfrxv108nXcUT/3znviJxfw==
X-Received: by 2002:a05:600c:4fd1:b0:3d0:6c60:b4d1 with SMTP id o17-20020a05600c4fd100b003d06c60b4d1mr5636139wmq.6.1670585049929;
        Fri, 09 Dec 2022 03:24:09 -0800 (PST)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c2ca500b003c6bbe910fdsm9845293wmc.9.2022.12.09.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 03:24:09 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        David Vernet <void@manifault.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v4] docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE
Date:   Fri,  9 Dec 2022 11:24:01 +0000
Message-Id: <20221209112401.69319-1-donald.hunter@gmail.com>
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
v3 -> v4:
- Update intro paragraph with detail about storage locality.
- Remove confusing text from bpf_map_update_elem()
  as reported by David Vernet
- Updated BPF_EXIST and BPF_NOEXIST behaviour as suggested
  by David Vernet
- Fixed extra space in function signature as reported by
  David Vernet
- Added reference to selftests for complete examples as
  suggested by Yonghong Song
v2 -> v3:
- Fix void * return, reported by Yonghong Song
- Add tracing programs to API note, reported by Yonghong Song
v1 -> v2:
- Fix bpf_sk_storage_* function signatures, reported by Yonghong Song
- Fix NULL return on failure, reported by Yonghong Song

 Documentation/bpf/map_sk_storage.rst | 155 +++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/bpf/map_sk_storage.rst

diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
new file mode 100644
index 000000000000..047e16c8aaa8
--- /dev/null
+++ b/Documentation/bpf/map_sk_storage.rst
@@ -0,0 +1,155 @@
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
+``BPF_MAP_TYPE_SK_STORAGE`` is used to provide socket-local storage for BPF
+programs. A map of type ``BPF_MAP_TYPE_SK_STORAGE`` declares the type of storage
+to be provided and acts as the handle for accessing the socket-local
+storage. The values for maps of type ``BPF_MAP_TYPE_SK_STORAGE`` are stored
+locally with each socket instead of with the map. The kernel is responsible for
+allocating storage for a socket when requested and for freeing the storage when
+either the map or the socket is deleted.
+
+.. note::
+  - The key type must be ``int`` and ``max_entries`` must be set to ``0``.
+  - The ``BPF_F_NO_PREALLOC`` flag must be used when creating a map for
+    socket-local storage.
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
+Socket-local storage can be retrieved using the ``bpf_sk_storage_get()``
+helper. The helper gets the storage from ``sk`` that is associated with ``map``.
+If the ``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then
+``bpf_sk_storage_get()`` will create the storage for ``sk`` if it does not
+already exist. ``value`` can be used together with
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it
+will be zero initialized. Returns a pointer to the storage on success, or
+``NULL`` in case of failure.
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
+Socket-local storage can be deleted using the ``bpf_sk_storage_delete()``
+helper. The helper deletes the storage from ``sk`` that is identified by
+``map``. Returns ``0`` on success, or negative error in case of failure.
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
+Socket-local storage for the socket identified by ``key`` belonging to
+``map_fd`` can be added or updated using the ``bpf_map_update_elem()`` libbpf
+function. ``key`` must be a pointer to a valid ``fd`` in the user space
+program. The ``flags`` parameter can be used to control the update behaviour:
+
+- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
+- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
+  exist, otherwise the call will fail with ``-EEXIST``.
+- ``BPF_EXIST`` will update existing storage for ``fd`` if it already exists,
+  otherwise the call will fail with ``-ENOENT``.
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
+Socket-local storage for the socket identified by ``key`` belonging to
+``map_fd`` can be retrieved using the ``bpf_map_lookup_elem()`` libbpf
+function. ``key`` must be a pointer to a valid ``fd`` in the user space
+program. Returns ``0`` on success, or negative error in case of failure.
+
+bpf_map_delete_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_delete_elem(int map_fd, const void *key)
+
+Socket-local storage for the socket identified by ``key`` belonging to
+``map_fd`` can be deleted using the ``bpf_map_delete_elem()`` libbpf
+function. Returns ``0`` on success, or negative error in case of failure.
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
+
+            return 1;
+    }
+
+
+Please see the ``tools/testing/selftests/bpf`` directory for functional
+examples.
+
+References
+==========
+
+https://lwn.net/ml/netdev/20190426171103.61892-1-kafai@fb.com/
-- 
2.38.1

