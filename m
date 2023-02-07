Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF268DFE3
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 19:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjBGSXI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 13:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjBGSWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:40 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CDD3EC5E
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 10:22:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so10694297wms.0
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVdLTLQft6enzmBPM6z7EP+DOR880oV54j7MQfksQV4=;
        b=e6OSwVp/NPzxEGu5b3/btFrO+8uOj89LTeWGJl9emjZZ4wnzZvkc/m2mUmYZXxRJtk
         q33u2WS9pSJ5U+MA0i8xz7x8gsJwapZaYKYsycL+Bms9N1UxsQnUX7zpgHuSZDEtcIYF
         2469o9/Z5vKfR7MRnipxbuqUfDCQoz5TpL5Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVdLTLQft6enzmBPM6z7EP+DOR880oV54j7MQfksQV4=;
        b=adKALHsDvQjWz4iBdiKZeGFemz4TNaO6GohnPReJJTX/9E+h9avS20EcRxJZvKe6uR
         QitVjsSzyd5YHveKNlWb+n1GZAmPJnAUp9FPIJaVYMxfOtLgmzLEJrCOTv6xCI5bIPIg
         3tvlV6bAjuh3OkGlCuiEormEZ+DlDp0vZ5ENS1AfzcTOLQ/wFarwDU0GRvBbUlBw3Ypp
         Zi3Vj5cNwaV55ejurDXN2UANQAJ3RN0WAV3WGhjsTwQkgVhlE1hHDZsz22HlWEq2ZvXk
         UDQ98O6IHdX2WkkXjl15t+CCql2ddloZ8VMjMNKXoTvJa8Y8PvBN5xuVU07lNkZHySzw
         MaXA==
X-Gm-Message-State: AO0yUKU51IH/Q9H0QIURhoqntvLylFnfVq47VrZS8ZDv0uL5YQx8dT//
        5m8MvubzcHK6TjmnP/h5N9O0fg==
X-Google-Smtp-Source: AK7set8fKEUWbnajG8z1g5+xmJ28NYOGcfnS0zhzV3RU5mzTU88toFWHPOFI25ou4Wy3tpHrEkKwoA==
X-Received: by 2002:a05:600c:1892:b0:3da:fa18:a535 with SMTP id x18-20020a05600c189200b003dafa18a535mr3844120wmp.29.1675794127977;
        Tue, 07 Feb 2023 10:22:07 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:22:07 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 05/10] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
Date:   Tue,  7 Feb 2023 19:21:30 +0100
Message-Id: <20230207182135.2671106-6-revest@chromium.org>
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

Direct called trampolines can be called in two ways:
- either from the ftrace callsite. In this case, they do not access any
  struct ftrace_regs nor pt_regs
- Or, if a ftrace ops is also attached, from the end of a ftrace
  trampoline. In this case, the call_direct_funcs ops is in charge of
  setting the direct call trampoline's address in a struct ftrace_regs

Since:

commit 9705bc709604 ("ftrace: pass fregs to arch_ftrace_set_direct_caller()")

The later case no longer requires a full pt_regs. It only needs a struct
ftrace_regs so DIRECT_CALLS can work with both WITH_ARGS or WITH_REGS.
With architectures like arm64 already abandoning WITH_REGS in favor of
WITH_ARGS, it's important to have DIRECT_CALLS work WITH_ARGS only.

Signed-off-by: Florent Revest <revest@chromium.org>
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/ftrace.h | 6 ++++++
 kernel/trace/Kconfig   | 2 +-
 kernel/trace/ftrace.c  | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 84f717f8959e..cabb40146da9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -241,6 +241,12 @@ enum {
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
 };
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
+#else
+#define FTRACE_OPS_FL_SAVE_ARGS                        0
+#endif
+
 /*
  * FTRACE_OPS_CMD_* commands allow the ftrace core logic to request changes
  * to a ftrace_ops. Note, the requests may fail.
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
index dfa5f34ec320..58b6f4411ac7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5282,7 +5282,7 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
-- 
2.39.1.519.gcb327c4b5f-goog

