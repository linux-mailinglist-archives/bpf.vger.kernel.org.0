Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D412A9476
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 11:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKFKh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 05:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgKFKhz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 05:37:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D45C061A4A
        for <bpf@vger.kernel.org>; Fri,  6 Nov 2020 02:37:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so780647wrc.8
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2020 02:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDrtghr7fl8Qm7zyLn6VVlKwXJERTG2goMRxM/wpmVk=;
        b=TG8m0rb86hYMe3axR5sMufRTlAfAJxsttHiX51AiVPLzYrLVvxctyW4cXaUlKNilb1
         o+TMsZ+KaWolXAApOuDjXG5Q0lAbRp9zQis+dBvz1YqPSP07MhBeTAc7Nvtkur9dK4P6
         fj3hGua5R4lTCYWGJAvkC+4XXRuNIF6fJo/WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDrtghr7fl8Qm7zyLn6VVlKwXJERTG2goMRxM/wpmVk=;
        b=TQq8ezZvZLPh9Uwd6ZzwVcpTRhSxu9LHQiZpUbzv+1K6YVsagRuTLbztxcpjfOCx9s
         KQdFSLy8mZcNpIBJbBu+Tlseokg1XXKQcRr8tYIerjMNtu+gs15P47u3dljMMRzLd/dU
         NG8KS8ipohJ4R5hH1/4ZB9PDWmZtqFGBKjEYtDGpMGMd+xW/qFqSfv1lIKyV98Dk/oIH
         1OG+EF7kQadg8EyM73Qphg3bRsGGWvDq2IsgmYKJcAGsrW3W7aocH5jCgkPRyKx3LTT9
         ouF9oGKQDCeNqi20WTwh/iNRJHV45Smv2NyBKpl4Dpxp7keOhT3etYtTpsgmvd/I6EYK
         miSQ==
X-Gm-Message-State: AOAM532z6E7/j4TNCfT14K116lP97dRaZ7YB40MSA/1CX+4xucOoLUp+
        b4txce3tAmS6k/bOm46Pew9+2Q==
X-Google-Smtp-Source: ABdhPJwqxxvFdQje8ueSIXSHHM+I0exSHpFHfLMsIF2YrjVNsFx6hHzUFXzbrii01rBcEKC6Q5q1iw==
X-Received: by 2002:adf:f083:: with SMTP id n3mr1891796wro.391.1604659073369;
        Fri, 06 Nov 2020 02:37:53 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id t1sm1537639wrs.48.2020.11.06.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:37:52 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v6 5/9] bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
Date:   Fri,  6 Nov 2020 10:37:43 +0000
Message-Id: <20201106103747.2780972-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106103747.2780972-1-kpsingh@chromium.org>
References: <20201106103747.2780972-1-kpsingh@chromium.org>
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

Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/bpf/verifier.c          |  7 +++++--
 kernel/trace/bpf_trace.c       | 16 ++++++++++++++++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2fffd30e13ac..73d5381a5d5c 100644
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
index f4037b2161a6..9879d6793e90 100644
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
index 00960f6a83ec..10da26e55130 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5186,11 +5186,14 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
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
index 4517c8b66518..e4515b0f62a8 100644
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
+static const struct bpf_func_proto bpf_get_current_task_btf_proto = {
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
index f4037b2161a6..9879d6793e90 100644
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
2.29.1.341.ge80a0c044ae-goog

