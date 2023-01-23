Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFCB677AF1
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 13:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjAWMa6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 07:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWMa5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 07:30:57 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFE023862
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 04:30:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w2so8606961pfc.11
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7c4acKxDEX9sdV2Y4lZk5DLs+E7fm7akuH638F4T3E=;
        b=WZ3IyrInRFW821dEBPEQrQ/nIEiYzf4oSItQjTXPNhHhAMVjBERbu7yau/W33NBEro
         yMXjRCKuawO+v+qlrHxW21V32WNHe4TDIndP2JiTY4HF60Be9hII9xGzT9kwwspND5zP
         UGmg8mq3/D/TzisQja1NKO0+loJVmqC4ZmgkW2LVmPWHROkyLZZDj8GHGJQBFLfZhtOO
         naQ9NmI2Goq3Jf9eYL2XUyDEInMebDchcRd+QCRmGNel/DnUzAXoLgse2pGf3l8NVVff
         Vl7Ba4xNLh7XejlKqJylSBvpzSDI/0SAMNc3qlpebOH3znibQTaKtoVlLdw4r8EJ2E7/
         hgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7c4acKxDEX9sdV2Y4lZk5DLs+E7fm7akuH638F4T3E=;
        b=Yn1jqqa4XjVLJM0d+GdTZpRGoVSwgpdY8zSLlH9kGSHX0lGqNfmZvAtJ/87bxRkmuc
         3PzorlS0k408Ky0rDM4XhI37GpHzw2XhZtw2AnNvvn+X6wS479tMlYUHug4+9a857m0u
         JanjighQ5uPAbqI/pJGqfLmhN+A9A9t73rgN8mNvcLf23ds4/wiYoxh3HpivmKJgn9+Q
         YUPtq+ouopM8j2Qt9ixBdI1+QO1OrbIazhaVUk5fg5+06PYZJOT3qpj5xVF0qsn2WMfb
         0KGf/6S/WeGVFanoqlkUPTg5/E6s8mho3HnwiJCGmHuPgb1I8zawsZmILfbkmXW3cUsC
         8BBA==
X-Gm-Message-State: AFqh2kpjrBPa8KY8AkPX6tOI0C0c6Zy9yRB5THJ2ot6dt+L/KMeiqxLN
        b3xGfN/2CHKk2gILsabuULxNrEL0vZ7+0IxvM6uldq2UCDc=
X-Google-Smtp-Source: AMrXdXuNu5CXu3CEDIkTKvh+D2IAitrbyC9ug1RtMonT2mtbG9AomY0/BoD+UnDgVr0eZ10qSU6hF9lUe/bu3vG23zk=
X-Received: by 2002:aa7:8a4e:0:b0:577:a0ce:6e5e with SMTP id
 n14-20020aa78a4e000000b00577a0ce6e5emr2453659pfa.21.1674477049605; Mon, 23
 Jan 2023 04:30:49 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com>
In-Reply-To: <878rhty100.fsf@cloudflare.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 23 Jan 2023 14:30:36 +0200
Message-ID: <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
Subject: Re: Are BPF programs preemptible?
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>
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

Ok, thanks Jakub for the answer and references.
I must say that I am very surprised though. First, most of the
documentation for BPF says that preemption is disabled, like the
reference I gave [1] and even the bpf-helpers man page [2] says "Note
that all programs run with preemption disabled..." for the
bpf_get_smp_processor_id() helper. I think this is something that
deserves more attention since many eBPF developers are still under the
assumption that eBPF programs are non-preemptible, and running their
programs on newer kernels might be broken.

I'm trying to figure out how I can solve this issue in our case - is
it correct to assume that no more than one preemption can happen
during a run of my bpf program? If so, I can try to write a percpu
buffer with 2 entries, and give the second entry to the program that
interrupted the first one. But even then, I will need to find a way to
know if my program currently interrupts the run of another program -
is there a way to do that? Maybe checking if the current context is of
an interrupt, can this be done? Any other suggestions to solve this
problem?

[1]: https://docs.cilium.io/en/latest/bpf/toolchain
[2]: https://man7.org/linux/man-pages/man7/bpf-helpers.7.html

Thanks,
Yaniv

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 23 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2023 =D7=91-12:54 =D7=9E=D7=90=D7=AA=
 =E2=80=AAJakub Sitnicki=E2=80=AC=E2=80=8F
<=E2=80=AAjakub@cloudflare.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Jan 23, 2023 at 11:21 AM +02, Yaniv Agman wrote:
> > Hello!
> >
> > Several places state that eBPF programs cannot be preempted by the
> > kernel (e.g. https://docs.cilium.io/en/latest/bpf/toolchain), however,
> > I did see a strange behavior where an eBPF percpu map gets overridden,
> > and I'm trying to figure out if it's due to a bug in my program or
> > some misunderstanding I have about eBPF. What caught my eye was a
> > sentence in a LWN article (https://lwn.net/Articles/812503/) that
> > says: "Alexei thankfully enlightened me recently over a beer that the
> > real intent here is to guarantee that the program runs to completion
> > on the same CPU where it started".
> >
> > So my question is - are BPF programs guaranteed to run from start to
> > end without being interrupted at all or the only guarantee I get is
> > that they run on the same CPU but IRQs (NMIs, soft irqs, whatever) can
> > interrupt their run?
> >
> > If the only guarantee is no migration, it means that a percpu map
> > cannot be safely used by two different BPF programs that can preempt
> > each other (e.g. some kprobe and a network cgroup program).
>
> Since v5.7 BPF program runners use migrate_disable() instead of
> preempt_disable(). See commit 2a916f2f546c ("bpf: Use
> migrate_disable/enable in array macros and cgroup/lirc code.") [1].
>
> But at that time migrate_disable() was merely an alias for
> preempt_disable() on !CONFIG_PREEMPT_RT kernels.
>
> Since v5.11 migrate_disable() does no longer disable preemption on
> !CONFIG_PREEMPT_RT kernels. See commit 74d862b682f5 ("sched: Make
> migrate_disable/enable() independent of RT") [2].
>
> So, yes, you are right, but it depends on the kernel version.
>
> PS. The migrate_disable vs per-CPU data problem is also covered in [3].
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D2a916f2f546ca1c1e3323e2a4269307f6d9890eb
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D74d862b682f51e45d25b95b1ecf212428a4967b0
> [3]: https://lwn.net/Articles/836503/
