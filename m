Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBF7686BDE
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjBAQft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjBAQfq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A393F79F15
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1921068wms.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0B1nR0feNzt6iYs1fcCSNwhqATraAQZbyN0DagmRgs=;
        b=jcn6cTs4+XY1hUWmIDmmwPG44YIXWbCtGh35J88AOeps79NC6Aub1gKAPPv419PyFm
         HTPegDj2V+wQXQ7DcQvVkjHumtHWHz7verUSkgH7IJrJQQz1clTf1SwWQ3717K7f1cqs
         BiPYS75krdieSyLXCxa9QTp4cnoHXv5nKh5HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0B1nR0feNzt6iYs1fcCSNwhqATraAQZbyN0DagmRgs=;
        b=8FyGY6hUOc9FvTTnhkl9x0Z42j+FpqDdBZIMNpLzuTACnt/d0hARdpjcQVj4ire3P/
         3a4zRun4dueIPey3e+JEau0GbN2PF66chicO4tJBxVVzKqduhKYesToVUw+KqCH1gP83
         k6zP7gZ5iCyt0fsFWTglvwskgrS5ojHM1xT3ibwYqPtEUgMMOmICB0WV3wPXMHYBcI8j
         pS1Bkbk4XZb6bQs8oqj2hHX7hST38fZCqGKXTkgllHiHtcHlw6+q1FOeZbkb3+LoiiPT
         Oz/qBAQFs8U6RNBz8zAQxiA+a/rCduQ6PJsoTmKFUh4AhpSE/MxJP4JNrZ14Oppf+Tk+
         4tNg==
X-Gm-Message-State: AO0yUKU5wOmjztxeQoOXNgtVLsqaQgGZ8rZyrlQ0N0+VAOl7Dz4n+S9Y
        a8rgbwOQtbU0Jmy2mXHsonl5XzwVLWBb7XmlznM=
X-Google-Smtp-Source: AK7set9sCy9RhmFzbGR11y6SAdcOcsShJEwbhl2h5tKcFqmeH9CrjXQjVjAY0i+Q+yzsszXf1HIeKQ==
X-Received: by 2002:a05:600c:491c:b0:3d9:ee01:60a4 with SMTP id f28-20020a05600c491c00b003d9ee0160a4mr2827768wmp.1.1675269328196;
        Wed, 01 Feb 2023 08:35:28 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:27 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 4/8] ftrace: Store direct called addresses in their ops
Date:   Wed,  1 Feb 2023 17:34:16 +0100
Message-Id: <20230201163420.1579014-5-revest@chromium.org>
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

All direct calls are now registered using the register_ftrace_direct API
so each ops can jump to only one direct-called trampoline.

By storing the direct called trampoline address directly in the ops we
can save one hashmap lookup in the direct call ops and implement arm64
direct calls on top of call ops.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/ftrace.h | 3 +++
 kernel/trace/ftrace.c  | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a7dbd307c3a4..84f717f8959e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -321,6 +321,9 @@ struct ftrace_ops {
 	unsigned long			trampoline_size;
 	struct list_head		list;
 	ftrace_ops_func_t		ops_func;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long			direct_call;
+#endif
 #endif
 };
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index cb77a0a208c7..b0426de11c45 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2577,9 +2577,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr;
+	unsigned long addr = ops->direct_call;
 
-	addr = ftrace_find_rec_direct(ip);
 	if (!addr)
 		return;
 
@@ -5375,6 +5374,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
+	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
 
@@ -5445,6 +5445,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
+	tmp_ops.direct_call = addr;
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
@@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 			entry->direct = addr;
 		}
 	}
+	ops->direct_call = addr;
 
 	mutex_unlock(&ftrace_lock);
 
-- 
2.39.1.519.gcb327c4b5f-goog

