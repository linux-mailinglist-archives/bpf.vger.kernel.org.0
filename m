Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0296C936C
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjCZJW3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjCZJWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:25 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9C9740;
        Sun, 26 Mar 2023 02:22:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id hf2so5878003qtb.3;
        Sun, 26 Mar 2023 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IttOk0+8XCKRMkImj0Us7L6S+8JkbptYujvUdCdqNsM=;
        b=oFXEPzd8QweT0zM+KjuIeU9h8UCXV3/G5mEHY2UeKsFbQI9jhWfABcjlcjJP79D5R0
         BrYviuHlEmow2FWQv2UI09K958ibw7WP/cT4i6cWTSok4yz3gG1PujG66GMT34EmoNk1
         4Pl/y4hbHOjkwNA0DVjbbVSKRYmQJq0dPvp9cYNWIwxy3bHSSrewTn3muC09lf5pdPeQ
         of3RgXmUdfkXleoPA5a8XtV5VdG7VAiup0dGZqSRezLf4v4dNARza+2ciiMOQ10MMy0V
         lRfEJq1z5+5g5LxwqZhHWQbgSduSqp6OzEAr7qcST9lI3JyqsiBM2DGVGU3Q0jv/gA/Q
         AGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IttOk0+8XCKRMkImj0Us7L6S+8JkbptYujvUdCdqNsM=;
        b=hoOrgcng4Y/JihUyBcgGbQAOZVl5PeOlf0gjYqS84eUeKsb+m39w7oTLCNkEU9NNbE
         SwM3vmzc+H2XU22XUZefe1Rnrr3lN5SF7LLaJi/cqOtiRl7f0DW559LYs9PorRv+Gro6
         O5g7r09MPVDG/L7eELJVxnBOu7xLMFDvh28TUab6ag6n24SU+mJjM9r5GOtzQImaGfPX
         fiQJSE2lxcIQ9BaJXRQREGRiKfL9BNT9pHHhK4lHEefDUzc2xFY986dlVaAkQDGzM7fg
         kpImEu+QjBDoW9ClnRhW7qXe4sTOqulaHKN0VcxB15EZtx3gf7kBYdnxnnyiWWneDfUr
         fv+g==
X-Gm-Message-State: AO0yUKWRbEDdW0EbVDgM01JO95VGI9L5Vxipj4x6BsN8kx9XnOOD6NeN
        XUY1SHY8EYh3uvhbkSn/lbI4718pgwlg6eWnp5k=
X-Google-Smtp-Source: AKy350aa/Cf7JCR/SBYjM6YZ/WRcM384g/nWCSMOKsCI60gnucp+fweeRUq9R95F0hO6UD7nmmFzmg==
X-Received: by 2002:a05:622a:214:b0:3e3:902a:a084 with SMTP id b20-20020a05622a021400b003e3902aa084mr14239455qtx.6.1679822543297;
        Sun, 26 Mar 2023 02:22:23 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:22 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 07/13] bpf: Add bpf helper to get bpf object id
Date:   Sun, 26 Mar 2023 09:22:02 +0000
Message-Id: <20230326092208.13613-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new bpf helper is introduced to get bpf object id in a tracing bpf
prog.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/task_iter.c         | 12 ++++++++++++
 kernel/trace/bpf_trace.c       |  2 ++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 5 files changed, 29 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2d8f3f6..c94034a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2867,6 +2867,7 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_find_obj_id_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e3d3b51..3009877 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5540,6 +5540,12 @@ struct bpf_stack_build_id {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_find_obj_id(void *obj_id)
+ *	Description
+ *		Get bpf object id in current bpf namespace.
+ *	Return
+ *		bpf object id is returned on success.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5754,6 +5760,7 @@ struct bpf_stack_build_id {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(find_obj_id, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6..a551743 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -8,6 +8,7 @@
 #include <linux/fdtable.h>
 #include <linux/filter.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_namespace.h>
 #include "mmap_unlock_work.h"
 
 static const char * const iter_task_type_names[] = {
@@ -823,6 +824,17 @@ static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *aux, struc
 	.arg5_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_1(bpf_find_obj_id, void *, obj_id)
+{
+	return bpf_obj_id_vnr(obj_id);
+}
+
+const struct bpf_func_proto bpf_find_obj_id_proto = {
+	.func		= bpf_find_obj_id,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bcf91bc..977bb61 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1510,6 +1510,8 @@ static int __init bpf_key_sig_kfuncs_init(void)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_find_obj_id:
+		return &bpf_find_obj_id_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d6c5a02..8beacad 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5540,6 +5540,12 @@ struct bpf_stack_build_id {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_find_obj_id(void *obj_id)
+ *	Description
+ *		Get bpf object id in current bpf namespace.
+ *	Return
+ *		bpf object id is returned on success.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5754,6 +5760,7 @@ struct bpf_stack_build_id {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(find_obj_id, 212, ##ctx)				\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
1.8.3.1

