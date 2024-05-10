Return-Path: <bpf+bounces-29424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0758C1BEC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CA82843E2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4013AA42;
	Fri, 10 May 2024 01:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF6n0HGK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19813AA2E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303602; cv=none; b=m0T/eo0i3LnhYGCCYPli3iWq7MNARmfoXkZ9CZEQg1PaJDadvg1howHJWbkcNCBxiOnPGJOCzol5NdkjEZY1LUUAST3196pprQRKqojJaJRKROPNF2MngGUJC3Fi0YXQAcQyee+4PxHrP5wuMCqM6cUNrEkdjyGIY0//rJMHSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303602; c=relaxed/simple;
	bh=WIIY6y7bxxaCZ5svhHpHgrLd2cPGOQG9EuH0faAVJAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFm+VIJcNdVITFCmhoZOfspF7GbiqzUzmeR5OmqDrqXdr1tcoCezlQDgH9qBM0EHyhJVF6Lwmew7U6H6aj++5/PEmE+7CqdCp1glzNZFnaNYTHh/mRzA9J1u+nbKgDTkQJJ8umH56cVLJOVC+Uk8VKcyStiXgz0QERshx9U3dLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF6n0HGK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f06b81676aso869240a34.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303600; x=1715908400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMjWdOewIK+UMq8dNEpTV+Ou7wl/z63UxnzhJFnwDoY=;
        b=NF6n0HGKDhGrOICjPG1O1W/YQgRtnYYobgJeyK58/gnyNzc4PGuQ+pgIWzAK7akXWC
         brOWn5haoLzTScnv36ty+snglst5AntcI+O81GO1WPSsPWRR3Y8tosMc9lzaqKECt830
         ftAG9VeiNbFFC+IZjt7CrdWdL5DbC0+dDu2U3jcYSvMmZSsjjzvApZ8NVymQhLwxDor5
         j5/x9Zi13+itj2pFw5F9eNVXvGcV1Db1+Up9K96rEUgSYK+bLtJefKbSlkGDsGaRt1Kc
         v56oGOpp628VSFAd0Xo0I5EsQi+8FROKV28+6mg9IJWPzw7mW8U7Y/yRoo4Vjrl97+iz
         V24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303600; x=1715908400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMjWdOewIK+UMq8dNEpTV+Ou7wl/z63UxnzhJFnwDoY=;
        b=juUWySnyeWrMFEzR/Wb97pXIQg7QfM9CBxiSBEiGBCmX5e5VChFRjK62FTQiDfCf5R
         NIYzbZD06W/U8eTR98kFt1sWEIhuPtHq3pn3zYa+Bk3uFI+eFOTh2V8a3O1FwzOs+ghJ
         GrSvVcapB1W2yfSEkC8DyNgeSwlF1zHyOBognN3S6WceSBHTPYIifTw9GCUexdySi6IA
         xH6rsJQHtl0ItB/piZ+5UgvXwCdWSIRWPX389qooi+N1fyTKkC3hpAtwmwFPnZY7acx8
         QZh4GwRC171UJUDdKucIgDsLo3RyyTNSIv5Kgq98H+plxqwEPgN+uHII4s9Iy5IQe19u
         1M5Q==
X-Gm-Message-State: AOJu0YxbdAJYQaMdADnvnEx9izqcgj9wdWcLn2blAQyof/bH2DXX5XjB
	r3NFiqOzeMSQ0TITH0v3WXWT7TOwltxw/nUupLmz3l5ElniK8MVeySclNg==
X-Google-Smtp-Source: AGHT+IF0yg06fH2L3PTwWl3peOf7rdNz0wlfQO9YneJuHN0m3JOTPzMaiYk0oIGAlUjhhZ8bTuKKTw==
X-Received: by 2002:a05:6830:1e61:b0:6f0:44d9:6a80 with SMTP id 46e09a7af769-6f0e92e9f02mr1388655a34.32.1715303600137;
        Thu, 09 May 2024 18:13:20 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 5/9] bpf: look into the types of the fields of a struct type recursively.
Date: Thu,  9 May 2024 18:13:08 -0700
Message-Id: <20240510011312.1488046-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
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


