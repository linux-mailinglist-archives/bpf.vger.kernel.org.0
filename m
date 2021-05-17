Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFD386D43
	for <lists+bpf@lfdr.de>; Tue, 18 May 2021 00:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbhEQWyz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbhEQWys (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 18:54:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2400BC0613ED
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 15:53:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a4so8077146wrr.2
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IsSJbJrrRvUOfFfyLw4/1xRvXLssRnMYFv4V+J+GoJs=;
        b=ZKmVdbBr7I/Hvq0LeI/DOPynoHXTDV6hINIeXS5sKo2m6nTBy9+OqSPWTqK0V7hyb4
         cT6aHm9I9AhA+CWT+hJ99tArZ1i9I2iWw4xQpGo7fZCrCc4q7xp28DChULyBD8e5JOP8
         1scGoeen+AoLjTTrzr1RLSfrcjrDoH/fmWfgbmt3qrBNHoj54LqDa1/2KteE7DTB2nFk
         0avchn9sRtppSck0oX61zTANro19/jWV2gjifaEw9bZJKsxs4Dp2MN97gswcKtWboCgg
         Kik0MnOGlchZLTJRzc52Syo/hhAG2xNQHYAIBhwfC4+KrxxjoCe9zlomM9gXIeLCtLMP
         22TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IsSJbJrrRvUOfFfyLw4/1xRvXLssRnMYFv4V+J+GoJs=;
        b=ZfTC09BPJvX/vtwIgCHqAiD7iLIo0ihtJaixaG2cNLQ2KnBHknn5uLmVMOsleH8F4g
         Zoore49gnP7nX19DyYadle9YjKQq4sTa5pMSyubmbJON63aEh1KJjEUoORhS3zv7NEgf
         Zw4g1rS/h4NJruRQkRmt0/RWyg4CSD5WjP/+LMBTxJRvXjVnNacn+/OktCcyDsvrltVq
         mte2Mdkei62jctir4GZsfDxEO4AxXrrH71yuqyarq3d+xQw0eb5tqjbXNRKG+9X8yMZk
         5N3b9aQxpcqCSM5wQNZAYt9S47rMARR4w74TPT11MXKULloHlumjIai/Byg6hLTETJEr
         H5CQ==
X-Gm-Message-State: AOAM531zEkrs3C8+Z09ha6HIoiUa/fGFurPUVuCzKVjH6g/4STEY7eoO
        2wk93PgKF8wyfbawJST1hH2SqVQq34ncTSgqtDA=
X-Google-Smtp-Source: ABdhPJwDuvpVHaWIvI9STxcReNex/owAO7gbDE65ygBwWbsImM/w+bsXabDT8rYEWtB4l1CpsAPOMg==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr2442588wrx.281.1621292007603;
        Mon, 17 May 2021 15:53:27 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id j14sm770438wmj.19.2021.05.17.15.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 15:53:27 -0700 (PDT)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com
Subject: [PATCH bpf-next 02/11] bpfilter: Add logging facility
Date:   Tue, 18 May 2021 02:52:59 +0400
Message-Id: <20210517225308.720677-3-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517225308.720677-1-me@ubique.spb.ru>
References: <20210517225308.720677-1-me@ubique.spb.ru>
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
 net/bpfilter/Makefile  |  2 +-
 net/bpfilter/bflog.c   | 29 +++++++++++++++++++++++++++++
 net/bpfilter/bflog.h   | 24 ++++++++++++++++++++++++
 net/bpfilter/context.h | 16 ++++++++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 net/bpfilter/bflog.c
 create mode 100644 net/bpfilter/bflog.h
 create mode 100644 net/bpfilter/context.h

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index cdac82b8c53a..874d5ef6237d 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -4,7 +4,7 @@
 #
 
 userprogs := bpfilter_umh
-bpfilter_umh-objs := main.o
+bpfilter_umh-objs := main.o bflog.o
 userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
diff --git a/net/bpfilter/bflog.c b/net/bpfilter/bflog.c
new file mode 100644
index 000000000000..2752e39060e4
--- /dev/null
+++ b/net/bpfilter/bflog.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ */
+
+#define _GNU_SOURCE
+
+#include "bflog.h"
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "context.h"
+
+void bflog(struct context *ctx, int level, const char *fmt, ...)
+{
+	if (ctx->log_file &&
+	    (level == BFLOG_LEVEL_FATAL || (level & ctx->log_level))) {
+		va_list va;
+
+		va_start(va, fmt);
+		vfprintf(ctx->log_file, fmt, va);
+		va_end(va);
+	}
+
+	if (level == BFLOG_LEVEL_FATAL)
+		exit(EXIT_FAILURE);
+}
diff --git a/net/bpfilter/bflog.h b/net/bpfilter/bflog.h
new file mode 100644
index 000000000000..4ed12791cfa1
--- /dev/null
+++ b/net/bpfilter/bflog.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ */
+
+#ifndef NET_BPFILTER_BFLOG_H
+#define NET_BPFILTER_BFLOG_H
+
+struct context;
+
+#define BFLOG_IMPL(ctx, level, fmt, ...) bflog(ctx, level, "bpfilter: " fmt, ##__VA_ARGS__)
+
+#define BFLOG_LEVEL_FATAL (0)
+#define BFLOG_LEVEL_NOTICE (1)
+#define BFLOG_LEVEL_DEBUG (2)
+
+#define BFLOG_FATAL(ctx, fmt, ...)                                                                 \
+	BFLOG_IMPL(ctx, BFLOG_LEVEL_FATAL, "fatal error: " fmt, ##__VA_ARGS__)
+#define BFLOG_NOTICE(ctx, fmt, ...) BFLOG_IMPL(ctx, BFLOG_LEVEL_NOTICE, fmt, ##__VA_ARGS__)
+#define BFLOG_DEBUG(ctx, fmt, ...) BFLOG_IMPL(ctx, BFLOG_LEVEL_DEBUG, fmt, ##__VA_ARGS__)
+
+void bflog(struct context *ctx, int level, const char *fmt, ...);
+
+#endif // NET_BPFILTER_BFLOG_H
diff --git a/net/bpfilter/context.h b/net/bpfilter/context.h
new file mode 100644
index 000000000000..e85c97c3d010
--- /dev/null
+++ b/net/bpfilter/context.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ */
+
+#ifndef NET_BPFILTER_CONTEXT_H
+#define NET_BPFILTER_CONTEXT_H
+
+#include <stdio.h>
+
+struct context {
+	FILE *log_file;
+	int log_level;
+};
+
+#endif // NET_BPFILTER_CONTEXT_H
-- 
2.25.1

