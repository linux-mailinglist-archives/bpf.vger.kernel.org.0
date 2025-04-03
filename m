Return-Path: <bpf+bounces-55270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A0EA7B209
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E817118966B9
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 22:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BB91ACEC8;
	Thu,  3 Apr 2025 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y220jqfc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2671A9B4A
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719300; cv=none; b=G4FjAX5OSpfqMgs5VxDRtSc5TYs7u8t9ec2ELnW1DGwQz+PAkrhqNzVf9Ffcxe4Cc8rujotYjcuo8ncArC0UBhJZoRIsjoq90eoQpM4SJGWbO6y47+vNF3fM7gU+gCgfSH4zmN5xqA0dkYlaq2whPao2zwGGRlWpyRGTsAWQVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719300; c=relaxed/simple;
	bh=KWaY+/cOB1D+dX+j2sLnWloyPm85RyrhH4tNk0LCeSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsGrwrYmpZKdpys7/oQlGKlP8883DtVCuErmd8memOKOYcSUg6v1kUCJ9TLk9+T0tI9GCibsb6cgL1pCzU7Lw1yJnaL+XKjb5dtIvAcQw/1ybxeiNR6LCW6fPcSDT4SU1srL064Jk/64esYr8w638rbsIpKxLxI9B9X/jGkbakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y220jqfc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a823036so13343915e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 15:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743719294; x=1744324094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xIBmhW+FIJLCI1Rfo8vhwrALknx8oL9oRsgu3k5kgw=;
        b=Y220jqfcNm5PjTpraYOlgERqAbwcE5Uyi5iYDIGh+G7pbiRKcDPtQeI1cPqn3B8s5Z
         pjxJ0x0mlEAmYZivMT+cTqOQNtXaIx+sGow2dT5rKTCWWhM1GhES0QcLlzN36eMsHmZP
         pJpUhEHplPAdbxTBdi3fHJTgANU+7U35cGllD5o2BmRQ/Z2acoIeWIKKLSHOoi/RjM1B
         h1LCw9iweQ3zh4uVB8h4SvZuEtFDM+bomRMn6JMaXYm+CoQN/qrMeP4Vda9BvSyWwrVt
         S29oBrrU6k33xyhoSpx0PK2NeDyazm97cquk6c5kzHFbKiPbcX5R3gyuIKlYdNBDWIzT
         KVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743719294; x=1744324094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xIBmhW+FIJLCI1Rfo8vhwrALknx8oL9oRsgu3k5kgw=;
        b=VpDW662RKoMDQkkxBIYO5EMWXxn7RZZ8TVE1Ug25LmK7YNkHuhu5iwFlWF3O9jjTP7
         M1seAeO2uGvVGwO8cVoB0pGn3XNJm3iAAxMIqi1YitPj8M3sfGjRLNkSIqPFKKSEtV2g
         /xn8R38TVBHN8gY29CGMGGp81ikzbYRqOrNL/R3iJLKMwYoZd1v8iI56qcrel0+lxqYH
         ZUULlWY6PzxVpzXkqcRFfCuUHcL5P/FdFoml6cDpIXRISw58pEW8yDRfQOR4ku7dD/XJ
         uGYNVwpaarNC9ZCOuqmGG1+NCb/mKaLlnWnes8mo+WXfahI7jxQOAawMEPiX6Gp35HVK
         0T9g==
X-Gm-Message-State: AOJu0YxG2MjIf7O9JrgKUchmEMrUYscRZEqlipCTbEGp8FekoSYlh2Dy
	AUJyucrEzpQxqYHiWrfM+ySEIjLXZf29+G5UBTpHxAJJruRhCmsg//tPRw==
X-Gm-Gg: ASbGncvJnMwjdWFHlFtIoWnY36SkbElhDc3tT7wETDZu2HF0kJgXZj82LamaeiVzNrg
	WJTLow69RYeZ+ICunbl+phJ+j6wYLV5tBYIDHnOAh0QwUwmJXBZnRCSOovMCXaQBIsft6qFXY9F
	IOPgL8Cvz3z1w2oTOdeB7EChSZt0EH5nR/rTPU9Eank7ROmWGAi++EDa6n/Sa4HYuWcw2f/2Zvu
	SYWYIgfiY/LGAFtsPeMManYuhtRDrPF4LpxnEDbv91nZT800iOeacd/NBaAWVzw4hVe4mztdf2k
	ZJNjmfe5NGWhFD9dYDjcPaLrwbRvpU863cEI/THc9AKiAOVPJCuXcNCNVCEDe5LOvG0jIe6JQw=
	=
X-Google-Smtp-Source: AGHT+IGJ/78giijBQFHDFDHUdWuxZbQ/Y75/K6MvdT05ExUkwlwFaCmqEOkTJoRaKHW34qBTJRD8gQ==
X-Received: by 2002:a05:6000:2910:b0:39c:1258:7e17 with SMTP id ffacd0b85a97d-39cba941d95mr750615f8f.56.1743719293634;
        Thu, 03 Apr 2025 15:28:13 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b816csm2846925f8f.57.2025.04.03.15.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 15:28:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 1/2] libbpf: add getters for BTF.ext func and line info
Date: Thu,  3 Apr 2025 23:28:08 +0100
Message-ID: <20250403222809.90634-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403222809.90634-1-mykyta.yatsenko5@gmail.com>
References: <20250403222809.90634-1-mykyta.yatsenko5@gmail.com>
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


