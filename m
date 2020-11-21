Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58C2BBB47
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 01:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKUAu6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 19:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKUAu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 19:50:58 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2CC0613CF
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:50:58 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so12698996wrx.5
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EcEA95lNa5ZZ+4yTLKOmHZRpqe2owrp9tTkgwACEiM=;
        b=HDfVcfahM3bKl9+qUQ17zfP7VPqPF47VMw+BHus3Ay4VZMn3CaP64kl4ysBf8B662Z
         8iy2knqgDfzfRBSuxTRSuVI/mM9QU6Xl3uvF+LmivdARc+EhYceK73AoEr5+4YBtgdwx
         H6MZ1Xw9f4RCyLGtwXbNlRLg4+6a4ugdGEerA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EcEA95lNa5ZZ+4yTLKOmHZRpqe2owrp9tTkgwACEiM=;
        b=XIFDxRFAGy5j7SRkLYfUvneBLygIJ0v7bxYTM7CwsaihNiImI0lwyyaG6vHp8QZMek
         JXtIaJpyLDbwfKZLoJQBy3uF1hx1raaIEZzUWUOJJF6yARra9YiFxiAqwX3yePWp0vD2
         2ZzvFxXul1Vc1d2GijDW/Lcs0J4cDYPmnzQZnp9/jeWaW7PWlyqsc3RNXpDgd+lUl4Rt
         iSPwrz8sRVrxUrt+ycfTt9wAGpDUCEa5wkm0JE5f1QF9pZn6wKSOiz7zaTnaLBdP/+AV
         y1OSle8ngaSvUoMbwozWza8gA8iGEayvIef/F1yIG8NrJu9mspWRoDYBBvsMJcvpe/LO
         78gA==
X-Gm-Message-State: AOAM533zCIM20I/o4q1Kk5XS44TjSykFN7W+iNl26D5mePVb7899F0bz
        LNN5aiaBOn44JMNwPMTujrPldg==
X-Google-Smtp-Source: ABdhPJwn2Ze2G+n7GEIgV6IFe/lQ3oFyWVfyjqDt0housibEsSKQxsoyQ5onAdYaytbYDxL5VwbWIA==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr18872821wrn.396.1605919856713;
        Fri, 20 Nov 2020 16:50:56 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id s8sm7133607wrn.33.2020.11.20.16.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 16:50:56 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/3] ima: Implement ima_inode_hash
Date:   Sat, 21 Nov 2020 00:50:52 +0000
Message-Id: <20201121005054.3467947-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

This is in preparation to add a helper for BPF LSM programs to use
IMA hashes when attached to LSM hooks. There are LSM hooks like
inode_unlink which do not have a struct file * argument and cannot
use the existing ima_file_hash API.

An inode based API is, therefore, useful in LSM based detections like an
executable trying to delete itself which rely on the inode_unlink LSM
hook.

Moreover, the ima_file_hash function does nothing with the struct file
pointer apart from calling file_inode on it and converting it to an
inode.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/ima.h               |  6 +++
 security/integrity/ima/ima_main.c | 78 +++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 8fa7bcfb2da2..7233a2751754 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -29,6 +29,7 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
+extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
 
 #ifdef CONFIG_IMA_KEXEC
@@ -115,6 +116,11 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 	return -EOPNOTSUPP;
 }
 
+static inline int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2d1af8899cab..cb2deaa188e7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -501,37 +501,14 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
-/**
- * ima_file_hash - return the stored measurement if a file has been hashed and
- * is in the iint cache.
- * @file: pointer to the file
- * @buf: buffer in which to store the hash
- * @buf_size: length of the buffer
- *
- * On success, return the hash algorithm (as defined in the enum hash_algo).
- * If buf is not NULL, this function also outputs the hash into buf.
- * If the hash is larger than buf_size, then only buf_size bytes will be copied.
- * It generally just makes sense to pass a buffer capable of holding the largest
- * possible hash: IMA_MAX_DIGEST_SIZE.
- * The file hash returned is based on the entire file, including the appended
- * signature.
- *
- * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
- * If the parameters are incorrect, return -EINVAL.
- */
-int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
-	struct inode *inode;
 	struct integrity_iint_cache *iint;
 	int hash_algo;
 
-	if (!file)
-		return -EINVAL;
-
 	if (!ima_policy_flag)
 		return -EOPNOTSUPP;
 
-	inode = file_inode(file);
 	iint = integrity_iint_find(inode);
 	if (!iint)
 		return -EOPNOTSUPP;
@@ -558,8 +535,61 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 
 	return hash_algo;
 }
+
+/**
+ * ima_file_hash - return the stored measurement if a file has been hashed and
+ * is in the iint cache.
+ * @file: pointer to the file
+ * @buf: buffer in which to store the hash
+ * @buf_size: length of the buffer
+ *
+ * On success, return the hash algorithm (as defined in the enum hash_algo).
+ * If buf is not NULL, this function also outputs the hash into buf.
+ * If the hash is larger than buf_size, then only buf_size bytes will be copied.
+ * It generally just makes sense to pass a buffer capable of holding the largest
+ * possible hash: IMA_MAX_DIGEST_SIZE.
+ * The file hash returned is based on the entire file, including the appended
+ * signature.
+ *
+ * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
+ * If the parameters are incorrect, return -EINVAL.
+ */
+int ima_file_hash(struct file *file, char *buf, size_t buf_size)
+{
+	if (!file)
+		return -EINVAL;
+
+	return __ima_inode_hash(file_inode(file), buf, buf_size);
+}
 EXPORT_SYMBOL_GPL(ima_file_hash);
 
+/**
+ * ima_inode_hash - return the stored measurement if the inode has been hashed
+ * and is in the iint cache.
+ * @inode: pointer to the inode
+ * @buf: buffer in which to store the hash
+ * @buf_size: length of the buffer
+ *
+ * On success, return the hash algorithm (as defined in the enum hash_algo).
+ * If buf is not NULL, this function also outputs the hash into buf.
+ * If the hash is larger than buf_size, then only buf_size bytes will be copied.
+ * It generally just makes sense to pass a buffer capable of holding the largest
+ * possible hash: IMA_MAX_DIGEST_SIZE.
+ * The hash returned is based on the entire contents, including the appended
+ * signature.
+ *
+ * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
+ * If the parameters are incorrect, return -EINVAL.
+ */
+int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
+{
+	if (!inode)
+		return -EINVAL;
+
+	return __ima_inode_hash(inode, buf, buf_size);
+}
+EXPORT_SYMBOL_GPL(ima_inode_hash);
+
 /**
  * ima_post_create_tmpfile - mark newly created tmpfile as new
  * @file : newly created tmpfile
-- 
2.29.2.454.gaff20da3a2-goog

