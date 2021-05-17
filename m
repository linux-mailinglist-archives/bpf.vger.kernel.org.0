Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFA386D54
	for <lists+bpf@lfdr.de>; Tue, 18 May 2021 00:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbhEQWza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 18:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbhEQWzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 18:55:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4180C06138C
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 15:54:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so421902wmk.0
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6BZu86G+a+CQ5lboyHSi67mKyj7jNYy4dIGKIAp22DI=;
        b=ZjDR7WQTSVwGdyZSJpRB3DAGB9Oy/YR5OWbYZIgEtMADji3qezP+4HBn1y/Zs2+Cd/
         s338aOt6EQJfilz9zcRXqF0Vqq95qv7a54JjTbh7ZUHUiXBxGanQzaDYrqUEqwz8Vg0o
         OcITSS5XvHNd3vooD3eV3q/uiRZafuEE6HhWbsKKLHJYisaufnfx4PG0QV4ZIjD129ls
         LWtR0Uq4eWhrO2j18sur44cESeExi5nahOI3kR8RbOMGJDI9rCA4gNS9YFt548aDXLjn
         sL9DdMc3UYtaNY40MK8yG0iUwhY6Ua3NmWH+Q1D9Ufqr0Odr6YWs1O8n+IONw90G4/QI
         0JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6BZu86G+a+CQ5lboyHSi67mKyj7jNYy4dIGKIAp22DI=;
        b=bL/aBaLxt9ZNzlBr+JM5CZkNYT4YTcQYnx3BJPqApZQvb7LEHe2my07DK+leSYmc0V
         yXoWjR98OILnKYk7cjfrjSeQkE9jXECsVHYNnB2UwYlhvshC8zF39MDiJUaMkcqMJTUB
         JU8wg6oVZEgFrgGPA4SH+sVdfNsnXM46A/DdI/YQ2UHlyjfVFGqybl4ALYvRBxTcKTBp
         DtqIxx5JM9zAEECn2B388gXiSE9SmZP88C+idDBnKUxqG8BbHyw9OW95WdmSDdnMeqX4
         foqieBnHctpcsuRlfPfKQXzS6qhPgGGcx53+XDTvd9vDArmP8cQ/B8EHEyN9khXCrgtk
         uAAg==
X-Gm-Message-State: AOAM531lURfLMRtPf9eQKooJ8N/i4g/k+v1qDnX9fOki8g9FaYpEOWpa
        8UKx7tqtLGMN72g/YpbWYr6eYOKpkAUHnljuWu4=
X-Google-Smtp-Source: ABdhPJxoSs8hoHf5GGDborHjkwA6ABbZNXeATkpzR/G2JBWzu29Ki9PbnrX25EsDtvv2IpHkrIXXdg==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr1832282wmh.131.1621292039409;
        Mon, 17 May 2021 15:53:59 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id p7sm18925555wrt.24.2021.05.17.15.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 15:53:59 -0700 (PDT)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, rdna@fb.com
Subject: [PATCH bpf-next 11/11] bpfilter: Handle setsockopts
Date:   Tue, 18 May 2021 02:53:08 +0400
Message-Id: <20210517225308.720677-12-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517225308.720677-1-me@ubique.spb.ru>
References: <20210517225308.720677-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use earlier introduced infrastructure for and handle setsockopt(2)
calls.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 net/bpfilter/main.c | 99 ++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
index 05e1cfc1e5cd..19c8c2d7ef87 100644
--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -1,64 +1,71 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Telegram FZ-LLC
+ */
+
 #define _GNU_SOURCE
-#include <sys/uio.h>
+
+#include <unistd.h>
 #include <errno.h>
+
 #include <stdio.h>
-#include <sys/socket.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "../../include/uapi/linux/bpf.h"
-#include <asm/unistd.h>
-#include "msgfmt.h"
+#include <string.h>
 
-FILE *debug_f;
+#include "bflog.h"
+#include "context.h"
+#include "io.h"
+#include "msgfmt.h"
+#include "sockopt.h"
 
-static int handle_get_cmd(struct mbox_request *cmd)
+static int setup_context(struct context *ctx)
 {
-	switch (cmd->cmd) {
-	case 0:
-		return 0;
-	default:
-		break;
-	}
-	return -ENOPROTOOPT;
-}
+	ctx->log_file = fopen("/dev/kmsg", "w");
+	if (!ctx->log_file)
+		return -errno;
 
-static int handle_set_cmd(struct mbox_request *cmd)
-{
-	return -ENOPROTOOPT;
+	setvbuf(ctx->log_file, 0, _IOLBF, 0);
+	ctx->log_level = BFLOG_LEVEL_NOTICE;
+
+	return 0;
 }
 
-static void loop(void)
+static void loop(struct context *ctx)
 {
-	while (1) {
-		struct mbox_request req;
-		struct mbox_reply reply;
-		int n;
-
-		n = read(0, &req, sizeof(req));
-		if (n != sizeof(req)) {
-			fprintf(debug_f, "invalid request %d\n", n);
-			return;
-		}
-
-		reply.status = req.is_set ?
-			handle_set_cmd(&req) :
-			handle_get_cmd(&req);
-
-		n = write(1, &reply, sizeof(reply));
-		if (n != sizeof(reply)) {
-			fprintf(debug_f, "reply failed %d\n", n);
-			return;
-		}
+	struct mbox_request req;
+	struct mbox_reply reply;
+	int err;
+
+	for (;;) {
+		err = read_exact(STDIN_FILENO, &req, sizeof(req));
+		if (err)
+			BFLOG_FATAL(ctx, "cannot read request: %s\n", strerror(-err));
+
+		reply.status = handle_sockopt_request(ctx, &req);
+
+		err = write_exact(STDOUT_FILENO, &reply, sizeof(reply));
+		if (err)
+			BFLOG_FATAL(ctx, "cannot write reply: %s\n", strerror(-err));
 	}
 }
 
 int main(void)
 {
-	debug_f = fopen("/dev/kmsg", "w");
-	setvbuf(debug_f, 0, _IOLBF, 0);
-	fprintf(debug_f, "Started bpfilter\n");
-	loop();
-	fclose(debug_f);
+	struct context ctx;
+	int err;
+
+	err = create_context(&ctx);
+	if (err)
+		return err;
+
+	err = setup_context(&ctx);
+	if (err) {
+		free_context(&ctx);
+		return err;
+	}
+
+	BFLOG_NOTICE(&ctx, "started\n");
+
+	loop(&ctx);
+
 	return 0;
 }
-- 
2.25.1

