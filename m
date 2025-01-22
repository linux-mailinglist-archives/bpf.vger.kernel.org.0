Return-Path: <bpf+bounces-49455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD46A18C03
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB7163B5A
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA661C8FB4;
	Wed, 22 Jan 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyUb5EqX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0A1BD4F1
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527155; cv=none; b=ZSM+jADhNtMzqGBjEGo8YEiYNta4eEjvUYjExR5wAqFmnnyzowOibrr2SJYIo3JhdGBZ6nlVR1FbZpBKfdGyfaCK8BVvIrSmO4WVhZvSF/C1y5mMIuRCnUrGfG2bj7WNzZGn2gk6WZfdLXasv6mEwmk2lGY8+wGqBtP1V420Re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527155; c=relaxed/simple;
	bh=YkWOp6sBnU9ELov42ERsPm7Vngu6X+NP4toNn4LW5Oc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Qj1doTh7MPhaQ1Tgh9NEjQPlqGdh+c/9UKZfmvu9rHDdhd6HPoGTzZBQrInfIe4Lfx6v7oXA2COb0irzASAOjhpkdxD0tfoP/GWSLRvlee51J+62aIKyDe+0UbIo7Odrbe8Vf5j0FS1QrtxeSocAZIXESK5P7dhWxkI9TPi+/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyUb5EqX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e39fd56398cso15278225276.1
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527153; x=1738131953; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9hPyZ1Eqh7FkhnlmqyYPUb6W8XykQq6Ozx0wTDbMtQ=;
        b=AyUb5EqXwM+HhTGIaPtl/e5ly715nkUGyRXd9pppHJAMVbeKJIDzLphhXccre/gT45
         mhLbEkkiQEVrW0Mp7F7g/wSsHFn0FZYcb32g4bqxSwyJG0vaOMPLC2tlmtZhxQdyIG6a
         s3E3wCIcD1/QxKkAEPW8uLQ7evlJMj5GKkg/cG9srdSdgNO4+SZkea5qFg1ZmojRlxR8
         7Gja07D3t/WbPNM94nL6LUr7tTYjGLbexHb0Pkr067GdXXu0aGimWn0jBsny1F0qjENa
         lqJBkHGB0FFIB2sqgExZPH7FitiqJe1jjs8VQSvQtD5RABZO8ZCGwQT9ycwNUfDckXBU
         RQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527153; x=1738131953;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9hPyZ1Eqh7FkhnlmqyYPUb6W8XykQq6Ozx0wTDbMtQ=;
        b=TNgVl9jNpffv88mzXrGok4PgaHltFgdyESeVQ3Xw8U/9t+g/R2hVTj/YnYXCq+4Qyc
         RecWwUGaJ0NmVmk5KHde/6X1ErqM3qtNCnA0iRipPWgpUA1D0f4LSLEp5p5z0VXISN1d
         c2bG8yNEtwFzf/Jy5JcTL2qe3ot+f9OWJWsQ7U0KYF2LgDZm1vANLr5JAGhzRzvNcG+O
         x5fdk7HByWYnzdRgfD+IBC/XNtsykqvSH++cSlsGY5oLUUnKp/gopcbD7InaIbHxZdwE
         En4eg+UJNobnCdvFhTX3oEJ8B9BYMafqkOPveYlljOaGHirzXftTr9E8t23xLfQCoI1B
         PsAg==
X-Forwarded-Encrypted: i=1; AJvYcCX77GnZGVir0M6JBlMRx/dbNuqIS1Kd8uRWSq+O3hRFpKmzEOlySy+wqKnvZ9YYMDPqNRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oAPyxBARYbzNjNjRCWzITd/pCzF+tQCNh8RIZuWcnJ4V9qZj
	nzt9nPGRfzwJTNPEzoTC7uv0iL+TOku6XQSYEo3AOlJIVNPNvfjriZDZFh0YzBwl4AloU3xikBg
	xKVsdmQ==
X-Google-Smtp-Source: AGHT+IENajIP32nGxFM0VFkKXqErBuQpYWc46Ni8szy3vhHn4bDuMStRS5BfINva+xTIFK/Nmc3Oq8aYUx+T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a81:c807:0:b0:6f2:8819:2318 with SMTP id
 00721157ae682-6f6eb93c63emr362427b3.5.1737527153324; Tue, 21 Jan 2025
 22:25:53 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:30 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 15/17] perf build: Remove unused defines
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

DISASM_FOUR_ARGS_SIGNATURE and DISASM_INIT_STYLED were used with
libbfd support. Remove now that libbfd support is removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 513dd5cab605..ba60a5b47be7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -320,9 +320,6 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
-
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
@@ -349,7 +346,7 @@ endif
 
 ifeq ($(FEATURES_DUMP),)
 # We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# As we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -1001,14 +998,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
-ifeq ($(feature-disassembler-four-args), 1)
-    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
-endif
-
-ifeq ($(feature-disassembler-init-styled), 1)
-    CFLAGS += -DDISASM_INIT_STYLED
-endif
-
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
@@ -1286,6 +1275,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.48.0.rc2.279.g1de40edade-goog


