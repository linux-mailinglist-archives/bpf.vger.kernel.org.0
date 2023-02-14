Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85F69581B
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 06:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBNFF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 00:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjBNFFL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 00:05:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E51284B;
        Mon, 13 Feb 2023 21:05:05 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gd1so3233084pjb.1;
        Mon, 13 Feb 2023 21:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GgY8PAE7TX9qFf4QOA0TPUy0m2n+TuiK45QUolCwnM=;
        b=Vtzu2Jd84dLUVnnINxxKqlgfaHwv55D/YSQ0RnG4ylwfeDuCwcBRf3ImNHVyTuf5b0
         CdQDwpmCcNwZtacR/cxiaSFYC6EzAvWYJ2qnjryscVq9LtJQBh4hrmKmYAsR8HT3whB/
         lyOfjy3z2js4V6LDt/CAUHIAJmqM5MGR+6gCKDPSwRHge73uz4OYw88ax3LzuQj5NhAL
         QLG+N4O9uEPruinvmEuZDyi5Bga4ITpQC5eE1IKFj/gB54yqd5p8vqRR6FFHKcki7IiS
         PVXws6nmYmdPPwV9XunX/0Z3nxhJ/fwrEZRpmNNL4bIX6LiyKXlNU8ocHib+6dDBkYc9
         /2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6GgY8PAE7TX9qFf4QOA0TPUy0m2n+TuiK45QUolCwnM=;
        b=sqsmsL6BsNTyFCEuD8c1gMvOur4sl1KHbmREoGXeKQwMPv7SVZfhlnBqQZ+UMgxepZ
         nz31z9N88GLYhWT0k6/bsKXposfnrbAdOc59/pCIHxCHAmv+8am4M0+RtTiN5eGnrRjD
         y63+PF/yTuqX4t3rY7P1oIevfWqSkyIxrJ+x+ibO4qKHHVsLvgXsrPHFyCbTMD0bwMuw
         +tOCL5FPGBasqpFiIBySXG99tbmyNwo4c0lliYgVEYbqIPhemaya68O0q0f0AmJpQqjd
         +ufQF0sE0OPjJKJEZCUWIThu75fCxJVaWGEwlQ7i8u6ihUH2EP0VRgF65DvKswUM+ID7
         ueng==
X-Gm-Message-State: AO0yUKUG51GHLeOsklStoGEXCb8dhtrygJkCn569WpLcCEHWivW6v1Gi
        wJdk3WJKrhwXkGMm2FihMiM=
X-Google-Smtp-Source: AK7set/Sg53DpA+clEajN2inlKuGqx8MpQ/RFdQMt+tea3Ux0OaEgENsQkNDFwfrnQpeiwxCvBNjww==
X-Received: by 2002:a17:902:7081:b0:199:2e01:13fb with SMTP id z1-20020a170902708100b001992e0113fbmr15106661plk.20.1676351104859;
        Mon, 13 Feb 2023 21:05:04 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:de3c:c4c2:3f15:764d])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902761200b001932a9e4f2csm9045593pll.255.2023.02.13.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:05:04 -0800 (PST)
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
Subject: [PATCH 6/7] perf bpf filter: Add more weight sample data support
Date:   Mon, 13 Feb 2023 21:04:51 -0800
Message-Id: <20230214050452.26390-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230214050452.26390-1-namhyung@kernel.org>
References: <20230214050452.26390-1-namhyung@kernel.org>
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
index 5117c76c7c7a..bdc06babb028 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -61,6 +61,12 @@ addr		{ return sample(PERF_SAMPLE_ADDR); }
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
index e9a0633d638d..5b239f194fa9 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -46,6 +46,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
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
2.39.1.581.gbfd45094c4-goog

