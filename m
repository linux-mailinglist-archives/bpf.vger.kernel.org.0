Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B17E2CC878
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 21:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbgLBU5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 15:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbgLBU5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 15:57:22 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF97C061A48
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 12:55:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id g185so19586wmf.3
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBLkMiU4AZr9DwvoaSu135Em+YugoC0ZruXr4QELs2A=;
        b=D3ytxhWURoBLOcrPs01AcRP2MBQHAj13BuK6bhz7hq0aJ1F3H8cYE/xv4dwQPLYibT
         z65SEy/wNI7SZo81yB8WgzDrWtW6/x8v6Cm/z/dtjOViUHnNv2SbAkww1ABrdel8UNdB
         tYr6wLp81a18046X60ZY99hcTx0DBMRgddwEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBLkMiU4AZr9DwvoaSu135Em+YugoC0ZruXr4QELs2A=;
        b=euekbWzyFeyrgJZlYtduF0XyO9Yv/s7vqXHUopM0KE9O9oSWL/IuPYzcfIYsUsKKLv
         J2pcRiCXRJFOVchEP7YM40wif3DjAScVXCUdxDUVEFu7B6irPpnKNlnEOtK7Ral6uRDH
         snRg0CbxszKFyurY15Q/Jl1nB9BG+kPAIrRfoGJhoG3eX1qXrWS8ZeSOvOlU7iC4QFNv
         nZ3f074XJY/bewt4rXnr+U2fpDFXnIiwOeKUlMtX4px3h/bYgBEoXRAU7nsCvfI+KQqR
         DYeuYqdWAygloYVGiagBQSmCEt2OM7lHdACj9bhUwvDn7KzOQMVDRBm69VIG3k/L42Bs
         7sUg==
X-Gm-Message-State: AOAM530YgWXtIGt/oyJOH2m9pAh08/vNWorwuHNPbhP22x6xN4usufoY
        AjBiVLHa8J6NF4VMdTZNnA/KRH/mAwUnaQ==
X-Google-Smtp-Source: ABdhPJydrQVZlqkWizDOX8et5w2HvknX2u6+CbnZ3VxXdXitOusfR8o4B7XRHu7merd3kioDhhcpsg==
X-Received: by 2002:a1c:a5d4:: with SMTP id o203mr4952501wme.41.1606942550444;
        Wed, 02 Dec 2020 12:55:50 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id d2sm3438486wrn.43.2020.12.02.12.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:55:49 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
X-Google-Original-From: Florent Revest <revest@google.com>
To:     bpf@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, revest@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        KP Singh <kpsingh@google.com>
Subject: [PATCH bpf-next v4 2/6] bpf: Add a bpf_sock_from_file helper
Date:   Wed,  2 Dec 2020 21:55:23 +0100
Message-Id: <20201202205527.984965-2-revest@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202205527.984965-1-revest@google.com>
References: <20201202205527.984965-1-revest@google.com>
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

