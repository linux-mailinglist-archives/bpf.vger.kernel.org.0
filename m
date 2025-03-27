Return-Path: <bpf+bounces-54784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA31A72B51
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA08C189781F
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC6204F8A;
	Thu, 27 Mar 2025 08:22:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE59204F72
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063778; cv=none; b=my3R7yTs6yvWgh9a070e7az9QFBMP3jRpTspDYN44E0ttW4TfWJnVrt2P2f45aKsQyZADan7yF6y7S2o0KL3SBndMXFIYd2mFnzQoYtvQ6nhsUR2Kg1Wb83U47n+daL3oFlrxn7rOupGcq7cdwgA0L0iStMZBxq54VVUqHMaGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063778; c=relaxed/simple;
	bh=6s1072Of2TkmZoucRpkDlaD00oTMM5x2AZTzoApXicU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjY19P6LyKMvJa2XH2zW5n4i0Zqmos1ix/OjfK3hGg+Qdb2O0wJUMHl9gTHjtlcmEsWRPzMKH0lBz9dPfJieBchwjVSwUpsIEWkAq2OTrpLsY02Yv+FD63x4t0cjX8z7fPflo1WgYTri3l51+3L0uz80CiMjhz6uEQ8ue0WgLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8g2dxgz4f3m7L
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C8C461A1511
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S5;
	Thu, 27 Mar 2025 16:22:51 +0800 (CST)
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
Subject: [PATCH bpf-next v3 01/16] bpf: Introduce BPF_DYNPTR and helpers to facilitate its parsing
Date: Thu, 27 Mar 2025 16:34:40 +0800
Message-Id: <20250327083455.848708-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4fJw1DCrWDZF43CrykKrg_yoWrur13pF
	nrAr13Cr48trW3uw1DGrs8u3y3tay8Gw12vFy7K34akFZ2qryDXFs8Kr18ZryYkrZ0kr1x
	Zr1YgFZ8Ary7AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add BPF_DYNPTR in btf_field_type to support bpf_dynptr in map key. The
parsing of bpf_dynptr in btf will be done in the following patch, and
the patch only adds two helpers: btf_new_bpf_dynptr_record() creates an
btf record which only includes a bpf_dynptr and btf_type_is_dynptr()
checks whether the btf_type is a bpf_dynptr or not.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h |  1 +
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 44 ++++++++++++++++++++++++++++++++++++++------
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2083905a4e9fa..0b65c98d8b7d5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -206,6 +206,7 @@ enum btf_field_type {
 	BPF_WORKQUEUE  = (1 << 10),
 	BPF_UPTR       = (1 << 11),
 	BPF_RES_SPIN_LOCK = (1 << 12),
+	BPF_DYNPTR     = (1 << 13),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b9446..2ab48b377d312 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -226,8 +226,10 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
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
index 16ba36f34dfab..1054a1e27e9d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3939,6 +3939,17 @@ static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
 	return 0;
 }
 
+static void btf_init_record(struct btf_record *record)
+{
+	record->cnt = 0;
+	record->field_mask = 0;
+	record->spin_lock_off = -EINVAL;
+	record->res_spin_lock_off = -EINVAL;
+	record->timer_off = -EINVAL;
+	record->wq_off = -EINVAL;
+	record->refcount_off = -EINVAL;
+}
+
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
@@ -3957,15 +3968,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	/* This needs to be kzalloc to zero out padding and unused fields, see
 	 * comment in btf_record_equal.
 	 */
-	rec = kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
+	rec = kzalloc(struct_size(rec, fields, cnt), GFP_KERNEL | __GFP_NOWARN);
 	if (!rec)
 		return ERR_PTR(-ENOMEM);
 
-	rec->spin_lock_off = -EINVAL;
-	rec->res_spin_lock_off = -EINVAL;
-	rec->timer_off = -EINVAL;
-	rec->wq_off = -EINVAL;
-	rec->refcount_off = -EINVAL;
+	btf_init_record(rec);
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -4067,6 +4074,25 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
@@ -7562,6 +7588,12 @@ static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
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
-- 
2.29.2


