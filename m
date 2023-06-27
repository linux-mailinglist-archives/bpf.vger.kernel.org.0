Return-Path: <bpf+bounces-3527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9797973F37A
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A8E1C20A6E
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C11399;
	Tue, 27 Jun 2023 04:35:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFDEDA
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:29 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D181720
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573d70da2dcso50846297b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840527; x=1690432527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=nE40fnnx3qIWki2nYoA1/v+G94eRqvQnMCSdQVEcoIAqwcEqwdH5xGRvoHMULswyJf
         hhKw9DtpPkkz8cb54YlMMwGZgQ8O12QZhSxRQ5mvhMtNxGcTapD1UlIbIKPgEPWELXX3
         C5iwOLn3MqPpb4wj/NtGS00FbCmi9fArMLRxr5XvmkOrIRIfseXua16fYYLG8sVa6+pv
         C4w+3TfaroczYIfF8GVov0g4BHnB0pL3rFgPayuOz1LU4ZKTyEwMypxfoCQU65zCV9yl
         QYRQfwHZewdzPshBiNrkAkTu1pDGQJ4M7zb+pCqqXiXUB3rh4hqdWm9maUqJDjphnREL
         jgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840527; x=1690432527;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pylB9mwmAKl3TUVj6l4nL/JaxRJCwOWbixQnNb1VbG4=;
        b=atF5cbruAxd9QMfAoSASGX0g7yBdvTU8mvRJh3XlAb4PspYiIoV25TKtTPo/fmruuC
         CFAE7byzDd3RQEKGF/en2q4AbUPJDb+iPSkuEWtPGRajw5X7o6oZB3K3neQGgalnLRS5
         w1T5ZNrVFbrlHsPLcrRkmp0gH8ecoS/1RecP6K4nxIg1jVG4OojDqcqcHNfxNJCxhOhW
         z0smg1OU0PxM/ag/EQk59YyeX5+0ZjKBumiUSb1uN7LYcKGCPHsj9NVbI26hqY6NwA/s
         pS/on8oBDglaVqyDB1MGIzpOvxdBi7U7+W5fHNxQ5jUSzyha73SHa7fbPy4FwmG7UXHr
         P9zw==
X-Gm-Message-State: AC+VfDxxA6YpHeB94q0yvo/aj5Jhg8bvTf6EqijUHdRh4JfvC71DATty
	BJ3GplK710jgZNjZ8DPKqLz+XTuqjcV8
X-Google-Smtp-Source: ACHHUZ5Gu3B+VYc3wNgtTeuuaO+/RDP6QeL6/VJYxih1YVprHtkiMZEOVqkUu5UNnJWhXb+9Y1cwSlJTY8bA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a25:74c9:0:b0:ba8:4ff5:3217 with SMTP id
 p192-20020a2574c9000000b00ba84ff53217mr6843137ybc.3.1687840526866; Mon, 26
 Jun 2023 21:35:26 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:49 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 04/13] perf parse-events: Add more comments to parse_events_state
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


