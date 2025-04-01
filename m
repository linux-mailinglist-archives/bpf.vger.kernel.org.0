Return-Path: <bpf+bounces-55090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C68A780E0
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E726A3A93E6
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519C220DD4B;
	Tue,  1 Apr 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkWg7mDl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC720D517
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526466; cv=none; b=pB4U8ih4wDkAHX24dsAPfImynUn9qU8DGztf7MedqwGtoR8tmWoIs0xy3bAGTxW+sfYdRG27bstLO0er3lpGLpp0ZzxBgOeZGHLmxUyAEZ1z4lSzWf//SU4wfa3iwshGczsjff+d3dhZFKyXwfWjvlt9zYUTMSgPd7URQo6xsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526466; c=relaxed/simple;
	bh=KWaY+/cOB1D+dX+j2sLnWloyPm85RyrhH4tNk0LCeSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXD/pCUIRctDdMJQHpT8g28DtrtPZFYMlXNcAkX65zWWPGi3SBfOWSo4SrGK9UON+9rF9dpza9lJ0tNOWHe2QWahW1tfGQF9jvMHsYEKe/i+aPZDJtltQCYqhlRD3tazNa80kVpFlVwsoJjDt2VsSZVfSmr2G/YsszsdxeceWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkWg7mDl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf680d351so150635e9.0
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526463; x=1744131263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xIBmhW+FIJLCI1Rfo8vhwrALknx8oL9oRsgu3k5kgw=;
        b=bkWg7mDlImGmi65HHnTVEIxWSg4yI5VD0/oPP3OR9IKVMWofRmiRQFcrZSnGK6Fr6F
         mM8vtur3VUDppO0CTZQBwM/ClwpGQY6heA3Vy21bBzEe2F9DHWrpBmtTI5WjfspE0dwm
         xUsl2tHX3NGbXCQOHLbB2SC5yqRxrBW5OTa1a0MElPVZSEJK6Dwn+FRF+/2gfmOJbv9m
         X4D0rcIQtJAMQIQxw/QZ/S71311VeuXaVh4hqey/Uhc4OJCVAE+06Vm6n50M35xmGf9K
         elvzXwVePNTFNtDIPLCAG1o2Zz85mtJkJFuxcO5//3EdlRyE0Eob1HfUO3B779UU5jC9
         aUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526463; x=1744131263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xIBmhW+FIJLCI1Rfo8vhwrALknx8oL9oRsgu3k5kgw=;
        b=hlos9PioGOwncCK2rZDYGu6JBjENe/LQdGGrbv6DLVrL5lfhZynyBXTHr4Ed0Lk32O
         ASVs9VKi4Oo9kzPXKXiW5w4e/3UK8QT8rJ7kyzxeyeCNo6wLbcbiO/fMUwkMqv0CV0DF
         hKYImNNlDLTkrTDqLAEuMqwtuWw5wFSJz/Lnj6dDxFETdRPribzQEpbzZ2/BewFhkqf7
         d5veqQStyvMagWg8rePseVLOu/W7DzePLHcgkGHXYsbYKqCXpiO7x9zVJWYxHgZaWntt
         6o5YNB7RphUmzU55X8ZwHmeiXrxlTJDjP0L9qzNWqR09A+ve7aOeQpODcbSSA7PTMj3A
         GiWA==
X-Gm-Message-State: AOJu0YwwyIt/h+HmEXD59MvxxqSFDbq0xCpEcXUi69YxCCGQ4EOm7uz1
	sqres4zEPJYWKEYABxmqqvslp2K6nY4PALH6yLWt0YMAzPS4z2EY3kp11A==
X-Gm-Gg: ASbGncuGxU80Tc54EwjyjPRwX9Pp7uOtybYg9p/HePY2OoPjTnqQddOpoLOp6inGx1M
	LRidVxGJ1j6bakNm4Rin64exK9FrtSfg9aBI/katRoV1GOf7BogCHhcrf2ifXIJzpXtGSY1hjRe
	ISLBWyPJyya8G0/0vkP6joLi5JlZr8c/Rc+V17PPk83eIATZB7rMqmM39mw4h3chxTewnlWgw6n
	slhzdebBcUGe5kr/1ga9ZVGswFxUfAXyTrf+tXFaGqrJYIIn0Q7+x8923TlaJRzkHHPUTOPRAEB
	Md+1gjfQKBYhHC87Gw/dVwjdUv/MeRCc9ULq9sqGRdUUVhw1U/SjBBnJQLF+/Rc=
X-Google-Smtp-Source: AGHT+IF0bYVEcwALmkJk0ZIKKaD2JGjTxPdVjOcTCzhiNPlEftMLWPNgIHJda4pXgIOU6I4FM0Rkqw==
X-Received: by 2002:a05:600c:1d0f:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43eb0579d9cmr8497455e9.7.1743526463340;
        Tue, 01 Apr 2025 09:54:23 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d84632ffcsm201397215e9.31.2025.04.01.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:54:22 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/2] libbpf: add getters for BTF.ext func and line info
Date: Tue,  1 Apr 2025 17:54:16 +0100
Message-ID: <20250401165417.170632-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401165417.170632-1-mykyta.yatsenko5@gmail.com>
References: <20250401165417.170632-1-mykyta.yatsenko5@gmail.com>
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


