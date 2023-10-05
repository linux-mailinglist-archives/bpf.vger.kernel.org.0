Return-Path: <bpf+bounces-11492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3CD7BAF0D
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D0320281F88
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6A43A80;
	Thu,  5 Oct 2023 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yGE388Mq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90D1640A
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:18 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6C8D5C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d816fa2404aso2121813276.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547351; x=1697152151; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTpWBQgPQVQy0TAZXLEWpBVQQ2YTPMy6ZmoyjFN0GGE=;
        b=yGE388MqJTU/fjPZnES+SGVGN9DpeJ67NXpzBBTNoFPld7Qa3qESa4n/bz8CNqTOwf
         HIIQWmLaUlkebgzY4Q3gKNp90E2XoDbKLIEPKdzYGgO6XCDdXMQAH9SUaiT8BtMHgLHy
         E0YPNMcbvC3wzbIzAa5emj5zUQ34vMY2hOrCDU8z086mUTnMggBg2JOChXXgXU7Uhrh3
         fzTrJ7zsslmFzOna+9kSTGk0EqqQhIKvaQpsh3VYC5GuXEZaFUBAStumtm/9oj6k7uNi
         72yCdGjHiikGpKiyR+LAmw8DW7eipCJKVo5qyt+dnG5TXlP6P/IAeno+FWc/5hgpw4/1
         UxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547351; x=1697152151;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTpWBQgPQVQy0TAZXLEWpBVQQ2YTPMy6ZmoyjFN0GGE=;
        b=AjXqzQGqakPUPXzCjMEfp0TQdMxzlNOZoNynCTu3iC5RROKqo35veKdAT8cln0k4m9
         rpsgfpWlVf9jA28i+FZbIgk9lj+gUblxDYEbypENNd3BDsecbkodm3vKeDZg+S9klA0d
         n13xtWLOGGHQI/4sgLi9J3XfMK9EF4ZE+72ab8aDmlHjrV8Y6yV/pAZqqjzv1j5jpjES
         ghAxMCxQPX7aXfa9UmjvIbyDddf84e6isuxeWIuAyTJxLvRErRCNvNSFEwmqj+pFODfa
         LmtdXGxiv1byHX2Z4KWNi1OWCwGQ30UpzfbCf0QQhYSr3WR3poXehUULLUlx1Qm4DmXG
         3eeg==
X-Gm-Message-State: AOJu0Ywv0+JaX9gxvrC0b0eOaQ1JuRZ0s5hyLDeuA4s7PfsL/HNm64uy
	uYYvfdNDuHqcjyM013XcOJenoz5oEJ/X
X-Google-Smtp-Source: AGHT+IGnxaCsZLcDNpjb2IRnCqzooQl7/eSuSXSt2DJTDf33tEW2BnCckAmI3vVY62Ne9wg9AkMtIxPrNICk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:2513:0:b0:d0f:a0a6:8e87 with SMTP id
 l19-20020a252513000000b00d0fa0a68e87mr93479ybl.2.1696547351036; Thu, 05 Oct
 2023 16:09:11 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:39 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 06/18] perf buildid-cache: Fix use of uninitialized value
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

The buildid filename is first determined and then from this the
buildid read. If getting the filename fails then the buildid will be
used for a later memcmp uninitialized. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index cd381693658b..e2a40f1d9225 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -277,8 +277,10 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	char filename[PATH_MAX];
 	struct build_id bid;
 
-	if (dso__build_id_filename(dso, filename, sizeof(filename), false) &&
-	    filename__read_build_id(filename, &bid) == -1) {
+	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
+		return true;
+
+	if (filename__read_build_id(filename, &bid) == -1) {
 		if (errno == ENOENT)
 			return false;
 
-- 
2.42.0.609.gbb76f46606-goog


