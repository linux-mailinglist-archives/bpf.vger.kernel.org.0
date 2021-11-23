Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E704945A795
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKWQ1m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 11:27:42 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:39559 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhKWQ1l (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 11:27:41 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id F3B622B0147B;
        Tue, 23 Nov 2021 11:24:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Nov 2021 11:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jZZJCwnz5T/np
        /iK1Ij3A33Bb+XUt+gsLHn16lOrvqs=; b=m1SshhThWGLdZ7h89DpwPJxPeCOOQ
        EyAKNz+gw8zAsbQKzGZX0Bd96L+yEkZqK7oDwBuIrc24qXwduvwyUoi4SToVPzqq
        i/aWj+tZR+/AqZEKEB+tsG9OdujbfuQgJk41re1LdwTn3hojJLSAmWFjZI0koTwm
        t8rfFzrrXAZtvH4VqgLRfOiB4Ahqv0arLuzpNiq8YJqezRs2J1cR9KhYy82NyIlw
        ceaxPoPs3qqtsGJzeXYpTPM/qR+XW3y89NNbQ/S92l2M3YRDDszFtZRNyRAVkD+e
        T7REEt7Oaydg8b42zG8KkMBugRo6jvkc+qdkz4c89o6n0Gr4609e9PU7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jZZJCwnz5T/np/iK1Ij3A33Bb+XUt+gsLHn16lOrvqs=; b=hSFjE3sg
        QT5ko2P867m0j1O/h6PZ1J6hFrGoz1H9jx3e1/dFOKWThPK9U3Wp5BVmunBVOjHk
        EkLaS3wtaTSJflA25TQaURzOfaZVGQfirbyrCOQyt7WZMW+KWp5PiryG0YxWjxkA
        d69/DFkaVmhPLiDCbHKn/nGs8byg6rqQYoStVfI/2rYjaGMh+5l8i+WVbjHWeWkY
        7ulFr0PDpBzibGt6WU8FZ1GnUrRxrEmUk50+Fwou2HwNKMm00lsaFLvWkXl5a0RZ
        F9yKxWytaLEvV6jVv94fVanGP5amgsuAvo/UYaQitVTzSvVZaJBmrVheRN/TdZBb
        tbXrCVBne8rcVQ==
X-ME-Sender: <xms:wBWdYagwvbIMnnhRJ2PXnNbYilmKsOPc104-4KzJF5kEH9wfWGXFsg>
    <xme:wBWdYbDDGueUGLXEnq-btGEE6xYhTCjmNBohksjXYHSbagdKPeKuIQE9I_VdqbYQB
    bE2p_M3azGxZ4XKnQ>
X-ME-Received: <xmr:wBWdYSHK1W_ZTN-Nnc6F4K2UO0IgnI6J9WXOWDn-SoSyx-FzBJp7cOTdu2umiaKloQSVMkaT-8qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghr
    rdgtohdruhhkqeenucggtffrrghtthgvrhhnpeeiudegtddvjefhfeetvdejveffhfethe
    etgefgfffggfegveehheffhfeuvdfhieenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvh
    gvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:wBWdYTQi8OpfEONwSn2WcdurmV20yrHWMdRuMBhWRn2Z5WlUzaZiHg>
    <xmx:wBWdYXwMLaO7_Cmd0DbEAL4hzpNldl4zF7Rl7hBWFPyFfrgEWVTuKA>
    <xmx:wBWdYR5VnH7yryI83ROamBSF0UeZf1zwkOU3UPked389xGz11_3c5w>
    <xmx:wBWdYfc34qMcbaXEk5VHM3EBOJPCz0LjuucCu253KI9lbOGAQ_A52T5t9pw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 11:24:32 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v2 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
Date:   Tue, 23 Nov 2021 16:24:21 +0000
Message-Id: <9b20a6e558008b8d422db1008dd2b5c8ff18ce46.1637684071.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <fb36291f5998c98faa1bd02ce282d940813c8efd.1637684071.git.dave@dtucker.co.uk>
References: <fb36291f5998c98faa1bd02ce282d940813c8efd.1637684071.git.dave@dtucker.co.uk>
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
 Documentation/bpf/map_array.rst | 172 ++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
new file mode 100644
index 000000000000..8ba05ba5d4ee
--- /dev/null
+++ b/Documentation/bpf/map_array.rst
@@ -0,0 +1,172 @@
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
+Since Kernel 5.4, memory mapping may be enabled for ``BPF_MAP_TYPE_ARRAY`` by setting the flag ``BPF_F_MMAPABLE``.
+The map definition is page-aligned and starts on the first page.
+Sufficient page-sized and page-aligned blocks of memory are allocated to store all array values, starting on the second page,
+which in some cases will result in over-allocation of memory. The benefit of using this is increased performance and
+ease of use since userspace programs would not be required to use helper functions to access and mutate data.
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
+    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf
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
+    {
+        int fd;
+        int ret = 0;
+        __u32 i, j;
+        __u32 index = 42;
+        long v, value;
+
+        fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(__u32), sizeof(long), 256, 0);
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
+        fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_ARRAY, sizeof(__u32), sizeof(long), 256, 0);
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
+As illustrated in the example above, when using a ``BPF_MAP_TYPE_PERCPU_ARRAY`` in userspace, the
+values are an array with ``ncpus`` elements.
+
+When calling ``bpf_map_update_elem()`` the flags ``BPF_NOEXIST`` can not be used for these maps. 
\ No newline at end of file
-- 
2.33.1

