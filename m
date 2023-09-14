Return-Path: <bpf+bounces-10092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638AA7A0FBE
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9770D1C21186
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC606273C8;
	Thu, 14 Sep 2023 21:20:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200D273C1
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:20:07 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A4270E
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:20:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81a47e12b5so1013972276.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726406; x=1695331206; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEBLCnDyHWS5IuPY851bB1uYjpvWDCqujKcJXiny/1I=;
        b=bzu+DbleT9wrOxJdJLp2RsnQvzhNTflsREXKrwLaHgs/Z2cJe4Rhy8WE9eGIXgSjSS
         iLsHeNuNq6H5xL/L2yLTiLGIJVD+jNFVRbzPJ374oInXRktPUrT9AO0lVgpdr+RV+xqE
         iEHJil3xwUhvn8+SJP+U5D34p9DUc0nkj506Y7YAfKSiKXqN6EQntS/THNBTHfh35XT7
         dIRD7eYEvNNyk77GrE5KPWjl3bXBaKcinepszOcu9KZeGYFKktzsb1x070gS02XZ/2yn
         6plBlb2i+KZpHgePtRH4PuVwEu6Nnt3kxhU609zKkvM/RgqlJwklqbsSSzVP+LLq0I69
         IEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726406; x=1695331206;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEBLCnDyHWS5IuPY851bB1uYjpvWDCqujKcJXiny/1I=;
        b=XNLXCE5dPOwUx+L9r7qPPgu1RI8nrPx9S1NmpJRFbbCUpnaV7wcWzuZ8SOrNCkceHR
         CRmfMjws0OXgtcqSIu9bq6Df5XkgBYXDN94iU83RgABDoXry79YbYUrrBA12QEIw7Nup
         4Tpi5m5BphawY4piqBpLSLSC1bmOKWxGnvsYzfx6FOXaI23ZaPccotH8YQEW7RrcJ740
         4WPcnpc59AcqY1MOUTqFI0cRT2ep97bwjHWnD+fcMrzp1NdE+oGNx7PHWHkamp6E42wy
         9R04pmQNWhZOoE4E2zFGjW/vLRUp+iD2LTZ/IMNXqIUAEa/0MEE7V5ZEjRxAYJLr6X6u
         Ddng==
X-Gm-Message-State: AOJu0YzqfzfpVLP3stXTYWfNn0D3rEMDURwRK4Gsx7/6KaLRON9H47wQ
	2i4xQ5kEUr9HKzisimC1IrHRkccDK6+A
X-Google-Smtp-Source: AGHT+IFjNitaNwEgv3EEZ6iXNRaR95WvUU1GpXUYm1fAho7ynBUmSGSSBv8y18SlBKTVkWFYTJLjScNmdKn2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a5b:bc6:0:b0:d7e:a025:2672 with SMTP id
 c6-20020a5b0bc6000000b00d7ea0252672mr153772ybr.9.1694726405869; Thu, 14 Sep
 2023 14:20:05 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:19:47 -0700
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Message-Id: <20230914211948.814999-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 4/5] perf test: Ensure EXTRA_TESTS is covered in build test
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

Add to run variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index a3a0f2a8bba0..d9945ed25bc5 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -138,6 +138,7 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
+run += make_extra_tests
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 run += make_no_libperl
-- 
2.42.0.459.ge4e396fd5e-goog


