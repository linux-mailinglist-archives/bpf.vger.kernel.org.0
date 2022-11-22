Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790A1633F1B
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 15:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiKVOjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 09:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKVOjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 09:39:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67D4387A;
        Tue, 22 Nov 2022 06:39:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so11442598wmg.2;
        Tue, 22 Nov 2022 06:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlJM+ofSATO1uMNLBzTdEriQrZsj390BN1kZ4yLqU+w=;
        b=WXjkZu1KRCyHtz3afdZN6TgxXvbwz+ts2YkNe/dT6Z+B9Od5Lhmo7ZFUAJbaapQ/lw
         5s2VGv/Nj2Og/+M9AR3GTqXsQWDXfI6IX6TdkU3L89Cqy1pNSddWMTgE/fA13HhJywX7
         L3ocRmVbnvKyHnvSZtiRpwYkqaLG7W8nJe5se8GKDkRBhVQSM9TYbbCQM1TitzkE4mDX
         y+RqguCoP2Pm3dFtD9RHGCjSFjfu5RscKjlEXV6A6JYK28I1FtcTeGBByTDXWi8hhHbD
         lNlo9MdlSUIXDdq1qynW8yW8zxUP/q2IfiD9zkh24doZj+aVjmZPJQaeKqBBC0Is8C7B
         U70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlJM+ofSATO1uMNLBzTdEriQrZsj390BN1kZ4yLqU+w=;
        b=vIa49iFevnj5B7D5hawNEXNx1WozBmIeGRFakI5s3b+DTBt8fF+ahIfAwRvOVeALgs
         hVPRFL/rQGHho5YPKCkBeBvw1KHDgf2g/FMuATh5tNhSsRdx21bL1/y++PoZDqbZTwE9
         lUeSsR1ufsYhpelBneXKvi0sqygz+kTxaXtOMczwvcuUw3Ut2JbsVDinjDUQ3Bst63e0
         tjW2EwNUAvBrdWl02f1hZC4uJ9fnnR5UUCZ6c7UQefnQpOXPIduWa3XwqyJmKmUkCJ2K
         FG2/p/Ilaq3AmbNgOZUE9NfZEcS/T9b7dRfKWW6NpYSAzWU23r6e+brkwjcAIPYVz6tD
         0H2Q==
X-Gm-Message-State: ANoB5plX9w3KZrlFGA4NJvGVzR3qGxBkrtHlsa8NonpBr/x15Q9kkf7t
        pc52Njdn245gN0zKjdz7p849f+wLu2r1UA==
X-Google-Smtp-Source: AA0mqf6Q3Q4qkzYIx3EEdwRgNz7te/zeRpPFBh7LRaWzdo70GAvZIveaD7NDtKFnwIxsRK3e81gMCg==
X-Received: by 2002:a05:600c:3d10:b0:3cf:8a44:e1eb with SMTP id bh16-20020a05600c3d1000b003cf8a44e1ebmr7366655wmb.189.1669127990192;
        Tue, 22 Nov 2022 06:39:50 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:986c:3a9f:58a6:a738])
        by smtp.gmail.com with ESMTPSA id q125-20020a1c4383000000b003c6cd82596esm21955825wma.43.2022.11.22.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:39:49 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH bpf-next v1] docs/bpf: Fix sphinx warnings in BPF map docs
Date:   Tue, 22 Nov 2022 14:39:33 +0000
Message-Id: <20221122143933.91321-1-donald.hunter@gmail.com>
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

Fix duplicate C declaration warnings when using sphinx >= 3.1

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reported-by: Akira Yokosawa <akiyks@gmail.com>
Link: https://lore.kernel.org/bpf/ed4dac84-1b12-5c58-e4de-93ab9ac67c09@gmail.com
---
 Documentation/bpf/map_array.rst       | 20 ++++++++++++---
 Documentation/bpf/map_hash.rst        | 33 ++++++++++++++++++++----
 Documentation/bpf/map_lpm_trie.rst    | 24 +++++++++++++++---
 Documentation/bpf/map_of_maps.rst     |  6 ++++-
 Documentation/bpf/map_queue_stack.rst | 36 ++++++++++++++++++++++-----
 5 files changed, 99 insertions(+), 20 deletions(-)

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
index 97bb80333254..f2f51a53e8ae 100644
--- a/Documentation/bpf/map_array.rst
+++ b/Documentation/bpf/map_array.rst
@@ -32,7 +32,11 @@ Usage
 Kernel BPF
 ----------
 
-.. c:function::
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
 
 Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
@@ -40,7 +44,11 @@ This helper returns a pointer into the array element, so to avoid data races
 with userspace reading the value, the user must use primitives like
 ``__sync_fetch_and_add()`` when updating the value in-place.
 
-.. c:function::
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
 
 Array elements can be updated using the ``bpf_map_update_elem()`` helper.
@@ -53,7 +61,7 @@ To clear an array element, you may use ``bpf_map_update_elem()`` to insert a
 zero value to that index.
 
 Per CPU Array
-~~~~~~~~~~~~~
+-------------
 
 Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs
 across different CPUs. To restrict storage to a single CPU, you may use a
@@ -63,7 +71,11 @@ When using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` the ``bpf_map_update_elem()`` and
 ``bpf_map_lookup_elem()`` helpers automatically access the slot for the current
 CPU.
 
-.. c:function::
+bpf_map_lookup_percpu_elem()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
 
 The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the array
diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index e85120878b27..8669426264c6 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -34,7 +34,14 @@ the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.
 Usage
 =====
 
-.. c:function::
+Kernel BPF
+----------
+
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
 
 Hash entries can be added or updated using the ``bpf_map_update_elem()``
@@ -49,14 +56,22 @@ parameter can be used to control the update behaviour:
 ``bpf_map_update_elem()`` returns 0 on success, or negative error in
 case of failure.
 
-.. c:function::
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
 
 Hash entries can be retrieved using the ``bpf_map_lookup_elem()``
 helper. This helper returns a pointer to the value associated with
 ``key``, or ``NULL`` if no entry was found.
 
-.. c:function::
+bpf_map_delete_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_delete_elem(struct bpf_map *map, const void *key)
 
 Hash entries can be deleted using the ``bpf_map_delete_elem()``
@@ -70,7 +85,11 @@ For ``BPF_MAP_TYPE_PERCPU_HASH`` and ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
 the ``bpf_map_update_elem()`` and ``bpf_map_lookup_elem()`` helpers
 automatically access the hash slot for the current CPU.
 
-.. c:function::
+bpf_map_lookup_percpu_elem()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
 
 The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the
@@ -89,7 +108,11 @@ See ``tools/testing/selftests/bpf/progs/test_spin_lock.c``.
 Userspace
 ---------
 
-.. c:function::
+bpf_map_get_next_key()
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    int bpf_map_get_next_key(int fd, const void *cur_key, void *next_key)
 
 In userspace, it is possible to iterate through the keys of a hash using
diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
index 31be1aa7ba2c..74d64a30f500 100644
--- a/Documentation/bpf/map_lpm_trie.rst
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -35,7 +35,11 @@ Usage
 Kernel BPF
 ----------
 
-.. c:function::
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
 
 The longest prefix entry for a given data value can be found using the
@@ -48,7 +52,11 @@ performing longest prefix lookups. For example, when searching for the
 longest prefix match for an IPv4 address, ``prefixlen`` should be set to
 ``32``.
 
-.. c:function::
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
 
 Prefix entries can be added or updated using the ``bpf_map_update_elem()``
@@ -61,7 +69,11 @@ case of failure.
     The flags parameter must be one of BPF_ANY, BPF_NOEXIST or BPF_EXIST,
     but the value is ignored, giving BPF_ANY semantics.
 
-.. c:function::
+bpf_map_delete_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_delete_elem(struct bpf_map *map, const void *key)
 
 Prefix entries can be deleted using the ``bpf_map_delete_elem()``
@@ -74,7 +86,11 @@ Userspace
 Access from userspace uses libbpf APIs with the same names as above, with
 the map identified by ``fd``.
 
-.. c:function::
+bpf_map_get_next_key()
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    int bpf_map_get_next_key (int fd, const void *cur_key, void *next_key)
 
 A userspace program can iterate through the entries in an LPM trie using
diff --git a/Documentation/bpf/map_of_maps.rst b/Documentation/bpf/map_of_maps.rst
index 07212b9227a9..7b5617c2d017 100644
--- a/Documentation/bpf/map_of_maps.rst
+++ b/Documentation/bpf/map_of_maps.rst
@@ -45,7 +45,11 @@ Usage
 Kernel BPF Helper
 -----------------
 
-.. c:function::
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
 
 Inner maps can be retrieved using the ``bpf_map_lookup_elem()`` helper. This
diff --git a/Documentation/bpf/map_queue_stack.rst b/Documentation/bpf/map_queue_stack.rst
index f20e31a647b9..8d14ed49d6e1 100644
--- a/Documentation/bpf/map_queue_stack.rst
+++ b/Documentation/bpf/map_queue_stack.rst
@@ -28,7 +28,11 @@ Usage
 Kernel BPF
 ----------
 
-.. c:function::
+bpf_map_push_elem()
+~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_push_elem(struct bpf_map *map, const void *value, u64 flags)
 
 An element ``value`` can be added to a queue or stack using the
@@ -38,14 +42,22 @@ when the queue or stack is full, the oldest element will be removed to
 make room for ``value`` to be added. Returns ``0`` on success, or
 negative error in case of failure.
 
-.. c:function::
+bpf_map_peek_elem()
+~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_peek_elem(struct bpf_map *map, void *value)
 
 This helper fetches an element ``value`` from a queue or stack without
 removing it. Returns ``0`` on success, or negative error in case of
 failure.
 
-.. c:function::
+bpf_map_pop_elem()
+~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    long bpf_map_pop_elem(struct bpf_map *map, void *value)
 
 This helper removes an element into ``value`` from a queue or
@@ -55,7 +67,11 @@ stack. Returns ``0`` on success, or negative error in case of failure.
 Userspace
 ---------
 
-.. c:function::
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    int bpf_map_update_elem (int fd, const void *key, const void *value, __u64 flags)
 
 A userspace program can push ``value`` onto a queue or stack using libbpf's
@@ -64,7 +80,11 @@ A userspace program can push ``value`` onto a queue or stack using libbpf's
 same semantics as the ``bpf_map_push_elem`` kernel helper. Returns ``0`` on
 success, or negative error in case of failure.
 
-.. c:function::
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    int bpf_map_lookup_elem (int fd, const void *key, void *value)
 
 A userspace program can peek at the ``value`` at the head of a queue or stack
@@ -72,7 +92,11 @@ using the libbpf ``bpf_map_lookup_elem`` function. The ``key`` parameter must be
 set to ``NULL``.  Returns ``0`` on success, or negative error in case of
 failure.
 
-.. c:function::
+bpf_map_lookup_and_delete_elem()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
    int bpf_map_lookup_and_delete_elem (int fd, const void *key, void *value)
 
 A userspace program can pop a ``value`` from the head of a queue or stack using
-- 
2.38.1

