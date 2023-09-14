Return-Path: <bpf+bounces-10091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA87A0FBD
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4D21C20F70
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274A7273C4;
	Thu, 14 Sep 2023 21:20:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF0E26E36
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:20:05 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81802706
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:20:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cbf62bae8so18403187b3.3
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726403; x=1695331203; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Br6oKi7mTFdhI/sS2Gl2xU7/jDtLT7KyY4n04DEal0=;
        b=YVMLB5OGWEbXMj2TypGxwScFqF5SMACUyZnerRqGrtVj2YnifhAtnPO747YqC1AbU2
         gDPOo6EGZlP3jauDQZBRIyN2jJGZyEwjO6nXomc5jAhgti+4fK7zA4DN3N5ck1nkrg3d
         kcNlltAmxDdIXXujV/p5gOTe0DVFmJmqoIH7cS8baMVfWAPa+fLTp0FrjAAF+7Qa2lm9
         4zQoEqTR5zcmmedQ4ayTUyXq47N32yzNCvj3kSwrA70wCTWGaNNLBBnI4OLMlf3K1XwS
         Gt8gR+nafWpkHYphWxNN9J60gzeIKppYC3j/zT0mkWFyTkSpsT9L8m0We8czhGR5HC8R
         mIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726403; x=1695331203;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Br6oKi7mTFdhI/sS2Gl2xU7/jDtLT7KyY4n04DEal0=;
        b=YSpz2s5ZQY4hwWYL/BrA6QBY0FBnSyPgmmYRFBkGE5I6veLVsXJ+A2/Il2yJkK35EC
         iRhHV16d/FpCTYxrF4q1nSGuQvdm3HpVQTihbYVKTukdRFgNHDsU7mSeeXmk86R6top8
         Xlig9Fhms6e6DAWBMT/jTIb8wBqFOMiirCwKoHzt6cDwx1BVZ8GWiqjzKY0anGahtl7Q
         AcYllhns2ASUJfRm83edp9tAVTpAnWai1cieUNYXScRe0VpdlT5HUB7ebfyEGumdpXeg
         PjMe9kWHGZWwAR2HYcBAY7I65O8P0knQqDbur2pHRsNTaZKPQb928aOCU505YafebFWT
         FNAg==
X-Gm-Message-State: AOJu0YyHEBkfOpLI24j8AYqclMySc1ccch9C76yhCW5hzsIh7MjVcwjl
	VE9fkxgQ9aRrc7+vN2p6j7xptpoWys3r
X-Google-Smtp-Source: AGHT+IHs5wkR+KiaL7EtqQCQpiLyI7h1XQQLsqyWJg8cBDHl64BZ691Sqo/oENqg9GTO1CpzGy0/AIzlBRLZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a25:aa83:0:b0:d77:984e:c770 with SMTP id
 t3-20020a25aa83000000b00d77984ec770mr152103ybi.5.1694726403757; Thu, 14 Sep
 2023 14:20:03 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:19:46 -0700
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Message-Id: <20230914211948.814999-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 3/5] perf test: Update build test for changed BPF skeleton defaults
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Patrice Duroux <patrice.duroux@gmail.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fix a target name and set BUILD_BPF_SKEL to 0 rather than 1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index ea4c341f5af1..a3a0f2a8bba0 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -70,8 +70,8 @@ make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
-make_bpf_skel       := BUILD_BPF_SKEL=1
-make_gen_vmlinux_h  := BUILD_BPF_SKEL=1 GEN_VMLINUX_H=1
+make_no_bpf_skel    := BUILD_BPF_SKEL=0
+make_gen_vmlinux_h  := GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -138,7 +138,7 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
-run += make_build_bpf_skel
+run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 run += make_no_libperl
 run += make_no_libpython
-- 
2.42.0.459.ge4e396fd5e-goog


