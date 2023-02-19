Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E989A69BEC3
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 07:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBSGNr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 01:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBSGNp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 01:13:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399BB12BD8;
        Sat, 18 Feb 2023 22:13:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t4so577358pjy.1;
        Sat, 18 Feb 2023 22:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMq0efOV3O0JcHMyIb01UsH1mIURqWe7SgZ9n1XJn8E=;
        b=frkM1tQ7mKrrCH7Sb53gTTNdy/doRYn0LX5IbsMRi7Ln5IobqBXI0WoEZciIinIwj9
         fjcIApJ+/QVVsu3uYdmIFk3XXFKZK/jzBa7OoyjJmN6t6RoJjQJJBcvYeKnArAZLYvPn
         WxQEJDXWV7yBw+I2ZeTyH0l8GCI4FRnmIVl3JUF3lBamrsk/Zt5a6PHHgeN7Kg+sRZ3v
         D1ukJzDybnwO1suEYQZSdktM9A2u+iM3yh8YNivS6ihTMGTULPBODS6NIL+XtR1HToeO
         3/NQ3ToFyOQwUCyePauOUZZDwRA1UyrkbUdmMdSkJVA5qb3qf7HwBt7V8M8AD32ugEuV
         dJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMq0efOV3O0JcHMyIb01UsH1mIURqWe7SgZ9n1XJn8E=;
        b=Zu0EXhhgIbpB9bARIjc+OV5rwsaaDXKfHn9E9/DrcU56PwPprQbMmuwz/FRw/GANFx
         lBuFj1qFrZd3beRLoR8lirshGpeph95AltzHvM0ahYnq7j6dYXEb7fqBZTg1dS4GtVhA
         GU4ICFhGrFPQ91BmIEOlzm1e/Mvjh8Igkh8JxhZSqbxold66Fs3Mt4hKg0mk8FkJGH9l
         KOqhj0FFSoMZwC1GrHj4EP+1eZdoaiFM4nI6lBYKaHO+yayyPLXaILuD2SpHep9vRd1M
         rUZSfDTr8UYqxJKOvv+hrQXFb4ivws5Hs2zecPn4Ou7M82gCHvstpG92ve3CaHyoVhRR
         cefg==
X-Gm-Message-State: AO0yUKUEoQkYwE6z+zNMiWs76uBd96RPtQ4TVFngGIh454Qe7IMm+Cy9
        DKVnhErctbLr3S/KkMVCqB0=
X-Google-Smtp-Source: AK7set//YWSn5+w61h/lJ9rC7KKSh1PAVp2Zp3kTjaDinoQQDAd+5TLj/q3wcehgLloHSM1EU67gFQ==
X-Received: by 2002:a05:6a20:394e:b0:bc:6ef3:1e74 with SMTP id r14-20020a056a20394e00b000bc6ef31e74mr6120093pzg.37.1676787223536;
        Sat, 18 Feb 2023 22:13:43 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:70ac:ab5:11d3:d785])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00189ac5a2340sm1182140plx.124.2023.02.18.22.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 22:13:43 -0800 (PST)
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
Date:   Sat, 18 Feb 2023 22:13:27 -0800
Message-Id: <20230219061329.1001079-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230219061329.1001079-1-namhyung@kernel.org>
References: <20230219061329.1001079-1-namhyung@kernel.org>
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
2.39.2.637.g21b0678d19-goog

