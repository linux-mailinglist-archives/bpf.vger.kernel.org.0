Return-Path: <bpf+bounces-48468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E0CA08266
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2267A0604
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBF204C37;
	Thu,  9 Jan 2025 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jOHT0rX9"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797D23C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459265; cv=none; b=ssM7M/UE8w2AWlOHUTW2YJ34aMIoaD6pfozeIIiooa9awiQcMeXx/OidaJVepITx91IqkWDToftjyHlTtkSBofOF5DiLXEf6obsctSHJN1Zpychl2COBJfpO3zeasHLv0ygBaMHiZEp8hvN8VTGH0LswcO1GQ+PVQxigDDQKlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459265; c=relaxed/simple;
	bh=FWmDC9rD8/kZK4E4pbs5Q12mS0bdq9C9AoCSS5Rp6rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+sB63b9N2MS9zFhkGOnRz0jAUqublMJ1v2dGzWQ9wQWhyEUC8hWzxmuiS19PyQibrdf93nhCOA90uhDQkZ388kw2F2RNdslwHia7AgMVUECXquZCCyt7eirhGKchDdHo/vyrbmgeHnQUGD8jw5ZXCy3mF/a+0NnRQM2hYrV82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jOHT0rX9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06BAC203E3A1;
	Thu,  9 Jan 2025 13:47:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06BAC203E3A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459263;
	bh=J2EIM2dLjlYqOYZXDG8ot5dzcKzX/R4eEuT7G/WwMEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOHT0rX9j59VYktkc5Qq5CgQGbplx+WKnocMVLU9n+WhgdhgqyU+wDlAuBcE620YR
	 jcTSroE5QVk8Fzv0zWInVMxamGoc+KhKg/zXqk9cz4nC7A6UndJkaLk7NlCDUQpSeP
	 HqYIYeW/05xUAcUxW8vDQJYHwdNZMrh5MmQDTgW0=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 06/14] bpf: Add BPF_LOAD_FD subcommand
Date: Thu,  9 Jan 2025 13:43:48 -0800
Message-ID: <20250109214617.485144-7-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here we define a new subcommand for the bpf syscall.

The new subcommand takes a file descriptor to a raw elf object file,
an a array of file descriptors for maps created in userspace, and a
file descriptor pointing to a sysfs entry that is later used to store
relocated instructions.

Additionally some book-keeping data for kconfig and arena map offsets
is passed in along with file descriptors corresponding to any kernel
modules being used.

The basic strategy employed with BPF_LOAD_FD is to allow userspace
and libbpf to continue to operate as they do now with respect to maps,
while deferring all of the relocation to the kernel so that userspace
isn't required to process the program before loading.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/uapi/linux/bpf.h       | 28 ++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  2 +-
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4162afc6b5d0d..6dd01db541c26 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -902,6 +902,20 @@ union bpf_iter_link_info {
  *	Return
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
+ * BPF_LOAD_FD
+ *	Description
+ *		Load a file descriptor corresponding to a raw elf object file
+ *		into the kernel, and associate it with a sysfs entry. The
+ *		kernel will then perform relocation calculations and instruction
+ *		rewriting on behalf of the user.
+ *
+ *	        Programs contained in the elf file can later be loaded via
+ *		BPF_PROG_LOAD, by passing in a sysfs file descirptor along with
+ *		the symbol name of the program.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
  *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
@@ -958,6 +972,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_LOAD_FD,
 	__MAX_BPF_CMD,
 };
 
@@ -1573,6 +1588,8 @@ union bpf_attr {
 		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32		prog_token_fd;
+		__s32           prog_loader_fd;
+		__aligned_u64   symbol_loader_name;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1827,6 +1844,17 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_PROG_LOAD command */
+		__u32		bpffs_fd;
+		__u32		obj_fd;
+		__aligned_u64   maps;
+		__u32           map_cnt;
+		__s32           kconfig_map_idx;
+		__s32           arena_map_idx;
+		__aligned_u64   modules;
+		__u32           module_cnt;
+	} load_fd;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dc763772b55e5..37e45145e113b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2730,7 +2730,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD prog_token_fd
+#define BPF_PROG_LOAD_LAST_FIELD symbol_loader_name
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4162afc6b5d0d..89d47c8c43c79 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -958,6 +958,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_LOAD_FD,
 	__MAX_BPF_CMD,
 };
 
@@ -1573,6 +1574,8 @@ union bpf_attr {
 		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32		prog_token_fd;
+		__s32           prog_loader_fd;
+		__aligned_u64   symbol_loader_name;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -1827,6 +1830,17 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_PROG_LOAD command */
+		__u32		bpffs_fd;
+		__u32		obj_fd;
+		__aligned_u64   maps;
+		__u32           map_cnt;
+		__s32           kconfig_map_idx;
+		__s32           arena_map_idx;
+		__aligned_u64   modules;
+		__u32           module_cnt;
+	} load_fd;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.47.1


