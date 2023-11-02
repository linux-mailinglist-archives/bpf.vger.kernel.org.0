Return-Path: <bpf+bounces-13978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D655A7DF800
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7623DB212AD
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D931BDD6;
	Thu,  2 Nov 2023 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt5XaQ6v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9918E17;
	Thu,  2 Nov 2023 16:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0855CC433C8;
	Thu,  2 Nov 2023 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698944104;
	bh=BjCSFY2LUDqve65p9mjPqLiMd/5wZBoOi6ScY3R1LwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mt5XaQ6vP/D6J672q6no+tZXJV+xc8JP7HYnsEq3r2GAGCi6v2+IeaxjJLy4thvhO
	 sK/FRDXOMbNcAIMhSqm5lX3yiqTrezkmB0OSaYBauxFhP/oJDIwLKbkH7//DYuoNZ6
	 ePDFePDAhxW6E4s3C2Nw7gfMcup5bWBHvgSgrQbHpGm+K5TdaXYiB9j3Rcq0M2SxRX
	 3Z1Pswc5WmkeDiSV4C54Wo8OCu5O8T/n6DgAzphbQLwPEz9vpCQ3LfpPJOSoc0/80P
	 KELlKaVigtKK18PmVarGAjIUNkB3xoHjNfxhKhhD3eZnFjE9D7C9xvCeD3buERAl9c
	 i56OJVjoF3o0w==
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
	kpsingh@kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v7 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
Date: Thu,  2 Nov 2023 09:54:27 -0700
Message-Id: <20231102165432.1769965-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102165432.1769965-1-song@kernel.org>
References: <20231102165432.1769965-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is common practice for security solutions to store tags/labels in
xattrs. To implement similar functionalities in BPF LSM, add new kfunc
bpf_get_file_xattr().

The first use case of bpf_get_file_xattr() is to implement file
verifications with asymmetric keys. Specificially, security applications
could use fsverity for file hashes and use xattr to store file signatures.
(kfunc for fsverity hash will be added in a separate commit.)

Currently, only xattrs with "user." prefix can be read with kfunc
bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefix
for bpf_get_file_xattr().

To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2626706b6387..19f3e5fddfe6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,6 +24,7 @@
 #include <linux/key.h>
 #include <linux/verification.h>
 #include <linux/namei.h>
+#include <linux/fileattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1436,6 +1437,69 @@ static int __init bpf_key_sig_kfuncs_init(void)
 late_initcall(bpf_key_sig_kfuncs_init);
 #endif /* CONFIG_KEYS */
 
+/* filesystem kfuncs */
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+/**
+ * bpf_get_file_xattr - get xattr of a file
+ * @file: file to get xattr from
+ * @name__str: name of the xattr
+ * @value_ptr: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
+				   struct bpf_dynptr_kern *value_ptr)
+{
+	struct dentry *dentry;
+	void *value;
+
+	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+		return -EPERM;
+
+	value = bpf_dynptr_slice_rdwr(value_ptr, 0, NULL, 0);
+	if (IS_ERR_OR_NULL(value))
+		return PTR_ERR(value);
+
+	dentry = file_dentry(file);
+	return __vfs_getxattr(dentry, dentry->d_inode, name__str,
+			      value, __bpf_dynptr_size(value_ptr));
+}
+
+__diag_pop();
+
+BTF_SET8_START(fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_SET8_END(fs_kfunc_set_ids)
+
+static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	/* Only allow to attach from LSM hooks, to avoid recursion */
+	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
+}
+
+const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &fs_kfunc_set_ids,
+	.filter = bpf_get_file_xattr_filter,
+};
+
+static int __init bpf_fs_kfuncs_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+}
+
+late_initcall(bpf_fs_kfuncs_init);
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.34.1


