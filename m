Return-Path: <bpf+bounces-74224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFCC4E03E
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 14:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76CE3A2AAB
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329083246FE;
	Tue, 11 Nov 2025 13:03:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C186309F07
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866185; cv=none; b=mMVuOHZDq3RqULwSzap4aXvspGuLFzs96A66cs7znlGWBl5STl7vGR95eAQcx5HXZcbLsH6VYcC0UbYA541gPQyGTPNVGnXWtMVgFJq/gwiVrJ0mNWj9ZV7e9cxn8vzVPNGHc5BwU1zagORwSIMrSBZ3iKo+wwmQLoCz7SYZuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866185; c=relaxed/simple;
	bh=Vt1k5EQoPqh3Nrp0Bhb6ewVSEmyuqnxy7cXy4xH/yLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DAfOAwtvXe15f5YBJdAft5DPw+sG7erU2AxiE6OFMNwn9CRN3ZT8dg0j9dnGxeXGShl1Iypg6Olw06F1O7VnN7xi1dqCKaCvLH41CKujJm5PxCo5htnzPx1fKjfMAg3Ok/SJAqEo3cFvbDYCT6I1YIoTwbcapCmq2NekH12zSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43470d72247so1808905ab.3
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 05:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762866183; x=1763470983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGB/TAKZOcKtrhPxjpEL/9Rt1n53HiPGQxYzu5TTEyA=;
        b=XNnqTtUcEl/n7P3eOon0afkwna2dnn+RNe+Lp9Zv2Z/ygx7W+p0sbo7Bn7mxu09u+i
         q5K47rbMKMeAc60KW9ya/SRoYIRDohj9tcMoHqQ8gM8gNudZATqrB6bqm+cYFBGdKXC/
         +t3PDCzgtm7aoPDpj6sS5T/r83g0VzsX7nc0qoeHWNg5gWA2Z3P2sPaGN4nsR2wpLgtK
         GioZYXB+mT1aQj0Mi76D1LSE+buja3Wq1xyID6uTklBqyOzlnc6Ai4oR3ZwJ55KIB46u
         X+RhwQv/u2T7Cbmwhw+/EcbZPZcd7O6PMF4tFkO2yczzKBMoizFcII/lusCWGWxMQHXg
         nQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyzHUCnE0GvrWKdJ4DzxksYU/5v/aWeioN3BydWv0if6bJvTPc9mJB5orcS4bU+kWKg2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kjWUuPJh8cNWMWAR6dYVh2VYP1HNv1taERkL+4o0BSCiHiwV
	J43hGGgUH8S+m6C9fZgmJRouS1qsSzUaDRwJPrpTshatoRmslw/PhN2QOXyYj5QiHLuRkj/4762
	FyqaiUwgnbr+Mv8QYoY0Snt7wLZ1gxTaoku5giwJcD2gCBKoQAR3rLCDYNYw=
X-Google-Smtp-Source: AGHT+IEpTzA/3NqtQbsss3Bt9ogTGA39GU8M8pGLRnvPzS3lXufcYtJkf55mtmGcYxBah4LCmhDhp2qV1vWIUjAYrBjwalX4qAqr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2408:b0:433:29c3:c512 with SMTP id
 e9e14a558f8ab-43367e2d24emr143895815ab.21.1762866183264; Tue, 11 Nov 2025
 05:03:03 -0800 (PST)
Date: Tue, 11 Nov 2025 05:03:03 -0800
In-Reply-To: <20251111-covern-deklamieren-ee89b7b4e502@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69133407.a70a0220.22f260.0138.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __ns_ref_active_put

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6581 at kernel/nscommon.c:171 __ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Modules linked in:
CPU: 0 UID: 0 PID: 6581 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Code: 4d 8b 3e e9 1b fd ff ff e8 76 62 32 00 90 0f 0b 90 e9 29 fd ff ff e8 68 62 32 00 90 0f 0b 90 e9 59 fd ff ff e8 5a 62 32 00 90 <0f> 0b 90 e9 72 ff ff ff e8 4c 62 32 00 90 0f 0b 90 e9 64 ff ff ff
RSP: 0018:ffffc9000238fd68 EFLAGS: 00010293
RAX: ffffffff818e5946 RBX: 00000000ffffffff RCX: ffff8880302ebc80
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000238fe00 R08: ffff888078968c2b R09: 1ffff1100f12d185
R10: dffffc0000000000 R11: ffffed100f12d186 R12: dffffc0000000000
R13: 1ffff1100f12d184 R14: ffff888078968c20 R15: ffff888078968c28
FS:  00007efc0fd536c0(0000) GS:ffff888125cf3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33263fff CR3: 0000000030876000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nsproxy_ns_active_put+0x4a/0x200 fs/nsfs.c:701
 free_nsproxy kernel/nsproxy.c:80 [inline]
 put_nsset kernel/nsproxy.c:316 [inline]
 __do_sys_setns kernel/nsproxy.c:-1 [inline]
 __se_sys_setns+0x1349/0x1b60 kernel/nsproxy.c:534
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc0ef90ef7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 34 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc0fd52fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000134
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007efc0ef90ef7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c9
RBP: 00007efc0f011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efc0f1e6038 R14: 00007efc0f1e5fa0 R15: 00007fff5692b648
 </TASK>


Tested on:

commit:         cc719c88 nsproxy: fix free_nsproxy() and simplify crea..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=1613f17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

