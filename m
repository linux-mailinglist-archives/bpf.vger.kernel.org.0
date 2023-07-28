Return-Path: <bpf+bounces-6167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EEA766479
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BD82823CB
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F23BE76;
	Fri, 28 Jul 2023 06:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C81FAF
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:49:47 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39F3592
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d10792c7582so1646019276.3
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526982; x=1691131782;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JSRNyTgH2RQM+IopPYAVHpRofqMWho9ANhQe7NRcfyI=;
        b=nRXi1Z1xCu+ny9dJx+xC1ohGfwhMrbNXm3ILlxZ3d8TaGL1vQWN1Y8b119HfJeOH+L
         sYKDJmVsp9CBS2egYSkyBlP6MXSlJmcM60reg1cTMtzo3s2yoXU4YF41uTIre8F6TBak
         IV7uqTL1PElSoXiUNzEsLMQ6Vt12zexPCG/AQVo9mBnI5/+IJYT5zRffhRstt5aFptQH
         aa98iwrlnIVy5+oVyhwnEV9xk0Uv4CWqfHV05vOOSjVxW3uJfPyTFTd2hQjYpTDrkTEW
         4vf0idf827w3L+2/4kRyak9lzmfRYrBeTuZj9mxJJxnARn3FrgPJ9mNUgA+HPLxu9GCS
         4tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526982; x=1691131782;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JSRNyTgH2RQM+IopPYAVHpRofqMWho9ANhQe7NRcfyI=;
        b=MTkZ6Q88hRQ+6baLR+2NA6w+0wuGrZCoAUMnXGdK3dNWm+nzIx/AqpeDDhKCnZ/oqq
         R860OvZvN9asN2DjocVRsf4g3XozZ2uwS9CivHPbiBXWUOQaSaXfGMd70krME4eBJQ7/
         ujO1r+HXSa3krR5NuQtQrnpyiOF9Ajbblo1/ecbSCbCJoAz4R6ZAS4/v8+nkmKLZezL2
         mIK3CY+0dFIMq0K5UgHpWkhmLCbfSZ8QlDU3jWEqtwtaLDbyc7HCbyOYs/TOoJ3yuzS0
         VixcR3oDMy+WubqVN2aidYJAaN6jI4sIqn7lo5gROt0/WwUtvYEomFD2+Lof+WXgN5GG
         Gelw==
X-Gm-Message-State: ABy/qLbDWgfVb9AAm7MZoRDDHrMe8Mvm/dpexIa5CkGVfYkL8MosJncr
	t9MEcWsdgp6AZTrdxyn1v5VfQh2xbYp/
X-Google-Smtp-Source: APBJJlH3g+5y4xz+Nx2m6TkDig3uk0UwJ/M7ao/vA9fmwc712RvGVnodtkcrYfR1OT2c4G9x/YNVMhG1rfj/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:ab47:0:b0:d08:8cf5:c5d8 with SMTP id
 u65-20020a25ab47000000b00d088cf5c5d8mr4845ybi.5.1690526982027; Thu, 27 Jul
 2023 23:49:42 -0700 (PDT)
Date: Thu, 27 Jul 2023 23:49:11 -0700
Message-Id: <20230728064917.767761-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/6] Simplify C/C++ compiler flags
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Gaosheng Cui <cuigaosheng1@huawei.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some compiler flags have been brought forward in the perf build but
without any explicit need, for example -ggdb3. Some warnings were
disabled but the underlying warning could be addressed. Try to reduce
the number of compiler options used in the perf build, to enable
Wextra for C++, and to disable fewer compiler warnings.

Ian Rogers (6):
  perf bpf-loader: Remove unneeded diagnostic pragma
  perf build: Don't always set -funwind-tables and -ggdb3
  perf build: Add Wextra for C++ compilation
  perf build: Disable fewer flex warnings
  perf build: Disable fewer bison warnings
  perf build: Remove -Wno-redundant-decls in 2 cases

 tools/perf/Makefile.config     |  9 ++++-----
 tools/perf/util/Build          | 18 ++++++------------
 tools/perf/util/bpf-filter.y   |  2 ++
 tools/perf/util/bpf-loader.c   |  3 ---
 tools/perf/util/c++/Build      |  3 +++
 tools/perf/util/expr.y         |  4 +++-
 tools/perf/util/parse-events.c |  1 -
 tools/perf/util/parse-events.y |  1 +
 tools/perf/util/pmu.y          |  3 +++
 9 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog


