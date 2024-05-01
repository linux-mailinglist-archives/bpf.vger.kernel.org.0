Return-Path: <bpf+bounces-28402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B948B90D0
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36151F22DC3
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37F165FA7;
	Wed,  1 May 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2HaLQAm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA621649CD
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596464; cv=none; b=aNnLkLVIRAykAEVLr40ojzOFUpuoNZPBT4drA3ck89ee8swrmlHbNKwj57QOj7PuQs7DYfH+IRdckmuUXwnE1pkwGrI9jN/vmaRqTUkiCuAlRW6FDUaVTFvwB8mym1QAMex2elLmX2dTCnPnA0kbpfdog4IjzyGTNfJeeS+hqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596464; c=relaxed/simple;
	bh=aOXBkWIp2RYw+AcZuT+hhsKn6B1qOAI2ah0gPNZgYXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lm4l69UJVlo2XxdG3XrvW15cIgoKq1dowuoK5a7OcESZCT7JW7aYIJL078MEdcftTEEjtxps61675cpkEUWoLz4XCuco00McsKN2RoCXrh2MtIx3ru4nMCJF4QcpGdZ28oVTPhzgi4DbfudT7g2KkNKoI4yhpN/59qi9p1lWL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2HaLQAm; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso1132452fac.0
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714596462; x=1715201262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktDhAmiz3+1lqS9BxQJAmXedd1vY8D/++/LytiIo7rw=;
        b=K2HaLQAm5OkF9K8nW8OvMedDLmewmW/FowDk6cP377U+cpc03f+iR+tmDJu8Vff3U0
         IOaBMofzN0GPyFYssfLJ1o65r74opbXkzHrsicfyUw2Yb9lOIQqGAv5fpClSNdOgRpZe
         626jExB0N3arrVECGnr1kv70ARerNNDKXZE/zrj3Fu6gWGI2ysoxM/tLfmzX9bGv778M
         PTPH/oIuV9w+MgZpqT3Nu7970E9YlDs+hUe3OP0r6knnokvJ73/D0QFRNWK5zJ0KdlDQ
         TL0pzVEhc3lg6b4lvVvxHeiSnEn348Ht6b5TuLIqh7iGC2dAdBDplf5URrumyWnDnh1Z
         ga0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596462; x=1715201262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktDhAmiz3+1lqS9BxQJAmXedd1vY8D/++/LytiIo7rw=;
        b=r70eTdBXJ3/WJ2VZKJNBAqXCaNLzp69RDUFQKZ62r7E0Ok2LSTX4NAk62EELYSQtl5
         1Vd4pJ58PpFtkseGJ6j3hc76dw5KaYo2NDuRvOSKLK+l54TeVbmJ/wjRgnPom5Eg0rZx
         ZIqCFZpsJ70+WEMD8iu0ZA65nHZy2y0kguh/wLCZo4daefo3OlVdwBv/aqJh7U151sXE
         jhtVj5gOOeuTPDYve0Wp8geOle9y1o82s6mClri4JPKlrHNwwELN5nYdehawvcjL40ak
         Bo1sv0OEUiC3dSwxdFFM0rOeXlwb7+vgPzzjQtHah20pnOK/K466fEykdY5emnNl7ZFU
         CqyQ==
X-Gm-Message-State: AOJu0YxV8ocgjkFfumIFSwdxq1MzK2Zc530hBNOIImfgDw9Uhg8c7vpO
	YGpJ9o9Da4VEA51E8wCH91XasBsy3nBNNSjAEuAICCE4M/LOgmEFAjE0OQ==
X-Google-Smtp-Source: AGHT+IFPMh4WxToTcjUH/zx3t/fkY4BuqahOzObw45cx38SM8NAQpApdUxChx6RdzvslAp/iiRuTSQ==
X-Received: by 2002:a05:6871:412:b0:23c:6020:6733 with SMTP id d18-20020a056871041200b0023c60206733mr4294480oag.27.1714596461921;
        Wed, 01 May 2024 13:47:41 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id rx17-20020a056871201100b002390714e903sm5744408oab.3.2024.05.01.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:47:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] bpf: create repeated fields for arrays.
Date: Wed,  1 May 2024 13:47:25 -0700
Message-Id: <20240501204729.484085-4-thinker.li@gmail.com>
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

The verifier uses field information for certain special types, such as
kptr, rbtree root, and list head. These types are treated
differently. However, we did not previously support these types in
arrays. This update examines arrays and duplicates field information the
same number of times as the length of the array if the element type is one
of the special types.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 81 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d4c3342e2027..4a78cd28fab0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3493,6 +3493,41 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 
 #undef field_mask_test_name
 
+/* Repeat a field for a specified number of times.
+ *
+ * Copy and repeat a field for repeat_cnt
+ * times. The field is repeated by adding the offset of each field
+ * with
+ *   (i + 1) * elem_size
+ * where i is the repeat index and elem_size is the size of the element.
+ */
+static int btf_repeat_field(struct btf_field_info *info, u32 field,
+			    u32 repeat_cnt, u32 elem_size)
+{
+	u32 i;
+	u32 cur;
+
+	/* Ensure not repeating fields that should not be repeated. */
+	switch (info[field].type) {
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
+	cur = field + 1;
+	for (i = 0; i < repeat_cnt; i++) {
+		memcpy(&info[cur], &info[field], sizeof(info[0]));
+		info[cur++].off += (i + 1) * elem_size;
+	}
+
+	return 0;
+}
+
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt)
@@ -3505,6 +3540,19 @@ static int btf_find_struct_field(const struct btf *btf,
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								    member->type);
+		const struct btf_array *array;
+		u32 j, nelems = 1;
+
+		/* Walk into array types to find the element type and the
+		 * number of elements in the (flattened) array.
+		 */
+		for (j = 0; j < MAX_RESOLVE_DEPTH && btf_type_is_array(member_type); j++) {
+			array = btf_array(member_type);
+			nelems *= array->nelems;
+			member_type = btf_type_by_id(btf, array->type);
+		}
+		if (nelems == 0)
+			continue;
 
 		field_type = btf_get_field_type(__btf_name_by_offset(btf, member_type->name_off),
 						field_mask, &seen_mask, &align, &sz);
@@ -3556,9 +3604,14 @@ static int btf_find_struct_field(const struct btf *btf,
 
 		if (ret == BTF_FIELD_IGNORE)
 			continue;
-		if (idx >= info_cnt)
+		if (idx + nelems > info_cnt)
 			return -E2BIG;
-		++idx;
+		if (nelems > 1) {
+			ret = btf_repeat_field(info, idx, nelems - 1, sz);
+			if (ret < 0)
+				return ret;
+		}
+		idx += nelems;
 	}
 	return idx;
 }
@@ -3575,6 +3628,19 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
 		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
+		const struct btf_array *array;
+		u32 j, nelems = 1;
+
+		/* Walk into array types to find the element type and the
+		 * number of elements in the (flattened) array.
+		 */
+		for (j = 0; j < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); j++) {
+			array = btf_array(var_type);
+			nelems *= array->nelems;
+			var_type = btf_type_by_id(btf, array->type);
+		}
+		if (nelems == 0)
+			continue;
 
 		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
 						field_mask, &seen_mask, &align, &sz);
@@ -3584,7 +3650,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			return field_type;
 
 		off = vsi->offset;
-		if (vsi->size != sz)
+		if (vsi->size != sz * nelems)
 			continue;
 		if (off % align)
 			continue;
@@ -3624,9 +3690,14 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 
 		if (ret == BTF_FIELD_IGNORE)
 			continue;
-		if (idx >= info_cnt)
+		if (idx + nelems > info_cnt)
 			return -E2BIG;
-		++idx;
+		if (nelems > 1) {
+			ret = btf_repeat_field(info, idx, nelems - 1, sz);
+			if (ret < 0)
+				return ret;
+		}
+		idx += nelems;
 	}
 	return idx;
 }
-- 
2.34.1


