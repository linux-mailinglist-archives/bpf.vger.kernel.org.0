Return-Path: <bpf+bounces-13019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E307B7D3BAD
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EBC2B20FAF
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F71CAB3;
	Mon, 23 Oct 2023 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjk1iogi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7F1C28A;
	Mon, 23 Oct 2023 16:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0FCC433C7;
	Mon, 23 Oct 2023 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698077052;
	bh=KegfHtw+dipb9WMoL0tp2jttgRiQoKqpiiVcpl1j3Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjk1iogiNLEaW7wZOztpkfWU38o7Ia5y5RF3HOSi7gfjYRP8zjIt2jdNZ4rziDKnY
	 QFmouIlGJgYgSiXhVvrZ6zYdF8kRD+HvlOwu5twiXkq1iamtbPfs2rNswJSHi2ADpq
	 aE8Dh7WMlgO4BB1ve+ndY1In7LQ0Ux0p9dvQIDdSd76xnDssne6BPlU3KKt1YIsjTv
	 4RkCjm+y1D3UgH1yytvJGTrJQgZFcR+kD06NbAP6qfTM6IZaztwqHQiPbSWtLL05oB
	 sgy8Wqai7c6hccqW8KNdBm3J0t68t73ZMBdBjAN2kMpJcDijAGO9BRqMv8Wsl9i8e+
	 8N1nzxph+9L1w==
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
Subject: [PATCH v3 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
Date: Mon, 23 Oct 2023 09:03:44 -0700
Message-Id: <20231023160349.4161154-5-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023160349.4161154-1-song@kernel.org>
References: <20231023160349.4161154-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This kfunc can be used to read xattr of a file. To avoid recursion, only
allow calling this kfunc from LSM hooks.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/trace/bpf_trace.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 43ed45a83ee2..4178d0e339d3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -24,6 +24,7 @@
 #include <linux/key.h>
 #include <linux/verification.h>
 #include <linux/namei.h>
+#include <linux/fileattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1436,6 +1437,61 @@ static int __init bpf_key_sig_kfuncs_init(void)
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
+static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	/* Only allow to attach from LSM hooks, to avoid recursion */
+	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
+}
+
+BTF_SET8_START(fs_kfunc_set)
+BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
+BTF_SET8_END(fs_kfunc_set)
+
+const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &fs_kfunc_set,
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


