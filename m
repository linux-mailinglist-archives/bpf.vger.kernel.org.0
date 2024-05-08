Return-Path: <bpf+bounces-29023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA48BF649
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B0AB21BD9
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7441015E88;
	Wed,  8 May 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf8enLOj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8467D1DA53
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149952; cv=none; b=bR4h7fcKq6mBzjdYuJTamHY+6GvFyvK/IROlxUaI4FioZXOIo83JYtK6b5Fe7Kxb8rFw6Kj4aKUfOnclKPW7SS2UAbsvvCTrcnOViF2a70oUAivsJEVA0dePks3AjS65Yv+a0gBGWzBH02HIB7AglDg0VqDvQuKN1/ZNZXlusfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149952; c=relaxed/simple;
	bh=IukWxncW71pOWKuXy6XwK0xo/mkiKGE5IHNqY5ILuKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=em/0j+F5Pemzeqdffqjdi+YcT/wFBLsW2V2wNorWHL2xG50e4NgnVd3jFQyJY2WRDo+iuJ4fTfV7CHi9jzVBJ4pBJFvlp7oMCWC+jaCBhSbyCdl54LBIDFS16uxsj+bmnb2xmgPFR5OSteHUErw42lQj8qbSStCsPslVe0uQ6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf8enLOj; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c96d8bff27so228609b6e.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149949; x=1715754749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMHj8IuUdPM0tOmYXvWLbeITQEfrgALpkMswxvMZiwc=;
        b=Xf8enLOjH4a/2pihQTJDP4fe2YryexPIJSQXB9+tyI4vAeDAOOKoJHHrCroagwgvy9
         g0NO9SMRp1xHaYVeh3DPTizOnU7e7xS172P4N22XfS8diFZchK3B8v++PulHddUnoxfn
         Cz2stn2NP5CApblupccQcLyfrihIz67kJrSHO+2z1x3StFfbLFwP4vgJ00LIAPcdgkgn
         pLOAHufsorgOY/+p7tYpgoslgzmfU9JvyP//qw8YyKqtC4dsHcgwlyxM6vqz+jRn/CWy
         vH0OMwNMz3kz5XeTJCxRqbsAEOSrzTQndVNzrShjOuLG2FPehovOg4njuLYMLhuLmazE
         7C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149949; x=1715754749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMHj8IuUdPM0tOmYXvWLbeITQEfrgALpkMswxvMZiwc=;
        b=b9T6Q4wbSleXDR0eOaVMxdjxza2RIFhOgCFapy85NXbmuEYlfIn/uy4lHbGqzlwhaH
         IkxoZ/5RXwCz3JDgUf4+EpXmPJZ+lLhLLP4wXOIOfjw5IpP1LvPzvKCue7m8OEJep41m
         AbDv8Woe49dlqv0Dt3lxm/22xj+45nST+iqHm8dZE+61mNUbW2fEKUwFcXHxQYXhD8uj
         7Z/nLgfWoROpyc+2F6xkvcktP6KV9qNK+5H18eGYuHyIWIvHg3setwr89sFZb/fXBFRq
         W/fBKzOpiO7S6Ba+dOBFFfF+7oz2eMIzKdnHuC7yjcPMlj/Dx7UCTkJMaFqL9tQVBG0n
         RS0w==
X-Gm-Message-State: AOJu0YzKxU66hjlm0KeEVBOTCx7hql1Ja5cm8wycpGEpqncDcMkoZRbE
	ofZFF+axtZ0zKBUrO5FY+sHMHSNgQR+/rJdPyYJDhusMaSWy4QW6kozM2A==
X-Google-Smtp-Source: AGHT+IFF+nh9MHmVqxyX6v9J1xkNli6ZnPfROimbxUVoPTmtVObywp/5f2EYYDx/mISGYvsCS8sRhA==
X-Received: by 2002:a05:6808:2988:b0:3c9:691b:dcee with SMTP id 5614622812f47-3c984b6a9aamr808328b6e.7.1715149949105;
        Tue, 07 May 2024 23:32:29 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:28 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 5/9] bpf: look into the types of the fields of a struct type recursively.
Date: Tue,  7 May 2024 23:32:14 -0700
Message-Id: <20240508063218.2806447-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508063218.2806447-1-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
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
index 633c3e037cef..bbda24299be2 100644
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
@@ -3555,6 +3597,17 @@ static int btf_find_field_one(const struct btf *btf,
 
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
@@ -3603,7 +3656,7 @@ static int btf_find_field_one(const struct btf *btf,
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


