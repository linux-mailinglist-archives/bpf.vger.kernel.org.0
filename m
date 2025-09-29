Return-Path: <bpf+bounces-69985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83DBAA6E6
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11E21923722
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7922BDC33;
	Mon, 29 Sep 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9yQeoMo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E402517A5
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172966; cv=none; b=Mcf/zfpuin+0KvhWA93ANPZUZB6jyHidAlQmLGLZSLv+N2FHbtRJ1tIj/kj7d1FG6Q9cekSVGtFIss4cC/8mv4Kf3mvCxdLrkztlWYTBdSglc3QfpzzEAfHO5/RgRnlxUj5yv5XBJ1jzFXoDqZ4veIr9aenvQCdkm92qPFKjhrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172966; c=relaxed/simple;
	bh=AdUfJ3+HbRhbK7PtlXvfEfALYxdhT7u77r7aSN4uwZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J13YBJZriCfO96nhCUCDB084qud11lmmNyl+JU6ymlFfEgnYATHjZNsiSE0JLd3QUfKTDJKR+qy8OCy6Onag3TZc+6Bixv1y42LUbukKW45euoglXSqi2ZOwne6MFvMEYCoeJt+APdECfN+WPW1wGR+4NAyNj2a8Oaoc5fBFx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9yQeoMo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-27eeb9730d9so40566685ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172964; x=1759777764; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4971M/0zABDO+i83fcQEQWVemuah1MT0Et0WsfrEZzk=;
        b=L9yQeoMoPkXg5d5lT2D7Ra4n++RDy2SE9MSuD1eTVbKyNZt8WSLkEloIFCzXNqO3cf
         wgo7N6WOlI3EbhXo5y3QghXVKhaL+Zvz8smMzTX6PYl9BbIVf1GEj4T9C4wjsBNEy4Q1
         KlOwLH5/fBorFi9cSI8qqlETXPIa4jpkZ8BNK0uEtWK6NZAVH6EQ+bKbkY9YGqEsyc6E
         BLs/sdBbGMY+DbRGhMRogroFvjoCF9NtRqAFJi8SLM2GPrX1fIc/hJ4vsLdpOiDW5Wft
         CCZEQXne39KFIdsPDNuxX8Nvhvcr9ivaFvj2gSVR3Mwpc54sE3l3Kzq5pqKdVIvy3Gzj
         r7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172964; x=1759777764;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4971M/0zABDO+i83fcQEQWVemuah1MT0Et0WsfrEZzk=;
        b=LInmBcjGfQccefOZwmbqY1h9fyFbge5dX/92y+SXdyyzrmBGlKRR91JrEARVNUdVKh
         uluP+dBCgdST4K+DDF6V02D2/Q/uPckB0vOuKLtmujaxxL1JBwQKrP/MmtCUdT2iR3vW
         exJSrEEgJv03d5SiK6vhPYXSNsgmWdddM/e3zB8ICql3aauAmTXQHP5gtbqZATzQrnSM
         DjkkXG2RqKyBcyJzmEeuLRbw2PbzAiTMIE+yyHodIkYvxq89BRtoDC1WQ04zIlKCqiHn
         6RT/MClIFXVwyyxupsu09NxdFzXV8zNUcHpOzTPefDeB+iE2Ym35OHEAVnK+Rrvw3EIz
         KKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiKv11DIzgfhOzBnaST+CdliL6hU9r/DqAi9F2fOjHgyLaBH7sKmxq0FRIKqd/YsRyOKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/olNUo6LY0WCwyV7ZbCezwhvhYK8bcruveeaphQSIqOK5vgG
	f5y9g3pFcGuAyFglXEQmN0TDwBYr3p9S1TGfGiCrVlpjdYkONnKmVJYRZSBD1Zr/UKen+JOankJ
	BmyzTrBxcxA==
X-Google-Smtp-Source: AGHT+IGSCDVx0cLNNfPAO34F5NCMZLpRD91/a9vLPfmnYqOXMggPFusn25YIXzpM5IEFpb7ikaAU0IUITXOR
X-Received: from pgar25.prod.google.com ([2002:a05:6a02:2e99:b0:b58:4e62:6f3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acf:b0:274:5030:2906
 with SMTP id d9443c01a7336-27ed4ab8df8mr196816435ad.46.1759172963586; Mon, 29
 Sep 2025 12:09:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:08:05 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-16-irogers@google.com>
Subject: [PATCH v6 15/15] perf disasm: Remove unused evsel from annotate_args
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set in symbol__annotate but never used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 -
 tools/perf/util/disasm.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c9b220d9f924..a2e34f149a07 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1015,7 +1015,6 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
-		.evsel		= evsel,
 		.options	= &annotate_opts,
 	};
 	struct arch *arch = NULL;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 09c86f540f7f..d2cb555e4a3b 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -98,7 +98,6 @@ struct ins_ops {
 struct annotate_args {
 	struct arch		  *arch;
 	struct map_symbol	  ms;
-	struct evsel		  *evsel;
 	struct annotation_options *options;
 	s64			  offset;
 	char			  *line;
-- 
2.51.0.570.gb178f27e6d-goog


