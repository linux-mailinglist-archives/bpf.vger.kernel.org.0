Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E160796D
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 16:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJUOXP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJUOXO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 10:23:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46808265C69;
        Fri, 21 Oct 2022 07:23:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f11so4661965wrm.6;
        Fri, 21 Oct 2022 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g6Df/BGV0KprZfQngcjICitzRLYKwYsx9iBoUok9f0=;
        b=XamG3OiiSrbUHxi7XD0ekWHKLygtajKAVSjRSpXaPvxYOrd1o51J9EOXEgSf6kEnLX
         WHVDYFaQLFz/VPD43V7jNTCEUh8alWCe2eAiXoHvRZrCK5OK8dd0FvNoDcBqb36D3TQP
         OKSzUxstBieI5dvSl03JTB01BQ+K4juCPKgdxhx4ZHRg9t4ea0tTARcSCYg8G5q/zE5B
         JG6BBZ8CTGKGmzjmSRvr8vFD+aNXJNL84Q2oQbvWhIL6NrQ5dPNBoJfGCoAMsJarc9tV
         x3Clj9oQFcFLI6be2UyD43UOuCT83/0cKbkhyqp9qzg8Vwv44Fb/sBmOCRxuqp4/jrQb
         sqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6g6Df/BGV0KprZfQngcjICitzRLYKwYsx9iBoUok9f0=;
        b=zCt1eZJD0M1AOYbjNFi5MBuBqW7iDemx0dNqkuDpgTry4XPihbqHhToyaIAUVYlFo/
         hpkfcJXfSe1rQdS4vCne6eUj/6xSFTInZS/8Rx/fa7Vytb9ACP2xyeTfus3SLHiBWChS
         gKRBDeyziK+jdiFR8dml3BBcPe0X+FCYBX4nlro/XxOwgZro8VCe3VDSd3sxc3njdh1x
         9i+Rfr/7DtX2Ak9FSMQh+rbIvx2tQhVjMXAifzveIn14o6hQcDWaykzurVKv+cIYpvfg
         tdS1FqTja/7aDVdqFpQgOGQt4qfkVJbpFM6qDm73jFDWvy9kA6ZlgFuqEBgHCTkJ8Amd
         VbDA==
X-Gm-Message-State: ACrzQf1Wq00uNljU/x3neuNFjoyEB/aDVYYNm/CgVh40cq2mKJFlHZ80
        Opc1/2c6DSxmzP2j6rfTyh5Mz37fqJomkg==
X-Google-Smtp-Source: AMsMyM6fyhqF5cPYrH0BEO4h1NgQtV4VulVYqsJWZYhHbHg7lSvmF1RTYPUgPH9DHhuWUblfDvSM8A==
X-Received: by 2002:adf:d1e5:0:b0:231:4ecf:7b7f with SMTP id g5-20020adfd1e5000000b002314ecf7b7fmr12709636wrd.678.1666362191307;
        Fri, 21 Oct 2022 07:23:11 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:cc4f:5367:93c1:b0d5])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b002364c77bc96sm3180522wrz.33.2022.10.21.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:23:10 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v8 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
Date:   Fri, 21 Oct 2022 15:22:59 +0100
Message-Id: <20221021142259.18093-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021142259.18093-1-donald.hunter@gmail.com>
References: <20221021142259.18093-1-donald.hunter@gmail.com>
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

From: Dave Tucker <dave@dtucker.co.uk>

Add documentation for the BPF_MAP_TYPE_ARRAY including kernel version
introduced, usage and examples. Also document BPF_MAP_TYPE_PERCPU_ARRAY
which is similar.

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_array.rst | 243 ++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
new file mode 100644
index 000000000000..3acc5a294428
--- /dev/null
+++ b/Documentation/bpf/map_array.rst
@@ -0,0 +1,243 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2022 Red Hat, Inc.
+
+================================================
+BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
+================================================
+
+.. note::
+   - ``BPF_MAP_TYPE_ARRAY`` was introduced in kernel version 3.19
+   - ``BPF_MAP_TYPE_PERCPU_ARRAY`` was introduced in version 4.6
+
+``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
+storage. The key type is an unsigned 32-bit integer (4 bytes) and the map is
+of constant size. The size of the array is defined in ``max_entries`` at
+creation time. All array elements are pre-allocated and zero initialized when
+created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
+CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The value
+stored can be of any size, however, all array elements are aligned to 8
+bytes.
+
+Since kernel 5.5, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
+setting the flag ``BPF_F_MMAPABLE``. The map definition is page-aligned and
+starts on the first page. Sufficient page-sized and page-aligned blocks of
+memory are allocated to store all array values, starting on the second page,
+which in some cases will result in over-allocation of memory. The benefit of
+using this is increased performance and ease of use since userspace programs
+would not be required to use helper functions to access and mutate data.
+
+Usage
+=====
+
+.. c:function::
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
+This helper returns a pointer into the array element, so to avoid data races
+with userspace reading the value, the user must use primitives like
+``__sync_fetch_and_add()`` when updating the value in-place. Access from
+userspace uses the libbpf API of the same name.
+
+.. c:function::
+   long bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
+
+Array elements can also be added using the ``bpf_map_update_elem()`` helper or
+libbpf API.
+
+``bpf_map_update_elem()`` returns 0 on success, or negative error in case of
+failure.
+
+Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
+To clear an array element, you may use ``bpf_map_update_elem()`` to insert a
+zero value to that index.
+
+Per CPU Array
+-------------
+
+Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs
+across different CPUs. To restrict storage to a single CPU, you may use a
+``BPF_MAP_TYPE_PERCPU_ARRAY``.
+
+When using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` the ``bpf_map_update_elem()`` and
+``bpf_map_lookup_elem()`` helpers automatically access the slot for the current
+CPU.
+
+.. c:function::
+   void *bpf_map_lookup_percpu_elem(struct bpf_map *map, const void *key, u32 cpu)
+
+The ``bpf_map_lookup_percpu_elem()`` helper can be used to lookup the array
+value for a specific CPU. Returns value on success , or ``NULL`` if no entry was
+found or ``cpu`` is invalid.
+
+Concurrency
+-----------
+
+Since kernel version 5.1, the BPF infrastructure provides ``struct bpf_spin_lock``
+to synchronize access.
+
+Examples
+========
+
+Please see the ``tools/testing/selftests/bpf`` directory for functional
+examples. The code samples below demonstrate API usage.
+
+Kernel BPF
+----------
+
+This snippet shows how to declare an array in a BPF program.
+
+.. code-block:: c
+
+    struct {
+            __uint(type, BPF_MAP_TYPE_ARRAY);
+            __type(key, u32);
+            __type(value, long);
+            __uint(max_entries, 256);
+    } my_map SEC(".maps");
+
+
+This example BPF program shows how to access an array element.
+
+.. code-block:: c
+
+    int bpf_prog(struct __sk_buff *skb)
+    {
+            struct iphdr ip;
+            int index;
+            long *value;
+
+            if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip, sizeof(ip)) < 0)
+                    return 0;
+
+            index = ip.protocol;
+            value = bpf_map_lookup_elem(&my_map, &index);
+            if (value)
+                    __sync_fetch_and_add(value, skb->len);
+
+            return 0;
+    }
+
+Userspace
+---------
+
+BPF_MAP_TYPE_ARRAY
+~~~~~~~~~~~~~~~~~~
+
+This snippet shows how to create an array, using ``bpf_map_create_opts`` to
+set flags.
+
+.. code-block:: c
+
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    int create_array()
+    {
+            int fd;
+            LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
+
+            fd = bpf_map_create(BPF_MAP_TYPE_ARRAY,
+                                "example_array",       /* name */
+                                sizeof(__u32),         /* key size */
+                                sizeof(long),          /* value size */
+                                256,                   /* max entries */
+                                &opts);                /* create opts */
+            return fd;
+    }
+
+This snippet shows how to initialize the elements of an array.
+
+.. code-block:: c
+
+    int initialize_array(int fd)
+    {
+            __u32 i;
+            long value;
+            int ret;
+
+            for (i = 0; i < 256; i++) {
+                    value = i;
+                    ret = bpf_map_update_elem(fd, &i, &value, BPF_ANY);
+                    if (ret < 0)
+                            return ret;
+            }
+
+            return ret;
+    }
+
+This snippet shows how to retrieve an element value from an array.
+
+.. code-block:: c
+
+    int lookup(int fd)
+    {
+            __u32 index = 42;
+            long value;
+            int ret;
+
+            ret = bpf_map_lookup_elem(fd, &index, &value);
+            if (ret < 0)
+                    return ret;
+
+            /* use value here */
+            assert(value == 42);
+
+            return ret;
+    }
+
+BPF_MAP_TYPE_PERCPU_ARRAY
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This snippet shows how to initialize the elements of a per CPU array.
+
+.. code-block:: c
+
+    int initialize_array(int fd)
+    {
+            int ncpus = libbpf_num_possible_cpus();
+            long values[ncpus];
+            __u32 i, j;
+            int ret;
+
+            for (i = 0; i < 256 ; i++) {
+                    for (j = 0; j < ncpus; j++)
+                            values[j] = i;
+                    ret = bpf_map_update_elem(fd, &i, &values, BPF_ANY);
+                    if (ret < 0)
+                            return ret;
+            }
+
+            return ret;
+    }
+
+This snippet shows how to access the per CPU elements of an array value.
+
+.. code-block:: c
+
+    int lookup(int fd)
+    {
+            int ncpus = libbpf_num_possible_cpus();
+            __u32 index = 42, j;
+            long values[ncpus];
+            int ret;
+
+            ret = bpf_map_lookup_elem(fd, &index, &values);
+            if (ret < 0)
+                    return ret;
+
+            for (j = 0; j < ncpus; j++) {
+                    /* Use per CPU value here */
+                    assert(values[j] == 42);
+            }
+
+            return ret;
+    }
+
+Semantics
+=========
+
+As shown in the example above, when accessing a ``BPF_MAP_TYPE_PERCPU_ARRAY``
+in userspace, each value is an array with ``ncpus`` elements.
+
+When calling ``bpf_map_update_elem()`` the flag ``BPF_NOEXIST`` can not be used
+for these maps.
-- 
2.35.1

