Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5117C68CB10
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 01:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBGAYO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 19:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGAYN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 19:24:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1304531E13;
        Mon,  6 Feb 2023 16:24:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id be8so13986421plb.7;
        Mon, 06 Feb 2023 16:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2GfCwFBQTq1hrL2JKXUDvrtcTopmGh5P2OuyRAmZh+4=;
        b=jxWU9GFOU8XwBsIFioQNYtJgX4fjvDHF3f90qKRhK95Q/qHoOlnArDv6sOGVUYOxKz
         qnof+8akBLDprLx26h7MGWSoXPE/rM/LSIpRDJs88n9OD91Xn3i2s+FCV9Lue371b5kB
         THonrpCL1hJScpwSN+33zqPmXG+XAro+sM6/9kxgvYjysDaRSivQ50vnTAxfLgm/3Fd3
         nmwiALdctvjKexRvQvY+aor+QuCc65OMNlGUu7Te8Mllhcb/Dprm+BxrZNUkn94DE3RD
         D80W7kcrqjs2QF+i0L5sfyYhKbrFCJNBaMDaBNR08CkA0zhJ4g+wmR4x8L2BBXzBN+pP
         UnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GfCwFBQTq1hrL2JKXUDvrtcTopmGh5P2OuyRAmZh+4=;
        b=l+TyDQ5pteeogZyFQAMs6ubg8vzTRQwRCvG+XoHErx3HNtjQxeWf9U7nSOQHXkyiFS
         U3NQjBrxIIkzhDITjHd3inX4Y4yNzMC+AVJG8Tze5tzSyGcyAovLqBv9+vlt7QnVzDQ6
         7I13OGWuMdFNd6VEyqiW5bDqLzAwQq+99PSOaTlSM0e/kMX5uK8sGOHjfQAe22zyRVD0
         0B3LqTgZ9/DuDz0HoGbxt52OSqqMH5sBflifj2bFY0tb/FoW74HJs2DIkjrJuDyE0knp
         DeI9csxQk1+pETgcAC4i44N2h9UPGDFSMhXZAy8dTc89QvF/m1GtdRzeeNPYa/pFdO5x
         h1cw==
X-Gm-Message-State: AO0yUKVEd3YZRSVz4JrahHLMI/SYTduxhQXuQHnUCB1DpLuZJHp0VEaf
        i5cwqJzfD29O3r/R4sUTs0U=
X-Google-Smtp-Source: AK7set9maURHywP6RmkNNCYUWDn7xGtqnx1e0uW2kL2SF4TpX8BY5hEB9bE6MhcN0bbtAezlPE4OSA==
X-Received: by 2002:a17:902:f0ca:b0:194:5fc9:f55a with SMTP id v10-20020a170902f0ca00b001945fc9f55amr713210pla.35.1675729446422;
        Mon, 06 Feb 2023 16:24:06 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:47cc:64dd:1572:cf18])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709029b8100b00189b2b8dbedsm3544080plp.228.2023.02.06.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 16:24:05 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Subject: [RFC/PATCH 0/3] perf lock contention: Track lock owner (v2)
Date:   Mon,  6 Feb 2023 16:24:00 -0800
Message-Id: <20230207002403.63590-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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

When there're many lock contentions in the system, people sometimes
want to know who caused the contention, IOW who's the owner of the
locks.

This patchset adds -o/--lock-owner option to track the owner info
if it's available.  Right now, it supports mutex and rwsem as they
have the owner fields in themselves.  Please see the patch 2 for the
details.

Changes in v2)
 * fix missing callstacks
 * support old rwsem type with recent clang (>= 15.0)

The patch 1 is a fix for missing callstacks and the patch 2 is the
main change.  The patch 3 adds support for old kernels when compiler
supports a recent builtin to check field type in a struct (Thanks
to Hao).

Example output (for mutex only):

  $ sudo ./perf lock con -abo -Y mutex -- ./perf bench sched pipe
  # Running 'sched/pipe' benchmark:
  # Executed 1000000 pipe operations between two processes

       Total time: 4.910 [sec]

         4.910435 usecs/op
           203647 ops/sec
   contended   total wait     max wait     avg wait          pid   owner

           2     15.50 us      8.29 us      7.75 us      1582852   sched-pipe
           7      7.20 us      2.47 us      1.03 us           -1   Unknown
           1      6.74 us      6.74 us      6.74 us      1582851   sched-pipe

You can get it from 'perf/lock-owner-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (3):
  perf lock contention: Fix to save callstack for the default modified
  perf lock contention: Add -o/--lock-owner option
  perf lock contention: Support old rw_semaphore type

 tools/perf/Documentation/perf-lock.txt        |  5 +
 tools/perf/builtin-lock.c                     | 52 +++++++++--
 tools/perf/util/bpf_lock_contention.c         |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 91 ++++++++++++++++++-
 tools/perf/util/lock-contention.h             |  1 +
 5 files changed, 136 insertions(+), 14 deletions(-)


base-commit: 17f248aa8664ff5b3643491136283e73b5c18166
-- 
2.39.1.519.gcb327c4b5f-goog

