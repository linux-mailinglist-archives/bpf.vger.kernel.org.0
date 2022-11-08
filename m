Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEE620A5E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiKHHiL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiKHHh1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:37:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC5A2F672
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:37:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-370624ca2e8so129934557b3.16
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHQYG2S+r6ZQkfu64Vbijcu9xq3IEuE8DFugpR25f3I=;
        b=ZUAZDJI66aG+v2oL+iUezXAlrcjCsx9STzuWpYrFIJ7KKSwlLdAeNYs6QXC12jzbr/
         bUpGUlyBk99Us4IxVCkwQlFnPFn8h1EUalTZqH/TU8mV86dDNvu0UmnfecUV5mPeockq
         G3yZNHGXas/SEjphMVJ2jTGysrb12qr9GZefcLdrPs7fWqPM5xK0/u58DVEyA4hKvkz5
         6pKeza5OGk7tiEFBLcXfYErgwUObvWjHsk5t9Lu70d89j87FhY3ebuxcNMz3iCj9jl/l
         m2kdkkOoG0vomG1G7qgqFTFoKv3qWH+KoJM5BQMF+aFTpwNRQcfpDXzK2Ey1BZ5y9fwh
         QjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHQYG2S+r6ZQkfu64Vbijcu9xq3IEuE8DFugpR25f3I=;
        b=YS4MCtcapzMQNiMfHvy5Y94f59QDVldrfwY+scwufiMPc1WUArIo2nMyBPRI2D3jsX
         FMqIxT3+8KaTcP6q4OyzG7J9tQSvOoljcIrTl42UfG2cQN9aCglqyrU1Hm2Y21t4dsOq
         ZefjiZSTfzuqKHlJSEBfBGQ0OjKd8dbs5fPUZw0lcb4bIlzKNuOArVsWQgl6SyM3Btmr
         gtNmYpxDJSKzftnOV9kQr7H5ihnoDqXXtTkQc5C4YEofnQDs5W4BsyOosYaCMN89zIn6
         3rsml8EoBbF2yoLL9R2q7tbjRAqFI36jPRqX20ESjqQMwOihk8MotIHBgijHv//obKPV
         Sbvg==
X-Gm-Message-State: ANoB5plWd5+ZnO9b0rHLpUIw5x3KPcEwjL8Vj08UuvBqRe46SPQL93gC
        4eMNy6T0Zicb6WlbdNbTNob8+oyN2xNC
X-Google-Smtp-Source: AA0mqf77IeoARDi2HjW0xRmFqlor4qhJZxA6V4qBqBtWXQ+/I6DQ+Yo3d3HGw2vk41NyDb4dHed9X3vbRKAq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a25:2507:0:b0:6d4:13d1:c781 with SMTP id
 l7-20020a252507000000b006d413d1c781mr617399ybl.478.1667893044770; Mon, 07 Nov
 2022 23:37:24 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:18 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-15-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 14/14] perf build: Use tools/lib headers from install path
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

Switch -I from tools/lib to the install path for the tools/lib
libraries that are depended upon.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 --
 tools/perf/Makefile.perf   | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d3d3c13a9f25..d7fcd1624cd7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -349,7 +349,6 @@ ifeq ($(DEBUG),0)
   endif
 endif
 
-INC_FLAGS += -I$(srctree)/tools/lib/perf/include
 INC_FLAGS += -I$(src-perf)/util/include
 INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
 INC_FLAGS += -I$(srctree)/tools/include/
@@ -367,7 +366,6 @@ endif
 
 INC_FLAGS += -I$(src-perf)/util
 INC_FLAGS += -I$(src-perf)
-INC_FLAGS += -I$(srctree)/tools/lib/
 
 CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 1d90d78303b4..851dcc0272e5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -305,6 +305,7 @@ LIBTRACEEVENT_INCLUDE = $(LIBTRACEEVENT_DESTDIR)/include
 LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
 export LIBTRACEEVENT
 LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
+CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
 
 #
 # The static build has no dynsym table, so this does not work for
@@ -322,6 +323,7 @@ LIBAPI_DESTDIR = $(LIBAPI_OUTPUT)
 LIBAPI_INCLUDE = $(LIBAPI_DESTDIR)/include
 LIBAPI = $(LIBAPI_OUTPUT)/libapi.a
 export LIBAPI
+CFLAGS += -I$(LIBAPI_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBBPF_OUTPUT = $(abspath $(OUTPUT))/libbpf
@@ -331,6 +333,7 @@ endif
 LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
 LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
 LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
+CFLAGS += -I$(LIBBPF_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
@@ -340,6 +343,7 @@ endif
 LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
 LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
 LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
+CFLAGS += -I$(LIBSUBCMD_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBSYMBOL_OUTPUT = $(abspath $(OUTPUT))/libsymbol
@@ -349,6 +353,7 @@ endif
 LIBSYMBOL_DESTDIR = $(LIBSYMBOL_OUTPUT)
 LIBSYMBOL_INCLUDE = $(LIBSYMBOL_DESTDIR)/include
 LIBSYMBOL = $(LIBSYMBOL_OUTPUT)/libsymbol.a
+CFLAGS += -I$(LIBSYMBOL_OUTPUT)/include
 
 ifneq ($(OUTPUT),)
   LIBPERF_OUTPUT = $(abspath $(OUTPUT))/libperf
@@ -359,6 +364,7 @@ LIBPERF_DESTDIR = $(LIBPERF_OUTPUT)
 LIBPERF_INCLUDE = $(LIBPERF_DESTDIR)/include
 LIBPERF = $(LIBPERF_OUTPUT)/libperf.a
 export LIBPERF
+CFLAGS += -I$(LIBPERF_OUTPUT)/include
 
 # python extension build directories
 PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
-- 
2.38.1.431.g37b22c650d-goog

