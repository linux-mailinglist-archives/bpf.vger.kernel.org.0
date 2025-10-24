Return-Path: <bpf+bounces-72162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A815C08312
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 23:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7742401B15
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C521305946;
	Fri, 24 Oct 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVg6RR3I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12771304982
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341360; cv=none; b=LI1bVSqU08zGO7vGR1MjLJ6RJiR8ZpnDRStJVwQ1ywx13cwvxZ+zryCkW2VW7u5KVpPhPyKCe8GDeyRVi25nblev7JYZHL9SHVD6dQLJ6O2aPbymzencUhc+Zmrp1I7CVP4WpbYb6sCnC4iU4+sHZqxyxUCBSGnULthVz0OWD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341360; c=relaxed/simple;
	bh=S5Gzkjv488/zqDjuIQgbuI3sfyK2bPsTljuP4qYvWPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWeZR4CVi+GKt9qMQZYAssgzYNgNiFLET32P6XaivD9WUpP13dbmLekylLShU0chDm1gV4VCYEKPZk3BocOrr14WBe05KRdy57V6eH3qRUfPHWGmLomNFGmybvYJ8XQk5jg6ETfENcJI5ebo10tFzbK0R6SUVH+p6X0PlxA1LL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVg6RR3I; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781010ff051so1677984b3a.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761341358; x=1761946158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkHFoq6KcBx33ONImwz70GoNCu2uqRDaYEwP8Pqmg4o=;
        b=YVg6RR3I8OK/UXpLpWYhoqATSjUH8hnC+nyKGOOl++phhU9t8hulnzgg00Um6bq6Mm
         r4wTyPZ42XDFiwWT/H2yc9QxNJVxvuYlmdbeoJxwLipa/7Bnz1psU0kJXvU29R1ji37Z
         BL6ZgFnuR9WbAt5K0gF1bNPoPfWMShBPU8aRsRwC0eNaKOweQgPaU+GRdPdoOJfokT5x
         RgXKuz5eJNiML/tbNYjRUHGufy6VKtCC79pPp0EVcXRs5pE/kot0BDAcwAYU8hVdgNPB
         ei7FDzKmhE1DX5r/Jpt6UZACXc7yya8dophfKJ40UE1llgyO2E/KAwfUwTD2nf2QE7jx
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341358; x=1761946158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkHFoq6KcBx33ONImwz70GoNCu2uqRDaYEwP8Pqmg4o=;
        b=ApIJaX/jply9s1R6FXbYJtvz1/AEPXCGupOYYXE3/MGd7DBTfgAW36yq6YotOuKrK6
         ZJxonnsGoWtqPnb1RDsIqrouX+8sp45uOIBPR29YaAJFHH9Y30yqPue6GujsOw1Mt4Bt
         Ei7SsbpIHHvYPfw8N5cxOLX9IJEVcnrJDon2/JYau/VPV2May1jvDAGZFfz0N3IlucCY
         uwOcjglKbJXJjGKA4Xfsob6fvBwheT8MJHyoUh3lKKUzYf4GiRF2G9g7idNpfsrCdI4O
         zd0Mo/nSQaZz16aBzN5t5aSj1ZTdrYNPT0HSy9qu2MCNETn6ZYwQLA+a7QjhiUU/T9Si
         +t4A==
X-Gm-Message-State: AOJu0YwB61ZYlRZoCNCPuvM+d9RHwUe3h7uW878sJAKl3J+qulICZyym
	rP5fNBUDEFN7BuTzz0DRyzS8Fj20KHihqvKcq5CRrYlbfxS8CfmYsVYrzuNP+w==
X-Gm-Gg: ASbGncscJctbzIo16KBcsdJ0YNGXeymItd1xthG1TU04br+HxiOT82ZTqh2+RIFfk/D
	MjzsMaAhr7leCHNnPw+uJCUiRe8Z6tS3cFFdFhFZgQJ4oDpgrMDBEovG+uorFtCqqWtCFOkkxRs
	tBZaHCsCOtKx+0MBrENzUNr+IsAB5vK6zkhxWW3/PSFgeW+e1+wKPJqpw6xAUAbwZsrNe90QCdS
	hlqx6APliAPDgwYnClhzKrJ3M3ttv8Yu0SPhThlXl/uCxUdYp/zfI4HJefOwcYmWpSseX4qO77+
	yi6q7QnC7ylpGRw4VAYIUzpPyDHRSE9vdK5WI/beGOSIJ/9mlGqja4aI7zaaJc282NHWy8R/ROV
	APN0H110nB268au7Qa8UCqvBxUR7GIW0ADV5i40NfRCvkWEnUv5OX2qsz+O479sbyPQ==
X-Google-Smtp-Source: AGHT+IFPIJV3PzYrj2xOmOHNsB5ExiwdFIeLAeX53s4qFNrtKW/9k1xfCjVvUR+fStL4GF/AgkYL8w==
X-Received: by 2002:a05:6a00:230b:b0:792:f084:404f with SMTP id d2e1a72fcca58-7a2749eab39mr8496153b3a.0.1761341358175;
        Fri, 24 Oct 2025 14:29:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm192529b3a.65.2025.10.24.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:29:17 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/6] libbpf: Add support for associating BPF program with struct_ops
Date: Fri, 24 Oct 2025 14:29:11 -0700
Message-ID: <20251024212914.1474337-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024212914.1474337-1-ameryhung@gmail.com>
References: <20251024212914.1474337-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
command in the bpf() syscall.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 88 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..885b0f891443 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	err = sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
 	return libbpf_err_errno(err);
 }
+
+int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
+			      struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_assoc_struct_ops);
+	union bpf_attr attr;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_assoc_struct_ops.map_fd = map_fd;
+	attr.prog_assoc_struct_ops.prog_fd = prog_fd;
+	attr.prog_assoc_struct_ops.flags = OPTS_GET(opts, flags, 0);
+
+	err = sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
+	return libbpf_err_errno(err);
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e983a3e40d61..1f9c28d27795 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -733,6 +733,27 @@ struct bpf_prog_stream_read_opts {
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_prog_assoc_struct_ops_opts {
+	size_t sz;
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_prog_assoc_struct_ops_opts__last_field flags
+
+/**
+ * @brief **bpf_prog_assoc_struct_ops** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param prog_fd FD for the BPF program
+ * @param map_fd FD for the struct_ops map to be associated with the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return 0 on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
+					 struct bpf_prog_assoc_struct_ops_opts *opts);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f92083f51bdb..863372bfde23 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -13895,6 +13895,36 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 	return 0;
 }
 
+int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+				  struct bpf_prog_assoc_struct_ops_opts *opts)
+{
+	int prog_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't associate BPF program without FD (was it loaded?)\n",
+			prog->name);
+		return -EINVAL;
+	}
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		pr_warn("prog '%s': can't associate struct_ops program\n", prog->name);
+		return -EINVAL;
+	}
+
+	if (map->fd < 0) {
+		pr_warn("map '%s': can't associate BPF map without FD (was it created?)\n", map->name);
+		return -EINVAL;
+	}
+
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't associate non-struct_ops map\n", map->name);
+		return -EINVAL;
+	}
+
+	return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
+}
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
 {
 	int err = 0, n, len, start, end = -1;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..45720b7c2aaa 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1003,6 +1003,22 @@ LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
 			       const char *attach_func_name);
 
+struct bpf_prog_assoc_struct_ops_opts; /* defined in bpf.h */
+
+/**
+ * @brief **bpf_program__assoc_struct_ops()** associates a BPF program with a
+ * struct_ops map.
+ *
+ * @param prog BPF program
+ * @param map struct_ops map to be associated with the BPF program
+ * @param opts optional options, can be NULL
+ *
+ * @return error code; or 0 if no error occurred.
+ */
+LIBBPF_API int
+bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *map,
+			      struct bpf_prog_assoc_struct_ops_opts *opts);
+
 /**
  * @brief **bpf_object__find_map_by_name()** returns BPF map of
  * the given name, if it exists within the passed BPF object
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8ed8749907d4..84fb90a016c9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -451,4 +451,6 @@ LIBBPF_1.7.0 {
 	global:
 		bpf_map__set_exclusive_program;
 		bpf_map__exclusive_program;
+		bpf_prog_assoc_struct_ops;
+		bpf_program__assoc_struct_ops;
 } LIBBPF_1.6.0;
-- 
2.47.3


