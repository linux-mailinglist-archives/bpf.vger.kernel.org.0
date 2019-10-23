Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D74E0F63
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2019 02:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfJWAyA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 20:54:00 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56180 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfJWAx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 20:53:59 -0400
Received: by mail-pl1-f201.google.com with SMTP id g11so11567282plm.22
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 17:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hTNszrLwiWQM9d4qPLewL0yEQ/cfDBLkldVagVLEUe8=;
        b=G3+2N9hR6CXSywV/BCG9jOzcYqmnnIcMKGmlNKEdFehcbxSmPwGHWUEGPxsOqi0UPp
         8M0SlH5BoyojTAmdI60I4dOtJ3aXm2zJJGSdETJyBFUEkUQv9JxUsiYcbWUeWnW6HR9M
         moMWeOLseXW3m+Ak1+9LsOXvbUUOmsHD1W8OOdKwYcVxOlF4J7ok5HWpf4mmtd3i0SUx
         jBxJiJYqlILVQ6WdIpWFFB/NYBoD3pg2UcQPJLrNqXMllSQomgO8rX4ZapAE76zjdLjW
         REN4Hu+gnSTSl53QCKw5BI2Z+WrADhrHAvaBO2pETg5rxfgSXkYFcIhpaoubzbm9GkAj
         uO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hTNszrLwiWQM9d4qPLewL0yEQ/cfDBLkldVagVLEUe8=;
        b=OmWtZu5vtSLUmfhNhm4nIknPv65Y5yvruwdSKpGesncXs73CplryWGp2xtAa/plN8U
         8H3zqpynKMzLa5gkKOFGdpImyeqyPbWBR37Z86LF4Vuqk0/QsIMh7iPhOK0ZqCrW04fE
         xkk2IdlxyX4cPUADhKR4wGDqFwgQK1pbr5pYXIkXjIy6CVjV4JQvTD0Fe4CN3izPufuP
         JELpmAG8Uj0dRVVJoGvbSQoRY7rXq/mLjBYgPklAXuLeji64kG3XRTfbPjsDHNKzbvcV
         5d9/prvXQydP6MtrxCcRgnQIoc2y1pMS8F095tQTs1RxXINgn1d6EHvn8TJw4bMZiS/N
         D3PQ==
X-Gm-Message-State: APjAAAU7YMelHKsWeAg+rLJwP9jJnzdLIC8V9/i0hyQGWCbah2Pc+5Ho
        NlKZW/5HXEOojvE/dqYxtwp+XWz/jqZE
X-Google-Smtp-Source: APXvYqzYOzdcq5nCtM6xX1BGWadrzL6Bve96/TmAwvY8X0RhJGLPOQH1XzQWxptmeVhcoCUBfC4g1K9JIAd4
X-Received: by 2002:a63:e255:: with SMTP id y21mr3404951pgj.353.1571792038384;
 Tue, 22 Oct 2019 17:53:58 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:53:28 -0700
In-Reply-To: <20191017170531.171244-1-irogers@google.com>
Message-Id: <20191023005337.196160-1-irogers@google.com>
Mime-Version: 1.0
References: <20191017170531.171244-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 0/9] Improvements to memory usage by parse events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The parse events parser leaks memory for certain expressions as well as
allowing a char* to reference stack, heap or .rodata. This series of patches
improves the hygeine and adds free-ing operations to reclaim memory in
the parser in error and non-error situations.

The series of patches was generated with LLVM's address sanitizer and
libFuzzer:
https://llvm.org/docs/LibFuzzer.html
called on the parse_events function with randomly generated input. With
the patches no leaks or memory corruption issues were present.

These patches are preferable to an earlier proposed patch:
   perf tools: avoid reading out of scope array

Ian Rogers (9):
  perf tools: add parse events append error
  perf tools: splice events onto evlist even on error
  perf tools: ensure config and str in terms are unique
  perf tools: move ALLOC_LIST into a function
  perf tools: avoid a malloc for array events
  perf tools: add destructors for parse event terms
  perf tools: before yyabort-ing free components
  perf tools: if pmu configuration fails free terms
  perf tools: add a deep delete for parse event terms

 tools/perf/util/parse-events.c | 177 ++++++++++-----
 tools/perf/util/parse-events.h |   3 +
 tools/perf/util/parse-events.y | 388 ++++++++++++++++++++++++---------
 tools/perf/util/pmu.c          |  38 ++--
 4 files changed, 431 insertions(+), 175 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

