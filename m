Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBD254997
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgH0PiJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgH0PiI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 11:38:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9625C061232
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so8251896eje.7
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFxVwUfpG0o5V6jeiag7wunJy3oc0V523MxaV/EfYOE=;
        b=Rj9btxGKFSBBPU2CIN2lx7OyG9Tdl8pOH+jm5tgq1Lclt3kaXTWDDOYV7u8wwG//Ii
         rMvSFIljHCUicLonsC4NhUez3RRAgjjqfYY2e5jApfbBKhmC09LeSkqxYSUUV5zqgZN8
         xywT38iEaCdwuNNWkxE5E1qh2A73wONit/WVOP1v2MwP/K/N57F0TVhxyc/RwlUwffQc
         u2u3qBWddHDwZR0w1tzqx3aUajUp0nyl9OuVUi6fGYRN6XR4rJXsStLnb+I2hGLodiYt
         kYAz2dT1hiSAw0ruT1kb0aQBfydhP/Xf5aPav8lsJ8Jz1ks5NCUkK8XUmP/grrrEjsB1
         28TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFxVwUfpG0o5V6jeiag7wunJy3oc0V523MxaV/EfYOE=;
        b=mN65byVz2EvjMOqtUbxFrAjhqKtectRdRVm7WTWI2R354DoE757yJ3Wqe7N0hP7FXZ
         Wxq2gQ/CmRMrszFgEQQ3rMGIqqNxrmmUhHox3uVVcK5Lm7XVQ59FgRcDZSDoqFNNoufm
         3HHGFYb2yzzi/YePaQgxq9pEC81DeT+4R20hfyW9NMfLXl6zxsAhMz2rE/5VpIjhANPF
         TpdCSFgLhU/W3I8xn3Gk81I2uvquqhydpVkrqTm4VZfVH0K1VWPTNlVywhzPg7VwcI36
         GGnpDVSnuZ6zwoUeSivIdrVTHSs8caeTrMzC9HTTWpgrwdWNYQd9iCC9VzH+1Ef7Tvwy
         Z81A==
X-Gm-Message-State: AOAM530hjKqmtCRL9Oqs8wSVopw4+xw/0o8wRMVF+y8p4xUjeJ1fXoKo
        Xxpmx4SyIDc1aN6F9q56QgSG0g==
X-Google-Smtp-Source: ABdhPJwbwjM3xQlm1zDhqVxSdglPW9h9226wfJ4MdZid73oHm7PKBm6ZJ9d0YXH7dByEvZNvCLQVFw==
X-Received: by 2002:a17:906:a89a:: with SMTP id ha26mr18614188ejb.391.1598542686220;
        Thu, 27 Aug 2020 08:38:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm1765616edt.1.2020.08.27.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:38:05 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH bpf-next 1/6] tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
Date:   Thu, 27 Aug 2020 17:36:25 +0200
Message-Id: <20200827153629.3820891-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827153629.3820891-1-jean-philippe@linaro.org>
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Several Makefiles in tools/ need to define the host toolchain variables.
Move their definition to tools/scripts/Makefile.include

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
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
index a88cd4426398..b06935578a96 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,15 +17,6 @@ else
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
index 727050c40f09..8a55378e8b7c 100644
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
index 7770edcda3a0..b7cb4f26ccde 100644
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
index 6031167939ae..43e90334a54e 100644
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
2.28.0

