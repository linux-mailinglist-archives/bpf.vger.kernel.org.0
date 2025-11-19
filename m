Return-Path: <bpf+bounces-75041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8322AC6C99A
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 04:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12FEA34F66F
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 03:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B302FE057;
	Wed, 19 Nov 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdGVl9Zs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD32FDC24
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522525; cv=none; b=HKqcP600dt9wdWJbgu8vZhxojwQKlaNypH/jWRylzO3ztnglmGK//mVjUQdLnUcvZCLzyZwaohpWkv71dG7zWgQT1fWeOFrdw8+iiq7cZ3i31w9W/EcLfFhJ4RBv5ADHI4R6ioDQW07hXJhRvVupRIyGbuW4lHvOuvFPDdowpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522525; c=relaxed/simple;
	bh=ZUKwweoi/8nzVzk7XZ/MU1Z+niGdx/B7murw68s/Bp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KP17U07kp36j4qYqBe/XjzSHgIi4f5B8GwBXJD9Mwpl6b3jlyihiTHxa8ROsB2Ck65d+Ojw8GzkS895n/GuxRu4lMJbJe9I8cv3Kn9U/IAaSn9Mlzs60fyFd4FVp49atFsL75wv5e0CH1bth+bIzxxCsF5mq/3LUl8kgKdFcV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdGVl9Zs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297ef378069so58643605ad.3
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763522523; x=1764127323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUmHdLag/Zwi31gDv/2YF21TbKhBrlOl+Tx3LANhSGo=;
        b=NdGVl9ZsbbzDLLmFX26258QD7CmpTG/7tlEiiG5O/z8FeYhd3AlnkQknAlp+vPz5uB
         m5ouEedomubjMf6fslIsBRWESdnwiwld5G8pE/IlXeVQgRCArkEsafz+PIlrbYaq1faA
         gxj6koyT9AYzEItxchEwJ/5UgOGZXuTUF2mNcTXuVRGJgtr7y+rrWTv/EQ53VbP+EZna
         iysw0NnTwK0WmsTmdiMJ1zVCEUntWOtiXjj0lkGLrTQXlSy4ceKdJX+cTmWyCWySjY8n
         9ysnWnXbFDSZZzJe8srS6LzQFsfTWCoTgVK1hAidPDI7TPOsAH7jn4PkXCetjUq5VgDJ
         zT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763522523; x=1764127323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUmHdLag/Zwi31gDv/2YF21TbKhBrlOl+Tx3LANhSGo=;
        b=Bjf5HEqMDdet2qpquKOS/F+FWnk0eNXC22tFUtNjQTZR5fXn+qMZsCUCrPRm3ye1WY
         aA0D2KcwEvX6gk4og8ZGWhNRHv7MeqkNcMHM+ARFEljjiM9kf+/oCHQNO/O39ST5jOM2
         88GqZ83yRN9VBs3hFIpIQWY9v78FQ9JEeSJBWRcu5gNNUxLWXElejH6H5ZsRwX29xanQ
         gYVSL44rTt5Ys8Odu9hujRpYQ50sA/2Cy8tDh5wBxQLDB6PyhNXk+OppO9uoLUB+ZXNe
         i7P4G7/nYw3IzhObrG72EYajPRUDUlGjqkbc0gWyBsXW3Fk264MtJCm6kklyinSR58FL
         ePYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXTKnDr/UjQEVhUIMQ5m11Rd76XqdjE+rbGPEdxbTMEi/YkbaGZf7NaMRLQTMX4Huaoj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WY+q7/au/E/TkOGgIGcwnOv4Ng9m8sknjKepLu0t9yrDJcqs
	C7PDUWVSD6zAetZIg2I6k3jgXjXxcoyI2aUtTt4khZG3Qe9XKy3yzRYw
X-Gm-Gg: ASbGncuAiOUSpl8aqj33ULO3Mjl+2kfIsJx9Gj45+y6DGyB6hnBT0KEK/eS8FB7f8eo
	1EC1ir4s/wbcwDVF3ioPJMf9ZwJevz3C5yNfq7CkVlnmDaNcMsrvnvjjMEmJlzkwYy9q1MqT2Je
	eurWJqvOquq3JBOdKQNbV/S6H9YXJ1IBkXPGMtykkDPeHWRNtshsPKfXNSUqMOH59ytMMTTpT9R
	P/8uLtMo7HjPy42JjVT34ObRBlga2J/WWPDUL0qsVvFprElthKSdGbKwvHzcJiNSCmYsEeJpuCk
	nLwLsLDIU0rscKjgFpaVErlZGhTI8CuMhXZ8BJdY/ixrHRp8cyW1YJJljrOGRR8CUNV3qOKuz7G
	9jEEwpuxUBXtE8Tiu4LkNtnBh/wm97SiB9pMwUtfYlTDL5cCWE4Zw2Px5uSgazQlpRavQ65SKkK
	QvG3JJtwcw4bxGiSNRSNelj1RoMAc=
X-Google-Smtp-Source: AGHT+IHpy1Aqpxs2EzkI3ifWZtaJJdDt7GcvJc8PdwkSqxfsWG9Ez6wqPI7Bjanrx6M+nXK35mM94Q==
X-Received: by 2002:a17:903:2309:b0:298:34b:492c with SMTP id d9443c01a7336-2986a768210mr245315575ad.54.1763522523402;
        Tue, 18 Nov 2025 19:22:03 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm188352485ad.88.2025.11.18.19.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:22:02 -0800 (PST)
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
Subject: [RFC PATCH v7 7/7] btf: Add sorting validation for binary search
Date: Wed, 19 Nov 2025 11:15:31 +0800
Message-Id: <20251119031531.1817099-8-dolinux.peng@gmail.com>
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


