Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D22B0ED5
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 21:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKLUKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 15:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgKLUKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 15:10:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6972BC0613D4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:10:09 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b6so7355466wrt.4
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y94nwo1CEggXD4knbaMbqIkUnYdaP7pApPBKsxsL/8U=;
        b=ctMlC2wcU5DQ1hCfy3zQObIY743O1hB6k3yheXjapLwE3074ggej2sU/Pg7B3yVv8V
         8CvceXjn5sQ8lx1kDb1Hqtxd0azQf2J6E12jPzEchymNcLT2o+wvmTGDpxiRlf0Wy3uF
         FxGNLgnOXfuTCk5s4n8tYG/ND11qxSr5RcVZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y94nwo1CEggXD4knbaMbqIkUnYdaP7pApPBKsxsL/8U=;
        b=XM2nzD0UAME14byCcgcVG8ZH/9CeJKdx/ed+s+xkaqhBGyZoQZUQSUvZyPIlwqE7sc
         EmQ0MVej/RoZo8k3Anayalra+u9zRAFiy1LTrxAlO4/+qffj2xO3P3mKdr+5h0BOCvpF
         lwiybabCRflO6VPv42PvIgXLTXg+FDQoQb52infm8gJB1GO5zHzntyn2E4CnoNXMtAfJ
         jnJ5M/QnjS+qsDqjSSdmsHa/b0O+YNElSIfFpe7csyhg48VVVBwyDrhm5gpRYtEt+3xZ
         +QHKSp7lLSfLJKE7h9rK4k9kK7Ppq4DFlc9KMoPKcOdu3RX7yUSIOFSRt9jz5JbDXi9w
         UA9Q==
X-Gm-Message-State: AOAM533/EaswAdEI9wQpJ6Bw+sdYu6nkGnDZCXo7E9yM5FSfb5FbCfnH
        EgFpy8hNbwdc1l/Yv4BVv5r1cQHEchY+KZ9L
X-Google-Smtp-Source: ABdhPJzfpLBsthkujmLfBJyhImkhpL1qzj+rdg96IvKaJnWitJXj1nf7M17nWUh1U2Ku2jXjbpWNpQ==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr1461329wrv.306.1605211807921;
        Thu, 12 Nov 2020 12:10:07 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id g138sm7767970wme.39.2020.11.12.12.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:10:07 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@google.com>
Subject: [PATCH] bpf: Expose a bpf_sock_from_file helper to tracing programs
Date:   Thu, 12 Nov 2020 21:09:44 +0100
Message-Id: <20201112200944.2726451-1-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Florent Revest <revest@google.com>

eBPF programs can already check whether a file is a socket using
file->f_op == &socket_file_ops but they can not convert file->private_data
into a struct socket with BTF information. For that, we need a new
helper that is essentially just a wrapper for sock_from_file.

sock_from_file can set an err value but this is only set to -ENOTSOCK
when the return value is NULL so it's useless superfluous information.

Signed-off-by: Florent Revest <revest@google.com>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/trace/bpf_trace.c       | 22 ++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  4 ++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 4 files changed, 40 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 162999b12790..6c96bf9c1f94 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3787,6 +3787,12 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * struct socket *bpf_sock_from_file(struct file *file)
+ *	Description
+ *		If the given file contains a socket, returns the associated socket.
+ *	Return
+ *		A pointer to a struct socket on success, or NULL on failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3954,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(sock_from_file),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3530120fa280..d040d3ec8313 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1255,6 +1255,26 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_1(bpf_sock_from_file, struct file *, file)
+{
+	int err;
+
+	return (unsigned long) sock_from_file(file, &err);
+}
+
+BTF_ID_LIST(bpf_sock_from_file_btf_ids)
+BTF_ID(struct, socket)
+BTF_ID(struct, file)
+
+const struct bpf_func_proto bpf_sock_from_file_proto = {
+	.func		= bpf_sock_from_file,
+	.gpl_only	= true,
+	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id	= &bpf_sock_from_file_btf_ids[0],
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_sock_from_file_btf_ids[1],
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1349,6 +1369,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_per_cpu_ptr_proto;
 	case BPF_FUNC_bpf_this_cpu_ptr:
 		return &bpf_this_cpu_ptr_proto;
+	case BPF_FUNC_sock_from_file:
+		return &bpf_sock_from_file_proto;
 	default:
 		return NULL;
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 6769caae142f..99068ec40315 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -434,6 +434,8 @@ class PrinterHelpers(Printer):
             'struct xdp_md',
             'struct path',
             'struct btf_ptr',
+            'struct socket',
+            'struct file',
     ]
     known_types = {
             '...',
@@ -477,6 +479,8 @@ class PrinterHelpers(Printer):
             'struct task_struct',
             'struct path',
             'struct btf_ptr',
+            'struct socket',
+            'struct file',
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 162999b12790..6c96bf9c1f94 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3787,6 +3787,12 @@ union bpf_attr {
  *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
  *	Return
  *		Pointer to the current task.
+ *
+ * struct socket *bpf_sock_from_file(struct file *file)
+ *	Description
+ *		If the given file contains a socket, returns the associated socket.
+ *	Return
+ *		A pointer to a struct socket on success, or NULL on failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3948,6 +3954,7 @@ union bpf_attr {
 	FN(task_storage_get),		\
 	FN(task_storage_delete),	\
 	FN(get_current_task_btf),	\
+	FN(sock_from_file),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.29.2.222.g5d2a92d10f8-goog

