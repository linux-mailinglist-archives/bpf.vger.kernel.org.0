Return-Path: <bpf+bounces-13194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6667D5EDE
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE937281C7A
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184259CA4D;
	Tue, 24 Oct 2023 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKttZHSB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893C47371;
	Tue, 24 Oct 2023 23:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966C3C433C7;
	Tue, 24 Oct 2023 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698191794;
	bh=FnRymnDl6vS/fctOPw/F8RFj6/lWTy9ja26pzsKEfSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKttZHSBJuest0niQo+jLq2gT4VuCJGVV2z1DRIA1otA1HTli0TQNyQV5wgF8re3a
	 enFxQxZiC8oOdmIAJIEMXvjvecoGqFTZoUfwwVjI9I5lPM8d7yzdJAvSRvN3b+AtdM
	 V1xFOmPZ5ZNpgq1gRdV0UOZWUJON97ILsTWd7zAsDT3QCGjY4C8eLnkniKh45Cr6mQ
	 rCBvyHKJVHTITdQV3ePp9/ssS1O7GL81KRi07cpy+a432IdTSJ8AFbc8kDehwNopIq
	 PoW5UsOzw3OfZ9XqYPgpDfPZjwze1WiBwuzuZTxrg3c4xcxvpp7XnaQT1BRqDH6yTI
	 cj4akF+rI68Zw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	kernel-team@meta.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	roberto.sassu@huaweicloud.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v6 bpf-next 5/9] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
Date: Tue, 24 Oct 2023 16:55:47 -0700
Message-Id: <20231024235551.2769174-6-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024235551.2769174-1-song@kernel.org>
References: <20231024235551.2769174-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fsverity provides fast and reliable hash of files, namely fsverity_digest.
The digest can be used by security solutions to verify file contents.

Add new kfunc bpf_get_fsverity_digest() so that we can access fsverity from
BPF LSM programs. This kfunc is added to fs/verity/measure.c because some
data structure used in the function is private to fsverity
(fs/verity/fsverity_private.h).

To avoid recursion, bpf_get_fsverity_digest is only allowed in BPF LSM
programs.

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/verity/fsverity_private.h | 10 +++++
 fs/verity/init.c             |  1 +
 fs/verity/measure.c          | 85 ++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index d071a6e32581..a6a6b2749241 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -100,6 +100,16 @@ fsverity_msg(const struct inode *inode, const char *level,
 #define fsverity_err(inode, fmt, ...)		\
 	fsverity_msg((inode), KERN_ERR, fmt, ##__VA_ARGS__)
 
+/* measure.c */
+
+#ifdef CONFIG_BPF_SYSCALL
+void __init fsverity_init_bpf(void);
+#else
+static inline void fsverity_init_bpf(void)
+{
+}
+#endif
+
 /* open.c */
 
 int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
diff --git a/fs/verity/init.c b/fs/verity/init.c
index a29f062f6047..1e207c0f71de 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -69,6 +69,7 @@ static int __init fsverity_init(void)
 	fsverity_init_workqueue();
 	fsverity_init_sysctl();
 	fsverity_init_signature();
+	fsverity_init_bpf();
 	return 0;
 }
 late_initcall(fsverity_init)
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index eec5956141da..ac3f891923f5 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -7,6 +7,8 @@
 
 #include "fsverity_private.h"
 
+#include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/uaccess.h>
 
 /**
@@ -100,3 +102,86 @@ int fsverity_get_digest(struct inode *inode,
 	return hash_alg->digest_size;
 }
 EXPORT_SYMBOL_GPL(fsverity_get_digest);
+
+#ifdef CONFIG_BPF_SYSCALL
+
+/* bpf kfuncs */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+/**
+ * bpf_get_fsverity_digest: read fsverity digest of file
+ * @file: file to get digest from
+ * @digest_ptr: (out) dynptr for struct fsverity_digest
+ *
+ * Read fsverity_digest of *file* into *digest_ptr*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_kern *digest_ptr)
+{
+	const struct inode *inode = file_inode(file);
+	struct fsverity_digest *arg;
+	const struct fsverity_info *vi;
+	const struct fsverity_hash_alg *hash_alg;
+	int out_digest_sz;
+
+	arg = bpf_dynptr_slice_rdwr(digest_ptr, 0, NULL, 0);
+	if (IS_ERR_OR_NULL(arg))
+		return PTR_ERR(arg);
+
+	if (!IS_ALIGNED((uintptr_t)arg, __alignof__(*arg)))
+		return -EINVAL;
+
+	if (__bpf_dynptr_size(digest_ptr) < sizeof(struct fsverity_digest))
+		return -EINVAL;
+
+	vi = fsverity_get_info(inode);
+	if (!vi)
+		return -ENODATA; /* not a verity file */
+
+	hash_alg = vi->tree_params.hash_alg;
+
+	arg->digest_algorithm = hash_alg - fsverity_hash_algs;
+	arg->digest_size = hash_alg->digest_size;
+
+	out_digest_sz = __bpf_dynptr_size(digest_ptr) - sizeof(struct fsverity_digest);
+
+	/* copy digest */
+	memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest_size, out_digest_sz));
+
+	/* fill the extra buffer with zeros */
+	if (out_digest_sz > hash_alg->digest_size)
+		memset(arg->digest + arg->digest_size, 0, out_digest_sz - hash_alg->digest_size);
+
+	return 0;
+}
+
+__diag_pop();
+
+BTF_SET8_START(fsverity_set_ids)
+BTF_ID_FLAGS(func, bpf_get_fsverity_digest)
+BTF_SET8_END(fsverity_set_ids)
+
+static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&fsverity_set_ids, kfunc_id))
+		return 0;
+
+	/* Only allow to attach from LSM hooks, to avoid recursion */
+	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
+}
+
+static const struct btf_kfunc_id_set bpf_fsverity_set = {
+	.owner = THIS_MODULE,
+	.set = &fsverity_set_ids,
+	.filter = bpf_get_fsverity_digest_filter,
+};
+
+void __init fsverity_init_bpf(void)
+{
+	register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fsverity_set);
+}
+
+#endif /* CONFIG_BPF_SYSCALL */
-- 
2.34.1


