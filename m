Return-Path: <bpf+bounces-14135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A28E7E0ACE
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB90280C00
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABA2241E2;
	Fri,  3 Nov 2023 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4MU+0I6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4923776;
	Fri,  3 Nov 2023 21:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7749C433C8;
	Fri,  3 Nov 2023 21:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699047979;
	bh=Xl9FvzV2bocdGcSqMI22VzVzpenWKD8WnxOLvum25ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4MU+0I6wEs8CFFVk+0+BBIQofAuqTTBvrd3c97/QlOl2iuO8mhwuYvcxGFrmGoYE
	 Aggf4Exd3+SL1R/hSJIjoXEFQcxXMTbcmpJvfyekp3zW11DA9Abb8CyY7zMNgIEzSV
	 irEWKVmqQKU6OXol41xw2M7PcVAvJ8DXm28RJWTvG/yzT3+GvTWGSBg4e0RB9U4zfA
	 sH+118gTLKh4QzBA1v8RgnMUObl253isiyikvCxDpaxm/rtnGPcsYyJNT5e2aVqgab
	 Bp49WdWG9eIfIWogzyvCQqkDpI1s+IubFxXpupP9zh1y5mQ/xMta0Oy0NtwsfaaNeJ
	 hNgqaUbO3soOg==
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
	vadfed@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v10 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
Date: Fri,  3 Nov 2023 14:45:30 -0700
Message-Id: <20231103214535.2674059-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103214535.2674059-1-song@kernel.org>
References: <20231103214535.2674059-1-song@kernel.org>
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
index bfe6fb83e8d0..82eaa099053b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,6 +24,7 @@
 #include <linux/key.h>
 #include <linux/verification.h>
 #include <linux/namei.h>
+#include <linux/fileattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1431,6 +1432,69 @@ static int __init bpf_key_sig_kfuncs_init(void)
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
+	value = __bpf_dynptr_data_rw(value_ptr, __bpf_dynptr_size(value_ptr));
+	if (!value)
+		return -EINVAL;
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


