Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038616BA3AB
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCNXnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCNXnN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:43:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083C3E618;
        Tue, 14 Mar 2023 16:42:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso98923pjs.3;
        Tue, 14 Mar 2023 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMxL2NHeZsRCM6blhtDc4AW9Gdpz11WHZ6f52Ygl1HM=;
        b=hFOpgmG+9oZLXQ6Ujq4k3ob30nepb+lX1yE1Ppvn7qFOJfNhU6OAsOLfgOqcQlVgt0
         RSlJO8U7ybCppY6tzgqzeE1EoGl7DdkFyvjwiIbd21/KEMUp2OH2H5UK4O5K1obXfN/B
         WfzmvWNbuh5Vee3ZyjKCiqUWYh1ri/Gpm1zkMP1LL5eXgw2EXJJH2UHXtWozPtY3P+Y6
         iguS0GZwuDy6Xv6BWnbqLV5ibQllK8FTyJY9TNma/2HqeWqsMoUYJs8C1bnRPvx/cbPC
         Ec8/8d2yLtypddxgnIbSp2KbkenRGm/YnYF19ExvVURWVDGk+uJ382e91Y0L/C0jEKi1
         331A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jMxL2NHeZsRCM6blhtDc4AW9Gdpz11WHZ6f52Ygl1HM=;
        b=BsrT+A8eJlD3WoYGtg6FLtcaEQad+rk4ZNviqH6x1TbGKtJipGg1KUNhZujU3cROST
         x5jitESCUUKOR86baoO1DVqzpq9UIfTGcWqnazB1nym/EjrrTbbe9Hon0bWxOJoj68BW
         JJrxk4Lvw86Q3uCJtfFP4zi/ANir9PybFahXxTRlm5pEgPNWqy07ygEK3rB5+I9DphPE
         MXzq3IKUizTU98IjfEAcjn9hTt+PZHs9QXrUghkyD0UyJ3lfgPl6eHeAmgb2NK8SQvdT
         gnPix/pONOdn7+r70et7GrE2jHJ6w/mFmat44zgawdszifMmlcIQH4CnPEOTkziXO6Lm
         WH2Q==
X-Gm-Message-State: AO0yUKX0IORcm+YzW4jyzdJwBXXOaJk/d2g9ND367oTOXvbuXYIemoR4
        2/us0QqEdy3P1QTch3Du1wY=
X-Google-Smtp-Source: AK7set8vh9xqppIpf5fA95KYD5Zk7VVQEXve2fZFcJflST1qVDIZ8jzlmCTcLzC6ZS8jBoK34aYWxw==
X-Received: by 2002:a17:903:11c5:b0:19c:ea4d:5995 with SMTP id q5-20020a17090311c500b0019cea4d5995mr761040plh.68.1678837371651;
        Tue, 14 Mar 2023 16:42:51 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:51 -0700 (PDT)
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
Subject: [PATCH 09/10] perf bpf filter: Show warning for missing sample flags
Date:   Tue, 14 Mar 2023 16:42:36 -0700
Message-Id: <20230314234237.3008956-10-namhyung@kernel.org>
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
index 6df8b823859d..7b7e74a56346 100644
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

