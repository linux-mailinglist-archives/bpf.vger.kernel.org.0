Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C067B9EC
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjAYSxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjAYSxA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:53:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15A27988
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:52:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id kt14so50265818ejc.3
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NLDns1B0HxrXP9xiG1pVCoEuXgRs9hyQrkWL8IQ9vc=;
        b=KGJ2e3W+d/gofjsesGAcKJNSXPE4giGMzmTLehgziuGO8A7+tezdRq2cm5Oib3oB1a
         I1Wzgjt3HveQheFWYbYnUr2bAdfoOIyz0gFonf/pUlmp0qwrANBMH8MQkXSzNDYeagPD
         Wx0HwvoMzEg9gdtlLkY4du/kz6PXNW5OoJlc/0KoYW9wUYchyAfXDnabSbIELw69cg9k
         CSTAWakir/cQIi4qqNyHeyoBSEBN90w0dHGvaU6qm5VA4+rFVS9sU41kUIM7/3Dy3wK6
         mqI5S4tvpZy8+kbAyOStIsLS677EutFXyFmzdslIHD47WtGjqisPj+eqM/6UHRPHwvxn
         9Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NLDns1B0HxrXP9xiG1pVCoEuXgRs9hyQrkWL8IQ9vc=;
        b=Exg97C5rbIAIVhq/fX3fngNBUdIzLzb0Opu/FWaD21/nAstMmkE2CHsMz9d7W7L4Kh
         mL/O96sigpxJU8yZF0hd+EGaphRjQ+winRU0vcCXX7fANPqTJOkZ7dtkK35Sx7jCAS88
         qiPvgwKm/bU6IwYPjSwtDOYm5N3NWS/AoRfMI6/HDUeWYlJf5lbn1QwJuQM2K/MJm50i
         ej4/6dKoaFN0vR5MILoZQvbLML8GkJVesQGC6CmOcIbSBLeu1pcomKsSMHVHaYIzml5Y
         w/Hs2cmnLKlPDRCezUu23nTCNBhzgI7Mk2lOl9H6t5BlCuy876Q7pHfhdM4yQUIyLZ9L
         6WHA==
X-Gm-Message-State: AFqh2koeIDaJ1G5dGKQeMTXh6Q92YGnZUSMOnjpM0AFLgG+0748du3NN
        OrEFrV0BLwhTH+8gBTTPn3OFo3qCzxtYxP0vOoQ=
X-Google-Smtp-Source: AMrXdXvmEu8u5OBjNU2UoUxAmY+sJ4Igs0vhKQRpQpAjY3z60SqroI7BybHH0/yMi49u8hCBel9wt9Lwnu5hSnLIRLk=
X-Received: by 2002:a17:906:5a94:b0:84d:3b9a:e2b3 with SMTP id
 l20-20020a1709065a9400b0084d3b9ae2b3mr3105633ejq.318.1674672774709; Wed, 25
 Jan 2023 10:52:54 -0800 (PST)
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
 <CAADnVQKbi6JA4tX=uBHvNrYEUeMa3jmB=FSb=1LufE3597c86A@mail.gmail.com> <CAMy7=ZW7tX4ziwJLhGtqQjbdLyJjqTo=Vi=nQ4sDJHASWMCKgQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZW7tX4ziwJLhGtqQjbdLyJjqTo=Vi=nQ4sDJHASWMCKgQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Jan 2023 10:52:43 -0800
Message-ID: <CAADnVQJmpB+bXB_tNXBSVFyG-1KnzKxapLfjUc51_v0-Vho+7w@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 8:39 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=93=
=D7=B3, 25 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-2:04 =D7=9E=D7=90=D7=
=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Tue, Jan 24, 2023 at 9:38 AM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=92=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-19:24 =D7=9E=D7=90=
=D7=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > On Tue, Jan 24, 2023 at 7:47 AM Yaniv Agman <yanivagman@gmail.com> =
wrote:
> > > > >
> > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=92=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-14:30 =D7=9E=D7=
=90=D7=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > > > > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=
=AC
> > > > > >
> > > > > > On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=
=9E=D7=90=D7=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > > > > > > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > > >
> > > > > > > > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=
=95=D7=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06=
 =D7=9E=D7=90=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > > > > > > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=
=AC
> > > > > > > > >>
> > > > > > > > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > > > > > > > >> >>> interrupted the first one. But even then, I will nee=
d to find a way to
> > > > > > > > >> >>> know if my program currently interrupts the run of a=
nother program -
> > > > > > > > >> >>> is there a way to do that?
> > > > > > > > >> May be a percpu atomic counter to see if the bpf prog ha=
s been re-entered on the
> > > > > > > > >> same cpu.
> > > > > > > > >
> > > > > > > > > Not sure I understand how this will help. If I want to sa=
ve local
> > > > > > > > > program data on a percpu map and I see that the counter i=
s bigger then
> > > > > > > > > zero, should I ignore the event?
> > > > > > > >
> > > > > > > > map_update w/ BPF_F_LOCK disables preemption, if you're aft=
er updating
> > > > > > > > an entry atomically. But it can't be used with PERCPU maps =
today.
> > > > > > > > Perhaps that's needed now too.
> > > > > > >
> > > > > > > Yep. I think what is needed here is the ability to disable pr=
eemption
> > > > > > > from the bpf program - maybe even adding a helper for that?
> > > > > >
> > > > > > I'm not sure what the issue is here.
> > > > > > Old preempt_disable() doesn't mean that one bpf program won't e=
ver
> > > > > > be interrupted by another bpf prog.
> > > > > > Like networking bpf prog in old preempt_disable can call into s=
omething
> > > > > > where there is a kprobe and another tracing bpf prog will be ca=
lled.
> > > > > > The same can happen after we switched to migrate_disable.
> > > > >
> > > > > One difference here is that in what you describe the programmer c=
an
> > > > > know in advance which functions might call others and avoid that =
or
> > > > > use other percpu maps, but if preemption can happen between funct=
ions
> > > > > which are not related to one another (don't have a relation of ca=
ller
> > > > > and callee), then the programmer can't have control over it
> > > >
> > > > Could you give a specific example?
> > >
> > > Sure. I can give two examples from places where we saw such corruptio=
n:
> > >
> > > 1. We use kprobes to trace some LSM hooks, e.g. security_file_open,
> > > and a percpu scratch map to prepare the event for submit. When we als=
o
> > > added a TRACEPOINT to trace sched_process_free (where we also use thi=
s
> > > scratch percpu map), the security_file_open events got corrupted and
> > > we didn't know what was happening (was very hard to debug)
> >
> > bpf_lsm_file_open is sleepable.
> > We never did preempt_disable there.
> > kprobe on security_file_open works, but it's a bit of a hack.
> > With preempt->migrate
> > the delayed_put_task_struct->trace_sched_process_free can happen
> > on the same cpu if prog gets preempted in preemtable kernel, but someth=
ing
> > is fishy here.
> > Non-sleepable bpf progs always run in rcu cs while
> > delayed_put_task_struct is call_rcu(),
> > so if you've used a per-cpu scratch buffer for a duration
> > of bpf prog (either old preempt_disable or new migrate_disable)
> > the trace_sched_process_free won't be called until prog is finished.
> >
> > If you're using per-cpu scratch buffer to remember the data in one
> > execution of kprobe-bpf and consuming in the next then all bets are off=
.
> > This is going to break sooner or later.
> >
>
> Yes, I agree this is fishy, but we only use the per-cpu scratch map
> for the duration of a bpf program, assuming tail-calls are considered
> to be part of the same program.
> We've even spotted the place where preemption happens to be right
> after calling bpf_perf_event_submit() helper by placing bpf_printk in
> the security_file_open kprobe. Before the call to the helper the
> buffer was ok, but after it got corrupted (and there were more lines
> in the program after the call to this helper).

I see. bpf_perf_event_output() may trigger irq_work->arch_irq_work_raise
which will send an ipi to the current cpu which may resched.

I'm still missing why kprobe in security_file_open has to share
per-cpu scratch buffer with kprobe in trace_sched_process_free.
Why not use a scratch buffer per program?

>
> > > 2. same was happening when kprobes were combined with cgroup_skb
> > > programs to trace network events
> >
> > irqs can interrupt old preempt_disable, so depending on where kprobe-bp=
f
> > is it can run while cgroup-bpf hasn't finished.
> >
>
> Actually what we saw here is that the ingress skb program that runs
> from ksoftirq/idle context corrupts a percpu map shared with a
> raw_sys_exit tracepoint used to submit execve/openat events.
>
> > Then there are differences in kernel configs: no preempt, full preempt,
> > preempt_rcu and differences in rcu_tasks_trace implementation
> > over the years. You can only assume that the validity of the pointer
> > to bpf per-cpu array and bpf per-cpu hash, but no assumption
> > about concurrent access to the same map if you share the same map
> > across different programs.
>
> I think that is the main point here. Thanks for clarifying this.
>
> > See BPF_F_LOCK earlier suggestion. It might be what you need.
>
> I am not sure how exactly this can help. The size of the percpu buffer
> we use is 32kb and we don't use the map_update helper but the pointer
> returned from the lookup to update the map in several places in the
> program.

It wasn't clear what you do with the scratch buffer.
BPF_F_LOCK will help if user space wants to bpf_lookup_elem it without
a race with bpf prog that would use bpf_spin_lock() to access the element.
Looks like that's not the case you had in mind.
You just stream these buffers to user space via bpf_perf_event_output().

Anyway back to preempt_disable(). Think of it as a giant spin_lock
that covers the whole program. In preemptable kernels it hurts
tail latency and fairness, and is completely unacceptable in RT.
That's why we moved to migrate_disable.
Technically we can add bpf_preempt_disable() kfunc, but if we do that
we'll be back to square one. The issues with preemptions and RT
will reappear. So let's figure out a different solution.
Why not use a scratch buffer per program ?
