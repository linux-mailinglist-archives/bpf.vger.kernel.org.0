Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D42BAAF1
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 14:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgKTNRP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 08:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgKTNRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 08:17:15 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69532C061A48
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 05:17:13 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 1so9779119wme.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kcXVWXPxoLKih6EtdFRtl2N21qH/p1/6u4SC99t+On8=;
        b=d64b+CWLC9dd2UR9cP7cGgIkvtHwVlwtPcgshP7H3YBR3mfTayvFqZj6OUBgjcR+/D
         Bpm6Jn5NFW1pEkT0XNWlVEopRlcyIYzk8XK6AgugHYhgEnIcbhoeYI55F5PmxDY73kgQ
         fZ9SauyaqxHBc8/ok/wpYVuMyx3rfNyq3ylyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kcXVWXPxoLKih6EtdFRtl2N21qH/p1/6u4SC99t+On8=;
        b=hvAlKYfCqcBziH9mSCnbDCMlbBJScG+wJnbog+qh6vB+Xl+JioFeGz9c72mDBkjvSG
         dFzflAeRk6w9A2YG/EZR22RIDwl22ci0YIeHJxGC0Xv7qIXBhDMRPRn57CuskPhLaV/A
         C8wOZkcwo7VbxzSzJizb8TLwStOgfM404ZEWRD6AZse1cf4WZQ0kpELPWhukYIVuANlF
         8FeqqUi1RYAoig6YVguemau1B+d3WOsqbFqnyedC+cH3P/QWW9y0AHut78iiGB7TEsyQ
         H1YcuCSZUxlzGHq7TJl1AYHOFSQpskKooGaydHDZI1gaOyMNb1P63hk+uSonoh1NHP5L
         7xYw==
X-Gm-Message-State: AOAM531wGKDzos+PcioW0B0+VkDi51iBjlu4BJC4iwzmhII9ZdwgQE+p
        yc6X/pwLc403UGQusoJkAHwJTA==
X-Google-Smtp-Source: ABdhPJygynZo+wiqSSmRj0zeAT8u4UVO6uobDEBWToYjLGR4EHpLdKr7WO7f55wFrIBQAF7BeFXK9w==
X-Received: by 2002:a1c:44f:: with SMTP id 76mr10120516wme.181.1605878232016;
        Fri, 20 Nov 2020 05:17:12 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id u203sm4260197wme.32.2020.11.20.05.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 05:17:11 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] bpf: Add a BPF helper for getting the IMA hash of an inode
Date:   Fri, 20 Nov 2020 13:17:07 +0000
Message-Id: <20201120131708.3237864-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120131708.3237864-1-kpsingh@chromium.org>
References: <20201120131708.3237864-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Provide a wrapper function to get the IMA hash of an inode. This helper
is useful in fingerprinting files (e.g executables on execution) and
using these fingerprints in detections like an executable unlinking
itself.

Since the ima_inode_hash can sleep, it's only allowed for sleepable
LSM hooks.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/uapi/linux/bpf.h       | 11 +++++++++++
 kernel/bpf/bpf_lsm.c           | 26 ++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  1 +
 tools/include/uapi/linux/bpf.h | 11 +++++++++++
 4 files changed, 49 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3ca6146f001a..dd5b8622bb89 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3807,6 +3807,16 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ *
+ * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
+ *	Description
+ *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		If the hash is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *	Return
+ *		The **hash_algo** of is returned on success,
+ *		**-EOPNOTSUP** if IMA is disabled and **-EINVAL** if
+ *		invalid arguments are passed.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3970,6 +3980,7 @@ union bpf_attr {
 	FN(get_current_task_btf),	\
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
+	FN(ima_inode_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index b4f27a874092..51c36f61339e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -15,6 +15,7 @@
 #include <net/bpf_sk_storage.h>
 #include <linux/bpf_local_storage.h>
 #include <linux/btf_ids.h>
+#include <linux/ima.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
  * function where a BPF program can be attached.
@@ -75,6 +76,29 @@ const static struct bpf_func_proto bpf_bprm_opts_set_proto = {
 	.arg2_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_3(bpf_ima_inode_hash, struct inode *, inode, void *, dst, u32, size)
+{
+	return ima_inode_hash(inode, dst, size);
+}
+
+static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
+{
+	return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
+}
+
+BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
+
+const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
+	.func		= bpf_ima_inode_hash,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &bpf_ima_inode_hash_btf_ids[0],
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.allowed	= bpf_ima_inode_hash_allowed,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_bprm_opts_set:
 		return &bpf_bprm_opts_set_proto;
+	case BPF_FUNC_ima_inode_hash:
+		return &bpf_ima_inode_hash_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index add7fcb32dcd..cb16687acb66 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -430,6 +430,7 @@ class PrinterHelpers(Printer):
             'struct tcp_request_sock',
             'struct udp6_sock',
             'struct task_struct',
+            'struct inode',
 
             'struct __sk_buff',
             'struct sk_msg_md',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3ca6146f001a..dd5b8622bb89 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3807,6 +3807,16 @@ union bpf_attr {
  * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
  * 	Return
  * 		Current *ktime*.
+ *
+ * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
+ *	Description
+ *		Returns the stored IMA hash of the *inode* (if it's avaialable).
+ *		If the hash is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *	Return
+ *		The **hash_algo** of is returned on success,
+ *		**-EOPNOTSUP** if IMA is disabled and **-EINVAL** if
+ *		invalid arguments are passed.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3970,6 +3980,7 @@ union bpf_attr {
 	FN(get_current_task_btf),	\
 	FN(bprm_opts_set),		\
 	FN(ktime_get_coarse_ns),	\
+	FN(ima_inode_hash),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.29.2.454.gaff20da3a2-goog

