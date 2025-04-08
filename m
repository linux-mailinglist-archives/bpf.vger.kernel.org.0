Return-Path: <bpf+bounces-55490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F0A8197E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 01:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF534C5EBA
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6607255254;
	Tue,  8 Apr 2025 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxtWGDW6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C8225405
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155936; cv=none; b=MxPIGZt735TQfLIVxh8yFFohN7wklyuz8S59FMjGqvZElmR32c2D9gJNEMb2fi5g0l0PIPPAo0hf1bv+lQWdStOnplb1M0U3P7hl4InFvMiyX/MMUScH/aQfgznGgClNEawAD86py1Gyd/XvRY4JAsKzNN79pakSyADaM4Pgze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155936; c=relaxed/simple;
	bh=KWaY+/cOB1D+dX+j2sLnWloyPm85RyrhH4tNk0LCeSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLJdTyJElbaFE8hnR/PFVjfxfAIRXMec5YwUP2gtVjrYFajKrjaka4vXA5TnN1HQnXMy2Y+THbjSjJradZkh0uLUOVn9kCJudJ+GooEK8hpH3+J7JKDTPSO3MzQS2VZW+t6y4GIAnm6/IjOcFUj9MX6hzMJTEurzg1hjVBS/+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxtWGDW6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5015776f8f.0
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155933; x=1744760733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xIBmhW+FIJLCI1Rfo8vhwrALknx8oL9oRsgu3k5kgw=;
        b=CxtWGDW6Fz6LoV/E9fqHhFWB5a9bAkvi2ir2icuYMOUQdNrw0QSOThVSud1wubevNW
         zeUcqJ6xGYAvsNt5nDb+fXhEhzaMu/sazN8xKcBq6xZDzsM+hrzzRmrbCzAUWmz6u6QA
         z5N9BMDUBKMYzFnaIM605knp0nN12KZ2g00+6jhY770aBMh82egEyf+IBK4VmFPnK1oc
         WxjwGCvsRwEdRnqqtdCPrC1uwzc1UelMIbrgZ9E+rGBv+LWV8vnbXb7R/PSpeeMMMUdw
         rfeb9Wwf7/8ZT0UPmPP4EAxdm+YtQVQA16dmBfbTyAY2OMUQR+ZU8e927bXCsvMglRdX
         LsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155933; x=1744760733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xIBmhW+FIJLCI1Rfo8vhwrALknx8oL9oRsgu3k5kgw=;
        b=WVVwjNwYbbJ7eVtQYDrTg2+aprbscJfoKEbaN4p3v4AYAyn5/7HVc2IX4Qb47uMfRZ
         pfStNgx/4uEQrxiA4K2S6Imm2VZq995ytUv5ucbjA7JJqPJiv1Gt0lTq/UMrhv2gMyZI
         e4tS7zmE+XMnYuPavF+zGd9rGPIqwc6ahIHEWeot3xqzDSiYlUcbZ32F9hMCn8y5Egas
         uKGKZ8j9TzScTWAsbqPEXrnEqqFDMMCv4rBYzxA3SpjGNwiAgN7CKSxDzS1OWiADCZqc
         h2qsVZEgORp5xaGhqOGjHjaThNUz0jcZVa8hXyj6bKWOwfuqDoNjAmFmXFRTwDEuEzRr
         f70w==
X-Gm-Message-State: AOJu0Yx/S3CxwbGPf5RwWs9Qa6ufJyIDZ7uxOkz65iYPwX8P9ki1CuUH
	vGaZ/pRoR08bbBaY77Wi8MANqkJJiTf71WS9faGArppnTibuDmiCd+Xgew==
X-Gm-Gg: ASbGncuCjhOGoBxs9hX8U/Jy0cKjTKy92q/JRqJBV7TFTeYIBnZYibbddi4dThXn68c
	iP3EIz1Q70WTN7JTlCa2c9MQxIFls0Emg8p5SU20zzkaka8i6KpzVbQAKcUUWw3bwFYcDJrYDJC
	QUNjUgz2G5vIjrqSMpEVaD3ipRhCAqMyslqjBB2Cfpb3eJW6pE5GusT4rx1wx91NkopLFvufGML
	aFN7nYBX73kTVwlFu+89tDQs82IEtn6WuQGaoklJFGsawT0llN5VfxwWmWTEjDXsBR3NLCB6McT
	/l0D8XOx3P01QRrvdffz43gmKv8f/iXnyMV6NYlO043o1SLFe9rxxSx+aRkBbEA=
X-Google-Smtp-Source: AGHT+IH+8WMbLmR0hnujLYIv7cEDx48GdVVuAdmRHMjRCmU9JIuN7xF1R/1bA33DAhXTR0cI5hlA6w==
X-Received: by 2002:a05:6000:22c1:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-39d87cd68a2mr733189f8f.45.1744155932827;
        Tue, 08 Apr 2025 16:45:32 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ec97csm3012485e9.6.2025.04.08.16.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:45:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 1/2] libbpf: add getters for BTF.ext func and line info
Date: Wed,  9 Apr 2025 00:44:16 +0100
Message-ID: <20250408234417.452565-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408234417.452565-1-mykyta.yatsenko5@gmail.com>
References: <20250408234417.452565-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing new libbpf API getters for BTF.ext func and line info,
namely:
  bpf_program__func_info
  bpf_program__func_info_cnt
  bpf_program__line_info
  bpf_program__line_info_cnt

This change enables scenarios, when user needs to load bpf_program
directly using `bpf_prog_load`, instead of higher-level
`bpf_object__load`. Line and func info are required for checking BTF
info in verifier; verification may fail without these fields if, for
example, program calls `bpf_obj_new`.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  6 ++++++
 tools/lib/bpf/libbpf.map |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b85060f07b3..551a8514dc7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9455,6 +9455,30 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 	return 0;
 }
 
+struct bpf_func_info *bpf_program__func_info(const struct bpf_program *prog)
+{
+	if (prog->func_info_rec_size != sizeof(struct bpf_func_info))
+		return libbpf_err_ptr(-EOPNOTSUPP);
+	return prog->func_info;
+}
+
+__u32 bpf_program__func_info_cnt(const struct bpf_program *prog)
+{
+	return prog->func_info_cnt;
+}
+
+struct bpf_line_info *bpf_program__line_info(const struct bpf_program *prog)
+{
+	if (prog->line_info_rec_size != sizeof(struct bpf_line_info))
+		return libbpf_err_ptr(-EOPNOTSUPP);
+	return prog->line_info;
+}
+
+__u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
+{
+	return prog->line_info_cnt;
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = (char *)sec_pfx,						    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e0605403f977..d39f19c8396d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -940,6 +940,12 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
 LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
 LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
+LIBBPF_API struct bpf_func_info *bpf_program__func_info(const struct bpf_program *prog);
+LIBBPF_API __u32 bpf_program__func_info_cnt(const struct bpf_program *prog);
+
+LIBBPF_API struct bpf_line_info *bpf_program__line_info(const struct bpf_program *prog);
+LIBBPF_API __u32 bpf_program__line_info_cnt(const struct bpf_program *prog);
+
 /**
  * @brief **bpf_program__set_attach_target()** sets BTF-based attach target
  * for supported BPF program types:
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d8b71f22f197..1205f9a4fe04 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -437,6 +437,10 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
 		bpf_object__prepare;
+		bpf_program__func_info;
+		bpf_program__func_info_cnt;
+		bpf_program__line_info;
+		bpf_program__line_info_cnt;
 		btf__add_decl_attr;
 		btf__add_type_attr;
 } LIBBPF_1.5.0;
-- 
2.49.0


