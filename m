Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E9664EA3
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 23:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjAJWUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 17:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjAJWUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 17:20:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F254F5D88C
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:20:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w15-20020a05690204ef00b007b966ba4410so11058573ybs.5
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nlle/Ds4SGPTSO3cAFMNWJvr6o/XSd9jrGxltpsb3Is=;
        b=ftX8xF0c4UQtCj8N+r4KjGdZEM2Q89eJAcT0lc5k/816CbQ+dPH3JYa+OAjFdHDNVd
         QyNvH3IJFde6G23zqfZ76D+IjfOJOEJQC8/srm5Q4JQO34ZQ6PHCNQNnk3T97ACazfYQ
         HHQBjOaNCkKCHAbfEPLr9p1YUIFhxolo+DlVnsz+cKtev8lxSLSXqjvP+LHfkU1/k/jk
         qPt0UvhGHIZTQfM9cCSp12yKvJbykIDjFeZDqP1xycj4bpUaMhu7YD3N+s012svSe704
         7D2j18A1UUV+BbCbxOCelY+whUXsx9mWkDkQvlwuDsyBryuamdZKE2ycCj+IlrBL6lUX
         Zfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nlle/Ds4SGPTSO3cAFMNWJvr6o/XSd9jrGxltpsb3Is=;
        b=59C+lyLuM4LwJif6JQpc1fN4Sdd/WGqQ10TNfWJLfKXplxJfRqWzabPoOkGAukQwFZ
         0hvfixCgztxT3XBKwyvVc2QEjvM7vE0R4U4XNm2WtH5Gf6ICsd9t3uIAfkENVCztXbLH
         940i2MjjB4ok8lfyntGD+UGFOmcN0Y4rrayXzFAolj9naqMXMz6uqBf5FbL92xkz06Ng
         E7SqhxP3cXtMvRbegKVjnE3eHBknv4iwT3lvU2927eOBUuWe71WeBRSdDPrD+MpqAvHq
         ZACgk/xoECV7DGfzsbODIuSgU2xhxQc2KO81hm+8oOHyLS12vQoNawF/CNx4wR17plEW
         lTuQ==
X-Gm-Message-State: AFqh2kpb7QOYr1s2GauU1lKdhWyRx65fPK4lKtXZZ8GS8ghHMPL21ulD
        s+d273Me4nRZKfSsUeplkTy61KWdqDMH
X-Google-Smtp-Source: AMrXdXtzpGXPPgsytierIDG6YXDjewBU1q0UJ4Cmay17C+CNB+GpbrmA2w0OASTh4x8U/CXwGr/u7lyqI43p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:8a8c:0:b0:7a7:c930:e66c with SMTP id
 h12-20020a258a8c000000b007a7c930e66cmr3763503ybl.644.1673389217080; Tue, 10
 Jan 2023 14:20:17 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:19:56 -0800
Message-Id: <20230110222003.1591436-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 0/7] Add and use run_command_strbuf
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is commonly useful to run a command using "/bin/sh -c" (like popen)
and to place the output in a string. Move strbuf to libapi, add a new
run_command that places output in a strbuf, then use it in help and
llvm in perf. Some small strbuf efficiency improvements are
included. Whilst adding a new function should increase lines-of-code,
by sharing two similar usages in perf llvm and perf help, the overall
lines-of-code is moderately reduced.

First "perf llvm: Fix inadvertent file creation" is cherry-picked
from:
https://lore.kernel.org/lkml/20230105082609.344538-1-irogers@google.com/
to avoid a merge conflict. The next patches deal with moving strbuf,
adding the run_command function with Makefile dependency from
libsubcmd to libapi, and improving the strbuf performance. The final
two patches add usage from the perf command.

Ian Rogers (7):
  perf llvm: Fix inadvertent file creation
  tools lib: Move strbuf to libapi
  tools lib subcmd: Add run_command_strbuf
  tools lib api: Minor strbuf_read improvements
  tools lib api: Tweak strbuf allocation size computation
  perf help: Use run_command_strbuf
  perf llvm: Remove read_from_pipe

 tools/lib/api/Build                   |   1 +
 tools/lib/api/Makefile                |   2 +-
 tools/{perf/util => lib/api}/strbuf.c |  28 ++--
 tools/{perf/util => lib/api}/strbuf.h |   0
 tools/lib/subcmd/Makefile             |  32 +++-
 tools/lib/subcmd/run-command.c        |  30 ++++
 tools/lib/subcmd/run-command.h        |  14 ++
 tools/perf/bench/evlist-open-close.c  |   2 +-
 tools/perf/builtin-help.c             |  49 ++----
 tools/perf/builtin-list.c             |   2 +-
 tools/perf/tests/bpf.c                |  12 +-
 tools/perf/tests/llvm.c               |  18 +--
 tools/perf/tests/llvm.h               |   3 +-
 tools/perf/util/Build                 |   1 -
 tools/perf/util/bpf-loader.c          |   9 +-
 tools/perf/util/cache.h               |   2 +-
 tools/perf/util/dwarf-aux.c           |   2 +-
 tools/perf/util/env.c                 |   2 +-
 tools/perf/util/header.c              |   2 +-
 tools/perf/util/llvm-utils.c          | 207 ++++++++------------------
 tools/perf/util/llvm-utils.h          |   6 +-
 tools/perf/util/metricgroup.c         |   2 +-
 tools/perf/util/pfm.c                 |   2 +-
 tools/perf/util/pmu.c                 |   2 +-
 tools/perf/util/probe-event.c         |   2 +-
 tools/perf/util/probe-file.c          |   2 +-
 tools/perf/util/probe-finder.c        |   2 +-
 tools/perf/util/sort.c                |   2 +-
 28 files changed, 201 insertions(+), 237 deletions(-)
 rename tools/{perf/util => lib/api}/strbuf.c (87%)
 rename tools/{perf/util => lib/api}/strbuf.h (100%)

-- 
2.39.0.314.g84b9a713c41-goog

