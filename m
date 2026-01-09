Return-Path: <bpf+bounces-78320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539CD0A603
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BB5331DF180
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F835CBDE;
	Fri,  9 Jan 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnFgMcuA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226935C1B6
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963631; cv=none; b=uByzMBRKNEElgcLSYfCVTsRNnGlj8/0KfyFvdjD6T5c5Mj4zD2mJLQmCv1j2sPyLR30ypKHmj9R2iQIDKKvSKK4WG+XOP2FyViCeitSYdOngoluu5ss6OJiGxeWS9w8PtRW6OK9bSxAjAjjXMSq7Ri5KCla+sQYK15bM4xzwxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963631; c=relaxed/simple;
	bh=c745HJ4eBL9O6dcjNGxahlJgFWWLs7lhqs1RisTI0i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8fqCNPfmAjLXqnDVtPcBKh6pw/u2K9nQFyMmxXqaeR5BM/1Oyp6uwLQbo+2S7hLgenexrGJZP3ybkpPj+/v8jCBIxxTnRqa03bw1RFuivUtWklcjt3ezYv6+MLwsp3Ok5BOBV/Xju9EEiPoYxacPwwifePyFqxw1FmgUPndxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnFgMcuA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0f3f74587so34901185ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963629; x=1768568429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQrwHecK7iJFotsalH69RC9yNT/x39b0nH1K09oW1Js=;
        b=OnFgMcuAiDhCqKAnfRzu0ej65dFsrGOItfSUTbaRbxX9pZD+2SxqUGt1v9sYFUsUsQ
         BL/XEYMTEQcGhGTi9rZqQJxLC00bxUVGyGrUUFWsRjfKIZhs1VR37vG86xKiIJcpstHp
         Of7xxvZ+rQIRC+pfPEBUtk4EjiC07yhTEHL6MzQg+e4PuicBZ9xgtHKzdFxOk5geMgS6
         r/XJfayqDZQNosJ9s6Ne1l6vhczQ+iKUUZzUVDxtfLwFznSip2zI2Ojwgw1+8EdASFoL
         sRcZG66J1QZujWLpSsm8tkNozmVwST3gHQ/AhioDkoe4vF2nO1nPGTaaXnOA1x8PMW/R
         W7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963629; x=1768568429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQrwHecK7iJFotsalH69RC9yNT/x39b0nH1K09oW1Js=;
        b=IeBVxXS1lf6SBLfnt9uguebgf/v7tbOPp9Fev+2KtfQaVGlFra47YHPGAwShlOe/3X
         kXazvC5nSBaDUvVXAKOS6rhF2WNCHRHD6y3JSEeggMibKhNcVOXP6T9yEzu986GT6ZwJ
         e4e+wbRUfnebl7RTaydITDGpT3zPBvX9RpdILLhu2lkvCSZ9F3l92T95QylAtxmrjYLo
         363vJJ0jyWMFfPRHpugBcdaEEB1cwQzacayO96pryG2R05L0dD3yE3HPYjqP0NPvDJK5
         rvsabJ5bH2/Deu7TdUOiXEiQeVX3wGrb8tHr3tEVtqKHGBIIwRPP2dM7Waf3KoauZEYI
         yAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAwwQ8NPbJUm+q4rBSlN4djc3Yz2RM7E4T+nq3y4za1Sr2+lbuP2dnOYexles4MRmu2Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgHyhgfgGXDakMx6aJm0qwZ98VeN6MrTB7DdEoDCEjV7pipw+
	tlYym5qobZHIyF4B2HzU0XHLNq+c0QtOsnD/E5c4oDanBcX4lhphj6oK
X-Gm-Gg: AY/fxX7/N2uWssAWbc6pXePF3u9vwkeowpgvjsMHB3zBwM8Rgf8da17hwgdqhb48oie
	XVeQ7OqZgTX6fs6r9NvuZH7H+hDWrYpuBZn4HXdvp9o7DO7RWbvqC5n3jMQLIzYw2KCnITbF92M
	RDF7SAU9pOJ5PzVk6Um9DIY2yUjOLoPUl1uepkSbilCY9XXL2heaNfqin8xIJs5gd1Q/NlC111j
	MZBf2aR5VMLOzUrsGNTho/zIGhDxfXcl+kDGx0rYp2QdyF5CvaDoIDBo7xkTVDlHlpaEt6hVlvy
	p8C4RUeck1BR5dwbi8xLaDgqVSew7ZgktiCcBcFwlc4rhmaXjA18bj4BnlbRYaN2zA7mKXeHkej
	kTC428Hb6XSqT/4IELwlgOT7IRKVoEdBy9xvTDpm1Ff02FDHOAbXy8mrQMUOkH2Ts/hKXizaOTk
	b3RoP46kDPgE5Yiz7GnSV48xRYHQg=
X-Google-Smtp-Source: AGHT+IH8r5Jl7OK/ko7OkHT0W07SkTpKr6K3Cb2AERKmBWRtYdKBRTbXr2RD8AFzYRrwDu33anvYvQ==
X-Received: by 2002:a17:902:c402:b0:2a0:97d2:a265 with SMTP id d9443c01a7336-2a3ee452277mr89382755ad.14.1767963627294;
        Fri, 09 Jan 2026 05:00:27 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:26 -0800 (PST)
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
Subject: [PATCH bpf-next v12 06/11] btf: Optimize type lookup with binary search
Date: Fri,  9 Jan 2026 20:59:58 +0800
Message-Id: <20260109130003.3313716-7-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
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


