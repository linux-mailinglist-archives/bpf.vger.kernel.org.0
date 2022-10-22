Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782806082D0
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 02:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJVAWk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 20:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJVAWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 20:22:39 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CD52B4147
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 17:22:37 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id o5so1322615vsc.0
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 17:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=93BGuosjA6Wu0xeSlrIGtuCH7vSrjSnpUerGqSJFtNA=;
        b=RFL0PO7E8HA28xHg4parvVwpFKpWV6ON8wn65ue37ToHWccEFksz25Q5y3xzQvWmEo
         Re/ejMEiZW2Ko1gt8pYmcErJBzggaNcPzYvFT1006z4ifdBAaTgyMDRiGA2ZsVx040Q5
         oZ7UQZY68d51B+WyCgaOeoJ52CmEMrK/aBOC/Xqq+CZcD9YDFtnP0aJ/Bj99glhKllYy
         Ick/JyqEhrXwjIxGl2Bhd8faNhpbGw1Y8cohYzmPi6Kho+KPXue10Jmt+aqmqR9e2yFm
         I0vE37okygJie8BgSaX/N8eYzj+b2ohlRPLi45IkFG2CddonyJ18yXv1+0R+8iOOp/o3
         ejaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93BGuosjA6Wu0xeSlrIGtuCH7vSrjSnpUerGqSJFtNA=;
        b=5jTKrFOCkSRIpua0KlPadVnN6/ntyMTnnQMAMqop223+Ur4Oh2jTWF5wZBO6JJtNh9
         yCZgaI/D69/qoLdC5FOR1LoFoqWgerfe7FbR3tf5+fQsnJ/I9X0kBM9eNRB4wxogEI2s
         NOtzurvq/GHq9q4owPu6RuYCh1sYuUJiSsNVOaAk2VAFkxLN1KxnaY/jY9EYRAfXA5ru
         kJ8eitaJ2DCt46Z+BnkhqSaizQwb5+fYaIIhi5Ww7Qh/hRXXjSM0xRGtyxHxs3aeIFdf
         OMxyLHfPL+ZFo/9/ec2Af0QJb8CTYFmye2eA+KxVV7CP+p1pGA4uSA3rFlHEdnNgo4lD
         x+Xg==
X-Gm-Message-State: ACrzQf0X4ofi9/gq2WXs+T+532bfyzJYMUNRtJ9fQHmrhCn1F7+6aUak
        Lt0/aowVJx3AbaXD1wF6MDfvh8jMLh2b5oz2VNT84w==
X-Google-Smtp-Source: AMsMyM5bjGn8jIDMb3tZC3S54U7894nKX04YDfHLvtcav9oTj2zeVuL1k7+gCCE8F+d1m9YPOjQBZcIQdFwJ8X9DqYY=
X-Received: by 2002:a05:6102:318c:b0:3a7:acd4:a5fc with SMTP id
 c12-20020a056102318c00b003a7acd4a5fcmr14840610vsh.48.1666398156354; Fri, 21
 Oct 2022 17:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009fa63105eb7648d8@google.com> <00000000000031aec805eb76a2d4@google.com>
 <20221020182155.ecd44ee984b1aeb2e5a2e8ed@linux-foundation.org>
 <CAJuCfpEh0byROe58H_FtL+NMLKAvSrQW0f0wd3QiVTBdRg5CTA@mail.gmail.com>
 <CAJuCfpF7xsZJevfj6ERsJi5tPFj0o6FATAm4k=CMsONFG86EmQ@mail.gmail.com>
 <CANp29Y7aNP+0hd01feB24XrCUPVa0+7kf7NiDAV_FdhPx2VkOQ@mail.gmail.com> <CAJuCfpF0eYsNZjQO4OcT8Pnaj9+H8UK_o4bwtLzD=n53-48hJw@mail.gmail.com>
In-Reply-To: <CAJuCfpF0eYsNZjQO4OcT8Pnaj9+H8UK_o4bwtLzD=n53-48hJw@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 21 Oct 2022 17:22:25 -0700
Message-ID: <CANp29Y4Q3X_KqxjajigGHXHFaY54vEdYkPf+5tcg3k2YyRh+jw@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in vm_area_dup
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com>,
        bigeasy@linutronix.de, bpf@vger.kernel.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 4:50 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Oct 21, 2022 at 4:12 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > On Fri, Oct 21, 2022 at 2:52 PM 'Suren Baghdasaryan' via
> > syzkaller-bugs <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Thu, Oct 20, 2022 at 6:58 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Thu, Oct 20, 2022 at 6:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Thu, 20 Oct 2022 05:40:43 -0700 syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > > syzbot has found a reproducer for the following issue on:
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > > HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
> > > > > > git tree:       linux-next
> > > > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=170a8016880000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=b910411d3d253dab25d8
> > > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e0372880000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1770d752880000
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com
> > > > > >
> > > > > > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> > > > >
> > > > > This is happening under dup_anon_vma_name().
> > > > >
> > > > > I can't spot preemption being disabled on that call path, and I assume
> > > > > this code has been exercised for some time.
> > > >
> > > > Indeed, it is unclear why copy_vma() would be called in atomic
> > > > context. I'll try to reproduce tomorrow. Maybe with lockdep enabled we
> > > > can get something interesting.
> > >
> > > Sorry for the delay. Having trouble booting the image built with the
> > > attached config. My qemu crashes with a "sched: CPU #1's llc-sibling
> > > CPU #0 is not on the same node! [node: 1 != 0]." warning before the
> > > crash. Trying to figure out why.
> >
> > qemu 6.2 changed the core-to-socket assignment and it looks like we
> > get such errors when a kernel with "numa=fake=" is run under qemu on a
> > system with multiple CPUs.
> >
> > You can try removing numa=fake=... from the CMDLINE config or just
> > manually setting the smp argument of the qemu process (e.g. -smp
> > 2,sockets=2,cores=1)
> >
> > See https://gitlab.com/qemu-project/qemu/-/issues/877
>
> That was it. Thank you, Aleksandr!
> I can boot with the image built using the attached config but still
> can't reproduce the issue using the C reproducer... Will keep it
> running for some time to see if it eventually shows up.

Just in case -- did you also try executing the reproducer against the
attached bootable disk image? Syzbot attaches the exact images on
which it managed to find the bug. The image should work for both GCE
and qemu.

> Thanks,
> Suren.
>
> >
> > > defconfig with CONFIG_ANON_VMA_NAME=y boots fine but does not
> > > reproduce the issue.
> > >
> > > >
> > > > >
> > > > > I wonder if this could be fallout from the KSM locking error which
> > > > > https://lkml.kernel.org/r/8c86678a-3bfb-3854-b1a9-ae5969e730b8@redhat.com
> > > > > addresses.  Seems quite unlikely.
> > > > >
> > > > > > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3602, name: syz-executor107
> > > > > > preempt_count: 1, expected: 0
> > > > > > RCU nest depth: 0, expected: 0
> > > > > > INFO: lockdep is turned off.
> > > > > > Preemption disabled at:
> > > > > > [<0000000000000000>] 0x0
> > > > > > CPU: 0 PID: 3602 Comm: syz-executor107 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > > > >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
> > > > > >  might_alloc include/linux/sched/mm.h:274 [inline]
> > > > > >  slab_pre_alloc_hook mm/slab.h:727 [inline]
> > > > > >  slab_alloc_node mm/slub.c:3323 [inline]
> > > > > >  slab_alloc mm/slub.c:3411 [inline]
> > > > > >  __kmem_cache_alloc_lru mm/slub.c:3418 [inline]
> > > > > >  kmem_cache_alloc+0x2e6/0x3c0 mm/slub.c:3427
> > > > > >  vm_area_dup+0x81/0x380 kernel/fork.c:466
> > > > > >  copy_vma+0x376/0x8d0 mm/mmap.c:3216
> > > > > >  move_vma+0x449/0xf60 mm/mremap.c:626
> > > > > >  __do_sys_mremap+0x487/0x16b0 mm/mremap.c:1075
> > > > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > > > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > > > > RIP: 0033:0x7fd090fa5b29
> > > > > > Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > > > > > RSP: 002b:00007ffc2e90bd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> > > > > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd090fa5b29
> > > > > > RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
> > > > > > RBP: 00007fd090f69cd0 R08: 00000000202ef000 R09: 0000000000000000
> > > > > > R10: 0000000000000003 R11: 0000000000000246 R12: 00007fd090f69d60
> > > > > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > > >  </TASK>
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAJuCfpF7xsZJevfj6ERsJi5tPFj0o6FATAm4k%3DCMsONFG86EmQ%40mail.gmail.com.
