Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1040A522
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 06:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhINEKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 00:10:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23782 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232173AbhINEKf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 00:10:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18E33Fke006334
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vnK0v3FAYMpmrILlEgujbyFiScJgDbeAQEk7efmzknY=;
 b=dOC593vg0D63O/oWa76CLLVHhC+pRyrA9QXLNgJNeLU+rpFBN6CTryFcPF80b58/06aA
 H7hnKRH9rHuKs3dPdcohnPk00xJCVADuZfCoAKeJEkW2OAEAhg5IiyYaUFIwz/FfUqXJ
 k4w9FRBiChCiDSTcb+yuvLaXwa5n5Mvb/cQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2kga88yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:17 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 21:09:16 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id AB12E25C5B61; Mon, 13 Sep 2021 21:09:14 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v2 bpf-next 1/4] bpf: Add bloom filter map implementation
Date:   Mon, 13 Sep 2021 21:04:30 -0700
Message-ID: <20210914040433.3184308-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914040433.3184308-1-joannekoong@fb.com>
References: <20210914040433.3184308-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 7cH09Vh3F48stt2AREKTr1-cRGfM2oKQ
X-Proofpoint-GUID: 7cH09Vh3F48stt2AREKTr1-cRGfM2oKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bloom filters are a space-efficient probabilistic data structure
used to quickly test whether an element exists in a set.
In a bloom filter, false positives are possible whereas false
negatives should never be.

This patch adds a bloom filter map for bpf programs.
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
element to query in the map as the value. In the verifier layer, this
requires us to modify the argument type of a bloom filter's
BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
the syscall layer, we need to copy over the user value so that in
bpf_map_peek_elem, we know which specific value to query.

A few things to please take note of:
 * If there are any concurrent lookups + updates, the user is
responsible for synchronizing this to ensure no false negative lookups
occur.
 * The number of hashes to use for the bloom filter is configurable from
userspace. If no number is specified, the default used will be 5 hash
functions. The benchmarks later in this patchset can help compare the
performance of using different number of hashes on different entry
sizes. In general, using more hashes decreases the speed of a lookup,
but increases the false positive rate of an element being detected in the
bloom filter.
 * Deleting an element in the bloom filter map is not supported.
 * The bloom filter map may be used as an inner map.
 * The "max_entries" size that is specified at map creation time is used =
to
approximate a reasonable bitmap size for the bloom filter, and is not
otherwise strictly enforced. If the user wishes to insert more entries in=
to
the bloom filter than "max_entries", they may do so but they should be
aware that this may lead to a higher false positive rate.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |  10 ++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bloom_filter.c      | 205 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  14 ++-
 kernel/bpf/verifier.c          |  19 ++-
 tools/include/uapi/linux/bpf.h |  10 ++
 7 files changed, 255 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bloom_filter.c

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
index 791f31dd0abe..1d82860fd98e 100644
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
@@ -1210,6 +1211,15 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* For bloom filter maps, the next 4 bits represent how many hashes to u=
se.
+ * The maximum number of hash functions supported is 15. If this is not =
set,
+ * the default number of hash functions used will be 5.
+ */
+	BPF_F_BLOOM_FILTER_HASH_BIT_1 =3D (1U << 13),
+	BPF_F_BLOOM_FILTER_HASH_BIT_2 =3D (1U << 14),
+	BPF_F_BLOOM_FILTER_HASH_BIT_3 =3D (1U << 15),
+	BPF_F_BLOOM_FILTER_HASH_BIT_4 =3D (1U << 16),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
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
index 000000000000..43a17c5b35ac
--- /dev/null
+++ b/kernel/bpf/bloom_filter.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bitmap.h>
+#include <linux/bpf.h>
+#include <linux/err.h>
+#include <linux/jhash.h>
+#include <linux/random.h>
+
+#define BLOOM_FILTER_HASH_BITMASK \
+	 (BPF_F_BLOOM_FILTER_HASH_BIT_1 | BPF_F_BLOOM_FILTER_HASH_BIT_2 | \
+	 BPF_F_BLOOM_FILTER_HASH_BIT_3 | BPF_F_BLOOM_FILTER_HASH_BIT_4)
+
+#define BLOOM_FILTER_CREATE_FLAG_MASK \
+	(BPF_F_NUMA_NODE | BPF_F_ZERO_SEED | BPF_F_ACCESS_MASK | \
+	 BLOOM_FILTER_HASH_BITMASK)
+
+struct bpf_bloom_filter {
+	struct bpf_map map;
+	u32 bit_array_mask;
+	u32 hash_seed;
+	/* If the size of the values in the bloom filter is u32 aligned,
+	 * then it is more performant to use jhash2 as the underlying hash
+	 * function, else we use jhash. This tracks the number of u32s
+	 * in an u32-aligned value size. If the value size is not u32 aligned,
+	 * this will be 0.
+	 */
+	u32 aligned_u32_count;
+	u8 nr_hashes;
+	unsigned long bit_array[];
+};
+
+static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
+{
+	struct bpf_bloom_filter *bloom_filter =3D
+		container_of(map, struct bpf_bloom_filter, map);
+	u32 hash;
+	u8 i;
+
+	for (i =3D 0; i < bloom_filter->nr_hashes; i++) {
+		if (bloom_filter->aligned_u32_count)
+			hash =3D jhash2(value, bloom_filter->aligned_u32_count,
+				      bloom_filter->hash_seed + i) &
+				bloom_filter->bit_array_mask;
+		else
+			hash =3D jhash(value, map->value_size,
+				     bloom_filter->hash_seed + i) &
+				bloom_filter->bit_array_mask;
+
+		if (!test_bit(hash, bloom_filter->bit_array))
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
+static u8 get_nr_hashes(u32 map_flags)
+{
+	u8 nr_hashes =3D (map_flags & BLOOM_FILTER_HASH_BITMASK) >>
+		ilog2(BPF_F_BLOOM_FILTER_HASH_BIT_1);
+
+	/* Default to 5 if no number of hashes was specified */
+	return nr_hashes =3D=3D 0 ? 5 : nr_hashes;
+}
+
+static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
+{
+	u32 nr_bits, bit_array_bytes, bit_array_mask;
+	int numa_node =3D bpf_map_attr_numa_node(attr);
+	struct bpf_bloom_filter *bloom_filter;
+	u8 nr_hashes;
+
+	if (!bpf_capable())
+		return ERR_PTR(-EPERM);
+
+	if (attr->key_size !=3D 0 || attr->value_size =3D=3D 0 || attr->max_ent=
ries =3D=3D 0 ||
+	    attr->map_flags & ~BLOOM_FILTER_CREATE_FLAG_MASK ||
+	    !bpf_map_flags_access_ok(attr->map_flags))
+		return ERR_PTR(-EINVAL);
+
+	nr_hashes =3D get_nr_hashes(attr->map_flags);
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
+	if (check_mul_overflow(attr->max_entries, (u32)nr_hashes, &nr_bits) ||
+	    check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
+	    nr_bits > (1UL << 31)) {
+		/* The bit array size is 2^32 bits but to avoid overflowing the
+		 * u32, we use BITS_TO_BYTES(U32_MAX), which will round up to the
+		 * equivalent number of bytes
+		 */
+		bit_array_bytes =3D BITS_TO_BYTES(U32_MAX);
+		bit_array_mask =3D U32_MAX;
+	} else {
+		if (nr_bits <=3D BITS_PER_LONG)
+			nr_bits =3D BITS_PER_LONG;
+		else
+			nr_bits =3D roundup_pow_of_two(nr_bits);
+		bit_array_bytes =3D BITS_TO_BYTES(nr_bits);
+		bit_array_mask =3D nr_bits - 1;
+	}
+
+	bit_array_bytes =3D roundup(bit_array_bytes, sizeof(unsigned long));
+	bloom_filter =3D bpf_map_area_alloc(sizeof(*bloom_filter) + bit_array_b=
ytes,
+					  numa_node);
+
+	if (!bloom_filter)
+		return ERR_PTR(-ENOMEM);
+
+	bpf_map_init_from_attr(&bloom_filter->map, attr);
+
+	bloom_filter->nr_hashes =3D nr_hashes;
+	bloom_filter->bit_array_mask =3D bit_array_mask;
+	if ((attr->value_size & (sizeof(u32) - 1)) =3D=3D 0)
+		bloom_filter->aligned_u32_count =3D attr->value_size / sizeof(u32);
+
+	if (!(attr->map_flags & BPF_F_ZERO_SEED))
+		bloom_filter->hash_seed =3D get_random_int();
+
+	return &bloom_filter->map;
+}
+
+static void bloom_filter_map_free(struct bpf_map *map)
+{
+	struct bpf_bloom_filter *bloom_filter =3D
+		container_of(map, struct bpf_bloom_filter, map);
+
+	bpf_map_area_free(bloom_filter);
+}
+
+static int bloom_filter_map_push_elem(struct bpf_map *map, void *value,
+				      u64 flags)
+{
+	struct bpf_bloom_filter *bloom_filter =3D
+		container_of(map, struct bpf_bloom_filter, map);
+	u32 hash;
+	u8 i;
+
+	if (flags !=3D BPF_ANY)
+		return -EINVAL;
+
+	for (i =3D 0; i < bloom_filter->nr_hashes; i++) {
+		if (bloom_filter->aligned_u32_count)
+			hash =3D jhash2(value, bloom_filter->aligned_u32_count,
+				      bloom_filter->hash_seed + i) &
+				bloom_filter->bit_array_mask;
+		else
+			hash =3D jhash(value, map->value_size,
+				     bloom_filter->hash_seed + i) &
+				bloom_filter->bit_array_mask;
+
+		set_bit(hash, bloom_filter->bit_array);
+	}
+
+	return 0;
+}
+
+static void *bloom_filter_map_lookup_elem(struct bpf_map *map, void *key=
)
+{
+	/* The eBPF program should use map_peek_elem instead */
+	return ERR_PTR(-EINVAL);
+}
+
+static int bloom_filter_map_update_elem(struct bpf_map *map, void *key,
+					void *value, u64 flags)
+{
+	/* The eBPF program should use map_push_elem instead */
+	return -EINVAL;
+}
+
+static int bloom_filter_map_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bloom_filter_map_get_next_key(struct bpf_map *map, void *key,
+					 void *next_key)
+{
+	return -EOPNOTSUPP;
+}
+
+static int bloom_filter_map_btf_id;
+const struct bpf_map_ops bloom_filter_map_ops =3D {
+	.map_meta_equal =3D bpf_map_meta_equal,
+	.map_alloc =3D bloom_filter_map_alloc,
+	.map_free =3D bloom_filter_map_free,
+	.map_push_elem =3D bloom_filter_map_push_elem,
+	.map_peek_elem =3D bloom_filter_map_peek_elem,
+	.map_lookup_elem =3D bloom_filter_map_lookup_elem,
+	.map_update_elem =3D bloom_filter_map_update_elem,
+	.map_delete_elem =3D bloom_filter_map_delete_elem,
+	.map_get_next_key =3D bloom_filter_map_get_next_key,
+	.map_check_btf =3D map_check_no_btf,
+	.map_btf_name =3D "bpf_bloom_filter",
+	.map_btf_id =3D &bloom_filter_map_btf_id,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..9865b5b1e667 100644
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
@@ -1080,6 +1082,14 @@ static int map_lookup_elem(union bpf_attr *attr)
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 047ac4b4703b..5cbcff4c2222 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4813,7 +4813,10 @@ static int resolve_map_arg_type(struct bpf_verifie=
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
@@ -5388,6 +5391,11 @@ static int check_map_func_compatibility(struct bpf=
_verifier_env *env,
 		    func_id !=3D BPF_FUNC_task_storage_delete)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_BLOOM_FILTER:
+		if (func_id !=3D BPF_FUNC_map_push_elem &&
+		    func_id !=3D BPF_FUNC_map_peek_elem)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -5455,13 +5463,18 @@ static int check_map_func_compatibility(struct bp=
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
+	case BPF_FUNC_map_push_elem:
+	case BPF_FUNC_map_peek_elem:
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
index 791f31dd0abe..1d82860fd98e 100644
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
@@ -1210,6 +1211,15 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* For bloom filter maps, the next 4 bits represent how many hashes to u=
se.
+ * The maximum number of hash functions supported is 15. If this is not =
set,
+ * the default number of hash functions used will be 5.
+ */
+	BPF_F_BLOOM_FILTER_HASH_BIT_1 =3D (1U << 13),
+	BPF_F_BLOOM_FILTER_HASH_BIT_2 =3D (1U << 14),
+	BPF_F_BLOOM_FILTER_HASH_BIT_3 =3D (1U << 15),
+	BPF_F_BLOOM_FILTER_HASH_BIT_4 =3D (1U << 16),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
--=20
2.30.2

