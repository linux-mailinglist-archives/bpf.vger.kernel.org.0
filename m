Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5812367C49C
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 07:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjAZG7z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 01:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjAZG7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 01:59:54 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCC5C0EF
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 22:59:54 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 141so545361pgc.0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 22:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL19IOgkHhe+MVcSiRjF63baRHUVdr2qKOxCW9XV1iM=;
        b=nPJx7bJskt1soa2deEGWRbF4RfPlfOcSTJkY/zEzHdONcf/YXOPHkThmUhAkm7oyVs
         LbTxDeFXg7Y62vUjFkpcI9MqirsY9PiR+/WUUYjwf0KIq/uBYnHcNZe8vfFBwzkGFYLI
         YVJXakaOosqFP0Mx+EufU/k6LZLXAy711gOjIKAOHRFuJX3tRe+9tysCu1stuNJHN+vd
         R46n1JBrAAcoimB0fcDI8bJVzjpQ7s+/EGdrASmq17CyiGgjalHqLfNW+rLJKi9Q0Y8k
         jwQFkdWjneMNcUgZCAgZba4dIgocQ2HC8aQSYRnqMEijU+ub8DtPJIRqyTB7+HwbZ+TO
         1Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL19IOgkHhe+MVcSiRjF63baRHUVdr2qKOxCW9XV1iM=;
        b=B2u/VwDaRonw8uZYmC5Gfz7UVjOEC5P8vDK6hUZGlfd8KggmhzWbkdZZBelMkLNFeO
         QX36lBFuAv/YUsLc3W8QkztD5zJPhHz0WbbMGskX6z1ebvHlYU3wFFgncELOousNfPIt
         kKwBjjG+8xLFteB4T5JA0SbWZFMQwtw5yJqrU36cWA8uZIXcLIyk55ylkDzGsS8zIBc9
         RDl6anb8N2GqCRlvb6U/yUtJqJ7j0yrsoQcNpO0bUWQJSUPc2fr9Egf3d5vjHxZsDEYZ
         ZdgvUJwwM54W6SWH/i25SdAH9bRGWBWadxekybf3YgJLoSB3G8OVSbXW5g1NLnzF4tUU
         2yAg==
X-Gm-Message-State: AFqh2kpMj1KG8SQ14KP/Mkompg1doR1h2Y/lXdqapUxWNCDq6rZqCzQo
        k3WfIRisVIBr+W7G8shGFpO0udiNautCYS/mBBQ=
X-Google-Smtp-Source: AMrXdXv97WNSd5P9QQubI635PGoj8JWXFCEvih1Itn3zaOpE2r0Moqe8KTx5RmD5RssL7Go7fARDK0FmG2e3DpXLOhE=
X-Received: by 2002:a62:e80a:0:b0:580:9012:2d71 with SMTP id
 c10-20020a62e80a000000b0058090122d71mr4046325pfi.52.1674716393258; Wed, 25
 Jan 2023 22:59:53 -0800 (PST)
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
 <CAMy7=ZW7tX4ziwJLhGtqQjbdLyJjqTo=Vi=nQ4sDJHASWMCKgQ@mail.gmail.com>
 <CAADnVQJmpB+bXB_tNXBSVFyG-1KnzKxapLfjUc51_v0-Vho+7w@mail.gmail.com>
 <CAMy7=ZX+swf7_TzKTHnrMK9d-2PjQK_22vFy_ypBQNsYarqChw@mail.gmail.com> <CAADnVQ++LzKt9Q-GtGXknVBqyMqY=vLJ3tR3NNGG3P66gvVCFQ@mail.gmail.com>
In-Reply-To: <CAADnVQ++LzKt9Q-GtGXknVBqyMqY=vLJ3tR3NNGG3P66gvVCFQ@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Thu, 26 Jan 2023 08:59:42 +0200
Message-ID: <CAMy7=ZUYQEJr9iFqGveLVhXqGoN+uVtUQRwx1F=KNVFVjtoZsw@mail.gmail.com>
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

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=D7=
=B3, 26 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-4:22 =D7=9E=D7=90=D7=AA =
=E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
<=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Wed, Jan 25, 2023 at 11:59 AM Yaniv Agman <yanivagman@gmail.com> wrote=
:
> >
> > > Anyway back to preempt_disable(). Think of it as a giant spin_lock
> > > that covers the whole program. In preemptable kernels it hurts
> > > tail latency and fairness, and is completely unacceptable in RT.
> > > That's why we moved to migrate_disable.
> > > Technically we can add bpf_preempt_disable() kfunc, but if we do that
> > > we'll be back to square one. The issues with preemptions and RT
> > > will reappear. So let's figure out a different solution.
> > > Why not use a scratch buffer per program ?
> >
> > Totally understand the reason for avoiding preemption disable,
> > especially in RT kernels.
> > I believe the answer for why not to use a scratch buffer per program
> > will simply be memory space.
> > In our use-case, Tracee [1], we let the user choose whatever events to
> > trace for a specific workload.
> > This list of events is very big, and we have many BPF programs
> > attached to different places of the kernel.
> > Let's assume that we have 100 events, and for each event we have a
> > different BPF program.
> > Then having 32kb per-cpu scratch buffers translates to 3.2MB per one
> > cpu, and ~100MB per 32 CPUs, which is more common for our case.
>
> Well, 100 bpf progs consume at least a page each,
> so you might want one program attached to all events.
>

Unfortunately, I don't think that would be possible. We still need to
support kernels with 4096 instructions limit.
We may add some generic programs for events with simpler logic, but
even then, support for bpf cookies needed for such programs was only
added in more recent kernels.

> > Since we always add new events to Tracee, this will also not be scalabl=
e.
> > Yet, if there is no other solution, I believe we will go in that direct=
ion
> >
> > [1] https://github.com/aquasecurity/tracee/blob/main/pkg/ebpf/c/tracee.=
bpf.c
>
> you're talking about BPF_PERCPU_ARRAY(scratch_map, scratch_t, 1); ?

We actually have 3 different percpu maps there shared between
different programs so we will have to take care of them all.

>
> Insead of scratch_map per program, use atomic per-cpu counter
> for recursion.
> You'll have 3 levels in the worst case.

Is it guaranteed that no more than 3 levels exist?
I suggested a similar solution with 2 levels at the beginning of this
thread, but Yonghong Song replied that there is no restriction on
this.

> So it will be:
> BPF_PERCPU_ARRAY(scratch_map, scratch_t, 3);
> On prog entry increment the recursion counter, on exit decrement.
> And use that particular scratch_t in the prog.

I'm just afraid of potential deadlocks. For sure we will need to
decrement the counter on each return path, but can it happen that a
bpf program crashes, leaving the counter non-zero? I know that's the
job of the verifier to make sure such things won't happen, but can we
be sure of that?
