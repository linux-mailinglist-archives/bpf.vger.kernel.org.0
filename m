Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90A26CEDA
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 00:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgIPWiZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 18:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIPWiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 18:38:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4FC061353
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 15:38:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y6so274038ybi.11
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H6ZmBHNIlcWXh49fohZxtebGN/ajK82s8lOp9sbc7A4=;
        b=hz3K6ntLTjv75W6gtd9iLg4Ywy313y+4oNNthWavTThkEnBPrS3K1L1iXq24LNvosL
         p9VIEAvJuGc9jh5PviWRks2wvubUtSet2ZU6PCd+z/pIVrWUu6goDC0Q4HfPvAb8WU+i
         WXYNoDZXnFSUOfjn7/i5rXrGiVSchmDzfKhxJNeQhbxW5RvAdXN9rr/XOdWJaKqizn7Q
         op2OVnrCQ/wvJB+4tgQsMYe2TsZ5ltUSxmfDPOhOJnencwSbgZBF/YGWkG/5T36VTwdT
         6qdwPfktlg33PUOiJI2P4XRP0bXYrgk9kl3LkIzCqo7CsKCI5PvZtJmelBAabfkvZRz8
         8ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H6ZmBHNIlcWXh49fohZxtebGN/ajK82s8lOp9sbc7A4=;
        b=M9gCf1B1k2UNc9RTdsuc6Q15qU3h2oQjZeA3AVhaRN/6AX+GUvBtROro+i+kHCJ7/6
         wqco2fOG+ad+eo9OhP6nD8uOk/MLL3YSeApxv0AJJmKiebb50DE6AXc6fZd+YBFz4Oat
         kRl928lABA77sPmkJ6ie8bRsD4r3FY/9PBb//wp9FNZm91PVK3fJTTnsLpVGNfZuPHdH
         SfkpxmPtpdaG2p58YezhR2Og+Iz4h5TFfQlGOMBtfrgjfKX7nPSeTh13RHNRni2JrG7N
         MqAnfBxVZj+cHdmpQvsxftrGIPCTVJ1Aiz9znTIJ/+zx8ruwrSEt3gM3HpBsIBPV8r4s
         H4WA==
X-Gm-Message-State: AOAM531mhqLAtXquFFqrgbfnt4vsNZ4NyNuaUntdzk3hrZJYisgc9B5X
        xjX7YfO7dkOC3a4GV6XtHYkC0+0x8Wc=
X-Google-Smtp-Source: ABdhPJyv9Y4hN7+iTDfB8hp6VYiOBLxX9J9WiPV08j1Ok5R3UURLarPkPk52EhQdbx2hEFChUx1llaKbM0Q=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a25:b186:: with SMTP id h6mr33624465ybj.24.1600295882651;
 Wed, 16 Sep 2020 15:38:02 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:35:11 -0700
In-Reply-To: <20200916223512.2885524-1-haoluo@google.com>
Message-Id: <20200916223512.2885524-6-haoluo@google.com>
Mime-Version: 1.0
References: <20200916223512.2885524-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH bpf-next v3 5/6] bpf: Introduce bpf_this_cpu_ptr()
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_this_cpu_ptr() to help access percpu var on this cpu. This
helper always returns a valid pointer, therefore no need to check
returned value for NULL. Also note that all programs run with
preemption disabled, which means that the returned pointer is stable
during all the execution of the program.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       | 13 +++++++++++++
 kernel/bpf/helpers.c           | 14 ++++++++++++++
 kernel/bpf/verifier.c          | 11 ++++++++---
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h | 13 +++++++++++++
 6 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 980907e837dd..d73c63150d51 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -307,6 +307,7 @@ enum bpf_return_type {
 	RET_PTR_TO_ALLOC_MEM_OR_NULL,	/* returns a pointer to dynamically allocated memory or NULL */
 	RET_PTR_TO_BTF_ID_OR_NULL,	/* returns a pointer to a btf_id or NULL */
 	RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL, /* returns a pointer to a valid memory or a btf_id or NULL */
+	RET_PTR_TO_MEM_OR_BTF_ID,	/* returns a pointer to a valid memory or a btf_id */
 };
 
 /* eBPF function prototype used by verifier to allow BPF_CALLs from eBPF programs
@@ -1790,6 +1791,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_per_cpu_ptr_proto;
+extern const struct bpf_func_proto bpf_this_cpu_ptr_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ed6fd7ab1f0c..b6e8c0995005 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3621,6 +3621,18 @@ union bpf_attr {
  *     Return
  *             A pointer pointing to the kernel percpu variable on *cpu*, or
  *             NULL, if *cpu* is invalid.
+ *
+ * void *bpf_this_cpu_ptr(const void *percpu_ptr)
+ *	Description
+ *		Take a pointer to a percpu ksym, *percpu_ptr*, and return a
+ *		pointer to the percpu kernel variable on this cpu. See the
+ *		description of 'ksym' in **bpf_per_cpu_ptr**\ ().
+ *
+ *		bpf_this_cpu_ptr() has the same semantic as this_cpu_ptr() in
+ *		the kernel. Different from **bpf_per_cpu_ptr**\ (), it would
+ *		never return NULL.
+ *	Return
+ *		A pointer pointing to the kernel percpu variable on this cpu.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3773,6 +3785,7 @@ union bpf_attr {
 	FN(d_path),			\
 	FN(copy_from_user),		\
 	FN(bpf_per_cpu_ptr),            \
+	FN(bpf_this_cpu_ptr),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5a64ce49597..8452fa251ebb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -639,6 +639,18 @@ const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
+{
+	return (unsigned long)this_cpu_ptr(percpu_ptr);
+}
+
+const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
+	.func		= bpf_this_cpu_ptr,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID,
+	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
@@ -703,6 +715,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_jiffies64_proto;
 	case BPF_FUNC_bpf_per_cpu_ptr:
 		return &bpf_per_cpu_ptr_proto;
+	case BPF_FUNC_bpf_this_cpu_ptr:
+		return &bpf_this_cpu_ptr_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6771d2e2ab9f..a033cba90271 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5016,7 +5016,8 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
 		regs[BPF_REG_0].id = ++env->id_gen;
 		regs[BPF_REG_0].mem_size = meta.mem_size;
-	} else if (fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL) {
+	} else if (fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL ||
+		   fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID) {
 		const struct btf_type *t;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -5034,10 +5035,14 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 					tname, PTR_ERR(ret));
 				return -EINVAL;
 			}
-			regs[BPF_REG_0].type = PTR_TO_MEM_OR_NULL;
+			regs[BPF_REG_0].type =
+				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
+				PTR_TO_MEM : PTR_TO_MEM_OR_NULL;
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
-			regs[BPF_REG_0].type = PTR_TO_BTF_ID_OR_NULL;
+			regs[BPF_REG_0].type =
+				fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
+				PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 		}
 	} else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4e01c98a16d8..a24195fe3d68 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1232,6 +1232,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return prog->aux->sleepable ? &bpf_copy_from_user_proto : NULL;
 	case BPF_FUNC_bpf_per_cpu_ptr:
 		return &bpf_per_cpu_ptr_proto;
+	case BPF_FUNC_bpf_this_cpu_ptr:
+		return &bpf_this_cpu_ptr_proto;
 	default:
 		return NULL;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ed6fd7ab1f0c..b6e8c0995005 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3621,6 +3621,18 @@ union bpf_attr {
  *     Return
  *             A pointer pointing to the kernel percpu variable on *cpu*, or
  *             NULL, if *cpu* is invalid.
+ *
+ * void *bpf_this_cpu_ptr(const void *percpu_ptr)
+ *	Description
+ *		Take a pointer to a percpu ksym, *percpu_ptr*, and return a
+ *		pointer to the percpu kernel variable on this cpu. See the
+ *		description of 'ksym' in **bpf_per_cpu_ptr**\ ().
+ *
+ *		bpf_this_cpu_ptr() has the same semantic as this_cpu_ptr() in
+ *		the kernel. Different from **bpf_per_cpu_ptr**\ (), it would
+ *		never return NULL.
+ *	Return
+ *		A pointer pointing to the kernel percpu variable on this cpu.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3773,6 +3785,7 @@ union bpf_attr {
 	FN(d_path),			\
 	FN(copy_from_user),		\
 	FN(bpf_per_cpu_ptr),            \
+	FN(bpf_this_cpu_ptr),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.28.0.618.gf4bc123cb7-goog

