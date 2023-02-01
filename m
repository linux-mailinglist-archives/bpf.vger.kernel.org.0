Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D3C686BE3
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjBAQfv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjBAQfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FA60C9D
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso1827681wmp.3
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h7L/6sUB2KnxbssfPmMIi6qgi9N82FF7O8XsVF6WqE=;
        b=eO7ef0lbntzUy8m51n14OyG3x4x9Mi3sefAioFTJImzU5ZFg5Vs78dtPVoYekbT3pk
         Cg3uxLoGda0UZ7Xy5jaLG8tClEL1RJYhO9a8twyYmoUmUPMXXAoMJjtxTKVjATmXRm3i
         jc39euXLJjlYSDkRk5RHgqVAXCCYmDq7Le2k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h7L/6sUB2KnxbssfPmMIi6qgi9N82FF7O8XsVF6WqE=;
        b=maudI6WAqWBYJYpT5Fd5Y0naaoim1ph73/N56sBI4bheWz6LAgMTS0usu1+bRmClq/
         2bI+Zvjvl1pHbkWSnyzkhpgobZyHaEqPAqLnguJ9iZc+li8I2Dx3G25agUZco69vbtY9
         MQRvHzDSnagYCx1Whz2C4097kg6Ynx6Qgzux7gbRTvTwZMq1CRorbbJy+3P3g2xw+2Fi
         LuZMlErcSK7rIVzOKOgwIDMWrZW06lBQNhn9L+IxPSFve3+nzZ1XhCoB0PUddXeWCHTh
         UzNUjPwlFToSOFCFpVcA1KCx/5MKjZNrAPWJ3GJ1Z1iKPb1F+KHZhVqVzoV5jJ1hUrqq
         s2Zw==
X-Gm-Message-State: AO0yUKVnvTZpnUUw+YK3D76ayZQit1QU6gGqemr6uwK2iipO0C+baNcJ
        BvkMWCt6X3lAGIrLBt/mIafmvQ==
X-Google-Smtp-Source: AK7set/s4PL//844ITpXCCvWBv/H9BGkGF1snDf6k8ign1+tNi1Gp86Z60+eLs40rYOD38/iM9jfmg==
X-Received: by 2002:a05:600c:4f12:b0:3de:271:7b24 with SMTP id l18-20020a05600c4f1200b003de02717b24mr2802649wmq.16.1675269331250;
        Wed, 01 Feb 2023 08:35:31 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:30 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Xu Kuohai <xukuohai@huawei.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 6/8] ftrace: Fix dead loop caused by direct call in ftrace selftest
Date:   Wed,  1 Feb 2023 17:34:18 +0100
Message-Id: <20230201163420.1579014-7-revest@chromium.org>
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

From: Xu Kuohai <xukuohai@huawei.com>

After direct call is enabled for arm64, ftrace selftest enters a
dead loop:

<trace_selftest_dynamic_test_func>:
00  bti     c
01  mov     x9, x30                            <trace_direct_tramp>:
02  bl      <trace_direct_tramp>    ---------->     ret
                                                     |
                                         lr/x30 is 03, return to 03
                                                     |
03  mov     w0, #0x0   <-----------------------------|
     |                                               |
     |                   dead loop!                  |
     |                                               |
04  ret   ---- lr/x30 is still 03, go back to 03 ----|

The reason is that when the direct caller trace_direct_tramp() returns
to the patched function trace_selftest_dynamic_test_func(), lr is still
the address after the instrumented instruction in the patched function,
so when the patched function exits, it returns to itself!

To fix this issue, we need to restore lr before trace_direct_tramp()
exits, so use a dedicated trace_direct_tramp() for arm64.

Reported-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 arch/arm64/include/asm/ftrace.h  |  7 +++++++
 arch/arm64/kernel/entry-ftrace.S | 10 ++++++++++
 kernel/trace/trace_selftest.c    |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1c2672bbbf37..cf6d9c42ff36 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -168,6 +168,13 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	 */
 	return !strcmp(sym + 8, name);
 }
+
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
+    defined(CONFIG_FTRACE_SELFTEST)
+extern void ftrace_dummy_tramp(void);
+#define trace_direct_tramp ftrace_dummy_tramp
+#endif
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* __ASM_FTRACE_H */
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 350ed81324ac..9869debd22fb 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -118,6 +118,16 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ret	x9
 SYM_CODE_END(ftrace_caller)
 
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
+    defined(CONFIG_FTRACE_SELFTEST)
+SYM_CODE_START(ftrace_dummy_tramp)
+	bti c
+	mov x10, x30
+	mov x30, x9
+	ret x10
+SYM_CODE_END(ftrace_dummy_tramp)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 /*
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 06218fc9374b..f9f5d4e8ab50 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -789,11 +789,13 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 #define CALL_DEPTH_ACCOUNT ""
 #endif
 
+#ifndef trace_direct_tramp
 noinline __noclone static void trace_direct_tramp(void)
 {
 	asm(CALL_DEPTH_ACCOUNT);
 }
 #endif
+#endif
 
 /*
  * Pretty much the same than for the function tracer from which the selftest
-- 
2.39.1.519.gcb327c4b5f-goog

