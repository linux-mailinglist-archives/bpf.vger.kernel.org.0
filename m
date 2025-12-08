Return-Path: <bpf+bounces-76263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B868ACAC2AD
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 07:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A14E301AB23
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 06:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582B5313E23;
	Mon,  8 Dec 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQJ60Lnb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605EF313546
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175062; cv=none; b=Y23nHJkeBYQom9wDOrM1ZR2AHeRIN4hcxsS/7LCzt8jhelIq0W/bWTim6w6MD2d+nIFYxotaUDAZU9FBDRArzmCJg70cNujhzgSC4b76WccSUMiizlX+FEDJDYc7kCkUZtEWavhk5jDGrpzdSULfQoRr0VshJ7fxjIPDesa3fWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175062; c=relaxed/simple;
	bh=0kgEQtgvPa55pKXFrtj7srWoStjEyAoMQzDyIdaQ2pI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9TYIpp6h69A0915431bxABqXSLrTSzFlBq2hsmuSfJ2/meiGk1dNGCQaaqsaO1rsX1QgOCc+njmMbPr3FG9/EjsZhcn58qEB5O2GyP50669kv11k+EPLQWKxQcUoLiSl2QODdQllvVEhNN7gJ+3NvDPJyCJKoz/Du/jo8TJZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQJ60Lnb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29808a9a96aso43337005ad.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 22:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765175061; x=1765779861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgDV1ROzgzpe5gCmmSbOnsLIyQpLC/h36ENHoKlfvVE=;
        b=CQJ60LnbKPu9bRhsOvempKpwtVkZuuwxSdJQeZcoeapgmDUrB+H9Ugn2zk+6/xAbml
         MwQnI5IAp4YWNygmpHEfPopeknHGIYfWxPu9xvc86A+eQ3dA/AW3knfsBCdH/uiYC54K
         3kURlKtZr6x2e2xztLNYFOjhk9QjYJLvh9bM3DCjy/g8rt8Xy+HrokXE4zVyECFlbkPs
         +s45EhBWEa+XZUolagBl1EnImbKYdWyGwTnRs5XkFdRIWMDOa+8T94ckHONyqjW/2HIk
         O3OUzCOuDJJM5Pvwhof5vgdNJeoOI/USh0ZxFtVoJw9vWlvUKbYuwcPohbDfn6ziU+7e
         ZCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765175061; x=1765779861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgDV1ROzgzpe5gCmmSbOnsLIyQpLC/h36ENHoKlfvVE=;
        b=YHaCYLLRsly0I7hqQZCqcIHfKKg/58F9qaEJT+wbI6uYWXewal4eiQUhHhgyiB6nCx
         h2tfC1q6XsoC/1TXPbQ6T8jvvL239EEvvrI5cpXFshYHJWg4fEVR1ckjmPayh3A8zOYY
         c9dAk5WtQlqZiHgjmBs9znoyEqvX9bB6OKcgEPfMjKmYUXpNR33Mb8PJ5aq23QTR5+/g
         7lvowaR0CGL2/mMWXL5te0ikX+3WN2ojkSHVhJSzUXOVyBiEzfwZgJ7xJH6AWf+YZ2PS
         mPYlBNgC0q0NNrbpIXZrLNsCcDrqjBFK7rIaaHOMGtNKb2FB0jweJT0JRCu9PoxtqdSk
         CnMw==
X-Forwarded-Encrypted: i=1; AJvYcCXXJqP0YTsic/+6gnO3w+vB8s2Dm7UFaYLDw7qY2LUkwndFviywPV95EsGhNmft0Hn2cv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZVd9H6R1qtZRC0d8fFg39Sqa4xFCrbFx8yXIUH9wACMu73Vm
	Jy0yZIO96wMt99eRbLsQb6AAhgxE2Qu1OTAvJ+yRcKbNrcongL5mmuKG
X-Gm-Gg: ASbGncsqqOIqI+Dc7ErWHNRDAfzcYVQSlAKJ/FSNOFP7XDy9RYKJ8jxEfP1gy1YPoRO
	46Xwmk+gv1bw1QdtmpN3A2lujOTlBZBiE6BBfNhtO3su/F7qMWpZtmcRBx3j1Nc+eDGeq0Sc7s5
	DXrTnvkioWMnEk02xWjV8XK6EK1C9UAybI4aVng173yyHW2kA9gBDhMJhB2cdfQvplw2O1cWgKO
	Rq93L/01NQ5uX23EA0t/ndvsLRettVfHw0eGZnv7+dlXmB6kuOwCySJM7pY0uyeygp460K6ToxI
	1anj0RW8FRIPLwG+ODdI9rewAgHCMlyvFaW7F7TGVVbMy1i3KFS7bipz9tbIrD62Q8qLSEgxOox
	dzMY3/12GNTFDGnKuKX36XWhgl0R4mKawnVH2TXu0dvtdPJnCmWvXQbn2ioTbzdCckmIV4JOkhZ
	4S5DwIa4zEDMaESnoSEKhturfjw+xL6lgvd/usMg==
X-Google-Smtp-Source: AGHT+IG6L+lPfbNCKWoFS4rN4KY/rh99CfbKovxPed4KtXlkFy6JUwLMvGN1EclnhEJL5Apqnbgs1g==
X-Received: by 2002:a17:903:1b6c:b0:295:6a9:cb62 with SMTP id d9443c01a7336-29df5e1c234mr68591085ad.35.1765175060725;
        Sun, 07 Dec 2025 22:24:20 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca1esm112555855ad.2.2025.12.07.22.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 22:24:19 -0800 (PST)
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
Subject: [PATCH bpf-next v9 06/10] btf: Optimize type lookup with binary search
Date: Mon,  8 Dec 2025 14:23:49 +0800
Message-Id: <20251208062353.1702672-7-dolinux.peng@gmail.com>
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

Improve btf_find_by_name_kind() performance by adding binary search
support for sorted types. Falls back to linear search for compatibility.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..842f9c0200e4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -259,6 +259,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 sorted_start_id;
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
@@ -544,21 +550,79 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
+				    s32 start_id, s32 end_id)
+{
+	const struct btf_type *t;
+	const char *tname;
+	s32 l, r, m, lmost = -ENOENT;
+	int ret;
+
+	l = start_id;
+	r = end_id;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf_name_by_offset(btf, t->name_off);
+		ret = strcmp(tname, name);
+		if (ret < 0) {
+			l = m + 1;
+		} else {
+			if (ret == 0)
+				lmost = m;
+			r = m - 1;
+		}
+	}
+
+	return lmost;
+}
+
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
+	const struct btf *base_btf = btf_base_btf(btf);
 	const struct btf_type *t;
 	const char *tname;
-	u32 i, total;
+	s32 idx;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	if (base_btf) {
+		idx = btf_find_by_name_kind(base_btf, name, kind);
+		if (idx > 0)
+			return idx;
+	}
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
+	if (btf->sorted_start_id > 0) {
+		/* skip anonymous types */
+		s32 start_id = btf->sorted_start_id;
+		s32 end_id = btf_nr_types(btf) - 1;
+
+		idx = btf_find_by_name_bsearch(btf, name, start_id, end_id);
+		if (idx < 0)
+			return -ENOENT;
+
+		t = btf_type_by_id(btf, idx);
+		if (BTF_INFO_KIND(t->info) == kind)
+			return idx;
+
+		for (idx++; idx <= end_id; idx++) {
+			t = btf_type_by_id(btf, idx);
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(tname, name) != 0)
+				return -ENOENT;
+			if (BTF_INFO_KIND(t->info) == kind)
+				return idx;
+		}
+	} else {
+		u32 i, total;
+
+		total = btf_nr_types(btf);
+		for (i = btf_start_id(btf); i < total; i++) {
+			t = btf_type_by_id(btf, i);
+			if (BTF_INFO_KIND(t->info) != kind)
+				continue;
+			tname = btf_name_by_offset(btf, t->name_off);
+			if (strcmp(tname, name) == 0)
+				return i;
+		}
 	}
 
 	return -ENOENT;
@@ -5791,6 +5855,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->sorted_start_id = 0;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6210,6 +6275,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->sorted_start_id = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6327,6 +6393,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->sorted_start_id = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


