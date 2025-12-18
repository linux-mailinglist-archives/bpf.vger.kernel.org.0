Return-Path: <bpf+bounces-76977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E31CCBA2B
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 12:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5975C3100586
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5B319871;
	Thu, 18 Dec 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WASuQfaY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA272DEA83
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057498; cv=none; b=i5h+0OMv+UKnBSSq+L9gQ8YZsv8GJWMRxkv2mJ/ldUznWTf57z5i2SuqcnaJjxoLpWWibAqVZrLLT/S4DLBzlgK0oME1nJGhP+B8lj2v8fSFTSBwlGEGzY2Dx2RfhNnvLbHTDa774EwwCHnZO1V7aXSHiXvWgvDLFrl7efJJsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057498; c=relaxed/simple;
	bh=KvaJlRaiUe8MkAKXREkrMgArNu7n4FxcgCEAlQluXAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNDDqY+h6iTmKHBSqHrEfDeaJGGE5Tpe05+Z3FsLYu+tRFlGBBhlX7tujDHAWEzh+PyjoHkuabYmZMD4CHcicZ4+xxZQuY1+nhbD2KYR5Gvy+RqIbZRUMKl+7bsZn0ztasow6L67IMHkydu5U4RC7WaSV8YD79u/e9yXrbGpWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WASuQfaY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34b75fba315so567307a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 03:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057495; x=1766662295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9wcZC55VqhhbPSAYuLEBFuNZUpMeWvJuY6oSbLgmgg=;
        b=WASuQfaY20GsSj3jQzEUzF4td6Z9F0w2pz+IhqUr3HUOL6AYPlKtBqwEdh0MmhtnPs
         bkxYpWKFoYzuw5DJy7p1gYv9phTkSpr62aPzfHhC+7HlYnLoK+1lGdfPPXc+k2t92BSr
         6ZQc/J+Did3outr/Bs21TSiboUp/loJqiz3WKJ1bRCm6TkUA8QzMEUzc5uUZnQR32SXw
         t0FlZGc6gJJSSmLyZkPq60BRN9RkD3dX5BiGyEZsNWgPlTZPKgy8pLmMByV3nmDMTrze
         T1eIQfT+9KG/ht+AsLMf3cV8b1Bm4w0BRcFXaIu6QKE/W1r2eakjO/zOhKQDyuG/tDLp
         Z+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057495; x=1766662295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9wcZC55VqhhbPSAYuLEBFuNZUpMeWvJuY6oSbLgmgg=;
        b=lUUGol3lmxRflkZrL1lIozl4fzRGKW9RTri/oodu//BUys33FF4+6sl49fTOASycoT
         VSxViHUJYTsJe2Y0uxj6A4uGtEoDyELwXLwfVoOZpr6oChtPt8swUob/ZQGXcT07cPSd
         Mo1NUYn05J+twYeUG8sIVnINc2Bmy05rVUYDAsX4wdewDzbggnAzOWzRzt27ipv9QIo7
         FR51dmFgwvDdcfnZiE02Y93KqZrdccbXwYXX9ljWijmX4zKqHHC5zeOh4qOoiRvAab8y
         U1stZI3JttcdaFnq4C2yUfYr38LgSgKxWL4OtUlK/So9ERjgmamFJFw7JaXAfjf+DANf
         qB/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUWsb7FQloFQsNhhSc2Af+ld1n+f2xTm/RIceRjjEszmt3tPlQ3s3+wY0e9sUz6d5T2mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MqVc+qSePSxYqDsRzVYY8T2lP9qwwCXv/IaEQ8Y3tehHSoOj
	YjWXSdUXUzfgvZp1S5HemFmZAhJW4X+h7rmWl9kZX+rc3dyVUbwFo5Ju
X-Gm-Gg: AY/fxX66kNTY1gea80Rek/KjZEh/hr09at6GlHG6Y8x1V4fZUK3OcT28pifrMxITMS8
	pCJuFRCWkUpDBgjt0m58u2NtAy1iTDpcfxO8/03ePdp3CFbdE8XF49K+mLlnpRnoyc1nwOhyh4g
	rFs4v1YEC4RtUCBYeKXRTenWS+Tip+Vv1psJBKDNTJQ6HdrAUlitXTpZY+TnKYkyBj3Ol+4enfQ
	jmfLdTAAbvpdzUyJMFs+9akgpUtrKwvkLjKDFBAIdlNkmlOfHwk0QFMSCRLcGoddZZQZA2QQSdd
	zM9kOQxZGnpIlO/gKDbctLULUoAUSznrxNslJX8RPmUH0hB5cx1+s9ucrSVbD1nEY76ybw91E4g
	Uz+f1ehn5AJcBQ332nFEK58Lz87DlFo6WVkL+YkBxLkF8KeeaP/ulZEpfCwmriFFHVwDV0/ZS5a
	BDtLMh0Klo/EEPeRocJwEFO1vxlrM=
X-Google-Smtp-Source: AGHT+IH6ci0tvt9FeyZRLVqlq2jq6tgQFC7Z53yosxENZOca7GsIes90pwCI3Ro/ideYOeQxsqwwwg==
X-Received: by 2002:a17:90b:5109:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-34abe3feccbmr19217290a91.10.1766057495472;
        Thu, 18 Dec 2025 03:31:35 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm2328237a91.3.2025.12.18.03.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 03:31:34 -0800 (PST)
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
Subject: [PATCH bpf-next v10 07/13] btf: Verify BTF Sorting
Date: Thu, 18 Dec 2025 19:30:45 +0800
Message-Id: <20251218113051.455293-8-dolinux.peng@gmail.com>
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

This patch checks whether the BTF is sorted by name in ascending order.
If sorted, binary search will be used when looking up types.

Specifically, vmlinux and kernel module BTFs are always sorted during
the build phase with anonymous types placed before named types, so we
only need to identify the starting ID of named types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0394f0c8ef74..a9e2345558c0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/*
+ * Assuming that types are sorted by name in ascending order.
+ */
+static int btf_compare_type_names(u32 *a, u32 *b, const struct btf *btf)
+{
+	const struct btf_type *ta = btf_type_by_id(btf, *a);
+	const struct btf_type *tb = btf_type_by_id(btf, *b);
+	const char *na, *nb;
+
+	na = btf_name_by_offset(btf, ta->name_off);
+	nb = btf_name_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+/* Note that vmlinux and kernel module BTFs are always sorted
+ * during the building phase.
+ */
+static void btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	u32 sorted_start_id;
+	u32 i, n, k;
+
+	if (btf_is_kernel(btf) && !btf_is_module(btf)) {
+		for (i = btf_start_id(btf); i < n; i++) {
+			t = btf_type_by_id(btf, i);
+			if (t->name_off) {
+				btf->sorted_start_id = i;
+				return;
+			}
+		}
+	}
+
+	if (btf->nr_types < 2)
+		return;
+
+	sorted_start_id = 0;
+	n = btf_nr_types(btf);
+	for (i = btf_start_id(btf); i < n; i++) {
+		k = i + 1;
+		if (k < n && btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+
+		if (sorted_start_id == 0) {
+			t = btf_type_by_id(btf, i);
+			if (t->name_off)
+				sorted_start_id = i;
+		}
+	}
+
+	if (sorted_start_id)
+		btf->sorted_start_id = sorted_start_id;
+}
+
 static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
 				    s32 start_id, s32 end_id)
 {
@@ -6296,6 +6350,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6430,6 +6485,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	}
 
 	btf_verifier_env_free(env);
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
-- 
2.34.1


