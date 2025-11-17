Return-Path: <bpf+bounces-74741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F180C64624
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5B15363467
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667903358C2;
	Mon, 17 Nov 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWaGHIDX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F50335579
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386016; cv=none; b=sWPDaFaLAI5nhxGn8HPVOOvLcTaYx7U//kVPjU/P7SiTPgAE1lP23YFYBQTEVihrzhJ5LcZT6/OpFli84gS+YWnLRdprc7o0deFE4mq3rFK4wy+cFfqJvOg6l8t0/slHmxlnVvJ1r1Q81QWg+yTLR+oC6EgtbkhqNoIovksqWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386016; c=relaxed/simple;
	bh=ZUKwweoi/8nzVzk7XZ/MU1Z+niGdx/B7murw68s/Bp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqVy6u6tCbJu7amTBAh36Kr6Fxjvfnck83e1mXU2wAhkjb8zlvlXt91MEiadwQonQO8AXyakIJBgm1bAzD1CLIROEnwNgdZQV8MOxjLXM/36NozCbkHlp1B0Vy3KnL4BLgidx/dZbxZfg4/wo0Eg4Vn4CzkdGsuAJfdgzuAGZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWaGHIDX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b75e366866so2285827b3a.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 05:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763386014; x=1763990814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUmHdLag/Zwi31gDv/2YF21TbKhBrlOl+Tx3LANhSGo=;
        b=OWaGHIDXAP7OGBMnmHhGk1TqhZNjmHjYNuPNG0QIJshfjw+bU0Zqif9IUUJYE5lQwE
         9iuW0MnbiiPcc8UZ/yClPlE9FbvxWulDNeB1T5dc0yzsq7YIs37VW28afkIxV84QiblA
         yLsoQhzpXzjvkyrcPXQSH6MRtjZzCrXrcSdZzIVX8rPRY8d1so3PQClHd9wo5HJZkA4e
         Ke00994j/pWIp8j9v9t/aaeEb3befwYT9DFi9ltCbjvaUQXGSgqBTT7PixKPRy0uRJWn
         u2/fxAqq0pxFbt82dOWYU0bBLR9hh15fxgnut+sVRy3A9tn5RS3lHFDIkfFp0v4WHFKz
         ihYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763386014; x=1763990814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUmHdLag/Zwi31gDv/2YF21TbKhBrlOl+Tx3LANhSGo=;
        b=WXsRie5l5UdH3VCdO0+FM8tl3T6ub57/4mV9rmfTsERPsBnKIrWBaMHDI47Iyma/jp
         X2+zn2yFPS906c/XXCJtdnPL5X7465cXPtkgjQIndIiPAOZ9eIcbDt+mGaue/ys2txYd
         H/LZSRv2Q2J1Bc0RQmgLNT2Ut5ANKe5QfWa2n1zcvV1cLPcmk0rF7AwzXlZ7OPMkSU7A
         cYo4I6KJD40M/R+3iGOmPONwKk9b+pkkKYMWJPLMLWaAiBHjffigKDguFtI6u/g+cxXr
         q+oTn2rxMOer9n7f8FDxAkfZAsLo/Qz7lwTPgqekOZGiiTiO1jR5hbE5uVRQFC+53TkW
         Forw==
X-Forwarded-Encrypted: i=1; AJvYcCU057JrikFT20aIjqS9P/QjvdRCPldC4K8eT35XokDTaEk1aeUQAQPFWpu0pMex7g9YFrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuesrApkYAL+nVTkQBu3iL37NAFzqEopN6HmPrNwid4VfyPvw
	q0faFTQIngcDLnj9pBnEclnw3KVUst2yecxw33mtWIsO2diTC03JfbU7
X-Gm-Gg: ASbGnctjJ/+o6fNc0nWdXBGRagcJ3PAyeeh5Iw7RPAH9Hz4kkHiZodR/w1jmZ8LQ61v
	CMUaBDRQltNyrzHrBFymwy23qG+5gcc0LBG5KtL0ilhY3CwUDhhMvM6CXfqbl5SpbY2UlaaVwCO
	YxKq79MB4SrO6oNdBQiVPajs4rzK5vIyDFt8qZp4gcwawVTk+OlEHQ7xxhTRUTl4T4H/jzDudTD
	N6nmD+CSQhJoxdtlGFwTSx44or4mdt2i0VptnXeAtXdEGL5g3+G5+IVxnbCdiAMAPZeeuIOwW3J
	bF/Asv5GPryJOrURsTe4Ha6DBCtMrFM/pFv+U3bhy4FpUnUlWdZ1bmObmX9bWbOtr63Sr7nK1Kp
	9KuYtoLov1RNNK9BqoDnkc1CZ/+3S2w+FDKKcbcS4wjANrmh6XO9tHIqnNev5Y88wYaw2hDfNF5
	ywc4R6BCDksobXC6+lFwhf7rZt8/E=
X-Google-Smtp-Source: AGHT+IH7nNeUVTI5MtzgwWkfmohW7BLPU8Ki2zP/T6SA+lyofQHTyXWYuBQSpmsX91Ot+Ie2xHqq2g==
X-Received: by 2002:a05:6a20:9389:b0:35d:6b4e:91f1 with SMTP id adf61e73a8af0-35d6b4eb84amr8682137637.34.1763386013790;
        Mon, 17 Nov 2025 05:26:53 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924cd89bcsm13220953b3a.15.2025.11.17.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:26:52 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: eddyz87@gmail.com,
	andrii.nakryiko@gmail.com,
	zhangxiaoqin@xiaomi.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>
Subject: [RFC PATCH v6 7/7] btf: Add sorting validation for binary search
Date: Mon, 17 Nov 2025 21:26:23 +0800
Message-Id: <20251117132623.3807094-8-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117132623.3807094-1-dolinux.peng@gmail.com>
References: <20251117132623.3807094-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Implement validation of BTF type ordering to enable efficient binary
search for sorted BTF.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5dd2c40d4874..e9d102360292 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -550,6 +550,66 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/* Anonymous types (with empty names) are considered greater than named types
+ * and are sorted after them. Two anonymous types are considered equal. Named
+ * types are compared lexicographically.
+ */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	if (!ta->name_off && tb->name_off)
+		return 1;
+	if (ta->name_off && !tb->name_off)
+		return -1;
+	if (!ta->name_off && !tb->name_off)
+		return 0;
+
+	na = btf_name_by_offset(btf, ta->name_off);
+	nb = btf_name_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+/* Verifies that BTF types are sorted in ascending order according to their
+ * names, with named types appearing before anonymous types. If the ordering
+ * is correct, counts the number of named types and updates the BTF object's
+ * nr_sorted_types field. Note that vmlinux and kernel module BTFs are sorted
+ * during the building phase, so the validation logic only needs to count the
+ * named types.
+ */
+static void btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, n, k = 0, nr_sorted_types;
+	bool skip_cmp = btf_is_kernel(btf);
+
+	if (btf->nr_types < 2)
+		return;
+
+	nr_sorted_types = 0;
+	n = btf_nr_types(btf) - 1;
+	for (i = btf_start_id(btf); i < n; i++) {
+		k = i + 1;
+		if (!skip_cmp && btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+
+		t = btf_type_by_id(btf, i);
+		if (t->name_off)
+			nr_sorted_types++;
+		else if (skip_cmp)
+			break;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (t->name_off)
+		nr_sorted_types++;
+	if (nr_sorted_types)
+		btf->nr_sorted_types = nr_sorted_types;
+}
+
 static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const char *name,
 						s32 start_id, s32 end_id)
 {
@@ -5885,6 +5945,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf);
+
 	struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
 	if (IS_ERR(struct_meta_tab)) {
 		err = PTR_ERR(struct_meta_tab);
@@ -6292,6 +6354,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6426,6 +6489,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	}
 
 	btf_verifier_env_free(env);
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
-- 
2.34.1


