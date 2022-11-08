Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD0620A3D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiKHHfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiKHHfi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:35:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C9224F34
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:35:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36b1a68bfa6so130578257b3.22
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWTS1f0segyhlSbmQWDTAnD8D0Og1YhYgrPvc18rTU=;
        b=EmO+WsH8dN6GDO6/5h7GCdX/Cnv9NhRf6EYSqpe4AqmNS2cH2SGTPbKtl6G7yQjMAz
         CwnXS6hLmcL64RHhKL4RTxmTGjPO+Kkvjgsj+uoBkr1/5rDfcdZtlSB+/eq0kuXDIaWc
         dCfNfHNVqf5PoEK+/GtMHiSjIPbLSPIE/PWCKmc2ikni/UHY4xXbhZR6in0lwhf3LVi3
         3ovYrwdURdQKrKJtYn0r7TO6abLkNaf9kll6D0w5PKsLerjX9mioksy5T102jb4GTJ0b
         UcNeWv0Nn7M91jk4hEFODz2prIJIrQoZvPF9JB83knRIcNQX0tDHnH8VEcYnrWmOfx4Z
         Ohtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWTS1f0segyhlSbmQWDTAnD8D0Og1YhYgrPvc18rTU=;
        b=gOWXAgkw4JrEMggbaQjSe8zNuKJWMjGc+cIlKxCmoHwn2nn0zJ46K6k9/B0Sz+CqdP
         IcyC4rssouqFL/0banBI5NyVRDIEiPsOamTrhVNhQAVFGfZXRIR4MdTiaTfG08v0L86e
         XE0hgVf7Uw1J5Rh++SQjAYVPE5+S7aNBhRiu+4XH2gMCEui+QRapuKsg2xm4DMLcr6uo
         zzqRyFF43FWCWg4M9CbPFeLAlwLQWOd9gR8Iq7CQufZbZNkXwStiduHkYCtkaH7XtqSp
         DwXmC1Z2hyD3fMu83Ca6h+DNOZ/HNcXxFiK9iNMJf5m60Fs/7T1z/C64iJASXcKOLJYX
         ++dg==
X-Gm-Message-State: ACrzQf0WhSHJgDDb92DulLBJq/tBOqIkTNkXm1aYU/IryJ4HACMVkG2u
        KzqgzPprpZ9tTBc70P1w687o6gxtbcjn
X-Google-Smtp-Source: AMsMyM7LnZu/wFQy9EA+L0NQtPfNNkmgSpLUuGqf9WDzu0ltDYcO5eusfEvGywPc5TooCw2k5ktF6/93eYEA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a5b:792:0:b0:6bd:2b3:a4de with SMTP id
 b18-20020a5b0792000000b006bd02b3a4demr879898ybq.123.1667892937391; Mon, 07
 Nov 2022 23:35:37 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:05 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-2-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 01/14] tools lib api: Add install target
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

This allows libapi to be installed as a dependency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index e21e1b40b525..6629d0fd0130 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -15,6 +15,16 @@ LD ?= $(CROSS_COMPILE)ld
 
 MAKEFLAGS += --no-print-directory
 
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
 LIBFILE = $(OUTPUT)libapi.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
@@ -45,10 +55,23 @@ RM = rm -f
 
 API_IN := $(OUTPUT)libapi-in.o
 
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
 all:
 
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
+include $(srctree)/tools/scripts/Makefile.include
 
 all: fixdep $(LIBFILE)
 
@@ -58,6 +81,32 @@ $(API_IN): FORCE
 $(LIBFILE): $(API_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(API_IN)
 
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
+		$(call do_install,cpu.h,$(prefix)/include/api,644); \
+		$(call do_install,debug.h,$(prefix)/include/api,644); \
+		$(call do_install,io.h,$(prefix)/include/api,644);
+
+install: install_lib install_headers
+
 clean:
 	$(call QUIET_CLEAN, libapi) $(RM) $(LIBFILE); \
 	find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
-- 
2.38.1.431.g37b22c650d-goog

