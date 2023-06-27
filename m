Return-Path: <bpf+bounces-3582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86637402DE
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DAE28108A
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290719BC4;
	Tue, 27 Jun 2023 18:10:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E01990D
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 18:10:44 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A9C2D53
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-67e3c6c4624so453085b3a.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889441; x=1690481441;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Xopb4bdl/ldlCNcPlk1SBW3U6rHNjvHDq0o2AtiFJI=;
        b=LdeB8wUNlVIVV2gUpS55NLo9+v10Wb9Y0ceqjwzkT1yVBKxdnlhfogJAz+yevuVglS
         p2qYBwVh+8EtpHmOCT/vL8Oi1vglidxQ8F07mByDY+YTsQn18CZ7JM0m792WbQGeEiPh
         +5eiou41/39HNI9eSkKwLKKP8IGe5gRDTjOu7COs0HebGo00V1OePY87Xe/fIW5GCPVv
         B0MPWAWG7lxqKViXNWxhlF6ydOEX0jNxAFqauCpLipTVbm5Nu7Dvi4WXaaRwYmFWFade
         7qaZ2xOogFo1gAzQeuXNuf7Qk00QnDArWjBqzcEAiH7Z2G1BoPO7OaX7Bp8xoSxssXjr
         6bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889441; x=1690481441;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Xopb4bdl/ldlCNcPlk1SBW3U6rHNjvHDq0o2AtiFJI=;
        b=GIx7t4QH9x8NXOIMSWEu1tkKf1QRzNLaIJbQXzY4unRAjUDjLgAg/WfRLHR6rIzoAe
         MGuBvEuiNYohIPGESXXkQAx58bK7p/vuaGsi/88/B4AMxFAiB7++WBgz8WybyfVGVAGR
         nmUvhKAFi56qTgFUzuCfi4bM0v88Lb+Jd26gocTYu0I5jf9fsl/cuHbp93gt4vDrmkMy
         R1USlmJAw85XBUOyvoqPltGYxbHUxpluebGYsG9JOFOMEPgkuxlpQNYxiQJzyUo3FCUq
         xiSz1fmJaN7OBeXuWhxxX8ghPU7lc/JwiBBMpINOAxf/L9K6bWXkISf+Kh/63R5qZQBa
         ClIg==
X-Gm-Message-State: AC+VfDxPM4+GCEc9crprjeklFPddj8Hoij8Td5WKZR9uvQ1vg68829TU
	tydBekB49FAlV5ppZ73AgVuzZ0/FZxho
X-Google-Smtp-Source: ACHHUZ6mT7X33BJiMUALcShfZoreYBIp2S3yS1Fc11hkbkfbrYxBsrXZVfgvcRxWjNGVzhcAy+ARaJSHoftN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2d9d:b0:668:6eed:7c1f with SMTP
 id fb29-20020a056a002d9d00b006686eed7c1fmr7849031pfb.3.1687889441460; Tue, 27
 Jun 2023 11:10:41 -0700 (PDT)
Date: Tue, 27 Jun 2023 11:10:17 -0700
Message-Id: <20230627181030.95608-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 00/13] parse-events clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove some tokens the lexer never produces. Ensure abort paths set an
error. Previously scanning all PMUs meant bad events could fail with
an invalid token, detect this at the point parsing for a PMU fails and
add error strings. Try to be consistent in using YYNOMEM for memory
failures and YYABORT for bad input.

v2. Fix build error when building without libtraceevent.

Ian Rogers (13):
  perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
  perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
  perf parse-events: Remove two unused tokens
  perf parse-events: Add more comments to parse_events_state
  perf parse-events: Avoid regrouped warning for wild card events
  perf parse-event: Add memory allocation test for name terms
  perf parse-events: Separate YYABORT and YYNOMEM cases
  perf parse-events: Move instances of YYABORT to YYNOMEM
  perf parse-events: Separate ENOMEM memory handling
  perf parse-events: Additional error reporting
  perf parse-events: Populate error column for BPF/tracepoint events
  perf parse-events: Improve location for add pmu
  perf parse-events: Remove ABORT_ON

 tools/perf/tests/bpf.c         |   2 +-
 tools/perf/util/parse-events.c |  98 +++++----
 tools/perf/util/parse-events.h |  20 +-
 tools/perf/util/parse-events.y | 351 +++++++++++++++++----------------
 4 files changed, 258 insertions(+), 213 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog


