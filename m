Return-Path: <bpf+bounces-66346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE2B325F3
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654C51BA309D
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B621D3CC;
	Sat, 23 Aug 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cA6iz2Fk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C586219EA5
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909185; cv=none; b=QRHiaJdeoD+2ObNP6aTkPz6qh+wNS5R0wLd7qc8nLlnuVtNcao/XxbhCgwE5VJcHyCiG0t98hPQgRKcoBVa2X4ZLd9qSp/0HW/0KrAXl0ZAxvrciMH7N0BpTzj1wE4chatYKgeWDWkN6s7dU0LhvtuQOSnv4Arckxm+kK0Ns32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909185; c=relaxed/simple;
	bh=8kyU+3N5rFa4jxI23fv/JBL+QDC2pprcydJkxdbk81k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JRKywT1h6Yns0th4hKYBkkrwMTUrvFVWzv2Z8JEru+6uDFg1zeN0vj3Zo9VLTeflkO7p/F8iGV9+M3xKKNi6BqCvWOH55uvM0UGKDIABp/aF5fIxHbrwSJ0OJ7omg2cxAiw/7hxD2aOumYAUe4oNLrjfp76AzTc0Rzl7L6bw0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cA6iz2Fk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71ff15cdbbcso6508787b3.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909181; x=1756513981; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Us6z2TKlP+S3hY+Lrnn4T4iR89YiftOtm9vFr92wiA=;
        b=cA6iz2FkyHvfICYNjXDVxPLDJzE/Gxs2MX0xbHQtxaF32LjHivzCqB94DMum3EdxUZ
         BRCzVyadq/OT61Z1fh8hLao6oz2AECHxDWFR+D5WfxOpccLKptZtpPVpjar9+Wy33ewv
         c2alR8bpHDaq4pKu60xivxwUE060zo19za/7SfSHLpUnbXqtM1Lm718HCx+NTP97sPgz
         hdeIGzpbBJCdw/glFHoKOzsPdggaY7pBCYwElse6d5H9BlCv5tRSKicJq1L6o0S9m8pJ
         YJI/RiW3AKqiQEcESkT1cTimv3Q2nio/HLHqEWeeEG7pbz3Rbq1nI/tl4go8/C2iFW7j
         iG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909181; x=1756513981;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Us6z2TKlP+S3hY+Lrnn4T4iR89YiftOtm9vFr92wiA=;
        b=TQMvltj2cybc8ZpVt6MJv/Ixz5ck1vdP3MywmyviMJeB+pJb2xP9g2Z4zXCNMV9IeO
         oYcS4nHC4ovnalUT+u2MxpAmHd33o0PbjIOE8dUTs0YTqoDSIM5kNSoQijqEn0Rh92j5
         cmsgvLJK/3vQYsVNl5T4w0TUQzyYdb8Wm5Enfhj9Xf9iSDncpXZc1Jt39PJckvzSXSWO
         jYqCvZslmhJz7usXBgZu+bZ6/9yqRWgx4xMVAZ4+tc75DoYOrACGzCJoo2+yOXhcerMq
         cAlSEYA4xDcUGjt09t4YpCksszZDueWnWTZqfGqEY+EqyZHda8TUpqj66CIO5+p3Z/AG
         YyUw==
X-Forwarded-Encrypted: i=1; AJvYcCXyWNTLuvU+OuM1LLjv+ppPV3GNfWN9BHMKjY240gCeG/61/hKEEnwtpeUN6MAlGsycWqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyn/alZpjIFfGErwi90bcpC60WNvsGpcFAuar1OoTbLptT5hpB
	QNHcD1bUO4mvGGvmjeF4FLzHlJwdmcMgErmrJNr9aIDmx7cSKlTzAlOdNmBvPUDj0Jk093A+VyK
	UFsHOERcXPA==
X-Google-Smtp-Source: AGHT+IGpxx6kQIV32JN8263+0yzcwCWq6SBuLlQ67pYy5mvtapsVA7DULVOD5wjGf4B8dA4bilIhjdNDayJw
X-Received: from ywbjb12.prod.google.com ([2002:a05:690c:6e0c:b0:71f:c8f3:536e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:3507:b0:719:f7ed:3211
 with SMTP id 00721157ae682-71fdc2b0312mr51727347b3.7.1755909181497; Fri, 22
 Aug 2025 17:33:01 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:11 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-16-irogers@google.com>
Subject: [PATCH v5 15/19] perf build: Remove unused defines
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

DISASM_FOUR_ARGS_SIGNATURE and DISASM_INIT_STYLED were used with
libbfd support. Remove now that libbfd support is removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7bc9985264a7..d39297bd404a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -323,9 +323,6 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
-
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
@@ -352,7 +349,7 @@ endif
 
 ifeq ($(FEATURES_DUMP),)
 # We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# As we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -1006,14 +1003,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
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
@@ -1288,6 +1277,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


