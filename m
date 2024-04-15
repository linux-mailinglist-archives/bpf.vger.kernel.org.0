Return-Path: <bpf+bounces-26742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E68A4832
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794D9281D07
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 06:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B1F208DA;
	Mon, 15 Apr 2024 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrgtutIL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE71F951
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162997; cv=none; b=FzTW9LX2KFIExsRtav0fi5rtaytJDijwjNkgyRWpNrpch0NQwDDZJDiz20e7blIK7MIM8Xk2YrIlubNFQs15jyoT2ANNJn1mck3is3O3Ak4nb/34ZN/0RSQEH2klH4TlWrRmV50mSb3ufm+gq+tGfthponN0vQJfKKaKdgmAT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162997; c=relaxed/simple;
	bh=O7hIVbr0xqoOv6vBJUBcktxWCtmfzAofbpA7+d5SIhs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=A7R5rs/VyimQ7Ym5hVYcKs1AAcSxU8T+b+NhU+85x6CiU5EclwdGDv4GyNpIgOdXGKfEj3jlGQW2yOEHzf4ziLLfkKC3lbGipXfYbNdbMbRse5JdPFXPSVjFPTPCau/E+Ui2xmXk82nfWXZFh2UDbojgIH80jtxfLcyyPgpAzns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrgtutIL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so3111603a12.3
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 23:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713162995; x=1713767795; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBIPczyGmK1H1pt2G8mgcHP61YsaqzYuWfuwlwliFdk=;
        b=RrgtutILUolHbtiLYDeQ7CZbZ872b3LlbNocS+Hx6FpRHOOeyRY5wLvAQUCgtP80f/
         rIWx3yQPAKNA9UozRK6c9+Cb7lLPPqDqAVqiy4ebspFhVIMUlbOgRWk6gVwpmgGEhly0
         yoc5uYsXIMOrLvn9TW27reVlWkLXAKxAW/FePBVb9boAkxRZCrCHfdoQN7Gq8rwFYBFe
         ejjmQ2ciD2C79XsVRgul3H6X9GU//Yu2/3g1VXyACIveSTWyopXGevm6mFKle+TMKnbm
         rHaP8b6wuAz7cYM6LBKRVw75sTEIZzhnJEBELE0eqPz4whaSpj7FhpbNcJ7Erd9ifX/j
         2yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713162995; x=1713767795;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBIPczyGmK1H1pt2G8mgcHP61YsaqzYuWfuwlwliFdk=;
        b=VWTFLVaQHY9+bbyyu77Gy1KiikYuUtl5CiJ6vOk6DpoIa/b7Zjh3jzEdbvZk1b9r9j
         foAePUujwBHWNVnb19mrAYMG+O/DSALNPKmZeH481fWdT32D2bBLyt49zw9hFXY8S3aw
         j7CazigbI07CUlj9J2VcJidWKXeHpay87S6mD6k+mOJPIK7QShCE3fXRppkmKw1nR53l
         I+amHKbIgMg4nR8ZXoAMpUYaOB/rBOr+MGDQR40ucrMeAATRWZKIELoR17B10RJ+sKIw
         iilBezOY2XVXVVD8eeAU0dvbgByp9xGaQjZg4Z7Du+egCQRZKhRQP11o9KR6AZgnM5dv
         U7yA==
X-Forwarded-Encrypted: i=1; AJvYcCXUS7xp7Gs6KpbvjwKnmKHPlCXUM5C2WRbvXfvcSX2zO35w4ovwKtJYty8/iPseo5V5NJ5WvqDxguo5steUHRiZ78Vf
X-Gm-Message-State: AOJu0YzBEtsKQXnSZwPBM2O2JrCldMcLJ+0QoVPiOm5Y8Pu3gbIQMrbQ
	B8YGPy+B0fGlHHYhi5D6mwZb5VWAwSHpEAYurRMv5Za48yNoGfUKzJ3h3Xm5MwRlTygUUnXfiuP
	syOCp9w==
X-Google-Smtp-Source: AGHT+IHksE11INoODcmfSA8PUTVNGXIlCH66XxnH2VvOntZKJzWoEyBWTiUDIjjhs1caK8c5pV3a1jp10fJX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a63:f919:0:b0:5db:edca:d171 with SMTP id
 h25-20020a63f919000000b005dbedcad171mr25389pgi.6.1713162994834; Sun, 14 Apr
 2024 23:36:34 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:19 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 2/9] perf parse-events: Directly pass PMU to parse_events_add_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Avoid passing the name of a PMU then finding it again, just directly
pass the PMU. parse_events_multi_pmu_add_or_add_pmu is the only
version that needs to find a PMU, so move the find there. Remove the
error message as parse_events_multi_pmu_add_or_add_pmu will given an
error at the end when a name isn't either a PMU name or event
name. Without the error message being created the location in the
input parameter (loc) can be removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 46 +++++++++++++---------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b16c75bf5580..bc4a5e3c6c21 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1386,32 +1386,18 @@ static bool config_term_percore(struct list_head *config_terms)
 }
 
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, const char *name,
-			 const struct parse_events_terms *const_parsed_terms,
-			 bool auto_merge_stats, void *loc_)
+				struct list_head *list, struct perf_pmu *pmu,
+				const struct parse_events_terms *const_parsed_terms,
+				bool auto_merge_stats)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
-	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
-	YYLTYPE *loc = loc_;
 	LIST_HEAD(config_terms);
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
 
-	pmu = parse_state->fake_pmu ?: perf_pmus__find(name);
-
-	if (!pmu) {
-		char *err_str;
-
-		if (asprintf(&err_str,
-				"Cannot find PMU `%s'. Missing kernel support?",
-				name) >= 0)
-			parse_events_error__handle(err, loc->first_column, err_str, NULL);
-		return -EINVAL;
-	}
-
 	parse_events_terms__init(&parsed_terms);
 	if (const_parsed_terms) {
 		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
@@ -1425,9 +1411,9 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		strbuf_init(&sb, /*hint=*/ 0);
 		if (pmu->selectable && list_empty(&parsed_terms.terms)) {
-			strbuf_addf(&sb, "%s//", name);
+			strbuf_addf(&sb, "%s//", pmu->name);
 		} else {
-			strbuf_addf(&sb, "%s/", name);
+			strbuf_addf(&sb, "%s/", pmu->name);
 			parse_events_terms__to_strbuf(&parsed_terms, &sb);
 			strbuf_addch(&sb, '/');
 		}
@@ -1469,7 +1455,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 		strbuf_init(&sb, /*hint=*/ 0);
 		parse_events_terms__to_strbuf(&parsed_terms, &sb);
-		fprintf(stderr, "..after resolving event: %s/%s/\n", name, sb.buf);
+		fprintf(stderr, "..after resolving event: %s/%s/\n", pmu->name, sb.buf);
 		strbuf_release(&sb);
 	}
 
@@ -1583,8 +1569,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			continue;
 
 		auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
-		if (!parse_events_add_pmu(parse_state, list, pmu->name,
-					  &parsed_terms, auto_merge_stats, loc)) {
+		if (!parse_events_add_pmu(parse_state, list, pmu,
+					  &parsed_terms, auto_merge_stats)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1596,8 +1582,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	}
 
 	if (parse_state->fake_pmu) {
-		if (!parse_events_add_pmu(parse_state, list, event_name, &parsed_terms,
-					  /*auto_merge_stats=*/true, loc)) {
+		if (!parse_events_add_pmu(parse_state, list, parse_state->fake_pmu, &parsed_terms,
+					  /*auto_merge_stats=*/true)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
@@ -1626,7 +1612,7 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 {
 	char *pattern = NULL;
 	YYLTYPE *loc = loc_;
-	struct perf_pmu *pmu = NULL;
+	struct perf_pmu *pmu;
 	int ok = 0;
 	char *help;
 
@@ -1637,10 +1623,12 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	INIT_LIST_HEAD(*listp);
 
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
-	if (!parse_events_add_pmu(parse_state, *listp, event_or_pmu, const_parsed_terms,
-					/*auto_merge_stats=*/false, loc))
+	pmu = parse_state->fake_pmu ?: perf_pmus__find(event_or_pmu);
+	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
+					/*auto_merge_stats=*/false))
 		return 0;
 
+	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
 	if (asprintf(&pattern, "%s*", event_or_pmu) < 0) {
 		zfree(listp);
@@ -1660,8 +1648,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 		    !perf_pmu__match(pattern, pmu->alias_name, event_or_pmu)) {
 			bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-			if (!parse_events_add_pmu(parse_state, *listp, pmu->name, const_parsed_terms,
-						  auto_merge_stats, loc)) {
+			if (!parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
+						  auto_merge_stats)) {
 				ok++;
 				parse_state->wild_card_pmus = true;
 			}
-- 
2.44.0.683.g7961c838ac-goog


