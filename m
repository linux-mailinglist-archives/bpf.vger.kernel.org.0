Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D403065374E
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 20:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiLUT7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 14:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbiLUT7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 14:59:20 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB8BE26
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:59:20 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jo4so71344ejb.7
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 11:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToRLYJb6c3lQIp6W0KLEsmDijuoR5i5vECoGljr1enU=;
        b=iKTl6C70rUL93y+c6Wy93c4Qj0+5gUtWG0u4f3YuxF8IxwyvkQ2RaanEuFoG1wvtYW
         rJkA2iIF16tj1rp3xYirAbng9mGctzH9SxyYUgepxv4+tFU8Q3byyL56XalVyMXM8bc/
         OqIQNfwsE0CDLigsMfTgDoedEtEEV24r5yDQrDneVy2cY2P3dpISbeqZB0e/1QsX2Wle
         j4LHJsUAxkStLgavYw6TuxDxgffC6RsT4/6rlPIs7w8B9AqXAIBIoeUPTjFnEVuNUdK5
         8mUJoEuNtXAoa5GnN9zzBWhat61Dh6KQ9DYd39wG42d465TslZjqVNDFPl/lmD2+qMLq
         5yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToRLYJb6c3lQIp6W0KLEsmDijuoR5i5vECoGljr1enU=;
        b=XzeNkV71K4I+CJOHSf/OuN0XncqYbQNfkmgOEzEQ9t7FAVi+FKz0cogC0Uyuz7y08O
         Pz8WcEZVkHfApSFNaiFZwXGKGU9DBXEfnoX6fzV+Y/mKiiuENPHN9Mr/i+zIn8vWi/Sn
         HGYhZNbeH0UfPUW2H4GMFTZ3diApyAMYiFGpq9dJBEorxSvZ7esjB581UVq8cDDrPPBX
         VoEA0N7xIjtGp/ZPiry+IvrORND3fukH7o8hPe3tq9KcN+dNDLwb7ZBn0TKP1j1TlS5H
         ar6wdv6YEYklWYIO0yNK+jntRiCW3KekYHWPTMkdKWenB61dMh6zZj8mqjHgyzll4JI5
         6jew==
X-Gm-Message-State: AFqh2kpUmy/O6GQr5TaR9iHIeJRBCyaN7znPDGvJuGkiT61K795+I7YS
        NvaRlwtw2figi+KxaYJBJTA0TpaFWPceIf58lgwy2RL3Rek=
X-Google-Smtp-Source: AMrXdXve/7IcU535sukYtzaa0xATPCeqZ1qMrMWFBJZ9ahhReTpAUhxHnrMqBxhQFQiDJMM+ZFY6NEWLfpLG//vhLuI=
X-Received: by 2002:a17:907:bb94:b0:7c1:bb5:7757 with SMTP id
 xo20-20020a170907bb9400b007c10bb57757mr183901ejc.633.1671652758428; Wed, 21
 Dec 2022 11:59:18 -0800 (PST)
MIME-Version: 1.0
References: <CABWLsevTYdR0HL0TDqQS6XkY8z8RePzfe=mAJtmpVAn8DD1Ewg@mail.gmail.com>
 <CAADnVQ+N920Wo9XnD-SCuEnSqkjEjZ5KGxa2mkTCdOGqFy=QWA@mail.gmail.com> <CABWLsetLDzK3hr=f-gvGttP1EDBYmxJnyi50kS1KfdrTsitgPw@mail.gmail.com>
In-Reply-To: <CABWLsetLDzK3hr=f-gvGttP1EDBYmxJnyi50kS1KfdrTsitgPw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 21 Dec 2022 11:59:06 -0800
Message-ID: <CAADnVQJ_itX6zKWPaHY15oQOG-kTPp03xO5HwDfJejc=u5pWKg@mail.gmail.com>
Subject: Re: [iovisor-dev] one-shot BPF program in the context of a specific PID
To:     Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>
Cc:     iovisor-dev <iovisor-dev@lists.iovisor.org>
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

On Tue, Dec 20, 2022 at 8:03 AM Andrei Matei <andreimatei1@gmail.com> wrote=
:
>
> Hi Alexei,
>
> I'm playing around with using BPF to read a given process' memory for deb=
ugging purposes. I'd like to recreate some of the experience that a debugge=
r gives you by stopping and ptrace-ing another process, except without the =
"stopping" part. One of the aspects is around getting a snapshot of the run=
ning process; for example, for a Go program, this involves reading the info=
rmation that the Go runtime has about all the Goroutines, walking their sta=
cks, and collecting different variables from the different stack frames.
> You'll notice that this use case doesn't quite fit as a uprobe - I don't =
want the BPF program to be run when a particular program counter is hit; in=
stead, I want the BPF program to run whenever the debugger decides to run i=
t. Crucially, the BPF program needs to run *within the virtual memory conte=
xt* of the debugged program, so it can bpf_probe_read_user() its memory. So=
, I want process A to trigger a BPF program that will execute within proces=
s B. Or, is there perhaps a way to read the virtual memory of an arbitrary =
program?

yes. That's what bpf iterator of task->vma is for.
The prog doesn't need to execute "within process B" to read its memory.

> > Have you considered using a task iterator parametrized with a particula=
r task?
>
> I had not. I'm reading about it now, but I'm not sure if it helps me. If =
it applies, can you please say more?

I think that is exactly what you need.
The iterator can read mm of another process as long as
you can ptrace it.
The same permission checks as gdb.
The main difference is that bpf iter doesn't stop another process.
See task iter and vma selftests including bpf_find_vma helper
that can also be useful.

> Thanks!
>
> On Tue, Dec 20, 2022 at 9:16 AM Alexei Starovoitov <alexei.starovoitov@gm=
ail.com> wrote:
>>
>> On Sun, Dec 18, 2022 at 4:09 PM Andrei Matei <andreimatei1@gmail.com> wr=
ote:
>> >
>> > Hello iovisor friends,
>> >
>> > I'm curious what my options are for running a BPF program once, immedi=
ately, in the virtual memory context of a particular (user space) process. =
For example, say I want to read the current value from a known virtual memo=
ry address in the process' space. I'm curious if there's an official answer=
 or, short of that, tricks that people might have used.
>> > What I want is similar in spirit to BPF_PROG_RUN, I think, except that=
 I think I want my program type to be perf-event (and BPF_PROG_RUN doesn't =
seem to support this program type), and I want to also control specify whic=
h process I'm interested in.
>> >
>> > I feel like one solution might be around sending a signal to the proce=
ss I'm interested in and placing a uprobe somewhere on the signal handling =
path, but I'm not sure of a general way to do this. Any suggestion is most =
welcome.
>>
>> Could you describe what prog is going to do?
>> Have you considered using a task iterator parametrized with a particular=
 task?
