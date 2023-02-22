Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2700769FF2C
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjBVXCc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjBVXBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:01:55 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DB474F1;
        Wed, 22 Feb 2023 15:01:54 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p5so5015400pgh.11;
        Wed, 22 Feb 2023 15:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w5v6HDDIJM40WcjLFww/rgpyST+M1urWgPilPWBon8=;
        b=YQ5wHmi8qisFfdU/P7pajLC17qKNsBusu4tx8BKHw1MgBV8pqOWkvPqhfO9Elwof30
         G0wAxMBquNFoXLr0ZLCDpyDZxAzdhk6yhj+t/7r5AK78AEQwN5e5wNZc6Mh5l0q3lu1x
         e5jmksxSksTDOAgw8U4YZmoZ8/5oX9HwMn/C7N0gNd1lJtcaXraM9Es9UkvX5Mo0zqq2
         YMLBU0ULesrvTHvBqig9YC8WJRgvoQJ+fHYIS61t8V4GYr/9CsS4YfFhvy8Vz2vFlwCQ
         cYIIzFIeeNwTOzFAIZPhADQcJis3sbLgG74+lpdOxkEkq9I6LVgFEeFCOuY/wYy7rUyi
         HQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7w5v6HDDIJM40WcjLFww/rgpyST+M1urWgPilPWBon8=;
        b=e5NeTBPWtIwt1ZO8+zkyLD/gRP5Qaas5DgTA10559/AFSGeIEjzA6n1D+FkX0FCC9S
         HIugSTJ1eNSbnRIdp7zRjJzyEahHs9PRkiOst5LLfjbQW8qLzsYijlwGS4PDVoSTBNOW
         EpBGThp2+Bf0R4jN9F0I3Ke2u2BwEsPOtasq6PFewCmWBu/HG9TblbqWGDy2sh6CMd8Z
         foXVQkxBJJ1aYgxRaxnqJiyLtXvD8knsRsltuG7ZUZmKz18ez06X5OG9PIn+N7ea3in5
         4FkiFWAjdzfAo9R7Bo32Dwc7LoP7n+zmY4kxluenOrB73ukfj7a0nCWUm+XNz0bcLrKt
         dVRQ==
X-Gm-Message-State: AO0yUKXkptEKVfGWyF207uHTG41DX2ndr5NmYE1JbH2JJbWVICzIu/CI
        tnwYtXVE0ZsvNgfI7rcwqtE=
X-Google-Smtp-Source: AK7set+2ns9vUVl6u4tJC3dwYZ0/+HuMiYjCeBZp5p9NTYLMcRVLcZRieOOZtjPcXGJOHIzNdWbVlQ==
X-Received: by 2002:aa7:9e4b:0:b0:5d6:138f:5596 with SMTP id z11-20020aa79e4b000000b005d6138f5596mr2824208pfq.14.1677106913583;
        Wed, 22 Feb 2023 15:01:53 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:8f76:587d:f250:fecf])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b005ccbe5346ebsm3895127pfm.163.2023.02.22.15.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:01:53 -0800 (PST)
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
Subject: [PATCH 6/8] perf bpf filter: Add more weight sample data support
Date:   Wed, 22 Feb 2023 15:01:39 -0800
Message-Id: <20230222230141.1729048-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230222230141.1729048-1-namhyung@kernel.org>
References: <20230222230141.1729048-1-namhyung@kernel.org>
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
PERF_SAMPE_WEIGHT_STRUCT.  Add weight{1,2,3} term to select them
separately.  Also add their aliases like 'ins_lat', 'p_stage_cyc'
and 'retire_lat'.

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
2.39.2.637.g21b0678d19-goog

