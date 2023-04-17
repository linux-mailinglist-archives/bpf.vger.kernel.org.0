Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEE46E4D90
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjDQPsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjDQPsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:48:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CFD49E9;
        Mon, 17 Apr 2023 08:48:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d8so912905plg.2;
        Mon, 17 Apr 2023 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681746482; x=1684338482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHDJ0ms5qntiTY/vJL+PnOx/U67KpWhrNxGfGdA7Jik=;
        b=CXHC9Ql/00zSsOmvxzChRGMGyfJcb0YMSNw/aRcGN4CDGRoiIsdn4lwffnubNCXcNM
         vAztb7EUps8Yn9pnIR+8z5hkJ3lzUg9UoZ4xQ0volTO4PDJIkzkroDBUAAzdcckTXov2
         fJc4CH+qEikLD7cQSRNSL7Po/5+XpImaxp47pgc1vulxntronqhcer4FWXFVWv9L3/kn
         Ay5Gq2cIUofwMWnYUm8oDZYXcwU/374p/X1usEz2PvCGCJxvZ5b4Ht3VtuAnLcw/TVXM
         yJVhqiTq/eWcs8yjAIrYVhwTWezSmsSRlL1/OzwtR0RhRZ9s7LRfuLJ58ztMJhGTNojc
         Zhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746482; x=1684338482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHDJ0ms5qntiTY/vJL+PnOx/U67KpWhrNxGfGdA7Jik=;
        b=DnyEbpFWKqbm41TIn0vW/xAnCCK7/RDkqcsS/aYKLrUj03GOgpnm/kc19859symfgk
         d0oyL85aowZVhN/+4Txt7cN4UfdCDzt8o/NnObEd+fNPPPlNYwQIiANQ0UCIbOcVru1t
         cgzulL8RYzvctIgXBW8TIiCd7GOqlJ5L/0MuHo6/tB73KiL2+SIA5m5nI0Ui6bt6VGxI
         rwyL0zj/wz+3lDxxFLpXCsHKlmzW2VedMqPKOoLtwWG0yqeBjx3H3ZbT0bkp0zAnGA25
         0uULC7GwesArwyST71uLgmsNSNV+NDOrRFxSSdBNTE9vNJuhk237Subt1SuDBs9wO+sq
         RJ3A==
X-Gm-Message-State: AAQBX9dZctk4a25sL9P43246ZiX7cRb9cO80RhTsNA/EGHt/etBbPO80
        MsoGTfTmmYTL8MDxLwuHssg=
X-Google-Smtp-Source: AKy350Y7nNjW5vBx2O5i0pQGxt1f7hj8LXlNdATz6b9i8hZ9OXYTnT0OSr7Vgm5Rr3dNUoZgZo979g==
X-Received: by 2002:a17:902:f54a:b0:1a6:7534:974a with SMTP id h10-20020a170902f54a00b001a67534974amr14200100plf.48.1681746482029;
        Mon, 17 Apr 2023 08:48:02 -0700 (PDT)
Received: from vultr.guest ([2401:c080:3800:263c:5400:4ff:fe66:d27f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001a6b308fcaesm4437513plb.153.2023.04.17.08.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:01 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/6] tracing: Add generic test_recursion_try_acquire()
Date:   Mon, 17 Apr 2023 15:47:33 +0000
Message-Id: <20230417154737.12740-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417154737.12740-1-laoar.shao@gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ftrace_test_recursion_trylock() also disables preemption. This is not
required, but was a clean up as every place that called it also disabled
preemption, and making the two tightly coupled appeared to make the code
simpler.

But the recursion protection can be used for other purposes that do not
require disabling preemption. As the recursion bits are attached to the
task_struct, it follows the task, so there's no need for preemption being
disabled.

Add test_recursion_try_acquire/release() functions to be used generically,
and separate it from being associated with ftrace. It also removes the
"lock" name, as there is no lock happening. Keeping the "lock" for the
ftrace version is better, as it at least differentiates that preemption is
being disabled (hence, "locking the CPU").

Link: https://lore.kernel.org/linux-trace-kernel/20230321020103.13494-1-laoar.shao@gmail.com/

Acked-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/trace_recursion.h | 47 ++++++++++++++++++++++++++++++-----------
 kernel/trace/ftrace.c           |  2 ++
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index d48cd92..80de2ee 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -150,9 +150,6 @@ static __always_inline int trace_get_context_bit(void)
 # define trace_warn_on_no_rcu(ip)	false
 #endif
 
-/*
- * Preemption is promised to be disabled when return bit >= 0.
- */
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
 							int start)
 {
@@ -182,18 +179,11 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	val |= 1 << bit;
 	current->trace_recursion = val;
 	barrier();
-
-	preempt_disable_notrace();
-
 	return bit;
 }
 
-/*
- * Preemption will be enabled (if it was previously enabled).
- */
 static __always_inline void trace_clear_recursion(int bit)
 {
-	preempt_enable_notrace();
 	barrier();
 	trace_recursion_clear(bit);
 }
@@ -205,12 +195,18 @@ static __always_inline void trace_clear_recursion(int bit)
  * tracing recursed in the same context (normal vs interrupt),
  *
  * Returns: -1 if a recursion happened.
- *           >= 0 if no recursion.
+ *           >= 0 if no recursion and preemption will be disabled.
  */
 static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 							 unsigned long parent_ip)
 {
-	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+	int bit;
+
+	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+	if (unlikely(bit < 0))
+		return bit;
+	preempt_disable_notrace();
+	return bit;
 }
 
 /**
@@ -221,6 +217,33 @@ static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
  */
 static __always_inline void ftrace_test_recursion_unlock(int bit)
 {
+	preempt_enable_notrace();
+	trace_clear_recursion(bit);
+}
+
+/**
+ * test_recursion_try_acquire - tests for recursion in same context
+ *
+ * This will detect recursion of a function.
+ *
+ * Returns: -1 if a recursion happened.
+ *           >= 0 if no recursion
+ */
+static __always_inline int test_recursion_try_acquire(unsigned long ip,
+						      unsigned long parent_ip)
+{
+	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+}
+
+/**
+ * test_recursion_release - called after a success of test_recursion_try_acquire()
+ * @bit: The return of a successful test_recursion_try_acquire()
+ *
+ * This releases the recursion lock taken by a non-negative return call
+ * by test_recursion_try_acquire().
+ */
+static __always_inline void test_recursion_release(int bit)
+{
 	trace_clear_recursion(bit);
 }
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c67bcc8..8ad3ab4 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7647,6 +7647,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 	if (bit < 0)
 		return;
 
+	preempt_disable();
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		/* Stub functions don't need to be called nor tested */
 		if (op->flags & FTRACE_OPS_FL_STUB)
@@ -7668,6 +7669,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 		}
 	} while_for_each_ftrace_op(op);
 out:
+	preempt_enable();
 	trace_clear_recursion(bit);
 }
 
-- 
1.8.3.1

