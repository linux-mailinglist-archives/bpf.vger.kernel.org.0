Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECD37EF32
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhELW7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346503AbhELVnu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:43:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C8FC08C5CA
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x188so19692467pfd.7
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFiaoGSVE/MXJGMzBbOSJu8xD0FLRvjcwuUH6ABF4QA=;
        b=s2nr71EEvbjghqS1mOt+/LxpLvg5ZZ+1tiRy3HuvS5EMFzX7aVORsTLgBjzEHO46EZ
         9tQHWeyAvhs2gFpuJkJo9q5Oh5/RU6W4KTNWFmtU8zLxIHGTwI0TASnQ7PAofs9qm6W7
         4gQmripNusinl6udfZShpcRBhQarJWTT6DdxdHb1vom1x1RxpmlIziDriH0a/4Td62m8
         h+bHpbEbJ8Y2Z0OjhLDTi+BdMuVS1Rkg4A137X//AArjZNJ+ngdLsccfCPgSL9iONAk2
         61KkANUaoe9ctk8/NWN4FpfopcF3vwr4RL+7giahaV885/ckPTmHVP67B2YznpPpeVqz
         RqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFiaoGSVE/MXJGMzBbOSJu8xD0FLRvjcwuUH6ABF4QA=;
        b=CRUotJFZ6T1hW67/KvoSq5DIuSjOtuaTyARllMNveID5TfGfOf05W8hN6rDH7SDa75
         q3Q/RGZhbSI5e66QwWFodW6mngD517cOk37K+lu/lI+OUE5ef9sKm60LjDibhXgyXpTe
         LNs+kEf2W2F9NwHkPOEdF6B+j/8C9zifWbMNtjykOQwM3RwZ+XIDhAPe9/FrNLjc6gQy
         5hCmrHskD/thEAzW3PELlCry9dIzqrT+G4wrAWofN1EQwB7FiIu5NvVemVsXd0xaFGHP
         XY9skZRYRRmR75tNQYR1pQQ5/6vdTv/tyVv3e1mPVv8/cvugAzSmtm5QCbuZ5hF75Tgp
         DfIQ==
X-Gm-Message-State: AOAM533FSeu9HgjcydGjup3U2+iw4wUFjmI0F/KL2AosJsao0IbDWZnF
        2eldfrCtYkwxIr0bmXLLeMw=
X-Google-Smtp-Source: ABdhPJz53zvWY2BIxWo+8HmanHaEmqXe/y3mPpyXnYqLE8cAcb3w32qVZc5P9y1n6VCTNOnl8rd04w==
X-Received: by 2002:a17:90a:f48c:: with SMTP id bx12mr41477461pjb.215.1620855197144;
        Wed, 12 May 2021 14:33:17 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:16 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 09/21] bpf: Add bpf_btf_find_by_name_kind() helper.
Date:   Wed, 12 May 2021 14:32:44 -0700
Message-Id: <20210512213256.31203-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add new helper:
long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
Description
	Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
Return
	Returns btf_id and btf_obj_fd in lower and upper 32 bits.

It will be used by loader program to find btf_id to attach the program to
and to find btf_ids of ksyms.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 ++++
 kernel/bpf/btf.c               | 62 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  2 ++
 tools/include/uapi/linux/bpf.h |  7 ++++
 5 files changed, 79 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7fd53380c981..9dc44ba97584 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1974,6 +1974,7 @@ extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
+extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 
 const struct bpf_func_proto *bpf_tracing_func_proto(
 	enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index de58a714ed36..3cc07351c1cf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4748,6 +4748,12 @@ union bpf_attr {
  * 		Execute bpf syscall with given arguments.
  * 	Return
  * 		A syscall result.
+ *
+ * long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
+ * 	Description
+ * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
+ * 	Return
+ * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4917,6 +4923,7 @@ union bpf_attr {
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
 	FN(sys_bpf),			\
+	FN(btf_find_by_name_kind),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fbf6c06a9d62..85716327c375 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6085,3 +6085,65 @@ struct module *btf_try_get_module(const struct btf *btf)
 
 	return res;
 }
+
+BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
+{
+	struct btf *btf;
+	long ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (name_sz <= 1 || name[name_sz - 1])
+		return -EINVAL;
+
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	ret = btf_find_by_name_kind(btf, name, kind);
+	/* ret is never zero, since btf_find_by_name_kind returns
+	 * positive btf_id or negative error.
+	 */
+	if (ret < 0) {
+		struct btf *mod_btf;
+		int id;
+
+		/* If name is not found in vmlinux's BTF then search in module's BTFs */
+		spin_lock_bh(&btf_idr_lock);
+		idr_for_each_entry(&btf_idr, mod_btf, id) {
+			if (!btf_is_module(mod_btf))
+				continue;
+			/* linear search could be slow hence unlock/lock
+			 * the IDR to avoiding holding it for too long
+			 */
+			btf_get(mod_btf);
+			spin_unlock_bh(&btf_idr_lock);
+			ret = btf_find_by_name_kind(mod_btf, name, kind);
+			if (ret > 0) {
+				int btf_obj_fd;
+
+				btf_obj_fd = __btf_new_fd(mod_btf);
+				if (btf_obj_fd < 0) {
+					btf_put(mod_btf);
+					return btf_obj_fd;
+				}
+				return ret | (((u64)btf_obj_fd) << 32);
+			}
+			spin_lock_bh(&btf_idr_lock);
+			btf_put(mod_btf);
+		}
+		spin_unlock_bh(&btf_idr_lock);
+	}
+	return ret;
+}
+
+const struct bpf_func_proto bpf_btf_find_by_name_kind_proto = {
+	.func		= bpf_btf_find_by_name_kind,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_CONST_SIZE,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_ANYTHING,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index da7dc2406470..f93ff2ebf96d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4584,6 +4584,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
 		return &bpf_sys_bpf_proto;
+	case BPF_FUNC_btf_find_by_name_kind:
+		return &bpf_btf_find_by_name_kind_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index de58a714ed36..3cc07351c1cf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4748,6 +4748,12 @@ union bpf_attr {
  * 		Execute bpf syscall with given arguments.
  * 	Return
  * 		A syscall result.
+ *
+ * long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
+ * 	Description
+ * 		Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
+ * 	Return
+ * 		Returns btf_id and btf_obj_fd in lower and upper 32 bits.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4917,6 +4923,7 @@ union bpf_attr {
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
 	FN(sys_bpf),			\
+	FN(btf_find_by_name_kind),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

