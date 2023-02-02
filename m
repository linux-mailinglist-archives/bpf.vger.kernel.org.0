Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB346875DC
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 07:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjBBG0M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 01:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjBBG0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 01:26:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B68244B0
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 22:26:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so537304wms.1
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 22:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMLCNaae3i76rjj2IAaEmT8qW6vZI37Z/4JXfn9a9ZM=;
        b=ETCSalYO/Dd9vpv0RuUgZO04cKnFMFlvaaS0RHueXo9QmyrCcVJO5sf+Ywo5Oh5iFw
         wTd7qxeN3oBffM3P39Tmq8mlAZIiYN/90XKEMoHwwnfjklaqkkly6p6dooQy1dMrKK6N
         pMxL0+1omMl0JwDW1XKVJzG1QZO2H9BBHqVbJl4Q1G9xosoEzDpTgj1cuQjypoKYMjVe
         ePGyCO1QrGWROj8dQh4/7X2ic9iO/ZOcVNpNZ0QygPJJEZgU8dgUDRU0bXcwuwjFYpAy
         e5lUwzNXxqivyexa7YFP31D+ZnDxMva6ya7U597pRujAeGUkJcFU5to39WJLo0gQdMZh
         8CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMLCNaae3i76rjj2IAaEmT8qW6vZI37Z/4JXfn9a9ZM=;
        b=0nLCZEjrXrBj2OkUmH3vEKpHH3HMCX67ppGf/iMl7nunJt9mSW/H9w6LLSa17280EH
         eepZN+hly1SAamluLP0nE0uGD5E6ZvINAPjTfZe8/wwd45KZ57JrAn4fyj+bM7qhKd2X
         zqCyg2s7O4OtYIM6QAN1xglLZJXR48kcd4Zu82vSVzNw0MFltJP79zyHZylSlrbuCZjY
         +vTVfZuzOpmvpY9dC1yURYC130AUbpzb8cgYFcUM9BaJ77iGzVvgHA27jC6ePBeHlQ+u
         eRywJJo9/UkXXlvXdW4M4KIl7L94owVvIbJptgMKGlHRiGkzNy5TD9xhO0ADuFfe8zuq
         60hw==
X-Gm-Message-State: AO0yUKU/fLL8S5cGHXw7ogjKyiyjVHzR5q/XZgZXi3Mb2OvFHAuoAtbT
        x0pJXfvaC4sRYDCFA6g6KaWbxpSyqZk=
X-Google-Smtp-Source: AK7set/uqKKyp/ZKs2P81GQVlF6bp5/DGVXeRsiUalrBor/LornRqLkZipm2jgMPays0xRqg6gGfIA==
X-Received: by 2002:a05:600c:4586:b0:3de:e447:8025 with SMTP id r6-20020a05600c458600b003dee4478025mr4141961wmo.21.1675319167576;
        Wed, 01 Feb 2023 22:26:07 -0800 (PST)
Received: from localhost.localdomain ([87.68.177.114])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c081b00b003de77597f16sm3577672wmp.21.2023.02.01.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 22:26:07 -0800 (PST)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v2] libbpf: Add wakeup_events to creation options
Date:   Thu,  2 Feb 2023 08:25:49 +0200
Message-Id: <20230202062549.632425-1-arilou@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jon Doron <jond@wiz.io>

Add option to set when the perf buffer should wake up, by default the
perf buffer becomes signaled for every event that is being pushed to it.

In case of a high throughput of events it will be more efficient to wake
up only once you have X events ready to be read.

So your application can wakeup once and drain the entire perf buffer.

Signed-off-by: Jon Doron <jond@wiz.io>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 tools/lib/bpf/libbpf.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index eed5cec6f510..6b30ff13922b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11719,8 +11719,8 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
+	attr.sample_period = OPTS_GET(opts, wakeup_events, 1);
+	attr.wakeup_events = OPTS_GET(opts, wakeup_events, 1);
 
 	p.attr = &attr;
 	p.sample_cb = sample_cb;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 8777ff21ea1d..e83c0a915dc7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
 /* common use perf buffer options */
 struct perf_buffer_opts {
 	size_t sz;
+	__u32 wakeup_events;
 };
-#define perf_buffer_opts__last_field sz
+#define perf_buffer_opts__last_field wakeup_events
 
 /**
  * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
-- 
2.39.1

