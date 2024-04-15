Return-Path: <bpf+bounces-26747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A345D8A483C
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B3D280F67
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43F381B9;
	Mon, 15 Apr 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDzBHwiA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B9374E9
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163009; cv=none; b=DmyijyKRi1gZqnE+uT1IhEs8XZ8sC3b0Ms+d6JorSxQs/T1kVdlfUamBTjoqkxUKwB/omhGPyoKU8advBy5OPRJfg23tmSLOnFqSEM4x+mYpiVq4ylxUNX/Pyq0m/f0EPETK0cqfrcyUhyZionCrVwUmEMMwb2V9C93GICq2BKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163009; c=relaxed/simple;
	bh=yRXdGKWgYrAy4QEN4utAId08JcclyUD6POZY54MLD3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OM0oPyckLGbVEqt9gkSDPaHJsAM7HIRT1cnX8P9DspH4XE+rJlyaGGdCy/GE83kamvKiof2EbWRxkuro4UPZz5OzoYKNxgS27pZGVMH/GkTtOPx0S2+YcjKqGxLAW79sD3Y0TRjbf+4nFwZBJTMbboY/hK5UIrbpWSmnwLYiBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDzBHwiA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ad90eba5cso2690767b3.2
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163007; x=1713767807; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6u9K3gcjLrMHLCFAhYLG4bnVQmGcLUFFxbpFKDU6RA=;
        b=jDzBHwiAOkRQskyS5zSTKTDjRWNAisWGYxkQYiJHclJSKc6s5nkq5mcNDw5yP+/sEB
         BFWqiKD9XbxK8gyJCu1tFIf2sZnqE7Es9jS5YcsEe2qkgfHKFQoadiV1PQ5SA0q6bG9y
         r5rusuuE+q77qkwkTm5Z5I9xn4WYjvUPmSfw94d/lsAa+fUaMNMPYWOV+vfhl5OWsIsx
         JzdHvJQl90399wtcKZhgQAgk2lEkXwjZ9UpGJLac+AAqkMtu7j0Nr+I4xz3TCiPHPs3P
         HRTA9Gveyg1N5b+eyYT7rR2SPQ/jXtaxBuMaAUx2BfyL5ANmiVX7J921CG7Xf8RXF939
         zasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163007; x=1713767807;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6u9K3gcjLrMHLCFAhYLG4bnVQmGcLUFFxbpFKDU6RA=;
        b=kpGiJJ7N++lPbGflcQjW4mPb/XAhnQOh4OekygSCtmcGA8yoid4EBK5Vvc5iluuis1
         Wg5kW6NU+g78F75gIyAS6aKMnGBIUnMd3koGVl9fmXE2PrMVZv6fj3kMhQ5gxLbYRmCD
         D2Xo/nj27e3sIO/Sc/xQjwQiqIDEP+0k+5awrSGw9W/Eb9bz8uBONpoMWGIzXZbqsJJt
         oVE15sVjNdevEcgL6K+dFqeq+c40dfpeTLtpKnr4dSurgxnc9LJdwBh6mnDM/QRQv2GQ
         zdbrYycBNCi/KLU4S+bSwswsIqVQduv69gVBIEA69veIlPh17RoU34gq3MqfQGz5FNNi
         OCug==
X-Forwarded-Encrypted: i=1; AJvYcCV3W0qTkj0IUf6m9Pq0lNq/uACgdsbCOm0pXj2zHjc7taTY0m8PfHv+TgSK16ZCKXYCJggASS5xopAEmOq5qTuF7rfM
X-Gm-Message-State: AOJu0YzJ+uMQXqdvcp+VS5smyP3xQd3BcvVCe4tnjRcjtwL+0ff0SkEx
	MQ0Xy81E/jVJxysSSxLKJodwj3Zz64xiXC4cR7+PMo/uOo5v09NEYNetE0vI4U34OB5njUFS+Yd
	RKphrXg==
X-Google-Smtp-Source: AGHT+IG8RJ4TxbVqnYh/ZFFdHmJfxbpZPCmfmXJfgiLHBndDiPsUAFRcqUnZUMNnHTZLEpylkDO/67CKESCA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:690c:64c7:b0:61a:c98c:c2a3 with SMTP
 id ht7-20020a05690c64c700b0061ac98cc2a3mr623165ywb.10.1713163007703; Sun, 14
 Apr 2024 23:36:47 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:24 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 7/9] perf parse-events: Handle PE_TERM_HW in name_or_raw
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

Avoid duplicate logic for name_or_raw and PE_TERM_HW by having a rule
to turn PE_TERM_HW into a name_or_raw.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 14175eee9489..bb9bee5c8a2b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -605,6 +605,11 @@ event_term
 }
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
+|
+PE_TERM_HW
+{
+	$$ = $1.str;
+}
 
 event_term:
 PE_RAW
@@ -646,20 +651,6 @@ name_or_raw '=' PE_VALUE
 	$$ = term;
 }
 |
-name_or_raw '=' PE_TERM_HW
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					 $1, $3.str, &@1, &@3);
-
-	if (err) {
-		free($1);
-		free($3.str);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_LEGACY_CACHE
 {
 	struct parse_events_term *term;
@@ -712,18 +703,6 @@ PE_TERM '=' name_or_raw
 	$$ = term;
 }
 |
-PE_TERM '=' PE_TERM_HW
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, $1, /*config=*/NULL, $3.str, &@1, &@3);
-
-	if (err) {
-		free($3.str);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_TERM '=' PE_TERM
 {
 	struct parse_events_term *term;
-- 
2.44.0.683.g7961c838ac-goog


