Return-Path: <bpf+bounces-48081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C0EA03EB4
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A8161287
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446D1F0E31;
	Tue,  7 Jan 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XblYy8Aq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1E1F0E59;
	Tue,  7 Jan 2025 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251747; cv=none; b=XaaoKtJGdyWJYMBJVphzAfJTyn1XvDWyxaqK7lCUi+qrPDre3bKazGpGeZcWDysP17C0KrRJJCR3uy4DklrBogfWSCU6Z06/cO7XRY3J9UTpsYPwwkcEmJctfph628lyJLXa6agwzp6PrdieZQQOpi8sIi74nUGRWsURkylDZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251747; c=relaxed/simple;
	bh=osXqyXtH97CQoBSxxuv95CbBgzFwd3GgTgbhpFmavPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKzBQpk9jpMbnxDgzd+Gt3wegAbVnvC4DyHgV1XKd/q40AFlV2rE3gms0lLRzuqDXqxkPdE2zI8rRCBrWwW1N3OzTBPPWaMor7amRn53ZKTjtrrWke4J0qm2inFDXpYD9K7NpT/33SVG6rlZmYfJ7VEG8oKIrjBkZULjP5j3iI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XblYy8Aq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21628b3fe7dso218298485ad.3;
        Tue, 07 Jan 2025 04:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251713; x=1736856513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4nYY5xKQLCD4XShiwpYWdqCAPwF8iOC/Na9Gt3GaZA=;
        b=XblYy8Aq3v2E0lH4WL4mO2OMCIFXNpQR9dtxM/RQ9zB3KpIoGjmDLfUPRapWeU7d7A
         YE2YtNBuGPOy6KF1+2xb/hUPzno6UqLTg7XPIDkyXWu6Wt8wPIWcvSxy2WavX0CkGEar
         E5E3YTEivsz6qhegKbEfJ4wZSmcvM6Y7V4podKuSo/09YMeUjYMa65G4af44xXLTJGtQ
         pAIZE0qW5u6Kwhnpu7MD/MT+/GLfuiWu8Mm4n8djUUpdPku/ffVaXMv1lPeTUQrwClsI
         JqiDKRvdmj5k7triPWnB8tui9NOFk40ZPCS27p33H8YsMOK5Qw+BDaoX9125BizR655q
         94uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251713; x=1736856513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4nYY5xKQLCD4XShiwpYWdqCAPwF8iOC/Na9Gt3GaZA=;
        b=eX9wBCtZCoPt0AShLGs/MAQuaBnMR91T+rzcaCstkgNeESvQtlrZ6W6RYo9pl1o9AJ
         4s8WwjHhDb6O6SjTnSCOTz4xQYczHa39qqCXDdptsNo73jHPK7S0OIYeNlYZHLBuR0E1
         lNOdyIQj7+azPoEMa6cKPyURFjsegf/oDJxlax9z1vQsh+QG1c/pGXIVvB1UOTPE7spK
         uksU7FxbEjgka/XEhe2YlfHDy1K29WBs0VQPFf3hSPtKUExqZtVOsM83YDb6gBSTf9ir
         y26b1Y/pV5sMhZsEujkBiXAjEvDFA77Q++mhcvMYaxI6aWZGzFW/wrsne/MVS0hmtVV3
         NpuA==
X-Forwarded-Encrypted: i=1; AJvYcCWiR5u80Ie7NsgYdNVtt7DkcK04G2loVthwsbxxawqrZoTdyXnm+8XcX02uz6/daAzib8uxuR7FuwF3Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZeD8+cGn2JW1sZwfgymNC+An86KzGVHi5c3qmsUcm5rjraWP
	M9g1TGL/Gl5KArcfIvLfTt1cXQkrfNn3fnfdVXegoX21kaF5WyXe
X-Gm-Gg: ASbGncs8vU4/oNJ9ySKQUi2qXE6OvkXgeYmTqz2OeTfrg3jcrJEces4K6SJJZX+vz15
	8t1bSkNGBG7yMqr5Lp8ndZyj99I3bJHfen1VBoqEmCYXUBuQJ3HDrVVehn8rEipYw36DAbKfsh2
	7OZZccx7rp9Jr3QFUIhQGhIZkzGDwJIL6ANJVVRLIXjDHfxIE2son0mU9JOLKTFTSl0aqybUhi0
	sGX0zGLG9kyTrQYaByQ4NE9q+cdpEKateZe3Jx5w/wzaS2G4HtIuNDWxhbu4GWsZI+5
X-Google-Smtp-Source: AGHT+IHZlURjqM3y/sGFhkSGNyXbWo2j4kS0GhxooVVRsPDjTzPI7x/tvW7VJh703YmygTU8PIWRZw==
X-Received: by 2002:a05:6a20:431d:b0:1e1:bf3d:a190 with SMTP id adf61e73a8af0-1e5e080c83fmr92989330637.30.1736251712681;
        Tue, 07 Jan 2025 04:08:32 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:32 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 12/22] selftests: ublk: add tests for the ublk-bpf initial implementation
Date: Tue,  7 Jan 2025 20:04:03 +0800
Message-ID: <20250107120417.1237392-13-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create one ublk null target over ublk-bpf, in which every block IO is
handled by the `ublk_null` bpf prog. And the whole ublk implementation
requires liburing.

Meantime add basic read/write IO test over this ublk null disk, and make
sure basic IO function works as expected.

ublk/Makefile is stolen from tools/testing/selftests/hid/Makefile

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 MAINTAINERS                                   |    1 +
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/ublk/.gitignore       |    4 +
 tools/testing/selftests/ublk/Makefile         |  228 +++
 tools/testing/selftests/ublk/config           |    2 +
 tools/testing/selftests/ublk/progs/ublk_bpf.h |   13 +
 .../selftests/ublk/progs/ublk_bpf_kfunc.h     |   23 +
 .../testing/selftests/ublk/progs/ublk_null.c  |   63 +
 tools/testing/selftests/ublk/test_common.sh   |   72 +
 tools/testing/selftests/ublk/test_null_01.sh  |   19 +
 tools/testing/selftests/ublk/test_null_02.sh  |   23 +
 tools/testing/selftests/ublk/ublk_bpf.c       | 1429 +++++++++++++++++
 12 files changed, 1878 insertions(+)
 create mode 100644 tools/testing/selftests/ublk/.gitignore
 create mode 100644 tools/testing/selftests/ublk/Makefile
 create mode 100644 tools/testing/selftests/ublk/config
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_bpf.h
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_null.c
 create mode 100755 tools/testing/selftests/ublk/test_common.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_02.sh
 create mode 100644 tools/testing/selftests/ublk/ublk_bpf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 890f6195d03f..8ff8773377c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23984,6 +23984,7 @@ S:	Maintained
 F:	Documentation/block/ublk.rst
 F:	drivers/block/ublk/
 F:	include/uapi/linux/ublk_cmd.h
+F:	tools/testing/selftests/ublk/
 
 UBSAN
 M:	Kees Cook <kees@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2401e973c359..1c20256e662b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -111,6 +111,7 @@ endif
 TARGETS += tmpfs
 TARGETS += tpm2
 TARGETS += tty
+TARGETS += ublk
 TARGETS += uevent
 TARGETS += user_events
 TARGETS += vDSO
diff --git a/tools/testing/selftests/ublk/.gitignore b/tools/testing/selftests/ublk/.gitignore
new file mode 100644
index 000000000000..865dca93cf75
--- /dev/null
+++ b/tools/testing/selftests/ublk/.gitignore
@@ -0,0 +1,4 @@
+ublk_bpf
+*.skel.h
+/tools
+*-verify.state
diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
new file mode 100644
index 000000000000..a95f317211e7
--- /dev/null
+++ b/tools/testing/selftests/ublk/Makefile
@@ -0,0 +1,228 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# based on tools/testing/selftest/bpf/Makefile
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+
+CXX ?= $(CROSS_COMPILE)g++
+
+HOSTPKG_CONFIG := pkg-config
+
+CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -I$(OUTPUT)/tools/include
+
+LDLIBS += -lelf -lz -lrt -lpthread -luring
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+TEST_PROGS := test_null_01.sh
+TEST_PROGS += test_null_02.sh
+
+# Order correspond to 'make run_tests' order
+TEST_GEN_PROGS_EXTENDED = ublk_bpf
+
+# Emit succinct information message describing current building step
+# $1 - generic step name (e.g., CC, LINK, etc);
+# $2 - optional "flavor" specifier; if provided, will be emitted as [flavor];
+# $3 - target (assumed to be file); only file name will be emitted;
+# $4 - optional extra arg, emitted as-is, if provided.
+ifeq ($(V),1)
+Q =
+msg =
+else
+Q = @
+msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
+MAKEFLAGS += --no-print-directory
+submake_extras := feature_display=0
+endif
+
+# override lib.mk's default rules
+OVERRIDE_TARGETS := 1
+override define CLEAN
+	$(call msg,CLEAN)
+	$(Q)$(RM) -r $(TEST_GEN_PROGS)
+	$(Q)$(RM) -r $(EXTRA_CLEAN)
+endef
+
+include ../lib.mk
+
+TOOLSDIR := $(top_srcdir)/tools
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+SCRATCH_DIR := $(OUTPUT)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+INCLUDE_DIR := $(SCRATCH_DIR)/include
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(BUILD_DIR)/host
+HOST_SCRATCH_DIR	:= $(OUTPUT)/host-tools
+HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
+else
+HOST_BUILD_DIR		:= $(BUILD_DIR)
+HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
+HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+
+VMLINUX_BTF_PATHS ?= /sys/kernel/btf/ublk_drv
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+# Define simple and short `make test_progs`, `make test_sysctl`, etc targets
+# to build individual tests.
+# NOTE: Semicolon at the end is critical to override lib.mk's default static
+# rule for binaries.
+$(notdir $(TEST_GEN_PROGS)): %: $(OUTPUT)/% ;
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids	\
+	       $(INCLUDE_DIR))
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+# LLVM's ld.lld doesn't support all the architectures, so use it only on x86
+ifeq ($(SRCARCH),x86)
+LLD := lld
+else
+LLD := ld
+endif
+
+DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
+
+TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
+
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
+		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) 	       \
+		    EXTRA_CFLAGS='-g -O0'				       \
+		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
+		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
+		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
+		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
+	   | $(BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
+		    EXTRA_CFLAGS='-g -O0'				       \
+		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
+
+ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
+$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
+		| $(HOST_BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
+		    EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=		       \
+		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD) \
+		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
+endif
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
+$(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
+		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
+		       $(TOOLSDIR)/lib/rbtree.c			\
+		       $(TOOLSDIR)/lib/zalloc.c			\
+		       $(TOOLSDIR)/lib/string.c			\
+		       $(TOOLSDIR)/lib/ctype.c			\
+		       $(TOOLSDIR)/lib/str_error_r.c
+	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/resolve_btfids	\
+		CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) \
+		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
+		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '--target=bpf'. This fixes "missing" files on some architectures/distros,
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
+# Determine target endianness.
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
+BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
+	     -I$(INCLUDE_DIR)
+
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
+	       -Wno-compare-distinct-pointer-types
+
+# Build BPF object using Clang
+# $1 - input .c file
+# $2 - output .o file
+# $3 - CFLAGS
+define CLANG_BPF_BUILD_RULE
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
+endef
+# Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
+define CLANG_NOALU32_BPF_BUILD_RULE
+	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
+endef
+# Build BPF object using GCC
+define GCC_BPF_BUILD_RULE
+	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
+	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
+endef
+
+BPF_PROGS_DIR := progs
+BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
+BPF_SRCS := $(notdir $(wildcard $(BPF_PROGS_DIR)/*.c))
+BPF_OBJS := $(patsubst %.c,$(OUTPUT)/%.bpf.o, $(BPF_SRCS))
+BPF_SKELS := $(patsubst %.c,$(OUTPUT)/%.skel.h, $(BPF_SRCS))
+TEST_GEN_FILES += $(BPF_OBJS)
+
+$(BPF_PROGS_DIR)-bpfobjs := y
+$(BPF_OBJS): $(OUTPUT)/%.bpf.o:				\
+	     $(BPF_PROGS_DIR)/%.c			\
+	     $(wildcard $(BPF_PROGS_DIR)/*.h)		\
+	     $(INCLUDE_DIR)/vmlinux.h				\
+	     $(wildcard $(BPFDIR)/ublk_bpf_*.h)			\
+	     $(wildcard $(BPFDIR)/*.bpf.h)			\
+	     | $(OUTPUT) $(BPFOBJ)
+	$(call $(BPF_BUILD_RULE),$<,$@, $(BPF_CFLAGS))
+
+$(BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(OUTPUT)
+	$(call msg,GEN-SKEL,$(BINARY),$@)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked1.o) name $(notdir $(<:.bpf.o=)) > $@
+
+$(OUTPUT)/%.o: %.c $(BPF_SKELS)
+	$(call msg,CC,,$@)
+	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
+
+$(OUTPUT)/%: $(OUTPUT)/%.o
+	$(call msg,BINARY,,$@)
+	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
+
+EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR) feature bpftool	\
+	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32)
diff --git a/tools/testing/selftests/ublk/config b/tools/testing/selftests/ublk/config
new file mode 100644
index 000000000000..295b1f5c6c6c
--- /dev/null
+++ b/tools/testing/selftests/ublk/config
@@ -0,0 +1,2 @@
+CONFIG_BLK_DEV_UBLK=m
+CONFIG_UBLK_BPF=y
diff --git a/tools/testing/selftests/ublk/progs/ublk_bpf.h b/tools/testing/selftests/ublk/progs/ublk_bpf.h
new file mode 100644
index 000000000000..a302a645b096
--- /dev/null
+++ b/tools/testing/selftests/ublk/progs/ublk_bpf.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef UBLK_BPF_GEN_H
+#define UBLK_BPF_GEN_H
+
+#include "ublk_bpf_kfunc.h"
+
+#ifdef DEBUG
+#define BPF_DBG(...) bpf_printk(__VA_ARGS__)
+#else
+#define BPF_DBG(...)
+#endif
+
+#endif
diff --git a/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h b/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
new file mode 100644
index 000000000000..acab490d933c
--- /dev/null
+++ b/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef UBLK_BPF_INTERNAL_H
+#define UBLK_BPF_INTERNAL_H
+
+#ifndef BITS_PER_LONG
+#define BITS_PER_LONG	(sizeof(unsigned long) * 8)
+#endif
+
+#define UBLK_BPF_DISPOSITION_BITS       (4)
+#define UBLK_BPF_DISPOSITION_SHIFT      (BITS_PER_LONG - UBLK_BPF_DISPOSITION_BITS)
+
+static inline ublk_bpf_return_t ublk_bpf_return_val(enum ublk_bpf_disposition rc,
+                unsigned int bytes)
+{
+	return (ublk_bpf_return_t) ((unsigned long)rc << UBLK_BPF_DISPOSITION_SHIFT) | bytes;
+}
+
+extern const struct ublksrv_io_desc *ublk_bpf_get_iod(const struct ublk_bpf_io *io) __ksym;
+extern void ublk_bpf_complete_io(const struct ublk_bpf_io *io, int res) __ksym;
+extern int ublk_bpf_get_dev_id(const struct ublk_bpf_io *io) __ksym;
+extern int ublk_bpf_get_queue_id(const struct ublk_bpf_io *io) __ksym;
+extern int ublk_bpf_get_io_tag(const struct ublk_bpf_io *io) __ksym;
+#endif
diff --git a/tools/testing/selftests/ublk/progs/ublk_null.c b/tools/testing/selftests/ublk/progs/ublk_null.c
new file mode 100644
index 000000000000..3225b52dcd24
--- /dev/null
+++ b/tools/testing/selftests/ublk/progs/ublk_null.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <linux/const.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+//#define DEBUG
+#include "ublk_bpf.h"
+
+/* libbpf v1.4.5 is required for struct_ops to work */
+
+static inline ublk_bpf_return_t __ublk_null_handle_io(const struct ublk_bpf_io *io, unsigned int _off)
+{
+	unsigned long off = -1, sects = -1;
+	const struct ublksrv_io_desc *iod;
+	int res;
+
+	iod = ublk_bpf_get_iod(io);
+	if (iod) {
+		res = iod->nr_sectors << 9;
+		off = iod->start_sector;
+		sects = iod->nr_sectors;
+	} else
+		res = -EINVAL;
+
+	BPF_DBG("ublk dev %u qid %u: handle io tag %u %lx-%d res %d",
+			ublk_bpf_get_dev_id(io),
+			ublk_bpf_get_queue_id(io),
+			ublk_bpf_get_io_tag(io),
+			off, sects, res);
+	ublk_bpf_complete_io(io, res);
+
+	return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+}
+
+SEC("struct_ops/ublk_bpf_queue_io_cmd")
+ublk_bpf_return_t BPF_PROG(ublk_null_handle_io, struct ublk_bpf_io *io, unsigned int off)
+{
+	return __ublk_null_handle_io(io, off);
+}
+
+SEC("struct_ops/ublk_bpf_attach_dev")
+int BPF_PROG(ublk_null_attach_dev, int dev_id)
+{
+	return 0;
+}
+
+SEC("struct_ops/ublk_bpf_detach_dev")
+void BPF_PROG(ublk_null_detach_dev, int dev_id)
+{
+}
+
+SEC(".struct_ops.link")
+struct ublk_bpf_ops null_ublk_bpf_ops = {
+	.id = 0,
+	.queue_io_cmd = (void *)ublk_null_handle_io,
+	.attach_dev = (void *)ublk_null_attach_dev,
+	.detach_dev = (void *)ublk_null_detach_dev,
+};
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
new file mode 100755
index 000000000000..466b82e77860
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+
+_check_root() {
+	local ksft_skip=4
+
+	if [ $UID != 0 ]; then
+		echo please run this as root >&2
+		exit $ksft_skip
+	fi
+}
+
+_remove_ublk_devices() {
+	${UBLK_PROG} del -a
+}
+
+_get_ublk_dev_state() {
+	${UBLK_PROG} list -n "$1" | grep "state" | awk '{print $11}'
+}
+
+_get_ublk_daemon_pid() {
+	${UBLK_PROG} list -n "$1" | grep "pid" | awk '{print $7}'
+}
+
+_prep_test() {
+	_check_root
+	export UBLK_PROG=$(pwd)/ublk_bpf
+	_remove_ublk_devices
+}
+
+_prep_bpf_test() {
+	_prep_test
+	_reg_bpf_prog $@
+}
+
+_show_result()
+{
+	if [ $2 -ne 0 ]; then
+		echo "$1 : [FAIL]"
+	else
+		echo "$1 : [PASS]"
+	fi
+}
+
+_cleanup_test() {
+	_remove_ublk_devices
+}
+
+_cleanup_bpf_test() {
+	_cleanup_test
+	_unreg_bpf_prog $@
+}
+
+_reg_bpf_prog() {
+	${UBLK_PROG} reg -t $1 $2
+	if [ $? -ne 0 ]; then
+		echo "fail to register bpf prog $1 $2"
+		exit -1
+	fi
+}
+
+_unreg_bpf_prog() {
+	${UBLK_PROG} unreg -t $1
+}
+
+_add_ublk_dev() {
+	${UBLK_PROG} add $@
+	if [ $? -ne 0 ]; then
+		echo "fail to add ublk dev $@"
+		exit -1
+	fi
+	udevadm settle
+}
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
new file mode 100755
index 000000000000..eecb4278e894
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="null_01"
+ERR_CODE=0
+
+_prep_test
+
+# add single ublk null disk without bpf prog
+_add_ublk_dev -t null -n 0 --quiet
+
+# run fio over the two disks
+fio --name=job1 --filename=/dev/ublkb0 --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
+ERR_CODE=$?
+
+_cleanup_test
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_null_02.sh b/tools/testing/selftests/ublk/test_null_02.sh
new file mode 100755
index 000000000000..eb0da89f3461
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_02.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="null_02"
+ERR_CODE=0
+
+# prepare & register and pin bpf prog
+_prep_bpf_test "null" ublk_null.bpf.o
+
+# add two ublk null disks with the pinned bpf prog
+_add_ublk_dev -t null -n 0 --bpf_prog 0 --quiet
+_add_ublk_dev -t null -n 1 --bpf_prog 0 --quiet
+
+# run fio over the two disks
+fio --name=job1 --filename=/dev/ublkb0 --rw=readwrite --size=256M \
+	--name=job2 --filename=/dev/ublkb1 --rw=readwrite --size=256M > /dev/null 2>&1
+ERR_CODE=$?
+
+# cleanup & unregister and unpin the bpf prog
+_cleanup_bpf_test "null"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/ublk_bpf.c b/tools/testing/selftests/ublk/ublk_bpf.c
new file mode 100644
index 000000000000..2d923e42845d
--- /dev/null
+++ b/tools/testing/selftests/ublk/ublk_bpf.c
@@ -0,0 +1,1429 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Description: uring_cmd based ublk
+ */
+#include <unistd.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <string.h>
+#include <pthread.h>
+#include <getopt.h>
+#include <limits.h>
+#include <poll.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <sys/inotify.h>
+#include <sys/wait.h>
+#include <liburing.h>
+#include <linux/ublk_cmd.h>
+
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+#define __maybe_unused __attribute__((unused))
+#define MAX_BACK_FILES   4
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+#define UBLK_BPF_PIN_PATH	"ublk"
+
+/****************** part 1: libublk ********************/
+
+#define CTRL_DEV		"/dev/ublk-control"
+#define UBLKC_DEV		"/dev/ublkc"
+#define UBLKB_DEV		"/dev/ublkb"
+#define UBLK_CTRL_RING_DEPTH            32
+
+/* queue idle timeout */
+#define UBLKSRV_IO_IDLE_SECS		20
+
+#define UBLK_IO_MAX_BYTES               65536
+#define UBLK_MAX_QUEUES                 4
+#define UBLK_QUEUE_DEPTH                128
+
+#define UBLK_DBG_DEV            (1U << 0)
+#define UBLK_DBG_QUEUE          (1U << 1)
+#define UBLK_DBG_IO_CMD         (1U << 2)
+#define UBLK_DBG_IO             (1U << 3)
+#define UBLK_DBG_CTRL_CMD       (1U << 4)
+#define UBLK_LOG                (1U << 5)
+
+struct ublk_dev;
+struct ublk_queue;
+
+struct dev_ctx {
+	char tgt_type[16];
+	unsigned long flags;
+	unsigned nr_hw_queues;
+	unsigned queue_depth;
+	int dev_id;
+	int nr_files;
+	char *files[MAX_BACK_FILES];
+	int bpf_prog_id;
+	unsigned int	logging:1;
+	unsigned int	all:1;
+};
+
+struct ublk_ctrl_cmd_data {
+	__u32 cmd_op;
+#define CTRL_CMD_HAS_DATA	1
+#define CTRL_CMD_HAS_BUF	2
+	__u32 flags;
+
+	__u64 data[2];
+	__u64 addr;
+	__u32 len;
+};
+
+struct ublk_io {
+	char *buf_addr;
+
+#define UBLKSRV_NEED_FETCH_RQ		(1UL << 0)
+#define UBLKSRV_NEED_COMMIT_RQ_COMP	(1UL << 1)
+#define UBLKSRV_IO_FREE			(1UL << 2)
+	unsigned short flags;
+	unsigned short refs;		/* used by target code only */
+
+	int result;
+};
+
+struct ublk_tgt_ops {
+	const char *name;
+	int (*init_tgt)(struct ublk_dev *);
+	void (*deinit_tgt)(struct ublk_dev *);
+
+	int (*queue_io)(struct ublk_queue *, int tag);
+	void (*tgt_io_done)(struct ublk_queue *,
+			int tag, const struct io_uring_cqe *);
+};
+
+struct ublk_tgt {
+	unsigned long dev_size;
+	unsigned int  sq_depth;
+	unsigned int  cq_depth;
+	const struct ublk_tgt_ops *ops;
+	struct ublk_params params;
+	char backing_file[1024 - 8 - sizeof(struct ublk_params)];
+};
+
+struct ublk_queue {
+	int q_id;
+	int q_depth;
+	unsigned int cmd_inflight;
+	unsigned int io_inflight;
+	struct ublk_dev *dev;
+	const struct ublk_tgt_ops *tgt_ops;
+	char *io_cmd_buf;
+	struct io_uring ring;
+	struct ublk_io ios[UBLK_QUEUE_DEPTH];
+#define UBLKSRV_QUEUE_STOPPING	(1U << 0)
+#define UBLKSRV_QUEUE_IDLE	(1U << 1)
+#define UBLKSRV_NO_BUF		(1U << 2)
+	unsigned state;
+	pid_t tid;
+	pthread_t thread;
+};
+
+struct ublk_dev {
+	struct ublk_tgt tgt;
+	struct ublksrv_ctrl_dev_info  dev_info;
+	struct ublk_queue q[UBLK_MAX_QUEUES];
+
+	int fds[2];	/* fds[0] points to /dev/ublkcN */
+	int nr_fds;
+	int ctrl_fd;
+	struct io_uring ring;
+
+	int bpf_prog_id;
+};
+
+#ifndef offsetof
+#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
+#endif
+
+#ifndef container_of
+#define container_of(ptr, type, member) ({                              \
+	unsigned long __mptr = (unsigned long)(ptr);                    \
+	((type *)(__mptr - offsetof(type, member))); })
+#endif
+
+#define round_up(val, rnd) \
+	(((val) + ((rnd) - 1)) & ~((rnd) - 1))
+
+static unsigned int ublk_dbg_mask = UBLK_LOG;
+
+static const struct ublk_tgt_ops *ublk_find_tgt(const char *name);
+
+static inline int is_target_io(__u64 user_data)
+{
+	return (user_data & (1ULL << 63)) != 0;
+}
+
+static inline __u64 build_user_data(unsigned tag, unsigned op,
+		unsigned tgt_data, unsigned is_target_io)
+{
+	assert(!(tag >> 16) && !(op >> 8) && !(tgt_data >> 16));
+
+	return tag | (op << 16) | (tgt_data << 24) | (__u64)is_target_io << 63;
+}
+
+static inline unsigned int user_data_to_tag(__u64 user_data)
+{
+	return user_data & 0xffff;
+}
+
+static inline unsigned int user_data_to_op(__u64 user_data)
+{
+	return (user_data >> 16) & 0xff;
+}
+
+static void ublk_err(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+}
+
+static void ublk_log(const char *fmt, ...)
+{
+	if (ublk_dbg_mask & UBLK_LOG) {
+		va_list ap;
+
+		va_start(ap, fmt);
+		vfprintf(stdout, fmt, ap);
+	}
+}
+
+static void ublk_dbg(int level, const char *fmt, ...)
+{
+	if (level & ublk_dbg_mask) {
+		va_list ap;
+		va_start(ap, fmt);
+		vfprintf(stdout, fmt, ap);
+        }
+}
+
+static inline void *ublk_get_sqe_cmd(const struct io_uring_sqe *sqe)
+{
+	return (void *)&sqe->cmd;
+}
+
+static inline void ublk_mark_io_done(struct ublk_io *io, int res)
+{
+	io->flags |= (UBLKSRV_NEED_COMMIT_RQ_COMP | UBLKSRV_IO_FREE);
+	io->result = res;
+}
+
+static inline const struct ublksrv_io_desc *ublk_get_iod(
+                const struct ublk_queue *q, int tag)
+{
+        return (struct ublksrv_io_desc *)
+                &(q->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
+}
+
+static inline void ublk_set_sqe_cmd_op(struct io_uring_sqe *sqe,
+		__u32 cmd_op)
+{
+        __u32 *addr = (__u32 *)&sqe->off;
+
+        addr[0] = cmd_op;
+        addr[1] = 0;
+}
+
+static inline int ublk_setup_ring(struct io_uring *r, int depth,
+		int cq_depth, unsigned flags)
+{
+	struct io_uring_params p;
+
+	memset(&p, 0, sizeof(p));
+	p.flags = flags | IORING_SETUP_CQSIZE;
+	p.cq_entries = cq_depth;
+
+	return io_uring_queue_init_params(depth, r, &p);
+}
+
+static void ublk_ctrl_init_cmd(struct ublk_dev *dev,
+		struct io_uring_sqe *sqe,
+		struct ublk_ctrl_cmd_data *data)
+{
+	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	struct ublksrv_ctrl_cmd *cmd = (struct ublksrv_ctrl_cmd *)ublk_get_sqe_cmd(sqe);
+
+	sqe->fd = dev->ctrl_fd;
+	sqe->opcode = IORING_OP_URING_CMD;
+	sqe->ioprio = 0;
+
+	if (data->flags & CTRL_CMD_HAS_BUF) {
+		cmd->addr = data->addr;
+		cmd->len = data->len;
+	}
+
+	if (data->flags & CTRL_CMD_HAS_DATA)
+		cmd->data[0] = data->data[0];
+
+	cmd->dev_id = info->dev_id;
+	cmd->queue_id = -1;
+
+	ublk_set_sqe_cmd_op(sqe, data->cmd_op);
+
+	io_uring_sqe_set_data(sqe, cmd);
+}
+
+static int __ublk_ctrl_cmd(struct ublk_dev *dev,
+		struct ublk_ctrl_cmd_data *data)
+{
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	int ret = -EINVAL;
+
+	sqe = io_uring_get_sqe(&dev->ring);
+	if (!sqe) {
+		ublk_err("%s: can't get sqe ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	ublk_ctrl_init_cmd(dev, sqe, data);
+
+	ret = io_uring_submit(&dev->ring);
+	if (ret < 0) {
+		ublk_err("uring submit ret %d\n", ret);
+		return ret;
+	}
+
+	ret = io_uring_wait_cqe(&dev->ring, &cqe);
+	if (ret < 0) {
+		ublk_err("wait cqe: %s\n", strerror(-ret));
+		return ret;
+	}
+	io_uring_cqe_seen(&dev->ring, cqe);
+
+	return cqe->res;
+}
+
+static int ublk_ctrl_stop_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_STOP_DEV,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_start_dev(struct ublk_dev *dev,
+		int daemon_pid)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_START_DEV,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_add_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_ADD_DEV,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) &dev->dev_info,
+		.len = sizeof(struct ublksrv_ctrl_dev_info),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_del_dev(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op = UBLK_U_CMD_DEL_DEV,
+		.flags = 0,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_get_info(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_GET_DEV_INFO,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) &dev->dev_info,
+		.len = sizeof(struct ublksrv_ctrl_dev_info),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_set_params(struct ublk_dev *dev,
+		struct ublk_params *params)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_SET_PARAMS,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) params,
+		.len = sizeof(*params),
+	};
+	params->len = sizeof(*params);
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_get_params(struct ublk_dev *dev,
+		struct ublk_params *params)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_CMD_GET_PARAMS,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64)params,
+		.len = sizeof(*params),
+	};
+
+	params->len = sizeof(*params);
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_get_features(struct ublk_dev *dev,
+		__u64 *features)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_GET_FEATURES,
+		.flags	= CTRL_CMD_HAS_BUF,
+		.addr = (__u64) (uintptr_t) features,
+		.len = sizeof(*features),
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static const char *ublk_dev_state_desc(struct ublk_dev *dev)
+{
+	switch (dev->dev_info.state) {
+	case UBLK_S_DEV_DEAD:
+		return "DEAD";
+	case UBLK_S_DEV_LIVE:
+		return "LIVE";
+	case UBLK_S_DEV_QUIESCED:
+		return "QUIESCED";
+	default:
+		return "UNKNOWN";
+	};
+}
+
+static void ublk_ctrl_dump(struct ublk_dev *dev, bool show_queue)
+{
+	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	int ret;
+	struct ublk_params p;
+
+	ret = ublk_ctrl_get_params(dev, &p);
+	if (ret < 0) {
+		ublk_err("failed to get params %m\n");
+		return;
+	}
+
+	ublk_log("dev id %d: nr_hw_queues %d queue_depth %d block size %d dev_capacity %lld\n",
+			info->dev_id,
+                        info->nr_hw_queues, info->queue_depth,
+                        1 << p.basic.logical_bs_shift, p.basic.dev_sectors);
+	ublk_log("\tmax rq size %d daemon pid %d flags 0x%llx state %s\n",
+                        info->max_io_buf_bytes,
+			info->ublksrv_pid, info->flags,
+			ublk_dev_state_desc(dev));
+	if (show_queue) {
+		int i;
+
+		for (i = 0; i < dev->dev_info.nr_hw_queues; i++)
+			ublk_log("\tqueue 0 tid: %d\n", dev->q[i].tid);
+	}
+	fflush(stdout);
+}
+
+static void ublk_ctrl_deinit(struct ublk_dev *dev)
+{
+	close(dev->ctrl_fd);
+	free(dev);
+}
+
+static struct ublk_dev *ublk_ctrl_init(void)
+{
+	struct ublk_dev *dev = (struct ublk_dev *)calloc(1, sizeof(*dev));
+	struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	int ret;
+
+	dev->ctrl_fd = open(CTRL_DEV, O_RDWR);
+	if (dev->ctrl_fd < 0) {
+		free(dev);
+		return NULL;
+	}
+
+	info->max_io_buf_bytes = UBLK_IO_MAX_BYTES;
+
+	ret = ublk_setup_ring(&dev->ring, UBLK_CTRL_RING_DEPTH,
+			UBLK_CTRL_RING_DEPTH, IORING_SETUP_SQE128);
+	if (ret < 0) {
+		ublk_err("queue_init: %s\n", strerror(-ret));
+		free(dev);
+		return NULL;
+	}
+	dev->nr_fds = 1;
+
+	return dev;
+}
+
+static int __ublk_queue_cmd_buf_sz(unsigned depth)
+{
+	int size =  depth * sizeof(struct ublksrv_io_desc);
+	unsigned int page_sz = getpagesize();
+
+	return round_up(size, page_sz);
+}
+
+static int ublk_queue_max_cmd_buf_sz(void)
+{
+	return __ublk_queue_cmd_buf_sz(UBLK_MAX_QUEUE_DEPTH);
+}
+
+static int ublk_queue_cmd_buf_sz(struct ublk_queue *q)
+{
+	return __ublk_queue_cmd_buf_sz(q->q_depth);
+}
+
+static void ublk_queue_deinit(struct ublk_queue *q)
+{
+	int i;
+	int nr_ios = q->q_depth;
+
+	io_uring_unregister_ring_fd(&q->ring);
+
+	if (q->ring.ring_fd > 0) {
+		io_uring_unregister_files(&q->ring);
+		close(q->ring.ring_fd);
+		q->ring.ring_fd = -1;
+	}
+
+	if (q->io_cmd_buf)
+		munmap(q->io_cmd_buf, ublk_queue_cmd_buf_sz(q));
+
+	for (i = 0; i < nr_ios; i++)
+		free(q->ios[i].buf_addr);
+}
+
+static int ublk_queue_init(struct ublk_queue *q)
+{
+	struct ublk_dev *dev = q->dev;
+	int depth = dev->dev_info.queue_depth;
+	int i, ret = -1;
+	int cmd_buf_size, io_buf_size;
+	unsigned long off;
+	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
+
+	q->tgt_ops = dev->tgt.ops;
+	q->state = 0;
+	q->q_depth = depth;
+	q->cmd_inflight = 0;
+	q->tid = gettid();
+	if (dev->dev_info.flags & UBLK_F_BPF)
+		q->state |= UBLKSRV_NO_BUF;
+
+	cmd_buf_size = ublk_queue_cmd_buf_sz(q);
+	off = UBLKSRV_CMD_BUF_OFFSET + q->q_id * ublk_queue_max_cmd_buf_sz();
+	q->io_cmd_buf = (char *)mmap(0, cmd_buf_size, PROT_READ,
+			MAP_SHARED | MAP_POPULATE, dev->fds[0], off);
+	if (q->io_cmd_buf == MAP_FAILED) {
+		ublk_err("ublk dev %d queue %d map io_cmd_buf failed %m\n",
+				q->dev->dev_info.dev_id, q->q_id);
+		goto fail;
+	}
+
+	io_buf_size = dev->dev_info.max_io_buf_bytes;
+	for (i = 0; i < q->q_depth; i++) {
+		q->ios[i].buf_addr = NULL;
+		q->ios[i].flags = UBLKSRV_NEED_FETCH_RQ | UBLKSRV_IO_FREE;
+
+		if (q->state & UBLKSRV_NO_BUF)
+			continue;
+
+		if (posix_memalign((void **)&q->ios[i].buf_addr,
+					getpagesize(), io_buf_size)) {
+			ublk_err("ublk dev %d queue %d io %d posix_memalign failed %m\n",
+					dev->dev_info.dev_id, q->q_id, i);
+			goto fail;
+		}
+	}
+
+	ret = ublk_setup_ring(&q->ring, ring_depth, cq_depth,
+			IORING_SETUP_COOP_TASKRUN);
+	if (ret < 0) {
+		ublk_err("ublk dev %d queue %d setup io_uring failed %d\n",
+				q->dev->dev_info.dev_id, q->q_id, ret);
+		goto fail;
+	}
+
+	io_uring_register_ring_fd(&q->ring);
+
+	ret = io_uring_register_files(&q->ring, dev->fds, dev->nr_fds);
+	if (ret) {
+		ublk_err("ublk dev %d queue %d register files failed %d\n",
+				q->dev->dev_info.dev_id, q->q_id, ret);
+		goto fail;
+	}
+
+	return 0;
+ fail:
+	ublk_queue_deinit(q);
+	ublk_err("ublk dev %d queue %d failed\n",
+			dev->dev_info.dev_id, q->q_id);
+	return -ENOMEM;
+}
+
+static int ublk_dev_prep(struct ublk_dev *dev)
+{
+	int dev_id = dev->dev_info.dev_id;
+	char buf[64];
+	int ret = 0;
+
+	snprintf(buf, 64, "%s%d", UBLKC_DEV, dev_id);
+	dev->fds[0] = open(buf, O_RDWR);
+	if (dev->fds[0] < 0) {
+		ret = -EBADF;
+		ublk_err("can't open %s, ret %d\n", buf, dev->fds[0]);
+		goto fail;
+	}
+
+	if (dev->tgt.ops->init_tgt)
+		ret = dev->tgt.ops->init_tgt(dev);
+
+	return ret;
+fail:
+	close(dev->fds[0]);
+	return ret;
+}
+
+static void ublk_dev_unprep(struct ublk_dev *dev)
+{
+	if (dev->tgt.ops->deinit_tgt)
+		dev->tgt.ops->deinit_tgt(dev);
+	close(dev->fds[0]);
+}
+
+static int ublk_queue_io_cmd(struct ublk_queue *q,
+		struct ublk_io *io, unsigned tag)
+{
+	struct ublksrv_io_cmd *cmd;
+	struct io_uring_sqe *sqe;
+	unsigned int cmd_op = 0;
+	__u64 user_data;
+
+	/* only freed io can be issued */
+	if (!(io->flags & UBLKSRV_IO_FREE))
+		return 0;
+
+	/* we issue because we need either fetching or committing */
+	if (!(io->flags &
+		(UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
+		return 0;
+
+	if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
+		cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
+	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
+		cmd_op = UBLK_U_IO_FETCH_REQ;
+
+	sqe = io_uring_get_sqe(&q->ring);
+	if (!sqe) {
+		ublk_err("%s: run out of sqe %d, tag %d\n",
+				__func__, q->q_id, tag);
+		return -1;
+	}
+
+	cmd = (struct ublksrv_io_cmd *)ublk_get_sqe_cmd(sqe);
+
+	if (cmd_op == UBLK_U_IO_COMMIT_AND_FETCH_REQ)
+		cmd->result = io->result;
+
+	/* These fields should be written once, never change */
+	ublk_set_sqe_cmd_op(sqe, cmd_op);
+	sqe->fd		= 0;	/* dev->fds[0] */
+	sqe->opcode	= IORING_OP_URING_CMD;
+	sqe->flags	= IOSQE_FIXED_FILE;
+	sqe->rw_flags	= 0;
+	cmd->tag	= tag;
+	cmd->q_id	= q->q_id;
+	if (!(q->state & UBLKSRV_NO_BUF))
+		cmd->addr	= (__u64) (uintptr_t) io->buf_addr;
+	else
+		cmd->addr	= 0;
+
+	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, 0);
+	io_uring_sqe_set_data64(sqe, user_data);
+
+	io->flags = 0;
+
+	q->cmd_inflight += 1;
+
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: (qid %d tag %u cmd_op %u) iof %x stopping %d\n",
+			__func__, q->q_id, tag, cmd_op,
+			io->flags, !!(q->state & UBLKSRV_QUEUE_STOPPING));
+	return 1;
+}
+
+__maybe_unused static int ublk_complete_io(struct ublk_queue *q,
+		unsigned tag, int res)
+{
+	struct ublk_io *io = &q->ios[tag];
+
+	ublk_mark_io_done(io, res);
+
+	return ublk_queue_io_cmd(q, io, tag);
+}
+
+static void ublk_submit_fetch_commands(struct ublk_queue *q)
+{
+	int i = 0;
+
+	for (i = 0; i < q->q_depth; i++)
+		ublk_queue_io_cmd(q, &q->ios[i], i);
+}
+
+static int ublk_queue_is_idle(struct ublk_queue *q)
+{
+	return !io_uring_sq_ready(&q->ring) && !q->io_inflight;
+}
+
+static int ublk_queue_is_done(struct ublk_queue *q)
+{
+	return (q->state & UBLKSRV_QUEUE_STOPPING) && ublk_queue_is_idle(q);
+}
+
+static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
+		struct io_uring_cqe *cqe)
+{
+	unsigned tag = user_data_to_tag(cqe->user_data);
+
+	if (cqe->res < 0 && cqe->res != -EAGAIN)
+		ublk_err("%s: failed tgt io: res %d qid %u tag %u, cmd_op %u\n",
+			__func__, cqe->res, q->q_id,
+			user_data_to_tag(cqe->user_data),
+			user_data_to_op(cqe->user_data));
+
+	if (q->tgt_ops->tgt_io_done)
+		q->tgt_ops->tgt_io_done(q, tag, cqe);
+}
+
+static void ublk_handle_cqe(struct io_uring *r,
+		struct io_uring_cqe *cqe, void *data)
+{
+	struct ublk_queue *q = container_of(r, struct ublk_queue, ring);
+	unsigned tag = user_data_to_tag(cqe->user_data);
+	unsigned cmd_op = user_data_to_op(cqe->user_data);
+	int fetch = (cqe->res != UBLK_IO_RES_ABORT) &&
+		!(q->state & UBLKSRV_QUEUE_STOPPING);
+	struct ublk_io *io;
+
+	ublk_dbg(UBLK_DBG_IO_CMD, "%s: res %d (qid %d tag %u cmd_op %u target %d) stopping %d\n",
+			__func__, cqe->res, q->q_id, tag, cmd_op,
+			is_target_io(cqe->user_data),
+			(q->state & UBLKSRV_QUEUE_STOPPING));
+
+	/* Don't retrieve io in case of target io */
+	if (is_target_io(cqe->user_data)) {
+		ublksrv_handle_tgt_cqe(q, cqe);
+		return;
+	}
+
+	io = &q->ios[tag];
+	q->cmd_inflight--;
+
+	if (!fetch) {
+		q->state |= UBLKSRV_QUEUE_STOPPING;
+		io->flags &= ~UBLKSRV_NEED_FETCH_RQ;
+	}
+
+	if (cqe->res == UBLK_IO_RES_OK) {
+		assert(tag < q->q_depth);
+		if (q->tgt_ops->queue_io)
+			q->tgt_ops->queue_io(q, tag);
+	} else {
+		/*
+		 * COMMIT_REQ will be completed immediately since no fetching
+		 * piggyback is required.
+		 *
+		 * Marking IO_FREE only, then this io won't be issued since
+		 * we only issue io with (UBLKSRV_IO_FREE | UBLKSRV_NEED_*)
+		 *
+		 * */
+		io->flags = UBLKSRV_IO_FREE;
+	}
+}
+
+static int ublk_reap_events_uring(struct io_uring *r)
+{
+	struct io_uring_cqe *cqe;
+	unsigned head;
+	int count = 0;
+
+	io_uring_for_each_cqe(r, head, cqe) {
+		ublk_handle_cqe(r, cqe, NULL);
+		count += 1;
+	}
+	io_uring_cq_advance(r, count);
+
+	return count;
+}
+
+static int ublk_process_io(struct ublk_queue *q)
+{
+	int ret, reapped;
+
+	ublk_dbg(UBLK_DBG_QUEUE, "dev%d-q%d: to_submit %d inflight cmd %u stopping %d\n",
+				q->dev->dev_info.dev_id,
+				q->q_id, io_uring_sq_ready(&q->ring),
+				q->cmd_inflight,
+				(q->state & UBLKSRV_QUEUE_STOPPING));
+
+	if (ublk_queue_is_done(q))
+		return -ENODEV;
+
+	ret = io_uring_submit_and_wait(&q->ring, 1);
+	reapped = ublk_reap_events_uring(&q->ring);
+
+	ublk_dbg(UBLK_DBG_QUEUE, "submit result %d, reapped %d stop %d idle %d\n",
+			ret, reapped, (q->state & UBLKSRV_QUEUE_STOPPING),
+			(q->state & UBLKSRV_QUEUE_IDLE));
+
+	return reapped;
+}
+
+static void *ublk_io_handler_fn(void *data)
+{
+	struct ublk_queue *q = data;
+	int dev_id = q->dev->dev_info.dev_id;
+	int ret;
+
+	ret = ublk_queue_init(q);
+	if (ret) {
+		ublk_err("ublk dev %d queue %d init queue failed\n",
+				dev_id, q->q_id);
+		return NULL;
+	}
+	ublk_dbg(UBLK_DBG_QUEUE, "tid %d: ublk dev %d queue %d started\n",
+			q->tid, dev_id, q->q_id);
+
+	/* submit all io commands to ublk driver */
+	ublk_submit_fetch_commands(q);
+	do {
+		if (ublk_process_io(q) < 0)
+			break;
+	} while (1);
+
+	ublk_dbg(UBLK_DBG_QUEUE, "ublk dev %d queue %d exited\n", dev_id, q->q_id);
+	ublk_queue_deinit(q);
+	return NULL;
+}
+
+static void ublk_set_parameters(struct ublk_dev *dev)
+{
+	int ret;
+
+	ret = ublk_ctrl_set_params(dev, &dev->tgt.params);
+	if (ret)
+		ublk_err("dev %d set basic parameter failed %d\n",
+				dev->dev_info.dev_id, ret);
+}
+
+static int ublk_start_daemon(struct ublk_dev *dev)
+{
+	int ret, i;
+	void *thread_ret;
+	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
+
+	if (daemon(1, 1) < 0)
+		return -errno;
+
+	ublk_dbg(UBLK_DBG_DEV, "%s enter\n", __func__);
+
+	ret = ublk_dev_prep(dev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < dinfo->nr_hw_queues; i++) {
+		dev->q[i].dev = dev;
+		dev->q[i].q_id = i;
+		pthread_create(&dev->q[i].thread, NULL,
+				ublk_io_handler_fn,
+				&dev->q[i]);
+	}
+
+	/* everything is fine now, start us */
+	ublk_set_parameters(dev);
+	ret = ublk_ctrl_start_dev(dev, getpid());
+	if (ret < 0) {
+		ublk_err("%s: ublk_ctrl_start_dev failed: %d\n", __func__, ret);
+		goto fail;
+	}
+
+	ublk_ctrl_get_info(dev);
+	ublk_ctrl_dump(dev, true);
+
+	/* wait until we are terminated */
+	for (i = 0; i < dinfo->nr_hw_queues; i++)
+		pthread_join(dev->q[i].thread, &thread_ret);
+ fail:
+	ublk_dev_unprep(dev);
+	ublk_dbg(UBLK_DBG_DEV, "%s exit\n", __func__);
+
+	return ret;
+}
+
+static int wait_ublk_dev(char *dev_name, int evt_mask, unsigned timeout)
+{
+#define EV_SIZE (sizeof(struct inotify_event))
+#define EV_BUF_LEN (128 * (EV_SIZE + 16))
+	struct pollfd pfd;
+	int fd, wd;
+	int ret = -EINVAL;
+
+	fd = inotify_init();
+	if (fd < 0) {
+		ublk_dbg(UBLK_DBG_DEV, "%s: inotify init failed\n", __func__);
+		return fd;
+	}
+
+	wd = inotify_add_watch(fd, "/dev", evt_mask);
+	if (wd == -1) {
+		ublk_dbg(UBLK_DBG_DEV, "%s: add watch for /dev failed\n", __func__);
+		goto fail;
+	}
+
+	pfd.fd = fd;
+	pfd.events = POLL_IN;
+	while (1) {
+		int i = 0;
+		char buffer[EV_BUF_LEN];
+		ret = poll(&pfd, 1, 1000 * timeout);
+
+		if (ret == -1) {
+			ublk_err("%s: poll inotify failed: %d\n", __func__, ret);
+			goto rm_watch;
+		} else if (ret == 0) {
+			ublk_err("%s: poll inotify timeout\n", __func__);
+			ret = -ETIMEDOUT;
+			goto rm_watch;
+		}
+
+		ret = read(fd, buffer, EV_BUF_LEN);
+		if (ret < 0) {
+			ublk_err("%s: read inotify fd failed\n", __func__);
+			goto rm_watch;
+		}
+
+		while (i < ret) {
+			struct inotify_event *event = (struct inotify_event *)&buffer[i];
+
+			ublk_dbg(UBLK_DBG_DEV, "%s: inotify event %x %s\n",
+					__func__, event->mask, event->name);
+			if (event->mask & evt_mask) {
+				if (!strcmp(event->name, dev_name)) {
+					ret = 0;
+					goto rm_watch;
+				}
+			}
+			i += EV_SIZE + event->len;
+		}
+	}
+rm_watch:
+	inotify_rm_watch(fd, wd);
+fail:
+	close(fd);
+	return ret;
+}
+
+static int ublk_stop_io_daemon(const struct ublk_dev *dev)
+{
+	int daemon_pid = dev->dev_info.ublksrv_pid;
+	int dev_id = dev->dev_info.dev_id;
+	char ublkc[64];
+	int ret;
+
+	/* daemon may be dead already */
+	if (kill(daemon_pid, 0) < 0)
+		goto wait;
+
+	/*
+	 * Wait until ublk char device is closed, when our daemon is shutdown
+	 */
+	snprintf(ublkc, sizeof(ublkc), "%s%d", "ublkc", dev_id);
+	ret = wait_ublk_dev(ublkc, IN_CLOSE_WRITE, 3);
+	/* double check and inotify may not be 100% reliable */
+	if (ret == -ETIMEDOUT)
+		/* the daemon doesn't exist now if kill(0) fails */
+		ret = kill(daemon_pid, 0) < 0;
+wait:
+	waitpid(daemon_pid, NULL, 0);
+	ublk_dbg(UBLK_DBG_DEV, "%s: pid %d dev_id %d ret %d\n",
+			__func__, daemon_pid, dev_id, ret);
+
+	return ret;
+}
+
+static int cmd_dev_add(struct dev_ctx *ctx)
+{
+	char *tgt_type = ctx->tgt_type;
+	unsigned depth = ctx->queue_depth;
+	unsigned nr_queues = ctx->nr_hw_queues;
+	__u64 features;
+	const struct ublk_tgt_ops *ops;
+	struct ublksrv_ctrl_dev_info *info;
+	struct ublk_dev *dev;
+	int dev_id = ctx->dev_id;
+	char ublkb[64];
+	int ret;
+
+	ops = ublk_find_tgt(tgt_type);
+	if (!ops) {
+		ublk_err("%s: no such tgt type, type %s\n",
+				__func__, tgt_type);
+		return -ENODEV;
+	}
+
+	if (nr_queues > UBLK_MAX_QUEUES || depth > UBLK_QUEUE_DEPTH) {
+		ublk_err("%s: invalid nr_queues or depth queues %u depth %u\n",
+				__func__, nr_queues, depth);
+		return -EINVAL;
+	}
+
+	dev = ublk_ctrl_init();
+	if (!dev) {
+		ublk_err("%s: can't alloc dev id %d, type %s\n",
+				__func__, dev_id, tgt_type);
+		return -ENOMEM;
+	}
+
+	/* kernel doesn't support get_features */
+	ret = ublk_ctrl_get_features(dev, &features);
+	if (ret < 0)
+		return -EINVAL;
+
+	if (!(features & UBLK_F_CMD_IOCTL_ENCODE))
+		return -ENOTSUP;
+
+	info = &dev->dev_info;
+	info->dev_id = ctx->dev_id;
+	info->nr_hw_queues =nr_queues;
+	info->queue_depth = depth;
+	info->flags = ctx->flags;
+	dev->tgt.ops = ops;
+	dev->tgt.sq_depth = depth;
+	dev->tgt.cq_depth = depth;
+	dev->bpf_prog_id = ctx->bpf_prog_id;
+
+	ret = ublk_ctrl_add_dev(dev);
+	if (ret < 0) {
+		ublk_err("%s: can't add dev id %d, type %s ret %d\n",
+				__func__, dev_id, tgt_type, ret);
+		goto fail;
+	}
+
+	ret = -EINVAL;
+	switch (fork()) {
+	case -1:
+		goto fail;
+	case 0:
+		ublk_start_daemon(dev);
+		ublk_dbg(UBLK_DBG_DEV, "%s: daemon is started in children");
+		exit(EXIT_SUCCESS);
+	}
+
+	/*
+	 * Wait until ublk disk is added, when our daemon is started
+	 * successfully
+	 */
+	snprintf(ublkb, sizeof(ublkb), "%s%u", "ublkb", dev->dev_info.dev_id);
+	ret = wait_ublk_dev(ublkb, IN_CREATE, 3);
+	if (ret < 0) {
+		ublk_err("%s: can't start daemon id %d, type %s\n",
+				__func__, dev_id, tgt_type);
+		ublk_ctrl_del_dev(dev);
+	} else {
+		ctx->dev_id = dev->dev_info.dev_id;
+	}
+	ublk_dbg(UBLK_DBG_DEV, "%s: start daemon id %d, type %s\n",
+				__func__, ctx->dev_id, tgt_type);
+fail:
+	ublk_ctrl_deinit(dev);
+	return ret;
+}
+
+static int __cmd_dev_del(struct dev_ctx *ctx)
+{
+	int number = ctx->dev_id;
+	struct ublk_dev *dev;
+	int ret;
+
+	dev = ublk_ctrl_init();
+	dev->dev_info.dev_id = number;
+
+	ret = ublk_ctrl_get_info(dev);
+	if (ret < 0)
+		goto fail;
+
+	ret = ublk_ctrl_stop_dev(dev);
+	if (ret < 0)
+		ublk_err("%s: stop dev %d failed ret %d\n", __func__, number, ret);
+
+	ret = ublk_stop_io_daemon(dev);
+	if (ret < 0)
+		ublk_err("%s: stop daemon id %d dev %d, ret %d\n",
+				__func__, dev->dev_info.ublksrv_pid, number, ret);
+	ublk_ctrl_del_dev(dev);
+fail:
+	if (ret >= 0)
+		ret = ublk_ctrl_get_info(dev);
+	ublk_ctrl_deinit(dev);
+
+	return (ret >= 0) ? 0 : ret;
+}
+
+static int cmd_dev_del(struct dev_ctx *ctx)
+{
+	int i;
+
+	if (ctx->dev_id >= 0 || !ctx->all)
+		return __cmd_dev_del(ctx);
+
+	for (i = 0; i < 255; i++) {
+		ctx->dev_id = i;
+		__cmd_dev_del(ctx);
+	}
+	return 0;
+}
+
+static int __cmd_dev_list(struct dev_ctx *ctx)
+{
+	struct ublk_dev *dev = ublk_ctrl_init();
+	int ret;
+
+	if (!dev)
+		return -ENODEV;
+
+	dev->dev_info.dev_id = ctx->dev_id;
+
+	ret = ublk_ctrl_get_info(dev);
+	if (ret < 0) {
+		if (ctx->logging)
+			ublk_err("%s: can't get dev info from %d: %d\n",
+					__func__, ctx->dev_id, ret);
+	} else {
+		ublk_ctrl_dump(dev, false);
+	}
+
+	ublk_ctrl_deinit(dev);
+
+	return ret;
+}
+
+static int cmd_dev_list(struct dev_ctx *ctx)
+{
+	int i;
+
+	if (ctx->dev_id >= 0 || !ctx->all)
+		return __cmd_dev_list(ctx);
+
+	ctx->logging = false;
+	for (i = 0; i < 255; i++) {
+		ctx->dev_id = i;
+		__cmd_dev_list(ctx);
+	}
+	return 0;
+}
+
+static int cmd_dev_unreg_bpf(struct dev_ctx *ctx)
+{
+	char path[PATH_MAX];
+	char cmd[PATH_MAX + 16];
+	struct stat st;
+
+	snprintf(path, PATH_MAX, "/sys/fs/bpf/%s/%s", UBLK_BPF_PIN_PATH, ctx->tgt_type);
+	if (stat(path, &st) != 0) {
+		ublk_err("bpf prog %s isn't registered on %s\n", ctx->tgt_type, path);
+		return -ENOENT;
+	}
+
+        sprintf(cmd, "rm -r %s", path);
+	if (system(cmd)) {
+		ublk_err("fail to run %s\n", cmd);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int pathname_concat(char *buf, int buf_sz, const char *path,
+		    const char *name)
+{
+	int len;
+
+	len = snprintf(buf, buf_sz, "%s/%s", path, name);
+	if (len < 0)
+		return -EINVAL;
+	if (len >= buf_sz)
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
+static int pin_map(struct bpf_map *map, const char *pindir,
+		    const char *name)
+{
+	char pinfile[PATH_MAX];
+	int err;
+
+	err = pathname_concat(pinfile, sizeof(pinfile), pindir, name);
+	if (err)
+		return -1;
+
+	return bpf_map__pin(map, pinfile);
+}
+
+static int pin_link(struct bpf_link *link, const char *pindir,
+		    const char *name)
+{
+	char pinfile[PATH_MAX];
+	int err;
+
+	err = pathname_concat(pinfile, sizeof(pinfile), pindir, name);
+	if (err)
+		return -1;
+
+	return bpf_link__pin(link, pinfile);
+}
+
+static int cmd_dev_reg_bpf(struct dev_ctx *ctx)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, open_opts);
+	struct bpf_object *obj;
+	struct bpf_map *map;
+	char path[PATH_MAX];
+	struct stat st;
+
+	assert(ctx->nr_files == 1);
+
+	snprintf(path, PATH_MAX, "/sys/fs/bpf");
+	if (stat(path, &st) != 0) {
+		ublk_err("bpf fs isn't mounted on %s\n", path);
+		return -ENOENT;
+	}
+
+	snprintf(path, PATH_MAX, "/sys/fs/bpf/%s", UBLK_BPF_PIN_PATH);
+	if (stat(path, &st) != 0) {
+		if (mkdir(path, 0700) != 0) {
+			ublk_err("fail to create ublk bpf on %s\n", path);
+			return -ENOENT;
+		}
+	}
+
+	snprintf(path, PATH_MAX, "/sys/fs/bpf/%s/%s", UBLK_BPF_PIN_PATH, ctx->tgt_type);
+	if (stat(path, &st) == 0) {
+		ublk_err("fail to pin ublk bpf on %s\n", path);
+		return -EEXIST;
+	}
+
+	obj = bpf_object__open_file(ctx->files[0], &open_opts);
+        if (!obj)
+                return -1;
+
+	if (bpf_object__load(obj)) {
+		ublk_err("fail to load bpf obj from %s\n", ctx->files[0]);
+		bpf_object__close(obj);
+		return -1;
+	}
+
+	bpf_object__for_each_map(map, obj) {
+		struct bpf_link *link;
+
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS) {
+			if (!bpf_map__is_internal(map))
+				pin_map(map, path, bpf_map__name(map));
+			continue;
+		}
+
+		link = bpf_map__attach_struct_ops(map);
+		if (!link) {
+			ublk_err("can't register struct_ops %s: %s",
+					bpf_map__name(map), strerror(errno));
+			continue;
+		}
+		pin_link(link, path, bpf_map__name(map));
+
+		bpf_link__disconnect(link);
+		bpf_link__destroy(link);
+	}
+
+	bpf_object__close(obj);
+	return 0;
+}
+
+static int cmd_dev_help(char *exe)
+{
+	printf("%s add -t [null] [-q nr_queues] [-d depth] [-n dev_id] [--bpf_prog ublk_prog_id] [backfile1] [backfile2] ...\n", exe);
+	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
+	printf("%s del [-n dev_id] -a \n", exe);
+	printf("\t -a delete all devices -n delete specified device\n");
+	printf("%s list [-n dev_id] -a \n", exe);
+	printf("\t -a list all devices, -n list specified device, default -a \n");
+	printf("%s reg -t [null] bpf_prog_obj_path \n", exe);
+	printf("%s unreg -t [null]\n", exe);
+	return 0;
+}
+
+/****************** part 2: target implementation ********************/
+
+static int ublk_null_tgt_init(struct ublk_dev *dev)
+{
+	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
+	unsigned long dev_size = 250UL << 30;
+	bool use_bpf = info->flags & UBLK_F_BPF;
+
+	dev->tgt.dev_size = dev_size;
+	dev->tgt.params = (struct ublk_params) {
+		.types = UBLK_PARAM_TYPE_BASIC |
+			(use_bpf ? UBLK_PARAM_TYPE_BPF : 0),
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift		= 12,
+			.io_min_shift		= 9,
+			.max_sectors		= info->max_io_buf_bytes >> 9,
+			.dev_sectors		= dev_size >> 9,
+		},
+		.bpf = {
+			.flags = UBLK_BPF_HAS_OPS_ID,
+			.ops_id = dev->bpf_prog_id,
+		},
+	};
+
+	return 0;
+}
+
+static int ublk_null_queue_io(struct ublk_queue *q, int tag)
+{
+	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+
+	/* won't be called for UBLK_F_BPF */
+	assert(!(q->dev->dev_info.flags & UBLK_F_BPF));
+
+	ublk_complete_io(q, tag, iod->nr_sectors << 9);
+
+	return 0;
+}
+
+static const struct ublk_tgt_ops tgt_ops_list[] = {
+	{
+		.name = "null",
+		.init_tgt = ublk_null_tgt_init,
+		.queue_io = ublk_null_queue_io,
+	},
+};
+
+static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
+{
+	const struct ublk_tgt_ops *ops;
+	int i;
+
+	if (name == NULL)
+		return NULL;
+
+	for (i = 0; sizeof(tgt_ops_list) / sizeof(*ops); i++)
+		if (strcmp(tgt_ops_list[i].name, name) == 0)
+			return &tgt_ops_list[i];
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "all",		0,	NULL, 'a' },
+		{ "type",		1,	NULL, 't' },
+		{ "number",		1,	NULL, 'n' },
+		{ "queues",		1,	NULL, 'q' },
+		{ "depth",		1,	NULL, 'd' },
+		{ "debug_mask",		1,	NULL,  0  },
+		{ "quiet",		0,	NULL,  0  },
+		{ "bpf_prog",		1,	NULL,  0  },
+		{ 0, 0, 0, 0 }
+	};
+	int option_idx, opt;
+	const char *cmd = argv[1];
+	struct dev_ctx ctx = {
+		.queue_depth	=	128,
+		.nr_hw_queues	=	2,
+		.dev_id		=	-1,
+		.bpf_prog_id	=	-1,
+	};
+	int ret = -EINVAL, i;
+
+	if (argc == 1)
+		return ret;
+
+	optind = 2;
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:a",
+				  longopts, &option_idx)) != -1) {
+		switch (opt) {
+		case 'a':
+			ctx.all = 1;
+			break;
+		case 'n':
+			ctx.dev_id = strtol(optarg, NULL, 10);
+			break;
+		case 't':
+			strncpy(ctx.tgt_type, optarg,
+					min(sizeof(ctx.tgt_type), strlen(optarg)));
+			break;
+		case 'q':
+			ctx.nr_hw_queues = strtol(optarg, NULL, 10);
+			break;
+		case 'd':
+			ctx.queue_depth = strtol(optarg, NULL, 10);
+			break;
+		case 0:
+			if (!strcmp(longopts[option_idx].name, "debug_mask"))
+				ublk_dbg_mask = strtol(optarg, NULL, 16);
+			if (!strcmp(longopts[option_idx].name, "quiet"))
+				ublk_dbg_mask = 0;
+			if (!strcmp(longopts[option_idx].name, "bpf_prog")) {
+				ctx.bpf_prog_id = strtol(optarg, NULL, 10);
+				ctx.flags |= UBLK_F_BPF;
+			}
+			break;
+		}
+	}
+
+	i = optind;
+	while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
+		ctx.files[ctx.nr_files++] = argv[i++];
+	}
+
+	if (!strcmp(cmd, "add"))
+		ret = cmd_dev_add(&ctx);
+	else if (!strcmp(cmd, "del"))
+		ret = cmd_dev_del(&ctx);
+	else if (!strcmp(cmd, "list")) {
+		ctx.all = 1;
+		ret = cmd_dev_list(&ctx);
+	} else if (!strcmp(cmd, "reg"))
+		ret = cmd_dev_reg_bpf(&ctx);
+	else if (!strcmp(cmd, "unreg"))
+		ret = cmd_dev_unreg_bpf(&ctx);
+	else if (!strcmp(cmd, "help"))
+		ret = cmd_dev_help(argv[0]);
+	else
+		cmd_dev_help(argv[0]);
+
+	return ret;
+}
-- 
2.47.0


