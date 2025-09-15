Return-Path: <bpf+bounces-68427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EFDB585EC
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA3F1AA7EF6
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF03295516;
	Mon, 15 Sep 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEJKW8BD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E1287271
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967510; cv=none; b=RiUavnYr92pH0CiJVIsswlSOnC7h1ptAO/bZrYwqxwAFgH4Z5njMPoRMGs4qQM091xIkzfdG5ebKY2t5MlX1A6jpMg28/8IJUNH4OpSrQ5VJnDM3YRLw1+mUbKv3DS+X0de9Tg5Sl14jt2F0urFY3Dg/seAVlJNWAY8vYLlanpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967510; c=relaxed/simple;
	bh=HFm36ImmXfA6Y4Ojn7UgJxKOtrEpOpg8eBr1DCLXNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9b3Xr8FfWfLDHPD0XyHatQS0iAivYGcBNgcx681bfhHDfRDS5g4lMj8uqlsMFCa/Opzh1KBYwHAUqioZU+u63DiixMjJzWiWPBDCMP9nCy30buAdWfSH7JTU+VyoB0kUO09FJ6VmEAyQjmb3oIqzHYR5HUB3qAVLpVMFk+vcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEJKW8BD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so32225645e9.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967506; x=1758572306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE7JjMkJBfBpQbLCNFsXIRnHcednO2z55VPXY+AQ3ic=;
        b=cEJKW8BDBp5MB6CjNVzfN6zSGDiUMgHb5amGcdw3QN/tUnFMxchAff6fXcnQrHDJEZ
         zQk9u0ioVuDy6WmE18638faLw98tHg5kreFQLqdUBVuw05QQeKGoP9aPIShGUIuzjM0x
         vPNwN7wz8Sj3p5m0E/4eL3dKEwFOIS2NSW1hQ5RTzl5c0B26X+PAlZOJvDqBVZvZmUWp
         3x4Jpw8ZnQTR+y/v0leG6NDPA46fUIM230i2BsAw6LHcyGrs4WYOTd4U+oYYVR69bpoy
         Qw3VM5ryRQdDtFMPTOKgGycREDMlHuIf6sHdW12A8c47fGRhyegLVWX540DrHleC1Oep
         kMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967506; x=1758572306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE7JjMkJBfBpQbLCNFsXIRnHcednO2z55VPXY+AQ3ic=;
        b=qDZKixgMboIRBuXoX5f6jcyNh6jNqzZEX8Ea2Nn7sUDD4jfmJ/l1I0Pcm5tH6cUQ5r
         cILTOBZZk29PjwYXI4qUzjUfjpY4xuf8mIyEWFNfb9fKFEqmmBHRuChl8WDNCWKxp0m7
         DBmEPthYwY0Hjmja6vq6QYn8kmsEj1HoXsKZWxBM1B+mZvLZKU1qyyzE9ugwPS6bWP1R
         8i5RQqg+HlKaDBGCX8Uqy4CVIULXVikH/DsuQLzpTWLf+/t9/CbCh0gfvhEjZ3+iB7rA
         Z95ZkV64LXuQx/1qMncfqwAfuGlaFiVpWaEfA3yluQhFC5AN/t0UBbTf9NbOXXtNfSQi
         f0bg==
X-Gm-Message-State: AOJu0YxP4+n0Mzg/8vRrTlwSV3XPy+9wf60q31MrR5mf7Rmr3WClT1Ip
	NBcjPqP5wbfYHKbbZFDvlUyjpvLGhUAjTAkMTFn6T25o7ZMt4VSHMIBXg5Rfvw==
X-Gm-Gg: ASbGncvwdp0wKPAW+8jTq/bFALCwlQC60gbLlXCpiKLzv03URmxf5bV3hvV5N8dh6Z4
	i9UB3/TjikQVN30XaRQ9axSStwgb+SduJHyX7bn1Wkp2Mce2kuFdFzpjK+yMicBZmd2ppuz3hLG
	Q0asvaXrfN+bq8X5DCf/UgfZsX1CsYxUcbCktQHer9z/SQN0PhFVRXhIv20r7fjyvhtBu2LVGa9
	Oj/p5EOOfAX1KuWmhuJvTSejgqXpvsL9xlCRyHtDUrL2jTUtQrIu6I78FfE6GVOOVj+FctzfEcj
	z196HOCINXnCEHIoob1zRJjKh2EDAln2kZxUZf3vTjtuaeeuIpASx1t6Y9BcdebW8W5SOespl0k
	UZcyzuZCcSWzIkw==
X-Google-Smtp-Source: AGHT+IFvV0P1DW+/q0IMnbSi1VVzsec1mxBfBecmIO+NNkQHRWLegyafokbaZkBp637VUDl4TwQeWQ==
X-Received: by 2002:a05:600c:6dc8:b0:45d:f88f:9304 with SMTP id 5b1f17b1804b1-45f211fbf54mr94782515e9.30.1757967505940;
        Mon, 15 Sep 2025 13:18:25 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2b9b443csm88542515e9.18.2025.09.15.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/8] bpf: refactor special field-type detection
Date: Mon, 15 Sep 2025 21:18:09 +0100
Message-ID: <20250915201820.248977-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
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


