Return-Path: <bpf+bounces-32144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD687907F75
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 01:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8011F21854
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C2157E9D;
	Thu, 13 Jun 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAIjzW1n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9326157A61
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321513; cv=none; b=defTcu4y2Hw/Dh909e4DHBF7gmqVI6ZEK1qB4Nl2cEUi8+Jk9J/eYuiMtOJTLXZEzlGrG7GDhhQ+4I1hW7i2XcJydjamtNZffZTVXKjHxwN07AKO2ltxnaiYVfabh4qssyLtpgAdiHe8ltmjjjQ/V2pRdCtJz1KyVlxNj4tdAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321513; c=relaxed/simple;
	bh=YCtNNA8v+ohwBpi9Rus0CYVSC7ZO/eTuaCLvVJt5XpM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=NGmolq7L4nRa3uauaKV91en9SeVkAxKCFlmVO41API22RyeGqqxgo1yUw04wj76sGkD9kg9I5AXGVIuTkQzy25lCUf99B+LV5K26Q2NgGH5CFAg3vAWkvATwZ050nhqfn2lswUlSA6IVbH/tc+ntFNZaZVL8bI0WLtoOx9sIy9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAIjzW1n; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a3dec382eso17491867b3.1
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321511; x=1718926311; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsC80hpqUOVrh72YOJDioHn4WeJ5/uS/HucL7CDuoyM=;
        b=XAIjzW1ncKog4oWEFMl6ZwB2pkG2xTX6RIFqdXE8szl9fWK2oDQ/gW7V7gCXlstkCP
         14kJ5fFiVljOqDwGaAvQrtp8A9jh020dt6GgMfh/g/oYbPInYm7gq/kbBuxiJFZCnPRp
         4ONYWkfdLaPehuuOllngc77Bc0/dclB0GuorHCUCVHr1Ph+Cb8fX+ThYPV7YvRyiJu73
         ZgXH88m933FXbTJiYBVWyjnQfbwPNzkIT22wVSswq5eLvpqbF/njpxsMdyHgpbqiS0MV
         5WzwIHsF9eL+0RpdJxxdu/S8SNgzZqjGUhoZV8gQzGQbBgp7W2vGq64X9Ff+DQOXZTX0
         rdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321511; x=1718926311;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsC80hpqUOVrh72YOJDioHn4WeJ5/uS/HucL7CDuoyM=;
        b=iexFcOtHjzSvsyiK8N3h/vtqJ56vC6MfOV1eJhn0IdPzQs0cXhUGJI/Z+avpfKpOL4
         blap6cCglZJ+j3noL2D7TzUJysVanSta28DGZscohCEkNbLUw7qgkeKiKi+Fs/1Nvjdf
         fj7Cf/TuNmrw1Kq7+IhVCHAKLhycrzCebUqzBj/S/wChh/gkD/fbOkSWfJ4drezQRHx7
         uv0vvzFfmzYZAuXTJKDTsveSkKwWdCjNlJJYgpE7ibuNiEstNho6i/AjDAnhWxgHRYW7
         zUXk042LkddwfQxDhRmk9iG6DWmU6eErLNtdR7sK6+JARGQyCc+bwIeLNThDC1mX0tTC
         4ZVw==
X-Forwarded-Encrypted: i=1; AJvYcCXjN21WqbSY/FqXO9qru3qKsnP/kPpQe2e7I6e60Z6A9yzCPbn5dRJBvMfa8vLtpNz4hcYbBmJVOG/+fswTv+F5RWG6
X-Gm-Message-State: AOJu0Yw3AryjbrhmuSoAzdzbxUHVjtXUuIVd0LXPWkLhIpzH99kZrPFM
	TPyCddm5gC88gQJiBx9CbocuVUIZmE1PO8o/JOJmkrsuUsDHM3XaWxAjWb3p/uowMeSl0VCsXV6
	yRMvrTg==
X-Google-Smtp-Source: AGHT+IFQbqBkASsdg2SlSfv0w0FxeOcJheuzQSPKY3DmVk1q2TSfwkGhF+bycTWG9UalHmuP2wL6xbAMBhcl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b12:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-632015b69f0mr4076157b3.0.1718321510936; Thu, 13 Jun 2024
 16:31:50 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:19 -0700
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
Message-Id: <20240613233122.3564730-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 5/8] perf bench: Make bench its own library
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the benchmark code into a library so it may be linked against
things like the python module to avoid compiling code twice.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Build         |  4 ++--
 tools/perf/Makefile.perf | 11 +++++++++-
 tools/perf/bench/Build   | 46 ++++++++++++++++++++--------------------
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index fddd45ab35b4..2787f5630ff7 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -1,4 +1,4 @@
-perf-y += builtin-bench.o
+perf-bench-y += builtin-bench.o
 perf-y += builtin-annotate.o
 perf-y += builtin-config.o
 perf-y += builtin-diff.o
@@ -35,7 +35,7 @@ endif
 
 perf-$(CONFIG_LIBELF) += builtin-probe.o
 
-perf-y += bench/
+perf-bench-y += bench/
 perf-test-y += tests/
 
 perf-y += perf.o
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9fa69dd0b472..4a3c000b9845 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -425,6 +425,9 @@ endif
 
 export PERL_PATH
 
+LIBPERF_BENCH_IN := $(OUTPUT)perf-bench-in.o
+LIBPERF_BENCH := $(OUTPUT)libperf-bench.a
+
 LIBPERF_TEST_IN := $(OUTPUT)perf-test-in.o
 LIBPERF_TEST := $(OUTPUT)libperf-test.a
 
@@ -438,7 +441,7 @@ PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPMU_EVENTS)
+PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -740,6 +743,12 @@ $(LIBPMU_EVENTS_IN): FORCE prepare
 $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
+$(LIBPERF_BENCH_IN): FORCE prepare
+	$(Q)$(MAKE) $(build)=perf-bench
+
+$(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(LIBPERF_TEST_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=perf-test
 
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index c2ab30907ae7..279ab2ab4abe 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -1,25 +1,25 @@
-perf-y += sched-messaging.o
-perf-y += sched-pipe.o
-perf-y += sched-seccomp-notify.o
-perf-y += syscall.o
-perf-y += mem-functions.o
-perf-y += futex-hash.o
-perf-y += futex-wake.o
-perf-y += futex-wake-parallel.o
-perf-y += futex-requeue.o
-perf-y += futex-lock-pi.o
-perf-y += epoll-wait.o
-perf-y += epoll-ctl.o
-perf-y += synthesize.o
-perf-y += kallsyms-parse.o
-perf-y += find-bit-bench.o
-perf-y += inject-buildid.o
-perf-y += evlist-open-close.o
-perf-y += breakpoint.o
-perf-y += pmu-scan.o
-perf-y += uprobe.o
+perf-bench-y += sched-messaging.o
+perf-bench-y += sched-pipe.o
+perf-bench-y += sched-seccomp-notify.o
+perf-bench-y += syscall.o
+perf-bench-y += mem-functions.o
+perf-bench-y += futex-hash.o
+perf-bench-y += futex-wake.o
+perf-bench-y += futex-wake-parallel.o
+perf-bench-y += futex-requeue.o
+perf-bench-y += futex-lock-pi.o
+perf-bench-y += epoll-wait.o
+perf-bench-y += epoll-ctl.o
+perf-bench-y += synthesize.o
+perf-bench-y += kallsyms-parse.o
+perf-bench-y += find-bit-bench.o
+perf-bench-y += inject-buildid.o
+perf-bench-y += evlist-open-close.o
+perf-bench-y += breakpoint.o
+perf-bench-y += pmu-scan.o
+perf-bench-y += uprobe.o
 
-perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
-perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
+perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
+perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
 
-perf-$(CONFIG_NUMA) += numa.o
+perf-bench-$(CONFIG_NUMA) += numa.o
-- 
2.45.2.627.g7a2c4fd464-goog


