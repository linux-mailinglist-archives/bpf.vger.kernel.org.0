Return-Path: <bpf+bounces-5754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0A9760055
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC851281494
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3411193;
	Mon, 24 Jul 2023 20:13:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A201094A
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:13:08 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F5172D
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:13:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso4733207b3.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229583; x=1690834383;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hkxh9LqcegTaK3Zyb2Y04p/jheCyz+iGuZbjHft5A=;
        b=dFnffByPi/9dPdpPXDPeErJAHkm4U9xmJEkUxTK523YIBmo/FhKa35iXauOduV2Pif
         qhrvAqczwoe1kO5YrqsE4HVa/uBo3+8dpoYCh3NieWigFEDe/IVK3O6HH6OdtI5i+ZM+
         2KRDhnab4TtHa6Xfwmg8rPe40dTtSGrCgHfS12vvP8ClkpFCg2qRBovuROUDtaY7RgGC
         rq6iGpbsv+MFoUANFCBaKzXVulRiJgAxltKkaziWxEl+HKkX9SEO4FlhIeLqgOjRtUd/
         7j9DqAayTNnDqpM5MrM1rjP74kQsTEvcd8AjHnDSeFYehB/V4Gfm0pF0X93t3kqOaUQl
         OgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229583; x=1690834383;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2hkxh9LqcegTaK3Zyb2Y04p/jheCyz+iGuZbjHft5A=;
        b=jjQf2aMVcuVkLm/fRG0DD4sCRTrWnj0oP7L9Os5QwLDKWrqzDuk8HXKjgh69SdaEyK
         gyLoe1NebO7shWkNymOc0XOFXV6GHFYHYcTIvlIJXVuIb2yxFD4NONKRUfdfCMqN6Fo3
         vxtJoTyit0xtmxldy8UrdZ3ICg6YkczfVIto1j9URgGF16H48GnSOwsnPRspCqtg8xIN
         AZJYGsqYfn5WCNQO5RpdNIxPrP4zl5pSIKoxhNHSlZdQ+jjFOzLSK4pNb53EtzLLNf+4
         1neInvTY/KvS2T1ktelAuuKdeLHikz+GF1cK3dtMq9ZT1w2OB63fc53ge+JFU+DSildM
         lINA==
X-Gm-Message-State: ABy/qLY292t7FmremgpWKfWwjJz87Z805hR7LujDwn1I5NlAMxPWr7Ra
	Qsu6qg/SItTtNLM4eSzbIQ67mzUmIFSy
X-Google-Smtp-Source: APBJJlEcBOZe3u432ZlnenysdB3kMfqSv4wJ57ueFyPxQ8WNtoVZQq8B8/KVokgcDdDgdzCi3rPmRZZpci+e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a81:af21:0:b0:56c:e585:8b17 with SMTP id
 n33-20020a81af21000000b0056ce5858b17mr70674ywh.5.1690229583398; Mon, 24 Jul
 2023 13:13:03 -0700 (PDT)
Date: Mon, 24 Jul 2023 13:12:47 -0700
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
Message-Id: <20230724201247.748146-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230724201247.748146-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 4/4] perf build: Add LTO build option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Cc: maskray@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add an LTO build option, that sets the appropriate CFLAGS and CXXFLAGS
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c5db0de49868..a9cfe83638a9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -256,6 +256,11 @@ ifdef PARSER_DEBUG
   $(call detected_var,PARSER_DEBUG_FLEX)
 endif
 
+ifdef LTO
+  CORE_CFLAGS += -flto
+  CXXFLAGS += -flto
+endif
+
 # Try different combinations to accommodate systems that only have
 # python[2][3]-config in weird combinations in the following order of
 # priority from lowest to highest:
-- 
2.41.0.487.g6d72f3e995-goog


