Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A372A649BD7
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 11:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiLLKQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiLLKQj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 05:16:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE28C6592;
        Mon, 12 Dec 2022 02:16:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so11545456wrm.2;
        Mon, 12 Dec 2022 02:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6CvzDc3g730+qXKZLiK6NaEy5ZkbFhBBsP4UvcP+jc=;
        b=dmOB28GWl+3NoZ6i49PcH+E5sODsDFQ+urrX6EIsVzFYF5vtuxsP7YHEy5TSqj73gc
         pjPT696uqhzNdGy3CP+H/eBywiHX9VBHZSe4IXyFt6DyXuqOor1G9GGuYlSUu1tF2lCt
         MNAdeYjf2M9ZIIyAUAP3psqK+OS/gt4ZHoH9LA6C0Rcnxlep/jKHNlrDfjN/qn5MQAva
         IqdoNMjHpdMSYwQZINKcnUErov61ErZ5pkcQL17IzYg2TLkBnJLIjvRDgdH7PiKOQHHi
         1rQyE4B/R5O6taH/0KjMI5Br7FKB/YQO3HtPlQBcF6va8t/l5aQGC7zPvGkd/lOwg99/
         DvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6CvzDc3g730+qXKZLiK6NaEy5ZkbFhBBsP4UvcP+jc=;
        b=5W9UFvhcS24brwS/cSzMqrpSIDhaWC4mcyS3envWCCT11c6sXde/JUGWUrHrYoOkIb
         a5eqV0LgM0MIlGYSojFexFiryO7mxC7EnfU8bfI0JXUxDkvmWV5RSEzcpgwAz9E+kKQh
         7lLfJgIoPyXdYZaFofRucRPB49/BKj4mDvelvhckuMPlrlwXh6PZTQf4mP7v5WFcvmm+
         MITcouysNnEFG/7IQutm6wBQsMcLb9pdmGNLHaUdizT8suWXzKXEdjsp/W62LOd1IrTm
         U3yFd4SYNnZSeD8KIKIsQ9BBGh56NMmMifVu9Bcn3yFImDvhIr8IOUJY2kgaBlN7Sir7
         joVw==
X-Gm-Message-State: ANoB5pmgG3Vv4aesoaI4zbOERLmkz5lI+loPiSvsSqaZw/t2GANK2w9k
        IZ8mpVsxwVzwcBVzcM3AR/pverseC5wvHQ==
X-Google-Smtp-Source: AA0mqf5Xb4Ok+KYwLRr+Vz9DyUCrE2Ecn7X74DbrpxqY6Ii902XTigGGXuhoODkO3EQSQLt+PguUeQ==
X-Received: by 2002:a5d:45ce:0:b0:242:4383:7e80 with SMTP id b14-20020a5d45ce000000b0024243837e80mr9664650wrs.22.1670840195842;
        Mon, 12 Dec 2022 02:16:35 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:f1ca:f257:9b2b:4489])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b00236545edc91sm8397506wrm.76.2022.12.12.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 02:16:34 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>,
        David Vernet <void@manifault.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] docs/bpf: Reword docs for BPF_MAP_TYPE_SK_STORAGE
Date:   Mon, 12 Dec 2022 10:16:00 +0000
Message-Id: <20221212101600.56026-1-donald.hunter@gmail.com>
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

Improve the grammar of the function descriptions and highlight
that the key is a socket fd.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Fixes: f3212ad5b7e9 ("docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE")
Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
---
 Documentation/bpf/map_sk_storage.rst | 56 +++++++++++++++-------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
index 047e16c8aaa8..4e9d23ab9ecd 100644
--- a/Documentation/bpf/map_sk_storage.rst
+++ b/Documentation/bpf/map_sk_storage.rst
@@ -34,13 +34,12 @@ bpf_sk_storage_get()
 
    void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
 
-Socket-local storage can be retrieved using the ``bpf_sk_storage_get()``
-helper. The helper gets the storage from ``sk`` that is associated with ``map``.
-If the ``BPF_LOCAL_STORAGE_GET_F_CREATE`` flag is used then
-``bpf_sk_storage_get()`` will create the storage for ``sk`` if it does not
-already exist. ``value`` can be used together with
-``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise it
-will be zero initialized. Returns a pointer to the storage on success, or
+Socket-local storage for ``map`` can be retrieved from socket ``sk`` using the
+``bpf_sk_storage_get()`` helper. If the ``BPF_LOCAL_STORAGE_GET_F_CREATE``
+flag is used then ``bpf_sk_storage_get()`` will create the storage for ``sk``
+if it does not already exist. ``value`` can be used together with
+``BPF_LOCAL_STORAGE_GET_F_CREATE`` to initialize the storage value, otherwise
+it will be zero initialized. Returns a pointer to the storage on success, or
 ``NULL`` in case of failure.
 
 .. note::
@@ -54,9 +53,9 @@ bpf_sk_storage_delete()
 
    long bpf_sk_storage_delete(struct bpf_map *map, void *sk)
 
-Socket-local storage can be deleted using the ``bpf_sk_storage_delete()``
-helper. The helper deletes the storage from ``sk`` that is identified by
-``map``. Returns ``0`` on success, or negative error in case of failure.
+Socket-local storage for ``map`` can be deleted from socket ``sk`` using the
+``bpf_sk_storage_delete()`` helper. Returns ``0`` on success, or negative
+error in case of failure.
 
 User space
 ----------
@@ -68,16 +67,20 @@ bpf_map_update_elem()
 
    int bpf_map_update_elem(int map_fd, const void *key, const void *value, __u64 flags)
 
-Socket-local storage for the socket identified by ``key`` belonging to
-``map_fd`` can be added or updated using the ``bpf_map_update_elem()`` libbpf
-function. ``key`` must be a pointer to a valid ``fd`` in the user space
-program. The ``flags`` parameter can be used to control the update behaviour:
+Socket-local storage for map ``map_fd`` can be added or updated locally to a
+socket using the ``bpf_map_update_elem()`` libbpf function. The socket is
+identified by a `socket` ``fd`` stored in the pointer ``key``. The pointer
+``value`` has the data to be added or updated to the socket ``fd``. The type
+and size of ``value`` should be the same as the value type of the map
+definition.
 
-- ``BPF_ANY`` will create storage for ``fd`` or update existing storage.
-- ``BPF_NOEXIST`` will create storage for ``fd`` only if it did not already
-  exist, otherwise the call will fail with ``-EEXIST``.
-- ``BPF_EXIST`` will update existing storage for ``fd`` if it already exists,
-  otherwise the call will fail with ``-ENOENT``.
+The ``flags`` parameter can be used to control the update behaviour:
+
+- ``BPF_ANY`` will create storage for `socket` ``fd`` or update existing storage.
+- ``BPF_NOEXIST`` will create storage for `socket` ``fd`` only if it did not
+  already exist, otherwise the call will fail with ``-EEXIST``.
+- ``BPF_EXIST`` will update existing storage for `socket` ``fd`` if it already
+  exists, otherwise the call will fail with ``-ENOENT``.
 
 Returns ``0`` on success, or negative error in case of failure.
 
@@ -88,10 +91,10 @@ bpf_map_lookup_elem()
 
    int bpf_map_lookup_elem(int map_fd, const void *key, void *value)
 
-Socket-local storage for the socket identified by ``key`` belonging to
-``map_fd`` can be retrieved using the ``bpf_map_lookup_elem()`` libbpf
-function. ``key`` must be a pointer to a valid ``fd`` in the user space
-program. Returns ``0`` on success, or negative error in case of failure.
+Socket-local storage for map ``map_fd`` can be retrieved from a socket using
+the ``bpf_map_lookup_elem()`` libbpf function. The storage is retrieved from
+the socket identified by a `socket` ``fd`` stored in the pointer
+``key``. Returns ``0`` on success, or negative error in case of failure.
 
 bpf_map_delete_elem()
 ~~~~~~~~~~~~~~~~~~~~~
@@ -100,9 +103,10 @@ bpf_map_delete_elem()
 
    int bpf_map_delete_elem(int map_fd, const void *key)
 
-Socket-local storage for the socket identified by ``key`` belonging to
-``map_fd`` can be deleted using the ``bpf_map_delete_elem()`` libbpf
-function. Returns ``0`` on success, or negative error in case of failure.
+Socket-local storage for map ``map_fd`` can be deleted from a socket using the
+``bpf_map_delete_elem()`` libbpf function. The storage is deleted from the
+socket identified by a `socket` ``fd`` stored in the pointer ``key``. Returns
+``0`` on success, or negative error in case of failure.
 
 Examples
 ========
-- 
2.38.1

