Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6885FA355A
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfH3LA4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 07:00:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39249 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfH3LA4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 07:00:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id n2so5616630wmk.4
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2019 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KL1UUCGXI64uWslAiK52D0uTNplrjm12P0PBpcTxduQ=;
        b=A5JOyQXUmrXOa9XrpuUkzBZHbsCqNyTN/N28VZhycpC5dwkz0wlr6BHHXNaPBrXFkt
         XyOxjlyA5eJ65Os4+1TTKWk4jq2K6e4R0jgTELGMZYLr7OcnNZyBNFxggRtvN4L3qw8C
         B0hhwFunCAxYwinBobKRXJhAxir3URiOPlC9Ij4Agijbj3c1Wd2Al2t3vMHI6a/r0p8e
         kEyKjQvH3RrKC/ZQoIlxyx0ie0p/EIYp3Vco6m1loNchMVeQXTKZJnchp3plHznp6C6E
         9LFAyYsSh9ukkR5I+hSjJiTjxLbApCdRny9CL04hQXlgdcfkBrnlXL9eIWZHtolpH453
         zV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KL1UUCGXI64uWslAiK52D0uTNplrjm12P0PBpcTxduQ=;
        b=mdgNeCGinUWH6n20Ghd1//0ufT1UYPM6cYA1zbWGAUCIsIeGIyjXYCfJWcAH4pzBRj
         mGP85JQJg4FT8Cvx5xBRjO4jbMpa+R2IV4s82/1HV+XiABPkfWAIImUXyzY6th2Hv88U
         65nk5+YMPQVKSlvYA1jwvA3qlabzxJ5CPD68N07WkegAtK0qSKUmY6moUYX+MBFV/ix2
         cwS87gjIMJAs/wAmtgsjDzEE2LaJd+W3mcXVqZj7M46EYjpdbXxuJSl2m8To+7zfjG9o
         /gc1h+kGnfa3/SQ2EdGzC72kZHee+EPiIDkTPsddeoCXPz+8BWjwgesGiL1PC7SOuvg5
         KHuw==
X-Gm-Message-State: APjAAAUfX53rxe6Sc407YPWa3VnRQTsWXnmpbsS1xsdl7Td7tRo4rptQ
        ZOaLT3A4K5wCOBcPSo1xuNcUAA==
X-Google-Smtp-Source: APXvYqybUDqMj3+qDn7pN1ui2OC5ROaGKJF4ajASppOEZEpghSkKJXV4Lm7d5GrhOc6jiRK2Qd9JYg==
X-Received: by 2002:a7b:c758:: with SMTP id w24mr7177541wmk.143.1567162854234;
        Fri, 30 Aug 2019 04:00:54 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t198sm7848083wmt.39.2019.08.30.04.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 04:00:53 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next v2 3/4] tools: bpf: account for generated feature/ and libbpf/ directories
Date:   Fri, 30 Aug 2019 12:00:39 +0100
Message-Id: <20190830110040.31257-4-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830110040.31257-1-quentin.monnet@netronome.com>
References: <20190830110040.31257-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When building "tools/bpf" from the top of the Linux repository, the
build system passes a value for the $(OUTPUT) Makefile variable to
tools/bpf/Makefile and tools/bpf/bpftool/Makefile, which results in
generating "libbpf/" (for bpftool) and "feature/" (bpf and bpftool)
directories inside the tree.

This commit adds such directories to the relevant .gitignore files, and
edits the Makefiles to ensure they are removed on "make clean". The use
of "rm" is also made consistent throughout those Makefiles (relies on
the $(RM) variable, use "--" to prevent interpreting
$(OUTPUT)/$(DESTDIR) as options.

v2:
- New patch.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/bpf/.gitignore         |  1 +
 tools/bpf/Makefile           |  5 +++--
 tools/bpf/bpftool/.gitignore |  2 ++
 tools/bpf/bpftool/Makefile   | 10 ++++++----
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/.gitignore b/tools/bpf/.gitignore
index dfe2bd5a4b95..59024197e71d 100644
--- a/tools/bpf/.gitignore
+++ b/tools/bpf/.gitignore
@@ -1,4 +1,5 @@
 FEATURE-DUMP.bpf
+feature
 bpf_asm
 bpf_dbg
 bpf_exp.yacc.*
diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 53b60ad452f5..fbf5e4a0cb9c 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -81,10 +81,11 @@ $(OUTPUT)bpf_exp.lex.o: $(OUTPUT)bpf_exp.lex.c
 
 clean: bpftool_clean
 	$(call QUIET_CLEAN, bpf-progs)
-	$(Q)rm -rf $(OUTPUT)*.o $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg \
+	$(Q)$(RM) -r -- $(OUTPUT)*.o $(OUTPUT)bpf_jit_disasm $(OUTPUT)bpf_dbg \
 	       $(OUTPUT)bpf_asm $(OUTPUT)bpf_exp.yacc.* $(OUTPUT)bpf_exp.lex.*
 	$(call QUIET_CLEAN, core-gen)
-	$(Q)rm -f $(OUTPUT)FEATURE-DUMP.bpf
+	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpf
+	$(Q)$(RM) -r -- $(OUTPUT)feature
 
 install: $(PROGS) bpftool_install
 	$(call QUIET_INSTALL, bpf_jit_disasm)
diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index 8248b8dd89d4..b13926432b84 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -3,3 +3,5 @@
 bpftool*.8
 bpf-helpers.*
 FEATURE-DUMP.bpftool
+feature
+libbpf
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 3fc82ff9b52c..b0c5a369f54a 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -124,9 +124,11 @@ $(OUTPUT)%.o: %.c
 
 clean: $(LIBBPF)-clean
 	$(call QUIET_CLEAN, bpftool)
-	$(Q)$(RM) $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
+	$(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
+	$(Q)$(RM) -r -- $(OUTPUT)libbpf/
 	$(call QUIET_CLEAN, core-gen)
-	$(Q)$(RM) $(OUTPUT)FEATURE-DUMP.bpftool
+	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
+	$(Q)$(RM) -r -- $(OUTPUT)feature/
 
 install: $(OUTPUT)bpftool
 	$(call QUIET_INSTALL, bpftool)
@@ -137,8 +139,8 @@ install: $(OUTPUT)bpftool
 
 uninstall:
 	$(call QUIET_UNINST, bpftool)
-	$(Q)$(RM) $(DESTDIR)$(prefix)/sbin/bpftool
-	$(Q)$(RM) $(DESTDIR)$(bash_compdir)/bpftool
+	$(Q)$(RM) -- $(DESTDIR)$(prefix)/sbin/bpftool
+	$(Q)$(RM) -- $(DESTDIR)$(bash_compdir)/bpftool
 
 doc:
 	$(call descend,Documentation)
-- 
2.17.1

