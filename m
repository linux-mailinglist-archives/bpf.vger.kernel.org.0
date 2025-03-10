Return-Path: <bpf+bounces-53702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF42A5899E
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 01:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F66B188BD78
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141BD3C0C;
	Mon, 10 Mar 2025 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpdWcHqE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD75234
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565634; cv=none; b=rrOSBwti9p7qVehMy9j4r32jmznRC2lnkZmXzzi4EPqajX738WKFkAkB6ODrBhqr9elvn1ZTuVnR2g0uUgd6ZqZXnIaC4fJw4GajgmD+gnSpi78js+2v3QatF94bj04a4muYcnd19N1urh84eEmrcbr5L6BHGSVgwFDEFQ3qEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565634; c=relaxed/simple;
	bh=kp/e0qNgxefwuXywmlYVPGMm2rI2DWDgEWT016wzcjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbJzYLT6NiL7UBIuweEZGQzRILC/zBLmJ6ihdLRHLkXXc7cs7D6B80gP9iJYTO/k+lbEEIzkXqFWb+2O/JsZpjOabjXKQa+XRiCoFsABmqloseVsY7oMv1yNFsKJyySxHFDjo+SziwfUTlmNyQ01CvXKznbrMUBHHLX6CuWeTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpdWcHqE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so30833955e9.1
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741565631; x=1742170431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UNF5GwknDE0vG6ee0NeasWfh0uGpqULTZqDPRg4pUU=;
        b=GpdWcHqEcRros0XT8Gr9BlJCsfFE5IFTU7DRsA+gIsUTLIyjAPVtU6ZrhjSUqFpd0e
         2EfRYu5s4nXYWuyR8RXLnI30lWDReVgLk4ZfQqjoZvQPuVT1Ue8KZSsnifyXqnBl6BhN
         7w4DbJ9KI3GA8yIeJqnCG+s9IDPWukqVospBh2g/JGeGmFX5NIn8+++RH4QdUVriw9o/
         TTJ87EqUTGiH5yHfr1f7FKF8b4ZvwFaO9+l8XEEiUERITNa6FN1R8YDAD/7c7Yh1Ozu0
         MK2WV1Gaf1nVI7mAzkHOe3s0vg+jDs5ap6pkBYeKslUkz/yvbu1mYVhC2PwbeX2ahaeP
         Q0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741565631; x=1742170431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UNF5GwknDE0vG6ee0NeasWfh0uGpqULTZqDPRg4pUU=;
        b=jSXMA5t3P+kQrZrYybeSSqMhwutSBD7sVBouUC35eiHwpmC6YeecDskHBx82U3OrZh
         WqqtihSLolbJnhNdzd9zw6Wsw6frI5GpIz5OZkHMnQZcxtGjzn+ZVJ99JP/tWmGNwOkP
         2r9L3cuEdGL54QpRc63l055mh2Dl1yoaMUmkAH8lrq07p9TjwEGbAhclVTOdT2PEhC3m
         5SUMXUkMqpDKbfyF865ymJ1Lcoft+/3xZXWMJ22/+er2k8PgI9wjlHe30oSB7b3yhIGB
         wrT0HkWWBwuHsEwN9UpxE/ehXNMWovBKXDc8XrrREzy1cnB6dYToE4SpXv2AsJVkH9a2
         mamA==
X-Gm-Message-State: AOJu0Yxiu15WC47GkfDtxVMHi7bnPoz23zXw4Bd8pUPdX3rJGMba+7ZL
	bZozeOl/LVWOlDS2GyRqOm1Uc79UV4QhOWTuLv6OySc8k+2NnV1INhyD9A==
X-Gm-Gg: ASbGnctk4AOHImMjqhARDfY0rudez0mKJImYx4GuCtLWw6cBJDAnmVA6bCBM4GPmXRu
	k+MiSLK3R2GoMWI8WmSmco/sRE1uThfHGc6TUg2rJE1/VUwQS0IyjT5StEO09cjiYDQJK3Husns
	X0LSs1B02Ztf6vylVVMP4p+XQVmwSEb7B1RF1uZyKYCXhaDlnHjEwLjVX7sEVzz8xMEgObBn3t9
	uKr6OIVFRRff7+BO5e60bd3LiT7Kp2/WfY9JNu3NPxzRTb3WHjIYpcb0fUTAlpaMpoMFf7u5FcI
	saf+IfOyYk2NB87Wf6XMfi3P2Z3ywrrL9a1TvXYoNAWqNJDk20RN9BnIypjoH58BJVjcuSjuEi7
	NEfoXhUPikoiT9sAiohC6N/Bvv07m+Mai73LmekDiHUGIIRtfkcsDPf0ltmeo
X-Google-Smtp-Source: AGHT+IGcMwxRyqLW6YdkrOnlK8E2m79BgR/omERIcliztyZzLsJXn3dP6bhusR3lNSAAo8BgLyb1eA==
X-Received: by 2002:a05:600c:3b28:b0:43c:f332:7038 with SMTP id 5b1f17b1804b1-43cf3327200mr15103515e9.21.1741565630764;
        Sun, 09 Mar 2025 17:13:50 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm13181050f8f.0.2025.03.09.17.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:13:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/4] libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
Date: Mon, 10 Mar 2025 00:13:18 +0000
Message-ID: <20250310001319.41393-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
References: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
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
 tools/lib/bpf/bpf.h             |  4 +++-
 tools/lib/bpf/btf.c             | 15 +++++++++++++--
 tools/lib/bpf/libbpf.c          | 10 +++++-----
 tools/lib/bpf/libbpf_internal.h |  1 +
 5 files changed, 24 insertions(+), 9 deletions(-)

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
index 435da95d2058..544215d7137c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -487,9 +487,11 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
 struct bpf_get_fd_by_id_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 open_flags; /* permissions requested for the operation on fd */
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_get_fd_by_id_opts__last_field open_flags
+
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


