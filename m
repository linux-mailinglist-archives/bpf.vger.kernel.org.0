Return-Path: <bpf+bounces-68165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C31B5395F
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3628A4E056F
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D8333A03D;
	Thu, 11 Sep 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zkm34VKj"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A435A28C
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608427; cv=none; b=nv6VSZM0sO7P3p7K/WIeaG1zk3HCrdKjw3yG5s+Q2m9pY8oSgGKMUgT8LrXb4TTiDCteR6OmFLllaUHkEzbbSX5CXYwZPR9Ob482RRf4fUy6rTUsLMxtl6Q0ghrAKF/Ha1monkuHXNL0VYztGcYYfr90+2FlCmD+f7dYCajKT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608427; c=relaxed/simple;
	bh=kLXrBPZ0ZGqXC7Z2eRmxeSmFBWDd2+/D1zvyAcXtVOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1cDn7axccfGWseAjnprsG0joUf6qv4I86kYRB+fuy3yfNEO0vTigPR+5bT3NZjTaMg/lYdNHnosE0rnqu1R3rPTVFlx+iYu2TzNHdoMxVCuh43PLZD2ol8e/xq4Nt8cmKciR60W+FCG7lbO0D3zpTAVUeejvw8XYSxqsjw6hmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zkm34VKj; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757608424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuD5BPJRS/xsu7Mqscs5Zf/Q3ZV8o55u4eJWohtiiCM=;
	b=Zkm34VKj0JblxXvF74SaB4/Q3r8bTNUulXhsQsIzz80wf1rbeopCsprlg22xtW17+MaTL8
	1TenMhaD2rvY24eJWlRKAWQWS8F6+PQ7JJ/VR7qeLPom0/xSmHriPNuEcwvB8sAF1YyAEm
	NkGXFcTCLGpf+4mgTE6p1dEyONOTepk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 2/6] libbpf: Add support for extended bpf syscall
Date: Fri, 12 Sep 2025 00:33:24 +0800
Message-ID: <20250911163328.93490-3-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-1-leon.hwang@linux.dev>
References: <20250911163328.93490-1-leon.hwang@linux.dev>
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
 tools/lib/bpf/bpf.c             | 45 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h             |  1 +
 tools/lib/bpf/features.c        |  8 ++++++
 tools/lib/bpf/libbpf.map        |  2 ++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 5 files changed, 58 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ab40dbf9f020f..27845e287dd5c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,51 @@ static inline __u64 ptr_to_u64(const void *ptr)
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
+	return sys_bpf_fd_extended(BPF_PROG_LOAD, &attr, attr_sz, &common_attrs,
+				   sizeof(common_attrs));
+}
+
 static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7252150e7ad35..38819071ecbe7 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -35,6 +35,7 @@
 extern "C" {
 #endif
 
+LIBBPF_API int probe_sys_bpf_extended(int token_fd);
 LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
 
 struct bpf_map_create_opts {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 760657f5224c2..a63172c6343d0 100644
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
index d7bd463e7017e..83d3d1af5ed1e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -448,4 +448,6 @@ LIBBPF_1.6.0 {
 } LIBBPF_1.5.0;
 
 LIBBPF_1.7.0 {
+	global:
+		probe_sys_bpf_extended;
 } LIBBPF_1.6.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 477a3b3389a09..497d845339a6b 100644
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


