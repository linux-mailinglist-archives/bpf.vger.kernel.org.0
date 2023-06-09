Return-Path: <bpf+bounces-2198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01841728EF4
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 06:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF11128185A
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 04:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B201377;
	Fri,  9 Jun 2023 04:32:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A17E2
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 04:32:48 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EF130E4
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 21:32:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565de4b5be5so19479557b3.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285166; x=1688877166;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWF7slA8vgXA8RW6bpiqoclUoglCNciaZKdWa5dk63U=;
        b=j3MQdwlPlNLSTAZ4JPSGVl2PkwH9k9SMKlrpWVwSIlZgNR8AhEh8j40ZMSq/Ij3yms
         qUeg4kfPtj5voC4sBWo+zdv9jE5SwHv8EKxP+EVpjDR1rku1BzGshxuoxH7oSEnHSJPx
         kADT7DRCNyNrO4Tqc/b3GGfDMKX6auftBx9DtFHn7E3HAJrjk9Zi6+45CWxFa8wPQ89m
         FwuYi8ld3YGYzpMLO0tIAdYyn9lXQBsmstAA3oJ9TDwZ7Oeg3suixjRtWNN6yB/JHw/w
         d6ldvdlJd9ASl3ZdlecZYVv19ohBwyMwOedDcxg9pJdyqiutkzn0p3/7DJiWYrFWEEgh
         y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285166; x=1688877166;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWF7slA8vgXA8RW6bpiqoclUoglCNciaZKdWa5dk63U=;
        b=bd6WWb1vPy7V9AaIZt6qG+k4eT+HFov++TCx9gOJIAcJ3lPe4lYSqohG8lvZvSEhyt
         koDgfC+WBg1b0xnPYxdaMAi6oUgKmxKPakN7uZ73wIbhbeiIiEuAU14uDoVE4x4rRZ+J
         LAbroLcfN4uputF/rhvBm5qdvYGlpWYBBTRwaREr7ydLkJNOE/I3uXhQhbl0cP88IFTm
         Pg4W//Uqg1ZVJvrn8Iwx9EdlSE1afKnI8uBpNX5KixBIxlS95zGMi+lf7YTC6wX+EdIP
         0lU/WVMOdHWy8snajkTs5pfLNsplsLzJ7E2jIF/wpPEIe+bRugTPqHJohQBdCjhg14n6
         wPIw==
X-Gm-Message-State: AC+VfDyvOmMXB0vG4GpQg7446g0L54ooX2q+5iM3afVAkI4RG6ZPTvCG
	899MdhNyRQYYk07I1f3HCKu+TXwSmS+a
X-Google-Smtp-Source: ACHHUZ44KRlU5EFyYw3JMeyIqiBlwHsT9TKFRUfjhoaPmuiiLS4fTqN0WKDjiNqDuvWLoJ72BMqe5oYveMfj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ad17:0:b0:561:2d82:7f08 with SMTP id
 l23-20020a81ad17000000b005612d827f08mr230962ywh.0.1686285165838; Thu, 08 Jun
 2023 21:32:45 -0700 (PDT)
Date: Thu,  8 Jun 2023 21:32:36 -0700
Message-Id: <20230609043240.43890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 0/4] Bring back vmlinux.h generation
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

v3. Address Namhyung's comments on filtering ELF files with readelf.
v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
    filter out kernels that lack a .BTF section and cause the build to
    break.

Ian Rogers (4):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL
  perf build: Filter out BTF sources without a .BTF section

 tools/perf/Makefile.config                    |  4 ++
 tools/perf/Makefile.perf                      | 39 ++++++++++++++++++-
 tools/perf/tests/make                         |  4 ++
 tools/perf/util/bpf_skel/.gitignore           |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 -
 .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 +++++
 6 files changed, 57 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.41.0.162.gfafddb0af9-goog


