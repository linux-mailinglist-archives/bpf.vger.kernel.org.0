Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90EE6B842B
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 22:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCMVqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCMVqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 17:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D365CC25;
        Mon, 13 Mar 2023 14:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25C57B81200;
        Mon, 13 Mar 2023 21:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4BEC433D2;
        Mon, 13 Mar 2023 21:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678743955;
        bh=01Ky8EiYMwVn2GreiPVqNFSfUohDeHiZlfiMQ+PP1Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3ZMpDK5NbupqVlmGKeqgNKszfOJuWmnoPatTttYap7E7HEaCf6DwGi8B08WOOTv1
         hkPThANc/MtITZPVNVmE5hRfK0Uv45q2BiG1HUkUoqtXmElBRzbu+uJm5qbunY0h/M
         U9mW7y0FUgaqzwvc3JJ9sx1W2ZrF4giYMc1ImxBo9ySaI+4rdyg6OrBXiAPe3DbMU5
         zeHD+IIapwMEq8qxeiNUujvchKoAypUk9l0WgtkjtniU171CBXuNhksZayv4dJU8vf
         JHvqtRXFRTRvukTOT4YOrfnwr6z5bcztwePDDem0TZ2Pz2jc5QvwTu8Fmd/2MxZ2aW
         1lo+CTY98wrsw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19FC64049F; Mon, 13 Mar 2023 18:45:53 -0300 (-03)
Date:   Mon, 13 Mar 2023 18:45:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] perf lock contention: Improve lock symbol display
 (v1)
Message-ID: <ZA+ZkRYADwtFEsPt@kernel.org>
References: <20230313204825.2665483-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313204825.2665483-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 13, 2023 at 01:48:21PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This patchset improves the symbolization of locks for -l/--lock-addr mode.
> As of now it only shows global lock symbols present in the kallsyms.  But
> we can add some more lock symbols by traversing pointers in the BPF program.
> 
> For example, mmap_lock can be reached from the mm_struct of the current task
> (task_struct->mm->mmap_lock) and we can compare the address of the give lock
> with it.  Similarly I've added 'siglock' for current->sighand->siglock.
> 
> On the other hand, we can traverse some of semi-global locks like per-cpu,
> per-device, per-filesystem and so on.  I've added 'rqlock' for each cpu's
> runqueue lock.
> 
> It cannot cover all types of locks in the system but it'd be fairly usefule
> if we can add many of often contended locks.  I tried to add futex locks
> but it failed to find the __futex_data symbol from BTF.  I'm not sure why but
> I guess it's because the struct doesn't have a tag name.
> 
> Those locks are added just because they got caught during my test.
> It'd be nice if you suggest which locks to add and how to do that. :)
> I'm thinking if there's a way to track file-based locks (like epoll, etc).
> 
> Finally I also added a lock type name after the symbols (if any) so that we
> can get some idea even though it has no symbol.  The example output looks
> like below:
> 
>   $ sudo ./perf lock con -abl -- sleep 1
>    contended   total wait     max wait     avg wait            address   symbol
> 
>           44      6.13 ms    284.49 us    139.28 us   ffffffff92e06080   tasklist_lock (rwlock)
>          159    983.38 us     12.38 us      6.18 us   ffff8cc717c90000   siglock (spinlock)
>           10    679.90 us    153.35 us     67.99 us   ffff8cdc2872aaf8   mmap_lock (rwsem)
>            9    558.11 us    180.67 us     62.01 us   ffff8cd647914038   mmap_lock (rwsem)
>           78    228.56 us      7.82 us      2.93 us   ffff8cc700061c00    (spinlock)
>            5     41.60 us     16.93 us      8.32 us   ffffd853acb41468    (spinlock)
>           10     37.24 us      5.87 us      3.72 us   ffff8cd560b5c200   siglock (spinlock)
>            4     11.17 us      3.97 us      2.79 us   ffff8d053ddf0c80   rq_lock (spinlock)
>            1      7.86 us      7.86 us      7.86 us   ffff8cd64791404c    (spinlock)
>            1      4.13 us      4.13 us      4.13 us   ffff8d053d930c80   rq_lock (spinlock)
>            7      3.98 us      1.67 us       568 ns   ffff8ccb92479440    (mutex)
>            2      2.62 us      2.33 us      1.31 us   ffff8cc702e6ede0    (rwlock)
> 
> The tasklist_lock is global so it's from the kallsyms.  But others like
> siglock, mmap_lock and rq_lock are from the BPF.

Beautiful :-)

And the csets are _so_ small and demonstrate techniques that should be
used in more and more tools.

Applied, testing.

- Arnaldo
 
> You get get the code at 'perf/lock-symbol-v1' branch in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (4):
>   perf lock contention: Track and show mmap_lock with address
>   perf lock contention: Track and show siglock with address
>   perf lock contention: Show per-cpu rq_lock with address
>   perf lock contention: Show lock type with address
> 
>  tools/perf/builtin-lock.c                     | 46 +++++++----
>  tools/perf/util/bpf_lock_contention.c         | 35 ++++++++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  | 77 +++++++++++++++++++
>  tools/perf/util/bpf_skel/lock_data.h          | 14 ++++
>  4 files changed, 152 insertions(+), 20 deletions(-)
> 
> 
> base-commit: b8fa3e3833c14151a47ebebbc5427dcfe94bb407
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
