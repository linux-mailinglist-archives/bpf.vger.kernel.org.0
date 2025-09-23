Return-Path: <bpf+bounces-69326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847CCB942F3
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 06:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D82445924
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9D27CCF3;
	Tue, 23 Sep 2025 04:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAf+saHE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A72749C4
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601140; cv=none; b=M65QkEowtyqEBmjHJhuHyjtQjXPn8rkmB2jXw6CULWG69o5eRyorGXM85RchkqurNb9URbEUQ98BnKux5v1hxps7xvnNFrWM5FGlTznP89I1ZtZH9a/eHjpO15RvL+8FKWqikt0Dn8fwcboTyvGneKmABoDcwGKwAN2MA7AnXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601140; c=relaxed/simple;
	bh=UCkII/yUTJU5Ivn/8kuSrZ54xDQZvy/PNGwyAbAEYn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fhk/cPFRzkKLOffPcgBvMmKcuIRRpBLygsprgPsuXzD/+T/Jh49jqcIdbck9lvcXtkJqcei9g9g2hrM8DG+6z7PaFHTpup6LEacd1HT6tyfAlrYPtmC3876Q8iSUXkO8hq5AfFVPW21WnFpt+6kAg9gd1DLraF9sWj9C3cX8OV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAf+saHE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77df7f0d7a3so4152990b3a.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 21:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601138; x=1759205938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFYBQLQUysyk1nrExOGMvOXafgreMYpCr9gCjccrHN4=;
        b=lAf+saHErg8pjfhr2fNNJFnqOiD+ylKEziZl8iUhBlyQxXeNelzvcqpMHFnompzqQT
         W1GZFJRxOHFPTPkr7jT5oow5+muscZccd2QoRmjb/rkfBENp+Iw5KYvdPqNETmFoNs3A
         oZBDLO7HYeAQ3fIN4iwvG+7gZIsqUWjO1vIJbo24uDmWrw48iSQbUtXYy0ZCZT2BVNxM
         Dd8xIwV60vZOo3sztsTgT9opg3sb3qyKeyUaF3PX9JAwUvCc4VmUOY5Vrec6mwoD4ewC
         ZEcwMueCQ4Kru2MW+eBQ2aQqEyJzzVFYUU+TfGzFUfJD+X5YspGVT51qbSGfJbvR2cfe
         1Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601138; x=1759205938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFYBQLQUysyk1nrExOGMvOXafgreMYpCr9gCjccrHN4=;
        b=eqMtrZcc6wfo3/6Wkycnv+rewIRJFRTZN/ON6BZ9Glopc8Mxn92puTFBJ36jzu+zVC
         hDFP4eGARswSL/+r9UpGEZkLZIuw+c0zcCN28OJ5QpBC0OOVuQJvFYtcobmnkOVNRgkd
         LqklKoLs/MCxSiTI8TGSeD7p/xapAK4n28ej/SHcvOy+Qg4zu9mVDgngA+RnVDAsTHfv
         VqsOAebrADxSCQzOOQbW8H+/8Q7BWeExrnA17AhtwWIijdwI5K3G+V61IhAmczPcKi4Y
         tI6hccm4kuZ2yb2M//+3NZPsr4NJ6njrPZbRt15TguxJy7vLPNoODIeIp+Cu6lx9ILVh
         yREA==
X-Forwarded-Encrypted: i=1; AJvYcCXny0cFuebo/seeh4Um0c9UCKGGYyXSDQrWGd/ngNrp+iI2cftZYgSlR4fFxf3p+76SgQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnELz0hn05JRJf3qgwXF1GHrZUT8VTHbo8/B4aicqQxE1QGxL
	xLza/5BbELtEPT/BVM0AWTmHQbB+jeiVKyAGwmUna4S7LIy09kE4RtcCpritUNdEGq+Z4v4ZP9z
	DuxApObtIOg==
X-Google-Smtp-Source: AGHT+IHEmj/LE9VH0KKqPkSM+6A0hjguDdHA7vLeWdwTfHEX41gmeyHcpeIukYt+wiVnjPTm1TQzkpxfHoaL
X-Received: from pjbqc15.prod.google.com ([2002:a17:90b:288f:b0:32d:e096:fcd5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9990:b0:24a:c995:e145
 with SMTP id adf61e73a8af0-2cfe7a24411mr1821681637.19.1758601138091; Mon, 22
 Sep 2025 21:18:58 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:24 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-6-irogers@google.com>
Subject: [PATCH v5 05/25] perf jevents: Support copying the source json files
 to OUTPUT
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The jevents command expects all json files to be organized under a
single directory. When generating json files from scripts (to reduce
laborious copy and paste in the json) we don't want to generate the
json into the source directory if there is an OUTPUT directory
specified. This change adds a GEN_JSON for this case where the
GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
specified. The Makefile.perf clean code is updated to clean up this
directory when present.

This patch is part of:
https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.com/
which was similarly adding support for generating json in scripts for
the consumption of jevents.py.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
 tools/perf/pmu-events/Build | 18 ++++++++++++------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e2150acc2c13..cc1635335586 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
+pmu-events-clean:
+ifeq ($(OUTPUT),)
+	$(call QUIET_CLEAN, pmu-events) $(RM) \
+		pmu-events/pmu-events.c \
+		pmu-events/metric_test.log \
+		pmu-events/test-empty-pmu-events.c \
+		pmu-events/empty-pmu-events.log
+else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
+	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
+		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/metric_test.log \
+		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
+		$(OUTPUT)pmu-events/empty-pmu-events.log
+endif
+
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
 		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
-		tests-coresight-targets-clean
+		tests-coresight-targets-clean pmu-events-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
 		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
@@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)pmu-events/pmu-events.c \
-		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
-		$(OUTPUT)pmu-events/empty-pmu-events.log \
-		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fsmount_arrays) \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 32f387d48908..1503a16e662a 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,6 @@
 pmu-events-y	+= pmu-events.o
 JDIR		=  pmu-events/arch/$(SRCARCH)
-JSON		=  $(shell [ -d $(JDIR) ] &&				\
-			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+JSON		=  $(shell find pmu-events/arch -name *.json -o -name *.csv)
 JDIR_TEST	=  pmu-events/arch/test
 JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
 			find $(JDIR_TEST) -name '*.json')
@@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Copy checked-in json for generation.
+$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)cp $< $@
+
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON))
+
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
 
-$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
+$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPUT)pmu-events/arch $@
 
 $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
@@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
 
-$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
+$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
     $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
 endif
 
 # pmu-events.c file is generated in the OUTPUT directory so it needs a
-- 
2.51.0.534.gc79095c0ca-goog


