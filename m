Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CE525302
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 18:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356698AbiELQvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356603AbiELQvA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 12:51:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F72C656
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 09:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F87B62039
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 16:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFE4C34100;
        Thu, 12 May 2022 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374257;
        bh=AwmiJirMonAA/HfePONtmelH7hPCWd5wpPfVSD/ItSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOBo2r6RFIgw5l7XDa37GNQcNUNN84OK8YXPiwLjCImV1nUgzuTATmznuuZ+O0kL4
         OsnoiombX6rwSfUjJuz7w+/AOrnEsAfhLGXrkCstGvK+Za/DFOK3cC0CxUrUj5dZ5G
         yl6kk7c9f0aX4kWPalYU+ewSRHayacEg+5nOj85Pp5VMCFVzUqdubVt909GicJcB/2
         Q+FQEi0oCHzzj/BOnKRFQARiSxEOyWDZRRgoQxZS0B8NXmvHy8UjmrZdLYfw6x1MZy
         brwgF942KhjN76QhXBjD1J4euD6vpMS2j+zM0TGycPYXbPpd8P4n2xshkKauBrl/EE
         51ps2pL3YhQkA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Implement bpf_getxattr helper
Date:   Thu, 12 May 2022 16:50:50 +0000
Message-Id: <20220512165051.224772-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512165051.224772-1-kpsingh@kernel.org>
References: <20220512165051.224772-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LSMs like SELinux store security state in xattrs. bpf_getxattr enables
BPF LSM to implement similar functionality. In combination with
bpf_local_storage, xattrs can be used to develop more complex security
policies.

This helper wraps around vfs_getxattr which can sleep and is, therefore,
limited to sleepable programs.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/uapi/linux/bpf.h       |  8 ++++++++
 kernel/trace/bpf_trace.c       | 26 ++++++++++++++++++++++++++
 scripts/bpf_doc.py             |  5 +++++
 tools/include/uapi/linux/bpf.h |  8 ++++++++
 4 files changed, 47 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0210f85131b3..ebd361c2e351 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5172,6 +5172,13 @@ union bpf_attr {
  * 	Return
  * 		Map value associated to *key* on *cpu*, or **NULL** if no entry
  * 		was found or *cpu* is invalid.
+ *
+ * long bpf_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry, const char *name, void *value, u64 value_size)
+ *	Description
+ *		Get the *value* of the xattr with the given *name*
+ *		where *value_size* is the size of the *value* buffer.
+ *	Return
+ *		The number of bytes copied into *value*.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5370,6 +5377,7 @@ union bpf_attr {
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
 	FN(map_lookup_percpu_elem),     \
+	FN(getxattr),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7141ca8a1c2d..185adbb9b1b6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,7 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/xattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1181,6 +1182,29 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_5(bpf_getxattr, struct user_namespace *, mnt_userns, struct dentry *,
+	   dentry, void *, name, void *, value, size_t, value_size)
+{
+	return vfs_getxattr(mnt_userns, dentry, name, value, value_size);
+}
+
+BTF_ID_LIST(bpf_getxattr_btf_ids)
+BTF_ID(struct, user_namespace)
+BTF_ID(struct, dentry)
+
+static const struct bpf_func_proto bpf_getxattr_proto = {
+	.func = bpf_getxattr,
+	.gpl_only = false,
+	.ret_type = RET_INTEGER,
+	.arg1_type = ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id = &bpf_getxattr_btf_ids[0],
+	.arg2_type = ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id = &bpf_getxattr_btf_ids[1],
+	.arg3_type = ARG_PTR_TO_CONST_STR,
+	.arg4_type = ARG_PTR_TO_UNINIT_MEM,
+	.arg5_type = ARG_CONST_SIZE,
+};
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1304,6 +1328,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_getxattr:
+		return prog->aux->sleepable ? &bpf_getxattr_proto : NULL;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 096625242475..be601c75c96c 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -633,6 +633,8 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct user_namespace',
+            'struct dentry',
     ]
     known_types = {
             '...',
@@ -682,6 +684,9 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct user_namespace',
+            'struct dentry',
+
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0210f85131b3..ebd361c2e351 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5172,6 +5172,13 @@ union bpf_attr {
  * 	Return
  * 		Map value associated to *key* on *cpu*, or **NULL** if no entry
  * 		was found or *cpu* is invalid.
+ *
+ * long bpf_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry, const char *name, void *value, u64 value_size)
+ *	Description
+ *		Get the *value* of the xattr with the given *name*
+ *		where *value_size* is the size of the *value* buffer.
+ *	Return
+ *		The number of bytes copied into *value*.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5370,6 +5377,7 @@ union bpf_attr {
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
 	FN(map_lookup_percpu_elem),     \
+	FN(getxattr),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.36.0.550.gb090851708-goog

