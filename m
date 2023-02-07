Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477A668D161
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 09:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBGITe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 03:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGITd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 03:19:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77628D0A
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 00:19:32 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o18so12709068wrj.3
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 00:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMN+/bUnu8lL9f+Ha8APPml+dMGwzujQBcD/5FLmO+o=;
        b=NDL/ljkPGI19hkNJDQiuDbm7jFMdNiiDcBcJxfF/y5yiCK2QbIYkpj7gf+H1ucmKbL
         /ZqLn+cz3w7uMzonnn8A1NBHQzjAp6nzZ+7AOB+DuGT0+s3DSS7WJ9ZBCCfnlRSA25mH
         fxZLKKLc8pqSvMS6ZKhrmpWB8lf1HvH13Fbwb66/3MYLm+qGZYJg1htjE+9if4uar5nv
         FdzDjV+l4S4h6BOPEDoC0KnrvigjzxMtPDoFYKCQrIFQJtNQH5hcokza0BWsKIU1dxee
         F3/gOpqdjkNxD6FYsHI2fDm1xw698fiw9DrqHEaAidEwMiBuLnA7XWZkR3iyzWtzNZwy
         PpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMN+/bUnu8lL9f+Ha8APPml+dMGwzujQBcD/5FLmO+o=;
        b=ddn+rSrWMgRsXQlgKQRLKcBLnuL3qWrop+IGK2MI65PBTuA0ZM5FT/dZJZj48YVONi
         07cvNWxaHoFPGa+rc5HzZnmaH7/VrQcHinr8lbJpuX9RqwCtVDRkEtecW2uwy4MCFfQq
         Q2A0hOwR7C1HXnr+FwD0cr4hhn+VMX2yv2J0gJ2LpWDW0vHaUMcPNC0iG9+yYMoakv8n
         U3I2OsdGEwpkqilVYH1NamhRHsVm29bcYkd6lZtZBSCm3Joazo1/WV/cRMIUscDoCiDJ
         sGH+MVjNRqyGkS5FHerqxCKNhjbTYmJV/iYXiwpgfd64wVDeaBAJ4i53hLIuOBl1SCXA
         Xcng==
X-Gm-Message-State: AO0yUKXSkADJujfc9VOE0heHSim7eElTJTKASYWnKpg+x9BI8VKp039E
        zgOHzutSdUlvFdVQTSMbZPXwGQSne6Q=
X-Google-Smtp-Source: AK7set+YOqG5pVDbXP1cECnWDDd1OsjG+XO9lmsHbiZDGOr1W5BEyB3oy78k5x5HpdouIeQa72Wq3A==
X-Received: by 2002:adf:ec84:0:b0:2c3:bbfa:d509 with SMTP id z4-20020adfec84000000b002c3bbfad509mr1622849wrn.61.1675757970465;
        Tue, 07 Feb 2023 00:19:30 -0800 (PST)
Received: from localhost.localdomain ([87.68.177.114])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b002c3ed120cf8sm3278789wro.61.2023.02.07.00.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:19:29 -0800 (PST)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v4] libbpf: Add sample_period to creation options
Date:   Tue,  7 Feb 2023 10:19:16 +0200
Message-Id: <20230207081916.3398417-1-arilou@gmail.com>
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
 tools/lib/bpf/libbpf.h | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

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
index 8777ff21ea1d..8104bd128e6b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1246,8 +1246,10 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
 /* common use perf buffer options */
 struct perf_buffer_opts {
 	size_t sz;
+	__u32 sample_period;
+	size_t :0;
 };
-#define perf_buffer_opts__last_field sz
+#define perf_buffer_opts__last_field sample_period
 
 /**
  * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
-- 
2.39.1

