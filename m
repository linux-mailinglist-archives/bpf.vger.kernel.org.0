Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4196C67A04E
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 18:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjAXRiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 12:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjAXRiR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 12:38:17 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569FE3E092
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:38:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z3so11732539pfb.2
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 09:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJhVsHPQGApzwNfyQ0ypP1XFkAzyW8k3WSfxl+nGrbs=;
        b=ZJvONw+GlhTBgOMtLQ6aF8I+JLtia9GcTT4V/xCUhFIPzWqwaA9Cz/yaX9BxJmdQAh
         eRcA4zlWkHLe5rH8iyRwIxPDXiSeqBRBfsIf8Iqsn/yjlqgNyozu3KEPPSX1xZWEquXp
         +RPoVLnrwx4ZL9z7O8QhmebyytaIrdLFr6SbERdS2eB/+Mra45D8HY08ulbjKd+Psi9D
         50UFooKe6KENsb/18Htr5QeuDaY23lgkZyKiJpjoKl5WGOL4EifXULbzyGpyqYNdRvBO
         KDlUYTLy7wv7o/Uoj9sMaZnfeFZt5S901GxZtHsXJnnt5uTomjEcZwAuwp9IwgKLd/OD
         3TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJhVsHPQGApzwNfyQ0ypP1XFkAzyW8k3WSfxl+nGrbs=;
        b=V/RHs/7pbtOvsnH+pxJpbB/1If9DrG0aCtJBCbPyCXuWA8iJz3mTBTFqpyEUaI5AiJ
         nQRo6dWRWH6VXqsR/ySQX7LFX+bwrU0gLNmEA93WuLcaGl7Ppkq8eO7MUAJi2aIAy6+X
         F8IBGJ3wA7+o/44Ft6XZI2ju/APBErqJYP5QXkDciv59aGuUQ/dAveZhStm+vISPDROE
         9F0xz8ecpMUF1tkqzF0JW0rBda/xs0jiXLuLSz0aHauQv0t0GLuP2Y/AvhwaRHUy3YdC
         QSRIAY9MTTDRv4hRyHgYXbZdNMur6otGiG16LskxI7LyGk6F0tmMDY+RQZwBzGfcpTsl
         3dGQ==
X-Gm-Message-State: AFqh2kqFg6cgYiZfwQm8N8fSt0itps9mRniHnqlyn5y6zI+sEBig/XQN
        zowAtD3NQ5qCykQn7VEvAWyVl45y0rWYdjRL+hg=
X-Google-Smtp-Source: AMrXdXvVvWgPT9uLFVY4fPgT1RORdQjR/PAegJjcszZc53ns1E5CXipkmHJHtxzOIcrXA286BRRdQTUVq6hGFE1Hk+U=
X-Received: by 2002:a05:6a00:f91:b0:58b:a1bd:6aae with SMTP id
 ct17-20020a056a000f9100b0058ba1bd6aaemr2912740pfb.25.1674581894416; Tue, 24
 Jan 2023 09:38:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com> <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
 <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev> <CAMy7=ZWi35SKj9rcKwj0eyH+xY8ZBgiX_vpF=mydxFDahK6trg@mail.gmail.com>
 <87k01dvt83.fsf@cloudflare.com> <CAMy7=ZXyqCzhosiwpLa9rsFqW2jX4V59-Ef4k-5dQtqKOakTFQ@mail.gmail.com>
 <CAADnVQJaCTQtmvOdQoeaZbt0wwPp4iYjbvaPvRZw4DBEOSrJYg@mail.gmail.com>
 <CAMy7=ZVpGMOK_kHk1qB4ywxV88Vvtt=rGw4Q-Fi1F7bGU+6prQ@mail.gmail.com> <CAADnVQLaKyRJwXnU4wZrih4pRduw_eWarA2uNuc=HssKQUAn_Q@mail.gmail.com>
In-Reply-To: <CAADnVQLaKyRJwXnU4wZrih4pRduw_eWarA2uNuc=HssKQUAn_Q@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Tue, 24 Jan 2023 19:38:03 +0200
Message-ID: <CAMy7=ZU7oEa-VJy1_5WM6+poWsVCyZ0Y7ocQLq3qkFcs2-ftBw@mail.gmail.com>
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

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=D7=
=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-19:24 =D7=9E=D7=90=D7=AA=
 =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
<=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Tue, Jan 24, 2023 at 7:47 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=92=
=D7=B3, 24 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-14:30 =D7=9E=D7=90=D7=
=AA =E2=80=AAAlexei Starovoitov=E2=80=AC=E2=80=8F
> > <=E2=80=AAalexei.starovoitov@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > >
> > > On Mon, Jan 23, 2023 at 2:03 PM Yaniv Agman <yanivagman@gmail.com> wr=
ote:
> > > >
> > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =
=D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-23:25 =D7=9E=D7=
=90=D7=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > > > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > >
> > > > > On Mon, Jan 23, 2023 at 11:01 PM +02, Yaniv Agman wrote:
> > > > > > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=
=9D =D7=91=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-22:06 =D7=
=9E=D7=90=D7=AA =E2=80=AAMartin KaFai Lau=E2=80=AC=E2=80=8F
> > > > > > <=E2=80=AAmartin.lau@linux.dev=E2=80=AC=E2=80=8F>:=E2=80=AC
> > > > > >>
> > > > > >> On 1/23/23 9:32 AM, Yaniv Agman wrote:
> > > > > >> >>> interrupted the first one. But even then, I will need to f=
ind a way to
> > > > > >> >>> know if my program currently interrupts the run of another=
 program -
> > > > > >> >>> is there a way to do that?
> > > > > >> May be a percpu atomic counter to see if the bpf prog has been=
 re-entered on the
> > > > > >> same cpu.
> > > > > >
> > > > > > Not sure I understand how this will help. If I want to save loc=
al
> > > > > > program data on a percpu map and I see that the counter is bigg=
er then
> > > > > > zero, should I ignore the event?
> > > > >
> > > > > map_update w/ BPF_F_LOCK disables preemption, if you're after upd=
ating
> > > > > an entry atomically. But it can't be used with PERCPU maps today.
> > > > > Perhaps that's needed now too.
> > > >
> > > > Yep. I think what is needed here is the ability to disable preempti=
on
> > > > from the bpf program - maybe even adding a helper for that?
> > >
> > > I'm not sure what the issue is here.
> > > Old preempt_disable() doesn't mean that one bpf program won't ever
> > > be interrupted by another bpf prog.
> > > Like networking bpf prog in old preempt_disable can call into somethi=
ng
> > > where there is a kprobe and another tracing bpf prog will be called.
> > > The same can happen after we switched to migrate_disable.
> >
> > One difference here is that in what you describe the programmer can
> > know in advance which functions might call others and avoid that or
> > use other percpu maps, but if preemption can happen between functions
> > which are not related to one another (don't have a relation of caller
> > and callee), then the programmer can't have control over it
>
> Could you give a specific example?

Sure. I can give two examples from places where we saw such corruption:

1. We use kprobes to trace some LSM hooks, e.g. security_file_open,
and a percpu scratch map to prepare the event for submit. When we also
added a TRACEPOINT to trace sched_process_free (where we also use this
scratch percpu map), the security_file_open events got corrupted and
we didn't know what was happening (was very hard to debug)
2. same was happening when kprobes were combined with cgroup_skb
programs to trace network events
