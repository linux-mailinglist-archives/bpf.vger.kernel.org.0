Return-Path: <bpf+bounces-70409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09DBBCC70
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 23:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543483B97A3
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C32C21D4;
	Sun,  5 Oct 2025 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNUpK6jh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A122C15B0
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699359; cv=none; b=CfmC/5HLqmynCpvzjqh+BPvQIih6JxkQYOqu+HdXs+29KkszhtMmLFW7EM0Oz8lQcmBUER1DPDayYwTwlxlZ3JB7NDCDklnOU2tjnh0kTatrjrwWvFHqcqMEu5r2zjpPv+GYo3azYkttiFybrMlxVVhsmYZ1nR6rsJtrj7WouP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699359; c=relaxed/simple;
	bh=d45wEUY1c4jrn84/iwX20DQE8nKTJ3WT+ZgvlVq/fR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EkxApCci6uxguRluE8LYWLgusq9WKK1PrOn4ie5TO0plQCxmgERf4+B7Q44MqLxJxB2IGwRRVY+ckioCfem1wpeKWT/T/XN+ZYvYMQoeeRaO4QvgcOtBzfeJIWaVIZOtCwIVA8ADvnYvF5SAf9TdC6ID3ZBE58PdTwbcYzwXye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNUpK6jh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso1735000a12.2
        for <bpf@vger.kernel.org>; Sun, 05 Oct 2025 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699358; x=1760304158; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UwuX+qcsVkIci0z0OtUlxAA0Fd588bD/7/Leb924no=;
        b=iNUpK6jhPiS5f/hKDyyWnevN+OHiX3QhhcYyX+IlJdkzeQ66LZzEt6M9X0NYe0WshC
         1gS6cd6/5KuHzgs0hW3p7qCSZvV8krOdyGJ0QVlYzJaaNMkEepNQOdw2AdCpALrGc//I
         RYKINoeHj7LsI4WF8RPr8WcpSG5q/nUC3zzFGUGQp/FCM6T4z0ob9ZjrkX1p6yPKzceh
         4Y3/NBeioidySuI6sX5jNXJwgCg/XYfmWm9IU8twlYnyHwSIYSJ3QDahNyOnoBfZy4u6
         f+GR8GTQvvd0ptxbF6t8nxFI7lxwXne2dloWt28sXkwOK4vyHZu7SgHpDKNFl8RPKu7M
         N1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699358; x=1760304158;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UwuX+qcsVkIci0z0OtUlxAA0Fd588bD/7/Leb924no=;
        b=YlPaYKhLkxf4LLJ//U32teyz9s6KrqIyZEhygFxsz81Y4W8owylitYkRHhhTpfdu2T
         wnV+djJJ3eiVorpjnfmTJ41ukQpnVcGRosrFb/BhAdtosPgfJqqWJxQq/U6u17yFFsti
         jKaa/wHZ6kIaE6/1vy7HOdVVsp6fpW4QNaqFJZ4wIZSHEEpfCqIIku0MFoZ1BQAdXAwH
         0ParGgli0KGJofu+Yt79Q+qlrz0qWS5Z5Yo97joYDiKdx9UZkk5umnerd4pBlRN9h5v/
         HmbkrPyj2MtlbhQQNbMK028jf4+sJ8TciFMhPtKT/uAzMYj46/sTii0qfJynl3VemBEm
         WjUg==
X-Forwarded-Encrypted: i=1; AJvYcCXLRXHzyM7QIAG/qBrOhh16WMlR5D7SFHK0p6i5a7JfZzYyGhpEg2V9WW8HaNcXu2DctpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdf5OCVIjs0SHXjWgHqRtfl7/9oBp/P3ldc1fCAiu1RSEoZha
	kT/499rdYtOxcMS4IQYzVqebq/Otji0gypgKJ7vatNH5T1xZ+Vva7/5eKgmq1X37BQmIXeXOsIj
	ezZsDFOKPdQ==
X-Google-Smtp-Source: AGHT+IGvT5pslbMCXLmkI8dz33jGeGYCBPk++vUXwX3QDvVBJVh6+9SImEKQrDsiOMs+ve1hP/rqlLC1JAam
X-Received: from pgac17.prod.google.com ([2002:a05:6a02:2951:b0:b58:7d6e:e9c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d527:b0:32b:70a1:7c84
 with SMTP id adf61e73a8af0-32b70a17d56mr10844469637.28.1759699357519; Sun, 05
 Oct 2025 14:22:37 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:09 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-9-irogers@google.com>
Subject: [PATCH v7 08/11] perf disasm: Remove unused evsel from annotate_args
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
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
2.51.0.618.g983fd99d29-goog


