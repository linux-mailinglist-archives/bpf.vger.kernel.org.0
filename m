Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815BC6438DB
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 00:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiLEXA5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 18:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiLEXAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 18:00:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C28D1EAE2
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 15:00:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i19-20020a253b13000000b0070358cca7f7so130380yba.9
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29cYpp0Ewjs+gzHUrxa4ZZynn8ecl1yz6sJ+mMKI1iY=;
        b=dqkx3dA8M0NS4ER0/zeH9vkBKGWQA2qFb96pbTe+HXR6K5Bma3er6/Rye2j+T83NJh
         /0hrvbMHcozNXhfKwmXHN4cX4i806/ymuNMuJudRJSgQHlBN1OOcxQcNjm3gg3DnIfAJ
         3ApwLjyxTABgKG3eGbIfOqEUsgF2yHh3zY41Hzao63Ms3damiiKD58QcXXRdZTGXQdKv
         JQ4/H/qq8eTcEdVBmTGQM6CaprOBkOgjxQ3PukxoWJ2+8Q2C21Zs6l/pmeEsvx+apBmE
         A5qUGbzJjYfRGGWvzGeV04FgJ2q28hKVfaxkKf5NY8et2/ZuqGHzJUVMgv618bH+VH8R
         Z8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29cYpp0Ewjs+gzHUrxa4ZZynn8ecl1yz6sJ+mMKI1iY=;
        b=Brdf5ovH83B61Pa96TLyJtPpbA3mcDT7NuEptURoMqmIurPZCoRFPomxhEYnQVCy/y
         yKr+zi7RmNqom8mCQ/nfkM1W7YfYifwn6LexxHuIqPnyVhcY0KXLEyvXMP4Awkc8c2h0
         R/CnkahxL+oSEC1qpEHxvdqfUI9j+PDhfR/vLxNU/cPuefKEbYQshN08fLmp5lGpxf16
         NPcQbj6UOSwoMwgp3HnswaRYSvgRaF9DOkSVHJDBlU8iNHeb09SmJ102K7AkgKkOtJ01
         zTfFQdnfwS4IPrdSxKleD1fPyJyvcdSeOgihC/pVd7Bvxk1nmz/UQMJYG2AzD9Z5iYhY
         uKLQ==
X-Gm-Message-State: ANoB5pnRv+bjoQaLQuZyjtM5l3DBgnmtUScfJSvWDoF497rDzh/3yIBD
        G0VoniJZFZXrTN1Duo9bl5GZuTqW0/q3
X-Google-Smtp-Source: AA0mqf4B9f2CkgsFsBObCG8SX92pN+WkJJT00KkEcVBC93nZPIyGaYd1Bl5QMGXw876c8d0tKTX669flR8QZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d2ab:5fbb:e81a:9151])
 (user=irogers job=sendgmr) by 2002:a25:a290:0:b0:6fe:efb3:2e29 with SMTP id
 c16-20020a25a290000000b006feefb32e29mr11389698ybi.616.1670281243531; Mon, 05
 Dec 2022 15:00:43 -0800 (PST)
Date:   Mon,  5 Dec 2022 14:59:40 -0800
In-Reply-To: <20221205225940.3079667-1-irogers@google.com>
Message-Id: <20221205225940.3079667-4-irogers@google.com>
Mime-Version: 1.0
References: <20221205225940.3079667-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 3/3] perf build: Fix python/perf.so library's name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index b34288cb1900..ede04e07e9cb 100644
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
index f0e4daeef812..869856bdfdc9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -642,7 +642,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

