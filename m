Return-Path: <bpf+bounces-54975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D46A7694B
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6953B28F4
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD2222570;
	Mon, 31 Mar 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgjBtR0B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC3222561
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432508; cv=none; b=NhUtknWkDYUzuiIEL1jXjuWJEXd+BrngWWEc1EO0yaH6vVM3I/QjBDQasnbTl5DYTKA7jnVMX+SDyMYgWJNqLZgXvKxhFh5A+JUasMwhLGHAdYl5/a8jvhG1kSvOJ6atsb8zN6RCLNuNMneKN79zH6Tsnh59ls9Pr5rm8+GCJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432508; c=relaxed/simple;
	bh=ekJYTX4GJ1CsYpgj/6pKya19vuWMDGVLtB44i/7Altc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvrN7PlOV0Ijm0DpLvCM8CVdJRikXCpNsKoQYqvI0sW0sZwkMOOsYwpSWQTpp00mCFAeLLt0c5yYh2EkXdG0DHEZ3hfsNHy4qQviajc2xvCti6JwvxoZACd996XFBpZLaOWpEiKqyI1EOUeLWARW9qwMOcxYHqRXqJnlm+PNwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgjBtR0B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so29185135e9.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743432505; x=1744037305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IL77MITwEdjMQy4onrWgnhLxS9QXk4+qF1htcd8UsCY=;
        b=cgjBtR0B5y6fL/CTN6wCNJd8MDHk1Qq/C2ltI1mZh6qJ9BoGC1vEyp/135Wvv4iN4Z
         MmaVkQPR9s5JiXibjZmI6lBI6r79K+JlAJ/0Bp0ReWprKOyE5wsxQ7CkPnYqwQ4s8KAL
         iP9b+C7ioyaT0dsSq+7Ey0zeCBg/VKf0jJX490XYF6P5VlS3TpvSIRN6kBwz5clImZj4
         xKzc8lrtKA801jWrdNpDfCFye5Uso1ut7PlJmRU2Pg6E3AXa378GzIWQ4WE6/OxXbTmZ
         7xfdPqFl4HVG/cBbK6VOs9skQfiDmnXgqeFU3C1VZrlAlByRvC+j0CuQYJf+4v44Kheh
         N4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743432505; x=1744037305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IL77MITwEdjMQy4onrWgnhLxS9QXk4+qF1htcd8UsCY=;
        b=QMTgG1rGI7THqO2xI8hBv3uPPX+bSsBKqQdkrnmkR4FUQZYhYMfd2GRzBloJtjEiid
         UTIc+HTUGdCHW7LGao0RAF4ys087leF2bqALTxSnqLYCmCqWDK9BfE+wW0J9UrdjT5SG
         d3PxbMHt8wluFby/vSsy1Waw2PAZ2kaT2SzkVpCIL67bhGkob1jKiVRHi1ES74HcLbZy
         HXoH1ysArY1dqSj2Q5Lk4TuHTjA8Y3AuAYhFXV8Y+7JgCRZ4Iv+UFqOlTu3CXClHYdDf
         xRWEOLutt7g87oiCLBHDDXaAXRe2bwbmdd+m1voS+gas4XFAFvTr1W5lsvHkjYuxtEpj
         W0Dw==
X-Gm-Message-State: AOJu0YwEBvu+D5rbTp9eolNOi9OLJ9VSPN7lTA5kaugWZpO/hII307Rx
	9CG9YKu3yEOybln/dLmxOQR6CfFIwBYkBzteTMfmLAXf1lauZBsuWOwv4A==
X-Gm-Gg: ASbGncuRqjGxin0XzYCgMBn6HtIxWyA5ucEk7JiHV+VAy958qf7D63xO9IH2RJvbMCM
	KFChlu7msdZm5OyGUEspsYkZ985YjTQQrctc7TquI21WOLsGWR9WNDd+HHUe7ypXx756wNUwm/M
	Dx/3uPryGDQqBMvW4UpiE2H1MhIv4VW4+W3o7zcK3oMGwdqMyV+Ui2csmq0fRzkYQnUtKFusWIG
	2eOrbZUYMFs8c8qS68MKIFavE7cPR2ly5T2cLnVLo8USeMbS7tp5NclYBb6matgI47K/Sas2L+4
	bEzqPXetz/SgY3C12C4x2KvjLpvmV0YJOBvJomffIMXXfr/bhquJX+QIb0UkWj8=
X-Google-Smtp-Source: AGHT+IHlowqL1PmBfkHWAeqbQBPP9Y54P5v8dJnJdlIqEA5SRB3+Yqev4GBsCcA6nx+6gwwSeLWpbA==
X-Received: by 2002:a05:600c:5119:b0:43d:526:e0ce with SMTP id 5b1f17b1804b1-43db62bb97dmr63061965e9.21.1743432504583;
        Mon, 31 Mar 2025 07:48:24 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d900009e5sm124338365e9.34.2025.03.31.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:48:24 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/2] libbpf: add getters for BTF.ext func and line info
Date: Mon, 31 Mar 2025 15:48:17 +0100
Message-ID: <20250331144817.78443-3-mykyta.yatsenko5@gmail.com>
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
 tools/lib/bpf/libbpf.c   | 20 ++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  6 ++++++
 tools/lib/bpf/libbpf.map |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6b85060f07b3..86f6aff76ef2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9455,6 +9455,26 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 	return 0;
 }
 
+struct bpf_func_info_min *bpf_program__func_info(const struct bpf_program *prog)
+{
+	return prog->func_info;
+}
+
+__u32 bpf_program__func_info_cnt(const struct bpf_program *prog)
+{
+	return prog->func_info_cnt;
+}
+
+struct bpf_line_info_min *bpf_program__line_info(const struct bpf_program *prog)
+{
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
index e0605403f977..a6ec87fb0fb9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -940,6 +940,12 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_le
 LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
 LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
+LIBBPF_API struct bpf_func_info_min *bpf_program__func_info(const struct bpf_program *prog);
+LIBBPF_API __u32 bpf_program__func_info_cnt(const struct bpf_program *prog);
+
+LIBBPF_API struct bpf_line_info_min *bpf_program__line_info(const struct bpf_program *prog);
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


