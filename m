Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9454236D8
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 06:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJFEJB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 00:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhJFEJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 00:09:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9E6C061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 21:07:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so1242062pff.3
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nnmz7CktOAgSmdg/FO0E46Bqg20MpOWRb3gz2AkPMEI=;
        b=erFfsnMYONMLCTxGeIiNvcMjLgyEHtvx+z03BkR5dQwXGJRqhHOwRXgvPJPKMEiZAl
         riHkl2YPJLCEgsz7eNYLOhx2uoeUhXxe8dsegSgebLaieQ3oCo+n8rNQHEQ3vNThNYO8
         XnLg9TfrtMk95xCocqQVc6AjkCYHqM3+RYMeAp/007Fk/B93Z+3K/inw2BLW0wY75I/f
         xBFpFFg0KjYH0awonvF5yyEtPYFEI+qDTGbL4wZmU2n88vSmyz+SdEIS3XyBJNt+UfRq
         Q/9eEdYFvbyvJ01OSLhgAmebdlsE50a+o7DX0EYkMAcpyj0ND+aCabZIDlKJBidq47un
         4rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nnmz7CktOAgSmdg/FO0E46Bqg20MpOWRb3gz2AkPMEI=;
        b=N2p/fzWOUUieyh2N24Qb07k8sKlRJNqBn96gI+w+EbpPP+aQNmftlQaOY9OZRog1wR
         mVpDl5rbnycnq6zIBC2gvWeuLmiOyLozs/6w+I7larupdy957FdhjIDXgI6xarVqt5lY
         aBZCQYjciuDNZBKG6jxQGLgb63Qz4/MC61SiF03Kkc5bzmEhJBuCSX0fQQ/FF+sLuJGP
         FUyGcJr2GMBJ3NRh8hLQm+D+lF0zxbeTrwYpFWtzt7pexjOIobACdSh7W998v0uvICL+
         +XbpCOOEeBhOwHD5PF/T2cQzKwHiNgvbmuyZYzYXnOGiVzaGWyxOlhvG1pc05ILlie9z
         zSmA==
X-Gm-Message-State: AOAM531Aa0HKBQvUOWmJ7bu6C1tDeNJUioNXmWLjcHt5Yk7+Bna/No2t
        oiUdsEk533l7mO3Cr7qGKJiM/AvVWL85ZQ==
X-Google-Smtp-Source: ABdhPJwJyqf5oF8aeQQfwZDJytQfxE6RBORfQEs8U9Iiju4fQtpRoF50AG6D793t0CXGCr3VfAI8ZA==
X-Received: by 2002:a62:15c3:0:b0:44c:667c:2731 with SMTP id 186-20020a6215c3000000b0044c667c2731mr12893602pfv.17.1633493228823;
        Tue, 05 Oct 2021 21:07:08 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id b21sm20846965pfv.96.2021.10.05.21.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 21:07:08 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_skc_to_unix_sock() helper
Date:   Wed,  6 Oct 2021 12:06:22 +0800
Message-Id: <20211006040623.401527-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006040623.401527-1-hengqi.chen@gmail.com>
References: <20211006040623.401527-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper is used in tracing programs to cast a socket
pointer to a unix_sock pointer.
The return value could be NULL if the casting is illegal.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/trace/bpf_trace.c       |  2 ++
 net/core/filter.c              | 23 +++++++++++++++++++++++
 scripts/bpf_doc.py             | 12 +++++++-----
 tools/include/uapi/linux/bpf.h |  7 +++++++
 6 files changed, 47 insertions(+), 5 deletions(-)

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
index 00ac7b79cddb..c11335a9b708 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -250,17 +250,17 @@ class PrinterRST(Printer):
         license = '''\
 .. Copyright (C) All BPF authors and contributors from 2014 to present.
 .. See git log include/uapi/linux/bpf.h in kernel tree for details.
-.. 
+..
 .. %%%LICENSE_START(VERBATIM)
 .. Permission is granted to make and distribute verbatim copies of this
 .. manual provided the copyright notice and this permission notice are
 .. preserved on all copies.
-.. 
+..
 .. Permission is granted to copy and distribute modified versions of this
 .. manual under the conditions for verbatim copying, provided that the
 .. entire resulting derived work is distributed under the terms of a
 .. permission notice identical to this one.
-.. 
+..
 .. Since the Linux kernel and libraries are constantly changing, this
 .. manual page may be incorrect or out-of-date.  The author(s) assume no
 .. responsibility for errors or omissions, or for damages resulting from
@@ -268,11 +268,11 @@ class PrinterRST(Printer):
 .. have taken the same level of care in the production of this manual,
 .. which is licensed free of charge, as they might when working
 .. professionally.
-.. 
+..
 .. Formatted or processed versions of this manual, if unaccompanied by
 .. the source, must acknowledge the copyright and authors of this work.
 .. %%%LICENSE_END
-.. 
+..
 .. Please do not edit this file. It was generated from the documentation
 .. located in file include/uapi/linux/bpf.h of the Linux kernel sources
 .. (helpers description), and from scripts/bpf_doc.py in the same
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
2.25.1

