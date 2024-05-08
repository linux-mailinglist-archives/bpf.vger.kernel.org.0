Return-Path: <bpf+bounces-29020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E798BF646
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E785A1C2255F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04774208D1;
	Wed,  8 May 2024 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwE2EfN1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDA1A269
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149948; cv=none; b=tiqvw8RX1eDI1vhNzwDX2wyNIAM1whKHk5lERRhu7o6KZ4QbD7Y07Sv5KQT7ab+T4x6LZflKdxTDw7LFj+8jLoPxOogVnB4NVvgY6g3/E53gHWe5ApxIkNj2IF4otiN0Jawxmp4D6NANayUg6MhIWlZRe7ISANCAhJ3Ab2qdQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149948; c=relaxed/simple;
	bh=6znW+NE8zwp4bgpiun5+PGm3xlcUg+KGbPtaqm1Ye3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAq9BqyhRmQrcrfApB5Qna8z4+Z1eEi2rTbp4bBGSIShPFbiayen+e8mVnavhuCjjMz8+fjI74u3UW/ewEhwGPzwKrlc+dsAy4XMPNcFbal42ukb7SZsSR+bbYBerfafFM+C24QoXlEphJ6cdKcsoZCM7iHJu5cLY5Rx9+72UuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwE2EfN1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c969fa8fd2so1856905b6e.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149946; x=1715754746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1a3kDiHecRAIVMu8M6ylST2Yj/4mbIS/q1HrQnEk5I=;
        b=GwE2EfN1e/Rgl3KNy3UH0FllRb0aoDRGoG2UXSci7l3znz6GerJFA6o250gqKT2Nbq
         58lSPvS52Fv9dgfDrH/OmtbzpVCw5TQMYLPBEBOTirqb90cvxRJ9KZjsNiBD4PqjNz8R
         FpD8lqmLra10V/3ZfJW0BHOH9037kxv2bMmfrCgTzRBpX7e58AyWuHM8rrbwMv1cWwUz
         I5I9VeXnsALiPi0nnK7kgn4jWEakmte3cMM3yPVen+0m02BgKPxF2ng8dxaWqKH5AlnK
         Dw+JepCxaH15qITU/6ndvbfnRvOLcri2O9QQyxm6t9axIw0KduQNq2i83jwzJQ2K44f3
         PhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149946; x=1715754746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1a3kDiHecRAIVMu8M6ylST2Yj/4mbIS/q1HrQnEk5I=;
        b=WdFPr+osni//eJazfZJcnXsBK7aW7d30Xo/lL6PXFEMVlw8uUqZA54o4qoYne+arPk
         YZHVgItmHMldUeR1PLTM1rGbrXU8XG1LqgpNSXGyKyzHE3xZQSeVDkP1W4YCs1NRDOBA
         8jAVwQGuAfz+IQgiCNd+qbu8/FiRxv+wEz41KZtZmEeWhbfqonWyJtgwr5jVc9UxrfyB
         It8VYq4oQsPDyAI3U6AGf3arqqLW5CPWgf/XLknuSxclZ+lygYReKcBztVrWHBvJNwD7
         nOehepJ0UZpTFR7x5jxcDtqcBhiIwcQnaIJqNmf7UdMcipECDatJ45TZg/mQ6k1iyi9i
         /4Fg==
X-Gm-Message-State: AOJu0YyQDGNJ1YITL2twkJES8+6ZyviLSj5NzcD2jdaFsA6axdv6HL5k
	PhuPg7x1hCwZYo0qvVmp1ZmyPZeUwsktCv6271+FDvAQWBLn1DkjR9anWA==
X-Google-Smtp-Source: AGHT+IHxrtLuAxtRcqS+opnA2Jumv6yW1HQVzYB8v3VMttf62IW+PmHin/MBbOTc6VcNg2m9KbsOsg==
X-Received: by 2002:a05:6808:2a8e:b0:3c8:47a3:3cb6 with SMTP id 5614622812f47-3c9852bd825mr2083676b6e.21.1715149945872;
        Tue, 07 May 2024 23:32:25 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/9] bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
Date: Tue,  7 May 2024 23:32:12 -0700
Message-Id: <20240508063218.2806447-4-thinker.li@gmail.com>
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

Move common code of the two functions to btf_find_field_one().

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 180 +++++++++++++++++++++--------------------------
 1 file changed, 79 insertions(+), 101 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 226138bd139a..2ce61c3a7e28 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3494,72 +3494,95 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 
 #undef field_mask_test_name
 
+static int btf_find_field_one(const struct btf *btf,
+			      const struct btf_type *var,
+			      const struct btf_type *var_type,
+			      int var_idx,
+			      u32 off, u32 expected_size,
+			      u32 field_mask, u32 *seen_mask,
+			      struct btf_field_info *info, int info_cnt)
+{
+	int ret, align, sz, field_type;
+	struct btf_field_info tmp;
+
+	field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
+					field_mask, seen_mask, &align, &sz);
+	if (field_type == 0)
+		return 0;
+	if (field_type < 0)
+		return field_type;
+
+	if (expected_size && expected_size != sz)
+		return 0;
+	if (off % align)
+		return 0;
+
+	switch (field_type) {
+	case BPF_SPIN_LOCK:
+	case BPF_TIMER:
+	case BPF_WORKQUEUE:
+	case BPF_LIST_NODE:
+	case BPF_RB_NODE:
+	case BPF_REFCOUNT:
+		ret = btf_find_struct(btf, var_type, off, sz, field_type,
+				      info_cnt ? &info[0] : &tmp);
+		if (ret < 0)
+			return ret;
+		break;
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+	case BPF_KPTR_PERCPU:
+		ret = btf_find_kptr(btf, var_type, off, sz,
+				    info_cnt ? &info[0] : &tmp);
+		if (ret < 0)
+			return ret;
+		break;
+	case BPF_LIST_HEAD:
+	case BPF_RB_ROOT:
+		ret = btf_find_graph_root(btf, var, var_type,
+					  var_idx, off, sz,
+					  info_cnt ? &info[0] : &tmp,
+					  field_type);
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	if (ret == BTF_FIELD_IGNORE)
+		return 0;
+	if (!info_cnt)
+		return -E2BIG;
+
+	return 1;
+}
+
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt)
 {
-	int ret, idx = 0, align, sz, field_type;
+	int ret, idx = 0;
 	const struct btf_member *member;
-	struct btf_field_info tmp;
 	u32 i, off, seen_mask = 0;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								    member->type);
 
-		field_type = btf_get_field_type(__btf_name_by_offset(btf, member_type->name_off),
-						field_mask, &seen_mask, &align, &sz);
-		if (field_type == 0)
-			continue;
-		if (field_type < 0)
-			return field_type;
-
 		off = __btf_member_bit_offset(t, member);
 		if (off % 8)
 			/* valid C code cannot generate such BTF */
 			return -EINVAL;
 		off /= 8;
-		if (off % align)
-			continue;
-
-		switch (field_type) {
-		case BPF_SPIN_LOCK:
-		case BPF_TIMER:
-		case BPF_WORKQUEUE:
-		case BPF_LIST_NODE:
-		case BPF_RB_NODE:
-		case BPF_REFCOUNT:
-			ret = btf_find_struct(btf, member_type, off, sz, field_type,
-					      idx < info_cnt ? &info[idx] : &tmp);
-			if (ret < 0)
-				return ret;
-			break;
-		case BPF_KPTR_UNREF:
-		case BPF_KPTR_REF:
-		case BPF_KPTR_PERCPU:
-			ret = btf_find_kptr(btf, member_type, off, sz,
-					    idx < info_cnt ? &info[idx] : &tmp);
-			if (ret < 0)
-				return ret;
-			break;
-		case BPF_LIST_HEAD:
-		case BPF_RB_ROOT:
-			ret = btf_find_graph_root(btf, t, member_type,
-						  i, off, sz,
-						  idx < info_cnt ? &info[idx] : &tmp,
-						  field_type);
-			if (ret < 0)
-				return ret;
-			break;
-		default:
-			return -EFAULT;
-		}
 
-		if (ret == BTF_FIELD_IGNORE)
-			continue;
-		if (idx >= info_cnt)
-			return -E2BIG;
-		++idx;
+		ret = btf_find_field_one(btf, t, member_type, i,
+					 off, 0,
+					 field_mask, &seen_mask,
+					 &info[idx], info_cnt - idx);
+		if (ret < 0)
+			return ret;
+		idx += ret;
 	}
 	return idx;
 }
@@ -3568,66 +3591,21 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				u32 field_mask, struct btf_field_info *info,
 				int info_cnt)
 {
-	int ret, idx = 0, align, sz, field_type;
+	int ret, idx = 0;
 	const struct btf_var_secinfo *vsi;
-	struct btf_field_info tmp;
 	u32 i, off, seen_mask = 0;
 
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
 		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
 
-		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
-						field_mask, &seen_mask, &align, &sz);
-		if (field_type == 0)
-			continue;
-		if (field_type < 0)
-			return field_type;
-
 		off = vsi->offset;
-		if (vsi->size != sz)
-			continue;
-		if (off % align)
-			continue;
-
-		switch (field_type) {
-		case BPF_SPIN_LOCK:
-		case BPF_TIMER:
-		case BPF_WORKQUEUE:
-		case BPF_LIST_NODE:
-		case BPF_RB_NODE:
-		case BPF_REFCOUNT:
-			ret = btf_find_struct(btf, var_type, off, sz, field_type,
-					      idx < info_cnt ? &info[idx] : &tmp);
-			if (ret < 0)
-				return ret;
-			break;
-		case BPF_KPTR_UNREF:
-		case BPF_KPTR_REF:
-		case BPF_KPTR_PERCPU:
-			ret = btf_find_kptr(btf, var_type, off, sz,
-					    idx < info_cnt ? &info[idx] : &tmp);
-			if (ret < 0)
-				return ret;
-			break;
-		case BPF_LIST_HEAD:
-		case BPF_RB_ROOT:
-			ret = btf_find_graph_root(btf, var, var_type,
-						  -1, off, sz,
-						  idx < info_cnt ? &info[idx] : &tmp,
-						  field_type);
-			if (ret < 0)
-				return ret;
-			break;
-		default:
-			return -EFAULT;
-		}
-
-		if (ret == BTF_FIELD_IGNORE)
-			continue;
-		if (idx >= info_cnt)
-			return -E2BIG;
-		++idx;
+		ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
+					 field_mask, &seen_mask,
+					 &info[idx], info_cnt - idx);
+		if (ret < 0)
+			return ret;
+		idx += ret;
 	}
 	return idx;
 }
-- 
2.34.1


