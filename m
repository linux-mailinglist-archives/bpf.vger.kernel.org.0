Return-Path: <bpf+bounces-66889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7268B3AC37
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2142A687E45
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3722D193F;
	Thu, 28 Aug 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfBdZuEo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A732BE63A
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414798; cv=none; b=CyMpteJzucjyzcROqxaZaSS7F0tOHAW1u+WWex0ZSAD8tBy7XZwj6AqpVyCNA8cdAMfuaoJ+2eU6Fu1LjGb5L9omwPX20DxET7RQvv+B3TOLekK4U2kkdJipLiJLbhlh/RdbZLMkK+02ln7wCJ9NK0lld02NYUejmALM+NoNQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414798; c=relaxed/simple;
	bh=HP2hsRF/T6DsMoG88ZIORykf1DmPqLqdbYaGBKIMD4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DqLLTGUbT+e+mbAHMPA5h9TrMz195Y9wSoeIpgZb+SEjzC21yxQyXcI28hR94Ykex6xDdu1Lv3ylRB4fQmt4jky9Z9YXK/jOl+UeTvOrT5CLsxgqbvMsRIOfaIJzypcpKhvd+AnzLbixw/Ro0qnDkF3YM35/gGQfnK/T/lmc7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfBdZuEo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c949fc524so315745a12.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414795; x=1757019595; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFuVdKQbWtAWkfjn4WwxF7ezypb8BrOvzInrkmEPeas=;
        b=SfBdZuEoBy+uXcA1+XQRamX77dZtusbeJWdGiTB/ZG2J5ng9PlwjFJOlVwCJV/KrzL
         V7OzU8vNQLhHEmnV6sFqhbDUhUhMpBcnSYIk9GSciI4r7Sxx+AtSo3IE51GvCrprU9dz
         6vQ2TlR45XorMOmA10sgC2cjJDInlD83K/UtAvyu2Hw3lssp1BbLYLrsM/bs+KgobOES
         /QPuB2vLYHI2rImPtiQiHkS+cjvB6iMP1hyDvPDxaSzfRQV3HmDCWX1ePexyQQkvRdun
         pQLk0jpcgDpdZpel5DAKLnd2DAoaf8AmE+VPrQOVJYv+v+8fzbOPp87A+8S2QGSPtMCK
         ZvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414795; x=1757019595;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFuVdKQbWtAWkfjn4WwxF7ezypb8BrOvzInrkmEPeas=;
        b=co9ZTWEXFrXW8aMu/Yb/beP8kg0sxCA8YkfqYivrywcvcq9XZhy+NmXmoPdkrJ5NfX
         R7iOdJ+wsG3Y9qgtJjhLqbJdKsr7LmHHrFsw9pLkNmWWTLIbEhZJoh3846nX55P3+D0g
         jdd6CU/lXkp1IPnKGBOjelD1srhz/rkFeQ61+tBxsoTr5/8L+pnF6VgMMkAsf/8B3Wap
         ceOT5EyG/m86Yq1tHJMpRpDc2OAkAih89dfFYUzMbbJpF1MvCiTeRQPizZZ2dbJy9WAv
         sJAlCa0x8DNA6CMvTlyHClGXPjRjpvI2gfz85iyhTBRX4txmQ4DkpwxnPkJZJGsbgN8v
         v26w==
X-Forwarded-Encrypted: i=1; AJvYcCWxsKPhsjVK1uLNVHnO88EnEG/Lyl7HBYcQhFsPJvz53JtwlJbmBvO36sjLtlDogh/A684=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1qst1xIAfyFbaSoHQrobFGcoVByrwfxwqx3yJV+XYkL0/be0
	nqJk3mYgI+AJrOTP6QfvApHZ3I5S5W5WRZRVWVpOG/B+W2876naAtBpysTYmH8/ecnKngb8TgAM
	X1F9d26MPTA==
X-Google-Smtp-Source: AGHT+IE8pbUPgReMEKQLmcbkY5a56WN83ZuLshDVRHMu7w8Lya4sJi8+4DhEP9CqzDo4ZZazT7Bha/6TfqZa
X-Received: from plbkg5.prod.google.com ([2002:a17:903:605:b0:246:9673:3625])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e783:b0:246:d98e:630
 with SMTP id d9443c01a7336-246d98e09c1mr187591525ad.44.1756414795293; Thu, 28
 Aug 2025 13:59:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:16 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-2-irogers@google.com>
Subject: [PATCH v3 01/15] perf parse-events: Fix legacy cache events if event
 is duplicated in a PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

The term list when adding an event to a PMU is expected to have the
event name for the alias lookup. Also, set found_supported so that
-EINVAL isn't returned.

Fixes: 62593394f66a ("perf parse-events: Legacy cache names on all
PMUs and lower priority")

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 28 +++++++++++++++++++++++++++-
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8282ddf68b98..c219e3ffae65 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -465,8 +465,10 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms)
+			   struct parse_events_terms *parsed_terms,
+			   void *loc_)
 {
+	YYLTYPE *loc = loc_;
 	struct perf_pmu *pmu = NULL;
 	bool found_supported = false;
 	const char *config_name = get_config_name(parsed_terms);
@@ -487,12 +489,36 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			 * The PMU has the event so add as not a legacy cache
 			 * event.
 			 */
+			struct parse_events_terms temp_terms;
+			struct parse_events_term *term;
+			char *config = strdup(name);
+
+			if (!config)
+				goto out_err;
+
+			parse_events_terms__init(&temp_terms);
+			if (!parsed_terms)
+				parsed_terms = &temp_terms;
+
+			if (parse_events_term__num(&term,
+						    PARSE_EVENTS__TERM_TYPE_USER,
+						    config, /*num=*/1, /*novalue=*/true,
+						    loc, /*loc_val=*/NULL) < 0) {
+				zfree(&config);
+				goto out_err;
+			}
+			list_add(&term->list, &parsed_terms->terms);
+
 			ret = parse_events_add_pmu(parse_state, list, pmu,
 						   parsed_terms,
 						   first_wildcard_match,
 						   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
+			list_del_init(&term->list);
+			parse_events_term__delete(term);
+			parse_events_terms__exit(&temp_terms);
 			if (ret)
 				goto out_err;
+			found_supported = true;
 			if (first_wildcard_match == NULL)
 				first_wildcard_match =
 					container_of(list->prev, struct evsel, core.node);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 62dc7202e3ba..c498d896badf 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -235,7 +235,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     bool wildcard);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
-			   struct parse_events_terms *parsed_terms);
+			   struct parse_events_terms *parsed_terms,
+			   void *loc);
 int parse_events__decode_legacy_cache(const char *name, int pmu_type, __u64 *config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index a2361c0040d7..ced26c549c33 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -353,7 +353,7 @@ PE_LEGACY_CACHE opt_event_config
 	if (!list)
 		YYNOMEM;
 
-	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2);
+	err = parse_events_add_cache(list, &parse_state->idx, $1, parse_state, $2, &@1);
 
 	parse_events_terms__delete($2);
 	free($1);
-- 
2.51.0.318.gd7df087d1a-goog


