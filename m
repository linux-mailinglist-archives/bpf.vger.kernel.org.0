Return-Path: <bpf+bounces-60578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FAAAD8283
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E08A3B6704
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3A253941;
	Fri, 13 Jun 2025 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub06w66h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F024EA85
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792592; cv=none; b=k2MJkzveohVlH7JEscvoCgMETZTZ+Bs2eP56Xe9jmlLabviy3B0L7rDVLvOwaHZrUlqvsTvq0PyqKyG/UkOoFwumFGgjXdfBlZT4Pb/zrzVmN+51/X18FvN1F0SBHtmnmgXy4tvA4/GNNCRjmpe+zuhuy237e8B11xehnWy00tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792592; c=relaxed/simple;
	bh=1Rlgb1gZsyjD3rapNuiDPWmgea8i39yAHaND5uUyX2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D+vUF/zr/0wZM4BOdi6bCdgOr1nmvkY9tOJjJuj5zDx0hf15o9hByTZSXjgOlLJBNeIjZYX3Wuld1xEbChLXL2WvT58hnj32PCwQdSl0LhZPbCrl9FUKUAwFbuw0Q++DGEAqzSPRCFcMN6+rgk/nqZMwAoiC1PLE+5gem2Mm1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub06w66h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191CBC4CEED;
	Fri, 13 Jun 2025 05:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749792592;
	bh=1Rlgb1gZsyjD3rapNuiDPWmgea8i39yAHaND5uUyX2s=;
	h=From:To:Cc:Subject:Date:From;
	b=ub06w66hjvgH/Gu03ffVx66xotNNfMnE10aKr8BnU8Uo6+sRuF8F6iFToOhX0So8f
	 izcXnLa9OYyyX7rnRNG6FvwNyTxvZqltQ7dvswu+xmFMDzk3/vqVZVsaHfRSSqtxCw
	 nIMUIjB78M+JlrpKaUXcfZIeEtMS9ADlnvvKmSzNdNYHNlYb0/DnICRaf+oqvQ+bQg
	 8+mHkYhXzmcJMvVAu1D9nRKVAZJbzpwxsUi819LRvaQP+9PKYPvWkBSLqdm0Gbwept
	 Y9w6pvGsxUMg4YffvkzLaSRKTl9RGyYCZ+z71nY0aVQg8QK46xWICx+af2qNWpINt6
	 J5lcLIck93+pw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] bpf: Mark dentry->d_inode as trusted_or_null
Date: Thu, 12 Jun 2025 22:28:56 -0700
Message-ID: <20250613052857.1992233-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LSM hooks such as security_path_mknod() and security_inode_rename() have
access to newly allocated negative dentry, which has NULL d_inode.
Therefore, it is necessary to do the NULL pointer check for d_inode.

Also add selftests that checks the verifier enforces the NULL pointer
check.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c                          |  5 ++---
 .../selftests/bpf/progs/verifier_vfs_accept.c  | 18 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c  | 15 +++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14dd836acb13..5c7775cf1259 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7104,8 +7104,7 @@ BTF_TYPE_SAFE_TRUSTED(struct file) {
 	struct inode *f_inode;
 };
 
-BTF_TYPE_SAFE_TRUSTED(struct dentry) {
-	/* no negative dentry-s in places where bpf can see it */
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
@@ -7143,7 +7142,6 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
-	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct dentry));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
@@ -7153,6 +7151,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 				    const char *field_name, u32 btf_id)
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index a7c0a553aa50..3e2d76ee8050 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2024 Google LLC. */
 
 #include <vmlinux.h>
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
@@ -82,4 +83,21 @@ int BPF_PROG(path_d_path_from_file_argument, struct file *file)
 	return 0;
 }
 
+SEC("lsm.s/inode_rename")
+__success
+int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
+	     struct inode *new_dir, struct dentry *new_dentry,
+	     unsigned int flags)
+{
+	struct inode *inode = new_dentry->d_inode;
+	ino_t ino;
+
+	if (!inode)
+		return 0;
+	ino = inode->i_ino;
+	if (ino == 0)
+		return -EACCES;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index d6d3f4fcb24c..4b392c6c8fc4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2024 Google LLC. */
 
 #include <vmlinux.h>
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <linux/limits.h>
@@ -158,4 +159,18 @@ int BPF_PROG(path_d_path_kfunc_non_lsm, struct path *path, struct file *f)
 	return 0;
 }
 
+SEC("lsm.s/inode_rename")
+__failure __msg("invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
+	     struct inode *new_dir, struct dentry *new_dentry,
+	     unsigned int flags)
+{
+	struct inode *inode = new_dentry->d_inode;
+	ino_t ino;
+
+	ino = inode->i_ino;
+	if (ino == 0)
+		return -EACCES;
+	return 0;
+}
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


