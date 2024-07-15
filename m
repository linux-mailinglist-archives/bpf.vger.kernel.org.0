Return-Path: <bpf+bounces-34847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C947F931BEC
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C51F22B9E
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC113D8AC;
	Mon, 15 Jul 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/eEr5YL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177713CF9C
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075633; cv=none; b=kIF8BYz/yRzGK5yBfVZM9Yh4USwdNzAsgKrFC3q7B9LzK1mjtVPtPlz7T4lZJslDKgCgJFMROyyc9+5Ptve57JlNcns+3YEPccCzTYCkfLhBwxP74K8vlNnpURXTUWfSy0+tLSz4Xcr/YkU7cPOCTC19FIn3k5pYXvILe/IzX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075633; c=relaxed/simple;
	bh=JEI8gAdqk4mZuCAVVRn/25JMk4drGzzZ8zKmP1BSQgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZMOa5Jx/SSkKpH48fnA+OdAUPjTkrYlLKtZxNComF8xYbKVzM154lfAs41EYuIt+1A9/5/ri/WOUwfTWmkj3KMJ0dN05hV7WIYZoL81yRHjRTyJzbbf+ppEnQRixj5F/mfqP8C9QYnHD+McnBtifvWUorbWA/LsgZ9ZwnFCDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/eEr5YL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fbc09ef46aso33487465ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721075631; x=1721680431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QagJQ5EBNzZIM/flu3JEUsij3j0Y4FzDew5rj+TiVcg=;
        b=H/eEr5YLgBH3MkNioPcLO9CSdVqbUWfFfg88U3sb3t3l3DBdMOpxVq1iPe/Qb2hnmR
         3thSX8MH1dLnr0UZtZ7NAFDmqhJZIwI2uSY/2+z7NtJQBAzPflx6HyUjYtWrazWerB8L
         /NP5zEDCYcC0iOzzWi9HChZTJolESWTuiNDrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721075631; x=1721680431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QagJQ5EBNzZIM/flu3JEUsij3j0Y4FzDew5rj+TiVcg=;
        b=ZXwi91/ldFuzx2Xd36KWX3yJTgob0t/i1BxhOCQbm7pKKacr1k5w/6ZzLoLBs8eTKE
         LiTv1W53lzr2X6/Lz4d6CXGrA7Wq5e/ATq5WOPJAE2N5SQExNKMhw3YAo3UkKxlfPopb
         IWZotkSvK0cNsLtRuaQ7QtgU6pe03Vq5lhMrfq5n6WZPukt2f5bGwVdIJHIVz7mjRmY6
         hvVKL+wGoiyraG50t5UZruPcM605XtdzSKlDlGD9n3GoymZQeqdAQeD4QOigu4eBmH9K
         blCqyAm3H6z8deoNDU8UAK+y2/r7t/SublrEBfo9SkZNujkriszH20tZtbLrUBV2nGFV
         NgSA==
X-Forwarded-Encrypted: i=1; AJvYcCVfMsXMeHnXcf3Dw0p8lPv/cs+RSTY8Sk52GeVbnfn5Z8O9K+TTmAOW+POj21atUzZxKhZCEDExvhj7643o2WTOjvIx
X-Gm-Message-State: AOJu0YzldgjoLN2vtlHRbFFEid2/rmB0h52fy9Ff+htGoQ64bduH8QeC
	Z3P22nOWsDvim6IXwoOByID2nHez+84MABUaBan9SZUDYGi2U5zoxr/8ctBSV5KUPFS+DsUdSzo
	=
X-Google-Smtp-Source: AGHT+IFfCLt2+h56owcmhJH7aR25w4v2Rcxjnnajy6sxLj46dbJoAc0mzb1xFU/8SNiSiIhVjg88rQ==
X-Received: by 2002:a17:903:27d0:b0:1fb:8419:8377 with SMTP id d9443c01a7336-1fbb6d67625mr101200875ad.61.1721075631327;
        Mon, 15 Jul 2024 13:33:51 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:9b77:1ea5:9de2:19a3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fc0bc2712csm45258775ad.176.2024.07.15.13.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 13:33:51 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v4 3/3] tools build: Correct bpf fixdep dependencies
Date: Mon, 15 Jul 2024 13:32:44 -0700
Message-ID: <20240715203325.3832977-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240715203325.3832977-1-briannorris@chromium.org>
References: <20240715203325.3832977-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dependencies in tools/lib/bpf/Makefile are incorrect. Before we
recurse to build $(BPF_IN_STATIC), we need to build its 'fixdep'
executable.

I can't use the usual shortcut from Makefile.include:

  <target>: <sources> fixdep

because its 'fixdep' target relies on $(OUTPUT), and $(OUTPUT) differs
in the parent 'make' versus the child 'make' -- so I imitate it via
open-coding.

I tweak a few $(MAKE) invocations while I'm at it, because
1. I'm adding a new recursive make; and
2. these recursive 'make's print spurious lines about files that are "up
   to date" (which isn't normally a feature in Kbuild subtargets) or
   "jobserver not available" (see [1])

I also need to tweak the assignment of the OUTPUT variable, so that
relative path builds work. For example, for 'make tools/lib/bpf', OUTPUT
is unset, and is usually treated as "cwd" -- but recursive make will
change cwd and so OUTPUT has a new meaning. For consistency, I ensure
OUTPUT is always an absolute path.

And $(Q) gets a backup definition in tools/build/Makefile.include,
because Makefile.include is sometimes included without
tools/build/Makefile, so the "quiet command" stuff doesn't actually work
consistently without it.

After this change, top-level builds result in an empty grep result from:

  $ grep 'cannot find fixdep' $(find tools/ -name '*.cmd')

[1] https://www.gnu.org/software/make/manual/html_node/MAKE-Variable.html
If we're not using $(MAKE) directly, then we need to use more '+'.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---

Changes in v4:
 - update tools/lib/bpf/.gitignore to exclude 'fixdep'
 - update tools/lib/bpf `make clean` target for fixdep
 - combine $(SHARED_OBJDIR) and $(STATIC_OBJDIR) rules

Changes in v3:
 - add Jiri's Acked-by

Changes in v2:
 - also fix libbpf shared library rules
 - ensure OUTPUT is always set, and always an absolute path
 - add backup $(Q) definition in tools/build/Makefile.include

 tools/build/Makefile.include | 12 +++++++++++-
 tools/lib/bpf/.gitignore     |  1 +
 tools/lib/bpf/Makefile       | 13 ++++++++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
index 8dadaa0fbb43..0e4de83400ac 100644
--- a/tools/build/Makefile.include
+++ b/tools/build/Makefile.include
@@ -1,8 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
+# More than just $(Q), we sometimes want to suppress all command output from a
+# recursive make -- even the 'up to date' printout.
+ifeq ($(V),1)
+  Q ?=
+  SILENT_MAKE = +$(Q)$(MAKE)
+else
+  Q ?= @
+  SILENT_MAKE = +$(Q)$(MAKE) --silent
+endif
+
 fixdep:
-	$(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
 
 fixdep-clean:
 	$(Q)$(MAKE) -C $(srctree)/tools/build clean
diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
index 0da84cb9e66d..f02725b123b3 100644
--- a/tools/lib/bpf/.gitignore
+++ b/tools/lib/bpf/.gitignore
@@ -5,3 +5,4 @@ TAGS
 tags
 cscope.*
 /bpf_helper_defs.h
+fixdep
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 2cf892774346..1b22f0f37288 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -108,6 +108,8 @@ MAKEOVERRIDES=
 
 all:
 
+OUTPUT ?= ./
+OUTPUT := $(abspath $(OUTPUT))/
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
@@ -141,7 +143,10 @@ all: fixdep
 
 all_cmd: $(CMD_TARGETS) check
 
-$(BPF_IN_SHARED): force $(BPF_GENERATED)
+$(SHARED_OBJDIR) $(STATIC_OBJDIR):
+	$(Q)mkdir -p $@
+
+$(BPF_IN_SHARED): force $(BPF_GENERATED) | $(SHARED_OBJDIR)
 	@(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
 	(diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
@@ -151,9 +156,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
 	@(test -f ../../include/uapi/linux/if_xdp.h -a -f ../../../include/uapi/linux/if_xdp.h && ( \
 	(diff -B ../../include/uapi/linux/if_xdp.h ../../../include/uapi/linux/if_xdp.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(SHARED_OBJDIR) $(SHARED_OBJDIR)fixdep
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
 
-$(BPF_IN_STATIC): force $(BPF_GENERATED)
+$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)
+	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= OUTPUT=$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
 
 $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
@@ -263,7 +270,7 @@ install_pkgconfig: $(PC_FILE)
 
 install: install_lib install_pkgconfig install_headers
 
-clean:
+clean: fixdep-clean
 	$(call QUIET_CLEAN, libbpf) $(RM) -rf $(CMD_TARGETS)		     \
 		*~ .*.d .*.cmd LIBBPF-CFLAGS $(BPF_GENERATED)		     \
 		$(SHARED_OBJDIR) $(STATIC_OBJDIR)			     \
-- 
2.45.2.993.g49e7a77208-goog


