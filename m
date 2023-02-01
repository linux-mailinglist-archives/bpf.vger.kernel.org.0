Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AD2686BDD
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjBAQfr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjBAQfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E641B77
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n13so6113941wmr.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xjgzv+CaWDCCmc9m2PtN7hh7GiZmUlZ8epcrKuwyKlk=;
        b=fB2BygETm73mrQ4E+jxUvmjud7LCPGfH0ctmgJAjk8dhSSEtRFb5FRPeDawZvISnAX
         SMWlkq1RxsqY0n9ATCYVe4TmRwqBeWUWhE9DKB1oj8V5RTWazQWdsb6E5fUjUwRH4ayK
         MiA1JFPW7zxvbGfJUF+AszD+OWqU9CTiC5tOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xjgzv+CaWDCCmc9m2PtN7hh7GiZmUlZ8epcrKuwyKlk=;
        b=IgcdeG/mSs28XV1/s347V0StPoJcsUg2hfpMQ3KTctl2wTp67O4qxBjxaVbxTGTTG7
         zRFh1MM8LrX+NhMg/72isnVR/IBk2bGo37fCDQ2yFoI6wjPeemEl1y2JSLKF5P17JIYb
         q1W13NYWQyX6BZ+bleVJlj5djGR5sMTOz9/w0R/jQaU2jmy62ejh/ZJXR0D2lpOp9llm
         9Y7SI5uaYEaz9AJEsV2QtYsVDnscZ5jNAAswc20ZHN/PKXiPrFOWB1YQ7ECe9MhGL4ya
         ubYZhXWH/E+CyY78PpHsefW2M3gPoQggVatly6t6bXNh7rb7vPID06Fi9Le13VlxQjny
         xDbQ==
X-Gm-Message-State: AO0yUKV+R51+BVMywGf3UY1P1ibHXnkdmAqbYs7gqe+DK/ZJ8RIxfUI9
        j2OohU5JKQcogjkqESc3WuujTA==
X-Google-Smtp-Source: AK7set8XqLfrpqZpOrgpsr7TxJ7QDVnSIcMeu3VwRNabuM38cqVSAX6unAWbUntH0DbhPAD9m3AdRg==
X-Received: by 2002:a05:600c:468e:b0:3db:1434:c51a with SMTP id p14-20020a05600c468e00b003db1434c51amr2813766wmo.40.1675269326776;
        Wed, 01 Feb 2023 08:35:26 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:26 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 3/8] ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
Date:   Wed,  1 Feb 2023 17:34:15 +0100
Message-Id: <20230201163420.1579014-4-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230201163420.1579014-1-revest@chromium.org>
References: <20230201163420.1579014-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that the original _ftrace_direct APIs are gone, the "_multi"
suffixes only add confusion.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/ftrace.h                      | 16 +++++------
 kernel/bpf/trampoline.c                     | 14 ++++-----
 kernel/trace/ftrace.c                       | 32 ++++++++++-----------
 kernel/trace/trace_selftest.c               |  7 +++--
 samples/Kconfig                             |  2 +-
 samples/ftrace/ftrace-direct-modify.c       |  8 +++---
 samples/ftrace/ftrace-direct-multi-modify.c |  8 +++---
 samples/ftrace/ftrace-direct-multi.c        |  6 ++--
 samples/ftrace/ftrace-direct-too.c          |  6 ++--
 samples/ftrace/ftrace-direct.c              |  6 ++--
 10 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2d7c85e47c2d..a7dbd307c3a4 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -398,10 +398,10 @@ struct ftrace_func_entry {
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 extern int ftrace_direct_func_count;
 unsigned long ftrace_find_rec_direct(unsigned long ip);
-int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
-int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
-int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
+int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
+int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 #else
 struct ftrace_ops;
@@ -410,19 +410,19 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
 }
-static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static inline int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	return -ENODEV;
 }
-static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static inline int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	return -ENODEV;
 }
-static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static inline int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	return -ENODEV;
 }
-static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
+static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
 {
 	return -ENODEV;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d0ed7d6f5eec..150b53316df2 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -39,14 +39,14 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd
 	int ret = 0;
 
 	if (cmd == FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
-		/* This is called inside register_ftrace_direct_multi(), so
+		/* This is called inside register_ftrace_direct(), so
 		 * tr->mutex is already locked.
 		 */
 		lockdep_assert_held_once(&tr->mutex);
 
 		/* Instead of updating the trampoline here, we propagate
-		 * -EAGAIN to register_ftrace_direct_multi(). Then we can
-		 * retry register_ftrace_direct_multi() after updating the
+		 * -EAGAIN to register_ftrace_direct(). Then we can
+		 * retry register_ftrace_direct() after updating the
 		 * trampoline.
 		 */
 		if ((tr->flags & BPF_TRAMP_F_CALL_ORIG) &&
@@ -198,7 +198,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
+		ret = unregister_ftrace_direct(tr->fops, (long)old_addr);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
@@ -215,9 +215,9 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 
 	if (tr->func.ftrace_managed) {
 		if (lock_direct_mutex)
-			ret = modify_ftrace_direct_multi(tr->fops, (long)new_addr);
+			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
 		else
-			ret = modify_ftrace_direct_multi_nolock(tr->fops, (long)new_addr);
+			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
 	}
@@ -243,7 +243,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 
 	if (tr->func.ftrace_managed) {
 		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
-		ret = register_ftrace_direct_multi(tr->fops, (long)new_addr);
+		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5efe201428fa..cb77a0a208c7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5312,7 +5312,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 }
 
 /**
- * register_ftrace_direct_multi - Call a custom trampoline directly
+ * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
  * @ops: The address of the struct ftrace_ops object
  * @addr: The address of the trampoline to call at @ops functions
@@ -5333,7 +5333,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
  *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
  *  -ENOMEM  - There was an allocation failure.
  */
-int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	struct ftrace_hash *hash, *free_hash = NULL;
 	struct ftrace_func_entry *entry, *new;
@@ -5391,11 +5391,11 @@ int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	}
 	return err;
 }
-EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
+EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
 /**
- * unregister_ftrace_direct_multi - Remove calls to custom trampoline
- * previously registered by register_ftrace_direct_multi for @ops object.
+ * unregister_ftrace_direct - Remove calls to custom trampoline
+ * previously registered by register_ftrace_direct for @ops object.
  * @ops: The address of the struct ftrace_ops object
  *
  * This is used to remove a direct calls to @addr from the nop locations
@@ -5406,7 +5406,7 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
  *  0 on success
  *  -EINVAL - The @ops object was not properly registered.
  */
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	int err;
@@ -5426,10 +5426,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	ops->trampoline = 0;
 	return err;
 }
-EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
 
 static int
-__modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+__modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	struct ftrace_hash *hash;
 	struct ftrace_func_entry *entry, *iter;
@@ -5476,7 +5476,7 @@ __modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 }
 
 /**
- * modify_ftrace_direct_multi_nolock - Modify an existing direct 'multi' call
+ * modify_ftrace_direct_nolock - Modify an existing direct 'multi' call
  * to call something else
  * @ops: The address of the struct ftrace_ops object
  * @addr: The address of the new trampoline to call at @ops functions
@@ -5493,19 +5493,19 @@ __modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
  * Returns: zero on success. Non zero on error, which includes:
  *  -EINVAL - The @ops object was not properly registered.
  */
-int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
+int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
 {
 	if (check_direct_multi(ops))
 		return -EINVAL;
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return -EINVAL;
 
-	return __modify_ftrace_direct_multi(ops, addr);
+	return __modify_ftrace_direct(ops, addr);
 }
-EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi_nolock);
+EXPORT_SYMBOL_GPL(modify_ftrace_direct_nolock);
 
 /**
- * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
+ * modify_ftrace_direct - Modify an existing direct 'multi' call
  * to call something else
  * @ops: The address of the struct ftrace_ops object
  * @addr: The address of the new trampoline to call at @ops functions
@@ -5519,7 +5519,7 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi_nolock);
  * Returns: zero on success. Non zero on error, which includes:
  *  -EINVAL - The @ops object was not properly registered.
  */
-int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	int err;
 
@@ -5529,11 +5529,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		return -EINVAL;
 
 	mutex_lock(&direct_mutex);
-	err = __modify_ftrace_direct_multi(ops, addr);
+	err = __modify_ftrace_direct(ops, addr);
 	mutex_unlock(&direct_mutex);
 	return err;
 }
-EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
+EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 9b7f10cbc51d..06218fc9374b 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -874,7 +874,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * and make sure we get graph trace.
 	 */
 	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
-	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
+	ret = register_ftrace_direct(&direct,
+				     (unsigned long)trace_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -894,8 +895,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 
 	unregister_ftrace_graph(&fgraph_ops);
 
-	ret = unregister_ftrace_direct_multi(&direct,
-				       (unsigned long) trace_direct_tramp);
+	ret = unregister_ftrace_direct(&direct,
+				       (unsigned long)trace_direct_tramp);
 	if (ret)
 		goto out;
 
diff --git a/samples/Kconfig b/samples/Kconfig
index 0d81c00289ee..e85998ca354d 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -38,7 +38,7 @@ config SAMPLE_FTRACE_DIRECT
 	  that hooks to wake_up_process and prints the parameters.
 
 config SAMPLE_FTRACE_DIRECT_MULTI
-	tristate "Build register_ftrace_direct_multi() example"
+	tristate "Build register_ftrace_direct() on multiple ips example"
 	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
 	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	help
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index e1e6c286970c..0f1b8859e1e1 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -116,7 +116,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
+		ret = modify_ftrace_direct(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -132,7 +132,7 @@ static int __init ftrace_direct_init(void)
 	int ret;
 
 	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
-	ret = register_ftrace_direct_multi(&direct, my_tramp);
+	ret = register_ftrace_direct(&direct, my_tramp);
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
 	return ret;
@@ -141,12 +141,12 @@ static int __init ftrace_direct_init(void)
 static void __exit ftrace_direct_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct_multi(&direct, my_tramp);
+	unregister_ftrace_direct(&direct, my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index d52370cad0b6..407c56325e65 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -123,7 +123,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
+		ret = modify_ftrace_direct(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -141,7 +141,7 @@ static int __init ftrace_direct_multi_init(void)
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
 	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
 
-	ret = register_ftrace_direct_multi(&direct, my_tramp);
+	ret = register_ftrace_direct(&direct, my_tramp);
 
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
@@ -151,12 +151,12 @@ static int __init ftrace_direct_multi_init(void)
 static void __exit ftrace_direct_multi_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct_multi(&direct, my_tramp);
+	unregister_ftrace_direct(&direct, my_tramp);
 }
 
 module_init(ftrace_direct_multi_init);
 module_exit(ftrace_direct_multi_exit);
 
 MODULE_AUTHOR("Jiri Olsa");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index ec1088922517..42a94806a446 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -73,17 +73,17 @@ static int __init ftrace_direct_multi_init(void)
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
 	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
 
-	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_multi_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	unregister_ftrace_direct(&direct, (unsigned long) my_tramp);
 }
 
 module_init(ftrace_direct_multi_init);
 module_exit(ftrace_direct_multi_exit);
 
 MODULE_AUTHOR("Jiri Olsa");
-MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 0e907092e2c0..7ee5dd3cc61d 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -76,17 +76,17 @@ static int __init ftrace_direct_init(void)
 {
 	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
 
-	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
+	unregister_ftrace_direct(&direct, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index e446c38f6b58..5ffce87fa83e 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -69,17 +69,17 @@ static int __init ftrace_direct_init(void)
 {
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
 
-	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
+	unregister_ftrace_direct(&direct, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
 MODULE_LICENSE("GPL");
-- 
2.39.1.519.gcb327c4b5f-goog

