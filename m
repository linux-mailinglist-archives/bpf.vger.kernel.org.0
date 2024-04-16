Return-Path: <bpf+bounces-26895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395378A638C
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E444C1F21D67
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB13D57E;
	Tue, 16 Apr 2024 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4zthJnQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7A6CDCE
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248159; cv=none; b=u2P6vhfGsJomt/YHKOGG6pWhUF+Z2MPXHLORIHVSwlPBWI9zWTaekQRoXjM9ojqBXyeWuap/jmXKbx+DLziPtaccltCSZdZ+lT4Ssj4yQTWlBlu0wO3rU158H4IcFrFVXtKnI/jrjRH8Nhrf4jeY4bvoqYwKn69mRPj0rm5BTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248159; c=relaxed/simple;
	bh=jUPnR8Eh1nwHTyI5wvU5SHFzAhN1eHw5S1/Bwquryzg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rbsDBya2nOEkX8EGc96EZuPB9y2BYewgttXtJI1SEre3pbLBp6bVNwziZ1n1TNFHG8k6J/uBOzrxGDwfE2STzWr8JKrV4R/ZMbq5Vg2OxON8Hxcxmfj1I1yqukuptQq/WvTkESDnfh700NP55WvJa/MC8/J507F9t/Sy3IS4GOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4zthJnQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b96c8ca2so67233507b3.2
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248156; x=1713852956; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=T4zthJnQjIgsQSTjSiNfDEarAik0KXjq92p6b3EBIeUPznZRCGJ4Ar/gsCIUiWkotW
         l6t5+Zji2uVxVHC7mPk/vGoTeOHyf2C0WSmpPNhDsudRIp5QrHfIDqmdqcpCPw14lMqs
         fpGRN4h6vnZWfH0OA56y9WRVmS21SML5rQDx/gXlzLAsoFbwoQk8EixnBRw5d7gYAzSA
         2bCM48y7m/rBQWwYisR65iZYGpANvn6zJp4HAm8WNrxTmPeWxmqJT7ztSLIKvz5nlEkJ
         GLcTiW7Wswmdn7TXiRDFaW/89eOzdOyT9qpb9AobL/xZP+8cVCzay3ZwGrz0oDkY+BF/
         RZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248156; x=1713852956;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=EtEfNhM1TgD+AcCIrF6ygXEVc8wmeNJB+qOB4t1lghRFTOpxqXF/AqmuDjfGBqIoia
         rj/jNa3levKGHz9RQz6qWnCnvY4+1nNk6+KcRUm+bokvLHxRGwwFlkC5nVRRGlsIJP4Z
         NDmWTsFIINnoo7hKh++REJIsv+4jmLjVtv9l3TPlQPgNtwIPz0oj5AM5tB+GMG8nmnVS
         89ihJ4f/anXKp07YLQsy8ty6ijsyXiqGQC0LW1rzBcqXi8HAee2y3wuVWDSea9cWGIzk
         iB0iKefMmo9TT0kAF7Rtkuk7U2CazRm+kTPRJkpyMPJ1dQ0ix8Dr8iA44NTpt3chwtZJ
         r+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUXhX8Dns/wOwTtrclI7bBOyeWjpZEh8faVy1nKuzUK/1WOYVJBvuDNx+2V4+qt9oI0ubwKDZMF7+FiKC4mOZoOk5uo
X-Gm-Message-State: AOJu0YxcKoyjzs6VuXh8gGQZ7M31GtMk2OZX4En6dtvz3g1ZhHjJKFVT
	D2dJlCv/fRXymSGW4MNRhstaaY7lWERZ+n3jN7vZa7l/6KVjhe2s4KNZ3leZ+tZ4gszWAhvEOmZ
	/SqoiDA==
X-Google-Smtp-Source: AGHT+IFvz2/ElMb8sqisE4iRWPUFBqPFEJev0kX5N83qt2rasL8K27n6w9ssQTNUocmaX8KnE4uhTcFVZFa+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1509:b0:dc2:398d:a671 with SMTP
 id q9-20020a056902150900b00dc2398da671mr3887166ybu.10.1713248155750; Mon, 15
 Apr 2024 23:15:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:21 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 05/16] perf tests parse-events: Use branches rather than cache-references
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

Switch from cache-references to branches in test as Intel has a sysfs
event for cache-references and changing the priority for sysfs over
legacy causes the test to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0b70451451b3..993e482f094c 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -942,8 +942,8 @@ static int test__group2(struct evlist *evlist)
 			continue;
 		}
 		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES)) {
-			/* cache-references + :u modifier */
+		    test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS)) {
+			/* branches + :u modifier */
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -2032,7 +2032,7 @@ static const struct evlist_test test__events[] = {
 		/* 8 */
 	},
 	{
-		.name  = "{faults:k,cache-references}:u,cycles:k",
+		.name  = "{faults:k,branches}:u,cycles:k",
 		.check = test__group2,
 		/* 9 */
 	},
-- 
2.44.0.683.g7961c838ac-goog


