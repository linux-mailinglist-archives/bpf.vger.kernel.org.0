Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CF7E5374
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfJYSKF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 14:10:05 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48999 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733008AbfJYSIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:38 -0400
Received: by mail-pl1-f201.google.com with SMTP id 40so353461plf.15
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kVRScVzVdmvaFoKwm7QtsLTFIeCMqlMKNHJqjiwIzwM=;
        b=AItMRH1UHy5LoenPDuyGkF1OiRvd0m877S2ToMuZivwha+hreqICwLyqyN9Ru2Y3vi
         deNqYrxmehH1S8leYnGzbZ4xYWQLuSEWdSeDdaeAOKcvVmk7a5CSvPsAdouwQJpw3iCT
         n2cLjvCsPvN6FiMbHKWUfiTAwXkiXJRhLpsaN2OXL26vA2wHypi9uFh/7qkxG3lHwCR2
         /IhupQ0bfr/hjyWVoMWXmmkEEkqPngb16yymwoKxhdzQhAapCGT7NOCnVPusDeGPFTLD
         geiDwPXy31fWFC4WLVMn2vnjZK/DSxYngLBmwARl64D+PXeGTcryng5l2NkuDZ5GUQYG
         ymGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kVRScVzVdmvaFoKwm7QtsLTFIeCMqlMKNHJqjiwIzwM=;
        b=UsrNSGY/+9f/OMrbvin2G84yHRtn0Y/0uv873akFOwmGmilbJUYnbDGJDjNxM3j/gP
         O/p7laNi3uMiqTKsRYqp2Z1b2f7Zx3XBG+3fnzIMmJW3aV29cAi/+RG1jeIQZt6OXMVU
         rvz0mXIV1Pl+Iw7B5MxeyuE9Ah5aB5kPhMwr87deoGk+eLH/N2Qexhx9Tusnu3vI3XZy
         chXZ50WI7okOwzXTI4/VBS29pPqJxr/bokDDv0GdGBVGs5UyTpK9xkYWxEofbByzr9oo
         Yjw3Ck8o06ZonYf1MjgiV2feOf3mHJmOE39boCutbsfOn70hbbfkhkZJ02wKfNJae/Ng
         3AZA==
X-Gm-Message-State: APjAAAX32bTB+20kMyZkOyauVQSSsgQTQJbiM5mEpQiH48/+Rkwx4uTW
        zyQhmyVsa6st7YMs2TijW9NeYXo70/yD
X-Google-Smtp-Source: APXvYqynPqIJ4hVRg5XDUe9xe9kDv4LxessSXAhwz9Vr0geBG3zYf3JlIDqhF3KzgC8ZV8hsDgy+TiNc8doq
X-Received: by 2002:a65:6456:: with SMTP id s22mr5837656pgv.287.1572026915558;
 Fri, 25 Oct 2019 11:08:35 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:08:18 -0700
In-Reply-To: <20191024190202.109403-1-irogers@google.com>
Message-Id: <20191025180827.191916-1-irogers@google.com>
Mime-Version: 1.0
References: <20191024190202.109403-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v4 0/9] Improvements to memory usage by parse events
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

The v4 patches address review comments from Jiri Olsa, turning a long
error message into a single warning, fixing the data type in a list
iterator and reordering patches.

The v3 patches address review comments from Jiri Olsa improving commit
messages, handling ENOMEM errors from strdup better, and removing a
printed warning if an invalid event is passed.

The v2 patches are preferable to an earlier proposed patch:
   perf tools: avoid reading out of scope array

Ian Rogers (9):
  perf tools: add parse events handle error
  perf tools: move ALLOC_LIST into a function
  perf tools: avoid a malloc for array events
  perf tools: splice events onto evlist even on error
  perf tools: ensure config and str in terms are unique
  perf tools: add destructors for parse event terms
  perf tools: before yyabort-ing free components
  perf tools: if pmu configuration fails free terms
  perf tools: add a deep delete for parse event terms

 tools/perf/util/parse-events.c | 177 ++++++++++-----
 tools/perf/util/parse-events.h |   3 +
 tools/perf/util/parse-events.y | 388 ++++++++++++++++++++++++---------
 tools/perf/util/pmu.c          |  32 +--
 4 files changed, 433 insertions(+), 167 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

