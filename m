Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C153FCFB0
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbhHaWv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 18:51:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17426 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240924AbhHaWv1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 18:51:27 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VMjxaN001854
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PSZPJD8vJl5F41xencKmU1tZ8cnxY3yNRlpDtwFYMzc=;
 b=EihkfwOaxGd6F45HZGx/5LbCus/wZWT3zBeSST7UJ1Lpuhm83K9U8LJwLZ2wv29dQblf
 RIYTrzpdgKWqD3/ea+DXhQVNmRX3BrUEoEIiD60cjUzHFf51NVtwrY6LyDC4p7/xbbD0
 RvnDyVkH68XV6o/RqgOCCr/wtwsoxIuxktI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3asrgut4ja-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 15:50:31 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 15:50:29 -0700
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id DB45B1C88BBD; Tue, 31 Aug 2021 15:50:23 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 1/5] bpf: Add bloom filter map implementation
Date:   Tue, 31 Aug 2021 15:50:01 -0700
Message-ID: <20210831225005.2762202-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831225005.2762202-1-joannekoong@fb.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xruRLdG5okd2zucNK0IRGX_bLG6LHn66
X-Proofpoint-ORIG-GUID: xruRLdG5okd2zucNK0IRGX_bLG6LHn66
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108310124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bloom filters are a space-efficient probabilistic data structure
used to quickly test whether an element exists in a set.
In a bloom filter, false positives are possible whereas false
negatives are not.

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
as the value, wih a NULL key. For lookups, the user will pass in the
element to query in the map as the value. In the verifier layer, this
requires us to modify the argument type of a bloom filter's
BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE; as well, in
the syscall layer, we need to copy over the user value so that in
bpf_map_peek_elem, we know which specific value to query.

The maximum number of entries in the bloom filter is not enforced; if
the user wishes to insert more entries into the bloom filter than they
specified as the max entries size of the bloom filter, that is permitted
but the performance of their bloom filter will have a higher false
positive rate.

The number of hashes to use for the bloom filter is configurable from
userspace. The benchmarks later in this patchset can help compare the
performances of different number of hashes on different entry
sizes. In general, using more hashes decreases the speed of a lookup,
but increases the false positive rate of an element being detected in the
bloom filter.

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/linux/bpf.h            |   3 +-
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |   3 +
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bloom_filter.c      | 171 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  20 +++-
 kernel/bpf/verifier.c          |  19 +++-
 tools/include/uapi/linux/bpf.h |   3 +
 8 files changed, 214 insertions(+), 8 deletions(-)
 create mode 100644 kernel/bpf/bloom_filter.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f4c16f19f83e..2abaa1052096 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -181,7 +181,8 @@ struct bpf_map {
 	u32 btf_vmlinux_value_type_id;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
-	/* 22 bytes hole */
+	u32 nr_hashes; /* used for bloom filter maps */
+	/* 18 bytes hole */
=20
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
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
index 791f31dd0abe..c2acb0a510fe 100644
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
@@ -1274,6 +1275,7 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+		__u32	nr_hashes;      /* used for configuring bloom filter maps */
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -5594,6 +5596,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u32 nr_hashes; /* used for bloom filter maps */
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
index 000000000000..3ae799ab3747
--- /dev/null
+++ b/kernel/bpf/bloom_filter.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bitmap.h>
+#include <linux/bpf.h>
+#include <linux/err.h>
+#include <linux/jhash.h>
+#include <linux/random.h>
+#include <linux/spinlock.h>
+
+#define BLOOM_FILTER_CREATE_FLAG_MASK \
+	(BPF_F_NUMA_NODE | BPF_F_ZERO_SEED | BPF_F_ACCESS_MASK)
+
+struct bpf_bloom_filter {
+	struct bpf_map map;
+	u32 bit_array_mask;
+	u32 hash_seed;
+	/* Used for synchronizing parallel writes to the bit array */
+	spinlock_t spinlock;
+	unsigned long bit_array[];
+};
+
+static int bloom_filter_map_peek_elem(struct bpf_map *map, void *value)
+{
+	struct bpf_bloom_filter *bloom_filter =3D
+		container_of(map, struct bpf_bloom_filter, map);
+	u32 i, hash;
+
+	for (i =3D 0; i < bloom_filter->map.nr_hashes; i++) {
+		hash =3D jhash(value, map->value_size, bloom_filter->hash_seed + i) &
+			bloom_filter->bit_array_mask;
+		if (!test_bit(hash, bloom_filter->bit_array))
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
+static struct bpf_map *bloom_filter_map_alloc(union bpf_attr *attr)
+{
+	int numa_node =3D bpf_map_attr_numa_node(attr);
+	u32 nr_bits, bit_array_bytes, bit_array_mask;
+	struct bpf_bloom_filter *bloom_filter;
+
+	if (!bpf_capable())
+		return ERR_PTR(-EPERM);
+
+	if (attr->key_size !=3D 0 || attr->value_size =3D=3D 0 || attr->max_ent=
ries =3D=3D 0 ||
+	    attr->nr_hashes =3D=3D 0 || attr->map_flags & ~BLOOM_FILTER_CREATE_=
FLAG_MASK ||
+	    !bpf_map_flags_access_ok(attr->map_flags))
+		return ERR_PTR(-EINVAL);
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
+	if (unlikely(check_mul_overflow(attr->max_entries, attr->nr_hashes, &nr=
_bits)) ||
+	    unlikely(check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits)) ||
+	    unlikely(nr_bits > (1UL << 31))) {
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
+	bloom_filter->map.nr_hashes =3D attr->nr_hashes;
+
+	bloom_filter->bit_array_mask =3D bit_array_mask;
+	spin_lock_init(&bloom_filter->spinlock);
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
+	unsigned long spinlock_flags;
+	u32 i, hash;
+
+	if (flags !=3D BPF_ANY)
+		return -EINVAL;
+
+	spin_lock_irqsave(&bloom_filter->spinlock, spinlock_flags);
+
+	for (i =3D 0; i < bloom_filter->map.nr_hashes; i++) {
+		hash =3D jhash(value, map->value_size, bloom_filter->hash_seed + i) &
+			bloom_filter->bit_array_mask;
+		bitmap_set(bloom_filter->bit_array, hash, 1);
+	}
+
+	spin_unlock_irqrestore(&bloom_filter->spinlock, spinlock_flags);
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
index 4e50c0bfdb7d..b80bdda26fbf 100644
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
@@ -810,7 +812,7 @@ static int map_check_btf(struct bpf_map *map, const s=
truct btf *btf,
 	return ret;
 }
=20
-#define BPF_MAP_CREATE_LAST_FIELD btf_vmlinux_value_type_id
+#define BPF_MAP_CREATE_LAST_FIELD nr_hashes
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
@@ -831,6 +833,9 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
=20
+	if (attr->nr_hashes !=3D 0 && attr->map_type !=3D BPF_MAP_TYPE_BLOOM_FI=
LTER)
+		return -EINVAL;
+
 	f_flags =3D bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
 		return f_flags;
@@ -1080,6 +1085,14 @@ static int map_lookup_elem(union bpf_attr *attr)
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
@@ -3872,6 +3885,7 @@ static int bpf_map_get_info_by_fd(struct file *file=
,
 	info.max_entries =3D map->max_entries;
 	info.map_flags =3D map->map_flags;
 	memcpy(info.name, map->name, sizeof(map->name));
+	info.nr_hashes =3D map->nr_hashes;
=20
 	if (map->btf) {
 		info.btf_id =3D btf_obj_id(map->btf);
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
index 791f31dd0abe..26b814a7d61a 100644
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
@@ -1274,6 +1275,7 @@ union bpf_attr {
 						   * struct stored as the
 						   * map value
 						   */
+		__u32	nr_hashes;	/* used for configuring bloom filter maps */
 	};
=20
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
@@ -5594,6 +5596,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
+	__u32 nr_hashes; /* used for bloom filter maps */
 } __attribute__((aligned(8)));
=20
 struct bpf_btf_info {
--=20
2.30.2

