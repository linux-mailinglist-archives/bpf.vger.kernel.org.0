Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C06C831C
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjCXRPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjCXRPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 13:15:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DC5FCB
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 10:15:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso1458345wmo.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 10:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679678100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTb8hl3+k2g5BleJPKEi21fxSb3Jo8zSKEOFv/5dzqM=;
        b=Sjs+e2MuGXM4+tmPbmahZDPk5vhmIGwM1TCJdHBvC/vfRdvIUj07fTTL5Wt/uaDaYu
         DfMJybSOkAeHgMxMvbMeNbajKEAsfOhtRrFJy8nQ9QMcHE2MtYMXpY5UHdm42LdjIudN
         vk7fz6LH3vojtLooWHY9sKvQRlThThT8omqho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTb8hl3+k2g5BleJPKEi21fxSb3Jo8zSKEOFv/5dzqM=;
        b=b9zacp5ke111XjcNjKQXSMmsUEyuBJiS4oTLoyr07i04zPsgf5SOdAISDP83gn1Lo1
         ROcoYI8NpbiFpfbvhEDIIyjEuXQp4tSq4OFALjsAKzr/uWe2eM7AyaU9QHYEn4poNGJc
         VzVm/QmbMDNXMgGk1t98qglJ1cWOXdu9QXta2v2y9wp1f/wb0WcZYqrd8+xa0Oek+7oC
         2v4HxGO3ny85URYhQCOc/ImV/AVCeB/1uMwei5XFoAK8/azaeETakeFvCexbjeTAnafi
         bcfX3Jb9fEHnbJUSusRZBllDuzOKw+1NtOz10IY8KXQu2Be3tKu1M9gfXBAIQYVL2ZJ7
         kZoQ==
X-Gm-Message-State: AO0yUKUkwdNup8uYQ1HL1cpc8ubKaAcm6SZS3zD4mefE+3oZlH7RgeT9
        gooVnu2EEWeQlL7bazNhP6qHLQ==
X-Google-Smtp-Source: AK7set/IU3/IZnULMqGdchh7xP/nUBYFvkCopwb13gAO4K8vJUP4QfRzDq1ks8LMggPOywxWb/EIhQ==
X-Received: by 2002:a05:600c:c6:b0:3ef:df3:1693 with SMTP id u6-20020a05600c00c600b003ef0df31693mr2530391wmm.32.1679678100550;
        Fri, 24 Mar 2023 10:15:00 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:ffb1:35ba:1031:ba71])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c231a00b003dc522dd25esm5385107wmo.30.2023.03.24.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:15:00 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 2/4] arm64: ftrace: Simplify get_ftrace_plt
Date:   Fri, 24 Mar 2023 18:14:49 +0100
Message-Id: <20230324171451.2752302-3-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230324171451.2752302-1-revest@chromium.org>
References: <20230324171451.2752302-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
2.40.0.348.gf938b09366-goog

