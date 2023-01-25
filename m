Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2567BB87
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 20:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjAYT7q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 14:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjAYT7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 14:59:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249C1A1
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 11:59:44 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso4664196pju.0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 11:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EuN8m+yAczoMn49A9EkDcLI7G3YjRkrn5SWf3bO5DY=;
        b=VprZaJpXaTVlHv3jPirmiaZnck/F7VbUT4DFNecb4tFW6mU6TizRTA0pRtHnNdyfYa
         hbg6FCW7pjMLL/tBWu0snZgDYTrdm8+f07+INPjdMrMZI2JBqCIL8oBKs2/xYIJpthGP
         mtkfWDaMsAH8ZyyPqr3chfb5JT3Gdlry3lPe0895YFLmhpJGuq+XobkBshyqGIuBMMZV
         pBD2rg5xmwQodqRA+mUpliMSPhWp7+fr12UkC8sDsjjGWjwCE2kzwXrVdrtJzqgknHxd
         lzb3/huh7CjUTV9DFmFvNABOf8p1IrXsbA5Y3Jk8sknJxwOJkZJgA3bFyGQTmpLRFId4
         AGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EuN8m+yAczoMn49A9EkDcLI7G3YjRkrn5SWf3bO5DY=;
        b=wgmvTkaYfJaOrQq+XAn2VdU7PpzlmZF95lRkcbAl9kn0pXPgfM3G1hj5L91fpmUGod
         f7ETizSA1ygf7ryGTCyxDTjXBhJ7mldYiH9MSfqvYTrNhwSmNO8jm0GuJs4/R7EIVM6Y
         HmmPhVn/R+t7fQxv3z1gMo+u5AfYJ8+vnUUvYvx+aDo8js82PxnOGaU8o0/CQ8J9xl51
         O+ZS9NkwuL5cfN64b4PX/9VfZ6WmayI9Kbsgl2AZw6UpzkYc1Zxz8M9c2Iwwdc7KIeFu
         exzZpm2FIvRN4aWfJU6eTxiq5iZgTr1syZrZdE9zfim21jj75ohouxoJtJlzPApzUQC7
         BC7Q==
X-Gm-Message-State: AFqh2kpcWQio4SheZLP7HwWRE6qZL01XpDqDASN3fg/uSnIeIQJ4SZtk
        76NzX3KpSwv/h2LctsbrFGc07petxz0iLv/Im6s=
X-Google-Smtp-Source: AMrXdXsPSaK6RimRNXYqzRoDElnyFemsPM6WxUsRNP1jIg5Q8Lv7QEpYfymzm0h5bfi4OQUywFvaZvenscqIo5NBBpc=
X-Received: by 2002:a17:90a:9b02:b0:226:2124:ef60 with SMTP id
 f2-20020a17090a9b0200b002262124ef60mr5648037pjp.201.1674676783453; Wed, 25
 Jan 2023 11:59:43 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
 <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
 <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com>
 <CAADnVQLaKyRJwXnU4wZrih4pRduw_eWarA2uNuc=HssKQUAn_Q@mail.gmail.com>
 <CAMy7=ZU7oEa-VJy1_5WM6+poWsVCyZ0Y7ocQLq3qkFcs2-ftBw@mail.gmail.com>
 <CAADnVQKbi6JA4tX=uBHvNrYEUeMa3jmB=FSb=1LufE3597c86A@mail.gmail.com>
 <CAMy7=ZW7tX4ziwJLhGtqQjbdLyJjqTo=Vi=nQ4sDJHASWMCKgQ@mail.gmail.com> <CAADnVQJmpB+bXB_tNXBSVFyG-1KnzKxapLfjUc51_v0-Vho+7w@mail.gmail.com>
In-Reply-To: <CAADnVQJmpB+bXB_tNXBSVFyG-1KnzKxapLfjUc51_v0-Vho+7w@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Wed, 25 Jan 2023 21:59:33 +0200
Message-ID: <CAMy7=ZX+swf7_TzKTHnrMK9d-2PjQK_22vFy_ypBQNsYarqChw@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=D7=
=B3, 25 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-20:52 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
<=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Wed, Jan 25, 2023 at 8:39 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=
=D7=B3, 25 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-2:04 =D7=9E=D7=90=D7=
=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Tue, Jan 24, 2023 at 9:38 AM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=92=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-19:24 =D7=9E=D7=
=90=D7=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > > > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >
> > > > > On Tue, Jan 24, 2023 at 7:47 AM Yaniv Agman <yanivagman@gmail.com=
> wrote:
> > > > > >
> > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=92=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-14:30 =D7=
=9E=D7=90=D7=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > > > > > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=
=80=AC
> > > > > > >
> > > > > > > On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail=
.com> wrote:
> > > > > > > >
> > > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=
=D7=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =
=D7=9E=D7=90=D7=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > > > > > > > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > > > >
> > > > > > > > > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > > > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=
=95=D7=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06=
 =D7=9E=D7=90=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > > > > > > > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=
=80=AC
> > > > > > > > > >>
> > > > > > > > > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > > > > > > > > >> >>> interrupted the first one. But even then, I will n=
eed to find a way to
> > > > > > > > > >> >>> know if my program currently interrupts the run of=
 another program -
> > > > > > > > > >> >>> is there a way to do that?
> > > > > > > > > >> May be a percpu atomic counter to see if the bpf prog =
has been re-entered on the
> > > > > > > > > >> same cpu.
> > > > > > > > > >
> > > > > > > > > > Not sure I understand how this will help. If I want to =
save local
> > > > > > > > > > program data on a percpu map and I see that the counter=
 is bigger then
> > > > > > > > > > zero, should I ignore the event?
> > > > > > > > >
> > > > > > > > > map_update w/ BPF_F_LOCK disables preemption, if you're a=
fter updating
> > > > > > > > > an entry atomically. But it can't be used with PERCPU map=
s today.
> > > > > > > > > Perhaps that's needed now too.
> > > > > > > >
> > > > > > > > Yep. I think what is needed here is the ability to disable =
preemption
> > > > > > > > from the bpf program - maybe even adding a helper for that?
> > > > > > >
> > > > > > > I'm not sure what the issue is here.
> > > > > > > Old preempt_disable() doesn't mean that one bpf program won't=
 ever
> > > > > > > be interrupted by another bpf prog.
> > > > > > > Like networking bpf prog in old preempt_disable can call into=
 something
> > > > > > > where there is a kprobe and another tracing bpf prog will be =
called.
> > > > > > > The same can happen after we switched to migrate_disable.
> > > > > >
> > > > > > One difference here is that in what you describe the programmer=
 can
> > > > > > know in advance which functions might call others and avoid tha=
t or
> > > > > > use other percpu maps, but if preemption can happen between fun=
ctions
> > > > > > which are not related to one another (don't have a relation of =
caller
> > > > > > and callee), then the programmer can't have control over it
> > > > >
> > > > > Could you give a specific example?
> > > >
> > > > Sure. I can give two examples from places where we saw such corrupt=
ion:
> > > >
> > > > 1. We use kprobes to trace some LSM hooks, e.g. security_file_open,
> > > > and a percpu scratch map to prepare the event for submit. When we a=
lso
> > > > added a TRACEPOINT to trace sched_process_free (where we also use t=
his
> > > > scratch percpu map), the security_file_open events got corrupted an=
d
> > > > we didn't know what was happening (was very hard to debug)
> > >
> > > bpf_lsm_file_open is sleepable.
> > > We never did preempt_disable there.
> > > kprobe on security_file_open works, but it's a bit of a hack.
> > > With preempt->migrate
> > > the delayed_put_task_struct->trace_sched_process_free can happen
> > > on the same cpu if prog gets preempted in preemtable kernel, but some=
thing
> > > is fishy here.
> > > Non-sleepable bpf progs always run in rcu cs while
> > > delayed_put_task_struct is call_rcu(),
> > > so if you've used a per-cpu scratch buffer for a duration
> > > of bpf prog (either old preempt_disable or new migrate_disable)
> > > the trace_sched_process_free won't be called until prog is finished.
> > >
> > > If you're using per-cpu scratch buffer to remember the data in one
> > > execution of kprobe-bpf and consuming in the next then all bets are o=
ff.
> > > This is going to break sooner or later.
> > >
> >
> > Yes, I agree this is fishy, but we only use the per-cpu scratch map
> > for the duration of a bpf program, assuming tail-calls are considered
> > to be part of the same program.
> > We've even spotted the place where preemption happens to be right
> > after calling bpf_perf_event_submit() helper by placing bpf_printk in
> > the security_file_open kprobe. Before the call to the helper the
> > buffer was ok, but after it got corrupted (and there were more lines
> > in the program after the call to this helper).
>
> I see. bpf_perf_event_output() may trigger irq_work->arch_irq_work_raise
> which will send an ipi to the current cpu which may resched.
>
> I'm still missing why kprobe in security_file_open has to share
> per-cpu scratch buffer with kprobe in trace_sched_process_free.
> Why not use a scratch buffer per program?
>

Well, since all the documentation I read about eBPF says that BPF
programs are non-preemptible, I assumed it will be ok if we use the
same per-cpu scratch buffer for all programs as long as we use it only
in the scope of the program, but now I understand this assumption (and
documentation) was wrong.

> >
> > > > 2. same was happening when kprobes were combined with cgroup_skb
> > > > programs to trace network events
> > >
> > > irqs can interrupt old preempt_disable, so depending on where kprobe-=
bpf
> > > is it can run while cgroup-bpf hasn't finished.
> > >
> >
> > Actually what we saw here is that the ingress skb program that runs
> > from ksoftirq/idle context corrupts a percpu map shared with a
> > raw_sys_exit tracepoint used to submit execve/openat events.
> >
> > > Then there are differences in kernel configs: no preempt, full preemp=
t,
> > > preempt_rcu and differences in rcu_tasks_trace implementation
> > > over the years. You can only assume that the validity of the pointer
> > > to bpf per-cpu array and bpf per-cpu hash, but no assumption
> > > about concurrent access to the same map if you share the same map
> > > across different programs.
> >
> > I think that is the main point here. Thanks for clarifying this.
> >
> > > See BPF_F_LOCK earlier suggestion. It might be what you need.
> >
> > I am not sure how exactly this can help. The size of the percpu buffer
> > we use is 32kb and we don't use the map_update helper but the pointer
> > returned from the lookup to update the map in several places in the
> > program.
>
> It wasn't clear what you do with the scratch buffer.
> BPF_F_LOCK will help if user space wants to bpf_lookup_elem it without
> a race with bpf prog that would use bpf_spin_lock() to access the element=
.
> Looks like that's not the case you had in mind.
> You just stream these buffers to user space via bpf_perf_event_output().
>

exactly

> Anyway back to preempt_disable(). Think of it as a giant spin_lock
> that covers the whole program. In preemptable kernels it hurts
> tail latency and fairness, and is completely unacceptable in RT.
> That's why we moved to migrate_disable.
> Technically we can add bpf_preempt_disable() kfunc, but if we do that
> we'll be back to square one. The issues with preemptions and RT
> will reappear. So let's figure out a different solution.
> Why not use a scratch buffer per program ?

Totally understand the reason for avoiding preemption disable,
especially in RT kernels.
I believe the answer for why not to use a scratch buffer per program
will simply be memory space.
In our use-case, Tracee [1], we let the user choose whatever events to
trace for a specific workload.
This list of events is very big, and we have many BPF programs
attached to different places of the kernel.
Let's assume that we have 100 events, and for each event we have a
different BPF program.
Then having 32kb per-cpu scratch buffers translates to 3.2MB per one
cpu, and ~100MB per 32 CPUs, which is more common for our case.
Since we always add new events to Tracee, this will also not be scalable.
Yet, if there is no other solution, I believe we will go in that direction

[1] https://github.com/aquasecurity/tracee/blob/main/pkg/ebpf/c/tracee.bpf.=
c
