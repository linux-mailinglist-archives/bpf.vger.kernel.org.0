Return-Path: <bpf+bounces-30416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1048CD943
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B101C20E9D
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E237F496;
	Thu, 23 May 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MroN+ott"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82D7E59A
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486136; cv=none; b=bCTTidPOr80G3lRTA9+ptTFtey93u3NrQkBBMMkvXVuLBywo1Cd+4zU6FSUxhBEB5q9GzeTtfaYoKbQak1/zWTHTmjhxVbuZ9BNiEeNXgJPfIYkil0IlW/wIUUTFlbO+pU7lOvxib1tyqDjtHMX1oPWrjZmX21SLE5suhWZG2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486136; c=relaxed/simple;
	bh=f04j8SdsNpNXGMvRaqa/0k9JqXQZUvTALaVd1buz13E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfkxYvlStrUqnMmOG+24ScEiHNXuEwD/5GgHqJ5EU0uMXDvRwNP9G7Al47D6oH+VmT4R2e1uVAEbwJ2RvCpXqWJnMw8vR8pLo95uXat7SRH6A+ZeDmi/p/+IRdB6JMExQt1xZSny3ubN3hdd3dHpNVpN5LenU4Bjp8upTFu8AsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MroN+ott; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-627efad69b4so19023877b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486134; x=1717090934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zxGdAc8OkC+Ohn5y0sNY+gVO/Nxy7mPn5wFOc9WrDY=;
        b=MroN+otttNOwkCg2NqQ93OAFbg91TzH+6gBv/+rf/4hkaYjbXMNFNcNY3Xe5nBNcNQ
         QrFG7+/3DILz1ng3NvyPRDo1ht3nRy6xWfvmrSplNMN96Lu4gxmmQga/QbChT+IOCxO+
         AAsnZIG1sYd4xTopAjRKAAStnuvg60vovs3npFd7mGvMZYfi1z9ERLxtDVCD3sOguv+N
         zUDTafjg4yj3KZiDdVihNAzKeC/gn5Y9YvdXIuBsW+Wx0WB7egjFGKxO6r6RqzEpoTQx
         wokwGudkhK8oW95YRPiViPIc+jdaB4mE+YyXVD6v+8FpdjKvvcJCnpACRrhxG4N3NKqF
         4VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486134; x=1717090934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zxGdAc8OkC+Ohn5y0sNY+gVO/Nxy7mPn5wFOc9WrDY=;
        b=TvdMPZzm7CPl7FgECsnJZlrBRxOHpD1vjiAWYjIWjTpOJq0axglDfr4ARvuHVp2xT6
         rEUMb7pMBbMt39f4fSRacLtPfSq//OybSQnD4fJ+nEob4mIQDtnS2Vocp3WTtMWi9YT7
         hKKvM5AUwZZaZ17QoHgwXXv5Hp5qk1Kzu801E4tK8WC25zBKqDcLOXeFGv5gjLZdnLe+
         H3EeHmyKgCNiwBd9D3lJMfgkUM+MR8vkpoVSzgGK3FtVOR4E5whQQbPSoRpBrKNK2bsT
         tqS2v1B549fl9SuFcK6atVzdaAgZ3cOakF6wnu61TauK05YA2V/XuuKPQdUmMzHoaa9T
         kG5g==
X-Gm-Message-State: AOJu0YxCnA85uO3WffvkPW1fZdpTCBmhEhlSGHNA8UKPsZnBGfRN8BMH
	rrV5KXi++jVh9n1SRP7JpCVlgVKDqMMVfuCyhIjZKwgBewT9mCM/93ePlw==
X-Google-Smtp-Source: AGHT+IGBpVGAaXUX+yEpSk1LnJ+tQC9AT0ZvFHh/yGh7QQ16fr0MvvKN2i4wGJWDEfWqgJmWnx0jgw==
X-Received: by 2002:a81:b64e:0:b0:627:ecd3:6223 with SMTP id 00721157ae682-627ecd364femr52227827b3.35.1716486133799;
        Thu, 23 May 2024 10:42:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:13 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 5/9] bpf: look into the types of the fields of a struct type recursively.
Date: Thu, 23 May 2024 10:41:58 -0700
Message-Id: <20240523174202.461236-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523174202.461236-1-thinker.li@gmail.com>
References: <20240523174202.461236-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier has field information for specific special types, such as
kptr, rbtree root, and list head. These types are handled
differently. However, we did not previously examine the types of fields of
a struct type variable. Field information records were not generated for
the kptrs, rbtree roots, and linked_list heads that are not located at the
outermost struct type of a variable.

For example,

  struct A {
    struct task_struct __kptr * task;
  };

  struct B {
    struct A mem_a;
  }

  struct B var_b;

It did not examine "struct A" so as not to generate field information for
the kptr in "struct A" for "var_b".

This patch enables BPF programs to define fields of these special types in
a struct type other than the direct type of a variable or in a struct type
that is the type of a field in the value type of a map.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 100 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4fefa27d5aea..5e2b231a9af4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3442,10 +3442,12 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 		goto end;						\
 	}
 
-static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
+static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_type,
+			      u32 field_mask, u32 *seen_mask,
 			      int *align, int *sz)
 {
 	int type = 0;
+	const char *name = __btf_name_by_offset(btf, var_type->name_off);
 
 	if (field_mask & BPF_SPIN_LOCK) {
 		if (!strcmp(name, "bpf_spin_lock")) {
@@ -3481,7 +3483,7 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
-	if (field_mask & BPF_KPTR) {
+	if (field_mask & BPF_KPTR && !__btf_type_is_struct(var_type)) {
 		type = BPF_KPTR_REF;
 		goto end;
 	}
@@ -3494,41 +3496,83 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 
 #undef field_mask_test_name
 
-/* Repeat a field for a specified number of times.
+/* Repeat a number of fields for a specified number of times.
  *
- * Copy and repeat the first field for repeat_cnt
- * times. The field is repeated by adding the offset of each field
- * with
+ * Copy the fields starting from the first field and repeat them for
+ * repeat_cnt times. The fields are repeated by adding the offset of each
+ * field with
  *   (i + 1) * elem_size
  * where i is the repeat index and elem_size is the size of an element.
  */
-static int btf_repeat_field(struct btf_field_info *info,
-			    u32 repeat_cnt, u32 elem_size)
+static int btf_repeat_fields(struct btf_field_info *info,
+			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
 {
-	u32 i;
+	u32 i, j;
 	u32 cur;
 
 	/* Ensure not repeating fields that should not be repeated. */
-	switch (info[0].type) {
-	case BPF_KPTR_UNREF:
-	case BPF_KPTR_REF:
-	case BPF_KPTR_PERCPU:
-	case BPF_LIST_HEAD:
-	case BPF_RB_ROOT:
-		break;
-	default:
-		return -EINVAL;
+	for (i = 0; i < field_cnt; i++) {
+		switch (info[i].type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
+		case BPF_LIST_HEAD:
+		case BPF_RB_ROOT:
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
-	cur = 1;
+	cur = field_cnt;
 	for (i = 0; i < repeat_cnt; i++) {
-		memcpy(&info[cur], &info[0], sizeof(info[0]));
-		info[cur++].off += (i + 1) * elem_size;
+		memcpy(&info[cur], &info[0], field_cnt * sizeof(info[0]));
+		for (j = 0; j < field_cnt; j++)
+			info[cur++].off += (i + 1) * elem_size;
 	}
 
 	return 0;
 }
 
+static int btf_find_struct_field(const struct btf *btf,
+				 const struct btf_type *t, u32 field_mask,
+				 struct btf_field_info *info, int info_cnt);
+
+/* Find special fields in the struct type of a field.
+ *
+ * This function is used to find fields of special types that is not a
+ * global variable or a direct field of a struct type. It also handles the
+ * repetition if it is the element type of an array.
+ */
+static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *t,
+				  u32 off, u32 nelems,
+				  u32 field_mask, struct btf_field_info *info,
+				  int info_cnt)
+{
+	int ret, err, i;
+
+	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt);
+
+	if (ret <= 0)
+		return ret;
+
+	/* Shift the offsets of the nested struct fields to the offsets
+	 * related to the container.
+	 */
+	for (i = 0; i < ret; i++)
+		info[i].off += off;
+
+	if (nelems > 1) {
+		err = btf_repeat_fields(info, ret, nelems - 1, t->size);
+		if (err == 0)
+			ret *= nelems;
+		else
+			ret = err;
+	}
+
+	return ret;
+}
+
 static int btf_find_field_one(const struct btf *btf,
 			      const struct btf_type *var,
 			      const struct btf_type *var_type,
@@ -3555,8 +3599,18 @@ static int btf_find_field_one(const struct btf *btf,
 	if (nelems == 0)
 		return 0;
 
-	field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
+	field_type = btf_get_field_type(btf, var_type,
 					field_mask, seen_mask, &align, &sz);
+	/* Look into variables of struct types */
+	if (!field_type && __btf_type_is_struct(var_type)) {
+		sz = var_type->size;
+		if (expected_size && expected_size != sz * nelems)
+			return 0;
+		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
+					     &info[0], info_cnt);
+		return ret;
+	}
+
 	if (field_type == 0)
 		return 0;
 	if (field_type < 0)
@@ -3605,7 +3659,7 @@ static int btf_find_field_one(const struct btf *btf,
 	if (nelems > info_cnt)
 		return -E2BIG;
 	if (nelems > 1) {
-		ret = btf_repeat_field(info, nelems - 1, sz);
+		ret = btf_repeat_fields(info, 1, nelems - 1, sz);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.34.1


