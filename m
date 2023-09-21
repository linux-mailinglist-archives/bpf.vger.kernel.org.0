Return-Path: <bpf+bounces-10604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CACBB7AA580
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 01:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id DEAF3B20A71
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900792940D;
	Thu, 21 Sep 2023 23:15:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55883168B3
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 23:15:45 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C1F7
	for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 16:15:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-307d20548adso1341184f8f.0
        for <bpf@vger.kernel.org>; Thu, 21 Sep 2023 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695338141; x=1695942941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0jmxeUHMyRvSul47ykDzG/kcgtqwpKI1qC1sVJFmMs=;
        b=Uu67o6wHSCJOmW99y3/jtHtDUDAtf/NQmtb7dPJHoFi2nsTzA4MNbQoRMvDuygl3n+
         eA6WHhNZ264slaSeFY8ulm8mNBDmt0GbEzrOMf1VvTmqGgBKnXIvTEMz8iAxge9XKNq/
         86SmNvBauir3eZPjMQdzX2KiZ3RUTkRoJPgNXal7PkQ2dQs/j8tXWTAlaFQxuRT8/Nti
         JrAwTA5DmI6P8UNLwVZQ4SiFGVtx9+V2jbEwcmqmW8JH1i/YIo93kP0GnA8XwEu4a94O
         X6Y36LkX3DqpWEDoFrMrbijZMFFwnhdKwP1NzlOxSN5t1ksFxPCwGhOzl4R29uYHkTAd
         NftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695338141; x=1695942941;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0jmxeUHMyRvSul47ykDzG/kcgtqwpKI1qC1sVJFmMs=;
        b=ongSHJrYKNO50u/jNIrB2GJHoKvF8sqDOxjdR31aLZSRx54ujLmG7sFl+PnWngXxUu
         B4LjY9i9hB/iohqLPG1eRnCM7rqIdlqeY3C7GTLBr0fXmB/mklRDYAr/IcoO1YdIp1Tk
         7OExEYvBqyPD6Jj79aFDuyNorNuL5RNbFMVdt09A1HEDPaKzZ0dTo2VqobnDROJQdB+a
         crlf2gsn/axCPOuTTqsZR5yEpfb43oiQ5HdWPjjRBhrVXerLhKXrfwK/XOuoObQjUwc9
         1HGGensdHY1KWLGaeqxtMT1OKhMjkxojGWp50t6ayC0YdXa1RFzDFj7aR0esGG+0kAR8
         WXKg==
X-Gm-Message-State: AOJu0YyYhAg+XhXsfWuFm9rmiozmjEYgIY+Bf6dqLB4C4ijiVAh+90IW
	LkheSt0ibf4QG9B3WCCwmNFqEQ==
X-Google-Smtp-Source: AGHT+IEP2PI1/W7hWYftVLg/4+qyY/LqCbYhRiu1QhICRTxA7xUEXZmBZJCSCOGW/2v1WCOr5XNfoQ==
X-Received: by 2002:a5d:440b:0:b0:319:6d03:13ae with SMTP id z11-20020a5d440b000000b003196d0313aemr6267180wrq.55.1695338141414;
        Thu, 21 Sep 2023 16:15:41 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d5083000000b003198a9d758dsm2911162wrt.78.2023.09.21.16.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 16:15:40 -0700 (PDT)
Message-ID: <0d9983af-1483-d43e-810e-64ce6068a381@arista.com>
Date: Fri, 22 Sep 2023 00:15:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [net?] memory leak in tcp_md5_do_add
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <0000000000004d83170605e16003@google.com>
 <CANn89iJwQ3TCSm+SMs=W90oThgRMLoiSAcTBJ9LH2AVsJY1NBA@mail.gmail.com>
 <18267b34-1dcf-08d5-5ba1-4f5162e6c43a@arista.com>
Content-Language: en-US
In-Reply-To: <18267b34-1dcf-08d5-5ba1-4f5162e6c43a@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

On 9/21/23 18:01, Dmitry Safonov wrote:
> On 9/21/23 17:59, Eric Dumazet wrote:
>> On Thu, Sep 21, 2023 at 6:56 PM syzbot
>> <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kernel.or..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1312bba8c80000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5733ca1757172ad
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=68662811b3d5f6695bcb
>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105393a8c80000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1113917f480000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/29e7966ab711/disk-ee3f96b1.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/ae21b8e855de/vmlinux-ee3f96b1.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/803ee0425ad6/bzImage-ee3f96b1.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com
>>>
>>> executing program
>>> BUG: memory leak
>>> unreferenced object 0xffff88810a86f7a0 (size 32):
>>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
>>>   hex dump (first 32 bytes):
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>   backtrace:
>>>     [<ffffffff81533d64>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1061
>>>     [<ffffffff840edaa0>] kmalloc include/linux/slab.h:580 [inline]
>>>     [<ffffffff840edaa0>] tcp_md5sig_info_add net/ipv4/tcp_ipv4.c:1169 [inline]
>>>     [<ffffffff840edaa0>] tcp_md5_do_add+0xa0/0x150 net/ipv4/tcp_ipv4.c:1240
>>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
>>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
>>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
>>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
>>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
>>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
>>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
>>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> BUG: memory leak
>>> unreferenced object 0xffff88811225ccc0 (size 192):
>>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
>>>   hex dump (first 32 bytes):
>>>     00 00 00 00 00 00 00 00 22 01 00 00 00 00 ad de  ........".......
>>>     22 0a 80 00 fe 80 00 00 00 00 00 00 00 00 00 00  "...............
>>>   backtrace:
>>>     [<ffffffff8153444a>] __do_kmalloc_node mm/slab_common.c:966 [inline]
>>>     [<ffffffff8153444a>] __kmalloc+0x4a/0x120 mm/slab_common.c:980
>>>     [<ffffffff83d75c15>] kmalloc include/linux/slab.h:584 [inline]
>>>     [<ffffffff83d75c15>] sock_kmalloc net/core/sock.c:2635 [inline]
>>>     [<ffffffff83d75c15>] sock_kmalloc+0x65/0xa0 net/core/sock.c:2624
>>>     [<ffffffff840eb9bb>] __tcp_md5_do_add+0xcb/0x300 net/ipv4/tcp_ipv4.c:1212
>>>     [<ffffffff840eda67>] tcp_md5_do_add+0x67/0x150 net/ipv4/tcp_ipv4.c:1253
>>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
>>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
>>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
>>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
>>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
>>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
>>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
>>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> If the bug is already fixed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want syzbot to run the reproducer, reply with:
>>> #syz test: git://repo/address.git branch-or-commit-hash
>>> If you attach or paste a git patch, syzbot will apply it before testing.
>>>
>>> If you want to overwrite bug's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the bug is a duplicate of another bug, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>
>> Dmitry, please take a look at this bug, we need to fix it before your
>> patch series.
> 
> Sure, seems reasonable to me to fix before merging something on top.

It seems to me that it's related to a race between RCU grace period and
kmemleak scan period. There seems to be a patch [1] that likely fixes
that, albeit I couldn't verify it as all my attempts to reproduce syzbot
issue produced only unrelated to TCP-MD5 log:

> [  263.201211] kmemleak: unreferenced object 0xffff9ceb047d9948 (size 192):
> [  263.201781] kmemleak:   comm "ip", pid 730, jiffies 4294937874 (age 257.270s)
> [  263.202460] kmemleak:   hex dump (first 32 bytes):
> [  263.202921] kmemleak:     00 c8 e9 01 eb 9c ff ff e0 00 00 01 00 00 00 00  ................
> [  263.203700] kmemleak:     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [  263.204484] kmemleak:   backtrace:
> [  263.204814] kmemleak:     [<ffffffff830a2946>] kmalloc_trace+0x26/0x90
> [  263.205440] kmemleak:     [<ffffffff837e8310>] ____ip_mc_inc_group+0xa0/0x240
> [  263.206134] kmemleak:     [<ffffffff837e9a9b>] ip_mc_up+0x4b/0xb0
> [  263.206725] kmemleak:     [<ffffffff837e28fb>] inetdev_event+0xbb/0x5c0
> [  263.207358] kmemleak:     [<ffffffff82f3caf6>] notifier_call_chain+0x56/0xc0
> [  263.208070] kmemleak:     [<ffffffff836f1818>] __dev_notify_flags+0x58/0xf0
> [  263.208784] kmemleak:     [<ffffffff836f2210>] dev_change_flags+0x50/0x60
> [  263.209471] kmemleak:     [<ffffffff837e1718>] devinet_ioctl+0x378/0x770
> [  263.210152] kmemleak:     [<ffffffff837e34a7>] inet_ioctl+0x187/0x1d0
> [  263.210805] kmemleak:     [<ffffffff836c40ed>] sock_do_ioctl+0x3d/0x100
> [  263.211482] kmemleak:     [<ffffffff836c4293>] sock_ioctl+0xe3/0x2b0
> [  263.212131] kmemleak:     [<ffffffff8313cbec>] __x64_sys_ioctl+0x8c/0xc0
> [  263.212789] kmemleak:     [<ffffffff83a2ad75>] do_syscall_64+0x35/0x80
> [  263.213438] kmemleak:     [<ffffffff83c0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  263.214283] kmemleak: unreferenced object 0xffff9ceb03ad5400 (size 512):
> [  263.214982] kmemleak:   comm "ip", pid 730, jiffies 4294937874 (age 257.290s)
> [  263.215728] kmemleak:   hex dump (first 32 bytes):
> [  263.216231] kmemleak:     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01  ................
> [  263.217106] kmemleak:     80 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff  ................
> [  263.218041] kmemleak:   backtrace:
> [  263.218438] kmemleak:     [<ffffffff830a2946>] kmalloc_trace+0x26/0x90
> [  263.219181] kmemleak:     [<ffffffff8384b90b>] ipv6_add_addr+0x13b/0x6c0
> [  263.219931] kmemleak:     [<ffffffff8384d4b5>] add_addr+0x75/0x150
> [  263.220627] kmemleak:     [<ffffffff8385357d>] addrconf_notify+0x53d/0x730
> [  263.221377] kmemleak:     [<ffffffff82f3caf6>] notifier_call_chain+0x56/0xc0
> [  263.222104] kmemleak:     [<ffffffff836f1818>] __dev_notify_flags+0x58/0xf0
> [  263.222844] kmemleak:     [<ffffffff836f2210>] dev_change_flags+0x50/0x60
> [  263.223581] kmemleak:     [<ffffffff837e1718>] devinet_ioctl+0x378/0x770
> [  263.224293] kmemleak:     [<ffffffff837e34a7>] inet_ioctl+0x187/0x1d0
> [  263.224961] kmemleak:     [<ffffffff836c40ed>] sock_do_ioctl+0x3d/0x100
> [  263.225660] kmemleak:     [<ffffffff836c4293>] sock_ioctl+0xe3/0x2b0
> [  263.226331] kmemleak:     [<ffffffff8313cbec>] __x64_sys_ioctl+0x8c/0xc0
> [  263.227039] kmemleak:     [<ffffffff83a2ad75>] do_syscall_64+0x35/0x80
> [  263.227747] kmemleak:     [<ffffffff83c0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [  263.228708] kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

This seems to be quite the same issue: inet6_ifa_finish_destroy()
destroys inet6_ifaddr with kfree_rcu().

[1]
https://lore.kernel.org/linux-mm/ZQA064908T5nngcc@arm.com/T/#ma4a68fdc44793e2594c9e7cadefa8ea40da5807d

Thanks,
            Dmitry


