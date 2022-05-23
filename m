Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9363E531DC1
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiEWV37 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiEWV2S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:28:18 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A398DA3087
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:28:17 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id o21-20020aa79795000000b0051841039a63so4970473pfp.19
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P0dc/hsbLfI6NQ/lZ14Xz2MO6AZmT1SEz1e3p5QB+CU=;
        b=KVrjJMgWtZ9fFnNlRcHeO9QfwmEQXGUYiM0Ui1qQ4KnHJmna9s7rviKOq0Z8+DZFab
         WoTShCn3U+p969h7FMSarMxfW03rqebUa9FnCSrcgdW5FAMmQEy/3xslLTP+lVrtfbgh
         FpTeL6PuyYBVU3AWdfm8cEvFE+jEyAdqJC3w6L29HQZgvlGaSpZWHwpmTbj9ZOYlyZ6T
         3l2q52e67phuNwBvOtTsUP2MlvAzBOqe0Z5kmRkSj/ohrgU4t5KFApNEFcIeMwMHxR+J
         Mik+DeJP40n01Fb3l9lUEze3hJ5QELzbKZAlITxvhPCXr0ajJTO+LpBkRh+EfmVJsPpk
         78Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P0dc/hsbLfI6NQ/lZ14Xz2MO6AZmT1SEz1e3p5QB+CU=;
        b=Gz8wJyo58ErVJZ8RjYIC7pyklttADm+OGJFnHhSwHST9FMSAVOavJ+lITxtbwSERjE
         OU2BRoozlu/Dhc8x8SbAvgBJUWpF/dIqh+HLRYSIgzH29g5+8PeK4qo1LlYMqg4zdB2g
         PUZYKsLAPOLn9+fbqWVDIYYsBu20gsnzfEib3B+3KIgITfy6S9o1TyaRVDkrf0ZoONm9
         x5SyXFEwZ/x86KwUG0hBmem/CKYHSZW1fvfRdKuyky/sLyhxnWo61jxddacb/EaM3tde
         Al8LlAu2srVnKc/kyeVkNJJg2kJbsWHACxi7e3tV9QcWzsB9cf8itwhWLq9lE5sj2ikB
         1ZuA==
X-Gm-Message-State: AOAM5322HVeELgP+66GeorBsYEsSKBNL3RtpzTZiMZu76ZMslPPT1boX
        VWtDuSG9r87AuAvDiI/5OxhwFCwofUbm
X-Google-Smtp-Source: ABdhPJzgRdtm4fQ9Gk9r0fxFUaClViNc9qKqf3adycUhzmR2wWez23rCUHfEtkxkewzkPqALGbiYy8s3HHc3
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:aa7:9019:0:b0:4fa:7532:9551 with SMTP id
 m25-20020aa79019000000b004fa75329551mr25987515pfo.26.1653341297002; Mon, 23
 May 2022 14:28:17 -0700 (PDT)
Date:   Mon, 23 May 2022 21:28:08 +0000
Message-Id: <20220523212808.603526-1-connoro@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH bpf-next v2] libbpf: also check /sys/kernel/tracing for
 tracefs files
From:   "Connor O'Brien" <connoro@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf looks for tracefs files only under debugfs, but tracefs may be
mounted even if debugfs is not. When /sys/kernel/debug/tracing is
absent, try looking under /sys/kernel/tracing instead.

Signed-off-by: Connor O'Brien <connoro@google.com>
---
v1->v2: cache result of debugfs check.

 src/libbpf.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index 2262bcd..cc47c52 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -9945,10 +9945,22 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 		 __sync_fetch_and_add(&index, 1));
 }
 
+static bool debugfs_available(void)
+{
+	static bool initialized = false, available;
+
+	if (!initialized) {
+		available = !access("/sys/kernel/debug/tracing", F_OK);
+		initialized = true;
+	}
+	return available;
+}
+
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
 				   const char *kfunc_name, size_t offset)
 {
-	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+	const char *file = debugfs_available() ? "/sys/kernel/debug/tracing/kprobe_events" :
+		"/sys/kernel/tracing/kprobe_events";
 
 	return append_to_file(file, "%c:%s/%s %s+0x%zx",
 			      retprobe ? 'r' : 'p',
@@ -9958,7 +9970,8 @@ static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
 
 static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
 {
-	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+	const char *file = debugfs_available() ? "/sys/kernel/debug/tracing/kprobe_events" :
+		"/sys/kernel/tracing/kprobe_events";
 
 	return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
 }
@@ -9968,7 +9981,8 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
 	char file[256];
 
 	snprintf(file, sizeof(file),
-		 "/sys/kernel/debug/tracing/events/%s/%s/id",
+		 debugfs_available() ? "/sys/kernel/debug/tracing/events/%s/%s/id" :
+		 "/sys/kernel/tracing/events/%s/%s/id",
 		 retprobe ? "kretprobes" : "kprobes", probe_name);
 
 	return parse_uint_from_file(file, "%d\n");
@@ -10144,7 +10158,8 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
-	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
+	const char *file = debugfs_available() ? "/sys/kernel/debug/tracing/uprobe_events" :
+		"/sys/kernel/tracing/uprobe_events";
 
 	return append_to_file(file, "%c:%s/%s %s:0x%zx",
 			      retprobe ? 'r' : 'p',
@@ -10154,7 +10169,8 @@ static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 
 static inline int remove_uprobe_event_legacy(const char *probe_name, bool retprobe)
 {
-	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
+	const char *file = debugfs_available() ? "/sys/kernel/debug/tracing/uprobe_events" :
+		"/sys/kernel/tracing/uprobe_events";
 
 	return append_to_file(file, "-:%s/%s", retprobe ? "uretprobes" : "uprobes", probe_name);
 }
@@ -10164,7 +10180,8 @@ static int determine_uprobe_perf_type_legacy(const char *probe_name, bool retpro
 	char file[512];
 
 	snprintf(file, sizeof(file),
-		 "/sys/kernel/debug/tracing/events/%s/%s/id",
+		 debugfs_available() ? "/sys/kernel/debug/tracing/events/%s/%s/id" :
+		 "/sys/kernel/tracing/events/%s/%s/id",
 		 retprobe ? "uretprobes" : "uprobes", probe_name);
 
 	return parse_uint_from_file(file, "%d\n");
@@ -10295,7 +10312,8 @@ static int determine_tracepoint_id(const char *tp_category,
 	int ret;
 
 	ret = snprintf(file, sizeof(file),
-		       "/sys/kernel/debug/tracing/events/%s/%s/id",
+		       debugfs_available() ? "/sys/kernel/debug/tracing/events/%s/%s/id" :
+		       "/sys/kernel/tracing/events/%s/%s/id",
 		       tp_category, tp_name);
 	if (ret < 0)
 		return -errno;
-- 
2.36.1.124.g0e6072fb45-goog

