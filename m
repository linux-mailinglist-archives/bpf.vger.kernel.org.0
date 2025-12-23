Return-Path: <bpf+bounces-77372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B856CDA038
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 18:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940AC302F819
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30174346782;
	Tue, 23 Dec 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQsjl3JH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1B28A701
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509251; cv=none; b=VrbdxDwO5SMzxBOZG2psFlYSeVmbgnGaMHaBQGa/EH18gHBDzPRaSqWtuA9pWcCsA4Fxm8mMS76LpivO39tmIs+XadEFxvhotVUmPxFoE+jZdvomSRnqtvjsMPafSlKv/inCdYIvN3vqaTt+AfX6PPudntCEh1gxWQK6bl0RoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509251; c=relaxed/simple;
	bh=U71eWv+lZlEigAhVYCviXUXxQA3e+e5qTV+RSri9qqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRl1EsIfB48aPoqe2rardDQzVmqscoBGWAlywBwKRBh5tpkeoUTdeGfB0d4uaLTjwNRct8zx3+osu75VRIH2lhjswurPFiWSfQ9stgAUH4vD3NnTTkUojJzRfkEMOyGaUq/zZ9PhP8nazbwacIL2+5pzEaYddzGCgKYnR0KEVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQsjl3JH; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so4158156f8f.1
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509248; x=1767114048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBD5hyInNJ1zU+FPwr6XKENm1lWydxvpThAe0QY6n2o=;
        b=MQsjl3JHY1u4bguvRcxufbsdHMPBtYxUOvWGeY0VP6MYVd2V/rwfWmBQ02vQOd5BFu
         oxFxiqlK67uAk+afnFFY51rV+pRcuNZVqB3GemuYKN8bN/LIrtBNHSmyvos3VY5HDzSD
         UcQ4hkexTpNwO7RRu0HBFx0aB6RfqqONRckvVMjwrk65eQRBAQzSYZgOe8tr+lvWEfXQ
         OZiwspVwY/8wzTUWlACYYmTUjhKbjymmIfFGaRdmdw9OaXFjjPMORsDFIcajWbbMk+8S
         +LTcTn3CPXuZKc0Uiqk8M0sF3PkYuNu6GS+Bi8+t022Yhr55C/Klz7VlojxjxTugwhJ5
         015g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509248; x=1767114048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MBD5hyInNJ1zU+FPwr6XKENm1lWydxvpThAe0QY6n2o=;
        b=oDto2L2hgb2aCjRLKV5I4Ti3XIOAJdjKZv7gvYTAHg/zsXvY/VFPnbNE6TGWBr4JWC
         LggcFkMqbHN6uFHu/Plph3mbw9AQyfv57GAeS1uhJe69So8wO/620/Ri2rMW7FZ+EbPA
         AO7MR+uPWb3bdMmfJPqmnsBXWpOmkoviZUUAjJPUEVUarpxOC9aHV/xN3p2D8PI4dz+j
         3znuFyANiu2gr3hmYTAwcXzpsx+9AMhuspFb4oHn3TEnqrCsqzFoFqr0NwUN286pNlME
         3m0dCFIuNH1B13oc3G2w1WxiVMctK97eqcy8Ymat8f/NprTYQUzgBl/jyNAevV+jX+rT
         5ERw==
X-Forwarded-Encrypted: i=1; AJvYcCXiM/NaGjSCPQDW6DOiPp6avLYwKnw96y63NsblGngQY5HYjg7tQ63jU2HDxCR8qsqUNrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDpDb9y2E7kWH1q6CgqLDiI2rixbJGRgNCGay3kzcMvH1Kukv
	cojxQB16nFvYY4957mxz8Wp2sYO3yHr5WnO6tSDZQTijqP6sIIcU4fu4YCQMTE+fPLU=
X-Gm-Gg: AY/fxX6mynbhWXez6iOMs4x1zHVgvouAZgWXyhQ65X/SfITMEBeN3tWSGKIHlLWgaVL
	moQCmgOyFpw16qdgHHx+z+ygQf8PGzkzVM2xTsoRDAeP0un/0f0WctAgjZ2D7wQW76DKCMYNpBL
	qG28JHnEoInOGfkKoJ60btybUC8eCouxKTBo9X5SJc/JqSQIlXgX7+pfJEU0wXA/fL5Qtfs89n1
	nuYiHhPSz2pPq//Ah3gId2WVVdLyjLVgsf061aWrgjF8jEr7twMlPoglkhhOYi8bLqK8dUc6G6N
	NZQRoRXZLBw+PnaSYoOkPswitShC86PgRJ33gYuqcLMBixYi53h4sYWmxJ8N1kwymzvytefxawB
	b+Mpn5fYgrgHiC6OTp0ytYyEYtF98KWCJeq1RJE/M3sH5yyItS0ulVx1vT6Xf3sTkfLqlpO00bk
	ud91QxCJtDAJIz1JjtKXGh
X-Google-Smtp-Source: AGHT+IHdxuaNfoOArrhJfQGMxJD7NTPYAUwkN7KhO+ZEUCIEmGuIhQs3mIG7HIDmUEghx29uGdFspA==
X-Received: by 2002:a5d:5442:0:b0:432:7068:18a with SMTP id ffacd0b85a97d-43270680252mr939319f8f.20.1766509247919;
        Tue, 23 Dec 2025 09:00:47 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:47 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 23 Dec 2025 17:00:24 +0000
Subject: [PATCH 1/5] perf build: Remove
 FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-james-libbfd-feat-check-v1-1-0e901ba32ed9@linaro.org>
References: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
In-Reply-To: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Leo Yan <leo.yan@arm.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Alexei Starovoitov <ast@kernel.org>, Andres Freund <andres@anarazel.de>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Nick Terrell <terrelln@fb.com>, 
 Song Liu <song@kernel.org>, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 James Clark <james.clark@linaro.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Quentin Monnet <qmo@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.14.0

From: Roberto Sassu <roberto.sassu@huawei.com>

As the building mechanism is now able to retry detection with different
combinations of linking flags, setting
FEATURE_CHECK_LDFLAGS-disassembler-four-args and
FEATURE_CHECK_LDFLAGS-disassembler-init-styled is not necessary anymore,
so remove it.

Committer notes:

Use the same technique to find the set of bfd-related libraries to link as in:

  3308ffc5016e6136 ("tools, build: Retry detection of bfd-related features")

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andres Freund <andres@anarazel.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/r/20220719170555.2576993-3-roberto.sassu@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[Cherry pick to fix accidental removal in commit ad5f604e186a]
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.config | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bd9f4804d56b..ea6636a09a95 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -379,8 +379,8 @@ ifneq ($(TCMALLOC),)
 endif
 
 ifeq ($(FEATURES_DUMP),)
-# We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# We will display at the end of this Makefile.config, using $(call feature_display_entries),
+# as we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -927,8 +927,6 @@ ifdef BUILD_NONDISTRO
 
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
-    FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-    FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
   else
     # we are on a system that requires -liberty and (maybe) -lz
     # to link against -lbfd; test each case individually here
@@ -940,13 +938,9 @@ ifdef BUILD_NONDISTRO
 
     ifeq ($(feature-libbfd-liberty), 1)
       EXTLIBS += -lbfd -lopcodes -liberty
-      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
-      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
     else
       ifeq ($(feature-libbfd-liberty-z), 1)
         EXTLIBS += -lbfd -lopcodes -liberty -lz
-        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
-        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
       endif
     endif
     $(call feature_check,disassembler-four-args)
@@ -1324,6 +1318,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about libbfd, disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))

-- 
2.34.1


