Return-Path: <bpf+bounces-26902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DC18A639A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81309280A6E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE242065;
	Tue, 16 Apr 2024 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6d98tz5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38984FBE
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248175; cv=none; b=JzNz83lvK+jT3prk9bvkuTfYudo2E0UsoaeXhB0SoYqlxpyxjsApoQygOt7pqA2GZMTlwcEeYkij5I6wodbxPnaSs6OIzU/OLvSZE/TyXyrDn5i+YepvP8ZXF+FH1POgg5bOV8GmkxJqfMdcyjOeTWGLb4vik+Fd4LF2lQI1WEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248175; c=relaxed/simple;
	bh=XX1cj9K5No2BuXWbuQ0xkOkv7ge+rMh/BIMFSe0VdkM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Pfa7he7FyAX1kHnNfIRQjnnzOJuBpwiVxFB2qkwvU2I59ukWGrt/FGr9O+hibJlg3f15v8gEYbg62wfW6bVet6gGFFT5RKyfZhLWz38mAYQ/hcyHGF//mzItF0Y80p8It7BKh82nglvAMaUH5NGKUbNXTBex2p8xFUHwy0y7/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6d98tz5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6180514a5ffso43663697b3.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248172; x=1713852972; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hPbZ7lnhh9QoC+3t1lsGMaRdpOWz8T0ZMfEFKF068g=;
        b=z6d98tz5J8ufr6y8Qe77yJlhTbm7A6YzhrZwxiLFzMNU1lKv/9UyY3eHg7RmZMyXu0
         jBDml5xVko5Svu6fg9UWWuJaT/MqagRNtwJ7PfpGEgm1dCPrOWHG/jRBufDzHEQlxdky
         B/oTXWtTrWfukS7aFs7ENWvxV9ELlpGMQfaBLcdQANlAyfvsLshvznU73I9sL2k96aE6
         RYVw2ZNdPzFK3mO4A6Tg3srLbv8RWetCVb9+8y4iPNpYwZjlhwOqu4q5uPINvBTtFMUz
         29ZAl40sNY5uL3ndHJCP1ljezT8F97kRKd51HyfREW0blkfbtrWoPYWhjdKEI/d5IwEU
         Rgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248172; x=1713852972;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hPbZ7lnhh9QoC+3t1lsGMaRdpOWz8T0ZMfEFKF068g=;
        b=qKMmuSFPyUb4xdraUEHWBwpbj0p4ehw90UxbTtyQWFB6oNGVgG9oisbeen/aZck8k+
         5rpzDGtNyV/kkeHtBZuuyoIKN7bwrotWtZfHvU8EdifVx0LsQoXYkYs1l7v8vAaUT94R
         aUiVV2QEjBZ1kN6qu7edKhyUAgb+9mMeOVW64vTzmv7yN6Cgz9XKYy4rULxvwX8y01EN
         obeeym7xEGn9gBkH6jNBMOrBzn3aePr7bRsJlEh1IVxTi8dOWRmk4Uk3jV/a6PjIVQFP
         x52u0M4Lrzu7UD5G9oEN2bgHYocnnTIvZ6IcMtRWb0kT8BGGZo4WsnkJjZ8Fz3CGSWYQ
         cckA==
X-Forwarded-Encrypted: i=1; AJvYcCXj8c2JoWF6JiyodzrepGTHT1zY41KGJRsevcMGICwuMvvB0fHl1R2Ae3AQbRHfzQc9UrKPaJVMz1Q2pkOOCalcXQVq
X-Gm-Message-State: AOJu0YzgHK3D2Fi+ZCBzHBEDd7wUzpdP0M/H1p7jd0NFNhblElSv48KD
	Sck2QjrJD7Fb+Ry4ABW6+JbYbAuHuOmjGwkduLMc+Yme6HoQE4dtkVI19K0me5RPqVHlbuWASBs
	OODhHIQ==
X-Google-Smtp-Source: AGHT+IH09dNa2Ep6hGWotz5Z/1B2yBTk2hy320YLi4pZ6NH6aEgIxJHZyqUteQDBUak/iqd6skeTLPOdRDRw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a81:8309:0:b0:618:308f:e418 with SMTP id
 t9-20020a818309000000b00618308fe418mr489314ywf.4.1713248172501; Mon, 15 Apr
 2024 23:16:12 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:28 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 12/16] perf parse-events: Inline parse_events_evlist_error
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

Inline parse_events_evlist_error that is only used in
parse_events_error. Modify parse_events_error to not report a parser
error unless errors haven't already been reported. Make it clearer
that the latter case only happens for unrecognized input.

Before:
```
$ perf stat -e 'cycles/period=99999999999999999999/' true
event syntax error: 'cycles/period=99999999999999999999/'
                                  \___ parser error

event syntax error: '..les/period=99999999999999999999/'
                                  \___ Bad base 10 number "99999999999999999999"
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
$ perf stat -e 'cycles:xyz' true
event syntax error: 'cycles:xyz'
                           \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

After:
```
$ perf stat -e 'cycles/period=99999999999999999999/xyz' true
event syntax error: '..les/period=99999999999999999999/xyz'
                                  \___ Bad base 10 number "99999999999999999999"
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
$ perf stat -e 'cycles:xyz' true
event syntax error: 'cycles:xyz'
                           \___ Unrecognized input
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c |  9 ---------
 tools/perf/util/parse-events.h |  2 --
 tools/perf/util/parse-events.y | 10 ++++++++--
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7eba714f0d73..ebada37ef98a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2760,15 +2760,6 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 	return 0;
 }
 
-void parse_events_evlist_error(struct parse_events_state *parse_state,
-			       int idx, const char *str)
-{
-	if (!parse_state->error)
-		return;
-
-	parse_events_error__handle(parse_state->error, idx, strdup(str), NULL);
-}
-
 static void config_terms_list(char *buf, size_t buf_sz)
 {
 	int i;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e8f2aebea10f..290ae6c72ec5 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -226,8 +226,6 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 					void *loc_);
 
 void parse_events__set_leader(char *name, struct list_head *list);
-void parse_events_evlist_error(struct parse_events_state *parse_state,
-			       int idx, const char *str);
 
 struct event_symbol {
 	const char	*symbol;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 51490f0f8c50..2c4817e126c1 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -790,9 +790,15 @@ sep_slash_slash_dc: '/' '/' | ':' |
 
 %%
 
-void parse_events_error(YYLTYPE *loc, void *parse_state,
+void parse_events_error(YYLTYPE *loc, void *_parse_state,
 			void *scanner __maybe_unused,
 			char const *msg __maybe_unused)
 {
-	parse_events_evlist_error(parse_state, loc->last_column, "parser error");
+	struct parse_events_state *parse_state = _parse_state;
+
+	if (!parse_state->error || !list_empty(&parse_state->error->list))
+		return;
+
+	parse_events_error__handle(parse_state->error, loc->last_column,
+				   strdup("Unrecognized input"), NULL);
 }
-- 
2.44.0.683.g7961c838ac-goog


