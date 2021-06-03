Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA6399E99
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFCKQf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 06:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFCKQd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Jun 2021 06:16:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13289C06175F
        for <bpf@vger.kernel.org>; Thu,  3 Jun 2021 03:14:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o2-20020a05600c4fc2b029019a0a8f959dso3369791wmq.1
        for <bpf@vger.kernel.org>; Thu, 03 Jun 2021 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuwQX9b3Q53MKMPqypL/AyJSs6wqqbe8JbkZm20C3Rg=;
        b=Ng1ja9QPTqcElrIgn69ls55E4UHCCtssErsfSm5LTgt0NIpaG3Vo4B6irV7ISd44+n
         ckSHdPiY7t3AZBbkwV4WEZmpRyeinTdfZy6ltxo0P7i2nuhtlFvmI3qacsL1tHhmnO2F
         oaRPQFj4S6q4ia9/RZi0mWh7SDr9lqmfn1fmJyoY9bobPPJqM+Fhah8t6TzetBUw9aoa
         mxmPu7Gd9ec6326uzUwWFzBbJPsGLcoacI35r05Gmklru7r8iyZyXFj4XFwCutLPIoUq
         iuu8ikdCbXvPJixNv3bEYm9kV3g+3nMPyD3SQBaq2KL+zr17L0x1Pn7nP8sbviHyRJc/
         ALiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuwQX9b3Q53MKMPqypL/AyJSs6wqqbe8JbkZm20C3Rg=;
        b=ZoOhI4gxyOx22BdHFUEXOpoiXWTVeHk73Mrool+M7uJPtOhv+08dJdkNBnI16RkJ0z
         nblRhGj+SWMlGYAJxTj05Pwh8FLrSKBPOR8UE3LTxYxSUWBB7WIBLziimhkwIbCmWBou
         6tIg+1mURR5eJEkBex4BgB9VF9jCjMY9YCsc5kUydbrnxBT+0PpEUt+2E95RrN5NgoDI
         nEBsBdX3VBB5zzoxOm6HdftIOkemaiz2Vqn9bIFAJyGPu1xxTp2OorNsHc+gjhWSNAn/
         /bGha85NLzGewUqL4H+3qwF1famROU1xoU+O15+OF8Z3NxehYaObxEDv5kABzbMH3/1Q
         XboA==
X-Gm-Message-State: AOAM533vmq9k7I8xCAnVg1h0o98xtlnUBiWCwP63TXinUKoCUXCXVqtB
        UUSzc8blHg4zWyZaJYTS2LyefBPCdF9JozeDcoI=
X-Google-Smtp-Source: ABdhPJyB7kax9YPkjpWJ1y8nT17B6XVNZrLMU1HKjcHvgOqaOOcsMskoFT+ToeQpczTEIT34me/9ww==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr9428382wmc.104.1622715287591;
        Thu, 03 Jun 2021 03:14:47 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id z19sm4581224wmf.31.2021.06.03.03.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:14:47 -0700 (PDT)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com
Subject: [PATCH bpf-next v1 02/10] bpfilter: Add logging facility
Date:   Thu,  3 Jun 2021 14:14:17 +0400
Message-Id: <20210603101425.560384-3-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210603101425.560384-1-me@ubique.spb.ru>
References: <20210603101425.560384-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are three logging levels for messages: FATAL, NOTICE and DEBUG.
When a message is logged with FATAL level it results in bpfilter
usermode helper termination.

Introduce struct context to avoid use of global objects and store there
the logging parameters: log level and log sink.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 net/bpfilter/context.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 net/bpfilter/context.h

diff --git a/net/bpfilter/context.h b/net/bpfilter/context.h
new file mode 100644
index 000000000000..e7bc27ee1ace
--- /dev/null
+++ b/net/bpfilter/context.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ */
+
+#ifndef NET_BPFILTER_CONTEXT_H
+#define NET_BPFILTER_CONTEXT_H
+
+#include <sys/syslog.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+
+struct context {
+	FILE *log_file;
+};
+
+#define BFLOG_IMPL(ctx, level, fmt, ...)                                                           \
+	do {                                                                                       \
+		if ((ctx)->log_file)								   \
+			fprintf((ctx)->log_file, "<%d>bpfilter: " fmt, (level), ##__VA_ARGS__);    \
+		if ((level) == LOG_EMERG)                                                          \
+			exit(EXIT_FAILURE);                                                        \
+	} while (0)
+
+#define BFLOG_EMERG(ctx, fmt, ...)                                                                 \
+	BFLOG_IMPL(ctx, LOG_KERN | LOG_EMERG, "fatal error: " fmt, ##__VA_ARGS__)
+
+#define BFLOG_NOTICE(ctx, fmt, ...) BFLOG_IMPL(ctx, LOG_KERN | LOG_NOTICE, fmt, ##__VA_ARGS__)
+
+#if 0
+#define BFLOG_DEBUG(ctx, fmt, ...) BFLOG_IMPL(ctx, LOG_KERN | LOG_DEBUG, fmt, ##__VA_ARGS__)
+#else
+#define BFLOG_DEBUG(ctx, fmt, ...)
+#endif
+
+#endif // NET_BPFILTER_CONTEXT_H
-- 
2.25.1

