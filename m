Return-Path: <bpf+bounces-54794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E229A72B61
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B03B3CA1
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1F204F7D;
	Thu, 27 Mar 2025 08:23:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355292054FE
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063783; cv=none; b=aVXAJNHFOFuRH0S5CLYvI8fNIBM1gBmH256TSkSGwiNP0l7eI9lMCAdZOqR7GptzL7kuT1LDOrvshRDFqF2FBzWpWqHcewiMULsf1VU80pQjLVTn61PViZ7Z6H/CXxicWMK2dJ+j7o62+cPgHr4mVRzy7FBsE62WuYEir467yDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063783; c=relaxed/simple;
	bh=vIUgmKhqEEy8Ky9B6Ja7qVovOblEFPnslBjvgQBIWDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VL3gEzC7IbrjgCT2T53862ascno8kza/J8vZt6z5OungMqiQ7i1tcPtBZJGR6sVhzor4Z1AhTU6eqTlaJimjnkAQYor6nbw/Pe5e0hswMXSsh022pncFkczg/Bgv8Pd+j4F+MdP2gclSHlZJ0QRV8mD2kHcwwOB5q/Jdr30RDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8j31XRz4f3jXm
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F08A1A117C
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S6;
	Thu, 27 Mar 2025 16:22:52 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 02/16] bpf: Parse bpf_dynptr in map key
Date: Thu, 27 Mar 2025 16:34:41 +0800
Message-Id: <20250327083455.848708-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S6
X-Coremail-Antispam: 1UD129KBjvJXoW3ury3CFWftFWxtF4DWF1fCrg_yoWDZw1xpF
	4xCryfCr4ktr43WrnxGay3ury3tw4kWw17WF95K34akF4SgryDZF18tFyrur45KFs8Krn7
	Ar429F95A347AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

To support variable-length key or strings in map key, use bpf_dynptr to
represent these variable-length objects and save these bpf_dynptr
fields in the map key. As shown in the examples below, a map key with an
integer and a string is defined:

	struct pid_name {
		int pid;
		struct bpf_dynptr name;
	};

The bpf_dynptr in the map key could also be contained indirectly in a
struct as shown below:

	struct pid_name_time {
		struct pid_name process;
		unsigned long long time;
	};

It is also fine to have multiple bpf_dynptrs in the map key as shown
below. The maximum number of bpf_dynptr in a map key is limited to 2 and
the limitation can be lifted if necessary.

	struct pid_name_tag {
		struct pid_name process;
		struct bpf_dynptr tag;
	};

If the whole map key is a bpf_dynptr, the map could be defined as a
struct or directly using bpf_dynptr as the map key:

	struct map_key {
		struct bpf_dynptr name;
	};

The bpf program could use bpf_dynptr_init() to initialize the dynptr
part in the map key, and the userspace application will use
bpf_dynptr_user_init() or similar API to initialize the dynptr. Just
like kptrs in map value, the bpf_dynptr field in the map key could also
be defined in a nested struct which is contained in the map key struct.

The patch updates map_create() accordingly to parse these bpf_dynptr
fields in map key, just like it does for other special fields in map
value. These special fields are saved in the newly-added key_record
field of bpf_map. Considering both key_record and key_size are used
during the lookup procedure, place key_record in the same cacheline as
key_size and move the cold map_extra to the next cacheline. At present,
only BPF_MAP_TYPE_HASH map supports bpf_dynptr and the support will be
enabled later when its implementation is ready.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     | 12 +++++++++++-
 kernel/bpf/btf.c        |  4 ++++
 kernel/bpf/map_in_map.c | 21 +++++++++++++++++----
 kernel/bpf/syscall.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0b65c98d8b7d5..e25ff78f1fabf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -271,10 +271,13 @@ struct bpf_map {
 	u32 key_size;
 	u32 value_size;
 	u32 max_entries;
-	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
 	u32 id;
+	/* BTF record for special fields in map Key. Only allow bpf_dynptr */
+	struct btf_record *key_record;
+	/* BTF record for special fields in map Value. Disallow bpf_dynptr. */
 	struct btf_record *record;
+	u64 map_extra; /* any per-map-type extra fields */
 	int numa_node;
 	u32 btf_key_type_id;
 	u32 btf_value_type_id;
@@ -341,6 +344,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_rb_node";
 	case BPF_REFCOUNT:
 		return "bpf_refcount";
+	case BPF_DYNPTR:
+		return "bpf_dynptr";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -373,6 +378,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return sizeof(struct bpf_refcount);
+	case BPF_DYNPTR:
+		return sizeof(struct bpf_dynptr);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -405,6 +412,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return __alignof__(struct bpf_refcount);
+	case BPF_DYNPTR:
+		return __alignof__(struct bpf_dynptr);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -436,6 +445,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
+	case BPF_DYNPTR:
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1054a1e27e9d3..c3c28ecf6bf09 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3513,6 +3513,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
 	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
 	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
+	field_mask_test_name(BPF_DYNPTR,    "bpf_dynptr");
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & (BPF_KPTR | BPF_UPTR) && !__btf_type_is_struct(var_type)) {
@@ -3551,6 +3552,7 @@ static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 		case BPF_UPTR:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
+		case BPF_DYNPTR:
 			break;
 		default:
 			return -EINVAL;
@@ -3674,6 +3676,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_LIST_NODE:
 	case BPF_RB_NODE:
 	case BPF_REFCOUNT:
+	case BPF_DYNPTR:
 		ret = btf_find_struct(btf, var_type, off, sz, field_type,
 				      info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -4037,6 +4040,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			break;
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
+		case BPF_DYNPTR:
 			break;
 		default:
 			ret = -EFAULT;
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 645bd30bc9a9d..564ebcc857564 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -12,6 +12,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	struct bpf_map *inner_map, *inner_map_meta;
 	u32 inner_map_meta_size;
 	CLASS(fd, f)(inner_map_ufd);
+	int ret;
 
 	inner_map = __bpf_map_get(f);
 	if (IS_ERR(inner_map))
@@ -45,10 +46,15 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		 * invalid/empty/valid, but ERR_PTR in case of errors. During
 		 * equality NULL or IS_ERR is equivalent.
 		 */
-		struct bpf_map *ret = ERR_CAST(inner_map_meta->record);
-		kfree(inner_map_meta);
-		return ret;
+		ret = PTR_ERR(inner_map_meta->record);
+		goto free_meta;
 	}
+	inner_map_meta->key_record = btf_record_dup(inner_map->key_record);
+	if (IS_ERR(inner_map_meta->key_record)) {
+		ret = PTR_ERR(inner_map_meta->key_record);
+		goto free_record;
+	}
+
 	/* Note: We must use the same BTF, as we also used btf_record_dup above
 	 * which relies on BTF being same for both maps, as some members like
 	 * record->fields.list_head have pointers like value_rec pointing into
@@ -71,6 +77,12 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
 	}
 	return inner_map_meta;
+
+free_record:
+	btf_record_free(inner_map_meta->record);
+free_meta:
+	kfree(inner_map_meta);
+	return ERR_PTR(ret);
 }
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
@@ -88,7 +100,8 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->map_flags == meta1->map_flags &&
-		btf_record_equal(meta0->record, meta1->record);
+		btf_record_equal(meta0->record, meta1->record) &&
+		btf_record_equal(meta0->key_record, meta1->key_record);
 }
 
 void *bpf_map_fd_get_ptr(struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6c..9ded3ba82d356 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -669,6 +669,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_DYNPTR:
 			/* Nothing to release */
 			break;
 		default:
@@ -682,7 +683,9 @@ void btf_record_free(struct btf_record *rec)
 void bpf_map_free_record(struct bpf_map *map)
 {
 	btf_record_free(map->record);
+	btf_record_free(map->key_record);
 	map->record = NULL;
+	map->key_record = NULL;
 }
 
 struct btf_record *btf_record_dup(const struct btf_record *rec)
@@ -722,6 +725,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_DYNPTR:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -841,6 +845,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
 			break;
+		case BPF_DYNPTR:
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
@@ -850,6 +856,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 
 static void bpf_map_free(struct bpf_map *map)
 {
+	struct btf_record *key_rec = map->key_record;
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
@@ -870,6 +877,7 @@ static void bpf_map_free(struct bpf_map *map)
 	 * eventually calls bpf_map_free_meta, since inner_map_meta is only a
 	 * template bpf_map struct used during verification.
 	 */
+	btf_record_free(key_rec);
 	btf_record_free(rec);
 	/* Delay freeing of btf for maps, as map_free callback may need
 	 * struct_meta info which will be freed with btf_put().
@@ -1209,6 +1217,8 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
+#define MAX_DYNPTR_CNT_IN_MAP_KEY 2
+
 static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			 const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
 {
@@ -1231,6 +1241,36 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 	if (!value_type || value_size != map->value_size)
 		return -EINVAL;
 
+	/* Key BTF type can't be data section */
+	if (btf_type_is_dynptr(btf, key_type))
+		map->key_record = btf_new_bpf_dynptr_record();
+	else if (__btf_type_is_struct(key_type))
+		map->key_record = btf_parse_fields(btf, key_type, BPF_DYNPTR, map->key_size);
+	else
+		map->key_record = NULL;
+	if (!IS_ERR_OR_NULL(map->key_record)) {
+		if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY) {
+			ret = -E2BIG;
+			goto free_map_tab;
+		}
+		if (!bpf_token_capable(token, CAP_BPF)) {
+			ret = -EPERM;
+			goto free_map_tab;
+		}
+		/* Disallow key with dynptr for special map */
+		if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) {
+			ret = -EACCES;
+			goto free_map_tab;
+		}
+		/* Enable for BPF_MAP_TYPE_HASH later */
+		ret = -EOPNOTSUPP;
+		goto free_map_tab;
+	} else if (IS_ERR(map->key_record)) {
+		/* Return an error early even the bpf program doesn't use it */
+		ret = PTR_ERR(map->key_record);
+		goto free_map_tab;
+	}
+
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
-- 
2.29.2


