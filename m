Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1545566B9A
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiGEMJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 08:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiGEMIk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 08:08:40 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149F18E31;
        Tue,  5 Jul 2022 05:08:02 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o8hLV-000Fmu-2A; Tue, 05 Jul 2022 14:08:01 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1o8hLU-0005EE-Ob; Tue, 05 Jul 2022 14:08:00 +0200
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Add benchmark for
 local_storage RCU Tasks Trace usage
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     rcu@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        Kernel Team <kernel-team@fb.com>
References: <20220705024555.2729240-1-davemarchevsky@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7c32070-fc4f-a62a-bdc7-a723da5cd5ce@iogearbox.net>
Date:   Tue, 5 Jul 2022 14:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220705024555.2729240-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26594/Tue Jul  5 09:24:14 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/5/22 4:45 AM, Dave Marchevsky wrote:
> This benchmark measures grace period latency and kthread cpu usage of
> RCU Tasks Trace when many processes are creating/deleting BPF
> local_storage. Intent here is to quantify improvement on these metrics
> after Paul's recent RCU Tasks patches [0].
> 
> Specifically, fork 15k tasks which call a bpf prog that creates/destroys
> task local_storage and sleep in a loop, resulting in many
> call_rcu_tasks_trace calls.
> 
> To determine grace period latency, trace time elapsed between
> rcu_tasks_trace_pregp_step and rcu_tasks_trace_postgp; for cpu usage
> look at rcu_task_trace_kthread's stime in /proc/PID/stat.
> 
> On my virtualized test environment (Skylake, 8 cpus) benchmark results
> demonstrate significant improvement:
> 
> BEFORE Paul's patches:
> 
>    SUMMARY tasks_trace grace period latency        avg 22298.551 us stddev 1302.165 us
>    SUMMARY ticks per tasks_trace grace period      avg 2.291 stddev 0.324
> 
> AFTER Paul's patches:
> 
>    SUMMARY tasks_trace grace period latency        avg 16969.197 us  stddev 2525.053 us
>    SUMMARY ticks per tasks_trace grace period      avg 1.146 stddev 0.178
> 
> Note that since these patches are not in bpf-next benchmarking was done
> by cherry-picking this patch onto rcu tree.
> 
>    [0]: https://lore.kernel.org/rcu/20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1/
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Looks like this still fails BPF CI on the gcc runners:

https://github.com/kernel-patches/bpf/runs/7194224073?check_suite_focus=true
https://github.com/kernel-patches/bpf/runs/7194224318?check_suite_focus=true

   [...]
   benchs/bench_local_storage_rcu_tasks_trace.c: In function 'kthread_pid_ticks':
   benchs/bench_local_storage_rcu_tasks_trace.c:115:2: error: ignoring return value of 'fscanf', declared with attribute warn_unused_result [-Werror=unused-result]
     115 |  fscanf(f, "%*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %ld", &stime);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make: *** [Makefile:566: /home/actions-runner/_work/bpf/bpf/tools/testing/selftests/bpf/bench_local_storage_rcu_tasks_trace.o] Error 1
   make: *** Waiting for unfinished jobs....
   Error: Process completed with exit code 2.

Thanks,
Daniel
