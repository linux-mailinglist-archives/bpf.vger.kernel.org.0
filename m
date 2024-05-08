Return-Path: <bpf+bounces-29022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ABA8BF648
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8259C1F23BB4
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1AF224D6;
	Wed,  8 May 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSlUbI00"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA9210E9
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149950; cv=none; b=XwhU3Uwt99fZB7fBVvZU/gxKMfB/ymZdnUbQQO2W+ccV4YXaGJfDY+Yh6uIpeLgBH/nz8QixJcF8QcZDOfaMQGONv+JZBufbfs2vUaSAs64XNIukb4MrDWUGkKQ3SaaVJtNXVfVCpAmKSS6f4mXayDb4vdbLVz2j+LtU+qowD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149950; c=relaxed/simple;
	bh=f+PxVLjc+66TcKUvZRUTfOmyFfg8SYJG6hUBE43pnGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KRjwgHqJxPo4UcEf3M2yIev37ZCNGpH9e8FbmuCJ9QdJZ/ZVhEWvmXBM9GMFJ5ClnBAmgcc7bRxojAkK2gWnea3hQZGCSdJZdOkavMvTJawwCrJhrZ+ugUF3Q9l/Sv3EKdCE0ADl/E09FfdvTQhnUScV7gvV66YK7xP7qWuuUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSlUbI00; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c5ee4ce695so979749b6e.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149948; x=1715754748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4r8v2MRLTFL20Ck49ByWH0xPmhJ1y/H0HI2kjXGJB0=;
        b=KSlUbI00K0jNYqLGXFhstZ9XqfvtIuNINXycWcAzBqb7w1avnmAIkBaOIhI1nmXvcE
         2RqUTVqPGCDcKs6N6MZSkUY0K0YvKW/O7vsjykFoeo0TUc4NpaOL1m3awGHHStPzgpoX
         ut3YqdaX5ussJaFSFy5qymlSXykKMl/ClbXCY0NYW6AfPWZSldHVrn/EfdaOX/6jHcNg
         keJQUHedQVQeFloTVDqsx/rvqsgA/dgh0dUC6ELdH9dw7zO4OaegjO4lNM4Z/CIZNXGY
         ghKoH83RdryZ2aF4NQcAcy8+ge9lEB9JnznGPt1E7NnvRIEgzc0H+1S8rhcO+PXj2I7a
         JGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149948; x=1715754748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4r8v2MRLTFL20Ck49ByWH0xPmhJ1y/H0HI2kjXGJB0=;
        b=pmSrqys50w0CDbidIyOaK6srLq/KjtGaQr0b/t/AB5H2FMg3TZhppUKqwYdH/Zi3j+
         jWNVsm//p36EhdPPPIXly58TDx/lNVIhFtFfMY4AFhnFWEv8by0g6G61+TKm8Ml62V85
         b7BzZ1wz6U2t/fT0e+QpKeAWFP8S1NLAVNrtvQ08Odt2Dqf3XCljpKITSCXk3+Rk0WtC
         eXOYhutBu84XichL7xICeKbanrZRJaqp9HdGcqNBvNtXSb1b+pQUg0q/RUAJI9KwbnAF
         xkHi8Se1fGcCKeszfcfsoTor7hXWK1sBAs8zaP5MkNfK/LnXprWaIiSDxH9qfCw4tVrL
         5/JQ==
X-Gm-Message-State: AOJu0Yz7Q/yiM9zx4XZJQGMNc1lRKuCUidTNiczdzf846PG2Ghxjc/cg
	Ck3o8GfcWV/u7KZHHhl80tv2+4T7VykaicJyRHcsiclJl8HW2e9EX5ye/Q==
X-Google-Smtp-Source: AGHT+IF/ZXbcT6c+m/WClPs8yRavwldCkDnTuQ8loFnZy+M/oWW2k2RjuKwQ3cractU9j2LBAGpAEQ==
X-Received: by 2002:a54:4411:0:b0:3c8:2bb4:2288 with SMTP id 5614622812f47-3c98529859bmr1675168b6e.2.1715149948033;
        Tue, 07 May 2024 23:32:28 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 4/9] bpf: create repeated fields for arrays.
Date: Tue,  7 May 2024 23:32:13 -0700
Message-Id: <20240508063218.2806447-5-thinker.li@gmail.com>
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

The verifier uses field information for certain special types, such as
kptr, rbtree root, and list head. These types are treated
differently. However, we did not previously support these types in
arrays. This update examines arrays and duplicates field information the
same number of times as the length of the array if the element type is one
of the special types.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 60 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2ce61c3a7e28..633c3e037cef 100644
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
@@ -3504,6 +3539,19 @@ static int btf_find_field_one(const struct btf *btf,
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
+	if (nelems == 0)
+		return 0;
 
 	field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
 					field_mask, seen_mask, &align, &sz);
@@ -3512,7 +3560,7 @@ static int btf_find_field_one(const struct btf *btf,
 	if (field_type < 0)
 		return field_type;
 
-	if (expected_size && expected_size != sz)
+	if (expected_size && expected_size != sz * nelems)
 		return 0;
 	if (off % align)
 		return 0;
@@ -3552,10 +3600,14 @@ static int btf_find_field_one(const struct btf *btf,
 
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


