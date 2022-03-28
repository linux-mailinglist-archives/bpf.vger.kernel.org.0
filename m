Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1072F4EA3BD
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 01:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiC1X2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 19:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiC1X2h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 19:28:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58232D1F7
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 16:26:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e8216c4c46so85506197b3.23
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 16:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fupq3XJMUIvfZtd7nCWtM0IzLS07K7rgInQ7zuEb4wY=;
        b=KVEofwtPahchiHI4Z6dqBFVjvduH18BDAzc6Li3xhStcNzxjpwFFX11Q4eX2TBBix9
         bcvhgJlkLEtrOvuv9FKy2sJxw5zcHfTv5UUBVZB0SYOOjrfPzED19tZE6GMBHz4NXOrB
         Il1jPsV3VZv7kzeFLRm8qblxI6/0YvASO5yNOLMeL34nbwkU3DQEZ62p1vlSUPGsn3DM
         jtljGlSYN0zjnXHRyvS9dXBJmtmuqAB0dvm+rifZFDUFHRQWBPIIdZTTLAg3K/Q08ZvO
         utwSViH/8XrW1j3KwEgfyRJZrZGFVy0cXqw0UMISd+diKqlJWkeCjB56JIjUp8obP2J9
         oIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fupq3XJMUIvfZtd7nCWtM0IzLS07K7rgInQ7zuEb4wY=;
        b=TxN2HRKkE4IP1PebKFZ2B7rsJ3Opai9pi8y28d7j31WXS/ERG3ZYjTUkEV+vylVKQg
         d34RDhhJ4XiAj5xZVMEadHZLCih5wGFopOh+VmVAhAdBNORNZGZsD6hJ5kAPWs589eSM
         r/aeNqBTTjAfUMIPmT8G4lpve3ntuTNrJYfr2zycaCkVNnsDcZseFrfkTM96ru/4a54e
         th9weAM9SX7dQDpVzLheB5WQQFQgv0pUOQSeqDkd3oSHYtPA56EhLCebWrJjq+T9TlAs
         GUSJx4dHACy5cHG7YH57kKOJTUyi/khz1umbFArsl4YUJdNE0VD86OtopqXIh8EbRpO/
         b93Q==
X-Gm-Message-State: AOAM531RFDUnO4iZN+mPL8oT84lkdG8U2m/2pUyHdsV3NrWYUbtX54B6
        q9natIDS36n+10xgbMsR+OuDRKykOnB+
X-Google-Smtp-Source: ABdhPJwhgyfHz9+dsnfidErRLGIU1bseQ1e85VsPFp79nt7lIgS3DYCsPf0dsDthmUWrgaFylWFZLs6Ui+gJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9d6a:527d:cf46:71e2])
 (user=irogers job=sendgmr) by 2002:a25:3246:0:b0:633:af97:a3eb with SMTP id
 y67-20020a253246000000b00633af97a3ebmr24623187yby.274.1648510015000; Mon, 28
 Mar 2022 16:26:55 -0700 (PDT)
Date:   Mon, 28 Mar 2022 16:26:43 -0700
In-Reply-To: <20220328232648.2127340-1-irogers@google.com>
Message-Id: <20220328232648.2127340-2-irogers@google.com>
Mime-Version: 1.0
References: <20220328232648.2127340-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 1/6] perf stat: Avoid segv if core.user_cpus isn't set.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Passing null to perf_cpu_map__max doesn't make sense as there is no
valid max. Avoid this problem by null checking in
perf_stat_init_aggr_mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ee40de698a4..b81ae5053218 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1472,7 +1472,10 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = perf_cpu_map__max(evsel_list->core.cpus).cpu;
+	if (evsel_list->core.cpus)
+		nr = perf_cpu_map__max(evsel_list->core.cpus).cpu;
+	else
+		nr = 0;
 	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
-- 
2.35.1.1021.g381101b075-goog

