Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7846080F5
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJUVw7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJUVw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:52:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D499A2A8A7E
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:52:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t186so4775439yba.12
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+iB1avfMUtaVh18uLZ7p0dXh1Zz9AyjjEzNxxQZxPGM=;
        b=eqzBo705DUJCn3T95QOAhLcb7AOUS4Quf6BmIC2OJEsmbLDzB68LWzLmGJtB0u+YIa
         wlA8cOEl0Lvur9ZEj0/oXqEb3V+07q9i+84FxeLlwBM344E/unP4Kaqo3fz0klwGZoJH
         e1SpD0WyZ/bZ6+zu3YMnVmvpQ1gIQYxVkzMLczNTVQjQmPDQ3dsliVxXwRYwrKEIekUD
         1Q/eAC/gIZ79gG3nm7FivsD9f/g4LY6R7/7eGrgY4/qTitJWICISgT5QiI8Da8oeAqOg
         CDdx5+7rQeqR1Oqz4CIpxs/8hqQIUTlDSadfyIvQ6gG07C2OBnRFn2s3HeFw3O1jzWEy
         V8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iB1avfMUtaVh18uLZ7p0dXh1Zz9AyjjEzNxxQZxPGM=;
        b=uHk7YsPfhbDkueekFMefcHWcSDMB7z9a8maYkNdGWEXShtAkBqajqo8Tj4d748WBiH
         YStxz/kpI4BDayz095/yNcBUweRl/8AFzK0B9gc9ebJF0cRHwS0gFpgzUMf3xwWvKK/n
         JRwwGel/32W76YIDF08K7n0MPzTq5RqvLhDemWGKMg3kkfnsfjGMuzg8M8srCpMwca6S
         opgdi42uYDKtwL7pF5oRO9CSjii7EfjmSghmGUxKNzQ/4hsKaBAytiE+OTnWSTTcCsuk
         AITCrblghNLmkvyUXXMGyU+VJOks5K5sKqOcXIC6d0de6lmztIoHDF+KhsKwDSew+eBS
         aUAw==
X-Gm-Message-State: ACrzQf0VZdsINeZ/FbvxrqzhWhoDNGFKEhrfOBzMCT+/ETtHTk3B1POW
        8T9vqhuHb0q9hqqo5GjzguxOctyHZTkVBWif6pFGAC2rLZYoyQ==
X-Google-Smtp-Source: AMsMyM5uxt7FKYLtjJ8frs4yggeb3qCC1JIvKfPpTiW95zXvKFyuLH6Fh4Sf/vqD23XI4DeS5byxPmICDT43FGagdzA=
X-Received: by 2002:a5b:cc4:0:b0:6ae:2a6c:59e6 with SMTP id
 e4-20020a5b0cc4000000b006ae2a6c59e6mr18314806ybr.59.1666389176846; Fri, 21
 Oct 2022 14:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009fa63105eb7648d8@google.com> <00000000000031aec805eb76a2d4@google.com>
 <20221020182155.ecd44ee984b1aeb2e5a2e8ed@linux-foundation.org> <CAJuCfpEh0byROe58H_FtL+NMLKAvSrQW0f0wd3QiVTBdRg5CTA@mail.gmail.com>
In-Reply-To: <CAJuCfpEh0byROe58H_FtL+NMLKAvSrQW0f0wd3QiVTBdRg5CTA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Oct 2022 14:52:45 -0700
Message-ID: <CAJuCfpF7xsZJevfj6ERsJi5tPFj0o6FATAm4k=CMsONFG86EmQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in vm_area_dup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com>,
        bigeasy@linutronix.de, bpf@vger.kernel.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 6:58 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Oct 20, 2022 at 6:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 20 Oct 2022 05:40:43 -0700 syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com> wrote:
> >
> > > syzbot has found a reproducer for the following issue on:
> >
> > Thanks.
> >
> >
> > > HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
> > > git tree:       linux-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=170a8016880000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b910411d3d253dab25d8
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e0372880000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1770d752880000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com
> > >
> > > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> >
> > This is happening under dup_anon_vma_name().
> >
> > I can't spot preemption being disabled on that call path, and I assume
> > this code has been exercised for some time.
>
> Indeed, it is unclear why copy_vma() would be called in atomic
> context. I'll try to reproduce tomorrow. Maybe with lockdep enabled we
> can get something interesting.

Sorry for the delay. Having trouble booting the image built with the
attached config. My qemu crashes with a "sched: CPU #1's llc-sibling
CPU #0 is not on the same node! [node: 1 != 0]." warning before the
crash. Trying to figure out why.
defconfig with CONFIG_ANON_VMA_NAME=y boots fine but does not
reproduce the issue.

>
> >
> > I wonder if this could be fallout from the KSM locking error which
> > https://lkml.kernel.org/r/8c86678a-3bfb-3854-b1a9-ae5969e730b8@redhat.com
> > addresses.  Seems quite unlikely.
> >
> > > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3602, name: syz-executor107
> > > preempt_count: 1, expected: 0
> > > RCU nest depth: 0, expected: 0
> > > INFO: lockdep is turned off.
> > > Preemption disabled at:
> > > [<0000000000000000>] 0x0
> > > CPU: 0 PID: 3602 Comm: syz-executor107 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
> > >  might_alloc include/linux/sched/mm.h:274 [inline]
> > >  slab_pre_alloc_hook mm/slab.h:727 [inline]
> > >  slab_alloc_node mm/slub.c:3323 [inline]
> > >  slab_alloc mm/slub.c:3411 [inline]
> > >  __kmem_cache_alloc_lru mm/slub.c:3418 [inline]
> > >  kmem_cache_alloc+0x2e6/0x3c0 mm/slub.c:3427
> > >  vm_area_dup+0x81/0x380 kernel/fork.c:466
> > >  copy_vma+0x376/0x8d0 mm/mmap.c:3216
> > >  move_vma+0x449/0xf60 mm/mremap.c:626
> > >  __do_sys_mremap+0x487/0x16b0 mm/mremap.c:1075
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7fd090fa5b29
> > > Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffc2e90bd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> > > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd090fa5b29
> > > RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
> > > RBP: 00007fd090f69cd0 R08: 00000000202ef000 R09: 0000000000000000
> > > R10: 0000000000000003 R11: 0000000000000246 R12: 00007fd090f69d60
> > > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > >  </TASK>
