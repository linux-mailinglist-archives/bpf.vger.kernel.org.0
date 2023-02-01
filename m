Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E219686241
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 10:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjBAJAb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 04:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjBAJA1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 04:00:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECEE5D90D
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 01:00:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso810516wms.3
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWxXVNRdoYzt5+5gf7yBtPWNCAqkks634pHQrASFn40=;
        b=Q80nCMUvtmuC7dpiTeveHZzSPIHalpR88EjL6DeoabiNjgoHH7cEYZUwJP+oHtjOYs
         u9AJFV8O7ebgs8Y5BTy1L0M1cGJOsl8FvisTOcZvagWPf1rkqQFNvGtS0HFqA/WDvI0A
         3R90Qyxhiug+TFKF8e5Cg32PgNCWoES3jvFNHw3Y2VFHPuudcRGvK/MCwZLIFyuRcMch
         gYKAVy8c3xtxphTYvh2+DnELrfU1LZPjsb4iisSPcVPgT6bacUBw3KsEiP7TPah9ulEu
         4i7K0X9l5YIJimDmujv3D+DEbY8OIf9pz2ZPfmRcS8/QuMF2S8XIPzg0gEcKircKP2S2
         aixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWxXVNRdoYzt5+5gf7yBtPWNCAqkks634pHQrASFn40=;
        b=hNzXc6009stp1dyAYFucrLCh8Du3crYu4v7VVbr1zNSV4PBaWLeUf4Xd2FVKHwjjEU
         +Kdw6UzQxlZB612TOvLwf+zNQb21XIhFb9kFBa7nNcpUMn1SN/Yz6BycT7/FR8DP2y2/
         oyVL/L935lKQ1yyBHbthethLXQeW2VpDMq252CgjgWO8KZ5HKGzZIeAWpeWzoAQe71pe
         TIyv0b7dAPtfkqrwKUk3kWotum69NHFvIhgT3ublXqAOX7DO5z4v18a8Z1Vg1mBnTM7s
         PIS/H7imhspOUQMa81IlY7k+Y8IZIq/kqTpUn7Xwr6xQXMaSvZDtANG8d6UdeqwDF3VW
         wneQ==
X-Gm-Message-State: AO0yUKWc53coyMtnRGlYmlyTGsHLXe9048P4yrvMvwjIEELovG/XceBI
        9/gYNe7x0hPkd2Il4SAaSCkUePY3Cfg=
X-Google-Smtp-Source: AK7set/Vg/xIBK6m+OxuaJzbqbwqshnrwtYJPZmLAqqgpkeMieuV9c/yVrghxA9SyijEtqscx8aCgA==
X-Received: by 2002:a05:600c:4e53:b0:3dc:5390:6499 with SMTP id e19-20020a05600c4e5300b003dc53906499mr1030371wmq.1.1675242022308;
        Wed, 01 Feb 2023 01:00:22 -0800 (PST)
Received: from localhost.localdomain ([87.68.177.114])
        by smtp.gmail.com with ESMTPSA id u1-20020a05600c00c100b003a3442f1229sm1068400wmm.29.2023.02.01.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:00:21 -0800 (PST)
From:   Jon Doron <arilou@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc:     Jon Doron <jond@wiz.io>
Subject: [PATCH bpf-next v1] libbpf: Add wakeup_events to creation options
Date:   Wed,  1 Feb 2023 11:00:09 +0200
Message-Id: <20230201090009.114398-1-arilou@gmail.com>
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
 tools/lib/bpf/libbpf.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index 8777ff21ea1d..2e4bdfc58c82 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1246,6 +1246,7 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
 /* common use perf buffer options */
 struct perf_buffer_opts {
 	size_t sz;
+	__u32 wakeup_events;
 };
 #define perf_buffer_opts__last_field sz
 
-- 
2.39.1

