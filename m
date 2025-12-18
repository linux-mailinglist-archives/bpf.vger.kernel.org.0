Return-Path: <bpf+bounces-76978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA9CCBA01
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDBAF302C5E0
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2593002D7;
	Thu, 18 Dec 2025 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD2iNS3L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500031A067
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057502; cv=none; b=CBMsp9gJMWXUOzGfr+i7/8wFaiemUBAZly3w1pMc6IHgWdqrJRFye8xtTqyWugJQoxdgD8t04huS2gLVBsgU4AX+S11Y2A8sQS5nfmlRPA5m9AVXsKVHrRDKV5mwAM7ugcyYxC8WxvLAKIlCHHlZNNci+vwtTdU8l89kes1IoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057502; c=relaxed/simple;
	bh=e4PdXHzqE2jWb1Mz7VBs2Ivn5mRVqnf4USlw0IL3LQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ka52fbU2LzDbqMeA2VYPSLPYJNXfMoGDjF47F9VuyE0/3Qsf1pYP+FfZcK/nsNCove5AT1079CqP57xSolss3PiSR0MkeRzUMYYjOxl4XYdkpiD6wd4XbDZvWuPyv2O4+elzg1pL5SSWnunvxnTQYWa9xeMcNp+kOu9A/6cH0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD2iNS3L; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c20ee83dso6592955ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057500; x=1766662300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4ua/Mfoorz93gkg4ZzzsoaKq2Zva6tuuEtR6k0T5nY=;
        b=mD2iNS3L6DSfQszNGOnft+OpQeMiBf8RjgEF6yLadDyH/X/nhRQnG5y97VtqoqaH5S
         i1dI9eN2LkySO1T3v09QHRyoshQKBGLFuoPUKr+7wgpo/949sUj04Zb7vxlE6Q3guqm9
         +9oax0k8piB7thXUoOKZK53K94tkPXTB5IRs6BPZ4hYaGVrDVX9/QvHUMtFHbmqzGJlr
         4YjF8WqrgN08ocYK15LY++hPLXEUPPYMdZEtP0Y/amrADs6rdeSpVSLBozDtfBRwGvXd
         YIPEy+insnFpxr6r5XXGjiFkPtE68lGLYWy2z+vf2tdevxopKwutbKPOr2oy1579KcwY
         5EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057500; x=1766662300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q4ua/Mfoorz93gkg4ZzzsoaKq2Zva6tuuEtR6k0T5nY=;
        b=Qe3iLQunVTqyZ+dnHybOIkXPH5NDQSndfV3/G4IMHYr7cRLJb24QxdtsCUAI15/Um/
         Q+QX60y7AR6UTsmBhv/SxwcBVOavWQGTvTuApRQGRxD67eXUyNTyuVVMcyn+iXV9twaP
         eUJcAybjQM34gmTrZXqHL4eix5lcBk17LajksMzyODre/eYDgtwVxTX8skXJNzCQgGIO
         VlxyJwOUsxlQYFCxc5AAAPYtE+c34iPDVSFCPM3I8y34OksXmvxaBzuVPU0MwfG3luFy
         FVt99Wn/UIX8ouaO5C/JA8qojoQItey6pejh+rKyp70PfFipNCbMSahWBwXqBRwr2V1G
         DP8g==
X-Forwarded-Encrypted: i=1; AJvYcCWVrUDwTyiRWf7eweDikgGEvuqNSVLB1Gd8wYq6HSDSyRNnqOnoGwyGIN5SmQONgZ2w2fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOU06DacDvZtDA6aj9BZI1eg0UEZNVZ8XgTWw7Mqf/EEfL7E1v
	4rYTSGtH5ZOPKhT0C2fKydYQkFtPpSzpyhxy3dAJi2A4W7Kl0/eCspsk
X-Gm-Gg: AY/fxX6SJ9w/zWvTSRja0Oq19tRXbi4rqI207XvC5XzUahA7eZUvROAxWDQnWgmGcH6
	hhOrvfYlfhGCtsNxSXIyfBG56V6a1KaFwHTTUJbm+XI/wnNEDGuSLRT5NOh0uYvIA7JNOH1N6wM
	m/BU+rt3aKWwUFubRSI1Q41jiOpMdGMM6Do5Z3lMExpyK7j8tQ3CpV/KsgteW0yHVe9HeSK2M9M
	aMgbPrIIHFCl1fMCpSI2v3DThxJBa/28xo0XRXrzQ4mRdlzctqMBVzv0eeuSS1rNKj584ykm9uJ
	2MsajluDrx/F5Lp+YjhAD9EPes9qsgdMI5m7XeV6ZsJHdya3beIzFz7nBK7fhK8JcCt+HjpGMes
	6ApTH+RXhziqFNZHzw3Ym94wLK+x77yV2Vw46aAMsPGNRZIAWEDdaV21mCC9dGnFTzhmzGFckc0
	nvlH5MPrJOGBksqYdAy0OijmFnJdU=
X-Google-Smtp-Source: AGHT+IHwEc3GSxPWRabZgzS1RVEcFDoMz8zwnEifDJsenEmzvMA0MJNr47Yymxi+cbS6e1uISU046Q==
X-Received: by 2002:a17:90b:1dc6:b0:32d:db5b:7636 with SMTP id 98e67ed59e1d1-34abd7853bcmr18909720a91.27.1766057499551;
        Thu, 18 Dec 2025 03:31:39 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:38 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v10 08/13] bpf: Skip anonymous types in type lookup for performance
Date: Thu, 18 Dec 2025 19:30:46 +0800
Message-Id: <20251218113051.455293-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251218113051.455293-1-dolinux.peng@gmail.com>
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
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
 kernel/bpf/btf.c      | 24 ++++++++++++++++++++----
 kernel/bpf/verifier.c |  7 +------
 3 files changed, 22 insertions(+), 10 deletions(-)

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
index a9e2345558c0..3aeb4f00cbfe 100644
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
@@ -3540,9 +3545,14 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
 {
 	const char *value = NULL;
 	const struct btf_type *t;
+	const struct btf *base_btf = btf;
 	int len, id;
 
-	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
+	while (base_btf->base_btf)
+		base_btf = base_btf->base_btf;
+
+	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key,
+				    btf_sorted_start_id(base_btf) - 1);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -7787,6 +7797,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	struct bpf_prog *prog = env->prog;
 	enum bpf_prog_type prog_type = prog->type;
 	struct btf *btf = prog->aux->btf;
+	struct btf *base_btf;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t, *fn_t;
 	u32 i, nargs, btf_id;
@@ -7852,12 +7863,17 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 			tname);
 		return -EINVAL;
 	}
+
+	base_btf = btf;
+	while (base_btf->base_btf)
+		base_btf = base_btf->base_btf;
+
 	/* Convert BTF function arguments into verifier types.
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
 	for (i = 0; i < nargs; i++) {
 		u32 tags = 0;
-		int id = 0;
+		int id = btf_sorted_start_id(base_btf) - 1;
 
 		/* 'arg:<tag>' decl_tag takes precedence over derivation of
 		 * register type from BTF type itself
@@ -9338,7 +9354,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	}
 
 	/* Attempt to find target candidates in vmlinux BTF first */
-	cands = bpf_core_add_cands(cands, main_btf, 1);
+	cands = bpf_core_add_cands(cands, main_btf, btf_sorted_start_id(main_btf));
 	if (IS_ERR(cands))
 		return ERR_CAST(cands);
 
@@ -9370,7 +9386,7 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 		 */
 		btf_get(mod_btf);
 		spin_unlock_bh(&btf_idr_lock);
-		cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
+		cands = bpf_core_add_cands(cands, mod_btf, btf_sorted_start_id(mod_btf));
 		btf_put(mod_btf);
 		if (IS_ERR(cands))
 			return ERR_CAST(cands);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6b8a77fbe3b..1a9da59d8589 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20651,12 +20651,7 @@ static int find_btf_percpu_datasec(struct btf *btf)
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


