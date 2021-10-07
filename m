Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE51842551B
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbhJGOQA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbhJGOP4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 10:15:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E9C061746
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 07:14:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so5771667pgl.10
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOyNecomXvoejU5gy2ePfruBRNMyjmdJcTJsYvrNzHE=;
        b=MY/CyDvFR5RZwB8y3XYoGvXT8okFPa5MB8pVztNhznOstOf9LQ4gnOlKKl3G4020GM
         PwG9VufEMugSvkOsfzJ1rDBoNXoSBao/s39iu4mFCYIXDVy9IqOWSAnGiSROf3LXsbgu
         No34ZhPy+80WD+T/eKelwMHhmZ4HS2M0ARMxEh0GIMU3jToh1ZCHWgxoi2P9wGEzqkb4
         Nlrd20x2gs8VnDawN3bU/tR9xo+mpIqtjWSS0cS5JM/YsznaszHkXogi83szJyy6/dEt
         OTNN9ITj6BgKmE4i9ivkEoR1G+EWel9Wk0KAs/v9LsLXAI8hwW9COzozp6KospA/BCAN
         p0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOyNecomXvoejU5gy2ePfruBRNMyjmdJcTJsYvrNzHE=;
        b=o++04fPXWx5ukCP2yuHiCrSA78vf6Xmg3XsiUUx05cvSOZ4sVFUQ1GD4YettQZFswb
         pzAMjskqvpYWW2ZPaLR8Uk201WkCzDNV2BcJRp/ph2siOd/zBeSHkIHIJAsmql8BnBG+
         h1nm8o9XtTimzQlSn3FdS5QGQiud2XbeRd5OCKZSfC+xpVqBigQc6EHiHuIw0lUzluVt
         SZq03CvrpYvd1w+MN4wlSJiqYPjSPr/K9QiP8aNTlQNAwL79PErU2x3OF/nr3mwja9Fq
         cKrh3pZDDpZ5mGmD2OF0M1r9n9Fw0Q08uwrOLWkw4FYSWD9mbVcHrCwTSpH5OrypwgM9
         s8KQ==
X-Gm-Message-State: AOAM5317UUU4AHzPWjbb5rjIG8d/4Is1qBSlunGIaylE46Pgq6upt7nA
        90R3Voi7x1cg3T1qXWEHonRExMy7h+VgpA==
X-Google-Smtp-Source: ABdhPJzS0kQYNqxrGZ8HVm3XFT9JjsQBE0NL/LMSij9wmFv6MkSULaAVeEYz3+0u4smj/JraOaV7yQ==
X-Received: by 2002:a65:664f:: with SMTP id z15mr3624635pgv.252.1633616042370;
        Thu, 07 Oct 2021 07:14:02 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id rm6sm3102699pjb.18.2021.10.07.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:14:02 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2 v2] bpf: Add bpf_skc_to_unix_sock() helper
Date:   Thu,  7 Oct 2021 22:13:30 +0800
Message-Id: <20211007141331.723149-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007141331.723149-1-hengqi.chen@gmail.com>
References: <20211007141331.723149-1-hengqi.chen@gmail.com>
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
 scripts/bpf_doc.py             |  2 +
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
