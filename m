Return-Path: <bpf+bounces-29423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801A98C1BEB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BECA28440B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0513AA37;
	Fri, 10 May 2024 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0PYpzXm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACE13A88F
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303600; cv=none; b=K/96gpUQyDy+zlu++RQyP0N6I5lMoFCUJsIpT/RJREsAp9QqjlDR0VjodcGff4+0+kbAnuD8uA/IPrlVTJrt7fYYkIQ10q08+y64KE1H5oKqzz9TmEieI+8pDlTGJckr08q5aBsbaVekDVnymS+F8pl39x3BYooTPNQgXEK/QEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303600; c=relaxed/simple;
	bh=upVhmpmzSJmS20JqXVMvwrSbBc8DdAjci0We5oLNjcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PD97X5hXB5Ygq5T8LdhOYiI069aElSwaEQPaNegJaAoEIixtdgM0LS3qlaRKyiL/8d6b9MIR+y9DIYrTfnnXwh3BHruHJWUdHFWIbSqHYW/uepI/eD3O5T25Oe56bLqwjowmLRQask/pEcRr17VjQ3DOZK+VlnEwSs6gs6a+T2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0PYpzXm; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23eb1851c34so608180fac.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303598; x=1715908398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+O2RZhOQRKcgUwqgGuv+62tvwQlJ69c+KC5kITkKYo=;
        b=X0PYpzXmKqAYkCp5lxfRzlxKzk3w+EVO/To6tHt2S2B1aaGEltLYAfOkhUVuNQvyzx
         IGDJNRdUSkPbNox70zrRIwmCtN/ylOhe00qUdLNRV0OzWbfXvOenLnhbKuyC2dm6AXD/
         Cwoui87nSyx71YAqX7XNbDqGfDChMacfBWKkSHEsXU/88aPhuuOijY0EO+CnOogmrmYz
         qoDNJdBF7My7JzfFU09DN9bSqI73z0xFFWHyjsORGpvkyaR6WyLhGXVULJYcpOfWND0y
         UDAgo9P5QCBudzKzzHDAKeKjSgrwo/fJfgEEFnFjmkkTyVdqKUPHxlwvpHNSkrEwvi48
         44gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303598; x=1715908398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+O2RZhOQRKcgUwqgGuv+62tvwQlJ69c+KC5kITkKYo=;
        b=ZmpdeODRVipQs0Gp3rFew64T2fUAkq7Vw4voYuff+g1nCGJC47YDBOfZ/jyik4TJlv
         GQLDazq1twzEB8+vq5z7MeFbhar2xhG2BIAiD4zDKZRxYIAmIYO4zEuVxkSfWzJxAam+
         ACahRh8rTCbN2qelpQ6Ftb8WyPaSu+HuKNG2cztIvLzpIFn5cGk1QT54XyRTg4QKjyF9
         fvVPk9TkdauhKvxh8nT1PpKE5Wy6B48B6PcTgAyL3bD8q89sRLk/1zmsxjveXW7xjeMW
         SI/n+Y3byAY4JObxgvyqw4hKMn0QMzUWlCv5GszoAIm6n21f343O6Vqq74AN+Z66EXre
         FfPw==
X-Gm-Message-State: AOJu0YwuiGMgKuURLMG8ACNA2cYWuRcuANs3W7i2cPiitQupOOgDAI8h
	zOR6SkDWDqni2kuauqBbYwrW1hZq7QK7qGKctGRjFIQNh6Otm+oigWLzkA==
X-Google-Smtp-Source: AGHT+IFwA2knURKD7BEEuWkeMYf1cDDh7ZR//eZ2tMgD2HzU2xmp1chYcDYfe8MHGgiNlcu3q3fmTA==
X-Received: by 2002:a05:6870:15c4:b0:22a:508a:66e6 with SMTP id 586e51a60fabf-24172a5aa40mr1518114fac.17.1715303598141;
        Thu, 09 May 2024 18:13:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:17 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v5 3/9] bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
Date: Thu,  9 May 2024 18:13:06 -0700
Message-Id: <20240510011312.1488046-4-thinker.li@gmail.com>
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

Move common code of the two functions to btf_find_field_one().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


