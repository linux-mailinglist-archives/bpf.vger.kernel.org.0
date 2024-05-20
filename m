Return-Path: <bpf+bounces-30046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB28CA36D
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647E3281C98
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4211139D1D;
	Mon, 20 May 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKlOcvJp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09294139CF6
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237629; cv=none; b=HUxx0rYL/hvorB2SPEdY34NZq5pGWxyPbboW81v9TfivZHFSkMOfeFi4AyX6Nc07zmkmZWv97SFNVfia0Ar1zw16lhx08RNa798tYUvnEh0GezbF9g2fvcLxYAXUmxNduPaayyf1mb9jiAWlTrYLW5HqHkJGEXXNR4qy/1TY/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237629; c=relaxed/simple;
	bh=beUO5MCH98hk7B1W+3WxHbLxcpbk5N8JhsxgQEHPOpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oYETVRHMZBYqBDcKHgi6RRx13G1yzKNTnqK2zuVVwiEf71WzdsVaBsGO0dlSg2Eb8y2hblLnxtnDE3VGTRHqrkqe7tVJhFnOFFTlkmCVML1jgvwn+uXbMZ5gKFcd935bGxy/mcNMpkrwA9oinpjqnvBauDebs5rvnHm9JZGd6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKlOcvJp; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61804067da0so28365497b3.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237627; x=1716842427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EScPTFIUsU9lafWPj5+nn2qz08FusFYqcC6FL2ky40Q=;
        b=SKlOcvJpehxBS1jSMKLMpCIrS+HPtDF+NA2Q9As1lmIowftQQNY0Hvk8GsAgygi/fA
         mM7obL3R6wpKLacVKfWFstSc0dzJcM3llkx7XO1g0axcJ6MMspxI1cbpEUbacIDfLurX
         F/Z05JU6Uy7aInKdgv6x/wG1TDRAiMg4XBa/zz6ypjV96tCnDL+SC+OYPiV2wv+Zku6n
         +m97IW0IC+TsGt4ucY0eBfq2ARafleeKjiVY0hxrek7GkDj4+XYPtJkupKHia7Ld05/M
         pjNariJ2s9kekag9UdUAjLRNaN94ePQVh67i/3WXAxTH+zNyTNe/fpbZB7r2b/xTc7LS
         3ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237627; x=1716842427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EScPTFIUsU9lafWPj5+nn2qz08FusFYqcC6FL2ky40Q=;
        b=U4Aj0cO65J2GsENZ0WForVwROc+rW8mPzao2OiegikGzaGWq0sIYpmthZ8qlGqmKZ/
         qT40w7oATku2Wt5SbFinTZzM3Prp+F1qg4e2S3Wy8WbrasRcZPSL28kvYfY0S1o3tExI
         8hLYDnvuEpjrUZXgv6hIQVNIr+U+2pATCgsGDQTY0MfxzloLVFgfh65K6HqViuJCKXWp
         NOlWm3bhvQhZzW57kONf8yIcW0nmAs+GPgYZ90bcWr0V9k8kzplJnYn/qjDptUPaR/sP
         BTcZWspW1Fmef37D1CLHEMpkEvOHQ3A4NkGVsXfbgzdVgtDPMF0zwPXgR5ik6rmLA5zG
         ajIw==
X-Gm-Message-State: AOJu0Yx9SOlPf4uJZi8dKWMJi9n8jqVkfd60t/vw3KZsC7uK0BNAhU0V
	tqcph+Nv4nV9aO6O8SjtX8+5E1q3ozS/285u58ioMMY0eD14t6pSGG3BIA==
X-Google-Smtp-Source: AGHT+IGzYtgMolj3fUhtd/IYGfsJK+QG/yxIWiegtbzEP7sE1ccEuDVJ8olZPgaagrVU7qj1kd5koQ==
X-Received: by 2002:a81:91cb:0:b0:61b:3346:eb60 with SMTP id 00721157ae682-622aff9a7b4mr277295757b3.22.1716237626885;
        Mon, 20 May 2024 13:40:26 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 4/9] bpf: create repeated fields for arrays.
Date: Mon, 20 May 2024 13:40:13 -0700
Message-Id: <20240520204018.884515-5-thinker.li@gmail.com>
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

The verifier uses field information for certain special types, such as
kptr, rbtree root, and list head. These types are treated
differently. However, we did not previously support these types in
arrays. This update examines arrays and duplicates field information the
same number of times as the length of the array if the element type is one
of the special types.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2ce61c3a7e28..4fefa27d5aea 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3494,6 +3494,41 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 
 #undef field_mask_test_name
 
+/* Repeat a field for a specified number of times.
+ *
+ * Copy and repeat the first field for repeat_cnt
+ * times. The field is repeated by adding the offset of each field
+ * with
+ *   (i + 1) * elem_size
+ * where i is the repeat index and elem_size is the size of an element.
+ */
+static int btf_repeat_field(struct btf_field_info *info,
+			    u32 repeat_cnt, u32 elem_size)
+{
+	u32 i;
+	u32 cur;
+
+	/* Ensure not repeating fields that should not be repeated. */
+	switch (info[0].type) {
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+	case BPF_KPTR_PERCPU:
+	case BPF_LIST_HEAD:
+	case BPF_RB_ROOT:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cur = 1;
+	for (i = 0; i < repeat_cnt; i++) {
+		memcpy(&info[cur], &info[0], sizeof(info[0]));
+		info[cur++].off += (i + 1) * elem_size;
+	}
+
+	return 0;
+}
+
 static int btf_find_field_one(const struct btf *btf,
 			      const struct btf_type *var,
 			      const struct btf_type *var_type,
@@ -3504,6 +3539,21 @@ static int btf_find_field_one(const struct btf *btf,
 {
 	int ret, align, sz, field_type;
 	struct btf_field_info tmp;
+	const struct btf_array *array;
+	u32 i, nelems = 1;
+
+	/* Walk into array types to find the element type and the number of
+	 * elements in the (flattened) array.
+	 */
+	for (i = 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++) {
+		array = btf_array(var_type);
+		nelems *= array->nelems;
+		var_type = btf_type_by_id(btf, array->type);
+	}
+	if (i == MAX_RESOLVE_DEPTH)
+		return -E2BIG;
+	if (nelems == 0)
+		return 0;
 
 	field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
 					field_mask, seen_mask, &align, &sz);
@@ -3512,7 +3562,7 @@ static int btf_find_field_one(const struct btf *btf,
 	if (field_type < 0)
 		return field_type;
 
-	if (expected_size && expected_size != sz)
+	if (expected_size && expected_size != sz * nelems)
 		return 0;
 	if (off % align)
 		return 0;
@@ -3552,10 +3602,14 @@ static int btf_find_field_one(const struct btf *btf,
 
 	if (ret == BTF_FIELD_IGNORE)
 		return 0;
-	if (!info_cnt)
+	if (nelems > info_cnt)
 		return -E2BIG;
-
-	return 1;
+	if (nelems > 1) {
+		ret = btf_repeat_field(info, nelems - 1, sz);
+		if (ret < 0)
+			return ret;
+	}
+	return nelems;
 }
 
 static int btf_find_struct_field(const struct btf *btf,
-- 
2.34.1


