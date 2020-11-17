Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89402B7269
	for <lists+bpf@lfdr.de>; Wed, 18 Nov 2020 00:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKQX3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 18:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKQX3d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 18:29:33 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A7C0613CF
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 15:29:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so416428wme.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 15:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlGLdU3rd5bCgeYAdwEbTNrseBnDwGqmsLX/kx+4ztU=;
        b=l5TmlNBF02C508yahqVzzJu2xsij69rRfVf2qWik3okKS2tJAgFzBfe6w/C+qNcS3W
         YZc/gQhFziRnRC2PACisFj5Sm2l2hnm4ETf57wZ7900v5Tcf5dksa9XONy1Bkjpw7l6q
         4pwcLWiZzya+0cfxH42hXBvjaAXyKSckYpP7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GlGLdU3rd5bCgeYAdwEbTNrseBnDwGqmsLX/kx+4ztU=;
        b=t+IeUdO6OjkE2LpiWTHrD6GSgxkzTJ+6mnlsmOh9b3ZZ9Me+CZSRO+8qSj2kS4S/QL
         cfIfu264RBmrJW13kpW6T5zlpSe6GbXpbiGdz6dsy1wp6YSUnJXyotMYkbnzCoapP/Bu
         /H/jkYMtisimbatsSVDcRPNl/10G+g0gUS4fguSSZbTZIMxyMVT5+IozmhDxjN5/eazN
         T7xCx5sXZ1FzORCFA3V/pr14yf8gMGFPxrFLRk3K+DMVhVO+sYaqF47ZYfoPeghVM4m0
         +cxJYqFkDkl2pWOVXxtezyv9KItYlEm8bzdt192dfbzKuKUum6rFmgrn/R4WmaOaMRd8
         uvtg==
X-Gm-Message-State: AOAM5315Uevgc76DO47XCrlsC8c4aFNlgBE47eyvQdi0vsHo37Z028sx
        cK4GuWRUF49i8P1lJLDUtiKXXQ==
X-Google-Smtp-Source: ABdhPJznFa5U6v0MtEpALP5uFBcZyFe4ubh6gG66TwACrqbQvTqcVQLSXITdUZbfHH7kAdzMio6b9w==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr1410139wmh.150.1605655771321;
        Tue, 17 Nov 2020 15:29:31 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id k3sm10212083wrn.81.2020.11.17.15.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:29:30 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: [PATCH bpf-next v4 1/2] bpf: Add bpf_bprm_opts_set helper
Date:   Tue, 17 Nov 2020 23:29:28 +0000
Message-Id: <20201117232929.2156341-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The helper allows modification of certain bits on the linux_binprm
struct starting with the secureexec bit which can be updated using the
BPF_F_BPRM_SECUREEXEC flag.

secureexec can be set by the LSM for privilege gaining executions to set
the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
use of certain environment variables (like LD_PRELOAD).

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/uapi/linux/bpf.h       | 16 ++++++++++++++++
 kernel/bpf/bpf_lsm.c           | 26 ++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 162999b12790..a52299b80b9d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3787,6 +3787,16 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * long bpf_bprm_opts_set(struct linux_binprm *bprm, u64 flags)
+ *	Description
+ *		Set or clear certain options on *bprm*:
+ *
+ *		**BPF_F_BPRM_SECUREEXEC** Set the secureexec bit
+ *		which sets the **AT_SECURE** auxv for glibc. The bit
+ *		is cleared if the flag is not specified.
+ *	Return
+ *		**-EINVAL** if invalid *flags* are passed, zero otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3958,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(bprm_opts_set),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -4119,6 +4130,11 @@ enum bpf_lwt_encap_mode {
 	BPF_LWT_ENCAP_IP,
 };
 
+/* Flags for bpf_bprm_opts_set helper */
+enum {
+	BPF_F_BPRM_SECUREEXEC	= (1ULL << 0),
+};
+
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 553107f4706a..b4f27a874092 100644
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
@@ -51,6 +52,29 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 	return 0;
 }
 
+/* Mask for all the currently supported BPRM option flags */
+#define BPF_F_BRPM_OPTS_MASK	BPF_F_BPRM_SECUREEXEC
+
+BPF_CALL_2(bpf_bprm_opts_set, struct linux_binprm *, bprm, u64, flags)
+{
+	if (flags & ~BPF_F_BRPM_OPTS_MASK)
+		return -EINVAL;
+
+	bprm->secureexec = (flags & BPF_F_BPRM_SECUREEXEC);
+	return 0;
+}
+
+BTF_ID_LIST_SINGLE(bpf_bprm_opts_set_btf_ids, struct, linux_binprm)
+
+const static struct bpf_func_proto bpf_bprm_opts_set_proto = {
+	.func		= bpf_bprm_opts_set,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_bprm_opts_set_btf_ids[0],
+	.arg2_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -71,6 +95,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_get_proto;
 	case BPF_FUNC_task_storage_delete:
 		return &bpf_task_storage_delete_proto;
+	case BPF_FUNC_bprm_opts_set:
+		return &bpf_bprm_opts_set_proto;
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
index 162999b12790..a52299b80b9d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3787,6 +3787,16 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * long bpf_bprm_opts_set(struct linux_binprm *bprm, u64 flags)
+ *	Description
+ *		Set or clear certain options on *bprm*:
+ *
+ *		**BPF_F_BPRM_SECUREEXEC** Set the secureexec bit
+ *		which sets the **AT_SECURE** auxv for glibc. The bit
+ *		is cleared if the flag is not specified.
+ *	Return
+ *		**-EINVAL** if invalid *flags* are passed, zero otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3958,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(bprm_opts_set),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -4119,6 +4130,11 @@ enum bpf_lwt_encap_mode {
 	BPF_LWT_ENCAP_IP,
 };
 
+/* Flags for bpf_bprm_opts_set helper */
+enum {
+	BPF_F_BPRM_SECUREEXEC	= (1ULL << 0),
+};
+
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
-- 
2.29.2.299.gdc1121823c-goog

