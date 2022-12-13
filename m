Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DDF64C0A0
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiLMX2I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237093AbiLMX1l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:27:41 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49E108B
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-40306a5a42cso185524517b3.1
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=72onBX7/v3Mkh3/F3ClgCmK3zR5kHyTFpk5uwdtwCSs=;
        b=T/Fv+q4wWPE3/uQotDdRijKFH3wyVwQbQ6gc3o+vcrxcGxHU3t678lqjpd5hs2LAm1
         x0WiDtolBdP9LLUfuShpATfqnEM94gWbBXa1GmMyuT8d3lyAz/XUjWRfuk9UDQJGWFJp
         CUgd8NywSesnjHsYKs9Z65pnqjEbDYgfgUWchjy/cUREjNsxMwwVCzR/SYJLIzw896hf
         nFXYYMdtkAJ0Yh8KfQBTZpXWI6ldCqpSDI2nY1kztBwuG8Bvg+cPgFOi0p+ba8eADjM6
         Gvhb3Ho2ZAHZ5Z9qTC73tqXlombRlG5MIm+fUTNKbEhSc6QgcgebKoPsHl7IVhnx1uHE
         Isyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72onBX7/v3Mkh3/F3ClgCmK3zR5kHyTFpk5uwdtwCSs=;
        b=OeO578a8/eo3Pkwa6CfKgMeIz0z03k+QPVueTQqZkFnrTd7qNmSSklanz/LrTCLkm+
         fx90FRiyZPwauc9lHgq/fi/uyXVEyQ7eRC8bCwPn0rCHb3oFWpd46LMiJXvNFSRe8bsj
         Pow+k8XjM3kbd77rZgxrVrgRszwZB2aKSgUNirqtVgtgh2ga2BE7q7Ow3Qgy3q38/67Z
         t381MTYWU46p8mcpSnY/yALws7rDizWCF4wGW1o4ny1biSoLc0s282B79mXo5NVkIQ77
         C7ZFaFBcXqyMec96w72k5byKQE4BK9z2THsYuTVnPUyjSYkooj6AdjXV6/8K3RJe92FR
         Wi3w==
X-Gm-Message-State: ANoB5pmLujIcFmeOsEUjBjP5pV9Vo7HL/+I/ftGH+2ngkr+NP6my6aFH
        ju3SeB1EUtRl0pxfQeQrPdbuoJN5y9jJ
X-Google-Smtp-Source: AA0mqf6FWf6mxEZmcY8v7SJOvXLGF/9RX9lRdm2kMd2lzjJY4Fdw/47j4qf7w0vBcY89VCUqD7mYsoFMgwy0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6268:b448:f7f4:4c2])
 (user=irogers job=sendgmr) by 2002:a81:8343:0:b0:36f:d5d4:7e0c with SMTP id
 t64-20020a818343000000b0036fd5d47e0cmr27799444ywf.122.1670974059011; Tue, 13
 Dec 2022 15:27:39 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:26:50 -0800
In-Reply-To: <20221213232651.1269909-1-irogers@google.com>
Message-Id: <20221213232651.1269909-5-irogers@google.com>
Mime-Version: 1.0
References: <20221213232651.1269909-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 4/5] perf trace-event: Use version check to avoid 1 define
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE by using a version
check against 1.5.0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config                             | 4 ----
 tools/perf/builtin-trace.c                             | 2 +-
 tools/perf/util/data-convert-bt.c                      | 3 ++-
 tools/perf/util/evsel.c                                | 2 +-
 tools/perf/util/python.c                               | 2 +-
 tools/perf/util/scripting-engines/trace-event-perl.c   | 2 +-
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 tools/perf/util/sort.c                                 | 3 ++-
 8 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 83ed969b95b4..9a71d8659efc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1199,10 +1199,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
-    LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE := $(shell expr 1 \* 255 \* 255 + 5 \* 255 + 0) # 1.5.0
-    ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt $(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
-      CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
-    endif
   else
     dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev/libtraceevent-devel)
   endif
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c9802ab549d7..2c8a213e0bc3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2729,7 +2729,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 				offset = format_field__intval(field, sample, evsel->needs_swap);
 				syscall_arg.len = offset >> 16;
 				offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index b842273458b8..7ec0d13fb470 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -36,6 +36,7 @@
 #include "util/sample.h"
 
 #ifdef HAVE_LIBTRACEEVENT
+#include "util/trace-event.h"
 #include <traceevent/event-parse.h>
 #endif
 
@@ -322,7 +323,7 @@ static int add_tracepoint_field_value(struct ctf_writer *cw,
 		offset = tmp_val;
 		len = offset >> 16;
 		offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
 		if (flags & TEP_FIELD_IS_RELATIVE)
 			offset += fmtf->offset + fmtf->size;
 #endif
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 77b2cf5a214e..6e623d5541e9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2784,7 +2784,7 @@ void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char
 	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 		offset = *(int *)(sample->raw_data + field->offset);
 		offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
 		if (field->flags & TEP_FIELD_IS_RELATIVE)
 			offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 7320f7f777fe..1d0cf72506a6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -442,7 +442,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 			offset  = val;
 			len     = offset >> 16;
 			offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
 			if (field->flags & TEP_FIELD_IS_RELATIVE)
 				offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index c097b7934fd4..1062629d13c2 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -393,7 +393,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
 				offset = *(int *)(data + field->offset);
 				offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index e930f5f1f36d..e294a13c399d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -994,7 +994,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				offset  = val;
 				len     = offset >> 16;
 				offset &= 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
 				if (field->flags & TEP_FIELD_IS_RELATIVE)
 					offset += field->offset + field->size;
 #endif
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0ecc2cb13792..b929cc5eb8cf 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 
 #ifdef HAVE_LIBTRACEEVENT
+#include "trace-event.h"
 #include <traceevent/event-parse.h>
 #endif
 
@@ -2568,7 +2569,7 @@ static int64_t __sort__hde_cmp(struct perf_hpp_fmt *fmt,
 		tep_read_number_field(field, a->raw_data, &dyn);
 		offset = dyn & 0xffff;
 		size = (dyn >> 16) & 0xffff;
-#ifdef HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
+#if MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION
 		if (field->flags & TEP_FIELD_IS_RELATIVE)
 			offset += field->offset + field->size;
 #endif
-- 
2.39.0.314.g84b9a713c41-goog

