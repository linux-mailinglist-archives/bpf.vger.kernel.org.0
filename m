Return-Path: <bpf+bounces-14832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C021D7E8881
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE39B20BA0
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41432525B;
	Sat, 11 Nov 2023 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcdMdrsO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232121860
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:52 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF2649FC;
	Fri, 10 Nov 2023 18:49:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so24194085ad.0;
        Fri, 10 Nov 2023 18:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670961; x=1700275761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ5M0ekdoeeO8ycO3mOcx5fgpAqMewpNgK5YUYDt5X8=;
        b=UcdMdrsODI1DsldECn7x2eJblfOeinNk9yAtzqNfT/W0KYCWmn6pVdDxBY7TMpQbEd
         e2lNrVZxigETvkGK46MHoDsCFdNGXLq0AxQ3LoMEGakbNMOHu9xtB4Z6n2NpssCPcsJB
         5CZPORwgdyar3w4C9Y8GjYTddIXQKxK6uM7Tc8fCIqlTB3o7qpwsv4U0QMJ60DM7D3zj
         T3nQmNmcbEhs/sLmMJN3gw+XuB8foOl6hPbQY9xHIjDgS8M7s2Y44H9l7ajtUGe8tyQS
         jzwJKT6FJ/xwqbTzlITSwZdSpIJb8rSv8vyMII1LOBwzGSwQsU/tNDYzZrv56EqslwrO
         NTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670961; x=1700275761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZ5M0ekdoeeO8ycO3mOcx5fgpAqMewpNgK5YUYDt5X8=;
        b=wzUB0QcImJpKdXZ5EDij3LmWEN28pY9KaGp58WQfI/q9HxvCqrrDQv2Fq9m3Gpc0vJ
         xNoowWnoXSoNS+0Q+MVqWAu2dFP44SAyEQx9FSDlfwlQQ1ZURfu1glNSkzrC7IL/erZz
         3/hR0skcYf5jsWbVisi4R0yfiwMlmezqmbrijA/gYMEEI2yxxX8xpGrHcxhhVXz3IYBX
         kHXHU0T49Zo1pQ8Pr3sdjIdDARSJEvTLRNjIHkPS4wnwrLi6xgWriDQWvAFr94D0Iin3
         3H3VXfTe4sNM7Gm9a1VHbVJrD4ZcHcj9Gdgp2KQqIEKV7GHXLWyT5Y0CEwXGnmNEdmtn
         LWzw==
X-Gm-Message-State: AOJu0YzlDKO5R7+hdzwyYMk/0LZ+uf2eYEZSWa5mNDeHfXBu/zpwzEEP
	R9/uNbKu85On4j/KbAKexko=
X-Google-Smtp-Source: AGHT+IG9Zy4BoIR4g40FV40z/bsxgu+q0is4TJOsZRfCcqkeOJBGYH6K0NJXTiWIIRz11+p3TH2Qvg==
X-Received: by 2002:a17:902:9687:b0:1cc:3b86:cfc5 with SMTP id n7-20020a170902968700b001cc3b86cfc5mr1025540plp.4.1699670960403;
        Fri, 10 Nov 2023 18:49:20 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b001bc675068e2sm354816plg.111.2023.11.10.18.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:19 -0800 (PST)
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
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/36] sched_ext: Add scx_simple and scx_example_qmap example schedulers
Date: Fri, 10 Nov 2023 16:47:39 -1000
Message-ID: <20231111024835.2164816-14-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
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

v5: * Improve Makefile. Build artifects are now collected into a separate
      dir which change be changed. Install and help targets are added and
      clean actually cleans everything.

    * MEMBER_VPTR() improved to improve access to structs. ARRAY_ELEM_PTR()
      and RESIZEABLE_ARRAY() are added to support resizable arrays in .bss.

    * Add scx_common.h which provides common utilities to user code such as
      SCX_BUG[_ON]() and RESIZE_ARRAY().

    * Use SCX_BUG[_ON]() to simplify error handling.

v4: * Dropped _example prefix from scheduler names.

v3: * Rename scx_example_dummy to scx_example_simple and restructure a bit
      to ease later additions. Comment updates.

    * Added declarations for BPF inline iterators. In the future, hopefully,
      these will be consolidated into a generic BPF header so that they
      don't need to be replicated here.

v2: * Updated with the generic BPF cpumask helpers.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 Makefile                         |   8 +-
 tools/Makefile                   |  10 +-
 tools/sched_ext/.gitignore       |   6 +
 tools/sched_ext/Kconfig          |   9 ++
 tools/sched_ext/Makefile         | 249 +++++++++++++++++++++++++++++++
 tools/sched_ext/gnu/stubs.h      |   1 +
 tools/sched_ext/scx_common.bpf.h | 239 +++++++++++++++++++++++++++++
 tools/sched_ext/scx_common.h     |  59 ++++++++
 tools/sched_ext/scx_qmap.bpf.c   | 241 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c       |  82 ++++++++++
 tools/sched_ext/scx_simple.bpf.c |  56 +++++++
 tools/sched_ext/scx_simple.c     |  91 +++++++++++
 tools/sched_ext/user_exit_info.h |  50 +++++++
 13 files changed, 1099 insertions(+), 2 deletions(-)
 create mode 100644 tools/sched_ext/.gitignore
 create mode 100644 tools/sched_ext/Kconfig
 create mode 100644 tools/sched_ext/Makefile
 create mode 100644 tools/sched_ext/gnu/stubs.h
 create mode 100644 tools/sched_ext/scx_common.bpf.h
 create mode 100644 tools/sched_ext/scx_common.h
 create mode 100644 tools/sched_ext/scx_qmap.bpf.c
 create mode 100644 tools/sched_ext/scx_qmap.c
 create mode 100644 tools/sched_ext/scx_simple.bpf.c
 create mode 100644 tools/sched_ext/scx_simple.c
 create mode 100644 tools/sched_ext/user_exit_info.h

diff --git a/Makefile b/Makefile
index c3ba618ca6a4..89cf28b5ac21 100644
--- a/Makefile
+++ b/Makefile
@@ -1341,6 +1341,12 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
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
@@ -1510,7 +1516,7 @@ PHONY += $(mrproper-dirs) mrproper
 $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
 
-mrproper: clean $(mrproper-dirs)
+mrproper: clean $(mrproper-dirs) tools_clean
 	$(call cmd,rmfiles)
 	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.rmeta' \) \
diff --git a/tools/Makefile b/tools/Makefile
index 37e9f6804832..8021267f7e5b 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -29,6 +29,7 @@ include scripts/Makefile.include
 	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
+	@echo '  sched_ext              - sched_ext example schedulers'
 	@echo '  bootconfig             - boot config tool'
 	@echo '  spi                    - spi tools'
 	@echo '  tmon                   - thermal monitoring and tuning tool'
@@ -92,6 +93,9 @@ perf: FORCE
 	$(Q)mkdir -p $(PERF_O) .
 	$(Q)$(MAKE) --no-print-directory -C perf O=$(PERF_O) subdir=
 
+sched_ext: FORCE
+	$(call descend,sched_ext)
+
 selftests: FORCE
 	$(call descend,testing/$@)
 
@@ -185,6 +189,9 @@ install: acpi_install cgroup_install counter_install cpupower_install gpio_insta
 	$(Q)mkdir -p $(PERF_O) .
 	$(Q)$(MAKE) --no-print-directory -C perf O=$(PERF_O) subdir= clean
 
+sched_ext_clean:
+	$(call descend,sched_ext,clean)
+
 selftests_clean:
 	$(call descend,testing/$(@:_clean=),clean)
 
@@ -214,6 +221,7 @@ clean: acpi_clean cgroup_clean counter_clean cpupower_clean hv_clean firewire_cl
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
-		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean
+		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
+		sched_ext_clean
 
 .PHONY: FORCE
diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
new file mode 100644
index 000000000000..00e0eef67b7b
--- /dev/null
+++ b/tools/sched_ext/.gitignore
@@ -0,0 +1,6 @@
+scx_simple
+scx_qmap
+*.skel.h
+*.subskel.h
+/tools/
+build/
diff --git a/tools/sched_ext/Kconfig b/tools/sched_ext/Kconfig
new file mode 100644
index 000000000000..6543fcf199f6
--- /dev/null
+++ b/tools/sched_ext/Kconfig
@@ -0,0 +1,9 @@
+CONFIG_BPF=y
+CONFIG_SCHED_CLASS_EXT=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_JIT_DEFAULT_ON=y
+CONFIG_PAHOLE_HAS_SPLIT_BTF=y
+CONFIG_PAHOLE_HAS_BTF_TAG=y
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
new file mode 100644
index 000000000000..1f306d54fdc8
--- /dev/null
+++ b/tools/sched_ext/Makefile
@@ -0,0 +1,249 @@
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
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
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
+	  -I$(TOOLSINCDIR) -I$(APIDIR)
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
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)				\
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
+$(SCXOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h scx_common.bpf.h	\
+		       user_exit_info.h						\
+		       | $(BPFOBJ) $(SCXOBJ_DIR)
+	$(call msg,CLNG-BPF,,$(notdir $@))
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(INCLUDE_DIR)/%.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL)
+	$(eval sched=$(notdir $@))
+	$(call msg,GEN-SKEL,,$(sched))
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
+	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(subst .skel.h,,$(sched)) > $@
+	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(subst .skel.h,,$(sched)) > $(@:.skel.h=.subskel.h)
+
+SCX_COMMON_DEPS := scx_common.h user_exit_info.h | $(BINDIR)
+
+################
+# C schedulers #
+################
+c-sched-targets = scx_simple scx_qmap
+
+$(addprefix $(BINDIR)/,$(c-sched-targets)): \
+	$(BINDIR)/%: \
+		$(filter-out %.bpf.c,%.c) \
+		$(INCLUDE_DIR)/%.skel.h \
+		$(SCX_COMMON_DEPS)
+	$(eval sched=$(notdir $@))
+	$(CC) $(CFLAGS) -c $(sched).c -o $(SCXOBJ_DIR)/$(sched).o
+	$(CC) -o $@ $(SCXOBJ_DIR)/$(sched).o $(HOST_BPFOBJ) $(LDFLAGS)
+$(c-sched-targets): %: $(BINDIR)/%
+
+install: all
+	$(Q)mkdir -p $(DESTDIR)/usr/local/bin/
+	$(Q)cp $(BINDIR)/* $(DESTDIR)/usr/local/bin/
+
+clean:
+	rm -rf $(OUTPUT_DIR) $(HOST_OUTPUT_DIR)
+	rm -f *.o *.bpf.o *.skel.h *.subskel.h
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
+	@printf '  %s\n' $(c-sched-targets) $(rust-sched-targets)
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
+	@echo   '  clean		  - Remove all generated files, including intermediate'
+	@echo   '                    rust files for rust schedulers.'
+
+all_targets: $(c-sched-targets) $(rust-sched-targets)
+
+.PHONY: all all_targets $(c-sched-targets) $(rust-sched-targets) clean help
+
+# delete failed targets
+.DELETE_ON_ERROR:
+
+# keep intermediate (.skel.h, .bpf.o, etc) targets
+.SECONDARY:
diff --git a/tools/sched_ext/gnu/stubs.h b/tools/sched_ext/gnu/stubs.h
new file mode 100644
index 000000000000..719225b16626
--- /dev/null
+++ b/tools/sched_ext/gnu/stubs.h
@@ -0,0 +1 @@
+/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
new file mode 100644
index 000000000000..cfd3122244eb
--- /dev/null
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#ifndef __SCHED_EXT_COMMON_BPF_H
+#define __SCHED_EXT_COMMON_BPF_H
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/errno.h>
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
+void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
+
+static inline __attribute__((format(printf, 1, 2)))
+void ___scx_bpf_error_format_checker(const char *fmt, ...) {}
+
+/*
+ * scx_bpf_error() wraps the scx_bpf_error_bstr() kfunc with variadic arguments
+ * instead of an array of u64. Note that __param[] must have at least one
+ * element to keep the verifier happy.
+ */
+#define scx_bpf_error(fmt, args...)						\
+({										\
+	static char ___fmt[] = fmt;						\
+	unsigned long long ___param[___bpf_narg(args) ?: 1] = {};		\
+										\
+	_Pragma("GCC diagnostic push")						\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
+	___bpf_fill(___param, args);						\
+	_Pragma("GCC diagnostic pop")						\
+										\
+	scx_bpf_error_bstr(___fmt, ___param, sizeof(___param));			\
+										\
+	___scx_bpf_error_format_checker(fmt, ##args);				\
+})
+
+s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
+bool scx_bpf_consume(u64 dsq_id) __ksym;
+u32 scx_bpf_dispatch_nr_slots(void) __ksym;
+void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
+bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
+s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
+void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
+void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+bool scx_bpf_task_running(const struct task_struct *p) __ksym;
+s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
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
+#define MEMBER_VPTR(base, member) (typeof((base) member) *)({			\
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
+#define ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)({	  \
+	u64 __base = (u64)arr;				  \
+	u64 __addr = (u64)&(arr[i]) - __base;		  \
+	asm volatile (					  \
+		"if %0 <= %[max] goto +2\n"		  \
+		"%0 = 0\n"				  \
+		"goto +1\n"				  \
+		"%0 += %1\n"				  \
+		: "+r"(__addr)				  \
+		: "r"(__base),				  \
+		  [max]"r"(sizeof(arr[0]) * ((n) - 1)));  \
+	__addr;						  \
+})
+
+/*
+ * BPF core and other generic helpers
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
+#endif	/* __SCHED_EXT_COMMON_BPF_H */
diff --git a/tools/sched_ext/scx_common.h b/tools/sched_ext/scx_common.h
new file mode 100644
index 000000000000..0e93d6b697b8
--- /dev/null
+++ b/tools/sched_ext/scx_common.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ */
+#ifndef __SCHED_EXT_COMMON_H
+#define __SCHED_EXT_COMMON_H
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "user_exit_info.h"
+
+#ifdef __KERNEL__
+#error "Should not be included by BPF programs"
+#endif
+
+#define SCX_BUG(__fmt, ...)							\
+	do {									\
+		fprintf(stderr, "%s:%d [scx panic]: %s\n", __FILE__, __LINE__,	\
+			strerror(errno));					\
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
+ * @elfsec: the data section of the BPF program in which to the array exists
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
+#define RESIZE_ARRAY(elfsec, arr, n)						  \
+	do {									  \
+		size_t __sz;							  \
+		bpf_map__set_value_size(skel->maps.elfsec##_##arr,		  \
+				sizeof(skel->elfsec##_##arr->arr[0]) * (n));	  \
+		skel->elfsec##_##arr =						  \
+			bpf_map__initial_value(skel->maps.elfsec##_##arr, &__sz); \
+	} while (0)
+
+#endif	/* __SCHED_EXT_COMMON_H */
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
new file mode 100644
index 000000000000..686681e2008a
--- /dev/null
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -0,0 +1,241 @@
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
+#include "scx_common.bpf.h"
+#include <linux/sched/prio.h>
+
+char _license[] SEC("license") = "GPL";
+
+const volatile u64 slice_ns = SCX_SLICE_DFL;
+
+u32 test_error_cnt;
+
+struct user_exit_info uei;
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
+/* Per-cpu dispatch index and remaining count */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, u32);
+	__type(value, u64);
+} dispatch_idx_cnt SEC(".maps");
+
+/* Statistics */
+unsigned long nr_enqueued, nr_dispatched, nr_dequeued;
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
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, enq_flags);
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
+	u32 zero = 0, one = 1;
+	u64 *idx = bpf_map_lookup_elem(&dispatch_idx_cnt, &zero);
+	u64 *cnt = bpf_map_lookup_elem(&dispatch_idx_cnt, &one);
+	void *fifo;
+	s32 pid;
+	int i;
+
+	if (!idx || !cnt) {
+		scx_bpf_error("failed to lookup idx[%p], cnt[%p]", idx, cnt);
+		return;
+	}
+
+	for (i = 0; i < 5; i++) {
+		/* Advance the dispatch cursor and pick the fifo. */
+		if (!*cnt) {
+			*idx = (*idx + 1) % 5;
+			*cnt = 1 << *idx;
+		}
+		(*cnt)--;
+
+		fifo = bpf_map_lookup_elem(&queue_arr, idx);
+		if (!fifo) {
+			scx_bpf_error("failed to find ring %llu", *idx);
+			return;
+		}
+
+		/* Dispatch or advance. */
+		if (!bpf_map_pop_elem(fifo, &pid)) {
+			struct task_struct *p;
+
+			p = bpf_task_from_pid(pid);
+			if (p) {
+				__sync_fetch_and_add(&nr_dispatched, 1);
+				scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, 0);
+				bpf_task_release(p);
+				return;
+			}
+		}
+
+		*cnt = 0;
+	}
+}
+
+s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
+		   struct scx_enable_args *args)
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
+void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops qmap_ops = {
+	.select_cpu		= (void *)qmap_select_cpu,
+	.enqueue		= (void *)qmap_enqueue,
+	.dequeue		= (void *)qmap_dequeue,
+	.dispatch		= (void *)qmap_dispatch,
+	.prep_enable		= (void *)qmap_prep_enable,
+	.exit			= (void *)qmap_exit,
+	.name			= "qmap",
+};
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
new file mode 100644
index 000000000000..b250cbb851cc
--- /dev/null
+++ b/tools/sched_ext/scx_qmap.c
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "scx_common.h"
+#include "scx_qmap.skel.h"
+
+const char help_fmt[] =
+"A simple five-level FIFO queue sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-s SLICE_US] [-e COUNT]\n"
+"\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
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
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_qmap__open();
+	SCX_BUG_ON(!skel, "Failed to open skel");
+
+	while ((opt = getopt(argc, argv, "s:e:tTd:h")) != -1) {
+		switch (opt) {
+		case 's':
+			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
+			break;
+		case 'e':
+			skel->bss->test_error_cnt = strtoul(optarg, NULL, 0);
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	SCX_BUG_ON(scx_qmap__load(skel), "Failed to load skel");
+
+	link = bpf_map__attach_struct_ops(skel->maps.qmap_ops);
+	SCX_BUG_ON(!link, "Failed to attach struct_ops");
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		long nr_enqueued = skel->bss->nr_enqueued;
+		long nr_dispatched = skel->bss->nr_dispatched;
+
+		printf("enq=%lu, dsp=%lu, delta=%ld, deq=%lu\n",
+		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
+		       skel->bss->nr_dequeued);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_qmap__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
new file mode 100644
index 000000000000..9326124a32fa
--- /dev/null
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -0,0 +1,56 @@
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
+#include "scx_common.bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct user_exit_info uei;
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
+void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (enq_flags & SCX_ENQ_LOCAL) {
+		stat_inc(0);	/* count local queueing */
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	stat_inc(1);	/* count global queueing */
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops simple_ops = {
+	.enqueue		= (void *)simple_enqueue,
+	.exit			= (void *)simple_exit,
+	.name			= "simple",
+};
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
new file mode 100644
index 000000000000..c282674af8c3
--- /dev/null
+++ b/tools/sched_ext/scx_simple.c
@@ -0,0 +1,91 @@
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
+#include "scx_common.h"
+#include "scx_simple.skel.h"
+
+const char help_fmt[] =
+"A simple sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s\n"
+"\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
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
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_simple__open();
+	SCX_BUG_ON(!skel, "Failed to open skel");
+
+	while ((opt = getopt(argc, argv, "h")) != -1) {
+		switch (opt) {
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	SCX_BUG_ON(scx_simple__load(skel), "Failed to load skel");
+
+	link = bpf_map__attach_struct_ops(skel->maps.simple_ops);
+	SCX_BUG_ON(!link, "Failed to attach struct_ops");
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		__u64 stats[2];
+
+		read_stats(skel, stats);
+		printf("local=%llu global=%llu\n", stats[0], stats[1]);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_simple__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/user_exit_info.h b/tools/sched_ext/user_exit_info.h
new file mode 100644
index 000000000000..f0e45bf3c766
--- /dev/null
+++ b/tools/sched_ext/user_exit_info.h
@@ -0,0 +1,50 @@
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
+struct user_exit_info {
+	int		kind;
+	char		reason[128];
+	char		msg[1024];
+};
+
+#ifdef __bpf__
+
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
+
+static inline void uei_record(struct user_exit_info *uei,
+			      const struct scx_exit_info *ei)
+{
+	bpf_probe_read_kernel_str(uei->reason, sizeof(uei->reason), ei->reason);
+	bpf_probe_read_kernel_str(uei->msg, sizeof(uei->msg), ei->msg);
+	/* use __sync to force memory barrier */
+	__sync_val_compare_and_swap(&uei->kind, uei->kind, ei->kind);
+}
+
+#else	/* !__bpf__ */
+
+static inline bool uei_exited(struct user_exit_info *uei)
+{
+	/* use __sync to force memory barrier */
+	return __sync_val_compare_and_swap(&uei->kind, -1, -1);
+}
+
+static inline void uei_print(const struct user_exit_info *uei)
+{
+	fprintf(stderr, "EXIT: %s", uei->reason);
+	if (uei->msg[0] != '\0')
+		fprintf(stderr, " (%s)", uei->msg);
+	fputs("\n", stderr);
+}
+
+#endif	/* __bpf__ */
+#endif	/* __USER_EXIT_INFO_H */
-- 
2.42.0


