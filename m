Return-Path: <bpf+bounces-32443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC790DE2B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A7C1F221AF
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9518E755;
	Tue, 18 Jun 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3hTimFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064D18E749;
	Tue, 18 Jun 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745688; cv=none; b=FPEA4rcdDiwWpEbsr8KfXZoZH3vQShKpLtfUzy4QTB5WGw4j1MUSATN5UV9Al4k9QE70o/ANNbM5YZyHT9io43wCxUBHZric85BG1Jx9hfxxtY55JuZ2Yi6x7H2BEeQPXsql4Y9R6lb/F88x5urD/XTB5HY/73aUC31+MVgkUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745688; c=relaxed/simple;
	bh=08+QBr18aoWJvyCMF1d7VVB/HIrB8eI2GVhwnqJaB5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQFNG6Zicjjmz7wf+6Kp9nvAnJS2ylFt1d/WVE2K9tF4gyOkxmF8ShR3hTVGrEn2bH0vUJwN8ZCZwcgXGwG5Ys2I63aeCUO79qd5g4hyBC0dUbXtQjkQOkWw5TG9TtIkePKbPL8SrkWcB3M0N427ihg+lIiMrrFdmK9vaSTsg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3hTimFu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c348a263easo191084a91.0;
        Tue, 18 Jun 2024 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745684; x=1719350484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOX0rfjwfI/1kd+fkyr2WoLkV/QRZOA/9q50w9B57Lc=;
        b=h3hTimFufzylBFgtAEt62m+qyJc/BUQSio/QdNW2EnKNSC9uneQvtMZZLBWh4v6d4C
         fYC30Fv7A2UUsAsPWk+ulPkZyHsEuHkXU8kN1ich5kVH/mk/JTtu1BpiQu62w22BJs1O
         UKbGUnb8lq0k3k5uUEqWZKN6B35lo9I9COWwNphkiuAKGm/weBHPE8LQl6UItrC75ro0
         t46oJSUlLnHae/kBNXCs3QYAHKML5bC2dcPh45YcpHCT5RI0fTi25o5PkqOCcTsrwfB0
         Zx5CbmOINU6QQ7jxsY4kNCtrNAqT9iuQXx2MxvnnP4TbxFRIQ7ya+iMyCkk+XO1iwceD
         he8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745684; x=1719350484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pOX0rfjwfI/1kd+fkyr2WoLkV/QRZOA/9q50w9B57Lc=;
        b=pRe3BR7GFpSVJGcpjBD+gjzG0eqW9Kk+uPtxsTfHsLToSY2jVTjpbIlxMv5nkCkA81
         oaUvHaQDsilL2HgpplyxPtVOF7ElQUeiDTEbw85RE78bJJlVPZXgigrCOL9//hinUgC4
         Md5bNs22jtNDYDbhjM7gNaS5sjTWTr6LfAl1mSXpZH9v4IyzT6RGUp9QYrFCSE9oSlbT
         MsCjhRSXlxAqnFhOdL5AczFw7UnTGHaJduMvciQtrU6N60SKjtvD3j4FBtIc1EdL1jsj
         YKjAKdR4GlUFJn9SipJnFkDJ6O21PMgDIMnp+oOHWNwuUqNIwyFDnIdeP54t65On3Wh6
         R8zA==
X-Forwarded-Encrypted: i=1; AJvYcCV9aig4og+6k1WPeyBanVAgpDmawgYRjF+tHHwJpHYtdJCS5d5VePlBWXtXa4CZZefHC0zhYhUNPMgVSsSlNqfl05sF
X-Gm-Message-State: AOJu0YzniNzBmuluUunLkGAT3Q27HDj9LFYcWz1WPPvn7sfsg5Mf73Zy
	4RUZr7OIN8n/pj07f1wwsIvcPwtaPEFL9hsOdYsbUxnmu2zBQCYq
X-Google-Smtp-Source: AGHT+IH1EwJOrh4+PRcZpw6tSAaC6JR4G/tMlXjEnGf3iUewMZ+kP+TvaW49F3Xqd2o4/NXiHAY8FQ==
X-Received: by 2002:a17:90a:e507:b0:2c7:8c6a:5755 with SMTP id 98e67ed59e1d1-2c7b3aa623cmr1281381a91.2.1718745683716;
        Tue, 18 Jun 2024 14:21:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c466bfb3sm11324486a91.41.2024.06.18.14.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/30] sched_ext: Add scx_simple and scx_example_qmap example schedulers
Date: Tue, 18 Jun 2024 11:17:25 -1000
Message-ID: <20240618212056.2833381-11-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two simple example BPF schedulers - simple and qmap.

* simple: In terms of scheduling, it behaves identical to not having any
  operation implemented at all. The two operations it implements are only to
  improve visibility and exit handling. On certain homogeneous
  configurations, this actually can perform pretty well.

* qmap: A fixed five level priority scheduler to demonstrate queueing PIDs
  on BPF maps for scheduling. While not very practical, this is useful as a
  simple example and will be used to demonstrate different features.

v7: - Compat helpers stripped out in prepartion of upstreaming as the
      upstreamed patchset will be the baselinfe. Utility macros that can be
      used to implement compat features are kept.

    - Explicitly disable map autoattach on struct_ops to avoid trying to
      attach twice while maintaining compatbility with older libbpf.

v6: - Common header files reorganized and cleaned up. Compat helpers are
      added to demonstrate how schedulers can maintain backward
      compatibility with older kernels while making use of newly added
      features.

    - simple_select_cpu() added to keep track of the number of local
      dispatches. This is needed because the default ops.select_cpu()
      implementation is updated to dispatch directly and won't call
      ops.enqueue().

    - Updated to reflect the sched_ext API changes. Switching all tasks is
      the default behavior now and scx_qmap supports partial switching when
      `-p` is specified.

    - tools/sched_ext/Kconfig dropped. This will be included in the doc
      instead.

v5: - Improve Makefile. Build artifects are now collected into a separate
      dir which change be changed. Install and help targets are added and
      clean actually cleans everything.

    - MEMBER_VPTR() improved to improve access to structs. ARRAY_ELEM_PTR()
      and RESIZEABLE_ARRAY() are added to support resizable arrays in .bss.

    - Add scx_common.h which provides common utilities to user code such as
      SCX_BUG[_ON]() and RESIZE_ARRAY().

    - Use SCX_BUG[_ON]() to simplify error handling.

v4: - Dropped _example prefix from scheduler names.

v3: - Rename scx_example_dummy to scx_example_simple and restructure a bit
      to ease later additions. Comment updates.

    - Added declarations for BPF inline iterators. In the future, hopefully,
      these will be consolidated into a generic BPF header so that they
      don't need to be replicated here.

v2: - Updated with the generic BPF cpumask helpers.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 Makefile                                      |   8 +-
 tools/Makefile                                |  10 +-
 tools/sched_ext/.gitignore                    |   2 +
 tools/sched_ext/Makefile                      | 246 ++++++++++++
 .../sched_ext/include/bpf-compat/gnu/stubs.h  |  11 +
 tools/sched_ext/include/scx/common.bpf.h      | 379 ++++++++++++++++++
 tools/sched_ext/include/scx/common.h          |  75 ++++
 tools/sched_ext/include/scx/compat.bpf.h      |  28 ++
 tools/sched_ext/include/scx/compat.h          | 153 +++++++
 tools/sched_ext/include/scx/user_exit_info.h  |  64 +++
 tools/sched_ext/scx_qmap.bpf.c                | 264 ++++++++++++
 tools/sched_ext/scx_qmap.c                    |  99 +++++
 tools/sched_ext/scx_simple.bpf.c              |  63 +++
 tools/sched_ext/scx_simple.c                  |  99 +++++
 14 files changed, 1499 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/.gitignore
 create mode 100644 tools/sched_ext/Makefile
 create mode 100644 tools/sched_ext/include/bpf-compat/gnu/stubs.h
 create mode 100644 tools/sched_ext/include/scx/common.bpf.h
 create mode 100644 tools/sched_ext/include/scx/common.h
 create mode 100644 tools/sched_ext/include/scx/compat.bpf.h
 create mode 100644 tools/sched_ext/include/scx/compat.h
 create mode 100644 tools/sched_ext/include/scx/user_exit_info.h
 create mode 100644 tools/sched_ext/scx_qmap.bpf.c
 create mode 100644 tools/sched_ext/scx_qmap.c
 create mode 100644 tools/sched_ext/scx_simple.bpf.c
 create mode 100644 tools/sched_ext/scx_simple.c

diff --git a/Makefile b/Makefile
index 7f921ae547f1..b2e57dfe8c7a 100644
--- a/Makefile
+++ b/Makefile
@@ -1355,6 +1355,12 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
+tools-clean-targets := sched_ext
+PHONY += $(tools-clean-targets)
+$(tools-clean-targets):
+	$(Q)$(MAKE) -sC tools $@_clean
+tools_clean: $(tools-clean-targets)
+
 # Clear a bunch of variables before executing the submake
 ifeq ($(quiet),silent_)
 tools_silent=s
@@ -1527,7 +1533,7 @@ PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-mrproper: clean $(mrproper-dirs)
+mrproper: clean $(mrproper-dirs) tools_clean
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.rmeta' \) \
diff --git a/tools/Makefile b/tools/Makefile
index 276f5d0d53a4..278d24723b74 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -28,6 +28,7 @@ include scripts/Makefile.include
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
+	@echo '  sched_ext              - sched_ext example schedulers'
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
@@ -91,6 +92,9 @@ perf: FORCE
 	$(Q)mkdir -p $(PERF_O) .
 	$(Q)$(MAKE) --no-print-directory -C perf O=$(PERF_O) subdir=
 
+sched_ext: FORCE
+	$(call descend,sched_ext)
+
 selftests: FORCE
 	$(call descend,testing/$@)
 
@@ -184,6 +188,9 @@ install: acpi_install counter_install cpupower_install gpio_install \
 	$(Q)mkdir -p $(PERF_O) .
 	$(Q)$(MAKE) --no-print-directory -C perf O=$(PERF_O) subdir= clean
 
+sched_ext_clean:
+	$(call descend,sched_ext,clean)
+
 selftests_clean:
 	$(call descend,testing/$(@:_clean=),clean)
 
@@ -213,6 +220,7 @@ clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
+		sched_ext_clean
 
 .PHONY: FORCE
diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
new file mode 100644
index 000000000000..d6264fe1c8cd
--- /dev/null
+++ b/tools/sched_ext/.gitignore
@@ -0,0 +1,2 @@
+tools/
+build/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
new file mode 100644
index 000000000000..626782a21375
--- /dev/null
+++ b/tools/sched_ext/Makefile
@@ -0,0 +1,246 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+include ../build/Build.include
+include ../scripts/Makefile.arch
+include ../scripts/Makefile.include
+
+all: all_targets
+
+ifneq ($(LLVM),)
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
+CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
+CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
+CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
+CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
+CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
+CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
+CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
+CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
+CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+
+ifeq ($(CROSS_COMPILE),)
+ifeq ($(CLANG_TARGET_FLAGS),)
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk)
+else
+CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
+endif # CLANG_TARGET_FLAGS
+else
+CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif # CROSS_COMPILE
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+else
+CC := $(CROSS_COMPILE)gcc
+endif # LLVM
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+GENDIR := $(abspath ../../include/generated)
+GENHDR := $(GENDIR)/autoconf.h
+
+ifeq ($(O),)
+OUTPUT_DIR := $(CURDIR)/build
+else
+OUTPUT_DIR := $(O)/build
+endif # O
+OBJ_DIR := $(OUTPUT_DIR)/obj
+INCLUDE_DIR := $(OUTPUT_DIR)/include
+BPFOBJ_DIR := $(OBJ_DIR)/libbpf
+SCXOBJ_DIR := $(OBJ_DIR)/sched_ext
+BINDIR := $(OUTPUT_DIR)/bin
+BPFOBJ := $(BPFOBJ_DIR)/libbpf.a
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(OBJ_DIR)/host
+HOST_OUTPUT_DIR	:= host-tools
+HOST_INCLUDE_DIR	:= $(HOST_OUTPUT_DIR)/include
+else
+HOST_BUILD_DIR		:= $(OBJ_DIR)
+HOST_OUTPUT_DIR	:= $(OUTPUT_DIR)
+HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+DEFAULT_BPFTOOL := $(HOST_OUTPUT_DIR)/sbin/bpftool
+
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../vmlinux						\
+		     /sys/kernel/btf/vmlinux					\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
+	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+LDFLAGS = -lelf -lz -lpthread
+
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
+	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)		\
+	     -I$(CURDIR)/include -I$(CURDIR)/include/bpf-compat			\
+	     -I$(INCLUDE_DIR) -I$(APIDIR)					\
+	     -I../../include							\
+	     $(call get_sys_includes,$(CLANG))					\
+	     -Wall -Wno-compare-distinct-pointer-types				\
+	     -O2 -mcpu=v3
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf			\
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids	\
+	       $(INCLUDE_DIR) $(SCXOBJ_DIR) $(BINDIR))
+
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
+	   $(APIDIR)/linux/bpf.h						\
+	   | $(OBJ_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(OBJ_DIR)/libbpf/	\
+		    EXTRA_CFLAGS='-g -O0 -fPIC'					\
+		    DESTDIR=$(OUTPUT_DIR) prefix= all install_headers
+
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
+		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/				\
+		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/			\
+		    LIBBPF_DESTDIR=$(HOST_OUTPUT_DIR)/				\
+		    prefix= DESTDIR=$(HOST_OUTPUT_DIR)/ install-bin
+
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(SCXOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h include/scx/*.h		\
+		       | $(BPFOBJ) $(SCXOBJ_DIR)
+	$(call msg,CLNG-BPF,,$(notdir $@))
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL)
+	$(eval sched=$(notdir $@))
+	$(call msg,GEN-SKEL,,$(sched))
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
+	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $@
+	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $(@:.skel.h=.subskel.h)
+
+SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
+
+c-sched-targets = scx_simple scx_qmap
+
+$(addprefix $(BINDIR)/,$(c-sched-targets)): \
+	$(BINDIR)/%: \
+		$(filter-out %.bpf.c,%.c) \
+		$(INCLUDE_DIR)/%.bpf.skel.h \
+		$(SCX_COMMON_DEPS)
+	$(eval sched=$(notdir $@))
+	$(CC) $(CFLAGS) -c $(sched).c -o $(SCXOBJ_DIR)/$(sched).o
+	$(CC) -o $@ $(SCXOBJ_DIR)/$(sched).o $(HOST_BPFOBJ) $(LDFLAGS)
+
+$(c-sched-targets): %: $(BINDIR)/%
+
+install: all
+	$(Q)mkdir -p $(DESTDIR)/usr/local/bin/
+	$(Q)cp $(BINDIR)/* $(DESTDIR)/usr/local/bin/
+
+clean:
+	rm -rf $(OUTPUT_DIR) $(HOST_OUTPUT_DIR)
+	rm -f *.o *.bpf.o *.bpf.skel.h *.bpf.subskel.h
+	rm -f $(c-sched-targets)
+
+help:
+	@echo   'Building targets'
+	@echo   '================'
+	@echo   ''
+	@echo   '  all		  - Compile all schedulers'
+	@echo   ''
+	@echo   'Alternatively, you may compile individual schedulers:'
+	@echo   ''
+	@printf '  %s\n' $(c-sched-targets)
+	@echo   ''
+	@echo   'For any scheduler build target, you may specify an alternative'
+	@echo   'build output path with the O= environment variable. For example:'
+	@echo   ''
+	@echo   '   O=/tmp/sched_ext make all'
+	@echo   ''
+	@echo   'will compile all schedulers, and emit the build artifacts to'
+	@echo   '/tmp/sched_ext/build.'
+	@echo   ''
+	@echo   ''
+	@echo   'Installing targets'
+	@echo   '=================='
+	@echo   ''
+	@echo   '  install	  - Compile and install all schedulers to /usr/bin.'
+	@echo   '		    You may specify the DESTDIR= environment variable'
+	@echo   '		    to indicate a prefix for /usr/bin. For example:'
+	@echo   ''
+	@echo   '                     DESTDIR=/tmp/sched_ext make install'
+	@echo   ''
+	@echo   '		    will build the schedulers in CWD/build, and'
+	@echo   '		    install the schedulers to /tmp/sched_ext/usr/bin.'
+	@echo   ''
+	@echo   ''
+	@echo   'Cleaning targets'
+	@echo   '================'
+	@echo   ''
+	@echo   '  clean		  - Remove all generated files'
+
+all_targets: $(c-sched-targets)
+
+.PHONY: all all_targets $(c-sched-targets) clean help
+
+# delete failed targets
+.DELETE_ON_ERROR:
+
+# keep intermediate (.bpf.skel.h, .bpf.o, etc) targets
+.SECONDARY:
diff --git a/tools/sched_ext/include/bpf-compat/gnu/stubs.h b/tools/sched_ext/include/bpf-compat/gnu/stubs.h
new file mode 100644
index 000000000000..ad7d139ce907
--- /dev/null
+++ b/tools/sched_ext/include/bpf-compat/gnu/stubs.h
@@ -0,0 +1,11 @@
+/*
+ * Dummy gnu/stubs.h. clang can end up including /usr/include/gnu/stubs.h when
+ * compiling BPF files although its content doesn't play any role. The file in
+ * turn includes stubs-64.h or stubs-32.h depending on whether __x86_64__ is
+ * defined. When compiling a BPF source, __x86_64__ isn't set and thus
+ * stubs-32.h is selected. However, the file is not there if the system doesn't
+ * have 32bit glibc devel package installed leading to a build failure.
+ *
+ * The problem is worked around by making this file available in the include
+ * search paths before the system one when building BPF.
+ */
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
new file mode 100644
index 000000000000..833fe1bdccf9
--- /dev/null
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -0,0 +1,379 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#ifndef __SCX_COMMON_BPF_H
+#define __SCX_COMMON_BPF_H
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <asm-generic/errno.h>
+#include "user_exit_info.h"
+
+#define PF_WQ_WORKER			0x00000020	/* I'm a workqueue worker */
+#define PF_KTHREAD			0x00200000	/* I am a kernel thread */
+#define PF_EXITING			0x00000004
+#define CLOCK_MONOTONIC			1
+
+/*
+ * Earlier versions of clang/pahole lost upper 32bits in 64bit enums which can
+ * lead to really confusing misbehaviors. Let's trigger a build failure.
+ */
+static inline void ___vmlinux_h_sanity_check___(void)
+{
+	_Static_assert(SCX_DSQ_FLAG_BUILTIN,
+		       "bpftool generated vmlinux.h is missing high bits for 64bit enums, upgrade clang and pahole");
+}
+
+s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
+s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+u32 scx_bpf_dispatch_nr_slots(void) __ksym;
+void scx_bpf_dispatch_cancel(void) __ksym;
+bool scx_bpf_consume(u64 dsq_id) __ksym;
+s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
+void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
+void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
+u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
+const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
+const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
+void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
+const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
+void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
+bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
+s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+bool scx_bpf_task_running(const struct task_struct *p) __ksym;
+s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+
+static inline __attribute__((format(printf, 1, 2)))
+void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
+
+/*
+ * Helper macro for initializing the fmt and variadic argument inputs to both
+ * bstr exit kfuncs. Callers to this function should use ___fmt and ___param to
+ * refer to the initialized list of inputs to the bstr kfunc.
+ */
+#define scx_bpf_bstr_preamble(fmt, args...)					\
+	static char ___fmt[] = fmt;						\
+	/*									\
+	 * Note that __param[] must have at least one				\
+	 * element to keep the verifier happy.					\
+	 */									\
+	unsigned long long ___param[___bpf_narg(args) ?: 1] = {};		\
+										\
+	_Pragma("GCC diagnostic push")						\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
+	___bpf_fill(___param, args);						\
+	_Pragma("GCC diagnostic pop")						\
+
+/*
+ * scx_bpf_exit() wraps the scx_bpf_exit_bstr() kfunc with variadic arguments
+ * instead of an array of u64. Using this macro will cause the scheduler to
+ * exit cleanly with the specified exit code being passed to user space.
+ */
+#define scx_bpf_exit(code, fmt, args...)					\
+({										\
+	scx_bpf_bstr_preamble(fmt, args)					\
+	scx_bpf_exit_bstr(code, ___fmt, ___param, sizeof(___param));		\
+	___scx_bpf_bstr_format_checker(fmt, ##args);				\
+})
+
+/*
+ * scx_bpf_error() wraps the scx_bpf_error_bstr() kfunc with variadic arguments
+ * instead of an array of u64. Invoking this macro will cause the scheduler to
+ * exit in an erroneous state, with diagnostic information being passed to the
+ * user.
+ */
+#define scx_bpf_error(fmt, args...)						\
+({										\
+	scx_bpf_bstr_preamble(fmt, args)					\
+	scx_bpf_error_bstr(___fmt, ___param, sizeof(___param));			\
+	___scx_bpf_bstr_format_checker(fmt, ##args);				\
+})
+
+#define BPF_STRUCT_OPS(name, args...)						\
+SEC("struct_ops/"#name)								\
+BPF_PROG(name, ##args)
+
+#define BPF_STRUCT_OPS_SLEEPABLE(name, args...)					\
+SEC("struct_ops.s/"#name)							\
+BPF_PROG(name, ##args)
+
+/**
+ * RESIZABLE_ARRAY - Generates annotations for an array that may be resized
+ * @elfsec: the data section of the BPF program in which to place the array
+ * @arr: the name of the array
+ *
+ * libbpf has an API for setting map value sizes. Since data sections (i.e.
+ * bss, data, rodata) themselves are maps, a data section can be resized. If
+ * a data section has an array as its last element, the BTF info for that
+ * array will be adjusted so that length of the array is extended to meet the
+ * new length of the data section. This macro annotates an array to have an
+ * element count of one with the assumption that this array can be resized
+ * within the userspace program. It also annotates the section specifier so
+ * this array exists in a custom sub data section which can be resized
+ * independently.
+ *
+ * See RESIZE_ARRAY() for the userspace convenience macro for resizing an
+ * array declared with RESIZABLE_ARRAY().
+ */
+#define RESIZABLE_ARRAY(elfsec, arr) arr[1] SEC("."#elfsec"."#arr)
+
+/**
+ * MEMBER_VPTR - Obtain the verified pointer to a struct or array member
+ * @base: struct or array to index
+ * @member: dereferenced member (e.g. .field, [idx0][idx1], .field[idx0] ...)
+ *
+ * The verifier often gets confused by the instruction sequence the compiler
+ * generates for indexing struct fields or arrays. This macro forces the
+ * compiler to generate a code sequence which first calculates the byte offset,
+ * checks it against the struct or array size and add that byte offset to
+ * generate the pointer to the member to help the verifier.
+ *
+ * Ideally, we want to abort if the calculated offset is out-of-bounds. However,
+ * BPF currently doesn't support abort, so evaluate to %NULL instead. The caller
+ * must check for %NULL and take appropriate action to appease the verifier. To
+ * avoid confusing the verifier, it's best to check for %NULL and dereference
+ * immediately.
+ *
+ *	vptr = MEMBER_VPTR(my_array, [i][j]);
+ *	if (!vptr)
+ *		return error;
+ *	*vptr = new_value;
+ *
+ * sizeof(@base) should encompass the memory area to be accessed and thus can't
+ * be a pointer to the area. Use `MEMBER_VPTR(*ptr, .member)` instead of
+ * `MEMBER_VPTR(ptr, ->member)`.
+ */
+#define MEMBER_VPTR(base, member) (typeof((base) member) *)			\
+({										\
+	u64 __base = (u64)&(base);						\
+	u64 __addr = (u64)&((base) member) - __base;				\
+	_Static_assert(sizeof(base) >= sizeof((base) member),			\
+		       "@base is smaller than @member, is @base a pointer?");	\
+	asm volatile (								\
+		"if %0 <= %[max] goto +2\n"					\
+		"%0 = 0\n"							\
+		"goto +1\n"							\
+		"%0 += %1\n"							\
+		: "+r"(__addr)							\
+		: "r"(__base),							\
+		  [max]"i"(sizeof(base) - sizeof((base) member)));		\
+	__addr;									\
+})
+
+/**
+ * ARRAY_ELEM_PTR - Obtain the verified pointer to an array element
+ * @arr: array to index into
+ * @i: array index
+ * @n: number of elements in array
+ *
+ * Similar to MEMBER_VPTR() but is intended for use with arrays where the
+ * element count needs to be explicit.
+ * It can be used in cases where a global array is defined with an initial
+ * size but is intended to be be resized before loading the BPF program.
+ * Without this version of the macro, MEMBER_VPTR() will use the compile time
+ * size of the array to compute the max, which will result in rejection by
+ * the verifier.
+ */
+#define ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)				\
+({										\
+	u64 __base = (u64)arr;							\
+	u64 __addr = (u64)&(arr[i]) - __base;					\
+	asm volatile (								\
+		"if %0 <= %[max] goto +2\n"					\
+		"%0 = 0\n"							\
+		"goto +1\n"							\
+		"%0 += %1\n"							\
+		: "+r"(__addr)							\
+		: "r"(__base),							\
+		  [max]"r"(sizeof(arr[0]) * ((n) - 1)));			\
+	__addr;									\
+})
+
+
+/*
+ * BPF declarations and helpers
+ */
+
+/* list and rbtree */
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
+void bpf_obj_drop_impl(void *kptr, void *meta) __ksym;
+
+#define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_local(type), NULL))
+#define bpf_obj_drop(kptr) bpf_obj_drop_impl(kptr, NULL)
+
+void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node) __ksym;
+struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ksym;
+struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
+struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
+				      struct bpf_rb_node *node) __ksym;
+int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
+			bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
+			void *meta, __u64 off) __ksym;
+#define bpf_rbtree_add(head, node, less) bpf_rbtree_add_impl(head, node, less, NULL, 0)
+
+struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
+
+void *bpf_refcount_acquire_impl(void *kptr, void *meta) __ksym;
+#define bpf_refcount_acquire(kptr) bpf_refcount_acquire_impl(kptr, NULL)
+
+/* task */
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* cgroup */
+struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym;
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
+
+/* css iteration */
+struct bpf_iter_css;
+struct cgroup_subsys_state;
+extern int bpf_iter_css_new(struct bpf_iter_css *it,
+			    struct cgroup_subsys_state *start,
+			    unsigned int flags) __weak __ksym;
+extern struct cgroup_subsys_state *
+bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
+extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
+
+/* cpumask */
+struct bpf_cpumask *bpf_cpumask_create(void) __ksym;
+struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask) __ksym;
+void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
+u32 bpf_cpumask_first(const struct cpumask *cpumask) __ksym;
+u32 bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
+void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask) __ksym;
+bool bpf_cpumask_test_and_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+bool bpf_cpumask_test_and_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
+void bpf_cpumask_setall(struct bpf_cpumask *cpumask) __ksym;
+void bpf_cpumask_clear(struct bpf_cpumask *cpumask) __ksym;
+bool bpf_cpumask_and(struct bpf_cpumask *dst, const struct cpumask *src1,
+		     const struct cpumask *src2) __ksym;
+void bpf_cpumask_or(struct bpf_cpumask *dst, const struct cpumask *src1,
+		    const struct cpumask *src2) __ksym;
+void bpf_cpumask_xor(struct bpf_cpumask *dst, const struct cpumask *src1,
+		     const struct cpumask *src2) __ksym;
+bool bpf_cpumask_equal(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+bool bpf_cpumask_intersects(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+bool bpf_cpumask_subset(const struct cpumask *src1, const struct cpumask *src2) __ksym;
+bool bpf_cpumask_empty(const struct cpumask *cpumask) __ksym;
+bool bpf_cpumask_full(const struct cpumask *cpumask) __ksym;
+void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym;
+u32 bpf_cpumask_any_distribute(const struct cpumask *cpumask) __ksym;
+u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
+				   const struct cpumask *src2) __ksym;
+
+/* rcu */
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+
+/*
+ * Other helpers
+ */
+
+/* useful compiler attributes */
+#define likely(x) __builtin_expect(!!(x), 1)
+#define unlikely(x) __builtin_expect(!!(x), 0)
+#define __maybe_unused __attribute__((__unused__))
+
+/*
+ * READ/WRITE_ONCE() are from kernel (include/asm-generic/rwonce.h). They
+ * prevent compiler from caching, redoing or reordering reads or writes.
+ */
+typedef __u8  __attribute__((__may_alias__))  __u8_alias_t;
+typedef __u16 __attribute__((__may_alias__)) __u16_alias_t;
+typedef __u32 __attribute__((__may_alias__)) __u32_alias_t;
+typedef __u64 __attribute__((__may_alias__)) __u64_alias_t;
+
+static __always_inline void __read_once_size(const volatile void *p, void *res, int size)
+{
+	switch (size) {
+	case 1: *(__u8_alias_t  *) res = *(volatile __u8_alias_t  *) p; break;
+	case 2: *(__u16_alias_t *) res = *(volatile __u16_alias_t *) p; break;
+	case 4: *(__u32_alias_t *) res = *(volatile __u32_alias_t *) p; break;
+	case 8: *(__u64_alias_t *) res = *(volatile __u64_alias_t *) p; break;
+	default:
+		barrier();
+		__builtin_memcpy((void *)res, (const void *)p, size);
+		barrier();
+	}
+}
+
+static __always_inline void __write_once_size(volatile void *p, void *res, int size)
+{
+	switch (size) {
+	case 1: *(volatile  __u8_alias_t *) p = *(__u8_alias_t  *) res; break;
+	case 2: *(volatile __u16_alias_t *) p = *(__u16_alias_t *) res; break;
+	case 4: *(volatile __u32_alias_t *) p = *(__u32_alias_t *) res; break;
+	case 8: *(volatile __u64_alias_t *) p = *(__u64_alias_t *) res; break;
+	default:
+		barrier();
+		__builtin_memcpy((void *)p, (const void *)res, size);
+		barrier();
+	}
+}
+
+#define READ_ONCE(x)					\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__c = { 0 } };			\
+	__read_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
+
+#define WRITE_ONCE(x, val)				\
+({							\
+	union { typeof(x) __val; char __c[1]; } __u =	\
+		{ .__val = (val) }; 			\
+	__write_once_size(&(x), __u.__c, sizeof(x));	\
+	__u.__val;					\
+})
+
+/*
+ * log2_u32 - Compute the base 2 logarithm of a 32-bit exponential value.
+ * @v: The value for which we're computing the base 2 logarithm.
+ */
+static inline u32 log2_u32(u32 v)
+{
+        u32 r;
+        u32 shift;
+
+        r = (v > 0xFFFF) << 4; v >>= r;
+        shift = (v > 0xFF) << 3; v >>= shift; r |= shift;
+        shift = (v > 0xF) << 2; v >>= shift; r |= shift;
+        shift = (v > 0x3) << 1; v >>= shift; r |= shift;
+        r |= (v >> 1);
+        return r;
+}
+
+/*
+ * log2_u64 - Compute the base 2 logarithm of a 64-bit exponential value.
+ * @v: The value for which we're computing the base 2 logarithm.
+ */
+static inline u32 log2_u64(u64 v)
+{
+        u32 hi = v >> 32;
+        if (hi)
+                return log2_u32(hi) + 32 + 1;
+        else
+                return log2_u32(v) + 1;
+}
+
+#include "compat.bpf.h"
+
+#endif	/* __SCX_COMMON_BPF_H */
diff --git a/tools/sched_ext/include/scx/common.h b/tools/sched_ext/include/scx/common.h
new file mode 100644
index 000000000000..5b0f90152152
--- /dev/null
+++ b/tools/sched_ext/include/scx/common.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ */
+#ifndef __SCHED_EXT_COMMON_H
+#define __SCHED_EXT_COMMON_H
+
+#ifdef __KERNEL__
+#error "Should not be included by BPF programs"
+#endif
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <errno.h>
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+typedef int8_t s8;
+typedef int16_t s16;
+typedef int32_t s32;
+typedef int64_t s64;
+
+#define SCX_BUG(__fmt, ...)							\
+	do {									\
+		fprintf(stderr, "[SCX_BUG] %s:%d", __FILE__, __LINE__);		\
+		if (errno)							\
+			fprintf(stderr, " (%s)\n", strerror(errno));		\
+		else								\
+			fprintf(stderr, "\n");					\
+		fprintf(stderr, __fmt __VA_OPT__(,) __VA_ARGS__);		\
+		fprintf(stderr, "\n");						\
+										\
+		exit(EXIT_FAILURE);						\
+	} while (0)
+
+#define SCX_BUG_ON(__cond, __fmt, ...)					\
+	do {								\
+		if (__cond)						\
+			SCX_BUG((__fmt) __VA_OPT__(,) __VA_ARGS__);	\
+	} while (0)
+
+/**
+ * RESIZE_ARRAY - Convenience macro for resizing a BPF array
+ * @__skel: the skeleton containing the array
+ * @elfsec: the data section of the BPF program in which the array exists
+ * @arr: the name of the array
+ * @n: the desired array element count
+ *
+ * For BPF arrays declared with RESIZABLE_ARRAY(), this macro performs two
+ * operations. It resizes the map which corresponds to the custom data
+ * section that contains the target array. As a side effect, the BTF info for
+ * the array is adjusted so that the array length is sized to cover the new
+ * data section size. The second operation is reassigning the skeleton pointer
+ * for that custom data section so that it points to the newly memory mapped
+ * region.
+ */
+#define RESIZE_ARRAY(__skel, elfsec, arr, n)						\
+	do {										\
+		size_t __sz;								\
+		bpf_map__set_value_size((__skel)->maps.elfsec##_##arr,			\
+				sizeof((__skel)->elfsec##_##arr->arr[0]) * (n));	\
+		(__skel)->elfsec##_##arr =						\
+			bpf_map__initial_value((__skel)->maps.elfsec##_##arr, &__sz);	\
+	} while (0)
+
+#include "user_exit_info.h"
+#include "compat.h"
+
+#endif	/* __SCHED_EXT_COMMON_H */
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
new file mode 100644
index 000000000000..3d2fe1208900
--- /dev/null
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#ifndef __SCX_COMPAT_BPF_H
+#define __SCX_COMPAT_BPF_H
+
+#define __COMPAT_ENUM_OR_ZERO(__type, __ent)					\
+({										\
+	__type __ret = 0;							\
+	if (bpf_core_enum_value_exists(__type, __ent))				\
+		__ret = __ent;							\
+	__ret;									\
+})
+
+/*
+ * Define sched_ext_ops. This may be expanded to define multiple variants for
+ * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
+ */
+#define SCX_OPS_DEFINE(__name, ...)						\
+	SEC(".struct_ops.link")							\
+	struct sched_ext_ops __name = {						\
+		__VA_ARGS__,							\
+	};
+
+#endif	/* __SCX_COMPAT_BPF_H */
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
new file mode 100644
index 000000000000..a7fdaf8a858e
--- /dev/null
+++ b/tools/sched_ext/include/scx/compat.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#ifndef __SCX_COMPAT_H
+#define __SCX_COMPAT_H
+
+#include <bpf/btf.h>
+
+struct btf *__COMPAT_vmlinux_btf __attribute__((weak));
+
+static inline void __COMPAT_load_vmlinux_btf(void)
+{
+	if (!__COMPAT_vmlinux_btf) {
+		__COMPAT_vmlinux_btf = btf__load_vmlinux_btf();
+		SCX_BUG_ON(!__COMPAT_vmlinux_btf, "btf__load_vmlinux_btf()");
+	}
+}
+
+static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v)
+{
+	const struct btf_type *t;
+	const char *n;
+	s32 tid;
+	int i;
+
+	__COMPAT_load_vmlinux_btf();
+
+	tid = btf__find_by_name(__COMPAT_vmlinux_btf, type);
+	if (tid < 0)
+		return false;
+
+	t = btf__type_by_id(__COMPAT_vmlinux_btf, tid);
+	SCX_BUG_ON(!t, "btf__type_by_id(%d)", tid);
+
+	if (btf_is_enum(t)) {
+		struct btf_enum *e = btf_enum(t);
+
+		for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
+			n = btf__name_by_offset(__COMPAT_vmlinux_btf, e[i].name_off);
+			SCX_BUG_ON(!n, "btf__name_by_offset()");
+			if (!strcmp(n, name)) {
+				*v = e[i].val;
+				return true;
+			}
+		}
+	} else if (btf_is_enum64(t)) {
+		struct btf_enum64 *e = btf_enum64(t);
+
+		for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
+			n = btf__name_by_offset(__COMPAT_vmlinux_btf, e[i].name_off);
+			SCX_BUG_ON(!n, "btf__name_by_offset()");
+			if (!strcmp(n, name)) {
+				*v = btf_enum64_value(&e[i]);
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+#define __COMPAT_ENUM_OR_ZERO(__type, __ent)					\
+({										\
+	u64 __val = 0;								\
+	__COMPAT_read_enum(__type, __ent, &__val);				\
+	__val;									\
+})
+
+static inline bool __COMPAT_has_ksym(const char *ksym)
+{
+	__COMPAT_load_vmlinux_btf();
+	return btf__find_by_name(__COMPAT_vmlinux_btf, ksym) >= 0;
+}
+
+static inline bool __COMPAT_struct_has_field(const char *type, const char *field)
+{
+	const struct btf_type *t;
+	const struct btf_member *m;
+	const char *n;
+	s32 tid;
+	int i;
+
+	__COMPAT_load_vmlinux_btf();
+	tid = btf__find_by_name_kind(__COMPAT_vmlinux_btf, type, BTF_KIND_STRUCT);
+	if (tid < 0)
+		return false;
+
+	t = btf__type_by_id(__COMPAT_vmlinux_btf, tid);
+	SCX_BUG_ON(!t, "btf__type_by_id(%d)", tid);
+
+	m = btf_members(t);
+
+	for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
+		n = btf__name_by_offset(__COMPAT_vmlinux_btf, m[i].name_off);
+		SCX_BUG_ON(!n, "btf__name_by_offset()");
+			if (!strcmp(n, field))
+				return true;
+	}
+
+	return false;
+}
+
+#define SCX_OPS_SWITCH_PARTIAL							\
+	__COMPAT_ENUM_OR_ZERO("scx_ops_flags", "SCX_OPS_SWITCH_PARTIAL")
+
+/*
+ * struct sched_ext_ops can change over time. If compat.bpf.h::SCX_OPS_DEFINE()
+ * is used to define ops and compat.h::SCX_OPS_LOAD/ATTACH() are used to load
+ * and attach it, backward compatibility is automatically maintained where
+ * reasonable.
+ */
+#define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
+	struct __scx_name *__skel;						\
+										\
+	__skel = __scx_name##__open();						\
+	SCX_BUG_ON(!__skel, "Could not open " #__scx_name);			\
+	__skel; 								\
+})
+
+#define SCX_OPS_LOAD(__skel, __ops_name, __scx_name) ({				\
+	SCX_BUG_ON(__scx_name##__load((__skel)), "Failed to load skel");	\
+})
+
+/*
+ * New versions of bpftool now emit additional link placeholders for BPF maps,
+ * and set up BPF skeleton in such a way that libbpf will auto-attach BPF maps
+ * automatically, assumming libbpf is recent enough (v1.5+). Old libbpf will do
+ * nothing with those links and won't attempt to auto-attach maps.
+ *
+ * To maintain compatibility with older libbpf while avoiding trying to attach
+ * twice, disable the autoattach feature on newer libbpf.
+ */
+#if LIBBPF_MAJOR_VERSION > 1 ||							\
+	(LIBBPF_MAJOR_VERSION == 1 && LIBBPF_MINOR_VERSION >= 5)
+#define __SCX_OPS_DISABLE_AUTOATTACH(__skel, __ops_name)			\
+	bpf_map__set_autoattach((__skel)->maps.__ops_name, false)
+#else
+#define __SCX_OPS_DISABLE_AUTOATTACH(__skel, __ops_name) do {} while (0)
+#endif
+
+#define SCX_OPS_ATTACH(__skel, __ops_name, __scx_name) ({			\
+	struct bpf_link *__link;						\
+	__SCX_OPS_DISABLE_AUTOATTACH(__skel, __ops_name);			\
+	SCX_BUG_ON(__scx_name##__attach((__skel)), "Failed to attach skel");	\
+	__link = bpf_map__attach_struct_ops((__skel)->maps.__ops_name);		\
+	SCX_BUG_ON(!__link, "Failed to attach struct_ops");			\
+	__link;									\
+})
+
+#endif	/* __SCX_COMPAT_H */
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
new file mode 100644
index 000000000000..8c3b7fac4d05
--- /dev/null
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Define struct user_exit_info which is shared between BPF and userspace parts
+ * to communicate exit status and other information.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#ifndef __USER_EXIT_INFO_H
+#define __USER_EXIT_INFO_H
+
+enum uei_sizes {
+	UEI_REASON_LEN		= 128,
+	UEI_MSG_LEN		= 1024,
+};
+
+struct user_exit_info {
+	int		kind;
+	s64		exit_code;
+	char		reason[UEI_REASON_LEN];
+	char		msg[UEI_MSG_LEN];
+};
+
+#ifdef __bpf__
+
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
+
+#define UEI_DEFINE(__name)							\
+	struct user_exit_info __name SEC(".data")
+
+#define UEI_RECORD(__uei_name, __ei) ({						\
+	bpf_probe_read_kernel_str(__uei_name.reason,				\
+				  sizeof(__uei_name.reason), (__ei)->reason);	\
+	bpf_probe_read_kernel_str(__uei_name.msg,				\
+				  sizeof(__uei_name.msg), (__ei)->msg);		\
+	if (bpf_core_field_exists((__ei)->exit_code))				\
+		__uei_name.exit_code = (__ei)->exit_code;			\
+	/* use __sync to force memory barrier */				\
+	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
+				    (__ei)->kind);				\
+})
+
+#else	/* !__bpf__ */
+
+#include <stdio.h>
+#include <stdbool.h>
+
+#define UEI_EXITED(__skel, __uei_name) ({					\
+	/* use __sync to force memory barrier */				\
+	__sync_val_compare_and_swap(&(__skel)->data->__uei_name.kind, -1, -1);	\
+})
+
+#define UEI_REPORT(__skel, __uei_name) ({					\
+	struct user_exit_info *__uei = &(__skel)->data->__uei_name;		\
+	fprintf(stderr, "EXIT: %s", __uei->reason);				\
+	if (__uei->msg[0] != '\0')						\
+		fprintf(stderr, " (%s)", __uei->msg);				\
+	fputs("\n", stderr);							\
+})
+
+#endif	/* __bpf__ */
+#endif	/* __USER_EXIT_INFO_H */
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
new file mode 100644
index 000000000000..976a2693da71
--- /dev/null
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -0,0 +1,264 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple five-level FIFO queue scheduler.
+ *
+ * There are five FIFOs implemented using BPF_MAP_TYPE_QUEUE. A task gets
+ * assigned to one depending on its compound weight. Each CPU round robins
+ * through the FIFOs and dispatches more from FIFOs with higher indices - 1 from
+ * queue0, 2 from queue1, 4 from queue2 and so on.
+ *
+ * This scheduler demonstrates:
+ *
+ * - BPF-side queueing using PIDs.
+ * - Sleepable per-task storage allocation using ops.prep_enable().
+ *
+ * This scheduler is primarily for demonstration and testing of sched_ext
+ * features and unlikely to be useful for actual workloads.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+
+enum consts {
+	ONE_SEC_IN_NS		= 1000000000,
+	SHARED_DSQ		= 0,
+};
+
+char _license[] SEC("license") = "GPL";
+
+const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile u32 dsp_batch;
+
+u32 test_error_cnt;
+
+UEI_DEFINE(uei);
+
+struct qmap {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 4096);
+	__type(value, u32);
+} queue0 SEC(".maps"),
+  queue1 SEC(".maps"),
+  queue2 SEC(".maps"),
+  queue3 SEC(".maps"),
+  queue4 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 5);
+	__type(key, int);
+	__array(values, struct qmap);
+} queue_arr SEC(".maps") = {
+	.values = {
+		[0] = &queue0,
+		[1] = &queue1,
+		[2] = &queue2,
+		[3] = &queue3,
+		[4] = &queue4,
+	},
+};
+
+/* Per-task scheduling context */
+struct task_ctx {
+	bool	force_local;	/* Dispatch directly to local_dsq */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+struct cpu_ctx {
+	u64	dsp_idx;	/* dispatch index */
+	u64	dsp_cnt;	/* remaining count */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct cpu_ctx);
+} cpu_ctx_stor SEC(".maps");
+
+/* Statistics */
+u64 nr_enqueued, nr_dispatched, nr_dequeued;
+
+s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	struct task_ctx *tctx;
+	s32 cpu;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx) {
+		scx_bpf_error("task_ctx lookup failed");
+		return -ESRCH;
+	}
+
+	if (p->nr_cpus_allowed == 1 ||
+	    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
+		tctx->force_local = true;
+		return prev_cpu;
+	}
+
+	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu >= 0)
+		return cpu;
+
+	return prev_cpu;
+}
+
+static int weight_to_idx(u32 weight)
+{
+	/* Coarsely map the compound weight to a FIFO. */
+	if (weight <= 25)
+		return 0;
+	else if (weight <= 50)
+		return 1;
+	else if (weight < 200)
+		return 2;
+	else if (weight < 400)
+		return 3;
+	else
+		return 4;
+}
+
+void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_ctx *tctx;
+	u32 pid = p->pid;
+	int idx = weight_to_idx(p->scx.weight);
+	void *ring;
+
+	if (test_error_cnt && !--test_error_cnt)
+		scx_bpf_error("test triggering error");
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx) {
+		scx_bpf_error("task_ctx lookup failed");
+		return;
+	}
+
+	/* Is select_cpu() is telling us to enqueue locally? */
+	if (tctx->force_local) {
+		tctx->force_local = false;
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
+		return;
+	}
+
+	ring = bpf_map_lookup_elem(&queue_arr, &idx);
+	if (!ring) {
+		scx_bpf_error("failed to find ring %d", idx);
+		return;
+	}
+
+	/* Queue on the selected FIFO. If the FIFO overflows, punt to global. */
+	if (bpf_map_push_elem(ring, &pid, 0)) {
+		scx_bpf_dispatch(p, SHARED_DSQ, slice_ns, enq_flags);
+		return;
+	}
+
+	__sync_fetch_and_add(&nr_enqueued, 1);
+}
+
+/*
+ * The BPF queue map doesn't support removal and sched_ext can handle spurious
+ * dispatches. qmap_dequeue() is only used to collect statistics.
+ */
+void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
+{
+	__sync_fetch_and_add(&nr_dequeued, 1);
+}
+
+void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
+{
+	struct task_struct *p;
+	struct cpu_ctx *cpuc;
+	u32 zero = 0, batch = dsp_batch ?: 1;
+	void *fifo;
+	s32 i, pid;
+
+	if (scx_bpf_consume(SHARED_DSQ))
+		return;
+
+	if (!(cpuc = bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
+		scx_bpf_error("failed to look up cpu_ctx");
+		return;
+	}
+
+	for (i = 0; i < 5; i++) {
+		/* Advance the dispatch cursor and pick the fifo. */
+		if (!cpuc->dsp_cnt) {
+			cpuc->dsp_idx = (cpuc->dsp_idx + 1) % 5;
+			cpuc->dsp_cnt = 1 << cpuc->dsp_idx;
+		}
+
+		fifo = bpf_map_lookup_elem(&queue_arr, &cpuc->dsp_idx);
+		if (!fifo) {
+			scx_bpf_error("failed to find ring %llu", cpuc->dsp_idx);
+			return;
+		}
+
+		/* Dispatch or advance. */
+		bpf_repeat(BPF_MAX_LOOPS) {
+			if (bpf_map_pop_elem(fifo, &pid))
+				break;
+
+			p = bpf_task_from_pid(pid);
+			if (!p)
+				continue;
+
+			__sync_fetch_and_add(&nr_dispatched, 1);
+			scx_bpf_dispatch(p, SHARED_DSQ, slice_ns, 0);
+			bpf_task_release(p);
+			batch--;
+			cpuc->dsp_cnt--;
+			if (!batch || !scx_bpf_dispatch_nr_slots()) {
+				scx_bpf_consume(SHARED_DSQ);
+				return;
+			}
+			if (!cpuc->dsp_cnt)
+				break;
+		}
+
+		cpuc->dsp_cnt = 0;
+	}
+}
+
+s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	/*
+	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
+	 * in this function and the following will automatically use GFP_KERNEL.
+	 */
+	if (bpf_task_storage_get(&task_ctx_stor, p, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return 0;
+	else
+		return -ENOMEM;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
+{
+	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+}
+
+void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(qmap_ops,
+	       .select_cpu		= (void *)qmap_select_cpu,
+	       .enqueue			= (void *)qmap_enqueue,
+	       .dequeue			= (void *)qmap_dequeue,
+	       .dispatch		= (void *)qmap_dispatch,
+	       .init_task		= (void *)qmap_init_task,
+	       .init			= (void *)qmap_init,
+	       .exit			= (void *)qmap_exit,
+	       .name			= "qmap");
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
new file mode 100644
index 000000000000..7c84ade7ecfb
--- /dev/null
+++ b/tools/sched_ext/scx_qmap.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_qmap.bpf.skel.h"
+
+const char help_fmt[] =
+"A simple five-level FIFO queue sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-b COUNT] [-p] [-v]\n"
+"\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
+"  -b COUNT      Dispatch upto COUNT tasks together\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static volatile int exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_qmap *skel;
+	struct bpf_link *link;
+	int opt;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
+
+	while ((opt = getopt(argc, argv, "s:e:b:pvh")) != -1) {
+		switch (opt) {
+		case 's':
+			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
+			break;
+		case 'e':
+			skel->bss->test_error_cnt = strtoul(optarg, NULL, 0);
+			break;
+		case 'b':
+			skel->rodata->dsp_batch = strtoul(optarg, NULL, 0);
+			break;
+		case 'p':
+			skel->struct_ops.qmap_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap);
+	link = SCX_OPS_ATTACH(skel, qmap_ops, scx_qmap);
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		long nr_enqueued = skel->bss->nr_enqueued;
+		long nr_dispatched = skel->bss->nr_dispatched;
+
+		printf("stats  : enq=%lu dsp=%lu delta=%ld deq=%"PRIu64"\n",
+		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
+		       skel->bss->nr_dequeued);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	UEI_REPORT(skel, uei);
+	scx_qmap__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
new file mode 100644
index 000000000000..6bb13a3c801b
--- /dev/null
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple scheduler.
+ *
+ * A simple global FIFO scheduler. It also demonstrates the following niceties.
+ *
+ * - Statistics tracking how many tasks are queued to local and global dsq's.
+ * - Termination notification for userspace.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, 2);			/* [local, global] */
+} stats SEC(".maps");
+
+static void stat_inc(u32 idx)
+{
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
+	if (cnt_p)
+		(*cnt_p)++;
+}
+
+s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	bool is_idle = false;
+	s32 cpu;
+
+	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
+	if (is_idle) {
+		stat_inc(0);	/* count local queueing */
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+	}
+
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	stat_inc(1);	/* count global queueing */
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(simple_ops,
+	       .select_cpu		= (void *)simple_select_cpu,
+	       .enqueue			= (void *)simple_enqueue,
+	       .exit			= (void *)simple_exit,
+	       .name			= "simple");
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
new file mode 100644
index 000000000000..789ac62fea8e
--- /dev/null
+++ b/tools/sched_ext/scx_simple.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_simple.bpf.skel.h"
+
+const char help_fmt[] =
+"A simple sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-v]\n"
+"\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static volatile int exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int simple)
+{
+	exit_req = 1;
+}
+
+static void read_stats(struct scx_simple *skel, __u64 *stats)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	__u64 cnts[2][nr_cpus];
+	__u32 idx;
+
+	memset(stats, 0, sizeof(stats[0]) * 2);
+
+	for (idx = 0; idx < 2; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_simple *skel;
+	struct bpf_link *link;
+	__u32 opt;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	skel = SCX_OPS_OPEN(simple_ops, scx_simple);
+
+	while ((opt = getopt(argc, argv, "vh")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	SCX_OPS_LOAD(skel, simple_ops, scx_simple);
+	link = SCX_OPS_ATTACH(skel, simple_ops, scx_simple);
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		__u64 stats[2];
+
+		read_stats(skel, stats);
+		printf("local=%llu global=%llu\n", stats[0], stats[1]);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	UEI_REPORT(skel, uei);
+	scx_simple__destroy(skel);
+	return 0;
+}
-- 
2.45.2


