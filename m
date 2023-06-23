Return-Path: <bpf+bounces-3228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0873AF4B
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 06:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50352818CF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 04:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE71A3B;
	Fri, 23 Jun 2023 04:14:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425BA20
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 04:14:16 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84355211D
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56938733c13so2088107b3.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493653; x=1690085653;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IWD9j1HDpuBwOtgRD8+VR/HyczlG3iSDWYis44Ihg3g=;
        b=Z6TPQvcA237450CbME4sySp4GZO5k8VXvDqisLx4wxKL4CKK/VN69L/LEq+H/jaxaa
         9jSPwdoN4ybnlf8zZXY2xA2TmCMbDjvpEblejvKPPC0N0bZ8bPoTy+JIdGEkptUU73zh
         E3XHe1UxVrOjHWaHcF5+wDYec6y8ndt8Nyq6paH6a+aoXZ0WVt3QQmKzMXCDOyaul7ag
         eByKdsLT4j27OEzLPHGbfYd3dwkCjRhmsTB3THolp9iILFJwADGV1IkAkP4dPjDZiyLZ
         Lg73CBhNQYuWVz6YdXlqTjET0jJZcFUOvcAispoSjBR0zBurogbz/GQYj3z9DIjRh6T6
         aN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493653; x=1690085653;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWD9j1HDpuBwOtgRD8+VR/HyczlG3iSDWYis44Ihg3g=;
        b=XRnrQD3Ml4YPPu8OEHXRkCt87fLADFJ3OjpQ7wqxjLABK8i4qWkpqMWNRUV9cn5Of8
         lGEV/n5jJxqNhjubvx4m7Y1kOJ+pnt0QTovbgWX1YtTutKjKlt+R5XSz7ZsyK/iJf6sC
         pbrNzXBEbRvCu5EF9J3W4nBtNmaMHleUl+mWcSuJF1+SqzKpJPWzC3O4zKkz8Jva2Jkp
         tfxwmXK15eGULI2O1K58MCxMhUQLV6D3h5GV3foQ8sOWy3NpYaDnrNe4lA+/u/JqdJW7
         UfS/E6mx0cPsHMpMu4InJpQx/bNXxzwGxu53WI9SIo8/4SEOWpMvw4ZwZyU7Spfb89vp
         VRPQ==
X-Gm-Message-State: AC+VfDy3iM4HvpPZ4sulVR6chzGje1wa9bDqUu3v4EyxpSITqF4NZ/yC
	GRase9gXfhxBZktA0tmTaj8Hd1KnM4Mo
X-Google-Smtp-Source: ACHHUZ4ktfc6111JvR7+3Ed89DYQF4EkwuteMc+RPTAZXpHpUpH1nYrRdu+tu44wMR35qHiNSmWLIti3pmo/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:ae07:0:b0:570:200:18e1 with SMTP id
 m7-20020a81ae07000000b00570020018e1mr7911028ywh.3.1687493653716; Thu, 22 Jun
 2023 21:14:13 -0700 (PDT)
Date: Thu, 22 Jun 2023 21:14:01 -0700
Message-Id: <20230623041405.4039475-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 0/4] Bring back vmlinux.h generation
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

v4. Rebase and add Namhyung and Jiri's acked-by.
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


