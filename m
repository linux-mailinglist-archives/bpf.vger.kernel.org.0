Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618859079D
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiHKU6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 16:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiHKU6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 16:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D14B8E9A9;
        Thu, 11 Aug 2022 13:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D91D6137B;
        Thu, 11 Aug 2022 20:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C812FC433C1;
        Thu, 11 Aug 2022 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660251510;
        bh=BeL7COxgF4Rw3pdfVdmP0uTJrvLxti0oHgf0ikfECu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1mkiPp7lJ4btv/yUxJmwj84GbDYm6FYiPrmwPkbquf7ZXQxvMtMGb/yTNFsagmfo
         1PcRn+GPVaVjcTAy11tK4YjbObTrgpuL/ShRQsezSap+va4JCCyPC780FaJyT5njb+
         tqTXwSjuwOEAVshhKqiAMiIlhi0gs3WB735nYflVq+t1EugoIlMAHFrt+66nAW/gM7
         kdbS4JL8Ab/hsyIGW/8Wyh0755t3HwubphX23vf0D0hBshUMiGWxekIw2pYXQamcAD
         exWi6F27cv2ZWcjtrqloSTpxS+KcQOCEfe8jkNRAH9t3KnVAn+TgoRZWsjhFBU0Ptf
         ZH5WZKiT6vUrg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 651A04035A; Thu, 11 Aug 2022 17:58:27 -0300 (-03)
Date:   Thu, 11 Aug 2022 17:58:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Blake Jones <blakejones@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 0/4] Track processes properly for perf record --off-cpu
 (v2)
Message-ID: <YvVtc8qY3/dS0r6J@kernel.org>
References: <20220811185456.194721-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811185456.194721-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Aug 11, 2022 at 11:54:52AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> This patch series implements inheritance of offcpu events for the
> child processes.  Unlike perf events, BPF cannot know which task it
> should track except for ones set in a BPF map at the beginning.  Add
> another BPF program to the fork path and add the process id to the map
> if the parent is tracked.

Thanks for resubmitting, applied!

Will be up in perf/core as soon as tests finish.

- Arnaldo
 
> Changes in v2)
>  * drop already merged fixes
>  * fix the shell test to omit noises
>  
> With this change, it can get the correct off-cpu events for child
> processes.  I've tested it with perf bench sched messaging which
> creates a lot of processes.
> 
>   $ sudo perf record -e dummy --off-cpu -- perf bench sched messaging
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups == 400 processes run
> 
>        Total time: 0.196 [sec]
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.178 MB perf.data (851 samples) ]
> 
> 
>   $ sudo perf report --stat | grep -A1 offcpu
>   offcpu-time stats:
>             SAMPLE events:        851
> 
> The benchmark passes messages by read/write and it creates off-cpu
> events.  With 400 processes, we can see more than 800 events.
> 
> The child process tracking is also enabled when -p option is given.
> But -t option does NOT as it only cares about the specific threads.
> It may be different what perf_event does now, but I think it makes
> more sense.
> 
> You can get it from 'perf/offcpu-child-v2' branch in my tree
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (4):
>   perf offcpu: Check process id for the given workload
>   perf offcpu: Parse process id separately
>   perf offcpu: Track child processes
>   perf offcpu: Update offcpu test for child process
> 
>  tools/perf/tests/shell/record_offcpu.sh | 57 ++++++++++++++++++++++---
>  tools/perf/util/bpf_off_cpu.c           | 53 ++++++++++++++++++++++-
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 38 ++++++++++++++++-
>  3 files changed, 138 insertions(+), 10 deletions(-)
> 
> 
> base-commit: b39c9e1b101d2992de9981673919ae55a088792c
> -- 
> 2.37.1.595.g718a3a8f04-goog

-- 

- Arnaldo
