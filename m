Return-Path: <bpf+bounces-2201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE4728EFA
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 06:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04F31C20E2B
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 04:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF6185B;
	Fri,  9 Jun 2023 04:32:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DC15AC
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 04:32:55 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEAF30E5
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 21:32:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5692be06cb2so17728967b3.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 21:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285173; x=1688877173;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eip+GKzgi+H+UisiUsEsMTegbA5w4/cyYD2LTNMLb1c=;
        b=DJBFhRCz579eISTrwAKv+a4Sa4rt7TRv99gGYmUFbbDFN56KBekmWQj07fqgH7OGmb
         i5Ht2/fOJZ5U/vdJedjrHdwBv06oebCd+wVsn5/qYpyhBDJWOy4NqmSbeUcaJFWmxocT
         XwHrpUMLZ+BnN2JshnuB93vp2qOGo4yFS1TQkJhCdlVAqOlHk/Y+CD+ROWxaDfBCtWwS
         1Kc6GAmU0q/Lfy6qaQzikMpAdYlzOo6b+/fjSd0UbYhFoo3uvb9WcqrAo+oqd+EtfmOl
         1Vmf+yNRmR9CzDBhsuKNqNLjwQ3ycx+BcGXLAphN9wMOCcs+USVzwLzXc+i2rro6niJ5
         zgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285173; x=1688877173;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eip+GKzgi+H+UisiUsEsMTegbA5w4/cyYD2LTNMLb1c=;
        b=ECLzMlVcmweUN7a86ibB1HcQuIW/NxzWwXG43s/2xr++CBuueftShKsU5N0h61ydDP
         GyWmYniJvgGZyLY8S0qMqhpxMUM7eUUpJT7GFfl63v2AD8TufGyEywo0M5yPWaKE9GDb
         D+6jgfnTpatdYlz0Ahhx0CuBSCyFLwNEvLT26ZoH9xNne18+sIwz+nvUYdosLOgDZfFi
         vTjT7waARRsQp+TQl52FwGTM/f9wvO/wOEY+cLRuAVkdKXTO+M2gN/xxDqZG7UJiw9PX
         aQX7YizKYk/wLMgx8aI4VJxHyfB6bQkmFmr+Ab/dYVaTuzF+yCCrsFIgvXH352VpRwDb
         O6Gw==
X-Gm-Message-State: AC+VfDxnNSUgbqItAuZI8f1NBakOtu0GW3XH1MI8n80QvgF00WOEhLwI
	rDSFaJ1dfUGn1geWeNB8Ebvq6d0Eu6dG
X-Google-Smtp-Source: ACHHUZ7tu13JlWNPkPP1onH/w35dv0gMnF/OAMoeeHS8gt2OBtOOuDzW1wv9x6GnuTMhwVkeKtqW3KZ0Vk7T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a05:6902:4e5:b0:bac:f387:735b with SMTP id
 w5-20020a05690204e500b00bacf387735bmr60622ybs.13.1686285173182; Thu, 08 Jun
 2023 21:32:53 -0700 (PDT)
Date: Thu,  8 Jun 2023 21:32:39 -0700
In-Reply-To: <20230609043240.43890-1-irogers@google.com>
Message-Id: <20230609043240.43890-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230609043240.43890-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 3/4] perf test: Add build tests for BUILD_BPF_SKEL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tests with and without generating vmlinux.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/tests/make | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8dd3f8090352..775f374d9345 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -69,6 +69,8 @@ make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
+make_bpf_skel       := BUILD_BPF_SKEL=1
+make_gen_vmlinux_h  := BUILD_BPF_SKEL=1 GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -136,6 +138,8 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
+run += make_build_bpf_skel
+run += make_gen_vmlinux_h
 run += make_no_libperl
 run += make_no_libpython
 run += make_no_scripts
-- 
2.41.0.162.gfafddb0af9-goog


