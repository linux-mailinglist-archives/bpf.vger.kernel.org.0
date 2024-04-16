Return-Path: <bpf+bounces-26893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E298A6384
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357BD1C20C34
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815C5B697;
	Tue, 16 Apr 2024 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNN4qflV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D853381
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248153; cv=none; b=NFTdGuzkij7IkLml7V1lPFsWB74LfbJiYrBdt2YTQjd7xaZhoYMyn8xWv+TXTeCa918m+lbUT8XqxhgLkcoBMafd703gEDGrdQmj3jS5ER3mXYaoxSvzVIytPke/lqvoGJPb691IX/Bd8aqBYGN4I36S64G6uN0+a+bMKNUHXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248153; c=relaxed/simple;
	bh=IERvH/Ao6HfWGEykCXtiWrApDF698nujkO4wwCpYmzw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H7IJBE5w1pkPtoYu+sGI9CCajGwzV93BHN6P4lXUU50top9NTRaBm9oDd+0n2B5KQpzVY8CkxctBu0efZ6j3dbWhwXsmyKhPi6pKK9smhqFHjZ8F4xlCSIp1QQSZ0mnnlOW/nJtCnCtGstc1cC+BLH4cUxSxNMZx2vbzmprdMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNN4qflV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-619151db81cso31527407b3.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248151; x=1713852951; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trVc8Z3cM9HfuUa79775aNx5De/ILl71mqLeEIudwkY=;
        b=XNN4qflVBY4y9wyZFiv0CpHJcPKMRC7AEpYwTL2cRaJQDuj6JK1i9EDrFqhyXSY4ih
         RsW/5rpPp/tXv4Ygt424I5TOBks3HxBrLTO+eHniPjok95LQPzu0YnWf46AjZ5vkgIc5
         Jh3+xbHXNq0lM9vloV2y94TIByFwtdip9eWaLX2IOAUVXSZDjGMpSAzO09EZwKtjLVj/
         2b7kZi+sEBjL1CpmQle52ix7WJr50iH7b0HX1qmFsO5olvaI2kklsycZX8AV7JHXt5MH
         VvaXSZrbkxAQG5PKyXMPiCDcesROb4qqpMhVL28wmMoMn/Hw8hOmtorLX9lPrcqGOXaU
         9E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248151; x=1713852951;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trVc8Z3cM9HfuUa79775aNx5De/ILl71mqLeEIudwkY=;
        b=ZOU3VgRSoY8f/bwXkRf52iuLgCmYiltvpRp1O6NfGmwnaLGBEwrmnyXDk4lEW7U9TC
         fhemfBSxF/0Pn/WDFf+YtQBoqgXtLEWEKB0j7AjJzhkB/PRWg9O7n2B975GZOhCbKz6o
         7Z0B7h9HpB2UBuRcKl5YS+lZ7uK4QIykyufXwWm4QrcncAawbidApLouja8vqHatiMs2
         B9j3FYx3HvrXoydFOrrMrBl3L9x3WtKBKdBOK4kSvbmi60Xj+ImdkW8ZqSBU5aT8A0Uy
         YsNlx7OWzUTBnbSQiC9S6GkVDzq61bKDE4YTc36w6npGQwfI6aDvzvAdUiFT7Wpc2u8G
         qYxg==
X-Forwarded-Encrypted: i=1; AJvYcCW2xkvzROfIjWH5ppffYYBn9go2V8pdAOrTJDCMd8agKDOUsw11f8FEwJPv2YyYec95dUWgV8xuRCJvG74ysZ/rPLFQ
X-Gm-Message-State: AOJu0YwixtBQhN95v6PBbTNbYgf1YOkdCXXo5B+lTsn9nUq5uYN/qfZU
	s1NAGKtawUDtG4TdYOY7Cv8CbvDRkZ9Hccc4PRnNPCapI1MbAWkmULC+sA19E61YCBwnYEcUOZW
	THeyMkA==
X-Google-Smtp-Source: AGHT+IHbe1DxlHRAKrzSKiVOtakxA6Q18A5QeFHX1nkM8ma5D0AnWniiwkUYIfGXxIcoemP4HQq1Zn/FTkGf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dbd:ee44:8908 with SMTP
 id w13-20020a056902100d00b00dbdee448908mr615704ybt.0.1713248151392; Mon, 15
 Apr 2024 23:15:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:19 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 03/16] perf parse-events: Avoid copying an empty list
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

In parse_events_add_pmu, delay copying the list of terms until it is
known the list contains terms.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2d5a275dd257..3b1f767039fa 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1398,29 +1398,21 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct parse_events_terms parsed_terms;
 	bool alias_rewrote_terms = false;
 
-	parse_events_terms__init(&parsed_terms);
-	if (const_parsed_terms) {
-		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
-
-		if (ret)
-			return ret;
-	}
-
 	if (verbose > 1) {
 		struct strbuf sb;
 
 		strbuf_init(&sb, /*hint=*/ 0);
-		if (pmu->selectable && list_empty(&parsed_terms.terms)) {
+		if (pmu->selectable && const_parsed_terms &&
+		    list_empty(&const_parsed_terms->terms)) {
 			strbuf_addf(&sb, "%s//", pmu->name);
 		} else {
 			strbuf_addf(&sb, "%s/", pmu->name);
-			parse_events_terms__to_strbuf(&parsed_terms, &sb);
+			parse_events_terms__to_strbuf(const_parsed_terms, &sb);
 			strbuf_addch(&sb, '/');
 		}
 		fprintf(stderr, "Attempt to add: %s\n", sb.buf);
 		strbuf_release(&sb);
 	}
-	fix_raw(&parsed_terms, pmu);
 
 	memset(&attr, 0, sizeof(attr));
 	if (pmu->perf_event_attr_init_default)
@@ -1428,7 +1420,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	attr.type = pmu->type;
 
-	if (list_empty(&parsed_terms.terms)) {
+	if (!const_parsed_terms || list_empty(&const_parsed_terms->terms)) {
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
 				    /*metric_id=*/NULL, pmu,
@@ -1437,6 +1429,15 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return evsel ? 0 : -ENOMEM;
 	}
 
+	parse_events_terms__init(&parsed_terms);
+	if (const_parsed_terms) {
+		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
+
+		if (ret)
+			return ret;
+	}
+	fix_raw(&parsed_terms, pmu);
+
 	/* Configure attr/terms with a known PMU, this will set hardcoded terms. */
 	if (config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
 		parse_events_terms__exit(&parsed_terms);
-- 
2.44.0.683.g7961c838ac-goog


