Return-Path: <bpf+bounces-75040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F3C6C98B
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A85A54F6C37
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153BE2FD7C3;
	Wed, 19 Nov 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9dE0G4a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB62EA730
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522522; cv=none; b=CETynUVk1lXVzJySmszZhVOgNddY6yVOGqIW4+Pp0aunz9y1M6Ot5btRpeLkchItR0+vyUDYx0ckDnVRBPApILhAOHXLgBHf9BNJ6JmziljvPT4VXaGjb67zl0OvzXx9eUNKUKOsZ0Vx+PRCbUAwnoIhK2gPRCqloQGggCnMuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522522; c=relaxed/simple;
	bh=1JCm2gAw7szR6coFfKCMu4oP2N4ZVTGa8uyyO11FaJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+HTiMLyPYn3ULkpCQ2nUQkDZabQLwol8yKRDeUibvK8D7aNBC1olpwM68vRnDG20Xa8vCUepI2uj3Il39ELFQnrKcX982IeXjoK5ixxuazk6vXEevfn1wOCNgVR3/9VbKUhlKFHjStNbMlMIBaxu/GWtz+AgvdGXF0sWpQLgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9dE0G4a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298250d7769so42755285ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522520; x=1764127320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rljz3QHqavQzM2+LGEfUj2V9NIFH9chI7oYU2DEYmt8=;
        b=k9dE0G4ag5Fnx9SS5p3L8YYXjqV+wx0Bzsa/FfYdvx83lFSAJuwAeSZ94/nmlGWASO
         73RJMuRdlhdrwmndRSiqcLWD84irgrOPkMmACK4USkLgGjAbJ5SraLKR7e/yDfsTA24k
         e0zVuBTNRfRTOzSBL5Wov01PRKu/PB4lpQt8kU3zgT9mMuNozyQe8NYCQSNNi/NyzK0i
         8IVPe9vx1L1fcshIMbwrBhse/kEPT8AJE+dMkBskkmsZzGE5PG7d7soPfUxR8Pa6zSM4
         31hgW4/2IpHni4PbldFqDCZ5d02TyPUda1lk3AuzuT2zGtFMC+ycNe9K+0m/EZyGHksv
         nuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522520; x=1764127320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rljz3QHqavQzM2+LGEfUj2V9NIFH9chI7oYU2DEYmt8=;
        b=Q1jxrKEdmrOuUk0gw9EqLKbG5qkhLrk7NXk/w6qnBSF/PMB6t/uJX1ShX7Ta7Y79K0
         FQAklJ6mCL5yqJ8Td3HMJ5YzwptQguSbzLkYJZKVzih6a7C61/HrNx/QAmGTjLIh02Hj
         QGYdJbSWbXOpntd/BYIxfGXFQxH6aJ0tNzWJekKnCY6mJdhRGFj9fk52hEyIW8rDkWhD
         e6ewEOmj8rii73TT95RfwpLj4DF2QJVOm3l6LJbgRaswjtdin5xuNivSjlTTjN9S/CDT
         1Vajhu9oXN2iPvIiGmLxeCIxWh91KiBDn9fMQGL5Ho8gaR6Iz378bmXEjWWwkY7fboMx
         U13Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvkvMaTOEOWCUmS80dGCWCnRwYP30DDaRGRRNvjyjasxyBC/MYK70UP83fo3KJOFsuVds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68Q0ZiJGKVm99Lpo42H7F4yML4RYJayPTopr0eTd3lGi9P4BP
	y3puXofEpNiQaTDgA2LlnZlueoxecVcem4AZeNQybFWqZoIKtUANJ9oI
X-Gm-Gg: ASbGncs1nkbNYg/gPdbtbHnzc0jdsIh+mERuh7TOAvjjNVXjRycQldm6/9wI5xJyzb5
	5iSKf/+fQtJMr7XxuIJd91ga1EtBEnF9A/AXbSqqwwI+sfSPayHZMe8rx2mEv/ojkH440llpM/I
	V5xrXxNr8l/BISYkshctHzKSrj9rab6pBvsi/x4GmiAt5hS/stFQbCsRy0hy2bgxJoo5oWQN7Zm
	WJzvkbIVa5K5zGB33rOBi6+8/DOGvznMB0G/z/T9PVWu/1mW6/COEtfT3+FYCs7iJ4ulvQeN385
	h8JTY8Fh6d/xqSw78JgSMnnmh2LIxA96QIxHGqBn3CbXyyyl+cpzmznZsS7gHf4rQrOyKpzx6HQ
	bVIX1gbRfLMx5h8NGctLcLIdUA5vzZIBrYcXn8YpTDi+9xfmYg7hjY9iT/TYU4PN2sYV10rDfTT
	l8eTZwtgn2ARosiqU/vrLD6l4vzPQhs/AQeabC/Q==
X-Google-Smtp-Source: AGHT+IGMGm4ssuCAcSuhBLMTVMUN9IlTul3KIQyJF8pQPYcJbxELNk2HFjnnrYFBfI+sDmaW0pEWCA==
X-Received: by 2002:a17:902:cf43:b0:248:ff5a:b768 with SMTP id d9443c01a7336-2986a6abcb9mr216810575ad.10.1763522520091;
        Tue, 18 Nov 2025 19:22:00 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:21:59 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v7 6/7] btf: Optimize type lookup with binary search
Date: Wed, 19 Nov 2025 11:15:30 +0800
Message-Id: <20251119031531.1817099-7-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119031531.1817099-1-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Improve btf_find_by_name_kind() performance by adding binary search
support for sorted types. Falls back to linear search for compatibility.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 83 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..5dd2c40d4874 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -259,6 +259,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 nr_sorted_types; /* exclude VOID for base BTF */
 	u32 types_size;
 	u32 data_size;
 	refcount_t refcnt;
@@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_type *t)
 	return false;
 }
 
+static int btf_start_id(const struct btf *btf)
+{
+	return btf->start_id + (btf->base_btf ? 0 : 1);
+}
+
 bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
@@ -544,24 +550,78 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const char *name,
+						s32 start_id, s32 end_id)
+{
+	const struct btf_type *t;
+	const char *tname;
+	s32 l, r, m;
+
+	l = start_id;
+	r = end_id;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf_name_by_offset(btf, t->name_off);
+		if (strcmp(tname, name) >= 0) {
+			if (l == r)
+				return r;
+			r = m;
+		} else {
+			l = m + 1;
+		}
+	}
+
+	return btf_nr_types(btf);
+}
+
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
+	const struct btf *base_btf = btf_base_btf(btf);
 	const struct btf_type *t;
 	const char *tname;
-	u32 i, total;
+	int err = -ENOENT;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	if (base_btf) {
+		err = btf_find_by_name_kind(base_btf, name, kind);
+		if (err > 0)
+			goto out;
+	}
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+	if (btf->nr_sorted_types > 0) {
+		/* binary search */
+		s32 start_id, end_id;
+		u32 idx;
+
+		start_id = btf_start_id(btf);
+		end_id = start_id + btf->nr_sorted_types - 1;
+		idx = btf_find_by_name_kind_bsearch(btf, name, start_id, end_id);
+		for (; idx <= end_id; idx++) {
+			t = btf_type_by_id(btf, idx);
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(tname, name))
+				goto out;
+			if (BTF_INFO_KIND(t->info) == kind)
+				return idx;
+		}
+	} else {
+		/* linear search */
+		u32 i, total;
+
+		total = btf_nr_types(btf);
+		for (i = btf_start_id(btf); i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (BTF_INFO_KIND(t->info) != kind)
+				continue;
+
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (!strcmp(tname, name))
+				return i;
+		}
 	}
 
-	return -ENOENT;
+out:
+	return err;
 }
 
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
@@ -5791,6 +5851,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->nr_sorted_types = 0;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6210,6 +6271,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6327,6 +6389,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


