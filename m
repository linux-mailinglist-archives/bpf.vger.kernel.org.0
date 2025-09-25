Return-Path: <bpf+bounces-69694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6CB9EA19
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DB23B72E8
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B52EAB7F;
	Thu, 25 Sep 2025 10:26:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1132EAB63;
	Thu, 25 Sep 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796008; cv=none; b=TuRh0LMiLeK6xdqFdRIz44AfybbfCo+mtd5WAvu1wO5NLhPQfU1g7iPqHdUNx017MHFRXDW3TL8kQrsveQAtvtS0W5YaLZhG3fsnGocYRyTWpJwW9hXrj7gZC2dTHlcIsRx1HcQvFQefqNyEdkxQo73wqbcF+bqMx942qKnIxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796008; c=relaxed/simple;
	bh=VJZzRV2G21iA5x83mYxoxWgeXu6NWW7QN9XhzccIjOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFBpk1qRuscEl86/5ujw/wW3ypX8Tw7/5T0AJJoGBb44ANrUuDSWnGRy8DZT+ynhdWYZmKw8K48hEupw0oP0n6Y+jc7dj5zpRFgbeffrdoqCB43+8wlJMb5xbMZ9IFnoRIfBgywYkwaUPLU/7Z2GTzFSdjeQicybHEaKwUtRFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A78E42936;
	Thu, 25 Sep 2025 03:26:38 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA543F694;
	Thu, 25 Sep 2025 03:26:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 25 Sep 2025 11:26:27 +0100
Subject: [PATCH 3/8] bpftool: Conditionally add -Wformat-signedness flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-perf_build_android_ndk-v1-3-8b35aadde3dc@arm.com>
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
In-Reply-To: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758795991; l=1336;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=VJZzRV2G21iA5x83mYxoxWgeXu6NWW7QN9XhzccIjOw=;
 b=5GNgul1OTFxQHj/IeyET7LW6e7d62JGQWlIFg9tx9Jl1PuU7OB88zlshiQSelFXPDqInRZBea
 SuEuIHnLEobD/7wU6vNDFnJorWPldQRzI0fOe6ufyMQeBz3OH28QBHb
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

clang-18.1.3 on Ubuntu 24.04.2 reports warning:

  warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]

Conditionally add the option only when it is supported by compiler.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/bpf/bpftool/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 9e9a5f006cd2aabe1e89bd83e394455c0d4473e0..948a0cc98b39d3f9afa0de73643eab04e8798ff5 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -64,11 +64,21 @@ $(LIBBPF_BOOTSTRAP)-clean: FORCE | $(LIBBPF_BOOTSTRAP_OUTPUT)
 prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
 
+try-run = $(shell set -e;		\
+	if ($(1)) >/dev/null 2>&1;	\
+	then echo "$(2)";		\
+	else echo "$(3)";		\
+	fi)
+
+__cc-option = $(call try-run,\
+	$(1) -Werror $(2) -c -x c /dev/null -o /dev/null,$(2),)
+cc-option = $(call __cc-option, $(CC),$(1))
+
 CFLAGS += -O2
 CFLAGS += -W
 CFLAGS += -Wall
 CFLAGS += -Wextra
-CFLAGS += -Wformat-signedness
+CFLAGS += $(call cc-option,-Wformat-signedness)
 CFLAGS += -Wno-unused-parameter
 CFLAGS += -Wno-missing-field-initializers
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))

-- 
2.34.1


