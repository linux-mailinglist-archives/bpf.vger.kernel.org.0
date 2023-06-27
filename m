Return-Path: <bpf+bounces-3586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602037402E6
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C1281126
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38151ACB8;
	Tue, 27 Jun 2023 18:10:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F019BB9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:10:53 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3722D4A
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57325434999so67281967b3.1
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889450; x=1690481450;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=DwonPv3+k7d87RYPLiQHRluN8geVSL/JuBedm0iIRSSridMUKd+QRAh1UTNbrX4Rc+
         2tRuCmYb7a+HMHtj2KZX571wOPyJrGR60Dq3/+JaFxSG0GwbdlvEzEp6fxBQetHs3DJ3
         yFXaBGg9M+J8lE9iiX4UNTSDmX6x5pSWn2U5u/BIDPEoK5Qg185uhmRrS8ED6F1LE5jG
         dabyrr6kNBhj3hMpTPKXaptlQ3c9GVv9jv0jzRjvzTvVfngEgYWKc5xQfRpm1tT/IC7W
         irQV1RF7wayw3JHLbxBub63u0hwGyuMWjq1Y/13neXOMviL18Rv36saBLHX/JYwsdlo6
         mElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889450; x=1690481450;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=kUhbIMdjYhLb47HmH2v7cFdo1IpwpYxc77bIAi+CeWcwk9Xf0D/azB2AURzbk/fty9
         P29tjE0IQQZu3bi9H/6laKQtHJMOtf2JZhmUlloZzesvSILKtygq5O2CbtIvOi61naLp
         RtjYCOqCr6aiu3Uh6m09sC+b2S3brZW82U/xS901WZOedBhX6j1qQBxt6oDCZ6b7kKeO
         /Y1EATJiNTMzkDiG49hENRRDqcrAbbGbRScTTEvOBflEtKwVWjQk2yeoiAkOVSD28a/n
         hy3krClyxFLDXN0Px3eI6U2kPQbCgZG2MNFtJaqA0Qw+8Oj8JQGMmNlz4sOoshP+Czxp
         sATA==
X-Gm-Message-State: AC+VfDyAA+zAoScQCWIsfi6spqArLp+4kab5PyZ1rm8QE1y8Lv7L9zu6
	ZDXD3GJxPc/IbYrdDz5y79CySgFOtRUY
X-Google-Smtp-Source: ACHHUZ4XYIxsTEbA4adKWxNXnm8MjJHZ+dVuNGVRGkIxnc/aVH6goL6IK/5IA70vJOxc3jszcWLIrfctyYob
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:ae64:0:b0:573:7ae2:2684 with SMTP id
 g36-20020a81ae64000000b005737ae22684mr9718244ywk.4.1687889450770; Tue, 27 Jun
 2023 11:10:50 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:21 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 04/13] perf parse-events: Add more comments to parse_events_state
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve documentation of struct parse_events_state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b0eb95f93e9c..b37e5ee193a8 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -121,17 +121,25 @@ struct parse_events_error {
 };
 
 struct parse_events_state {
+	/* The list parsed events are placed on. */
 	struct list_head	   list;
+	/* The updated index used by entries as they are added. */
 	int			   idx;
+	/* Error information. */
 	struct parse_events_error *error;
+	/* Used by BPF event creation. */
 	struct evlist		  *evlist;
+	/* Holds returned terms for term parsing. */
 	struct list_head	  *terms;
+	/* Start token. */
 	int			   stoken;
+	/* Special fake PMU marker for testing. */
 	struct perf_pmu		  *fake_pmu;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
 	bool			   match_legacy_cache_terms;
+	/* Were multiple PMUs scanned to find events? */
 	bool			   wild_card_pmus;
 };
 
-- 
2.41.0.162.gfafddb0af9-goog


