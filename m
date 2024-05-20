Return-Path: <bpf+bounces-30047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243998CA36E
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478241C21216
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B813A243;
	Mon, 20 May 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKaxFnVg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE67139D13
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237631; cv=none; b=T5fb+Z0FGWcNmsem56Ky4nhOUpffjQ5wrPYrZWQNSdp1MBmcFiN4o9ZLBm05WGbRMruLmbeR4ZoPKGM1vYQZ4cgittfK+TnCuM3V5bni4Zihu9RWhndq8ZUXUMnGBU7FcYLM+LaVWuVyW+riXyZMX0mJwsRyoIwE4eGFva4MypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237631; c=relaxed/simple;
	bh=WIIY6y7bxxaCZ5svhHpHgrLd2cPGOQG9EuH0faAVJAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1gMv7dr5529oogRtyjShkOf/fV0oRqz+1TNwdr8dDpx3YKGa/vrLudmw9H15o7u2fjxKttLVTlSQAoCXGfHDoJNa2TdWlua+73tO0JSN5k4Tx307uvBOT1ORJNSQ3+uICspO1tc+nFoPIgjOg2tzZFBKdTzcNeCK5ilOQJEEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKaxFnVg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61816fc256dso29575847b3.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237628; x=1716842428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMjWdOewIK+UMq8dNEpTV+Ou7wl/z63UxnzhJFnwDoY=;
        b=IKaxFnVgRLWpyoBh1zxRUJMf1NSk5Xs/wWnpRY3HziVgFr6mqfrIXNhdp+eh3YI8sS
         XfTRarXGfvHJaUF4AwayUFNrKtdQ2X0AeHrBern6bDEBVPHD0md4LBEnKNrP1duH3zKP
         ASBTUuERr0cVenEfakmaRVQFR6WUrsTYJkj+Z8MfKRJbynFSa/fUIakJCbFNxPtpadrg
         e8YwEBUVj6umRL4d43V1ZK1s+FFglpYcRyT9bc3Lkj1qv4rZtnliFQPf/1U4IMMP5rx6
         UtI+bDJVbx+70D/5WzJBZG5rJ8sdgWMumMMPMBYJUCQid9uDPge7OFH5Wi0ZwGqsU7x1
         8qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237628; x=1716842428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMjWdOewIK+UMq8dNEpTV+Ou7wl/z63UxnzhJFnwDoY=;
        b=m2cOQbPOCFR4f4adCV44RWvx4mYihI68jDKHbSOGwQ9Y1ZuB7xzIkh3AL52oWSmm8l
         8kzTU4xACJmr5oR2AujSg2t84UrbQwFHR+xJuTWdTC13C5DOiv4jWk5lSNA9Sz0aHmKI
         ROGlu6mPJp7M4NFakTo75CBr6y+uz4k8jv4w2Gwb3mwRmJdGpSazjR2XDQl542Mj1+5A
         Ygz6XgMEv9dbPf+ZAS8xjFHG5GJMZvi3aqD6rqLk5IgTCw/FV9mZ2mdjU0edtnI/acXA
         jJ3sibe661+HJvlkEPb3IFAJD/6LeK1CRLJgrtDlhH/LoLXWj5wEqILop/9KmghCEX5n
         k/2g==
X-Gm-Message-State: AOJu0YxZI8HtwDW4ZJo0rwQry5fYmn7C8xO8jAVyrfkf0gt4trARh2tO
	7Bgk0x8/2T3f+ozIPZg9bXw1rW51biDNVcSvWaWIFM/3qVhdoQnCzPHDrA==
X-Google-Smtp-Source: AGHT+IHn4ydVAtbOtdnyaqZNNK8lm1IntAgfdHxixqMSVLOoexsRAGcAE/VcF5zLPBpW27uNqY9AtQ==
X-Received: by 2002:a05:690c:6109:b0:61a:e5c9:9fc1 with SMTP id 00721157ae682-622affc747cmr320314397b3.1.1716237627998;
        Mon, 20 May 2024 13:40:27 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 5/9] bpf: look into the types of the fields of a struct type recursively.
Date: Mon, 20 May 2024 13:40:14 -0700
Message-Id: <20240520204018.884515-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520204018.884515-1-thinker.li@gmail.com>
References: <20240520204018.884515-1-thinker.li@gmail.com>
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

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 93 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4fefa27d5aea..e78e2e41467d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3494,41 +3494,83 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 
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
@@ -3557,6 +3599,17 @@ static int btf_find_field_one(const struct btf *btf,
 
 	field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
 					field_mask, seen_mask, &align, &sz);
+	/* Look into variables of struct types */
+	if ((field_type == BPF_KPTR_REF || !field_type) &&
+	    __btf_type_is_struct(var_type)) {
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
@@ -3605,7 +3658,7 @@ static int btf_find_field_one(const struct btf *btf,
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


