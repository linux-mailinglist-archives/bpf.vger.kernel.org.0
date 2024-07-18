Return-Path: <bpf+bounces-34976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF3F934549
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 02:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571C12833D6
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 00:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547B63A;
	Thu, 18 Jul 2024 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS8afZNj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B3365;
	Thu, 18 Jul 2024 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721261362; cv=none; b=T5TnieEP0MiJwS0sMF/Rs6Pqqt61aM4JOp5BJEfagei+fEds0BV+Y4xdIJn3kHXM5m44ctbxW9Mwfdhz1UzzMBNyAuU3iXdbHhDcKvmiov9SFayFJYcOHIBb4VPQfIKpRsOeeOiPX2eT0ZbHVx8kktfJcu5RUS+MrvksIbLJlM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721261362; c=relaxed/simple;
	bh=7f58NATk/lks0DgmRpcHdttEv16OLx86uzxxaU4HTD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNFva+DQ7lmJUKfTRw8LoIvcu49ehXXc2rIRUJ2RfvZpSi5BTVMRRWsD5+GsEQ/xvjg+CAxmAZGcDOY1RX9SijHND7ZPKEoxkk0tlUrI2I+q1NQD2jO64eVRZgb8pL+86zryCx8iCPcwlzO84BOo7+tg6OorcIc3x4GKuP69ZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS8afZNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503DFC2BD10;
	Thu, 18 Jul 2024 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721261361;
	bh=7f58NATk/lks0DgmRpcHdttEv16OLx86uzxxaU4HTD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qS8afZNjJNeg2LJkAucf7XNvBQuMTRMjoGeUGMU6xwQJ3wW4VJjmmiCu4XyQ36g/5
	 8u5BAnpGE2jBiDF9283m3PfpWnraw64QrqYfPLCW2HHxvIP6GGVzZgD/68as1UHFPn
	 zcsuf9hTqOtr9FMae6A98coUnyZN+dGQmcQTBVdE26NsRvHbXFKgWtzq+twGMUYJ9/
	 S7wjz6OmjhDVGl4aeJe22wVdt6dUe09dS6F364Dc+At/96HzCrXHJQnS5Ubiq9Q+TW
	 Ew0VvnfDU+xUxPQ/c/xvPS6LmcLQsqy0zmK9jz6D272A0BFBasymnj2gifaXDspw8V
	 s5KuWJCYI6+FA==
Date: Wed, 17 Jul 2024 17:09:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: bigeasy@linutronix.de
Cc: syzbot <syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bp@alien8.de, bpf@vger.kernel.org,
 daniel@iogearbox.net, dave.hansen@linux.intel.com, davem@davemloft.net,
 eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, hawk@kernel.org,
 hpa@zytor.com, jacob.jun.pan@linux.intel.com, jasowang@redhat.com,
 jiri@resnulli.us, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
 pbonzini@redhat.com, peterz@infradead.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 wei.liu@kernel.org, willemdebruijn.kernel@gmail.com, x86@kernel.org,
 yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] KASAN: stack-out-of-bounds Read in
 xdp_do_check_flushed
Message-ID: <20240717170919.455624c0@kernel.org>
In-Reply-To: <000000000000968ac6061d0f53ba@google.com>
References: <000000000000968ac6061d0f53ba@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sebastian!

IIUC syzbot continues to hit this, is it on your radar?

On Fri, 12 Jul 2024 09:25:24 -0700 syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    523b23f0bee3 Add linux-next specific files for 20240710
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13187c7e980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
> dashboard link: https://syzkaller.appspot.com/bug?extid=709e4c85c904bcd62735
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106dd859980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111637b9980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/345bcd25ed2f/disk-523b23f0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a4508962d345/vmlinux-523b23f0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4ba5eb555639/bzImage-523b23f0.xz
> 
> The issue was bisected to:
> 
> commit fecef4cd42c689a200bdd39e6fffa71475904bc1
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Thu Jul 4 14:48:15 2024 +0000
> 
>     tun: Assign missing bpf_net_context.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164d6f76980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=154d6f76980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=114d6f76980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com
> Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> 
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in bpf_net_ctx_get_all_used_flush_lists include/linux/filter.h:837 [inline]
> BUG: KASAN: stack-out-of-bounds in xdp_do_check_flushed+0x231/0x240 net/core/filter.c:4298
> Read of size 4 at addr ffffc90003def7f8 by task syz-executor156/5107
> 
> CPU: 0 UID: 0 PID: 5107 Comm: syz-executor156 Not tainted 6.10.0-rc7-next-20240710-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  bpf_net_ctx_get_all_used_flush_lists include/linux/filter.h:837 [inline]
>  xdp_do_check_flushed+0x231/0x240 net/core/filter.c:4298
>  __napi_poll+0xe4/0x490 net/core/dev.c:6774
>  napi_poll net/core/dev.c:6840 [inline]
>  net_rx_action+0x89b/0x1240 net/core/dev.c:6962
>  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
>  do_softirq+0x11b/0x1e0 kernel/softirq.c:455
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  tun_get_user+0x2884/0x4720 drivers/net/tun.c:1936
>  tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2052
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f26cdb99d90
> Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 11 e3 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> RSP: 002b:00007ffd1139eb08 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f26cdb99d90
> RDX: 000000000000fdef RSI: 0000000020000200 RDI: 00000000000000c8
> RBP: 0000000000000000 R08: 00007ffd1139ec38 R09: 00007ffd1139ec38
> R10: 00007ffd1139ec38 R11: 0000000000000202 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffd1139eb40 R15: 00007ffd1139eb30
>  </TASK>
> 
> The buggy address belongs to stack of task syz-executor156/5107
>  and is located at offset 88 in frame:
>  do_softirq+0x0/0x1e0
> 
> This frame has 2 objects:
>  [32, 40) 'flags.i.i.i105'
>  [64, 72) 'flags.i.i.i'
> 
> The buggy address belongs to the virtual mapping at
>  [ffffc90003de8000, ffffc90003df1000) created by:
>  copy_process+0x5d1/0x3d90 kernel/fork.c:2206
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6b798
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 5089, tgid 5089 (sshd), ts 45267990588, free_ts 13316620078
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
>  prep_new_page mm/page_alloc.c:1501 [inline]
>  get_page_from_freelist+0x2ccb/0x2d80 mm/page_alloc.c:3480
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4738
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
>  vm_area_alloc_pages mm/vmalloc.c:3584 [inline]
>  __vmalloc_area_node mm/vmalloc.c:3660 [inline]
>  __vmalloc_node_range_noprof+0x971/0x1460 mm/vmalloc.c:3841
>  alloc_thread_stack_node kernel/fork.c:314 [inline]
>  dup_task_struct+0x444/0x8c0 kernel/fork.c:1115
>  copy_process+0x5d1/0x3d90 kernel/fork.c:2206
>  kernel_clone+0x226/0x8f0 kernel/fork.c:2788
>  __do_sys_clone kernel/fork.c:2931 [inline]
>  __se_sys_clone kernel/fork.c:2915 [inline]
>  __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2915
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 1 tgid 1 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1094 [inline]
>  free_unref_page+0xd22/0xea0 mm/page_alloc.c:2644
>  free_contig_range+0x9e/0x160 mm/page_alloc.c:6694
>  destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1017
>  debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
>  do_one_initcall+0x248/0x880 init/main.c:1267
>  do_initcall_level+0x157/0x210 init/main.c:1329
>  do_initcalls+0x3f/0x80 init/main.c:1345
>  kernel_init_freeable+0x435/0x5d0 init/main.c:1578
>  kernel_init+0x1d/0x2b0 init/main.c:1467
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Memory state around the buggy address:
>  ffffc90003def680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90003def700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffffc90003def780: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 00 f3 f3 f3  
>                                                                 ^
>  ffffc90003def800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffc90003def880: f1 f1 f1 f1 00 f3 f3 f3 00 00 00 00 00 00 00 00
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


