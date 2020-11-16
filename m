Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908B52B456A
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 15:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgKPOBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 09:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbgKPOBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 09:01:14 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469EFC0613CF
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:01:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so18841313wrx.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOdSjJjyvVNgQtsUvxPpLbV0pNCPERoLSo5YvFTvZ40=;
        b=KcVd0U8xlIfn7HK1Dq6WrEzt6gl1EKTomGeLKjsU4wabIIZWO2EFXxOSGWKPAK+03/
         ViNO9GU9AWQzr0mUGQRGS2PcnK3ntavcvPIUtwlJCIZyHcAWrr5NrRZlyMWjH5iz0QFr
         PX6spB6WPtelclmUFnxwi5co4tpwztN53PQp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOdSjJjyvVNgQtsUvxPpLbV0pNCPERoLSo5YvFTvZ40=;
        b=qqBiBLDRThBm/KX03zfWhpZE4OcSo+mtDAbE1bIUyH/LOmcH2j77RPoz1IN+jbFBiG
         IOCpa+lGZBdrBfo5ieCm2MvI3u/4LxPaO3AMmUQQHnOW+sxX2dOyh0i2dLryU5Cr4Uqh
         tD8jiB3eblyNyDuNVZVajZCFsjk03Zrj/gWMY5hX4U+ZnYPFurpsFOHJ/nlcscg/s3kG
         JmR2LWBJ+8M/zLKYacBKVmIFnEr/X2ipu8rmdhegqFb1ggRELD5Ny92VdUl8Yg2d0/Xh
         zRqCH8/aPq1C/Yw1RNrnHiUmEltZiHxvtY1t6jW685lR8dvp958lfNLtaIdfMNDMeZ8s
         zRFQ==
X-Gm-Message-State: AOAM532sgmBFYup0L6LInJXeAR0rVmgAkXcSuxPINBRl0Yfa9EfbJycg
        nPTpLdKTzjU3dDZmgsFJGecI0Q==
X-Google-Smtp-Source: ABdhPJxMHQb+3Y9GbxiERRhlbEo68i9w/ti694qVoyTC9Je04z9hGPFjfBRI4hwDyWJEAaSNgud49Q==
X-Received: by 2002:a5d:5482:: with SMTP id h2mr8645344wrv.18.1605535272933;
        Mon, 16 Nov 2020 06:01:12 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id i11sm23172477wrm.1.2020.11.16.06.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 06:01:12 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Pauline Middelink <middelin@google.com>
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
Date:   Mon, 16 Nov 2020 15:01:09 +0100
Message-Id: <20201116140110.1412642-1-kpsingh@chromium.org>
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
 kernel/bpf/bpf_lsm.c           | 20 ++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 162999b12790..ed4f575be3d3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3787,6 +3787,14 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * void bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
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
index 553107f4706a..4d04fc490a14 100644
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
@@ -51,6 +52,23 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 	return 0;
 }
 
+BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
+{
+	bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
+	return 0;
+}
+
+BTF_ID_LIST_SINGLE(bpf_lsm_set_bprm_opts_btf_ids, struct, linux_binprm)
+
+const static struct bpf_func_proto bpf_lsm_set_bprm_opts_proto = {
+	.func		= bpf_lsm_set_bprm_opts,
+	.gpl_only	= false,
+	.ret_type	= RET_VOID,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_lsm_set_bprm_opts_btf_ids[0],
+	.arg2_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -71,6 +89,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index 162999b12790..ed4f575be3d3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3787,6 +3787,14 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * void bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
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

