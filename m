Return-Path: <bpf+bounces-75557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9875C88C41
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5213ABBBB
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690E322547;
	Wed, 26 Nov 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmW18q3w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480331AF31
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147057; cv=none; b=oGj/pHmEAVbn1tXv69/Tm2M6PNQkARBVlfVPPrIjuBETGfg9dyky4rJLuY/p1KJ02fSH62oaxWTS3POQk/wDuUBh7RKQ4w4OPLuqFFj9HTKQ49z4PcdueZQP44g48T6cpSEb8kHUs21FhHoZhMVGl0uapDPUwG57B0SkVRFClOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147057; c=relaxed/simple;
	bh=SkiiMl3aCQEr+d5U8ft32wOaTMUA9E4gZBiYCpbgSZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZSJUzS8fwrMZqrJ6rxNkteHrHnK8dYzY6fnDfoZ2Fk3aN4ZpvzLgNZ9ghsCea2VjFmIFtBvpwvMWb4nlgfBvEGt1WXlkmbclA8efQ8KpS4dp7+rOTyKkWkjFjv97iAhrl/qSi65C3kRJlS+QWlcsMtSOa+7/Mq0RvKpgR22G/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmW18q3w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso9810273b3a.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147055; x=1764751855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QTcvpacDQDrdV3P23xBsLkdItSxCnXjFnIjmUhrbpI=;
        b=hmW18q3wDsJHOXz68dAzlRC0fNduPF93cVq+J9aJmBID50Re1Vh72VD28qolB9Jdjc
         NxxPsiZgWqViI9yeZpBLXXZggdJ02kOoq884KzSXFdSq5u9hHe5XjsDSjhNHIAP1o+Zg
         JmLllg4qqW/C4QVMVcB57cER8ttVQEzet3UY4+bFEFRwA5g1YItaNmi7HL5z8+868fvW
         A0fbxmEtl+hx3atmjWaO4HUAO3qchh3TYnYj5iMskWLJbatg9qzSmgRfJEetSYPXPx/I
         f5nt5q8/gB6CGJWtTVXi8y4vHGRADFnFSyiZCJTaE7edSOL9fG0IdVPY61Lsns9sTAHL
         wdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147055; x=1764751855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QTcvpacDQDrdV3P23xBsLkdItSxCnXjFnIjmUhrbpI=;
        b=f9VGduIDConi1WXazTW0hpGZYCZ9FHuDhhWSDv6Dr7zIdNwP83q9mAVmXEau09xlZ4
         iDobufzKnRfa5Qu9eqCF9nncsd6RdZNRcg7Pv2lyA7czBObIpXfmUOqC9x0aJVe0B1D2
         zPKuwDXV0hmfDTS9IhjM3Kz7o60eLsTLOcajabVkUD6z/uwVOPrrncuGBe8iGqNAfzdl
         T+T5us4eotcl7S1fgmGk5ITwgWglVc5bzoC2olDtA+/fpvrcFrRrAyFYcgS4NsVM1xLr
         JEGSBqdJvtwMjOfL5V0A128DsBEtuK8lWRVGCaDTpFQxXYfB0WuMhJJKNta7QlFt/Iz6
         G96w==
X-Forwarded-Encrypted: i=1; AJvYcCVqanHszdtzbWzuOOiWqZ1g+J2ZVRFvieOFCcUaRVW0q9aRf2J6uECxFCXc3akqmD2LpXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqKgTfZ+oxdcT62OEc2qmaN8ogXv9Kr+gNdcUwFj05QPlIkA8
	SS7VvRRn1DKpipnUU74IpaK+0l1kQyJP/IfuFeodhGh1BRjLOx1I4Qyc
X-Gm-Gg: ASbGncuu8J3sEWNcmWcie8BH8/X+euFOaA2zNSXi8a1+kYy0a5Yv+5AOh4S/pqweZ4m
	VBbPfNo3LPke9x76580PRkQeaoUFe/m8JsPnMBnzlgrPiolQ9KFI9+0hmCJYEy+UK76yw8D89t1
	55ivosQD4ICUjZI0hRfVTO3zR00vKNAmRmNDS9ar2heoyH3bB8GJw4tmVRc/miMtML7nE2MoaOT
	jXybq5fKT3skf/KA7zztK/wm7ogvZVP+srdKA0jAh+iCkORjJGTeNQYuAEcGf4Ae47WssmvJEA+
	UBgOplKA+z1qFjn4FehxYYQyUQJKrVDnDBmytEhDyq1Nj1g7nSLjOhq8IXiePPxQBvV28R9tO3d
	H2rzG3g6VOPOpiqMDnBz83jY8t692B1ASCypDAdki8tToyCTPiBJv7iDu0zAHpPz5jPqk1iSncP
	R5SiJdoB+34aIPzKxiROzXF4u3JL8=
X-Google-Smtp-Source: AGHT+IEc75RcYRzyB2QjrAR9JxTghgDBcvpbAyHuxNPUY2qamQHEbD1gRabTOEt/ypeNrmjMsOdUGA==
X-Received: by 2002:a05:6a20:748e:b0:35d:6bbc:e9ce with SMTP id adf61e73a8af0-3637db64599mr7017524637.16.1764147055433;
        Wed, 26 Nov 2025 00:50:55 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f023fd82sm20885721b3a.42.2025.11.26.00.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:50:54 -0800 (PST)
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
Subject: [RFC bpf-next v8 7/9] btf: Verify BTF Sorting
Date: Wed, 26 Nov 2025 16:50:23 +0800
Message-Id: <20251126085025.784288-8-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126085025.784288-1-dolinux.peng@gmail.com>
References: <20251126085025.784288-1-dolinux.peng@gmail.com>
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
 kernel/bpf/btf.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 842f9c0200e4..925cb524f3a8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/*
+ * Assuming that types are sorted by name in ascending order.
+ */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
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
+	bool skip_cmp = btf_is_kernel(btf);
+	u32 sorted_start_id = 0;
+	int i, n, k = 0;
+
+	if (btf->nr_types < 2)
+		return;
+
+	n = btf_nr_types(btf) - 1;
+	for (i = btf_start_id(btf); i < n; i++) {
+		k = i + 1;
+		if (!skip_cmp &&
+			btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+
+		if (sorted_start_id == 0) {
+			t = btf_type_by_id(btf, i);
+			if (t->name_off) {
+				sorted_start_id = i;
+				if (skip_cmp)
+					break;
+			}
+		}
+	}
+
+	if (sorted_start_id == 0) {
+		t = btf_type_by_id(btf, k);
+		if (t->name_off)
+			sorted_start_id = k;
+	}
+	if (sorted_start_id)
+		btf->sorted_start_id = sorted_start_id;
+}
+
 static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
 				    s32 start_id, s32 end_id)
 {
@@ -5889,6 +5943,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf);
+
 	struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
 	if (IS_ERR(struct_meta_tab)) {
 		err = PTR_ERR(struct_meta_tab);
@@ -6296,6 +6352,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6430,6 +6487,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	}
 
 	btf_verifier_env_free(env);
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
-- 
2.34.1


