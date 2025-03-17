Return-Path: <bpf+bounces-54221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8956DA65B1F
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235193BB891
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0D1B0F30;
	Mon, 17 Mar 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcOgmqF9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AF21A3BD8
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233253; cv=none; b=S3ZVv1ldRGq0Xr9OiSiv096R5p0dd1zrc5PnZWjykkR1P6oJBR6uZvX4Xa4xL5aAaTb4LofUFcmLd131O7pCUCngBKo0r4BOReSqQ+x1oDZQ4MmwsN9vf9pL0zdLAxdIutpRy8D8KAdyJpNGP6XzhXoNRnqvJcW02B3XPVo/Jbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233253; c=relaxed/simple;
	bh=WrTQfOLg8ZbwWKlI4huPsh2RoBWA0mthoXYTmUuK3bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNhvk12Rzy5G8hhAqXpXKHBaRgj6cgqW0vOK9WjV37zYlfOvw7Leu61dAOB+GwiNkOvRC2f8g5LEWmh+sHYV74gHUVy6SxCKVzQE+QO0+PskhffCOYXzRaizRhmu5hRShtGSVGnfYeBhbXKQEQMCBQ4ZHIfOx+Zf4SEdPwvLVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcOgmqF9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2aeada833so925408466b.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233250; x=1742838050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Etrm9x8xkyPVlC012p8LxpAAlEOufd5DjE1GG/S8pDI=;
        b=FcOgmqF9Cc2ytfSChmzQtcVm4C7xICHUdqxh5h94Y2jM8/R1YkOj2RG7PnRMErno1k
         ySU1gLYjvAI/PU0EZFD+4AVCF2knscxPgnJdzQQW9FZN4NvUkvbUcHUx4acAUKVuzILF
         qtfpDa0rr28mzMG6SLTsWUcGMCpD0zQPuzoWR4p9L5HCanMprLKsb8+uXwLkscreRTfe
         6JozDSvrB4adyBnPdCr5BJec1RkfJsT4zCKDP3Ejc4+NWAyI5oKotjXKUh8c/+HHLatc
         Q55B/sHMsS1eqfGU+/FCpZSZlTPgB6ZsqALmx4rBEGcSBRrPD1oz3Zs9DwlTzXHnJApP
         d6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233250; x=1742838050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Etrm9x8xkyPVlC012p8LxpAAlEOufd5DjE1GG/S8pDI=;
        b=WoKrxY5etJKZzaDFt3MZye2ciMwK0bB9A4agKdQ5cQ2uhLfGYbRA0rVoA/cQhQptVe
         FXRsOJHEenQn8piinrZiWRCksiIco+IBmTBNeKCJ7Ur+B8E122n4a9WLWZ3TvYvFbkpl
         1G2BKkZUTW73TEkF2IP8yJ3Ccn1ovbUetPqUwnDQ+2CIBAFeycoxsNhRp6w6PGPS7bW5
         fjaQoZ66dD9xo9qCm5s0R+gtEBg9nc/RAsJxmAjSI++3UHW5CyUZ1VuqRljsH3Pbla1O
         4QYVKCw05mDyxh+OQI9Ek8kFmjTSJ9jWkQsueK60tYveYHliRyd0GYEgqGUebIwxGQZc
         VBNA==
X-Gm-Message-State: AOJu0YxZUFODx3BZG+74B34MHEmufElYXt5Q9VJVolDUC2aIDNdJ9NUN
	Ugv0jKKA0DSbPG9sjuGseZPdhgxMEVbvOXvE3YTmo2tJl2wjXWJnsnEcWw==
X-Gm-Gg: ASbGncv5mVWOwhHlRVdt1sqZDRq0vaOm2YPi4z+J17DorxJxWbDBNpqiIojVaNxrFkS
	6pqNcKOI4TtYZbGlwGoywSni5wi0KZ1FJNunYe5cViNuNb15d8QxJBTDh1uIyCB0+Anlzsz7brp
	Mda5Qne6NYmZ+Xhq4hV81kbSVshISB+Sd9dBHpR2SRqEXiEA+EFrYx6vyfqjriRylINwlPfSOA+
	twirTnU6BKD47BmO+Qjfoi+j7QsQChnvHknVGWiTSJMuDt+iqINZ7c4hI5KDf4H+qHk1qQ/yTgn
	pwbjL/HyJ+hqRHW5kvwg/zh3PtrNfDjYCADfEH2YNxkb17WKlcscm0DZQw==
X-Google-Smtp-Source: AGHT+IHTO7FD1YCmzFXZrLsjS1Gr8LjcRVw1x/49Go4t+nModLmGADEamFfCD7/fejPCDyd3TjYc6g==
X-Received: by 2002:a17:907:d2dc:b0:ac3:8895:2775 with SMTP id a640c23a62f3a-ac38f7dc415mr45476166b.13.1742233249699;
        Mon, 17 Mar 2025 10:40:49 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:812])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9cadsm693917166b.48.2025.03.17.10.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:40:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/4] libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
Date: Mon, 17 Mar 2025 17:40:38 +0000
Message-ID: <20250317174039.161275-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
References: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
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
index 359f73ead613..a9c3e33d0f8a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1097,7 +1097,7 @@ int bpf_map_get_fd_by_id(__u32 id)
 int bpf_btf_get_fd_by_id_opts(__u32 id,
 			      const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
+	const size_t attr_sz = offsetofend(union bpf_attr, fd_by_id_token_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -1107,6 +1107,7 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
 	memset(&attr, 0, attr_sz);
 	attr.btf_id = id;
 	attr.open_flags = OPTS_GET(opts, open_flags, 0);
+	attr.fd_by_id_token_fd = OPTS_GET(opts, token_fd, 0);
 
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


