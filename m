Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52A365CD47
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 07:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjADGoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 01:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjADGoI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 01:44:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22A62E5;
        Tue,  3 Jan 2023 22:44:06 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 7so21635684pga.1;
        Tue, 03 Jan 2023 22:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BvYzXAL/OlbKW9D/wg8hZHsAC+MKri2nzRM9M3nCnfw=;
        b=VL/fZbA6t/GuJl1DROc4Q7erRbG8ljlGFm3MYSZroHsARxDV4ES1aGPnfkDUBlaWgm
         VxtSzASxNXkYZkyeH6JJk7cr6egf0qSLP2FHXN7++JE9M6SMHMtg9MT9pO0cOIjnPCC9
         YJ0mcYujWew9RDk1VH9zkE3VTmn+iUuYbkGaXPcb8r63I3IRpzJdZtOkmFYRM+cajuwH
         SQ05zAb4bm6/6Yk0VoZdIgoCaaPV6KtemTe8NAwcIyuC0Pi6bvt96kur2oMIxonte4i/
         o+pPSawng+oGruQqSiIukrGJF4q/S3qJMH0KSLvfoFIMXvmtUv9rmsFKzUJAebm0R8Ku
         TfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvYzXAL/OlbKW9D/wg8hZHsAC+MKri2nzRM9M3nCnfw=;
        b=dIxYKbKZaiqyoJq/+gFFdwn7fgWIi7D+KAm5zlkwQwEoql9JMZsSIdI4USSDTTbOJH
         Wdj1HvmVmH7N0pRyzeJ5TL01Bn5+DH9fujNLYq5ViWtiK0w2QU2Vpg3kR4QdX8QTlOS0
         mFV6TDZJXymo0ywQDtYfPBv03KVEu+KJSQaQnuCZxzgxTqWgwKjeU3GDmDlnemXJo4Vz
         dUfvHyU3DQmBRfotU2ozbLLM0mHnwtvj1i83XdhvBzVHLhCrze4oBAary0JrKIdFC9J4
         rujswNjp2hdc36LoHnlFgFCk5eynjeYwNQ+++sJ1VzJb7LtFfQGbHqyCs2f/ZNK2F6Wi
         OK9w==
X-Gm-Message-State: AFqh2kp82PQ/Cz6zvkURIZMlPll8yk/oFFTMGHR26ZOoPyYWhezyFky0
        /uN2ZyMwbcAan+6Hl4NVOp9UZvgLkhJi1A==
X-Google-Smtp-Source: AMrXdXtHjIsd7F/CDve4QRLOpi0yINQhobFMRqn5Qstw4aIThCiNLCA0qj9ikvS8jdJ50GyvwBJjQg==
X-Received: by 2002:a62:1614:0:b0:580:dd4d:43bc with SMTP id 20-20020a621614000000b00580dd4d43bcmr37428806pfw.26.1672814646060;
        Tue, 03 Jan 2023 22:44:06 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:d1f4:a47f:3a41:e1a2])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b00576f7bd92cdsm11829257pfj.14.2023.01.03.22.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:44:05 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 0/4] perf bpf_counter: A set of random fixes (v1)
Date:   Tue,  3 Jan 2023 22:43:58 -0800
Message-Id: <20230104064402.1551516-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

This is a collection of small fixes for perf stat bpf counters (bperf).

The bperf framework maintains perf_attr_map in the BPF fs to share the
same event as much as possible.  But the size was limited to 16 and
perf stat with -ddd option would create more than 16 events and fails.

Also cgroup events with --for-each-cgroup had some other problems when
dealing with unsupported events and duplicate cgroups.

The code is available at 'perf/stat-bpf-fix-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (4):
  perf bpf_counter: Add more error messages for bperf
  perf bpf_counter: Increase perf_attr_map entries to 32
  perf bpf_counter: Handle unsupported cgroup events
  perf stat: Do not use the same cgroup more than once

 tools/perf/util/bpf_counter.c        | 11 ++++++++---
 tools/perf/util/bpf_counter_cgroup.c | 14 +++-----------
 tools/perf/util/cgroup.c             | 23 ++++++++++++++++++-----
 3 files changed, 29 insertions(+), 19 deletions(-)


base-commit: d8d85ce86dc82de4f88b821a78f533b9d5b22a45
-- 
2.39.0.314.g84b9a713c41-goog

