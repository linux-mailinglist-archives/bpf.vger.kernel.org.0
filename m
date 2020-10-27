Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7031629BF96
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815602AbgJ0RD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 13:03:27 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43201 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815584AbgJ0RD0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 13:03:26 -0400
Received: by mail-ej1-f65.google.com with SMTP id k3so3240349ejj.10
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNakQeGeyxrRJjlLdJNQei/MTqP76Y8rZjk9gebVfxc=;
        b=LGNRkX13iGGBWGrm2Yc7mU943QsXPmPFGFBgYu68Yoj3m8GJ347xOQ3XusKMOk456H
         7g0g8ec3nyutvuEMITII4eanmC7MVV3ESGPf2YNI054MGFdEGa/R5kPZx54rBGj9VL1p
         NA4/kCrD46tMKQT20G60royLhXSi2LsUfZXpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNakQeGeyxrRJjlLdJNQei/MTqP76Y8rZjk9gebVfxc=;
        b=aFT+cBUNEGfWYzP7DBX5O8oHdk7nRHRAcieuo6fiawwMjSJ4FMV9QZsicI6cg+7Y8c
         f6XHo/A+Qq/3ix42VMlL0XhEWLWew5VISLN4PTWdsSi8FM4JVZJps4gWYc5geu4hMxXD
         Z3e5dX/JDN2hNyOUWfLh9iHxWq/5SG9UmaGUeoJDECp2TCjP+1EhnOFkJLTdFpLBvhZt
         oWlsZLaCWJExzN8sCAPSV/ThOu1atjjek5DSGRd9xIivqrMH+IQxrR0lvf9+Gm2hY+o6
         U79wLzZxfwRe/XDN7WUpUHTeDJsqx30sN0ASpkm2Ko0h2bwY+cxKc0aISM7cICh6wq5L
         hXGw==
X-Gm-Message-State: AOAM533CPDocXjN2AATXNOZSIjDVTIqSDfCpZbgpKbPKQgNCu1bggBK8
        h3shIheY725OLgpc1ZqukVCxnA==
X-Google-Smtp-Source: ABdhPJyGi63mfoPDTWdkddgTcg/wAal6h3q2SV6722ik/sxVncl6VpTwNbsMSoyKfdz3DysepmSZfA==
X-Received: by 2002:a17:906:a04c:: with SMTP id bg12mr3249707ejb.317.1603818203546;
        Tue, 27 Oct 2020 10:03:23 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id ba6sm1315006edb.61.2020.10.27.10.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:03:22 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 2/5] bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
Date:   Tue, 27 Oct 2020 18:03:14 +0100
Message-Id: <20201027170317.2011119-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201027170317.2011119-1-kpsingh@chromium.org>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The currently available bpf_get_current_task returns an unsigned integer
which can be used along with BPF_CORE_READ to read data from
the task_struct but still cannot be used as an input argument to a
helper that accepts an ARG_PTR_TO_BTF_ID of type task_struct.

In order to implement this helper a new return type, RET_PTR_TO_BTF_ID,
is added. This is similar to RET_PTR_TO_BTF_ID_OR_NULL but does not
require checking the nullness of returned pointer.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/bpf/verifier.c          | 10 +++++++---
 kernel/trace/bpf_trace.c       | 16 ++++++++++++++++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b16bf48aab6..05ea8c55d893 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -310,6 +310,7 @@ enum bpf_return_type {
 	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
 	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
 	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
+	RET_PTR_TO_BTF_ID,		/* returns a pointer to a btf_id */
 };
 
 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bb443c4f3637..05c997913872 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3779,6 +3779,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * struct task_struct *bpf_get_current_task_btf(void)
+ *	Description
+ *		Return a BTF pointer to the "current" task.
+ *		This pointer can also be used in helpers that accept an
+ *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
+ *	Return
+ *		Pointer to the current task.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3939,6 +3947,7 @@ union bpf_attr {
 	FN(redirect_peer),		\
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
+	FN(get_current_task_btf),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b0790876694f..eb0aef85fc11 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -493,7 +493,8 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp6_sock ||
 		func_id == BPF_FUNC_skc_to_udp6_sock ||
 		func_id == BPF_FUNC_skc_to_tcp_timewait_sock ||
-		func_id == BPF_FUNC_skc_to_tcp_request_sock;
+		func_id == BPF_FUNC_skc_to_tcp_request_sock ||
+		func_id == BPF_FUNC_get_current_task_btf;
 }
 
 /* string representation of 'enum bpf_reg_type' */
@@ -5186,11 +5187,14 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 				PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 		}
-	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL) {
+	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL ||
+		   fn->ret_type == RET_PTR_TO_BTF_ID) {
 		int ret_btf_id;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = PTR_TO_BTF_ID_OR_NULL;
+		regs[BPF_REG_0].type = fn->ret_type == RET_PTR_TO_BTF_ID ?
+						     PTR_TO_BTF_ID :
+						     PTR_TO_BTF_ID_OR_NULL;
 		ret_btf_id = *fn->ret_btf_id;
 		if (ret_btf_id == 0) {
 			verbose(env, "invalid return type %d of func %s#%d\n",
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4517c8b66518..7b48aa1c695a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1022,6 +1022,20 @@ const struct bpf_func_proto bpf_get_current_task_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
+BPF_CALL_0(bpf_get_current_task_btf)
+{
+	return (unsigned long) current;
+}
+
+BTF_ID_LIST_SINGLE(bpf_get_current_btf_ids, struct, task_struct)
+
+const struct bpf_func_proto bpf_get_current_task_btf_proto = {
+	.func		= bpf_get_current_task_btf,
+	.gpl_only	= true,
+	.ret_type	= RET_PTR_TO_BTF_ID,
+	.ret_btf_id	= &bpf_get_current_btf_ids[0],
+};
+
 BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
@@ -1265,6 +1279,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_get_current_task:
 		return &bpf_get_current_task_proto;
+	case BPF_FUNC_get_current_task_btf:
+		return &bpf_get_current_task_btf_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_current_comm:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bb443c4f3637..05c997913872 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3779,6 +3779,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * struct task_struct *bpf_get_current_task_btf(void)
+ *	Description
+ *		Return a BTF pointer to the "current" task.
+ *		This pointer can also be used in helpers that accept an
+ *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
+ *	Return
+ *		Pointer to the current task.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3939,6 +3947,7 @@ union bpf_attr {
 	FN(redirect_peer),		\
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
+	FN(get_current_task_btf),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.29.0.rc2.309.g374f81d7ae-goog

