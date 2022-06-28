Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAF55E697
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 18:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbiF1Okj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiF1Oki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 10:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D452A268;
        Tue, 28 Jun 2022 07:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 344A2B81A9D;
        Tue, 28 Jun 2022 14:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4515C3411D;
        Tue, 28 Jun 2022 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656427235;
        bh=SPjXuF7ug4/m0B1q/9Wi9NwaJ+Z+lH+ARwTZHw5gHqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHYUeL/5wForfMIxqXQ8LwzpYmy6yom92ZLlP8BjmA+R3eVGsNcqZDjHkFEUjKGMh
         TCE2j1+1DW4thBIHoiU6WOyRXFP0/ClW+2Q15hxIMbsOQA2zW62rp8ytdKQtDb1HCl
         C4t2MUhXnyBW+rp4ckFOjne2UZHTsvHN9ruYi4fijBxfiw0Q970+uo0CgwUfoCEzXx
         ++hTh0dQJrcFvS5OclZW5SoypVcEBdlrF0licrd/gSMIcLPhdSZlvF8cOhS++sVOI/
         NqfOSPn51q6WXQATW/7MlMAMoRQID3OlSBVhdqNTPzyIBLtsmnuiHo8pUl0Rg7aTcS
         R0vyd11BH4E7Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E8AB4096F; Tue, 28 Jun 2022 11:40:32 -0300 (-03)
Date:   Tue, 28 Jun 2022 11:40:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCHSET 0/6] perf tools: A couple of fixes for perf record
 --off-cpu (v1)
Message-ID: <YrsS4HxNBUk5wtcU@kernel.org>
References: <20220624231313.367909-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624231313.367909-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jun 24, 2022 at 04:13:07PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> The first patch fixes a build error on old kernels which has
> task_struct->state field that is renamed to __state.  Actually I made
> a mistake when I wrote the code and assumed new kernel version.
> 
> The second patch is to prevent invalid sample synthesize by
> disallowing unsupported sample types.

So I'll pick the first two for perf/urgent and then when that is merged
into perf/core pick the rest, ok?

- Arnaldo
 
> The rest of the series implements inheritance of offcpu events for the
> child processes.  Unlike perf events, BPF cannot know which task it
> should track except for ones set in a BPF map at the beginning.  Add
> another BPF program to the fork path and add the process id to the
> map if the parent is tracked.
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
> You can get it from 'perf/offcpu-child-v1' branch in my tree
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (6):
>   perf offcpu: Fix a build failure on old kernels
>   perf offcpu: Accept allowed sample types only
>   perf offcpu: Check process id for the given workload
>   perf offcpu: Parse process id separately
>   perf offcpu: Track child processes
>   perf offcpu: Update offcpu test for child process
> 
>  tools/perf/tests/shell/record_offcpu.sh | 57 ++++++++++++++++++++---
>  tools/perf/util/bpf_off_cpu.c           | 60 +++++++++++++++++++++++--
>  tools/perf/util/bpf_skel/off_cpu.bpf.c  | 58 +++++++++++++++++++++---
>  tools/perf/util/evsel.c                 |  9 ++++
>  tools/perf/util/off_cpu.h               |  9 ++++
>  5 files changed, 176 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog

-- 

- Arnaldo
