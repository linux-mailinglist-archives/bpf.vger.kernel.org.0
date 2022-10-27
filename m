Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D4360F671
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 13:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiJ0Lpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 07:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiJ0Lp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 07:45:29 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C63A162;
        Thu, 27 Oct 2022 04:45:28 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-36a4b86a0abso11089777b3.7;
        Thu, 27 Oct 2022 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh53vd22mwF1Y1C5Jt4I2djem762GVNc/l7tAg9eyEM=;
        b=bv9S8pv9I1H9msl8qSDwehmXqnPXu0X6ihYOMsoWINe+Us3OSqBuJGwKIEWbVx84Gn
         HmQfTK4wCOUoqDg335RNdDNmBAbmlTC0Fks4Skpy408jiwRh5r4GwT7t5/PXWnmm7Hal
         OjeEdRGwV4oR36VI9FW04+mb7ZpXafknRt7+aOTcCH1OGiKXbtLO2rC9/u1hCKLiW4I0
         ZM9PsZXf8+jgo48IhXT0/hh5gOSMT+zsvVspWHypSLS5uQA0bi+PWlO/lrppQmstMIaH
         0rsICSDec4Fcb/5Z3zz/1iBoI3J8qe3Sf7N+/mgx95dFIlJ2A5Tyl/KtmVFBb1mr/OHT
         f2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh53vd22mwF1Y1C5Jt4I2djem762GVNc/l7tAg9eyEM=;
        b=NqFlbUe2+g6UuRTEzH8CT4MQpG4MHSj9Qz4UWGHQAeoVFOf5PORhQhrP8DtJDtWKQV
         EycX73RHtuok11uMNo38uMHWPgh/tdKXT8Q27e7D7atTad2CjdX5hIvZ9WQBfk7lxfrG
         b4L88m66VXxnAzXFpqEp+8WH5gbxKoi6j3Nf6621bPkhUNqjbi0lvWIWc65ZhvCMr4v6
         vwEFc4dQdmIEHECt7Fsi5PfuxaWP81UeTTnFBecNaD8IxP+aeYLCs923A1NO79wjcT8X
         vQP2vMuPr+KzBk00EQxm4L2e7Tjd+sNq/1nY7/BNaAohjyTUO7XcGTrFyBxokRucv/I0
         tH1Q==
X-Gm-Message-State: ACrzQf2Awk2k8raMCF+7muJdYpHKaojhn1hqy+QzJFXPkj60wB4XAbLE
        l9ftaX1cQIqaucycGkXxZQlaWjXj/L5rBNkoOQ==
X-Google-Smtp-Source: AMsMyM6PRoCD08t/qzrBeZ9nJ4Vu1tfTU1onjr+6nA6hqXDI9oUU/0i8wUwoXBylFGwtGvNAVejztZBoqf4XN2vVdhg=
X-Received: by 2002:a0d:fa45:0:b0:368:5bc3:8db3 with SMTP id
 k66-20020a0dfa45000000b003685bc38db3mr36207376ywf.104.1666871127627; Thu, 27
 Oct 2022 04:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com>
 <Y1pqWPRmP0M+hcXf@krava>
In-Reply-To: <Y1pqWPRmP0M+hcXf@krava>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 27 Oct 2022 19:45:16 +0800
Message-ID: <CACkBjsbP-iw-gpnYN=Ormcu2zXAeOgjeptjGAFXNNJRRVhRAag@mail.gmail.com>
Subject: Re: WARNING in bpf_bprintf_prepare
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrii@kernel.org, ast@kernel.org, bpf <bpf@vger.kernel.org>,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com
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

Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8827=E6=97=A5=
=E5=91=A8=E5=9B=9B 19:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 27, 2022 at 10:27:28AM +0800, Hao Sun wrote:
> > Hi,
> >
> > The following warning can be triggered with the C reproducer in the lin=
k.
> > Syzbot also reported this several days ago, Jiri posted a patch that
> > uses bpf prog `active` field to fix this by 05b24ff9b2cfab (bpf:
> > Prevent bpf program recursion...) according to syzbot dashboard
> > (https://syzkaller.appspot.com/bug?id=3D179313fb375161d50a98311a28b8e2f=
c5f7350f9).
> > But this warning can still be triggered on 247f34f7b803
> > (Linux-v6.1-rc2) that already merged the patch, so it seems that this
> > still is an issue.
> >
> > HEAD commit: 247f34f7b803 Linux 6.1-rc2
> > git tree: upstream
> > console output: https://pastebin.com/raw/kNw8JCu5
> > kernel config: https://pastebin.com/raw/sE5QK5HL
> > C reproducer: https://pastebin.com/raw/X96ASi27
>
> hi,
> right, that fix addressed that issue for single bpf program,
> and it won't prevent if there are multiple programs hook on
> contention_begin tracepoint and calling bpf_trace_printk,
>
> I'm not sure we can do something there.. will check
>
> do you run just the reproducer, or you load the server somehow?
> I cannot hit the issue so far
>

Hi,

Last email has format issues, resend it here.

I built the kernel with the config in the link, which contains
=E2=80=9CCONFIG_CMDLINE=3D"earlyprintk=3Dserial net.ifnames=3D0
sysctl.kernel.hung_task_all_cpu_backtrace=3D1 panic_on_warn=3D1 =E2=80=A6=
=E2=80=9D, and
boot the kernel with normal qemu setup and then the warning can be
triggered by executing the reproducer.

Also, I=E2=80=99m willing to test the proposed patch if any.

Thanks
Hao

> thanks,
> jirka
>
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 6 PID: 6850 at kernel/bpf/helpers.c:770
> > try_get_fmt_tmp_buf kernel/bpf/helpers.c:770 [inline]
> > WARNING: CPU: 6 PID: 6850 at kernel/bpf/helpers.c:770
> > bpf_bprintf_prepare+0xf6a/0x1170 kernel/bpf/helpers.c:818
> > Modules linked in:
> > CPU: 6 PID: 6850 Comm: a.out Not tainted 6.1.0-rc2-dirty #23
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.13.0-1ubuntu1.1 04/01/2014
> > RIP: 0010:try_get_fmt_tmp_buf kernel/bpf/helpers.c:770 [inline]
> > RIP: 0010:bpf_bprintf_prepare+0xf6a/0x1170 kernel/bpf/helpers.c:818
> > Code: c6 e8 ba 51 00 07 83 c0 01 48 98 48 01 c5 48 89 6c 24 08 e8 b8
> > 0a eb ff 8d 6b 02 83 44 24 10 01 e9 2d f5 ff ff e8 a6 0a eb ff <0f> 0b
> > 65 ff 0d 85 bf 7c 7e bf 01 00 00 00 41 bc f0 ff ff ff e8 2d
> > RSP: 0018:ffffc90015a96c20 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88814f8057c0
> > RDX: 0000000000000000 RSI: ffff88814f8057c0 RDI: 0000000000000002
> > RBP: ffffc90015a96d50 R08: ffffffff818681ba R09: 0000000000000003
> > R10: 0000000000000005 R11: fffffbfff1a25ab2 R12: 0000000000000003
> > R13: 0000000000000004 R14: ffffc90015a96e08 R15: 0000000000000003
> > FS:  00007f012f4d2440(0000) GS:ffff8880b9d80000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f012f19ac28 CR3: 0000000148da3000 CR4: 0000000000350ee0
> > Call Trace:
> >  <TASK>
> >  ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
> >  bpf_trace_printk+0xab/0x420 kernel/trace/bpf_trace.c:376
> >  bpf_prog_0605f9f479290f07+0x2f/0x33
> >  bpf_dispatcher_nop_func include/linux/bpf.h:963 [inline]
> >  __bpf_prog_run include/linux/filter.h:600 [inline]
> >  bpf_prog_run include/linux/filter.h:607 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2254 [inline]
> >  bpf_trace_run2+0x14d/0x3d0 kernel/trace/bpf_trace.c:2293
> >  __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
> >  __traceiter_contention_begin+0x56/0x90 include/trace/events/lock.h:95
> >  trace_contention_begin include/trace/events/lock.h:95 [inline]
> >  __pv_queued_spin_lock_slowpath+0x542/0xff0 kernel/locking/qspinlock.c:=
405
> >  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inli=
ne]
> >  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
> >  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> >  do_raw_spin_lock+0x204/0x2d0 kernel/locking/spinlock_debug.c:115
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
> >  _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
> >  ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> >  bpf_trace_printk+0xcf/0x420 kernel/trace/bpf_trace.c:376
> >  </TASK>
> >
> > Regards
> > Hao Sun
