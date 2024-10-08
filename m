Return-Path: <bpf+bounces-41200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857B994388
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772E31C24942
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD94178CF6;
	Tue,  8 Oct 2024 09:02:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC08144D21
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378151; cv=none; b=AkPAUG5+lJA81zWqFibq1Ji2wUTbwPoNAuctXA4lfvKRDi+JBxSdoQFvoC9z8IbkNGxuI5QT0hE5r70kbbze0btpjsrAf696VfP1kskO3zpY2wv83DDJCqvso/LsQ2MYOrlYkFsAnUnpw1wpQeH0PUxjpLdeZA1rVn7mrgxpAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378151; c=relaxed/simple;
	bh=Eyl2QH+w8IQPcln9wLqXUg7kD/RvCqzDpufkcvXlsV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3OiDcjvq1/cWdr22PHWII8POdswJaLhtioHTaNWJ6cToWztYTyWhWkGlXDE/wmHlNEO7VZr69e/KD+5DUlwUZKgRPaiXMM9Kn6+nXF3W4yoI2/cmIRmrAO2VvKZjNYZQt8OPgtnauLmi56L8k4uinV0JV43c7JSS8xnXS7as04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XN94w60dCz4f3jY8
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A0F181A08FC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S6;
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
Subject: [PATCH bpf-next 02/16] bpf: Add two helpers to facilitate the btf parsing of bpf_dynptr
Date: Tue,  8 Oct 2024 17:14:47 +0800
Message-ID: <20241008091501.8302-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UZry5Xw17XryUAF43KFg_yoWrXFy3pF
	nrAry3Cr48tFWfuw1DGan8C3y3tay8Ww12vFy7G343KFWIqryDZF4UKr18uryYkrWYkr1x
	Zr1aga98Ary7AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUob18
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add helper btf_type_is_dynptr() to check whether or not the btf_type is
a bpf_dynptr, and add helper btf_new_bpf_dynptr_record() to create an
btf record which only includes a bpf_dynptr. These two helpers will be
used when using bpf_dynptr as the map key directly.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 42 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index b8a583194c4a..ed89b83e8c19 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -222,8 +222,10 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
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
index 5254fc9c1b24..321356710924 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3923,6 +3923,16 @@ static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
 	return 0;
 }
 
+static void btf_init_btf_record(struct btf_record *record)
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
@@ -3941,14 +3951,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
+	btf_init_btf_record(rec);
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -4038,6 +4045,25 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
+	btf_init_btf_record(record);
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
@@ -7276,6 +7302,12 @@ static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
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
2.44.0


