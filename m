Return-Path: <bpf+bounces-77975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC7CF97FC
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 18:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC6EA302A462
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28D280327;
	Tue,  6 Jan 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u2HcALvs"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB92F6562
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718808; cv=none; b=G3Q40vFQkdxZHol1Ow7/nUSKaI+PC0aasvwkZ/yFwveAntAnADdy2l1sxGIA0JfthLsYHUPkZA4uB1RBR5stIZhZZDRnNsTY1XQ4qrbEJLvZMpibzhRhPHkAvkTrq5UntdH7+TTIL3SfSX59Z038WTm/xluHEn+/DNo+gI5e8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718808; c=relaxed/simple;
	bh=oxIVZtcibxIdlrQ7G9EZOx7tfCuyfYgUcq67L6JvSzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj21SJ6bL9Vi2UcnkeKHfzYimzvlQmNxLBIelQGJUvArMd80D7UfCEIy6pFgZlC7FkgVf/9bVhs8QXNlVSCLQOSEz0aieh6umpVPVdXL2bNvyYZluZV4ayO1cJ3oDBsqKXlFGoeDytfOVe5cUmorlQn5XjPbZcLSH88esjwrP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u2HcALvs; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767718803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUTAxF7YINRUTHUdOTMsQNv3ktVF4OtuYgRb7ZMltyA=;
	b=u2HcALvs0CiGxOjd5OFYr+fS1XYGuRKqyjHukvxkiJnfA3MC0JEXVHITaQ+6W5Y70JTImk
	yXyiQ6dz2eOCRPUm4ir8bZZbyv9Fz7amJgEkfNzJYTOFeUWGr0GwEDAZQbJDqdYPODEtfF
	YFnz3mAX8PGtvyQnasCG9F/Rdwyz4ec=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 1/9] bpf: Extend bpf syscall with common attributes support
Date: Wed,  7 Jan 2026 00:58:59 +0800
Message-ID: <20260106165907.53631-2-leon.hwang@linux.dev>
In-Reply-To: <20260106165907.53631-1-leon.hwang@linux.dev>
References: <20260106165907.53631-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend the BPF syscall to support a set of common attributes shared
across all BPF commands:

1. 'log_buf': User-provided buffer for storing logs.
2. 'log_size': Size of the log buffer.
3. 'log_level': Log verbosity level.
4. 'log_true_size': The size of log reported by kernel.

These common attributes are passed as the 4th argument to the BPF
syscall, with the 5th argument specifying the size of this structure.

To indicate the use of these common attributes from userspace, a new flag
'BPF_COMMON_ATTRS' ('1 << 16') is introduced. This flag is OR-ed into the
'cmd' field of the syscall.

When 'cmd & BPF_COMMON_ATTRS' is set, the kernel will copy the common
attributes from userspace into kernel space for use.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/syscalls.h       |  3 ++-
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/syscall.c           | 25 +++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cf84d98964b2..729659202d77 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -937,7 +937,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
-asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
+asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size,
+			struct bpf_common_attr __user *attr_common, unsigned int size_common);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 84ced3ed2d21..dcae1f3e50b7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying bpf_common_attr. */
 };
 
 enum bpf_map_type {
@@ -1489,6 +1490,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6dd2ad2f9e81..8f464b847405 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6160,8 +6160,10 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
 	return ret;
 }
 
-static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
+static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
+		     bpfptr_t uattr_common, unsigned int size_common)
 {
+	struct bpf_common_attr common_attrs;
 	union bpf_attr attr;
 	int err;
 
@@ -6175,6 +6177,20 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	if (copy_from_bpfptr(&attr, uattr, size) != 0)
 		return -EFAULT;
 
+	memset(&common_attrs, 0, sizeof(common_attrs));
+	if (cmd & BPF_COMMON_ATTRS) {
+		err = bpf_check_uarg_tail_zero(uattr_common, sizeof(common_attrs), size_common);
+		if (err)
+			return err;
+
+		cmd &= ~BPF_COMMON_ATTRS;
+		size_common = min_t(u32, size_common, sizeof(common_attrs));
+		if (copy_from_bpfptr(&common_attrs, uattr_common, size_common) != 0)
+			return -EFAULT;
+	} else {
+		size_common = 0;
+	}
+
 	err = security_bpf(cmd, &attr, size, uattr.is_kernel);
 	if (err < 0)
 		return err;
@@ -6310,9 +6326,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
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
@@ -6343,7 +6360,7 @@ BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
 	default:
 		return -EINVAL;
 	}
-	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size);
+	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size, KERNEL_BPFPTR(NULL), 0);
 }
 
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6b92b0847ec2..2cb847b38f20 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -986,6 +986,7 @@ enum bpf_cmd {
 	BPF_PROG_STREAM_READ_BY_FD,
 	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
+	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying bpf_common_attr. */
 };
 
 enum bpf_map_type {
@@ -1489,6 +1490,13 @@ struct bpf_stack_build_id {
 	};
 };
 
+struct bpf_common_attr {
+	__u64 log_buf;
+	__u32 log_size;
+	__u32 log_level;
+	__u32 log_true_size;
+};
+
 #define BPF_OBJ_NAME_LEN 16U
 
 enum {
-- 
2.52.0


