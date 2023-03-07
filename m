Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E706AFA83
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCGXe2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCGXeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:34:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99CA8381;
        Tue,  7 Mar 2023 15:33:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso434320pjb.2;
        Tue, 07 Mar 2023 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678232010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lePgVC2revAs5MYaikVkrYflEU1JfVf67vE9njBHVCY=;
        b=YKJzHaZC0+j+fRV6Dq3o4NrGvaF6eJ8VEHoBAEU03F/LYyBfvqhG242DSDsJSJxTwV
         t0g4cylrUpfpDiK/lI8TAUmIcAsdjeIhcH0E1DpLonCjsmv2Yxivn9x+3ZSG03sJZ77m
         tSnYXNmAEGmbUUiBwpWEBlRDcR/MF6rCJyVZbrZKtybYxzBYPXtFs7u1KzlIXolngX8q
         jr6Ksd8fMGKjSt2EIjoFKu4FEK+jmu4/W1Gpb+LOLXcx1FUswdtVvs3pRypd9x3/x4Px
         si6UYhkg8jB77c67stPfzp5SElP//raDwAtGd2IV1p6dw5RUaCm/kGMD72rpE4fe2//e
         9D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lePgVC2revAs5MYaikVkrYflEU1JfVf67vE9njBHVCY=;
        b=bzLl3NkGmIZzKrxRMuzxNe6Z8Vsd4pwOH2LthGnlp5J/esNn+H5aXnNtoGes8RSRcR
         R6W+R9UAecC/h1dYhINaoDngqwJjoCtPrEY3Wnw5hjWB6OfsTTJGqVxi0LC7Yb7+/QeO
         vUs9e8UTagzoeG6jC0aanzG2Er1HOJLLevtAAr4VXKHJaTEBEiDe4NrHp/lsnWB7KOPa
         vThf6T44+uNJTPuZ3P6e/ICxFMTvDJEFGPS/PRKHO3vSbZ+PK04TFH53JXGpXIlvNwu1
         nvPcGvJ6PhqFMNm2+9VnIV8F7Dv5M77wvOVLjDB5rCoPUaH3pAW2pqzxHpBkFKvSJ9Oj
         sgTA==
X-Gm-Message-State: AO0yUKVMDZ21VtlDa0WVIGRJ96AZDdKoPVQ+hnazr3WKok+4qwde0svv
        ovKhEh0zJpAghwcJN63DIg0=
X-Google-Smtp-Source: AK7set/ig4stm/MxQBlUPJEKcu27Wz6zyalcG+mesMYOnoRYgwbxIEy7S3/CPVUHtJJcQSCJ8i2++g==
X-Received: by 2002:a05:6a20:918a:b0:cd:9664:3d5a with SMTP id v10-20020a056a20918a00b000cd96643d5amr18405629pzd.22.1678232009821;
        Tue, 07 Mar 2023 15:33:29 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:15e8:b801:cd55:a496])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b005da23d8cbffsm8342217pff.158.2023.03.07.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 15:33:29 -0800 (PST)
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
Subject: [PATCH 9/9] perf bpf filter: Show warning for missing sample flags
Date:   Tue,  7 Mar 2023 15:33:09 -0800
Message-Id: <20230307233309.3546160-10-namhyung@kernel.org>
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

For a BPF filter to work properly, users need to provide appropriate
options to enable the sample types.  Otherwise the BPF program would
see an invalid value (i.e. always 0) and filter won't work well.

Show a warning message if sample types are missing like below.

  $ sudo ./perf record -e cycles --filter 'addr < 100' true
  Error: cycles event does not have PERF_SAMPLE_ADDR
   Hint: please add -d option to perf record.
  failed to set filter "BPF" on event cycles with 22 (Invalid argument)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c  |  2 +-
 tools/perf/util/bpf-filter.c | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 197e802a150b..3e9de6ad64fd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1353,7 +1353,7 @@ static int record__open(struct record *rec)
 
 	if (evlist__apply_filters(evlist, &pos)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
-			pos->filter, evsel__name(pos), errno,
+			pos->filter ?: "BPF", evsel__name(pos), errno,
 			str_error_r(errno, msg, sizeof(msg)));
 		rc = -1;
 		goto out;
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index bd638737e12f..0b30688d78a7 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -17,6 +17,64 @@
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
+#define __PERF_SAMPLE_TYPE(st, opt)	{ st, #st, opt }
+#define PERF_SAMPLE_TYPE(_st, opt)	__PERF_SAMPLE_TYPE(PERF_SAMPLE_##_st, opt)
+
+static const struct perf_sample_info {
+	u64 type;
+	const char *name;
+	const char *option;
+} sample_table[] = {
+	/* default sample flags */
+	PERF_SAMPLE_TYPE(IP, NULL),
+	PERF_SAMPLE_TYPE(TID, NULL),
+	PERF_SAMPLE_TYPE(PERIOD, NULL),
+	/* flags mostly set by default, but still have options */
+	PERF_SAMPLE_TYPE(ID, "--sample-identifier"),
+	PERF_SAMPLE_TYPE(CPU, "--sample-cpu"),
+	PERF_SAMPLE_TYPE(TIME, "-T"),
+	/* optional sample flags */
+	PERF_SAMPLE_TYPE(ADDR, "-d"),
+	PERF_SAMPLE_TYPE(DATA_SRC, "-d"),
+	PERF_SAMPLE_TYPE(PHYS_ADDR, "--phys-data"),
+	PERF_SAMPLE_TYPE(WEIGHT, "-W"),
+	PERF_SAMPLE_TYPE(WEIGHT_STRUCT, "-W"),
+	PERF_SAMPLE_TYPE(TRANSACTION, "--transaction"),
+	PERF_SAMPLE_TYPE(CODE_PAGE_SIZE, "--code-page-size"),
+	PERF_SAMPLE_TYPE(DATA_PAGE_SIZE, "--data-page-size"),
+};
+
+static const struct perf_sample_info *get_sample_info(u64 flags)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(sample_table); i++) {
+		if (sample_table[i].type == flags)
+			return &sample_table[i];
+	}
+	return NULL;
+}
+
+static int check_sample_flags(struct evsel *evsel, struct perf_bpf_filter_expr *expr)
+{
+	const struct perf_sample_info *info;
+
+	if (evsel->core.attr.sample_type & expr->sample_flags)
+		return 0;
+
+	info = get_sample_info(expr->sample_flags);
+	if (info == NULL) {
+		pr_err("Error: %s event does not have sample flags %lx\n",
+		       evsel__name(evsel), expr->sample_flags);
+		return -1;
+	}
+
+	pr_err("Error: %s event does not have %s\n", evsel__name(evsel), info->name);
+	if (info->option)
+		pr_err(" Hint: please add %s option to perf record\n", info->option);
+	return -1;
+}
+
 int perf_bpf_filter__prepare(struct evsel *evsel)
 {
 	int i, x, y, fd;
@@ -40,6 +98,10 @@ int perf_bpf_filter__prepare(struct evsel *evsel)
 			.flags = expr->sample_flags,
 			.value = expr->val,
 		};
+
+		if (check_sample_flags(evsel, expr) < 0)
+			return -1;
+
 		bpf_map_update_elem(fd, &i, &entry, BPF_ANY);
 		i++;
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

