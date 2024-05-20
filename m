Return-Path: <bpf+bounces-30045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73E8CA36C
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 22:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB0E1F21E2C
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209C139D0A;
	Mon, 20 May 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK71bz8i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03528139596
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237628; cv=none; b=kVLWNro8dfMlhiqWtQ+S4LjmE2gXit11LDBdATsSac1ArY28VSWy8jKWHj+V9wKBeZ0jyyWW2/ggobJ0dBCECDgngE3ZpmUi5kQzmVwcQGpzanwHU49ozHzmD1FaHddeqUhtzslELo3JQibGbP3rLYFnnPrmk8Al+TtASx9FkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237628; c=relaxed/simple;
	bh=upVhmpmzSJmS20JqXVMvwrSbBc8DdAjci0We5oLNjcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFPef5KbGPT6LqESWEJ0EL0i+C/M3CYJ7xOa+V8FaS7G7rx1Ghe+bh418YFRvQmT9dtPv09Zg2NUaAOvy/r400FbL3tlVuH4S2Yc3+4TOdpi8Xv/njLhbhIbu1jrzHh+KvMOFVmFHe7aE+l1TMcegpjiIthk7CpRNgs3mAf9vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK71bz8i; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61b4cbb8834so26033047b3.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237625; x=1716842425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+O2RZhOQRKcgUwqgGuv+62tvwQlJ69c+KC5kITkKYo=;
        b=GK71bz8itYKiBVSSS91U8CAaet5qrV740fcyY89GZCLbNlE3uD8VAtuDLECDcwx7k2
         qUdthA7Y8tj/ongYUFCQWAnitB/O+N0iBMcKWH7Aagoere6WqbtQ8IOSUV2BOTazY/vn
         bku3iri44qE5gjiUNFnmg3bEQP0nyQbM/5xA9yVqHrne7ZR2t/CYS1oo28k4n1Pvc1bH
         g1jWGC0PZ7qOfbNM9t5e4enCyTlSXaNnXGWU4GynUwKhaDd4Zj3UDaBx/SQI4Q2SBbAt
         2MkJ9SdLQ9UYSvTaDhQpLeuZJqX/kkp3GyKN23nHK6KJ+67GwGAgrQeEX7UTCTbxrpvO
         buTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237625; x=1716842425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+O2RZhOQRKcgUwqgGuv+62tvwQlJ69c+KC5kITkKYo=;
        b=aAVCugLLHDYfg5MaoxHgJE+SmQ6qr/7Q3rC5o7sWGy2S4OBdSrvv+iqWcZPh3+dsuw
         syxHttZsUELSkzOUtGW163WgH6tDJw2ry6luhvJXYURY1mk80VXnWIx5ehJXYvPShuDR
         Zwz0K0eJGUukb+1UmSRUCVnajKa35PcXQPVceYAv+CacTevKd8RZsttMv2nFZ/sKtA9t
         4TyfLXkJuSZc90lGRG0pnVN8F510RxUp7MsYZaEXpBQGfAUwxYtgONWADZSNBEN2+V8d
         DwIqSplUgMVJW1blZPI3gflbPIGeuigt1VC54bwMQpJ396YboQXpGJNA7QQqhR1cDTh4
         tyMg==
X-Gm-Message-State: AOJu0YxdGQl9NODK+ThJu6y3Wjt1OLK6dvcO0YMl1Y6T66n1uCJjk0lP
	8S8xuZFgzls3n00hEEpgkPRmb35oMOOG7VTY8GTdmy6/WM7QyRn5dZi8eQ==
X-Google-Smtp-Source: AGHT+IHR5wYW/JJtHqUVcYWKMqkysQ/fGUuXXQalCDjb6ZJawbyms6y+NqeBqp0wGs28HvOabg2UGg==
X-Received: by 2002:a05:690c:6e0d:b0:615:1413:95c1 with SMTP id 00721157ae682-622affa71c6mr329972777b3.19.1716237625584;
        Mon, 20 May 2024 13:40:25 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:764d:6809:5ff0:b5b6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e381afdsm49684267b3.127.2024.05.20.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:40:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/9] bpf: refactor btf_find_struct_field() and btf_find_datasec_var().
Date: Mon, 20 May 2024 13:40:12 -0700
Message-Id: <20240520204018.884515-4-thinker.li@gmail.com>
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


