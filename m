Return-Path: <bpf+bounces-28403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978938B90D1
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECA9284B38
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA0165FB1;
	Wed,  1 May 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9BixgZ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A41649D5
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596465; cv=none; b=csXTk4kwCyu/7ukzzLP9DYixBZgcItC9OnDwIQwYUHUjkLWQpXTMi9IHBX9HSDbcnBDwZIWPXSi8e/1CA2eoeGgEUFv15gTQSbzG2pMkh8ntv4ZmJE1nmdf78a9Vrvr33gx3bjVH0F4CY7Wk3LSwLdpMgErjeQtetIIsv0H9nS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596465; c=relaxed/simple;
	bh=z0UqkRTALXxZhdkB4fYqH5hLwBNvnV4yPnOqyGhHMDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXLgtuTBf9KUQRVrYC/Dij3bkAkegTTEBaEiKpN0DIJYA7c4WHWjCxmbtz/f+L82YhpIzkoQiQTuk4gS6OkI51FPuu/r+k5mz2JB0wIF8R7l/vyNWmbBtRPOsuCSJZbvcZu/0dqYcGAWBYxtGhiI6hIQJsBaXscig587z8Xyg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9BixgZ7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23d4a716ee7so973677fac.2
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596463; x=1715201263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebdVSdcEKl/+3KcoL/wBPwiUHNfirTRrd05AF7bSsRk=;
        b=X9BixgZ7AMYMUGT8joTxQbOcCqkpkFNMGSxrATbAJxpw3Q9y12aCIf+j0Lv1ZeZCoo
         VL8LGIK5FM/pOGG6Y58Y3KEmSRH5OFAJXl+ZUGmjDHOzsqCH2je3VaVdpDI57LNqb1aX
         WYxY0lGMCDqfRnACd0WwNlUbdz2Y2H7K8GYi9bYDHDTGCP1TZOr/LULaCwrEhOe1L0qa
         rjfEE20sA3dmCLwT8CKFIMquMkXTronBcTBKTxroylVsG1s/0DZAAkiXlCUTXMw2at1X
         e5L5PAWodqF0sTv7yAOAScyR5rkoaTUXbvTootBw2AZbEEEwWHq7MEdpcL5xrD0rVuH8
         xQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596463; x=1715201263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebdVSdcEKl/+3KcoL/wBPwiUHNfirTRrd05AF7bSsRk=;
        b=j4/9qttvlbsPQBAjCe8b7m1LbnDUwKZ3OTDn/uYnkkfPI5gZp+QHUPK0dQuPrKvrr9
         9HznuUGB5kb6dJBMMTzoE/20LBpr0cCFMXgcdWQbwwVvc4+Aif0Em/whEX+Ix5TDXNal
         yhcUTdiTs1z1U+TL0zy5UJwY40mVgPSgLhZ8PAvblUbm3Sm0ZG+sPISs7HLbRvME6yY+
         AMCM2frYu7glzhHp+6hExvw2N58GjCTQMjRApoh43TVIKQ9PzgjPHl8wkrzDQWoRKktZ
         RxImRgqRiDnC0d87PX/4N78QojyC/6KvGaRUwlcWmPeFUaIi1+EWfhRssZGz6s/h3P+V
         r/5Q==
X-Gm-Message-State: AOJu0YwKX1QUP30xC0fregzLdsGv9sX3PWuWFsSk7dXbiKo4upOOaJEA
	0DVi5EDuyMlmBh+c/EQJUujtazVZBE1k3mREAfY6Ye+CNFV7gjn2PuiDhg==
X-Google-Smtp-Source: AGHT+IHUdzpUXApNP93wwy1J4ebhVnixlnegee3eS680rkSsMlnYpp/dr+eKyv0+4T0giiZQqnS2oA==
X-Received: by 2002:a05:6871:4008:b0:22e:c4e7:8aba with SMTP id kx8-20020a056871400800b0022ec4e78abamr168986oab.47.1714596462893;
        Wed, 01 May 2024 13:47:42 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id rx17-20020a056871201100b002390714e903sm5744408oab.3.2024.05.01.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:47:42 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/7] bpf: look into the types of the fields of a struct type recursively.
Date: Wed,  1 May 2024 13:47:26 -0700
Message-Id: <20240501204729.484085-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501204729.484085-1-thinker.li@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
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
 kernel/bpf/btf.c | 118 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 98 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4a78cd28fab0..2ceff77b7e71 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3493,41 +3493,83 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 
 #undef field_mask_test_name
 
-/* Repeat a field for a specified number of times.
+/* Repeat a number of fields for a specified number of times.
  *
- * Copy and repeat a field for repeat_cnt
- * times. The field is repeated by adding the offset of each field
+ * Copy the fields starting from first_field and repeat them for repeat_cnt
+ * times. The fields are repeated by adding the offset of each field
  * with
  *   (i + 1) * elem_size
  * where i is the repeat index and elem_size is the size of the element.
  */
-static int btf_repeat_field(struct btf_field_info *info, u32 field,
-			    u32 repeat_cnt, u32 elem_size)
+static int btf_repeat_fields(struct btf_field_info *info, u32 first_field,
+			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
 {
-	u32 i;
+	u32 i, j;
 	u32 cur;
 
 	/* Ensure not repeating fields that should not be repeated. */
-	switch (info[field].type) {
-	case BPF_KPTR_UNREF:
-	case BPF_KPTR_REF:
-	case BPF_KPTR_PERCPU:
-	case BPF_LIST_HEAD:
-	case BPF_RB_ROOT:
-		break;
-	default:
-		return -EINVAL;
+	for (i = 0; i < field_cnt; i++) {
+		switch (info[first_field + i].type) {
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
 
-	cur = field + 1;
+	cur = first_field + field_cnt;
 	for (i = 0; i < repeat_cnt; i++) {
-		memcpy(&info[cur], &info[field], sizeof(info[0]));
-		info[cur++].off += (i + 1) * elem_size;
+		memcpy(&info[cur], &info[first_field], field_cnt * sizeof(info[0]));
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
+		err = btf_repeat_fields(info, 0, ret, nelems - 1, t->size);
+		if (err == 0)
+			ret *= nelems;
+		else
+			ret = err;
+	}
+
+	return ret;
+}
+
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt)
@@ -3556,6 +3598,27 @@ static int btf_find_struct_field(const struct btf *btf,
 
 		field_type = btf_get_field_type(__btf_name_by_offset(btf, member_type->name_off),
 						field_mask, &seen_mask, &align, &sz);
+		/* Look into fields of struct types */
+		if ((field_type == BPF_KPTR_REF || !field_type) &&
+		    __btf_type_is_struct(member_type)) {
+			/* For field_type == BPF_KPTR_REF, it is not
+			 * necessary a kptr type. It can also be other
+			 * types not special types handled here. However,
+			 * it can not be a struct type if it is a kptr.
+			 */
+			off = __btf_member_bit_offset(t, member);
+			if (off % 8)
+				/* valid C code cannot generate such BTF */
+				return -EINVAL;
+			off /= 8;
+			ret = btf_find_nested_struct(btf, member_type, off, nelems, field_mask,
+						     &info[idx], info_cnt - idx);
+			if (ret < 0)
+				return ret;
+			idx += ret;
+			continue;
+		}
+
 		if (field_type == 0)
 			continue;
 		if (field_type < 0)
@@ -3607,7 +3670,7 @@ static int btf_find_struct_field(const struct btf *btf,
 		if (idx + nelems > info_cnt)
 			return -E2BIG;
 		if (nelems > 1) {
-			ret = btf_repeat_field(info, idx, nelems - 1, sz);
+			ret = btf_repeat_fields(info, idx, 1, nelems - 1, sz);
 			if (ret < 0)
 				return ret;
 		}
@@ -3644,6 +3707,21 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 
 		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
 						field_mask, &seen_mask, &align, &sz);
+		/* Look into variables of struct types */
+		if ((field_type == BPF_KPTR_REF || !field_type) &&
+		    __btf_type_is_struct(var_type)) {
+			sz = var_type->size;
+			if (vsi->size != sz * nelems)
+				continue;
+			off = vsi->offset;
+			ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
+						     &info[idx], info_cnt - idx);
+			if (ret < 0)
+				return ret;
+			idx += ret;
+			continue;
+		}
+
 		if (field_type == 0)
 			continue;
 		if (field_type < 0)
@@ -3693,7 +3771,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		if (idx + nelems > info_cnt)
 			return -E2BIG;
 		if (nelems > 1) {
-			ret = btf_repeat_field(info, idx, nelems - 1, sz);
+			ret = btf_repeat_fields(info, idx, 1, nelems - 1, sz);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.34.1


