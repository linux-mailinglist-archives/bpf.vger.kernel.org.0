Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE94E52578C
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 00:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348898AbiELWHY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 May 2022 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345855AbiELWHY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 18:07:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85371674ED
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 15:07:22 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CLqsd8019257
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 15:07:22 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g054f6huq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 15:07:22 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 15:07:20 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4024C19D448DC; Thu, 12 May 2022 15:07:14 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: add safer high-level wrappers for map operations
Date:   Thu, 12 May 2022 15:07:12 -0700
Message-ID: <20220512220713.2617964-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mronZ6POPE5UcoGzbAFEAq3uwXl5ScBj
X-Proofpoint-GUID: mronZ6POPE5UcoGzbAFEAq3uwXl5ScBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_18,2022-05-12_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add high-level API wrappers for most common and typical BPF map
operations that works directly on instances of struct bpf_map * (so you
don't have to call bpf_map__fd()) and validate key/value size
expectations.

These helpers require users to specify key (and value, where
appropriate) sizes when performing lookup/update/delete/etc. This forces
user to actually think and validate (for themselves) those. This is
a good thing as user is expected by kernel to implicitly provide correct
key/value buffer sizes and kernel will just read/write necessary amount
of data. If it so happens that user doesn't set up buffers correctly
(which bit people for per-CPU maps especially) kernel either randomly
overwrites stack data or return -EFAULT, depending on user's luck and
circumstances. These high-level APIs are meant to prevent such
unpleasant and hard to debug bugs.

This patch also adds bpf_map_delete_elem_flags() low-level API and
requires passing flags to bpf_map__delete_elem() API for consistency
across all similar APIs, even though currently kernel doesn't expect any
extra flags for BPF_MAP_DELETE_ELEM operation.

List of map operations that get these high-level APIs:
  - bpf_map_lookup_elem;
  - bpf_map_update_elem;
  - bpf_map_delete_elem;
  - bpf_map_lookup_and_delete_elem;
  - bpf_map_get_next_key.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v1->v2:
  - add pr_warn() with helpful messages for users (Daniel).

 tools/lib/bpf/bpf.c      |  14 ++++++
 tools/lib/bpf/bpf.h      |   1 +
 tools/lib/bpf/libbpf.c   | 104 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 104 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |   6 +++
 5 files changed, 229 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5660268e103f..4677644d80f4 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -639,6 +639,20 @@ int bpf_map_delete_elem(int fd, const void *key)
 	return libbpf_err_errno(ret);
 }
 
+int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags)
+{
+	union bpf_attr attr;
+	int ret;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.map_fd = fd;
+	attr.key = ptr_to_u64(key);
+	attr.flags = flags;
+
+	ret = sys_bpf(BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
+	return libbpf_err_errno(ret);
+}
+
 int bpf_map_get_next_key(int fd, const void *key, void *next_key)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 34af2232928c..2e0d3731e4c0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -244,6 +244,7 @@ LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 LIBBPF_API int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key,
 						    void *value, __u64 flags);
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
+LIBBPF_API int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4867a930628b..9aae886cbabf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9949,6 +9949,110 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset)
 	return libbpf_err_ptr(-ENOTSUP);
 }
 
+static int validate_map_op(const struct bpf_map *map, size_t key_sz,
+			   size_t value_sz, bool check_value_sz)
+{
+	if (map->fd <= 0)
+		return -ENOENT;
+
+	if (map->def.key_size != key_sz) {
+		pr_warn("map '%s': unexpected key size %zu provided, expected %u\n",
+			map->name, key_sz, map->def.key_size);
+		return -EINVAL;
+	}
+
+	if (!check_value_sz)
+		return 0;
+
+	switch (map->def.type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE: {
+		int num_cpu = libbpf_num_possible_cpus();
+		size_t elem_sz = roundup(map->def.value_size, 8);
+
+		if (value_sz != num_cpu * elem_sz) {
+			pr_warn("map '%s': unexpected value size %zu provided for per-CPU map, expected %d * %zu = %zd\n",
+				map->name, value_sz, num_cpu, elem_sz, num_cpu * elem_sz);
+			return -EINVAL;
+		}
+		break;
+	}
+	default:
+		if (map->def.value_size != value_sz) {
+			pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
+				map->name, value_sz, map->def.value_size);
+			return -EINVAL;
+		}
+		break;
+	}
+	return 0;
+}
+
+int bpf_map__lookup_elem(const struct bpf_map *map,
+			 const void *key, size_t key_sz,
+			 void *value, size_t value_sz, __u64 flags)
+{
+	int err;
+
+	err = validate_map_op(map, key_sz, value_sz, true);
+	if (err)
+		return libbpf_err(err);
+
+	return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
+}
+
+int bpf_map__update_elem(const struct bpf_map *map,
+			 const void *key, size_t key_sz,
+			 const void *value, size_t value_sz, __u64 flags)
+{
+	int err;
+
+	err = validate_map_op(map, key_sz, value_sz, true);
+	if (err)
+		return libbpf_err(err);
+
+	return bpf_map_update_elem(map->fd, key, value, flags);
+}
+
+int bpf_map__delete_elem(const struct bpf_map *map,
+			 const void *key, size_t key_sz, __u64 flags)
+{
+	int err;
+
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	if (err)
+		return libbpf_err(err);
+
+	return bpf_map_delete_elem_flags(map->fd, key, flags);
+}
+
+int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
+				    const void *key, size_t key_sz,
+				    void *value, size_t value_sz, __u64 flags)
+{
+	int err;
+
+	err = validate_map_op(map, key_sz, value_sz, true);
+	if (err)
+		return libbpf_err(err);
+
+	return bpf_map_lookup_and_delete_elem_flags(map->fd, key, value, flags);
+}
+
+int bpf_map__get_next_key(const struct bpf_map *map,
+			  const void *cur_key, void *next_key, size_t key_sz)
+{
+	int err;
+
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	if (err)
+		return libbpf_err(err);
+
+	return bpf_map_get_next_key(map->fd, cur_key, next_key);
+}
+
 long libbpf_get_error(const void *ptr)
 {
 	if (!IS_ERR_OR_NULL(ptr))
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 21984dcd6dbe..9e9a3fd3edd8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -990,6 +990,110 @@ LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
 LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
 LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
 
+/**
+ * @brief **bpf_map__lookup_elem()** allows to lookup BPF map value
+ * corresponding to provided key.
+ * @param map BPF map to lookup element in
+ * @param key pointer to memory containing bytes of the key used for lookup
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @param value pointer to memory in which looked up value will be stored
+ * @param value_sz size in byte of value data memory; it has to match BPF map
+ * definition's **value_size**. For per-CPU BPF maps value size has to be
+ * a product of BPF map value size and number of possible CPUs in the system
+ * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
+ * per-CPU values value size has to be aligned up to closest 8 bytes for
+ * alignment reasons, so expected size is: `round_up(value_size, 8)
+ * * libbpf_num_possible_cpus()`.
+ * @flags extra flags passed to kernel for this operation
+ * @return 0, on success; negative error, otherwise
+ *
+ * **bpf_map__lookup_elem()** is high-level equivalent of
+ * **bpf_map_lookup_elem()** API with added check for key and value size.
+ */
+LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
+				    const void *key, size_t key_sz,
+				    void *value, size_t value_sz, __u64 flags);
+
+/**
+ * @brief **bpf_map__update_elem()** allows to insert or update value in BPF
+ * map that corresponds to provided key.
+ * @param map BPF map to insert to or update element in
+ * @param key pointer to memory containing bytes of the key
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @param value pointer to memory containing bytes of the value
+ * @param value_sz size in byte of value data memory; it has to match BPF map
+ * definition's **value_size**. For per-CPU BPF maps value size has to be
+ * a product of BPF map value size and number of possible CPUs in the system
+ * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
+ * per-CPU values value size has to be aligned up to closest 8 bytes for
+ * alignment reasons, so expected size is: `round_up(value_size, 8)
+ * * libbpf_num_possible_cpus()`.
+ * @flags extra flags passed to kernel for this operation
+ * @return 0, on success; negative error, otherwise
+ *
+ * **bpf_map__update_elem()** is high-level equivalent of
+ * **bpf_map_update_elem()** API with added check for key and value size.
+ */
+LIBBPF_API int bpf_map__update_elem(const struct bpf_map *map,
+				    const void *key, size_t key_sz,
+				    const void *value, size_t value_sz, __u64 flags);
+
+/**
+ * @brief **bpf_map__delete_elem()** allows to delete element in BPF map that
+ * corresponds to provided key.
+ * @param map BPF map to delete element from
+ * @param key pointer to memory containing bytes of the key
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @flags extra flags passed to kernel for this operation
+ * @return 0, on success; negative error, otherwise
+ *
+ * **bpf_map__delete_elem()** is high-level equivalent of
+ * **bpf_map_delete_elem()** API with added check for key size.
+ */
+LIBBPF_API int bpf_map__delete_elem(const struct bpf_map *map,
+				    const void *key, size_t key_sz, __u64 flags);
+
+/**
+ * @brief **bpf_map__lookup_and_delete_elem()** allows to lookup BPF map value
+ * corresponding to provided key and atomically delete it afterwards.
+ * @param map BPF map to lookup element in
+ * @param key pointer to memory containing bytes of the key used for lookup
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @param value pointer to memory in which looked up value will be stored
+ * @param value_sz size in byte of value data memory; it has to match BPF map
+ * definition's **value_size**. For per-CPU BPF maps value size has to be
+ * a product of BPF map value size and number of possible CPUs in the system
+ * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
+ * per-CPU values value size has to be aligned up to closest 8 bytes for
+ * alignment reasons, so expected size is: `round_up(value_size, 8)
+ * * libbpf_num_possible_cpus()`.
+ * @flags extra flags passed to kernel for this operation
+ * @return 0, on success; negative error, otherwise
+ *
+ * **bpf_map__lookup_and_delete_elem()** is high-level equivalent of
+ * **bpf_map_lookup_and_delete_elem()** API with added check for key and value size.
+ */
+LIBBPF_API int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
+					       const void *key, size_t key_sz,
+					       void *value, size_t value_sz, __u64 flags);
+
+/**
+ * @brief **bpf_map__get_next_key()** allows to iterate BPF map keys by
+ * fetching next key that follows current key.
+ * @param map BPF map to fetch next key from
+ * @param cur_key pointer to memory containing bytes of current key or NULL to
+ * fetch the first key
+ * @param next_key pointer to memory to write next key into
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @return 0, on success; -ENOENT if **cur_key** is the last key in BPF map;
+ * negative error, otherwise
+ *
+ * **bpf_map__get_next_key()** is high-level equivalent of
+ * **bpf_map_get_next_key()** API with added check for key size.
+ */
+LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
+				     const void *cur_key, void *next_key, size_t key_sz);
+
 /**
  * @brief **libbpf_get_error()** extracts the error code from the passed
  * pointer
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 008da8db1d94..6b36f46ab5d8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -443,7 +443,13 @@ LIBBPF_0.7.0 {
 LIBBPF_0.8.0 {
 	global:
 		bpf_map__autocreate;
+		bpf_map__get_next_key;
+		bpf_map__delete_elem;
+		bpf_map__lookup_and_delete_elem;
+		bpf_map__lookup_elem;
 		bpf_map__set_autocreate;
+		bpf_map__update_elem;
+		bpf_map_delete_elem_flags;
 		bpf_object__destroy_subskeleton;
 		bpf_object__open_subskeleton;
 		bpf_program__attach_kprobe_multi_opts;
-- 
2.30.2

