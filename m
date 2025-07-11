Return-Path: <bpf+bounces-63035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E68B018A0
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 11:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6343AE71E
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3150927FB02;
	Fri, 11 Jul 2025 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NXATx2Xz"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77A27E7EC
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227156; cv=none; b=eCcs9AMHN6KuWD+O8FdIc9AN81M20hpa541xsvX3DBIu5y0apWORPF0PwIiBHWkqibpijddIQxv0gFT1OGKSbWTUr3ved+9HSNjwDEOQwmFx+0bj5MLzZfow0kriPVuc1u5B10iixRT+tt9Il8kOr17toVlHg1D86q4RuGGOmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227156; c=relaxed/simple;
	bh=zxuuEGNueutqrRURbOl7rW8OCM1hy4XsjEuCw/yFNpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tihs14tX2jZ3NmZGA0oB7czVsj2WlX1xkUCZcGHMzhvSyT0mOzLq5XJvisbP7n6UVrCfLkfJlpyd45X9hq7skmVHqp7hEERaxEaiLdKy6oBCsOphwEiWNvAeJ0N4uEo9734OycX0MC+leCHA/3VoZgw1c33J7EwJyuY3srx/rbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NXATx2Xz; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752227142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TQD3v1aKvpDwwgaUlCECmBTZKfWk144pgLdrlapMGwk=;
	b=NXATx2Xzqr0ZWmaKYFdrQ0u4cIQTw4Rrxoq8bAC46mnGF60y78At8S5O6eK9XqotUY+xAJ
	1V+Eg6B1v1OvHwBDbx45DakKTVHTptgnHWEPMCXjTIA+1O13WZViY3FkuOCrARbhga5cH8
	J894SQVmbaL/BojVvnbKMkmEOfj2o/I=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
Date: Fri, 11 Jul 2025 17:45:16 +0800
Message-ID: <20250711094517.931999-1-chen.dylane@linux.dev>
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

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h            | 11 +++++++++++
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/bpf/syscall.c           | 18 ++++++++++++++++++
 kernel/bpf/token.c             | 30 ++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 5 files changed, 73 insertions(+), 2 deletions(-)

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
index 26057aa1350..319e252b879 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -101,9 +101,9 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 
 #define BPF_TOKEN_INODE_NAME "bpf-token"
 
-static const struct inode_operations bpf_token_iops = { };
+const struct inode_operations bpf_token_iops = { };
 
-static const struct file_operations bpf_token_fops = {
+const struct file_operations bpf_token_fops = {
 	.release	= bpf_token_release,
 	.show_fdinfo	= bpf_token_show_fdinfo,
 };
@@ -210,6 +210,32 @@ int bpf_token_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_token_get_info_by_fd(struct bpf_token *token,
+			     const union bpf_attr *attr,
+			     union bpf_attr __user *uattr)
+{
+	struct bpf_token_info __user *uinfo;
+	struct bpf_token_info info;
+	u32 info_copy, uinfo_len;
+
+	uinfo = u64_to_user_ptr(attr->info.info);
+	uinfo_len = attr->info.info_len;
+
+	info_copy = min_t(u32, uinfo_len, sizeof(info));
+	memset(&info, 0, sizeof(info));
+
+	info.allowed_cmds = token->allowed_cmds;
+	info.allowed_maps = token->allowed_maps;
+	info.allowed_progs = token->allowed_progs;
+	info.allowed_attachs = token->allowed_attachs;
+
+	if (copy_to_user(uinfo, &info, info_copy) ||
+	    put_user(info_copy, &uattr->info.info_len))
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


