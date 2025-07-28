Return-Path: <bpf+bounces-64519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D515B13D07
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B162B7A2744
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503B226E6EB;
	Mon, 28 Jul 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F0TjOadZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7A19ABD8
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712684; cv=none; b=IGKHhZMixgdI8sl26DCuJHmsf/6/UNfx0g0lI9ycq7hJcR5Cx5VIXnp50ioWDuVvi9oX0pN+W95ICP9qzukK+e4efrOyudMjKlT0pXHL3iu/gWPdTb0cfRCLami0f1FuzWGwKss/f7P/GfcyDiokb5sjWcLg5YlcK8qKe/6G5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712684; c=relaxed/simple;
	bh=/iYPXPXSoMeESyQG0CC42c12OaTvJ0Hn/hloULtencc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNmieLubNEZWQreqoCoCbtRtakzotlp6S15AEpHgwsdTw49iXbEmgLLNa/D2lQgtTdWfjLgocinb/CWsIFpznwZEdv+zBY5DPq3Y7Ih4WMr8XwmXn8ltD9Gdqsd8tvaT/Wt2mNkRnNrR3XE7B61HvMe4v0bVGejfbcP4QzdkKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F0TjOadZ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753712679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNMQV/bP/LmxSyFzNFXRUPSQEe6k+HHdLnSrHH2wZQ8=;
	b=F0TjOadZwnjbPucojiA2Pi2XAGIMel//HuwdBsmGJQjVNNgHRwc5eibV+Lu8eg1+o0hR/I
	DiNxzQr2MUXuI2yr9XMR8grLjNFuJU5upNmiKpTTYWiX1s7QKnKmk3Aq0X4XUN1kL+FgdG
	U/lkUTsISZUR1tSkocyqN7kbxf1DKpM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 1/5] bpf: Extend bpf syscall with common attributes support
Date: Mon, 28 Jul 2025 22:23:42 +0800
Message-ID: <20250728142346.95681-2-leon.hwang@linux.dev>
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

This patch extends the 'bpf()' syscall to support a set of common
attributes shared across all BPF commands:

1. 'log_buf': User-provided buffer for storing logs
2. 'log_size': Size of the log buffer
3. 'log_level': Log verbosity level

These common attributes are passed as the 4th argument to the 'bpf()'
syscall, with the 5th argument specifying the size of this structure.

To indicate the use of these common attributes from userspace, a new flag
'BPF_COMMON_ATTRS' ('1 << 16') is introduced. This flag is OR-ed into the
'cmd' field of the syscall.

When 'cmd & BPF_COMMON_ATTRS' is set, the kernel will copy the common
attributes from userspace into kernel space for use.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/syscall.c           | 19 +++++++++++++++----
 tools/include/uapi/linux/bpf.h |  7 +++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..5014baccf065 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1474,6 +1474,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+};
+
+#define BPF_COMMON_ATTRS (1 << 16)
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e63039817af3..ca7ce8474812 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5980,8 +5980,10 @@ static int prog_stream_read(union bpf_attr *attr)
 	return ret;
 }
 
-static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
+static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
+		     bpfptr_t uattr_common, unsigned int size_common)
 {
+	struct bpf_common_attr common_attrs;
 	union bpf_attr attr;
 	int err;
 
@@ -5995,6 +5997,14 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
+	memset(&common_attrs, 0, sizeof(common_attrs));
+	if (cmd & BPF_COMMON_ATTRS) {
+		cmd &= ~BPF_COMMON_ATTRS;
+		size_common = min_t(u32, size_common, sizeof(common_attrs));
+		if (uattr_common.user && copy_from_bpfptr(&common_attrs, uattr_common, size_common))
+			return -EFAULT;
+	}
+
 	err = security_bpf(cmd, &attr, size, uattr.is_kernel);
 	if (err < 0)
 		return err;
@@ -6127,9 +6137,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	return err;
 }
 
-SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
+SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size,
+		struct bpf_common_attr __user *, uattr_common, unsigned int, size_common)
 {
-	return __sys_bpf(cmd, USER_BPFPTR(uattr), size);
+	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
 }
 
 static bool syscall_prog_is_valid_access(int off, int size,
@@ -6160,7 +6171,7 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 	default:
 		return -EINVAL;
 	}
-	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size);
+	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size, KERNEL_BPFPTR(NULL), 0);
 }
 
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..5014baccf065 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1474,6 +1474,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+};
+
+#define BPF_COMMON_ATTRS (1 << 16)
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
-- 
2.50.1


