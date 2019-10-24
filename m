Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61F7E3B8D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504234AbfJXTCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 15:02:09 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:46150 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504226AbfJXTCI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 15:02:08 -0400
Received: by mail-yw1-f73.google.com with SMTP id c72so9973198ywb.13
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=StLsOwadC4o8p6VwUA79Cb5g5hBpyjdxZ8Va4K7Io2Y=;
        b=QZhxhWfvgj/crSBx9d+GO3r08rd5P6BVS82LNd+Ehg/f0jTdzBLrAWrGMEvIdVP4So
         xLhPAFCIpMtjXdHGwFect6AFUvfUFd+IVeY/umCEsFDjuz8O+g+O3UdJTQ/KW04oS0bq
         tphX/B5Q+/2Tts6ASFcwP1m8d6ZTvrpdS7Wf8Y/RcniR30+O309uhBSFNNpON/fmNNAp
         KRAdi522wh+TkDnIiBT7Z4HZ55B8mVV7sgY2paZq8DQgB8+VJa1wEv3+3105cm/EdZuK
         Wms4gkFotY43Yd3dEREwoDYDJGZALonwJKUlH1g8D/kGhWWcR+1ffw6nNdrSM+AKkhg7
         vJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=StLsOwadC4o8p6VwUA79Cb5g5hBpyjdxZ8Va4K7Io2Y=;
        b=TlenHbufhuPcND/3yKpmEjC/bvzGLoGK6YmdWWx6LahPPizLXO0JExRS8bxY6U8iYl
         JmMUvyVDc20iKs3YH4tt/teP3QGPFGVuWMEQAkS2SP9m+W7f+5NzRwkXuugwx0hXGZQ4
         4ngwN9bFmzpgd6KCmFQpehq67p6rL68NMXl2RScPmumcbkyvph9EAPKUHHGhkqzh6xVi
         3+290M+4nloqqVURLSrKeVRmylS+xS/X+87MuEk0imiMcnCA3l1k1AuXrM3GWbZNr2Sy
         qYk6A4dx8pHVrIfPBTv1h8EOVABBG1kPvFfI4ZMGmNplURDHL/mrZhgkOHEO1/qeBK2R
         jC4A==
X-Gm-Message-State: APjAAAW7DugKdoKEuQf20MdlDorYeG16E4wEtzIGwtjdNxJPOuRRVcrP
        Fr1i9W8QsMPUO0E8ItaCBUeSMLtyVFB9
X-Google-Smtp-Source: APXvYqwwBcGirXU8CMxMhVsbS7PauC9YYQN7HiutNMY0S16PECuKPj/2/yGYD9TCX9TG+ynf3AbW7fdfxlYV
X-Received: by 2002:a0d:d84b:: with SMTP id a72mr7582697ywe.331.1571943727482;
 Thu, 24 Oct 2019 12:02:07 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:01:53 -0700
In-Reply-To: <20191023005337.196160-1-irogers@google.com>
Message-Id: <20191024190202.109403-1-irogers@google.com>
Mime-Version: 1.0
References: <20191023005337.196160-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v3 0/9] Improvements to memory usage by parse events
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

The parse events parser leaks memory for certain expressions as well
as allowing a char* to reference stack, heap or .rodata. This series
of patches improves the hygeine and adds free-ing operations to
reclaim memory in the parser in error and non-error situations.

The series of patches was generated with LLVM's address sanitizer and
libFuzzer:
https://llvm.org/docs/LibFuzzer.html
called on the parse_events function with randomly generated input. With
the patches no leaks or memory corruption issues were present.

The v3 patches address review comments from Jiri Olsa improving commit
messages, handling ENOMEM errors from strdup better, and removing a
printed warning if an invalid event is passed.

The v2 patches are preferable to an earlier proposed patch:
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

 tools/perf/util/parse-events.c | 193 +++++++++++-----
 tools/perf/util/parse-events.h |   3 +
 tools/perf/util/parse-events.y | 388 ++++++++++++++++++++++++---------
 tools/perf/util/pmu.c          |  32 +--
 4 files changed, 449 insertions(+), 167 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

