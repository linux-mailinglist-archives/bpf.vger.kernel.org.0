Return-Path: <bpf+bounces-76265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDC7CAC2C9
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A0BF307ECE8
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DE4314A60;
	Mon,  8 Dec 2025 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnMuIIdP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FE3148B6
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175069; cv=none; b=QssLQCJiUmQmjV1MF6HFfuqt9DB3emfOUhdsgH28amWrLF4Pq7k+3TOb/6EiWZ31KbXVVBS40U3vmmcOst0pJk4+31LCqMpzl9rbymUQVJmvbt3mcB17PxWooqFLjYYHDykMmq0xR69G+ejW0h/F3Ha2GPug05c65Yntb/GtdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175069; c=relaxed/simple;
	bh=i7QanyYSi/r+PgBdCryQh6I5m7xPTm9Iqix4Q3VKzZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qb/rUdz95Qhz1FSZpSn40sr+04x1CikmTTcUhEaXO+sIffVljyljXWyPYINVWzDv1oKkMAB6BbJufRy+M4O2B6vywSQIjBgSlEDpZo+TMswZjG4DA3ZeChbJ6WcNBp4+cNE0pq6dxRfeVKeP0ALrukIeXZ7nKHnGpuiym6JhsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnMuIIdP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295548467c7so54072025ad.2
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175068; x=1765779868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Fz+H+Y9xd77iPc8boezvXQ6uLdCfh3xlXlYrH3URU=;
        b=TnMuIIdPju7kQMGEpbUgDAf/1Z0KOEki1Oxanpm//yDE4+UylorsFk53GZJXotAJ3T
         GKAufyO04eAOeuBHBFOO1LlmOu5Y92sSU/AZI/gMlYAMb0XyUwFx15wtSc9SpQgSsGnM
         HLyalj3qmcsWUPYFNhZ6aiWZcG+Q4jyo3i8YinJYlPJZcQs4or2JVg9TdrvO1P4zoRVf
         VAOvpHrvNtfLdQW/+57+DPbzrNr3jGv4FXB7Da/DmWAlKCc8kB/3FjHa/rCQXZpkr8II
         3rPj/uuoLF/RVQj53zwZf4byQ7bOrif+hIv1wopg11bTkkFjlGLvDA1GcKADz1tlMAoE
         PzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175068; x=1765779868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9Fz+H+Y9xd77iPc8boezvXQ6uLdCfh3xlXlYrH3URU=;
        b=iGby2VYTwt7p7kBBZiKtzKdFQjmrXnhgKl3WIR5pJBh6Uy7rUO2IfBmvZfSaAnqonR
         9R6g2hFQ/fMSjZFgnBJHTKrgPAjVrp67m7/HUhYEX+6tb41C+hpXhSEv6G6/yJIyRyaF
         fmXciB+WsSW6FiILugHHloZ7Pvb9l0s3jmv7rlU0ZexoHsIznvWL40D/r11kMjVmQGis
         sgV2sKRsm9hWOBZ8IIS+wkc13QavaZ9Xahjqhs92x4D+pT7dG0YBkY/X/c7NeMkAGNvM
         Qf++LYl0aTpe2KUHuA8v0S1yY7SNH2ZNSMQ+E0j0oBlQorKxtCXjTg7tlbBdyuv8Bqxv
         4bjw==
X-Forwarded-Encrypted: i=1; AJvYcCWuKn46iJ9cC8TtHgGnD7q8TWx4xwonT8RU9ppQ99BbNM2UgyLQ9Q8ZGnevvdNEqBwP+F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqC2BZvo6xPcCZVev9Z0NBZKy/wskhn/UGwHukYTA/bRXqjJq
	B7lu9uhlCdVOF1Q/OVnVzxTTH8+3HJj3A369v/yDptJHawUUcrRQ5pp1
X-Gm-Gg: ASbGncsdMBryLiyvDK15fRf4LXjQgdn8aJTKUdXiKFkpB9eMHfcBFmmzdT96/Cquyz4
	YRSUhrha87l8dIjxAaJPXQEBUTP0qfMgyMB5MzZDQIVFYGC0j9+XcJuqiqhn8M/eXBrew97roD+
	dZcAe3tnPAd/n5LSsbbyCdIgI/EE5wdsWo6TmbIprFBdCYo6AptRSDgEIBFrsUvsi7KDWgmrbxY
	NNfz9c8HiaZnWM9Jw4z2M39XhmXPrxPAM0b+QKndREHAOjHprKKNP12DL/LwfpajNn0wEsdFotj
	Xt66TA2FDbF6JKQlkQfKB+ZMjgDbmBF/CTCxHH4oVnXH/B7H/TplEbUzywlLjPXbUx/LUDpxKts
	YaCI/f4ar/Jz9KXo8lkH43xY5bn+cLHoFFYG+jjvT4un4IB6wLmPar1H6cxCDN6rc1od3iGPE3F
	p+wTxf7UC8U+gFAwGurzVNdlGGM+I=
X-Google-Smtp-Source: AGHT+IEcsc2LtgH3QM15NWRvotNsGzkF1f7ECf0FET9aNq28ZN1vpLBBARPtfOIx4sM9uf1KOSiEow==
X-Received: by 2002:a17:903:41c7:b0:298:ea9:5732 with SMTP id d9443c01a7336-29df5db8441mr55529665ad.41.1765175067626;
        Sun, 07 Dec 2025 22:24:27 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:26 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com,
	zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v9 08/10] bpf: Skip anonymous types in type lookup for performance
Date: Mon,  8 Dec 2025 14:23:51 +0800
Message-Id: <20251208062353.1702672-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208062353.1702672-1-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Currently, vmlinux and kernel module BTFs are unconditionally
sorted during the build phase, with named types placed at the
end. Thus, anonymous types should be skipped when starting the
search. In my vmlinux BTF, the number of anonymous types is
61,747, which means the loop count can be reduced by 61,747.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/btf.c      | 15 ++++++++++-----
 kernel/bpf/verifier.c |  7 +------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..2d28f2b22ae5 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
 bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+u32 btf_sorted_start_id(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 925cb524f3a8..5f4f51b0acf4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+u32 btf_sorted_start_id(const struct btf *btf)
+{
+	return btf->sorted_start_id ?: (btf->start_id ?: 1);
+}
+
 /*
  * Assuming that types are sorted by name in ascending order.
  */
@@ -3540,9 +3545,9 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
 {
 	const char *value = NULL;
 	const struct btf_type *t;
-	int len, id;
+	int len, id = btf->sorted_start_id > 0 ? btf->sorted_start_id - 1 : 0;
 
-	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
+	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, id);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -7859,7 +7864,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	 */
 	for (i = 0; i < nargs; i++) {
 		u32 tags = 0;
-		int id = 0;
+		int id = btf->sorted_start_id > 0 ? btf->sorted_start_id - 1 : 0;
 
 		/* 'arg:<tag>' decl_tag takes precedence over derivation of
 		 * register type from BTF type itself
@@ -9340,7 +9345,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	}
 
 	/* Attempt to find target candidates in vmlinux BTF first */
-	cands = bpf_core_add_cands(cands, main_btf, 1);
+	cands = bpf_core_add_cands(cands, main_btf, main_btf->sorted_start_id);
 	if (IS_ERR(cands))
 		return ERR_CAST(cands);
 
@@ -9372,7 +9377,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 		 */
 		btf_get(mod_btf);
 		spin_unlock_bh(&btf_idr_lock);
-		cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
+		cands = bpf_core_add_cands(cands, mod_btf, mod_btf->sorted_start_id);
 		btf_put(mod_btf);
 		if (IS_ERR(cands))
 			return ERR_CAST(cands);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..2ae87075db6a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20655,12 +20655,7 @@ static int find_btf_percpu_datasec(struct btf *btf)
 	 * types to look at only module's own BTF types.
 	 */
 	n = btf_nr_types(btf);
-	if (btf_is_module(btf))
-		i = btf_nr_types(btf_vmlinux);
-	else
-		i = 1;
-
-	for(; i < n; i++) {
+	for (i = btf_sorted_start_id(btf); i < n; i++) {
 		t = btf_type_by_id(btf, i);
 		if (BTF_INFO_KIND(t->info) != BTF_KIND_DATASEC)
 			continue;
-- 
2.34.1


