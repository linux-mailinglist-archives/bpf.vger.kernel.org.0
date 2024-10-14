Return-Path: <bpf+bounces-41876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A499D51C
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 19:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C96A1C228D4
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC381C304B;
	Mon, 14 Oct 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcx+jtY3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8391C3023;
	Mon, 14 Oct 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925209; cv=none; b=rS9o72P/vFIW/fS9xpDEFGzqJOI9EjEOTZB7clodsjx5pRL/7h/JQQ2KTDXwycXNWqgMsp/19iJwF+0YEVZUkj15jTQP0hgyvFe+YpjsWXgdgVJNgmq0AHoEseVV7YMckiB4G0mAIkxsUrbteXCVbEEyjlWtJMRCIscPRr6q4IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925209; c=relaxed/simple;
	bh=dx2soaUPCbsFbZieW0r9gxOBgSB3AIqhOEL8OJLMfPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikFZaHL5t+aOnjXFIuP5YbqPuAn+nh5C98IkgSry6d3TYmOrIDL964e8V6zyU5HQhsMG/vlBWePLHAIh+c7WuKKG1t7UsDui1owzCnzn7sOaSIVWsFL1JfEhqtjmN9v5zhYRSsggC4vvXI/vqoL//QZxSpB0Deb+kXMNgJxljww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcx+jtY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F963C4CED0;
	Mon, 14 Oct 2024 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925209;
	bh=dx2soaUPCbsFbZieW0r9gxOBgSB3AIqhOEL8OJLMfPk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Bcx+jtY3TY/WdSFe9X4umz+KPyrrz21jFD9/nBQXt695h+rVTzuRPZRxhp2lkpX2I
	 LS/DPrYb9bc4vLbK4CGuCzmoBSE/GEOFW8cWWaDEKCppGT5PlyQYZCS/lBpDcAlA1g
	 3Bo9Aupm2NljgLMu/8S31XkMkPYmpltddaZUbmLI1AP4aawUTW8lDNwXgiricjAFic
	 YFQ9fFcSqzw1ewTfDB/rzqTaDO36RzIVMpUwFbBiQlS0lIMLLBTRDjAhYWbdnmS1IX
	 u6c1fZZoqVQjj1x5Y3KsIPFB6ea6LbYm2pYDNuthohNNtEI7SKQPhLJ7OQ+9D46GKn
	 KJkOG5a7U2hOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7296CE0B68; Mon, 14 Oct 2024 10:00:08 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:00:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>, urezki@gmail.com
Cc: syzbot <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	Marco Elver <elver@google.com>, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in __mod_timer / kvfree_call_rcu
Message-ID: <278957c8-a6d2-43e5-aed7-9ed44648ffb2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <670cb520.050a0220.4cbc0.0041.GAE@google.com>
 <CACT4Y+a1sWaWSVoYrafE+9secQgHYwywEWGCSTF6MZs0Rr7zUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a1sWaWSVoYrafE+9secQgHYwywEWGCSTF6MZs0Rr7zUA@mail.gmail.com>

On Mon, Oct 14, 2024 at 10:27:05AM +0200, Dmitry Vyukov wrote:
> On Mon, 14 Oct 2024 at 08:07, syzbot
> <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=148ae327980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
> > dashboard link: https://syzkaller.appspot.com/bug?extid=061d370693bdd99f9d34
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/79bb9e82835a/disk-5b7c893e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5931997fd31c/vmlinux-5b7c893e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fc8cc3d97b18/bzImage-5b7c893e.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KCSAN: data-race in __mod_timer / kvfree_call_rcu
> >
> > read to 0xffff888237d1cce8 of 8 bytes by task 10149 on cpu 1:
> >  schedule_delayed_monitor_work kernel/rcu/tree.c:3520 [inline]

This is the access to krcp->monitor_work.timer.expires in the function
schedule_delayed_monitor_work().

Uladzislau, could you please take a look at this one?

							Thanx, Paul

> +rcu maintainers, this looks more like rcu issue
> 
> #syz set subsystems: rcu
> 
> >  kvfree_call_rcu+0x3b8/0x510 kernel/rcu/tree.c:3839
> >  trie_update_elem+0x47c/0x620 kernel/bpf/lpm_trie.c:441
> >  bpf_map_update_value+0x324/0x350 kernel/bpf/syscall.c:203
> >  generic_map_update_batch+0x401/0x520 kernel/bpf/syscall.c:1849
> >  bpf_map_do_batch+0x28c/0x3f0 kernel/bpf/syscall.c:5143
> >  __sys_bpf+0x2e5/0x7a0
> >  __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
> >  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5739
> >  x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > write to 0xffff888237d1cce8 of 8 bytes by task 56 on cpu 0:
> >  __mod_timer+0x578/0x7f0 kernel/time/timer.c:1173
> >  add_timer_global+0x51/0x70 kernel/time/timer.c:1330
> >  __queue_delayed_work+0x127/0x1a0 kernel/workqueue.c:2523
> >  queue_delayed_work_on+0xdf/0x190 kernel/workqueue.c:2552
> >  queue_delayed_work include/linux/workqueue.h:677 [inline]
> >  schedule_delayed_monitor_work kernel/rcu/tree.c:3525 [inline]
> >  kfree_rcu_monitor+0x5e8/0x660 kernel/rcu/tree.c:3643
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
> >  worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
> >  kthread+0x1d1/0x210 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:4 Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Workqueue: events_unbound kfree_rcu_monitor
> > ==================================================================
> > bridge0: port 2(bridge_slave_1) entered blocking state
> > bridge0: port 2(bridge_slave_1) entered forwarding state
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/670cb520.050a0220.4cbc0.0041.GAE%40google.com.

