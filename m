Return-Path: <bpf+bounces-63441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A798B07744
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C37564F5D
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4981C5D44;
	Wed, 16 Jul 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jiQ9Mi5M"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228792F2E
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673636; cv=none; b=t4Bk6a/h8XuAx0ANHYcpoWGdMsgsknecIP+AOWuaI8wAOU1KhhyjTHOhd7T3QCp+Tj5Lj3O9c7hukaQHwfwGmCzXYfgVKZahdbbaEHwlqW8T/F16a1OovXc/sO7ntzuSnMVzMEobWmPX5RIGRktXXscLZ/lZVrTwrYAmdAZqqNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673636; c=relaxed/simple;
	bh=y0yltTcJqulGpZ53fnr5joFFfG+L5pFlkTmcXWh9i6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGFOoXF9ugoprMpg1Psw/JSc385XG0Qweos+ABMUTikx7yNXAYqStNyps65J0K3orSNjDdduJPjEnrr9MEuGwNEjI7qLTgDiBdhSOfpc/FucQReMilmXE6tk5KN3A/KvwlrHIxzzdg1JChKEPld4EbVwPQvSzNZp3fk0S10/JJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jiQ9Mi5M; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752673631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cjcdcwIptp2ApGCqk64OfxPdesKWDlhn8m1LcCCbceI=;
	b=jiQ9Mi5M9O4/YVz549DCxdnv08BnJa3aVVuqpv5wB4W2xMBe7FnouGCq9W3LpKymFp66ua
	tY5WaPKDJiDySV8Qy3DZ2SsvhzcfAiJnEs1uUsqmGh92Ef82WhSy+pyQTdVxxroaLHbBEL
	7dJzHaXWs1CdcWwc8GLcvnvKJnLKZ4c=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 1/2] bpf: Add struct bpf_token_info
Date: Wed, 16 Jul 2025 21:46:53 +0800
Message-ID: <20250716134654.1162635-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The 'commit 35f96de04127 ("bpf: Introduce BPF token object")' added
BPF token as a new kind of BPF kernel object. And BPF_OBJ_GET_INFO_BY_FD
already used to get BPF object info, so we can also get token info with
this cmd.
One usage scenario, when program runs failed with token, because of
the permission failure, we can report what BPF token is allowing with
this API for debugging.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h            | 11 +++++++++++
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/syscall.c           | 18 ++++++++++++++++++
 kernel/bpf/token.c             | 25 ++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 5 files changed, 69 insertions(+), 1 deletion(-)

Change list:
 v2 -> v3:
  - remove info_copy variable.(Andrii)
  - assign the err when ASSERT_EQ fails in selftest.(Andrii)
  - Acked from Andrii
 v2: https://lore.kernel.org/bpf/20250715035831.1094282-1-chen.dylane@linux.dev

 v1 -> v2:
  - fix compilation warning reported by kernel test robot
 v1: https://lore.kernel.org/bpf/20250711094517.931999-1-chen.dylane@linux.dev

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 34dd90ec7fa..2c772f1556d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2350,6 +2350,7 @@ extern const struct super_operations bpf_super_ops;
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
 extern const struct file_operations bpf_iter_fops;
+extern const struct file_operations bpf_token_fops;
 
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
 	extern const struct bpf_prog_ops _name ## _prog_ops; \
@@ -2546,6 +2547,9 @@ void bpf_token_inc(struct bpf_token *token);
 void bpf_token_put(struct bpf_token *token);
 int bpf_token_create(union bpf_attr *attr);
 struct bpf_token *bpf_token_get_from_fd(u32 ufd);
+int bpf_token_get_info_by_fd(struct bpf_token *token,
+			     const union bpf_attr *attr,
+			     union bpf_attr __user *uattr);
 
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
@@ -2944,6 +2948,13 @@ static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline int bpf_token_get_info_by_fd(struct bpf_token *token,
+					   const union bpf_attr *attr,
+					   union bpf_attr __user *uattr)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void __dev_flush(struct list_head *flush_list)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0670e15a610..233de867738 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -450,6 +450,7 @@ union bpf_iter_link_info {
  *		* **struct bpf_map_info**
  *		* **struct bpf_btf_info**
  *		* **struct bpf_link_info**
+ *		* **struct bpf_token_info**
  *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
@@ -6803,6 +6804,13 @@ struct bpf_link_info {
 	};
 } __attribute__((aligned(8)));
 
+struct bpf_token_info {
+	__u64 allowed_cmds;
+	__u64 allowed_maps;
+	__u64 allowed_progs;
+	__u64 allowed_attachs;
+} __attribute__((aligned(8)));
+
 /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
  * by user and intended to be used by socket (e.g. to bind to, depends on
  * attach type).
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f36bfe1326..c21b6bba62a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5234,6 +5234,21 @@ static int bpf_link_get_info_by_fd(struct file *file,
 }
 
 
+static int token_get_info_by_fd(struct file *file,
+				struct bpf_token *token,
+				const union bpf_attr *attr,
+				union bpf_attr __user *uattr)
+{
+	struct bpf_token_info __user *uinfo = u64_to_user_ptr(attr->info.info);
+	u32 info_len = attr->info.info_len;
+	int err;
+
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(*uinfo), info_len);
+	if (err)
+		return err;
+	return bpf_token_get_info_by_fd(token, attr, uattr);
+}
+
 #define BPF_OBJ_GET_INFO_BY_FD_LAST_FIELD info.info
 
 static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
@@ -5257,6 +5272,9 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 	else if (fd_file(f)->f_op == &bpf_link_fops || fd_file(f)->f_op == &bpf_link_fops_poll)
 		return bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
 					      attr, uattr);
+	else if (fd_file(f)->f_op == &bpf_token_fops)
+		return token_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
+					    attr, uattr);
 	return -EINVAL;
 }
 
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 26057aa1350..0bbe412f854 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -103,7 +103,7 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 
 static const struct inode_operations bpf_token_iops = { };
 
-static const struct file_operations bpf_token_fops = {
+const struct file_operations bpf_token_fops = {
 	.release	= bpf_token_release,
 	.show_fdinfo	= bpf_token_show_fdinfo,
 };
@@ -210,6 +210,29 @@ int bpf_token_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_token_get_info_by_fd(struct bpf_token *token,
+			     const union bpf_attr *attr,
+			     union bpf_attr __user *uattr)
+{
+	struct bpf_token_info __user *uinfo = u64_to_user_ptr(attr->info.info);
+	struct bpf_token_info info;
+	u32 info_len = attr->info.info_len;
+
+	info_len = min_t(u32, info_len, sizeof(info));
+	memset(&info, 0, sizeof(info));
+
+	info.allowed_cmds = token->allowed_cmds;
+	info.allowed_maps = token->allowed_maps;
+	info.allowed_progs = token->allowed_progs;
+	info.allowed_attachs = token->allowed_attachs;
+
+	if (copy_to_user(uinfo, &info, info_len) ||
+	    put_user(info_len, &uattr->info.info_len))
+		return -EFAULT;
+
+	return 0;
+}
+
 struct bpf_token *bpf_token_get_from_fd(u32 ufd)
 {
 	CLASS(fd, f)(ufd);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0670e15a610..233de867738 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -450,6 +450,7 @@ union bpf_iter_link_info {
  *		* **struct bpf_map_info**
  *		* **struct bpf_btf_info**
  *		* **struct bpf_link_info**
+ *		* **struct bpf_token_info**
  *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
@@ -6803,6 +6804,13 @@ struct bpf_link_info {
 	};
 } __attribute__((aligned(8)));
 
+struct bpf_token_info {
+	__u64 allowed_cmds;
+	__u64 allowed_maps;
+	__u64 allowed_progs;
+	__u64 allowed_attachs;
+} __attribute__((aligned(8)));
+
 /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
  * by user and intended to be used by socket (e.g. to bind to, depends on
  * attach type).
-- 
2.48.1


