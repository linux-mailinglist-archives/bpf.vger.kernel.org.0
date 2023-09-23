Return-Path: <bpf+bounces-10676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC37ABDEC
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 07:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 17148282426
	for <lists+bpf@lfdr.de>; Sat, 23 Sep 2023 05:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9D1C38;
	Sat, 23 Sep 2023 05:36:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53F3FFF
	for <bpf@vger.kernel.org>; Sat, 23 Sep 2023 05:36:19 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B183A10E4
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c29d6887cso52790347b3.0
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447364; x=1696052164; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5vqIfXNWliDocU8tzStcp+r+OU5EjvAXvx9gVnGgcs=;
        b=GhGHPD2qvlwf6DPEFJ+9yvS+OHNHzTKjhuNdApz5z/GoqKX68u3AFI4wayELNU/30Y
         uqWwzPKCLls98voX1c3ZEoR0IIWdaw2l2YKBbZL5/bOb67lRDSQjuiuinpGDQJIzZ1Xe
         +zEwKIC34AdfWybCaqoHYKlTD/fTkn+g9M/dmHawF+giGaLFT+8zlSm6plTrql/TlRD9
         QcwWV4t4QCd+tQTvo4iH3BTJLd8lTcKOdP8liGHVFmVCQ1HqzArTeiRLonqw+oSZMy+K
         rvpNNmXWQSX1PB6aOznwwoP5ooJJ0m81SD4y2DYhB2cvAyDxfpkHTcdgzl6tRNNCubf/
         wK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447364; x=1696052164;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5vqIfXNWliDocU8tzStcp+r+OU5EjvAXvx9gVnGgcs=;
        b=Z0MZppFI6mPhmQ8JGSgcJG3pk+lXchyz171cod9xoMeywXbBcMikCClF6yh0NgRvvr
         GwJeYwZ7Q+Sz9/bizZbJ+uXE2fOGua8OX8OI5gpAynVjsl1Dsc7OejnP+Ak91aFzKbhE
         qk7thZHauCJpiTQ5RA5bWgj2C0hxOWiplHkc62WljXz0LDrbnV6lQoioasRZolAKXj6s
         wIYaqLegGPVjUHtmWoz39T7bKsEKFC0lLQzJ6bg3yamoq2nmt0zyV0IwdXPZUzgaTGdz
         zhgkwURYP2dRPWp9Y81jVnYM/k5+IlA2/LAUFWEsIpysPaiU8cj29CvtzKGAVSuVg4G3
         WwDA==
X-Gm-Message-State: AOJu0YweJIerVnXySCQDYJ06Jui3gmSvSMxPGN3GQSUvk6cY53anqiBH
	YgtNisFI3EUT3PU0EMkbKAgGlivp+sFB
X-Google-Smtp-Source: AGHT+IEsgOcl2A0UL8zGlp3FXRaWIZMQmNaQRl2Uoy/Z9jK5/KtmB2FVYeGP9zN3vSGo3xTtN8wODP+0jzxj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:264b:0:b0:d7f:8e0a:4b3f with SMTP id
 m72-20020a25264b000000b00d7f8e0a4b3fmr12822ybm.3.1695447363914; Fri, 22 Sep
 2023 22:36:03 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:35:09 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 12/18] perf hists browser: Avoid potential NULL dereference
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

On other code paths browser->he_selection is NULL checked, add a
missing case reported by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f02ee605bbce..f4812b226818 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3302,7 +3302,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 							&options[nr_options],
 							&bi->to.ms,
 							bi->to.al_addr);
-		} else {
+		} else if (browser->he_selection) {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-- 
2.42.0.515.g380fc7ccd1-goog


