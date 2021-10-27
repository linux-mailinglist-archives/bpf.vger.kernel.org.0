Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2F43D7B6
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 01:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhJ0Xr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 19:47:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229565AbhJ0Xrz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 19:47:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19RLfaeO002444
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:45:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Awgy2B63krOaFwc0yfxqXA/vPvGmTAzZYuHPAjl0tSA=;
 b=LpVFsEf+K/9UbUebSwLZERBqufmkTyi6tZVr6h9rnLwAR5y9x7M3TtRc9RXISCa9y3kG
 Jn6i21oF7WBkZiqfDbBkP+8WNfjpbBmkB91BDhBRNNA8Mac83wQP8oTwWJ5E85kAH7vo
 6nd8udM4yNbZWRRgKr2FGrN1yIFD/zNuyco= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3by7pswywy-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 16:45:29 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 16:45:23 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 5973B421C735; Wed, 27 Oct 2021 16:45:18 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
Date:   Wed, 27 Oct 2021 16:45:00 -0700
Message-ID: <20211027234504.30744-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027234504.30744-1-joannekoong@fb.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: VjJrETFdz-MeXx13WvF1v3FVAtBWkqnT
X-Proofpoint-ORIG-GUID: VjJrETFdz-MeXx13WvF1v3FVAtBWkqnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_07,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110270130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the kernel-side changes for the implementation of
a bpf bloom filter map.

The bloom filter map supports peek (determining whether an element
is present in the map) and push (adding an element to the map)
operations.These operations are exposed to userspace applications
through the already existing syscalls in the following way:

BPF_MAP_LOOKUP_ELEM -> peek
BPF_MAP_UPDATE_ELEM -> push

The bloom filter map does not have keys, only values. In light of
this, the bloom filter map's API matches that of queue stack maps:
user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
APIs to query or add an element to the bloom filter map. When the
bloom filter map is created, it must be created with a key_size of 0.

For updates, the user will pass in the element to add to the map
as the value, with a NULL key. For lookups, the user will pass in the
element to query in the map as the value, with a NULL key. In the
verifier layer, this requires us to modify the argument type of
a bloom filter's BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE;
as well, in the syscall layer, we need to copy over the user value
so that in bpf_map_peek_elem, we know which specific value to query.

A few things to please take note of:
 * If there are any concurrent lookups + updates, the user is
responsible for synchronizing this to ensure no false negative lookups
occur.
 * The number of hashes to use for the bloom filter is configurable from
userspace. If no number is specified, the default used will be 5 hash
functions. The benchmarks later in this patchset can help compare the
performance of using different number of hashes on different entry
sizes. In general, using more hashes decreases both the false positive
rate and the speed of a lookup.
 * Deleting an element in the bloom filter map is not supported.
 * The bloom filter map may be used as an inner map.
 * The "max_entries" size that is specified at map creation time is used
to approximate a reasonable bitmap size for the bloom filter, and is not
otherwise strictly enforced. If the user wishes to insert more entries
into the bloom filter than "max_entries", they may do so but they should
be aware that this may lead to a higher false positive rate.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/linux/bpf.h            |   1 +
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |   9 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bloom_filter.c      | 195 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  24 +++-
 kernel/bpf/verifier.c          |  19 +++-
 tools/include/uapi/linux/bpf.h |   9 ++
 8 files changed, 253 insertions(+), 7 deletions(-)
 create mode 100644 kernel/bpf/bloom_filter.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 31421c74ba08..50105e0b8fcc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -169,6 +169,7 @@ struct bpf_map {
 	u32 value_size;
 	u32 max_entries;
 	u32 map_flags;
+	u64 map_extra; /* any per-map-type extra fields */
 	int spin_lock_off; /* >=3D0 valid offset, <0 error */
 	int timer_off; /* >=3D0 valid offset, <0 error */
 	u32 id;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9c81724e4b98..c4424ac2fa02 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -125,6 +125,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_RINGBUF, ringbuf_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
=20
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c10820037883..8bead4aa3ad0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -906,6 +906,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_BLOOM_FILTER,
 };
=20
 /* Note that tracing related programs such as
@@ -1274,6 +1275,13 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+		/* Any per-map-type extra fields
+		 *
+		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
+		 * number of hash functions (if 0, the bloom filter will default
+		 * to using 5 hash functions).
+		 */
+		__u64	map_extra;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -5638,6 +5646,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u64 map_extra;
 } __attribute__((aligned(8)));
=20
 struct bpf_btf_info {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7f33098ca63f..cf6ca339f3cd 100644
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
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  +=3D bpf_inode_storage.o
diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
new file mode 100644
index 000000000000..7c50232b7571
--- /dev/null
+++ b/kernel/bpf/bloom_filter.c
@@ -0,0 +1,195 @@
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
+#define BLOOM_CREATE_FLAG_MASK \
+	(BPF_F_NUMA_NODE | BPF_F_ZERO_SEED | BPF_F_ACCESS_MASK)
+
+struct bpf_bloom_filter {
+	struct bpf_map map;
+	u32 bitset_mask;
+	u32 hash_seed;
+	/* If the size of the values in the bloom filter is u32 aligned,
+	 * then it is more performant to use jhash2 as the underlying hash
+	 * function, else we use jhash. This tracks the number of u32s
+	 * in an u32-aligned value size. If the value size is not u32 aligned,
+	 * this will be 0.
+	 */
+	u32 aligned_u32_count;
+	u32 nr_hash_funcs;
+	unsigned long bitset[];
+};
+
+static u32 hash(struct bpf_bloom_filter *bloom, void *value,
+		u32 value_size, u32 index)
+{
+	u32 h;
+
+	if (bloom->aligned_u32_count)
+		h =3D jhash2(value, bloom->aligned_u32_count,
+			   bloom->hash_seed + index);
+	else
+		h =3D jhash(value, value_size, bloom->hash_seed + index);
+
+	return h & bloom->bitset_mask;
+}
+
+static int peek_elem(struct bpf_map *map, void *value)
+{
+	struct bpf_bloom_filter *bloom =3D
+		container_of(map, struct bpf_bloom_filter, map);
+	u32 i, h;
+
+	for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
+		h =3D hash(bloom, value, map->value_size, i);
+		if (!test_bit(h, bloom->bitset))
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int push_elem(struct bpf_map *map, void *value, u64 flags)
+{
+	struct bpf_bloom_filter *bloom =3D
+		container_of(map, struct bpf_bloom_filter, map);
+	u32 i, h;
+
+	if (flags !=3D BPF_ANY)
+		return -EINVAL;
+
+	for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
+		h =3D hash(bloom, value, map->value_size, i);
+		set_bit(h, bloom->bitset);
+	}
+
+	return 0;
+}
+
+static int pop_elem(struct bpf_map *map, void *value)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct bpf_map *map_alloc(union bpf_attr *attr)
+{
+	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
+	int numa_node =3D bpf_map_attr_numa_node(attr);
+	struct bpf_bloom_filter *bloom;
+
+	if (!bpf_capable())
+		return ERR_PTR(-EPERM);
+
+	if (attr->key_size !=3D 0 || attr->value_size =3D=3D 0 ||
+	    attr->max_entries =3D=3D 0 ||
+	    attr->map_flags & ~BLOOM_CREATE_FLAG_MASK ||
+	    !bpf_map_flags_access_ok(attr->map_flags) ||
+	    (attr->map_extra & ~0xF))
+		return ERR_PTR(-EINVAL);
+
+	/* The lower 4 bits of map_extra specify the number of hash functions *=
/
+	nr_hash_funcs =3D attr->map_extra & 0xF;
+	if (nr_hash_funcs =3D=3D 0)
+		/* Default to using 5 hash functions if unspecified */
+		nr_hash_funcs =3D 5;
+
+	/* For the bloom filter, the optimal bit array size that minimizes the
+	 * false positive probability is n * k / ln(2) where n is the number of
+	 * expected entries in the bloom filter and k is the number of hash
+	 * functions. We use 7 / 5 to approximate 1 / ln(2).
+	 *
+	 * We round this up to the nearest power of two to enable more efficien=
t
+	 * hashing using bitmasks. The bitmask will be the bit array size - 1.
+	 *
+	 * If this overflows a u32, the bit array size will have 2^32 (4
+	 * GB) bits.
+	 */
+	if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits) ||
+	    check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
+	    nr_bits > (1UL << 31)) {
+		/* The bit array size is 2^32 bits but to avoid overflowing the
+		 * u32, we use U32_MAX, which will round up to the equivalent
+		 * number of bytes
+		 */
+		bitset_bytes =3D BITS_TO_BYTES(U32_MAX);
+		bitset_mask =3D U32_MAX;
+	} else {
+		if (nr_bits <=3D BITS_PER_LONG)
+			nr_bits =3D BITS_PER_LONG;
+		else
+			nr_bits =3D roundup_pow_of_two(nr_bits);
+		bitset_bytes =3D BITS_TO_BYTES(nr_bits);
+		bitset_mask =3D nr_bits - 1;
+	}
+
+	bitset_bytes =3D roundup(bitset_bytes, sizeof(unsigned long));
+	bloom =3D bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_node);
+
+	if (!bloom)
+		return ERR_PTR(-ENOMEM);
+
+	bpf_map_init_from_attr(&bloom->map, attr);
+
+	bloom->nr_hash_funcs =3D nr_hash_funcs;
+	bloom->bitset_mask =3D bitset_mask;
+
+	/* Check whether the value size is u32-aligned */
+	if ((attr->value_size & (sizeof(u32) - 1)) =3D=3D 0)
+		bloom->aligned_u32_count =3D
+			attr->value_size / sizeof(u32);
+
+	if (!(attr->map_flags & BPF_F_ZERO_SEED))
+		bloom->hash_seed =3D get_random_int();
+
+	return &bloom->map;
+}
+
+static void map_free(struct bpf_map *map)
+{
+	struct bpf_bloom_filter *bloom =3D
+		container_of(map, struct bpf_bloom_filter, map);
+
+	bpf_map_area_free(bloom);
+}
+
+static void *lookup_elem(struct bpf_map *map, void *key)
+{
+	/* The eBPF program should use map_peek_elem instead */
+	return ERR_PTR(-EINVAL);
+}
+
+static int update_elem(struct bpf_map *map, void *key,
+		       void *value, u64 flags)
+{
+	/* The eBPF program should use map_push_elem instead */
+	return -EINVAL;
+}
+
+static int check_btf(const struct bpf_map *map, const struct btf *btf,
+		     const struct btf_type *key_type,
+		     const struct btf_type *value_type)
+{
+	/* Bloom filter maps are keyless */
+	return btf_type_is_void(key_type) ? 0 : -EINVAL;
+}
+
+static int bpf_bloom_btf_id;
+const struct bpf_map_ops bloom_filter_map_ops =3D {
+	.map_meta_equal =3D bpf_map_meta_equal,
+	.map_alloc =3D map_alloc,
+	.map_free =3D map_free,
+	.map_push_elem =3D push_elem,
+	.map_peek_elem =3D peek_elem,
+	.map_pop_elem =3D pop_elem,
+	.map_lookup_elem =3D lookup_elem,
+	.map_update_elem =3D update_elem,
+	.map_check_btf =3D check_btf,
+	.map_btf_name =3D "bpf_bloom_filter",
+	.map_btf_id =3D &bpf_bloom_btf_id,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5beb321b3b3b..ff0c6f5b2ec5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -199,7 +199,8 @@ static int bpf_map_update_value(struct bpf_map *map, =
struct fd f, void *key,
 		err =3D bpf_fd_reuseport_array_update_elem(map, key, value,
 							 flags);
 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_QUEUE ||
-		   map->map_type =3D=3D BPF_MAP_TYPE_STACK) {
+		   map->map_type =3D=3D BPF_MAP_TYPE_STACK ||
+		   map->map_type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER) {
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
+		   map->map_type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER) {
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
+		   "map_extra:\t%#llx\n"
 		   "memlock:\t%lu\n"
 		   "map_id:\t%u\n"
 		   "frozen:\t%u\n",
@@ -561,6 +565,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, s=
truct file *filp)
 		   map->value_size,
 		   map->max_entries,
 		   map->map_flags,
+		   (unsigned long long)map->map_extra,
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
@@ -831,6 +836,10 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
=20
+	if (attr->map_type !=3D BPF_MAP_TYPE_BLOOM_FILTER &&
+	    attr->map_extra !=3D 0)
+		return -EINVAL;
+
 	f_flags =3D bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
 		return f_flags;
@@ -1080,6 +1089,14 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!value)
 		goto free_key;
=20
+	if (map->map_type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER) {
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
@@ -3875,6 +3892,7 @@ static int bpf_map_get_info_by_fd(struct file *file=
,
 	info.value_size =3D map->value_size;
 	info.max_entries =3D map->max_entries;
 	info.map_flags =3D map->map_flags;
+	info.map_extra =3D map->map_extra;
 	memcpy(info.name, map->name, sizeof(map->name));
=20
 	if (map->btf) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c6616e325803..3c8aa7df1773 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5002,7 +5002,10 @@ static int resolve_map_arg_type(struct bpf_verifie=
r_env *env,
 			return -EINVAL;
 		}
 		break;
-
+	case BPF_MAP_TYPE_BLOOM_FILTER:
+		if (meta->func_id =3D=3D BPF_FUNC_map_peek_elem)
+			*arg_type =3D ARG_PTR_TO_MAP_VALUE;
+		break;
 	default:
 		break;
 	}
@@ -5577,6 +5580,11 @@ static int check_map_func_compatibility(struct bpf=
_verifier_env *env,
 		    func_id !=3D BPF_FUNC_task_storage_delete)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_BLOOM_FILTER:
+		if (func_id !=3D BPF_FUNC_map_peek_elem &&
+		    func_id !=3D BPF_FUNC_map_push_elem)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -5644,13 +5652,18 @@ static int check_map_func_compatibility(struct bp=
f_verifier_env *env,
 		    map->map_type !=3D BPF_MAP_TYPE_SOCKHASH)
 			goto error;
 		break;
-	case BPF_FUNC_map_peek_elem:
 	case BPF_FUNC_map_pop_elem:
-	case BPF_FUNC_map_push_elem:
 		if (map->map_type !=3D BPF_MAP_TYPE_QUEUE &&
 		    map->map_type !=3D BPF_MAP_TYPE_STACK)
 			goto error;
 		break;
+	case BPF_FUNC_map_peek_elem:
+	case BPF_FUNC_map_push_elem:
+		if (map->map_type !=3D BPF_MAP_TYPE_QUEUE &&
+		    map->map_type !=3D BPF_MAP_TYPE_STACK &&
+		    map->map_type !=3D BPF_MAP_TYPE_BLOOM_FILTER)
+			goto error;
+		break;
 	case BPF_FUNC_sk_storage_get:
 	case BPF_FUNC_sk_storage_delete:
 		if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index c10820037883..8bead4aa3ad0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -906,6 +906,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_BLOOM_FILTER,
 };
=20
 /* Note that tracing related programs such as
@@ -1274,6 +1275,13 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+		/* Any per-map-type extra fields
+		 *
+		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
+		 * number of hash functions (if 0, the bloom filter will default
+		 * to using 5 hash functions).
+		 */
+		__u64	map_extra;
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -5638,6 +5646,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u64 map_extra;
 } __attribute__((aligned(8)));
=20
 struct bpf_btf_info {
--=20
2.30.2

