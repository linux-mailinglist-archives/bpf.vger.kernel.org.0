Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB5380133
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhENAh5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B78C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m124so22792947pgm.13
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kGCehd7tU7fXg+dXTqFsyCRIRI15J2sPfk28ulDCx7I=;
        b=iricubpJKQyOUAHx0cVyos879FemvM57jKC+gXgCmw9qQCxYnamOqBSGkAEgZNnF6J
         lByfeU3h6FcD8IQ1o6rUlhKN9OMV65I67LOzh59c+ZdPRVcgzj0Iy9evizxZfIhYiOh5
         z87kF+VoqEtHvC6iQ5cWEZidIOomWg9oJbMdzUIgBSz5ql9MlyxT6eZMvPd4p3/lXtvL
         bbfquhmT5rwzaM5aqP1/UPiJr5i1s7x13O1NY/kupMiiX1pWE1T/58gKiL2M9Y6LLFRu
         p6U33AAD+2gMR+OkPkiPz6WxZfoBNVCpuTFiundXOZqz//WFBimjbB76kjNEaXy71Sit
         rBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kGCehd7tU7fXg+dXTqFsyCRIRI15J2sPfk28ulDCx7I=;
        b=T7REBf59OxRBHnP6WAGrV4Pnx3zoSbByjxRtS+VD+2Rgj2E5mwvurIALiKLYkGuDl/
         zAlqgB38aJkYLVe0Mk0ZHOjC5aIek5FK7I+spKNn1vAquLmTKT9ieKrPte3gW1OuZSA7
         VqHrSTh11dtb2sS/tsGYmbDF+SmdvsZdD2y3SX+BRHsWcGWSVXBgDzh+gbi21Ppaitg7
         c+s4m3tL2Fff4dJqyuX+BrQQD3MK9c9NhOeAgSDI5WQvkHZT6J0kJ0/hlAc3qX4x4x+2
         mSdSbTMneTcUxyJTI7b/cR2MDWNaWCMWGge0rb2DuVVPCQ3Fr5O4ysBy6hcb8opejO8F
         ytkA==
X-Gm-Message-State: AOAM530y7xXil8YXts71Z3VtJYBg5r+0ck9sPm+0WZiwNPhFwT8VgIKJ
        ck+shUm9aJGSrBYEob1DxKs=
X-Google-Smtp-Source: ABdhPJwF2m1/Kyerhd27G7GdkTcO3jCeUafE8DuXAglmVgDmAU/PxPQeewEmNz3Qq84f3g1EqKxc7g==
X-Received: by 2002:aa7:9398:0:b029:2ce:9147:85c2 with SMTP id t24-20020aa793980000b02902ce914785c2mr9734892pfe.23.1620952605780;
        Thu, 13 May 2021 17:36:45 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:45 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 10/21] bpf: Add bpf_sys_close() helper.
Date:   Thu, 13 May 2021 17:36:12 -0700
Message-Id: <20210514003623.28033-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add bpf_sys_close() helper to be used by the syscall/loader program to close
intermediate FDs and other cleanup.
Note this helper must never be allowed inside fdget/fdput bracketing.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
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

