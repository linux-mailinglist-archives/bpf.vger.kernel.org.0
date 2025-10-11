Return-Path: <bpf+bounces-70787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B77BCFDE7
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 01:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2883334987A
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 23:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44503257851;
	Sat, 11 Oct 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="vsxGsCVa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA422A7E9
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760226096; cv=none; b=I7WV98b7NLZaZrYcSQsxiULsIZ8ELZZb4GxLCENmifzmlws74Wt5JTfVnJjQuXjDqzq7U/394cb9GorCwwORER8MLs90oLWJGkgyX+535mE45VlGMgzy6JJl0IU49T0OnFwDzz83B6RNm4m7+ib0B+SWab8Nl8pX5bTK9vyUcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760226096; c=relaxed/simple;
	bh=+BgaisoJpkMJRcrw4zm/dOKBPWo38wqDjpde9doKT6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU0GHcbcuZ/K6Gwry4SO9+vsv+LEs4qER7Boj3Z1d9TtqevHOqPQBDZ4TsEALA4e3OQWdRNhuK/uM2FPUU4udpVnUQlHKyAEMSSPtz3/rr3a7L+S1ICgi5ehqMRQiSV/BP5WeR2DqZptSchm7KgI5/VfgQFdTSZr8zm1Jjbmo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=vsxGsCVa; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1760226088;
	bh=ixMJ4H8Ln9X+7kZmTOGyuMjN/YJrJMUvqkp2MDOpWO4=;
	h=From:Subject:Date:Message-ID;
	b=vsxGsCVaNTv/6ML2VYPOI5F+px/E9hjZ0oaza0imReZvPmrDyinRLDnLD4Dqq3ocP
	 uoznuh7mHd4i+UIbaBXmdAjgSUddmP9m1Qljh9pe5kB0O/dJ6VFVOl/QlsvPKNHMuK
	 7taV+7Zgbu9iL6zJe6e/mw4yY7aSKpZLmyb6wiHE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68EAEB1B00001BA5; Sat, 12 Oct 2025 07:41:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7920164456699
X-SMAIL-UIID: 2CABCCB3694F44FFBBD46C5BB5C6B241-20251012-074117-1
From: Hillf Danton <hdanton@sina.com>
To: ast@kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+ad76dbe500667f3a4e17@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_delete_elem (2)
Date: Sun, 12 Oct 2025 07:41:05 +0800
Message-ID: <20251011234106.8522-1-hdanton@sina.com>
In-Reply-To: <68e92928.050a0220.3897dc.0194.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Oct 2025 08:41:28 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fd94619c4336 Merge tag 'zonefs-6.18-rc1' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ff8ee2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
> dashboard link: https://syzkaller.appspot.com/bug?extid=ad76dbe500667f3a4e17
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/201636e25a0b/disk-fd94619c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b63e3832240c/vmlinux-fd94619c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/11fc378734e8/bzImage-fd94619c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ad76dbe500667f3a4e17@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))

Did bpf help find out anything wrong in softirq?

> WARNING: CPU: 0 PID: 5969 at kernel/softirq.c:176 __local_bh_disable_ip+0x3d9/0x540 kernel/softirq.c:176
> Modules linked in:
> CPU: 0 UID: 0 PID: 5969 Comm: syz.1.2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> RIP: 0010:__local_bh_disable_ip+0x3d9/0x540 kernel/softirq.c:176
> Code: 0f b6 04 28 84 c0 0f 85 56 01 00 00 83 3d 52 9b 32 0d 00 75 19 90 48 c7 c7 c0 b7 c9 8a 48 c7 c6 00 b8 c9 8a e8 f8 5f fe ff 90 <0f> 0b 90 90 90 e9 7b ff ff ff 90 0f 0b 90 e9 71 fe ff ff e8 cf 84
> RSP: 0018:ffffc900056bf940 EFLAGS: 00010246
> RAX: f63c8546519c3800 RBX: 1ffff92000ad7f30 RCX: 0000000000080000
> RDX: ffffc9000d891000 RSI: 00000000000093ed RDI: 00000000000093ee
> RBP: ffffc900056bfa48 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffed101710487b R12: ffff88803c911e00
> R13: dffffc0000000000 R14: ffff88803c91294c R15: 1ffff11007922529
> FS:  00007fe7c46d66c0(0000) GS:ffff888127020000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30217ff8 CR3: 000000001dfd6000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  local_bh_disable include/linux/bottom_half.h:20 [inline]
>  spin_lock_bh include/linux/spinlock_rt.h:87 [inline]
>  __sock_map_delete net/core/sock_map.c:421 [inline]
>  sock_map_delete_elem+0xaf/0x170 net/core/sock_map.c:452
>  bpf_prog_e78d8a1634f5e22d+0x46/0x4e
>  bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
>  __bpf_prog_run include/linux/filter.h:721 [inline]
>  bpf_prog_run include/linux/filter.h:728 [inline]
>  bpf_prog_run_pin_on_cpu include/linux/filter.h:745 [inline]
>  bpf_flow_dissect+0x225/0x720 net/core/flow_dissector.c:1024
>  bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1425
>  bpf_prog_test_run+0x2cd/0x340 kernel/bpf/syscall.c:4673
>  __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6152
>  __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

