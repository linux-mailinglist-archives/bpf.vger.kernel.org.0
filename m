Return-Path: <bpf+bounces-54974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BFCA76919
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE67188CCBB
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4B215773;
	Mon, 31 Mar 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv4HZHGq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18833218E97
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432506; cv=none; b=rHspyP4sr93AQJCDfDWPLAP/Ib9lWE8a3HR04OIO237Jk9elRM7nZdKn+diK0EyPvXQsEzY6aa1YNrH1qzCZ7xGYXh0eoTaLK7yzP4zuF+iIaKi4RrhCtgIQSQA4e8QPtnApIknRaxjusNce4jL4wDArirvwoTafRrj/vDLQqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432506; c=relaxed/simple;
	bh=009GYcNcNMfbKfl5x1JMbPkQFnzybpdy8mzCONH1nwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTdBZut9VsbmJTkOw+1TT4bGi3BDL4cedJl/7JTmFBrrkUMhKXu9dX8Ki5lr4mWe60yL3BqPL3rjBjinWCqYEj68cZoelv1AcGUmIp/AYkxsUMj6n4dbxGq5m6/gIcA/KZ1wvbKw61r4tRbpZv8anwSzZfLQGgeaQoROaxjTKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv4HZHGq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-399744f74e9so2999352f8f.1
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743432503; x=1744037303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/ESWaXW1Wx9ycu4Xw1g8qibzmC2Ev6q3foTxvPEaaQ=;
        b=mv4HZHGqaITsLk9SbHBfwFBDg2RDN8/XyFfGz/dorYHKLWCQXEkmDAjbCwmX41MRSP
         enaXLpPJiXRjWfvurEwrwHc7uQFyxaMWAGfficvvu3bwucJJGh0K2aIdMSr1Qlc7/6Vf
         1kN8YOM89KeIJ3o9kZ1SkRKXgM+INNDCbw0ySM5SMan4C5YkGTAIj/aXrljs7JRBa7kd
         /P8wBy/cm3RMXYVhc/BOu0/s5ibHIXl1OldA3/1Lc8991rXIGM+eDzfFA2eO19MFKtdq
         Jwx4LVVMVIsu0zcM1w7gFENBFFIOIuEzSZHiQvYzUlvIA+cN0LyriZGsszUesw9VPGAp
         B3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743432503; x=1744037303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/ESWaXW1Wx9ycu4Xw1g8qibzmC2Ev6q3foTxvPEaaQ=;
        b=QSvfHzVOgnlPEWhS/TupT2TaZBtxQPrM8cWyuzPGtKLBpMOGUr8CAsJjlrLxpWqPKO
         17RsLhPQ/u8BKJ+VhZAJmAmb4x2VZejGv8PjedAVxHHog9YN57pWmCEDXNM13Hj7vSTX
         /+Jv7Nk863vPCS+rga1FD6hGOAzDUGDeKVIZBdcsZ71Q85MqGY5zkStQsJa4dG4+5veU
         Hbovf1n3vkEdGcBpgPQWQ6EwU3XcyR4+V5byNU7S0PgTazhGFxAaXSgglkQX6XwxFnJT
         yrpcOSjy7v0lRdydFJGROCt8y621zWY8jub80FfFuWvMutofjmXNGatfbJhZDQ6CHExl
         pjkw==
X-Gm-Message-State: AOJu0YwDI/hgFwODk8MFzxiRJlQhGU1xADahF43TavStSotqfkVGBmSJ
	/zPhI/BsOu4XQKMoPigeSpmSc2MM+DEpYwTI7mXboRPeqvQZpBjPVPSQRg==
X-Gm-Gg: ASbGnctonRwjOsef+ZwArsxNq7Xhll4PBu1Zps0x4TpYxs8K6ZuPqfuQno8alSocjfn
	JtaaW32PKJBZnry9aQ4tOApaVguN8Jd4b/VC1IwBM9itEIsroiO+uiLGW5dn7zvqEwxqLkInAlI
	HZGB2adVQvdVPAnjtISBqGWJwLVKtx3ylIR7aMuN1D1Yz+N1HzqGRkZBfyghslLIcZZ9TA+TKcP
	71XncfaN/eRZH1mHwtnxRz9bDZJ0nhjHPG68xGPmd0qGVwiIAvqApPwhS4aC3OZrCMhxZ2itHdA
	o3Tcool3+RzNTRvcRHpBCxO/sns3kN2G7QIvVHXcGeFs18gVYhkU87RoqTL2Fco=
X-Google-Smtp-Source: AGHT+IEi1j2WvgVzkdu0Oh3S7RY/Qu9c75Q05m3d+E+McN26TPUz4QqEKDgFuM87zggqLal0dZ5LFw==
X-Received: by 2002:a05:6000:43ca:b0:390:fbba:e64b with SMTP id ffacd0b85a97d-39c120e0ac0mr5219245f8f.31.1743432503151;
        Mon, 31 Mar 2025 07:48:23 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d900009e5sm124338365e9.34.2025.03.31.07.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:48:22 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: make bpf_line/func_info_min public
Date: Mon, 31 Mar 2025 15:48:16 +0100
Message-ID: <20250331144817.78443-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331144817.78443-1-mykyta.yatsenko5@gmail.com>
References: <20250331144817.78443-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move struct bpf_line_info_min and bpf_func_info_min to public header
btf.h, allowing to use these structures in public APIs.
This change is needed for the next patch, introducing getters for
bpf_program's func and line infos.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/btf.h             | 14 ++++++++++++++
 tools/lib/bpf/libbpf_internal.h | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 4392451d634b..1e57cedf9d58 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -610,6 +610,20 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
 	return (struct btf_decl_tag *)(t + 1);
 }
 
+/* Represents func_info encoded in .BTF.ext section of ELF */
+struct bpf_func_info_min {
+	__u32   insn_off;
+	__u32   type_id;
+};
+
+/* Represents line_info encoded in .BTF.ext section of ELF */
+struct bpf_line_info_min {
+	__u32	insn_off;
+	__u32	file_name_off;
+	__u32	line_off;
+	__u32	line_col;
+};
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 76669c73dcd1..6bc9a9919295 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -501,20 +501,6 @@ struct btf_ext_info_sec {
 	__u8	data[];
 };
 
-/* The minimum bpf_func_info checked by the loader */
-struct bpf_func_info_min {
-	__u32   insn_off;
-	__u32   type_id;
-};
-
-/* The minimum bpf_line_info checked by the loader */
-struct bpf_line_info_min {
-	__u32	insn_off;
-	__u32	file_name_off;
-	__u32	line_off;
-	__u32	line_col;
-};
-
 /* Functions to byte-swap info records */
 
 typedef void (*info_rec_bswap_fn)(void *);
-- 
2.49.0


