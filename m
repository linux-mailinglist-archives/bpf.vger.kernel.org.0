Return-Path: <bpf+bounces-26904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E5B8A639E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4CDB23153
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D561598E0;
	Tue, 16 Apr 2024 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2JEn8eOz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9D158861
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248179; cv=none; b=ENYZUluUZkFWLs5Cof3UzFMkITLbbeDyrH3kXeWhKsK2nR55cP/fyj0Xy2EI7d9LKW2+bdB1MdQLVYew3A+jfIKau8mprtuF/GfKGLMWwZ6ER1Nf/O3LslrxYbrUL6Y+fBtclqNcBRdPnmPOb98bjLDML6eFOlBAk4cX8pjmHZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248179; c=relaxed/simple;
	bh=RJLEGacEoWTcJGv5R0SFmVMGUwKOfcVwsf41gQZkJ4U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oFyiRAgaf6obNH4uiBjnck//mB8k1g4libV1K9CdeqNGRlDYw+4YoOot3KxPg5cDPANmheexGr3o1OVdSsl4RA7WAoK/OQQ3XjNEkLCeDL9cJ5zyr4hgdmqBcT0B/lV9SLaW01nnzpMzNcOKydRbop0RH0QGLIQX3CufqT0edd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2JEn8eOz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso7990816276.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248177; x=1713852977; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CS464tDCakpyTmrmcLFcR8YYU9aH6y31Ipzi53/1x7k=;
        b=2JEn8eOzqJsheImB37OB5RjMrLuxx1MmAAVe1ESawyN7MwgjXfNak80eiQDclyluRf
         B9dQuSQBB18S5eMNDtgwwGxa8FsMscw4o21oH9jDQdezNqeWRvj+zAFqRbx/pvQSycQj
         RDkMHIOKKF90NZlfqkNay9oVQvH/bSmIF68LV+wNjFfa21vtFiEvbBvljMJaO6MRFx69
         bJqXXm/cf2yAdsIGut2gEjd3//GVZ2tbqhshsIyHm5cL5qBSwBzWETqFstGGvfXCDBcZ
         VxcQSIWHvgc2HwYRXfEj/HDRhfb9xoCBmMQ/FzgreaCtZVzf1esFO1ayK2Q2cB5u/Bgq
         2xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248177; x=1713852977;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS464tDCakpyTmrmcLFcR8YYU9aH6y31Ipzi53/1x7k=;
        b=ibDNntcNUR5LB6N6YuKpbxVMYcjmwMd0Z4RGEr98FFb2mEDydIm+sws/BoHqteXwq1
         URa4k9VOWtpgssnCiWaBNTqh7W5xKOyWAPYdA/6ga7cYn69gYlChhULDCEfhwwtxY6Bd
         EnqGn377oI53/EPBAN49/vd469vPLM4JuKn673POr05IJLXpPyP00UFD56DZW9eOrwSy
         qmC8pSOCfpSr2f15Nx9HsG7FFGLrwSfBlMurI5d4kyTSNZuVi+hdMETT9/ATLf5rj8lP
         ERcM86hRt1qkfzilsPPj9smaHMz5nYVfdAYhJmsgWyUix3wfoq4oJIjJLdA5ZVVmVnt5
         zqtw==
X-Forwarded-Encrypted: i=1; AJvYcCUY6MkgnGzT4wrxx3pgBZXc00gMDu4QjBPAynEmLqqEnZz8eCIhIa1V716Cli5JiTQnLuyDXjsoAlYjfkD88S+xaGyy
X-Gm-Message-State: AOJu0YwemDuziYldaQngeeOhcOexUYm/bB1Kelc5eA+LD8oPwLB3AMFD
	g3XIgct2RIQKoCllY4VVYiBUNHOvXxjHdroyGCpxHaesLyPT8Q4h1OPCrbqD/ZinPbAadJZIj42
	s+5xnpA==
X-Google-Smtp-Source: AGHT+IHO0Fo9+D3NBOjv38HGGbmFqRswvl8m/oJgT2uKaZFhVmwhvI9Qz+b/36nYjScIaD300oJtaekLWfEs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:100d:b0:dbd:ee44:8908 with SMTP
 id w13-20020a056902100d00b00dbdee448908mr615874ybt.0.1713248177044; Mon, 15
 Apr 2024 23:16:17 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:30 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 14/16] perf parse-event: Constify event_symbol arrays
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

Moves 352 bytes from .data to .data.rel.ro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 4 ++--
 tools/perf/util/parse-events.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3ab533d0e653..8d3d692d219d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -39,7 +39,7 @@ static int get_config_terms(const struct parse_events_terms *head_config,
 static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 
-struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
+const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
 		.symbol = "cpu-cycles",
 		.alias  = "cycles",
@@ -82,7 +82,7 @@ struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	},
 };
 
-struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
+const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	[PERF_COUNT_SW_CPU_CLOCK] = {
 		.symbol = "cpu-clock",
 		.alias  = "",
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index f104faef1a78..0bb5f0c80a5e 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -250,8 +250,8 @@ struct event_symbol {
 	const char	*symbol;
 	const char	*alias;
 };
-extern struct event_symbol event_symbols_hw[];
-extern struct event_symbol event_symbols_sw[];
+extern const struct event_symbol event_symbols_hw[];
+extern const struct event_symbol event_symbols_sw[];
 
 char *parse_events_formats_error_string(char *additional_terms);
 
-- 
2.44.0.683.g7961c838ac-goog


