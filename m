Return-Path: <bpf+bounces-56204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A31A92DCE
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F1E7A43E0
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214892571CE;
	Thu, 17 Apr 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssB2vQJy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D9256C6D
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931316; cv=none; b=nXIsGz+4kQAjM2pz1Q2imfCQyVfGV/hboCL1pJ39iFH20adANRQ8iPx1oUFU1SPnhleXZXvjOAfeC2f3fa1+GoC7aJD2YSubuOF6JLBXSZGDGfK0kwRhWBbaySOi2w2bT95B0k/+4lnpEei/perbgPi2y2JAgdLeFp2PjdUAIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931316; c=relaxed/simple;
	bh=BMIYhQe06B1m/m1VG1ijiI+0phHw0fLo69Q/i9qHTls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EHQyA0y+dRyccXsvdFwWf6mM4T6YN4ZYMRuyGf5/2ADVVZD6RrBh6yYhMCi1I9s0+k+XdIzwfLGioCk7XS58hDxQR5mEXoO9dk3RY6gEbuv5eT14ZXKvJyJQnZs12NfQDffBfDI7eaq9VunNZNkLSRO2kCQC87g3cGvujkJ1EaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssB2vQJy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22c31b55ac6so20059265ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931314; x=1745536114; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWFtkFZGIqy5t/lwfSWZdekY1UZ0W7H50S3h5IILNr0=;
        b=ssB2vQJybKGPyWCD1t5Y+aDP5S7146o8l6tysGdfMLs9s0zRCjBh41+tNHGXTkc8JA
         sqXk0S8GLNpS6rQmKBflWXV3h4FGGxhoP/khDjHqKrS5UjBTxp7g2u0hVDQsiPLxlgnZ
         Ev6aMU/ZTo6eYyMIxB1dUaT+y2yb9y3hhPtTKBqjxv3yT2ZCIC/jwp/P1XrfP5p3sX++
         aHC3JxvUGxI1RUZm6oPvyqTouuc1y+8qInjnvmp2gRDrhWImgFniLyvLGR7+VoRGXwW5
         EtVUNk0ccSJXVSG00EjgcJojpcVNfHfFysqDVcDsYkZOCKj33sFvyGzyjyolJRqWyd8s
         D4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931314; x=1745536114;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWFtkFZGIqy5t/lwfSWZdekY1UZ0W7H50S3h5IILNr0=;
        b=ZBrxp//cA5IZKU4RMbp95eYpaXoz/mHH5WneypPf72GO+4BDkq29PlcRs7kutD4tzr
         k6WamsSCF25m/c81rR//nXXhSTMSfXc55P6uctqyPE0rQk8vb1j9S/rFVjNwscRMmxD3
         L0uRzJt80nVR7gsXi/MNJlxIolybbvl2jWCw4Z4nAHxec+LZwroy+hlF9B6dK0eLbOnD
         rlQKJGl7elOQ9XR9ztMn8J8N1FHOVEGSiGYlt8HoKbPCjEuEoFf6nreP2xMVVL5qqvVX
         //cz9I6VMDgdvOiTnkkJGzBbuMS4nqFBTfguqpe0XhFGqFB6OyfsnTeD/NfmYzvb1kLa
         HPSw==
X-Forwarded-Encrypted: i=1; AJvYcCU64QD6HbczCaxDvNzbKwGKat9cPmTOtorHl6C5KUMok466Wim8q8nMoQC4qeohk0hXP2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAF4VIAyLLtdB2OaLOmoB/we4zyiF/tVsnexN2EzNmzM0uYBt
	wlhN4Msi+rZaeF5Ls5sYXwFCIoXQkYJvt3V3My588xzdHQMMOxHsvqAr+SQOgQyl08Tyz1ocRPK
	r96CWsQ==
X-Google-Smtp-Source: AGHT+IEViYHLkFOWXw+5kwQsGXZZ/Zsx+Y2Lhd4vhaB6w7nKZkxVtdfZ8HyaZrzD+J1xMdknmkgOW1xEQGPK
X-Received: from plbaz2.prod.google.com ([2002:a17:902:a582:b0:220:eaf6:fcbf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cd:b0:21f:35fd:1b6c
 with SMTP id d9443c01a7336-22c5364235fmr8482205ad.45.1744931314420; Thu, 17
 Apr 2025 16:08:34 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:40 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-20-irogers@google.com>
Subject: [PATCH v4 19/19] perf disasm: Remove unused evsel from annotate_args
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set in symbol__annotate but never used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 1 -
 tools/perf/util/disasm.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 264a212b47df..a2a2849a5b79 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1013,7 +1013,6 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
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
2.49.0.805.g082f7c87e0-goog


