Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B262F68DFEA
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBGSXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 13:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjBGSWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F940BED
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 10:22:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a2so14180475wrd.6
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwiKy1zj4XtkpCcy3j7M0LLtAyzN4Se5srzdcyUGneM=;
        b=i6anilsmtrDvvnD7dCrN7APQRKSLf4SQehdySBYQzHfjNwkByZSE27QgysKpKqEJTG
         1XRm9Z9tWJvbwHGA01GZAoDA8aNKN4IxMAZ/PrL/qNrtJlIdWGtu5IBEAJuw8VvHNVYa
         02ngq/sYVPC0fMjOVKxrpuj+5tOMU1YD5dssQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwiKy1zj4XtkpCcy3j7M0LLtAyzN4Se5srzdcyUGneM=;
        b=ULBCNaDwIhfI4SDlj/U8MdixXgPk5OX/XaMeWHOQwW5YNoExh33rEen+obFmtqU0SW
         FxM4p3Z4kRlVxluFXUuzdSx0vsU9m7Q6mS2Ww8irp96bJynYi+PjSKHMpbATVm0JANuA
         2FBZP2+VLAvGXSNqF5TEIp7cqJ8DZ0xjO9Oew3n8A6sYp7kmK30D9fNrmDcR+fnkIzkn
         hiEBMHVCPNa0mz2iE/LIrEkOfgmS038xM0zCpGF3600QFrDRZHKShbt+Aoz6KAYBtmIQ
         TuZHQbkkKMzjzb20qmGNnIKxpddAHilr5jML3S1pXrMu1iDaTMyFdk2vo046kNp1yMzr
         x88w==
X-Gm-Message-State: AO0yUKW9f9llwTNMHNySeFrfjcz/keJ1aVNisTXoay/Xh/mPSeiTuf/H
        f3CW4N2gUzrbY/yA4dWoYiVh0g==
X-Google-Smtp-Source: AK7set8yHwGNGCZNZPCYn9JngyhQZFgrUNTJQQy+keu0mNN2pAKVQLvT7Cvp7NN7IjYJGJpWneockA==
X-Received: by 2002:a5d:5150:0:b0:2c3:f971:ae1 with SMTP id u16-20020a5d5150000000b002c3f9710ae1mr592301wrt.29.1675794132793;
        Tue, 07 Feb 2023 10:22:12 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:22:12 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 08/10] arm64: ftrace: Simplify get_ftrace_plt
Date:   Tue,  7 Feb 2023 19:21:33 +0100
Message-Id: <20230207182135.2671106-9-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207182135.2671106-1-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
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

Following recent refactorings, the get_ftrace_plt function only ever
gets called with addr = FTRACE_ADDR so its code can be simplified to
always return the ftrace trampoline plt.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 arch/arm64/kernel/ftrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 758436727fba..432626c866a8 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -195,15 +195,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
+static struct plt_entry *get_ftrace_plt(struct module *mod)
 {
 #ifdef CONFIG_ARM64_MODULE_PLTS
 	struct plt_entry *plt = mod->arch.ftrace_trampolines;
 
-	if (addr == FTRACE_ADDR)
-		return &plt[FTRACE_PLT_IDX];
-#endif
+	return &plt[FTRACE_PLT_IDX];
+#else
 	return NULL;
+#endif
 }
 
 static bool reachable_by_bl(unsigned long addr, unsigned long pc)
@@ -270,7 +270,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (WARN_ON(!mod))
 		return false;
 
-	plt = get_ftrace_plt(mod, *addr);
+	plt = get_ftrace_plt(mod);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
-- 
2.39.1.519.gcb327c4b5f-goog

