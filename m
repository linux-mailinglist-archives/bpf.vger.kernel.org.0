Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AAF374E15
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhEFDqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhEFDqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D9C061574
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v191so4113338pfc.8
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5dOt2ICV2YMuXw6Q5/9wTf1h3zkV9EcQfwC4XhpWXk=;
        b=UrkITXY4BE0w7Lvxr/GYnlmLv4e6BtEY0rSjai3OAP2nPQxcGFsOkF+6yRARjMLIND
         1cYFN2Q++u/u/3UaIYaXs+9YJYZ7CE7aeRfT7FbhkQNvkA0wffjkk0NiyXQlYOLNSdF2
         FYvirOZTx6D1XLynPPe0dCXyw29eCUH48DrsQ+43Yebqo4Su5gK+lKu8DUdvqi8HNi0R
         ThtrcatDBdFD663HPLQT6Eotu5MUsjuBG+viH0qJwnicefdkfYlA2XxKEI2oQF8FEsCd
         q+aDhca9zANxF5iAAQSJ4ax3ZcSc12ho946lvIbCSIi1996/7TaGbL1fJS8u1wIiMcWe
         BQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v5dOt2ICV2YMuXw6Q5/9wTf1h3zkV9EcQfwC4XhpWXk=;
        b=i37jXeoQbDi1wZw7P2jyNyblKTZJoPX3U3Q+kZwB3Vdm3hdgL0wxESNmY4IFFpbP2n
         gcx0y6UXTOMhzjKJ0mQlXd3Mmc0pdjFHe4u4b+BcllKdec1tP065RxCB7qW1qgPZpqve
         Nkc6Ne9/MVSO8SJ+DQ9xdERG+NN5SJIE/rysbU5cNgrHIQJrRMosSdulvctQKESkq6bP
         gcpL99nsDxyPNsGWp48YsoAyF2NzSFClvSVa7Js5ssjYVAqNPlgmS0E9bdNWLDv6b1+I
         FVuKDfLEzRM5Uiw4JKiWOGd7tB07CkAIFhIAr58zYcGd0ZRl9pN8uYNtpl/hRO5f6ggZ
         bdMg==
X-Gm-Message-State: AOAM5304IutcY5fcQufq8n46EYgwxB73fpuGurz56S+z4fp0dr+mWylS
        kocfgfBCMkW4JMqj/r/X0Vs=
X-Google-Smtp-Source: ABdhPJzYZFwsdm1M/+Sdp5WkaUKrJ/H9Yu5x1BqyUca3qMX4iS+31mX/shaLDVb8IVtnZjO0hW80ig==
X-Received: by 2002:a63:1a47:: with SMTP id a7mr2106760pgm.437.1620272721663;
        Wed, 05 May 2021 20:45:21 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:21 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 10/17] bpf: Add bpf_btf_find_by_name_kind() helper.
Date:   Wed,  5 May 2021 20:44:58 -0700
Message-Id: <20210506034505.25979-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add new helper:
long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
Description
	Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
Return
	Returns btf_id and btf_obj_fd in lower and upper 32 bits.

It will be used by loader program to find btf_id to attach the program to
and to find btf_ids of ksyms.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 ++++
 kernel/bpf/btf.c               | 62 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  2 ++
 tools/include/uapi/linux/bpf.h |  7 ++++
 5 files changed, 79 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7fd53380c981..9dc44ba97584 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1974,6 +1974,7 @@ extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
+extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index de58a714ed36..3cc07351c1cf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4748,6 +4748,12 @@ union bpf_attr {
  * 		Execute bpf syscall with given arguments.
  * 	Return
  * 		A syscall result.
+ *
+ * long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
+ * 	Description
+ * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
+ * 	Return
+ * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4917,6 +4923,7 @@ union bpf_attr {
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
 	FN(sys_bpf),			\
+	FN(btf_find_by_name_kind),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fbf6c06a9d62..85716327c375 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6085,3 +6085,65 @@ struct module *btf_try_get_module(const struct btf *btf)
 
 	return res;
 }
+
+BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
+{
+	struct btf *btf;
+	long ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (name_sz <= 1 || name[name_sz - 1])
+		return -EINVAL;
+
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	ret = btf_find_by_name_kind(btf, name, kind);
+	/* ret is never zero, since btf_find_by_name_kind returns
+	 * positive btf_id or negative error.
+	 */
+	if (ret < 0) {
+		struct btf *mod_btf;
+		int id;
+
+		/* If name is not found in vmlinux's BTF then search in module's BTFs */
+		spin_lock_bh(&btf_idr_lock);
+		idr_for_each_entry(&btf_idr, mod_btf, id) {
+			if (!btf_is_module(mod_btf))
+				continue;
+			/* linear search could be slow hence unlock/lock
+			 * the IDR to avoiding holding it for too long
+			 */
+			btf_get(mod_btf);
+			spin_unlock_bh(&btf_idr_lock);
+			ret = btf_find_by_name_kind(mod_btf, name, kind);
+			if (ret > 0) {
+				int btf_obj_fd;
+
+				btf_obj_fd = __btf_new_fd(mod_btf);
+				if (btf_obj_fd < 0) {
+					btf_put(mod_btf);
+					return btf_obj_fd;
+				}
+				return ret | (((u64)btf_obj_fd) << 32);
+			}
+			spin_lock_bh(&btf_idr_lock);
+			btf_put(mod_btf);
+		}
+		spin_unlock_bh(&btf_idr_lock);
+	}
+	return ret;
+}
+
+const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
+	.func		= bpf_btf_find_by_name_kind,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_ANYTHING,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index da7dc2406470..f93ff2ebf96d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4584,6 +4584,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
 		return &bpf_sys_bpf_proto;
+	case BPF_FUNC_btf_find_by_name_kind:
+		return &bpf_btf_find_by_name_kind_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6c8e178d8ffa..8a892231a1ae 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4748,6 +4748,12 @@ union bpf_attr {
  * 		Execute bpf syscall with given arguments.
  * 	Return
  * 		A syscall result.
+ *
+ * long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
+ * 	Description
+ * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
+ * 	Return
+ * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4917,6 +4923,7 @@ union bpf_attr {
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
 	FN(sys_bpf),			\
+	FN(btf_find_by_name_kind),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

