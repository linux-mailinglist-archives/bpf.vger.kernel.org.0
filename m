Return-Path: <bpf+bounces-41842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203FD99C337
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 10:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B18284617
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 08:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CE154BFE;
	Mon, 14 Oct 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1l8tcPP0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90415AAC1
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894440; cv=none; b=C4iugV2vTIAgczeGCw7ictORuT3KMqpJChK4BFWlRBX1KZ4ikDGq9pYKxjTEiwNVJNezIOkSZOBAGeQi+28OnrimLBrtaKKKSvZTRWV6hE+lpI1e4BmckuSzsqRyG2ocpqcPKpVorpOQdX6yxc95i9MHzTNnjcG/Ht/mDK43B9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894440; c=relaxed/simple;
	bh=LvYGHStzCtcz+9e/DZlTfVJS7zU9dpZwIJ9ZhL42uSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZK5FhXJywDcLedefbGWBUmpZp4iKMA5hGdKS76n+T5idU0wt75t/tOoVf4+Z+YfY4IcqrkLrNl/ldAI+AzwwVnk8V9YeHPMNe1OZBuF8Re4a0xxsljcxSdtFpsUyQfSwMENyoGKeqPR6yPoi39cAYu9jPOrzUmZd3Z9HInIGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1l8tcPP0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so49491121fa.2
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728894437; x=1729499237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4U+q04AM0alBVevec+hSgnxI/ctIzw+GPfbc8eU/zBk=;
        b=1l8tcPP0ovdbNr/ltzAe5Q8mDuC2rcoBnAExZwG7dAgt8RM8SUE/+iZEqg2NhgfoL1
         0txkQFt+QvY2nCZZxBg4Pn9kGDI6gdNbf/nIfJ96yTO0kDX+2foCPKOa2a6FZOV6g+wG
         Kma9Tg+ymoAbDkZBlg/W3akKraM5+wqPWacvoUFA4VYTGls/lDy242BvoWJSpZ0Bzgre
         2gHLdwYteOR5TedPBUTVFj94FR6rsAU0jAazJNUudtHambhPPP5xO9wYd1z08VeH5ZRW
         HBXXdBc/D+P9uFnNf8JeZt6xGg49dzc77YgEWF/vVighex8YVhHnlLqj/9mJB+fSn+mf
         8IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894437; x=1729499237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4U+q04AM0alBVevec+hSgnxI/ctIzw+GPfbc8eU/zBk=;
        b=mSVEejDlTZZ50mKlvlYFkxRXBfKQxoMAqwwkwLdetopoOv7VS0yo81dFE6eCBpbgU7
         bxV80yCTqm1P5LQqudzorpE2PLh2uVyoKeNfj7RfVxEu2fz2TgfZTQY4X8VX5XmMBz40
         8R6pqcXoqV2NRTJ9UapaacEri5OIIoYW8RuDnQ+aHG7dwCy/IBqoJqYodTh2DaOXrEqi
         GvL9/SMXVxlBr8c5DM0kjEQWWIqCXzWpJoWyJx1hYbe7Y3uSN5r18g7QGLbhZR12LsQm
         vV8Lb1E+6NIQ5EVH+Rcc1hrl5dMgczZNhUOHgag5CMV1079qUfmV5qOgpSJsOE+y1deR
         8AQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqdf9znVTTGmGu6cklzcdVgiJqTONfMuzQQ5TzEcHjiICBP2xRNdHitOgxj/8d9OaHyVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAORD8ZXVYXYFBXUE9g9HtjmogUeL9TWSc/ffXW1NtwX5eMc7
	qyhO+0mSr2ek5TYS4QZmJwknJlYtHawKFKunmabC5/fnK/9NU8YLJXi2/2NjVeAOi8zcLuhec+M
	1EEd2zvW6FoRtSyo2AzudtAymJW0nlJwpTQQP
X-Google-Smtp-Source: AGHT+IGkWptcxvpbi4kLJj7CIrPyKLsbvdpvN2NGzgazbbzC4V+8GlljYAOc0GZo4E//XsoW8w/0JS1NoNbhy6wodXE=
X-Received: by 2002:a2e:6101:0:b0:2fb:cff:b535 with SMTP id
 38308e7fff4ca-2fb3f1980demr27708401fa.13.1728894436934; Mon, 14 Oct 2024
 01:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb520.050a0220.4cbc0.0041.GAE@google.com>
In-Reply-To: <670cb520.050a0220.4cbc0.0041.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Oct 2024 10:27:05 +0200
Message-ID: <CACT4Y+a1sWaWSVoYrafE+9secQgHYwywEWGCSTF6MZs0Rr7zUA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in __mod_timer / kvfree_call_rcu
To: syzbot <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>, 
	Marco Elver <elver@google.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 08:07, syzbot
<syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=148ae327980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2f7ae2f221e9eae
> dashboard link: https://syzkaller.appspot.com/bug?extid=061d370693bdd99f9d34
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/79bb9e82835a/disk-5b7c893e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5931997fd31c/vmlinux-5b7c893e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fc8cc3d97b18/bzImage-5b7c893e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in __mod_timer / kvfree_call_rcu
>
> read to 0xffff888237d1cce8 of 8 bytes by task 10149 on cpu 1:
>  schedule_delayed_monitor_work kernel/rcu/tree.c:3520 [inline]

+rcu maintainers, this looks more like rcu issue

#syz set subsystems: rcu

>  kvfree_call_rcu+0x3b8/0x510 kernel/rcu/tree.c:3839
>  trie_update_elem+0x47c/0x620 kernel/bpf/lpm_trie.c:441
>  bpf_map_update_value+0x324/0x350 kernel/bpf/syscall.c:203
>  generic_map_update_batch+0x401/0x520 kernel/bpf/syscall.c:1849
>  bpf_map_do_batch+0x28c/0x3f0 kernel/bpf/syscall.c:5143
>  __sys_bpf+0x2e5/0x7a0
>  __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
>  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5739
>  x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:322
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> write to 0xffff888237d1cce8 of 8 bytes by task 56 on cpu 0:
>  __mod_timer+0x578/0x7f0 kernel/time/timer.c:1173
>  add_timer_global+0x51/0x70 kernel/time/timer.c:1330
>  __queue_delayed_work+0x127/0x1a0 kernel/workqueue.c:2523
>  queue_delayed_work_on+0xdf/0x190 kernel/workqueue.c:2552
>  queue_delayed_work include/linux/workqueue.h:677 [inline]
>  schedule_delayed_monitor_work kernel/rcu/tree.c:3525 [inline]
>  kfree_rcu_monitor+0x5e8/0x660 kernel/rcu/tree.c:3643
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
>  worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
>  kthread+0x1d1/0x210 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:4 Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events_unbound kfree_rcu_monitor
> ==================================================================
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/670cb520.050a0220.4cbc0.0041.GAE%40google.com.

