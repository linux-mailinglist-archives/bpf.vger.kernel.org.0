Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449264C099
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiLMX1X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiLMX1Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:27:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E11BE1F
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so18414856yba.1
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aIVRe/cOjz9L4S8nY/UBbQxzSd/MuoYQzSglM53rsyM=;
        b=MpdcS79Frn7RTmMinJubNMYt88+6lL4Cqi6ZXslqSjEcj3Cc+ffaIF61e32yPrqXKr
         oEEqe5WgQXYXZIwaecs50menBnE+KS4PInPrB6VEHfGFllC3dcUZC0AjLUmtokz7oV3/
         RhB14QI8hD+y2MaD0x09hL0YwxrlvEqzZQhSdQkJ66qn7bh41UNsjNYQ7gEdWFbaCi8b
         tXu8U1lQ///G1A7PA4TPQ5zf42wdDIUAdN19sx5NEmRQrmaqgG7w95voh5PLKyRm/2QZ
         IrA88MyZRV0FXu4tk++gTPp87PNt4e1V5zu0CGP6d4B3B7TJdjLJUdI6eQBowjNRtpwJ
         Ftsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIVRe/cOjz9L4S8nY/UBbQxzSd/MuoYQzSglM53rsyM=;
        b=E+jjfBICOiOWD7kne8h9T4X+bXQK8+YK4RKbAeDxD6wMADgLDtWqs0ytjuKjXn5HYl
         v7FP+tcx0OfGTOgNpQqr2QbaVPW37B6BnuSE9wdsOhP/wu0QJxA0MjN9DLENEB795NKL
         nP7SEEoIjPzKy6Upk/4BYeOxvdIQ6z6ndxRluVAsiThV0v8er3JwUqzCUoAUf2yxL3JS
         cSyBWgYZfbnJSUSGUQRrUbJSithV3ZzkvjOvbG+G1T0P6Mz8eB5ign2kexvvXNWAnwzu
         M++NuC9krcn/FWN4kki49bcXdHW1/HHIzpN/pY2CHwUxf5DI9sTS+kkCgwuQyMpiycZP
         7hcA==
X-Gm-Message-State: ANoB5plq0qn4hHdiAo9Y1WIrgJAEejqJDOT+K12GAo3+KFY32YtDsU/b
        dIW5scufXxn566GxP2XKTuNwyvS/fJHD
X-Google-Smtp-Source: AA0mqf4ivmvAS6D5iJ1XqzGr6XWwaMuvq3r8JjefQy94X3aXoM7+6W4WRDSUNklgvLh5Ob22rdse41dAXKme
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6268:b448:f7f4:4c2])
 (user=irogers job=sendgmr) by 2002:a81:4e09:0:b0:370:202b:f085 with SMTP id
 c9-20020a814e09000000b00370202bf085mr26434974ywb.502.1670974035210; Tue, 13
 Dec 2022 15:27:15 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:26:47 -0800
In-Reply-To: <20221213232651.1269909-1-irogers@google.com>
Message-Id: <20221213232651.1269909-2-irogers@google.com>
Mime-Version: 1.0
References: <20221213232651.1269909-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 1/5] perf build: Fix python/perf.so library's name
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

Since Python 3.3 extensions have a suffix encoding platform and
version information. For example, the perf extension was previously
perf.so but now maybe perf.cpython-310-x86_64-linux-gnu.so. Compute
the extension using Python and then use this in the target name. Doing
this avoids the "perf.so" target always being rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 +++-
 tools/perf/Makefile.perf   | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 52a4dc029111..83ed969b95b4 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -871,6 +871,7 @@ define disable-python_code
   NO_LIBPYTHON := 1
 endef
 
+PYTHON_EXTENSION_SUFFIX := '.so'
 ifdef NO_LIBPYTHON
   $(call disable-python,Python support disabled by user)
 else
@@ -889,7 +890,8 @@ else
       else
          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
          EXTLIBS += $(PYTHON_EMBED_LIBADD)
-         LANG_BINDINGS += $(obj-perf)python/perf.so
+         PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
+         LANG_BINDINGS += $(obj-perf)python/perf$(PYTHON_EXTENSION_SUFFIX)
          CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
       endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 98f629bbd1aa..9b7886ce0674 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -647,7 +647,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
-- 
2.39.0.314.g84b9a713c41-goog

