Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBD6BD82D
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 19:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCPSal convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Mar 2023 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCPSak (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 14:30:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BED52916
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:30:37 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GI6klY032522
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:30:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pbpxsp9qy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 11:30:37 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 11:30:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 80CAA2AC19580; Thu, 16 Mar 2023 11:30:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/6] bpf: split off basic BPF verifier log into separate file
Date:   Thu, 16 Mar 2023 11:30:08 -0700
Message-ID: <20230316183013.2882810-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316183013.2882810-1-andrii@kernel.org>
References: <20230316183013.2882810-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nYGasoiXTvDRrukZVy183G_QIxJA2ThH
X-Proofpoint-GUID: nYGasoiXTvDRrukZVy183G_QIxJA2ThH
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kernel/bpf/verifier.c file is large and growing larger all the time. So
it's good to start splitting off more or less self-contained parts into
separate files to keep source code size (somewhat) somewhat under
control.

This patch is a one step in this direction, moving some of BPF verifier log
routines into a separate kernel/bpf/log.c. Right now it's most low-level
and isolated routines to append data to log, reset log to previous
position, etc. Eventually we could probably move verifier state
printing logic here as well, but this patch doesn't attempt to do that
yet.

Subsequent patches will add more logic to verifier log management, so
having basics in a separate file will make sure verifier.c doesn't grow
more with new changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h | 19 +++-----
 kernel/bpf/Makefile          |  3 +-
 kernel/bpf/log.c             | 85 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 69 -----------------------------
 4 files changed, 94 insertions(+), 82 deletions(-)
 create mode 100644 kernel/bpf/log.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81d525d057c7..83dff25545ee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -498,11 +498,6 @@ struct bpf_verifier_log {
 	u32 len_total;
 };
 
-static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
-{
-	return log->len_used >= log->len_total - 1;
-}
-
 #define BPF_LOG_LEVEL1	1
 #define BPF_LOG_LEVEL2	2
 #define BPF_LOG_STATS	4
@@ -512,6 +507,11 @@ static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
 #define BPF_LOG_MIN_ALIGNMENT 8U
 #define BPF_LOG_ALIGNMENT 40U
 
+static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
+{
+	return log->len_used >= log->len_total - 1;
+}
+
 static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 {
 	return log &&
@@ -519,13 +519,6 @@ static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
 		 log->level == BPF_LOG_KERNEL);
 }
 
-static inline bool
-bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
-{
-	return log->len_total >= 128 && log->len_total <= UINT_MAX >> 2 &&
-	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
-}
-
 #define BPF_MAX_SUBPROGS 256
 
 struct bpf_subprog_info {
@@ -608,12 +601,14 @@ struct bpf_verifier_env {
 	char type_str_buf[TYPE_STR_BUF_LEN];
 };
 
+bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log);
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
 					   const char *fmt, ...);
 __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 			    const char *fmt, ...);
+void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos);
 
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 02242614dcc7..1d3892168d32 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,8 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
+obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
new file mode 100644
index 000000000000..920061e38d2e
--- /dev/null
+++ b/kernel/bpf/log.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
+ * Copyright (c) 2016 Facebook
+ * Copyright (c) 2018 Covalent IO, Inc. http://covalent.io
+ */
+#include <uapi/linux/btf.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+
+bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
+{
+	return log->len_total >= 128 && log->len_total <= UINT_MAX >> 2 &&
+	       log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);
+}
+
+void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
+		       va_list args)
+{
+	unsigned int n;
+
+	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
+
+	WARN_ONCE(n >= BPF_VERIFIER_TMP_LOG_SIZE - 1,
+		  "verifier log line truncated - local buffer too short\n");
+
+	if (log->level == BPF_LOG_KERNEL) {
+		bool newline = n > 0 && log->kbuf[n - 1] == '\n';
+
+		pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
+		return;
+	}
+
+	n = min(log->len_total - log->len_used - 1, n);
+	log->kbuf[n] = '\0';
+	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
+		log->len_used += n;
+	else
+		log->ubuf = NULL;
+}
+
+void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
+{
+	char zero = 0;
+
+	if (!bpf_verifier_log_needed(log))
+		return;
+
+	log->len_used = new_pos;
+	if (put_user(zero, log->ubuf + new_pos))
+		log->ubuf = NULL;
+}
+
+/* log_level controls verbosity level of eBPF verifier.
+ * bpf_verifier_log_write() is used to dump the verification trace to the log,
+ * so the user can figure out what's wrong with the program
+ */
+__printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
+					   const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_verifier_log_needed(&env->log))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(&env->log, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
+
+__printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
+			    const char *fmt, ...)
+{
+	va_list args;
+
+	if (!bpf_verifier_log_needed(log))
+		return;
+
+	va_start(args, fmt);
+	bpf_verifier_vlog(log, fmt, args);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(bpf_log);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60793f793ca6..203d6e644e44 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -335,61 +335,6 @@ find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
 	return &linfo[i - 1];
 }
 
-void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
-		       va_list args)
-{
-	unsigned int n;
-
-	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);
-
-	WARN_ONCE(n >= BPF_VERIFIER_TMP_LOG_SIZE - 1,
-		  "verifier log line truncated - local buffer too short\n");
-
-	if (log->level == BPF_LOG_KERNEL) {
-		bool newline = n > 0 && log->kbuf[n - 1] == '\n';
-
-		pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
-		return;
-	}
-
-	n = min(log->len_total - log->len_used - 1, n);
-	log->kbuf[n] = '\0';
-	if (!copy_to_user(log->ubuf + log->len_used, log->kbuf, n + 1))
-		log->len_used += n;
-	else
-		log->ubuf = NULL;
-}
-
-static void bpf_vlog_reset(struct bpf_verifier_log *log, u32 new_pos)
-{
-	char zero = 0;
-
-	if (!bpf_verifier_log_needed(log))
-		return;
-
-	log->len_used = new_pos;
-	if (put_user(zero, log->ubuf + new_pos))
-		log->ubuf = NULL;
-}
-
-/* log_level controls verbosity level of eBPF verifier.
- * bpf_verifier_log_write() is used to dump the verification trace to the log,
- * so the user can figure out what's wrong with the program
- */
-__printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
-					   const char *fmt, ...)
-{
-	va_list args;
-
-	if (!bpf_verifier_log_needed(&env->log))
-		return;
-
-	va_start(args, fmt);
-	bpf_verifier_vlog(&env->log, fmt, args);
-	va_end(args);
-}
-EXPORT_SYMBOL_GPL(bpf_verifier_log_write);
-
 __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
 {
 	struct bpf_verifier_env *env = private_data;
@@ -403,20 +348,6 @@ __printf(2, 3) static void verbose(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
-__printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
-			    const char *fmt, ...)
-{
-	va_list args;
-
-	if (!bpf_verifier_log_needed(log))
-		return;
-
-	va_start(args, fmt);
-	bpf_verifier_vlog(log, fmt, args);
-	va_end(args);
-}
-EXPORT_SYMBOL_GPL(bpf_log);
-
 static const char *ltrim(const char *s)
 {
 	while (isspace(*s))
-- 
2.34.1

