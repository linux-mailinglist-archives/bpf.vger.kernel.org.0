Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010C82B54E9
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 00:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKPXZk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 18:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKPXZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 18:25:40 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C9C0613CF
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 15:25:39 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so20826015wrr.13
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 15:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33uKN+9Cl21nHIzw+MtC0Lw4sQzHiWLWopQ6EWaBywg=;
        b=ldoO+4eAJCUKf81SOfHdQemnc+VAfFVQD/yRN58xiQej9CnrSNBBvSqbnY3eR4hB2Q
         kKm9POM4YFDRE/P9jBjNvh2RwZZxBDy3tJKIa6kGxtx6cy8x5Stx+rfcHwLwG87kWXMD
         JZG/H/RFL0F5akORkVk0DltLnjwS1erjfuyoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33uKN+9Cl21nHIzw+MtC0Lw4sQzHiWLWopQ6EWaBywg=;
        b=DbNlo9wOj75+QJqsDcwS8o4R5zynbnGujYaRvtv0ymuOdhZMAUtVWxwbisf5VVZCpO
         TxL1vgi293JlfgTVzzK9yGoO+7zTr7nr4JCrmhcze5LaQJCxrSokPNR9z5TuQ9NI7vJ+
         8gzees4bCf483pSI5bFSmxkYTHuTxfcp3S4utNBCR6cRx27dKKtx71fK/Mw15jMWEzXr
         cC3T/8wYAoUwaIp28NsBPHnksedKl8nCw052WbWwLoUiaFWXVX3XjWcth+0psZNlWUAE
         arQFvAM4M7zse/L5uClxNcTh/Kh+ZOngJTpTGFZZ/9OM5dsI5xU5SREnaCIw5/RlQwIL
         LBSA==
X-Gm-Message-State: AOAM533T//+wjVBx6f7i6Tepq1vxfYDYPhtC7uvBY7UaejhZaB5U8xhC
        fLNR8ygMA2NomEzG6GkEe8SThg==
X-Google-Smtp-Source: ABdhPJyFWMMVzLrNMzEghtw8MN+go5Texi+l5kWSjBuYib5lj0uvL9iO6vymu7ytN2H6s1KDCozVPA==
X-Received: by 2002:adf:8382:: with SMTP id 2mr21814905wre.227.1605569138400;
        Mon, 16 Nov 2020 15:25:38 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m3sm20783212wrv.6.2020.11.16.15.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:25:37 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
Date:   Mon, 16 Nov 2020 23:25:35 +0000
Message-Id: <20201116232536.1752908-1-kpsingh@chromium.org>
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
 include/uapi/linux/bpf.h       | 14 ++++++++++++++
 kernel/bpf/bpf_lsm.c           | 27 +++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 162999b12790..7f1b6ba8246c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3787,6 +3787,14 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
+ *
+ *	Description
+ *		Sets certain options on the *bprm*:
+ *
+ *		**BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
+ *		which sets the **AT_SECURE** auxv for glibc.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3956,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(lsm_set_bprm_opts),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -4119,6 +4128,11 @@ enum bpf_lwt_encap_mode {
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
index 553107f4706a..31f85474a0ef 100644
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
+#define BPF_LSM_F_BRPM_OPTS_MASK	0x1ULL
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
index 162999b12790..7f1b6ba8246c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3787,6 +3787,14 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
+ *
+ *	Description
+ *		Sets certain options on the *bprm*:
+ *
+ *		**BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
+ *		which sets the **AT_SECURE** auxv for glibc.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3956,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(lsm_set_bprm_opts),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -4119,6 +4128,11 @@ enum bpf_lwt_encap_mode {
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

