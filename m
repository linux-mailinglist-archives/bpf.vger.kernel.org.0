Return-Path: <bpf+bounces-47350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081D9F85D3
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 21:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501677A2BB2
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 20:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F31BD9E5;
	Thu, 19 Dec 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAvKID5c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E85383;
	Thu, 19 Dec 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639959; cv=none; b=q+AIlt+NLFJjOjFEY8LRW5Dh5jB+gx6pSXGuUrQ1mA2l7x5ZCodebdxUI0WVIzRv4rqWS+ZRXXcnWK+wigkTZg8/f0crXOEtv4bSObgUceC8bYh07Dh5D/Ko4u/wX26o/zRkEwPGPjltpY7iD/J0hxiVrXtEJ2pMqrk9VL4CDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639959; c=relaxed/simple;
	bh=5LaYnZ+gbcvsP52hIhnW1K3ketWNyG+MdzJx0uYzW8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Def8Wf9aTuifQQ0DPh1EOANWRdeAOLgTtyouoy6I8+jY1wViWZuJkmbKwfFC5S1jFyHZGLUkvwRW0NianeGpSJAq+hD8FbIoEyHLBiyoT+8oSKR6HARPC0yn0ADTFCJke5QE7cwpeFu7b1wY8YcvmsWz5ErSGGtDx2FRrBqV+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAvKID5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FA4C4CED0;
	Thu, 19 Dec 2024 20:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639959;
	bh=5LaYnZ+gbcvsP52hIhnW1K3ketWNyG+MdzJx0uYzW8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAvKID5c6YIHisctA3IMjbir98UjRKyD0HIat6Ii3jvsknsamfCHkR4QGvjVzw0VG
	 kvWW51vh6UNOhsAxtEJ3Uyc9gy/NucoXd160cFCLBhHdf4P0soMXeoWOf+5JSsGGgd
	 y8p9vVE/L3CKyVACZ+0tYvA4AmJrwKWwfPr1HLhVpmaRMhdWh/LuLSFS2xcnM5p7q7
	 82DJCMmxLWO6ZJJK7zc092nw9PRQsNVLYJMkpWmtuuLQXg9sGVKpWK/1OOHfEhJLpG
	 gQhcxNjT4+vIlaRUAUf5Wyt2Ur/V4s1zepr1Xfcb7Nyfe/d6HKSNIo3JIZTQVF5sc1
	 9KcvW8m9ZOU8A==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	memxor@gmail.com,
	Song Liu <song@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v6 bpf-next 1/7] fs/xattr: bpf: Introduce security.bpf. xattr name prefix
Date: Thu, 19 Dec 2024 12:25:30 -0800
Message-ID: <20241219202536.1625216-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219202536.1625216-1-song@kernel.org>
References: <20241219202536.1625216-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduct new xattr name prefix security.bpf., and enable reading these
xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr().

As we are on it, correct the comments for return value of
bpf_get_[file|dentry]_xattr(), i.e. return length the xattr value on
success.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/bpf_fs_kfuncs.c         | 19 ++++++++++++++-----
 include/uapi/linux/xattr.h |  4 ++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..8a65184c8c2c 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -93,6 +93,11 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
 	return len;
 }
 
+static bool match_security_bpf_prefix(const char *name__str)
+{
+	return !strncmp(name__str, XATTR_NAME_BPF_LSM, XATTR_NAME_BPF_LSM_LEN);
+}
+
 /**
  * bpf_get_dentry_xattr - get xattr of a dentry
  * @dentry: dentry to get xattr from
@@ -101,9 +106,10 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
  *
  * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefix "user." or
+ * "security.bpf." is allowed.
  *
- * Return: 0 on success, a negative value on error.
+ * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
 				     struct bpf_dynptr *value_p)
@@ -117,7 +123,9 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
 	if (WARN_ON(!inode))
 		return -EINVAL;
 
-	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+	/* Allow reading xattr with user. and security.bpf. prefix */
+	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
+	    !match_security_bpf_prefix(name__str))
 		return -EPERM;
 
 	value_len = __bpf_dynptr_size(value_ptr);
@@ -139,9 +147,10 @@ __bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__st
  *
  * Get xattr *name__str* of *file* and store the output in *value_ptr*.
  *
- * For security reasons, only *name__str* with prefix "user." is allowed.
+ * For security reasons, only *name__str* with prefix "user." or
+ * "security.bpf." is allowed.
  *
- * Return: 0 on success, a negative value on error.
+ * Return: length of the xattr value on success, a negative value on error.
  */
 __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 				   struct bpf_dynptr *value_p)
diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9854f9cff3c6..c7c85bb504ba 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -83,6 +83,10 @@ struct xattr_args {
 #define XATTR_CAPS_SUFFIX "capability"
 #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
 
+#define XATTR_BPF_LSM_SUFFIX "bpf."
+#define XATTR_NAME_BPF_LSM (XATTR_SECURITY_PREFIX XATTR_BPF_LSM_SUFFIX)
+#define XATTR_NAME_BPF_LSM_LEN (sizeof(XATTR_NAME_BPF_LSM) - 1)
+
 #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
 #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_ACCESS
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
-- 
2.43.5


