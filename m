Return-Path: <bpf+bounces-12977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724D7D2A14
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C812B1C209D1
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A38F63AB;
	Mon, 23 Oct 2023 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+kWBi9u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE785612F;
	Mon, 23 Oct 2023 06:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6A8C433C7;
	Mon, 23 Oct 2023 06:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698041674;
	bh=bTFqEHU7zXrJ2Y3hxNQ2CnsGr9qWfYenxKwmCpjWOMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+kWBi9uWFl0y2efK3qcGv2Xnj6caCxFnw93tVX/x6S9lOCxkD8mX7OUeyqhueeb5
	 AzeDvnKQb30qQgRci4X4fuMuVk217Mc+kB5p1SuTv5+X4b9sgu/Dp5eZ/BqhprYeuZ
	 rsL6zkx5+0zA1NaUr/k0mEeZuuatNkGTjHeE4xahCVDsRJH8Eh1lGXrw8P5o25corY
	 VnjUUx7MLulM+b/eO54NA3UaN4S7K7c8baZQm+kx5h/X4nZtf0GARer+dVBSQwv2C1
	 Aq6Ja1jFo8682a8kd3yxu9uG8krY67ooMSNS6xwJBHz0gseXNTRsqmGl8vXPFmn0uG
	 9KfOghaDLb2KQ==
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
Subject: [PATCH v2 bpf-next 5/9] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
Date: Sun, 22 Oct 2023 23:13:50 -0700
Message-Id: <20231023061354.941552-6-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023061354.941552-1-song@kernel.org>
References: <20231023061354.941552-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kfunc can be used to read fsverity_digest, so that we can verify
signature in BPF LSM.

This kfunc is added to fs/verity/measure.c because some data structure used
in the function is private to fsverity (fs/verity/fsverity_private.h).

Signed-off-by: Song Liu <song@kernel.org>
---
 fs/verity/fsverity_private.h | 10 +++++
 fs/verity/init.c             |  1 +
 fs/verity/measure.c          | 82 ++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index d071a6e32581..f7124f89ab6f 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -145,4 +145,14 @@ static inline void fsverity_init_signature(void)
 
 void __init fsverity_init_workqueue(void);
 
+/* measure.c */
+
+#ifdef CONFIG_BPF_SYSCALL
+int __init fsverity_init_bpf(void);
+#else
+static inline int fsverity_init_bpf(void)
+{
+}
+#endif
+
 #endif /* _FSVERITY_PRIVATE_H */
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
index eec5956141da..db8b3472a16c 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -8,6 +8,8 @@
 #include "fsverity_private.h"
 
 #include <linux/uaccess.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
 
 /**
  * fsverity_ioctl_measure() - get a verity file's digest
@@ -100,3 +102,83 @@ int fsverity_get_digest(struct inode *inode,
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
+static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	/* Only allow to attach from LSM hooks, to avoid recursion */
+	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
+}
+
+BTF_SET8_START(fsverity_set)
+BTF_ID_FLAGS(func, bpf_get_fsverity_digest)
+BTF_SET8_END(fsverity_set)
+
+static const struct btf_kfunc_id_set bpf_fsverity_set = {
+	.owner = THIS_MODULE,
+	.set = &fsverity_set,
+	.filter = bpf_get_fsverity_digest_filter,
+};
+
+int __init fsverity_init_bpf(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fsverity_set);
+}
+
+#endif /* CONFIG_BPF_SYSCALL */
-- 
2.34.1


