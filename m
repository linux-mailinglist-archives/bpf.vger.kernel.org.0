Return-Path: <bpf+bounces-78197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F5D00D4A
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 04:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8F74300F711
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 03:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A0928DB71;
	Thu,  8 Jan 2026 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIWJglGa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70028C2DD
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842232; cv=none; b=rj1aWKKrTzCoWK2J3297wtpnW8kLRHCa09nVQfA3pvZDoH5FNDDogSvYA2cusFNtIF/mbDmL/TXZTltlJTOQp/2hf/r8P88Yeo0ZIeirzv0TZ2MP1X8gnRQ40XeDnTdUNDwKnM9K3vb7UsC9EQOAoHn9Mv9B5Wf6mVTL7BdnL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842232; c=relaxed/simple;
	bh=c745HJ4eBL9O6dcjNGxahlJgFWWLs7lhqs1RisTI0i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFsJ/7G+kb5WDKLyFmQCy7hXl08NH0kNQN3VF5lIFF1sTHlTBLzU6BZOC7tnSJjTfl55vQEsxS6kr+vXosc9VIg7npNYETqd9BAJIA5uVctWVBZZjk+XMwAC+ICY2wxOd4vuI59WOsdg3EJvmDwEujH1GipBD92IdnzeGXXX88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIWJglGa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b80fed1505so2017999b3a.3
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 19:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767842230; x=1768447030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQrwHecK7iJFotsalH69RC9yNT/x39b0nH1K09oW1Js=;
        b=XIWJglGaS33yu28VmoRDhibmZorvC5zlVvIRKkfDSZuXHOD0i3H+x2vzqhCY5YXTPp
         J55tPNsz6C9T4Km1s/FTOYKbgNYBfUKip19fRS0Q4SZOnXP3CAdfpt3wpw8+mB3kNthL
         qwrfn1jp9Bw+vi0anMXkVjpEfD+CsHFnjCM9jCiVYmN0PjyYuutPqWWxFYFDbVhqrKCo
         0AZD4O1dBDREJmz4fIiaRiUCSjihOPBdgpvqbP4Qv9WR6dz+JU27YsPtaz1Sb0tIROd0
         oQYYUSAcBNXN1Cu/MCgwfwb/HShdId0nTB3zySYn3wM1Kuz4gpQkGVu9zARvuJXj3KoJ
         XELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767842230; x=1768447030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQrwHecK7iJFotsalH69RC9yNT/x39b0nH1K09oW1Js=;
        b=ht18WzDp6v+Wuy8oVZz+aqAWvRVr2Y8AtVn1s6EgjYd+tnadBpifsStin70akfI89l
         veTJcSVZo/FGn/vyx1ccPYBOtMmXx3Ok7davnNC0y6Wwl43rqEB+GY4jrSe8B9ypC5Pb
         Wmr/xc4c9YRtbZZ6s68ONbKizDvsGmGGAaEh0/0zrg7o2tNa8NFJkQQIqDJBeLOhXTFP
         I8+b9RYB6Tk47mwW9rVR6umbCwQijuZTilBc0AVBo30xrc52gSn9J0PsMqR9vStFlfyv
         IQye+rnp1GKYPXX6bBQZNk3mqChKxaRvyqxHYMgMuC1Eu7Dxx1gwkc3RDSXz7Ab+cJ/R
         qO9w==
X-Forwarded-Encrypted: i=1; AJvYcCVNil6SK/kzpyXQUireu1fTAFo5sVSgW2FfdQT3bQ3tdNer476MZVuHPFR6/xw4OOCtfbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy09Q7C0Gc4sYInVqfLBgjeDlkaRn2tavC5BalpPrrfN1SpzkQX
	j9Ahn++v5UWlPNJ+a5jlsNwlqS34kEVjByBONKeBjW+43Lv61sqGziJBN2Z2FDCrwZE=
X-Gm-Gg: AY/fxX4msS0FlUqS4uaDMABJEUEpW9XAN22e4CPQV8MfffFFdijrykz4faGlG9gWHSR
	EYQcBmqgtRazq6if55KbpfXCA4aPdmRnhTAFuqBUpR99ifKrVOqu+ewtoAxL8kenNwxPMOZlkqE
	JsOu+M2whOaGN3h0fiqGo4yqQy6DH6Lmt+5fck5R+mILX362Tx9sh6D7VqMKnyEjweijubla0aK
	DWdUztnn4FmoP6LQG0WRyEqQKS6omA2IebSnJnIip2P0O5QamRm3REDunb+Y+bbfsub4qDzFUfc
	U1ww6v1mRa4i8o6MW6tggvNFd4AMeCJ7aUK/L3HwfT2SV1cJ1BIEs37ulSLamWpsdSI+IKNZghq
	NW4wq2D7YDmTIHMcIcDxaHWF/9yRHHwDc+NF8Z1Sd2vlEVrW5J16jo946SLKuloCvFfI/QkoIma
	Rr/2PlwhPG/AuCGBAvFTfmlomkNPc=
X-Google-Smtp-Source: AGHT+IG6VmaJGUutpIyeyvJlJbHM3t8zY9VuCBzH5ppbJhqIHdZT2QK6JoML3+Lr+VD5o+fEXKe/zQ==
X-Received: by 2002:a05:6a00:340a:b0:7f6:e75d:8efa with SMTP id d2e1a72fcca58-81b7de58e2bmr4118281b3a.17.1767842229910;
        Wed, 07 Jan 2026 19:17:09 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de655bsm6134860b3a.60.2026.01.07.19.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 19:17:09 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v11 06/11] btf: Optimize type lookup with binary search
Date: Thu,  8 Jan 2026 11:16:40 +0800
Message-Id: <20260108031645.1350069-7-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108031645.1350069-1-dolinux.peng@gmail.com>
References: <20260108031645.1350069-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Improve btf_find_by_name_kind() performance by adding binary search
support for sorted types. Falls back to linear search for compatibility.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 include/linux/btf.h |  1 +
 kernel/bpf/btf.c    | 91 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 691f09784933..78dc79810c7d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -219,6 +219,7 @@ bool btf_is_module(const struct btf *btf);
 bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+u32 btf_named_start_id(const struct btf *btf, bool own);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 539c9fdea41d..d1f4b984100d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -259,6 +259,7 @@ struct btf {
 	void *nohdr_data;
 	struct btf_header hdr;
 	u32 nr_types; /* includes VOID for base BTF */
+	u32 named_start_id;
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
@@ -544,21 +550,85 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/* btf_named_start_id - Get the named starting ID for the BTF
+ * @btf: Pointer to the target BTF object
+ * @own: Flag indicating whether to query only the current BTF (true = current BTF only,
+ *       false = recursively traverse the base BTF chain)
+ *
+ * Return value rules:
+ * 1. For a sorted btf, return its named_start_id
+ * 2. Else for a split BTF, return its start_id
+ * 3. Else for a base BTF, return 1
+ */
+u32 btf_named_start_id(const struct btf *btf, bool own)
+{
+	const struct btf *base_btf = btf;
+
+	while (!own && base_btf->base_btf)
+		base_btf = base_btf->base_btf;
+
+	return base_btf->named_start_id ?: (base_btf->start_id ?: 1);
+}
+
+static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const char *name)
+{
+	const struct btf_type *t;
+	const char *tname;
+	s32 l, r, m;
+
+	l = btf_named_start_id(btf, true);
+	r = btf_nr_types(btf) - 1;
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		t = btf_type_by_id(btf, m);
+		tname = btf_name_by_offset(btf, t->name_off);
+		if (strcmp(tname, name) >= 0) {
+			if (l == r)
+				return r;
+			r = m;
+		} else {
+			l = m + 1;
+		}
+	}
+
+	return btf_nr_types(btf);
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
+	if (btf->named_start_id > 0 && name[0]) {
+		idx = btf_find_by_name_kind_bsearch(btf, name);
+		for (; idx < btf_nr_types(btf); idx++) {
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
@@ -5791,6 +5861,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout;
 	}
 	env->btf = btf;
+	btf->named_start_id = 0;
 
 	data = kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!data) {
@@ -6210,6 +6281,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	btf->data = data;
 	btf->data_size = data_size;
 	btf->kernel_btf = true;
+	btf->named_start_id = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", name);
 
 	err = btf_parse_hdr(env);
@@ -6327,6 +6399,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	btf->start_id = base_btf->nr_types;
 	btf->start_str_off = base_btf->hdr.str_len;
 	btf->kernel_btf = true;
+	btf->named_start_id = 0;
 	snprintf(btf->name, sizeof(btf->name), "%s", module_name);
 
 	btf->data = kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN);
-- 
2.34.1


