Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A000446BCA6
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 14:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhLGNeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 08:34:50 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:57655 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232505AbhLGNeu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Dec 2021 08:34:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 77C81580170;
        Tue,  7 Dec 2021 08:31:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 07 Dec 2021 08:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dtucker.co.uk;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=i1hkE236crppS
        SEFLxNFj87bPJMt+3aJ3avMpJLh4wY=; b=nraWPCn65Rbp4gUD86560VfJQQ+6r
        /vYsasonyAMbq+1psaDPfKhjTfUo8QRQxi83Ii6BZiKQN4v+p1ozj+St4to2U9wU
        2km0njup8Gdpszm+1ih1Jh20t9mSrN02P60mHmgjk+TxiYWqGYIfbMzlFl0f2T4Y
        lchULGBJBss4DsHSzqG1rNOMVIrqyllxJ33llmNJ6Ej+Da6YFJLoMVgv53a4Tl1p
        C3/9We7GUT3pVCn/mLMzNYc+1tygU/2Lh85ChlAI3um+3TaGNz2Q28Yp+RHd6/0s
        9TP8/vOELIesl++7vUdTFbfKuqPXMVBzeALsvA/MxxF5SZjsC/fGqWV9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=i1hkE236crppSSEFLxNFj87bPJMt+3aJ3avMpJLh4wY=; b=Ncgu+Cor
        /w067+gIFvq6FkmeWaKexyrSfBCQAFtV/iqyDDxakIhvzW9OPca/g8zsgJWk/jB8
        gudDJGRLTNFFNFmbm5OfY20h3kaP2LN7w/3T2TvnHfF6IfkmmvZ+EQSBBTC87dQD
        uAQVfWcz5lFll4pjT6tuyMFLK2Fsz9xbDE8ZJNcBCvIUUI6F1UEZ72Z8pWzufLXm
        RWGudBOh5HJ+TiixXIx26vX91HovZXrYVe5rDW41cena/n6sCrzeg+n7yugekZVz
        uKdsIbIvWt1sKDAxMx564ybZ/bq71TFmbSshIxQ4pCp0RPOGxEsAIe6q9O809dVI
        dpIZTsBn+mFnPQ==
X-ME-Sender: <xms:J2KvYdcBaaE6vCzdYK78ZkZYcB8sKz-Bp2PXmnWmFJSTR6qA_MCp5w>
    <xme:J2KvYbMOh33uBs9xTME27yPbJyVXe8xrEqxwXSTG7xtYQxlSRngBaJcLodwIAob5Z
    mc7yujvJrsB0MaNXw>
X-ME-Received: <xmr:J2KvYWhsGojULLjJb_ZBYo-ossUXJTiw_OZE6rhfQP-_6waaVYXNmW7822uM5idL3GoKEC18qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghvvgcuvfhutghkvghruceouggrvhgvseguthhutghkvghr
    rdgtohdruhhkqeenucggtffrrghtthgvrhhnpeeiudegtddvjefhfeetvdejveffhfethe
    etgefgfffggfegveehheffhfeuvdfhieenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrvh
    gvseguthhutghkvghrrdgtohdruhhk
X-ME-Proxy: <xmx:J2KvYW8EaRWxvt2fO8tN1HnwbXECLbReB6YQ6L-ny0FcCFhRA_qT5w>
    <xmx:J2KvYZthSgyEQkxUnPOAgiRD2jYU0HU1VWHRqUmM1EkYHxjU-kIZFw>
    <xmx:J2KvYVFtJ_UytA1R_OV-eNv1KeDeROb2dktC6iurAEoxBkoZz_Q95w>
    <xmx:J2KvYfIeFAGdq8EcqVSKg2TwgKLHDknLDlVCSTg98MiysKEzVT1uFg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 08:31:18 -0500 (EST)
From:   Dave Tucker <dave@dtucker.co.uk>
To:     bpf@vger.kernel.org
Cc:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, Dave Tucker <dave@dtucker.co.uk>
Subject: [PATCH v3 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
Date:   Tue,  7 Dec 2021 13:31:11 +0000
Message-Id: <9010b4d5fa1b25410a34f2954f272cce7dca0c99.1638883067.git.dave@dtucker.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638883067.git.dave@dtucker.co.uk>
References: <cover.1638883067.git.dave@dtucker.co.uk>
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
 Documentation/bpf/map_array.rst | 182 ++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
new file mode 100644
index 000000000000..7ed5f7654ee8
--- /dev/null
+++ b/Documentation/bpf/map_array.rst
@@ -0,0 +1,182 @@
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
2.33.1

