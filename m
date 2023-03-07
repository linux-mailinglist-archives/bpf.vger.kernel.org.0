Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948A96AFA7A
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCGXdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCGXdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:33:25 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB37BA2A;
        Tue,  7 Mar 2023 15:33:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so470788pjh.0;
        Tue, 07 Mar 2023 15:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678232003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3XJiLzYWTl1qdcO6Aoy/MeuV984OrXXQga9tTJym9M=;
        b=k/ZMLtxDsB+YHPhfeOKHYIWLbC8qdI6ZoY7C2sPPUkIl3TUW1OeJkzWUQdTijzRFDO
         GhExusyellPgYMqpl4alfdYq9NFrrgu6GUlAOKd03NJOY9x11JoBc9pGxQznHCfw+Vkc
         5FT8HDnVzrVhFAB9g2h7otDaInhTm5KRBrOQkLlR31DNoBrNv+QLLhAX/AXG3Kb86Uqq
         feJZ1nEjMTimEuVqxg6Wlf2+R8vVyi8QN3pnFuFxH4nvbVY5ZQAo6O0qPJI9NbJFrpOa
         EEFJ5uMniBL+MR72jGxlelEI4gxgxwG6vJP/JH9qp/FTHWGGxuInYjcxa0xACDmz5/i6
         eopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3XJiLzYWTl1qdcO6Aoy/MeuV984OrXXQga9tTJym9M=;
        b=18D/Bj9CzvvvpAdwDlQKfNVt/jG7IUH4BiaBzkPD12yGE8hzcMDSRQurqwXQHDU3Db
         DUbC9HWtHObWcUdWgdnd4vCVFtvFMk64EWWUFf5iEmK1zc7YML1zCv7ZJyGjWbN6veHc
         x6PLbgQN/IlqlRHbX46ENacUaCwdA7mLv+0szG6aQ/VRjQf9s9dnzYf0N+/OT9xo263m
         IJHZQenmpamRGhVsd2JDXFYdt+FM1tEj5yo0Jxa5vbu3vgXcAVbzwUEZ9pKlQEIZOldH
         Ipfqm5l6+WXyDbcqWw2QfcyK2Nux9qpnfSZm3UjlT1rKVGNpsotzttCl3qj+HPUHHeHb
         Jscw==
X-Gm-Message-State: AO0yUKXH5cr7r2ceIhbaDTlXxczc1Hz03vPTUun6/HH3vy4lmskMj9L3
        653dtmzXzj8184774o6vEbw=
X-Google-Smtp-Source: AK7set//M15swegfo840vAPhluG6X15dTHI61Dzkynwcp3PxVLv8165+EUMgSytQouKSSp4bTw+byA==
X-Received: by 2002:a05:6a20:a01a:b0:cc:7967:8a75 with SMTP id p26-20020a056a20a01a00b000cc79678a75mr15029486pzj.46.1678232003035;
        Tue, 07 Mar 2023 15:33:23 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:15e8:b801:cd55:a496])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b005da23d8cbffsm8342217pff.158.2023.03.07.15.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:33:22 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 6/9] perf bpf filter: Add more weight sample data support
Date:   Tue,  7 Mar 2023 15:33:06 -0800
Message-Id: <20230307233309.3546160-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230307233309.3546160-1-namhyung@kernel.org>
References: <20230307233309.3546160-1-namhyung@kernel.org>
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

The weight data consists of a couple of fields with the
PERF_SAMPLE_WEIGHT_STRUCT.  Add weight{1,2,3} term to select them
separately.  Also add their aliases like 'ins_lat', 'p_stage_cyc'
and 'retire_lat'.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf-filter.l                 | 6 ++++++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index ec12fc4d2ab8..419f923b35c0 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -71,6 +71,12 @@ addr		{ return sample(PERF_SAMPLE_ADDR); }
 period		{ return sample(PERF_SAMPLE_PERIOD); }
 txn		{ return sample(PERF_SAMPLE_TRANSACTION); }
 weight		{ return sample(PERF_SAMPLE_WEIGHT); }
+weight1		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 1); }
+weight2		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 2); }
+weight3		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 3); }
+ins_lat		{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 2); } /* alias for weight2 */
+p_stage_cyc	{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 3); } /* alias for weight3 */
+retire_lat	{ return sample_part(PERF_SAMPLE_WEIGHT_STRUCT, 3); } /* alias for weight3 */
 phys_addr	{ return sample(PERF_SAMPLE_PHYS_ADDR); }
 code_pgsz	{ return sample(PERF_SAMPLE_CODE_PAGE_SIZE); }
 data_pgsz	{ return sample(PERF_SAMPLE_DATA_PAGE_SIZE); }
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index dddf38c27bb7..d930401c5bfc 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -54,6 +54,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
 		return kctx->data->period;
 	case PERF_SAMPLE_TRANSACTION:
 		return kctx->data->txn;
+	case PERF_SAMPLE_WEIGHT_STRUCT:
+		if (entry->part == 1)
+			return kctx->data->weight.var1_dw;
+		if (entry->part == 2)
+			return kctx->data->weight.var2_w;
+		if (entry->part == 3)
+			return kctx->data->weight.var3_w;
+		/* fall through */
 	case PERF_SAMPLE_WEIGHT:
 		return kctx->data->weight.full;
 	case PERF_SAMPLE_PHYS_ADDR:
-- 
2.40.0.rc1.284.g88254d51c5-goog

