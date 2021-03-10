Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1063A3349EC
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 22:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCJVlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 16:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhCJVl0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 16:41:26 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46896C061574
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 13:41:26 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d9so19519109ybq.1
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 13:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BV/PaKdSGc2acxUiU23fTCEM4JuzRLoQl9owVT7hoJE=;
        b=CsX0sgB3t6adtBNyU+qbQ4ylJ/F+/tkMxJ3UZomxh3dSXN6N4QsLfiavRwenSjGnKr
         vMemtI0sFYDSGUuyw0tLnmYoburbHVpObZuveBPh22prveiEoN7OYTnB4nyzMbmReo7s
         585AfOQDLzSjCOASVA9MkeIBDq6Ja42CThu+VqdcIxnILfTxuEE1lha95jS7hZSsbWow
         2HC2f3Sg64fjo22Bj7ti+xEniUm2E1v83KgOsfDraSn3A54TmENJHtuWUcDLZvd+jiPF
         QjeMjDS4bxAAVsTv2YnKCfRVM+I+OV2S+a+xH1VTVZ9BdD3FBS7EVjtesDBL4v2WbkcU
         JbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BV/PaKdSGc2acxUiU23fTCEM4JuzRLoQl9owVT7hoJE=;
        b=omC7X+ev30vdisHjkJNpkw5k5BRIBm0aTwn2/uJjGsOHTCRnwEhO5jbIngbIcJ6ehs
         G6CEWTzmhZGFO5AEC3884OGud7qv674DHr4eQ2T8VNLVE5Z6I+xMYsLvYDq+djaJyDk8
         iZqSRu9PCAiE7pwPBts+7sgu1GmF9Jt5bQ8W4RH5/wua00THMS0MlpPo3riteLmKFY4/
         XqMowCrUD82Ai1xZMe3uJvnYjbxBhN6y3FGt2c61oV9bLyziVlh5gtWLfh3zqNlAWptJ
         4TEwqZubvHqvaqfDlT2Vvmt9nu1kmkBntpw/wMxRvdwUId7Wq4pP0EnxWBKVxRUTuCZN
         P03w==
X-Gm-Message-State: AOAM533EFAKBncGVgYb8xF3Zch4sb+uvGZkeAxgzFcM0DMyAsu4kB8gD
        fFNhImHaEuX9suOAok5e9LHKt4CMz1n/qK6p1gw=
X-Google-Smtp-Source: ABdhPJw+1d0BPneKAM/HLbK8Z8KTdACflysut/CyS4gmvtlkOM6H4ZcBwp09qqFyqW5oM3gyB9CpfCtY3qG38OpZnho=
X-Received: by 2002:a25:3d46:: with SMTP id k67mr6729736yba.510.1615412485523;
 Wed, 10 Mar 2021 13:41:25 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzapVMa4dnXpwU0uwj3oHqyYutVp_YCbuwrPWNbVjdH08A@mail.gmail.com>
 <CAEf4BzbzsK8A8-tjigcde2zUY0JkHY495LDd3OYRxokG4wfAJg@mail.gmail.com>
 <5fe2f279bfc6f_1b18d20838@john-XPS-13-9370.notmuch> <CAEf4BzYeSU6hAO1Yk06bFzh5=ufWD2pwd6+xvoip3GW_1gT77A@mail.gmail.com>
In-Reply-To: <CAEf4BzYeSU6hAO1Yk06bFzh5=ufWD2pwd6+xvoip3GW_1gT77A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Mar 2021 13:41:14 -0800
Message-ID: <CAEf4BzaE2FR8=ktp=L8Z2VyJcnkszkvyk-ssptA9qD2EvKgFHg@mail.gmail.com>
Subject: Re: Warnings in test_maps selftests in test_sockmap parts
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 23, 2020 at 12:13 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Dec 22, 2020 at 11:32 PM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > On Tue, Dec 22, 2020 at 11:44 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > Hi John and Martin,
> > > >
> > > > I've noticed that all our CIs (libbpf and kernel-patches) started to
> > > > emit kernel warning when running test_maps test. I've narrowed it down
> > > > to test_sockmap() part of it. If I disable it, the warning goes away.
> > > > The warning looks like this:
> > > >
> > > > Failed sockmap unexpected timeout

So this is still happening, quite often. It would be good to take care
of it, it makes test_maps quite unstable and just reduces the
signal-to-noise ratio of kernel-patches CI :(


> > > > [   23.316720] ------------[ cut here ]------------
> > > > [   23.317615] WARNING: CPU: 0 PID: 93 at net/core/stream.c:208
> > > > sk_stream_kill_queues+0x111/0x120
> > > > [   23.319194] Modules linked in:
> > > > [   23.319698] CPU: 0 PID: 93 Comm: test_maps Not tainted
> > > > 5.10.0-rc7-02263-g0e12c0271887-dirty #51
> > > > [   23.321297] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > > BIOS 1.9.3-1.el7.centos 04/01/2014
> > > > [   23.322756] RIP: 0010:sk_stream_kill_queues+0x111/0x120
> > > > [   23.323668] Code: 00 85 c0 75 1f 85 f6 75 21 5b 5d c3 48 89 df e8
> > > > d5 fd fe ff 8b 83 68 02 00 00 8b b3 20 02 00 00 85 c0 74 e1 0f 0b 85
> > > > f6 74 df <0f> 0b 5b 5d c3 0f 0b eb ac 66 0f 1f 44 00 00 0f 1f 44 00 00
> > > > 41 57
> > > > [   23.326251] RSP: 0018:ffffc900001d7d80 EFLAGS: 00010202
> > > > [   23.326863] RAX: 0000000000000000 RBX: ffff88813a44a280 RCX: 0000000000000000
> > > > [   23.327597] RDX: 0000000000000001 RSI: 0000000000000aec RDI: ffff88813a44a3d0
> > > > [   23.328375] RBP: ffff88813a44a3d0 R08: 0000000000000000 R09: 0000000000000001
> > > > [   23.329300] R10: 0000000000000050 R11: 0000000000000000 R12: ffff888100362200
> > > > [   23.330281] R13: ffff88802564b8e0 R14: ffff8881006175f0 R15: 0000000000000000
> > > > [   23.331106] FS:  00007f56532ad740(0000) GS:ffff88813bc00000(0000)
> > > > knlGS:0000000000000000
> > > > [   23.332162] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   23.333011] CR2: 000000000064d448 CR3: 0000000101fd2000 CR4: 00000000000006f0
> > > > [   23.334051] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [   23.334876] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [   23.335777] Call Trace:
> > > > [   23.336027]  inet_csk_destroy_sock+0x4f/0x120
> > > > [   23.336542]  tcp_rcv_state_process+0xcee/0x1240
> > > > [   23.337010]  tcp_v4_do_rcv+0xb2/0x1e0
> > > > [   23.337541]  __release_sock+0x5c/0xf0
> > > > [   23.337956]  __tcp_close+0x1cb/0x4c0
> > > > [   23.338351]  tcp_close+0x20/0x70
> > > > [   23.338875]  inet_release+0x3c/0x70
> > > > [   23.339466]  __sock_release+0x37/0xa0
> > > > [   23.340003]  sock_close+0x14/0x20
> > > > [   23.340580]  __fput+0xb1/0x260
> > > > [   23.341091]  task_work_run+0x59/0xa0
> > > > [   23.341685]  exit_to_user_mode_prepare+0x152/0x160
> > > > [   23.342213]  syscall_exit_to_user_mode+0x38/0x240
> > > > [   23.342758]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > [   23.343250] RIP: 0033:0x7f565348b797
> > > > [   23.343702] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> > > > 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
> > > > 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb
> > > > ff ff
> > > > [   23.345817] RSP: 002b:00007ffd178c1b68 EFLAGS: 00000246 ORIG_RAX:
> > > > 0000000000000003
> > > > [   23.346972] RAX: 0000000000000000 RBX: 00007ffd178c1be0 RCX: 00007f565348b797
> > > > [   23.348069] RDX: 0000000000000078 RSI: 00007ffd178c1ae0 RDI: 0000000000000008
> > > > [   23.349139] RBP: 00007ffd178c1cd0 R08: 0000000000000017 R09: 0000000000000016
> > > > [   23.350210] R10: 0000000000000016 R11: 0000000000000246 R12: 00007ffd178c1c20
> > > > [   23.351442] R13: 0000000000000016 R14: 000000000000000f R15: 0000000000000017
> > > > [   23.352500] irq event stamp: 1775071
> > > > [   23.352999] hardirqs last  enabled at (1775079):
> > > > [<ffffffff810d0dbf>] console_unlock+0x48f/0x590
> > > > [   23.354360] hardirqs last disabled at (1775088):
> > > > [<ffffffff810d0d27>] console_unlock+0x3f7/0x590
> > > > [   23.355748] softirqs last  enabled at (1775026):
> > > > [<ffffffff81a00ebf>] asm_call_irq_on_stack+0xf/0x20
> > > > [   23.357071] softirqs last disabled at (1775021):
> > > > [<ffffffff81a00ebf>] asm_call_irq_on_stack+0xf/0x20
> > > > [   23.358497] ---[ end trace 1fe2d145c0b7718d ]---
> > > >
> > > > When trying to bisect, it turns out we get this warning even with
> > > > older versions of bpf-next tree, which didn't seem to trigger this
> > > > warning before. One thing that seems to have changed in our CI setup
> > > > is that we went from 4 CPU VM to 2 CPU VM (due to Travis CI
> > > > limitations). So that might have changed some timings and
> > > > interactions.
> > > >
> > > > I'm dealing with other fallouts of this 4 to 2 CPU reduction and this
> > > > warning itself doesn't cause the failure in libbpf CI (but it will in
> > >
> > > I take this back, it does return error from test_maps due to "Failed
> > > sockmap unexpected timeout", so both CIs are broken, I've just
> > > disabled test_maps in libbpf CI for now. And I'm sending a work-around
> > > for EBUSY errors from hashmap on update/delete in a separate patch.
> >
> > OK thanks Andrii, I'll take a look. If its not obvious to me what the problem
> > is though it might slip into the new year as I'm on PTO shortly.
> >
>
> Yeah, no worries. I just wanted to give a heads up and get it off my
> head :) Don't lose your sleep over it.
>
> > Also FWIW I'm sitting on some patches to start pulling the tests from
> > test_sockmap into the more normal test progs framework. Then we can just
> > keep test_sockmap around as a tool to test different setups or move it
> > out of tree. As far as I understand it CI doesn't run test_sockmap at the
> > moment.
>
> CI that tests all incoming patches is currently red due to this and
> the EBUSY problem I worked around in [0]. Libbpf CI doesn't run
> test_maps currently, so it's good. I hesitated to disable test_maps
> for patches CI, though, but we can do that temporarily as well, if
> necessary.
>
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20201223200652.3417075-1-andrii@kernel.org/
>
> >
> > Thanks,
> > John
> >
> > >
> > > > kernel-patches CI), but it would be great if you can take a look at
> > > > this and see if we can get it fixed soon-ish to get CI to a green
> > > > state.
> > > >
> > > > Thanks!
> > > >
> > > >
> > > > -- Andrii
