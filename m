Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7405AFA5C
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 05:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIGDDB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 23:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGDCz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 23:02:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D9283BFA;
        Tue,  6 Sep 2022 20:02:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a70so1577059edf.10;
        Tue, 06 Sep 2022 20:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XbE8raIYybgu/eeU8tkOPooJt1AdcsnX26x3zxOVBq4=;
        b=bJ7Rt1Gw7E7bP1DH9ZXXWZ5TAKDKIbI8Nb9tK9Un1NZGIlW2Zjcd9d0SjfXqLgm7hd
         L8ie2WXUswKPucleTApgfAayFMeEigInBMsdnDnoCESFtJVR5Ohigmd9paPQLlbdEqHi
         TQ+C3DTqbSABmIzF+XdJeAlaO3Ou1DIowznR1YeytyYlc0k/PiMdDaLp38hMzRLjFz1y
         2X/z20+5Vg1xkXB1bSYtY28yQqUczv3QRNqwzatxCt2MRK1VdOEIfKKei3pQZILKw9j7
         mH4i0nDSWtQAu2IJV5AjxRB3Ikgai9Co0FYDn4NhIX5gqeCHnEFDvTr4Oo+SzCy/MxIT
         liZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XbE8raIYybgu/eeU8tkOPooJt1AdcsnX26x3zxOVBq4=;
        b=EOVBwGxV+c+W1Euq+U9HMw8Nmr+2lHRENcjDaB0zwSGOoAHuwFn37/pMIOQ6lxAGum
         Q4jntQ9BzwJ0zmem9LnEyX/LZpMy+xfiwL8+A0uv3ER/5csbRqgQTvQtxWYxXIUC2GXA
         L3VlOMpgNg2F7JeygQkP37g1aHleXylb6Q/2Gok/V8Vl/EkpcBSYZljYjo+VVhlVq3ha
         0JBNTVBFlOUnWZDg09rKUNo0oZZ/8RQibxnyNL11tJTf1atQtqTGrlFetbJwe4YsuckP
         u+U7Av839byAjiaCLPqw7r05Ed8+bRW2wKRE5cBQuiAM4oZJbUxZxKzLoR+PWBMnMjvb
         nicg==
X-Gm-Message-State: ACgBeo3wrIUTagmZwGamWJWsDoA5KpMT/Lvsvkhj1PZtEdCAJc4KNHsD
        tprq/7zAk0qbDxOjwO5OTc5Fc8g1prhizUCbrY8=
X-Google-Smtp-Source: AA6agR6ARo4dD4hc1YpgGSU6KS0brc6AUkEXv5WLP1LgTy3Qtdb+aiJbaM9PP5sF8yy2rjDS6FT86oUVVLXpEftniv4=
X-Received: by 2002:a05:6402:1a4f:b0:44e:f731:f7d5 with SMTP id
 bf15-20020a0564021a4f00b0044ef731f7d5mr1233017edb.357.1662519770220; Tue, 06
 Sep 2022 20:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008be47905e7e08b85@google.com> <YxXZT6NxSSLufivZ@krava>
In-Reply-To: <YxXZT6NxSSLufivZ@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Sep 2022 20:02:39 -0700
Message-ID: <CAADnVQKthoffNDuO8TsjyCx1JF8jvsyh_pvmT+Q3yB493OeQeA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in bpf_bprintf_prepare (2)
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     syzbot <syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 5, 2022 at 4:11 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sun, Sep 04, 2022 at 02:21:23PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    7fd22855300e Add linux-next specific files for 20220831
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e5668b080000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3e56c1a274c93753
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2251879aa068ad9c960d
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dc728b080000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164748d7080000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2251879aa068ad9c960d@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 3601 at kernel/bpf/helpers.c:769 try_get_fmt_tmp_buf kernel/bpf/helpers.c:769 [inline]
> > WARNING: CPU: 1 PID: 3601 at kernel/bpf/helpers.c:769 bpf_bprintf_prepare+0xf31/0x11a0 kernel/bpf/helpers.c:817
> > Modules linked in:
> > CPU: 1 PID: 3601 Comm: strace-static-x Not tainted 6.0.0-rc3-next-20220831-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > RIP: 0010:try_get_fmt_tmp_buf kernel/bpf/helpers.c:769 [inline]
> > RIP: 0010:bpf_bprintf_prepare+0xf31/0x11a0 kernel/bpf/helpers.c:817
> > Code: ff e8 93 9f ea ff 48 83 7c 24 08 00 41 bd 04 00 00 00 0f 85 8a fa ff ff e8 7c 9f ea ff 8d 6b 03 e9 f7 f6 ff ff e8 6f 9f ea ff <0f> 0b 65 ff 0d 8e ba 71 7e bf 01 00 00 00 41 bc f0 ff ff ff e8 16
> > RSP: 0018:ffffc90003cfeb70 EFLAGS: 00010093
> > RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
> > RDX: ffff8880219b3a80 RSI: ffffffff819186b1 RDI: 0000000000000005
> > RBP: ffffc90003cfeca0 R08: 0000000000000005 R09: 0000000000000003
> > R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000003
> > R13: 0000000000000004 R14: ffffc90003cfed58 R15: 0000000000000003
> > FS:  0000000001655340(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020003000 CR3: 0000000074d58000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  ____bpf_trace_printk kernel/trace/bpf_trace.c:383 [inline]
> >  bpf_trace_printk+0xab/0x170 kernel/trace/bpf_trace.c:374
> >  bpf_prog_0605f9f479290f07+0x2f/0x33
> >  bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
> >  __bpf_prog_run include/linux/filter.h:594 [inline]
> >  bpf_prog_run include/linux/filter.h:601 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
> >  bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
> >  __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
> >  trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
> >  __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
> >  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
> >  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
> >  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> >  do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
> >  _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
> >  ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
> >  bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:374
> >  bpf_prog_0605f9f479290f07+0x2f/0x33
> >  bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
> >  __bpf_prog_run include/linux/filter.h:594 [inline]
> >  bpf_prog_run include/linux/filter.h:601 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
> >  bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
> >  __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
> >  trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
> >  __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
> >  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
> >  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
> >  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> >  do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
> >  _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
> >  ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
> >  bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:374
> >  bpf_prog_0605f9f479290f07+0x2f/0x33
> >  bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
> >  __bpf_prog_run include/linux/filter.h:594 [inline]
> >  bpf_prog_run include/linux/filter.h:601 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
> >  bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
> >  __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
> >  trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
> >  __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
> >  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
> >  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
> >  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> >  do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
> >  _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
> >  ____bpf_trace_printk kernel/trace/bpf_trace.c:388 [inline]
> >  bpf_trace_printk+0xcf/0x170 kernel/trace/bpf_trace.c:374
> >  bpf_prog_0605f9f479290f07+0x2f/0x33
> >  bpf_dispatcher_nop_func include/linux/bpf.h:904 [inline]
> >  __bpf_prog_run include/linux/filter.h:594 [inline]
> >  bpf_prog_run include/linux/filter.h:601 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2046 [inline]
> >  bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2083
> >  __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
> >  trace_contention_begin+0xc0/0x150 include/trace/events/lock.h:95
> >  __mutex_lock_common kernel/locking/mutex.c:605 [inline]
> >  __mutex_lock+0x13c/0x1350 kernel/locking/mutex.c:747
> >  __pipe_lock fs/pipe.c:103 [inline]
> >  pipe_write+0x132/0x1be0 fs/pipe.c:431
> >  call_write_iter include/linux/fs.h:2188 [inline]
> >  new_sync_write fs/read_write.c:491 [inline]
> >  vfs_write+0x9e9/0xdd0 fs/read_write.c:578
> >  ksys_write+0x1e8/0x250 fs/read_write.c:631
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> looks like __bpf_trace_contention_begin needs bpf_prog_active check
> (like below untested), which would prevent the recursion and bail
> out after 2nd invocation
>
> should be easy to reproduce, will check
>
> jirka
>
>
> ---
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 6a13220d2d27..481b057cc8d9 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -4,6 +4,8 @@
>
>  #ifdef CONFIG_BPF_EVENTS
>
> +DECLARE_PER_CPU(int, bpf_prog_active);
> +
>  #undef __entry
>  #define __entry entry
>
> @@ -82,7 +84,11 @@ static notrace void                                                  \
>  __bpf_trace_##call(void *__data, proto)                                        \
>  {                                                                      \
>         struct bpf_prog *prog = __data;                                 \
> +       if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))      \
> +               goto out;                                               \
>         CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(prog, CAST_TO_U64(args));  \
> +out:                                                                   \
> +        __this_cpu_dec(bpf_prog_active);

I don't think we can use this big hammer here.
raw_tp progs attached to different hooks need to
run on the same cpu otherwise we will lose events.
