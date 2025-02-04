Return-Path: <bpf+bounces-50334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2565A26837
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D161631DB
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDF27456;
	Tue,  4 Feb 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w95DlM63"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEF18EAD
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738627830; cv=none; b=KbzP8+qUhktmxiMY/mf1/z1GbPC89CZNxB6LoO9V7cmBOvVZvWx/AIZQHo4ZUmc+YXPzzn3PDwkDDWSKdGxLuD5GwUIWv7xMad1qzV777S4WJ/sljJSYy6lG2j5uN+HDOFUieBXPkC9CcNwMsL1ujGiDDC3YJRiXSLgO85uE8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738627830; c=relaxed/simple;
	bh=afFbwZhPvABw9QtnhyLoeWFZ1DAKvScTsQg8dH8fITI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOKBHwCZGmAV1+CKQMBlMRUmY/+K3AM4ehGNnxT7fKriIT42i6QT3vzrK+s5NHpK/CpxVeGwP0llcg1fMsl9gYHMR4cZMHg1M//J2oj69zwZwGoqrP4paLbmvMzJquGDWpxwlgh7BiPqH45DVSH/kVs3ymDQo5351NOdDrppc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w95DlM63; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so84282325ad.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 16:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738627828; x=1739232628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZC6hwdmsqFUIUOrfafnyuVDJQQmUYi4erRt9zplJew=;
        b=w95DlM63ExLLX/g2yW3FBG661vb8xIZCxLLMKzT83xMEYyIJXATpW/64582N+L3VgK
         E4w43h0kVH29EZOfnuxB/Ty8jD5QC4vtno66jSDZXx2Bojd6ZXaE4U5DdxvXyuyBLjRP
         5btWbiL0EeeYbb6tr5QxGP+i4LnTdzIV3lgzv5woXu9so6tbYpbEE6vTt4YQr0lRmAPb
         jKb+ikunvB0slqld7vkWxA7y9F1xPJnzQN88kXgLJa+/Bu4jUdOXYfCcJf62i3bwrgZ7
         8p9KYFvDUxH1TeUz4QQ2rTBNcqXvCLoswJ/PMmUF6kIaG/F+tkXcR8wqE55MSE3G0qAY
         BFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738627828; x=1739232628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZC6hwdmsqFUIUOrfafnyuVDJQQmUYi4erRt9zplJew=;
        b=Mb/r9z335HyVWQ17gF0j/bjhqt0VyO6OY+hP2eJ57lZKyuu5v5Ba+uvaRT6rtSnx9+
         JAUAiSFbWsxKGDebt3N7CgTcn31UVbKcOaWYJHQl5/scZHrvij1iUCtYFM94VxphYG3E
         PgI+elxnJxUk9umAHnXpUoqh8fs9USZp8mE2puPH8kndJu52qoZznRVD2SW9kH3wXJlp
         ZuOG4QOsuvP8T3Pw3zxeYdLYEV6O4aMq2TkRsoZAnyLJZBfD+r+IVZUpHF8EBTKywHVe
         2B7VZ5WWvKUaVxFFR5J7cB3ThALe8t5EojYlLF8++zjf3bouez1hLVM0gHnBxY/hLkmJ
         oPzw==
X-Gm-Message-State: AOJu0Yy0qoTmL7iAlAW2MtaWXjaN3X0vYbZTTfSSN5IuUvSM/SI668Nf
	c2CEdUW1VJi3vB63r349GrTGHV61RTIso6FebligRAZtb3NfWQKnFdu7klRZAQM=
X-Gm-Gg: ASbGncvz5DV528PnpAC3ktPBALJRjySFrqnWbnkCgTTlIcU1pBoY6ENoGU/pW91BMdy
	65S0PEnz0cGOh0iU8i5nmri40caeZFUAmM6GXjfSCyrCvDJsv2+2FwgW+JrJdL8+GkcAWjaySkr
	dg0srfhSqBktx22sHk4sP7o13IgZs0zccTNQlgTrSzIdifudNR5xqM5nK2G+CYtUOFR5RP8ZQHN
	RQSbGCCIWjVeDT38QAeLiMOTajy683aHUnIihBxyyW69Nr6drIGvcgl0DRwaVYRH2bj3fx+vZvX
	0ymmzWAH7Ta0A83WsPcYKUnyz1MHhGM=
X-Google-Smtp-Source: AGHT+IHHGXlWF6SoH1LocgByYURB2i6ZZlSMHYhnVurxdmpMOSoe1ozZwwR8TPZih/wzLmmPut7sgA==
X-Received: by 2002:a05:6a20:9186:b0:1dc:e8d:c8f0 with SMTP id adf61e73a8af0-1ed7a6b825amr41908107637.29.1738627827687;
        Mon, 03 Feb 2025 16:10:27 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe85656bsm7279199a12.36.2025.02.03.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:10:27 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 03 Feb 2025 16:10:08 -0800
Subject: [PATCH 2/2] tools: Remove redundant quiet setup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-quiet_tools-v1-2-d25c8956e59a@rivosinc.com>
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
In-Reply-To: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10090; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=afFbwZhPvABw9QtnhyLoeWFZ1DAKvScTsQg8dH8fITI=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/rCqDeTpkiHBfRO/vXAKPf2ZhFGY/vgjpir1lMVTJfuT
 Pl+sFeuo5SFQYyLQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIk4fWX4p+b74rTp5tW72jvr
 TjEGqjKn7xKTCWwSWDgzepahyeGfDxj+2cdaeeWnHZLwOW6z6+2X1HmGCV5Bb57+Z5z/8Un8+Un
 fuAE=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Q is exported from Makefile.include so it is not necessary to manually
set it.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/arch/arm64/tools/Makefile           |  6 ------
 tools/bpf/Makefile                        |  6 ------
 tools/bpf/bpftool/Documentation/Makefile  |  6 ------
 tools/bpf/bpftool/Makefile                |  6 ------
 tools/bpf/resolve_btfids/Makefile         |  2 --
 tools/bpf/runqslower/Makefile             |  5 +----
 tools/lib/bpf/Makefile                    | 13 -------------
 tools/lib/perf/Makefile                   | 13 -------------
 tools/lib/thermal/Makefile                | 13 -------------
 tools/objtool/Makefile                    |  6 ------
 tools/testing/selftests/bpf/Makefile.docs |  6 ------
 tools/testing/selftests/hid/Makefile      |  2 --
 tools/thermal/lib/Makefile                | 13 -------------
 tools/tracing/latency/Makefile            |  6 ------
 tools/tracing/rtla/Makefile               |  6 ------
 tools/verification/rv/Makefile            |  6 ------
 16 files changed, 1 insertion(+), 114 deletions(-)

diff --git a/tools/arch/arm64/tools/Makefile b/tools/arch/arm64/tools/Makefile
index 7b42feedf647190ad498de0937e8fb557e40f39c..de4f1b66ef0148b7bfd0fd16655ad854c7542240 100644
--- a/tools/arch/arm64/tools/Makefile
+++ b/tools/arch/arm64/tools/Makefile
@@ -13,12 +13,6 @@ AWK	?= awk
 MKDIR	?= mkdir
 RM	?= rm
 
-ifeq ($(V),1)
-Q =
-else
-Q = @
-endif
-
 arm64_tools_dir = $(top_srcdir)/arch/arm64/tools
 arm64_sysreg_tbl = $(arm64_tools_dir)/sysreg
 arm64_gen_sysreg = $(arm64_tools_dir)/gen-sysreg.awk
diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 243b79f2b451e52ca196f79dc46befd1b3dab458..062bbd6cd048e9e42f9bc8f9972ec96594f3dbd2 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -27,12 +27,6 @@ srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 FEATURE_USER = .bpf
 FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
 FEATURE_DISPLAY = libbfd
diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
index 4315652678b9f2e27e48b7815f3b9ddc70a57165..bf843f328812e10dd65a73f355f74e6825ad95b9 100644
--- a/tools/bpf/bpftool/Documentation/Makefile
+++ b/tools/bpf/bpftool/Documentation/Makefile
@@ -5,12 +5,6 @@ INSTALL ?= install
 RM ?= rm -f
 RMDIR ?= rmdir --ignore-fail-on-non-empty
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 prefix ?= /usr/local
 mandir ?= $(prefix)/man
 man8dir = $(mandir)/man8
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dd9f3ec842017f1dd24054bf3a0986d546811dc4..6ea4823b770cbbe7fd9eb7da79956cc1dae1f204 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -7,12 +7,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 BPF_DIR = $(srctree)/tools/lib/bpf
 
 ifneq ($(OUTPUT),)
diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 4b8079f294f65b284481e9a2bf6ff52594a4669a..afbddea3a39c64ffb2efc874a3637b6401791c5b 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -5,10 +5,8 @@ include ../../scripts/Makefile.arch
 srctree := $(abspath $(CURDIR)/../../../)
 
 ifeq ($(V),1)
-  Q =
   msg =
 else
-  Q = @
   ifeq ($(silent),1)
     msg =
   else
diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index c4f1f1735af659c2e660a322dbf6912d9a5724bc..e49203ebd48c18607a6136a9e805ccf16ee960d3 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -26,10 +26,7 @@ VMLINUX_BTF_PATHS := $(if $(O),$(O)/vmlinux)		\
 VMLINUX_BTF_PATH := $(or $(VMLINUX_BTF),$(firstword			       \
 					  $(wildcard $(VMLINUX_BTF_PATHS))))
 
-ifeq ($(V),1)
-Q =
-else
-Q = @
+ifneq ($(V),1)
 MAKEFLAGS += --no-print-directory
 submake_extras := feature_display=0
 endif
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 857a5f7b413d6dc4cbe7bc4167496674dd08d875..168140f8e6461bd06db40e23d21a3fb8847ccbf4 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -53,13 +53,6 @@ include $(srctree)/tools/scripts/Makefile.include
 
 # copy a bit from Linux kbuild
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
 INCLUDES = -I$(or $(OUTPUT),.) \
 	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
 	   -I$(srctree)/tools/arch/$(SRCARCH)/include
@@ -96,12 +89,6 @@ override CFLAGS += $(CLANG_CROSS_FLAGS)
 # flags specific for shared library
 SHLIB_FLAGS := -DSHARED -fPIC
 
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 # Disable command line variables (CFLAGS) override from top
 # level Makefile (perf), otherwise build Makefile will get
 # the same command line setup.
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3a9b2140aa048ea919c69ed2240bf0ea444dbf21..e9a7ac2c062e2b398c2f22af41907b62815ca07e 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -39,19 +39,6 @@ libdir = $(prefix)/$(libdir_relative)
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 TEST_ARGS := $(if $(V),-v)
 
 # Set compile option CFLAGS
diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index 8890fd57b110ccc1a837d37624a5dead00f18656..a1f5e388644d31d36f973d3ddce48d036ee0a083 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -39,19 +39,6 @@ libdir = $(prefix)/$(libdir_relative)
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
   CFLAGS := $(EXTRA_CFLAGS)
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index f56e2772753414ff8d3462bdebbc8e95e7667fcd..7a65948892e569cbe1d6e5a78db68bb35102cd26 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -46,12 +46,6 @@ HOST_OVERRIDES := CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)"
 AWK = awk
 MKDIR = mkdir
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 BUILD_ORC := n
 
 ifeq ($(SRCARCH),x86)
diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
index eb6a4fea8c794d8354363ac8daa0baac3e3bd060..f7f9e7088bb38c7507282990fb62921ca7a636d2 100644
--- a/tools/testing/selftests/bpf/Makefile.docs
+++ b/tools/testing/selftests/bpf/Makefile.docs
@@ -7,12 +7,6 @@ INSTALL ?= install
 RM ?= rm -f
 RMDIR ?= rmdir --ignore-fail-on-non-empty
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
 prefix ?= /usr/local
 mandir ?= $(prefix)/man
 man2dir = $(mandir)/man2
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 0336353bd15f0d56dbed6c8fa02f53c234f949e1..2839d2612ce3a70f4332f8e886586e9cca6f03cb 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -43,10 +43,8 @@ TEST_GEN_PROGS = hid_bpf hidraw
 # $3 - target (assumed to be file); only file name will be emitted;
 # $4 - optional extra arg, emitted as-is, if provided.
 ifeq ($(V),1)
-Q =
 msg =
 else
-Q = @
 msg = @printf '  %-8s%s %s%s\n' "$(1)" "$(if $(2), [$(2)])" "$(notdir $(3))" "$(if $(4), $(4))";
 MAKEFLAGS += --no-print-directory
 submake_extras := feature_display=0
diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index f2552f73a64c7eb1be24c27b3a1414617391315b..056d212f25cf51cd8c02260fbe2ef28dda5e4acb 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
@@ -39,19 +39,6 @@ libdir = $(prefix)/$(libdir_relative)
 libdir_SQ = $(subst ','\'',$(libdir))
 libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
 
-ifeq ("$(origin V)", "command line")
-  VERBOSE = $(V)
-endif
-ifndef VERBOSE
-  VERBOSE = 0
-endif
-
-ifeq ($(VERBOSE),1)
-  Q =
-else
-  Q = @
-endif
-
 # Set compile option CFLAGS
 ifdef EXTRA_CFLAGS
   CFLAGS := $(EXTRA_CFLAGS)
diff --git a/tools/tracing/latency/Makefile b/tools/tracing/latency/Makefile
index 6518b03e05c71b4fa84498f9628adf81a38c9f56..257a56b1899f23837de533353e9c2cebdb6035bd 100644
--- a/tools/tracing/latency/Makefile
+++ b/tools/tracing/latency/Makefile
@@ -37,12 +37,6 @@ FEATURE_TESTS	+= libtracefs
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 
-ifeq ($(V),1)
-  Q 		=
-else
-  Q 		= @
-endif
-
 all: $(LATENCY-COLLECTOR)
 
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 8b5101457c70b48e9c720f1ba53293f1307c15a2..0b61208db604ec0754024c3007db6b2fe74a613c 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -37,12 +37,6 @@ FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 FEATURE_DISPLAY	+= libcpupower
 
-ifeq ($(V),1)
-  Q		=
-else
-  Q		= @
-endif
-
 all: $(RTLA)
 
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 411d62b3d8eb93abf85526ad33cafd783df86bc1..5b898360ba4818b12e8a16c27bd88c75d0076fb9 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -35,12 +35,6 @@ FEATURE_TESTS	+= libtracefs
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 
-ifeq ($(V),1)
-  Q		=
-else
-  Q		= @
-endif
-
 all: $(RV)
 
 include $(srctree)/tools/build/Makefile.include

-- 
2.43.0


