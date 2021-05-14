Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2AC380132
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhENAhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAhy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A69C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso476399pjp.5
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFiaoGSVE/MXJGMzBbOSJu8xD0FLRvjcwuUH6ABF4QA=;
        b=IHO30iiW1OMlSsdNuk0VLCw0w5II1OUBpStNiKtNmVw2RzNcnZXo77AwbF0PjoIqEt
         r+c3QVATA0pLB/qmTN9Xti/Ws1Sbje+H3+2pA71FgsC6u9+fYX3keos+3OAqKt5AfYQH
         wu0tAc+IOZn5jAJ20EwaC1YANNkXsOEAVmsFwUcRxnqRmYQUIZdcCJsxcqJXDwOhVR0A
         960hzw6MUdIa/NA9K3bgDvIAI6SiepjVi8ugIezbDxvZSjXR4rsG1VLxzzOGxxXKlQSv
         U0l1ZHT883xVHDa45SotZgFFV5cz+HJ+C9RhsCVrdHR1PlabyZRxKqxW5pXo6yL52NPr
         qFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFiaoGSVE/MXJGMzBbOSJu8xD0FLRvjcwuUH6ABF4QA=;
        b=Lv1r8kXISW5guFUPiWYD/DpidledIknqP392MM+tmlSRV3z7MyVWk3D3NX765a3VSM
         +V4xGcx+PfgY7T+fd3O0P4MDeKhaCl2BKBDscZ2ex789zOpDZxlsQmvbNGdRYL3H3mhG
         FPb2cHCD6046vvkQtmt9E6PItcYZ931QvppSmmSvgbb7VvCw8NA1jLqZVDWfoQnU6GEF
         qtWtcldu6TDQ9yEhKwydiiIH+wkxHYABykbUmJUy/PhbORuz/qVkgZ+u9IQYfD/DJKyw
         d1XXjkV0bUFUWxaypvbvIYpc7J85DgibuYRB/FMrkosSXk7SAIQuHX9Rnv3wNIsQllpt
         uOdw==
X-Gm-Message-State: AOAM53115QvpjwbMdsq3NFrB0YdykdNHlM183/SFfhbM+Hwc+VgBY5ti
        GJvAXbpQoIm9pyrflPjuvVdzlh2jm0k=
X-Google-Smtp-Source: ABdhPJxdK8ZEQF6vxaISDU6XoFnMFZSxmI3wqePrjADcp7T98BiNaiN9xBnxbiF9qoQp5nHA9HFffA==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr38107714pjb.218.1620952604084;
        Thu, 13 May 2021 17:36:44 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:43 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 09/21] bpf: Add bpf_btf_find_by_name_kind() helper.
Date:   Thu, 13 May 2021 17:36:11 -0700
Message-Id: <20210514003623.28033-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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
index de58a714ed36..3cc07351c1cf 100644
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

