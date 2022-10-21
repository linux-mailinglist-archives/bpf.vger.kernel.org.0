Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5526606D4B
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 03:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJUB65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 21:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJUB64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 21:58:56 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA8A158D56
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:58:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 63so1720258ybq.4
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 18:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZncWdL3mM95UrAjtlnMYK6cfS00d+HEAMrkP+Zaf3vA=;
        b=ETCDQ1V0Rav1JUKf7JrFXd/bCduUcFQSGNKFTEgHoxSvIBzuBRYzSFf5jfF8MfgzNS
         655pcJShWcEHHLby6HitiQxsf2tdeTpbHml6ZpXhrXN0hec/Tq6PbCOMdN2WUdVGrp99
         I/oMpE8qoZwo+YYe6hG9kY2kjw1eo0qnDlEBHd2kfm7+T71jN4FH0P+AxEt2ZJ2Yz2Ne
         U1iEAgwV2/K0iBNG0n6pgDll8zJMPZEGjUXkDJM2B78l3mR9XaKGv+cXh9jXerF2Ed+n
         LN+BMVqANeeZ++6dvFeFgZ4bI511bPfP45wQko6FQgvJRz7QeGzO9IEWDVQ+QXQAYNYU
         O1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZncWdL3mM95UrAjtlnMYK6cfS00d+HEAMrkP+Zaf3vA=;
        b=C75CMy/3k2DbDjkENMjuEZWtjnZSRNlpe+Bw/PbdeX+CJ8sPzdtgDMAlfsBzZUccpI
         c7RKsRkE9zdHXarZKhCYtPZkoH2RTQrGuCMAyOTCANYivewRZYLfBxAPVH9JTw8+h3JX
         XkBd7QV4US5WuPI7EM4YkiA4FRzBxF/YkKRK/4vkA8Qb21mpfM7HzYtlV8Z9hTRnACA3
         mhYcZ5bA9OKdZe6h9Gxbm93ysablVD/hlv22lbJ5O917QfsD4JQTQYM3gNB0D5RE88hv
         uctHSk8CBYLZCfJ3jJr22IWx6NMCo5rYgWw5GxkWkVBbflSu22JlKXEqZjqF4QdCu0vv
         K8VQ==
X-Gm-Message-State: ACrzQf307ShinTztm0ydWg2RCa1jMzoek3rAXwEBEqqjCzrd2P6d4sYN
        67stiDKyxMCg7QCSq96ssvdcfN7E09LJbjS1yZy95YUdQ7eenQ==
X-Google-Smtp-Source: AMsMyM7jN901gwP4uzMwLACtoi7zo6/ph3pmTGVePx+cdgkV2tfQtbyhDzKyhFUYYlMwepHes801wEytwuvP3P4sVUI=
X-Received: by 2002:a05:6902:1244:b0:6bd:6409:9591 with SMTP id
 t4-20020a056902124400b006bd64099591mr14512504ybu.431.1666317534121; Thu, 20
 Oct 2022 18:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009fa63105eb7648d8@google.com> <00000000000031aec805eb76a2d4@google.com>
 <20221020182155.ecd44ee984b1aeb2e5a2e8ed@linux-foundation.org>
In-Reply-To: <20221020182155.ecd44ee984b1aeb2e5a2e8ed@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Oct 2022 18:58:42 -0700
Message-ID: <CAJuCfpEh0byROe58H_FtL+NMLKAvSrQW0f0wd3QiVTBdRg5CTA@mail.gmail.com>
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

On Thu, Oct 20, 2022 at 6:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 20 Oct 2022 05:40:43 -0700 syzbot <syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com> wrote:
>
> > syzbot has found a reproducer for the following issue on:
>
> Thanks.
>
>
> > HEAD commit:    acee3e83b493 Add linux-next specific files for 20221020
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=170a8016880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c82245cfb913f766
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b910411d3d253dab25d8
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e0372880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1770d752880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/98cc5896cded/disk-acee3e83.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b3d3eb3aa10a/vmlinux-acee3e83.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b910411d3d253dab25d8@syzkaller.appspotmail.com
> >
> > BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
>
> This is happening under dup_anon_vma_name().
>
> I can't spot preemption being disabled on that call path, and I assume
> this code has been exercised for some time.

Indeed, it is unclear why copy_vma() would be called in atomic
context. I'll try to reproduce tomorrow. Maybe with lockdep enabled we
can get something interesting.

>
> I wonder if this could be fallout from the KSM locking error which
> https://lkml.kernel.org/r/8c86678a-3bfb-3854-b1a9-ae5969e730b8@redhat.com
> addresses.  Seems quite unlikely.
>
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3602, name: syz-executor107
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > INFO: lockdep is turned off.
> > Preemption disabled at:
> > [<0000000000000000>] 0x0
> > CPU: 0 PID: 3602 Comm: syz-executor107 Not tainted 6.1.0-rc1-next-20221020-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
> >  might_alloc include/linux/sched/mm.h:274 [inline]
> >  slab_pre_alloc_hook mm/slab.h:727 [inline]
> >  slab_alloc_node mm/slub.c:3323 [inline]
> >  slab_alloc mm/slub.c:3411 [inline]
> >  __kmem_cache_alloc_lru mm/slub.c:3418 [inline]
> >  kmem_cache_alloc+0x2e6/0x3c0 mm/slub.c:3427
> >  vm_area_dup+0x81/0x380 kernel/fork.c:466
> >  copy_vma+0x376/0x8d0 mm/mmap.c:3216
> >  move_vma+0x449/0xf60 mm/mremap.c:626
> >  __do_sys_mremap+0x487/0x16b0 mm/mremap.c:1075
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fd090fa5b29
> > Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffc2e90bd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd090fa5b29
> > RDX: 0000000000001000 RSI: 0000000000004000 RDI: 00000000201c4000
> > RBP: 00007fd090f69cd0 R08: 00000000202ef000 R09: 0000000000000000
> > R10: 0000000000000003 R11: 0000000000000246 R12: 00007fd090f69d60
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >  </TASK>
