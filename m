Return-Path: <bpf+bounces-3231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526E73AF52
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 06:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0582818DB
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 04:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D74138C;
	Fri, 23 Jun 2023 04:14:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951D1385
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 04:14:24 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF0268F
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ba5667d5so2240647b3.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493660; x=1690085660;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4C6MEu0bdRCdsKhKJkDe52m91K0P7NYWvYmLuS2Nk1g=;
        b=t23oRjjyXKdcxH/4YCNTTSnoxHqcUSXsDgf4xU3h5uPbQwOkTC9mT681iyeRqYj7X8
         oPlzCaGT5/zL6HKP9ruOVPEgfg5MhAPuJlvnB+kFeGIkXkkj6LpN3lJDbAc+oXXi2tt6
         o8tyET78G+WZds/8vqy9bfaNpKIhTDe2/aM4Tw2pVUYlaCKRUNlw00WPK9YC0D0vmCg5
         WP/njZCggHcJb3I0w3nNBrREmKUx2HgsfhQgiL0TaehbEcEdNVVX0vCGoVvDpi+Mj4PD
         x/G3DAgVHM+27rxi/pp+o6E+gq4o+YpkFXNDY12JFVNjf5xkKHtM1kV2SL6U8ebJwmiS
         ciEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493660; x=1690085660;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4C6MEu0bdRCdsKhKJkDe52m91K0P7NYWvYmLuS2Nk1g=;
        b=OvKi8GHd6uC4562Nsa/kY/UitHCVCTsjJnM/YlgYn64GNDX5tw1WDcpY5LXZcX+Xx9
         HBX9rOME3fy7rfWT4LR1ABFO1IEX0S02ljUTJgih2LiNkIUPlZ/NBjxkb2vJS3h+y/AH
         IfG1OQVXGzTkd/19tX7DXge5e7bsKzeNTNm6dRLMxJRiY1Z5neQLMtrY8Ernmrv0labU
         3RMiXXCr7qMLn5Uu5bZWONGCV236z3QjRS11Ht6NsPmbBeS00Nw/g2NA6NvmfMvo0PBe
         Po+gmGZU2Ur1GEC34Z+KPVDLqGk+jTvNNtcIN1mCgQnTfLucQkWYaXJJHJ7HxzTHszUG
         Bm7g==
X-Gm-Message-State: AC+VfDzkWLTcGXPRdOwkjhxPWA+hTot2ciSuWvjYYo6yuTXi2oY4p3Td
	VntqxJOd087Fi9+EE3QDlUcADbqHcKTd
X-Google-Smtp-Source: ACHHUZ6n1Y2QhsqshDgG46WGDwQEb4sUxMAtqz7hX4U+836p8rCyiVp8s6+MOz3xXfTu3v/pwdiQZex8zAZ/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:b1c5:0:b0:570:b1:ca37 with SMTP id
 p188-20020a81b1c5000000b0057000b1ca37mr7965992ywh.5.1687493660181; Thu, 22
 Jun 2023 21:14:20 -0700 (PDT)
Date: Thu, 22 Jun 2023 21:14:04 -0700
In-Reply-To: <20230623041405.4039475-1-irogers@google.com>
Message-Id: <20230623041405.4039475-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 3/4] perf test: Add build tests for BUILD_BPF_SKEL
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/make | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 885cd321d67b..58cf96d762d0 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -70,6 +70,8 @@ make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
+make_bpf_skel       := BUILD_BPF_SKEL=1
+make_gen_vmlinux_h  := BUILD_BPF_SKEL=1 GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -137,6 +139,8 @@ endif
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


