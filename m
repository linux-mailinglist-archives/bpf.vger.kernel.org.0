Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22456BA3B2
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCNXoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCNXnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:43:11 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6781A3D93D;
        Tue, 14 Mar 2023 16:42:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p20so18249803plw.13;
        Tue, 14 Mar 2023 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3XJiLzYWTl1qdcO6Aoy/MeuV984OrXXQga9tTJym9M=;
        b=YfwH9F1l3G2eOx+tqRFUa5gB29eIlnIQOrF6uSb9KsL2XpNEOWQmorubCoMqQ57bJP
         O+AYOeY9gLBRyKGvm4ihpiE3x5jtp+Z7LJVE92OTXUHbWgn0u7w9zu4mjgPmoMHnCBC0
         MueAdtYt3bDXEugMhsIC0JihNCyZZ2r1LTVuTWCCgn1kXudjxeJYFKSmQuW6vqy5R0+8
         SVk9WBcSSOe0xk7HIQaY4s/o64qHreO0U4Is1N9l3T9FFnL6ARax72VWcwTlkpgh5olu
         MrduIAWItyaArnbirqCA3f3meGvglTJ3nTjJf1tU1/qD/Vr/FuPxLluDMbQnT+wOo/Fz
         vQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x3XJiLzYWTl1qdcO6Aoy/MeuV984OrXXQga9tTJym9M=;
        b=IdqIUw5JeF21z6SwqPSZnttABGNqVQ+oxnhoVhtSgfM9aev6IZ78bXg/M5qOlvBTRK
         jbX2UApp9Kd/LbjykEFvIBxuSEoq37bs/EXO3ezug+Ik/ghx8A+4WNbXhgv7Oot7KTck
         RONj7h1LAM+AFb+GJ+Rki/R6qb615O4cAimG1Xurx0hIucigCetpe5MdNwCI3DtygqBH
         lrwDGSlDfrz0pUArnMhUj7bcuv1qvzcn5UmVT2rTtnDEtooSR3bJRb9e50dtvyYH6zQI
         8teuLzak5PRQnfEHlMnAbHs+rn0cjXQextkY2cWhO2IpgiZNhMVOdjPpbP12L/vU7/P2
         /Jtw==
X-Gm-Message-State: AO0yUKVteCNQMcSaP7k2MUmhTvmWaOb+GGDFacuMgitTXMoFtzIwL068
        JjjQ9j9OlAY9hadhJM7MabI=
X-Google-Smtp-Source: AK7set+hAncAWzBZw53gwPAyhS5+8hzUzB7Ef2MSaTxZuoWnhfMfMKXkXTt0J3w5te9i/1Hfk1nDHA==
X-Received: by 2002:a17:902:dac1:b0:19e:b6b0:6b3 with SMTP id q1-20020a170902dac100b0019eb6b006b3mr899832plx.15.1678837367776;
        Tue, 14 Mar 2023 16:42:47 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:47 -0700 (PDT)
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
Subject: [PATCH 06/10] perf bpf filter: Add more weight sample data support
Date:   Tue, 14 Mar 2023 16:42:33 -0700
Message-Id: <20230314234237.3008956-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230314234237.3008956-1-namhyung@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
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

