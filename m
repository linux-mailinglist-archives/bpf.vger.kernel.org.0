Return-Path: <bpf+bounces-49790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6675A1C2D3
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684183A6D6F
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF282080D9;
	Sat, 25 Jan 2025 10:59:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493F1E7C08
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802756; cv=none; b=NaOtL/XfftU83mTzo3a9lTLqN3TStf2RkREU0rfKofF50tPCzhBllK1gBjZ1qpfrUFyfcwb9JOrxLe8D8rCTK53H9tLoHREUUBmq6edzg+twhlztsoHdT43fpeTLri68JaUrhRFdXG8qKXyrfY5TE6ZnS4D3gPM5riYSD16MfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802756; c=relaxed/simple;
	bh=B1F11KEE9Qca94HEBMzs6CuwUZzXLLE2Go1zv0rxy1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPIfFZJf1JKtYYJ1dUVLVApjbA09EA8CusEHL8slPEDk/HK2R8z61zIvTVtTS3L3tQoOB1CMZfJa2AZb2WdkO40agvrPkv/c4MEkPAroHnf0WBhpN9WLCf3pTP1adfOMc+rOzZBpsWiY6eQtrEXT9pFWhoDtBd78L9RXFJdmtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YgBW72qLxz4f3jXs
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 235451A0C42
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S6;
	Sat, 25 Jan 2025 18:59:03 +0800 (CST)
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 02/20] bpf: Parse bpf_dynptr in map key
Date: Sat, 25 Jan 2025 19:10:51 +0800
Message-Id: <20250125111109.732718-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S6
X-Coremail-Antispam: 1UD129KBjvJXoW3ury3CFWftw1rZr4DJFyUtrb_yoWDXrWrpF
	4xGryfCr4ktr43WrnxGay5ury3tw4kWw17WF95K34akF4SgryDZF18tFy8ur45tFs8Krn7
	Ar4a9F95A3s7AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UCZXrU
	UUUU=
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
value. To enable bpf_dynptr support in map key, the map_type should be
BPF_MAP_TYPE_HASH. For now, the max number of bpf_dynptr in a map key
is limited as 1 and the limitation can be relaxed later.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     | 14 ++++++++++++++
 kernel/bpf/btf.c        |  4 ++++
 kernel/bpf/map_in_map.c | 21 +++++++++++++++++----
 kernel/bpf/syscall.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0ee14ae30100f..ed58d5dd6b34b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -271,7 +271,14 @@ struct bpf_map {
 	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
 	u32 id;
+	/* BTF record for special fields in map value. bpf_dynptr is disallowed
+	 * at present.
+	 */
 	struct btf_record *record;
+	/* BTF record for special fields in map key. Only bpf_dynptr is allowed
+	 * at present.
+	 */
+	struct btf_record *key_record;
 	int numa_node;
 	u32 btf_key_type_id;
 	u32 btf_value_type_id;
@@ -336,6 +343,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_rb_node";
 	case BPF_REFCOUNT:
 		return "bpf_refcount";
+	case BPF_DYNPTR:
+		return "bpf_dynptr";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -366,6 +375,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return sizeof(struct bpf_refcount);
+	case BPF_DYNPTR:
+		return sizeof(struct bpf_dynptr);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -396,6 +407,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return __alignof__(struct bpf_refcount);
+	case BPF_DYNPTR:
+		return __alignof__(struct bpf_dynptr);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -426,6 +439,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
+	case BPF_DYNPTR:
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b316631b614fa..0ce5180e024a3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3500,6 +3500,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
 	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
 	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
+	field_mask_test_name(BPF_DYNPTR,    "bpf_dynptr");
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & (BPF_KPTR | BPF_UPTR) && !__btf_type_is_struct(var_type)) {
@@ -3538,6 +3539,7 @@ static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 		case BPF_UPTR:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
+		case BPF_DYNPTR:
 			break;
 		default:
 			return -EINVAL;
@@ -3660,6 +3662,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_LIST_NODE:
 	case BPF_RB_NODE:
 	case BPF_REFCOUNT:
+	case BPF_DYNPTR:
 		ret = btf_find_struct(btf, var_type, off, sz, field_type,
 				      info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -4017,6 +4020,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
index 0daf098e32074..6e14208cca813 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -651,6 +651,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_DYNPTR:
 			/* Nothing to release */
 			break;
 		default:
@@ -664,7 +665,9 @@ void btf_record_free(struct btf_record *rec)
 void bpf_map_free_record(struct bpf_map *map)
 {
 	btf_record_free(map->record);
+	btf_record_free(map->key_record);
 	map->record = NULL;
+	map->key_record = NULL;
 }
 
 struct btf_record *btf_record_dup(const struct btf_record *rec)
@@ -703,6 +706,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_DYNPTR:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -821,6 +825,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
 			break;
+		case BPF_DYNPTR:
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
@@ -830,6 +836,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 
 static void bpf_map_free(struct bpf_map *map)
 {
+	struct btf_record *key_rec = map->key_record;
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
@@ -850,6 +857,7 @@ static void bpf_map_free(struct bpf_map *map)
 	 * eventually calls bpf_map_free_meta, since inner_map_meta is only a
 	 * template bpf_map struct used during verification.
 	 */
+	btf_record_free(key_rec);
 	btf_record_free(rec);
 	/* Delay freeing of btf for maps, as map_free callback may need
 	 * struct_meta info which will be freed with btf_put().
@@ -1180,6 +1188,8 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
+#define MAX_DYNPTR_CNT_IN_MAP_KEY 1
+
 static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			 const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
 {
@@ -1202,6 +1212,37 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
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
+		if (map->map_type != BPF_MAP_TYPE_HASH) {
+			ret = -EOPNOTSUPP;
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
+	} else if (IS_ERR(map->key_record)) {
+		/* Return an error early even the bpf program doesn't use it */
+		ret = PTR_ERR(map->key_record);
+		goto free_map_tab;
+	}
+
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
-- 
2.29.2


