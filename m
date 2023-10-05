Return-Path: <bpf+bounces-11504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DC7BAF26
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AB5F4282E37
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08941E58;
	Thu,  5 Oct 2023 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFrkysO+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27143686
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:49 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6C10C2
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a23fed55d7so22032237b3.2
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547379; x=1697152179; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=aFrkysO+gaNCXmgevliCscZ/ljl+qyLGxh4dkDOE8MXHBtBSjaflkaNqf2jTG4i5MD
         QtJwYlUVzJGLFXYJeZ9yJS3xK449JhO48JT8wJ/tKK35WVBEm7gtvtrRIKJd2rVXJtLO
         g2HLvywtsp55v2tSZ2083iBvgZgZBcwkM6CxQ+xGntrWJifs4LlmqTIWbWxKqY+vj0im
         PAC6FeLuZn6ZHpcRxe1YAlbr+xT9mxYJJZnB4osUIzw90DTyqF8NO9Na5inVskaKuxVs
         JG4gVSQty7O5rVwbeI/Uj4la9jQAU4m5H05vmWXCJnFAHhjRkP88CPBK+X+HW6J/LANl
         Q3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547379; x=1697152179;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=SoRRaPqvwTZpWL5rgIYItIRw+0Z7LgSM9bqs9zp7Z2imZlEEBZvxB6Bk31wFvTewMi
         SdvlJqv0ZcbHP3yrVqg6NlIdYFdQRxYT78TkbQ7C/DRo2Z5bm8npgbG2inOITtSVhrbc
         IjwUROzTEg6AIHdQBA/nuxHc1LkOnev0lR20XK/hgqQNc70b+28rqhSm+457FTMCoK2n
         bVcsZg2jv5K8fz+ppieEhCCFfIJm4qvQhVRrGWbpa53QH1/sjGwznNZnkZ9sqEN4tOs+
         AgjupSXkZlnrnjhAJfqmKBboT94X37Snh/v0Yd/4fJN11WvVnRvzvrPOQAZ50RQMIVbC
         vLUQ==
X-Gm-Message-State: AOJu0YwYuAQmI4x1JlYGY9EkbcKkYE1Wx8kD55E+ZL0HY9xeJ3IruXmM
	Senf78o/I3chK/MYpVMmyNqfdYI1hW9C
X-Google-Smtp-Source: AGHT+IHgsU7WqtGzIXgNXr1P8QSditE9WLikTdLCJCQWnQLq+FpPEmuFYiUkFS5RxrsXiCHqXCKcfq5Bkre2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:586:0:b0:d7e:dff4:b0fe with SMTP id
 128-20020a250586000000b00d7edff4b0femr96767ybf.7.1696547379763; Thu, 05 Oct
 2023 16:09:39 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:51 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 18/18] perf bpf_counter: Fix a few memory leaks
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ming Wang <wangming01@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yuan Can <yuancan@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Memory leaks were detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 6732cbbcf9b3..7f9b0e46e008 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -104,7 +104,7 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	struct bpf_prog_profiler_bpf *skel;
 	struct bpf_counter *counter;
 	struct bpf_program *prog;
-	char *prog_name;
+	char *prog_name = NULL;
 	int prog_fd;
 	int err;
 
@@ -155,10 +155,12 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	assert(skel != NULL);
 	counter->skel = skel;
 	list_add(&counter->list, &evsel->bpf_counter_list);
+	free(prog_name);
 	close(prog_fd);
 	return 0;
 err_out:
 	bpf_prog_profiler_bpf__destroy(skel);
+	free(prog_name);
 	free(counter);
 	close(prog_fd);
 	return -1;
@@ -180,6 +182,7 @@ static int bpf_program_profiler__load(struct evsel *evsel, struct target *target
 		    (*p != '\0' && *p != ',')) {
 			pr_err("Failed to parse bpf prog ids %s\n",
 			       target->bpf_str);
+			free(bpf_str_);
 			return -1;
 		}
 
-- 
2.42.0.609.gbb76f46606-goog


