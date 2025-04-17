Return-Path: <bpf+bounces-56186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F770A92DAD
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A377A1BAE
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA94221DB0;
	Thu, 17 Apr 2025 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tatps3Ue"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759D221546
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931279; cv=none; b=uc4IRmqJiu766co/Ps04jSuqBqhNPyWzNHTg0zwt2+sYz3UT5hQUP3kF3jB96YLpLU10obSFCR4JqBlBAyoGvXIaTXotKxvsXRsHCzzNV9JTwz3dtJsYs0pWGrXMvkJuPm+bmIfsN8bAd+61wPLIM9X8UxYYrtoxcn8LPA5jJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931279; c=relaxed/simple;
	bh=DUhmjAhpzI4glFlJFVyHh6Dy0isdHfkiubMes37ZCtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IMJGFjkRTLUMe7U1CXsQBFP/exUgPZcNR4Bgaegf2QWhhwvGKUrCUApZWcsHuyB7GsK+opiaet62RCIUjDRSN9bnPwJALJDjmOO6w9PpVXpRJbw2gq4wfyVyz0wzJpUkVWm2ThkRleBU9AwGs13pWPmGv+CBCSc7is953TBFPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tatps3Ue; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ce15cc3so12538965ad.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931276; x=1745536076; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnICyJ2RGS0Y400AqNRs1KksXFmr5hh/vv3vYVQnBHQ=;
        b=Tatps3UeOf3aVg+3xmw+Ju+O8rdbwyVWbCD32mkYDDwu7ibuc/j4wotSFOrASJSFQZ
         eaNO+oRAD82RTlqH+Cxqe8w6QJCd8WJ/0uVVOhG2PCTrqbygl4immiLzgtzlTVvaFmP/
         +ET3q0RiWqjkj03aJ+uS0Rcory8jkt3EbXsrbzb+GjsSUoNDUfea8CGncx29InN3wJnN
         Wxj8GTNYkUG2/79z7HSHIprwC8NhBySAk1SS5rq3xO3b/5eWtHq42dSz3k/G8dcW6fTP
         64H4J0GBlewWDWE0+nBSik8eDIQK+4b/JUlE9AiSZUY2wa/wI3XrmcRKrx43UtauIjTO
         o7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931276; x=1745536076;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnICyJ2RGS0Y400AqNRs1KksXFmr5hh/vv3vYVQnBHQ=;
        b=YL54qZJHC4rHBLPRNFFyYA4tnE0ZT07Kxwzw0OPq1ciWa2L+k1A4pTXdrwzY9i/xJe
         K+bMv02JsQwHr+2wqYuNGeSJH22lzgqb+84U3wb4QEAFRINx3jLAuQQceqwoSjYGdAf2
         Wdan93opTToPd2ZOFXhp5BXSzqBnup41JAdOVU+USPURpZA8WC9Poh9YM3RYOA8ukJXM
         kJapGMw7pk57d1apRfjx82Led/7jSV+Y1Ff05Ug2Jy23L7gXMcOQaalToa2v8SmGkDCd
         IpApaiC1fdVq9ryesjZ+DOFYiyQc6nXC/KG3kEAQ648agbu/UkopoyA92lTXidZw+Gyy
         DkSA==
X-Forwarded-Encrypted: i=1; AJvYcCWpt91MTmCB9QV9iq/q3gcOAJAzHt5uRD5dYjSy2bKqBknd6g9iFp+Dhh+dUu6cjLdmrCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5V1jCzsXhD3EVA/hs30YNlPfCXFluFx6yAElvV2fA0N4vhMhi
	UpWNwxeW06oE/ug5obBYNxoKtFStOE07VEF1PSWTcPIQLdJBGraidej3iplUGRW9ShErtFuCfTS
	AH6FbRg==
X-Google-Smtp-Source: AGHT+IEwa/KfQTqntEV82qp0baymPwWs4os7wo5Uctj1zdlTuJFxSq6S5ewEmLz+IORlKXcqOKBHo7BSNgld
X-Received: from plkj8.prod.google.com ([2002:a17:902:6908:b0:220:d79f:a9bd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecd1:b0:226:5dbf:373f
 with SMTP id d9443c01a7336-22c53379f8amr10249835ad.10.1744931276358; Thu, 17
 Apr 2025 16:07:56 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:22 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-2-irogers@google.com>
Subject: [PATCH v4 01/19] perf build: Remove libtracefs configuration
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

libtracefs isn't used by perf but not having it installed causes build
warnings. Given the library isn't used, there is no need for the
configuration or warnings so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9f08a6e96b35..f31b240cd23e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1176,20 +1176,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   else
     $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1)
   endif
-
-  ifeq ($(feature-libtracefs), 1)
-    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
-    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
-    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
-    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs).0.0
-    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
-    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
-  else
-    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
-  endif
 endif
 
 # Among the variables below, these:
-- 
2.49.0.805.g082f7c87e0-goog


