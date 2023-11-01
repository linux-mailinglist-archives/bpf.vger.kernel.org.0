Return-Path: <bpf+bounces-13813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240F27DE562
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E911C20AB7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAE18025;
	Wed,  1 Nov 2023 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPsJKuhW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085618021;
	Wed,  1 Nov 2023 17:32:25 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F41EE4;
	Wed,  1 Nov 2023 10:32:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso7798466b.1;
        Wed, 01 Nov 2023 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698859942; x=1699464742; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyjIjE8oDJiKS+8P2onJcWqcyO/pjdYH5TLyKN7Do2E=;
        b=JPsJKuhWLuK5e6nqFuOqNkpmjmf97pa220iofzOgK4f6PgfP2w70dbj0Dpq4Bd8r9h
         xOGmJftf4VK3NXuTRfrye5sDOBJTzo8xqX67zstZreGGJjzrrW1z+B103KTRIVjeAAaU
         lXS5MOixPHPdr3f7KLUabHzOIj94uGzvWgRfxZBcS6jxisOrrowOAnuoAi4nSU0sIxlI
         7KD/Yi7ovekQNceN/cmCvDapHny5LeG3Bv9z9UEK0WcnVTLJrmk8xJuzbGG3BlQEbfV1
         U9zM5aKD+LpV9FHw1ZR/MSxHqjO8Qp+S4XSRPlW3BEHaGnlBgvuZ18Dp+/GNegCIUS8m
         BO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859942; x=1699464742;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyjIjE8oDJiKS+8P2onJcWqcyO/pjdYH5TLyKN7Do2E=;
        b=r85Kw1Aak9W44YURu9QJwGxhmqHJdMB1rNWpyBgZNHHCjgJbLvizPPwkBS5OubyY/s
         YJbrBQ3HRTCNdOVNdCztbOpw/veP0uKV9OUJpkA2FE89kFQ1r8G5h+cq1PoTaLNhuQjs
         wWq91ZakcJFPlnhGLW2LeaP/l1A6eaedN0yzckNuWu4f5yr21tczhSMzPlKqr2efg5+H
         b9ZxNDyL1NBUupLejLGInfU57B4rxrfuYmGbvQffQUblOVtLaB4zpdS1wITLbKOsTNha
         y7Hy7mQOZkgeNhy5UlU01oB3gIVKnYOvBVnFFlbKb0O5VrfaylxeKvBHnQMIcn0KHPVV
         N7pg==
X-Gm-Message-State: AOJu0YyEwSwoyNQGfodrERlardgQbanFznP9+83AaCZ944Qqx+5TbHfJ
	DG0hngII1B+F0pyGs8TIJYLKJsOsQBBSlA==
X-Google-Smtp-Source: AGHT+IGITewd+1U2k4AjBqiBmRhf3DHVYVVUJULjT+LS1cxPGo3XUJlZ4sDASG0woQ4kQInKCIFpdA==
X-Received: by 2002:a17:907:72d6:b0:9bf:3be2:cc7a with SMTP id du22-20020a17090772d600b009bf3be2cc7amr2962141ejc.60.1698859942324;
        Wed, 01 Nov 2023 10:32:22 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c11-20020a170906d18b00b009bf7a4d591csm182540ejz.11.2023.11.01.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:32:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Nov 2023 18:32:14 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [QUESTION] ftrace_test_recursion_trylock behaviour
Message-ID: <ZUKLnmYyHpthlMEE@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
I'm doing some testing on top of fprobes and noticed that the
ftrace_test_recursion_trylock allows caller from the same context
going through twice.

The change below adds extra fprobe on stack_trace_print, which is
called within the sample_entry_handler and I can see it being executed
with following trace output:

           <...>-457     [003] ...1.    32.352554: sample_entry_handler: Enter <kernel_clone+0x0/0x380> ip = 0xffffffff81177420
           <...>-457     [003] ...2.    32.352578: sample_entry_handler_extra: Enter <stack_trace_print+0x0/0x60> ip = 0xffffffff8127ae70

IOW nested ftrace_test_recursion_trylock call in the same context succeeded.

It seems the reason is the TRACE_CTX_TRANSITION bit logic.

Just making sure it's intentional.. we have kprobe_multi code on top of
fprobe with another re-entry logic and that might behave differently based
on ftrace_test_recursion_trylock logic.

thanks,
jirka


---
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 64e715e7ed11..531272af0682 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -23,6 +23,9 @@
 static struct fprobe sample_probe;
 static unsigned long nhit;
 
+static struct fprobe sample_probe_extra;
+static char *symbol_extra = "stack_trace_print";
+
 static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
 module_param_string(symbol, symbol, sizeof(symbol), 0644);
 MODULE_PARM_DESC(symbol, "Probed symbol(s), given by comma separated symbols or a wildcard pattern.");
@@ -48,6 +51,15 @@ static void show_backtrace(void)
 	stack_trace_print(stacks, len, 24);
 }
 
+static int sample_entry_handler_extra(struct fprobe *fp, unsigned long ip,
+				      unsigned long ret_ip,
+				      struct pt_regs *regs, void *data)
+{
+	if (use_trace)
+		trace_printk("Enter <%pS> ip = 0x%p\n", (void *)ip, (void *)ip);
+	return 0;
+}
+
 static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 				unsigned long ret_ip,
 				struct pt_regs *regs, void *data)
@@ -96,6 +108,8 @@ static int __init fprobe_init(void)
 	sample_probe.entry_handler = sample_entry_handler;
 	sample_probe.exit_handler = sample_exit_handler;
 
+	sample_probe_extra.entry_handler = sample_entry_handler_extra;
+
 	if (strchr(symbol, '*')) {
 		/* filter based fprobe */
 		ret = register_fprobe(&sample_probe, symbol,
@@ -137,12 +151,19 @@ static int __init fprobe_init(void)
 	else
 		pr_info("Planted fprobe at %s\n", symbol);
 
+	ret = register_fprobe_syms(&sample_probe_extra, (const char **) &symbol_extra, 1);
+	if (ret < 0)
+		pr_err("register_fprobe extra failed, returned %d\n", ret);
+	else
+		pr_info("Planted extra fprobe at %s\n", symbol_extra);
+
 	return ret;
 }
 
 static void __exit fprobe_exit(void)
 {
 	unregister_fprobe(&sample_probe);
+	unregister_fprobe(&sample_probe_extra);
 
 	pr_info("fprobe at %s unregistered. %ld times hit, %ld times missed\n",
 		symbol, nhit, sample_probe.nmissed);

