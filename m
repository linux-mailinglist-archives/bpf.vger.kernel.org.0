Return-Path: <bpf+bounces-76264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA526CAC2BC
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38C63073D75
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1463148A5;
	Mon,  8 Dec 2025 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/CtXLsL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE191313534
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175066; cv=none; b=fcP1PwbMrcgeA1bAGwiP5Xe+sIkvxM/jQ5SWkdLuTdlnMVLq5Q9efiFaVTXmaktfRkAlVjh7wWJf9vPFPd2Mb+bLLEzsanXSqJAYNzdLAgEek3jOxKeIrDH4OkeaQQn+8EvHPusTl7+2p4a1Wf8opuacvz8ujZZCYBm5wCW96mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175066; c=relaxed/simple;
	bh=SkiiMl3aCQEr+d5U8ft32wOaTMUA9E4gZBiYCpbgSZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUhk3V1BRCYzRyEVrDH0RT1pEoExbWSBzrxBXdjYmO4PtqCwwKtEhFJd3pcOCA8sqstnj0DmVKJr/ciQJrO+avKlo1JquTnqap671iPsG67PYgyD0+izVosG7p6rHwmKMo/vYHhK839xPnGA22G7cgiX8lxtmy4Z3hDWRx0pizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/CtXLsL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29845b06dd2so56080695ad.2
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175064; x=1765779864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QTcvpacDQDrdV3P23xBsLkdItSxCnXjFnIjmUhrbpI=;
        b=h/CtXLsL+tWIp47DX3VHrKi3BH9HPSPsQtJRjIgvUDH2yGIQ9nfeSlma9K5WDU4rye
         PUu21qHX2q4hMWNHkpQFSqhY5v0xc93eJzA8xVnS1CGDKF89ZDFnMIFqoxu3C82TmO6e
         z2j4IxQG5C40kdsq3jrYI1z8+goxxRSeML0MQQDaed4aPbUbkKvuEptZcDFDPhps4XCr
         AGEej6AkgY1ZvPJDO9ZV7ZXTpMLP3b6jDmk8SzqEobC+lFLL3soRJHzXJZTPhoyOENq9
         wKOpJ+qyUVLb1CBOs3J3YQ5WBnRRG6P/PB8OwcgjV0zn4WzuSBOOYu40QwXb0KKj2jGx
         wtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175064; x=1765779864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QTcvpacDQDrdV3P23xBsLkdItSxCnXjFnIjmUhrbpI=;
        b=ZGwPx3pNVQtKbpMS8x3/xTNyYPIIWddx2HquhC3ncvfjnnvkLR/P50OhhJrsu/3dL7
         Pvb/dQQ29JjeXZr1GR0evYRFwbilRhgjH3hICn9JhSoYvlPPjdyrEev5r3Xx7OD/yGD5
         yRc0+K0FoMgTBx7DYBUtSEfdX96KWxrJmRQk36NclM0mQ+B7SgG8WN2/BdXzMkHW9qlv
         Cnb8Zb2pXqBHG38ulFucz3gsJ0FRUVDIt4BugwerEN8pZjM6wfspeC9XHCRezyDB/1Zd
         +/ckNDj0YV7q88+3iuFUvS5K0Dq6XcqHbEZCaMCLBRzy4PTPq+1Xgey3riMuAsUeVLHh
         91eg==
X-Forwarded-Encrypted: i=1; AJvYcCWIVbhFKr/wbjHaMKjJ6w7TYJqgG88L6fHWocKtpHRvGrPWp7skrVheaN9/fibxIfW7YJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeqV/Mv5/Rd/jJLGuvfUsyuMplFbmayVB6uERfcjrlz0xhZn7
	qEjIOJVIhvbWoyKINJOFRuFqxj8PGost/Lv4I/+F/TGivYH+VPI6YtYB
X-Gm-Gg: ASbGncs5TXC16dlq9kjSGpO3wcz6L9mDD6cSTAPRdcXnfgIGXu3tHwx7LiTjcdKdveV
	VpoVPJEGYggcRFqpDzKEzWbmEsf1+Mpnh1U79MVCTiJfcOEsVrgXCwmVzLpXOM3EEUhowYqpQ5T
	rk4TkMIDmKIVCpLJakK4tQbgwlsOwsFFwCpDESCywMOAq6PXZsGk/32D9u1gCQoo7EL6EWoMjy7
	EucEiW5suCrO3OZRrVebdBSd2GbXl4MzA7wpPfOsrlQnXRuZLWs/zwxZZ7fV5ZbBQVuHxA8cOIb
	sGMNyFAMxcsbBJ1Fc4TT+73JIaBWOVwmTV/9ewt+SnVIVmQVqH449J7ne2RwEkWE3HsosL/HaBL
	AjyshT1eVnQ4T76ZJf1MX7Dti18BtJ0XF+odh5o/oFzATf38nRyss7qkfdc8AP3eS8OGL5J8RhF
	pFoH/1nHk6N7iBwV3FaxP1UZsJL/M=
X-Google-Smtp-Source: AGHT+IGy9ZHkYoDCeMBMkITpN3+AePbwh+IYnfo+UR/72sgLY/5EfSwCwoF5HbXDJD2v4dWdOPEYQA==
X-Received: by 2002:a17:902:cf0f:b0:295:1277:7920 with SMTP id d9443c01a7336-29df5dc065dmr62398555ad.28.1765175064159;
        Sun, 07 Dec 2025 22:24:24 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:23 -0800 (PST)
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
Subject: [PATCH bpf-next v9 07/10] btf: Verify BTF Sorting
Date: Mon,  8 Dec 2025 14:23:50 +0800
Message-Id: <20251208062353.1702672-8-dolinux.peng@gmail.com>
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


