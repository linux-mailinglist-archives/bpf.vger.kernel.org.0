Return-Path: <bpf+bounces-49502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B3A197E0
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3907E188E281
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4D21764B;
	Wed, 22 Jan 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYjEqGWW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5D216E0C
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567798; cv=none; b=iOpScSHQgH6aIWhzL2diO+Lfjx8pToXkwO0dC4RtrwI+KuVYCifYwpV2OY2O1K+/umin5LxRcdee1XrCM+JLd3uA2a4gDPIS7YJPJvxdAT13bYUzxq5/I6Yla39RKvhIsnQfkASWG1F1ou3k7h9P+gUEWVWQX151t4lnmZmtUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567798; c=relaxed/simple;
	bh=+SiSH7CLHUUhlFjrtfw/RdUrBE2m3hzevec1yCiEXZI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bSLUbxX8gMG2TBxjhL2ye3LydXejT9cqs/XJMkwLMnTI6tBvfAQ/gXpNTx6FD0vXS2oSTuYXzPkrFc9ocHny9nOO+0nHPdNNjmyYvq3M94J5abcfwi5jgenMSmh4tZVDBZJviXxKigxId/JCTwyc4DbpZzev14StuC/+ZTKP67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYjEqGWW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e572cd106f7so18440265276.3
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567795; x=1738172595; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvK3AGwJ0K5BrCR508+h+usqMhR+kgkezdw0g6O+CCA=;
        b=jYjEqGWWV1J/hLzVUzlV9+ZBQwpAe4p8WMiYX33qSBcvQTs3ZJK58FrlnyGAHMc2N/
         EAj9IqxlruMEdq6pHsDVfHkAFdHolDGi+SYQDfddniCgULmaYnUlEivoJKILtUVIAw8P
         VB9YW3XkyQSagXzoAoSIaHoQGPw751qDXqaRcndWKqCfJ8hC9YJftdS+lybTkboxTFOF
         dQnSrCfU76uYElGfgezn1Ozu2GkWzjqPDJ66wfQ0UH8+rMKtBH/bYTug4f0+34CZL3yA
         r4v3sPIHn2+7g1bju2gEXp/Xn0s09hW7wfb0i8qXRhYl92zwbTvBiSDEUlscNG/sKQHD
         VW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567795; x=1738172595;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvK3AGwJ0K5BrCR508+h+usqMhR+kgkezdw0g6O+CCA=;
        b=SCV2UPBUlRwbx0e99UVVgXJ7BibHJQN6tKRDs+6hWK8P4Ye81is+HLXPsV3xgNhDV2
         EKS7zc7BFvykikDN4b2JLYTP2HMfA3dcKnArTgrkh+0VHamgTOnUGvBiqq1OstKIs6m0
         cGXbIcuwiCfSv76zAEEoIR8O6tHLlmpmznwu2cMJ5a/77R5WV3R9jIRNtDY31N3JBUQM
         u6ioPOok2wMJ7m8zIfS0CM6CAQshS/+qWW53DcR3YnB3ZHaImsyPsdXX0J1Ito7b0daO
         9YdPPJvMiOYAMj/AdHo7DOjE6BZeumAMTIQOF31GDtaEa5tU115QM3SAKUgh2J5c3v9B
         /7RA==
X-Forwarded-Encrypted: i=1; AJvYcCWpLIDL5XKlRinZDoiEtq4qyG3LU+dbiKnM03XomMpsMVx+Lv4RdfKOeamKwd7in9ZwRy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwumtJY1yn5+AEv/k2V5DzjX2AVRN4ZcmK+rYEJkLMxnuGaDrwK
	ryJByQ2ZLk22cWny3+IwyImBjnX6mr0qGmWLc9fVIN/7uwmFbBPmvbzwpi3QBtEAflxDIzQz8Tm
	t0clgqw==
X-Google-Smtp-Source: AGHT+IGuNDiz5m/eNmZM5imjDkd6RlEJTMH/eiVjLZsAwq564mKsb5O7VD1tI51H48iqKvALbnZ2UuQm44KK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6101:b0:6f6:d314:49c9 with SMTP
 id 00721157ae682-6f6eb949eefmr553907b3.8.1737567794993; Wed, 22 Jan 2025
 09:43:14 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:51 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 01/18] perf build: Remove libtracefs configuration
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
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
index a148ca9efca9..cd773fbbc176 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1174,20 +1174,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
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
2.48.1.262.g85cc9f2d1e-goog


