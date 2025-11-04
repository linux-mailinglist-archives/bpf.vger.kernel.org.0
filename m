Return-Path: <bpf+bounces-73438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24925C31484
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 14:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DA114FB737
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AC32938B;
	Tue,  4 Nov 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfS5D4fc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2A329C77
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263664; cv=none; b=GcCshO1bFhNOIYY5BVXZI7eQtTcsDbPXxVBf0qwl83eEcSpdmtfCamjpVhLfCc83We+REz5Pvqc6Adj8loyoWfImHCQyrB6QmO3mK0SuSIqk8XgoDRBsP8RxUjE05OnV41VeAKscIjsO8722Locc4WYXSoJc3QaqDPPvq0sErvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263664; c=relaxed/simple;
	bh=YhPYNJZFXEH3DqLl890OXpoNt5wtfd9zUXgWwSlWmnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSe5tNmE3EJqBu4M60I8FTjaqX0Mo2r8RAYY8SSAfHlsJqG4EvbJaE0JZ7lV20yimnFyFXXoKbR7kC4/pogdHCE1BNkKuYD1ITN4GCFSPKyh8GEIMJJ+BdydJUJZlfAcCqimAQad7zV8KMRv4zKjQBNnvkxj2DzfZIlobidIs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfS5D4fc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so6818312b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 05:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263661; x=1762868461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyvKaozorZTBSzeG44mKs2zUGk0qFaFKA//27+I4xKM=;
        b=dfS5D4fcrgyqiSQdidiGLa61QLnTQsQJeSHCbxDYhtkwtYJnXOSxXPnJX0ECNB6tbZ
         kMpQ317Wz0ZxvhitZSXAQmFlJBMz2gQCKbtE2yckAXrqr/pkGhB8CRLe3m3hsgM3roD/
         A9K6QWYkR0LhPm3/DAgY4VtleMVpxKImBPuiP15gXsoHiQesJdMMdSEM97xSuHhG6+qY
         Ie1D9u5XNh1a1WB5gLDKNh18Fb1uDhD1rpyI+tfI53H80gouXd7CGxC4+rIK3k/XHtPe
         Nh2lo4morJo3d/sXdtpC9gF8LrEjvLNMy89Iw6K+dUy2psRKyMIeAwdp9zDxRSi71vO5
         UDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263661; x=1762868461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyvKaozorZTBSzeG44mKs2zUGk0qFaFKA//27+I4xKM=;
        b=X8F1Q9UBE1q6FVjUHvivrCAejySYSw/NFpT3alte+L0rjIRjGLyhKt6o3QQFSowjDQ
         Peuhs5ToQz05+PqGLwhH32JoS63ClYHH7OF9rO6mWTvkxIfvF9j4a1nhfZ4jFnmlrKRZ
         dluZ1G6zWbVUS/loYlKOypU9CLaCS02JcV9j7bpYO8uBKyi6a0C9c+J0mQ5dYK9Ac/WG
         150dhVMWcBf87oz2IGWyE2BoBxinyLFtzTRQVkyVYSu7u/8CLQfgPtD7pd+quynwafkx
         lp+S6gPH8pTF4HrDRroa+ni0LstfwdNqxI6OSD07MegBnpZDsR38eVGn16LUoxs3AXXY
         lV7g==
X-Forwarded-Encrypted: i=1; AJvYcCVKBfP8kkj/0kscOBwhDTDjIY5anlnMLMMnWNjztX0Z6VpbCZsgBScoQVaAPbCxnNTr9Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPNr/Yedp99sFtKPaNLTHH+VUteFnr8b+MmnwKUfRLk2b+EYY
	CRyEX75Hokii0KSic5jSt6LzsWjglB//wcwN7CXiy+ZNFB4ykwNEb8XO
X-Gm-Gg: ASbGncuu80zUbsSW9QlTq+UL5U1a9AyOprxK3+WR1tLZkTf5J/5oyA3lUiDOznCl+gJ
	eFm9d37E4g1+zKCBOZa64UORNdS4iKqdFWOVY0i0q//vUBV/pvRjCzMDXQbfrZrYd5OiY2o8vMi
	lD1x6Rr3ayREILjtKzUQA7ENa1ena/zTxd6x7j6ZhECpfpfztdBdNEl3bf3xnQb0Be46q3lbYsb
	OKjTf3kK9sC7Ua8CQ4eWKa93Bd/+InTXWDJxl1xF8PXZ0wnVSDhJLjyHZG2Kx5uMZu9ASF6UX6d
	cvkjyqE6pRehkIkndnjoktEu0+P+TpKgdINf947Xco4hXlb351fjnjJm9ttQySd/BZxM+mQl8hL
	i0bDcZWGfQ455otfapZtSC3oUSjZcAtbIKxJxJbv6w8+Po2n4VrTcNbAiMSJZwlchmhEYkYaDzl
	HWHoFLqeaXACQ44pTm
X-Google-Smtp-Source: AGHT+IH3DRVhPlh4emSZg1dm1+iTAic5V+qWeWDSQkHbTRONigJBsNgybx0L0pzSSZX0CG6cHLsNRg==
X-Received: by 2002:a05:6a20:728a:b0:340:f36d:6b03 with SMTP id adf61e73a8af0-348ca15b031mr19019665637.9.1762263661522;
        Tue, 04 Nov 2025 05:41:01 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2499238a12.31.2025.11.04.05.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:41:00 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Song Liu <song@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v4 6/7] btf: Add lazy sorting validation for binary search
Date: Tue,  4 Nov 2025 21:40:32 +0800
Message-Id: <20251104134033.344807-7-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104134033.344807-1-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Implement lazy validation of BTF type ordering to enable efficient
binary search for sorted BTF while maintaining linear search fallback
for unsorted cases.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 kernel/bpf/btf.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index da35d8636b9b..c76d77fd30a7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -192,6 +192,8 @@
  */
 #define BTF_MAX_SIZE (16 * 1024 * 1024)
 
+#define BTF_NEED_SORT_CHECK ((u32)-1)
+
 #define for_each_member_from(i, from, struct_type, member)		\
 	for (i = from, member = btf_type_member(struct_type) + from;	\
 	     i < btf_type_vlen(struct_type);				\
@@ -550,6 +552,65 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
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
+/* Verifies BTF type ordering by name and counts named types.
+ *
+ * Checks that types are sorted in ascending order with named types
+ * before anonymous ones. If verified, sets nr_sorted_types to the
+ * number of named types.
+ */
+static void btf_check_sorted(struct btf *btf, int start_id)
+{
+	const struct btf_type *t;
+	int i, n, nr_sorted_types;
+
+	if (likely(btf->nr_sorted_types != BTF_NEED_SORT_CHECK))
+		return;
+
+	btf->nr_sorted_types = 0;
+
+	if (btf->nr_types < 2)
+		return;
+
+	nr_sorted_types = 0;
+	n = btf_nr_types(btf);
+	for (n--, i = start_id; i < n; i++) {
+		int k = i + 1;
+
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+
+		t = btf_type_by_id(btf, k);
+		if (t->name_off)
+			nr_sorted_types++;
+	}
+
+	t = btf_type_by_id(btf, start_id);
+	if (t->name_off)
+		nr_sorted_types++;
+
+	if (nr_sorted_types)
+		btf->nr_sorted_types = nr_sorted_types;
+}
+
 /* Find BTF types with matching names within the [left, right] index range.
  * On success, updates *left and *right to the boundaries of the matching range
  * and returns the leftmost matching index.
@@ -617,6 +678,8 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 		err = btf_find_by_name_kind(base_btf, name, kind);
 
 	if (err == -ENOENT) {
+		btf_check_sorted((struct btf *)btf, btf_start_id(btf));
+
 		if (btf->nr_sorted_types) {
 			/* binary search */
 			s32 l, r;
@@ -5882,6 +5945,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6301,6 +6365,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6418,6 +6483,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->nr_sorted_types = BTF_NEED_SORT_CHECK;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


