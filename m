Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7A6B830D
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjCMUsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMUsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 16:48:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE596187;
        Mon, 13 Mar 2023 13:48:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d13so3249509pjh.0;
        Mon, 13 Mar 2023 13:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678740508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jDEZYmHN4oYDSx2bm7gTBW0Ghq4BZOGxx8ZHt3XAI/o=;
        b=P9rpsY3z0Yho+b2Ayeq30KO//EWYdfmC+d+MFlJJrLYrZGrNYmBhAHc9HfGLjTc6KE
         dNft0C37pRNAGMs2LeZj+TR68Wv11aa+qYm//pqNqtrFHrspk2jn35N3TJekEpVzkPhI
         VFPbhuVjcR2PP0jZ5d3l+JARTuXiLbuUTfUWvEch8KMbkeChb8OQIOikHvP3JmPPwIr1
         mZl+oP+arxVtk7sGc9S//CdwFX21cJp6A6QJmmdBBX9Qcy/FczlllivZbhduScIT3Wyc
         s0HANYHLV/O//d4wcUPiOtvc2lObsEhAqsPlnvKJilYuYIIiwv3EU2ILBRsyPnbiOCwj
         19zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDEZYmHN4oYDSx2bm7gTBW0Ghq4BZOGxx8ZHt3XAI/o=;
        b=0FW5FJ+aEmHMQkn8h4RQtOjWp4PlfT7OMOWk2HtYxJfSIqU3DAn6yOqNZ3KtSqRgZ/
         /zSIeo+xXoRDudvGUmsXZfm4OEt6GMvCi4u4KbspWi845Qg+vo9iiKuwBV53to24q/G+
         eZDRVg4y3GNpqY9Y1rlYfLkyAFYjS1s2Cu6RmJFI709VHKVB3aBHDSkyByqXe2ioW0s9
         jygiVR4O9imSH3cCPF7PteLJ6WjprQvT9UEzoqgutF5taeqEd8BUa7Trk9LNLYiEFbNp
         5L52By2npgMrI7VRVnoWCbO4sFUaLwwY9r2XKGL8UV6ArgTYjl/HYbHuPukRqBhPEhQC
         wcOQ==
X-Gm-Message-State: AO0yUKX5us45sTWIRQZ4ELhK8K2MrpqbKuPQlQ+MQWYzg1MSJMdVuYuQ
        yHjdyyJhqti4bIN0hUpeAtG47jLQals=
X-Google-Smtp-Source: AK7set+eZTGOSQU/TIFJrqcYefQ59t1I1yBfbgcvTf6+HtklhjhcAGYlmKjpom/7MxbhaZ9QvpcQGA==
X-Received: by 2002:a17:90b:38c3:b0:234:159:4003 with SMTP id nn3-20020a17090b38c300b0023401594003mr35629915pjb.25.1678740508233;
        Mon, 13 Mar 2023 13:48:28 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:26de:6cd7:2c4f:96d5])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0023af8a3cf6esm265026pjr.48.2023.03.13.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:48:27 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 0/4] perf lock contention: Improve lock symbol display (v1)
Date:   Mon, 13 Mar 2023 13:48:21 -0700
Message-Id: <20230313204825.2665483-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

This patchset improves the symbolization of locks for -l/--lock-addr mode.
As of now it only shows global lock symbols present in the kallsyms.  But
we can add some more lock symbols by traversing pointers in the BPF program.

For example, mmap_lock can be reached from the mm_struct of the current task
(task_struct->mm->mmap_lock) and we can compare the address of the give lock
with it.  Similarly I've added 'siglock' for current->sighand->siglock.

On the other hand, we can traverse some of semi-global locks like per-cpu,
per-device, per-filesystem and so on.  I've added 'rqlock' for each cpu's
runqueue lock.

It cannot cover all types of locks in the system but it'd be fairly usefule
if we can add many of often contended locks.  I tried to add futex locks
but it failed to find the __futex_data symbol from BTF.  I'm not sure why but
I guess it's because the struct doesn't have a tag name.

Those locks are added just because they got caught during my test.
It'd be nice if you suggest which locks to add and how to do that. :)
I'm thinking if there's a way to track file-based locks (like epoll, etc).

Finally I also added a lock type name after the symbols (if any) so that we
can get some idea even though it has no symbol.  The example output looks
like below:

  $ sudo ./perf lock con -abl -- sleep 1
   contended   total wait     max wait     avg wait            address   symbol

          44      6.13 ms    284.49 us    139.28 us   ffffffff92e06080   tasklist_lock (rwlock)
         159    983.38 us     12.38 us      6.18 us   ffff8cc717c90000   siglock (spinlock)
          10    679.90 us    153.35 us     67.99 us   ffff8cdc2872aaf8   mmap_lock (rwsem)
           9    558.11 us    180.67 us     62.01 us   ffff8cd647914038   mmap_lock (rwsem)
          78    228.56 us      7.82 us      2.93 us   ffff8cc700061c00    (spinlock)
           5     41.60 us     16.93 us      8.32 us   ffffd853acb41468    (spinlock)
          10     37.24 us      5.87 us      3.72 us   ffff8cd560b5c200   siglock (spinlock)
           4     11.17 us      3.97 us      2.79 us   ffff8d053ddf0c80   rq_lock (spinlock)
           1      7.86 us      7.86 us      7.86 us   ffff8cd64791404c    (spinlock)
           1      4.13 us      4.13 us      4.13 us   ffff8d053d930c80   rq_lock (spinlock)
           7      3.98 us      1.67 us       568 ns   ffff8ccb92479440    (mutex)
           2      2.62 us      2.33 us      1.31 us   ffff8cc702e6ede0    (rwlock)

The tasklist_lock is global so it's from the kallsyms.  But others like
siglock, mmap_lock and rq_lock are from the BPF.

You get get the code at 'perf/lock-symbol-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (4):
  perf lock contention: Track and show mmap_lock with address
  perf lock contention: Track and show siglock with address
  perf lock contention: Show per-cpu rq_lock with address
  perf lock contention: Show lock type with address

 tools/perf/builtin-lock.c                     | 46 +++++++----
 tools/perf/util/bpf_lock_contention.c         | 35 ++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 77 +++++++++++++++++++
 tools/perf/util/bpf_skel/lock_data.h          | 14 ++++
 4 files changed, 152 insertions(+), 20 deletions(-)


base-commit: b8fa3e3833c14151a47ebebbc5427dcfe94bb407
-- 
2.40.0.rc1.284.g88254d51c5-goog

