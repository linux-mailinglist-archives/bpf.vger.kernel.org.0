Return-Path: <bpf+bounces-13117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D87D478B
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 08:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E612E1F225BA
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3D11CA7;
	Tue, 24 Oct 2023 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW30W3gi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7BF13ADF;
	Tue, 24 Oct 2023 06:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25754C433C8;
	Tue, 24 Oct 2023 06:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698129088;
	bh=70cM7P9ogvSVRhbmDElsdFpyPt2tYGMZH5mXwAxLWw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mW30W3giyIWOmPNutEHL0bi8jdteJOs/vsigB8KLXcjVw7jjqBO6t3jcBIYUJXmH8
	 eXhbobKtuuC0YrsjnXUxiBT927rsuMpHhhRoACCqgxEYEd/efYaNAsxEmd2swPw4k7
	 rT/+6RLWNhIy7v+v+RrgODf6pEfDPX9sQwbzULuaKh3Yr52wpFAWOC4nqOcIu86WBA
	 rxz3UYYf2NZs3MieWb5gS0yULXbdoSkfuT6U+fA8/vZMX+m4Mm+hrZiA4DRED8dTln
	 X2mcBWc2KsV1zgfNmvPj6qYeHbaRDLGLhzQOn2MiD2DjSFva+ykpPc2BTL6mgYju3n
	 9B9aapa6nDbaQ==
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
Subject: [PATCH v5 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
Date: Mon, 23 Oct 2023 23:30:51 -0700
Message-Id: <20231024063056.1008702-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024063056.1008702-1-song@kernel.org>
References: <20231024063056.1008702-1-song@kernel.org>
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

To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/trace/bpf_trace.c | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2626706b6387..802181986ad3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,6 +24,7 @@
 #include <linux/key.h>
 #include <linux/verification.h>
 #include <linux/namei.h>
+#include <linux/fileattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1436,6 +1437,64 @@ static int __init bpf_key_sig_kfuncs_init(void)
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
+ * @name__const_str: name of the xattr
+ * @value_ptr: output buffer of the xattr value
+ *
+ * Get xattr *name__const_str* of *file* and store the output in *value_ptr*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__const_str,
+				   struct bpf_dynptr_kern *value_ptr)
+{
+	struct dentry *dentry;
+	void *value;
+
+	value = bpf_dynptr_slice_rdwr(value_ptr, 0, NULL, 0);
+	if (IS_ERR_OR_NULL(value))
+		return PTR_ERR(value);
+
+	dentry = file_dentry(file);
+	return __vfs_getxattr(dentry, dentry->d_inode, name__const_str,
+			      value, __bpf_dynptr_size(value_ptr));
+}
+
+__diag_pop();
+
+BTF_SET8_START(fs_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
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


