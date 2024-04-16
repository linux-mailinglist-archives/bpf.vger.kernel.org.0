Return-Path: <bpf+bounces-26901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC278A6397
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D2F281A34
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08484DED;
	Tue, 16 Apr 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4ufWgn0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560284E0D
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248172; cv=none; b=S0NVqutCG9EGw3FdHGwXeTMioS9BW5Hk0KJ/wOOR4rJkfV8ZY14HkaKbHtnaFqkzUSzKrpMsh90l0MNDoECwBvt9QPzLrSu8Wuh6k6CzttqXjzLyNRGkkCpl1+45nrGM9OnrhIbG1msk7JxWSjUPib5I+qG4UPmOlk+/txNdDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248172; c=relaxed/simple;
	bh=eftodLo96oKKWTTBK2VOKzkPV1r4wS9wxU2SLYPC8Eo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=e/Fpk2DIJyflxiPAUJCW+UMjzlJucswNrjlPvvNeoeS7aaW2cnVonDapQjI8mbcm3wUKvWdnrGnofK51c0tmH1ag7t4oK3uzmbVusZHkJo5lL6YjWOLdASunuJq5sSuv+MjWZSXII2PGvxQoJyLAgjmo15rN8w3rl3qxug6MQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4ufWgn0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so6490549276.1
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248170; x=1713852970; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boFz9eIMJ+Fb11V/P0+sRNFH04HSu2tXThEFb/mBZSs=;
        b=l4ufWgn0MhCDqXGTY4M+/K46oVdjcrnyp7udcxTfCbTxbiz6JHuVM3X7jnH/Ipp1zZ
         MFS+GbuMJEhjzv/CHSIORIittQBgSFk9EjM5RkevL6aR1VCnqwXL6IohwbLjGP9ryr16
         S+VNrHP2a1slYeT6FDyWGzQNF1lak1gCGhQYV6yntNRoNk1TpVDhmHg8Gx1lTekHuZjn
         fQE0PV+U8bNAisUThsyFCsE//dj0BrFu+f5MzxDdXwXIFnIsUeW+yKVf/Dcb7VkeY1U7
         6o60Id47PMn7A21AgM3Oevyu1oR1iS8VF31h48U8YfDGrojUOmcqYpY3NAQCOa/ymc7g
         DCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248170; x=1713852970;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boFz9eIMJ+Fb11V/P0+sRNFH04HSu2tXThEFb/mBZSs=;
        b=J8gkxA4cuHiHcuqQWo+rDQZeQeDb2vqs/5u9e7ZTPDTzAfvja6YAfBf2Zs6TB4ARbF
         XVksL9VKoXokZewNEsXXgWjVG9RiIMtIOklxmiWtYb0wOmzLgJ7tST/w4CpNLtP9uNyj
         UtsyShdKMBGYdNd38c49128bVrasLnMIwAi1ZwMLwemeEFeSdQNOHqumSQv/9C7VTZVG
         kfAcfOuiWn0PHdQhe8YB0v2G/QRUdDAn4iHR9CL4LV+DcFz1CaYNmCmAGax6fFnZcomu
         9j7k6z3zni/Ild417LjcpZJlyNRSQJu+eRNGQ8HWtfxrEwQQyc7CD2fG9DBsE4bc/YYP
         UFSw==
X-Forwarded-Encrypted: i=1; AJvYcCWFF4XCnsCjOJziJHwN3ka96y6o1cpT1Ou4x8RjmiYzqrE0diR/td0AUG8cgSxQNWnlFjfX7VloS+90tW+3V73iL2bD
X-Gm-Message-State: AOJu0YxF45wHUlLfBvRmaXxmqUuhdb9wSAEjYlOEiuyT1J2p1VqLasgj
	obWpnk9vYzMuShUPBBiHp1NwLE0Rh+H0MGjfngDtxbWRKiTk8rVLshtHe4YAuFEOoeu4ddSHCgR
	5hxgh3A==
X-Google-Smtp-Source: AGHT+IHd9B6qnuS0vDMu71FLmzqF2ZG7fcWnX6FbkHfRo5r1HZC5wXOQPvp4ubEYNvo/IQi3a4rVn7px521z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:c07:b0:dbe:a0c2:df25 with SMTP id
 fs7-20020a0569020c0700b00dbea0c2df25mr1501367ybb.8.1713248170374; Mon, 15 Apr
 2024 23:16:10 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:27 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 11/16] perf parse-events: Improve error message for bad numbers
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

Use the error handler from the parse_state to give a more informative
error message.

Before:
```
$ perf stat -e 'cycles/period=99999999999999999999/' true
event syntax error: 'cycles/period=99999999999999999999/'
                                  \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

After:
```
$ perf stat -e 'cycles/period=99999999999999999999/' true
event syntax error: 'cycles/period=99999999999999999999/'
                                  \___ parser error

event syntax error: '..les/period=99999999999999999999/'
                                  \___ Bad base 10 number "99999999999999999999"
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.l | 40 ++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 6fe37003ab7b..0cd68c9f0d4f 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -18,26 +18,34 @@
 
 char *parse_events_get_text(yyscan_t yyscanner);
 YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
+int parse_events_get_column(yyscan_t yyscanner);
+int parse_events_get_leng(yyscan_t yyscanner);
 
-static int __value(YYSTYPE *yylval, char *str, int base, int token)
+static int get_column(yyscan_t scanner)
 {
-	u64 num;
-
-	errno = 0;
-	num = strtoull(str, NULL, base);
-	if (errno)
-		return PE_ERROR;
-
-	yylval->num = num;
-	return token;
+	return parse_events_get_column(scanner) - parse_events_get_leng(scanner);
 }
 
-static int value(yyscan_t scanner, int base)
+static int value(struct parse_events_state *parse_state, yyscan_t scanner, int base)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 	char *text = parse_events_get_text(scanner);
+	u64 num;
 
-	return __value(yylval, text, base, PE_VALUE);
+	errno = 0;
+	num = strtoull(text, NULL, base);
+	if (errno) {
+		struct parse_events_error *error = parse_state->error;
+		char *help = NULL;
+
+		if (asprintf(&help, "Bad base %d number \"%s\"", base, text) > 0)
+			parse_events_error__handle(error, get_column(scanner), help , NULL);
+
+		return PE_ERROR;
+	}
+
+	yylval->num = num;
+	return PE_VALUE;
 }
 
 static int str(yyscan_t scanner, int token)
@@ -283,8 +291,8 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 	 */
 "/"/{digit}		{ return PE_BP_SLASH; }
 "/"/{non_digit}		{ BEGIN(config); return '/'; }
-{num_dec}		{ return value(yyscanner, 10); }
-{num_hex}		{ return value(yyscanner, 16); }
+{num_dec}		{ return value(_parse_state, yyscanner, 10); }
+{num_hex}		{ return value(_parse_state, yyscanner, 16); }
 	/*
 	 * We need to separate 'mem:' scanner part, in order to get specific
 	 * modifier bits parsed out. Otherwise we would need to handle PE_NAME
@@ -330,8 +338,8 @@ cgroup-switches					{ return sym(yyscanner, PERF_COUNT_SW_CGROUP_SWITCHES); }
 {lc_type}-{lc_op_result}-{lc_op_result}	{ return str(yyscanner, PE_LEGACY_CACHE); }
 mem:			{ BEGIN(mem); return PE_PREFIX_MEM; }
 r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
-{num_dec}		{ return value(yyscanner, 10); }
-{num_hex}		{ return value(yyscanner, 16); }
+{num_dec}		{ return value(_parse_state, yyscanner, 10); }
+{num_hex}		{ return value(_parse_state, yyscanner, 16); }
 
 {modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
 {name}			{ return str(yyscanner, PE_NAME); }
-- 
2.44.0.683.g7961c838ac-goog


