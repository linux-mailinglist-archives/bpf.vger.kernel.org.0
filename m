Return-Path: <bpf+bounces-65185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD532B1D3FD
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 10:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A19E1883D1D
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC82494F8;
	Thu,  7 Aug 2025 08:06:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D592236F4
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554016; cv=none; b=qtXTbguIB9pOoK9H6lMPzJ+eF9+n/M8c2bD6yKfzf7xVezIFXB4OVZg65ZSUmYy54c7KmKciGqiF6ngDOiuk83PwbKuBgfKfNOtMuE2I3Zqi5MIK0gI3NnPEbIpQg/uv3UC+VGnCKORzeaXj/sYwomYsucZMiVi2I0S6JiNH9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554016; c=relaxed/simple;
	bh=nyJwpKcflWB6KyyIOeLQAdbgo2iU7AbYDHvpbDdnGgs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rLwtoSFs7fHM7WbzdNnYJBBhOxqFVf1D3c5+yR/7+ExyKv7AloA77ncCQ8qTXN/YeXOM1Jzn+Uuvgb/h7ot+q0L4s3qU4ndEY+LQQPFJrayzxiC3uoaGfefEpPPpfeF4tW0oQtK97b2zu2CdOCNdZ2K6hY/HOa67q8rQFvqsV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8818f0fd38cso73250339f.0
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 01:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754554014; x=1755158814;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8p3scDZixEMjVu2rPlXknNZevyfYlJKLq4iu1bGSzA=;
        b=LAeFA436F89ZSrfNGK33j90vVI+IkWAqubQMMN7gvB0yImSrvNnLPcXoQC1XGV9tVu
         xJ69TJdk8i0JoVIWA1NiOUdZbvTlQ15zl1TobDkyIaMQwuIkOBSeKky3tEw7dgJrPZCc
         9OrY9zPpTWJHTBngsvM6jqIWBVSRc/WzBUD7jEuCLzuz4HyOFEBEn9pYrl5073FOY5so
         sfF51q3nWUSrFmm2fKlOmZtjavkepVXNwO91oRGvbPSXFoGwb1InYz5TcKCW1Glba+Cf
         wmzedZpXTNoPOar1jDe2ho8zcj9zXitqoqQJNuXFYtIczDux77MFH8OfSJ0m2C6sXP38
         UDZA==
X-Forwarded-Encrypted: i=1; AJvYcCVIMbQZgnP47ZCZ7U7CGn6lr8FH43z4F9L8QEBuvZ39UdoRQbM7RKgaG1tiP3nysAM+mQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzObWUc+D68VT6L/TgYLXIaluPG9N7WhKz2/yoydyK9l/9+5qJb
	qFSF/mx549KUWEOssndnI53PL7uTQ8MNakiaBu4I7gOjtcjSJz7Cymwe2K7ncvuT+w+uled+VQ1
	zN/G9mbPByzEjhoGKGrGrmvn7xnDd4FWczujFHyyZyaL+F8uNyYbglFvomdk=
X-Google-Smtp-Source: AGHT+IFcXOTEo+xm8RJP/u+XlmuT3WzDuANaV73aw2YJGkMV2whuVQ7VV3FiCdxL0Nv6/hCTT0qs7uhnGcjRsHcz75dLqmbnBDfK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c4:b0:881:983d:dd7b with SMTP id
 ca18e2360f4ac-8819f33b7f1mr1088746039f.8.1754554013618; Thu, 07 Aug 2025
 01:06:53 -0700 (PDT)
Date: Thu, 07 Aug 2025 01:06:53 -0700
In-Reply-To: <20250806154127.2161434-1-maciej.fijalkowski@intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68945e9d.050a0220.7f033.0041.GAE@google.com>
Subject: [syzbot ci] Re: xsk: fix immature cq descriptor production
From: syzbot ci <syzbot+ci0a6ec7a9d4421fcc@syzkaller.appspotmail.com>
To: aleksander.lobakin@intel.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, e.kubanski@partner.samsung.com, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, 
	netdev@vger.kernel.org
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] xsk: fix immature cq descriptor production
https://lore.kernel.org/all/20250806154127.2161434-1-maciej.fijalkowski@intel.com
* [PATCH v3 bpf] xsk: fix immature cq descriptor production

and found the following issue:
WARNING in xsk_create

Full report is available here:
https://ci.syzbot.org/series/ed9b41fb-c772-4c8d-ab6b-07919dac7f3f

***

WARNING in xsk_create

tree:      bpf
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf.git
base:      e8d780dcd957d80725ad5dd00bab53b856429bc0
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/ac640846-151f-4c3e-8a63-10a1d56881e1/config
syz repro: https://ci.syzbot.org/findings/34ebabe4-f302-4e4b-9951-0a44d704970a/syz_repro

------------[ cut here ]------------
kmem_cache of name 'xsk_generic_xmit_cache' already exists
WARNING: CPU: 1 PID: 6031 at mm/slab_common.c:110 kmem_cache_sanity_check mm/slab_common.c:109 [inline]
WARNING: CPU: 1 PID: 6031 at mm/slab_common.c:110 __kmem_cache_create_args+0xa3/0x320 mm/slab_common.c:307
Modules linked in:
CPU: 1 UID: 0 PID: 6031 Comm: syz.2.21 Not tainted 6.16.0-syzkaller-06699-ge8d780dcd957-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:109 [inline]
RIP: 0010:__kmem_cache_create_args+0xa3/0x320 mm/slab_common.c:307
Code: 81 fc 58 a5 22 8e 74 26 49 8b 7c 24 f8 48 89 de e8 32 81 67 09 85 c0 75 e2 90 48 c7 c7 f2 e1 98 8d 48 89 de e8 5e 00 7f ff 90 <0f> 0b 90 90 48 89 df be 20 00 00 00 e8 cc 82 67 09 48 85 c0 0f 85
RSP: 0018:ffffc90002dffcc8 EFLAGS: 00010246
RAX: 2d59588130194a00 RBX: ffffffff8cb69260 RCX: ffff888105d20000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000010 R08: ffffc90002dff9e7 R09: 1ffff920005bff3c
R10: dffffc0000000000 R11: fffff520005bff3d R12: ffff88801fde6928
R13: 0000607e5bfbe4c0 R14: ffffc90002dffd60 R15: 0000000000000098
FS:  00007f455d4c26c0(0000) GS:ffff8881a3c7e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f455c7b7dac CR3: 0000000106b38000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __kmem_cache_create include/linux/slab.h:353 [inline]
 xsk_create+0x67e/0x8d0 net/xdp/xsk.c:1817
 __sock_create+0x4b3/0x9f0 net/socket.c:1589
 sock_create net/socket.c:1647 [inline]
 __sys_socket_create net/socket.c:1684 [inline]
 __sys_socket+0xd7/0x1b0 net/socket.c:1731
 __do_sys_socket net/socket.c:1745 [inline]
 __se_sys_socket net/socket.c:1743 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f455c58ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f455d4c2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 00007f455c7b5fa0 RCX: 00007f455c58ebe9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000000000000002c
RBP: 00007f455c611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f455c7b6038 R14: 00007f455c7b5fa0 R15: 00007ffd678e28c8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

