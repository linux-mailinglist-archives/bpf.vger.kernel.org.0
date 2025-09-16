Return-Path: <bpf+bounces-68575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A877B7D75C
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C87B38FD
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216B2F25F7;
	Tue, 16 Sep 2025 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY2boPLo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDB62ED873
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065828; cv=none; b=N9wyE74QOoM2+vxixwaaP4lyDY8JAaRl0OdlpZ4rf6RYxaCWklrLeKzDEiju84JM12luBca78hUPMdsEhSTjxmmH4QHi35v52auRysvxXuxN9OaI0GeNoJRJ4bAc2+ZQm+2d+iEzP+5mg5v8zMRQoVpFRPosW52CXqtZBkgPmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065828; c=relaxed/simple;
	bh=HFm36ImmXfA6Y4Ojn7UgJxKOtrEpOpg8eBr1DCLXNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QB9Pk9miqGAAacyNSE09sUjnMr3UUJWVRX32bOaxYxtxd0xuAFJUVOzBRD8dnUcufm4lyV17DkHbQaUqUSIudI2CRUkU6/EL2lQR11awd07JwRys6eD0jhvr6mufQzYDcDESErg/zAW/7CKt6RQb2TcqQFaaontY0FWyqU3tEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY2boPLo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso66253015e9.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065825; x=1758670625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE7JjMkJBfBpQbLCNFsXIRnHcednO2z55VPXY+AQ3ic=;
        b=jY2boPLokJNbgzvSWevGLOZjVlVAUFI3WYWssT1Oq7fSUiAGzugcTBDuvTNnFHBHM7
         ZMm2ot2px9OA6VgY5XgkpWsXfZFpW+9G9QPla7csP95iL6xbhMT9FqujRjLgZDdBClBI
         ZqGbx1jPdFP+pC8mniZ/ntlh/+BrKpuroC1U3HMv2ilRPl5SFC+2zx1UumEUYVIFylne
         EDIR9+GmFHGgHhucQOb5jlc8BkXpVtVd3IkBqeGUfvI3hY5n77cUnpyCmd5dsymq3YJ6
         3PkuWXXSCM+6adSrCK0Fw2Tz4m+fPk2Y/lUtS6zGK0LPZQBYVjbz5Cu/zwoi7Ebggcp2
         /5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065825; x=1758670625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE7JjMkJBfBpQbLCNFsXIRnHcednO2z55VPXY+AQ3ic=;
        b=mo1iaqs5dVT4+kEb6zdwEd234SSjjSavjObnhWYMYDlmN+C5t3vXnZhZk3+bPGPSJO
         xhd+ZfMMgUeeTKj9L7A3Udf+q6/G6dTOh85jlJ9COqTtfFSEHf2bbk8uXFKmAlhe3H87
         j7Q8tz6mHRKe5dvl2gLpn8GNa2m7iH+aLB/mwo/wSCPJhF1ba746cNtJdb6dP8j0Y0qw
         uF6+2XHi01p1aev4Gc0rjtTDyW7YXPNtc8pjk3GmkUkXwXtoVNiurMjIXseHZ47qx6oH
         F1yFzjT2hwKcABwRaDn4yqsRIBqPL4FZZ5sbbI9aHC5GghQuXgf9FzPYo/QN6ajkSrWp
         kZcg==
X-Gm-Message-State: AOJu0Yx+CT5oLm7uBNBQ5Uut3me7OisVaVC3a/GmQK0rGu9rvNhnO49C
	EG68NZJRSMYDO9BQ25o0IxrdJzBpNo/O85oDUOVY7JnHTTT/YW/UDHq0pB35tA==
X-Gm-Gg: ASbGnctrdL+Sf8R7mK4hpeHQtMjaJ3fZMSP0csqr31UaXW3LblesWqCeZCZUk0o/6tT
	MKXK0DkGsG/luzC1ZXLzaJVNc1yyw7A08eGGhx8NtecKJes+7LVoohlF/bqIQepza34Jss5QkIg
	gv6EpaKYNnJ+b+2CzyU0gvofROxyajiqwjZmSxKR+hHkko72Dn2ywh5fC0Qlg0NKguqFlsNP3HU
	qX7pUyOv9II8TjRo0FijEj/z1kmhxM0iuc7HbrTgVe2xPVyC3123CCQtim3+VZGB9mL/pszenFc
	4gZJTS1IpoEMSBd0MT5SR3m7t+D8HD+EVvwPqc1/m6fro0v3dRJSwRXuHWe6n5QIQEMhiImRjbQ
	PZVdmrCydSuSpt95XFDH/NFTcmejIzeAA
X-Google-Smtp-Source: AGHT+IFx3044497oiWMZ0eewNiOq+Pm91Dq05cuWS1Ll/2z/NRWmX4H/lNfMdoYskExZE621+RtlTw==
X-Received: by 2002:a05:600c:1c15:b0:45c:b627:3b05 with SMTP id 5b1f17b1804b1-46201e960d6mr742675e9.5.1758065824757;
        Tue, 16 Sep 2025 16:37:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078708bsm24171422f8f.15.2025.09.16.16.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/8] bpf: refactor special field-type detection
Date: Wed, 17 Sep 2025 00:36:44 +0100
Message-ID: <20250916233651.258458-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
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


