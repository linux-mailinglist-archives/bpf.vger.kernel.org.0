Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFB42B56A1
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 03:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKQCNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 21:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgKQCNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 21:13:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A25C0613CF
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:13:11 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so21440420wrw.10
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 18:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCloNKbMkToJ9Mk9/+OpMDkl1WAHnjlarpErfCnvWfI=;
        b=P40HCWm1qA2a7108A8dIoPbqkWrPz9Swy/e2nLmTJsLlcX+3gFumvPqk3FTo3xgpRc
         xPh3o6C9bvVjwHMKGB1uekA9IX+s3WVYDmLCjXOhn4wd/W4hRbc14muO+QIRE8Qu+BOJ
         dbIszWk1Z8MEUioM/PnhZihJ6CFUiWm+5RGPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCloNKbMkToJ9Mk9/+OpMDkl1WAHnjlarpErfCnvWfI=;
        b=CO8zBuX7+WR6YV6qRO1PjtE3ckozMhlsI15umAS8ZzrGYOQemuYUz6eKCY5JJc8kY4
         vy3JJiaO/luU9sJ37KZLaSjnlLEV+gTBfRwnHyLG5Ncv+Gl/gEPWziJThu0N+7JfrCOS
         LdTfRxCfXplkRUw770RYPU9gXiKdzK89v3c6QJn2UBM99L6WPNjLJlzXJYTKoVQMAOAR
         8IhXlgppSDvXLizdUDWE5co4toPTp8+BK6RPI6JxlCIpE5bEsLFmw0IDg1g8whl4kf6O
         U2iXp91qui4JawnHP6w/Ilk5eVNQqBjJ/e57XQDbtXylzRiVLndC3afMmNdfkOSYNa5w
         XuSA==
X-Gm-Message-State: AOAM533PdoN3r5kPxOvBZ56/gQGMW05ATMcaTi7QRBp/CQ0E+KL8rG8N
        YSRP1urX15sWFZR0XM/nZo/RaQ==
X-Google-Smtp-Source: ABdhPJxdl9LiIt200IA8WggJuIzTrDxoN4FurLbbfAauDxnISbNqdAy5V3PhOV9nTOX7CctKmEfY0Q==
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr24398397wrw.207.1605579189854;
        Mon, 16 Nov 2020 18:13:09 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id u7sm1470001wmb.20.2020.11.16.18.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 18:13:09 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
Date:   Tue, 17 Nov 2020 02:13:06 +0000
Message-Id: <20201117021307.1846300-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The helper allows modification of certain bits on the linux_binprm
struct starting with the secureexec bit which can be updated using the
BPF_LSM_F_BPRM_SECUREEXEC flag.

secureexec can be set by the LSM for privilege gaining executions to set
the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
use of certain environment variables (like LD_PRELOAD).

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
 kernel/bpf/bpf_lsm.c           | 27 +++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 162999b12790..bfa79054d106 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3787,6 +3787,18 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
+ *
+ *	Description
+ *		Set or clear certain options on *bprm*:
+ *
+ *		**BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
+ *		which sets the **AT_SECURE** auxv for glibc. The bit
+ *		is cleared if the flag is not specified.
+ *	Return
+ *		**-EINVAL** if invalid *flags* are passed.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3960,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(lsm_set_bprm_opts),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -4119,6 +4132,11 @@ enum bpf_lwt_encap_mode {
 	BPF_LWT_ENCAP_IP,
 };
 
+/* Flags for LSM helpers */
+enum {
+	BPF_LSM_F_BPRM_SECUREEXEC	= (1ULL << 0),
+};
+
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 553107f4706a..cd85482228a0 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -7,6 +7,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/binfmts.h>
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
@@ -51,6 +52,30 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 	return 0;
 }
 
+/* Mask for all the currently supported BPRM option flags */
+#define BPF_LSM_F_BRPM_OPTS_MASK	BPF_LSM_F_BPRM_SECUREEXEC
+
+BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
+{
+
+	if (flags & ~BPF_LSM_F_BRPM_OPTS_MASK)
+		return -EINVAL;
+
+	bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
+	return 0;
+}
+
+BTF_ID_LIST_SINGLE(bpf_lsm_set_bprm_opts_btf_ids, struct, linux_binprm)
+
+const static struct bpf_func_proto bpf_lsm_set_bprm_opts_proto = {
+	.func		= bpf_lsm_set_bprm_opts,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_lsm_set_bprm_opts_btf_ids[0],
+	.arg2_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -71,6 +96,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_get_proto;
 	case BPF_FUNC_task_storage_delete:
 		return &bpf_task_storage_delete_proto;
+	case BPF_FUNC_lsm_set_bprm_opts:
+		return &bpf_lsm_set_bprm_opts_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 31484377b8b1..c5bc947a70ad 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -418,6 +418,7 @@ class PrinterHelpers(Printer):
             'struct bpf_tcp_sock',
             'struct bpf_tunnel_key',
             'struct bpf_xfrm_state',
+            'struct linux_binprm',
             'struct pt_regs',
             'struct sk_reuseport_md',
             'struct sockaddr',
@@ -465,6 +466,7 @@ class PrinterHelpers(Printer):
             'struct bpf_tcp_sock',
             'struct bpf_tunnel_key',
             'struct bpf_xfrm_state',
+            'struct linux_binprm',
             'struct pt_regs',
             'struct sk_reuseport_md',
             'struct sockaddr',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 162999b12790..bfa79054d106 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3787,6 +3787,18 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
+ *
+ *	Description
+ *		Set or clear certain options on *bprm*:
+ *
+ *		**BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
+ *		which sets the **AT_SECURE** auxv for glibc. The bit
+ *		is cleared if the flag is not specified.
+ *	Return
+ *		**-EINVAL** if invalid *flags* are passed.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3960,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(lsm_set_bprm_opts),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -4119,6 +4132,11 @@ enum bpf_lwt_encap_mode {
 	BPF_LWT_ENCAP_IP,
 };
 
+/* Flags for LSM helpers */
+enum {
+	BPF_LSM_F_BPRM_SECUREEXEC	= (1ULL << 0),
+};
+
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
-- 
2.29.2.299.gdc1121823c-goog

