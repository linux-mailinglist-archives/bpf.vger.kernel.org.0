Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A01686BD8
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjBAQff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBAQfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6575B744BA
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n13so6113824wmr.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWFrI/ZwPkf24GvAi4zS93lAjO18wCo9ugFdCRD9vug=;
        b=R/wJRycxVlXr98cXymYAxYn59y2w9nV7JoCbhkjevWZR1Cd6qPhPtO6JgzG3VxSI9Q
         GKjV0BjUpT2ySQyMbsatvRUEOMMnI83NorJqYQruLmLn9Dd7v4V8prfj6ZAjCD1ul2/+
         TWRYbF22VUKSRARcJ2XvXOHcRQs/Rg82E+MiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWFrI/ZwPkf24GvAi4zS93lAjO18wCo9ugFdCRD9vug=;
        b=BOw4609MZYun9NwGxmMz1fK4YhCsARLUjociryHdNDfsFIg/B8tNvYnaGHAko3+/cM
         cvrZhg62txuzysyvVWQ3nDFJ7PMjvE63bJU/m/aZd7D50He+g1zmbCgHIYhlnNOsM9Ex
         xAipDxtj1reAvaZbg7l1Wy+CLJhmPZUfRo00rwMCAkZpVjDL/VCwvYOA06AUpLjHsR8r
         fHtp+xJ8g+JJlT0+Ckrxmq4ke2px330Z9ypN89B5WGJvSBtsDbaRa3OzYIan1CmJQgsX
         Tfcago5tD+LMT9E6D55fA/SgWRjgBPA+yUGToxpJ+Pqd+GXvC0BORHvVGiOYqbNLdOP3
         dKRQ==
X-Gm-Message-State: AO0yUKUxI/GfDPatO8xpFxrqNTHeZ5Zoo1eGGrU4+q0ZzntI6qSqSeyo
        tPP1xFh4C0oRG0iEuZtlR4pTog==
X-Google-Smtp-Source: AK7set+/RTqNE3i6RzBFCPFMdJxcxKMsNBsU7or9P4oRwy2TN0ZjlO+eOnMfvdrBDV3haIG0hgP9Kw==
X-Received: by 2002:a05:600c:3544:b0:3dd:1c46:b92 with SMTP id i4-20020a05600c354400b003dd1c460b92mr2882937wmq.16.1675269323861;
        Wed, 01 Feb 2023 08:35:23 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:23 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 1/8] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
Date:   Wed,  1 Feb 2023 17:34:13 +0100
Message-Id: <20230201163420.1579014-2-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230201163420.1579014-1-revest@chromium.org>
References: <20230201163420.1579014-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The _multi API requires that users keep their own ops and can enforce
that an op is only associated to one direct call.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/trace_selftest.c         |  9 ++++++---
 samples/ftrace/ftrace-direct-modify.c | 11 +++++++----
 samples/ftrace/ftrace-direct-too.c    | 12 +++++++-----
 samples/ftrace/ftrace-direct.c        | 12 +++++++-----
 4 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index ff0536cea968..9b7f10cbc51d 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -806,6 +806,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	int ret;
 	unsigned long count;
 	char *func_name __maybe_unused;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	struct ftrace_ops direct = {};
+#endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (ftrace_filter_param) {
@@ -870,8 +873,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * Register direct function together with graph tracer
 	 * and make sure we get graph trace.
 	 */
-	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
-				     (unsigned long) trace_direct_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -891,7 +894,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 
 	unregister_ftrace_graph(&fgraph_ops);
 
-	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
+	ret = unregister_ftrace_direct_multi(&direct,
 				       (unsigned long) trace_direct_tramp);
 	if (ret)
 		goto out;
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index de5a0f67f320..e1e6c286970c 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -96,6 +96,8 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
@@ -114,7 +116,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct(my_ip, my_tramp, tramps[t]);
+		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -129,7 +131,8 @@ static int __init ftrace_direct_init(void)
 {
 	int ret;
 
-	ret = register_ftrace_direct(my_ip, my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, my_tramp);
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
 	return ret;
@@ -138,12 +141,12 @@ static int __init ftrace_direct_init(void)
 static void __exit ftrace_direct_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct(my_ip, my_tramp);
+	unregister_ftrace_direct_multi(&direct, my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index e13fb59a2b47..0e907092e2c0 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -70,21 +70,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)handle_mm_fault,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)handle_mm_fault,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1f769d0db20f..e446c38f6b58 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -63,21 +63,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)wake_up_process,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)wake_up_process,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
-- 
2.39.1.519.gcb327c4b5f-goog

