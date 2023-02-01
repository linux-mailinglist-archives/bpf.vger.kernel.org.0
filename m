Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0D686BE0
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjBAQfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjBAQfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255EA62276
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso1922044wms.3
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V920tXDgaE7z8bCeiKLUkBejFiJJs4xj6S06IJdrTDo=;
        b=DYuGfqui4JmugKay/2snlgInuN8NoSZVoexURJTLb8Kn8f4JIyvQgTexs4woxHNsnz
         wO8Z6dafnQ/XbyCE2eZZeApXulDjM44aq8GV5zcg7oNuhHSxUTyM5itzgz5nZpMAO8jf
         QGTjtSgg4ehtaz3yn7QunU2caI+VvbmJ2wS54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V920tXDgaE7z8bCeiKLUkBejFiJJs4xj6S06IJdrTDo=;
        b=Wh3v4+YwngqQZ4d0tnKE5qGRSNL45PztV0aStxh3cuX/A+/mgx+pIURAmFXTKgrcaC
         DkY1w6p7yUrNCgIjGtDcqX33ScPh3/EI6oN/YJ1m6BEPggR43HweZkaYWDCSE533CoNT
         lLBPRCZHcNtIfXbHIEBqjdQixFJCCoTplPGUqNkA3R9uzwPmfGV2VDx1V50Jp2C3xzQH
         4aIzM5nEP0j90hyLTZo4dZ1qCn/TsMljPSJ5Rtm3qu+0o8gJ3iHofa+GVqEZI/AFKgjg
         s4u9zzgcUp0jChat4w3W7iCFOJWF1NMTK/qmDiDxEBPl80UCjF+rQd/Wp0lWSKNzhAKe
         aD4g==
X-Gm-Message-State: AO0yUKXpDCXxj0t3hkcLXDXvZ85ODP3wgXD3JS/pQr0xAwIQZ0tM4Zwt
        l05A3tA55qkkkj7dU901+pvh1Q==
X-Google-Smtp-Source: AK7set/w1a9aVC2lSJ1aNaktqbPxU7ogYk690xUJ/cBVHkXalBaadY++SDNwkAXdZxgSJMASgFFFGQ==
X-Received: by 2002:a05:600c:2e06:b0:3dd:dd46:1274 with SMTP id o6-20020a05600c2e0600b003dddd461274mr2822832wmf.4.1675269329591;
        Wed, 01 Feb 2023 08:35:29 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:29 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 5/8] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
Date:   Wed,  1 Feb 2023 17:34:17 +0100
Message-Id: <20230201163420.1579014-6-revest@chromium.org>
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

Direct called trampolines can be called in two ways:
- either from the ftrace callsite. In this case, they do not access any
  struct ftrace_regs nor pt_regs
- Or, if a ftrace ops is also attached, from the end of a ftrace
  trampoline. In this case, the call_direct_funcs ops is in charge of
  setting the direct call trampoline's address in a struct ftrace_regs

Since "ftrace: pass fregs to arch_ftrace_set_direct_caller()", the later
case no longer requires a full pt_regs. It only needs a struct
ftrace_regs so DIRECT_CALLS can work with both WITH_ARGS or WITH_REGS.
With architectures like arm64 already abandoning WITH_REGS in favor of
WITH_ARGS, it's important to have DIRECT_CALLS work WITH_ARGS only.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/Kconfig  | 2 +-
 kernel/trace/ftrace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5df427a2321d..4496a7c69810 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -257,7 +257,7 @@ config DYNAMIC_FTRACE_WITH_REGS
 
 config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	def_bool y
-	depends on DYNAMIC_FTRACE_WITH_REGS
+	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config DYNAMIC_FTRACE_WITH_CALL_OPS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b0426de11c45..73b6f6489ba1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5282,7 +5282,7 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
-- 
2.39.1.519.gcb327c4b5f-goog

