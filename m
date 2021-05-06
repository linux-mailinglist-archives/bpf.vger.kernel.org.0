Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45501374E16
	for <lists+bpf@lfdr.de>; Thu,  6 May 2021 05:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhEFDqW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 23:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEFDqV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 23:46:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78842C061574
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 20:45:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y32so3768517pga.11
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UP5FzMQY3k+D4hSQComA92zMatpJTE1K9fVtajhtQOs=;
        b=ZRLZ8WrF1ggRt5vJ2ISAvwYvfHosUZV7iNb87/+3Ntp0Ab/m+99q0pL1/9KqzJAyjJ
         w5Po/ln05Q1RVBwQXVijt+3mmtnVyAAQLHA7ulmEySrh/YTAJKSURYkMczkCyAtMYiFB
         GltAZogQtfDGCkZygjpcLgxUXoLQaPVHAa6trso4Q9FdqHocB+lOoN1dCvW/cYXuU0S+
         qQHDGDTVhxSDRVFuiKlC6cERHWVoxYNzaSh9m2YdGrCDkLlZ7eMEubH8K02GFRb5lWsi
         WAcecb22tLriuwajybSrjwvSJoWy+3E5/8Ho7ueeAvLa8oozd5cQIEk0R6s0eHDbE9Om
         j2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UP5FzMQY3k+D4hSQComA92zMatpJTE1K9fVtajhtQOs=;
        b=IJSw+dVUMroUl8kvAuW6mLZH/dpw95BMesCEKUCt1KKFY63YIOo+QnxVdUWENn3WEB
         fekNmQ4Z4mRcJWsXZ8OztvacPMxTmIRDqXWLLvjHVkowGfxu1iVtROUjJsgmWeNXTHaf
         z0LlAeaIWiyjRWKZ6Ix5roW+6Z0JyfwRaylUuqmJtIAQEzbtI+REVdtuuWSXO7fw6iSC
         Nv1+UJipMtDvenFm7+pCDdZF9CPZ/XHfvFJZMudSf36sQr/U5t3F47LwY1Epu+LeG/hd
         lW0UgkGJxjOA+Mt7VI43w7xP0hebePAD23a8DP49dtw6KZJ22ijskt/WlakkqFbC9szz
         wjjg==
X-Gm-Message-State: AOAM530Erm/iqwIIfuYcxYMtbJu3i27H8LyaK/4E1AgHnlkPG4RX0nSf
        mi3G6fyEGlwR6VvZJ8OsEfA=
X-Google-Smtp-Source: ABdhPJy7Y6ybvw29IEM5uGVHu8m309lXJdYa+mkSnINgq12qz0+/piXtbpVnleXI0BiLsRYI/EuwWw==
X-Received: by 2002:a65:530c:: with SMTP id m12mr2106060pgq.425.1620272723007;
        Wed, 05 May 2021 20:45:23 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id r22sm578997pgr.1.2021.05.05.20.45.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 20:45:22 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 11/17] bpf: Add bpf_sys_close() helper.
Date:   Wed,  5 May 2021 20:44:59 -0700
Message-Id: <20210506034505.25979-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
References: <20210506034505.25979-1-alexei.starovoitov@gmail.com>
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
index 8a892231a1ae..5ded6b3a30a3 100644
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

