Return-Path: <bpf+bounces-42205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515E9A0DA3
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5041F24163
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB33C20E02F;
	Wed, 16 Oct 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jutC7Ve5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2654F95;
	Wed, 16 Oct 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091293; cv=none; b=LeHsnSZWWIURkm/lTRGXCRnBoE6POvq77ai4IIU8H+9eWr2XIv+gu/BexKbDGYz2HbR+koscizfz4LWmXjcSGdhWgh1S5ncXldKKSny+ThlGEScaGQdFwtYV3CWKLWXdZvDygzNAUrGXVIn9578LT3Cj0rEJcO6/vHoKZErhemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091293; c=relaxed/simple;
	bh=LFMX6aOf4sbvZcO0BW0FdVsE+TnJkhrN/1S+FnDsSdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2FVyxfegjZzlUq7N1Nan36u0w5UY/j4kwTuarYQTtgnnliLihsF9kq4KtuOwYtGwQHnXbX3YRNhrQ1nakKMgkKa3Gh2PfBA89IUuajmEkKF28ZHN7Up/hR56Ubnp0tBifIbrE/6AOnAeGWjmEpCIOyrTPuM6yyPgVMF+t2AOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jutC7Ve5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c962c3e97dso4982850a12.0;
        Wed, 16 Oct 2024 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729091290; x=1729696090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R0Mxro5aq1p2IlmjvlEWTlfSxkLbXh80rEOstKpdqk=;
        b=jutC7Ve5upaZ/LjRe/pc/rCGncdaG0/SeR0ySfX6Ox2mwT23kXRPRMJ81zHyUjun37
         jQNM5z3mlzKV4SZBok6+9CZV8ZpFVp0GQV4eTYfRQvBrn5IYs3zZR/10IkDojzzhcjbU
         7WF+WkZ5iC8Bjc+HtLL8VnqtsZp+/c7AF2xOko1QR3e4C1Bv2WG4Bo8cLZzl4icVRIe5
         zMgfnSjkJjmxgLcRUGaSjooEI/ThYzOr7Y74eqi42+9NiCuJo0H7vfkIdwRjOzi4vAie
         h+sl+5IiVzT63+4YSvZFFWNTmiGVvI0B2Lnj+wr3ZletI3MEWzJiLNb9sEAqmkKj9bVe
         4OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091290; x=1729696090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R0Mxro5aq1p2IlmjvlEWTlfSxkLbXh80rEOstKpdqk=;
        b=Vq+5MSYgUsv37PAsYY9lDv75oUcoDkAUESu9HNjeb1aK7iEKxMxJQZ9kVWpJEO9sVf
         dT6JAfvZq6WGYiNoESlzk/xpxGPZCGqr67Vqb6Jid0eyvxRyDnnYOxPiCCBLyGOLSPB6
         Bkfk8HeQgSbPss9H5iFgLDqLaSfHmu2HTPeJ+H9/i8YV42/P/YvMTEAFSAIqpicW66uz
         aGWp8b1rdTCMXuu7NPfvINc/ktPiYGQ1UIen50zyf3ytIm4T8a/VbOvy4GmB//JrWoSx
         740ptVPyfcEchTZa3up6JiVC1s8UvOk18RFtt1TkFSV6T5mWvmLnvEN3KRxBphBIZZfU
         Tpuw==
X-Forwarded-Encrypted: i=1; AJvYcCUhJwCC3aHQ1qJw0ew3DwuwcXKQ08fu1qzUGZKdCPoNMsI5n07GD+Jv2nQqZQbvC/m5kLkjFchmei4YJVJ3@vger.kernel.org, AJvYcCVVNmeSmXVGOvPSJv1HRE1EbL9EXYus0iBEMRe1QtEvN3BnVNnK9eyCpCL0F3VGgxG8XdY=@vger.kernel.org, AJvYcCXBSVgcexanWCTWU1cKemjDYft8BGlZSt6rkkuq/ScezYMPsCuFEEU06k3Yq+boI4e0fgKG@vger.kernel.org
X-Gm-Message-State: AOJu0YzghmowakKFwTwjsy1PhUE/lSxPQCpgsLrEQfM7jNfOQNFjmRNO
	hfKigIjVs4wfmWbwCQG1yeHXoQ/34j6QsEWbDD2wxN4qV+TAdXWWSdmtqeEx3YkNa10aJlnB5ZO
	wYVwIJab57o1QEvXXWpnI7pXBFjQ=
X-Google-Smtp-Source: AGHT+IF1U+zudIlW1KBw4ym9LDMi6u1ZDc7h3iZU66bIWFZRg5MRqpidxzHN7eV/h97wUE8QUDdTRTbxFKDDdivRh7c=
X-Received: by 2002:a05:6402:2714:b0:5c9:7dd9:3eda with SMTP id
 4fb4d7f45d1cf-5c97dd946f0mr9522311a12.5.1729091289619; Wed, 16 Oct 2024
 08:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb520.050a0220.4cbc0.0041.GAE@google.com> <CACT4Y+a1sWaWSVoYrafE+9secQgHYwywEWGCSTF6MZs0Rr7zUA@mail.gmail.com>
 <278957c8-a6d2-43e5-aed7-9ed44648ffb2@paulmck-laptop>
In-Reply-To: <278957c8-a6d2-43e5-aed7-9ed44648ffb2@paulmck-laptop>
From: Uladzislau Rezki <urezki@gmail.com>
Date: Wed, 16 Oct 2024 17:07:58 +0200
Message-ID: <CA+KHdyX5n8K0guzyGiWFOt=p8UY6OvHrkH01-wgRHjzF8BZxDQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in __mod_timer / kvfree_call_rcu
To: paulmck@kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>, 
	Marco Elver <elver@google.com>, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will have a look at this!

On Mon, Oct 14, 2024 at 7:00=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Oct 14, 2024 at 10:27:05AM +0200, Dmitry Vyukov wrote:
> > On Mon, 14 Oct 2024 at 08:07, syzbot
> > <syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://gi=
thub...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D148ae3279=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da2f7ae2f2=
21e9eae
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D061d370693b=
dd99f9d34
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/79bb9e82835a=
/disk-5b7c893e.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/5931997fd31c/vm=
linux-5b7c893e.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/fc8cc3d97b=
18/bzImage-5b7c893e.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+061d370693bdd99f9d34@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KCSAN: data-race in __mod_timer / kvfree_call_rcu
> > >
> > > read to 0xffff888237d1cce8 of 8 bytes by task 10149 on cpu 1:
> > >  schedule_delayed_monitor_work kernel/rcu/tree.c:3520 [inline]
>
> This is the access to krcp->monitor_work.timer.expires in the function
> schedule_delayed_monitor_work().
>
> Uladzislau, could you please take a look at this one?
>
>                                                         Thanx, Paul
>
> > +rcu maintainers, this looks more like rcu issue
> >
> > #syz set subsystems: rcu
> >
> > >  kvfree_call_rcu+0x3b8/0x510 kernel/rcu/tree.c:3839
> > >  trie_update_elem+0x47c/0x620 kernel/bpf/lpm_trie.c:441
> > >  bpf_map_update_value+0x324/0x350 kernel/bpf/syscall.c:203
> > >  generic_map_update_batch+0x401/0x520 kernel/bpf/syscall.c:1849
> > >  bpf_map_do_batch+0x28c/0x3f0 kernel/bpf/syscall.c:5143
> > >  __sys_bpf+0x2e5/0x7a0
> > >  __do_sys_bpf kernel/bpf/syscall.c:5741 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5739 [inline]
> > >  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5739
> > >  x64_sys_call+0x2625/0x2d60 arch/x86/include/generated/asm/syscalls_6=
4.h:322
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > write to 0xffff888237d1cce8 of 8 bytes by task 56 on cpu 0:
> > >  __mod_timer+0x578/0x7f0 kernel/time/timer.c:1173
> > >  add_timer_global+0x51/0x70 kernel/time/timer.c:1330
> > >  __queue_delayed_work+0x127/0x1a0 kernel/workqueue.c:2523
> > >  queue_delayed_work_on+0xdf/0x190 kernel/workqueue.c:2552
> > >  queue_delayed_work include/linux/workqueue.h:677 [inline]
> > >  schedule_delayed_monitor_work kernel/rcu/tree.c:3525 [inline]
> > >  kfree_rcu_monitor+0x5e8/0x660 kernel/rcu/tree.c:3643
> > >  process_one_work kernel/workqueue.c:3229 [inline]
> > >  process_scheduled_works+0x483/0x9a0 kernel/workqueue.c:3310
> > >  worker_thread+0x51d/0x6f0 kernel/workqueue.c:3391
> > >  kthread+0x1d1/0x210 kernel/kthread.c:389
> > >  ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:4 Not tainted 6.12.0-rc2-syzka=
ller-00050-g5b7c893ed5ed #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 09/13/2024
> > > Workqueue: events_unbound kfree_rcu_monitor
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > bridge0: port 2(bridge_slave_1) entered blocking state
> > > bridge0: port 2(bridge_slave_1) entered forwarding state
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > >
> > > --
> > > You received this message because you are subscribed to the Google Gr=
oups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/=
msgid/syzkaller-bugs/670cb520.050a0220.4cbc0.0041.GAE%40google.com.



--=20
Uladzislau Rezki

