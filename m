Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C252E2AB62D
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 12:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgKILKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 06:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKILKd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:33 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2DC0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Nov 2020 03:10:33 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id o20so8291369eds.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2020 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2Cfn+qf6dsBYRmwxFqKcDe9TIG0CW1IWpnyFZWW40U=;
        b=hncWSr8JjQJMv9mJOaj63v3xtItKykUmLbKxu68NLYLCb+LH6JF2NhL6WFKtUsXKry
         VLo8DxUY00CCVbOZ1927avwa1yM4KtZlIy4YBMnTSjD0veGXAvezK7t5fkcoUBp0P1Gj
         xgCEgOjGCYZR88K8gd6tFc19a38aObX3Wz3WcdT4geKBNHF69YemSgqWNfAoYDLublIK
         kIUZTToYoMbOTEJF/Go5H3sEdVEpFJ+5aAdNKUWU0cVz5zrthvkQ0zMod4dXK8sKECB2
         Nsk36jsgtjVSsCClWEv5en3PP/A6ZglwILEQ094or2v+e+Cd4WBZ1DNfipk6W+BoD5LU
         NR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2Cfn+qf6dsBYRmwxFqKcDe9TIG0CW1IWpnyFZWW40U=;
        b=Nvx7ir9oii6z/kJi7FDhUKKEGbx0bqs2qs8Sp8+KAF5etYtGcTTrdjT9Wjkn32pbHF
         TDbTZ3Hv2QO15W+ojLGYwHr7iSyPiJwohGW6aEKfeFBJnmdYcfMz1vGD4seQ4y2NdSRG
         pG4vi2sRzv4DAFlVmEFc9A13AGf+hGqgMJqKASiqcMHgc/IZXCBb5Rvy3vQc/BnMxKj5
         AW6AWXjd50k6ExKCkrXXTh9j/LAjBPD1Ncd9P2si1588zTiU+UuOw6ZN8avaeER+Y54d
         jxatdSv1ccWChbDRNXQbeEyZzrJXZBaA8H/2RCWGrG4sAITr3kjeNsXxJfOtXDGkQ3EX
         qplg==
X-Gm-Message-State: AOAM533UC0K7CNsm7RkYvqlGLYvFEl3QxqHADHTFbemmdREbYXP1xqf4
        iw5sKBb8Q1h7YF0ZNUVgPSTPgA==
X-Google-Smtp-Source: ABdhPJzpz+j4UyTF2DMQI8w1doJFCKwzCUumt21o7Ypa/kmYBoTww8uqx19c0rpOEfAy5/rpnZrPGA==
X-Received: by 2002:a05:6402:16d6:: with SMTP id r22mr15325414edx.246.1604920232260;
        Mon, 09 Nov 2020 03:10:32 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s21sm8768064edc.42.2020.11.09.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:10:31 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH bpf-next v2 1/6] tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
Date:   Mon,  9 Nov 2020 12:09:25 +0100
Message-Id: <20201109110929.1223538-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109110929.1223538-1-jean-philippe@linaro.org>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Several Makefiles in tools/ need to define the host toolchain variables.
Move their definition to tools/scripts/Makefile.include

Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1: https://lore.kernel.org/bpf/20200827153629.3820891-2-jean-philippe@linaro.org/

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Erik Kaneda <erik.kaneda@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: devel@acpica.org
---
 tools/bpf/resolve_btfids/Makefile |  9 ---------
 tools/build/Makefile              |  4 ----
 tools/objtool/Makefile            |  9 ---------
 tools/perf/Makefile.perf          |  4 ----
 tools/power/acpi/Makefile.config  |  1 -
 tools/scripts/Makefile.include    | 10 ++++++++++
 6 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 66cb92136de4..bf656432ad73 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -18,15 +18,6 @@ else
 endif
 
 # always use the host compiler
-ifneq ($(LLVM),)
-HOSTAR  ?= llvm-ar
-HOSTCC  ?= clang
-HOSTLD  ?= ld.lld
-else
-HOSTAR  ?= ar
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-endif
 AR       = $(HOSTAR)
 CC       = $(HOSTCC)
 LD       = $(HOSTLD)
diff --git a/tools/build/Makefile b/tools/build/Makefile
index 722f1700d96a..bae48e6fa995 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -15,10 +15,6 @@ endef
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
 $(call allow-override,LD,$(CROSS_COMPILE)ld)
 
-HOSTCC ?= gcc
-HOSTLD ?= ld
-HOSTAR ?= ar
-
 export HOSTCC HOSTLD HOSTAR
 
 ifeq ($(V),1)
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 4ea9a833dde7..5cdb19036d7f 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -3,15 +3,6 @@ include ../scripts/Makefile.include
 include ../scripts/Makefile.arch
 
 # always use the host compiler
-ifneq ($(LLVM),)
-HOSTAR	?= llvm-ar
-HOSTCC	?= clang
-HOSTLD	?= ld.lld
-else
-HOSTAR	?= ar
-HOSTCC	?= gcc
-HOSTLD	?= ld
-endif
 AR	 = $(HOSTAR)
 CC	 = $(HOSTCC)
 LD	 = $(HOSTLD)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ce3f2e8b9c7..62f3deb1d3a8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -175,10 +175,6 @@ endef
 
 LD += $(EXTRA_LDFLAGS)
 
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-HOSTAR  ?= ar
-
 PKG_CONFIG = $(CROSS_COMPILE)pkg-config
 LLVM_CONFIG ?= llvm-config
 
diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index 54a2857c2510..331f6d30f472 100644
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -54,7 +54,6 @@ INSTALL_SCRIPT = ${INSTALL_PROGRAM}
 CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
 CROSS_COMPILE ?= $(CROSS)
 LD = $(CC)
-HOSTCC = gcc
 
 # check if compiler option is supported
 cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2>&1; then echo "$(1)"; fi;}
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index a7974638561c..1358e89cdf7d 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -59,6 +59,16 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
 $(call allow-override,CXX,$(CROSS_COMPILE)g++)
 $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
 
+ifneq ($(LLVM),)
+HOSTAR  ?= llvm-ar
+HOSTCC  ?= clang
+HOSTLD  ?= ld.lld
+else
+HOSTAR  ?= ar
+HOSTCC  ?= gcc
+HOSTLD  ?= ld
+endif
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 endif
-- 
2.29.1

