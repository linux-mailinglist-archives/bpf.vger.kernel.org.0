Return-Path: <bpf+bounces-66845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F228B3A661
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15644683EC9
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09388322DA9;
	Thu, 28 Aug 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShwcZpW9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2021578F
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398765; cv=none; b=VaaxqlSr0/OEl0bYJZnXgU1+l+bGWMPKtlvIJczGiHutl0CIVbZzIfnkF7TVryc2+Yt5AbXnhxCGcYWcs+S76JD8vQcoE5D18IE2u2ckKcovn97rlh8LXYoPlWUYlnzTtxu8RnvykUs7gaRe8g1AGHwxp2Qm/R3/n89DzwCCbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398765; c=relaxed/simple;
	bh=J11KFE1Be/Xr62/bc+bzuCs7KvWgB6SiP/dHHQRBxgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KgRR4Son8evROEyF+J4DidUK7Nj7pXOzHiBlohuMO1vTtkKsFkGc7aPLbiasOYBSI9lAkWqCjBNzodSQCx85pDEQloGd8k/yvm35P+cfeePypUI6yETrUqsiNrsYYgvMG3RkvKl2ywjPnkxUUwNbjzhqoGex/9bRO6coe2AT7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShwcZpW9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246266f9ae1so11075255ad.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398763; x=1757003563; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQ/ghY8pg6tJyPFakofOZholK8TaewPdt9a6aHSESZA=;
        b=ShwcZpW9uvT2W3p+ofesDQoxkvnxB7LbiO5PHx43lh4DPWtC2upTUCLQci1lB17iYh
         +/azhNgft+WwMg4fF5Zuckm5a5QaM7yeHT0IY6WWITrdBu12pmJ+lQrdWcUmbIMa1Qi9
         ZtACNzorYUM4eUrbFW2rAZ8ljQVtfwZ1/GMqHx27PUYXpx1aHCrp8uLvU5XMlQtWvkkP
         MueMwVSzESIUwkhVvzJZ5I1tqB5+wRbtE6oiXcZ000Z4h5SJudjGE7DV0xWwL6CjVEJB
         Qb1ohyXERJ1QCYpiNUm2Cp6XzbL1zk2ufWcL6+5bsXgVkWTbqV4z3lOAemId/lM092ea
         9Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398763; x=1757003563;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ/ghY8pg6tJyPFakofOZholK8TaewPdt9a6aHSESZA=;
        b=l3fcG5pBzReegFbY9fDETkeEmZJQH8lnH4FvU4EwZ3G34pNkCjpPGO+xH1uHeCJ1Wb
         TqOBl47Xaa78IP3CUYpuB6aqfzHHUNtYDWhoLcVsCfQSl327pZxrYPxR8+Wp31yKLSU1
         xjIirJL3NjeOr7EgAYZ8ehGOSq3dUyIAbF934bDX8ri3IF6LcaM5hJOj8ZnLppvjxJ17
         aXTl+Ygu6RhDl+wPkK0UNlJtbLSjcAecYJA0eu4uneVv4fa7qqdBwIV222Y06Rgqnmq6
         LO14XmNk5bulgKy+Q2dsckrtPIA80t/Aj+ku7oJ/BGIQevvoPUhwaSudZFLUP5gZY+3+
         l5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkczpQhkMNw+pvj1wj38P7zIUjMcDhSyVq8FFBcQxm+hDpRmQ3Hj9fFwQSYN+8wmqzuio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUi1iyDi3zux9rvxd4UKScATO4evRHpmyl3GesmvTJW0jpxgp9
	QoIU7BzEpT2fxwudCRjdekAqg0yc9ohko9UZD1/AZfk6Rdwkv5JsaUgjBpazCYeYrIHe6pkbdeT
	hwpC8ZzijzQ==
X-Google-Smtp-Source: AGHT+IFu8V6TtyELchwUcAY78ealGTcerTErw/SpJ+KzGdeEI071RTZnVasMx+0nurw1gfBfBMnNb+sKJBsp
X-Received: from pjbsv16.prod.google.com ([2002:a17:90b:5390:b0:325:4747:a99b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40d:b0:248:79d4:93bb
 with SMTP id d9443c01a7336-24879d49735mr109408325ad.31.1756398763077; Thu, 28
 Aug 2025 09:32:43 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:11 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-2-irogers@google.com>
Subject: [PATCH v2 01/15] perf parse-events: Fix legacy cache events if event
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
2.51.0.268.g9569e192d0-goog


