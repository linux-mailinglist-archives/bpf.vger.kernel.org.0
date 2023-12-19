Return-Path: <bpf+bounces-18270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0A818434
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF7B1F2520D
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFF612E44;
	Tue, 19 Dec 2023 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTuLrRzs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE5134A5;
	Tue, 19 Dec 2023 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso1152558b3a.3;
        Tue, 19 Dec 2023 01:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702977158; x=1703581958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S0gp9Jxo3cDEk/nLtV7yts+X/4EkarkszSdWdET8Oek=;
        b=LTuLrRzsrBha8PkRHwfeTotQM4e6VFZfcRSEFZVpF7OKZw+S9mfi8ekKm3rEin2ZzB
         Gwi8EwEi9az0rsgqO0QFjI9leEjZBFYsJ78ku2uDTibT8rmR1+xrFivoh8phJNFU3W+B
         FwUjM2lg/ph9XxuOLnqByBUc0qMYpwU0AGL4ojPlMWliZ4eameNK60Uq5h5MK4qkxfvR
         K6HKQbp3GT6CAaBWSLdBgzashRP4dHoW0hk1VFODGZs2bg4jvdBcICK6Fgir71Ss1GP5
         IJZLcGuTiNpJey9AEjJNAWJlopdPCdbKt2MFp1esQ7f+iyDB31tKW2NJLDb03s8UXTeh
         GELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977158; x=1703581958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0gp9Jxo3cDEk/nLtV7yts+X/4EkarkszSdWdET8Oek=;
        b=Rki9UIfm0aGuVrFCTrOUZBP5WgNDG6NQJGBpLQ+u1D6yhjTuJUtfNOeBdwsEbTvonm
         AtuCiRpeGGjqL4/Ok38RIYdn/qQHB4l/psab+o3ji2i76yxU7y7ci/qc897nK86eMzS6
         GF52Y8bFfVccimHMYSVI4MTCOEYhlyzSkuGV1mWLstHxZRg0h0s+j/yiPhF8M5qBzx8P
         ZfcFjgp/jdE0Vy4XQbvc6EZRrq8QLajzhX4g19O2YckG40a+6b961yCkUv+jqWNBtnD4
         uqfYKrx/X79WfAPg7/aCeKPx+UjXjKDslh+XdMrqoKI9Xy9oIRYL2eoRkkjZpnCHvdag
         n8PA==
X-Gm-Message-State: AOJu0YyfxrgNzS+LYPWnkrKIe4aYe+EDSszs5bEuzhgBJ8vz4widK/dn
	67S22rSs7seu2rdY5C+6JTKtp+1h6qLeK17kjrk=
X-Google-Smtp-Source: AGHT+IHdnn5mMVHiI0MStsOIzuZheu6lYHSXTpe+iM5s21ZW7cQHqIfPphRas+VSv5P3yeEUdhdf9W8otGRUY286WUA=
X-Received: by 2002:aa7:9f0b:0:b0:6d2:7e5f:8c6 with SMTP id
 g11-20020aa79f0b000000b006d27e5f08c6mr1978193pfr.41.1702977158374; Tue, 19
 Dec 2023 01:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Tue, 19 Dec 2023 17:12:25 +0800
Message-ID: <CABOYnLwXyxPukiaL36NvGvSa6yW3y0rXgrU=ABOzE-1gDAc4-g@mail.gmail.com>
Subject: memory leak in unix_create1/copy_process/security_prepare_creds
To: davem@davemloft.net
Cc: Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	kuniyu@amazon.com, alexander@mihalicyn.com, dhowells@redhat.com, 
	john.fastabend@gmail.com, daan.j.demeyer@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello I found a bug in net/af_unix in the lastest upstream linux
6.7.rc5 and comfired in lastest net/net-next/bpf/bpf-next tree.
Titled "TITLE: memory leak in unix_create1=E2=80=9D and I also upload the
repro.c and repro.txt.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei Lee <xrivendell7@gmail.com>

lastest net tree: 979e90173af8d2f52f671d988189aab98c6d1be6
Kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D8c=
4e4700f1727d30

in the lastest net tree, the crash like:
Linux syzkaller 6.7.0-rc5-00172-g979e90173af8 #4 SMP PREEMPT_DYNAMIC
Tue Dec 19 11:03:58 HKT 2023 x86_4

TITLE: memory leak in security_prepare_creds
   [<ffffffff8129291a>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
   [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
   [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
BUG: memory leak
unreferenced object 0xffff8881408b9390 (size 16):
 comm "cd01", pid 8363, jiffies 4296754700 (age 12.260s)
 hex dump (first 16 bytes):
   00 00 00 00 00 00 00 00 00 4b 99 00 81 88 ff ff  .........K......
 backtrace:
   [<ffffffff816340fd>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
   [<ffffffff8157f42b>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
   [<ffffffff8157f42b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1020
   [<ffffffff823695b1>] kmalloc include/linux/slab.h:604 [inline]
   [<ffffffff823695b1>] kzalloc include/linux/slab.h:721 [inline]
   [<ffffffff823695b1>] lsm_cred_alloc security/security.c:577 [inline]
   [<ffffffff823695b1>] security_prepare_creds+0x121/0x140
security/security.c:2950
   [<ffffffff812e1189>] prepare_creds+0x329/0x4e0 kernel/cred.c:300
   [<ffffffff812e18f4>] copy_creds+0x44/0x280 kernel/cred.c:373
   [<ffffffff8129291a>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
   [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
   [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888147c26b40 (size 112):
 comm "cd01", pid 8363, jiffies 4296754700 (age 12.260s)
 hex dump (first 32 bytes):
   01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 backtrace:
   [<ffffffff81631578>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
   [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
   [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
   [<ffffffff812d30ca>] alloc_pid+0x6a/0x570 kernel/pid.c:183
   [<ffffffff81293ab8>] copy_process+0x1848/0x25c0 kernel/fork.c:2518
   [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
   [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810813d040 (size 1088):
 comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
 hex dump (first 32 bytes):
   00 00 00 00 00 00 00 00 8a 00 00 00 00 00 00 00  ................
   01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
 backtrace:
   [<ffffffff81631578>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
   [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
   [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
   [<ffffffff83ecc0ce>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2069
   [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
   [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
   [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
   [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
   [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
   [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
   [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
   [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
   [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88811701bd10 (size 16):
 comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
 hex dump (first 16 bytes):
   00 4b 99 00 81 88 ff ff 00 00 00 00 00 00 00 00  .K..............
 backtrace:
   [<ffffffff816340fd>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
   [<ffffffff8157ed85>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
   [<ffffffff823a75c2>] kmalloc include/linux/slab.h:600 [inline]
   [<ffffffff823a75c2>] kzalloc include/linux/slab.h:721 [inline]
   [<ffffffff823a75c2>] apparmor_sk_alloc_security+0x52/0xd0
security/apparmor/lsm.c:997
   [<ffffffff8236b407>] security_sk_alloc+0x47/0x80 security/security.c:441=
1
   [<ffffffff83ecc11f>] sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2078
   [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
   [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
   [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
   [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
   [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
   [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
   [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
   [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
   [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



TITLE: memory leak in copy_process
   [<ffffffff8129291a>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
   [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
   [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
BUG: memory leak
unreferenced object 0xffff888147c26b40 (size 112):
 comm "cd01", pid 8363, jiffies 4296754700 (age 12.260s)
 hex dump (first 32 bytes):
   01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 backtrace:
   [<ffffffff81631578>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
   [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
   [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
   [<ffffffff812d30ca>] alloc_pid+0x6a/0x570 kernel/pid.c:183
   [<ffffffff81293ab8>] copy_process+0x1848/0x25c0 kernel/fork.c:2518
   [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
   [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810813d040 (size 1088):
 comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
 hex dump (first 32 bytes):
   00 00 00 00 00 00 00 00 8a 00 00 00 00 00 00 00  ................
   01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
 backtrace:
   [<ffffffff81631578>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
   [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
   [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
   [<ffffffff83ecc0ce>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2069
   [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
   [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
   [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
   [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
   [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
   [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
   [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
   [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
   [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88811701bd10 (size 16):
 comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
 hex dump (first 16 bytes):
   00 4b 99 00 81 88 ff ff 00 00 00 00 00 00 00 00  .K..............
 backtrace:
   [<ffffffff816340fd>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
   [<ffffffff8157ed85>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
   [<ffffffff823a75c2>] kmalloc include/linux/slab.h:600 [inline]
   [<ffffffff823a75c2>] kzalloc include/linux/slab.h:721 [inline]
   [<ffffffff823a75c2>] apparmor_sk_alloc_security+0x52/0xd0
security/apparmor/lsm.c:997
   [<ffffffff8236b407>] security_sk_alloc+0x47/0x80 security/security.c:441=
1
   [<ffffffff83ecc11f>] sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2078
   [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
   [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
   [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
   [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
   [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
   [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
   [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
   [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
   [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

TITLE: memory leak in unix_create1
   [<ffffffff81293ab8>] copy_process+0x1848/0x25c0 kernel/fork.c:2518
   [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
   [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
BUG: memory leak
unreferenced object 0xffff88810813d040 (size 1088):
 comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
 hex dump (first 32 bytes):
   00 00 00 00 00 00 00 00 8a 00 00 00 00 00 00 00  ................
   01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
 backtrace:
   [<ffffffff81631578>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
   [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
   [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
   [<ffffffff83ecc0ce>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2069
   [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
   [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
   [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
   [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
   [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
   [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
   [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
   [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
   [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88811701bd10 (size 16):
 comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
 hex dump (first 16 bytes):
   00 4b 99 00 81 88 ff ff 00 00 00 00 00 00 00 00  .K..............
 backtrace:
   [<ffffffff816340fd>] kmemleak_alloc_recursive
include/linux/kmemleak.h:42 [inline]
   [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
   [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
   [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
   [<ffffffff8157ed85>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
   [<ffffffff823a75c2>] kmalloc include/linux/slab.h:600 [inline]
   [<ffffffff823a75c2>] kzalloc include/linux/slab.h:721 [inline]
   [<ffffffff823a75c2>] apparmor_sk_alloc_security+0x52/0xd0
security/apparmor/lsm.c:997
   [<ffffffff8236b407>] security_sk_alloc+0x47/0x80 security/security.c:441=
1
   [<ffffffff83ecc11f>] sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2078
   [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
   [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
   [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
   [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
   [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
   [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
   [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
   [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
   [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
   [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

=3D* repro.c =3D*
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] =3D 0;
 int len =3D strlen(buf);
 int fd =3D open(file, O_WRONLY | O_CLOEXEC);
 if (fd =3D=3D -1) return false;
 if (write(fd, buf, len) !=3D len) {
   int err =3D errno;
   close(fd);
   errno =3D err;
   return false;
 }
 close(fd);
 return true;
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i =3D 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid) return;
   usleep(1000);
 }
 DIR* dir =3D opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent =3D readdir(dir);
     if (!ent) break;
     if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=
=3D 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd =3D open(abort, O_WRONLY);
     if (fd =3D=3D -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) !=3D pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

#define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"

static void setup_leak() {
 if (!write_file(KMEMLEAK_FILE, "scan")) exit(1);
 sleep(5);
 if (!write_file(KMEMLEAK_FILE, "scan")) exit(1);
 if (!write_file(KMEMLEAK_FILE, "clear")) exit(1);
}

static void check_leaks(void) {
 int fd =3D open(KMEMLEAK_FILE, O_RDWR);
 if (fd =3D=3D -1) exit(1);
 uint64_t start =3D current_time_ms();
 if (write(fd, "scan", 4) !=3D 4) exit(1);
 sleep(1);
 while (current_time_ms() - start < 4 * 1000) sleep(1);
 if (write(fd, "scan", 4) !=3D 4) exit(1);
 static char buf[128 << 10];
 ssize_t n =3D read(fd, buf, sizeof(buf) - 1);
 if (n < 0) exit(1);
 int nleaks =3D 0;
 if (n !=3D 0) {
   sleep(1);
   if (write(fd, "scan", 4) !=3D 4) exit(1);
   if (lseek(fd, 0, SEEK_SET) < 0) exit(1);
   n =3D read(fd, buf, sizeof(buf) - 1);
   if (n < 0) exit(1);
   buf[n] =3D 0;
   char* pos =3D buf;
   char* end =3D buf + n;
   while (pos < end) {
     char* next =3D strstr(pos + 1, "unreferenced object");
     if (!next) next =3D end;
     char prev =3D *next;
     *next =3D 0;
     fprintf(stderr, "BUG: memory leak\n%s\n", pos);
     *next =3D prev;
     pos =3D next;
     nleaks++;
   }
 }
 if (write(fd, "clear", 5) !=3D 5) exit(1);
 close(fd);
 if (nleaks) exit(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter =3D 0;
 for (;; iter++) {
   int pid =3D fork();
   if (pid < 0) exit(1);
   if (pid =3D=3D 0) {
     setup_test();
     execute_one();
     exit(0);
   }
   int status =3D 0;
   uint64_t start =3D current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid) break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000) continue;
     kill_and_wait(pid, &status);
     break;
   }
   check_leaks();
 }
}

uint64_t r[1] =3D {0xffffffffffffffff};

void execute_one(void) {
 intptr_t res =3D 0;
 syscall(__NR_socketpair, /*domain=3D*/1ul, /*type=3D*/1ul, /*proto=3D*/0,
         /*fds=3D*/0x20000000ul);
 *(uint32_t*)0x200000c0 =3D 0x12;
 *(uint32_t*)0x200000c4 =3D 2;
 *(uint32_t*)0x200000c8 =3D 4;
 *(uint32_t*)0x200000cc =3D 1;
 *(uint32_t*)0x200000d0 =3D 0;
 *(uint32_t*)0x200000d4 =3D -1;
 *(uint32_t*)0x200000d8 =3D 0;
 memset((void*)0x200000dc, 0, 16);
 *(uint32_t*)0x200000ec =3D 0;
 *(uint32_t*)0x200000f0 =3D -1;
 *(uint32_t*)0x200000f4 =3D 0;
 *(uint32_t*)0x200000f8 =3D 0;
 *(uint32_t*)0x200000fc =3D 0;
 *(uint64_t*)0x20000100 =3D 0;
 res =3D syscall(__NR_bpf, /*cmd=3D*/0ul, /*arg=3D*/0x200000c0ul, /*size=3D=
*/0x48ul);
 if (res !=3D -1) r[0] =3D res;
 *(uint32_t*)0x200003c0 =3D r[0];
 *(uint64_t*)0x200003c8 =3D 0x20000040;
 *(uint64_t*)0x200003d0 =3D 0x20000000;
 *(uint64_t*)0x200003d8 =3D 0;
 syscall(__NR_bpf, /*cmd=3D*/2ul, /*arg=3D*/0x200003c0ul, /*size=3D*/0x20ul=
);
 *(uint32_t*)0x200003c0 =3D r[0];
 *(uint64_t*)0x200003c8 =3D 0x20000040;
 *(uint64_t*)0x200003d0 =3D 0x20000000;
 *(uint64_t*)0x200003d8 =3D 0;
 syscall(__NR_bpf, /*cmd=3D*/2ul, /*arg=3D*/0x200003c0ul, /*size=3D*/0x20ul=
);
}
int main(void) {
 syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 setup_leak();
 loop();
 return 0;
}



=3D* repro.txt =3D*
socketpair(0x1, 0x1, 0x0, &(0x7f0000000000))
r0 =3D bpf$MAP_CREATE(0x0, &(0x7f00000000c0)=3D@base=3D{0x12, 0x2, 0x4, 0x1=
}, 0x48)
bpf$MAP_DELETE_ELEM(0x2, &(0x7f00000003c0)=3D{r0, &(0x7f0000000040),
0x20000000}, 0x20)
bpf$MAP_DELETE_ELEM(0x2, &(0x7f00000003c0)=3D{r0, &(0x7f0000000040),
0x20000000}, 0x20)


Please see also
https://gist.github.com/xrivendell7/80fc686da1e9223cf49ec87ad8e2ebfc

I do not analysis it deeply but looks like it might be related to the
bpf module so I aslo CC bpf maintainers.
Hope it helps.
Best regards.
xingwei Lee

