Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD09F4100FB
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbhIQV64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhIQV64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:58:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C8DC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c4so7070278pls.6
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljVCzM/zo6Gnq9xzK0zSxHWalW4UjS9N0rqB6zLy9dc=;
        b=XYaeTls5LhCS+08WcH/lZHPsYuw5DYjpQcWj6UOg0mTtpRzExVlXCN+MPOcCMEzmlK
         4dahyzUtUEPKgIKEjTjLE2bDqFbdrjC31frIhQDb18PjQLJuaCKUujawGVlojMS8tI3J
         q8O8H5UDQjUPrOMFfkF3bKnLyKNeMvOhXO0eJkCCX+ipBA4lDVm8xykTwBY0Wov466h9
         KZ8z6/xMgk9ZaZZ/fKF2k0gXkNm9i2d6HSnGLuJytYSrBNIQMh+Uhmrna+IYXnr/trAJ
         XMFVdqClQXZcfkiBO0OnI7ZXHFXM72HtcxJ7JbEatIRCCT5mm7/MHkTKLegp/JEcyeVV
         p8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljVCzM/zo6Gnq9xzK0zSxHWalW4UjS9N0rqB6zLy9dc=;
        b=VhjunFKkHEOamXfzAaJs4NPLEGq8LHBAH9D16n+cAlrHWE7u9f8TrMRBc3nCDw0yc3
         MmRMIaBYSsqspOXxHCooNv/r9VjQS9df1Aceb1T8/QmZUUw1mldxkIHrxB9Om/kUL35Y
         ebMb8HbsDGAh16S0ip9z9gNT0dXsGUJ+HoBuKuirdLwK8q95gsWdkYJ/3npRUcrgzEZo
         s1PSDVjKRfSvnwY77at0ec0PFh0x5WgP2G9EBcMQYxXK4BZyKqZWJns0+FPoQ93LpUTY
         s5Fu/hSW2W7N5kCHeK6HORLS4V5qqg03GcNAg4xPSVDHSMEtOAA7EeC160oqkeFqCnNN
         TRlQ==
X-Gm-Message-State: AOAM532qmA3fJ6g2RV0IAKP60/BFbxMe88RYwOE4RnIxP17GScgZe6FJ
        NOcJ5aofARWF3kyRJq+qZ5E=
X-Google-Smtp-Source: ABdhPJxz1r1akWa0rB5VPTaZkt01Ho1zg3MrkUS2dPS2qAv1jJqL//oNEzeBxHo12TTaB/2p6W3fjw==
X-Received: by 2002:a17:902:a3cf:b0:13a:70c6:f911 with SMTP id q15-20020a170902a3cf00b0013a70c6f911mr11552718plb.42.1631915853159;
        Fri, 17 Sep 2021 14:57:33 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id j6sm6964040pgh.17.2021.09.17.14.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:32 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 03/10] bpf: Add proto of bpf_core_apply_relo()
Date:   Fri, 17 Sep 2021 14:57:14 -0700
Message-Id: <20210917215721.43491-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Prototype of bpf_core_apply_relo() helper.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 14 ++++++++++++++
 kernel/bpf/btf.c               | 22 ++++++++++++++++++++++
 kernel/bpf/syscall.c           |  2 ++
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 5 files changed, 53 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b6c45a6cbbba..a3cb8ea272f7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2102,6 +2102,7 @@ extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
+extern const struct bpf_func_proto bpf_core_apply_relo_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8fb61f22b72c..c2b8857b8a1c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4909,6 +4909,13 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * long bpf_core_apply_relo(int btf_fd, struct bpf_core_relo_desc *relo, int relo_sz,
+ *			    struct bpf_insn *insn, int flags)
+ * 	Description
+ * 		Apply given relo.
+ * 	Return
+ * 		Returns 0 on success.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5089,6 +5096,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(core_apply_relo),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -6313,4 +6321,10 @@ enum bpf_core_relo_kind {
 	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
 };
 
+struct bpf_core_relo_desc {
+	__u32 type_id;
+	__u32 access_str_off;
+	enum bpf_core_relo_kind kind;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fa2c88f6ac4a..9bb1247346ce 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6369,3 +6369,25 @@ size_t bpf_core_essential_name_len(const char *name)
 	}
 	return n;
 }
+
+BPF_CALL_5(bpf_core_apply_relo, int, btf_fd, struct bpf_core_relo_desc *, relo,
+	   int, relo_sz, void *, insn, int, flags)
+{
+	struct btf *btf;
+	long ret;
+
+	if (flags)
+		return -EINVAL;
+	return -EOPNOTSUPP;
+}
+
+const struct bpf_func_proto bpf_core_apply_relo_proto = {
+	.func		= bpf_core_apply_relo,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg5_type	= ARG_ANYTHING,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..3c349b244a28 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4763,6 +4763,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_btf_find_by_name_kind_proto;
 	case BPF_FUNC_sys_close:
 		return &bpf_sys_close_proto;
+	case BPF_FUNC_core_apply_relo:
+		return &bpf_core_apply_relo_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8fb61f22b72c..c2b8857b8a1c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4909,6 +4909,13 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * long bpf_core_apply_relo(int btf_fd, struct bpf_core_relo_desc *relo, int relo_sz,
+ *			    struct bpf_insn *insn, int flags)
+ * 	Description
+ * 		Apply given relo.
+ * 	Return
+ * 		Returns 0 on success.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5089,6 +5096,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(core_apply_relo),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
@@ -6313,4 +6321,10 @@ enum bpf_core_relo_kind {
 	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
 };
 
+struct bpf_core_relo_desc {
+	__u32 type_id;
+	__u32 access_str_off;
+	enum bpf_core_relo_kind kind;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.30.2

