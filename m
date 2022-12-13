Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E063D64C097
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiLMX1L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiLMX1K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:27:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE739B01
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h67-20020a25d046000000b00729876d3b2bso8619680ybg.17
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHQZUcHwOCNQCQu4EEiVjneXbxGX4iNgf8b6SmHwn0g=;
        b=r8yHpGdZu5aIN/QCfTXrmNUZMMFwjavoMKQ1kc+qlVCoRP/pV148OkgD3Xqa+/5zy0
         8yZIR/J9/Fpn+9ePpZX9JquD0mxHLTa1e1an62pwgckN01U9oeO0i6QgUez8Yp5Pdn6A
         MEGpDvLHGzvOMpPEqq9xELuZsOTOkrZ0s6ikeQllHLyzGjU+5ty6H6TRteniIQ/HRnFF
         6M5Q0TV7HFDU2IZq+E7t/NFeQDz7KxXCjg6zgNme32v7Pm/ogZ5ls/hIqpfxc+A0aRKW
         TLdtQQHCW77xvdnfXTRJus5I3jgteloTf9YD5fpeDmorgE+RFMyKgUA494xj4CUSjPvZ
         DnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHQZUcHwOCNQCQu4EEiVjneXbxGX4iNgf8b6SmHwn0g=;
        b=HMVfB3LCDekVw+3MOeyHurVtDllhIiVE62FdnSQigUqVxik7lUE+uBLqmawtXmYECv
         Cp+LZ4ZJGtgQfLkTAf6Z3DJJopJiKXsomWhvJrwK0RVbvRXt6xvbRc4BVpRswCQ4p9am
         aS/oDPdXpuGP+VrQj9bvLA4HR89W3s9Ub617VXd0INsTqQmmtOD+dDHMA3K9EcMTA719
         5O4E/LkQSRu/1sgKJEwLnPxrwfL5rO6Fv4/VPj1iOz64z0GozN5CySxCiqZsowRNU9ZZ
         73jSBQHdaE3nidKEYNgET/JJbPtZrh1eA5j1Glr4AyNTw4dcxm4BgqFu4+yBQMO8E1aA
         g/dw==
X-Gm-Message-State: ANoB5pkT/OWnTaMVjIDl+GHF8kWsANK2UF12t09A00Gxan3V+IWD4DYu
        qUoh14tl/gj0wBEB0XTYb+CAdaZ2TpAr
X-Google-Smtp-Source: AA0mqf4QYQ47MdZiguR8J6xMAXoZ/osT9eFVfYeVRdsatT2dNIuZd/nBSaqgA1F5rxc2l32ZN0NQsCV+Dsx7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6268:b448:f7f4:4c2])
 (user=irogers job=sendgmr) by 2002:a25:414f:0:b0:713:a975:c696 with SMTP id
 o76-20020a25414f000000b00713a975c696mr3780948yba.511.1670974027010; Tue, 13
 Dec 2022 15:27:07 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:26:46 -0800
Message-Id: <20221213232651.1269909-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 0/5] build/libtraceevent resends
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

All patches on the acme perf/core branch.

Resend incremental build fix python plugin:
https://lore.kernel.org/lkml/20221205225940.3079667-4-irogers@google.com/

Break apart and resend libtraceevent debug logging support:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/

Switch "#if HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE" to "#if
MAKE_LIBTRACEEVENT_VERSION(1, 5, 0) <= LIBTRACEEVENT_VERSION",
ensuring trace-event.h is included as discussed on the mailing list.

Resend removal of --group option:
https://lore.kernel.org/lkml/20220707195610.303254-1-irogers@google.com/

Ian Rogers (5):
  perf build: Fix python/perf.so library's name
  perf trace-event: Add libtraceevent version tools to header
  libtraceevent: Increase libtraceevent logging when verbose
  perf trace-event: Use version check to avoid 1 define
  perf evlist: Remove group option.

 tools/perf/Documentation/perf-record.txt      |  4 ----
 tools/perf/Documentation/perf-top.txt         |  7 ++----
 tools/perf/Makefile.config                    |  8 +++----
 tools/perf/Makefile.perf                      |  2 +-
 tools/perf/builtin-record.c                   |  2 --
 tools/perf/builtin-stat.c                     |  6 -----
 tools/perf/builtin-top.c                      |  2 --
 tools/perf/builtin-trace.c                    |  2 +-
 tools/perf/tests/attr/README                  |  2 --
 tools/perf/tests/attr/test-record-group       | 22 -------------------
 tools/perf/tests/attr/test-stat-group         | 17 --------------
 tools/perf/util/data-convert-bt.c             |  3 ++-
 tools/perf/util/debug.c                       | 10 +++++++++
 tools/perf/util/evlist.c                      |  2 +-
 tools/perf/util/evlist.h                      |  2 --
 tools/perf/util/evsel.c                       |  2 +-
 tools/perf/util/python.c                      | 10 +--------
 tools/perf/util/record.c                      |  7 ------
 tools/perf/util/record.h                      |  1 -
 .../util/scripting-engines/trace-event-perl.c |  2 +-
 .../scripting-engines/trace-event-python.c    |  2 +-
 tools/perf/util/sort.c                        |  3 ++-
 tools/perf/util/trace-event.h                 | 13 +++++++++++
 23 files changed, 39 insertions(+), 92 deletions(-)
 delete mode 100644 tools/perf/tests/attr/test-record-group
 delete mode 100644 tools/perf/tests/attr/test-stat-group

-- 
2.39.0.314.g84b9a713c41-goog

