Return-Path: <bpf+bounces-49784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F237A1C2CE
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028B33A6938
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5A1E7C24;
	Sat, 25 Jan 2025 10:59:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA790146A68
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802754; cv=none; b=nE3agtzuWzvjj4FOztvdTr2+V+VMDfbuSaecEaBFjKfCHqXg1mZB++PSexqKJWjDDELhpPlU74e4ndmVaFV04ikkTi9lPQubOaywgpQhGvlUQRKpX/BDAODcopFB5Xc78ob4P4rl+PacpE7eD+3iyQ524CpGX7OZuvnNBFkRnRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802754; c=relaxed/simple;
	bh=tPmlQirGkxTkILVa6EJ5wVWrlcTLSaIsclgY5S2lY8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d01L0SR+GOJeeVbJWrqINKzQMH33ndsLZEDuvdRrnCYC0dM8q9zHk1Hfy05vq+A8+LDb8+ri9HG2HcSfBngmLxY1u7N5BrwVYZWkxlwruBV2pNYwU9mSakrZMW9eCU1PYP+qGfca4CatAmDjtk7Ay1KI2PpaG90aAluclpq5fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBW53gNnz4f3kvm
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 843D61A0B95
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S5;
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
Subject: [PATCH bpf-next v2 01/20] bpf: Add two helpers to facilitate the parsing of bpf_dynptr
Date: Sat, 25 Jan 2025 19:10:50 +0800
Message-Id: <20250125111109.732718-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar18tFyfXrW7trykuw4rXwb_yoW7Ww4kpF
	yDA343Cr48trW3uw1DGws8u3y3t3y8Ww1YyFy7W34akFW2qryDXF4DKr18ZryYkrWakrn3
	ZrnIgFZ8AryxAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r
	1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-_-PUU
	UUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add BPF_DYNPTR in btf_field_type to support bpf_dynptr in map key. The
parsing of bpf_dynptr in btf will be done in the following patch, and
the patch only adds two helpers: btf_new_bpf_dynptr_record() creates an
btf record which only includes a bpf_dynptr and btf_type_is_dynptr()
checks whether the btf_type is a bpf_dynptr or not.

With the introduction of BPF_DYNPTR, BTF_FIELDS_MAX is changed from 11
to 13, therefore, update the hard-coded number in cpumask test as well.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h                           |  5 ++-
 include/linux/btf.h                           |  2 +
 kernel/bpf/btf.c                              | 42 ++++++++++++++++---
 .../selftests/bpf/progs/cpumask_common.h      |  2 +-
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index feda0ce90f5a3..0ee14ae30100f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -184,8 +184,8 @@ struct bpf_map_ops {
 };
 
 enum {
-	/* Support at most 11 fields in a BTF type */
-	BTF_FIELDS_MAX	   = 11,
+	/* Support at most 13 fields in a BTF type */
+	BTF_FIELDS_MAX	   = 13,
 };
 
 enum btf_field_type {
@@ -204,6 +204,7 @@ enum btf_field_type {
 	BPF_REFCOUNT   = (1 << 9),
 	BPF_WORKQUEUE  = (1 << 10),
 	BPF_UPTR       = (1 << 11),
+	BPF_DYNPTR     = (1 << 12),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2a08a2b55592e..ee1488494c73d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -223,8 +223,10 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size);
+struct btf_record *btf_new_bpf_dynptr_record(void);
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
+bool btf_type_is_dynptr(const struct btf *btf, const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8396ce1d0fba3..b316631b614fa 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3925,6 +3925,16 @@ static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
 	return 0;
 }
 
+static void btf_init_record(struct btf_record *record)
+{
+	record->cnt = 0;
+	record->field_mask = 0;
+	record->spin_lock_off = -EINVAL;
+	record->timer_off = -EINVAL;
+	record->wq_off = -EINVAL;
+	record->refcount_off = -EINVAL;
+}
+
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
@@ -3943,14 +3953,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	/* This needs to be kzalloc to zero out padding and unused fields, see
 	 * comment in btf_record_equal.
 	 */
-	rec = kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
+	rec = kzalloc(struct_size(rec, fields, cnt), GFP_KERNEL | __GFP_NOWARN);
 	if (!rec)
 		return ERR_PTR(-ENOMEM);
 
-	rec->spin_lock_off = -EINVAL;
-	rec->timer_off = -EINVAL;
-	rec->wq_off = -EINVAL;
-	rec->refcount_off = -EINVAL;
+	btf_init_record(rec);
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -4041,6 +4048,25 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
 
+struct btf_record *btf_new_bpf_dynptr_record(void)
+{
+	struct btf_record *record;
+
+	record = kzalloc(struct_size(record, fields, 1), GFP_KERNEL | __GFP_NOWARN);
+	if (!record)
+		return ERR_PTR(-ENOMEM);
+
+	btf_init_record(record);
+
+	record->cnt = 1;
+	record->field_mask = BPF_DYNPTR;
+	record->fields[0].offset = 0;
+	record->fields[0].size = sizeof(struct bpf_dynptr);
+	record->fields[0].type = BPF_DYNPTR;
+
+	return record;
+}
+
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 {
 	int i;
@@ -7439,6 +7465,12 @@ static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 	return false;
 }
 
+bool btf_type_is_dynptr(const struct btf *btf, const struct btf_type *t)
+{
+	return __btf_type_is_struct(t) && t->size == sizeof(struct bpf_dynptr) &&
+	       !strcmp(__btf_name_by_offset(btf, t->name_off), "bpf_dynptr");
+}
+
 struct bpf_cand_cache {
 	const char *name;
 	u32 name_len;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 4ece7873ba609..afbf2e99b1bb8 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -10,7 +10,7 @@
 /* Should use BTF_FIELDS_MAX, but it is not always available in vmlinux.h,
  * so use the hard-coded number as a workaround.
  */
-#define CPUMASK_KPTR_FIELDS_MAX 11
+#define CPUMASK_KPTR_FIELDS_MAX 13
 
 int err;
 
-- 
2.29.2


