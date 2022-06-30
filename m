Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C8561A25
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 14:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiF3MQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbiF3MQA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 08:16:00 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CDF1D306;
        Thu, 30 Jun 2022 05:15:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5410E5802D8;
        Thu, 30 Jun 2022 08:04:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 Jun 2022 08:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656590686; x=1656597886; bh=8fLAj7Cosaq3L
        KVDA7qNFWnIgEzd8lukzSVga6MMBEw=; b=jy5NNYHLeyEBuA5d844L22mQ9G+2X
        xBLo2JrD+oVIypGTm4im7rELDSpqWgJOjbv8iX8t5QNq1S8kmeynjEfO21w01XTK
        V4kAmEItjsVNl3vOL0VMGHBWCVz1qkmXAPff4ReT6n35tTisj8a7nRV5WxWqf4/6
        TwXiXTyg6laeCUiOuI7p3MuGZGc1ky/jkVvRmXeCdZbDkR2/FDoXMazu8xd0uHwf
        WUvuTIVaI8OSP5aJsxBwCqoIHaRPn6gjZYBo/iZHqlq2POrC6o358d7fj7lblKF6
        IDHw86LFu+yslqPDEmvh5toqZr4SVOPbsYJwClTgS9luDh7ZvuO2NXhSQ==
X-ME-Sender: <xms:XpG9YoJy4M7tk_KzNDrh7LUmjJTJ--jKiW-hKvRPM9FNEtSQuBgMGQ>
    <xme:XpG9YoKpP1C2iRYgTnXqnRrec7Kn2f50Dvkr3bLpLoXG4_iVR0p8UKt0crWVmRbRF
    V6c71SQatiO28WChQ>
X-ME-Received: <xmr:XpG9YotQnlRW_5zor8wJi97LoWEW4jGl4LeX1YDjbYUl2uUqH59PNhUMiPjY0lOfpb1NKsl15Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehuddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghk
    vghrrdgtohdruhhkqeenucggtffrrghtthgvrhhnpeetuedvvdehheetfeeifefhvdejve
    ekteegveegvdfhjeekffefledvfefgfffhgeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepug
    grvhgvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:XpG9YlaZzFJaQqEgSd84Z1WjGEti1Nykm7ZruLwBVlKV11AnTteygQ>
    <xmx:XpG9YvZRbD5Wsbs7-tj36UCPnHLulG9GkdECXJD_-T_x_WZ43fhLmA>
    <xmx:XpG9YhCGcEk-8eJWLjn59yxYMZq-jzHbksSecOKS3ZaD9NMWHV-Qyw>
    <xmx:XpG9Ypm7MndPMasYldyY6rWhPRNnajlienfIFQ7soW49hUJ4uRe4CA>
Feedback-ID: i559945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 08:04:45 -0400 (EDT)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v4 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
Date:   Thu, 30 Jun 2022 13:04:09 +0100
Message-Id: <ca8a57db17da57f403b029c14ba4f0b89774d361.1656590177.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1656590177.git.dave@dtucker.co.uk>
References: <cover.1656590177.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_FAIL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
kernel version introduced, usage and examples.
It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 Documentation/bpf/map_array.rst | 183 ++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
new file mode 100644
index 000000000000..eadc714591d2
--- /dev/null
+++ b/Documentation/bpf/map_array.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2021 Red Hat, Inc.
+
+================================================
+BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
+================================================
+
+.. note:: ``BPF_MAP_TYPE_ARRAY`` was introduced in Kernel version 3.19 and
+   ``BPF_MAP_TYPE_PERCPU_ARRAY`` in version 4.6
+
+``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array
+storage.  The key type is an unsigned 32-bit integer (4 bytes) and the map is of
+constant size. All array elements are pre-allocated and zero initialized when
+created. ``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each
+CPU whereas ``BPF_MAP_TYPE_ARRAY`` uses the same memory region. The maximum
+size of an array, defined in max_entries, is limited to 2^32. The value stored
+can be of any size, however, small values will be rounded up to 8 bytes.
+
+Since Kernel 5.4, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by
+setting the flag ``BPF_F_MMAPABLE``.  The map definition is page-aligned and
+starts on the first page.  Sufficient page-sized and page-aligned blocks of
+memory are allocated to store all array values, starting on the second page,
+which in some cases will result in over-allocation of memory. The benefit of
+using this is increased performance and ease of use since userspace programs
+would not be required to use helper functions to access and mutate data.
+
+Usage
+=====
+
+Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
+This helper returns a pointer into the array element, so to avoid data races
+with userspace reading the value, the user must use primitives like
+``__sync_fetch_and_add()`` when updating the value in-place.  Access from
+userspace uses the libbpf API of the same name.
+
+Array elements can also be added using the ``bpf_map_update_elem()`` helper or
+libbpf API.
+
+Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
+To clear an array element, you may use ``bpf_map_update_eleme()`` to insert a
+zero value to that index.
+
+Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs
+across different CPUs.  To restrict storage to a single CPU, you may use a
+``BPF_MAP_TYPE_PERCPU_ARRAY``.  Since Kernel version 5.1, the BPF infrastructure
+provides ``struct bpf_spin_lock`` to synchronize access.
+
+``bpf_map_get_next_key()`` can be used to iterate over array values.
+
+Examples
+========
+
+Please see the `tools/testing/selftests/bpf`_ directory for functional examples.
+This sample code simply demonstrates the API.
+
+.. section links
+.. _tools/testing/selftests/bpf:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf
+
+Kernel
+------
+
+.. code-block:: c
+
+    struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __type(key, u32);
+        __type(value, long);
+        __uint(max_entries, 256);
+    } my_map SEC(".maps");
+
+    int bpf_prog(struct __sk_buff *skb)
+    {
+        int index = load_byte(skb,
+                              ETH_HLEN + offsetof(struct iphdr, protocol));
+        long *value;
+
+        if (skb->pkt_type != PACKET_OUTGOING)
+            return 0;
+
+        value = bpf_map_lookup_elem(&my_map, &index);
+        if (value)
+            __sync_fetch_and_add(value, skb->len);
+
+        return 0;
+    }
+
+Userspace
+---------
+
+BPF_MAP_TYPE_ARRAY
+~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+    #include <assert.h>
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    int main(int argc, char **argv)
+    {
+        int fd;
+        int ret = 0;
+        __u32 i, j;
+        __u32 index = 42;
+        long v, value;
+
+        fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(__u32), sizeof(long),
+                            256, 0);
+        if (fd < 0)
+            return fd;
+
+        /* fill the map with values from 0-255 */
+        for (i = 0; i < 256 ; i++) {
+            ret = bpf_map_update_elem(fd, &i, &v, BPF_ANY);
+            if (ret < 0)
+                return ret;
+        }
+
+        ret = bpf_map_lookup_elem(fd, &index, &value);
+        if (ret < 0)
+            return ret;
+
+        assert(value == 42);
+
+        return ret;
+    }
+
+BPF_MAP_TYPE_PERCPU_ARRAY
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+    #include <assert.h>
+    #include <bpf/libbpf.h>
+    #include <bpf/bpf.h>
+
+    int main(int argc, char **argv)
+    {
+        int ncpus = libbpf_num_possible_cpus();
+        if (ncpus < 0)
+            return ncpus;
+
+        int fd;
+        int ret = 0;
+        __u32 i, j;
+        __u32 index = 42;
+        long v[ncpus], value[ncpus];
+
+
+        fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_ARRAY, sizeof(__u32),
+                            sizeof(long), 256, 0);
+        if (fd < 0)
+            return -1;
+
+        /* fill the map with values from 0-255 for each cpu */
+        for (i = 0; i < 256 ; i++) {
+            for (j = 0; j < ncpus; j++)
+                v[j] = i;
+            ret = bpf_map_update_elem(fd, &i, &v, BPF_ANY);
+            if (ret < 0)
+                return ret;
+        }
+
+        ret = bpf_map_lookup_elem(fd, &index, &value);
+        if (ret < 0)
+            return ret;
+
+        for (j = 0; j < ncpus; j++)
+            assert(value[j] == 42);
+
+        return ret;
+    }
+
+Semantics
+=========
+
+As illustrated in the example above, when using a ``BPF_MAP_TYPE_PERCPU_ARRAY``
+in userspace, the values are an array with ``ncpus`` elements.
+
+When calling ``bpf_map_update_elem()`` the flags ``BPF_NOEXIST`` can not be used
+for these maps.
+
-- 
2.37.0

