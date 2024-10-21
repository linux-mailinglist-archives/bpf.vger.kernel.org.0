Return-Path: <bpf+bounces-42656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96A9A6EFA
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 18:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D54B1F21F0C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29111DF754;
	Mon, 21 Oct 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7e3feHW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7217C224;
	Mon, 21 Oct 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526520; cv=none; b=ouXg9piQhxokwl6gGpV8kG6RrfoNo6ZOE8D38XJmjAaB22rmzkDbzEKiLvrMfWOjSqnyNX8ycMeP1TlySOXByoeXkgRZAz36xZC4x3R7JGkGB37qrPgFoHDhb3W18gr21H/Jbz8AXSSDR0DM66NYB49dW/azTY2oNK6eadXLYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526520; c=relaxed/simple;
	bh=KqOvlvWU4dwKQIYucRDgx5Bc6wlqDO5UU2lJZuu2g4g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBLLPjjGeywEWAE5CelvVbsQZtwsJAl1jm/FLLWS9ubiPFS5492DbgIzNTN4aE6gnnFa+1tPThvxq9weVErOjIt1c2L8XWt74iK9Tyau2qU9/t4XQ3DugrHAEls+s3n4CgfiWWlCHICQB+epRx8+nCXHo+K1aPOitubZtiaV0wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7e3feHW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e8586b53so4781465e87.1;
        Mon, 21 Oct 2024 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729526516; x=1730131316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U3dxFTPmf1Xx55SxWH3mCtz6g7NbAdX1kAdoe9FSYX4=;
        b=Y7e3feHWAdZu4baUmetvZbgMdzPErvu2LoFcLVvYsQ9csI89ZlmQlzOZgNwm3oG/WG
         NLHSogxJY1k8bOWqkGqGnUorDtkmIbwFy/r0m1duhd72toGiWab+9eGM3qlRtJ0vdznL
         iWPQ7sIKdC/xVWXJfePC0sHmbUpD3fiNHs9019xFUOe02+2NW716nhNNDaRI0BWFqfJP
         wbfIVDal+3zcErC9KTWpG7IyCHpOYA+gN648VOSERPklOr+H5S+VezcZ4uzP2z06Te5O
         ptjK9f7+XTCMdnBx8VIIZOkCYoyDCaL6s7kEU7z23kAAQcBbHn1651/2ih0Tt6ogxA2C
         2htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526516; x=1730131316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3dxFTPmf1Xx55SxWH3mCtz6g7NbAdX1kAdoe9FSYX4=;
        b=ppDpY4TmI7hN3XWgUPlET42BsI5qPZ+flIITXp74IJkhGFTApxlw2tfJok5iuv4mhU
         TFB5on3ZJ92Yy7q9DTEzPHwG7iHHr5OrzB7gbxH016UEwGBkZMM3bSfkense8dAbgo/w
         0d7N/M/XU6PCVj9b2lVm2kdGP59SHTWXaKJZV0kn4Z8s5/28VlFOXI+mgg+2ocp/3WW2
         wCVbb9g2Dx8kpvmCrlRVd3BG3vqzFcfht2RYKlWtWIrKFQ8eREHgfPqxlkTzFWEQE2bc
         x/9x74x9HC+0CWbWqQKL2wyz6juHPAnj4SD+NdiKxfFq3tbAnNC8cKqJlYWZMjWTkIis
         gZZg==
X-Forwarded-Encrypted: i=1; AJvYcCV3WIozy9H9wHxr/72RQchfKBkIbAIa39blCjM+JwjYIYqgEO8fyEtBOD/rcZ2DjHi9e17/8tt+2DzlzoMx@vger.kernel.org, AJvYcCVRkI1Evz/yus3DFAe56YuKtM80kI2Q0os4e7FnmpQaQWYc+lf4MCXf0p4Xv5DdNpFWCC3Q@vger.kernel.org, AJvYcCXJRVUZKyDwAgGZEF9JlpyfOVrCrbPTCa4+8ml25H+Ifb+r1l7VzdFsPxntcdIPhKWkSX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hyDxjA249ou9Ohn4v3Ktnz+ULTRBvmvWdn8amu09pI4nw1XY
	shku7BZkx4CEu77EsTFEfWM/R2EGmmJObQT1NOK9u4ytJZ+Q5Vq0
X-Google-Smtp-Source: AGHT+IHeKm06YyrvKQ0tfAGHWdf+1GK274E7UqvzwaxdSk+6ZjECVQrZ5AXSQ8ROVmeI8Ec5+paYeA==
X-Received: by 2002:a05:6512:3d92:b0:539:fe02:c1fe with SMTP id 2adb3069b0e04-53b13185208mr22440e87.16.1729526515916;
        Mon, 21 Oct 2024 09:01:55 -0700 (PDT)
Received: from pc636 (host-90-233-222-236.mobileonline.telia.com. [90.233.222.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a224313b5sm521241e87.201.2024.10.21.09.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:01:55 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 21 Oct 2024 18:01:52 +0200
To: paulmck@kernel.org
Cc: paulmck@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com>,
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
Message-ID: <ZxZ68KmHDQYU0yfD@pc636>
References: <670cb520.050a0220.4cbc0.0041.GAE@google.com>
 <CACT4Y+a1sWaWSVoYrafE+9secQgHYwywEWGCSTF6MZs0Rr7zUA@mail.gmail.com>
 <278957c8-a6d2-43e5-aed7-9ed44648ffb2@paulmck-laptop>
 <CA+KHdyX5n8K0guzyGiWFOt=p8UY6OvHrkH01-wgRHjzF8BZxDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+KHdyX5n8K0guzyGiWFOt=p8UY6OvHrkH01-wgRHjzF8BZxDQ@mail.gmail.com>

> On Mon, Oct 14, 2024 at 7:00 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Oct 14, 2024 at 10:27:05AM +0200, Dmitry Vyukov wrote:
> > > On Mon, 14 Oct 2024 at 08:07, syzbot
> > > <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=148ae327980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=061d370693bdd99f9d34
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/79bb9e82835a/disk-5b7c893e.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/5931997fd31c/vmlinux-5b7c893e.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/fc8cc3d97b18/bzImage-5b7c893e.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
> > > >
> > > > ==================================================================
> > > > BUG: KCSAN: data-race in __mod_timer / kvfree_call_rcu
> > > >
> > > > read to 0xffff888237d1cce8 of 8 bytes by task 10149 on cpu 1:
> > > >  schedule_delayed_monitor_work kernel/rcu/tree.c:3520 [inline]
> >
> > This is the access to krcp->monitor_work.timer.expires in the function
> > schedule_delayed_monitor_work().
> >
> > Uladzislau, could you please take a look at this one?
> >
> >                                                         Thanx, Paul
> >
> > > +rcu maintainers, this looks more like rcu issue
> > >
> > > #syz set subsystems: rcu
> > >
> > > >  kvfree_call_rcu+0x3b8/0x510 kernel/rcu/tree.c:3839
> > > >  trie_update_elem+0x47c/0x620 kernel/bpf/lpm_trie.c:441
> > > >  bpf_map_update_value+0x324/0x350 kernel/bpf/syscall.c:203
> > > >  generic_map_update_batch+0x401/0x520 kernel/bpf/syscall.c:1849
> > > >  bpf_map_do_batch+0x28c/0x3f0 kernel/bpf/syscall.c:5143
> > > >  __sys_bpf+0x2e5/0x7a0
> > > >  __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
> > > >  __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
> > > >  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5739
> > > >  x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > write to 0xffff888237d1cce8 of 8 bytes by task 56 on cpu 0:
> > > >  __mod_timer+0x578/0x7f0 kernel/time/timer.c:1173
> > > >  add_timer_global+0x51/0x70 kernel/time/timer.c:1330
> > > >  __queue_delayed_work+0x127/0x1a0 kernel/workqueue.c:2523
> > > >  queue_delayed_work_on+0xdf/0x190 kernel/workqueue.c:2552
> > > >  queue_delayed_work include/linux/workqueue.h:677 [inline]
> > > >  schedule_delayed_monitor_work kernel/rcu/tree.c:3525 [inline]
> > > >  kfree_rcu_monitor+0x5e8/0x660 kernel/rcu/tree.c:3643
> > > >  process_one_work kernel/workqueue.c:3229 [inline]
> > > >  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
> > > >  worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
> > > >  kthread+0x1d1/0x210 kernel/kthread.c:389
> > > >  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > >
> > > > Reported by Kernel Concurrency Sanitizer on:
> > > > CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:4 Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > > > Workqueue: events_unbound kfree_rcu_monitor
> > > > ==================================================================
> > > > bridge0: port 2(bridge_slave_1) entered blocking state
> > > > bridge0: port 2(bridge_slave_1) entered forwarding state
> > > >
>
I tried to reproduce it but i am not able to. For the other hand, it is
obvious that a reading "krcp->monitor_work.timer.expires" and simultaneous
writing is possible.

So, we can address it, i mean to prevent such parallel access by following patch:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..d711870fde84 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3531,7 +3531,7 @@ static int krc_count(struct kfree_rcu_cpu *krcp)
 }
 
 static void
-schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+__schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 {
 	long delay, delay_left;
 
@@ -3545,6 +3545,16 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
 }
 
+static void
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	__schedule_delayed_monitor_work(krcp);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
 static void
 kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 {
@@ -3841,7 +3851,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_monitor_work(krcp);
+		__schedule_delayed_monitor_work(krcp);
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
<snip>

i will send out the patch after some testing!

--
Uladzislau Rezki

