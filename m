Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD56232FC
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiKISvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiKISu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:58 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994019022
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:50:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-373582569edso169619207b3.2
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=muU+zEa3MJNYALn8xXqWOElORRD713Llcp74WiFN9WY=;
        b=SfPv1cgUAbM/buANqiprCgGiNsnWrnfOHq4RL0cN1i7tIknjj9leomXlYxLDSVNuYi
         KGNT6FIsAm3iDJ4vXSKRmVObWHx+JiX2ZA/IiAJO/esQO+QSgqIVK9iUM8Nlmv0seYSP
         TS3aO2Qz2gTm0tn3IVsDKHy/vTzTXQ+QRXHl/iEH3HzC5cNpLBY1MatIrtCfk1rHs6Q8
         l9sucyEqfmzlNk1up39LnceSWq85r65lR+l2wg5je/37gXF7BqycJ+IJGC9NR7jQfu/A
         hVXCCu+VJZMo4iVHw7ppwfxiDCZK+XD/m4RqQAWE378WqleTl85BJ3w/olOhHEvSu6mr
         sBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muU+zEa3MJNYALn8xXqWOElORRD713Llcp74WiFN9WY=;
        b=eaCWQt3F/6tX0JHGGimrwlIpeiGMeQmzDf8S7t/HZgQQT6GQFunwHnZNsov0ZES8zA
         x7Xb3GdOJOI8ilZXZXSK6DKq20kB7oHFP3X1JTXBf9eYw/rQ5Z1+jgA7NMziTEonv53A
         XKYTXLSBx4WoIZV7nJ0hxqlO2kb0BcJ6MGVusyYLnnumqqxNW2iVPh08ugJmcOprPcOU
         GOlUF0mtRxfWTUBxoyA+TlD8DHk6n5TbqWIl9Hiovt6M4QDMkViaAus+R0fYPBqSf27v
         1NI5uC07pzfgpUou78cwYu0zGwfRDnRnN3acA++F47nnRlFfom9i8Ooh9K7+E8Rh8MVu
         azjQ==
X-Gm-Message-State: ACrzQf0iMjHFVypTW9XRD3sJcZFelFlvcXyCvtgJImWriDdUVII0AwfL
        CvBFibsky/U5Nni+jUK+7PRGkPuqOCIK
X-Google-Smtp-Source: AMsMyM5VWH92X5x0mD0J/Z9Zva+Ay7U+TFc0wKads0Lk8BgNsaWmfFvVlDOquMCWWccuwBfIlLFJAXnT9Y8j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:6757:0:b0:6cf:f079:62f with SMTP id
 b84-20020a256757000000b006cff079062fmr37251446ybc.23.1668019841501; Wed, 09
 Nov 2022 10:50:41 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:09 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-10-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 09/14] tool lib symbol: Add Makefile/Build
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add sufficient Makefile for libsymbol to be built as a dependency and
header files installed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/symbol/Build    |   1 +
 tools/lib/symbol/Makefile | 115 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tools/lib/symbol/Build
 create mode 100644 tools/lib/symbol/Makefile

diff --git a/tools/lib/symbol/Build b/tools/lib/symbol/Build
new file mode 100644
index 000000000000..9b9a9c78d3c9
--- /dev/null
+++ b/tools/lib/symbol/Build
@@ -0,0 +1 @@
+libsymbol-y += kallsyms.o
diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
new file mode 100644
index 000000000000..4c1d6b53032d
--- /dev/null
+++ b/tools/lib/symbol/Makefile
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../scripts/Makefile.include
+include ../../scripts/utilities.mak		# QUIET_CLEAN
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+CC ?= $(CROSS_COMPILE)gcc
+AR ?= $(CROSS_COMPILE)ar
+LD ?= $(CROSS_COMPILE)ld
+
+MAKEFLAGS += --no-print-directory
+
+INSTALL = install
+
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
+LIBFILE = $(OUTPUT)libsymbol.a
+
+CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
+CFLAGS += -ggdb3 -Wall -Wextra -std=gnu11 -U_FORTIFY_SOURCE -fPIC
+
+ifeq ($(DEBUG),0)
+ifeq ($(CC_NO_CLANG), 0)
+  CFLAGS += -O3
+else
+  CFLAGS += -O6
+endif
+endif
+
+ifeq ($(DEBUG),0)
+  CFLAGS += -D_FORTIFY_SOURCE
+endif
+
+# Treat warnings as errors unless directed not to
+ifneq ($(WERROR),0)
+  CFLAGS += -Werror
+endif
+
+CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
+
+CFLAGS += -I$(srctree)/tools/lib
+CFLAGS += -I$(srctree)/tools/include
+
+RM = rm -f
+
+SYMBOL_IN := $(OUTPUT)libsymbol-in.o
+
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+
+all:
+
+export srctree OUTPUT CC LD CFLAGS V
+include $(srctree)/tools/build/Makefile.include
+include $(srctree)/tools/scripts/Makefile.include
+
+all: fixdep $(LIBFILE)
+
+$(SYMBOL_IN): FORCE
+	$(MAKE) $(build)=libsymbol V=1
+
+$(LIBFILE): $(SYMBOL_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(SYMBOL_IN)
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: $(LIBFILE)
+	$(call QUIET_INSTALL, $(LIBFILE)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,kallsyms.h,$(prefix)/include/symbol,644);
+
+install: install_lib install_headers
+
+clean:
+	$(call QUIET_CLEAN, libsymbol) $(RM) $(LIBFILE); \
+	find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
+
+FORCE:
+
+.PHONY: clean FORCE
-- 
2.38.1.431.g37b22c650d-goog

