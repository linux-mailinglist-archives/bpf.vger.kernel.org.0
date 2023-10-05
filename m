Return-Path: <bpf+bounces-11501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7107BAF23
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 10086B20BF9
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BF43AA0;
	Thu,  5 Oct 2023 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUOafyNy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADF43AA3
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:38 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F4F139
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8997e79faeso2352372276.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547375; x=1697152175; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=TUOafyNyFpkw5HlqfYRfZ2KDifTOAdVmsiDbHfjG/tZN/K8MzsmB/ZyW5kBRpV2Vxy
         de74SPcO2Y7bY63zeRo9X8qRZb4HqiJdZ5erMNkRGnn2RLShlYln8bQWo9Tr1me2ePok
         FQI67umDKydZoQghwfHdaV8hDbSXJh9GRZgQ1CsKGmFkPlmL5MO7j/icse3vDywordTm
         8W/sjG/pfzMWKZR3cNINtiHol7zEsm3s0i4AxMwLJqVdmUaG8VVo0nQtuiSl5ljNeFF9
         URw4OS+6wvbgPA8PFEREKVzNQQeBUu89MH+A/ukCoDC3jrHzJDnR1x+stOZJBTl/VL/k
         YAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547375; x=1697152175;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxVOZd3C3ppqYjNmukwrdUncP0WHK7JyRq4ciQhpawI=;
        b=L+xgkkf95fBjPD7ChKmEz27kSsindDlmrKL+jKGD6XyZ85uwL3OYafTd90uuVIwpDI
         xubjBLQbMHeyRNz74+2boq77zCUspYod59VneHrDbfDHH8eDUWQlthwMsbhp/+bmVBNm
         KfPF3jjs4hfD75EkJaxZLWfMaaHCNwVqEFS8liL4qkBZhePVmukYtC+UptoE8WScN9Ty
         SyiW3WULefOO0b7myPfUZM0pl6fU3Gt1jKB/pKxnJzvyx77YTWARB2AeWkCnKtO9FmPN
         kdFX31FVzuRKIkxUucXL//XZfgRyG/VdYCXfSZQ5vd4y+p0ciPAeM66kXF67kR6wtTxw
         hnrg==
X-Gm-Message-State: AOJu0YxUpp0kgkomdHQ/9F0mLoSQw0JAsKVuxAujLUgF0VgN2faK6nGO
	CwMigX36QjLbbBDlkzvcL0/67EBMzA3C
X-Google-Smtp-Source: AGHT+IGhoEJjFH3ZasD0vN2aSL1BJQWA509hpCLmPH3Yh8OO4E14fhwoU9hhQx/jEj6F0UZsTT+z8Dsn07pZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:6a04:0:b0:d89:42d7:e72d with SMTP id
 f4-20020a256a04000000b00d8942d7e72dmr57696ybc.3.1696547375084; Thu, 05 Oct
 2023 16:09:35 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:49 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 16/18] perf trace-event-info: Avoid passing NULL value to closedir
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If opendir failed then closedir was passed NULL which is
erroneous. Caught by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 319ccf09a435..c8755679281e 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -313,7 +313,8 @@ static int record_event_files(struct tracepoint_path *tps)
 	}
 	err = 0;
 out:
-	closedir(dir);
+	if (dir)
+		closedir(dir);
 	put_tracing_file(path);
 
 	return err;
-- 
2.42.0.609.gbb76f46606-goog


