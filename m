Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C92305EF
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 10:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgG1I6L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 04:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgG1I5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:36 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE120C0619D2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:36 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s28so14357229pfd.19
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gVIM4kdH9NokKpwghbO519hac6rQk+0+42h/FkNtOmc=;
        b=nVjd2v2r9Q1oUMii1yR5ZajFAwiIRcWUQZazQMb/M7UontU6LQuWm5iwdtO3/n33O3
         Lb/zwJgQ/trsVmsWM8ohNipHPaIrC/bcGltE6QrazEYolwkY9LueMxvJCL7eDHlUuYco
         ZucijjlK3XDHN5p4OFutR+qjpMiOuLpYOafkxRVNDwV1htvZ9XHd+T1m148q4q2dN5rt
         hAISvDZdZavoiVStR4KiWdFYODjwthY7LtG1+Qv/6wchJSBTZ0Mjb7czpWg2y9EcA87g
         qPVL8qlTgMK3qmH1S94tx62jzon1UhmDo3yuxY7QDeINXqv43TYLPZivOivq2SQIflsY
         JBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gVIM4kdH9NokKpwghbO519hac6rQk+0+42h/FkNtOmc=;
        b=OkNqzr61tg/vl/Dws595Y+dZlDSNvpbsQr0n41ITVax+MDpBKj+YyWkaOfuU3zrLJZ
         3VjVQbIhj5GuxEPWmuhZ9KLuJ5APNkIfzgLCdXSgzpC1X1P187FtCU7Lq+6PUXqEoC0P
         wBOuIoxXLPY6E9CC9Km3zdnSoTHX+kAVQFpwaeJ9RJ7bRE/XY5IO1wI5l4aZ7U5NQJxk
         0pTXj+NkzBL3ymk4t4HpuOkLCbiQKKKRqbJFJNyrbGMjPUuh7Vm9W0OLb9scDGff2Hf+
         cW6x42+5HyzEoJRtIZ4+cJt+ACfPyKLl2DURjTYCqAbDps2rFKL8wuh5ZUo0Zv79rpN4
         6ybg==
X-Gm-Message-State: AOAM532GMSOe9xNWYY7gRfIA9x9+k0FcM28AqV7Vo5xSB5jeDRhuhveV
        l79cY+wTpY+SJwWfEuGZj894sgu14mdJ
X-Google-Smtp-Source: ABdhPJwp2u/D21xwmzwq6NAD7G2DvtD23wewLcS0WtXYTfXCdBdhEV3/tkm4JQwe+UMNfMzo/RXIQNFXG/57
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr3465095pjb.214.1595926656213;
 Tue, 28 Jul 2020 01:57:36 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:29 -0700
Message-Id: <20200728085734.609930-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 0/5] Fixes for setting event freq/periods
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
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some fixes that address issues for regular and pfm4 events with 2
additional perf_event_attr tests. Various authors, David Sharp isn't
currently at Google.

v2. corrects the commit message following Athira Rajeev's suggestion.

David Sharp (1):
  perf record: Set PERF_RECORD_PERIOD if attr->freq is set.

Ian Rogers (3):
  perf test: Ensure sample_period is set libpfm4 events
  perf record: Don't clear event's period if set by a term
  perf test: Leader sampling shouldn't clear sample period

Stephane Eranian (1):
  perf record: Prevent override of attr->sample_period for libpfm4
    events

 tools/perf/tests/attr/README                 |  2 ++
 tools/perf/tests/attr/test-record-group2     | 29 ++++++++++++++++++++
 tools/perf/tests/attr/test-record-pfm-period |  9 ++++++
 tools/perf/util/evsel.c                      | 10 +++++--
 tools/perf/util/record.c                     | 28 +++++++++++++------
 5 files changed, 67 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group2
 create mode 100644 tools/perf/tests/attr/test-record-pfm-period

-- 
2.28.0.163.g6104cc2f0b6-goog

