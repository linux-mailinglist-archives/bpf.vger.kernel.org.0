Return-Path: <bpf+bounces-1863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18C723162
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41776281473
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3E261E6;
	Mon,  5 Jun 2023 20:28:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF181118D
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 20:28:14 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED9EC
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 13:28:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f44c25595so1928425a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996893; x=1688588893;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XnxfahBFhDdYZkXlZPUfdWCh0pSs+dY9UekTfoE8XFc=;
        b=Q9T10dtnVViuYX7PiAM77gTQR0mNL3l97CIumpOUFIVSRAIJxcSd3D2ssFddid/ZER
         4yvhaKqX+CXtWJOEEHsIF1yDBSZMgW+3U2Dg0QjFQ55IN/igthyx8QVzi7TuPneZdMSo
         qBwAdbSf3nSWBH6RfewrhomP/I0PC2ahg28AHryNHnChrBkmAhLkUpbUku9HyU3wCGE5
         ZrrC6SF/Tn+Z0D4LZdyOmwPRCfQS2rkd8UCnKCqnnJLzFS3Q+Tmbf6YTv1J+HigoQAk3
         w8f7zo+pYQdVXX3jPv76zrwHgJEmr0M4X8TE03/0WaKp1+pSCpmpu4tGo/rWgZjL1i6y
         DVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996893; x=1688588893;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnxfahBFhDdYZkXlZPUfdWCh0pSs+dY9UekTfoE8XFc=;
        b=MrXr11vCFeFEtxAO3Bvf4KUxThCqY8vIodX3ERdrvXwOoRB3f8QYJ0Kb8c1TVfSuJm
         dIvAzQsExlVJNs3YFy7ZrUThyHqPHzFZ86TCIsGKriICytdVNZbGQsJ4E3bUmPOAMSTf
         LWY3CK293nybPlYUh/TRCGnJiK2WWbktSTlORKs3yn5pJdXi6UsJpn6KhxvJaRZx3Lqw
         y1/HU5MhkqJAe0ix3JbULM2QEbpJD/PdqK93fZW5mO2BXhg2kib+nChukWexPAaycHpa
         LtbGrCwgVaMzI/EXVjUGo9I0BeZuturRN0TQbmBgVTkrGoKxcE462qOP2wLhH21LeIZ5
         ZHnw==
X-Gm-Message-State: AC+VfDzEdrbxVwFmNEE9qzPrQdUc4Dk60GRZjxyXTyTWNxUikwJoXE8G
	uVMUSgeBg6pDAbc1GW9HU6odTeZRUwIF
X-Google-Smtp-Source: ACHHUZ5bhfZTZzASA6Lnd8k7u3qSQLLP0zYksqWxf+mRuBv7Pszw2pIpT7PC1WG+Mphjo3kJ1B+xcPEnKtB/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a63:f14c:0:b0:52c:4227:aa61 with SMTP id
 o12-20020a63f14c000000b0052c4227aa61mr193290pgk.6.1685996892776; Mon, 05 Jun
 2023 13:28:12 -0700 (PDT)
Date: Mon,  5 Jun 2023 13:27:08 -0700
Message-Id: <20230605202712.1690876-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 0/4] Bring back vmlinux.h generation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
satisfy libbpf 'runqueue' type verification") inadvertently created a
declaration of 'struct rq' that conflicted with a generated
vmlinux.h's:

```
util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
struct rq {};
       ^
/tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
struct rq {
       ^
1 error generated.
```

Fix the issue by moving the declaration to vmlinux.h. So this can't
happen again, bring back build support for generating vmlinux.h then
add build tests.

v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
    filter out kernels that lack a .BTF section and cause the build to
    break.

Ian Rogers (4):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL
  perf build: Filter out BTF sources without a .BTF section

 tools/perf/Makefile.config                    |  4 +++
 tools/perf/Makefile.perf                      | 33 ++++++++++++++++++-
 tools/perf/tests/make                         |  4 +++
 tools/perf/util/bpf_skel/.gitignore           |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 --
 .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 ++++++
 6 files changed, 51 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.41.0.rc0.172.g3f132b7071-goog


