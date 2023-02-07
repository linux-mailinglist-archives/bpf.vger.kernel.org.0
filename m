Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A168DFE5
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 19:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBGSXK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 13:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBGSWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE440BFB
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 10:22:11 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n13so11667808wmr.4
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gYG58EXqJ0Y/4xeABUM52stBBVLAlCY7i+yS36s6U0=;
        b=XBazxPYD1Uufwyyi1baCxXMaUEsvIHLnoOtqCFtvBxdPWmbI4De00A2AyWOEum3+eK
         /2mUo1ymD3oisFSKMs+LPeqg3YrbZzCOoMi1cnBivXXL7oCfs3PC1f/UXEp01WrwsbpO
         HBPMU1Ys57d0hQDTXpQjEtPY4H7dF36DxnKeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gYG58EXqJ0Y/4xeABUM52stBBVLAlCY7i+yS36s6U0=;
        b=Z5u/qIC6rh0mRAyj5zWO2uAeM5za/tyfJ62KajxSEGnvXXVajR9sKNZqtVO2WxDYwn
         AFEE3koCUOvG88sIxsYFlbkxdJsNB2fWuLmpArKGK9WL+N2wdctP9uJYU5H9RdDpiHdo
         IuJuW56nQMrexMZo7HMHqyEDh1OZddffQPogREQefjbl88o3tz5/LIn6MYirvTOocTcZ
         AWrbRxGqREHt0gYRghUj0NDuyw9hHH+w+iI94eMlgn73SZpvNEwZBr7Y5nR2g+g0mVYX
         LjC+FGWoiIgcVRyETXNquOn1+gfnKbdAJxmH4nFXWt+i2EqGbOPt97r/2d4CTEYM56PY
         IHAA==
X-Gm-Message-State: AO0yUKXDr8EUB0yjlnX3BVq3oeFmRZAPpHyseKSqdsaC3orO1oRG8Aio
        xKxnZaM6CeI/1EKw902jjplKxg==
X-Google-Smtp-Source: AK7set95XDnsdagYIadJ54ZQFBsvpQkSJa9jgeAZgVJqL0KSJC+dPRFAVjGHPYrfXVzTvPMMHqkpdg==
X-Received: by 2002:a05:600c:16c6:b0:3db:fc3:6de4 with SMTP id l6-20020a05600c16c600b003db0fc36de4mr3834804wmn.35.1675794129630;
        Tue, 07 Feb 2023 10:22:09 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:22:09 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Xu Kuohai <xukuohai@huawei.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 06/10] ftrace: selftest: remove broken trace_direct_tramp
Date:   Tue,  7 Feb 2023 19:21:31 +0100
Message-Id: <20230207182135.2671106-7-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207182135.2671106-1-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
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

From: Mark Rutland <mark.rutland@arm.com>

The ftrace selftest code has a trace_direct_tramp() function which it
uses as a direct call trampoline. This happens to work on x86, since the
direct call's return address is in the usual place, and can be returned
to via a RET, but in general the calling convention for direct calls is
different from regular function calls, and requires a trampoline written
in assembly.

On s390, regular function calls place the return address in %r14, and an
ftrace patch-site in an instrumented function places the trampoline's
return address (which is within the instrumented function) in %r0,
preserving the original %r14 value in-place. As a regular C function
will return to the address in %r14, using a C function as the trampoline
results in the trampoline returning to the caller of the instrumented
function, skipping the body of the instrumented function.

Note that the s390 issue is not detcted by the ftrace selftest code, as
the instrumented function is trivial, and returning back into the caller
happens to be equivalent.

On arm64, regular function calls place the return address in x30, and
an ftrace patch-site in an instrumented function saves this into r9
and places the trampoline's return address (within the instrumented
function) in x30. A regular C function will return to the address in
x30, but will not restore x9 into x30. Consequently, using a C function
as the trampoline results in returning to the trampoline's return
address having corrupted x30, such that when the instrumented function
returns, it will return back into itself.

To avoid future issues in this area, remove the trace_direct_tramp()
function, and require that each architecture with direct calls provides
a stub trampoline, named ftrace_stub_direct_tramp. This can be written
to handle the architecture's trampoline calling convention, and in
future could be used elsewhere (e.g. in the ftrace ops sample, to
measure the overhead of direct calls), so we may as well always build it
in.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: Xu Kuohai <xukuohai@huawei.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Florent Revest <revest@chromium.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 arch/s390/kernel/mcount.S     |  5 +++++
 arch/x86/kernel/ftrace_32.S   |  5 +++++
 arch/x86/kernel/ftrace_64.S   |  4 ++++
 include/linux/ftrace.h        |  2 ++
 kernel/trace/trace_selftest.c | 15 ++-------------
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 4786bfe02144..ad13a0e2c307 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -32,6 +32,11 @@ ENTRY(ftrace_stub)
 	BR_EX	%r14
 ENDPROC(ftrace_stub)
 
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	lgr	%r1, %r0
+	BR_EX	%r1
+SYM_CODE_END(ftrace_stub_direct_tramp)
+
 	.macro	ftrace_regs_entry, allregs=0
 	stg	%r14,(__SF_GPRS+8*8)(%r15)	# save traced function caller
 
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a0ed0e4a2c0c..0d9a14528176 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -163,6 +163,11 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	jmp	.Lftrace_ret
 SYM_CODE_END(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_CODE_START(ftrace_graph_caller)
 	pushl	%eax
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 1265ad519249..8fc77e3e039c 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -307,6 +307,10 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index cabb40146da9..48b13bb888bf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -412,6 +412,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
+void ftrace_stub_direct_tramp(void);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 06218fc9374b..e6530b7b42e4 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -784,17 +784,6 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-#ifndef CALL_DEPTH_ACCOUNT
-#define CALL_DEPTH_ACCOUNT ""
-#endif
-
-noinline __noclone static void trace_direct_tramp(void)
-{
-	asm(CALL_DEPTH_ACCOUNT);
-}
-#endif
-
 /*
  * Pretty much the same than for the function tracer from which the selftest
  * has been borrowed.
@@ -875,7 +864,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 */
 	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
 	ret = register_ftrace_direct(&direct,
-				     (unsigned long)trace_direct_tramp);
+				     (unsigned long)ftrace_stub_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -896,7 +885,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	unregister_ftrace_graph(&fgraph_ops);
 
 	ret = unregister_ftrace_direct(&direct,
-				       (unsigned long)trace_direct_tramp);
+				       (unsigned long)ftrace_stub_direct_tramp);
 	if (ret)
 		goto out;
 
-- 
2.39.1.519.gcb327c4b5f-goog

