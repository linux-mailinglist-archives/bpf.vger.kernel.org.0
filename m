Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D16620A4E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiKHHhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiKHHgv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:51 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E6232BBE
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:36:42 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p18-20020a63e652000000b0046b27534651so7556770pgj.17
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=muU+zEa3MJNYALn8xXqWOElORRD713Llcp74WiFN9WY=;
        b=s92/M/iZnB81De9qQ/B8+ANBxDA6WVzJALt2qoWR4RIT83TBf13yHEF85BYlgiusVz
         G4NmPsuDzNQh9XYIIZgz6RwzJyhghjdBDLl/ftSV+vdDNqvbBquyRzkve5rg1YDT4WYp
         z/4+zAXpC1i9uGUP2mDcZfWxNvYvVLE8HGlRgSwFLNwKQEP/INDhHeHEf/lL+knSj/4R
         +94JahGlY3OYRawNbAAi/b1k6PihXr/Ro0PXMRXRfOBQtJzOJnQnNl7pYwd8iDqLnxP0
         xnp7z9gU1eq2u7UQqlfe51MNNnfG9juYdZkvC+YQIKvDpOJSGeadD70SoNAzDKRo9QoS
         uBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muU+zEa3MJNYALn8xXqWOElORRD713Llcp74WiFN9WY=;
        b=nm9T3YraF3bkgL+IDuJH2P3i0OrdN/aXALdJii10Qx0WxiE6Ie3C5+r9cVS6kuvZqg
         w3TjvwO2oRS4+/6e1V6dnvAu8tFYfew+w/iDL36lL1RuHS1pNcKUf/NHM6rwGp2XACia
         pVkJzrNnuATLuOkEIccWj4eKwxjaUn4/u9Y3pPfdA0Uk+68w3v/8y5rNc2fPd3xBUekx
         wnXoU2L2DgU91aoI9CAbKuHFJfhKmEF0pUO42gatDsT/ivHkZEfr3Cj9ieCIH6jd7Z88
         DHja6TB5iTeKQcVnapv33+qNU2ycwDEf6OE8JpQQ9qYFkXzhKfDCcXxu2AVpG3mWdFqR
         miVg==
X-Gm-Message-State: ACrzQf0dphwA9ApZLohl/3Q3TgvYC7s9sqkYDD2UjiOr2yG7/N8/0lm6
        MlrfFUpLYhC8k9ow9MJVKYbeDettTl4g
X-Google-Smtp-Source: AMsMyM6DEXsHR5Y8UnkemxuTdxdfyDjoHKiExtvL0O/OzgpbztTpntvxJIoSEBU/gsF9Q8Bih0Mq6L9SX3Q3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a17:902:e40c:b0:186:5bbc:2ad9 with SMTP id
 m12-20020a170902e40c00b001865bbc2ad9mr952636ple.157.1667893002263; Mon, 07
 Nov 2022 23:36:42 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:13 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-10-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 09/14] tool lib symbol: Add Makefile/Build
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

