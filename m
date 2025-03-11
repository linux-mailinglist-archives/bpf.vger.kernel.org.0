Return-Path: <bpf+bounces-53864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB489A5D214
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2908C188A047
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13410264FA8;
	Tue, 11 Mar 2025 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt+KTPIM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454325EFBE
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730077; cv=none; b=FknepOcc12I9ROSmJh+EHUe1B0aQphNv45eAQkr4waEEdlvXll2J1rjn4QISJv76zVJy+ArfNWljIZdNqszi2eI9qNgI5dlWrMKTkF0cAaiwT1WDSpMewlOBZJborCAnnTE7fgYPL2UEukqOSkNnUNStqC/12CD491U/uYUnUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730077; c=relaxed/simple;
	bh=bNhNJno1WF5Av4Wnvdm6SuZGJw78pFb109H9wOp/CkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APjlaBvZ8tqFI3j0omDyrX0ubhUd+GbHGdJSJFlM0zkMtEgQ01F0lVCzq7i8kODe8bpSA/9BYSUNRTyFNH2BpEBNRh/CFdZMhxN7/MSneuorEmxppFCRI7mN0OgAIt+XWPHWl5fTYPIMTp5W4mTI0yNhg+yWypziRip80EobZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt+KTPIM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso34734655e9.2
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741730073; x=1742334873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyRjA3TfRwv+1/8UEfl04VvAMkvAOthfcOfrJZBSw7U=;
        b=Bt+KTPIMZsPT3g+bY2ycE2iz6d+/Qrr0tykBwRCmdtkPobg5izjA//hzEPBGuKtV50
         V5J2Mpi5AsJAKckpXF2SfhgkGu7rxaC2aAhmO3EEaW/5+wrWKLEmrL9ZOTvpXWsg501Q
         TSw5EZ5dpLZ0Ftafw5XnuYeE/8uv6pbVYJZzDbAcUr4prdNOG42CPOp5YZn9izt2JDAD
         fLYtsEDokE9CDkkIWVpWXIL+A9mRPVUE0B2Z8NrhQ+TZbnIQgcXyV05cEltrBegmF8YC
         gEGNrQcxXII9OE7YIurI+/0uE9F24N9sSWQP7xu8zqzftXrF20MfPy1eh6MUrX71PRvK
         Cqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730073; x=1742334873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyRjA3TfRwv+1/8UEfl04VvAMkvAOthfcOfrJZBSw7U=;
        b=lKiZOxv5dnagE+LzETasvQPDIYtYqIwv9Ovk0EjHxTuddV512ps7+YbEDPA4BqRSDo
         fNv6OZhKqtxZ+I/kNTiQZ4AHx3lylzTrC24ZeRYiIzTTEdLltQLejYjPKo8PNdvHDEle
         Fnxg/5R8czysFCsqUTcnLiaW02/xYGZEY7rbHIZn3OC6wVZihDjBAHS+zXt2JLpTBv//
         cUm3QpW1P1EFUS2Mhdwagm/i5OAcsnl/j5tioIVEs9T/JYdLsj82ZyFoVR+yLgPj0gzK
         Uw0WPTeSh1sYBpUS4hT+PoyI3FTlMyBSBo4/Rjy0StA0TWMX9w8qgrmIJaR0uKEnA/l/
         5HEw==
X-Gm-Message-State: AOJu0YyVCj+nt25X26IWkAF0Hn147j+y5dJqA3PCN6iryeRegyySz1i0
	O5XXpAhDjPlxWb9e+A9/fhzzksPpH3H9R9VAfzm72zGyhmxvdEtwIKQ3EQ==
X-Gm-Gg: ASbGncsCYdYYj7A0IOnwJCxZETVCXqRQlA9S3mzvZsCeFSQQVtkwcGlJ61MuXC408vL
	vv9UPz+nZY4bEhKsjoztj22Ey9zLG6VSARb+np6P6ijzFmoPQDYSpafllXRqUyumN2K3T54EGhh
	ykvUU+Do3qONBwYW6DDZv5rcl8cbmyRjSUc4qBrcrkWmSt9nE3moLXULJ/x16/FY2nS6G5d0y4n
	wJCS60GfV1oTKFNv97Phi2GA2MecDt2eV8Xo88OdKdDct+MgYD5A1PK3DayFOxd0Mmi7QBtRoB4
	VW1fxw1r9p1KTnBEZGNH8dl0mUsrJDBpSPi5ZlXW4g1XyOx4CUUvADMITmXhAcqOybmMzXF8diB
	oC8NmBF+gCLQl6xyuf8a/CK5MsWUBcOkll4bKKPt3MSDmuMvQwg==
X-Google-Smtp-Source: AGHT+IF8tqr9ZPUhOgJoCPqA9Lmrm5jv2Xqby6Jf/2o5qDqDdrTJHFlA47rhdP0ZeUZfbPlNy3PZ3Q==
X-Received: by 2002:a05:600c:524a:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43cf75aed5emr117220125e9.13.1741730072831;
        Tue, 11 Mar 2025 14:54:32 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd62sm18815549f8f.46.2025.03.11.14.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:54:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 3/4] libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
Date: Tue, 11 Mar 2025 21:54:19 +0000
Message-ID: <20250311215420.456512-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
References: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Pass BPF token from bpf_program__set_attach_target to
BPF_BTF_GET_FD_BY_ID bpf command.
When freplace program attaches to target program, it needs to look up
for BTF of the target, this may require BPF token, if, for example,
running from user namespace.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/bpf.c             |  3 ++-
 tools/lib/bpf/bpf.h             |  3 ++-
 tools/lib/bpf/btf.c             | 15 +++++++++++++--
 tools/lib/bpf/libbpf.c          | 10 +++++-----
 tools/lib/bpf/libbpf_internal.h |  1 +
 5 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 359f73ead613..783274172e56 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1097,7 +1097,7 @@ int bpf_map_get_fd_by_id(__u32 id)
 int bpf_btf_get_fd_by_id_opts(__u32 id,
 			      const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
+	const size_t attr_sz = offsetofend(union bpf_attr, token_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -1107,6 +1107,7 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
 	memset(&attr, 0, attr_sz);
 	attr.btf_id = id;
 	attr.open_flags = OPTS_GET(opts, open_flags, 0);
+	attr.token_fd = OPTS_GET(opts, token_fd, 0);
 
 	fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 435da95d2058..777627d33d25 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -487,9 +487,10 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
 struct bpf_get_fd_by_id_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 open_flags; /* permissions requested for the operation on fd */
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_get_fd_by_id_opts__last_field open_flags
+#define bpf_get_fd_by_id_opts__last_field token_fd
 
 LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
 LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eea99c766a20..38bc6b14b066 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1619,12 +1619,18 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 	return btf;
 }
 
-struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
+struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd)
 {
 	struct btf *btf;
 	int btf_fd;
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
+
+	if (token_fd) {
+		opts.open_flags |= BPF_F_TOKEN_FD;
+		opts.token_fd = token_fd;
+	}
 
-	btf_fd = bpf_btf_get_fd_by_id(id);
+	btf_fd = bpf_btf_get_fd_by_id_opts(id, &opts);
 	if (btf_fd < 0)
 		return libbpf_err_ptr(-errno);
 
@@ -1634,6 +1640,11 @@ struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
 	return libbpf_ptr(btf);
 }
 
+struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
+{
+	return btf_load_from_kernel(id, base_btf, 0);
+}
+
 struct btf *btf__load_from_kernel_by_id(__u32 id)
 {
 	return btf__load_from_kernel_by_id_split(id, NULL);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8e32286854ef..6b85060f07b3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10024,7 +10024,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
 	return libbpf_err(err);
 }
 
-static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
+static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd)
 {
 	struct bpf_prog_info info;
 	__u32 info_len = sizeof(info);
@@ -10044,7 +10044,7 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 		pr_warn("The target program doesn't have BTF\n");
 		goto out;
 	}
-	btf = btf__load_from_kernel_by_id(info.btf_id);
+	btf = btf_load_from_kernel(info.btf_id, NULL, token_fd);
 	err = libbpf_get_error(btf);
 	if (err) {
 		pr_warn("Failed to get BTF %d of the program: %s\n", info.btf_id, errstr(err));
@@ -10127,7 +10127,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 			pr_warn("prog '%s': attach program FD is not set\n", prog->name);
 			return -EINVAL;
 		}
-		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd);
+		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd, prog->obj->token_fd);
 		if (err < 0) {
 			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %s\n",
 				prog->name, attach_prog_fd, attach_name, errstr(err));
@@ -12923,7 +12923,7 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	if (target_fd) {
 		LIBBPF_OPTS(bpf_link_create_opts, target_opts);
 
-		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd);
+		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd, prog->obj->token_fd);
 		if (btf_id < 0)
 			return libbpf_err_ptr(btf_id);
 
@@ -13744,7 +13744,7 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 
 	if (attach_prog_fd) {
 		btf_id = libbpf_find_prog_btf_id(attach_func_name,
-						 attach_prog_fd);
+						 attach_prog_fd, prog->obj->token_fd);
 		if (btf_id < 0)
 			return libbpf_err(btf_id);
 	} else {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index de498e2dd6b0..76669c73dcd1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -409,6 +409,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
 			 int token_fd);
+struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
-- 
2.48.1


