Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC43839DD
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbhEQQbI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242510AbhEQQa3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 12:30:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6066AC08EB14
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 08:13:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lg14so9731732ejb.9
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bLr3dvsxNdy0UeY38eDV6Oh4VUIamKJAGy6n2/RNMI=;
        b=rlWsrHmq5zAdM7pgyI18kXkNymY1FfXFGuMchyiAVtdqJg0nEVDqJbu8FGYMgJsG0W
         cN3Nqnq2CYCmKguPiAYhgUJK/tR634A4vE3TmGkMFnZTOCFFwTrPPDPBjWgY0qyCm86V
         Mk17Ak1Hf6uSbTwakS3enaCGsYsJL/h/qCo+/N5FvQ/kOry7+dtQKkd2guN833JcQasW
         CfnkI5aek693W7Fezpj66GVdwC6kJz3yC21KZnYPy59riueTx9/NVxidckIjI7BocI7o
         dKiMmGv7Tm1Km1ccCMJyTSmV/yqhJFh3ctvTCIgSGUZF7LXi3Qghvvnhi7u3uLdpafQE
         ZbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bLr3dvsxNdy0UeY38eDV6Oh4VUIamKJAGy6n2/RNMI=;
        b=ev0o5jFfFCTk5soSxav8OiWocuqe/gGngawBm9RMqNhu6EPx1RR2BflpO8aY2eVQhJ
         Q5nKlVULrwtzI264clLnXl2ExdNHF0wM1ymdgw3Tm1xNKaROIH4ndRyxvIEj+f6t0ctQ
         eAXi5nbaKxaReklKngkw1Z60E/HF/EXKLJyDV5Upe6u+cPNZ6haRMSBjmSkFA5XKtVxz
         tpjAQ3pj1mki0GNAxPttzmioLz0/kxN8nEOg08ImsII9d5UjzdQFAFVEjXt9xex3YLz3
         +g1CFZ51A1OFfjJ4hYTnCoowDRP7LrhRDJzuc+GG9hbiU/6/voZubitgqWqzPVCWedSa
         lS1g==
X-Gm-Message-State: AOAM532RcvksUKZdNOXGcJJFNM7Q20k1xk8WtLmjAgKMWEkWOAkwmA4c
        BL+ATSbsuuqxAezJUrf8yGeDZMn3nJ3YxZLu
X-Google-Smtp-Source: ABdhPJym5QZ4FYRp7TfXalnYbGIbyw5cQdgn57wJi8tqK6Rf9et6IBeHqw4nt+SMZT3FfudOSaEqqw==
X-Received: by 2002:a17:906:66cb:: with SMTP id k11mr411572ejp.9.1621264424450;
        Mon, 17 May 2021 08:13:44 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id i8sm11361874edu.64.2021.05.17.08.13.42
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:13:43 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id z17so6793589wrq.7
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 08:13:42 -0700 (PDT)
X-Received: by 2002:a5d:6285:: with SMTP id k5mr241611wru.50.1621264422296;
 Mon, 17 May 2021 08:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006a77d205c284e0d2@google.com> <CA+FuTSfjaqntvGGJAWc=QxWFkTPrXF+Ed9rkUKM8sor4=ZAK+Q@mail.gmail.com>
 <CACT4Y+ZL4cZwTM=_Etizj+gXykxBLU2t6XCb-yA1d0S4N6L3LQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZL4cZwTM=_Etizj+gXykxBLU2t6XCb-yA1d0S4N6L3LQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 17 May 2021 11:13:04 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeoNgY_kc-zjUc0644k3_YyWfO==ezoi1D=rbjppPrxYA@mail.gmail.com>
Message-ID: <CA+FuTSeoNgY_kc-zjUc0644k3_YyWfO==ezoi1D=rbjppPrxYA@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in virtio_net_hdr_to_skb
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+106457891e3cf3b273a9@syzkaller.appspotmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Alexander Potapenko <glider@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tanner Love <tannerlove@google.com>,
        Xie He <xie.he.0141@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 17, 2021 at 10:57 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, May 17, 2021 at 4:06 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Mon, May 17, 2021 at 7:27 AM syzbot
> > <syzbot+106457891e3cf3b273a9@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    4ebaab5f kmsan: drop unneeded references to kmsan_context_..
> > > git tree:       https://github.com/google/kmsan.git master
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17ac508ed00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ab8076fe8508c0d3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=106457891e3cf3b273a9
> > > compiler:       Debian clang version 11.0.1-2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138f4972d00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1624ffced00000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+106457891e3cf3b273a9@syzkaller.appspotmail.com
> > >
> > > =====================================================
> > > BUG: KMSAN: uninit-value in virtio_net_hdr_to_skb+0x1414/0x14f0 include/linux/virtio_net.h:86
> >
> > No answer/fix, just initial investigation.
> >
> > This is an odd location. Line 86 is the inner if statement. Both
> > protocol and skb->protocol are clearly initialized by then. But, that
> > is also not the allocation that MSAN reports, see below.
> >
> >                         if (!skb->protocol) {
> >                                 __be16 protocol =
> > dev_parse_header_protocol(skb);
> >
> >                                 virtio_net_hdr_set_proto(skb, hdr);
> >                                 if (protocol && protocol != skb->protocol)
> >                                         return -EINVAL;
> >                         }
> >
> > The repro itself seems mostly straightforward:
> >
> > - create a packet socket
> > - enable PACKET_VNET_HDR with setsockopt(r3, 0x107, 0xf ..)
> > - bind to AF_PACKET (0x11)
> >
> > - create a pipe
> > - write to pipe[1]
> > - splice pipe[0] to the packet socket
> >
> > there are a few other calls that I think are irrelevant and/or would fail.
> >
> > Perhaps there is some race condition in device refcounting, as bind
> > operates on that?
> >
> > > CPU: 0 PID: 8426 Comm: syz-executor777 Not tainted 5.12.0-rc6-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:79 [inline]
> > >  dump_stack+0x24c/0x2e0 lib/dump_stack.c:120
> > >  kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
> > >  __msan_warning+0x5c/0xa0 mm/kmsan/kmsan_instr.c:197
> > >  virtio_net_hdr_to_skb+0x1414/0x14f0 include/linux/virtio_net.h:86
> > >  packet_snd net/packet/af_packet.c:2994 [inline]
> > >  packet_sendmsg+0x85b8/0x99d0 net/packet/af_packet.c:3031
> > >  sock_sendmsg_nosec net/socket.c:654 [inline]
> > >  sock_sendmsg net/socket.c:674 [inline]
> > >  kernel_sendmsg+0x22c/0x2f0 net/socket.c:694
> > >  sock_no_sendpage+0x205/0x2b0 net/core/sock.c:2860
> > >  kernel_sendpage+0x47a/0x590 net/socket.c:3631
> > >  sock_sendpage+0x161/0x1a0 net/socket.c:947
> > >  pipe_to_sendpage+0x3e4/0x520 fs/splice.c:364
> > >  splice_from_pipe_feed fs/splice.c:418 [inline]
> > >  __splice_from_pipe+0x5e3/0xff0 fs/splice.c:562
> > >  splice_from_pipe fs/splice.c:597 [inline]
> > >  generic_splice_sendpage+0x1d5/0x2c0 fs/splice.c:746
> > >  do_splice_from fs/splice.c:767 [inline]
> > >  do_splice+0x23c3/0x2c10 fs/splice.c:1079
> > >  __do_splice fs/splice.c:1144 [inline]
> > >  __do_sys_splice fs/splice.c:1350 [inline]
> > >  __se_sys_splice+0x8fa/0xb50 fs/splice.c:1332
> > >  __x64_sys_splice+0x6e/0x90 fs/splice.c:1332
> > >  do_syscall_64+0x9f/0x140 arch/x86/entry/common.c:48
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > RIP: 0033:0x449a39
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007f8ed790b2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
> > > RAX: ffffffffffffffda RBX: 00000000004cf518 RCX: 0000000000449a39
> > > RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
> > > RBP: 00000000004cf510 R08: 000000000004ffe0 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004cf51c
> > > R13: 000000000049e46c R14: 6d32cc5e8ead0600 R15: 0000000000022000
> > >
> > > Uninit was created at:
> > >  kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
> > >  kmsan_alloc_page+0xd0/0x1e0 mm/kmsan/kmsan_shadow.c:274
> > >  __alloc_pages_nodemask+0x827/0xf90 mm/page_alloc.c:5044
> > >  alloc_pages_current+0x7b6/0xb60 mm/mempolicy.c:2277
> > >  alloc_pages include/linux/gfp.h:561 [inline]
> > >  alloc_slab_page mm/slub.c:1653 [inline]
> > >  allocate_slab+0x364/0x1260 mm/slub.c:1793
> > >  new_slab mm/slub.c:1856 [inline]
> > >  new_slab_objects mm/slub.c:2602 [inline]
> > >  ___slab_alloc+0xd42/0x1930 mm/slub.c:2765
> > >  __slab_alloc mm/slub.c:2805 [inline]
> > >  slab_alloc_node mm/slub.c:2886 [inline]
> > >  slab_alloc mm/slub.c:2931 [inline]
> > >  kmem_cache_alloc_trace+0xc53/0x1030 mm/slub.c:2948
> > >  kmalloc include/linux/slab.h:554 [inline]
> > >  kzalloc include/linux/slab.h:684 [inline]
> > >  ____ip_mc_inc_group+0x4d7/0x10b0 net/ipv4/igmp.c:1435
> >
> > This allocates ip_mc_list, but it uses kzalloc. Can that ever count as
> > uninitialized?
>
> Yes, kzalloc should never be a source of uninitialized-ness.
> But it's not actually this kzalloc, it's underlying page allocation
> (that is allocated uninitialized, so can be source of
> uninitialized-ness).
> If it would be this kzalloc, then stack would be shorter, along the
> lines of kzalloc->kmem_cache_alloc_trace->kmsan_save_stack_with_flags.
>
> This smells like a wild access in virtio_net_hdr_to_skb, which just
> hit a random uninit somewhere.
> Searching for virtio_net_hdr_to_skb I found this:
>
> KASAN: use-after-free Read in eth_header_parse_protocol
> https://syzkaller.appspot.com/bug?id=a486048b63065fd224f57b16d5a2fdece2b40eca
>
> Can it be a dup of that bug?

Great find.

That commit is not yet present at kmsan.git at 4ebaab5fb428.

Certainly sounds plausible.
