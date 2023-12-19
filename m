Return-Path: <bpf+bounces-18307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D21818B97
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC93284FF2
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2441CF9C;
	Tue, 19 Dec 2023 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TxY4eE8h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7B1C2BB;
	Tue, 19 Dec 2023 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703001074; x=1734537074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aVhJerWl3eOmgiYiOZn/k+JakqJefDrzf8GXS19hJQU=;
  b=TxY4eE8hcks593l+rLNz4gFd6Yoz85R7aOUPvr0Wp8s2S4HtVvFDHxtc
   JN3pcwtw+XQNW8i1gZroNl8PZXghmhb1ogkQdTdt5KLIV5tv2oywDllEG
   7pQ6Dq83QPILgc6n3HPlLcq6lpNAPyonXVmYvY3g8u/WIh5q++irg1/h/
   4=;
X-IronPort-AV: E=Sophos;i="6.04,288,1695686400"; 
   d="scan'208";a="260459588"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:51:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id EBB0CC0B25;
	Tue, 19 Dec 2023 15:51:11 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:46729]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.75:2525] with esmtp (Farcaster)
 id e7a4edc8-13c8-425e-b776-feb43675466b; Tue, 19 Dec 2023 15:51:11 +0000 (UTC)
X-Farcaster-Flow-ID: e7a4edc8-13c8-425e-b776-feb43675466b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 15:51:11 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 15:51:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xrivendell7@gmail.com>
CC: <alexander@mihalicyn.com>, <bpf@vger.kernel.org>,
	<daan.j.demeyer@gmail.com>, <davem@davemloft.net>, <dhowells@redhat.com>,
	<edumazet@google.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: memory leak in unix_create1/copy_process/security_prepare_creds
Date: Wed, 20 Dec 2023 00:50:57 +0900
Message-ID: <20231219155057.12716-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CABOYnLwXyxPukiaL36NvGvSa6yW3y0rXgrU=ABOzE-1gDAc4-g@mail.gmail.com>
References: <CABOYnLwXyxPukiaL36NvGvSa6yW3y0rXgrU=ABOzE-1gDAc4-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: xingwei lee <xrivendell7@gmail.com>
Date: Tue, 19 Dec 2023 17:12:25 +0800
> Hello I found a bug in net/af_unix in the lastest upstream linux
> 6.7.rc5 and comfired in lastest net/net-next/bpf/bpf-next tree.
> Titled "TITLE: memory leak in unix_create1” and I also upload the
> repro.c and repro.txt.
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>

Thanks for reporting!

It seems 8866730aed510 forgot to add sock_put().
I've confirmed that the diff below silenced kmemleak but will check
more before posting a patch.

---8<---
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 7ea7c3a0d0d0..32daba9e7f8b 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -164,6 +164,7 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
 	if (restore) {
 		sk->sk_write_space = psock->saved_write_space;
 		sock_replace_proto(sk, psock->sk_proto);
+		sock_put(psock->sk_pair);
 		return 0;
 	}
 
---8<---

Thanks!


> 
> lastest net tree: 979e90173af8d2f52f671d988189aab98c6d1be6
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=8c4e4700f1727d30
> 
> in the lastest net tree, the crash like:
> Linux syzkaller 6.7.0-rc5-00172-g979e90173af8 #4 SMP PREEMPT_DYNAMIC
> Tue Dec 19 11:03:58 HKT 2023 x86_4
> 
> TITLE: memory leak in security_prepare_creds
>    [<ffffffff8129291a>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
>    [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
>    [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> BUG: memory leak
> unreferenced object 0xffff8881408b9390 (size 16):
>  comm "cd01", pid 8363, jiffies 4296754700 (age 12.260s)
>  hex dump (first 16 bytes):
>    00 00 00 00 00 00 00 00 00 4b 99 00 81 88 ff ff  .........K......
>  backtrace:
>    [<ffffffff816340fd>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
>    [<ffffffff8157f42b>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
>    [<ffffffff8157f42b>] __kmalloc+0x4b/0x150 mm/slab_common.c:1020
>    [<ffffffff823695b1>] kmalloc include/linux/slab.h:604 [inline]
>    [<ffffffff823695b1>] kzalloc include/linux/slab.h:721 [inline]
>    [<ffffffff823695b1>] lsm_cred_alloc security/security.c:577 [inline]
>    [<ffffffff823695b1>] security_prepare_creds+0x121/0x140
> security/security.c:2950
>    [<ffffffff812e1189>] prepare_creds+0x329/0x4e0 kernel/cred.c:300
>    [<ffffffff812e18f4>] copy_creds+0x44/0x280 kernel/cred.c:373
>    [<ffffffff8129291a>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
>    [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
>    [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> BUG: memory leak
> unreferenced object 0xffff888147c26b40 (size 112):
>  comm "cd01", pid 8363, jiffies 4296754700 (age 12.260s)
>  hex dump (first 32 bytes):
>    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  backtrace:
>    [<ffffffff81631578>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
>    [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>    [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
>    [<ffffffff812d30ca>] alloc_pid+0x6a/0x570 kernel/pid.c:183
>    [<ffffffff81293ab8>] copy_process+0x1848/0x25c0 kernel/fork.c:2518
>    [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
>    [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> BUG: memory leak
> unreferenced object 0xffff88810813d040 (size 1088):
>  comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 8a 00 00 00 00 00 00 00  ................
>    01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>  backtrace:
>    [<ffffffff81631578>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
>    [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>    [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
>    [<ffffffff83ecc0ce>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2069
>    [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
>    [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
>    [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
>    [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
>    [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
>    [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
>    [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
>    [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
>    [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> BUG: memory leak
> unreferenced object 0xffff88811701bd10 (size 16):
>  comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
>  hex dump (first 16 bytes):
>    00 4b 99 00 81 88 ff ff 00 00 00 00 00 00 00 00  .K..............
>  backtrace:
>    [<ffffffff816340fd>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
>    [<ffffffff8157ed85>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
>    [<ffffffff823a75c2>] kmalloc include/linux/slab.h:600 [inline]
>    [<ffffffff823a75c2>] kzalloc include/linux/slab.h:721 [inline]
>    [<ffffffff823a75c2>] apparmor_sk_alloc_security+0x52/0xd0
> security/apparmor/lsm.c:997
>    [<ffffffff8236b407>] security_sk_alloc+0x47/0x80 security/security.c:4411
>    [<ffffffff83ecc11f>] sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2078
>    [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
>    [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
>    [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
>    [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
>    [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
>    [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
>    [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
>    [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
>    [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> 
> 
> TITLE: memory leak in copy_process
>    [<ffffffff8129291a>] copy_process+0x6aa/0x25c0 kernel/fork.c:2366
>    [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
>    [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> BUG: memory leak
> unreferenced object 0xffff888147c26b40 (size 112):
>  comm "cd01", pid 8363, jiffies 4296754700 (age 12.260s)
>  hex dump (first 32 bytes):
>    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  backtrace:
>    [<ffffffff81631578>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
>    [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>    [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
>    [<ffffffff812d30ca>] alloc_pid+0x6a/0x570 kernel/pid.c:183
>    [<ffffffff81293ab8>] copy_process+0x1848/0x25c0 kernel/fork.c:2518
>    [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
>    [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> BUG: memory leak
> unreferenced object 0xffff88810813d040 (size 1088):
>  comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 8a 00 00 00 00 00 00 00  ................
>    01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>  backtrace:
>    [<ffffffff81631578>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
>    [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>    [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
>    [<ffffffff83ecc0ce>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2069
>    [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
>    [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
>    [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
>    [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
>    [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
>    [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
>    [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
>    [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
>    [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> BUG: memory leak
> unreferenced object 0xffff88811701bd10 (size 16):
>  comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
>  hex dump (first 16 bytes):
>    00 4b 99 00 81 88 ff ff 00 00 00 00 00 00 00 00  .K..............
>  backtrace:
>    [<ffffffff816340fd>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
>    [<ffffffff8157ed85>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
>    [<ffffffff823a75c2>] kmalloc include/linux/slab.h:600 [inline]
>    [<ffffffff823a75c2>] kzalloc include/linux/slab.h:721 [inline]
>    [<ffffffff823a75c2>] apparmor_sk_alloc_security+0x52/0xd0
> security/apparmor/lsm.c:997
>    [<ffffffff8236b407>] security_sk_alloc+0x47/0x80 security/security.c:4411
>    [<ffffffff83ecc11f>] sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2078
>    [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
>    [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
>    [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
>    [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
>    [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
>    [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
>    [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
>    [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
>    [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> TITLE: memory leak in unix_create1
>    [<ffffffff81293ab8>] copy_process+0x1848/0x25c0 kernel/fork.c:2518
>    [<ffffffff812949db>] kernel_clone+0x11b/0x690 kernel/fork.c:2907
>    [<ffffffff81294fcc>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3050
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> BUG: memory leak
> unreferenced object 0xffff88810813d040 (size 1088):
>  comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 8a 00 00 00 00 00 00 00  ................
>    01 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>  backtrace:
>    [<ffffffff81631578>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff81631578>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff81631578>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff81631578>] slab_alloc mm/slub.c:3486 [inline]
>    [<ffffffff81631578>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
>    [<ffffffff81631578>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
>    [<ffffffff83ecc0ce>] sk_prot_alloc+0x3e/0x1b0 net/core/sock.c:2069
>    [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
>    [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
>    [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
>    [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
>    [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
>    [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
>    [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
>    [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
>    [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> BUG: memory leak
> unreferenced object 0xffff88811701bd10 (size 16):
>  comm "cd01", pid 8365, jiffies 4296754700 (age 12.260s)
>  hex dump (first 16 bytes):
>    00 4b 99 00 81 88 ff ff 00 00 00 00 00 00 00 00  .K..............
>  backtrace:
>    [<ffffffff816340fd>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:42 [inline]
>    [<ffffffff816340fd>] slab_post_alloc_hook mm/slab.h:766 [inline]
>    [<ffffffff816340fd>] slab_alloc_node mm/slub.c:3478 [inline]
>    [<ffffffff816340fd>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
>    [<ffffffff8157ed85>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
>    [<ffffffff823a75c2>] kmalloc include/linux/slab.h:600 [inline]
>    [<ffffffff823a75c2>] kzalloc include/linux/slab.h:721 [inline]
>    [<ffffffff823a75c2>] apparmor_sk_alloc_security+0x52/0xd0
> security/apparmor/lsm.c:997
>    [<ffffffff8236b407>] security_sk_alloc+0x47/0x80 security/security.c:4411
>    [<ffffffff83ecc11f>] sk_prot_alloc+0x8f/0x1b0 net/core/sock.c:2078
>    [<ffffffff83ecf506>] sk_alloc+0x36/0x2f0 net/core/sock.c:2128
>    [<ffffffff84371e34>] unix_create1+0x84/0x320 net/unix/af_unix.c:982
>    [<ffffffff84372168>] unix_create+0x98/0x130 net/unix/af_unix.c:1049
>    [<ffffffff83ec493f>] __sock_create+0x19f/0x2e0 net/socket.c:1569
>    [<ffffffff83ec8440>] sock_create net/socket.c:1620 [inline]
>    [<ffffffff83ec8440>] __sys_socketpair+0x160/0x370 net/socket.c:1771
>    [<ffffffff83ec866f>] __do_sys_socketpair net/socket.c:1820 [inline]
>    [<ffffffff83ec866f>] __se_sys_socketpair net/socket.c:1817 [inline]
>    [<ffffffff83ec866f>] __x64_sys_socketpair+0x1f/0x30 net/socket.c:1817
>    [<ffffffff84b70dcf>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    [<ffffffff84b70dcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
>    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> =* repro.c =*
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> 
> #define _GNU_SOURCE
> 
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> 
> #ifndef __NR_bpf
> #define __NR_bpf 321
> #endif
> 
> static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }
> 
> static uint64_t current_time_ms(void) {
>  struct timespec ts;
>  if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
>  return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> 
> static bool write_file(const char* file, const char* what, ...) {
>  char buf[1024];
>  va_list args;
>  va_start(args, what);
>  vsnprintf(buf, sizeof(buf), what, args);
>  va_end(args);
>  buf[sizeof(buf) - 1] = 0;
>  int len = strlen(buf);
>  int fd = open(file, O_WRONLY | O_CLOEXEC);
>  if (fd == -1) return false;
>  if (write(fd, buf, len) != len) {
>    int err = errno;
>    close(fd);
>    errno = err;
>    return false;
>  }
>  close(fd);
>  return true;
> }
> 
> static void kill_and_wait(int pid, int* status) {
>  kill(-pid, SIGKILL);
>  kill(pid, SIGKILL);
>  for (int i = 0; i < 100; i++) {
>    if (waitpid(-1, status, WNOHANG | __WALL) == pid) return;
>    usleep(1000);
>  }
>  DIR* dir = opendir("/sys/fs/fuse/connections");
>  if (dir) {
>    for (;;) {
>      struct dirent* ent = readdir(dir);
>      if (!ent) break;
>      if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>        continue;
>      char abort[300];
>      snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>               ent->d_name);
>      int fd = open(abort, O_WRONLY);
>      if (fd == -1) {
>        continue;
>      }
>      if (write(fd, abort, 1) < 0) {
>      }
>      close(fd);
>    }
>    closedir(dir);
>  } else {
>  }
>  while (waitpid(-1, status, __WALL) != pid) {
>  }
> }
> 
> static void setup_test() {
>  prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>  setpgrp();
>  write_file("/proc/self/oom_score_adj", "1000");
> }
> 
> #define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"
> 
> static void setup_leak() {
>  if (!write_file(KMEMLEAK_FILE, "scan")) exit(1);
>  sleep(5);
>  if (!write_file(KMEMLEAK_FILE, "scan")) exit(1);
>  if (!write_file(KMEMLEAK_FILE, "clear")) exit(1);
> }
> 
> static void check_leaks(void) {
>  int fd = open(KMEMLEAK_FILE, O_RDWR);
>  if (fd == -1) exit(1);
>  uint64_t start = current_time_ms();
>  if (write(fd, "scan", 4) != 4) exit(1);
>  sleep(1);
>  while (current_time_ms() - start < 4 * 1000) sleep(1);
>  if (write(fd, "scan", 4) != 4) exit(1);
>  static char buf[128 << 10];
>  ssize_t n = read(fd, buf, sizeof(buf) - 1);
>  if (n < 0) exit(1);
>  int nleaks = 0;
>  if (n != 0) {
>    sleep(1);
>    if (write(fd, "scan", 4) != 4) exit(1);
>    if (lseek(fd, 0, SEEK_SET) < 0) exit(1);
>    n = read(fd, buf, sizeof(buf) - 1);
>    if (n < 0) exit(1);
>    buf[n] = 0;
>    char* pos = buf;
>    char* end = buf + n;
>    while (pos < end) {
>      char* next = strstr(pos + 1, "unreferenced object");
>      if (!next) next = end;
>      char prev = *next;
>      *next = 0;
>      fprintf(stderr, "BUG: memory leak\n%s\n", pos);
>      *next = prev;
>      pos = next;
>      nleaks++;
>    }
>  }
>  if (write(fd, "clear", 5) != 5) exit(1);
>  close(fd);
>  if (nleaks) exit(1);
> }
> 
> static void execute_one(void);
> 
> #define WAIT_FLAGS __WALL
> 
> static void loop(void) {
>  int iter = 0;
>  for (;; iter++) {
>    int pid = fork();
>    if (pid < 0) exit(1);
>    if (pid == 0) {
>      setup_test();
>      execute_one();
>      exit(0);
>    }
>    int status = 0;
>    uint64_t start = current_time_ms();
>    for (;;) {
>      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) break;
>      sleep_ms(1);
>      if (current_time_ms() - start < 5000) continue;
>      kill_and_wait(pid, &status);
>      break;
>    }
>    check_leaks();
>  }
> }
> 
> uint64_t r[1] = {0xffffffffffffffff};
> 
> void execute_one(void) {
>  intptr_t res = 0;
>  syscall(__NR_socketpair, /*domain=*/1ul, /*type=*/1ul, /*proto=*/0,
>          /*fds=*/0x20000000ul);
>  *(uint32_t*)0x200000c0 = 0x12;
>  *(uint32_t*)0x200000c4 = 2;
>  *(uint32_t*)0x200000c8 = 4;
>  *(uint32_t*)0x200000cc = 1;
>  *(uint32_t*)0x200000d0 = 0;
>  *(uint32_t*)0x200000d4 = -1;
>  *(uint32_t*)0x200000d8 = 0;
>  memset((void*)0x200000dc, 0, 16);
>  *(uint32_t*)0x200000ec = 0;
>  *(uint32_t*)0x200000f0 = -1;
>  *(uint32_t*)0x200000f4 = 0;
>  *(uint32_t*)0x200000f8 = 0;
>  *(uint32_t*)0x200000fc = 0;
>  *(uint64_t*)0x20000100 = 0;
>  res = syscall(__NR_bpf, /*cmd=*/0ul, /*arg=*/0x200000c0ul, /*size=*/0x48ul);
>  if (res != -1) r[0] = res;
>  *(uint32_t*)0x200003c0 = r[0];
>  *(uint64_t*)0x200003c8 = 0x20000040;
>  *(uint64_t*)0x200003d0 = 0x20000000;
>  *(uint64_t*)0x200003d8 = 0;
>  syscall(__NR_bpf, /*cmd=*/2ul, /*arg=*/0x200003c0ul, /*size=*/0x20ul);
>  *(uint32_t*)0x200003c0 = r[0];
>  *(uint64_t*)0x200003c8 = 0x20000040;
>  *(uint64_t*)0x200003d0 = 0x20000000;
>  *(uint64_t*)0x200003d8 = 0;
>  syscall(__NR_bpf, /*cmd=*/2ul, /*arg=*/0x200003c0ul, /*size=*/0x20ul);
> }
> int main(void) {
>  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
>  setup_leak();
>  loop();
>  return 0;
> }
> 
> 
> 
> =* repro.txt =*
> socketpair(0x1, 0x1, 0x0, &(0x7f0000000000))
> r0 = bpf$MAP_CREATE(0x0, &(0x7f00000000c0)=@base={0x12, 0x2, 0x4, 0x1}, 0x48)
> bpf$MAP_DELETE_ELEM(0x2, &(0x7f00000003c0)={r0, &(0x7f0000000040),
> 0x20000000}, 0x20)
> bpf$MAP_DELETE_ELEM(0x2, &(0x7f00000003c0)={r0, &(0x7f0000000040),
> 0x20000000}, 0x20)
> 
> 
> Please see also
> https://gist.github.com/xrivendell7/80fc686da1e9223cf49ec87ad8e2ebfc
> 
> I do not analysis it deeply but looks like it might be related to the
> bpf module so I aslo CC bpf maintainers.
> Hope it helps.
> Best regards.
> xingwei Lee

