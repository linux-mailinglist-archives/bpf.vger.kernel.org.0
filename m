Return-Path: <bpf+bounces-30414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94AC8CD941
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E67D283468
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE827E583;
	Thu, 23 May 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHonMHX7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3476034
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486134; cv=none; b=nml997aVr0l0yk5trSf1IPnjVVVc8zlK5nOKYqrLLvRIVk7A1Zw49yKdRQOe9s3puRnhGiw2fIwBbZ2zJ4X5DLW5Z+iqyDSOlXZCyynpgMus+MuMrERY2y0Y4wxjblQN6hA3JKehOEAKQOqCzh1AFbDd/wIDccEZVYYW+v+3t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486134; c=relaxed/simple;
	bh=upVhmpmzSJmS20JqXVMvwrSbBc8DdAjci0We5oLNjcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjZHBSVCkcNvEHCBOezbuaxA9dswW9y9H0KZLifPdkMriOXjAe3l2MpW0UvvE0DsB/5vQRu3P4JhBcKOKeTimw7gcEQDjYn4XUaLUhyH8+p3ymR7hEDlT2uJ5+U96p8U7Dyovh/jqTRIANoryFJMS3jIvLASSq7R5ASexLSK0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHonMHX7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6203f553e5fso62146987b3.1
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486131; x=1717090931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+O2RZhOQRKcgUwqgGuv+62tvwQlJ69c+KC5kITkKYo=;
        b=RHonMHX7MEZBVq7ZUAJMGRch+duty2Ttzvh+FW9/T+o2H70rhuxfceVb02fpw1fqW0
         yF1UNlGfMhYywJxUVvTX4rO0CBePs20pfECCvo3Cj+q83IM0ByaIYOG0THTS9JaKTxmT
         kW+gVEsQjiCfOydBXZZGf/wl1nKQzaIXGbdkoo6ok4OPQKPpTGRKCUqQBOwv1WzQQj3q
         pPv7rgXroiyhMo/t50rEk0EO7zchYGsKxC6b/Y7wsOynekF4EVds+ke/bXGFux/PmFwI
         6xpmMSHEem9lkt/BABbpJgxnWYFKLc+MbxoiyV/KPsIsIDABhqKKviUVusKPIP52cw1O
         SUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486131; x=1717090931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+O2RZhOQRKcgUwqgGuv+62tvwQlJ69c+KC5kITkKYo=;
        b=WkukxbwIOZCpR7z19ltQr3tCPTfw+zi/1xE+yVDSNfmRPlPvBBRyWsPweJapff7vDl
         dzWEIhtaVL85vSjpem9dwke10gyWh5/kDqklH8oEboNOyFsG8gRdMft6i6Cky/fZP85f
         iQLIw5BFlkR/qqkrNiS5CW/ZpJJYIUOFgLwA3SWv4sQWQPk29ZyYefP5pWyvOpyPbJAU
         Sl6Q4+ySJc83vJsCNnJIQ2FBJ82JXbhcKcNRhH8rlXjcwKgH0mJnmjTe2sgSltA35w68
         8qhWaxBmIbdLNmH1Wl9H3s5JNYDxUFyUMekYjI/182f2CMMQvCBVAe49wF85wyDubohb
         AjHA==
X-Gm-Message-State: AOJu0YyDXtGq5bJepjWyyMhbsDRUlfcwbyyip0P4vgXD0EbOMHZEwX/Q
	cuUp1RbikKg9507aStqKkTNRfu4QvRA0gUeltDxK4ekk7vLGtp1cRj5o5g==
X-Google-Smtp-Source: AGHT+IGswrBEivxJssocldEQmuzZiMYEkmF1O4SL/5xj5MD3AYOI58M3rTCgoqrB18ssiCpD3IwMAg==
X-Received: by 2002:a81:ab52:0:b0:618:8f69:df36 with SMTP id 00721157ae682-627e4685a7bmr58669077b3.23.1716486131375;
        Thu, 23 May 2024 10:42:11 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e2514bbsm63652277b3.42.2024.05.23.10.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:42:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/9] bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
Date: Thu, 23 May 2024 10:41:56 -0700
Message-Id: <20240523174202.461236-4-thinker.li@gmail.com>
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


