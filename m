Return-Path: <bpf+bounces-53619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3CA5739D
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 22:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A787A694B
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 21:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673AD2580D5;
	Fri,  7 Mar 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLeYCZ2F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E52580C7
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382988; cv=none; b=aV4FzWTrBRr793o36bn3qClQ4oNH5TyJXAKZ91mBYIEZJPc5P6kDhBsY6G8V37Y4b4zbkvyoTY+oKi8VkdUbAe8aKkk5ecapCIuSBfkaa5jGHVIUUKZ8w+lBta8cqtKTlqXet1fDXqc047KKx0L5elcrDJLxQ9AehE3zjcPepyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382988; c=relaxed/simple;
	bh=pAH6DJM5WKTVlhQa1dSW67kEovIMWL4V2bwazD63tZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNH5Kz4avDcpSLpcUgOKKJHZ3DwF5wSoJBu4h99uMxonlkE2tqi1HYBPSg+hUZnkyd4XrqBkTntISPohTXEZ7ssoQJNS2nABnWQA6RyqGAnAaqfsj+ucu7JWndbQhALwFqafzcGyIMr5ScxQ7D+tgCvm4I3dQkZIrKP1Gb9N3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLeYCZ2F; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390fdaf2897so2397266f8f.0
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741382985; x=1741987785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgEEAiOqgkfh9oPgNuZeeRzfgmXM/drUMjby4IjFxno=;
        b=hLeYCZ2Ftp8O/96qPikivY7zwlCtnoarrhsw+SDJMJilzQInj3ToekPPrUGZRS2vMN
         cxMyFh+yPLU5G1WCuHzUBTRuqbx6rWWrdsipu/39z7FfSxaj7FQ8af0FB56h3Z6nXlME
         civfc5ZgPECZPGihlA9zUnTKczfK58N738IPevRQlXzddnZ+ZM9b6uoRQdOBKcxUIR2e
         UWA79cCdS48HUnOxcu9r2fekA4zXv7axDGvBJb+E1xnOdcVpnQq7cDr93kHZLkZgdSSU
         X6/fM5NStWCqoq6DaZJfpsCtldoqUtAM9ofkbnG8nhl1TGryflESx2298cQOwo1f76/O
         pqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741382985; x=1741987785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgEEAiOqgkfh9oPgNuZeeRzfgmXM/drUMjby4IjFxno=;
        b=HlPsHWb4ZhUIVp0UGykUhgZzQ6doBskM2Rj87To4sq8Y0jy8HTQV0nnUAdm7nw4rGI
         8FJppSvP0GUT+razC+ilRRRGKOgivxVLF3cAYfiWzPRx1A5XNNuMHx408Tm0PxX7hDpx
         dlwW+OGdTb01i3CcYwsD/mTHkscE2WRK9cNhRcUll+J36OuFOVs7pTDAVKCTsNRbrW6a
         dCFB0vNdDMHJHV9L8x0dXqPU7gAPLElHtIKcJCLGnnqCF6VkTAalp2ggAvujT/dg7GsE
         WINeGRS0Jg4zVYx9L/Owtp+3Ekv+ufVlaZ3k3lDBmb3vlZ4TEPGxYvqyuB4NOCmpaEZ9
         5Kng==
X-Gm-Message-State: AOJu0YxUCJn/RxN8+NfQZaqBIk2YHANf/N9ErweA2O5RVt4AXjJ6dbjd
	1DlEuq+ueoiWSnvMxTw4U/WGCN/ZGn91O2KgIR+Sdv1Lo9DTQIJicjHuYg==
X-Gm-Gg: ASbGncuUpXLRxYQAGq4St7CnR2lxMAtZ9qhdQx3KlrUB4ZsbppEmJVPaaqIVnOq0FoX
	BtuYfFg0EY4ENESuAo/RSr/Q0BpCu0X9WltGcGMRxz2qMoY2OfiWbuYTn24Tm9H/D5QllWvt7hN
	Og2jMpxyUQNfm9KDd2BIJpfFvr/eqnvmQDNIS6nNHfp2cELMde0ti+LMGDSgEByF60X7HmL9fvf
	lWGA4CQt1PYQh8Q2GjCw+V5zfKLUuiPkhaztA9CczNjVzqBNrr/kTj9T68cbS9M9STJyZ5jLbvn
	UpLh3NJKngTTCqE9C9bAMjhxKuApiVlqMZGIGDI17UxNdgAMfAjPWwsq3DZI0d4zyVkaZPHJX5a
	W9ber2Yeaenp7XeH6eDojUtCcoNFHU9lUfidVDgtikC/kVkj2Wg==
X-Google-Smtp-Source: AGHT+IHm7FyITqeRMCNz/4hfVL/kwAl89pvHdaX09zVM+qe7eBcBQzWXwaZz3lRZTUGQ27uFY8Zt+g==
X-Received: by 2002:a05:6000:18a4:b0:390:ffd0:4142 with SMTP id ffacd0b85a97d-39132d5a5d8mr4914624f8f.26.1741382985267;
        Fri, 07 Mar 2025 13:29:45 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm92203145e9.32.2025.03.07.13.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:29:44 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 3/4] libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
Date: Fri,  7 Mar 2025 21:29:33 +0000
Message-ID: <20250307212934.181996-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
References: <20250307212934.181996-1-mykyta.yatsenko5@gmail.com>
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
---
 tools/lib/bpf/bpf.c             |  3 ++-
 tools/lib/bpf/bpf.h             |  4 +++-
 tools/lib/bpf/btf.c             | 14 ++++++++++++--
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
index eea99c766a20..466336f16134 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1619,12 +1619,17 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 	return btf;
 }
 
-struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
+struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd)
 {
 	struct btf *btf;
 	int btf_fd;
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
+
+	opts.token_fd = token_fd;
+	if (token_fd)
+		opts.open_flags |= BPF_F_TOKEN_FD;
 
-	btf_fd = bpf_btf_get_fd_by_id(id);
+	btf_fd = bpf_btf_get_fd_by_id_opts(id, &opts);
 	if (btf_fd < 0)
 		return libbpf_err_ptr(-errno);
 
@@ -1634,6 +1639,11 @@ struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
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


