Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0737B9D5
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELKAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 06:00:21 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:56631 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbhELKAU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 May 2021 06:00:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yunbo.xufeng@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UYdyiiS_1620813539;
Received: from localhost.localdomain(mailfrom:yunbo.xufeng@linux.alibaba.com fp:SMTPD_---0UYdyiiS_1620813539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 May 2021 17:59:06 +0800
From:   Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
To:     kpsingh@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     revest@chromium.org, jackmanb@chromium.org, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, john.fastabend@gmail.com,
        joe@cilium.io, quentin@isovalent.com,
        Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
Subject: [RFC] [PATCH bpf-next 1/1] bpf: Add a BPF helper for getting the cgroup path of current task
Date:   Wed, 12 May 2021 17:58:23 +0800
Message-Id: <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
References: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To implement security rules for application containers by utilizing
bpf LSM, the container to which the current running task belongs need
to be known in bpf context. Think about this scenario: kubernetes
schedules a pod into one host, before the application container can run,
the security rules for this application need to be loaded into bpf
maps firstly, so that LSM bpf programs can make decisions based on
this rule maps.

However, there is no effective bpf helper to achieve this goal,
especially for cgroup v1. In the above case, the only available information
from user side is container-id, and the cgroup path for this container
is certain based on container-id, so in order to make a bridge between
user side and bpf programs, bpf programs also need to know the current
cgroup path of running task.

This change add a new bpf helper: bpf_get_current_cpuset_cgroup_path(),
since cgroup_path_ns() can sleep, this helper is only allowed for
sleepable LSM hooks.

Signed-off-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
---
 include/uapi/linux/bpf.h       | 13 +++++++++++++
 kernel/bpf/bpf_lsm.c           | 28 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 13 +++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ec6d85a81744..e8295101b865 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4735,6 +4735,18 @@ union bpf_attr {
  *		be zero-terminated except when **str_size** is 0.
  *
  *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
+ *
+ * int bpf_get_current_cpuset_cgroup_path(char *buf, u32 buf_len)
+ *	Description
+ *		Get the cpuset cgroup path of current task from kernel memory,
+ *		this path can be used to identify in which container is the
+ *		current task running.
+ *		*buf* memory is pre-allocated, and *buf_len* indicates the size
+ *		of this memory.
+ *
+ *	Return
+ *		The cpuset cgroup path is copied into *buf* on success,
+ *		or a negative integer error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4903,6 +4915,7 @@ union bpf_attr {
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
+	FN(get_current_cpuset_cgroup_path),     \
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 5efb2b24012c..5e62e3875df1 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -99,6 +99,30 @@ static const struct bpf_func_proto bpf_ima_inode_hash_proto = {
 	.allowed	= bpf_ima_inode_hash_allowed,
 };
 
+#ifdef CONFIG_CGROUPS
+BPF_CALL_2(bpf_get_current_cpuset_cgroup_path, char *, buf, u32, buf_len)
+{
+	struct cgroup_subsys_state *css;
+	int retval;
+
+	css = task_get_css(current, cpuset_cgrp_id);
+	retval = cgroup_path_ns(css->cgroup, buf, buf_len, &init_cgroup_ns);
+	css_put(css);
+	if (retval >= buf_len)
+		retval = -ENAMETOOLONG;
+	return retval;
+}
+
+static const struct bpf_func_proto bpf_get_current_cpuset_cgroup_path_proto = {
+	.func           = bpf_get_current_cpuset_cgroup_path,
+	.gpl_only       = false,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type      = ARG_CONST_SIZE,
+	.allowed        = bpf_ima_inode_hash_allowed,
+};
+#endif
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -119,6 +143,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_bprm_opts_set_proto;
 	case BPF_FUNC_ima_inode_hash:
 		return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
+#ifdef CONFIG_CGROUPS
+	case BPF_FUNC_get_current_cpuset_cgroup_path:
+		return prog->aux->sleepable ? &bpf_get_current_cpuset_cgroup_path_proto : NULL;
+#endif
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ec6d85a81744..fe31252d92e3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4735,6 +4735,18 @@ union bpf_attr {
  *		be zero-terminated except when **str_size** is 0.
  *
  *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
+ *
+ * int bpf_get_current_cpuset_cgroup_path(char *buf, u32 buf_len)
+ *	Description
+ *		Get the cpuset cgroup path of current task from kernel memory,
+ *		this path can be used to identify in which container is the
+ *		current task running.
+ *		*buf* memory is pre-allocated, and *buf_len* indicates the size
+ *		of this memory.
+ *
+ *	Return
+ *		The cpuset cgroup path is copied into *buf* on success,
+ *		or a negative integer error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4903,6 +4915,7 @@ union bpf_attr {
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
+	FN(get_current_cpuset_cgroup_path),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.20.1 (Apple Git-117)

