Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1644593E9
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 18:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbhKVRW5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 12:22:57 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:60457 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240126AbhKVRWx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 12:22:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 53AB62B01C22;
        Mon, 22 Nov 2021 12:19:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 Nov 2021 12:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=N2PN2xc7p1uax
        Vo8LJRNlMYVKF+hFOUc5Ckji+zhQeo=; b=uB5ofZ3yrDMcaysxClU4Ay9AF7aZW
        i+twOKZ/Du0rZkS2cGmhg4I+K3QGwC6IiF6qDeaamaGCuHlYKswJNM0efq8Duxvw
        WcwgFKoqdU+vX/UelicP5+Rm86FUqVX8xUZ+5XzeoDi7Ex8WqbDN3ZxXpzh4uIZx
        1+V7S9lUVnOCd3J9c0gkKgIaJ10RWIQnzHDkIfIlPJJHU7xkaRvVav3dxkiPtP9q
        n23C9Q62i+isc0OronmsLbLEjfsxZGYUXgn4Eq1HpEqPHj/+dikQM8421cGDqlxM
        CkDBTta49HFSWUEzMOCvOLyCi6kcg28OW1UT+b6Park3ZvTBI//RCNADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=N2PN2xc7p1uaxVo8LJRNlMYVKF+hFOUc5Ckji+zhQeo=; b=RLpdlW14
        OBj5UN3Y5X9q+rYlWXf+XUeRuPBnwQhY3rRh4UCJzLeDiWNTwC75aBuFjauD8e5J
        9A7lTdpVRHaAx7cnE7akjb1sPJPDFWCJTNtqmx2uGd08gGhCh/bkvYb+LvOLCnur
        CPMY/7V2jjJHKOt5a33PcuMTNLIv0P54GhNxchcuzA3GmgxA9fdftKKinlzWTxNV
        cy42Xf10U+y6LJQ3sJdQZSwv6+/N8W/adboxLivF12/4/E4dEHKLZqNpoGolhSMW
        ArfUAllPAQXUnY49Pg5zXGS+CTsulauouxNuhrxh4wMQNVx7T5AmPOD42Y4I6jiB
        3ItdrhHhofEKGA==
X-ME-Sender: <xms:MNGbYXR23RrVNtwypgmKRKjX6m-XBaiCAG-YfidN-B4eIxDcjQGymg>
    <xme:MNGbYYzDnXvz2i89aPm2T8NViQU1iei1gr5fehg-yYNr4LiUM7lU1g07OXnvfey5G
    UQpWsszeSPj2dO6FA>
X-ME-Received: <xmr:MNGbYc1iTARZUXe_Tg79NvtQegKV__m3wbE8pi2siwQh62qwuaTNb7u6ei9lrX0knt4Z58jdffLS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepffgrvhgvucfvuhgtkhgvrhcuoegurghvvgesughtuhgtkhgv
    rhdrtghordhukheqnecuggftrfgrthhtvghrnhepiedugedtvdejhfeftedvjeevfffhte
    ehteeggfffgffggeevheehfffhuedvhfeinecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegurg
    hvvgesughtuhgtkhgvrhdrtghordhukh
X-ME-Proxy: <xmx:MNGbYXCrKZXUX9WzyHMsIsqYB334T7ZUdiw1RNK0n692eBUIctzkEA>
    <xmx:MNGbYQhjSFoMZBgz6XXcQWaEOsv4Eya8eAFj4QzspK-TQTiZnOFJhA>
    <xmx:MNGbYbr2ETaSdfbtm7knAx2xEoxuM9v9Ow51PkgQviUvwH3VUth1tQ>
    <xmx:MNGbYTOIwP5Y-QmLa9dS35gNx9-SMfhC6ni2Gwixc44NGVCUYAYhG6Fgd3Y>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 12:19:44 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
Date:   Mon, 22 Nov 2021 17:19:32 +0000
Message-Id: <5da383bc01c66e6c1342cdb2b3dc53196214e003.1637601045.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637601045.git.dave@dtucker.co.uk>
References: <cover.1637601045.git.dave@dtucker.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
kernel version introduced, usage and examples.
It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.

Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
---
 Documentation/bpf/map_array.rst | 150 ++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
new file mode 100644
index 000000000000..f9eb5473a240
--- /dev/null
+++ b/Documentation/bpf/map_array.rst
@@ -0,0 +1,150 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2021 Red Hat, Inc.
+
+================================================
+BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
+================================================
+
+.. note:: ``BPF_MAP_TYPE_ARRAY`` was introduced in Kernel version 3.19 and ``BPF_MAP_TYPE_PERCPU_ARRAY`` in version 4.6
+
+``BPF_MAP_TYPE_ARRAY`` and ``BPF_MAP_TYPE_PERCPU_ARRAY`` provide generic array storage.
+The key type is an unsigned 32-bit integer (4 bytes) and the map is of constant size.
+All array elements are pre-allocated and zero initialized when created.
+``BPF_MAP_TYPE_PERCPU_ARRAY`` uses a different memory region for each CPU whereas
+``BPF_MAP_TYPE_ARRAY`` uses the same memory region.
+The maximum size of an array, defined in max_entries, is limited to 2^32.
+The value stored can be of any size, however, small values will be rounded up to 8 bytes.
+
+Usage
+=====
+
+Array elements can be retrieved using the ``bpf_map_lookup_elem()`` helper.
+This helper returns a pointer into the array element, so to avoid data races with userspace reading the value,
+the user must use primitives like ``__sync_fetch_and_add()`` when updating the value in-place.
+Access from userspace uses the libbpf API of the same name.
+
+Array elements can also be added using the ``bpf_map_update_elem()`` helper or libbpf API.
+
+Since the array is of constant size, ``bpf_map_delete_elem()`` is not supported.
+To clear an array element, you may use ``bpf_map_update_eleme()`` to insert a zero value to that index.
+
+Values stored in ``BPF_MAP_TYPE_ARRAY`` can be accessed by multiple programs across different CPUs.
+To restrict storage to a single CPU, you may use a ``BPF_MAP_TYPE_PERCPU_ARRAY``.
+Since Kernel version 5.1, the BPF infrastructure provides ``struct bpf_spin_lock`` to synchronize access.
+
+```bpf_map_get_next_key()`` can be used to iterate over array values.
+
+Examples
+========
+
+Please see the `bpf/samples`_ directory for functional examples.
+This sample code simply demonstrates the API.
+
+.. section links
+.. _bpf/samples:
+    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/bpf/
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
+        int index = load_byte(skb, ETH_HLEN + offsetof(struct iphdr, protocol));
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
+        {
+
+            int fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(__u32), sizeof(long), 256, 0);
+            if (fd < 0)
+            return -1;
+
+            // fill the map with values from 0-255
+            for(__u32 i=0; i < 256 ; i++) {
+                long v = i;
+                bpf_map_update_elem(fd, &i, &v, BPF_ANY);
+            }
+
+            __u32 index = 42;
+            long value;
+            bpf_map_lookup_elem(fd, &index, &value);
+            assert(value == 42);
+            return 0;
+    }
+
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
+        {
+            int ncpus = libbpf_num_possible_cpus();
+
+            int fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_ARRAY, sizeof(__u32), sizeof(long), 256, 0);
+            if (fd < 0)
+            return -1;
+
+            // fill the map with values from 0-255 for each cpu
+            for(__u32 i=0; i < 256 ; i++) {
+                long v[ncpus];
+                for (int j=0; j < ncpus; j++ ) {
+                    v[j] = i;
+                }
+                bpf_map_update_elem(fd, &i, &v, BPF_ANY);
+            }
+
+            sleep(60);
+
+            __u32 index = 42;
+            long value[ncpus];
+            bpf_map_lookup_elem(fd, &index, &value);
+            for (int j=0; j < ncpus; j++ ) {
+                assert(value[j] == 42);
+            }
+            return 0;
+    }
+
+Semantics
+=========
+
+As illustrated in the example above, when using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` in userspace, the
+values are an array with ``ncpus`` elements.
+
+When calling ``bpf_map_update_elem()`` the flags `BPF_NOEXIST` can not be used for these maps.
\ No newline at end of file
-- 
2.33.1

