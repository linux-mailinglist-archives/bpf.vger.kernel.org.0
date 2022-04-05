Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81E44F217A
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiDECgG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 22:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDECgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:36:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B8237EAB4
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19A1CB81B00
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 00:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB04CC340F3
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 00:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649117086;
        bh=oXjOq1gK7Yp901jopfGeilhzM0QjUvKiUx2MQVyavq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g1zk8z4kENMFcU8RpRw6LLKT9gzlkG5yoTduRDO4vTaALtnnTD9z7ne8OirHDIniA
         XDxtbsr7k5bMyU044WZN7plt4VoUw15zKtvH5DhOrhBlruLh1lqTU9LfY+L/MXkONq
         gfJeLZ7yARuSGCSZ24AulL8B26ZeTznF7MeD9yMvxM6LraaJSqmXIiRRnudaVDwn2X
         Xi9ZNd+eQL/f5aKbf/2NzXguKQGSYAf8dIfqIL4R4+OOGcMZ8LMVc4jTnSTs3iU0ok
         h5jTTi35Gd+qwMZuw2DnT1NzaXj5VuZqB5OPDg8UXmGXBJDpJfCOUODfjYg8ptcy1I
         DQ0NBwwplmj6g==
Received: by mail-ed1-f48.google.com with SMTP id b24so12966385edu.10
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 17:04:46 -0700 (PDT)
X-Gm-Message-State: AOAM532rs4dZiOKmJg1ZqC18XRV5AXa2vlDvb8c/GsswtGfDrJwrTbsD
        v414Rl4cJ4wIkAT3rKVpeYQAJ4EG+59mpt5fpVEl6A==
X-Google-Smtp-Source: ABdhPJw4ecsR1WcDp5GfJ+5Qx78Y5oC3P/6Rd+mO1TpIt3z+d+NR3xbLnOYUEH+9TySywhPANQkEvyHehMVu9U0rdbs=
X-Received: by 2002:a50:a408:0:b0:41c:cdc7:88bd with SMTP id
 u8-20020a50a408000000b0041ccdc788bdmr694617edb.399.1649117084756; Mon, 04 Apr
 2022 17:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
 <CANn89iJaeBneeqiDBUh_ppEQGne_eyPp-BCVYjEyvoYkUxrDxg@mail.gmail.com>
 <20220331231312.GA4285@paulmck-ThinkPad-P17-Gen-1> <CANn89i+rfrkRrdYAq8Baq04n_ACq+VdB+UcsMoq7U-dB-2hKJA@mail.gmail.com>
 <20220401000642.GB4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iJtfTiSz4v+L3YW+b_gzNoPLz_wuAmXGrNJXqNs9BU9cA@mail.gmail.com>
 <20220401130114.GC4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iLicuKS2wDjY1D5qNT4c-ob=D2n1NnRnm5fGg4LFuW1Kg@mail.gmail.com>
 <20220401152037.GD4285@paulmck-ThinkPad-P17-Gen-1> <20220401152814.GA2841044@paulmck-ThinkPad-P17-Gen-1>
 <20220401154837.GA2842076@paulmck-ThinkPad-P17-Gen-1> <7a90a9b5-df13-6824-32d1-931f19c96cba@quicinc.com>
In-Reply-To: <7a90a9b5-df13-6824-32d1-931f19c96cba@quicinc.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 5 Apr 2022 02:04:34 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4FzbFu5NfdRMParp3Ome=ygVAqQPs2v6UGzRDt2LC6iw@mail.gmail.com>
Message-ID: <CACYkzJ4FzbFu5NfdRMParp3Ome=ygVAqQPs2v6UGzRDt2LC6iw@mail.gmail.com>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     paulmck@kernel.org, Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>, andrii@kernel.org,
        ast@kernel.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 7:45 AM Neeraj Upadhyay <quic_neeraju@quicinc.com> wrote:
>
> Hi,
>
> Trying to understand the issue.
>
> On 4/1/2022 9:18 PM, Paul E. McKenney wrote:
> > On Fri, Apr 01, 2022 at 08:28:14AM -0700, Paul E. McKenney wrote:
> >> [ Adding Andrii and Alexei at Andrii's request. ]
> >>
> >> On Fri, Apr 01, 2022 at 08:20:37AM -0700, Paul E. McKenney wrote:
> >>> On Fri, Apr 01, 2022 at 06:24:13AM -0700, Eric Dumazet wrote:
> >>>> On Fri, Apr 1, 2022 at 6:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>>
> >>>>> On Thu, Mar 31, 2022 at 09:39:02PM -0700, Eric Dumazet wrote:
> >>>>>> On Thu, Mar 31, 2022 at 5:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>>>>
> >>>>>>> On Thu, Mar 31, 2022 at 04:28:04PM -0700, Eric Dumazet wrote:
> >>>>>>>> On Thu, Mar 31, 2022 at 4:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>>>>>>
> >>>>>>>>> The initial setting of ->percpu_enqueue_shift forces all in-range CPU
> >>>>>>>>> IDs to shift down to zero.  The grace-period kthread is allowed to run
> >>>>>>>>> where it likes.  The callback lists are protected by locking, even in
> >>>>>>>>> the case of local access, so this should be safe.
> >>>>>>>>>
> >>>>>>>>> Or am I missing your point?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> In fact I have been looking at this code, because we bisected a
> >>>>>>>> regression back to this patch:
> >>>>>>>>
> >>>>>>>> 4fe192dfbe5ba9780df699d411aa4f25ba24cf61 rcu-tasks: Shorten
> >>>>>>>> per-grace-period sleep for RCU Tasks Trace
> >>>>>>>>
> >>>>>>>> It is very possible the regression comes because the RCU task thread
> >>>>>>>> is using more cpu cycles, from 'CPU 0'  where our system daemons are
> >>>>>>>> pinned.
> >>>>>>>
> >>>>>>> Heh!  I did express that concern when creating that patch, but was
> >>>>>>> assured that the latency was much more important.
> >>>>>>>
> >>>>>>> Yes, that patch most definitely increases CPU utilization during RCU Tasks
> >>>>>>> Trace grace periods.  If you can tolerate longer grace-period latencies,
> >>>>>>> it might be worth toning it down a bit.  The ask was for about twice
> >>>>>>> the latency I achieved in my initial attempt, and I made the mistake of
> >>>>>>> forwarding that attempt out for testing.  They liked the shorter latency
> >>>>>>> very much, and objected strenuously to the thought that I might detune
> >>>>>>> it back to the latency that they originally asked for.  ;-)
> >>>>>>>
> >>>>>>> But I can easily provide the means to detune it through use of a kernel
> >>>>>>> boot parameter or some such, if that would help.
> >>>>>>>
> >>>>>>>> But I could not spot where the RCU task kthread is forced to run on CPU 0.
> >>>>>>>
> >>>>>>> I never did intend this kthread be bound anywhere.  RCU's policy is
> >>>>>>> that any binding of its kthreads is the responsibility of the sysadm,
> >>>>>>> be that carbon-based or otherwise.
> >>>>>>>
> >>>>>>> But this kthread is spawned early enough that only CPU 0 is online,
> >>>>>>> so maybe the question is not "what is binding it to CPU 0?" but rather
> >>>>>>> "why isn't something kicking it off of CPU 0?"
> >>>>>>
> >>>>>> I guess the answer to this question can be found in the following
> >>>>>> piece of code :)
> >>>>>>
> >>>>>> rcu_read_lock();
> >>>>>> for_each_process_thread(g, t)
> >>>>>>          rtp->pertask_func(t, &holdouts);
> >>>>>> rcu_read_unlock();
> >>>>>>
> >>>>>>
> >>>>>> With ~150,000 threads on a 256 cpu host, this holds current cpu for
> >>>>>> very long times:
> >>>>>>
> >>>>>>   rcu_tasks_trace    11 [017]  5010.544762:
> >>>>>> probe:rcu_tasks_wait_gp: (ffffffff963fb4b0)
> >>>>>>   rcu_tasks_trace    11 [017]  5010.600396:
> >>>>>> probe:rcu_tasks_trace_postscan: (ffffffff963fb7c0)
> >>>>>
> >>>>> So about 55 milliseconds for the tasklist scan, correct?  Or am I
> >>>>> losing the plot here?
> >>>>>
> >>>>>>   rcu_tasks_trace    11 [022]  5010.618783:
> >>>>>> probe:check_all_holdout_tasks_trace: (ffffffff963fb850)
> >>>>>>   rcu_tasks_trace    11 [022]  5010.618840:
> >>>>>> probe:rcu_tasks_trace_postgp: (ffffffff963fba70)
> >>>>>>
> >>>>>> In this case, CPU 22 is the victim, not CPU 0 :)
> >>>>>
> >>>>> My faith in the scheduler is restored!  ;-)
> >>>>>
> >>>>> My position has been that this tasklist scan does not need to be broken
> >>>>> up because it should happen only when a sleepable BPF program is removed,
> >>>>> which is a rare event.
> >>>>
> >>>> Hmm... what about  bpf_sk_storage_free() ?
> >>>>
> >>>> Definitely not a rare event.
> >>>
> >>> Hmmm...  Are the BPF guys using call_rcu_tasks_trace() to free things that
> >>> are not trampolines for sleepable BPF programs?  Kind of looks like it.
> >>>
> >>> Maybe RCU Tasks Trace was too convenient to use?  ;-)
> >>>
> >>>>> In addition, breaking up this scan is not trivial, because as far as I
> >>>>> know there is no way to force a given task to stay in the list.  I would
> >>>>> have to instead use something like rcu_lock_break(), and restart the
> >>>>> scan if either of the nailed-down pair of tasks was removed from the list.
> >>>>> In a system where tasks were coming and going very frequently, it might
> >>>>> be that such a broken-up scan would never complete.
> >>>>>
> >>>>> I can imagine tricks where the nailed-down tasks are kept on a list,
> >>>>> and the nailed-downness is moved to the next task when those tasks
> >>>>> are removed.  I can also imagine a less-than-happy response to such
> >>>>> a proposal.
> >>>>>
> >>>>> So I am not currently thinking in terms of breaking up this scan.
> >>>>>
> >>>>> Or is there some trick that I am missing?
> >>>>>
> >>>>> In the meantime, a simple patch that reduces the frequency of the scan
> >>>>> by a factor of two.  But this would not be the scan of the full tasklist,
> >>>>> but rather the frequency of the calls to check_all_holdout_tasks_trace().
> >>>>> And the total of these looks to be less than 20 milliseconds, if I am
> >>>>> correctly interpreting your trace.  And most of that 20 milliseconds
> >>>>> is sleeping.
> >>>>>
> >>>>> Nevertheless, the patch is at the end of this email.
> >>>>>
> >>>>> Other than that, I could imagine batching removal of sleepable BPF
> >>>>> programs and using a single grace period for all of their trampolines.
> >>>>> But are there enough sleepable BPF programs ever installed to make this
> >>>>> a useful approach?
> >>>>>
> >>>>> Or is the status quo in fact acceptable?  (Hey, I can dream, can't I?)
> >>>>>
> >>>>>                                                          Thanx, Paul
> >>>>>
> >>>>>>>> I attempted to backport to our kernel all related patches that were
> >>>>>>>> not yet backported,
> >>>>>>>> and we still see a regression in our tests.
> >>>>>>>
> >>>>>>> The per-grace-period CPU consumption of rcu_tasks_trace was intentionally
> >>>>>>> increased by the above commit, and I never have done anything to reduce
> >>>>>>> that CPU consumption.  In part because you are the first to call my
> >>>>>>> attention to it.
> >>>>>>>
> >>>>>>> Oh, and one other issue that I very recently fixed, that has not
> >>>>>>> yet reached mainline, just in case it matters.  If you are building a
> >>>>>>> CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y kernel, but also have
> >>>>>>> CONFIG_RCU_TORTURE_TEST=m (or, for that matter, =y, but please don't in
> >>>>>>> production!), then your kernel will use RCU Tasks instead of vanilla RCU.
> >>>>>>> (Note well, RCU Tasks, not RCU Tasks Trace, the latter being necessaary
> >>>>>>> for sleepable BPF programs regardless of kernel .config).
> >>>>>>>
> >>>>>>>> Please ignore the sha1 in this current patch series, this is only to
> >>>>>>>> show my current attempt to fix the regression in our tree.
> >>>>>>>>
> >>>>>>>> 450b3244f29b rcu-tasks: Don't remove tasks with pending IPIs from holdout list
> >>>>>>>> 5f88f7e9cc36 rcu-tasks: Create per-CPU callback lists
> >>>>>>>> 1a943d0041dc rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic
> >>>>>>>> queue selection
> >>>>>>>> ea5289f12fce rcu-tasks: Convert grace-period counter to grace-period
> >>>>>>>> sequence number
> >>>>>>>> 22efd5093c3b rcu/segcblist: Prevent useless GP start if no CBs to accelerate
> >>>>>>>> 16dee1b3babf rcu: Implement rcu_segcblist_is_offloaded() config dependent
> >>>>>>>> 8cafaadb6144 rcu: Add callbacks-invoked counters
> >>>>>>>> 323234685765 rcu/tree: Make rcu_do_batch count how many callbacks were executed
> >>>>>>>> f48f3386a1cc rcu/segcblist: Add additional comments to explain smp_mb()
> >>>>>>>> 4408105116de rcu/segcblist: Add counters to segcblist datastructure
> >>>>>>>> 4a0b89a918d6 rcu/tree: segcblist: Remove redundant smp_mb()s
> >>>>>>>> 38c0d18e8740 rcu: Add READ_ONCE() to rcu_do_batch() access to rcu_divisor
> >>>>>>>> 0b5d1031b509 rcu/segcblist: Add debug checks for segment lengths
> >>>>>>>> 8a82886fbf02 rcu_tasks: Convert bespoke callback list to rcu_segcblist structure
> >>>>>>>> cbd452a5c01f rcu-tasks: Use spin_lock_rcu_node() and friends
> >>>>>>>> 073222be51f3 rcu-tasks: Add a ->percpu_enqueue_lim to the rcu_tasks structure
> >>>>>>>> 5af10fb0f8fb rcu-tasks: Abstract checking of callback lists
> >>>>>>>> d3e8be598546 rcu-tasks: Abstract invocations of callbacks
> >>>>>>>> 65784460a392 rcu-tasks: Use workqueues for multiple
> >>>>>>>> rcu_tasks_invoke_cbs() invocations
> >>>>>>>> dd6413e355f1 rcu-tasks: Make rcu_barrier_tasks*() handle multiple
> >>>>>>>> callback queues
> >>>>>>>> 2499cb3c438e rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set
> >>>>>>>> initial queueing
> >>>>>>>> a859f409a503 rcu-tasks: Count trylocks to estimate call_rcu_tasks() contention
> >>>>>>>> 4ab253ca056e rcu-tasks: Avoid raw-spinlocked wakeups from
> >>>>>>>> call_rcu_tasks_generic()
> >>>>>>>> e9a3563fe76e rcu-tasks: Use more callback queues if contention encountered
> >>>>>>>> 4023187fe31d rcu-tasks: Use separate ->percpu_dequeue_lim for callback
> >>>>>>>> dequeueing
> >>>>>>>> 533be3bd47c3 rcu: Provide polling interfaces for Tree RCU grace periods
> >>>>>>>> f7e5a81d7953 rcu-tasks: Use fewer callbacks queues if callback flood ends
> >>>>>>>> bb7ad9078e1b rcu-tasks: Fix computation of CPU-to-list shift counts
> >>>>>>>> d9cebde55539 rcu-tasks: Use order_base_2() instead of ilog2()
> >>>>>>>> 95606f1248f5 rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention
> >>>>>
> >>>>>
> >>>>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> >>>>> index 65d6e21a607a..141e2b4c70cc 100644
> >>>>> --- a/kernel/rcu/tasks.h
> >>>>> +++ b/kernel/rcu/tasks.h
> >>>>> @@ -1640,10 +1640,10 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
> >>>>>                  rcu_tasks_trace.gp_sleep = HZ / 10;
> >>>>>                  rcu_tasks_trace.init_fract = HZ / 10;
> >>>>>          } else {
> >>>>> -               rcu_tasks_trace.gp_sleep = HZ / 200;
> >>>>> +               rcu_tasks_trace.gp_sleep = HZ / 100;
> >>>>>                  if (rcu_tasks_trace.gp_sleep <= 0)
> >>>>>                          rcu_tasks_trace.gp_sleep = 1;
> >>>>> -               rcu_tasks_trace.init_fract = HZ / 200;
> >>>>> +               rcu_tasks_trace.init_fract = HZ / 100;
> >>>>>                  if (rcu_tasks_trace.init_fract <= 0)
> >>>>>                          rcu_tasks_trace.init_fract = 1;
> >>>>>          }
> >>>>
> >>>> It seems that if the scan time is > 50ms in some common cases (at
> >>>> least at Google scale),
> >>>> the claim of having a latency of 10ms is not reasonable.
> >>>
> >>> But does the above patch make things better?  If it does, I will send
> >>> you a proper patch with kernel boot parameters.  We can then discuss
> >>> better autotuning, for example, making the defaults a function of the
> >>> number of CPUs.
> >>>
> >>> Either way, that certainly is a fair point.  Another fair point is that
> >>> the offending commit was in response to a bug report from your colleagues.  ;-)
> >>>
> >>> Except that I don't see any uses of synchronize_rcu_tasks_trace(), so
> >>> I am at a loss as to why latency matters anymore.
> >>>
> >>> Is the issue the overall CPU consumption of the scan (which is my
> >>> current guess) or the length of time that the scan runs without invoking
> >>> cond_resched() or similar?
> >>>
>
> I agree on this part; depending on the results of increasing the sleep
> time for trace kthread to 10 ms; if  scanning all threads is holding the
> CPU, we can try cond_resched(), to isolate the issue. I checked other
> commits in this code path. Don't see anything obvious impacting this.
> However, will check more on this.
>
>
> Thanks
> Neeraj
>
> >>> Either way, how frequently is call_rcu_tasks_trace() being invoked in
> >>> your setup?  If it is being invoked frequently, increasing delays would
> >>> allow multiple call_rcu_tasks_trace() instances to be served by a single
> >>> tasklist scan.
> >>>
> >>>> Given that, I do not think bpf_sk_storage_free() can/should use
> >>>> call_rcu_tasks_trace(),
> >>>> we probably will have to fix this soon (or revert from our kernels)
> >>>
> >>> Well, you are in luck!!!  This commit added call_rcu_tasks_trace() to
> >>> bpf_selem_unlink_storage_nolock(), which is invoked in a loop by
> >>> bpf_sk_storage_free():
> >>>
> >>> 0fe4b381a59e ("bpf: Allow bpf_local_storage to be used by sleepable programs")
> >>>
> >>> This commit was authored by KP Singh, who I am adding on CC.  Or I would
> >>> have, except that you beat me to it.  Good show!!!  ;-)

Hello :)

Martin, if this ends up being an issue we might have to go with the
initial proposed approach
of marking local storage maps explicitly as sleepable so that not all
maps are forced to be
synchronized via trace RCU.

We can make the verifier reject loading programs that try to use
non-sleepable local storage
maps in sleepable programs.

Do you think this is a feasible approach we can take or do you have
other suggestions?

> >>>
> >>> If this commit provoked this issue, then the above patch might help.
> >
> > Another question...  Were there actually any sleepable BPF
> > programs running on this system at that time?  If not, then maybe
> > bpf_selem_unlink_storage_nolock() should check for that condition, and
> > invoke call_rcu_tasks_trace() only if there are actually sleepable BPF
> > programs running (or in the process of being removed.  If I understand
> > correctly (ha!), if there were no sleepable BPF programs running, you
> > would instead want call_rcu().  (Here I am assuming that non-sleepable
> > BPF programs still run within a normal RCU read-side critical section.)
> >
> >                                                       Thanx, Paul
> >
> >>> I am also adding Neeraj Uphadhyay on CC for his thoughts, as he has
> >>> also been throught this code.
> >>>
> >>> My response time may be a bit slow next week, but I will be checking
> >>> email.
> >>>
> >>>                                                     Thanx, Paul
