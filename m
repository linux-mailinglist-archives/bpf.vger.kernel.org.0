Return-Path: <bpf+bounces-41202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3499438B
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659AA1F27312
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7B17B4EC;
	Tue,  8 Oct 2024 09:02:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F242538A
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378152; cv=none; b=WqMBlBEEmGga5tYskPajL3q3Quo5Es/h6H198sdX/NIwRfsJRTsLVu0OV6ujFIPM3Eh7CbAKRJntumwHg3twbXfcbj2bS/QL85wsE5d1Bt8X3hkBITgdywQEw5vOz2KwZ2Co+ZKnRDNQ5kmBuSJkIPvQbzycWn/MeO0+aumM+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378152; c=relaxed/simple;
	bh=D/V+IqSlBbjEoh2eAiCkzOwphcUgKk86iEhfnyyzCxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taIcAzS6dEWHTN5mf2RGJCxfnPab7Kr3pAt+dJav+eqV9pgTohO75y/CgT22MOp4DQ2GAQX032pWBnDpLmhLvzyQuYsBld9Ol4LSkj63V59dqZHhYCO41Hgivc9Htkb7gG2pDbG543DpakEErofRkUhSidWvzlgar/A+uLPOiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN94w4vnJz4f3lWJ
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3AF911A08FC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S7;
	Tue, 08 Oct 2024 17:02:25 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 03/16] bpf: Parse bpf_dynptr in map key
Date: Tue,  8 Oct 2024 17:14:48 +0800
Message-ID: <20241008091501.8302-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008091501.8302-1-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S7
X-Coremail-Antispam: 1UD129KBjvJXoW3ury3CFWftF4UCF17JFy8AFb_yoWDCryxpF
	4xGrWxCr4ktrW3Wr98Wa98u343tr4kWw1UWF95K34akF4agryDZF18tFyxZr45tFZ8Krn7
	Ar4a9F95A34xAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UH
	nmiUUUUU=
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
like kptrs in map value, the bpf_dynptr in the map key could also be
defined in a nested struct which is contained in the map key struct.

The patch updates map_create() accordingly to parse these bpf_dynptr
fields in map key, just like it does for other special fields in map
value. To enable bpf_dynptr support in map key, the map_type should be
BPF_MAP_TYPE_HASH, and BPF_F_DYNPTR_IN_KEY should also be enabled in
map_flags. For now, the max number of bpf_dynptr in a map key is
arbitrarily chosen as 4 and it may be changed later.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h     | 13 ++++++++++--
 kernel/bpf/btf.c        |  4 ++++
 kernel/bpf/map_in_map.c | 19 ++++++++++++-----
 kernel/bpf/syscall.c    | 47 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f61bf427e14e..3e25e94b7457 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -184,8 +184,8 @@ struct bpf_map_ops {
 };
 
 enum {
-	/* Support at most 11 fields in a BTF type */
-	BTF_FIELDS_MAX	   = 11,
+	/* Support at most 12 fields in a BTF type */
+	BTF_FIELDS_MAX	   = 12,
 };
 
 enum btf_field_type {
@@ -203,6 +203,7 @@ enum btf_field_type {
 	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
 	BPF_REFCOUNT   = (1 << 9),
 	BPF_WORKQUEUE  = (1 << 10),
+	BPF_DYNPTR     = (1 << 11),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -270,6 +271,7 @@ struct bpf_map {
 	u32 map_flags;
 	u32 id;
 	struct btf_record *record;
+	struct btf_record *key_record;
 	int numa_node;
 	u32 btf_key_type_id;
 	u32 btf_value_type_id;
@@ -337,6 +339,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_rb_node";
 	case BPF_REFCOUNT:
 		return "bpf_refcount";
+	case BPF_DYNPTR:
+		return "bpf_dynptr";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -366,6 +370,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return sizeof(struct bpf_refcount);
+	case BPF_DYNPTR:
+		return sizeof(struct bpf_dynptr);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -395,6 +401,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return __alignof__(struct bpf_refcount);
+	case BPF_DYNPTR:
+		return __alignof__(struct bpf_dynptr);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -424,6 +432,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_DYNPTR:
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 321356710924..2604cef53915 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3500,6 +3500,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
 	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
 	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
+	field_mask_test_name(BPF_DYNPTR,    "bpf_dynptr");
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & BPF_KPTR && !__btf_type_is_struct(var_type)) {
@@ -3537,6 +3538,7 @@ static int btf_repeat_fields(struct btf_field_info *info,
 		case BPF_KPTR_PERCPU:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
+		case BPF_DYNPTR:
 			break;
 		default:
 			return -EINVAL;
@@ -3659,6 +3661,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_LIST_NODE:
 	case BPF_RB_NODE:
 	case BPF_REFCOUNT:
+	case BPF_DYNPTR:
 		ret = btf_find_struct(btf, var_type, off, sz, field_type,
 				      info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -4014,6 +4017,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			break;
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
+		case BPF_DYNPTR:
 			break;
 		default:
 			ret = -EFAULT;
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 645bd30bc9a9..a072835dc645 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -9,7 +9,7 @@
 
 struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 {
-	struct bpf_map *inner_map, *inner_map_meta;
+	struct bpf_map *inner_map, *inner_map_meta, *ret;
 	u32 inner_map_meta_size;
 	CLASS(fd, f)(inner_map_ufd);
 
@@ -45,9 +45,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		 * invalid/empty/valid, but ERR_PTR in case of errors. During
 		 * equality NULL or IS_ERR is equivalent.
 		 */
-		struct bpf_map *ret = ERR_CAST(inner_map_meta->record);
-		kfree(inner_map_meta);
-		return ret;
+		ret = ERR_CAST(inner_map_meta->record);
+		goto free;
+	}
+	inner_map_meta->key_record = btf_record_dup(inner_map->key_record);
+	if (IS_ERR(inner_map_meta->key_record)) {
+		ret = ERR_CAST(inner_map_meta->key_record);
+		goto free;
 	}
 	/* Note: We must use the same BTF, as we also used btf_record_dup above
 	 * which relies on BTF being same for both maps, as some members like
@@ -71,6 +75,10 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
 	}
 	return inner_map_meta;
+
+free:
+	bpf_map_meta_free(inner_map_meta);
+	return ret;
 }
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
@@ -88,7 +96,8 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->map_flags == meta1->map_flags &&
-		btf_record_equal(meta0->record, meta1->record);
+		btf_record_equal(meta0->record, meta1->record) &&
+		btf_record_equal(meta0->key_record, meta1->key_record);
 }
 
 void *bpf_map_fd_get_ptr(struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bffd803c5977..aa0a500f8fad 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -561,6 +561,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_DYNPTR:
 			/* Nothing to release */
 			break;
 		default:
@@ -574,7 +575,9 @@ void btf_record_free(struct btf_record *rec)
 void bpf_map_free_record(struct bpf_map *map)
 {
 	btf_record_free(map->record);
+	btf_record_free(map->key_record);
 	map->record = NULL;
+	map->key_record = NULL;
 }
 
 struct btf_record *btf_record_dup(const struct btf_record *rec)
@@ -612,6 +615,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_DYNPTR:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -728,6 +732,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
 			break;
+		case BPF_DYNPTR:
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
@@ -737,6 +743,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 
 static void bpf_map_free(struct bpf_map *map)
 {
+	struct btf_record *key_rec = map->key_record;
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
@@ -751,6 +758,7 @@ static void bpf_map_free(struct bpf_map *map)
 	 * eventually calls bpf_map_free_meta, since inner_map_meta is only a
 	 * template bpf_map struct used during verification.
 	 */
+	btf_record_free(key_rec);
 	btf_record_free(rec);
 	/* Delay freeing of btf for maps, as map_free callback may need
 	 * struct_meta info which will be freed with btf_put().
@@ -1081,6 +1089,8 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
+#define MAX_DYNPTR_CNT_IN_MAP_KEY 4
+
 static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			 const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
 {
@@ -1103,6 +1113,40 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 	if (!value_type || value_size != map->value_size)
 		return -EINVAL;
 
+	if (btf_type_is_dynptr(btf, key_type))
+		map->key_record = btf_new_bpf_dynptr_record();
+	else
+		map->key_record = btf_parse_fields(btf, key_type, BPF_DYNPTR, map->key_size);
+	if (!IS_ERR_OR_NULL(map->key_record)) {
+		if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY) {
+			ret = -E2BIG;
+			goto free_map_tab;
+		}
+		if (!bpf_map_has_dynptr_key(map)) {
+			ret = -EINVAL;
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
+	} else if (bpf_map_has_dynptr_key(map)) {
+		ret = -EINVAL;
+		goto free_map_tab;
+	} else {
+		/* Ensure key_record is either a valid btf_record or NULL */
+		map->key_record = NULL;
+	}
+
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE,
@@ -1230,6 +1274,9 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
 
+	if ((attr->map_flags & BPF_F_DYNPTR_IN_KEY) && !attr->btf_key_type_id)
+		return -EINVAL;
+
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
 	    !(attr->map_flags & BPF_F_DYNPTR_IN_KEY) &&
-- 
2.44.0


