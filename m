Return-Path: <bpf+bounces-76262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B35BCAC2B3
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE448306341C
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F8313539;
	Mon,  8 Dec 2025 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYUWxGDO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782031353A
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175059; cv=none; b=NfiXBkePf3pgRjr5S2IIR7/L6gHRfK9LntWoIngxnJ3XaanlQHvMKFqbSHx8m4pBU5BFEq6HVD6Vv76PEKK+Tg47eqbI/dFk9mPG1Qcknzn76QgaWW8B5uG0X0cxYshSzXCtW1WGbL761friZP8odCNwVauC2YpMcLFdVGkDlTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175059; c=relaxed/simple;
	bh=8hsjVTc4iHNm8LdtJrSwh8RnQyLo12TybfR54C1ppls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXKoi+iRXNPF93W7En3H9nOpbPVcloy+NkufbK3N5qbmVpwgD6Xf1u5E0oLQctY7CZqsV+lqsY3uKdcqERQw9XPHCmKbNzZITjSzbwXUkO/vXZMIvtzEVIeBGYd1jgO+Lhatbbxyd72avfP1e6iOXJnzI+k83y6bJ20QeOoiow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYUWxGDO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297d4ac44fbso27807555ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175057; x=1765779857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAB27SW8ze5pe2PA9+A7ZhKextxDBm6v0Soq1ZoL2Ng=;
        b=YYUWxGDO1vJ0tq4hnYCw3RgR0onyHkO/7yCOOwiusJrR0XTPvcVksqdiY6tD8WHzCe
         zVe1WAXdN+CjuWVTrkvdYoWCj1bCrzoSCe26kLxUAAzoABvZp2cdzlA9zpFKsnbbgDlU
         1YkBwHLhAOcfIyjA2aDpiWlWU2Vs4vUMzfpl5wXuuovqiKwzhqU6biWVU3AYItsb2v3O
         NqOmGUr8u7Jwbd7t+rX0V7gKCibdcd6B59ArUoT5jOVFE+u6Izrmf5/rQ1MCouQ9q/sk
         S+LGsEDayugxdbrrf93+oVIXLoatd8da4zDHeaSEvGzm/f1QlEvnqp5dopACwoo8ol27
         RmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175057; x=1765779857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xAB27SW8ze5pe2PA9+A7ZhKextxDBm6v0Soq1ZoL2Ng=;
        b=lLYd084sI0Ghgh657o6CHsdNwVw2b9wQMn8Qpq29z92KNLb+SlX2bORjx706hHkStH
         Sy8x0ooRvwITUuY+ibsgr5/WGWHKRGXZ9KGccNgKmXq/YChIyF8Vk8IPxGpFCsiWrrLJ
         AaBPfCYrDOmuj23bAW4hJRy4g/IZiGtgYDse07uDLzHFxf2zbj7Viei7ss1CII+HE/8O
         2ggDP4aiC3bo9i0h0qjYxwPDCRA372HPUMsw1qAuL6/kaTK2zBegGCUxWS94xADKZVvU
         AD90eE/nNIqDKkneFW7WYfHWFjU3ZV0fpmm8MnrxeAdFYtq6REBUzxY/ILKcpXsnSYy7
         WGXg==
X-Forwarded-Encrypted: i=1; AJvYcCW1/E9xCjQc/Xza07tRQFy9b1CqAfM0wwPnBLdYMRWcwKGiKMcM8eoYGN2UU230hS64sIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwjuOD9k+lovBc7ZjQRYriJ3xf5jHvUvGkAHDrY1E8SC42Pu6
	F3ML7M/0gtdk6MmXXtSPxc/zMEeBT76ub46m0YmNSSpIyLbMVLQO7pJi
X-Gm-Gg: ASbGncvvj+hM2oscx4sgWQ2VAoIMXbmanbPkv7gowJAUD8lUFADnitbC93BnGj5Bwdn
	wjSnZkMjQWmFVhqT1KuAr8yj5HlW2eGPomZH920kR7hY5Sq4qfX4GQROnyNdwF1zdBEsIjImfvd
	Mtf+Hbv0VQwZYQESJLT5itv+zW7DFbP88mn7vnksPEzY6/+im2hvPJ0eNXvhra7VsGZzgvcb0rU
	o2Bqo7pk1LDRZ0uXmSsVbqMoJOM0DnibrSDmYAm1G9fvE+vEc0pSZ0YlqhopcctoUrLgN8fqP44
	tMtiZTsMAE1B07wgUhTuk/JTYk/7gvKUAnMuIY2q6c+8mn1rZAG1xa8vAPayaX6tKQxMyj4QBTL
	yP1WCsYPhti7PXw7HkbCeEsG3HFCPcq0gL/ooVV+DgkOEWWG3kw++E1BVM9OXKdJaim2g4XECX3
	NFPXZzvcCKuFfidKJn1qKQl1qpV3w=
X-Google-Smtp-Source: AGHT+IE+5YDDDuQsk4AB/Xv49ebPh4yjqmdlSSxW7j/cMhZAbaKPySX/s4q4XWI8x+qvn7t4NxuZzg==
X-Received: by 2002:a17:902:fc46:b0:297:eafd:5c19 with SMTP id d9443c01a7336-29d9ec50fbfmr143611025ad.10.1765175057265;
        Sun, 07 Dec 2025 22:24:17 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:15 -0800 (PST)
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
Subject: [PATCH bpf-next v9 05/10] libbpf: Verify BTF Sorting
Date: Mon,  8 Dec 2025 14:23:48 +0800
Message-Id: <20251208062353.1702672-6-dolinux.peng@gmail.com>
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

This patch checks whether the BTF is sorted by name in ascending
order. If sorted, binary search will be used when looking up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 tools/lib/bpf/btf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7f150c869bf6..a53d24704857 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -899,6 +899,49 @@ int btf__resolve_type(const struct btf *btf, __u32 type_id)
 	return type_id;
 }
 
+/*
+ * Assuming that types are sorted by name in ascending order.
+ */
+static int btf_compare_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	struct btf_type *ta = btf_type_by_id(btf, *(__u32 *)a);
+	struct btf_type *tb = btf_type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static void btf_check_sorted(struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, k = 0, n;
+	__u32 sorted_start_id = 0;
+
+	if (btf->nr_types < 2)
+		return;
+
+	n = btf__type_cnt(btf) - 1;
+	for (i = btf->start_id; i < n; i++) {
+		k = i + 1;
+		if (btf_compare_type_names(&i, &k, btf) > 0)
+			return;
+		t = btf_type_by_id(btf, i);
+		if (sorted_start_id == 0 &&
+			!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+			sorted_start_id = i;
+	}
+
+	t = btf_type_by_id(btf, k);
+	if (sorted_start_id == 0 &&
+		!str_is_empty(btf__str_by_offset(btf, t->name_off)))
+		sorted_start_id = k;
+	if (sorted_start_id)
+		btf->sorted_start_id = sorted_start_id;
+}
+
 static __s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
 						__s32 start_id, __s32 end_id)
 {
@@ -935,7 +978,7 @@ static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id,
 
 	if (start_id < btf->start_id) {
 		idx = btf_find_by_name_kind(btf->base_btf, start_id,
-			type_name, kind);
+					    type_name, kind);
 		if (idx >= 0)
 			return idx;
 		start_id = btf->start_id;
@@ -1147,6 +1190,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = err ?: btf_sanity_check(btf);
 	if (err)
 		goto done;
+	btf_check_sorted(btf);
 
 done:
 	if (err) {
-- 
2.34.1


