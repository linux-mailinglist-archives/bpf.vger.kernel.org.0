Return-Path: <bpf+bounces-67057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C3B3C856
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 07:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AD81C805D1
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7AC2356D9;
	Sat, 30 Aug 2025 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhBQFXuv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3F1E1E1E
	for <bpf@vger.kernel.org>; Sat, 30 Aug 2025 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532156; cv=none; b=aaJvLOUHiNbaUCZdc49Mknqu04+uwRJ171L9u9luNg5fYvVRBGD8vG+ytqF1PD7XKCS6usrSLCOkEHS3BTcWIYKzhWebGmrkxYdJe0TnvYWOjFroEnM2BYm7LIk+gjKuDCQuXPqE+6u3hReSvrRFGWuT0kidcIPviAOiVrOadjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532156; c=relaxed/simple;
	bh=QmYI0zj/X4Kwrmbx/4/heNHuxCp9kC0znQJ9RD/CgSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ejmokVNLqOOJ01LikITkycdizNQkilyjk6LzvKNskPnd3ftUuEd4yvnqtXdduDXw+71XVnTN8PaKM5bh/cyy8AcefJG2xT7VwGLpwxkTAv8e59EOARlnQWNBhChYxLQ/jeJvBzO+bZmh3cCIEjk+lSZCgnSNvPppP0dc6wt642E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhBQFXuv; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-30cceb0a741so2891690fac.2
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532154; x=1757136954; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5nOW4iK3c1eBL10WZVuLjDvECTNyCoJ5GM8pDiglm8=;
        b=PhBQFXuvxA3KAHag+m2TwTpGX79feG7rVRS+R+DD8+aMClmE9IC58XfoKbsTo8Tgw1
         r6uiaDAFCf75P7yOwrHs3Khv9yyHnm70n7Np52MOZbTosLy/dKpyemrypZmL15hAQNRX
         bHfXo70f9aiIbMM1jGWqqlCE2gyCKBT7cFXtNUM3jPfcaokld/2L71JXRN5bLX+AQJSq
         Xjn0hmUIlZjLSdoj26E6QeJvkA5om2frsvQauGL7ASG3A7ZYhVfI+eKna/F0eB0PMCZF
         SBA+zoOE0GOZReUFpeqXyXYSfT+eRUUuaU+V2yGZ4R58ruT9jT7J2VWdbB298MUyPNDG
         1NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532154; x=1757136954;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5nOW4iK3c1eBL10WZVuLjDvECTNyCoJ5GM8pDiglm8=;
        b=O+b/pq/xZgOTwOoHlFWmIbeNG1ydEIQ38N8hffIZ89TGj+qFchSJ4DbmJ2Kh2WlIDy
         lz8tQpjvX3Dbf23T8R93x80DNaJTE7korV64tPaYGfyD2HbaRCngjZfbCtqXhnVlsFbF
         SpNhZ7ro08o41MSal9O0+y0H8z9YssG4nssI4LIa4OzGo28bUJHECgbRR0KeklBYNQc4
         Fq6Vd8d0U0Ujmo6TSIImcjXlT+/7k+jCNbkQJoY7Gw9lpr3mdw9QnfqlLZfNf+4xscJa
         vc46I9x1/Xs8V6dS1o7rHXEO0ZCozaXjtJwZ2Gdf3bhEi+LmbirV50CpeUfjryVSCOoA
         hBKg==
X-Forwarded-Encrypted: i=1; AJvYcCVeczf/v1XY/fRtGOt8JZehDve9C5wOqtrtxs/uXtPp4NKZvtOIrKe9yLVyb6Zvkivue9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCKuAyLnKycftpVgPK96LznA/1xbx4ZvsSNyZdAs9pzLhyeGQW
	ZyQY2JEoZP/PNNqR0yBCzs5p31sqShF3CXEkDHw7TYBk6gVZUG6dRfuKsvxHrr/oPUg/wP/QEL0
	5zlWOHOWYEA==
X-Google-Smtp-Source: AGHT+IEc1GIA49XbBalZevG878g4TPyrLDAk/JyZXXK/zHcAZRkDvhFlv5+yj3+9nhHnmcLmNFb4G7tNK70h
X-Received: from oabhi24.prod.google.com ([2002:a05:6870:c998:b0:315:aed6:7f83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:171a:b0:315:b768:bd1d
 with SMTP id 586e51a60fabf-3196307eeb4mr441687fac.6.1756532154143; Fri, 29
 Aug 2025 22:35:54 -0700 (PDT)
Date: Fri, 29 Aug 2025 22:35:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053549.1966520-1-irogers@google.com>
Subject: [PATCH v1] perf bpf-filter: Fix opts declaration on older libbpfs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Hao Ge <gehao@kylinos.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Building perf with LIBBPF_DYNAMIC (ie not the default static linking
of libbpf with perf) is breaking as the libbpf isn't version 1.7 or
newer, where dont_enable is added to bpf_perf_event_opts. To avoid
this breakage add a compile time version check and don't declare the
variable when not present.

Fixes: 5e2ac8e8571d ("perf bpf-filter: Enable events manually")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a0b11f35395f..92308c38fbb5 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -443,6 +443,10 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	return -1;
 }
 
+#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)			\
+	(LIBBPF_MAJOR_VERSION > (major) ||				\
+	 (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
+
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
@@ -451,8 +455,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
 			    .dont_enable = true);
+#else
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+#endif
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
-- 
2.51.0.318.gd7df087d1a-goog


