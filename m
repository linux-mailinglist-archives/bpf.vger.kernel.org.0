Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DE647583
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiLHS0s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 13:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiLHS0q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 13:26:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A340AD32B;
        Thu,  8 Dec 2022 10:26:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so2339732plw.1;
        Thu, 08 Dec 2022 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ze6sTd98o+g+6IIqM1P3HBE6uRWEE3mJ5ZQRVJK3+kI=;
        b=ir+BkFOqTEnIwxMwiDi1qxBss3dcDnH4LP4ATiGGOkJHtkbTjaXxCN2LVPi/O94LN5
         Hw6lfqXHVmjrmFFioKM5dca8WX3ut2gwdqbDo5rj8T2nea5dm9CCgWIVlVmOBPJ0cs8u
         0H67qvZ1PkYImLRJKpK0Q7Hcq/egl2NPvTYnpH2O0NTkj1jOvFNLFddpUiJVfK82D7ll
         vcsg2xEtEZWDAIxP2z/Bh+0/U8DNPxxTvVPfHXiN5E0M7NInh28qx46egKMJ6BiHLodb
         CxGcwO1Yc+FEVn/w/hx55yANIY2vSgWIQVJQiDBzDaKD8OGcALxu9woAg6bOFovVBBt3
         5aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze6sTd98o+g+6IIqM1P3HBE6uRWEE3mJ5ZQRVJK3+kI=;
        b=urUhWwYE6rKl+UZVfJOIN50U30uqf5E8xcxAe7geJkaYQoxMDN/L2AfvSxVQcTdBs8
         lPSBjxd8fgYkGsGlupxZesUzmjFOVcQEO3idKBFvtk/os/yGuH2FMsDNOnjFagBVK3HF
         9cCqqPBoKxuDhr4okJ9mQTGIkAZBUeK4sU0bY34HOxM04DCbtIJZ9MYAzQ4Jhck6nvI0
         H4T2D22+/ocjmUCFnyEYxHoQcQPtj0HDuNSYnei5xAAJ7Wk+bkhDXzYKSS+tnHH891iQ
         OpFeJ0uBulZF0Hyeb0AVpNXgQEYlAKNJe3R5rLxU0Pj3iF4KZPOGXwNMQ0uXvsyO5MGt
         S4Dg==
X-Gm-Message-State: ANoB5plgBhBdDGmzgesi3XDu1fHcUqpgQNCXqy9cXH4m0Cq4zxGpUDAo
        65Q+NqZ3U97Wu/5mpBUlvxs=
X-Google-Smtp-Source: AA0mqf7AFaUGxBh2S1oElEAgW5c2HAmruuZ/tSpzAO7F8OJItjGNTEszfpHSMAtxbYyoRmWNyDMKPQ==
X-Received: by 2002:a17:90a:2d81:b0:219:9676:fef4 with SMTP id p1-20020a17090a2d8100b002199676fef4mr27870762pjd.89.1670523997544;
        Thu, 08 Dec 2022 10:26:37 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:e288:d3e1:a97a:4b35])
        by smtp.gmail.com with ESMTPSA id c133-20020a621c8b000000b00575cdd7c0adsm15606679pfc.80.2022.12.08.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 10:26:37 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH] perf tools: Fix a typo in BTF tracepoint name
Date:   Thu,  8 Dec 2022 10:26:36 -0800
Message-Id: <20221208182636.524139-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the BTF, tracepoint definitions have the prefix of "btf_trace_".
The off-cpu profilier needs to check the signature of sched_switch
event using the definition.  But there's a typo (s/bpf/btf/) so it
failed always.

Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index c257813e674e..01f70b8e705a 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -102,7 +102,7 @@ static void check_sched_switch_args(void)
 	const struct btf_type *t1, *t2, *t3;
 	u32 type_id;
 
-	type_id = btf__find_by_name_kind(btf, "bpf_trace_sched_switch",
+	type_id = btf__find_by_name_kind(btf, "btf_trace_sched_switch",
 					 BTF_KIND_TYPEDEF);
 	if ((s32)type_id < 0)
 		return;
-- 
2.39.0.rc1.256.g54fd8350bd-goog

