Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D23FADCB
	for <lists+bpf@lfdr.de>; Sun, 29 Aug 2021 20:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhH2Sh2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Aug 2021 14:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhH2ShX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Aug 2021 14:37:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF6FC0613D9
        for <bpf@vger.kernel.org>; Sun, 29 Aug 2021 11:36:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u14so26113130ejf.13
        for <bpf@vger.kernel.org>; Sun, 29 Aug 2021 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sagqmcStq41RDjLaOhz2T4BhmwMQgqsG9aJMXKJM7DQ=;
        b=XQTidk0yXriODQO+5xeSLpu2iTWCn1LAWfXHSxIj50gw+bopKnrJFY+/p63ueJ/oWS
         GwqRzWnD9ELUiQcEtiUdE9cESk7zIqG8ZFluKGZI+0zPmoMSX/4SRWjuKpuYogHogTZY
         Yu+0wNmkEXvFNHfIe7+bIYDDinAdCsbGDFoQKcagi1EnNcBz/nQxaGiIbUsYyRs444Cb
         EEYqe+1W6eal4wqJs6eKL2S7Osh4wpfLuLYBkWrKYSCU4ODFJE9UeanaU28EaDO7LjjL
         j+M8C0EVePmgZs5znhGCN1/8MP0Mo6vERg8nAs5/lB1iAM+tY1FK2K6cfosJ5FHZPgOC
         NfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sagqmcStq41RDjLaOhz2T4BhmwMQgqsG9aJMXKJM7DQ=;
        b=XYxC63ogU/lMyES7BhcfpCV9BFkyaqxEr/6QtZtItqVE6FiGDCyaz+abC1xSIw+uj4
         BvfqgTrYQKuM3UBbaNf9tAgPRbajHSyoeNMbM+le0gbr6JB7vn7y2lVLITOFvbWcI0G/
         +FU5eRpLWj51Xt+pBowd7EFw9YB9NPY0dxbqjbxp0a8AQ+4j160HYqSuYCWQ/jJ66DRa
         u042Y0l3kfl0O9bmzcRHpLWRO9MYlOzNFdlunFdRMvGkUVNI74NLU0tenCGG2K9NmB7z
         +yLXANHT/PfTaGjFYn+FluEQyrd6HmwfTkN0FdDBO7t57/ekGuFo5piIU16d4bgy2x04
         s2xQ==
X-Gm-Message-State: AOAM531pHGE4J30/qNTFYwVZHgjRtgQfdZx4BbYBd7WUSsFqkh/obv5q
        srYaBAfkXg600ahl/1rqHiGlUq7ZrdYuXI8F7Yw=
X-Google-Smtp-Source: ABdhPJwhZT9FpzeaUxEDjaVyUUpHLcLJoRXsUw3ufyLCVVXE3cxQJaiU5wWl4Bwy3rn03wx2uvI3/A==
X-Received: by 2002:a17:906:e2d5:: with SMTP id gr21mr21262202ejb.401.1630262189406;
        Sun, 29 Aug 2021 11:36:29 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id o21sm1579053edc.47.2021.08.29.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 11:36:29 -0700 (PDT)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com
Subject: [PATCH bpf-next v2 02/13] bpfilter: Add logging facility
Date:   Sun, 29 Aug 2021 22:35:57 +0400
Message-Id: <20210829183608.2297877-3-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829183608.2297877-1-me@ubique.spb.ru>
References: <20210829183608.2297877-1-me@ubique.spb.ru>
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
index 000000000000..6503eda27809
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
+		if ((ctx)->log_file)                                                               \
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

