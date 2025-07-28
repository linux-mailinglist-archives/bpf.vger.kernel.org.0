Return-Path: <bpf+bounces-64520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208CB13D08
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228D97A2268
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B3E26E14D;
	Mon, 28 Jul 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ADYdHu1Z"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410E255F26
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712687; cv=none; b=r9egJFn8s1LVVEWYmjri3u/294jmsci4JBFXKSkKAetP4kQSkyjo5+gIfVX1tbhPXml6KglglomE/VWTy3FnPEpi/nYte8X0AW/npYew9iDLzL2376ydtjdcQGvsJviU7Eh0L3ExuylTLH5v+cbOoZQ8ubtRgFMUaqvwBbJUgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712687; c=relaxed/simple;
	bh=AA3gQoOUMT1eOkLciMkfHBmOjrA6O1vZVMY2LKasDFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpyNJnY/1UFecfadY9zpMSas3SASWIDQgqlSrQmIHx6O7kZVh9Oth5fIpBmcx2ah0tNdXLpTJtL4UqrZG+C20wKLZQEBW/Rw2xl76DEYYYAb/rFAr764OxsRZeb8SG2V11T2SwYhceBMMDEe6IxKFPl+MZZu/GurhvlYxe6ywMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ADYdHu1Z; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753712681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXbx01W2MIa83ZnLM36PhZuc+V4lZvxUiHyHx2e7J64=;
	b=ADYdHu1ZMbRMACLhtYlYkMRbhs3qmKEkgHb53E80IWNE4zm68y+I/o1BYTH67qXgNPA/0r
	bdk9SSioujXd4buJMWztzRba95cRsQv4nFOoZQdrePrkZ4eOvLy5NG6tZPfQi5l7aaS6gH
	AeIK/mASUCOSP1GXyRcJ/E9Nls+4miY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 2/5] libbpf: Add support for extended bpf syscall
Date: Mon, 28 Jul 2025 22:23:43 +0800
Message-ID: <20250728142346.95681-3-leon.hwang@linux.dev>
In-Reply-To: <20250728142346.95681-1-leon.hwang@linux.dev>
References: <20250728142346.95681-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To support the extended 'bpf()' syscall introduced in the previous commit,
this patch adds the following APIs:

1. *Internal:*

   * 'sys_bpf_extended()'
   * 'sys_bpf_fd_extended()'
     These wrap the raw 'syscall()' interface to support passing extended
     attributes.

2. *Exported:*

   * 'probe_sys_bpf_extended()'
     This function checks whether the running kernel supports the extended
     'bpf()' syscall with common attributes.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c             | 44 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h             |  1 +
 tools/lib/bpf/features.c        |  8 ++++++
 tools/lib/bpf/libbpf.map        |  2 ++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 5 files changed, 57 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ab40dbf9f020..de0c5c6c8ae6 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,50 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
+static inline int sys_bpf_extended(enum bpf_cmd cmd, union bpf_attr *attr,
+				   unsigned int size,
+				   struct bpf_common_attr *common_attrs,
+				   unsigned int size_common)
+{
+	cmd = common_attrs ? cmd | BPF_COMMON_ATTRS : cmd & ~BPF_COMMON_ATTRS;
+	return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_common);
+}
+
+static inline int sys_bpf_fd_extended(enum bpf_cmd cmd, union bpf_attr *attr,
+				      unsigned int size,
+				      struct bpf_common_attr *common_attrs,
+				      unsigned int size_common)
+{
+	int fd;
+
+	fd = sys_bpf_extended(cmd, attr, size, common_attrs, size_common);
+	return ensure_good_fd(fd);
+}
+
+int probe_sys_bpf_extended(int token_fd)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	struct bpf_common_attr common_attrs;
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	union bpf_attr attr;
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	attr.license = ptr_to_u64("GPL");
+	attr.insns = ptr_to_u64(insns);
+	attr.insn_cnt = (__u32)ARRAY_SIZE(insns);
+	attr.prog_token_fd = token_fd;
+	if (token_fd)
+		attr.prog_flags |= BPF_F_TOKEN_FD;
+	libbpf_strlcpy(attr.prog_name, "libbpf_sysbpftest", sizeof(attr.prog_name));
+	memset(&common_attrs, 0, sizeof(common_attrs));
+
+	return sys_bpf_fd_extended(BPF_PROG_LOAD, &attr, attr_sz, &common_attrs, sizeof(common_attrs));
+}
+
 static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7252150e7ad3..38819071ecbe 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -35,6 +35,7 @@
 extern "C" {
 #endif
 
+LIBBPF_API int probe_sys_bpf_extended(int token_fd);
 LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
 struct bpf_map_create_opts {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 760657f5224c..a63172c6343d 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -507,6 +507,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_kern_extended_syscall(int token_fd)
+{
+	return probe_fd(probe_sys_bpf_extended(token_fd));
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -582,6 +587,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_EXTENDED_SYSCALL] = {
+		"Kernel supports extended syscall", probe_kern_extended_syscall,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d7bd463e7017..83d3d1af5ed1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -448,4 +448,6 @@ LIBBPF_1.6.0 {
 } LIBBPF_1.5.0;
 
 LIBBPF_1.7.0 {
+	global:
+		probe_sys_bpf_extended;
 } LIBBPF_1.6.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 477a3b3389a0..497d845339a6 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -380,6 +380,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports extended syscall */
+	FEAT_EXTENDED_SYSCALL,
 	__FEAT_CNT,
 };
 
-- 
2.50.1


