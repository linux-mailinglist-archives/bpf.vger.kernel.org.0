Return-Path: <bpf+bounces-32464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890490DE58
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B16E288269
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5319E832;
	Tue, 18 Jun 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHCP6DZN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9219E7FB;
	Tue, 18 Jun 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745730; cv=none; b=f3QTKKKE2QEPEz9xvdOp8fG4+wEC3TFt27P6lYIEcdZ8/jimAesOqvPjzi1Y4RxNPm8gSqMusis3oikU9qq0HPOMhxj3e2E4FylN+Jn4hED0f/pDEL79LVvbXQs4W02fhckOXr2OSxu0ECYybdj6RIjTEyl23QMp71YkWBzQ+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745730; c=relaxed/simple;
	bh=+dFnDOjQPD+Z6vP+k1bbTk8LcVNoNaf7FWkSfOIJj+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6pHdEkfDu3T/mPfT34NQFCp3stRSubIsMvZMFVchDM2aZdIvBuwhhgRZC4eDpDj5RGX9d+dfKZSJCv0noQ1puEaiUdz7MUruNGuN1LW7ar7sXSfDm3smYrYtAGwpm+yOvb7UGWa09HCi8KKk2x8mQxvGycAch5qNYSUgQOpQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHCP6DZN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-705cffc5bcfso5458877b3a.3;
        Tue, 18 Jun 2024 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745725; x=1719350525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbA8jrdwdIvsJ6Aw8KYEayc+6JuZoDUTS14G5d2GZ0A=;
        b=bHCP6DZNdFL3QFE+9aFpxDlpVmOpNxWclLWU1ZgFdwpaRc0yMGE//kx1H4CIPZYykC
         +VENZBn1Xdy7gqUnHKgaJb9v2twb7C09/XwVvaxiDRoIDYBSawwQBO5phE79/Wmxx/R1
         //fR2m5hVqAJClIDc4rLd/f9ttyK3CUK7QKc2XAPrCiNeb3v+nvqrniKiDFTRWm9YDC0
         4r5ubV32V1xWcv/3G9OTx00KyVVKsXKhNbVjuRsMVxuW7q0QN1jFBThqhxSvAoj9wXCL
         Lc3Ua7NzkB8UWGuH5KFnETzPoQd1BBFb02+IBVh1UzatQoQ+qJt/B7R//Ovq3ThSgril
         QXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745725; x=1719350525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbA8jrdwdIvsJ6Aw8KYEayc+6JuZoDUTS14G5d2GZ0A=;
        b=IAfxW5dgxNYyrQxi/3ItpYC4vYBAYQYj7W1MqzHEiVx1KMNRyXNecZehPYYGAd9E6R
         8iY3FOzrrj43CrtgQT4x9u9qWt9nxMfatlfFqzUsMY+6ncL91DOhGWcIXgwqmuqgKUaF
         SdN5gnFnZV3yWQ9KYLdZRYmA8fuIgN5fvBzy/caHbqa2FlZLCu15qkeNL/Ma3/gBMF70
         2oWwpl/FNUjqyUuOFntD0npFveGwFxZ1W0Fa5fEz7w8ZUS9EOBuFVZwIrkrVEmg3Mu9M
         IEJHHqxggPao8pxzIXcvUnJ9XBBUlMWRtsOOHkz9tuvG6U+k7j92lYvPizEabF7bbkOG
         dixA==
X-Forwarded-Encrypted: i=1; AJvYcCUnyuvvypOV7m73oJXlGzNFF67Bo/wBiN560tO0+VAvsEfNARPcKNApsmdVzprl6SQ3i5D3F/xfKUutnThm2ul+B5r6
X-Gm-Message-State: AOJu0YyqA3Oswj1P94w38LdlT/nVlP4XkBjY+ABry/79h5cnINP7OrsZ
	ZtJOEGF8ntRO/wJvEBMcAlHJZJYKDfpjtGpAxvz9/AJK9RiMA/+m
X-Google-Smtp-Source: AGHT+IHyjG8+WGuIrocC1cNAY4Ds/CKoa5qD5oAQwIbTRh1i5tMOOurpTyCwlinHqAxgmdScuJqFrA==
X-Received: by 2002:aa7:849a:0:b0:705:ac54:2dd0 with SMTP id d2e1a72fcca58-70629c4f549mr987725b3a.18.1718745724125;
        Tue, 18 Jun 2024 14:22:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3013f5csm7152682a12.71.2024.06.18.14.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:22:03 -0700 (PDT)
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
Subject: [PATCH 30/30] sched_ext: Add selftests
Date: Tue, 18 Jun 2024 11:17:45 -1000
Message-ID: <20240618212056.2833381-31-tj@kernel.org>
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

From: David Vernet <dvernet@meta.com>

Add basic selftests.

Signed-off-by: David Vernet <dvernet@meta.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/sched_ext/.gitignore  |   6 +
 tools/testing/selftests/sched_ext/Makefile    | 218 ++++++++++++++++++
 tools/testing/selftests/sched_ext/config      |   9 +
 .../selftests/sched_ext/create_dsq.bpf.c      |  58 +++++
 .../testing/selftests/sched_ext/create_dsq.c  |  57 +++++
 .../sched_ext/ddsp_bogus_dsq_fail.bpf.c       |  42 ++++
 .../selftests/sched_ext/ddsp_bogus_dsq_fail.c |  57 +++++
 .../sched_ext/ddsp_vtimelocal_fail.bpf.c      |  39 ++++
 .../sched_ext/ddsp_vtimelocal_fail.c          |  56 +++++
 .../selftests/sched_ext/dsp_local_on.bpf.c    |  65 ++++++
 .../selftests/sched_ext/dsp_local_on.c        |  58 +++++
 .../sched_ext/enq_last_no_enq_fails.bpf.c     |  21 ++
 .../sched_ext/enq_last_no_enq_fails.c         |  60 +++++
 .../sched_ext/enq_select_cpu_fails.bpf.c      |  43 ++++
 .../sched_ext/enq_select_cpu_fails.c          |  61 +++++
 tools/testing/selftests/sched_ext/exit.bpf.c  |  84 +++++++
 tools/testing/selftests/sched_ext/exit.c      |  55 +++++
 tools/testing/selftests/sched_ext/exit_test.h |  20 ++
 .../testing/selftests/sched_ext/hotplug.bpf.c |  61 +++++
 tools/testing/selftests/sched_ext/hotplug.c   | 168 ++++++++++++++
 .../selftests/sched_ext/hotplug_test.h        |  15 ++
 .../sched_ext/init_enable_count.bpf.c         |  53 +++++
 .../selftests/sched_ext/init_enable_count.c   | 166 +++++++++++++
 .../testing/selftests/sched_ext/maximal.bpf.c | 132 +++++++++++
 tools/testing/selftests/sched_ext/maximal.c   |  51 ++++
 .../selftests/sched_ext/maybe_null.bpf.c      |  36 +++
 .../testing/selftests/sched_ext/maybe_null.c  |  49 ++++
 .../sched_ext/maybe_null_fail_dsp.bpf.c       |  25 ++
 .../sched_ext/maybe_null_fail_yld.bpf.c       |  28 +++
 .../testing/selftests/sched_ext/minimal.bpf.c |  21 ++
 tools/testing/selftests/sched_ext/minimal.c   |  58 +++++
 .../selftests/sched_ext/prog_run.bpf.c        |  32 +++
 tools/testing/selftests/sched_ext/prog_run.c  |  78 +++++++
 .../testing/selftests/sched_ext/reload_loop.c |  75 ++++++
 tools/testing/selftests/sched_ext/runner.c    | 201 ++++++++++++++++
 tools/testing/selftests/sched_ext/scx_test.h  | 131 +++++++++++
 .../selftests/sched_ext/select_cpu_dfl.bpf.c  |  40 ++++
 .../selftests/sched_ext/select_cpu_dfl.c      |  72 ++++++
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c |  89 +++++++
 .../sched_ext/select_cpu_dfl_nodispatch.c     |  72 ++++++
 .../sched_ext/select_cpu_dispatch.bpf.c       |  41 ++++
 .../selftests/sched_ext/select_cpu_dispatch.c |  70 ++++++
 .../select_cpu_dispatch_bad_dsq.bpf.c         |  37 +++
 .../sched_ext/select_cpu_dispatch_bad_dsq.c   |  56 +++++
 .../select_cpu_dispatch_dbl_dsp.bpf.c         |  38 +++
 .../sched_ext/select_cpu_dispatch_dbl_dsp.c   |  56 +++++
 .../sched_ext/select_cpu_vtime.bpf.c          |  92 ++++++++
 .../selftests/sched_ext/select_cpu_vtime.c    |  59 +++++
 .../selftests/sched_ext/test_example.c        |  49 ++++
 tools/testing/selftests/sched_ext/util.c      |  71 ++++++
 tools/testing/selftests/sched_ext/util.h      |  13 ++
 51 files changed, 3244 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/.gitignore
 create mode 100644 tools/testing/selftests/sched_ext/Makefile
 create mode 100644 tools/testing/selftests/sched_ext/config
 create mode 100644 tools/testing/selftests/sched_ext/create_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/create_dsq.c
 create mode 100644 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c
 create mode 100644 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c
 create mode 100644 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dsp_local_on.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
 create mode 100644 tools/testing/selftests/sched_ext/exit.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/exit.c
 create mode 100644 tools/testing/selftests/sched_ext/exit_test.h
 create mode 100644 tools/testing/selftests/sched_ext/hotplug.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/hotplug.c
 create mode 100644 tools/testing/selftests/sched_ext/hotplug_test.h
 create mode 100644 tools/testing/selftests/sched_ext/init_enable_count.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/init_enable_count.c
 create mode 100644 tools/testing/selftests/sched_ext/maximal.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/maximal.c
 create mode 100644 tools/testing/selftests/sched_ext/maybe_null.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/maybe_null.c
 create mode 100644 tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/minimal.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/minimal.c
 create mode 100644 tools/testing/selftests/sched_ext/prog_run.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/prog_run.c
 create mode 100644 tools/testing/selftests/sched_ext/reload_loop.c
 create mode 100644 tools/testing/selftests/sched_ext/runner.c
 create mode 100644 tools/testing/selftests/sched_ext/scx_test.h
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dfl.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dispatch.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/select_cpu_vtime.c
 create mode 100644 tools/testing/selftests/sched_ext/test_example.c
 create mode 100644 tools/testing/selftests/sched_ext/util.c
 create mode 100644 tools/testing/selftests/sched_ext/util.h

diff --git a/tools/testing/selftests/sched_ext/.gitignore b/tools/testing/selftests/sched_ext/.gitignore
new file mode 100644
index 000000000000..ae5491a114c0
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/.gitignore
@@ -0,0 +1,6 @@
+*
+!*.c
+!*.h
+!Makefile
+!.gitignore
+!config
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
new file mode 100644
index 000000000000..0754a2c110a1
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -0,0 +1,218 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+include ../../../build/Build.include
+include ../../../scripts/Makefile.arch
+include ../../../scripts/Makefile.include
+include ../lib.mk
+
+ifneq ($(LLVM),)
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+else
+CC := gcc
+endif # LLVM
+
+ifneq ($(CROSS_COMPILE),)
+$(error CROSS_COMPILE not supported for scx selftests)
+endif # CROSS_COMPILE
+
+CURDIR := $(abspath .)
+REPOROOT := $(abspath ../../../..)
+TOOLSDIR := $(REPOROOT)/tools
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+GENDIR := $(REPOROOT)/include/generated
+GENHDR := $(GENDIR)/autoconf.h
+SCXTOOLSDIR := $(TOOLSDIR)/sched_ext
+SCXTOOLSINCDIR := $(TOOLSDIR)/sched_ext/include
+
+OUTPUT_DIR := $(CURDIR)/build
+OBJ_DIR := $(OUTPUT_DIR)/obj
+INCLUDE_DIR := $(OUTPUT_DIR)/include
+BPFOBJ_DIR := $(OBJ_DIR)/libbpf
+SCXOBJ_DIR := $(OBJ_DIR)/sched_ext
+BPFOBJ := $(BPFOBJ_DIR)/libbpf.a
+LIBBPF_OUTPUT := $(OBJ_DIR)/libbpf/libbpf.a
+DEFAULT_BPFTOOL := $(OUTPUT_DIR)/sbin/bpftool
+HOST_BUILD_DIR := $(OBJ_DIR)
+HOST_OUTPUT_DIR := $(OUTPUT_DIR)
+
+VMLINUX_BTF_PATHS ?= ../../../../vmlinux					\
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
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include -I$(SCXTOOLSINCDIR)
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+LDFLAGS = -lelf -lz -lpthread -lzstd
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
+	     -I$(INCLUDE_DIR) -I$(APIDIR) -I$(SCXTOOLSINCDIR)			\
+	     -I$(REPOROOT)/include						\
+	     $(call get_sys_includes,$(CLANG))					\
+	     -Wall -Wno-compare-distinct-pointer-types				\
+	     -Wno-incompatible-function-pointer-types				\
+	     -O2 -mcpu=v3
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(OBJ_DIR)/libbpf $(OBJ_DIR)/libbpf				\
+	       $(OBJ_DIR)/bpftool $(OBJ_DIR)/resolve_btfids			\
+	       $(INCLUDE_DIR) $(SCXOBJ_DIR))
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
+		    $(LIBBPF_OUTPUT) | $(OBJ_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    OUTPUT=$(OBJ_DIR)/bpftool/					\
+		    LIBBPF_OUTPUT=$(OBJ_DIR)/libbpf/				\
+		    LIBBPF_DESTDIR=$(OUTPUT_DIR)/				\
+		    prefix= DESTDIR=$(OUTPUT_DIR)/ install-bin
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
+$(SCXOBJ_DIR)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h	| $(BPFOBJ) $(SCXOBJ_DIR)
+	$(call msg,CLNG-BPF,,$(notdir $@))
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BPFTOOL) | $(INCLUDE_DIR)
+	$(eval sched=$(notdir $@))
+	$(call msg,GEN-SKEL,,$(sched))
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
+	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $@
+	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(subst .bpf.skel.h,,$(sched)) > $(@:.skel.h=.subskel.h)
+
+################
+# C schedulers #
+################
+
+override define CLEAN
+	rm -rf $(OUTPUT_DIR)
+	rm -f *.o *.bpf.o *.bpf.skel.h *.bpf.subskel.h
+	rm -f $(TEST_GEN_PROGS)
+	rm -f runner
+endef
+
+# Every testcase takes all of the BPF progs are dependencies by default. This
+# allows testcases to load any BPF scheduler, which is useful for testcases
+# that don't need their own prog to run their test.
+all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
+
+auto-test-targets :=			\
+	create_dsq			\
+	enq_last_no_enq_fails		\
+	enq_select_cpu_fails		\
+	ddsp_bogus_dsq_fail		\
+	ddsp_vtimelocal_fail		\
+	dsp_local_on			\
+	exit				\
+	hotplug				\
+	init_enable_count		\
+	maximal				\
+	maybe_null			\
+	minimal				\
+	prog_run			\
+	reload_loop			\
+	select_cpu_dfl			\
+	select_cpu_dfl_nodispatch	\
+	select_cpu_dispatch		\
+	select_cpu_dispatch_bad_dsq	\
+	select_cpu_dispatch_dbl_dsp	\
+	select_cpu_vtime		\
+	test_example			\
+
+testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
+
+$(SCXOBJ_DIR)/runner.o: runner.c | $(SCXOBJ_DIR)
+	$(CC) $(CFLAGS) -c $< -o $@
+
+# Create all of the test targets object files, whose testcase objects will be
+# registered into the runner in ELF constructors.
+#
+# Note that we must do double expansion here in order to support conditionally
+# compiling BPF object files only if one is present, as the wildcard Make
+# function doesn't support using implicit rules otherwise.
+$(testcase-targets): $(SCXOBJ_DIR)/%.o: %.c $(SCXOBJ_DIR)/runner.o $(all_test_bpfprogs) | $(SCXOBJ_DIR)
+	$(eval test=$(patsubst %.o,%.c,$(notdir $@)))
+	$(CC) $(CFLAGS) -c $< -o $@ $(SCXOBJ_DIR)/runner.o
+
+$(SCXOBJ_DIR)/util.o: util.c | $(SCXOBJ_DIR)
+	$(CC) $(CFLAGS) -c $< -o $@
+
+runner: $(SCXOBJ_DIR)/runner.o $(SCXOBJ_DIR)/util.o $(BPFOBJ) $(testcase-targets)
+	@echo "$(testcase-targets)"
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+
+TEST_GEN_PROGS := runner
+
+all: runner
+
+.PHONY: all clean help
+
+.DEFAULT_GOAL := all
+
+.DELETE_ON_ERROR:
+
+.SECONDARY:
diff --git a/tools/testing/selftests/sched_ext/config b/tools/testing/selftests/sched_ext/config
new file mode 100644
index 000000000000..0de9b4ee249d
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/config
@@ -0,0 +1,9 @@
+CONFIG_SCHED_DEBUG=y
+CONFIG_SCHED_CLASS_EXT=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_EXT_GROUP_SCHED=y
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_BTF=y
diff --git a/tools/testing/selftests/sched_ext/create_dsq.bpf.c b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
new file mode 100644
index 000000000000..23f79ed343f0
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Create and destroy DSQs in a loop.
+ *
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+void BPF_STRUCT_OPS(create_dsq_exit_task, struct task_struct *p,
+		    struct scx_exit_task_args *args)
+{
+	scx_bpf_destroy_dsq(p->pid);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(create_dsq_init_task, struct task_struct *p,
+			     struct scx_init_task_args *args)
+{
+	s32 err;
+
+	err = scx_bpf_create_dsq(p->pid, -1);
+	if (err)
+		scx_bpf_error("Failed to create DSQ for %s[%d]",
+			      p->comm, p->pid);
+
+	return err;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(create_dsq_init)
+{
+	u32 i;
+	s32 err;
+
+	bpf_for(i, 0, 1024) {
+		err = scx_bpf_create_dsq(i, -1);
+		if (err) {
+			scx_bpf_error("Failed to create DSQ %d", i);
+			return 0;
+		}
+	}
+
+	bpf_for(i, 0, 1024) {
+		scx_bpf_destroy_dsq(i);
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops create_dsq_ops = {
+	.init_task		= create_dsq_init_task,
+	.exit_task		= create_dsq_exit_task,
+	.init			= create_dsq_init,
+	.name			= "create_dsq",
+};
diff --git a/tools/testing/selftests/sched_ext/create_dsq.c b/tools/testing/selftests/sched_ext/create_dsq.c
new file mode 100644
index 000000000000..fa946d9146d4
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/create_dsq.c
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "create_dsq.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct create_dsq *skel;
+
+	skel = create_dsq__open_and_load();
+	if (!skel) {
+		SCX_ERR("Failed to open and load skel");
+		return SCX_TEST_FAIL;
+	}
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct create_dsq *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.create_dsq_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct create_dsq *skel = ctx;
+
+	create_dsq__destroy(skel);
+}
+
+struct scx_test create_dsq = {
+	.name = "create_dsq",
+	.description = "Create and destroy a dsq in a loop",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&create_dsq)
diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
new file mode 100644
index 000000000000..e97ad41d354a
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	s32 cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+
+	if (cpu >= 0) {
+		/*
+		 * If we dispatch to a bogus DSQ that will fall back to the
+		 * builtin global DSQ, we fail gracefully.
+		 */
+		scx_bpf_dispatch_vtime(p, 0xcafef00d, SCX_SLICE_DFL,
+				       p->scx.dsq_vtime, 0);
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops ddsp_bogus_dsq_fail_ops = {
+	.select_cpu		= ddsp_bogus_dsq_fail_select_cpu,
+	.exit			= ddsp_bogus_dsq_fail_exit,
+	.name			= "ddsp_bogus_dsq_fail",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c
new file mode 100644
index 000000000000..e65d22f23f3b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.c
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "ddsp_bogus_dsq_fail.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct ddsp_bogus_dsq_fail *skel;
+
+	skel = ddsp_bogus_dsq_fail__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct ddsp_bogus_dsq_fail *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.ddsp_bogus_dsq_fail_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
+
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct ddsp_bogus_dsq_fail *skel = ctx;
+
+	ddsp_bogus_dsq_fail__destroy(skel);
+}
+
+struct scx_test ddsp_bogus_dsq_fail = {
+	.name = "ddsp_bogus_dsq_fail",
+	.description = "Verify we gracefully fail, and fall back to using a "
+		       "built-in DSQ, if we do a direct dispatch to an invalid"
+		       " DSQ in ops.select_cpu()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&ddsp_bogus_dsq_fail)
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
new file mode 100644
index 000000000000..dde7e7dafbfb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(ddsp_vtimelocal_fail_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	s32 cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+
+	if (cpu >= 0) {
+		/* Shouldn't be allowed to vtime dispatch to a builtin DSQ. */
+		scx_bpf_dispatch_vtime(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL,
+				       p->scx.dsq_vtime, 0);
+		return cpu;
+	}
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(ddsp_vtimelocal_fail_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops ddsp_vtimelocal_fail_ops = {
+	.select_cpu		= ddsp_vtimelocal_fail_select_cpu,
+	.exit			= ddsp_vtimelocal_fail_exit,
+	.name			= "ddsp_vtimelocal_fail",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c
new file mode 100644
index 000000000000..abafee587cd6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include "ddsp_vtimelocal_fail.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct ddsp_vtimelocal_fail *skel;
+
+	skel = ddsp_vtimelocal_fail__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct ddsp_vtimelocal_fail *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.ddsp_vtimelocal_fail_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
+
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct ddsp_vtimelocal_fail *skel = ctx;
+
+	ddsp_vtimelocal_fail__destroy(skel);
+}
+
+struct scx_test ddsp_vtimelocal_fail = {
+	.name = "ddsp_vtimelocal_fail",
+	.description = "Verify we gracefully fail, and fall back to using a "
+		       "built-in DSQ, if we do a direct vtime dispatch to a "
+		       "built-in DSQ from DSQ in ops.select_cpu()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&ddsp_vtimelocal_fail)
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
new file mode 100644
index 000000000000..efb4672decb4
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+const volatile s32 nr_cpus;
+
+UEI_DEFINE(uei);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 8192);
+	__type(value, s32);
+} queue SEC(".maps");
+
+s32 BPF_STRUCT_OPS(dsp_local_on_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(dsp_local_on_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	s32 pid = p->pid;
+
+	if (bpf_map_push_elem(&queue, &pid, 0))
+		scx_bpf_error("Failed to enqueue %s[%d]", p->comm, p->pid);
+}
+
+void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
+{
+	s32 pid, target;
+	struct task_struct *p;
+
+	if (bpf_map_pop_elem(&queue, &pid))
+		return;
+
+	p = bpf_task_from_pid(pid);
+	if (!p)
+		return;
+
+	target = bpf_get_prandom_u32() % nr_cpus;
+
+	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | target, SCX_SLICE_DFL, 0);
+	bpf_task_release(p);
+}
+
+void BPF_STRUCT_OPS(dsp_local_on_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops dsp_local_on_ops = {
+	.select_cpu		= dsp_local_on_select_cpu,
+	.enqueue		= dsp_local_on_enqueue,
+	.dispatch		= dsp_local_on_dispatch,
+	.exit			= dsp_local_on_exit,
+	.name			= "dsp_local_on",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.c b/tools/testing/selftests/sched_ext/dsp_local_on.c
new file mode 100644
index 000000000000..472851b56854
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <unistd.h>
+#include "dsp_local_on.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct dsp_local_on *skel;
+
+	skel = dsp_local_on__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+
+	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
+	SCX_FAIL_IF(dsp_local_on__load(skel), "Failed to load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct dsp_local_on *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.dsp_local_on_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
+
+	/* Just sleeping is fine, plenty of scheduling events happening */
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct dsp_local_on *skel = ctx;
+
+	dsp_local_on__destroy(skel);
+}
+
+struct scx_test dsp_local_on = {
+	.name = "dsp_local_on",
+	.description = "Verify we can directly dispatch tasks to a local DSQs "
+		       "from osp.dispatch()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&dsp_local_on)
diff --git a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c
new file mode 100644
index 000000000000..b0b99531d5d5
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.bpf.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates the behavior of direct dispatching with a default
+ * select_cpu implementation.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC(".struct_ops.link")
+struct sched_ext_ops enq_last_no_enq_fails_ops = {
+	.name			= "enq_last_no_enq_fails",
+	/* Need to define ops.enqueue() with SCX_OPS_ENQ_LAST */
+	.flags			= SCX_OPS_ENQ_LAST,
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
new file mode 100644
index 000000000000..2a3eda5e2c0b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_last_no_enq_fails.c
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "enq_last_no_enq_fails.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct enq_last_no_enq_fails *skel;
+
+	skel = enq_last_no_enq_fails__open_and_load();
+	if (!skel) {
+		SCX_ERR("Failed to open and load skel");
+		return SCX_TEST_FAIL;
+	}
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct enq_last_no_enq_fails *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.enq_last_no_enq_fails_ops);
+	if (link) {
+		SCX_ERR("Incorrectly succeeded in to attaching scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct enq_last_no_enq_fails *skel = ctx;
+
+	enq_last_no_enq_fails__destroy(skel);
+}
+
+struct scx_test enq_last_no_enq_fails = {
+	.name = "enq_last_no_enq_fails",
+	.description = "Verify we fail to load a scheduler if we specify "
+		       "the SCX_OPS_ENQ_LAST flag without defining "
+		       "ops.enqueue()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&enq_last_no_enq_fails)
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
new file mode 100644
index 000000000000..b3dfc1033cd6
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* Manually specify the signature until the kfunc is added to the scx repo. */
+s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   bool *found) __ksym;
+
+s32 BPF_STRUCT_OPS(enq_select_cpu_fails_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	/*
+	 * Need to initialize the variable or the verifier will fail to load.
+	 * Improving these semantics is actively being worked on.
+	 */
+	bool found = false;
+
+	/* Can only call from ops.select_cpu() */
+	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
+
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops enq_select_cpu_fails_ops = {
+	.select_cpu		= enq_select_cpu_fails_select_cpu,
+	.enqueue		= enq_select_cpu_fails_enqueue,
+	.name			= "enq_select_cpu_fails",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
new file mode 100644
index 000000000000..dd1350e5f002
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "enq_select_cpu_fails.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct enq_select_cpu_fails *skel;
+
+	skel = enq_select_cpu_fails__open_and_load();
+	if (!skel) {
+		SCX_ERR("Failed to open and load skel");
+		return SCX_TEST_FAIL;
+	}
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct enq_select_cpu_fails *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.enq_select_cpu_fails_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	sleep(1);
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct enq_select_cpu_fails *skel = ctx;
+
+	enq_select_cpu_fails__destroy(skel);
+}
+
+struct scx_test enq_select_cpu_fails = {
+	.name = "enq_select_cpu_fails",
+	.description = "Verify we fail to call scx_bpf_select_cpu_dfl() "
+		       "from ops.enqueue()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&enq_select_cpu_fails)
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
new file mode 100644
index 000000000000..ae12ddaac921
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#include "exit_test.h"
+
+const volatile int exit_point;
+UEI_DEFINE(uei);
+
+#define EXIT_CLEANLY() scx_bpf_exit(exit_point, "%d", exit_point)
+
+s32 BPF_STRUCT_OPS(exit_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	bool found;
+
+	if (exit_point == EXIT_SELECT_CPU)
+		EXIT_CLEANLY();
+
+	return scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+}
+
+void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	if (exit_point == EXIT_ENQUEUE)
+		EXIT_CLEANLY();
+
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
+{
+	if (exit_point == EXIT_DISPATCH)
+		EXIT_CLEANLY();
+
+	scx_bpf_consume(SCX_DSQ_GLOBAL);
+}
+
+void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
+{
+	if (exit_point == EXIT_ENABLE)
+		EXIT_CLEANLY();
+}
+
+s32 BPF_STRUCT_OPS(exit_init_task, struct task_struct *p,
+		    struct scx_init_task_args *args)
+{
+	if (exit_point == EXIT_INIT_TASK)
+		EXIT_CLEANLY();
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(exit_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(exit_init)
+{
+	if (exit_point == EXIT_INIT)
+		EXIT_CLEANLY();
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops exit_ops = {
+	.select_cpu		= exit_select_cpu,
+	.enqueue		= exit_enqueue,
+	.dispatch		= exit_dispatch,
+	.init_task		= exit_init_task,
+	.enable			= exit_enable,
+	.exit			= exit_exit,
+	.init			= exit_init,
+	.name			= "exit",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
new file mode 100644
index 000000000000..31bcd06e21cd
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "exit.bpf.skel.h"
+#include "scx_test.h"
+
+#include "exit_test.h"
+
+static enum scx_test_status run(void *ctx)
+{
+	enum exit_test_case tc;
+
+	for (tc = 0; tc < NUM_EXITS; tc++) {
+		struct exit *skel;
+		struct bpf_link *link;
+		char buf[16];
+
+		skel = exit__open();
+		skel->rodata->exit_point = tc;
+		exit__load(skel);
+		link = bpf_map__attach_struct_ops(skel->maps.exit_ops);
+		if (!link) {
+			SCX_ERR("Failed to attach scheduler");
+			exit__destroy(skel);
+			return SCX_TEST_FAIL;
+		}
+
+		/* Assumes uei.kind is written last */
+		while (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_NONE))
+			sched_yield();
+
+		SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG_BPF));
+		SCX_EQ(skel->data->uei.exit_code, tc);
+		sprintf(buf, "%d", tc);
+		SCX_ASSERT(!strcmp(skel->data->uei.msg, buf));
+		bpf_link__destroy(link);
+		exit__destroy(skel);
+	}
+
+	return SCX_TEST_PASS;
+}
+
+struct scx_test exit_test = {
+	.name = "exit",
+	.description = "Verify we can cleanly exit a scheduler in multiple places",
+	.run = run,
+};
+REGISTER_SCX_TEST(&exit_test)
diff --git a/tools/testing/selftests/sched_ext/exit_test.h b/tools/testing/selftests/sched_ext/exit_test.h
new file mode 100644
index 000000000000..94f0268b9cb8
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/exit_test.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+
+#ifndef __EXIT_TEST_H__
+#define __EXIT_TEST_H__
+
+enum exit_test_case {
+	EXIT_SELECT_CPU,
+	EXIT_ENQUEUE,
+	EXIT_DISPATCH,
+	EXIT_ENABLE,
+	EXIT_INIT_TASK,
+	EXIT_INIT,
+	NUM_EXITS,
+};
+
+#endif  // # __EXIT_TEST_H__
diff --git a/tools/testing/selftests/sched_ext/hotplug.bpf.c b/tools/testing/selftests/sched_ext/hotplug.bpf.c
new file mode 100644
index 000000000000..8f2601db39f3
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/hotplug.bpf.c
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+#include "hotplug_test.h"
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(hotplug_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+static void exit_from_hotplug(s32 cpu, bool onlining)
+{
+	/*
+	 * Ignored, just used to verify that we can invoke blocking kfuncs
+	 * from the hotplug path.
+	 */
+	scx_bpf_create_dsq(0, -1);
+
+	s64 code = SCX_ECODE_ACT_RESTART | HOTPLUG_EXIT_RSN;
+
+	if (onlining)
+		code |= HOTPLUG_ONLINING;
+
+	scx_bpf_exit(code, "hotplug event detected (%d going %s)", cpu,
+		     onlining ? "online" : "offline");
+}
+
+void BPF_STRUCT_OPS_SLEEPABLE(hotplug_cpu_online, s32 cpu)
+{
+	exit_from_hotplug(cpu, true);
+}
+
+void BPF_STRUCT_OPS_SLEEPABLE(hotplug_cpu_offline, s32 cpu)
+{
+	exit_from_hotplug(cpu, false);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops hotplug_cb_ops = {
+	.cpu_online		= hotplug_cpu_online,
+	.cpu_offline		= hotplug_cpu_offline,
+	.exit			= hotplug_exit,
+	.name			= "hotplug_cbs",
+	.timeout_ms		= 1000U,
+};
+
+SEC(".struct_ops.link")
+struct sched_ext_ops hotplug_nocb_ops = {
+	.exit			= hotplug_exit,
+	.name			= "hotplug_nocbs",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/hotplug.c b/tools/testing/selftests/sched_ext/hotplug.c
new file mode 100644
index 000000000000..87bf220b1bce
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/hotplug.c
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <sched.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "hotplug_test.h"
+#include "hotplug.bpf.skel.h"
+#include "scx_test.h"
+#include "util.h"
+
+const char *online_path = "/sys/devices/system/cpu/cpu1/online";
+
+static bool is_cpu_online(void)
+{
+	return file_read_long(online_path) > 0;
+}
+
+static void toggle_online_status(bool online)
+{
+	long val = online ? 1 : 0;
+	int ret;
+
+	ret = file_write_long(online_path, val);
+	if (ret != 0)
+		fprintf(stderr, "Failed to bring CPU %s (%s)",
+			online ? "online" : "offline", strerror(errno));
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	if (!is_cpu_online())
+		return SCX_TEST_SKIP;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status test_hotplug(bool onlining, bool cbs_defined)
+{
+	struct hotplug *skel;
+	struct bpf_link *link;
+	long kind, code;
+
+	SCX_ASSERT(is_cpu_online());
+
+	skel = hotplug__open_and_load();
+	SCX_ASSERT(skel);
+
+	/* Testing the offline -> online path, so go offline before starting */
+	if (onlining)
+		toggle_online_status(0);
+
+	if (cbs_defined) {
+		kind = SCX_KIND_VAL(SCX_EXIT_UNREG_BPF);
+		code = SCX_ECODE_VAL(SCX_ECODE_ACT_RESTART) | HOTPLUG_EXIT_RSN;
+		if (onlining)
+			code |= HOTPLUG_ONLINING;
+	} else {
+		kind = SCX_KIND_VAL(SCX_EXIT_UNREG_KERN);
+		code = SCX_ECODE_VAL(SCX_ECODE_ACT_RESTART) |
+		       SCX_ECODE_VAL(SCX_ECODE_RSN_HOTPLUG);
+	}
+
+	if (cbs_defined)
+		link = bpf_map__attach_struct_ops(skel->maps.hotplug_cb_ops);
+	else
+		link = bpf_map__attach_struct_ops(skel->maps.hotplug_nocb_ops);
+
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		hotplug__destroy(skel);
+		return SCX_TEST_FAIL;
+	}
+
+	toggle_online_status(onlining ? 1 : 0);
+
+	while (!UEI_EXITED(skel, uei))
+		sched_yield();
+
+	SCX_EQ(skel->data->uei.kind, kind);
+	SCX_EQ(UEI_REPORT(skel, uei), code);
+
+	if (!onlining)
+		toggle_online_status(1);
+
+	bpf_link__destroy(link);
+	hotplug__destroy(skel);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status test_hotplug_attach(void)
+{
+	struct hotplug *skel;
+	struct bpf_link *link;
+	enum scx_test_status status = SCX_TEST_PASS;
+	long kind, code;
+
+	SCX_ASSERT(is_cpu_online());
+	SCX_ASSERT(scx_hotplug_seq() > 0);
+
+	skel = SCX_OPS_OPEN(hotplug_nocb_ops, hotplug);
+	SCX_ASSERT(skel);
+
+	SCX_OPS_LOAD(skel, hotplug_nocb_ops, hotplug, uei);
+
+	/*
+	 * Take the CPU offline to increment the global hotplug seq, which
+	 * should cause attach to fail due to us setting the hotplug seq above
+	 */
+	toggle_online_status(0);
+	link = bpf_map__attach_struct_ops(skel->maps.hotplug_nocb_ops);
+
+	toggle_online_status(1);
+
+	SCX_ASSERT(link);
+	while (!UEI_EXITED(skel, uei))
+		sched_yield();
+
+	kind = SCX_KIND_VAL(SCX_EXIT_UNREG_KERN);
+	code = SCX_ECODE_VAL(SCX_ECODE_ACT_RESTART) |
+	       SCX_ECODE_VAL(SCX_ECODE_RSN_HOTPLUG);
+	SCX_EQ(skel->data->uei.kind, kind);
+	SCX_EQ(UEI_REPORT(skel, uei), code);
+
+	bpf_link__destroy(link);
+	hotplug__destroy(skel);
+
+	return status;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+
+#define HP_TEST(__onlining, __cbs_defined) ({				\
+	if (test_hotplug(__onlining, __cbs_defined) != SCX_TEST_PASS)	\
+		return SCX_TEST_FAIL;					\
+})
+
+	HP_TEST(true, true);
+	HP_TEST(false, true);
+	HP_TEST(true, false);
+	HP_TEST(false, false);
+
+#undef HP_TEST
+
+	return test_hotplug_attach();
+}
+
+static void cleanup(void *ctx)
+{
+	toggle_online_status(1);
+}
+
+struct scx_test hotplug_test = {
+	.name = "hotplug",
+	.description = "Verify hotplug behavior",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&hotplug_test)
diff --git a/tools/testing/selftests/sched_ext/hotplug_test.h b/tools/testing/selftests/sched_ext/hotplug_test.h
new file mode 100644
index 000000000000..73d236f90787
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/hotplug_test.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+
+#ifndef __HOTPLUG_TEST_H__
+#define __HOTPLUG_TEST_H__
+
+enum hotplug_test_flags {
+	HOTPLUG_EXIT_RSN = 1LLU << 0,
+	HOTPLUG_ONLINING = 1LLU << 1,
+};
+
+#endif  // # __HOTPLUG_TEST_H__
diff --git a/tools/testing/selftests/sched_ext/init_enable_count.bpf.c b/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
new file mode 100644
index 000000000000..47ea89a626c3
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that verifies that we do proper counting of init, enable, etc
+ * callbacks.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+u64 init_task_cnt, exit_task_cnt, enable_cnt, disable_cnt;
+u64 init_fork_cnt, init_transition_cnt;
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(cnt_init_task, struct task_struct *p,
+			     struct scx_init_task_args *args)
+{
+	__sync_fetch_and_add(&init_task_cnt, 1);
+
+	if (args->fork)
+		__sync_fetch_and_add(&init_fork_cnt, 1);
+	else
+		__sync_fetch_and_add(&init_transition_cnt, 1);
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(cnt_exit_task, struct task_struct *p)
+{
+	__sync_fetch_and_add(&exit_task_cnt, 1);
+}
+
+void BPF_STRUCT_OPS(cnt_enable, struct task_struct *p)
+{
+	__sync_fetch_and_add(&enable_cnt, 1);
+}
+
+void BPF_STRUCT_OPS(cnt_disable, struct task_struct *p)
+{
+	__sync_fetch_and_add(&disable_cnt, 1);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops init_enable_count_ops = {
+	.init_task	= cnt_init_task,
+	.exit_task	= cnt_exit_task,
+	.enable		= cnt_enable,
+	.disable	= cnt_disable,
+	.name		= "init_enable_count",
+};
diff --git a/tools/testing/selftests/sched_ext/init_enable_count.c b/tools/testing/selftests/sched_ext/init_enable_count.c
new file mode 100644
index 000000000000..97d45f1e5597
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/init_enable_count.c
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <sched.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include "scx_test.h"
+#include "init_enable_count.bpf.skel.h"
+
+#define SCHED_EXT 7
+
+static struct init_enable_count *
+open_load_prog(bool global)
+{
+	struct init_enable_count *skel;
+
+	skel = init_enable_count__open();
+	SCX_BUG_ON(!skel, "Failed to open skel");
+
+	if (!global)
+		skel->struct_ops.init_enable_count_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
+
+	SCX_BUG_ON(init_enable_count__load(skel), "Failed to load skel");
+
+	return skel;
+}
+
+static enum scx_test_status run_test(bool global)
+{
+	struct init_enable_count *skel;
+	struct bpf_link *link;
+	const u32 num_children = 5, num_pre_forks = 1024;
+	int ret, i, status;
+	struct sched_param param = {};
+	pid_t pids[num_pre_forks];
+
+	skel = open_load_prog(global);
+
+	/*
+	 * Fork a bunch of children before we attach the scheduler so that we
+	 * ensure (at least in practical terms) that there are more tasks that
+	 * transition from SCHED_OTHER -> SCHED_EXT than there are tasks that
+	 * take the fork() path either below or in other processes.
+	 */
+	for (i = 0; i < num_pre_forks; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork child");
+		if (pids[i] == 0) {
+			sleep(1);
+			exit(0);
+		}
+	}
+
+	link = bpf_map__attach_struct_ops(skel->maps.init_enable_count_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
+
+	for (i = 0; i < num_pre_forks; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for pre-forked child\n");
+
+		SCX_FAIL_IF(status != 0, "Pre-forked child %d exited with status %d\n", i,
+			    status);
+	}
+
+	bpf_link__destroy(link);
+	SCX_GE(skel->bss->init_task_cnt, num_pre_forks);
+	SCX_GE(skel->bss->exit_task_cnt, num_pre_forks);
+
+	link = bpf_map__attach_struct_ops(skel->maps.init_enable_count_ops);
+	SCX_FAIL_IF(!link, "Failed to attach struct_ops");
+
+	/* SCHED_EXT children */
+	for (i = 0; i < num_children; i++) {
+		pids[i] = fork();
+		SCX_FAIL_IF(pids[i] < 0, "Failed to fork child");
+
+		if (pids[i] == 0) {
+			ret = sched_setscheduler(0, SCHED_EXT, &param);
+			SCX_BUG_ON(ret, "Failed to set sched to sched_ext");
+
+			/*
+			 * Reset to SCHED_OTHER for half of them. Counts for
+			 * everything should still be the same regardless, as
+			 * ops.disable() is invoked even if a task is still on
+			 * SCHED_EXT before it exits.
+			 */
+			if (i % 2 == 0) {
+				ret = sched_setscheduler(0, SCHED_OTHER, &param);
+				SCX_BUG_ON(ret, "Failed to reset sched to normal");
+			}
+			exit(0);
+		}
+	}
+	for (i = 0; i < num_children; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for SCX child\n");
+
+		SCX_FAIL_IF(status != 0, "SCX child %d exited with status %d\n", i,
+			    status);
+	}
+
+	/* SCHED_OTHER children */
+	for (i = 0; i < num_children; i++) {
+		pids[i] = fork();
+		if (pids[i] == 0)
+			exit(0);
+	}
+
+	for (i = 0; i < num_children; i++) {
+		SCX_FAIL_IF(waitpid(pids[i], &status, 0) != pids[i],
+			    "Failed to wait for normal child\n");
+
+		SCX_FAIL_IF(status != 0, "Normal child %d exited with status %d\n", i,
+			    status);
+	}
+
+	bpf_link__destroy(link);
+
+	SCX_GE(skel->bss->init_task_cnt, 2 * num_children);
+	SCX_GE(skel->bss->exit_task_cnt, 2 * num_children);
+
+	if (global) {
+		SCX_GE(skel->bss->enable_cnt, 2 * num_children);
+		SCX_GE(skel->bss->disable_cnt, 2 * num_children);
+	} else {
+		SCX_EQ(skel->bss->enable_cnt, num_children);
+		SCX_EQ(skel->bss->disable_cnt, num_children);
+	}
+	/*
+	 * We forked a ton of tasks before we attached the scheduler above, so
+	 * this should be fine. Technically it could be flaky if a ton of forks
+	 * are happening at the same time in other processes, but that should
+	 * be exceedingly unlikely.
+	 */
+	SCX_GT(skel->bss->init_transition_cnt, skel->bss->init_fork_cnt);
+	SCX_GE(skel->bss->init_fork_cnt, 2 * num_children);
+
+	init_enable_count__destroy(skel);
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	enum scx_test_status status;
+
+	status = run_test(true);
+	if (status != SCX_TEST_PASS)
+		return status;
+
+	return run_test(false);
+}
+
+struct scx_test init_enable_count = {
+	.name = "init_enable_count",
+	.description = "Verify we do the correct amount of counting of init, "
+		       "enable, etc callbacks.",
+	.run = run,
+};
+REGISTER_SCX_TEST(&init_enable_count)
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
new file mode 100644
index 000000000000..44612fdaf399
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler with every callback defined.
+ *
+ * This scheduler defines every callback.
+ *
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
+		   u64 wake_flags)
+{
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
+{}
+
+void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_consume(SCX_DSQ_GLOBAL);
+}
+
+void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
+{}
+
+void BPF_STRUCT_OPS(maximal_running, struct task_struct *p)
+{}
+
+void BPF_STRUCT_OPS(maximal_stopping, struct task_struct *p, bool runnable)
+{}
+
+void BPF_STRUCT_OPS(maximal_quiescent, struct task_struct *p, u64 deq_flags)
+{}
+
+bool BPF_STRUCT_OPS(maximal_yield, struct task_struct *from,
+		    struct task_struct *to)
+{
+	return false;
+}
+
+bool BPF_STRUCT_OPS(maximal_core_sched_before, struct task_struct *a,
+		    struct task_struct *b)
+{
+	return false;
+}
+
+void BPF_STRUCT_OPS(maximal_set_weight, struct task_struct *p, u32 weight)
+{}
+
+void BPF_STRUCT_OPS(maximal_set_cpumask, struct task_struct *p,
+		    const struct cpumask *cpumask)
+{}
+
+void BPF_STRUCT_OPS(maximal_update_idle, s32 cpu, bool idle)
+{}
+
+void BPF_STRUCT_OPS(maximal_cpu_acquire, s32 cpu,
+		    struct scx_cpu_acquire_args *args)
+{}
+
+void BPF_STRUCT_OPS(maximal_cpu_release, s32 cpu,
+		    struct scx_cpu_release_args *args)
+{}
+
+void BPF_STRUCT_OPS(maximal_cpu_online, s32 cpu)
+{}
+
+void BPF_STRUCT_OPS(maximal_cpu_offline, s32 cpu)
+{}
+
+s32 BPF_STRUCT_OPS(maximal_init_task, struct task_struct *p,
+		   struct scx_init_task_args *args)
+{
+	return 0;
+}
+
+void BPF_STRUCT_OPS(maximal_enable, struct task_struct *p)
+{}
+
+void BPF_STRUCT_OPS(maximal_exit_task, struct task_struct *p,
+		    struct scx_exit_task_args *args)
+{}
+
+void BPF_STRUCT_OPS(maximal_disable, struct task_struct *p)
+{}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
+{
+	return 0;
+}
+
+void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
+{}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops maximal_ops = {
+	.select_cpu		= maximal_select_cpu,
+	.enqueue		= maximal_enqueue,
+	.dequeue		= maximal_dequeue,
+	.dispatch		= maximal_dispatch,
+	.runnable		= maximal_runnable,
+	.running		= maximal_running,
+	.stopping		= maximal_stopping,
+	.quiescent		= maximal_quiescent,
+	.yield			= maximal_yield,
+	.core_sched_before	= maximal_core_sched_before,
+	.set_weight		= maximal_set_weight,
+	.set_cpumask		= maximal_set_cpumask,
+	.update_idle		= maximal_update_idle,
+	.cpu_acquire		= maximal_cpu_acquire,
+	.cpu_release		= maximal_cpu_release,
+	.cpu_online		= maximal_cpu_online,
+	.cpu_offline		= maximal_cpu_offline,
+	.init_task		= maximal_init_task,
+	.enable			= maximal_enable,
+	.exit_task		= maximal_exit_task,
+	.disable		= maximal_disable,
+	.init			= maximal_init,
+	.exit			= maximal_exit,
+	.name			= "maximal",
+};
diff --git a/tools/testing/selftests/sched_ext/maximal.c b/tools/testing/selftests/sched_ext/maximal.c
new file mode 100644
index 000000000000..f38fc973c380
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/maximal.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "maximal.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct maximal *skel;
+
+	skel = maximal__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct maximal *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.maximal_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct maximal *skel = ctx;
+
+	maximal__destroy(skel);
+}
+
+struct scx_test maximal = {
+	.name = "maximal",
+	.description = "Verify we can load a scheduler with every callback defined",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&maximal)
diff --git a/tools/testing/selftests/sched_ext/maybe_null.bpf.c b/tools/testing/selftests/sched_ext/maybe_null.bpf.c
new file mode 100644
index 000000000000..27d0f386acfb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/maybe_null.bpf.c
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+u64 vtime_test;
+
+void BPF_STRUCT_OPS(maybe_null_running, struct task_struct *p)
+{}
+
+void BPF_STRUCT_OPS(maybe_null_success_dispatch, s32 cpu, struct task_struct *p)
+{
+	if (p != NULL)
+		vtime_test = p->scx.dsq_vtime;
+}
+
+bool BPF_STRUCT_OPS(maybe_null_success_yield, struct task_struct *from,
+		    struct task_struct *to)
+{
+	if (to)
+		bpf_printk("Yielding to %s[%d]", to->comm, to->pid);
+
+	return false;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops maybe_null_success = {
+	.dispatch               = maybe_null_success_dispatch,
+	.yield			= maybe_null_success_yield,
+	.enable			= maybe_null_running,
+	.name			= "minimal",
+};
diff --git a/tools/testing/selftests/sched_ext/maybe_null.c b/tools/testing/selftests/sched_ext/maybe_null.c
new file mode 100644
index 000000000000..31cfafb0cf65
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/maybe_null.c
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "maybe_null.bpf.skel.h"
+#include "maybe_null_fail_dsp.bpf.skel.h"
+#include "maybe_null_fail_yld.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status run(void *ctx)
+{
+	struct maybe_null *skel;
+	struct maybe_null_fail_dsp *fail_dsp;
+	struct maybe_null_fail_yld *fail_yld;
+
+	skel = maybe_null__open_and_load();
+	if (!skel) {
+		SCX_ERR("Failed to open and load maybe_null skel");
+		return SCX_TEST_FAIL;
+	}
+	maybe_null__destroy(skel);
+
+	fail_dsp = maybe_null_fail_dsp__open_and_load();
+	if (fail_dsp) {
+		maybe_null_fail_dsp__destroy(fail_dsp);
+		SCX_ERR("Should failed to open and load maybe_null_fail_dsp skel");
+		return SCX_TEST_FAIL;
+	}
+
+	fail_yld = maybe_null_fail_yld__open_and_load();
+	if (fail_yld) {
+		maybe_null_fail_yld__destroy(fail_yld);
+		SCX_ERR("Should failed to open and load maybe_null_fail_yld skel");
+		return SCX_TEST_FAIL;
+	}
+
+	return SCX_TEST_PASS;
+}
+
+struct scx_test maybe_null = {
+	.name = "maybe_null",
+	.description = "Verify if PTR_MAYBE_NULL work for .dispatch",
+	.run = run,
+};
+REGISTER_SCX_TEST(&maybe_null)
diff --git a/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c b/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
new file mode 100644
index 000000000000..c0641050271d
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+u64 vtime_test;
+
+void BPF_STRUCT_OPS(maybe_null_running, struct task_struct *p)
+{}
+
+void BPF_STRUCT_OPS(maybe_null_fail_dispatch, s32 cpu, struct task_struct *p)
+{
+	vtime_test = p->scx.dsq_vtime;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops maybe_null_fail = {
+	.dispatch               = maybe_null_fail_dispatch,
+	.enable			= maybe_null_running,
+	.name			= "maybe_null_fail_dispatch",
+};
diff --git a/tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c b/tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c
new file mode 100644
index 000000000000..3c1740028e3b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+u64 vtime_test;
+
+void BPF_STRUCT_OPS(maybe_null_running, struct task_struct *p)
+{}
+
+bool BPF_STRUCT_OPS(maybe_null_fail_yield, struct task_struct *from,
+		    struct task_struct *to)
+{
+	bpf_printk("Yielding to %s[%d]", to->comm, to->pid);
+
+	return false;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops maybe_null_fail = {
+	.yield			= maybe_null_fail_yield,
+	.enable			= maybe_null_running,
+	.name			= "maybe_null_fail_yield",
+};
diff --git a/tools/testing/selftests/sched_ext/minimal.bpf.c b/tools/testing/selftests/sched_ext/minimal.bpf.c
new file mode 100644
index 000000000000..6a7eccef0104
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/minimal.bpf.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A completely minimal scheduler.
+ *
+ * This scheduler defines the absolute minimal set of struct sched_ext_ops
+ * fields: its name. It should _not_ fail to be loaded, and can be used to
+ * exercise the default scheduling paths in ext.c.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC(".struct_ops.link")
+struct sched_ext_ops minimal_ops = {
+	.name			= "minimal",
+};
diff --git a/tools/testing/selftests/sched_ext/minimal.c b/tools/testing/selftests/sched_ext/minimal.c
new file mode 100644
index 000000000000..6c5db8ebbf8a
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/minimal.c
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "minimal.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct minimal *skel;
+
+	skel = minimal__open_and_load();
+	if (!skel) {
+		SCX_ERR("Failed to open and load skel");
+		return SCX_TEST_FAIL;
+	}
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct minimal *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.minimal_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		return SCX_TEST_FAIL;
+	}
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct minimal *skel = ctx;
+
+	minimal__destroy(skel);
+}
+
+struct scx_test minimal = {
+	.name = "minimal",
+	.description = "Verify we can load a fully minimal scheduler",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&minimal)
diff --git a/tools/testing/selftests/sched_ext/prog_run.bpf.c b/tools/testing/selftests/sched_ext/prog_run.bpf.c
new file mode 100644
index 000000000000..fd2c8f12af16
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/prog_run.bpf.c
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates that we can invoke sched_ext kfuncs in
+ * BPF_PROG_TYPE_SYSCALL programs.
+ *
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+
+#include <scx/common.bpf.h>
+
+UEI_DEFINE(uei);
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+int BPF_PROG(prog_run_syscall)
+{
+	scx_bpf_exit(0xdeadbeef, "Exited from PROG_RUN");
+	return 0;
+}
+
+void BPF_STRUCT_OPS(prog_run_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops prog_run_ops = {
+	.exit			= prog_run_exit,
+	.name			= "prog_run",
+};
diff --git a/tools/testing/selftests/sched_ext/prog_run.c b/tools/testing/selftests/sched_ext/prog_run.c
new file mode 100644
index 000000000000..3cd57ef8daaa
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/prog_run.c
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <sched.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "prog_run.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct prog_run *skel;
+
+	skel = prog_run__open_and_load();
+	if (!skel) {
+		SCX_ERR("Failed to open and load skel");
+		return SCX_TEST_FAIL;
+	}
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct prog_run *skel = ctx;
+	struct bpf_link *link;
+	int prog_fd, err = 0;
+
+	prog_fd = bpf_program__fd(skel->progs.prog_run_syscall);
+	if (prog_fd < 0) {
+		SCX_ERR("Failed to get BPF_PROG_RUN prog");
+		return SCX_TEST_FAIL;
+	}
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	link = bpf_map__attach_struct_ops(skel->maps.prog_run_ops);
+	if (!link) {
+		SCX_ERR("Failed to attach scheduler");
+		close(prog_fd);
+		return SCX_TEST_FAIL;
+	}
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	SCX_EQ(err, 0);
+
+	/* Assumes uei.kind is written last */
+	while (skel->data->uei.kind == EXIT_KIND(SCX_EXIT_NONE))
+		sched_yield();
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_UNREG_BPF));
+	SCX_EQ(skel->data->uei.exit_code, 0xdeadbeef);
+	close(prog_fd);
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct prog_run *skel = ctx;
+
+	prog_run__destroy(skel);
+}
+
+struct scx_test prog_run = {
+	.name = "prog_run",
+	.description = "Verify we can call into a scheduler with BPF_PROG_RUN, and invoke kfuncs",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&prog_run)
diff --git a/tools/testing/selftests/sched_ext/reload_loop.c b/tools/testing/selftests/sched_ext/reload_loop.c
new file mode 100644
index 000000000000..5cfba2d6e056
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/reload_loop.c
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <pthread.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "maximal.bpf.skel.h"
+#include "scx_test.h"
+
+static struct maximal *skel;
+static pthread_t threads[2];
+
+bool force_exit = false;
+
+static enum scx_test_status setup(void **ctx)
+{
+	skel = maximal__open_and_load();
+	if (!skel) {
+		SCX_ERR("Failed to open and load skel");
+		return SCX_TEST_FAIL;
+	}
+
+	return SCX_TEST_PASS;
+}
+
+static void *do_reload_loop(void *arg)
+{
+	u32 i;
+
+	for (i = 0; i < 1024 && !force_exit; i++) {
+		struct bpf_link *link;
+
+		link = bpf_map__attach_struct_ops(skel->maps.maximal_ops);
+		if (link)
+			bpf_link__destroy(link);
+	}
+
+	return NULL;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	int err;
+	void *ret;
+
+	err = pthread_create(&threads[0], NULL, do_reload_loop, NULL);
+	SCX_FAIL_IF(err, "Failed to create thread 0");
+
+	err = pthread_create(&threads[1], NULL, do_reload_loop, NULL);
+	SCX_FAIL_IF(err, "Failed to create thread 1");
+
+	SCX_FAIL_IF(pthread_join(threads[0], &ret), "thread 0 failed");
+	SCX_FAIL_IF(pthread_join(threads[1], &ret), "thread 1 failed");
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	force_exit = true;
+	maximal__destroy(skel);
+}
+
+struct scx_test reload_loop = {
+	.name = "reload_loop",
+	.description = "Stress test loading and unloading schedulers repeatedly in a tight loop",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&reload_loop)
diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
new file mode 100644
index 000000000000..eab48c7ff309
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/runner.c
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "scx_test.h"
+
+const char help_fmt[] =
+"The runner for sched_ext tests.\n"
+"\n"
+"The runner is statically linked against all testcases, and runs them all serially.\n"
+"It's required for the testcases to be serial, as only a single host-wide sched_ext\n"
+"scheduler may be loaded at any given time."
+"\n"
+"Usage: %s [-t TEST] [-h]\n"
+"\n"
+"  -t TEST       Only run tests whose name includes this string\n"
+"  -s            Include print output for skipped tests\n"
+"  -q            Don't print the test descriptions during run\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+static bool quiet, print_skipped;
+
+#define MAX_SCX_TESTS 2048
+
+static struct scx_test __scx_tests[MAX_SCX_TESTS];
+static unsigned __scx_num_tests = 0;
+
+static void sigint_handler(int simple)
+{
+	exit_req = 1;
+}
+
+static void print_test_preamble(const struct scx_test *test, bool quiet)
+{
+	printf("===== START =====\n");
+	printf("TEST: %s\n", test->name);
+	if (!quiet)
+		printf("DESCRIPTION: %s\n", test->description);
+	printf("OUTPUT:\n");
+}
+
+static const char *status_to_result(enum scx_test_status status)
+{
+	switch (status) {
+	case SCX_TEST_PASS:
+	case SCX_TEST_SKIP:
+		return "ok";
+	case SCX_TEST_FAIL:
+		return "not ok";
+	default:
+		return "<UNKNOWN>";
+	}
+}
+
+static void print_test_result(const struct scx_test *test,
+			      enum scx_test_status status,
+			      unsigned int testnum)
+{
+	const char *result = status_to_result(status);
+	const char *directive = status == SCX_TEST_SKIP ? "SKIP " : "";
+
+	printf("%s %u %s # %s\n", result, testnum, test->name, directive);
+	printf("=====  END  =====\n");
+}
+
+static bool should_skip_test(const struct scx_test *test, const char * filter)
+{
+	return !strstr(test->name, filter);
+}
+
+static enum scx_test_status run_test(const struct scx_test *test)
+{
+	enum scx_test_status status;
+	void *context = NULL;
+
+	if (test->setup) {
+		status = test->setup(&context);
+		if (status != SCX_TEST_PASS)
+			return status;
+	}
+
+	status = test->run(context);
+
+	if (test->cleanup)
+		test->cleanup(context);
+
+	return status;
+}
+
+static bool test_valid(const struct scx_test *test)
+{
+	if (!test) {
+		fprintf(stderr, "NULL test detected\n");
+		return false;
+	}
+
+	if (!test->name) {
+		fprintf(stderr,
+			"Test with no name found. Must specify test name.\n");
+		return false;
+	}
+
+	if (!test->description) {
+		fprintf(stderr, "Test %s requires description.\n", test->name);
+		return false;
+	}
+
+	if (!test->run) {
+		fprintf(stderr, "Test %s has no run() callback\n", test->name);
+		return false;
+	}
+
+	return true;
+}
+
+int main(int argc, char **argv)
+{
+	const char *filter = NULL;
+	unsigned testnum = 0, i;
+	unsigned passed = 0, skipped = 0, failed = 0;
+	int opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	while ((opt = getopt(argc, argv, "qst:h")) != -1) {
+		switch (opt) {
+		case 'q':
+			quiet = true;
+			break;
+		case 's':
+			print_skipped = true;
+			break;
+		case 't':
+			filter = optarg;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	for (i = 0; i < __scx_num_tests; i++) {
+		enum scx_test_status status;
+		struct scx_test *test = &__scx_tests[i];
+
+		if (filter && should_skip_test(test, filter)) {
+			/*
+			 * Printing the skipped tests and their preambles can
+			 * add a lot of noise to the runner output. Printing
+			 * this is only really useful for CI, so let's skip it
+			 * by default.
+			 */
+			if (print_skipped) {
+				print_test_preamble(test, quiet);
+				print_test_result(test, SCX_TEST_SKIP, ++testnum);
+			}
+			continue;
+		}
+
+		print_test_preamble(test, quiet);
+		status = run_test(test);
+		print_test_result(test, status, ++testnum);
+		switch (status) {
+		case SCX_TEST_PASS:
+			passed++;
+			break;
+		case SCX_TEST_SKIP:
+			skipped++;
+			break;
+		case SCX_TEST_FAIL:
+			failed++;
+			break;
+		}
+	}
+	printf("\n\n=============================\n\n");
+	printf("RESULTS:\n\n");
+	printf("PASSED:  %u\n", passed);
+	printf("SKIPPED: %u\n", skipped);
+	printf("FAILED:  %u\n", failed);
+
+	return 0;
+}
+
+void scx_test_register(struct scx_test *test)
+{
+	SCX_BUG_ON(!test_valid(test), "Invalid test found");
+	SCX_BUG_ON(__scx_num_tests >= MAX_SCX_TESTS, "Maximum tests exceeded");
+
+	__scx_tests[__scx_num_tests++] = *test;
+}
diff --git a/tools/testing/selftests/sched_ext/scx_test.h b/tools/testing/selftests/sched_ext/scx_test.h
new file mode 100644
index 000000000000..90b8d6915bb7
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/scx_test.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ */
+
+#ifndef __SCX_TEST_H__
+#define __SCX_TEST_H__
+
+#include <errno.h>
+#include <scx/common.h>
+#include <scx/compat.h>
+
+enum scx_test_status {
+	SCX_TEST_PASS = 0,
+	SCX_TEST_SKIP,
+	SCX_TEST_FAIL,
+};
+
+#define EXIT_KIND(__ent) __COMPAT_ENUM_OR_ZERO("scx_exit_kind", #__ent)
+
+struct scx_test {
+	/**
+	 * name - The name of the testcase.
+	 */
+	const char *name;
+
+	/**
+	 * description - A description of your testcase: what it tests and is
+	 * meant to validate.
+	 */
+	const char *description;
+
+	/*
+	 * setup - Setup the test.
+	 * @ctx: A pointer to a context object that will be passed to run and
+	 *	 cleanup.
+	 *
+	 * An optional callback that allows a testcase to perform setup for its
+	 * run. A test may return SCX_TEST_SKIP to skip the run.
+	 */
+	enum scx_test_status (*setup)(void **ctx);
+
+	/*
+	 * run - Run the test.
+	 * @ctx: Context set in the setup() callback. If @ctx was not set in
+	 *	 setup(), it is NULL.
+	 *
+	 * The main test. Callers should return one of:
+	 *
+	 * - SCX_TEST_PASS: Test passed
+	 * - SCX_TEST_SKIP: Test should be skipped
+	 * - SCX_TEST_FAIL: Test failed
+	 *
+	 * This callback must be defined.
+	 */
+	enum scx_test_status (*run)(void *ctx);
+
+	/*
+	 * cleanup - Perform cleanup following the test
+	 * @ctx: Context set in the setup() callback. If @ctx was not set in
+	 *	 setup(), it is NULL.
+	 *
+	 * An optional callback that allows a test to perform cleanup after
+	 * being run. This callback is run even if the run() callback returns
+	 * SCX_TEST_SKIP or SCX_TEST_FAIL. It is not run if setup() returns
+	 * SCX_TEST_SKIP or SCX_TEST_FAIL.
+	 */
+	void (*cleanup)(void *ctx);
+};
+
+void scx_test_register(struct scx_test *test);
+
+#define REGISTER_SCX_TEST(__test)			\
+	__attribute__((constructor))			\
+	static void ___scxregister##__LINE__(void)	\
+	{						\
+		scx_test_register(__test);		\
+	}
+
+#define SCX_ERR(__fmt, ...)						\
+	do {								\
+		fprintf(stderr, "ERR: %s:%d\n", __FILE__, __LINE__);	\
+		fprintf(stderr, __fmt"\n", ##__VA_ARGS__);			\
+	} while (0)
+
+#define SCX_FAIL(__fmt, ...)						\
+	do {								\
+		SCX_ERR(__fmt, ##__VA_ARGS__);				\
+		return SCX_TEST_FAIL;					\
+	} while (0)
+
+#define SCX_FAIL_IF(__cond, __fmt, ...)					\
+	do {								\
+		if (__cond)						\
+			SCX_FAIL(__fmt, ##__VA_ARGS__);			\
+	} while (0)
+
+#define SCX_GT(_x, _y) SCX_FAIL_IF((_x) <= (_y), "Expected %s > %s (%lu > %lu)",	\
+				   #_x, #_y, (u64)(_x), (u64)(_y))
+#define SCX_GE(_x, _y) SCX_FAIL_IF((_x) < (_y), "Expected %s >= %s (%lu >= %lu)",	\
+				   #_x, #_y, (u64)(_x), (u64)(_y))
+#define SCX_LT(_x, _y) SCX_FAIL_IF((_x) >= (_y), "Expected %s < %s (%lu < %lu)",	\
+				   #_x, #_y, (u64)(_x), (u64)(_y))
+#define SCX_LE(_x, _y) SCX_FAIL_IF((_x) > (_y), "Expected %s <= %s (%lu <= %lu)",	\
+				   #_x, #_y, (u64)(_x), (u64)(_y))
+#define SCX_EQ(_x, _y) SCX_FAIL_IF((_x) != (_y), "Expected %s == %s (%lu == %lu)",	\
+				   #_x, #_y, (u64)(_x), (u64)(_y))
+#define SCX_ASSERT(_x) SCX_FAIL_IF(!(_x), "Expected %s to be true (%lu)",		\
+				   #_x, (u64)(_x))
+
+#define SCX_ECODE_VAL(__ecode) ({						\
+        u64 __val = 0;								\
+	bool __found = false;							\
+										\
+	__found = __COMPAT_read_enum("scx_exit_code", #__ecode, &__val);	\
+	SCX_ASSERT(__found);							\
+	(s64)__val;								\
+})
+
+#define SCX_KIND_VAL(__kind) ({							\
+        u64 __val = 0;								\
+	bool __found = false;							\
+										\
+	__found = __COMPAT_read_enum("scx_exit_kind", #__kind, &__val);		\
+	SCX_ASSERT(__found);							\
+	__val;									\
+})
+
+#endif  // # __SCX_TEST_H__
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
new file mode 100644
index 000000000000..2ed2991afafe
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates the behavior of direct dispatching with a default
+ * select_cpu implementation.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+bool saw_local = false;
+
+static bool task_is_test(const struct task_struct *p)
+{
+	return !bpf_strncmp(p->comm, 9, "select_cpu");
+}
+
+void BPF_STRUCT_OPS(select_cpu_dfl_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	const struct cpumask *idle_mask = scx_bpf_get_idle_cpumask();
+
+	if (task_is_test(p) &&
+	    bpf_cpumask_test_cpu(scx_bpf_task_cpu(p), idle_mask)) {
+		saw_local = true;
+	}
+	scx_bpf_put_idle_cpumask(idle_mask);
+
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops select_cpu_dfl_ops = {
+	.enqueue		= select_cpu_dfl_enqueue,
+	.name			= "select_cpu_dfl",
+};
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
new file mode 100644
index 000000000000..a53a40c2d2f0
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "select_cpu_dfl.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_CHILDREN 1028
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct select_cpu_dfl *skel;
+
+	skel = select_cpu_dfl__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct select_cpu_dfl *skel = ctx;
+	struct bpf_link *link;
+	pid_t pids[NUM_CHILDREN];
+	int i, status;
+
+	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dfl_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		pids[i] = fork();
+		if (pids[i] == 0) {
+			sleep(1);
+			exit(0);
+		}
+	}
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
+		SCX_EQ(status, 0);
+	}
+
+	SCX_ASSERT(!skel->bss->saw_local);
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct select_cpu_dfl *skel = ctx;
+
+	select_cpu_dfl__destroy(skel);
+}
+
+struct scx_test select_cpu_dfl = {
+	.name = "select_cpu_dfl",
+	.description = "Verify the default ops.select_cpu() dispatches tasks "
+		       "when idles cores are found, and skips ops.enqueue()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&select_cpu_dfl)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
new file mode 100644
index 000000000000..4bb5abb2d369
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates the behavior of direct dispatching with a default
+ * select_cpu implementation, and with the SCX_OPS_ENQ_DFL_NO_DISPATCH ops flag
+ * specified.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+bool saw_local = false;
+
+/* Per-task scheduling context */
+struct task_ctx {
+	bool	force_local;	/* CPU changed by ops.select_cpu() */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct task_ctx);
+} task_ctx_stor SEC(".maps");
+
+/* Manually specify the signature until the kfunc is added to the scx repo. */
+s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   bool *found) __ksym;
+
+s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_select_cpu, struct task_struct *p,
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
+	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags,
+				     &tctx->force_local);
+
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
+		    u64 enq_flags)
+{
+	u64 dsq_id = SCX_DSQ_GLOBAL;
+	struct task_ctx *tctx;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx) {
+		scx_bpf_error("task_ctx lookup failed");
+		return;
+	}
+
+	if (tctx->force_local) {
+		dsq_id = SCX_DSQ_LOCAL;
+		tctx->force_local = false;
+		saw_local = true;
+	}
+
+	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, enq_flags);
+}
+
+s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_init_task,
+		   struct task_struct *p, struct scx_init_task_args *args)
+{
+	if (bpf_task_storage_get(&task_ctx_stor, p, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return 0;
+	else
+		return -ENOMEM;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops select_cpu_dfl_nodispatch_ops = {
+	.select_cpu		= select_cpu_dfl_nodispatch_select_cpu,
+	.enqueue		= select_cpu_dfl_nodispatch_enqueue,
+	.init_task		= select_cpu_dfl_nodispatch_init_task,
+	.name			= "select_cpu_dfl_nodispatch",
+};
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
new file mode 100644
index 000000000000..1d85bf4bf3a3
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "select_cpu_dfl_nodispatch.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_CHILDREN 1028
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct select_cpu_dfl_nodispatch *skel;
+
+	skel = select_cpu_dfl_nodispatch__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct select_cpu_dfl_nodispatch *skel = ctx;
+	struct bpf_link *link;
+	pid_t pids[NUM_CHILDREN];
+	int i, status;
+
+	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dfl_nodispatch_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		pids[i] = fork();
+		if (pids[i] == 0) {
+			sleep(1);
+			exit(0);
+		}
+	}
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
+		SCX_EQ(status, 0);
+	}
+
+	SCX_ASSERT(skel->bss->saw_local);
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct select_cpu_dfl_nodispatch *skel = ctx;
+
+	select_cpu_dfl_nodispatch__destroy(skel);
+}
+
+struct scx_test select_cpu_dfl_nodispatch = {
+	.name = "select_cpu_dfl_nodispatch",
+	.description = "Verify behavior of scx_bpf_select_cpu_dfl() in "
+		       "ops.select_cpu()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&select_cpu_dfl_nodispatch)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
new file mode 100644
index 000000000000..f0b96a4a04b2
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates the behavior of direct dispatching with a default
+ * select_cpu implementation.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+s32 BPF_STRUCT_OPS(select_cpu_dispatch_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	u64 dsq_id = SCX_DSQ_LOCAL;
+	s32 cpu = prev_cpu;
+
+	if (scx_bpf_test_and_clear_cpu_idle(cpu))
+		goto dispatch;
+
+	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu >= 0)
+		goto dispatch;
+
+	dsq_id = SCX_DSQ_GLOBAL;
+	cpu = prev_cpu;
+
+dispatch:
+	scx_bpf_dispatch(p, dsq_id, SCX_SLICE_DFL, 0);
+	return cpu;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops select_cpu_dispatch_ops = {
+	.select_cpu		= select_cpu_dispatch_select_cpu,
+	.name			= "select_cpu_dispatch",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.c
new file mode 100644
index 000000000000..0309ca8785b3
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.c
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "select_cpu_dispatch.bpf.skel.h"
+#include "scx_test.h"
+
+#define NUM_CHILDREN 1028
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct select_cpu_dispatch *skel;
+
+	skel = select_cpu_dispatch__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct select_cpu_dispatch *skel = ctx;
+	struct bpf_link *link;
+	pid_t pids[NUM_CHILDREN];
+	int i, status;
+
+	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dispatch_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		pids[i] = fork();
+		if (pids[i] == 0) {
+			sleep(1);
+			exit(0);
+		}
+	}
+
+	for (i = 0; i < NUM_CHILDREN; i++) {
+		SCX_EQ(waitpid(pids[i], &status, 0), pids[i]);
+		SCX_EQ(status, 0);
+	}
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct select_cpu_dispatch *skel = ctx;
+
+	select_cpu_dispatch__destroy(skel);
+}
+
+struct scx_test select_cpu_dispatch = {
+	.name = "select_cpu_dispatch",
+	.description = "Test direct dispatching to built-in DSQs from "
+		       "ops.select_cpu()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&select_cpu_dispatch)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
new file mode 100644
index 000000000000..7b42ddce0f56
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates the behavior of direct dispatching with a default
+ * select_cpu implementation.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* Dispatching to a random DSQ should fail. */
+	scx_bpf_dispatch(p, 0xcafef00d, SCX_SLICE_DFL, 0);
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops select_cpu_dispatch_bad_dsq_ops = {
+	.select_cpu		= select_cpu_dispatch_bad_dsq_select_cpu,
+	.exit			= select_cpu_dispatch_bad_dsq_exit,
+	.name			= "select_cpu_dispatch_bad_dsq",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c
new file mode 100644
index 000000000000..47eb6ed7627d
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "select_cpu_dispatch_bad_dsq.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct select_cpu_dispatch_bad_dsq *skel;
+
+	skel = select_cpu_dispatch_bad_dsq__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct select_cpu_dispatch_bad_dsq *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dispatch_bad_dsq_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct select_cpu_dispatch_bad_dsq *skel = ctx;
+
+	select_cpu_dispatch_bad_dsq__destroy(skel);
+}
+
+struct scx_test select_cpu_dispatch_bad_dsq = {
+	.name = "select_cpu_dispatch_bad_dsq",
+	.description = "Verify graceful failure if we direct-dispatch to a "
+		       "bogus DSQ in ops.select_cpu()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&select_cpu_dispatch_bad_dsq)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
new file mode 100644
index 000000000000..653e3dc0b4dc
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates the behavior of direct dispatching with a default
+ * select_cpu implementation.
+ *
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+s32 BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/* Dispatching twice in a row is disallowed. */
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+
+	return prev_cpu;
+}
+
+void BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops select_cpu_dispatch_dbl_dsp_ops = {
+	.select_cpu		= select_cpu_dispatch_dbl_dsp_select_cpu,
+	.exit			= select_cpu_dispatch_dbl_dsp_exit,
+	.name			= "select_cpu_dispatch_dbl_dsp",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c
new file mode 100644
index 000000000000..48ff028a3c46
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.c
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2023 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2023 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "select_cpu_dispatch_dbl_dsp.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct select_cpu_dispatch_dbl_dsp *skel;
+
+	skel = select_cpu_dispatch_dbl_dsp__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct select_cpu_dispatch_dbl_dsp *skel = ctx;
+	struct bpf_link *link;
+
+	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_dispatch_dbl_dsp_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	sleep(1);
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_ERROR));
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct select_cpu_dispatch_dbl_dsp *skel = ctx;
+
+	select_cpu_dispatch_dbl_dsp__destroy(skel);
+}
+
+struct scx_test select_cpu_dispatch_dbl_dsp = {
+	.name = "select_cpu_dispatch_dbl_dsp",
+	.description = "Verify graceful failure if we dispatch twice to a "
+		       "DSQ in ops.select_cpu()",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&select_cpu_dispatch_dbl_dsp)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
new file mode 100644
index 000000000000..7f3ebf4fc2ea
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A scheduler that validates that enqueue flags are properly stored and
+ * applied at dispatch time when a task is directly dispatched from
+ * ops.select_cpu(). We validate this by using scx_bpf_dispatch_vtime(), and
+ * making the test a very basic vtime scheduler.
+ *
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+volatile bool consumed;
+
+static u64 vtime_now;
+
+#define VTIME_DSQ 0
+
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+static inline u64 task_vtime(const struct task_struct *p)
+{
+	u64 vtime = p->scx.dsq_vtime;
+
+	if (vtime_before(vtime, vtime_now - SCX_SLICE_DFL))
+		return vtime_now - SCX_SLICE_DFL;
+	else
+		return vtime;
+}
+
+s32 BPF_STRUCT_OPS(select_cpu_vtime_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	s32 cpu;
+
+	cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+	if (cpu >= 0)
+		goto ddsp;
+
+	cpu = prev_cpu;
+	scx_bpf_test_and_clear_cpu_idle(cpu);
+ddsp:
+	scx_bpf_dispatch_vtime(p, VTIME_DSQ, SCX_SLICE_DFL, task_vtime(p), 0);
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(select_cpu_vtime_dispatch, s32 cpu, struct task_struct *p)
+{
+	if (scx_bpf_consume(VTIME_DSQ))
+		consumed = true;
+}
+
+void BPF_STRUCT_OPS(select_cpu_vtime_running, struct task_struct *p)
+{
+	if (vtime_before(vtime_now, p->scx.dsq_vtime))
+		vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(select_cpu_vtime_stopping, struct task_struct *p,
+		    bool runnable)
+{
+	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(select_cpu_vtime_enable, struct task_struct *p)
+{
+	p->scx.dsq_vtime = vtime_now;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(select_cpu_vtime_init)
+{
+	return scx_bpf_create_dsq(VTIME_DSQ, -1);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops select_cpu_vtime_ops = {
+	.select_cpu		= select_cpu_vtime_select_cpu,
+	.dispatch		= select_cpu_vtime_dispatch,
+	.running		= select_cpu_vtime_running,
+	.stopping		= select_cpu_vtime_stopping,
+	.enable			= select_cpu_vtime_enable,
+	.init			= select_cpu_vtime_init,
+	.name			= "select_cpu_vtime",
+	.timeout_ms		= 1000U,
+};
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.c
new file mode 100644
index 000000000000..b4629c2364f5
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.c
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "select_cpu_vtime.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct select_cpu_vtime *skel;
+
+	skel = select_cpu_vtime__open_and_load();
+	SCX_FAIL_IF(!skel, "Failed to open and load skel");
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct select_cpu_vtime *skel = ctx;
+	struct bpf_link *link;
+
+	SCX_ASSERT(!skel->bss->consumed);
+
+	link = bpf_map__attach_struct_ops(skel->maps.select_cpu_vtime_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	sleep(1);
+
+	SCX_ASSERT(skel->bss->consumed);
+
+	bpf_link__destroy(link);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct select_cpu_vtime *skel = ctx;
+
+	select_cpu_vtime__destroy(skel);
+}
+
+struct scx_test select_cpu_vtime = {
+	.name = "select_cpu_vtime",
+	.description = "Test doing direct vtime-dispatching from "
+		       "ops.select_cpu(), to a non-built-in DSQ",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&select_cpu_vtime)
diff --git a/tools/testing/selftests/sched_ext/test_example.c b/tools/testing/selftests/sched_ext/test_example.c
new file mode 100644
index 000000000000..ce36cdf03cdc
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/test_example.c
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_test.h"
+
+static bool setup_called = false;
+static bool run_called = false;
+static bool cleanup_called = false;
+
+static int context = 10;
+
+static enum scx_test_status setup(void **ctx)
+{
+	setup_called = true;
+	*ctx = &context;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	int *arg = ctx;
+
+	SCX_ASSERT(setup_called);
+	SCX_ASSERT(!run_called && !cleanup_called);
+	SCX_EQ(*arg, context);
+
+	run_called = true;
+	return SCX_TEST_PASS;
+}
+
+static void cleanup (void *ctx)
+{
+	SCX_BUG_ON(!run_called || cleanup_called, "Wrong callbacks invoked");
+}
+
+struct scx_test example = {
+	.name		= "example",
+	.description	= "Validate the basic function of the test suite itself",
+	.setup		= setup,
+	.run		= run,
+	.cleanup	= cleanup,
+};
+REGISTER_SCX_TEST(&example)
diff --git a/tools/testing/selftests/sched_ext/util.c b/tools/testing/selftests/sched_ext/util.c
new file mode 100644
index 000000000000..e47769c91918
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/util.c
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <dvernet@meta.com>
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* Returns read len on success, or -errno on failure. */
+static ssize_t read_text(const char *path, char *buf, size_t max_len)
+{
+	ssize_t len;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	len = read(fd, buf, max_len - 1);
+
+	if (len >= 0)
+		buf[len] = 0;
+
+	close(fd);
+	return len < 0 ? -errno : len;
+}
+
+/* Returns written len on success, or -errno on failure. */
+static ssize_t write_text(const char *path, char *buf, ssize_t len)
+{
+	int fd;
+	ssize_t written;
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return -errno;
+
+	written = write(fd, buf, len);
+	close(fd);
+	return written < 0 ? -errno : written;
+}
+
+long file_read_long(const char *path)
+{
+	char buf[128];
+
+
+	if (read_text(path, buf, sizeof(buf)) <= 0)
+		return -1;
+
+	return atol(buf);
+}
+
+int file_write_long(const char *path, long val)
+{
+	char buf[64];
+	int ret;
+
+	ret = sprintf(buf, "%lu", val);
+	if (ret < 0)
+		return ret;
+
+	if (write_text(path, buf, sizeof(buf)) <= 0)
+		return -1;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/sched_ext/util.h b/tools/testing/selftests/sched_ext/util.h
new file mode 100644
index 000000000000..bc13dfec1267
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/util.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024 David Vernet <void@manifault.com>
+ */
+
+#ifndef __SCX_TEST_UTIL_H__
+#define __SCX_TEST_UTIL_H__
+
+long file_read_long(const char *path);
+int file_write_long(const char *path, long val);
+
+#endif // __SCX_TEST_H__
-- 
2.45.2


