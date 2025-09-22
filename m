Return-Path: <bpf+bounces-69279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B8DB93923
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683A116E993
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E82FD1D6;
	Mon, 22 Sep 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzdDbh8v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941CC2F8BF4
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583583; cv=none; b=BM6ciy0i1LMidtmMFX3KUD7m7oejYh1IYMlybL3xkAAxU/fUkXaHJQ4j78Q1yiK6vUY1BfFbjLbN+FYGPvMpNHNxlE+iLqd+PWIIOdO34waJq1UUi2jjoFrEsPVG8I0WVhuZ0cFQJV2XC2Hf5bWbRnBN3dSIRq88QSk+qfClkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583583; c=relaxed/simple;
	bh=+ioDn0T91c3U2wSK5dCLigfLTC3FOf1bJyl3C075ynY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdrBFl5xkAIMmW9UOemE3rmMKZ9s5w4dgkTRYRmaWXAc9KGYSL4SKNOaVWwQKs4jaCJAVvUxZtGT+aQM5c7R8aXRpHzzf11QJmn7CKxjx5PXs18Bv5ZRYQOgdO04Q13Ic5SjCPMel7HDJznvUUfNRsr9clw12FZta1m+u/6jBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzdDbh8v; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b2e173b8364so212926466b.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583580; x=1759188380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZxZHSq14qVvoAREjd7VMVg4/hmFfZleNQc+oR7OyM4=;
        b=YzdDbh8v92pdgFxS8AysW7QqX5z7bmXAo+KpNz6vLw7dyApahst6TwyF+T0evlNf38
         QRq6dkkKLbtt8yWpezWaDEXTS3v9aXzi768ZlfSQGd2/eugsoQIn7XOGKshboFuDI3Cl
         7LjQ8Al1bAy/LmagHAfDyAILxGAbHBLnYZrfvJomS7xpBtTu1T+NFPCkxLfHuZv+G+Qf
         S2DTh4rbXcsiqy7Y324WFMDYPcNqGjbt9ASQH37IWZ80vdbfpOrsfJOy+LaJmjpu4d1G
         FxCA0Nebv44mSbctZeRj51pLN8xH0P/bhodk9vgJ3noaRvXDUnptyTpqY6KCJhyYizfa
         EC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583580; x=1759188380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZxZHSq14qVvoAREjd7VMVg4/hmFfZleNQc+oR7OyM4=;
        b=XTJnaZx+3u8rxzTCcwkVlmVtuVSwrSVHAEK/Rv3tTHwN/+uwh0275UxfH1I0B1Su+e
         /WEB6097DugFzaM1L2J8k/qNEV0m2pip6YxGIG1e7AJIqvADCrPT4KrhIzE7W1YOT+yq
         aW/Qxh+H/VI2KeKWuwjyr+WI6CNZMRqpfbQoVBofPTaAH3FJZ1hq0Y4WeIKyKinR/65H
         7mz+ItVaV1b5QvBhIb+pk9Nmlboi/wf6oRbG1Tgr4B1gVrhYWbpX2APcACHqaUFr4IMn
         JNzfcjuP8YI6TEDMTr1ruaZMH+JewRyte01O0mNfuluGnUUF6VBuLdWrrhrHjNC7VB7p
         tvpg==
X-Gm-Message-State: AOJu0YyDw0oW9sroIFBgoClv15kJP3LWEbs1C1sjK+BzXHkogtlHlKhx
	ZzMGPy1umzZu3qPLM+nM8E9Hi8Nv0r6kXn0rAB3Okzje76O2sjJzmcQreOtHgQ==
X-Gm-Gg: ASbGnctXtUTD4tn7HK+ebQ/663vXKfOmUAT/MTf2+w/gZrDDp3OozB9iasdz/yi8Apv
	QoB2ou0LvtxrQtHrz7OeKoFqagEIzVGjuXy5EpzNYnumyewtmjoHsv8i9OV4UD5D9xpxUpri93f
	1CQvOh0FCgOxT7qouZrGBRCZWfijiFC/l7qGIwKUQ/5k8dQfFrMtvi1fE5lnwhLI2X4q0vdgJdl
	8hE13DxmAhVCbd9WDMIhsbgCnvrzcsZ+71JAIQxOy9ar4uzAyGNDlhgO+PReXNhg5HDcSmU/Bbm
	DuXX+u69gvf0p+WyLSwamSAdd3nocrxHwEfq0S1P0E+HxUTFNeo/yJydNEc9J3pTASqgFOiKCxp
	946NVgNew/XhyvvNEsf1T
X-Google-Smtp-Source: AGHT+IHqUUW7xs9bxvPjmn4CPQr7Ag2HlEbOjIRx9O5TMmp0qwmnHxn/oc2hxWw8rp8h1+b/PausrA==
X-Received: by 2002:a17:907:3f29:b0:b04:6fc2:ebb9 with SMTP id a640c23a62f3a-b302ab33a5bmr35834766b.45.1758583579708;
        Mon, 22 Sep 2025 16:26:19 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2890e04727sm662124766b.4.2025.09.22.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 1/9] bpf: refactor special field-type detection
Date: Tue, 23 Sep 2025 00:26:02 +0100
Message-ID: <20250922232611.614512-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
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
index 64739308902f..71a3de2a1cc9 100644
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
+		if (field_types[i].is_unique) {
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


