Return-Path: <bpf+bounces-3523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC773F36F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B09280F75
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B52EDD;
	Tue, 27 Jun 2023 04:35:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19217E9
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:20 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8E1716
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573d70da2afso54558787b3.2
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840518; x=1690432518;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/QPCwex7ROy04p3TgGaGQBp0Wh9htCcujKoYqvqbhU=;
        b=YIEtfV/tr8KxF7V5aLrfZcniPuQsJM5gIdAoE4WgszjGdqZj/+0XoWec3H4jZsxwTc
         d307Xf2HU3yt7LYA8UabPMG9pbguL2zus8l0v+IP62n6pyEFmEPbHMoLCh/8aZwA+F1G
         10FmVM6LqW8okifrUT6mL66+rGSkX8QbXuPZamxpxgmM9Qt0KaCKnf03Dp7AVrI1WKOB
         df/+FGralqpiwD1YHivBoDep8xn5io5pPK+/3RKivPOzF8d1oDawUKN45c8+sHn6HAS/
         /CcyjyPDded8esXmFvegflLUBB6iqJ3FF9lzYLMgL2rK1txcMcGtxYSyXX2OSkpvwwOq
         I/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840518; x=1690432518;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/QPCwex7ROy04p3TgGaGQBp0Wh9htCcujKoYqvqbhU=;
        b=MN0Ow9zpEeEMsClClX7OKxrbfZLNxh2q4ajz2+AaHqzuKI4/ARbw1MHnebnKMwPJCm
         k5nJEyJ/GJ44JDGlwd4XbAMOPzJCyGOTHHtqhfyN7jK+PiP4BwRtZvptMRFOqLfAi4ja
         0gKvctmx/BVAfqrPdgUwk52OUsADzh2r/OADyb0gfzrygai15jwTfgCyTDh8tJEVeRqZ
         lHX4ecXPYBtj4hfhVG+Xyn8Wu7TiDP7QeZcL2ID6sRQXXUd9LSz5AxLoVcArQfZBC2kC
         WRBuBSTwtEsotyBcVCw8W6T38LLNf6t6x5KgUHIirkKTI+u3Ni81EV4g0gsz+A6b2Bp5
         uCNw==
X-Gm-Message-State: AC+VfDxBd2dlGhgEfs4JaNllrNqUY1JIdsD3zAxo2s4oeii7xJICHSIE
	JS91ZhN/NqsvDrzkQE7fo5QbPEy+BeOr
X-Google-Smtp-Source: ACHHUZ5IpVTstgl7l3U4JaRHaOVP1KMYuAf/ZIqCFZ/h7GWQ0amGVNA0QYNxgmMIMoHLrDxsm7vKHYX2K0VF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:4312:0:b0:56c:fce1:7d8d with SMTP id
 q18-20020a814312000000b0056cfce17d8dmr13551974ywa.6.1687840518437; Mon, 26
 Jun 2023 21:35:18 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:45 -0700
Message-Id: <20230627043458.662048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 00/13] parse-events clean up
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
  perf parse-events: Populate error column for BPF events
  perf parse-events: Improve location for add pmu
  perf parse-events: Remove ABORT_ON

 tools/perf/tests/bpf.c         |   2 +-
 tools/perf/util/parse-events.c |  95 +++++----
 tools/perf/util/parse-events.h |  20 +-
 tools/perf/util/parse-events.y | 351 +++++++++++++++++----------------
 4 files changed, 256 insertions(+), 212 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog


