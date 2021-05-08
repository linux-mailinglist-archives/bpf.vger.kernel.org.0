Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726AC376F3C
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhEHDuD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhEHDuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB6C061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a11so6233363plh.3
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i2IYG8EW9hvtHL7j1SorOuzsq3cQ3EMooNko0bSzuhU=;
        b=DDs4hYpN1JlGK07wzIbAbPGr9HCVfGHzQ/TZlu2Qpme2zJxOQQ0VeD/iMJaiyqfMNi
         aN4nyTT788EWNMPOmKN/rO99QXOKRjyu69Rs1uhAOD3cob4p/69pSds7cYbX9fkugvOU
         ZlAqBQe5hfyQR7Si4RZU5hJWpH3+XdGKlubSpAhOLdk+qiJpv3PkHKhi3B1bMVnaoUro
         cOzVTVtQscIPU0dx47jbpFWkA/QpM+DkUH9YswktUiJONOP7Ea+chWeveCI9Yl7QUHzf
         4zmgdVaq3otryddBbCtkRNpa5pScr0T9/EQg/d68jO8I6iH8aHEpQZp2yjr2jViddfkV
         W1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i2IYG8EW9hvtHL7j1SorOuzsq3cQ3EMooNko0bSzuhU=;
        b=BXcPJoHTwYGUsaxirF/SUVKgTMnjscNRI+WNKb1vdG9IAiGSors/PXDjglSvubUg0j
         LFeVST5YNkSzHVQujnWqjiRzEMl1neo6mdKuvCrs0NvCTG20ef0tY6/0it99RjZMSV9R
         ycTX1HNW18IKf171WNF2R6TN0yPMSHOz5Hzw3PIdsWwd7PyISqaPzP4xe6abX4Fi2w3M
         Yo8LsTLGIigisQvn9/f4IoHPuvrOsQLpJTmukwVXjci9AaRvh31Pni56Gh/3sn8RD/Hx
         MuuZ6ogJuK9RcWJfhUv5uJVfHlLrLKtDlALXRe8bR++5Qd7EbTslvknlJQTe9BRajudV
         HisA==
X-Gm-Message-State: AOAM530GyNRnA/fCiplv9j7AqENw/jQhnhb8XfyoVU2k3AAmIdwJUnbZ
        L2og+ZbgRiqZmpRIMECr9eXSSXWRJQA=
X-Google-Smtp-Source: ABdhPJwsIY/vO3JhJcXL0sqeiuiet98NddilHt1jLCjVzsHUtiC2H+JzfM7MgZGODkUz4eQ2lqrkXQ==
X-Received: by 2002:a17:902:8a8a:b029:ec:857a:4d51 with SMTP id p10-20020a1709028a8ab02900ec857a4d51mr12995505plo.68.1620445741390;
        Fri, 07 May 2021 20:49:01 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:00 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 11/22] bpf: Add bpf_sys_close() helper.
Date:   Fri,  7 May 2021 20:48:26 -0700
Message-Id: <20210508034837.64585-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add bpf_sys_close() helper to be used by the syscall/loader program to close
intermediate FDs and other cleanup.
Note this helper must never be allowed inside fdget/fdput bracketing.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/syscall.c           | 19 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 3 files changed, 33 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3cc07351c1cf..4cd9a0181f27 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4754,6 +4754,12 @@ union bpf_attr {
  * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
  * 	Return
  * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
+ *
+ * long bpf_sys_close(u32 fd)
+ * 	Description
+ * 		Execute close syscall for given FD.
+ * 	Return
+ * 		A syscall result.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4924,6 +4930,7 @@ union bpf_attr {
 	FN(snprintf),			\
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
+	FN(sys_close),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f93ff2ebf96d..0f1ce2171f1e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4578,6 +4578,23 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return bpf_base_func_proto(func_id);
 }
 
+BPF_CALL_1(bpf_sys_close, u32, fd)
+{
+	/* When bpf program calls this helper there should not be
+	 * an fdget() without matching completed fdput().
+	 * This helper is allowed in the following callchain only:
+	 * sys_bpf->prog_test_run->bpf_prog->bpf_sys_close
+	 */
+	return close_fd(fd);
+}
+
+const struct bpf_func_proto bpf_sys_close_proto = {
+	.func		= bpf_sys_close,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -4586,6 +4603,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
+	case BPF_FUNC_sys_close:
+		return &bpf_sys_close_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3cc07351c1cf..4cd9a0181f27 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4754,6 +4754,12 @@ union bpf_attr {
  * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
  * 	Return
  * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
+ *
+ * long bpf_sys_close(u32 fd)
+ * 	Description
+ * 		Execute close syscall for given FD.
+ * 	Return
+ * 		A syscall result.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4924,6 +4930,7 @@ union bpf_attr {
 	FN(snprintf),			\
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
+	FN(sys_close),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

