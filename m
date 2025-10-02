Return-Path: <bpf+bounces-70201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6DBB464E
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FFB3C2922
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C4F235046;
	Thu,  2 Oct 2025 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SDPAFybr"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8178F54
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420162; cv=none; b=mFGikBigE99m2sOIULMrPkiNOIU6mWQtynsJHkRyoZoH0YpNWzdNs7sW6s+qLhMHZL1SNsH7f5or7/KAGciY6wsVwzICreFnt1NzOVguOY0qpTZI1r1+uPgxDuqLh7ZFVo5gaVBTy4gYIsiZSJJTCzcsJkm3ITKIFr12zzHiiSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420162; c=relaxed/simple;
	bh=VBCqnJU+hrpTf4EEol0smvmUCw+GPCuYkT2Nzo/AC2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9izUEqrObM64m6fVsiz+cu4+8KOMA6kiRJzodppEzQ6J3PQgexw9+ccrqOmJah3OKEbUv1JzrxvE64Q/ssPKZe9LKNKwjyUX+yQuiAVaAoF9szuXvBxYGDJHl+8kYjo++jNhTcLWFmYTEp2Fxo+Sg/xZxP5qO5WQeJRkOeBxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SDPAFybr; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Vlu/hQHthmPhF+EZzWb/8uJq/AE+u4XS+KH/E1Bn5A=;
	b=SDPAFybrZ+ptPh2WQ5eYX1JL+qpIFRVEbub2LZg44UoDaspmt5Wdd5a8L9aVJZgwcVILeE
	FvqYtIjSCSRmZSflkJGUspVFg0kLXT8ppTyIaMzfdRn7NURpQI9KHTU6PRGdsM436Da+NL
	lzgLio4SPTC1LaBT9Vqu49KPXJPlOzw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 02/10] libbpf: Add support for extended bpf syscall
Date: Thu,  2 Oct 2025 23:48:33 +0800
Message-ID: <20251002154841.99348-3-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-1-leon.hwang@linux.dev>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To support the extended 'bpf()' syscall introduced in the previous commit,
introduce the following internal APIs:

* 'sys_bpf_ext()'
* 'sys_bpf_ext_fd()'
  They wrap the raw 'syscall()' interface to support passing extended
  attributes.
* 'probe_sys_bpf_ext()'
  Check whether current kernel supports the extended attributes.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c             | 33 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/features.c        |  8 ++++++++
 tools/lib/bpf/libbpf_internal.h |  3 +++
 3 files changed, 44 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b197972374..9cd79beb13a2d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,39 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
+static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
+			      unsigned int size,
+			      struct bpf_common_attr *common_attrs,
+			      unsigned int size_common)
+{
+	cmd = common_attrs ? cmd | BPF_COMMON_ATTRS : cmd & ~BPF_COMMON_ATTRS;
+	return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_common);
+}
+
+static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
+				 unsigned int size,
+				 struct bpf_common_attr *common_attrs,
+				 unsigned int size_common)
+{
+	int fd;
+
+	fd = sys_bpf_ext(cmd, attr, size, common_attrs, size_common);
+	return ensure_good_fd(fd);
+}
+
+int probe_sys_bpf_ext(void)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
+	union bpf_attr attr;
+	int fd;
+
+	memset(&attr, 0, attr_sz);
+	fd = syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
+		     sizeof(struct bpf_common_attr));
+	fd = errno == EFAULT ? syscall(__NR_memfd_create, "fd", 0) : fd;
+	return ensure_good_fd(fd);
+}
+
 static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 760657f5224c2..d01df62394f89 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -507,6 +507,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+static int probe_kern_extended_syscall(int token_fd)
+{
+	return probe_fd(probe_sys_bpf_ext());
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
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index c93797dcaf5bc..af05df8d040ce 100644
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
 
@@ -740,4 +742,5 @@ int probe_fd(int fd);
 #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
 
 void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_LENGTH]);
+int probe_sys_bpf_ext(void);
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.51.0


