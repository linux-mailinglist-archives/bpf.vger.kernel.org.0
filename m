Return-Path: <bpf+bounces-1043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3870CB5E
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8E7281103
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458E9174D4;
	Mon, 22 May 2023 20:41:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82C174CE
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:41:26 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F494
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 13:41:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2532da9e45bso2043878a91.0
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788085; x=1687380085;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iR+BWwf4OJyjMqBDmvTGWi3YCxxOLx+95DOCyJVhKPk=;
        b=xEa2mOQ2SU1uUUjttd9udMgRxPuLw8oCfRKbF8vtgTjACLQmxJkg3UlfAOJR42UukM
         2ceUcX4VaZ3REotSepvjFLOyzJj6wCM9CXPDxU6j3PR5bc5IPOtAhWh1/oqItWFbKb+l
         733AS0+sqdBmKeoiq9rksTo8cQroiIz3l70/cGsIUiBtEeuOHdNHejR/PaQdK6xnsVQJ
         XUBiLUf1hBSGbYMKJvUzpTcqDcCRL669NjLWUA27uHWUc0BBEx74CIGWM+tl8oxQrIKX
         XJTY0s8FmyqQUBkNT7x3lSqe4UciisM58DPS/vS7/Hav5LKzuhpyJ7um5LQ/px5A+9Rb
         Wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788085; x=1687380085;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iR+BWwf4OJyjMqBDmvTGWi3YCxxOLx+95DOCyJVhKPk=;
        b=VXwrFd0i8BLUJ72UJZVZHpredm0uG8oFMwL2Cg9tgZqUwActiNmJuTPmyrVpZluO4p
         4ep/d4UQG2hJY3o6wycabkY2vuCV0JHHRP37Cf5gJULo9BBtli7mN77PgIGkv+EU5vYp
         W/lUAd0pIBayrUG2MjLYdDNLJDP6sbuqjwBvFST6SRqCURDHMNKcQKy8YrXaXrG7lrCQ
         qpdBOmPaXCEpLBO5OjEWpQD+oRnY/8n1gLAUttVihd91Um7ku+fkt6Y34cEBndkYlJB5
         FIQH6qBKIN2bUpyOzQnPNjDsE7payqGLucoAthPHLlTug9h6qVcil0kqRClYpyWwmSki
         MsOw==
X-Gm-Message-State: AC+VfDwJ5Alh2ocEv/2mng92LWRUHhqGyH5iffEejngzPE4tCRg0dLhz
	ZhhiSoOH574dD2HZeAGHrTgl3Ci5WXA8
X-Google-Smtp-Source: ACHHUZ5UVJ/C3KmSAfO5qNKyH4H6nxwXGqLXpomHHJOGaFsacH0kVA5wReOpD9Jl2yVocPJozpRri3FrjLbf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a17:903:3390:b0:1ae:5474:4c82 with SMTP id
 kb16-20020a170903339000b001ae54744c82mr2770731plb.1.1684788085354; Mon, 22
 May 2023 13:41:25 -0700 (PDT)
Date: Mon, 22 May 2023 13:40:44 -0700
Message-Id: <20230522204047.800543-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 0/3] Bring back vmlinux.h generation
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
	autolearn=ham autolearn_force=no version=3.4.6
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

Ian Rogers (3):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL

 tools/perf/Makefile.config                       |  4 ++++
 tools/perf/Makefile.perf                         | 16 +++++++++++++++-
 tools/perf/tests/make                            |  4 ++++
 tools/perf/util/bpf_skel/.gitignore              |  1 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
 tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h | 10 ++++++++++
 6 files changed, 34 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.40.1.698.g37aff9b760-goog


