Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3072342498B
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 00:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhJFWX3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 18:23:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38098 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232093AbhJFWX1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 18:23:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196K2B72031837
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 15:21:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=zIqCMU8tZ795WjfVpccUB57ruS3PHFhfs2t/8PLpCDg=;
 b=FYB7BCX9dJYSMwWchSMhJuYBuoLlBrHPVFS4U8AUGeIT3nkapuPjYNZlK8aUEbVvKoiI
 35Y186P6/lYeuM+nloK0b/5whfyWoBC6b4hU2nAl3E7ibd6J7Ak8RmtumTTAZb0zvGMF
 ZsfbCuRD4thkNsgL0WFbJ4vE/MIBXCUDSIU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhetfawgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 15:21:34 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 15:21:33 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 9CC5D345188D; Wed,  6 Oct 2021 15:21:29 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter capabilities
Date:   Wed, 6 Oct 2021 15:20:59 -0700
Message-ID: <20211006222103.3631981-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006222103.3631981-1-joannekoong@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: f1Cg-fYPXBdOwHyDylG3UnWVugngH1LT
X-Proofpoint-ORIG-GUID: f1Cg-fYPXBdOwHyDylG3UnWVugngH1LT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the kernel-side changes for the implementation of
a bitset map with bloom filter capabilities.

The bitset map does not have keys, only values since it is a
non-associative data type. When the bitset map is created, it must
be created with a key_size of 0, and the max_entries value should be the
desired size of the bitset, in number of bits.

The bitset map supports peek (determining whether a bit is set in the
map), push (setting a bit in the map), and pop (clearing a bit in the
map) operations. These operations are exposed to userspace applications
through the already existing syscalls in the following way:

BPF_MAP_UPDATE_ELEM -> bpf_map_push_elem
BPF_MAP_LOOKUP_ELEM -> bpf_map_peek_elem
BPF_MAP_LOOKUP_AND_DELETE_ELEM -> bpf_map_pop_elem

For updates, the user will pass in a NULL key and the index of the
bit to set in the bitmap as the value. For lookups, the user will pass
in the index of the bit to check as the value. If the bit is set, 0
will be returned, else -ENOENT. For clearing the bit, the user will pass
in the index of the bit to clear as the value.

Since we need to pass in the index of the bit to set/clear in the bitmap
whenever we do a lookup/clear, in the verifier layer this requires us to
modify the argument type of a bitset's BPF_FUNC_map_peek_elem and
BPF_FUNC_map_pop_elem calls to ARG_PTR_TO_MAP_VALUE; correspondingly, in
the syscall layer, we need to copy over the user value so that in
bpf_map_peek_elem and bpf_map_pop_elem, we have the specific
value to check.

The bitset map may be used as an inner map.

The bitset map may also have additional bloom filter capabilities. The
lower 4 bits of the map_extra flags for the bitset map denote how many
hash functions to use. If more than 0 hash functions is specified, the
bitset map will operate as a bloom filter where a set of bits are
set/checked where the bits are the results from the bloom filter
functions. Right now, jhash is function used; in the future, this can be
expanded to use map_extra to specify which hash function to use.

A few things to additionally please take note of:
 * If there are any concurrent lookups + updates in the bloom filter, the
user is responsible for synchronizing this to ensure no false negative
lookups occur.
 * Deleting an element in the bloom filter map is not supported.
 * The benchmarks later in this patchset can help compare the performance
of using different number of hashes on different entry sizes. In general,
using more hashes increases the false positive rate of an element being
detected in the bloom filter but decreases the speed of a lookup.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/linux/bpf.h            |   2 +
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |   9 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bitset.c            | 256 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  25 +++-
 kernel/bpf/verifier.c          |  10 +-
 tools/include/uapi/linux/bpf.h |   9 ++
 8 files changed, 308 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bitset.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d604c8251d88..eac5bcecc6a7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -193,6 +193,8 @@ struct bpf_map {
 	struct work_struct work;
 	struct mutex freeze_mutex;
 	u64 writecnt; /* writable mmap cnt; protected by freeze_mutex */
+
+	u32 map_extra; /* any per-map-type extra fields */
 };
=20
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9c81724e4b98..85339faeca71 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -125,6 +125,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_BITSET, bitset_map_ops)
=20
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6fc59d61937a..b40fa1a72a75 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -906,6 +906,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_BITSET,
 };
=20
 /* Note that tracing related programs such as
@@ -1252,6 +1253,13 @@ struct bpf_stack_build_id {
=20
 #define BPF_OBJ_NAME_LEN 16U
=20
+/* map_extra flags for bitset maps
+ *
+ * The lowest 4 bits are reserved for indicating the number of hash func=
tions.
+ * If the number of hash functions is greater than 0, the bitset map wil=
l
+ * be used as a bloom filter.
+ */
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1274,6 +1282,7 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+		__u32	map_extra;	/* any per-map-type extra fields */
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7f33098ca63f..72e381adc708 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -7,7 +7,7 @@ endif
 CFLAGS_core.o +=3D $(call cc-disable-warning, override-init) $(cflags-no=
gcse-yy)
=20
 obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
-obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bitset.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  +=3D bpf_inode_storage.o
diff --git a/kernel/bpf/bitset.c b/kernel/bpf/bitset.c
new file mode 100644
index 000000000000..a5fca0ebb520
--- /dev/null
+++ b/kernel/bpf/bitset.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bitmap.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/err.h>
+#include <linux/jhash.h>
+#include <linux/random.h>
+
+#define BITSET_MAP_CREATE_FLAG_MASK \
+	(BPF_F_NUMA_NODE | BPF_F_ZERO_SEED | BPF_F_ACCESS_MASK)
+
+struct bpf_bitset_map {
+	struct bpf_map map;
+
+	/* If the number of hash functions at map creation time is greater
+	 * than 0, the bitset map will function as a bloom filter and the field=
s
+	 * in the struct below will be initialized accordingly.
+	 */
+	struct {
+		u32 nr_hash_funcs;
+		u32 bitset_mask;
+		u32 hash_seed;
+		/* If the size of the values in the bloom filter is u32 aligned,
+		 * then it is more performant to use jhash2 as the underlying hash
+		 * function, else we use jhash. This tracks the number of u32s
+		 * in an u32-aligned value size. If the value size is not u32 aligned,
+		 * this will be 0.
+		 */
+		u32 aligned_u32_count;
+	} bloom_filter;
+
+	unsigned long bitset[];
+};
+
+static inline bool use_bloom_filter(struct bpf_bitset_map *map)
+{
+	return map->bloom_filter.nr_hash_funcs > 0;
+}
+
+static u32 hash(struct bpf_bitset_map *map, void *value,
+		u64 value_size, u32 index)
+{
+	u32 h;
+
+	if (map->bloom_filter.aligned_u32_count)
+		h =3D jhash2(value, map->bloom_filter.aligned_u32_count,
+			   map->bloom_filter.hash_seed + index);
+	else
+		h =3D jhash(value, value_size, map->bloom_filter.hash_seed + index);
+
+	return h & map->bloom_filter.bitset_mask;
+}
+
+static int bitset_map_push_elem(struct bpf_map *map, void *value,
+				u64 flags)
+{
+	struct bpf_bitset_map *bitset_map =3D
+		container_of(map, struct bpf_bitset_map, map);
+	u32 i, h, bitset_index;
+
+	if (flags !=3D BPF_ANY)
+		return -EINVAL;
+
+	if (use_bloom_filter(bitset_map)) {
+		for (i =3D 0; i < bitset_map->bloom_filter.nr_hash_funcs; i++) {
+			h =3D hash(bitset_map, value, map->value_size, i);
+			set_bit(h, bitset_map->bitset);
+		}
+	} else {
+		bitset_index =3D *(u32 *)value;
+
+		if (bitset_index >=3D map->max_entries)
+			return -EINVAL;
+
+		set_bit(bitset_index, bitset_map->bitset);
+	}
+
+	return 0;
+}
+
+static int bitset_map_peek_elem(struct bpf_map *map, void *value)
+{
+	struct bpf_bitset_map *bitset_map =3D
+		container_of(map, struct bpf_bitset_map, map);
+	u32 i, h, bitset_index;
+
+	if (use_bloom_filter(bitset_map)) {
+		for (i =3D 0; i < bitset_map->bloom_filter.nr_hash_funcs; i++) {
+			h =3D hash(bitset_map, value, map->value_size, i);
+			if (!test_bit(h, bitset_map->bitset))
+				return -ENOENT;
+		}
+	} else {
+		bitset_index =3D *(u32 *)value;
+		if (bitset_index  >=3D map->max_entries)
+			return -EINVAL;
+
+		if (!test_bit(bitset_index, bitset_map->bitset))
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int bitset_map_pop_elem(struct bpf_map *map, void *value)
+{
+	struct bpf_bitset_map *bitset_map =3D
+		container_of(map, struct bpf_bitset_map, map);
+	u32 bitset_index;
+
+	if (use_bloom_filter(bitset_map))
+		return -EOPNOTSUPP;
+
+	bitset_index =3D *(u32 *)value;
+
+	if (!test_and_clear_bit(bitset_index, bitset_map->bitset))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void init_bloom_filter(struct bpf_bitset_map *bitset_map, union b=
pf_attr *attr,
+			      u32 nr_hash_funcs, u32 bitset_mask)
+{
+	bitset_map->bloom_filter.nr_hash_funcs =3D nr_hash_funcs;
+	bitset_map->bloom_filter.bitset_mask =3D bitset_mask;
+
+	/* Check whether the value size is u32-aligned */
+	if ((attr->value_size & (sizeof(u32) - 1)) =3D=3D 0)
+		bitset_map->bloom_filter.aligned_u32_count =3D
+			attr->value_size / sizeof(u32);
+
+	if (!(attr->map_flags & BPF_F_ZERO_SEED))
+		bitset_map->bloom_filter.hash_seed =3D get_random_int();
+}
+
+static struct bpf_map *bitset_map_alloc(union bpf_attr *attr)
+{
+	int numa_node =3D bpf_map_attr_numa_node(attr);
+	u32 bitset_bytes, bitset_mask, nr_hash_funcs;
+	struct bpf_bitset_map *bitset_map;
+	u64 nr_bits_roundup_pow2;
+
+	if (!bpf_capable())
+		return ERR_PTR(-EPERM);
+
+	if (attr->key_size !=3D 0 || attr->max_entries =3D=3D 0 ||
+	    attr->map_flags & ~BITSET_MAP_CREATE_FLAG_MASK ||
+	    !bpf_map_flags_access_ok(attr->map_flags))
+		return ERR_PTR(-EINVAL);
+
+	if (attr->map_extra & ~0xF)
+		return ERR_PTR(-EINVAL);
+
+	/* The lower 4 bits of map_extra specify the number of hash functions *=
/
+	nr_hash_funcs =3D attr->map_extra & 0xF;
+
+	if (!nr_hash_funcs) {
+		if (attr->value_size !=3D sizeof(u32))
+			return ERR_PTR(-EINVAL);
+
+		/* Round up to the size of an unsigned long since a bit gets set
+		 * at the granularity of an unsigned long.
+		 */
+		bitset_bytes =3D roundup(BITS_TO_BYTES(attr->max_entries),
+				       sizeof(unsigned long));
+	} else {
+		/* If the number of hash functions > 0, then the map will
+		 * function as a bloom filter
+		 */
+
+		if (attr->value_size =3D=3D 0)
+			return ERR_PTR(-EINVAL);
+
+		/* We round up the size of the bitset to the nearest power of two to
+		 * enable more efficient hashing using a bitmask. The bitmask will be
+		 * the bitset size - 1.
+		 */
+		nr_bits_roundup_pow2 =3D roundup_pow_of_two(attr->max_entries);
+		bitset_mask =3D nr_bits_roundup_pow2 - 1;
+
+		bitset_bytes =3D roundup(BITS_TO_BYTES(nr_bits_roundup_pow2),
+				       sizeof(unsigned long));
+	}
+
+	bitset_map =3D bpf_map_area_alloc(sizeof(*bitset_map) + bitset_bytes,
+					numa_node);
+	if (!bitset_map)
+		return ERR_PTR(-ENOMEM);
+
+	bpf_map_init_from_attr(&bitset_map->map, attr);
+
+	if (nr_hash_funcs)
+		init_bloom_filter(bitset_map, attr, nr_hash_funcs, bitset_mask);
+
+	return &bitset_map->map;
+}
+
+static void bitset_map_free(struct bpf_map *map)
+{
+	struct bpf_bitset_map *bitset_map =3D
+		container_of(map, struct bpf_bitset_map, map);
+
+	bpf_map_area_free(bitset_map);
+}
+
+static void *bitset_map_lookup_elem(struct bpf_map *map, void *key)
+{
+	/* The eBPF program should use map_peek_elem instead */
+	return ERR_PTR(-EINVAL);
+}
+
+static int bitset_map_update_elem(struct bpf_map *map, void *key,
+				  void *value, u64 flags)
+{
+	/* The eBPF program should use map_push_elem instead */
+	return -EINVAL;
+}
+
+static int bitset_map_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bitset_map_get_next_key(struct bpf_map *map, void *key,
+				   void *next_key)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bitset_map_check_btf(const struct bpf_map *map, const struct =
btf *btf,
+				const struct btf_type *key_type,
+				const struct btf_type *value_type)
+{
+	/* Bitset maps are keyless */
+	return btf_type_is_void(key_type) ? 0 : -EINVAL;
+}
+
+static int bpf_bitset_map_btf_id;
+const struct bpf_map_ops bitset_map_ops =3D {
+	.map_meta_equal =3D bpf_map_meta_equal,
+	.map_alloc =3D bitset_map_alloc,
+	.map_free =3D bitset_map_free,
+	.map_push_elem =3D bitset_map_push_elem,
+	.map_peek_elem =3D bitset_map_peek_elem,
+	.map_pop_elem =3D bitset_map_pop_elem,
+	.map_lookup_elem =3D bitset_map_lookup_elem,
+	.map_update_elem =3D bitset_map_update_elem,
+	.map_delete_elem =3D bitset_map_delete_elem,
+	.map_get_next_key =3D bitset_map_get_next_key,
+	.map_check_btf =3D bitset_map_check_btf,
+	.map_btf_name =3D "bpf_bitset_map",
+	.map_btf_id =3D &bpf_bitset_map_btf_id,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..7726774d972a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -199,7 +199,8 @@ static int bpf_map_update_value(struct bpf_map *map, =
struct fd f, void *key,
 		err =3D bpf_fd_reuseport_array_update_elem(map, key, value,
 							 flags);
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_QUEUE ||
-		   map->map_type =3D=3D BPF_MAP_TYPE_STACK) {
+		   map->map_type =3D=3D BPF_MAP_TYPE_STACK ||
+		   map->map_type =3D=3D BPF_MAP_TYPE_BITSET) {
 		err =3D map->ops->map_push_elem(map, value, flags);
 	} else {
 		rcu_read_lock();
@@ -238,7 +239,8 @@ static int bpf_map_copy_value(struct bpf_map *map, vo=
id *key, void *value,
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
 		err =3D bpf_fd_reuseport_array_lookup_elem(map, key, value);
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_QUEUE ||
-		   map->map_type =3D=3D BPF_MAP_TYPE_STACK) {
+		   map->map_type =3D=3D BPF_MAP_TYPE_STACK ||
+		   map->map_type =3D=3D BPF_MAP_TYPE_BITSET) {
 		err =3D map->ops->map_peek_elem(map, value);
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_STRUCT_OPS) {
 		/* struct_ops map requires directly updating "value" */
@@ -348,6 +350,7 @@ void bpf_map_init_from_attr(struct bpf_map *map, unio=
n bpf_attr *attr)
 	map->max_entries =3D attr->max_entries;
 	map->map_flags =3D bpf_map_flags_retain_permanent(attr->map_flags);
 	map->numa_node =3D bpf_map_attr_numa_node(attr);
+	map->map_extra =3D attr->map_extra;
 }
=20
 static int bpf_map_alloc_id(struct bpf_map *map)
@@ -553,6 +556,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, s=
truct file *filp)
 		   "value_size:\t%u\n"
 		   "max_entries:\t%u\n"
 		   "map_flags:\t%#x\n"
+		   "map_extra:\t%#x\n"
 		   "memlock:\t%lu\n"
 		   "map_id:\t%u\n"
 		   "frozen:\t%u\n",
@@ -561,6 +565,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, s=
truct file *filp)
 		   map->value_size,
 		   map->max_entries,
 		   map->map_flags,
+		   map->map_extra,
 		   bpf_map_memory_footprint(map),
 		   map->id,
 		   READ_ONCE(map->frozen));
@@ -810,7 +815,7 @@ static int map_check_btf(struct bpf_map *map, const s=
truct btf *btf,
 	return ret;
 }
=20
-#define BPF_MAP_CREATE_LAST_FIELD btf_vmlinux_value_type_id
+#define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
@@ -1080,6 +1085,14 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!value)
 		goto free_key;
=20
+	if (map->map_type =3D=3D BPF_MAP_TYPE_BITSET) {
+		if (copy_from_user(value, uvalue, value_size))
+			err =3D -EFAULT;
+		else
+			err =3D bpf_map_copy_value(map, key, value, attr->flags);
+		goto free_value;
+	}
+
 	err =3D bpf_map_copy_value(map, key, value, attr->flags);
 	if (err)
 		goto free_value;
@@ -1549,6 +1562,12 @@ static int map_lookup_and_delete_elem(union bpf_at=
tr *attr)
 	if (map->map_type =3D=3D BPF_MAP_TYPE_QUEUE ||
 	    map->map_type =3D=3D BPF_MAP_TYPE_STACK) {
 		err =3D map->ops->map_pop_elem(map, value);
+	} else if (map->map_type =3D=3D BPF_MAP_TYPE_BITSET) {
+		if (copy_from_user(value, uvalue, value_size))
+			err =3D -EFAULT;
+		else
+			err =3D map->ops->map_pop_elem(map, value);
+		goto free_value;
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_HASH ||
 		   map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type =3D=3D BPF_MAP_TYPE_LRU_HASH ||
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20900a1bac12..731cc90b6e98 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5007,7 +5007,11 @@ static int resolve_map_arg_type(struct bpf_verifie=
r_env *env,
 			return -EINVAL;
 		}
 		break;
-
+	case BPF_MAP_TYPE_BITSET:
+		if (meta->func_id =3D=3D BPF_FUNC_map_peek_elem ||
+		    meta->func_id =3D=3D BPF_FUNC_map_pop_elem)
+			*arg_type =3D ARG_PTR_TO_MAP_VALUE;
+		break;
 	default:
 		break;
 	}
@@ -5562,6 +5566,7 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
 		break;
 	case BPF_MAP_TYPE_QUEUE:
 	case BPF_MAP_TYPE_STACK:
+	case BPF_MAP_TYPE_BITSET:
 		if (func_id !=3D BPF_FUNC_map_peek_elem &&
 		    func_id !=3D BPF_FUNC_map_pop_elem &&
 		    func_id !=3D BPF_FUNC_map_push_elem)
@@ -5653,7 +5658,8 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
 	case BPF_FUNC_map_pop_elem:
 	case BPF_FUNC_map_push_elem:
 		if (map->map_type !=3D BPF_MAP_TYPE_QUEUE &&
-		    map->map_type !=3D BPF_MAP_TYPE_STACK)
+		    map->map_type !=3D BPF_MAP_TYPE_STACK &&
+		    map->map_type !=3D BPF_MAP_TYPE_BITSET)
 			goto error;
 		break;
 	case BPF_FUNC_sk_storage_get:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 6fc59d61937a..b40fa1a72a75 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -906,6 +906,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_BITSET,
 };
=20
 /* Note that tracing related programs such as
@@ -1252,6 +1253,13 @@ struct bpf_stack_build_id {
=20
 #define BPF_OBJ_NAME_LEN 16U
=20
+/* map_extra flags for bitset maps
+ *
+ * The lowest 4 bits are reserved for indicating the number of hash func=
tions.
+ * If the number of hash functions is greater than 0, the bitset map wil=
l
+ * be used as a bloom filter.
+ */
+
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
 		__u32	map_type;	/* one of enum bpf_map_type */
@@ -1274,6 +1282,7 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+		__u32	map_extra;	/* any per-map-type extra fields */
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
--=20
2.30.2

