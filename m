Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD443635A
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJUNuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhJUNun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 09:50:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE26C0613B9
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:48:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t184so353185pgd.8
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1Ls68ZN+8sYJaB10n7o5jVA9RtAOP8y/er56I2qbI4=;
        b=Qa3SR+m3ap9Y+Vaxz/0hx2mWnDloWOq6uUg3e56wHF03JP52Ix9M/+FxY9So7wJrHJ
         5AhmNf9G1tqWL4vweJZPfc+qYCdsdfTNPXaHbaYvICY5STII3I+21wR+oVWo+uQCpjNb
         QUoU9UUQw1X61Gq592GYPNXITlswaRocrEqyG3R4/EXzh6PVRUYpJkHwlL6C/k3GKRhv
         cxjHOZbsWZUX/9nns7IbwInZrjPUDWkp8ZNdOlhzjfAslxfH6Qa9gSRiW7iCX397gzXU
         gAxFZiLkSpVx1XjwvDBddZe0ucjQ/mxNqvzfpjlMNmqkAMkZ6iesbO5Mlu6t3R2tRVlz
         DhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1Ls68ZN+8sYJaB10n7o5jVA9RtAOP8y/er56I2qbI4=;
        b=4VIw4Qpi0LFnfKhiFHbqszeQkAxbLNNYcgWRKe1J8pJdy8sGgoD9pGAhwd5jVnDOLe
         wFJbx3WvwskF8hFXpDOlDcG670S/Bruf1tpTGN3HjfQUKHod9palKOhkpOABZASzA2Q+
         RdlT9mQpPMdCo5/owlAEz5Kim7zR4r/xcocrqTNSZBq0pO2reMvMZQYYYBsxRLBdRCOC
         x/Rq1i2Gi59jhfee31zdzM0wCPXlZ3q4sMRGWkv/ESOyyfhe36DQsvMtQCX0zMu3EtBl
         gPzMKTQQ1MT6XrVcSD5+0IgpfPTGhlKaRFbtwYKsUTYYfUyCeDTfAWMgA++P6kfORa/R
         PBfA==
X-Gm-Message-State: AOAM530zr+KMDOICqbmRr195LAyv4GsAX9jF+/ENeEUkKdCaITNrPsbz
        wXmRduKYWcYlq//m2UWP75oiVDe3aceurA==
X-Google-Smtp-Source: ABdhPJwFmVggdBo9fxh2S9smrYSTGpcr5M88Ty6hhVh+HOPcD8sJQ5KlmjdVyS9fhxtF6PRExjS2hA==
X-Received: by 2002:a62:5ec2:0:b0:44d:47e2:4b3b with SMTP id s185-20020a625ec2000000b0044d47e24b3bmr5678860pfb.38.1634824107553;
        Thu, 21 Oct 2021 06:48:27 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id f21sm6830067pfc.203.2021.10.21.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:48:27 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3 1/2] bpf: Add bpf_skc_to_unix_sock() helper
Date:   Thu, 21 Oct 2021 21:47:51 +0800
Message-Id: <20211021134752.1223426-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021134752.1223426-1-hengqi.chen@gmail.com>
References: <20211021134752.1223426-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper is used in tracing programs to cast a socket
pointer to a unix_sock pointer.
The return value could be NULL if the casting is illegal.

Suggested-by: Yonghong Song <yhs@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 23 +++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 6 files changed, 42 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d604c8251d88..be3102b4554b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2093,6 +2093,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
+extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6fc59d61937a..22e7a3f38b9f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4909,6 +4909,12 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * struct unix_sock *bpf_skc_to_unix_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *unix_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5089,6 +5095,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(skc_to_unix_sock),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6b3153841a33..cbcd0d6fca7c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1608,6 +1608,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skc_to_tcp_request_sock_proto;
 	case BPF_FUNC_skc_to_udp6_sock:
 		return &bpf_skc_to_udp6_sock_proto;
+	case BPF_FUNC_skc_to_unix_sock:
+		return &bpf_skc_to_unix_sock_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
diff --git a/net/core/filter.c b/net/core/filter.c
index 4bace37a6a44..8e8d3b49c297 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10723,6 +10723,26 @@ const struct bpf_func_proto bpf_skc_to_udp6_sock_proto = {
 	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_UDP6],
 };
 
+BPF_CALL_1(bpf_skc_to_unix_sock, struct sock *, sk)
+{
+	/* unix_sock type is not generated in dwarf and hence btf,
+	 * trigger an explicit type generation here.
+	 */
+	BTF_TYPE_EMIT(struct unix_sock);
+	if (sk && sk_fullsock(sk) && sk->sk_family == AF_UNIX)
+		return (unsigned long)sk;
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_skc_to_unix_sock_proto = {
+	.func			= bpf_skc_to_unix_sock,
+	.gpl_only		= false,
+	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
+	.arg1_type		= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_UNIX],
+};
+
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
 	return (unsigned long)sock_from_file(file);
@@ -10762,6 +10782,9 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_skc_to_udp6_sock:
 		func = &bpf_skc_to_udp6_sock_proto;
 		break;
+	case BPF_FUNC_skc_to_unix_sock:
+		func = &bpf_skc_to_unix_sock_proto;
+		break;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 00ac7b79cddb..a6403ddf5de7 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -537,6 +537,7 @@ class PrinterHelpers(Printer):
             'struct tcp_timewait_sock',
             'struct tcp_request_sock',
             'struct udp6_sock',
+            'struct unix_sock',
             'struct task_struct',
 
             'struct __sk_buff',
@@ -589,6 +590,7 @@ class PrinterHelpers(Printer):
             'struct tcp_timewait_sock',
             'struct tcp_request_sock',
             'struct udp6_sock',
+            'struct unix_sock',
             'struct task_struct',
             'struct path',
             'struct btf_ptr',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6fc59d61937a..22e7a3f38b9f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4909,6 +4909,12 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * struct unix_sock *bpf_skc_to_unix_sock(void *sk)
+ * 	Description
+ *		Dynamically cast a *sk* pointer to a *unix_sock* pointer.
+ *	Return
+ *		*sk* if casting is valid, or **NULL** otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5089,6 +5095,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(skc_to_unix_sock),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

