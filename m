Return-Path: <bpf+bounces-68784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E8B84CB2
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CED7C3737
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7F30C35A;
	Thu, 18 Sep 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfusFnYo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104E30C0FB
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201995; cv=none; b=u/cjLVyfT1ZmKGugRUiYhlpWx2jBNfUkNQdyU7iX+GyOIox0rnFMojTZfvGbwtThUiqbQh9STSKc3ArGIzxgUdy4cP1PB7LTsFXArwQm4A66ux3zrSbdVupb3two63jiTmuf0gBs3g+TOyIwxP48+nHrE6FHHQ02/uIQhUY20V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201995; c=relaxed/simple;
	bh=HFm36ImmXfA6Y4Ojn7UgJxKOtrEpOpg8eBr1DCLXNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhiVgQvDIoC56rFWL3KW2lf/exjuJcPTNI2qkRXsbZ5qnQ6jIwVnDistur6wTWuf7Zv1apkNp8s9Yb3d32mx/iRn2dtEzxL0qXZAscLD7hhTfZm+GCSNhT4L8RbyUfm+UekeKnjrtB6an7X54SkxLgcoRkk1uSMox6G6yHY3fyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfusFnYo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so5311285e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201992; x=1758806792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE7JjMkJBfBpQbLCNFsXIRnHcednO2z55VPXY+AQ3ic=;
        b=TfusFnYolL32Wd214oLyf3aM7yk+Bl41FLCJM+4xzrs4/8t2Uzcqs+6CkexdYY53MN
         M0h+jKusvkjsFHWML6sAG3DTvNNhuGsqWNifPbZJQ0Rq+7FUtl8ntmU9GhL0Yh50w2r4
         FD6V8Y/S0VgGemRSWBEe7ygfqIBOOLEvM9H/ojL5OISJMTfMXJNsVTM7RRC2QdwjVDoL
         f5Fc6WdFmJQxnDBixXO1DlGfeEYeGPUfqwmJx8oBDK04swK62JRu7Tz573Pob9sN4lKn
         AD3JpjnfiYmQOWgKjb9oGVd8tDZ7BHSVbHNEMMIlUBaeIGNc/WUqfcRvqD2ayHw4aG5l
         uhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201992; x=1758806792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE7JjMkJBfBpQbLCNFsXIRnHcednO2z55VPXY+AQ3ic=;
        b=CLT3R+d6ygtbqcMUG4hBd61nRG42Mi3fqd2t7jW7ijVR99vICVuSsy7FiPqpbEBa1a
         9avt3sLf1YpO4bKi+AZjl9+Umy31uA3r+QFAhY1GzPkFfgfLvP24FUP88p4mEYhS2StZ
         WD15CROCpnPenHsg55enUw1YIHuWVkfeHcghqIWlfJ3NV1peBb+TiJShUNmFPcxeJhC6
         lM79H+NMAaGhYU0GYRB627R/yjJBHVKJ7k8i2zxJd/MFfA+o4jNI8YreUFNKbmnvpBVH
         8fkfvCwiMS2aHpELEOv0y4Jl1OVy/8ekHoQ6Un84GJX8ZpMg7/IgIOmmNAePjKbrx0w0
         gB7A==
X-Gm-Message-State: AOJu0Yz+D82FtFkfTOND3L/XDAwi0Zqk+5X11L2uzL0hdq5USaStymGC
	rY8jrll5wGXGd69qpZiP6IZkrBD/Y0MuE/J6NBW7HISFWoEhrm93n7bqFmPndiar
X-Gm-Gg: ASbGncuEL1Bz3Qc5Vo25IsaxelEpBBWRosXfaWHbNdahn6usGIA6+8CgYW0w21hrv2V
	fMcj6B9K/faWJeYvRKyGWnl/hwHJ0gyHi6XnX+kd1nlAr0dC/tvGYIoBQsihpGLZbePP1s/iTPk
	dkA+I7dp9gPbXaUy8TElGOdPYo+IF0Tz/hVMMloXj+VOlBG0+SsVnn+sbmLMhAmD129fC3mKI2g
	IOT1ZNB7LNV5nRgEwD30Zm++oPN0s8XbP9QF7995PIm2L3rcnvA3l4BThlf0GClZAlU7yfrLcBr
	07yB/6dEdjg+SZqj6Krv6vK2LAgErKcg3WsuAFUdTeDo2ZNUdNKvpIcjCuQynFXeDxJxTRsKp2C
	7RWSZHFKgVvCkwdwOrQRQ
X-Google-Smtp-Source: AGHT+IEMxyO5HQZCFqTAOyfNOmIWn/XgdvGO8z4QX22jJTpEJwadiW0YY6G3XsGmqRVzTQNgI5pejw==
X-Received: by 2002:a05:600c:b86:b0:45d:e110:e690 with SMTP id 5b1f17b1804b1-4620376fef1mr56303375e9.14.1758201991535;
        Thu, 18 Sep 2025 06:26:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139ba88d0sm81290885e9.10.2025.09.18.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:26:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/8] bpf: refactor special field-type detection
Date: Thu, 18 Sep 2025 14:26:08 +0100
Message-ID: <20250918132615.193388-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
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


