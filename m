Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD73682F
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 01:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFEXmG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 19:42:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:32879 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFEXmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 19:42:06 -0400
Received: by mail-io1-f69.google.com with SMTP id n4so252061ioc.0
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2019 16:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=If8zYrfgMvREoNxOF+APhy3YFYkcq8XTmIhwfd8Qif4=;
        b=eJgas4pCid5aCTTLrWEHvIwo9cT7/nlNyuxyQuCBBiugfXcK8sNzzf3rEAo/T3Vnp4
         Zi0Rl1DpNYuNs8pn1Wo1FMN8YX9hZoGvePyyRAEmHshzvGVrIcMwJhrJVF54AQfk/uOo
         7ZNMQh7f/SbO2XvN8vOcNLEFN+eq7wQ1BO9Y/JwpjpCjHhY9+ssBdkZUKCqCAoJEjT6c
         q4AZARHAvoYve21Ri0KBBGd14tuTz572qMeumy10826RrjDxsPKJmv2cKzWj9e/Zbyhs
         Qj9yb7EjWUZ8zKB6PmZ/fbci5ArWX4t9cJdhtkAThb7FiNT5MIIHklEZ/EdgQcLMcPw4
         yY0Q==
X-Gm-Message-State: APjAAAXDByjYu4kjwI5Ix2LxaezVEXMaG+iz901Fd0vmoQjkFy5WHpta
        dwGyvrju/D4BBshZv8zfA1drIMNSqyyCVNN3TxvrrW0c3cyV
X-Google-Smtp-Source: APXvYqyv7nsvHNrQ68UBjoE3uareCjq/xghIfL2qvARCjcEuGCVrReipnpbeK7ASMfANvkONy2j3ewcak6QZD9ptXz7gkQVpxpQw
MIME-Version: 1.0
X-Received: by 2002:a24:7c45:: with SMTP id a66mr8223766itd.139.1559778125448;
 Wed, 05 Jun 2019 16:42:05 -0700 (PDT)
Date:   Wed, 05 Jun 2019 16:42:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000188da1058a9c25e3@google.com>
Subject: memory leak in vhost_net_ioctl
From:   syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        jasowang@redhat.com, john.fastabend@gmail.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org,
        xdp-newbies@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    788a0249 Merge tag 'arc-5.2-rc4' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dc9ea6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d5c73825cbdc7326
dashboard link: https://syzkaller.appspot.com/bug?extid=0789f0c7e45efd7bb643
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b31761a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124892c1a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com

udit: type=1400 audit(1559768703.229:36): avc:  denied  { map } for   
pid=7116 comm="syz-executor330" path="/root/syz-executor330334897"  
dev="sda1" ino=16461 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88812421fe40 (size 64):
   comm "syz-executor330", pid 7117, jiffies 4294949245 (age 13.030s)
   hex dump (first 32 bytes):
     01 00 00 00 20 69 6f 63 00 00 00 00 64 65 76 2f  .... ioc....dev/
     50 fe 21 24 81 88 ff ff 50 fe 21 24 81 88 ff ff  P.!$....P.!$....
   backtrace:
     [<00000000ae0c4ae0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000ae0c4ae0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000ae0c4ae0>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000ae0c4ae0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000079ebab38>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000079ebab38>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<0000000079ebab38>] vhost_net_set_backend drivers/vhost/net.c:1534  
[inline]
     [<0000000079ebab38>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1716
     [<000000009f6204a2>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000009f6204a2>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000009f6204a2>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000b45866de>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000dfb41eb8>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000dfb41eb8>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000dfb41eb8>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000049c1f547>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000029cc8ca7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812421fa80 (size 64):
   comm "syz-executor330", pid 7130, jiffies 4294949755 (age 7.930s)
   hex dump (first 32 bytes):
     01 00 00 00 01 00 00 00 00 00 00 00 2f 76 69 72  ............/vir
     90 fa 21 24 81 88 ff ff 90 fa 21 24 81 88 ff ff  ..!$......!$....
   backtrace:
     [<00000000ae0c4ae0>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:55 [inline]
     [<00000000ae0c4ae0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000ae0c4ae0>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000ae0c4ae0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000079ebab38>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000079ebab38>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  
[inline]
     [<0000000079ebab38>] vhost_net_set_backend drivers/vhost/net.c:1534  
[inline]
     [<0000000079ebab38>] vhost_net_ioctl+0xb43/0xc10  
drivers/vhost/net.c:1716
     [<000000009f6204a2>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000009f6204a2>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000009f6204a2>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000b45866de>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000dfb41eb8>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000dfb41eb8>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000dfb41eb8>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000049c1f547>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:301
     [<0000000029cc8ca7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
