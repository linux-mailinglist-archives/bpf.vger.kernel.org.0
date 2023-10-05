Return-Path: <bpf+bounces-11499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AB7BAF21
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7D781282A7D
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0FD43AB2;
	Thu,  5 Oct 2023 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qjtCvls5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476843A93
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:09:37 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74413A
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:09:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8943298013so1910842276.2
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547370; x=1697152170; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=qjtCvls5v8mag+wFClqLuBaKLzk6ijHeHJt4XcHzOxbnR1rQR1spiwejCbu0YVBuI/
         cluu6B6kbyRaJ1sb5HPqGcTgislwsIrmQWi158NgzXwvwL7G13hlOacWou+SijnRv0Lo
         Mw8ClDoyvOpV0QXDm7rs1UPsVGFLhLeuc3XkQv+MctNpbw8bmo8B+dsSdPqVLo6sKQb3
         gIbydW4Zzvx9cGBKz9yPKhnhXDRW1YOvrOvPJzkQd3ctbyWpOWoDfLx4UoF4RvTkgU0y
         9O4Gn02xioFzNdYrO0/maAxkgco11ttZ63P+F9/y/OpL6PXFG6fPbXb4iH9+7TQidOgx
         AWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547370; x=1697152170;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGxcidzGPRegna1u1K7BT077Nrlph2dhlmMJs3FQauY=;
        b=oVv0I4/JYTDCLpEsagSO7Ul65+m3Sxm9R07yoxFs0PeJit0Pp+dIQRj8EYMxNyGfmp
         gMasS3QKjXae8JFNGSLWm6NOout5fEI3wmI3JrfY0oK2fZmKh4aMevQaCsF2OnuHrCK3
         lqKc9+LxeCwEyHiIa7wl1xYU0iy3vQEWTTWC54the1XB/ChFTZ/GYulKFPpkvc47g3Ma
         9NNzGtMPIFTNAcYiHYHNqVGr3oxV4cK5wiWtx4SjEJ8EMN3kNq4cNvUSlQAAUP98koIO
         1H0yEvSdhQQP7AqbOGbuktKBjmDhJ9LHHfZh4KZYYMs4TNjaWtuSKdPDY6gqDNUoEa+v
         S6/Q==
X-Gm-Message-State: AOJu0Yzzi+g+pJIBzj/BGgRu8v9e6YBWZ7OcUik4vs7CxtZbct/g8kMY
	8C+JcGQGoh8f/OKqWnQH90dOndqr4XPS
X-Google-Smtp-Source: AGHT+IEgTi3PLG+3o2WWDEFrIlbIkR+q1EaEaSDVhwE+qexUhANhreJWyGErr61dmZWaJXVBJMGi41ML+jYa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:74c2:0:b0:d7b:9902:fb3d with SMTP id
 p185-20020a2574c2000000b00d7b9902fb3dmr105008ybc.0.1696547370559; Thu, 05 Oct
 2023 16:09:30 -0700 (PDT)
Date: Thu,  5 Oct 2023 16:08:47 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 14/18] perf parse-events: Fix unlikely memory leak when
 cloning terms
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

Add missing free on an error path as detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c56e07bd7dd6..23c027cf20ae 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2549,8 +2549,10 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, /*str=*/NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		zfree(&temp.config);
 		return -ENOMEM;
+	}
 	return new_term(new, &temp, str, /*num=*/0);
 }
 
-- 
2.42.0.609.gbb76f46606-goog


