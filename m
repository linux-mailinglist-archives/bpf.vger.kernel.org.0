Return-Path: <bpf+bounces-10681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 141857ABDF6
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id A6E38B20990
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2172116;
	Sat, 23 Sep 2023 05:36:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC0A53
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:36:44 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EE5CF5
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d817775453dso4183820276.2
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447378; x=1696052178; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywZDu0emPkmJVQQeOexJ/0NU/+t2nDPbGZwUB+L0bX8=;
        b=Y8jSrrZv3uPNR16NU6PIlHK/E0c2RkCwOxr6RioM8kd9ZLc1L3eoIH+6EqTxn+rUPj
         UDAUB2SyaQhQTUDFR9YUmWrNSb7cJd9JZ9M+pF41SAr5jTVJcW4Eep8p1vMLcexGDQlK
         +GMR9mrHWPgFoyqFaUKBh0nWaEtpg/scq0y9rmgqoKR+P3d0iWU/lrtEwFpxNdE/DiBL
         wNIq0fv6BQ1FagEGVOq2Fe3uoBnTFDb+JHF5QdBLYNmHOmuF9ccuexW7m98KCKvnXWq2
         DVIrirAofJDREV7prSR3DwQs1SLUxu45g3DnWxZqLqs8wcWRAQPD6VbGejFconNQzNUj
         BdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447378; x=1696052178;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywZDu0emPkmJVQQeOexJ/0NU/+t2nDPbGZwUB+L0bX8=;
        b=ZJtrI1s6YxEKDGabpiaE8zDenN86d19X//CT3uyIjfXWTezg6JWVZZdXDSNmwtxlDk
         iTrXU6fh8uzA/+0QbssiD5/SdRmqTe8xx8VfQpxEj69ZxZ4CHEHWjviq89hlrENUbi8S
         kpTKwT90J7AE60SgeqLRfLuBPNF4jstWuqkO3h/mBWYAceMWhkPiSyMpPGWfvCDedMh4
         RGZkS1HzPhDUwVReHDO0WflEfqO5hoBftq/SclZmAUXcSbMBSp6L07S6OpsmCLF1UdBf
         F7TvLTOrZh0ONXOkgyP0Xy+Ki84viUNuobvypApl+G4Te1hgqTzalkEcwYscV9sMbzYL
         otTA==
X-Gm-Message-State: AOJu0YzPTmL3GYlxKE824LaPPWtcNPUEtZS0eHampH9rg47S4zquYYJb
	3jYXcDMTiMp0T+2Ee5S5hVcV1DQwtH37
X-Google-Smtp-Source: AGHT+IGTu58JilIBfDpSy7tMqNuBcfjoioDdjm+UokXTsJGVIl9AVdtE2VsgkJoMSD2sydC3Nw35sn/h8sOx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:6942:0:b0:d81:68ac:e046 with SMTP id
 e63-20020a256942000000b00d8168ace046mr11989ybc.12.1695447377882; Fri, 22 Sep
 2023 22:36:17 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:15 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 18/18] perf bpf_counter: Fix a few memory leaks
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
	James Clark <james.clark@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
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
2.42.0.515.g380fc7ccd1-goog


