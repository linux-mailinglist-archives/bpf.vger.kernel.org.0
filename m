Return-Path: <bpf+bounces-50333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80494A26833
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156451882D25
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357317588;
	Tue,  4 Feb 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ct77tYyx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37A8836
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738627828; cv=none; b=aBbJ++nQuAQp8vGDplMyCBQYtA1RF1IMvTpNzSUoK5iMUgUFjb1Or9sM/n1l0DK8w3ONmN9rXXnPN1LiRE6ZGY89CDEMkcuwuCARRkmrsTPkj9QEGxinW/s0ZpCvoFH7zc8LUMEDyxoOfZpoB+C2uMfpxYsHcIOLNQ+j7crcRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738627828; c=relaxed/simple;
	bh=bhD+jzAfi75Qb6U6sRAzzzbhDaKnP0n2UTw5mGZ1vUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOdNChNB4T5YB6dYnqlMyS774L6HyG2GD2yiIkQeX8lUX5atyV4k251P6KMUVaR3Ia0fszNFqHoa58DpBqf5Eq0A9kd1DRopmBnI2ZPiDXYGKTYTv0WJYfF/Gh82ty5R4glhaPMExVR0R9juN0PoCE5DNrQZvpmlaasZCo8EcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ct77tYyx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso86877545ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 16:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738627825; x=1739232625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mV2AeW4JKHQUjeXAFEZvGKyMnM4utRXk62zeLgdCkpw=;
        b=Ct77tYyxkPGtcHJMF4qNHwQMlccslayvci8Xgvfiw/212ZUKF+fAjt2agv3zQx0GIl
         uWDl63Cli9awgQ+kA5Dhd9jxJr53l39hq6VdMMgu2eD3pWowwplDmmOYqRIG3cw5FapW
         qm1MGMpnCZjVXIbWlZYsOM8rODXuo1q9XBP/1cejIIX1lKKMpjxovuE3dxB7h8bwMGQo
         cpIsOB6KSL5EsRH6A0Swqu+DY8HwrUInvsQBhDCV/081lP/b1jAfejBLNVDPFpz/hUgy
         ClMQeaHjXR1cPG+fB32aPYNvuRnHV256p6WCzqlo/pZ8OHUKEQNkiYE+M62Q4WKNE8S6
         CBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738627825; x=1739232625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV2AeW4JKHQUjeXAFEZvGKyMnM4utRXk62zeLgdCkpw=;
        b=F0ImjAdUmillvb+hxQJhFzZgq5FQS1Y8ZkF7F65WIbySz2A8Jf7Jy5+EmjUjFx59gv
         f4k47Ah4A6RZL1AA6j8My0wh8Io/82kCaPJMGLo/pnsazkWE36MFqVYcPDL295VQDCAn
         k8ceWATaBRvqprdHAncEAcwuq2dQO5qqKWsU4t/KU3tOliHxeh/96ZbZWHTIpJ8Ptmvp
         tEjr9C7M+7T3t3tRQ3QXNzYJQeLiIuJWr+8Vi8QABbmbg7FKIZskcKdXCMksTff+f1Ow
         yi4jLLuoW975A1PqvwlbcA+gRHNPlQTgAWgaKoDzwpBjNaZOYUKehvcvK+LIQpBsFweg
         Af3A==
X-Gm-Message-State: AOJu0Yy/mGwOoFFDfvbV9HvuSq4/gJPNINMRB0wfbtGVBhA4GQygitTx
	RqKsU3o3+Nd72pG0cDFBEulDcsMDj080YBLtA4qzParih7bjoyJDDETYEjTVYdE=
X-Gm-Gg: ASbGncvuycmRvVKIEEAhow0XwdTNhCa75y4D5n4ctM58eJi7iyxWwgIjPKzBs8IAPII
	4Ko+JtSLWY6QWM1utra63k2m90B6re6P0CxFgxbmdlAhAmy7YIqHSmrHzh711wsnBrxfhhEFMPX
	fj3F9Fs6k0Mf3jesMSwSl8F1kEGRzON2+zongHNIBUE1w7guECh/tqW14iKOaBfhcXLhli6Rooc
	bhKmnxG1ERUJgP1cjkuFjq6XDhc6qJPYUg2u8LZBny9MpFe9Ri6LtGJoUGZ+JVBTXfpSHvqSMd/
	MPJGE6H/KDgh/HqBSPxSBTfBCfiKud0=
X-Google-Smtp-Source: AGHT+IG2jr96Mw5aWJjKNhXlRC8GROtI0ClvCTGD8Rv8hVZWph8wfoVcaQJzfepQ8BWiaQ+zaT5P9g==
X-Received: by 2002:a17:902:c409:b0:215:5935:7eef with SMTP id d9443c01a7336-21dd7d78cafmr394808535ad.22.1738627825178;
        Mon, 03 Feb 2025 16:10:25 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe85656bsm7279199a12.36.2025.02.03.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:10:24 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 03 Feb 2025 16:10:07 -0800
Subject: [PATCH 1/2] tools: Unify top-level quiet infrastructure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-quiet_tools-v1-1-d25c8956e59a@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4583; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=bhD+jzAfi75Qb6U6sRAzzzbhDaKnP0n2UTw5mGZ1vUo=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/rCqNdplb5vf7asKdvRxOPppOVyx+qhZVzNmi1cokHvN
 NkiX/t2lLIwiHExyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJF3OowMe5R1lgbdYF10ILn8
 wZG/cyR0Dzrp/LW78eBkEseHU+nTLRgZmgJ557Ce4f2/u+YJ02Vbr9QDRbN8rPeETlc4XNdZ03e
 AHQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Commit f2868b1a66d4 ("perf tools: Expose quiet/verbose variables in
Makefile.perf") moved the quiet infrastructure out of
tools/build/Makefile.build and into the top-level Makefile.perf file so
that the quiet infrastructure could be used throughout perf and not just
in Makefile.build.

Extract out the quiet infrastructure into Makefile.include so that it
can be leveraged outside of perf.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: f2868b1a66d4 ("perf tools: Expose quiet/verbose variables in Makefile.perf")
---
 tools/build/Makefile           |  8 +-------
 tools/perf/Makefile.perf       | 41 -----------------------------------------
 tools/scripts/Makefile.include | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 49 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 18ad131f6ea74aebfc3fd6aa6dddfdc00634b66c..63ef2187876169d8daaeed6f7a4ff27e4b610271 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -17,13 +17,7 @@ $(call allow-override,LD,$(CROSS_COMPILE)ld)
 
 export HOSTCC HOSTLD HOSTAR
 
-ifeq ($(V),1)
-  Q =
-else
-  Q = @
-endif
-
-export Q srctree CC LD
+export srctree CC LD
 
 MAKEFLAGS := --no-print-directory
 build     := -f $(srctree)/tools/build/Makefile.build dir=. obj
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc..05c083bb11220486e3246896af4fa0051f048832 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -161,47 +161,6 @@ export VPATH
 SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
-# Beautify output
-# ---------------------------------------------------------------------------
-#
-# Most of build commands in Kbuild start with "cmd_". You can optionally define
-# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
-# that command is printed by default.
-#
-# e.g.)
-#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
-#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
-#
-# A simple variant is to prefix commands with $(Q) - that's useful
-# for commands that shall be hidden in non-verbose mode.
-#
-#    $(Q)$(MAKE) $(build)=scripts/basic
-#
-# To put more focus on warnings, be less verbose as default
-# Use 'make V=1' to see the full commands
-
-ifeq ($(V),1)
-  quiet =
-  Q =
-else
-  quiet=quiet_
-  Q=@
-endif
-
-# If the user is running make -s (silent mode), suppress echoing of commands
-# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
-ifeq ($(filter 3.%,$(MAKE_VERSION)),)
-short-opts := $(firstword -$(MAKEFLAGS))
-else
-short-opts := $(filter-out --%,$(MAKEFLAGS))
-endif
-
-ifneq ($(findstring s,$(short-opts)),)
-  quiet=silent_
-endif
-
-export quiet Q
-
 # Do not use make's built-in rules
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0aa4005017c72f10bb7c5e47bc78ec81718c47ef..c4f240042f02bf76994b1e183b3c1c464cb5ed95 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -136,6 +136,33 @@ else
 NO_SUBDIR = :
 endif
 
+# Beautify output
+# ---------------------------------------------------------------------------
+#
+# Most of build commands in Kbuild start with "cmd_". You can optionally define
+# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
+# that command is printed by default.
+#
+# e.g.)
+#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
+#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
+#
+# A simple variant is to prefix commands with $(Q) - that's useful
+# for commands that shall be hidden in non-verbose mode.
+#
+#    $(Q)$(MAKE) $(build)=scripts/basic
+#
+# To put more focus on warnings, be less verbose as default
+# Use 'make V=1' to see the full commands
+
+ifeq ($(V),1)
+  quiet =
+  Q =
+else
+  quiet=quiet_
+  Q=@
+endif
+
 # If the user is running make -s (silent mode), suppress echoing of commands
 # make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
 ifeq ($(filter 3.%,$(MAKE_VERSION)),)
@@ -145,9 +172,11 @@ short-opts := $(filter-out --%,$(MAKEFLAGS))
 endif
 
 ifneq ($(findstring s,$(short-opts)),)
-  silent=1
+  quiet=silent_
 endif
 
+export quiet Q
+
 #
 # Define a callable command for descending to a new directory
 #

-- 
2.43.0


