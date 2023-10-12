Return-Path: <bpf+bounces-12001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A6C7C6574
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C5B1C2118B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C0D305;
	Thu, 12 Oct 2023 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED5zioZl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE6D311
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:22 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B0AD9
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f53027158so10824407b3.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091859; x=1697696659; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1XV0QFNl94Dga6C5yNB0j7b/b+j1y+ea9fmjMXYiZE=;
        b=ED5zioZlE2JQEYIbZxOIUw0/ikIag2J7aKWATtm8K1f4h3JJdvHw5UOKDveG7N3i5Z
         xt48kuA0sLFwarUHJbmzGCYNX49g3zoLEBABaF+kMO2gdhikcvvv+roP5qoRc+xudako
         Rv7zV/cSnFEP0sM7ipA8Bw48PFDAO+EdHo6SR3mSq+F2ss9uCxF8UkAHkHBYlxPFYV/U
         SCA1GecmlPIl5otdvOka5tRsHaz+V8kgSObPH4IZTSLdR2qLGLu/808QaBE4pTnM5OKT
         OpMUaOveJ8P5EJhMIwe0O0XzNqcxw82IrZcUwcwVLtcar4Imm3a4/TV+GbLMfrBJovF0
         Lbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091859; x=1697696659;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1XV0QFNl94Dga6C5yNB0j7b/b+j1y+ea9fmjMXYiZE=;
        b=sNZPOuj2YW2Weg+0f8sUcsgVXLBleCKkGlXN9FEFlNo6horRpv48mvRRgqxG/Cepar
         DhGmnWW3VmYM1JfXF8tLdoXVHIPyQv9jRwHn8eY3wmXHJTOffCUUVIqK3Vly1CiBuPnK
         uZbb+ocH4JTQQ5pOJuYDUKqPmFASW46CyFSY5Zn1SbbCbL9goSrybbmA0osxdKJrQAHn
         LhA26vOaGWQLq51y6eU3NRqXsL2jlDOsv/bC213jKnLQh9I5JHjtsT8DpM+6O62Ypieo
         osoDhawLeXTKFuxmoT82ddGLxVjFk0dgSQ7FPCAzC3MIqVEunhfovnRX6750p5eFgsEy
         1GiA==
X-Gm-Message-State: AOJu0YyVqP7DzK/5y+ECgq31sJXxpEitZ/7l2pTSpJ4iWDJbSYdiW4yg
	wE3UzNa6oBPzFisCIm9jUQdiiYlIDc4E
X-Google-Smtp-Source: AGHT+IEtnoASSsk/Nird/ZGn7R6QxnVY+UPZa4Hq2teEUgoVuV/bsP6OcU6vLxDnODFIrvfjzKo0NZ50XKFs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a05:690c:c15:b0:5a7:a98a:4af0 with SMTP id
 cl21-20020a05690c0c1500b005a7a98a4af0mr182493ywb.3.1697091859678; Wed, 11 Oct
 2023 23:24:19 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:52 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 06/13] perf callchain: Make display use of branch_type_stat const
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Display code doesn't modify the branch_type_stat so switch uses to
const. This is done to aid refactoring struct callchain_list where
current the branch_type_stat is embedded even if not used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/branch.c    | 4 ++--
 tools/perf/util/branch.h    | 4 ++--
 tools/perf/util/callchain.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 378f16a24751..ab760e267d41 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -109,7 +109,7 @@ const char *get_branch_type(struct branch_entry *e)
 	return branch_type_name(e->flags.type);
 }
 
-void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
+void branch_type_stat_display(FILE *fp, const struct branch_type_stat *st)
 {
 	u64 total = 0;
 	int i;
@@ -171,7 +171,7 @@ static int count_str_scnprintf(int idx, const char *str, char *bf, int size)
 	return scnprintf(bf, size, "%s%s", (idx) ? " " : " (", str);
 }
 
-int branch_type_str(struct branch_type_stat *st, char *bf, int size)
+int branch_type_str(const struct branch_type_stat *st, char *bf, int size)
 {
 	int i, j = 0, printed = 0;
 	u64 total = 0;
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index e41bfffe2217..87704d713ff6 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -86,8 +86,8 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 const char *branch_type_name(int type);
 const char *branch_new_type_name(int new_type);
 const char *get_branch_type(struct branch_entry *e);
-void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
-int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
+void branch_type_stat_display(FILE *fp, const struct branch_type_stat *st);
+int branch_type_str(const struct branch_type_stat *st, char *bf, int bfsize);
 
 const char *branch_spec_desc(int spec);
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index aee937d14fbb..229cedee1e68 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1339,7 +1339,7 @@ static int count_float_printf(int idx, const char *str, float value,
 static int branch_to_str(char *bf, int bfsize,
 			 u64 branch_count, u64 predicted_count,
 			 u64 abort_count,
-			 struct branch_type_stat *brtype_stat)
+			 const struct branch_type_stat *brtype_stat)
 {
 	int printed, i = 0;
 
@@ -1403,7 +1403,7 @@ static int counts_str_build(char *bf, int bfsize,
 			     u64 abort_count, u64 cycles_count,
 			     u64 iter_count, u64 iter_cycles,
 			     u64 from_count,
-			     struct branch_type_stat *brtype_stat)
+			     const struct branch_type_stat *brtype_stat)
 {
 	int printed;
 
@@ -1430,7 +1430,7 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 abort_count, u64 cycles_count,
 				   u64 iter_count, u64 iter_cycles,
 				   u64 from_count,
-				   struct branch_type_stat *brtype_stat)
+				   const struct branch_type_stat *brtype_stat)
 {
 	char str[256];
 
-- 
2.42.0.609.gbb76f46606-goog


