Return-Path: <bpf+bounces-3012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188DF738287
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0551C20DF5
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59464156F4;
	Wed, 21 Jun 2023 12:01:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB57101C5
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 12:01:04 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B792DE
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:01:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668709767b1so2566583b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687348859; x=1689940859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDQnw74ve3MTgkClD5cbfA1Ek2xMpIY+rJY9np9fNE4=;
        b=pHeos/GLJP9LFoqPji9s81ttDB6S7XN3cfxwWCa1HKAxqc5s+imAzlP4j/mgSOcdqj
         v8eryFJM8q2kafoSxuWvfZDIkDBiqB1aYNLuvPwZ7A54mecCRpBsWqKsUOapqjbQplNI
         t4GWnnfNJox0dMweJVhCe0Ib2cpn+RjOZA84L9F96nGyp3iTzgQtmGvLH+Qm7FNkV0z0
         gh+6URkpD4OTuSEDFjT0g2P/TimEzQ7Kq7q6HSPaBlPPohiUWBLyy3kw3bu3LRFPjeja
         4dzVQa35d49QPAV/DA6c+kEa1WHI2gU/A0ttPRyLRce50IVzf2s1Xdgx4h7IwkrnyLw8
         PVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348859; x=1689940859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDQnw74ve3MTgkClD5cbfA1Ek2xMpIY+rJY9np9fNE4=;
        b=K50vmS7dGddzPECPfmvsduuK3FFSRsTzZy3hNP3dD99mL/coh7PtZz9tepBKzaRsNQ
         0F8lBZdRLXCCBFWyuRRk1g0ePnn4hMz68Rgp+g22DtUGtoFB0A9mDb8iKcLD9X9S+kq8
         fhKiK8fcJ7N8Z3l0Mh+jLa4/6SyYt60bdyD7tzjV9k0ndHKC1TlWdiHEsAXWzr56PzKj
         yPzTX23+NkZkVV5AR2YjaP7Z6d6FgKebz44F7MMsfswSF5E6xIwsdyZJid8cbpN+AgkB
         fPPSL8oTp7kfkswrDcnhzF6MY2tWMeySoEqX8Tl6tpn9mpiJQPyyXoIPnOkID3UPUtKh
         50wQ==
X-Gm-Message-State: AC+VfDxiGfABHLmFYnZkhYYKXxfUSNQQiW1oykK4IzWmWwQ/avtJx2JL
	939cJa4xWLCYCJKeAtFa6/slA5Zz/yXsRGEEsTY=
X-Google-Smtp-Source: ACHHUZ4+R7oTQSjmdKkYee2dtCWE+Dl3r893A02TwmJlo3LJLpqaS3cCA3OmfSh2IFVbL6qAbRdTGQ==
X-Received: by 2002:a05:6a00:168d:b0:64d:3e99:83a5 with SMTP id k13-20020a056a00168d00b0064d3e9983a5mr16553193pfc.26.1687348859408;
        Wed, 21 Jun 2023 05:00:59 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:32e:5400:4ff:fe7b:7461])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0066887dc50easm2810620pfi.3.2023.06.21.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:00:58 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next] bpf: Add two new bpf helpers bpf_perf_type_[uk]probe()
Date: Wed, 21 Jun 2023 12:00:42 +0000
Message-Id: <20230621120042.3903-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230621120042.3903-1-laoar.shao@gmail.com>
References: <20230621120042.3903-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are utilizing BPF LSM to monitor BPF operations within our container
environment. Our goal is to examine the program type and perform the 
respective audits in our LSM program.

When it comes to the perf_event BPF program, there are no specific
definitions for the perf types of kprobe or uprobe. In other words, there
is no PERF_TYPE_[UK]PROBE. It appears that defining them as UAPI at this
stage would be impractical.

Therefore, if we wish to determine whether a new BPF program created via 
perf_event_open() is a kprobe or an uprobe, we need to retrieve the type in
userspace by reading /sys/bus/event_source/devices/[uk]probe/type and 
subsequently store it in global variables within the LSM program. This
approach proves to be inconvenient.

Two new BPF helpers have been introduced to enhance the functionality.
These helpers allow us to directly obtain the perf type of a kprobe or
uprobe within a BPF program.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h            |  2 ++
 include/uapi/linux/bpf.h       | 18 ++++++++++++++++++
 kernel/bpf/core.c              |  2 ++
 kernel/bpf/helpers.c           | 23 +++++++++++++++++++++++
 kernel/trace/bpf_trace.c       |  4 ++++
 tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++++
 6 files changed, 67 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f588958..27135d1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2909,6 +2909,8 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_perf_type_kprobe_proto;
+extern const struct bpf_func_proto bpf_perf_type_uprobe_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91..1ddb1dc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5572,6 +5572,22 @@ struct bpf_stack_build_id {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_perf_type_kprobe(void)
+ *	Description
+ *		Get perf_kprobe.type
+ *	Return
+ *		perf_kprobe.type on success.
+ *
+ *		**-EOPNOTSUPP** if CONFIG_KPROBE_EVENTS is not set.
+ *
+ * int bpf_perf_type_uprobe(void)
+ *	Description
+ *		Get perf_uprobe.type
+ *	Return
+ *		perf_uprobe.type on success.
+ *
+ *		**-EOPNOTSUPP** if CONFIG_UPROBE_EVENTS is not set.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5786,6 +5802,8 @@ struct bpf_stack_build_id {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(perf_type_kprobe, 212, ##ctx)		\
+	FN(perf_type_uprobe, 213, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 599136c..ab5fc7e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2666,6 +2666,8 @@ void bpf_user_rnd_init_once(void)
 const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
 const struct bpf_func_proto bpf_set_retval_proto __weak;
 const struct bpf_func_proto bpf_get_retval_proto __weak;
+const struct bpf_func_proto bpf_perf_type_kprobe__weak;
+const struct bpf_func_proto bpf_perf_type_uprobe__weak;
 
 const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e80efa..f139fe3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
+#include <linux/perf_event.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1654,6 +1655,28 @@ static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offse
 	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
 
+BPF_CALL_0(bpf_perf_type_kprobe)
+{
+	return perf_type_kprobe();
+}
+
+const struct bpf_func_proto bpf_perf_type_kprobe_proto = {
+	.func		= bpf_perf_type_kprobe,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+BPF_CALL_0(bpf_perf_type_uprobe)
+{
+	return perf_type_uprobe();
+}
+
+const struct bpf_func_proto bpf_perf_type_uprobe_proto = {
+	.func		= bpf_perf_type_uprobe,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6..59c66ad 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1510,6 +1510,10 @@ static int __init bpf_key_sig_kfuncs_init(void)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_perf_type_kprobe:
+		return &bpf_perf_type_kprobe_proto;
+	case BPF_FUNC_perf_type_uprobe:
+		return &bpf_perf_type_uprobe_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7b5e91..1ddb1dc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5572,6 +5572,22 @@ struct bpf_stack_build_id {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * int bpf_perf_type_kprobe(void)
+ *	Description
+ *		Get perf_kprobe.type
+ *	Return
+ *		perf_kprobe.type on success.
+ *
+ *		**-EOPNOTSUPP** if CONFIG_KPROBE_EVENTS is not set.
+ *
+ * int bpf_perf_type_uprobe(void)
+ *	Description
+ *		Get perf_uprobe.type
+ *	Return
+ *		perf_uprobe.type on success.
+ *
+ *		**-EOPNOTSUPP** if CONFIG_UPROBE_EVENTS is not set.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5786,6 +5802,8 @@ struct bpf_stack_build_id {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(perf_type_kprobe, 212, ##ctx)		\
+	FN(perf_type_uprobe, 213, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
1.8.3.1


