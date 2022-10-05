Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2A5F52D2
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJEKqo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 06:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEKqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 06:46:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D66A23392;
        Wed,  5 Oct 2022 03:46:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w18so16600038wro.7;
        Wed, 05 Oct 2022 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D95P2l0dTucL7d9vv84t55p3ocxxsCfixlMxJVU5e7s=;
        b=HJ6C9teJ61vGE8KLt1RMTRt0xyWorhPq2AFS4dGTP5woV19zCKZpjcNDSfSkfxzQOM
         pw5xK4ij1VMBVMNtAcs/O1cHkcw/dHLlzSsKVWaRs7Lc48STNlF0Ix/nF4ZTTz2wOa62
         bC0AxvKOsiIG/QGiHUMPpWoc2Ynjb3ybkLnMc+OpMtK00GKJr21HcgQ852mIOQHE5uEy
         SWIXdcN1kSTC8zIpZkUNpgadQ0BRcpL5Ox/dNIeMJWeZkwjh2K5CbtgMlWKTRnrCEIbN
         n4N5InuFTVWTEPuXI8eQVNgREyIuHqsyvcCixf5sBlMlmXp8KAJ6G/7lPadjSwsbBnPS
         17Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D95P2l0dTucL7d9vv84t55p3ocxxsCfixlMxJVU5e7s=;
        b=jrKWzqKt8of/9/fFy2E3iMTqsv3U8qMwtQ5sZGE5xQShhpW1pAW16TgNNMaQP6h7u0
         LTjrOTn9X5aCkqYJ+QhxU8D7Mi017ZttZOPClAB82dRgKjgCpeEL01eOdvu9Qm8/Yvf/
         NmKc3dgt8hG0XEJLKXE5GV3FgaPG3YzOlvJutDqGjBktdRCcSivjH/wi+4e7T+oVFe/7
         ucgHqFoIPzO6KxsNQrm1iTr1tPC4fdV0EuGkoZPPRUDyVMh7hni/9iYtac3mCXk08kVJ
         L/7rKhy5CldSIMBDCOuVxNSP3Fl/UZ0mW+WtzxB1P1KlUIv9UWvEilMQN1DW0m/3xKpP
         g/jg==
X-Gm-Message-State: ACrzQf2oXtHCdiFSIoUIgLFNSEFYqpEK1ef/dibRpvAMfh4W3d3xUW1r
        gOcdQpTWGaP6XZt+zVq6egfFk3o2Ds1YyQ==
X-Google-Smtp-Source: AMsMyM4eX0ykbCDIdkCOu7TV1d5FvUGd1TH4Gv7hmz35Sntoz8x+EvX+27kJYgOW6c1KQZSqiRm+gw==
X-Received: by 2002:a05:6000:183:b0:22e:2c5d:fb9f with SMTP id p3-20020a056000018300b0022e2c5dfb9fmr12903229wrx.637.1664966800591;
        Wed, 05 Oct 2022 03:46:40 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b4e1:6c12:775b:a638])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003a5f54e3bbbsm1580959wmo.38.2022.10.05.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:46:40 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v6 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
Date:   Wed,  5 Oct 2022 11:46:34 +0100
Message-Id: <20221005104634.66406-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005104634.66406-1-donald.hunter@gmail.com>
References: <20221005104634.66406-1-donald.hunter@gmail.com>
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
 Documentation/bpf/map_array.rst | 231 ++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
new file mode 100644
index 000000000000..9d2da884c41e
--- /dev/null
+++ b/Documentation/bpf/map_array.rst
@@ -0,0 +1,231 @@
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
+storage. The key type is an unsigned 32-bit integer (4 bytes) and the map is of
+constant size. All array elements are pre-allocated and zero initialized when
+created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
+CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The maximum
+size of an array, defined in max_entries, is limited to 2^32. The value stored
+can be of any size, however, small values will be rounded up to 8 bytes.
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
+``bpf_map_lookup_elem()`` helpers automatically access the hash slot for the
+current CPU.
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
+            int index = load_byte(skb,
+                                  ETH_HLEN + offsetof(struct iphdr, protocol));
+            long *value;
+
+            if (skb->pkt_type != PACKET_OUTGOING)
+                    return 0;
+
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
+    int create_array() {
+            int fd;
+            LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
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
+    int initialize_array(int fd) {
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
+    int lookup(int fd) {
+            __u32 index = 42;
+            long value;
+            int ret = bpf_map_lookup_elem(fd, &index, &value);
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
+    int initialize_array(int fd) {
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
+    int lookup(int fd) {
+            int ncpus = libbpf_num_possible_cpus();
+            __u32 index = 42, j;
+            long values[ncpus];
+            int ret = bpf_map_lookup_elem(fd, &index, &values);
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

