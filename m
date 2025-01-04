Return-Path: <bpf+bounces-47879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F36A0159F
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 16:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104603A3C90
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 15:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841791CEE83;
	Sat,  4 Jan 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVSJ9kbl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699DE1C9B7A;
	Sat,  4 Jan 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005512; cv=none; b=nBYAYyklhkXRWYye2k67X00Oapd2POAyG23PpCZngV5nwP9xC1SyN6F3+KYo43MZqvlIRN+du7gx3iq9ujd1yn+bzn5NKesl91TzoAgYZ/vQG9Ka8Jt98S7nkjt8z44TD2xw7m42aWii3B0FQLGHd2o56CqsttxE+cMPCGyGA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005512; c=relaxed/simple;
	bh=AtyPqjeKFU9afGdDHyL0h3Wn3CMwclYQjfCQPRoZ4o4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAF8TY5mcY9mjnogT8XAsxt/w2reCGkmG2P76mTW6lTakM+AOjKWVDqqapMlyuZh5P69olHPBF6W8lmZ1mhq2iGw1xhkjOcFJngseudAkBhBQwnXgIBqmQxgekDZ3/aZ6a0T9H0vyuo4t1APdDtNOJh1WCSBPrU34cgiTyvWX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVSJ9kbl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67f31a858so2334747366b.2;
        Sat, 04 Jan 2025 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736005508; x=1736610308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGuwaxKFAgepLe7eWKLOd3Qb7WhhDhEuisaVVpDDpj4=;
        b=HVSJ9kblwa209gLikYVpd2AaFE/OiOm+xxuPt5glD++uiy4oRNAeXnHKmRLMBZej2c
         NE/2HVkIR+dSDcBlb/6AsYs/21cgScWT6Ibz3UUWohA77nZZpP6wzGVWxgYImZBb90Tb
         oygjJ53tLMXkio4dMcxnXtaEgbMN2rqE+5FYnWu8UxTDLAW8BWjJA+FkeDJGXZ2rLp47
         sXOiNVQvTa5d325SXgugTJiGpN3yDtusiCSYC34vesy5wuuwsz0mvbV7SlwytlpQJyND
         Yuj1g8/HXmJPiYJzGhSS/RkU0r5fN7TMfftRTIhAsEHozhncTs9RPvOUYtqjtFdQDM5T
         Lp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736005508; x=1736610308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGuwaxKFAgepLe7eWKLOd3Qb7WhhDhEuisaVVpDDpj4=;
        b=YhCnuQseJmW1bPAmzRbqTZtP8Y350VLDR6sFi8rfyin5xTHaGbhU5o8Wfm5B+wiGuP
         Mt9RJK7HkyPX5I5VU5yCNv45lUOTPf2sM4oRivcYejWBDvnm0PcwzO9Gy2ZK3vQ4vaYr
         eZ1W5J9s/fCKRmPvHKmNU7sE4wKXFyGjWNy9ybtxu5bdNqn6Dbc7ug9jchB4AoysT/RJ
         e5FfTKBFQrscN3SNYTgv6aBFvWqY3//Vplo+xQ8PmeF6xilsYj9BjApsuDde7apeb5sG
         OF1jhFlbksvM35WEzmHRi6gjDBNL0qUDISswlHJSnaBRnFA4iBpSB51viXqz56WsPkp+
         8Ahw==
X-Forwarded-Encrypted: i=1; AJvYcCU1JTJz9z7FUmw5yLItIAwaR0DJZa+d/IF9K7I+qCgRBh6C4DJ0gnO67Sd4bONMF1CQUUtnVoLeKIlvNf4d@vger.kernel.org, AJvYcCXbp5W6ROTzXsiIPHUQ/E1+JgzWbkm0M8jNMKki9HfRCN7HoKaPBa9+Xlj96uCvM1qBBok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3WfmNf/K9fD6M2kN1HuN9VUKNsduQjx5rtfXg7M9nozkkbKk
	aT+/+4KK3gKB2/xYg/waeAm/cq9Iy+UkRmoLcNjAhId7OZqNLVNc
X-Gm-Gg: ASbGncuu1Ie3rX45AIlH5Sxj0Gg+6tujh54XAAHbpFbwTkOK2nsxTn0osmIWcxxuudA
	rsqjeO8mrvX5Wd+2Mm8g5GUAjZ8+2uz8caLGnnfhslRFwxpVuwzGQidlBXY4aFAzdER0vliUTdf
	pp/gfe33JJFpWBTuEnzhoWOFNpw7C+gcDe/fqryoT2wDwlBdsPSUhXPMeb8JWRXAVldZ0EkD3Ky
	61hfojqYBiXo7Pc30oTBOKve1nUJc+rdTFflhS8UXo=
X-Google-Smtp-Source: AGHT+IHJh3tqUpfeikKHrKbQUJbD3UvypiV8u45tKCYmGQe3oAVUZMiNiYNDJTlAgyAxndEypxguEw==
X-Received: by 2002:a17:906:dc8d:b0:aa6:7ab9:e24d with SMTP id a640c23a62f3a-aac3365d010mr4221748666b.57.1736005508207;
        Sat, 04 Jan 2025 07:45:08 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f05fd7csm2027771666b.172.2025.01.04.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 07:45:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 4 Jan 2025 16:45:06 +0100
To: syzbot <syzbot+091dd8c0495cc3c6b48d@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING: held lock freed in process_one_work
Message-ID: <Z3lXguFBy-L1Z7Fj@krava>
References: <67769386.050a0220.3a8527.003e.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67769386.050a0220.3a8527.003e.GAE@google.com>

On Thu, Jan 02, 2025 at 05:24:22AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fd0584d220fe Merge tag 'trace-tools-v6.13-rc4' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16bf90b0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
> dashboard link: https://syzkaller.appspot.com/bug?extid=091dd8c0495cc3c6b48d
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ecc75c8807ba/disk-fd0584d2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0d5d397df783/vmlinux-fd0584d2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/da7bfd7b8963/bzImage-fd0584d2.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+091dd8c0495cc3c6b48d@syzkaller.appspotmail.com
> 
> =========================
> WARNING: held lock freed!
> 6.13.0-rc4-syzkaller-00071-gfd0584d220fe #0 Not tainted
> -------------------------
> kworker/1:2/28505 is freeing memory 0000000000000000-ffffffffffffefff, with a lock still held there!

that address range looks wrong, too bad there's no reproducer

jirka


> ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12cd/0x1b30 kernel/workqueue.c:3204
> 2 locks held by kworker/1:2/28505:
>  #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x12cd/0x1b30 kernel/workqueue.c:3204
>  #1: ffffc900186f7d80 ((work_completion)(&aux->work)){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1b30 kernel/workqueue.c:3205
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 28505 Comm: kworker/1:2 Not tainted 6.13.0-rc4-syzkaller-00071-gfd0584d220fe #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events bpf_prog_free_deferred
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_freed_lock_bug kernel/locking/lockdep.c:6662 [inline]
>  debug_check_no_locks_freed+0x208/0x2b0 kernel/locking/lockdep.c:6697
>  remove_vm_area+0x128/0x3f0 mm/vmalloc.c:3240
>  vfree+0x90/0x950 mm/vmalloc.c:3364
>  bpf_prog_free_deferred+0x539/0x6f0 kernel/bpf/core.c:2820
>  process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ------------[ cut here ]------------
> ODEBUG: free active (active state 1) object: ffff88807a9a9100 object type: rcu_head hint: 0x0
> WARNING: CPU: 1 PID: 28505 at lib/debugobjects.c:612 debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
> Modules linked in:
> 
> CPU: 1 UID: 0 PID: 28505 Comm: kworker/1:2 Not tainted 6.13.0-rc4-syzkaller-00071-gfd0584d220fe #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events bpf_prog_free_deferred
> 
> RIP: 0010:debug_print_object+0x1a2/0x2b0 lib/debugobjects.c:612
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd e0 80 b1 8b 41 56 4c 89 e6 48 c7 c7 60 75 b1 8b e8 af 52 bc fc 90 <0f> 0b 90 90 58 83 05 f6 53 7f 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
> RSP: 0018:ffffc900186f7a08 EFLAGS: 00010282
> 
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff815a1729
> RDX: ffff8880655ebc00 RSI: ffffffff815a1736 RDI: 0000000000000001
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8bb17c00
> R13: ffffffff8b4e5e20 R14: 0000000000000000 R15: ffffc900186f7b18
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f78f559790a CR3: 000000006b8b2000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __debug_check_no_obj_freed lib/debugobjects.c:1099 [inline]
>  debug_check_no_obj_freed+0x4b7/0x600 lib/debugobjects.c:1129
>  remove_vm_area+0x1ae/0x3f0 mm/vmalloc.c:3241
>  vfree+0x90/0x950 mm/vmalloc.c:3364
>  bpf_prog_free_deferred+0x539/0x6f0 kernel/bpf/core.c:2820
>  process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
>  process_scheduled_works kernel/workqueue.c:3310 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
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

