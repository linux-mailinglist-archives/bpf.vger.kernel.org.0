Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C2C2E196B
	for <lists+bpf@lfdr.de>; Wed, 23 Dec 2020 08:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgLWHdA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Dec 2020 02:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWHdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Dec 2020 02:33:00 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353DC0613D3
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 23:32:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id w5so10097884pgj.3
        for <bpf@vger.kernel.org>; Tue, 22 Dec 2020 23:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=D7gVOb3i+0fPeSUqvzlH2yOs9dWFelNNQdrT/jYGtdo=;
        b=lkoYknFDOgpAgwaas8P2+fsxwQQ0GkRS59KQ5hK8wHLCsNePWw7/M3JoWbmLrc4Lnc
         xM95vS7liKDLPPHkmnwgmaMhALHD1sFsTJwnJ4GNMj530UKEhpTVakK7DktZOnIyFOyT
         OxDIa2WRVxwQFtgP537XaNcNaaKz5QCiWmBNU+fDeVEkGhoY2QPAhNKCX78ai9C4ksdw
         AW50dFVTPaRh43vtSP3rwLpO1IB3C3scQm3o4g88PWzALujhdk9Y0Ck9/os3rhREH02K
         ouHweFnPzy0+FNMSGskBq6kkwPgghBYd9sHT4x5qM/GgGTsa/j1CBg8lXf4scBwTOKJV
         DgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=D7gVOb3i+0fPeSUqvzlH2yOs9dWFelNNQdrT/jYGtdo=;
        b=RNVYUo/Q9UTGp7hwKijJ3wHjRhzplDtYbvz5a7rv6wxZ2CTHVgOGkj3KWB1iJd6L6v
         U4malZr2Gr3eHFirvKmtZRSfZZClp29jL+QPK0l26vuIOd2x+Oqzjb2Nh+MqAxFglOZq
         4JI1NKnYbgnjrvnmzxHqz216Mz2fBsGlswOekk6grDDU3vMzUDrRb6pIrG3j9V6YfQ5F
         GtJt0l3IOy89UGsEkTDUuu1kRhDh2dhunv4gb7eC7mWsw2TBhQvIwQHfCSdquZN9LCgp
         Y1v5jR2TBNV7vyOjWCgOtdXraXIA2vEO/QaziwSpdC42b5uS4+izcnfmyU48U2pgh0Sn
         X1UA==
X-Gm-Message-State: AOAM532fXxIRxQUZuVF0morYWnzimPGnM9+8eJK2XEpnWGQ1g/g6TuEw
        YBxQkG3Qeiomh4hNez+s0Lg=
X-Google-Smtp-Source: ABdhPJwZVxpQs7G0x+bf4MKuTDWOcVLGYHPRiREmundBkwTRv2nswPbOggX/p459ceh6jp/nSnBXTw==
X-Received: by 2002:a63:dc06:: with SMTP id s6mr8757254pgg.358.1608708739685;
        Tue, 22 Dec 2020 23:32:19 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id p15sm22144072pgl.19.2020.12.22.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 23:32:19 -0800 (PST)
Date:   Tue, 22 Dec 2020 23:32:09 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Message-ID: <5fe2f279bfc6f_1b18d20838@john-XPS-13-9370.notmuch>
In-Reply-To: <CAEf4BzbzsK8A8-tjigcde2zUY0JkHY495LDd3OYRxokG4wfAJg@mail.gmail.com>
References: <CAEf4BzapVMa4dnXpwU0uwj3oHqyYutVp_YCbuwrPWNbVjdH08A@mail.gmail.com>
 <CAEf4BzbzsK8A8-tjigcde2zUY0JkHY495LDd3OYRxokG4wfAJg@mail.gmail.com>
Subject: Re: Warnings in test_maps selftests in test_sockmap parts
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> On Tue, Dec 22, 2020 at 11:44 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Hi John and Martin,
> >
> > I've noticed that all our CIs (libbpf and kernel-patches) started to
> > emit kernel warning when running test_maps test. I've narrowed it down
> > to test_sockmap() part of it. If I disable it, the warning goes away.
> > The warning looks like this:
> >
> > Failed sockmap unexpected timeout
> > [   23.316720] ------------[ cut here ]------------
> > [   23.317615] WARNING: CPU: 0 PID: 93 at net/core/stream.c:208
> > sk_stream_kill_queues+0x111/0x120
> > [   23.319194] Modules linked in:
> > [   23.319698] CPU: 0 PID: 93 Comm: test_maps Not tainted
> > 5.10.0-rc7-02263-g0e12c0271887-dirty #51
> > [   23.321297] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.9.3-1.el7.centos 04/01/2014
> > [   23.322756] RIP: 0010:sk_stream_kill_queues+0x111/0x120
> > [   23.323668] Code: 00 85 c0 75 1f 85 f6 75 21 5b 5d c3 48 89 df e8
> > d5 fd fe ff 8b 83 68 02 00 00 8b b3 20 02 00 00 85 c0 74 e1 0f 0b 85
> > f6 74 df <0f> 0b 5b 5d c3 0f 0b eb ac 66 0f 1f 44 00 00 0f 1f 44 00 00
> > 41 57
> > [   23.326251] RSP: 0018:ffffc900001d7d80 EFLAGS: 00010202
> > [   23.326863] RAX: 0000000000000000 RBX: ffff88813a44a280 RCX: 0000000000000000
> > [   23.327597] RDX: 0000000000000001 RSI: 0000000000000aec RDI: ffff88813a44a3d0
> > [   23.328375] RBP: ffff88813a44a3d0 R08: 0000000000000000 R09: 0000000000000001
> > [   23.329300] R10: 0000000000000050 R11: 0000000000000000 R12: ffff888100362200
> > [   23.330281] R13: ffff88802564b8e0 R14: ffff8881006175f0 R15: 0000000000000000
> > [   23.331106] FS:  00007f56532ad740(0000) GS:ffff88813bc00000(0000)
> > knlGS:0000000000000000
> > [   23.332162] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   23.333011] CR2: 000000000064d448 CR3: 0000000101fd2000 CR4: 00000000000006f0
> > [   23.334051] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   23.334876] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   23.335777] Call Trace:
> > [   23.336027]  inet_csk_destroy_sock+0x4f/0x120
> > [   23.336542]  tcp_rcv_state_process+0xcee/0x1240
> > [   23.337010]  tcp_v4_do_rcv+0xb2/0x1e0
> > [   23.337541]  __release_sock+0x5c/0xf0
> > [   23.337956]  __tcp_close+0x1cb/0x4c0
> > [   23.338351]  tcp_close+0x20/0x70
> > [   23.338875]  inet_release+0x3c/0x70
> > [   23.339466]  __sock_release+0x37/0xa0
> > [   23.340003]  sock_close+0x14/0x20
> > [   23.340580]  __fput+0xb1/0x260
> > [   23.341091]  task_work_run+0x59/0xa0
> > [   23.341685]  exit_to_user_mode_prepare+0x152/0x160
> > [   23.342213]  syscall_exit_to_user_mode+0x38/0x240
> > [   23.342758]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   23.343250] RIP: 0033:0x7f565348b797
> > [   23.343702] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> > 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb
> > ff ff
> > [   23.345817] RSP: 002b:00007ffd178c1b68 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000003
> > [   23.346972] RAX: 0000000000000000 RBX: 00007ffd178c1be0 RCX: 00007f565348b797
> > [   23.348069] RDX: 0000000000000078 RSI: 00007ffd178c1ae0 RDI: 0000000000000008
> > [   23.349139] RBP: 00007ffd178c1cd0 R08: 0000000000000017 R09: 0000000000000016
> > [   23.350210] R10: 0000000000000016 R11: 0000000000000246 R12: 00007ffd178c1c20
> > [   23.351442] R13: 0000000000000016 R14: 000000000000000f R15: 0000000000000017
> > [   23.352500] irq event stamp: 1775071
> > [   23.352999] hardirqs last  enabled at (1775079):
> > [<ffffffff810d0dbf>] console_unlock+0x48f/0x590
> > [   23.354360] hardirqs last disabled at (1775088):
> > [<ffffffff810d0d27>] console_unlock+0x3f7/0x590
> > [   23.355748] softirqs last  enabled at (1775026):
> > [<ffffffff81a00ebf>] asm_call_irq_on_stack+0xf/0x20
> > [   23.357071] softirqs last disabled at (1775021):
> > [<ffffffff81a00ebf>] asm_call_irq_on_stack+0xf/0x20
> > [   23.358497] ---[ end trace 1fe2d145c0b7718d ]---
> >
> > When trying to bisect, it turns out we get this warning even with
> > older versions of bpf-next tree, which didn't seem to trigger this
> > warning before. One thing that seems to have changed in our CI setup
> > is that we went from 4 CPU VM to 2 CPU VM (due to Travis CI
> > limitations). So that might have changed some timings and
> > interactions.
> >
> > I'm dealing with other fallouts of this 4 to 2 CPU reduction and this
> > warning itself doesn't cause the failure in libbpf CI (but it will in
> 
> I take this back, it does return error from test_maps due to "Failed
> sockmap unexpected timeout", so both CIs are broken, I've just
> disabled test_maps in libbpf CI for now. And I'm sending a work-around
> for EBUSY errors from hashmap on update/delete in a separate patch.

OK thanks Andrii, I'll take a look. If its not obvious to me what the problem
is though it might slip into the new year as I'm on PTO shortly.

Also FWIW I'm sitting on some patches to start pulling the tests from
test_sockmap into the more normal test progs framework. Then we can just
keep test_sockmap around as a tool to test different setups or move it
out of tree. As far as I understand it CI doesn't run test_sockmap at the
moment.

Thanks,
John

> 
> > kernel-patches CI), but it would be great if you can take a look at
> > this and see if we can get it fixed soon-ish to get CI to a green
> > state.
> >
> > Thanks!
> >
> >
> > -- Andrii
