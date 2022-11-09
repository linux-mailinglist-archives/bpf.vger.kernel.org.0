Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB26232E9
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKIStg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiKIStf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831113F6D
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:49:34 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id k9-20020a17090a39c900b0021671e97a25so1604591pjf.1
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWTS1f0segyhlSbmQWDTAnD8D0Og1YhYgrPvc18rTU=;
        b=h8+HoLUbYhCjId0Y+B244sJvGF1KwrxdyFZTx69OSLbRfEnws6kzRpSaCdTIRDjYnp
         4Piy3y3cJ7wY6F4MjoLW/ZrCko/VItNGisyhAiDlUOLT6Loa+OB7OMvNK9kP6TthCM4+
         81YfXJYk7kVGXTg/7LoouhUv0QE89yJpr3qltAyaS9g2UORODNXSwHeaBLJD6KwtXbHj
         7VEBC7nKz4YtZ4+Dai53TP4wIm937JBC0Hbt0aX56Ivx4y1O/N0s5HAk84haphososiM
         qW8Q7Qj7rkQM7veSWJ/SBAMl+aq+9hLOofy3340Ga92XUKXsL+EXRoDfTTJ99cgyyti3
         ZBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWTS1f0segyhlSbmQWDTAnD8D0Og1YhYgrPvc18rTU=;
        b=t9udLiv9vFCkF5mKfkwwUI0DyfZfwCM8r/hNG+651yQtsTLZ1TX2MSaDLLGas0Mxep
         91nj8HU1ALPlZfFe+Nssy4uk1Ez24L9w42UI6RK6lHdfuApG6/8BOrvgeA79uJknBFDN
         sxlMcEylwRwyPLE/JGQNwZ0MvB/Q7JZWtQOl55W8C7LdKIanw/KGawuw20tE3WWgxcJK
         0WGm5yfBxSsnf38Zyq94Yxa4GmvDGAX2X2xYsFJKLl2CJoSv0dHxtRvhcgVPeI2XUjcH
         aYIGQbUOPLvjM1ekcS3e+/jASgmA5Rr155G/fBwZ8bJNJ+/pzRo/A+RRo5ZacxFK3SZD
         9UcQ==
X-Gm-Message-State: ACrzQf2pCowTHGelgKaYVrP+pQubD0VkXXwZe58qTsQ4efSHmokz677W
        3hHijYcfPXR1VEkyfmdVqHQagQL9gYYx
X-Google-Smtp-Source: AMsMyM5xbUA/rskJrvjee/Gig9EwkjMLwfHK7DAHXLoRP2Wt7Pd/WfJSt74tu+vCa0w33TdxjKA8n5JVmqVt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a17:902:9692:b0:186:6180:fb89 with SMTP id
 n18-20020a170902969200b001866180fb89mr1199782plp.142.1668019774263; Wed, 09
 Nov 2022 10:49:34 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:01 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-2-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 01/14] tools lib api: Add install target
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

