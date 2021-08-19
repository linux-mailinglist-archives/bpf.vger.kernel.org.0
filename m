Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE83F201F
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhHSSsw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSSsv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 14:48:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C6C061575
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 11:48:15 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z128so14068039ybc.10
        for <bpf@vger.kernel.org>; Thu, 19 Aug 2021 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgJSc8W6dICMImfAJcfGdsQm/gL9XKJ3ArhABodSO/w=;
        b=EtHx4yCfj54Sc5ZtU7AaAlh1G6v4bl4xJ0yuBVzWh9m63TIfcPDtiu0uOUBGxamfB0
         Y7A8w76s1BEUFLMRTWIpnI6MzuLUL6VaIK8n4qMF9/IE7uK3mTMbxFLFfARoKGPmoV5a
         8oPguI4unpkWEcvvh1BTiLsF9NoW7FKPvr8cCIVUbP40Nl0P81R+sBtsdDK7VKl1I2MI
         4gWvBysKenn861Rq1CtciZ5NKozogY2GhnqRWZTF8s1X2YGdCHAjCposgTfdcIHcExKg
         bhxlf2y47U8SPJhAz9OpXZfUnrO++Em/3sVqRLB9KW4pNyjKa48lRrtXROH045IxfCjO
         yEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgJSc8W6dICMImfAJcfGdsQm/gL9XKJ3ArhABodSO/w=;
        b=HvwXD8N5tRkWy3P8OrqVoh+Ltbw1ICMpQLOXFkOIgazX/Kw6caukwFSBG8tBjavkB5
         V+B285FF7OIsStsrwCEH2ppe2TOnp5RVQzLS/bWr3Sjz1YNyyvi8axXyaQC5Vl3B+xW7
         VeEQAxowzkImVwjc4dNZtwFO7NUhaR8viNS/Kc7af0dqrptjWyImuTJbh3eSWnHe0Q0e
         L6VsdhbbdfLb8gNQJmVuho6JMq/npTo3HWM8GkKZAvJX8IgCjpcOD1UuDeU6SgyIreRW
         TIYoo5KwjmpgXopD3hjMgk84SQ8K96xmBky8r3adYhwjOlipHivQPHL57K93xY6y+28r
         WRNQ==
X-Gm-Message-State: AOAM530HAis5Y5VwqaGoVXs1j7KNsCYS7tTQRGWKbBPBnFm0zXfFAPME
        zuvgljhiDsxJAza5ihSYCmPnKjXI4xkj1ika3k4=
X-Google-Smtp-Source: ABdhPJx6a/OmZTi/cTMmOTMsEtHtLR78TcKy06wSe+OrNyTsfPSVF1yX7R8cmbPlU1oV+X//2xXQDwlquufVP4VhMRE=
X-Received: by 2002:a25:1e03:: with SMTP id e3mr1550032ybe.459.1629398894577;
 Thu, 19 Aug 2021 11:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210819155209.1927994-1-yhs@fb.com>
In-Reply-To: <20210819155209.1927994-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Aug 2021 11:48:03 -0700
Message-ID: <CAEf4BzZyQ0c4YtOcqGG9RxSbPCYw6ORfVQXr2XAcbr1xAW6ENA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix NULL event->prog pointer access in bpf_overflow_handler
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 19, 2021 at 8:52 AM Yonghong Song <yhs@fb.com> wrote:
>
> Andrii reported that libbpf CI hit the following oops when
> running selftest send_signal:
>   [ 1243.160719] BUG: kernel NULL pointer dereference, address: 0000000000000030
>   [ 1243.161066] #PF: supervisor read access in kernel mode
>   [ 1243.161066] #PF: error_code(0x0000) - not-present page
>   [ 1243.161066] PGD 0 P4D 0
>   [ 1243.161066] Oops: 0000 [#1] PREEMPT SMP NOPTI
>   [ 1243.161066] CPU: 1 PID: 882 Comm: new_name Tainted: G           O      5.14.0-rc5 #1
>   [ 1243.161066] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>   [ 1243.161066] RIP: 0010:bpf_overflow_handler+0x9a/0x1e0
>   [ 1243.161066] Code: 5a 84 c0 0f 84 06 01 00 00 be 66 02 00 00 48 c7 c7 6d 96 07 82 48 8b ab 18 05 00 00 e8 df 55 eb ff 66 90 48 8d 75 48 48 89 e7 <ff> 55 30 41 89 c4 e8 fb c1 f0 ff 84 c0 0f 84 94 00 00 00 e8 6e 0f
>   [ 1243.161066] RSP: 0018:ffffc900000c0d80 EFLAGS: 00000046
>   [ 1243.161066] RAX: 0000000000000002 RBX: ffff8881002e0dd0 RCX: 00000000b4b47cf8
>   [ 1243.161066] RDX: ffffffff811dcb06 RSI: 0000000000000048 RDI: ffffc900000c0d80
>   [ 1243.161066] RBP: 0000000000000000 R08: 0000000000000000 R09: 1a9d56bb00000000
>   [ 1243.161066] R10: 0000000000000001 R11: 0000000000080000 R12: 0000000000000000
>   [ 1243.161066] R13: ffffc900000c0e00 R14: ffffc900001c3c68 R15: 0000000000000082
>   [ 1243.161066] FS:  00007fc0be2d3380(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
>   [ 1243.161066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1243.161066] CR2: 0000000000000030 CR3: 0000000104f8e000 CR4: 00000000000006e0
>   [ 1243.161066] Call Trace:
>   [ 1243.161066]  <IRQ>
>   [ 1243.161066]  __perf_event_overflow+0x4f/0xf0
>   [ 1243.161066]  perf_swevent_hrtimer+0x116/0x130
>   [ 1243.161066]  ? __lock_acquire+0x378/0x2730
>   [ 1243.161066]  ? __lock_acquire+0x372/0x2730
>   [ 1243.161066]  ? lock_is_held_type+0xd5/0x130
>   [ 1243.161066]  ? find_held_lock+0x2b/0x80
>   [ 1243.161066]  ? lock_is_held_type+0xd5/0x130
>   [ 1243.161066]  ? perf_event_groups_first+0x80/0x80
>   [ 1243.161066]  ? perf_event_groups_first+0x80/0x80
>   [ 1243.161066]  __hrtimer_run_queues+0x1a3/0x460
>   [ 1243.161066]  hrtimer_interrupt+0x110/0x220
>   [ 1243.161066]  __sysvec_apic_timer_interrupt+0x8a/0x260
>   [ 1243.161066]  sysvec_apic_timer_interrupt+0x89/0xc0
>   [ 1243.161066]  </IRQ>
>   [ 1243.161066]  asm_sysvec_apic_timer_interrupt+0x12/0x20
>   [ 1243.161066] RIP: 0010:finish_task_switch+0xaf/0x250
>   [ 1243.161066] Code: 31 f6 68 90 2a 09 81 49 8d 7c 24 18 e8 aa d6 03 00 4c 89 e7 e8 12 ff ff ff 4c 89 e7 e8 ca 9c 80 00 e8 35 af 0d 00 fb 4d 85 f6 <58> 74 1d 65 48 8b 04 25 c0 6d 01 00 4c 3b b0 a0 04 00 00 74 37 f0
>   [ 1243.161066] RSP: 0018:ffffc900001c3d18 EFLAGS: 00000282
>   [ 1243.161066] RAX: 000000000000031f RBX: ffff888104cf4980 RCX: 0000000000000000
>   [ 1243.161066] RDX: 0000000000000000 RSI: ffffffff82095460 RDI: ffffffff820adc4e
>   [ 1243.161066] RBP: ffffc900001c3d58 R08: 0000000000000001 R09: 0000000000000001
>   [ 1243.161066] R10: 0000000000000001 R11: 0000000000080000 R12: ffff88813bd2bc80
>   [ 1243.161066] R13: ffff8881002e8000 R14: ffff88810022ad80 R15: 0000000000000000
>   [ 1243.161066]  ? finish_task_switch+0xab/0x250
>   [ 1243.161066]  ? finish_task_switch+0x70/0x250
>   [ 1243.161066]  __schedule+0x36b/0xbb0
>   [ 1243.161066]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
>   [ 1243.161066]  ? lockdep_hardirqs_on+0x79/0x100
>   [ 1243.161066]  schedule+0x43/0xe0
>   [ 1243.161066]  pipe_read+0x30b/0x450
>   [ 1243.161066]  ? wait_woken+0x80/0x80
>   [ 1243.161066]  new_sync_read+0x164/0x170
>   [ 1243.161066]  vfs_read+0x122/0x1b0
>   [ 1243.161066]  ksys_read+0x93/0xd0
>   [ 1243.161066]  do_syscall_64+0x35/0x80
>   [ 1243.161066]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> The oops can also be reproduced with the following steps:
>   ./vmtest.sh -s
>   # at qemu shell
>   cd /root/bpf && while true; do ./test_progs -t send_signal
>
> Further analysis showed that the failure is introduced with
> commit b89fbfbb854c ("bpf: Implement minimal BPF perf link").
> With the above commit, the following scenario becomes possible:
>     cpu1                        cpu2
>                                 hrtimer_interrupt -> bpf_overflow_handler
>     (due to closing link_fd)
>     bpf_perf_link_release ->
>     perf_event_free_bpf_prog ->
>     perf_event_free_bpf_handler ->
>       WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler)
>       event->prog = NULL
>                                 bpf_prog_run(event->prog, &ctx)
>
> In the above case, the event->prog is NULL for bpf_prog_run, hence
> causing oops.
>
> To fix the issue, check whether event->prog is NULL or not. If it
> is, do not call bpf_prog_run. This seems working as the above
> reproducible step runs more than one hour and I didn't see any
> failures.
>
> Fixes: b89fbfbb854c ("bpf: Implement minimal BPF perf link")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/events/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2d1e63dd97f2..011cc5069b7b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9920,13 +9920,16 @@ static void bpf_overflow_handler(struct perf_event *event,
>                 .data = data,
>                 .event = event,
>         };
> +       struct bpf_prog *prog;
>         int ret = 0;
>
>         ctx.regs = perf_arch_bpf_user_pt_regs(regs);
>         if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
>                 goto out;
>         rcu_read_lock();
> -       ret = bpf_prog_run(event->prog, &ctx);
> +       prog = READ_ONCE(event->prog);
> +       if (prog)
> +               ret = bpf_prog_run(prog, &ctx);

Thanks a lot for figuring this out! I knew BPF_PROG_RUN_ARRAY does
NULL check, but I missed that raw perf_event has its own code path
that doesn't use any of that.

>         rcu_read_unlock();
>  out:
>         __this_cpu_dec(bpf_prog_active);
> --
> 2.30.2
>
