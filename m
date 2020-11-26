Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0678A2C5985
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403974AbgKZQqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403923AbgKZQpn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 11:45:43 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92558C061A47
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:45:41 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so2812539wrv.6
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 08:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBLkMiU4AZr9DwvoaSu135Em+YugoC0ZruXr4QELs2A=;
        b=Z+g9Cd897ku1PCfexurtrEKmKTArtxH/GS6WUlZGdbueQMN4Zy9ClCUTXRGhP6qBIu
         v/5mazfLJ2QzyxrJqlCx/K7EpkJEWuozj8G8sF70nLpTWb5oDZffxlG+q06rP0MBUpJb
         cOJsCl4FPTODAFNVIanqPy9UInMphaITtArmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBLkMiU4AZr9DwvoaSu135Em+YugoC0ZruXr4QELs2A=;
        b=iBVIuVvyGNrPlazd/DOjVTgZn+1Ai/NEZqW7Kq2vJNasdRDw7LO8cQYXv9UUNVCcpv
         XqJk3R7QFVQoNBZDcOT6VBw3GH/ZRJWWvW53ePYNEnOEPX0gLTRIROtDTlwxuIPy81K4
         ZG6erFp+qb8yWkDTorVsbf+2IrcRTp7R/ugeBS/r2BDKxaHGveBdb3pnlGQdk+PTqLEu
         WoblVdx++M5CUyk8713JgHLFL2HnnU5lj5NIijO7Vt9QaTXRcLl6Z6x7VaJsMLdihxAa
         0LKlu2hiIpO21xjFEYwbRF737vbft6fDJte8WxHtiSlt2uHps7WqxM8+KjBgp+oN1ZyG
         DpUA==
X-Gm-Message-State: AOAM530O6our072bxlxMU0rEtHUyzPtc3ufK9c8AzfuzYQwC8ES0z7bw
        pB/32jq/kcKFx1LPwVTa/HBELdbWVIODYNeG
X-Google-Smtp-Source: ABdhPJzpzqOZ2ltvKHE1YHKtRwuBy1a1wReRu5pxL/0DcvJGQHt988+K3byFXupcu8wSor4VuiSPIA==
X-Received: by 2002:a5d:4ec8:: with SMTP id s8mr5050945wrv.349.1606409140037;
        Thu, 26 Nov 2020 08:45:40 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id f17sm8805824wmh.10.2020.11.26.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 08:45:39 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        KP Singh <kpsingh@google.com>
Subject: [PATCH bpf-next v3 2/6] bpf: Add a bpf_sock_from_file helper
Date:   Thu, 26 Nov 2020 17:44:45 +0100
Message-Id: <20201126164449.1745292-2-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201126164449.1745292-1-revest@google.com>
References: <20201126164449.1745292-1-revest@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While eBPF programs can check whether a file is a socket by file->f_op
== &socket_file_ops, they cannot convert the void private_data pointer
to a struct socket BTF pointer. In order to do this a new helper
wrapping sock_from_file is added.

This is useful to tracing programs but also other program types
inheriting this set of helpers such as iterators or LSM programs.

Signed-off-by: Florent Revest <revest@google.com>
Acked-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/trace/bpf_trace.c       | 20 ++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  4 ++++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 4 files changed, 42 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c3458ec1f30a..a92b2b7d331b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3817,6 +3817,14 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * struct socket *bpf_sock_from_file(struct file *file)
+ *	Description
+ *		If the given file represents a socket, returns the associated
+ *		socket.
+ *	Return
+ *		A pointer to a struct socket on success or NULL if the file is
+ *		not a socket.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3981,6 +3989,7 @@ union bpf_attr {
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
 	FN(ima_inode_hash),		\
+	FN(sock_from_file),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d255bc9b2bfa..d0aac9eac2d8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1260,6 +1260,24 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_1(bpf_sock_from_file, struct file *, file)
+{
+	return (unsigned long) sock_from_file(file);
+}
+
+BTF_ID_LIST(bpf_sock_from_file_btf_ids)
+BTF_ID(struct, socket)
+BTF_ID(struct, file)
+
+static const struct bpf_func_proto bpf_sock_from_file_proto = {
+	.func		= bpf_sock_from_file,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id	= &bpf_sock_from_file_btf_ids[0],
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_sock_from_file_btf_ids[1],
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1356,6 +1374,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_per_cpu_ptr_proto;
 	case BPF_FUNC_bpf_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
+	case BPF_FUNC_sock_from_file:
+		return &bpf_sock_from_file_proto;
 	default:
 		return NULL;
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 8b829748d488..867ada23281c 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -437,6 +437,8 @@ class PrinterHelpers(Printer):
             'struct path',
             'struct btf_ptr',
             'struct inode',
+            'struct socket',
+            'struct file',
     ]
     known_types = {
             '...',
@@ -482,6 +484,8 @@ class PrinterHelpers(Printer):
             'struct path',
             'struct btf_ptr',
             'struct inode',
+            'struct socket',
+            'struct file',
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c3458ec1f30a..a92b2b7d331b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3817,6 +3817,14 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * struct socket *bpf_sock_from_file(struct file *file)
+ *	Description
+ *		If the given file represents a socket, returns the associated
+ *		socket.
+ *	Return
+ *		A pointer to a struct socket on success or NULL if the file is
+ *		not a socket.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3981,6 +3989,7 @@ union bpf_attr {
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
 	FN(ima_inode_hash),		\
+	FN(sock_from_file),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.29.2.454.gaff20da3a2-goog

