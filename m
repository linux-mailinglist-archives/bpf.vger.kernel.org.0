Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383555A4AA
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 01:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiFXXNS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 19:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXXNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 19:13:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A468012;
        Fri, 24 Jun 2022 16:13:16 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 68so3681189pgb.10;
        Fri, 24 Jun 2022 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97W1aGnfJTsRH0sQeB3uyZG1FdhNBzAYORArQFFa5J8=;
        b=WaQTACkscwQ+r10TsXLL2IDdBXO78KeBOqyPH1sEf7nHOfk/88AkzO/GRuWjF8cOvl
         pTH2J7EM5+tcc/pM49YYi12tc9NsS3F+QVdPYtsF05j+fs9mW3Lu9BU6KLS+Ln+snonm
         CQocnuVS6GgqZeivqXaouar2yFPS3ljolbxXEBV7DM2rqYg7mjOKYaRvsjZmNLFdMZKj
         15jGbtn9phJS2OEikiiRPvLTd0H6zJcgsu5armedsY8pQhB7kLBENwsmkblXjD5m1chL
         4DGKiqSV4Q1owDTwxj33HiY9FWQ0c8bzgzOGJ2410tnkODzTtLhY1QKxAMqOIpU4nMNs
         vEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=97W1aGnfJTsRH0sQeB3uyZG1FdhNBzAYORArQFFa5J8=;
        b=FP/brQVtddT5shmYM78NAH4t7+KcxnIp1k7K6SqqGIsMJ/a1LKnHhzTMZS+B7/zH5T
         2bNUmSI8Tfitg0Y5tIq3HUIf/DAo4VgRhOhv37UIePy2Yos3cEZ8rf2Dkx8GiOtNvgX7
         R5uQVgt+SawQeWslCVrgWQoflETYFbjljEYlNo/sWcbrpKDs/9+GeI1lM5TAk3KqLUSN
         4YLUgFx0Liey4/Fuxl1ZzpdmXwy07AKXRl9ywlZx2JDiNp5YPP+xpq1WkWPmbJoxpveg
         Hts5zpU7YD5PklDtRant3cSdPBGCP3XRbuR0mvprIPtYhSau3vIykOv0dLn+FRUYnj2S
         zSZQ==
X-Gm-Message-State: AJIora+Rhq56Ckycv9bSxUZHTUce2m3YSOx9XGateW4tkR0e46E9nALo
        ZMXNnysfQRXSisiO84zzcYQ=
X-Google-Smtp-Source: AGRyM1tRHHjEWu+SxmsXdStgAmXUbMstdEJ81AIJqaNRIFgHwUDeylo9SumsU2ECSZWng7xqzcvskw==
X-Received: by 2002:a05:6a00:d9b:b0:525:6b81:4f14 with SMTP id bf27-20020a056a000d9b00b005256b814f14mr1554852pfb.38.1656112395401;
        Fri, 24 Jun 2022 16:13:15 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:eeb0:3156:8fd:28f6])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b0050dc76281e0sm2242439pfe.186.2022.06.24.16.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:13:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCHSET 0/6] perf tools: A couple of fixes for perf record --off-cpu (v1)
Date:   Fri, 24 Jun 2022 16:13:07 -0700
Message-Id: <20220624231313.367909-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

The first patch fixes a build error on old kernels which has
task_struct->state field that is renamed to __state.  Actually I made
a mistake when I wrote the code and assumed new kernel version.

The second patch is to prevent invalid sample synthesize by
disallowing unsupported sample types.

The rest of the series implements inheritance of offcpu events for the
child processes.  Unlike perf events, BPF cannot know which task it
should track except for ones set in a BPF map at the beginning.  Add
another BPF program to the fork path and add the process id to the
map if the parent is tracked.

With this change, it can get the correct off-cpu events for child
processes.  I've tested it with perf bench sched messaging which
creates a lot of processes.

  $ sudo perf record -e dummy --off-cpu -- perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.196 [sec]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.178 MB perf.data (851 samples) ]


  $ sudo perf report --stat | grep -A1 offcpu
  offcpu-time stats:
            SAMPLE events:        851

The benchmark passes messages by read/write and it creates off-cpu
events.  With 400 processes, we can see more than 800 events.

The child process tracking is also enabled when -p option is given.
But -t option does NOT as it only cares about the specific threads.
It may be different what perf_event does now, but I think it makes
more sense.

You can get it from 'perf/offcpu-child-v1' branch in my tree

  https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf offcpu: Fix a build failure on old kernels
  perf offcpu: Accept allowed sample types only
  perf offcpu: Check process id for the given workload
  perf offcpu: Parse process id separately
  perf offcpu: Track child processes
  perf offcpu: Update offcpu test for child process

 tools/perf/tests/shell/record_offcpu.sh | 57 ++++++++++++++++++++---
 tools/perf/util/bpf_off_cpu.c           | 60 +++++++++++++++++++++++--
 tools/perf/util/bpf_skel/off_cpu.bpf.c  | 58 +++++++++++++++++++++---
 tools/perf/util/evsel.c                 |  9 ++++
 tools/perf/util/off_cpu.h               |  9 ++++
 5 files changed, 176 insertions(+), 17 deletions(-)


base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
-- 
2.37.0.rc0.161.g10f37bed90-goog

