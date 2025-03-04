Return-Path: <bpf+bounces-53242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B0A4EF44
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7682188DAF5
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7172641F4;
	Tue,  4 Mar 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUUq1nlt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B327810B
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122914; cv=none; b=t8H1O3y0htOYWMTJcb6VET+uEliydNwy0HbBNFYW4zuECCQT0AM8iOJbLrerR5BDBRrBLHgek/ij90vM3Ij0PYdNfi7Mc3cEjxoVX1MrqT87uWxSaCelW7Y38xMXE/FZ6XFgfIGNbAWEJ7+K4kCtlC+o+tWv5W1iENTkLS//Obs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122914; c=relaxed/simple;
	bh=aSWR4poZCWrBIGciP1SHBOElDGS7YtXIAK1ujnS+OBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf1TGW+s+mpX1HxZ6EYw6rp3wIzZQdqVzKDkVLCSxn472OUPOl+gPywH5WqqN+7LDsUBKwKb/gnEnM637KucfrQ0J8eac2lRHXSWssr06qj/Ikj55RFCAhRDITY4FgtDAoivey1op0/8MJihJAYyOiCDJkwgI8FrcO2wR3SUVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUUq1nlt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso4948325a12.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122911; x=1741727711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snpfOmieYgaJqPfBzd32DQFt0eMmhWKAQE2ih1F2TD8=;
        b=dUUq1nlt9mybtTDRRXnt0Vj/ZIEQx9klNin/ifDAb9kH+qdGZNgGj8tL77tBtEmPat
         v+PTJIQ6vD1ttQ9zw0J+TMmoo+dyGsPOGNDopzlh968snAgtebzrWDgBj/XIvEm2ptTQ
         Qjh/W3txa6y/rbIqOCh/Jrs9B7GIvYhsXxszhokauKCJfqUrLWvKpf/+/ToYvscJ3G2m
         DcPkTWiL2yysIFck+r3/Jg+WOe2r/+Ueku2XJv0H36KOdmJPC7rr0OpAVpAyrpDS8S+g
         H9qB3w6Si4IlMt04BntQ7T4H+32KARAPX+46zmdHfsCk2J5yiqD1YzR5bISOeVW7X9no
         ZrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122911; x=1741727711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snpfOmieYgaJqPfBzd32DQFt0eMmhWKAQE2ih1F2TD8=;
        b=Xf6Ecc5PH4O1C7dPdVmsT0SKSC2a3+wyTUQpu8pdQX8L5J7pmNW85BSlVQ1udg90ys
         bHhjh7bK90iwn4waFDTFDlzFVmdn6VJl+dLUTtMyseum2lSWGn2w+LrOGWgiyIjuvpQl
         Nri0h60wisTQB5rlS4dW0GhIPEjUCox2vMHX85XGj7yP4Wk9rPc5KMZl+kKTIlP4247E
         ykQMkkgWaPrtGbiPY7VHXCyD2ugNaUVQVhoQT/RC7ngvhocqnvZkKWsK2BMAMcDA+Xha
         vOfCSnSgPdh5CuOnpDD/b6WskabNTwfvRal11YPvEYJjcrXIRcWExeGin8ckos2/3Fhy
         gzvA==
X-Gm-Message-State: AOJu0YxprBiC7QvwA6PSvM1T4tQsHFHqxocBR+1XxvpZdtEb+3DjHzRZ
	/ulL/zLJt2/a/yjILBvViSVAvYX7W+6IaP2PlyLBfChAadIlcuzpNZNcHQ==
X-Gm-Gg: ASbGncsP4y9AOupdedQ7GuwwV/EIU+XAFc9/h5bVkZjkPoi1I6pkpzpGu1njrepqqxK
	6EnKQ5rHhnUhAMJ6fT+Y6UK4LJe95N3O7NhbmS1c/Kb4ydzGZ6NhyTnJ7GQFIN/cUC3ed1YUy4l
	fXBJba2OLPUyDmP0LxtvtqwF0wxb4XaMNFNCUyQ0Iv/KJ7kZEZ1XqPKJlI/WIeU6l/bE7u8mS3w
	noMpikZs0zJOfoarT1IJROmV7ViHWUp3AY73ErXFel1Gk2qgKxpY7JgO0Qv+BLRHV7ZmiZrpQq8
	nOLSEidywDZMXAmq5NZH/JE0nwoLeyNK+o8iSI4DR9jtY8UHwJmTXbfonH8=
X-Google-Smtp-Source: AGHT+IFqzxpkdqK5LYZO+3Psa5gT1iHq0fhCdH18+CSxczjJxcFyPfO7gmrKDCydCb/sWTP3SKD5xw==
X-Received: by 2002:a05:6402:3553:b0:5e5:3343:4320 with SMTP id 4fb4d7f45d1cf-5e59f389da8mr541140a12.12.1741122911001;
        Tue, 04 Mar 2025 13:15:11 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:8902])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4ae60sm8582112a12.10.2025.03.04.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:15:09 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 2/3] libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
Date: Tue,  4 Mar 2025 21:14:59 +0000
Message-ID: <20250304211500.213073-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com>
References: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com>
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
 tools/include/uapi/linux/bpf.h  |  1 +
 tools/lib/bpf/bpf.c             |  3 ++-
 tools/lib/bpf/bpf.h             |  4 +++-
 tools/lib/bpf/btf.c             | 10 ++++++++--
 tools/lib/bpf/libbpf.c          | 10 +++++-----
 tools/lib/bpf/libbpf_internal.h |  1 +
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bb37897c0393..73c23daacabf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1652,6 +1652,7 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
+		__s32		token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
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
index eea99c766a20..251071e1ce1d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1619,12 +1619,13 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 	return btf;
 }
 
-struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
+struct btf *btf_load_from_kernel_by_id_split(__u32 id, struct btf *base_btf, int token_fd)
 {
 	struct btf *btf;
 	int btf_fd;
+	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts, .token_fd = token_fd);
 
-	btf_fd = bpf_btf_get_fd_by_id(id);
+	btf_fd = bpf_btf_get_fd_by_id_opts(id, &opts);
 	if (btf_fd < 0)
 		return libbpf_err_ptr(-errno);
 
@@ -1634,6 +1635,11 @@ struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
 	return libbpf_ptr(btf);
 }
 
+struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
+{
+	return btf_load_from_kernel_by_id_split(id, base_btf, 0);
+}
+
 struct btf *btf__load_from_kernel_by_id(__u32 id)
 {
 	return btf__load_from_kernel_by_id_split(id, NULL);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8e32286854ef..6b21086156a9 100644
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
+	btf = btf_load_from_kernel_by_id_split(info.btf_id, NULL, token_fd);
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
index de498e2dd6b0..fe99fc85617e 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -409,6 +409,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 int btf_load_into_kernel(struct btf *btf,
 			 char *log_buf, size_t log_sz, __u32 log_level,
 			 int token_fd);
+struct btf *btf_load_from_kernel_by_id_split(__u32 id, struct btf *base_btf, int token_fd);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
-- 
2.48.1


