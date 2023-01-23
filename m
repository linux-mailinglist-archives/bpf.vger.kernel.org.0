Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA54367834F
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjAWRdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 12:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjAWRd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 12:33:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B1305E1
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 09:32:16 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b6so9517502pgi.7
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9RsFo5m03+CpH0Jmap1Hmzr9vgnRQD8xGqMAJqSVSk=;
        b=m2ZLoMH7LiAZotEYLn4+FG2SbsY0N0LKZRYYU/elc9HJQQcZKOxMnhQNtyshB8+Bxm
         7AspjmaCqQ+BLVtHq5wj89B/97i5Z1wXKnqX/I3PZxP3R9gnNUOFrw1qGnPbRCV/L1rz
         PQ3V9sTuUoJxA1qDWp9yg2xAjZU0t2I5EAKs3BibiJZXWSaDzL1zfM7S5uH1QHfa7+zk
         dqAbTBq5s15RfTBBrEPbH+DIrYE7KWcSC3AYTShv/nl4U+gLAALB+sHNuRUYSA62Y1yK
         3Q56yf8eeerGQeYsLp1kB6FvscmTdczvC9H8Wpah6o7tnrE39tSMfAsmvNCG2vnRGxFu
         389w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9RsFo5m03+CpH0Jmap1Hmzr9vgnRQD8xGqMAJqSVSk=;
        b=MxHnjCgTzDr6cv8DaTLOKS1f560JxdUhRKiv95Fm61QErosNKcJG145cTdB/8hNAIB
         ZhHbnpURklH0/lilQE5VmeTbK50730G0XtnrGcYlWRrgUG+zbbVmM7V9ow0qfcptLe1o
         LRzGtgNwbGUiP1ZuWC4OPnHgQ6sUG/Htes/hZRuAXupEHPX7K+lMPLa5v5JAlLSabCNC
         zF+lNQYI95ddh3Snhi2FVG6SLTCS7LSQGY62UbU5Cm5ccP9scQVavjgxHAE1i43w22GK
         k6UF9lp+/gra/WOEJ/+0jnbShYwtWD77tnBwgdrDd205r0jG9A6B4cSap8rLj4xPppfQ
         HnRg==
X-Gm-Message-State: AFqh2koEH8hr8pPMuxXBnaVB5NFI5w3rLceJNkq4crjCqURNikynUO4X
        Bm1xW6KRIhxbRLLnMPMfcJWmKnzLIKgToGxu0sc=
X-Google-Smtp-Source: AMrXdXsAMUZRHvlpBeGD/Kt1Nr47mDJ+RAFJwK4ecYugyn+Q+c7K33W/39rRSUo7hpLiIircZ2jZfTdEWTH+LVr/Gqg=
X-Received: by 2002:aa7:8a4e:0:b0:577:a0ce:6e5e with SMTP id
 n14-20020aa78a4e000000b00577a0ce6e5emr2590518pfa.21.1674495134705; Mon, 23
 Jan 2023 09:32:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com> <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com>
In-Reply-To: <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 23 Jan 2023 19:32:03 +0200
Message-ID: <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Yonghong Song <yhs@meta.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>, bpf <bpf@vger.kernel.org>
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

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-19:02 =D7=9E=D7=90=D7=AA=
 =E2=80=AAYonghong Song=E2=80=AC=E2=80=8F <=E2=80=AAyhs@meta.com=E2=80=AC=
=E2=80=8F>:=E2=80=AC
>
>
>
> On 1/23/23 4:30 AM, Yaniv Agman wrote:
> > Ok, thanks Jakub for the answer and references.
> > I must say that I am very surprised though. First, most of the
> > documentation for BPF says that preemption is disabled, like the
> > reference I gave [1] and even the bpf-helpers man page [2] says "Note
> > that all programs run with preemption disabled..." for the
> > bpf_get_smp_processor_id() helper. I think this is something that
> > deserves more attention since many eBPF developers are still under the
> > assumption that eBPF programs are non-preemptible, and running their
> > programs on newer kernels might be broken.
>
> It would be great if you can send a patch to fix these
> out-dated comments!
>
> >
> > I'm trying to figure out how I can solve this issue in our case - is
> > it correct to assume that no more than one preemption can happen
> > during a run of my bpf program? If so, I can try to write a percpu
>
> No. It is possible that you have more than one preemption during the
> same prog run. There is no restriction on this.
>

Any other suggestions for a solution to this problem?
For us, it is a regression caused by this change, but I didn't find
any proper alternative to use

> > buffer with 2 entries, and give the second entry to the program that
> > interrupted the first one. But even then, I will need to find a way to
> > know if my program currently interrupts the run of another program -
> > is there a way to do that? Maybe checking if the current context is of
> > an interrupt, can this be done? Any other suggestions to solve this
> > problem?
> >
> > [1]: https://docs.cilium.io/en/latest/bpf/toolchain
> > [2]: https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
> >
> > Thanks,
> > Yaniv
> >
> > =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-12:54 =D7=9E=D7=90=D7=
=AA =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
> > <=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >>
> >> On Mon, Jan 23, 2023 at 11:21 AM +02, Yaniv Agman wrote:
> >>> Hello!
> >>>
> >>> Several places state that eBPF programs cannot be preempted by the
> >>> kernel (e.g. https://docs.cilium.io/en/latest/bpf/toolchain ), howeve=
r,
> >>> I did see a strange behavior where an eBPF percpu map gets overridden=
,
> >>> and I'm trying to figure out if it's due to a bug in my program or
> >>> some misunderstanding I have about eBPF. What caught my eye was a
> >>> sentence in a LWN article (https://lwn.net/Articles/812503/ ) that
> >>> says: "Alexei thankfully enlightened me recently over a beer that the
> >>> real intent here is to guarantee that the program runs to completion
> >>> on the same CPU where it started".
> >>>
> >>> So my question is - are BPF programs guaranteed to run from start to
> >>> end without being interrupted at all or the only guarantee I get is
> >>> that they run on the same CPU but IRQs (NMIs, soft irqs, whatever) ca=
n
> >>> interrupt their run?
> >>>
> >>> If the only guarantee is no migration, it means that a percpu map
> >>> cannot be safely used by two different BPF programs that can preempt
> >>> each other (e.g. some kprobe and a network cgroup program).
> >>
> >> Since v5.7 BPF program runners use migrate_disable() instead of
> >> preempt_disable(). See commit 2a916f2f546c ("bpf: Use
> >> migrate_disable/enable in array macros and cgroup/lirc code.") [1].
> >>
> >> But at that time migrate_disable() was merely an alias for
> >> preempt_disable() on !CONFIG_PREEMPT_RT kernels.
> >>
> >> Since v5.11 migrate_disable() does no longer disable preemption on
> >> !CONFIG_PREEMPT_RT kernels. See commit 74d862b682f5 ("sched: Make
> >> migrate_disable/enable() independent of RT") [2].
> >>
> >> So, yes, you are right, but it depends on the kernel version.
> >>
> >> PS. The migrate_disable vs per-CPU data problem is also covered in [3]=
.
> >>
> >> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D2a916f2f546ca1c1e3323e2a4269307f6d9890eb
> >> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D74d862b682f51e45d25b95b1ecf212428a4967b0
> >> [3]: https://lwn.net/Articles/836503/
