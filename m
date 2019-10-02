Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC2BC902B
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfJBRqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 13:46:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44306 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfJBRqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 13:46:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id r16so16021977edq.11
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZzjEbxaLFF1tUuJ1VMjmL8gObXUEiWGpMSquU9Ax2E=;
        b=Z+FbIHwlu/DoLjLAX0nBIgP/HtZhGA9qeFHDoEkuDPWG2I2ZKIMfaw7I88fyWh7Pkb
         CPG3RTw8QDO2O7/0Ua2wr1A4YZnwItDoqWXfu7S0qcEkJzrF8CkY8hh6tK41a4upSDjF
         KmNDOAgEpnMWxSUeLzLAveyFDIZeoBUONmX80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZzjEbxaLFF1tUuJ1VMjmL8gObXUEiWGpMSquU9Ax2E=;
        b=s6lnyQeUohOYwrgxhrEKTS66F9RCyoh3z54u9pBL5vUa3etiMX8DzpDKCHTrWGBog6
         TJRe2R+zqZsKS8KeOojLKyU9hHPWRKsFE/lepOKFIFWBFQ62wnNgc+O4+7xBBuK619Jk
         BrM++a0aACglH3SCsxgJij8+vFYg4KpSW9iJ1jNapjOm0aQv/VgFdQCDUfIlzVkXrgQj
         FCWEqvl0hkLZhRWqRyNlhPAOwYUgrRtaKwREJtd0V7ihJ4ib4A9eOmyany2UJpvXjXvW
         UZ3QSJISpWRRGv7rfn0exRClsDTnTmRElBODxs3QyY3hz+/2wizdJyhmsZqLJruTxSZ+
         BTwg==
X-Gm-Message-State: APjAAAV6BaTABg8Wum+cb0X4/z0LFsZ5iFpMa6CWgzhJYMESKRBqChkY
        aHP87rbxI3uX1/OlTpG7iRcdvA==
X-Google-Smtp-Source: APXvYqxPacqa+6X/8OT1eDR/vEf0bUWxvUoMQjqgzvUGa08sM87WYvd49c5hrffKeb2gY3rveOA7Vg==
X-Received: by 2002:a17:906:b804:: with SMTP id dv4mr4032576ejb.243.1570038406376;
        Wed, 02 Oct 2019 10:46:46 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id j8sm3931874edy.44.2019.10.02.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:46:45 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] samples/bpf: Fix broken samples.
Date:   Wed,  2 Oct 2019 19:46:32 +0200
Message-Id: <20191002174632.28610-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Rename asm_goto_workaround.h to asm_workaround.h and add a
workaround for the newly added "asm_inline" in:

  commit eb111869301e ("compiler-types.h: add asm_inline definition")

Add missing include for <linux/perf_event.h> which was removed from
perf-sys.h in:

  commit 91854f9a077e ("perf tools: Move everything related to
	               sys_perf_event_open() to perf-sys.h")

Co-developed-by: Florent Revest <revest@google.com>
Signed-off-by: Florent Revest <revest@google.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 samples/bpf/Makefile                            |  2 +-
 .../{asm_goto_workaround.h => asm_workaround.h} | 17 ++++++++++++++---
 samples/bpf/task_fd_query_user.c                |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)
 rename samples/bpf/{asm_goto_workaround.h => asm_workaround.h} (46%)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 42b571cde177..ab2b4d7ecb4b 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -289,7 +289,7 @@ $(obj)/%.o: $(src)/%.c
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
 		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
-		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
+		-I$(srctree)/samples/bpf/ -include asm_workaround.h \
 		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
 ifeq ($(DWARF2BTF),y)
 	$(BTF_PAHOLE) -J $@
diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_workaround.h
similarity index 46%
rename from samples/bpf/asm_goto_workaround.h
rename to samples/bpf/asm_workaround.h
index 7409722727ca..7c99ea6ae98c 100644
--- a/samples/bpf/asm_goto_workaround.h
+++ b/samples/bpf/asm_workaround.h
@@ -1,9 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2019 Facebook */
-#ifndef __ASM_GOTO_WORKAROUND_H
-#define __ASM_GOTO_WORKAROUND_H
+#ifndef __ASM_WORKAROUND_H
+#define __ASM_WORKAROUND_H
 
-/* this will bring in asm_volatile_goto macro definition
+/*
+ * This will bring in asm_volatile_goto and asm_inline macro definitions
  * if enabled by compiler and config options.
  */
 #include <linux/types.h>
@@ -13,5 +14,15 @@
 #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
 #endif
 
+/*
+ * asm_inline is defined as asm __inline in "include/linux/compiler_types.h"
+ * if supported by the kernel's CC (i.e CONFIG_CC_HAS_ASM_INLINE) which is not
+ * supported by CLANG.
+ */
+#ifdef asm_inline
+#undef asm_inline
+#define asm_inline asm
+#endif
+
 #define volatile(x...) volatile("")
 #endif
diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index e39938058223..4c31b305e6ef 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -13,6 +13,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <linux/perf_event.h>
 
 #include "libbpf.h"
 #include "bpf_load.h"
-- 
2.20.1

