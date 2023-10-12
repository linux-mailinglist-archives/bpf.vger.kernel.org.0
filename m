Return-Path: <bpf+bounces-11995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E77C656B
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EE01C21024
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA6D302;
	Thu, 12 Oct 2023 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8asiOS7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401865B
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:24:06 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3AA9
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a4f656f751so10140447b3.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091843; x=1697696643; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6QJQ7uhIxdVvam4EsyPr00sicdDNbMv8/7DafmssRJc=;
        b=q8asiOS7fGW7Q4TUpCn/E5BwcBKRPa2Z6TMoj3KMqcOKF6vFp8JaXNKJXZ/JMwomgd
         +mu+2/+7nSDTmnkrOKgb3TUCxPgaxxAovXwqcwrFBHzV3TVcsYWDcxvZfH/lAOlcFVxO
         GRTjE++HeKTs0GQ3xEbQVqClAxiOW4c2qdJPkvd8d35nkQB3iqomyDw2AukUR7H9VOvB
         su6QVB3cEkRaF4I/YPe3r68mjugQh08jtxH1BM7/o4dIC0uYIz5kzp8uJga3jafQzlBQ
         u16c+Ze2GhPMVIaqNW44W4/IjamLX/8ZfeeQgHiSorjWm4Qie7veIT8mr+Nf057wCtuM
         LoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091843; x=1697696643;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QJQ7uhIxdVvam4EsyPr00sicdDNbMv8/7DafmssRJc=;
        b=WHMnyIbPMY1Dpfyrru3Q1POSxCzaa5XSh/y6bXiD8RPNmo1yKm1Dkir61b3pwVztsR
         jjHc7O3QjEDWUf3DViV2VEaoX9dyBwPgtg60/wpoxCXgdF2gk3haWWTHY04VcElqeV+0
         JJFl5yABp6MB4WiQ2IiV2tpPrjA2W1QRR9scDYr9WFb3gNz35prRD2ioRogv8qtsVt4Z
         VZ007yMS4m9TP/3012A0wDpgNUnW9OnF4ZMKushUSsdofLK1OP8MkIFxZUsiXIp3jHGJ
         CRXLagrIJpcPocfyRgrpuLpBRVjvloQQFJ34e3qojDXbcjS6YB4uHgXmFuX+dropcjT3
         iL+g==
X-Gm-Message-State: AOJu0Yw6StR8ajuZgegxg82RgDfkLXsTe2SC5FyVDmfRdxAmu2bnxdXd
	oLJPe72RZGI6jHOXzRBsMyEAMABgJZac
X-Google-Smtp-Source: AGHT+IE9+bGU2dJLV4W9drtMJyLl57j1AoK17XLAh2MK1ViWE0qAcDAFExgoSJrPBgJDJHq6P7kediUOKvSZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a81:a84a:0:b0:59b:e97e:f7df with SMTP id
 f71-20020a81a84a000000b0059be97ef7dfmr417701ywh.2.1697091843534; Wed, 11 Oct
 2023 23:24:03 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:46 -0700
Message-Id: <20231012062359.1616786-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 00/13] Improvements to memory use
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix memory leaks detected by address/leak sanitizer affecting LBR
call-graphs, perf mem and BPF offcpu.

Make branch_type_stat in callchain_list optional as it is large and
not always necessary - in particular it isn't used by perf top.

Make the allocations of zstd streams, kernel symbols and event copies
lazier in order to save memory in cases like perf record.

Handle the thread exit event and have it remove the thread from the
threads set in machine. Don't do this for perf report as it causes a
regression for task lists, which assume threads are never removed from
the machine's set, and offcpu events, that may sythensize samples for
threads that have exited.

The overall effect is to reduce memory consumption significantly for
perf top - with call graphs enabled running longer before 1GB of
memory is consumed. For a perf record of 'true', the memory
consumption goes from 39912kb max resident to 20820kb max resident -
nearly halved.

v2: Add additional memory fixes on top of initial LBR and rc check
    fixes.

Ian Rogers (13):
  perf machine: Avoid out of bounds LBR memory read
  libperf rc_check: Make implicit enabling work for GCC
  perf hist: Add missing puts to hist__account_cycles
  perf threads: Remove unused dead thread list
  perf offcpu: Add missed btf_free
  perf callchain: Make display use of branch_type_stat const
  perf callchain: Make brtype_stat in callchain_list optional
  perf callchain: Minor layout changes to callchain_list
  perf mem_info: Add and use map_symbol__exit and addr_map_symbol__exit
  perf record: Lazy load kernel symbols
  libperf: Lazily allocate mmap event copy
  perf mmap: Lazily initialize zstd streams
  perf machine thread: Remove exited threads by default

 tools/lib/perf/include/internal/mmap.h     |  2 +-
 tools/lib/perf/include/internal/rc_check.h |  6 ++-
 tools/lib/perf/mmap.c                      |  9 ++++
 tools/perf/builtin-inject.c                |  4 ++
 tools/perf/builtin-record.c                |  2 +
 tools/perf/builtin-report.c                |  7 +++
 tools/perf/util/Build                      |  1 +
 tools/perf/util/bpf_off_cpu.c              | 10 ++--
 tools/perf/util/branch.c                   |  4 +-
 tools/perf/util/branch.h                   |  4 +-
 tools/perf/util/callchain.c                | 62 ++++++++++++++--------
 tools/perf/util/callchain.h                | 18 +++----
 tools/perf/util/compress.h                 |  1 +
 tools/perf/util/event.c                    |  4 +-
 tools/perf/util/hist.c                     | 16 +++---
 tools/perf/util/machine.c                  | 39 +++++++-------
 tools/perf/util/machine.h                  |  1 -
 tools/perf/util/map_symbol.c               | 15 ++++++
 tools/perf/util/map_symbol.h               |  4 ++
 tools/perf/util/mmap.c                     |  5 +-
 tools/perf/util/mmap.h                     |  1 -
 tools/perf/util/symbol.c                   |  5 +-
 tools/perf/util/symbol_conf.h              |  4 +-
 tools/perf/util/thread.h                   | 14 +++++
 tools/perf/util/zstd.c                     | 61 +++++++++++----------
 25 files changed, 196 insertions(+), 103 deletions(-)
 create mode 100644 tools/perf/util/map_symbol.c

-- 
2.42.0.609.gbb76f46606-goog


