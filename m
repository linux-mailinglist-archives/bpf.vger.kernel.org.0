Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3515467B70A
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjAYQj3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjAYQj2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:39:28 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454871EFC0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 08:39:27 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 7so13786313pga.1
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 08:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is7MnY9HfSvyvPSygEvqR7Cwlcu3FM1u3JYxn+yGTSs=;
        b=PHR0v10K00Sw32cX0sMIRmo7yQMneAYc09Z+KVdV7DjTbIRC1U7C9BYXGvQGY64oVE
         AT6enOzhsgZUVPF/F5zx6CqJNF/0xS2r3tgRbWjuaZ7nqFdhGBS0QryPEhS7U7xT+fau
         5sUN7AGBtVNQ+LJiqbImCTciydKWYdvH4hJ3dXEexnJTqo9Jm4/2BLXiASXgQaQvUxad
         xyClvbCXKhQPuP/HKPtPvJ6v+kYgs1sBFEwBiUUg11SthhMlk+4hVBAqu/J3WSJAT4aT
         pwl3hrjR+1Z5h0pX3YWg5sMU3U8ZLwJN6TyXSQ5ETIaNDxU7UmdUoYNbs8eFxfe/cZ2z
         lCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is7MnY9HfSvyvPSygEvqR7Cwlcu3FM1u3JYxn+yGTSs=;
        b=ASU+j3jwWxBy1jI569ReRATxU1jezEjc1zxo4FJhU65fZl/ZWUWhxv2P2bA5eArRMS
         C6MSiF4ElnB3uwDR4kd+nMJAqfg90RCJZOqR1NsKRFdmNBh5PdeAKmcCE4v3jv2BlBC9
         A3moWncWpeM1XClYwNY74LwOs43cAPEqbNQi54hGphQfJMN50JLjcD9jQBgN8THA1KYn
         izw9Wr6goMzDQzlkf8SsxheEvgBiZpmJc7JQLMDxkwLGzSEQdQA04Fdc8UVyT4zmENv2
         qhXGfMuULbqn2HlRtyNhkDVHaQQ5goua0FH4YSEjXdRuCB2b8WUNglcCgU3kNkxu8tgw
         DQEw==
X-Gm-Message-State: AFqh2kpGn7mW4CktwtJqknmGhkUE4n89ZOwvNWJSzTpYKXycz6kQgT/J
        kZh74/aCOyHcFnfaADMZ/pDRS1qkh+GfXVI63Qw=
X-Google-Smtp-Source: AMrXdXtizq7W10iPj0VR7c48mSf37wA5tgJTXaHk+D+TTpV4YHW06Gc0hTZ5hwnB2zpJYEtlrhZUUqy2kHOdRRZyzfE=
X-Received: by 2002:a62:bd15:0:b0:58d:8e62:6c05 with SMTP id
 a21-20020a62bd15000000b0058d8e626c05mr3630069pff.23.1674664766548; Wed, 25
 Jan 2023 08:39:26 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
 <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
 <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com>
 <CAADnVQLaKyRJwXnU4wZrih4pRduw_eWarA2uNuc=HssKQUAn_Q@mail.gmail.com>
 <CAMy7=ZU7oEa-VJy1_5WM6+poWsVCyZ0Y7ocQLq3qkFcs2-ftBw@mail.gmail.com> <CAADnVQKbi6JA4tX=uBHvNrYEUeMa3jmB=FSb=1LufE3597c86A@mail.gmail.com>
In-Reply-To: <CAADnVQKbi6JA4tX=uBHvNrYEUeMa3jmB=FSb=1LufE3597c86A@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Wed, 25 Jan 2023 18:39:15 +0200
Message-ID: <CAMy7=ZW7tX4ziwJLhGtqQjbdLyJjqTo=Vi=nQ4sDJHASWMCKgQ@mail.gmail.com>
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
=B3, 25 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-2:04 =D7=9E=D7=90=D7=AA =
=E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
<=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Tue, Jan 24, 2023 at 9:38 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-19:24 =D7=9E=D7=90=D7=
=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Tue, Jan 24, 2023 at 7:47 AM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=92=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-14:30 =D7=9E=D7=
=90=D7=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > > > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >
> > > > > On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail.com=
> wrote:
> > > > > >
> > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=
=9E=D7=90=D7=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > > > > > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > >
> > > > > > > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=
=D7=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =
=D7=9E=D7=90=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > > > > > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > > >>
> > > > > > > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > > > > > > >> >>> interrupted the first one. But even then, I will need =
to find a way to
> > > > > > > >> >>> know if my program currently interrupts the run of ano=
ther program -
> > > > > > > >> >>> is there a way to do that?
> > > > > > > >> May be a percpu atomic counter to see if the bpf prog has =
been re-entered on the
> > > > > > > >> same cpu.
> > > > > > > >
> > > > > > > > Not sure I understand how this will help. If I want to save=
 local
> > > > > > > > program data on a percpu map and I see that the counter is =
bigger then
> > > > > > > > zero, should I ignore the event?
> > > > > > >
> > > > > > > map_update w/ BPF_F_LOCK disables preemption, if you're after=
 updating
> > > > > > > an entry atomically. But it can't be used with PERCPU maps to=
day.
> > > > > > > Perhaps that's needed now too.
> > > > > >
> > > > > > Yep. I think what is needed here is the ability to disable pree=
mption
> > > > > > from the bpf program - maybe even adding a helper for that?
> > > > >
> > > > > I'm not sure what the issue is here.
> > > > > Old preempt_disable() doesn't mean that one bpf program won't eve=
r
> > > > > be interrupted by another bpf prog.
> > > > > Like networking bpf prog in old preempt_disable can call into som=
ething
> > > > > where there is a kprobe and another tracing bpf prog will be call=
ed.
> > > > > The same can happen after we switched to migrate_disable.
> > > >
> > > > One difference here is that in what you describe the programmer can
> > > > know in advance which functions might call others and avoid that or
> > > > use other percpu maps, but if preemption can happen between functio=
ns
> > > > which are not related to one another (don't have a relation of call=
er
> > > > and callee), then the programmer can't have control over it
> > >
> > > Could you give a specific example?
> >
> > Sure. I can give two examples from places where we saw such corruption:
> >
> > 1. We use kprobes to trace some LSM hooks, e.g. security_file_open,
> > and a percpu scratch map to prepare the event for submit. When we also
> > added a TRACEPOINT to trace sched_process_free (where we also use this
> > scratch percpu map), the security_file_open events got corrupted and
> > we didn't know what was happening (was very hard to debug)
>
> bpf_lsm_file_open is sleepable.
> We never did preempt_disable there.
> kprobe on security_file_open works, but it's a bit of a hack.
> With preempt->migrate
> the delayed_put_task_struct->trace_sched_process_free can happen
> on the same cpu if prog gets preempted in preemtable kernel, but somethin=
g
> is fishy here.
> Non-sleepable bpf progs always run in rcu cs while
> delayed_put_task_struct is call_rcu(),
> so if you've used a per-cpu scratch buffer for a duration
> of bpf prog (either old preempt_disable or new migrate_disable)
> the trace_sched_process_free won't be called until prog is finished.
>
> If you're using per-cpu scratch buffer to remember the data in one
> execution of kprobe-bpf and consuming in the next then all bets are off.
> This is going to break sooner or later.
>

Yes, I agree this is fishy, but we only use the per-cpu scratch map
for the duration of a bpf program, assuming tail-calls are considered
to be part of the same program.
We've even spotted the place where preemption happens to be right
after calling bpf_perf_event_submit() helper by placing bpf_printk in
the security_file_open kprobe. Before the call to the helper the
buffer was ok, but after it got corrupted (and there were more lines
in the program after the call to this helper).

> > 2. same was happening when kprobes were combined with cgroup_skb
> > programs to trace network events
>
> irqs can interrupt old preempt_disable, so depending on where kprobe-bpf
> is it can run while cgroup-bpf hasn't finished.
>

Actually what we saw here is that the ingress skb program that runs
from ksoftirq/idle context corrupts a percpu map shared with a
raw_sys_exit tracepoint used to submit execve/openat events.

> Then there are differences in kernel configs: no preempt, full preempt,
> preempt_rcu and differences in rcu_tasks_trace implementation
> over the years. You can only assume that the validity of the pointer
> to bpf per-cpu array and bpf per-cpu hash, but no assumption
> about concurrent access to the same map if you share the same map
> across different programs.

I think that is the main point here. Thanks for clarifying this.

> See BPF_F_LOCK earlier suggestion. It might be what you need.

I am not sure how exactly this can help. The size of the percpu buffer
we use is 32kb and we don't use the map_update helper but the pointer
returned from the lookup to update the map in several places in the
program.
