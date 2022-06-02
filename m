Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044A53BF0B
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 21:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiFBTnO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Jun 2022 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiFBTm4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 15:42:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA312AD8
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 12:42:56 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252FLKdG021156
        for <bpf@vger.kernel.org>; Thu, 2 Jun 2022 12:42:55 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ge9m2sj5j-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 12:42:55 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 2 Jun 2022 12:42:49 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 97C5586C00CE; Thu,  2 Jun 2022 12:37:15 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>, <jolsa@kernel.org>,
        <mhiramat@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 2/5] ftrace: add modify_ftrace_direct_multi_nolock
Date:   Thu, 2 Jun 2022 12:37:03 -0700
Message-ID: <20220602193706.2607681-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602193706.2607681-1-song@kernel.org>
References: <20220602193706.2607681-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PLGzm1rwk8-YE5kQoHR_QLhgEFQATJqs
X-Proofpoint-ORIG-GUID: PLGzm1rwk8-YE5kQoHR_QLhgEFQATJqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is similar to modify_ftrace_direct_multi, but does not acquire
direct_mutex. This is useful when direct_mutex is already locked by the
user.

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/ftrace.h |  5 +++
 kernel/trace/ftrace.c  | 85 ++++++++++++++++++++++++++++++------------
 2 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 820500430eae..9023bf69f675 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -343,6 +343,7 @@ unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 #else
 struct ftrace_ops;
@@ -387,6 +388,10 @@ static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned lo
 {
 	return -ENODEV;
 }
+static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index afe782ae28d3..6a419f6bbbf0 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5601,22 +5601,8 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
 
-/**
- * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
- * to call something else
- * @ops: The address of the struct ftrace_ops object
- * @addr: The address of the new trampoline to call at @ops functions
- *
- * This is used to unregister currently registered direct caller and
- * register new one @addr on functions registered in @ops object.
- *
- * Note there's window between ftrace_shutdown and ftrace_startup calls
- * where there will be no callbacks called.
- *
- * Returns: zero on success. Non zero on error, which includes:
- *  -EINVAL - The @ops object was not properly registered.
- */
-int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static int
+__modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 {
 	struct ftrace_hash *hash;
 	struct ftrace_func_entry *entry, *iter;
@@ -5627,12 +5613,8 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	int i, size;
 	int err;
 
-	if (check_direct_multi(ops))
+	if (WARN_ON_ONCE(!mutex_is_locked(&direct_mutex)))
 		return -EINVAL;
-	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
-		return -EINVAL;
-
-	mutex_lock(&direct_mutex);
 
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
@@ -5640,7 +5622,7 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 
 	err = register_ftrace_function(&tmp_ops);
 	if (err)
-		goto out_direct;
+		return err;
 
 	/*
 	 * Now the ftrace_ops_list_func() is called to do the direct callers.
@@ -5664,7 +5646,64 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	/* Removing the tmp_ops will add the updated direct callers to the functions */
 	unregister_ftrace_function(&tmp_ops);
 
- out_direct:
+	return err;
+}
+
+/**
+ * modify_ftrace_direct_multi_nolock - Modify an existing direct 'multi' call
+ * to call something else
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the new trampoline to call at @ops functions
+ *
+ * This is used to unregister currently registered direct caller and
+ * register new one @addr on functions registered in @ops object.
+ *
+ * Note there's window between ftrace_shutdown and ftrace_startup calls
+ * where there will be no callbacks called.
+ *
+ * Caller should already have direct_mutex locked, so we don't lock
+ * direct_mutex here.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -EINVAL - The @ops object was not properly registered.
+ */
+int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
+{
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	return __modify_ftrace_direct_multi(ops, addr);
+}
+EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi_nolock);
+
+/**
+ * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
+ * to call something else
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the new trampoline to call at @ops functions
+ *
+ * This is used to unregister currently registered direct caller and
+ * register new one @addr on functions registered in @ops object.
+ *
+ * Note there's window between ftrace_shutdown and ftrace_startup calls
+ * where there will be no callbacks called.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -EINVAL - The @ops object was not properly registered.
+ */
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	int err;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	err = __modify_ftrace_direct_multi(ops, addr);
 	mutex_unlock(&direct_mutex);
 	return err;
 }
-- 
2.30.2

