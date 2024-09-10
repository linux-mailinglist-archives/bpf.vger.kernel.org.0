Return-Path: <bpf+bounces-39442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2769973956
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DC71C24972
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20041199929;
	Tue, 10 Sep 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEsL2pKp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154B19923A
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977081; cv=none; b=rIa+38NObjVFcMfbvKDxxCEKEeZCVxA0L+qq1aG/HO82ad+cmD/lm6U+5fEav0KH08qWow8tmfGVKcGOArZbL4JmfkBwXvLnjao5i0s2pRgyaYSAlLqbIeHUCXoD2b5auwjQqEqaN9wNSw9T3jKfTT6EAzT1lZrroO1d68AtR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977081; c=relaxed/simple;
	bh=OjtweS1q3V27F5fK6RgxbRa8U+kYLJ/fvAGK90ksCB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cc6H3H/RcWYHFygs/u3d4hyJMmU82nFl6cDr4lu92bEO6eoLRzsDTUfbSflbsYgbdoEnTk8sGYtokyRn0tv/f2deXF9cOufm8cwbqd+f6g+OGpJBgfGD9xr/D/zOgNeb7DjbUNqnh6qOYhWyx1wWPbNlby1eQ+/qjbLZTdUDkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEsL2pKp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-535be093a43so1104364e87.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725977078; x=1726581878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS/maFmCMzAAa4s+MCdvfSFRa4peuXy1wJykcXIHmPk=;
        b=gEsL2pKptFzYFzlk4/YRhDLOOvxj76WgXwcVA3ciYClXow4Iu0pAet1Ne3qMa1V3gk
         IKKfropaemR4cyesZMZEFDut3xktIQp4yVJOzEhi23kPVXdE0N7gqsJA5srNUgVNImmv
         ROEt0vtlYwKTQ8c5Y7JelFa3G2sOdZsr5pppKi0Es+spf07Hc/uLWgWPclfW7xBoQqiO
         jm4IbpqRE/uMOn7X8cQDeufcJ7+Lr0tyog2rWFMY71qP5TfX/VM9jrBTjexjSIwUfS63
         RapVY2rOOWdfS1u15MQNVWrtooc5Hb8NXl6fgtqY5quRQJjEudEEL0Sah5kIZAR3hLHU
         tOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977078; x=1726581878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS/maFmCMzAAa4s+MCdvfSFRa4peuXy1wJykcXIHmPk=;
        b=sRN3qJ7/JgRfgwUq/QCkHu54Hzti8Mgnd0Rd4BI9FK+z2IJ6+s6WdeTo2B851+A7da
         1H1m7QZvk6Bm2dB1G+FzpsmbE6kiUlao4zk9cTW7IJqCDcq1ZDPDoOgTiycFl3maJwKu
         Ho+Z+AkUVH79ZQKP5lOL0s01j7mZkq3iiqw7QxJXs5Gsdw30PfW/twx5M1Owrwbto9Op
         4j2EwlykszCQ4gSYR2YzsTvbit8+AVhj74fKumdQm6Hf/yvXktCwnq1w5dFVmAs3v1Gq
         H0BulgaXEHhTD1AFmYC5KAxBxgIQShQMaBcKakIdwp2TrNqaEiJdyqISCkVyzhePfVqg
         C0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWOAubJ28+XDZo0eD3APvzz2JEDjGVfuYHsG8+7beYvNT7YVuiQaBQBYu3wUbJc18NNDxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJ1ebWgModsCT5AIzkR3sZzw2FxpjHmQ3u75hhdwHzG2OxOkf
	jFhwfvdfPqmniFpxpze1ZXX/ypYS8Z6bp+CeoG5RthFM9d4zZpJZqWNtLIAk6c8=
X-Google-Smtp-Source: AGHT+IHoK5woUUfrtzi8S8rwG8nObPbqRVcjsqfShnp3wADgkiTW2rnKUpQlo65zvgcisMPeXektZQ==
X-Received: by 2002:a05:6512:2523:b0:535:6795:301a with SMTP id 2adb3069b0e04-536587fce23mr9726515e87.47.1725977077413;
        Tue, 10 Sep 2024 07:04:37 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7f1sm114787075e9.48.2024.09.10.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:04:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	sesse@google.com,
	acme@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	Leo Yan <leo.yan@arm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Manu Bretelle <chantr4@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/2] perf build: Remove unused feature test target
Date: Tue, 10 Sep 2024 15:04:01 +0100
Message-Id: <20240910140405.568791-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910140405.568791-1-james.clark@linaro.org>
References: <20240910140405.568791-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llvm-version was removed in commit 56b11a2126bf ("perf bpf: Remove
support for embedding clang for compiling BPF events (-e foo.c)") but
some parts were left in the Makefile so finish removing them.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/build/feature/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d6a98b3854f8..5938cf799dc6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -74,7 +74,6 @@ FILES=                                          \
          test-clang.bin				\
          test-llvm.bin				\
          test-llvm-perf.bin   \
-         test-llvm-version.bin			\
          test-libaio.bin			\
          test-libzstd.bin			\
          test-clang-bpf-co-re.bin		\
@@ -397,11 +396,6 @@ $(OUTPUT)test-llvm-perf.bin:
 		$(shell $(LLVM_CONFIG) --system-libs)		\
 		> $(@:.bin=.make.output) 2>&1
 
-$(OUTPUT)test-llvm-version.bin:
-	$(BUILDXX) -std=gnu++17					\
-		-I$(shell $(LLVM_CONFIG) --includedir)		\
-		> $(@:.bin=.make.output) 2>&1
-
 $(OUTPUT)test-clang.bin:
 	$(BUILDXX) -std=gnu++17					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
-- 
2.34.1


