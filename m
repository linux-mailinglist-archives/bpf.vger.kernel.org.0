Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7368BE58
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 14:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFNf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 08:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBFNf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 08:35:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4945C104
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 05:35:55 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id z13so1214599wmp.2
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 05:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqfjyzqFb4ymT7jvttdq8kUZtil4InYTkivB788ERSA=;
        b=S/fWuNmmPHpOUTCLuYcoGyYQHiJKSIZg8j08ezDxYAIKFD5FoOhmp5+G8T2VInzkCX
         QSADvmX67eSirhoAzm2h01kKyle0z8m1xr6zfGA1B35ACB7y1Suc1C0L6Ru7MODKhkDN
         ttfg8Af+HscIbC0cV5uXsFCYBldektDpC66MxZvrVlG2YpmL6aWny7pWETAG+txoEdEe
         so8Gk8kYp99qz3lNKobQ8BWDYwTR/3rxQTz8f8Q2sYEcdU5UPw3kLw10x4g1atqirmwh
         mF+LmJkrB3ioF7ojDlTm5DboyAjPzQaevGpjwYKBZoo4jK6vBIxNgsP0htvE89Ev22vW
         PZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqfjyzqFb4ymT7jvttdq8kUZtil4InYTkivB788ERSA=;
        b=TV1P+8YO2hIOtaeEWeobr+1KsNZ7tNRyX3vjuGqyZpzI8B/XXOc6FkSbmkqRbJwyLM
         ZgGn5kPrD4ZKYAVQi1lbKm/bX05AmaYuPCYE/TZUPh8v6kSSprA2YO0LIr3izmW5UFfr
         y2KO9GGrsdJtxHWUFfwJ/XT3rsm7nPm79e1bRAP60l8XWXkE5bAA9u7A7LiQwscec3F9
         RCHliEJt8+jgfFCONafA42pfmECEHuuYPWbzzrO9oGfNRrn0pvF6Qirf+KxWTN0+SOS2
         TlhmsV7bj+/CSBOCh/mN5oQD+OmIbuY37UuoqOHChXtq6Dz7OsZptsZIDheBfj56burm
         mP1A==
X-Gm-Message-State: AO0yUKWbPudmpPCzTs1KE/yCc9ktas2GsYiqHmsW9/dqE4PvLsXr1Y20
        J2SOL2XyX60IUJqRIxRQxnGOmhn9RF4=
X-Google-Smtp-Source: AK7set/XrrCo5Q/woB19XyYCSBE3Mq2LndAkXrKfvzau1wYVD5kJBcBjX1VekctLvEPPy9pZsVPTPw==
X-Received: by 2002:a05:600c:3847:b0:3df:fff4:5f6f with SMTP id s7-20020a05600c384700b003dffff45f6fmr4410616wmr.36.1675690553553;
        Mon, 06 Feb 2023 05:35:53 -0800 (PST)
Received: from localhost.localdomain ([87.68.177.114])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bc042000000b003dd8feea827sm15837670wmc.4.2023.02.06.05.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:35:53 -0800 (PST)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v3] libbpf: Add sample_period to creation options
Date:   Mon,  6 Feb 2023 15:35:32 +0200
Message-Id: <20230206133532.2973474-1-arilou@gmail.com>
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
 tools/lib/bpf/libbpf.c | 9 +++++++--
 tools/lib/bpf/libbpf.h | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index eed5cec6f510..cd0bce5482b2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11710,17 +11710,22 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_buffer_params p = {};
 	struct perf_event_attr attr;
+	__u32 sample_period;
 
 	if (!OPTS_VALID(opts, perf_buffer_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	sample_period = OPTS_GET(opts, sample_period, 1);
+	if (!sample_period)
+		sample_period = 1;
+
 	memset(&attr, 0, attr_sz);
 	attr.size = attr_sz;
 	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
+	attr.sample_period = sample_period;
+	attr.wakeup_events = sample_period;
 
 	p.attr = &attr;
 	p.sample_cb = sample_cb;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 8777ff21ea1d..5d3b75a5acde 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1246,8 +1246,9 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
 /* common use perf buffer options */
 struct perf_buffer_opts {
 	size_t sz;
+	__u32 sample_period;
 };
-#define perf_buffer_opts__last_field sz
+#define perf_buffer_opts__last_field sample_period
 
 /**
  * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
-- 
2.39.1

