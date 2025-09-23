Return-Path: <bpf+bounces-69387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A025CB959F4
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39040174ED5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F583218D6;
	Tue, 23 Sep 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asHrfVy/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC473164B5
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626654; cv=none; b=GEF3wTzRXZ9/Trs5wgcT9BvqLe1bXignmjKKnKI/1Mn1HJyvwVW19sCLd/GirCdRKPmbLEsOUz17LJ8BEwLxSsyF4eCC/IJmfb7ZoHRmkb5CsG+q4yFvCzXtGAqu4m2T8EihbpepKDDV2QffZkX63mzGwvbibJcbVHTzLlOE+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626654; c=relaxed/simple;
	bh=Ii3FDyRoKseJX+RAu0RlZ5aSgA1Qakeg2ytKlggQSPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSI6fOKjDuYM1y1oHAN1KTmmxeRvVPCK2GZYxgXgUK29W8kcN1pwqxx/1NHWnnBmTUum6OLMWwmbc/aewNa2uLr00zPTMOnuiEeUjMLnf8B5uWMLogItJmBO7+I2RKDlWKTbvtajl/dUIQvsjVbCHLC4xL92dEXH91UJL3tszFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asHrfVy/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2ee3c13aa4so210575566b.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758626651; x=1759231451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1uyaxu184N81AaFHdfreIq2Vww9o+XvpQpsED7/vtQ=;
        b=asHrfVy/O3S7GjG1dZyUFApI5h5aXSI1jBALNlePDp1kDIM0BoIzbySjQFV/w3D1UN
         go37+ILDmPZ1QKPzMm87H5mc4NPYPx4o5/J/pQkXolTaVTKFdZu4qCguKAhXzZ8rMlK6
         TygnlNBMadNFYsZg3N+gdpmuKWbE6IkUZFmAjYd07yhzJzbWrM5/Ggcbxs7HvPpzoGmT
         xbw4lauZuEXqq9cOTVkaYjrrdSmfYZo59LVFZ0OLEDcOSClLPp9vD8rgmFkqOxdMHtm5
         lEkTxNB3Tj7q5ausWImDgzwz455g8vxVD7mmoRiwFjmr+huSgO+sb6zaCWi+qmQ9NkcE
         wN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626651; x=1759231451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1uyaxu184N81AaFHdfreIq2Vww9o+XvpQpsED7/vtQ=;
        b=RQo5ToSU8wGsjh5MQQIWxHVJJoDZZC/wRix33UtHO/UwLXijUJcKZjgGEWKIbb/acO
         WPusApoQwYtQLg4ISQbxIyT5sUsjJ9GpzcrRbtR43gVHTdfD48eI8Gq6cgFimnxUnp9Y
         q8qenWO8vezNEfZIy0xdrMVwJAkp0OCojGc9IOCCrrf9sNKhLsLIZ3BjCZmJlvS8g1Mg
         oEx18s7+420D0aIncq6+n3F1J5JmdP/jskG5eTdqCGoQnmI7uAX9ItDS3mrsdJPUp6c/
         trlnZg7KO1JvsqrY05ZSeMbN5+X10UJzxtV4FVK5iEAdyUyrbbvoouEhVXKiKkFhRUX1
         oFMQ==
X-Gm-Message-State: AOJu0Yz4oRi0vOzsSF/fVGTy96jBNNjOxbFth2Kxz+oI2NtVyv+amThs
	9r4IGC4p3ITGS7eQh54XUr99cSypvue8Mi4mKEUt/suEfilmMytpnrmFIsDPrg==
X-Gm-Gg: ASbGncvpJt95jC488jNfPjlsdaHiGuPyWbffGvmmbRleuXcMfxBpWEd64i9OIiRJSN7
	2K9pJ9e7VMHiZSZu8MrwOaHwvEwxGiZhS9eOa+qwnXm7E77GCcP4Ptn2t5s0y4mPZc8Xr68fHdu
	ZF0P/Zoo8bCpF3y6/tfAFQeuYxEXmpnaoRi8KFRiAwc0G4tpHWRgLbRjiUyEJWQKWAz6PvpsfF7
	uKDwVDyuttkKflLifjIYZreGVg47/ScHqLtN6I5m7tGJdUjLYFQh4jya7bDzdmgj/pzrPWtw3Mr
	94jtyN06pS0WibVa3bq7WcZ6p31/oZm+cc3X3zgkp5n/Fmlbjkt0HVBVELNCM4Mgfs7+eL5hQAy
	wcVV6v+KXVvJTmzQ5PIKv
X-Google-Smtp-Source: AGHT+IGFiIPHD4y9bf3LTmmm5g/18NZW6mUH0kJWDgTmoJ1f7BPJ0B0VJY8e+S3FV9VnE7kO/+kK/w==
X-Received: by 2002:a17:906:9fcd:b0:b04:20c0:b1fd with SMTP id a640c23a62f3a-b302ae300ccmr219873766b.36.1758626650892;
        Tue, 23 Sep 2025 04:24:10 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b264fc793f4sm963925066b.17.2025.09.23.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:24:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v8 1/9] bpf: refactor special field-type detection
Date: Tue, 23 Sep 2025 12:23:56 +0100
Message-ID: <20250923112404.668720-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Reduce code duplication in detection of the known special field types in
map values. This refactoring helps to avoid copying a chunk of code in
the next patch of the series.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 84 +++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64739308902f..c51e16bbf0c1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3478,60 +3478,44 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 	return BTF_FIELD_FOUND;
 }
 
-#define field_mask_test_name(field_type, field_type_str) \
-	if (field_mask & field_type && !strcmp(name, field_type_str)) { \
-		type = field_type;					\
-		goto end;						\
-	}
-
 static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_type,
-			      u32 field_mask, u32 *seen_mask,
-			      int *align, int *sz)
-{
-	int type = 0;
+			      u32 field_mask, u32 *seen_mask, int *align, int *sz)
+{
+	const struct {
+		enum btf_field_type type;
+		const char *const name;
+		const bool is_unique;
+	} field_types[] = {
+		{ BPF_SPIN_LOCK, "bpf_spin_lock", true },
+		{ BPF_RES_SPIN_LOCK, "bpf_res_spin_lock", true },
+		{ BPF_TIMER, "bpf_timer", true },
+		{ BPF_WORKQUEUE, "bpf_wq", true },
+		{ BPF_LIST_HEAD, "bpf_list_head", false },
+		{ BPF_LIST_NODE, "bpf_list_node", false },
+		{ BPF_RB_ROOT, "bpf_rb_root", false },
+		{ BPF_RB_NODE, "bpf_rb_node", false },
+		{ BPF_REFCOUNT, "bpf_refcount", false },
+	};
+	int type = 0, i;
 	const char *name = __btf_name_by_offset(btf, var_type->name_off);
-
-	if (field_mask & BPF_SPIN_LOCK) {
-		if (!strcmp(name, "bpf_spin_lock")) {
-			if (*seen_mask & BPF_SPIN_LOCK)
-				return -E2BIG;
-			*seen_mask |= BPF_SPIN_LOCK;
-			type = BPF_SPIN_LOCK;
-			goto end;
-		}
-	}
-	if (field_mask & BPF_RES_SPIN_LOCK) {
-		if (!strcmp(name, "bpf_res_spin_lock")) {
-			if (*seen_mask & BPF_RES_SPIN_LOCK)
-				return -E2BIG;
-			*seen_mask |= BPF_RES_SPIN_LOCK;
-			type = BPF_RES_SPIN_LOCK;
-			goto end;
-		}
-	}
-	if (field_mask & BPF_TIMER) {
-		if (!strcmp(name, "bpf_timer")) {
-			if (*seen_mask & BPF_TIMER)
-				return -E2BIG;
-			*seen_mask |= BPF_TIMER;
-			type = BPF_TIMER;
-			goto end;
-		}
-	}
-	if (field_mask & BPF_WORKQUEUE) {
-		if (!strcmp(name, "bpf_wq")) {
-			if (*seen_mask & BPF_WORKQUEUE)
+	const char *field_type_name;
+	enum btf_field_type field_type;
+	bool is_unique;
+
+	for (i = 0; i < ARRAY_SIZE(field_types); ++i) {
+		field_type = field_types[i].type;
+		field_type_name = field_types[i].name;
+		is_unique = field_types[i].is_unique;
+		if (!(field_mask & field_type) || strcmp(name, field_type_name))
+			continue;
+		if (is_unique) {
+			if (*seen_mask & field_type)
 				return -E2BIG;
-			*seen_mask |= BPF_WORKQUEUE;
-			type = BPF_WORKQUEUE;
-			goto end;
+			*seen_mask |= field_type;
 		}
+		type = field_type;
+		goto end;
 	}
-	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
-	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
-	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
-	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
-	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & (BPF_KPTR | BPF_UPTR) && !__btf_type_is_struct(var_type)) {
@@ -3545,8 +3529,6 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	return type;
 }
 
-#undef field_mask_test_name
-
 /* Repeat a number of fields for a specified number of times.
  *
  * Copy the fields starting from the first field and repeat them for
-- 
2.51.0


