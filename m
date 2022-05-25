Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544FE533DB9
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 15:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiEYNVm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 May 2022 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiEYNVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 May 2022 09:21:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4327FF6;
        Wed, 25 May 2022 06:21:38 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L7Wss32wrz67j7Z;
        Wed, 25 May 2022 21:21:05 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 15:21:35 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kpsingh@kernel.org>
CC:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/3] bpf: Add BPF_F_VERIFY_ELEM to require signature verification on map values
Date:   Wed, 25 May 2022 15:21:13 +0200
Message-ID: <20220525132115.896698-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525132115.896698-1-roberto.sassu@huawei.com>
References: <20220525132115.896698-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In some cases, it is desirable to ensure that a map contains data from
authenticated sources, for example if map data are used for making security
decisions.

Such restriction is achieved by verifying the signature of map values, at
the time those values are added to the map with the bpf() system call (more
specifically, when the commands passed to bpf() are BPF_MAP_UPDATE_ELEM or
BPF_MAP_UPDATE_BATCH). Mmappable maps are not allowed in this case.

Signature verification is initially done with keys in the primary and
secondary kernel keyrings, similarly to kernel modules. This allows system
owners to enforce a system-wide policy based on the keys they trust.
Support for additional keyrings could be added later, based on use case
needs.

Signature verification is done only for those maps for which the new map
flag BPF_F_VERIFY_ELEM is set. When the flag is set, the kernel expects map
values to be in the following format:

+-------------------------------+---------------+-----+-----------------+
| verified data+sig size (be32) | verified data | sig | unverified data |
+-------------------------------+---------------+-----+-----------------+

where sig is a module-style appended signature as generated by the
sign-file tool. The verified data+sig size (in big endian) must be
explicitly provided (it is not generated by sign-file), as it cannot be
determined in other ways (currently, the map value size is fixed). It can
be obtained from the size of the file created by sign-file.

Introduce the new map flag BPF_F_VERIFY_ELEM, and additionally call the new
function bpf_map_verify_value_sig() from bpf_map_update_value() if the flag
is set. bpf_map_verify_value_sig(), declared as global for a new helper, is
basically equivalent to mod_verify_sig(). It additionally does the marker
check, that for kernel modules is done in module_sig_check(), and the
parsing of the verified data+sig size.

Currently, enable the usage of the flag only for the array map. Support for
more map types can be added later.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/bpf.h            |  7 ++++
 include/uapi/linux/bpf.h       |  3 ++
 kernel/bpf/arraymap.c          |  2 +-
 kernel/bpf/syscall.c           | 70 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  3 ++
 5 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a7080c86fa76..8f5c042e70a7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1825,6 +1825,8 @@ static inline bool unprivileged_ebpf_enabled(void)
 	return !sysctl_unprivileged_bpf_disabled;
 }
 
+int bpf_map_verify_value_sig(const void *mod, size_t modlen, bool verify);
+
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 {
@@ -2034,6 +2036,11 @@ static inline bool unprivileged_ebpf_enabled(void)
 	return false;
 }
 
+static inline int bpf_map_verify_value_sig(const void *mod, size_t modlen,
+					   bool verify)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f4009dbdf62d..a8e7803d2593 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1226,6 +1226,9 @@ enum {
 
 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+
+/* Verify map value (fmt: ver data+sig size(be32), ver data, sig, unver data) */
+	BPF_F_VERIFY_ELEM	= (1U << 13)
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index fe40d3b9458f..b430fdd0e892 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -17,7 +17,7 @@
 
 #define ARRAY_CREATE_FLAG_MASK \
 	(BPF_F_NUMA_NODE | BPF_F_MMAPABLE | BPF_F_ACCESS_MASK | \
-	 BPF_F_PRESERVE_ELEMS | BPF_F_INNER_MAP)
+	 BPF_F_PRESERVE_ELEMS | BPF_F_INNER_MAP | BPF_F_VERIFY_ELEM)
 
 static void bpf_array_free_percpu(struct bpf_array *array)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2b69306d3c6e..ca9e4a284120 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,8 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/verification.h>
+#include <linux/module_signature.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -180,6 +182,13 @@ static int bpf_map_update_value(struct bpf_map *map, struct fd f, void *key,
 {
 	int err;
 
+	if (map->map_flags & BPF_F_VERIFY_ELEM) {
+		err = bpf_map_verify_value_sig(value, bpf_map_value_size(map),
+					       true);
+		if (err < 0)
+			return err;
+	}
+
 	/* Need to create a kthread, thus must support schedule */
 	if (bpf_map_is_dev_bound(map)) {
 		return bpf_map_offload_update_elem(map, key, value, flags);
@@ -1057,6 +1066,11 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		return -EINVAL;
 
+	/* Allow signed data to go through update/push methods only. */
+	if ((attr->map_flags & BPF_F_VERIFY_ELEM) &&
+	    (attr->map_flags & BPF_F_MMAPABLE))
+		return -EINVAL;
+
 	if (attr->btf_vmlinux_value_type_id) {
 		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
 		    attr->btf_key_type_id || attr->btf_value_type_id)
@@ -1353,6 +1367,62 @@ static int map_lookup_elem(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_map_verify_value_sig(const void *mod, size_t modlen, bool verify)
+{
+	const size_t marker_len = strlen(MODULE_SIG_STRING);
+	struct module_signature ms;
+	size_t sig_len;
+	u32 _modlen;
+	int ret;
+
+	/*
+	 * Format of mod:
+	 *
+	 * verified data+sig size (be32), verified data, sig, unverified data
+	 */
+	if (modlen <= sizeof(u32))
+		return -ENOENT;
+
+	_modlen = be32_to_cpu(*(u32 *)(mod));
+
+	if (_modlen > modlen - sizeof(u32))
+		return -EINVAL;
+
+	modlen = _modlen;
+	mod += sizeof(u32);
+
+	if (modlen <= marker_len)
+		return -ENOENT;
+
+	if (memcmp(mod + modlen - marker_len, MODULE_SIG_STRING, marker_len))
+		return -ENOENT;
+
+	modlen -= marker_len;
+
+	if (modlen <= sizeof(ms))
+		return -EBADMSG;
+
+	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
+
+	ret = mod_check_sig(&ms, modlen, "bpf_map_value");
+	if (ret)
+		return ret;
+
+	sig_len = be32_to_cpu(ms.sig_len);
+	modlen -= sig_len + sizeof(ms);
+
+	if (verify) {
+		ret = verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
+					     VERIFY_USE_SECONDARY_KEYRING,
+					     VERIFYING_UNSPECIFIED_SIGNATURE,
+					     NULL, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return modlen;
+}
+EXPORT_SYMBOL_GPL(bpf_map_verify_value_sig);
 
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f4009dbdf62d..a8e7803d2593 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1226,6 +1226,9 @@ enum {
 
 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+
+/* Verify map value (fmt: ver data+sig size(be32), ver data, sig, unver data) */
+	BPF_F_VERIFY_ELEM	= (1U << 13)
 };
 
 /* Flags for BPF_PROG_QUERY. */
-- 
2.25.1

