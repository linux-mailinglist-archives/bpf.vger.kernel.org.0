Return-Path: <bpf+bounces-67580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0717B45E81
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917433B9697
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C2309EEF;
	Fri,  5 Sep 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKyZ4+YI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC702F7AC7
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090717; cv=none; b=twuoPbnMRSyBogPShNWbl0iPeizgBZupwgrVEG9o6LONvYgsT6CGHWrjbPC/KtxWFVeQQ/xaWykAcvZfRxwB1aTxiGvhXLnqjhzQ96JfaUiQBf/+km+L45mVp4rOXv2UOLxSzfOiqLzMaHd30x27KFtbXd4PSIX22TEC92CS+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090717; c=relaxed/simple;
	bh=WKlqY+jDUKH2pA9OW0wWWq11rou3iEP8Op5q/Bcobbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGmVLEhaTOSFTGgtW8+k2MlprkRpIR31MeifSvTZ7bgzCsmI+xDcT5Ta061ttD0X/N2Gb7YHGYtYYxBOyh3K4XlSy2RKOSoaLdABjcUruCcEjZbrAjqUurYD+3tIxQuGJUYX5kx5HlbQxZVeDHeTUWKRZr0gWVP0Rnv3QRVwp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKyZ4+YI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo625449f8f.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090714; x=1757695514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeKK8ZB+ockw47d0fxPC1fjOenrP7+gVwrrWR/20oj8=;
        b=KKyZ4+YIAKHMhEeCUKjpEGkcsYE8jlCF6NZhp6j83QIpOFhey7H0X6eWiWC65AIQ4Q
         jNRpVL/eHPG9yx6ZmoqjgotI9W0SaGXJ7uVlHqU47yvOUuwhV+mgGTYBC+GgO3w5ILFx
         JaI/AGbFXAfI3o9hlAOLMLM241cxlmRUR0N11JB10yK9yYsehpNaB8p1OZ+px7Gs3OKV
         eF5Xa3gn/BlX32NfwKxnf61G3k8xhdOp4GdQ8SIr/qgwqCGDcDE02WdgUj3LPaY3NZ48
         Gn1OkXHyxoWPpDTzFF2IkvqekhtNlpRoOX4rq6EdDoZusOjuuAxWPFr/yP0TKM/dBfgq
         LZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090714; x=1757695514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeKK8ZB+ockw47d0fxPC1fjOenrP7+gVwrrWR/20oj8=;
        b=nF5v8sizN0G1ihCzCsRk1gP5Kh4PoIlFQw48810AtXb7NG6c7+C6skxKsqzOUnSllj
         z6m8ONv7IzsbdQjDuk3Nwl/Va3Y05AMdjtXtiBFvnd7iM80AfBG3aU94z69Fup5i+hVW
         xe6/gmB/whLR2RZfFp55yhfL9ZCfpNhGTkCMgLrwebQk210SsKNQcSeH70lAitkud1jz
         UxCPeEol4FOJttdimdLmuCxV+JCisf188qLlsye6nGko2Uq13Sra2RoF02XaIr0SzkZT
         mvz7XJwxqCat1qg+0x9fQYeOtK9QtdYDR8/1N0VvMCfQpZDJ/YCL2se4o+u3Btsgowb8
         8xaQ==
X-Gm-Message-State: AOJu0YzH/GdHaCVfFiCV9IX8pnyOBdU5g4r9frCMkCghRj7LTyWNF2l2
	jZ38WUpYmaMXiHVf/8Yv8HjZlY/K9HEQFYiCljfQa6js/cYdZHLFzA3qjw+4lA==
X-Gm-Gg: ASbGncvYiYekL92quFveRY6Avp22fHxevNfq4a5pTbowQdHqld/o8GCYUTtMlvmZkRM
	nFyROPa3BibCEua1R4Ys0JWDTEN9/9cmC5n50ADu4+66i4wmEFj7UxeVaDZ/s2Drlv2csyyMX8V
	gag7VWC1ciYp3pc94rmBwnt7pFKCnyHYV3TUEKLpp3t8OFFz6hP6ffLSGAWC0IB8+ALy1AMt9Z0
	kTTlM2LktKkNIKXfUhtnRdCCcqmdk1p//WI0kR7uPPUaE5P/emWYDmseRlH/T+w7cjRdCDCyoT+
	0bdqIbz0+V8Jd9gBkNBmzz9Ige2zbdyKarKe3aaP6zCmG7bMeWTXAYdQZgHoDtNTbNA0TyIzr37
	4v40xxNvlC9f/+NqjF3X7M3qCSRH8ySKYDdFkfFr1Gw==
X-Google-Smtp-Source: AGHT+IH7NCEfLeCITqX6ipzxqieRjO4Vu8dwoA5Z7hkQOn8gd53QhR09qYSNPngddDM9J6lru+2eMA==
X-Received: by 2002:a05:6000:2410:b0:3d8:e1de:7e4f with SMTP id ffacd0b85a97d-3d8e1edc849mr12053893f8f.21.1757090714041;
        Fri, 05 Sep 2025 09:45:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45c447244c4sm139275305e9.6.2025.09.05.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/7] bpf: refactor special field-type detection
Date: Fri,  5 Sep 2025 17:44:59 +0100
Message-ID: <20250905164508.1489482-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
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
---
 kernel/bpf/btf.c | 56 +++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64739308902f..a1a9bc589518 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3488,44 +3488,28 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 			      u32 field_mask, u32 *seen_mask,
 			      int *align, int *sz)
 {
-	int type = 0;
+	const struct {
+		enum btf_field_type type;
+		const char *const name;
+	} field_types[] = { { BPF_SPIN_LOCK, "bpf_spin_lock" },
+			    { BPF_RES_SPIN_LOCK, "bpf_res_spin_lock" },
+			    { BPF_TIMER, "bpf_timer" },
+			    { BPF_WORKQUEUE, "bpf_wq" }};
+	int type = 0, i;
 	const char *name = __btf_name_by_offset(btf, var_type->name_off);
+	const char *field_type_name;
+	enum btf_field_type field_type;
 
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
-				return -E2BIG;
-			*seen_mask |= BPF_WORKQUEUE;
-			type = BPF_WORKQUEUE;
-			goto end;
-		}
+	for (i = 0; i < ARRAY_SIZE(field_types); ++i) {
+		field_type = field_types[i].type;
+		field_type_name = field_types[i].name;
+		if (!(field_mask & field_type) || strcmp(name, field_type_name))
+			continue;
+		if (*seen_mask & field_type)
+			return -E2BIG;
+		*seen_mask |= field_type;
+		type = field_type;
+		goto end;
 	}
 	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
 	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
-- 
2.51.0


