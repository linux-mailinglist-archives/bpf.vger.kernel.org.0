Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4C621F24
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKHWW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKHWWA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:22:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28263162
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:20:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8776179A
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 22:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DCBC433C1;
        Tue,  8 Nov 2022 22:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667946053;
        bh=xs1hLTfGmmUq+T4+FviU/LlW8MyjEF+gz+UkhDuqqao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0hwFV/QQP979pyS6a+NCrov0s8QXFzYp9eblVZmJLAlqRClrNjiHYPFU8WQ1EXR+
         1/4vCnAKj1EIGY7jTzEBvt0NWvRkjNp1iNO4zoNueQ0iFrOG9+i3bgz7XCi+MbzZ9N
         lRzP6ontmkQtCG0MvIbktkGt0OznLv1yngFI7D8bS/qcICrp4JWG9I1lIEuMQ8PJa7
         QhlbwZ2OgaWWUrFUbplft9Tx7I6qxWv24ydR2UAyBpgvKRC4WUTz6kPHVOSzUvrMN/
         9O+cMxTnzuYVjH40aAYkh+sANt14YZSJPLip4mOAqA+ZAvObcu/MHktzu1I+ElNR2F
         bq5O4Rq4xj1rw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 2/3] bpf: Add bpf_vma_build_id_parse helper
Date:   Tue,  8 Nov 2022 23:20:26 +0100
Message-Id: <20221108222027.3409437-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108222027.3409437-1-jolsa@kernel.org>
References: <20221108222027.3409437-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_vma_build_id_parse helper that parses build ID of ELF file
mapped vma struct passed as an argument.

I originally wanted to add this as kfunc, but we need to be sure the
receiving buffer is big enough and we can't check for that on kfunc
side.

The use case for this helper is to provide the build id for executed
binaries on kernel side, when the monitoring user side does not have
access to the actual binaries.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  9 +++++++++
 kernel/trace/bpf_trace.c       | 22 ++++++++++++++++++++++
 scripts/bpf_doc.py             |  2 ++
 tools/include/uapi/linux/bpf.h |  9 +++++++++
 4 files changed, 42 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 94659f6b3395..00559c40617e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5481,6 +5481,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_vma_build_id_parse(struct vm_area_struct *vma, char *build_id)
+ *	Description
+ *		Parse build ID of ELF file mapped to @vma.
+ *
+ *	Return
+ *		Size of parsed build id on success.
+ *		Negative errno in case of failure.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5695,6 +5703,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(vma_build_id_parse, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2d8d070d024..b52d0f1b3c7a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/key.h>
 #include <linux/verification.h>
+#include <linux/buildid.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1205,6 +1206,25 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_2(vma_build_id_parse, struct vm_area_struct *, vma, char *, build_id)
+{
+	__u32 size;
+	int err;
+
+	err = build_id_parse(vma, build_id, &size);
+	return err < 0 ? (long) err : (long) size;
+}
+
+static const struct bpf_func_proto bpf_vma_build_id_parse_proto = {
+	.func		= vma_build_id_parse,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_VMA],
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM,
+	.arg2_size	= BUILD_ID_SIZE_MAX,
+};
+
 #ifdef CONFIG_KEYS
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
@@ -1953,6 +1973,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
 	case BPF_FUNC_get_attach_cookie:
 		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto_tracing : NULL;
+	case BPF_FUNC_vma_build_id_parse:
+		return &bpf_vma_build_id_parse_proto;
 	default:
 		fn = raw_tp_prog_func_proto(func_id, prog);
 		if (!fn && prog->expected_attach_type == BPF_TRACE_ITER)
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index fdb0aff8cb5a..a55c3d0327db 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -700,6 +700,7 @@ class PrinterHelpers(Printer):
             'struct bpf_dynptr',
             'struct iphdr',
             'struct ipv6hdr',
+            'struct vm_area_struct',
     ]
     known_types = {
             '...',
@@ -754,6 +755,7 @@ class PrinterHelpers(Printer):
             'struct bpf_dynptr',
             'struct iphdr',
             'struct ipv6hdr',
+            'struct vm_area_struct',
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 94659f6b3395..00559c40617e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5481,6 +5481,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_vma_build_id_parse(struct vm_area_struct *vma, char *build_id)
+ *	Description
+ *		Parse build ID of ELF file mapped to @vma.
+ *
+ *	Return
+ *		Size of parsed build id on success.
+ *		Negative errno in case of failure.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5695,6 +5703,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(vma_build_id_parse, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.38.1

