Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D4E67A752
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 01:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjAYAE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 19:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAYAE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 19:04:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B21A24D
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 16:04:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so43462572ejc.4
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 16:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/y6bB/1g2mvzhVNVRJi3rG6IdGddR1EQLe3DnpGSQc=;
        b=pTpeEJ2GcFEdYTE8cNGCNJo7VX1k4354hLBZ1ufNP1xpNzRitnrY1xyMqJ3SFZZIq/
         bnPZm0VyIv2TO14uv8kgCUVRbYA6rDxM/hSsJbCqiDDYqlFA3ZmXoeSS1tLf7HgOSiqo
         xPlqWY97T2z2oHVlp2bUAmzakJvTZRQziQBjztskC0Qoj82eJpQnV0bgcgQ6/FFMpVji
         BhcFLLHdVzc11FJXIJIaglJM2QqL9j0pcjQEIIxPHOJda4PQyfVkTZOfxLhVkRyOWIKg
         WEB+CGf4ghxiKkaSV7OTCIrpp/V1qQousSiZCJON9cnHzZ41J9IoKOkyz4+oL66XUYkq
         7xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/y6bB/1g2mvzhVNVRJi3rG6IdGddR1EQLe3DnpGSQc=;
        b=HMPtVfnHBORj7pkU96/NLJV0mCQkyKSoQbbt1C6GtB6EWhtIyo3mm1xpbwiy63yNLa
         rJlyTPYcNP6Izkge56dubtkXAvPp3HsAd0aJ/6oXiMLVhxylets14ZO6kgU762V/RVFx
         QxamWQoaRkcTj+aeClx3oXB57x9H3Nrtw2Wk9Q6uhVQ4QJ9ZOjM5YBHzBLCGfpwiN77+
         d5nJaZ4wgBGBo2D3teFfzp6dRZwsS4iO+jgjKips3qyox53CxD01L481xvI8C5FoAIyv
         1uiUWWPaspM///TgXeqNBVChrwVrMSOOQq9BsXGgmyOulc6JVv4HV7N5/kmW2yF0clfU
         xExg==
X-Gm-Message-State: AFqh2krp6XFBDivo3oESYWl27w1FtkHss0Ybqx+BO6kGYnLpy+QEm6PV
        NKMQe/mhnn7xCujoVYg6DWk0aWhgivFRg2S14J0=
X-Google-Smtp-Source: AMrXdXsxtTPWZzE++kcSkUNRMhfWrubyOpTVbJkyUq4ZRC0qiNR7TU10FYyvkT2JuIkqDJrjumswtZCrPya5uSPC1Ys=
X-Received: by 2002:a17:906:e0d3:b0:7b2:7af0:c231 with SMTP id
 gl19-20020a170906e0d300b007b27af0c231mr3127633ejb.240.1674605094280; Tue, 24
 Jan 2023 16:04:54 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
 <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
 <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com>
 <CAADnVQLaKyRJwXnU4wZrih4pRduw_eWarA2uNuc=HssKQUAn_Q@mail.gmail.com> <CAMy7=ZU7oEa-VJy1_5WM6+poWsVCyZ0Y7ocQLq3qkFcs2-ftBw@mail.gmail.com>
In-Reply-To: <CAMy7=ZU7oEa-VJy1_5WM6+poWsVCyZ0Y7ocQLq3qkFcs2-ftBw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Jan 2023 16:04:42 -0800
Message-ID: <CAADnVQKbi6JA4tX=uBHvNrYEUeMa3jmB=FSb=1LufE3597c86A@mail.gmail.com>
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

On Tue, Jan 24, 2023 at 9:38 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-19:24 =D7=9E=D7=90=D7=
=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Tue, Jan 24, 2023 at 7:47 AM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=
=92=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-14:30 =D7=9E=D7=90=
=D7=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > >
> > > > On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail.com> =
wrote:
> > > > >
> > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=9E=D7=
=90=D7=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > > > > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > >
> > > > > > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=
=9E=D7=90=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > > > > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > > >>
> > > > > > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > > > > > >> >>> interrupted the first one. But even then, I will need to=
 find a way to
> > > > > > >> >>> know if my program currently interrupts the run of anoth=
er program -
> > > > > > >> >>> is there a way to do that?
> > > > > > >> May be a percpu atomic counter to see if the bpf prog has be=
en re-entered on the
> > > > > > >> same cpu.
> > > > > > >
> > > > > > > Not sure I understand how this will help. If I want to save l=
ocal
> > > > > > > program data on a percpu map and I see that the counter is bi=
gger then
> > > > > > > zero, should I ignore the event?
> > > > > >
> > > > > > map_update w/ BPF_F_LOCK disables preemption, if you're after u=
pdating
> > > > > > an entry atomically. But it can't be used with PERCPU maps toda=
y.
> > > > > > Perhaps that's needed now too.
> > > > >
> > > > > Yep. I think what is needed here is the ability to disable preemp=
tion
> > > > > from the bpf program - maybe even adding a helper for that?
> > > >
> > > > I'm not sure what the issue is here.
> > > > Old preempt_disable() doesn't mean that one bpf program won't ever
> > > > be interrupted by another bpf prog.
> > > > Like networking bpf prog in old preempt_disable can call into somet=
hing
> > > > where there is a kprobe and another tracing bpf prog will be called=
.
> > > > The same can happen after we switched to migrate_disable.
> > >
> > > One difference here is that in what you describe the programmer can
> > > know in advance which functions might call others and avoid that or
> > > use other percpu maps, but if preemption can happen between functions
> > > which are not related to one another (don't have a relation of caller
> > > and callee), then the programmer can't have control over it
> >
> > Could you give a specific example?
>
> Sure. I can give two examples from places where we saw such corruption:
>
> 1. We use kprobes to trace some LSM hooks, e.g. security_file_open,
> and a percpu scratch map to prepare the event for submit. When we also
> added a TRACEPOINT to trace sched_process_free (where we also use this
> scratch percpu map), the security_file_open events got corrupted and
> we didn't know what was happening (was very hard to debug)

bpf_lsm_file_open is sleepable.
We never did preempt_disable there.
kprobe on security_file_open works, but it's a bit of a hack.
With preempt->migrate
the delayed_put_task_struct->trace_sched_process_free can happen
on the same cpu if prog gets preempted in preemtable kernel, but something
is fishy here.
Non-sleepable bpf progs always run in rcu cs while
delayed_put_task_struct is call_rcu(),
so if you've used a per-cpu scratch buffer for a duration
of bpf prog (either old preempt_disable or new migrate_disable)
the trace_sched_process_free won't be called until prog is finished.

If you're using per-cpu scratch buffer to remember the data in one
execution of kprobe-bpf and consuming in the next then all bets are off.
This is going to break sooner or later.

> 2. same was happening when kprobes were combined with cgroup_skb
> programs to trace network events

irqs can interrupt old preempt_disable, so depending on where kprobe-bpf
is it can run while cgroup-bpf hasn't finished.

Then there are differences in kernel configs: no preempt, full preempt,
preempt_rcu and differences in rcu_tasks_trace implementation
over the years. You can only assume that the validity of the pointer
to bpf per-cpu array and bpf per-cpu hash, but no assumption
about concurrent access to the same map if you share the same map
across different programs.
See BPF_F_LOCK earlier suggestion. It might be what you need.
