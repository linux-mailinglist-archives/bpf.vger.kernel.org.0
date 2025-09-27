Return-Path: <bpf+bounces-69880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6FBA595C
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 07:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4427232621F
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 05:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15981ACA;
	Sat, 27 Sep 2025 05:47:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464923B62C
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758952072; cv=none; b=gcMjyhE3qZC8DJkRC013IqigTFPSJ9+fKcSPA9trFIQix1QzVRkkC3RjjrzKikgdIo6kX77nwjqv5wVlmEgtIURtcrrZui/eKgFq7v13cNZRHghGNZYb4UhJLonAfGz5yCMnHiGjSMIwr/xhYpB2fPiH10JogaNKiO7iFF9yTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758952072; c=relaxed/simple;
	bh=/A1XHfYqiL6m86d/twQMNE7yCNuB0WyY5f1thFLlGzU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=IWy0SsoPszFqbWhIxsoqi67VocRKq4Ar3eSxOaXlRYY/30eiMzt7FoelnEH1BmYylzSipWbpGs6Aqd1Nw56rQ/7LCyyiWY/IKnjKvJmZ7WU91N0zJuLO5KeU/E2cDSjV+cg2w62jGCmwllS9E1u8fhTETDd6+SZ4n0cU78At20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42594b7f324so53623445ab.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 22:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758952070; x=1759556870;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+sFNfH61oBTsVvfdy0ADyi6bsfNMI5oeFbdyvXP4cY=;
        b=aoRZu20VIifPzJ6jKBhAj71tQypbkQexz/UYBxuy0sgtyueHpvvuQ8e54HqWn8F44t
         oer6iNw5fFnz/VdRkMEhQw1Kz2mXT5d3rKWboXpvHU3yNcNRCAslrP+ZjYpKO+HLH6EC
         aNvWgriYl0R3gzAQYD+vdo8wkriAeJCQLOTUk/+ChHJv/Gc4SDey3pGzPbxf72DYLN3c
         sUJjjL2ak8JOHucpt4GRXzy18gerEHIgUHQVmMsGy0I/s3mXrrtHnXwVgmSdgkPsq8Sw
         WHBTbeEfsjZq047N68hq3ojndHV7vR+z/N/kshb6RpgviHkXrRNcCjQ4iL+qfX0s3n4Y
         O6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUFt1USPli9N+B0p8hV/z2p/x1jEqrMPaAP7ljQbgEe9x8gZM1fKpKNWyBaVO/2KO1N1Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjOLyNDHhCrjViXGz1P5LBYbFay1/qJfg/Dlmw8Fe4NZJjhQvl
	X7d3UJevDpDfLiDPgHlUsJ/zbVL5QkL5YEnasUc15xMLOgX+6MgjNjHh4oeyl3d1xJWOzK8Jzxg
	UP4EiHTNS7uDF0nDE3PigiLb5OX9ituo7meeIkFabj2z4RHK4VeDi+Q3svnc=
X-Google-Smtp-Source: AGHT+IF0bLvN1Dwx1fHUb16SHVoEGHd0AUYxhYgc+MSqPvVsgj217nsAlE5b4G9WpWqsBJcPBvwDqAYkxPUiNWu1XO4rNBhbQ3sP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:425:7a75:1014 with SMTP id
 e9e14a558f8ab-425c2b1c47cmr105751285ab.12.1758952070125; Fri, 26 Sep 2025
 22:47:50 -0700 (PDT)
Date: Fri, 26 Sep 2025 22:47:50 -0700
In-Reply-To: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d77a86.050a0220.25d7ab.0252.GAE@google.com>
Subject: [syzbot ci] Re: BPF signature hash chains
From: syzbot ci <syzbot+ci175b04b41cdfef4d@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bboscaccy@linux.microsoft.com, 
	bpf@vger.kernel.org, daniel@iogearbox.net, 
	james.bottomley@hansenpartnership.com, kpsingh@kernel.org, kys@microsoft.com, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	wufan@linux.microsoft.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] BPF signature hash chains
https://lore.kernel.org/all/20250926203111.1305999-1-bboscaccy@linux.microsoft.com
* [PATCH bpf-next 1/2] bpf: Add hash chain signature support for arbitrary maps
* [PATCH bpf-next 2/2] selftests/bpf: Enable map verification for some lskel tests

and found the following issue:
general protection fault in bpf_prog_verify_signature

Full report is available here:
https://ci.syzbot.org/series/9d93d1cd-d2bd-4967-a631-f3e84ee6fb41

***

general protection fault in bpf_prog_verify_signature

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      d43029ff7d1b7183dc0cf11b6cc2c12a0b810ad8
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/a6b64e3c-6f08-4a6d-b484-ece99910a3f0/config
C repro:   https://ci.syzbot.org/findings/a6c59e03-c4f7-4752-8d4f-526ccf945b7c/c_repro
syz repro: https://ci.syzbot.org/findings/a6c59e03-c4f7-4752-8d4f-526ccf945b7c/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc00020244a9: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000010122548-0x000000001012254f]
CPU: 1 UID: 0 PID: 6002 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:bpf_prog_verify_signature+0x610/0xc40 kernel/bpf/syscall.c:2873
Code: f7 e8 04 73 52 00 4d 8b 2e 89 d8 25 ff ff ff 7f 48 8b 4c 24 10 4c 8d 34 81 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 c9 03 00 00 49 63 06 4c 8d 34 85 00 00 00
RSP: 0018:ffffc90002bff920 EFLAGS: 00010206
RAX: 00000000020244a9 RBX: 0000000004048956 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002bffb30 R08: ffffffff8fa3b537 R09: 1ffffffff1f476a6
R10: dffffc0000000000 R11: fffffbfff1f476a7 R12: 1ffff9200057ff34
R13: 0000000000000000 R14: 000000001012254a R15: 0000000080000000
FS:  0000555591f35500(0000) GS:ffff8881a3c11000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000011081a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 bpf_prog_load+0xcc7/0x19e0 kernel/bpf/syscall.c:3072
 __sys_bpf+0x4ff/0x850 kernel/bpf/syscall.c:6199
 __do_sys_bpf kernel/bpf/syscall.c:6309 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6307 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6307
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feeb318ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd613f7e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007feeb33d5fa0 RCX: 00007feeb318ec29
RDX: 00000000000000b9 RSI: 0000200000000100 RDI: 0000000000000005
RBP: 00007feeb3211e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feeb33d5fa0 R14: 00007feeb33d5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_prog_verify_signature+0x610/0xc40 kernel/bpf/syscall.c:2873
Code: f7 e8 04 73 52 00 4d 8b 2e 89 d8 25 ff ff ff 7f 48 8b 4c 24 10 4c 8d 34 81 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 c9 03 00 00 49 63 06 4c 8d 34 85 00 00 00
RSP: 0018:ffffc90002bff920 EFLAGS: 00010206
RAX: 00000000020244a9 RBX: 0000000004048956 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002bffb30 R08: ffffffff8fa3b537 R09: 1ffffffff1f476a6
R10: dffffc0000000000 R11: fffffbfff1f476a7 R12: 1ffff9200057ff34
R13: 0000000000000000 R14: 000000001012254a R15: 0000000080000000
FS:  0000555591f35500(0000) GS:ffff8881a3c11000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000011081a000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	f7 e8                	imul   %eax
   2:	04 73                	add    $0x73,%al
   4:	52                   	push   %rdx
   5:	00 4d 8b             	add    %cl,-0x75(%rbp)
   8:	2e 89 d8             	cs mov %ebx,%eax
   b:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
  10:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  15:	4c 8d 34 81          	lea    (%rcx,%rax,4),%r14
  19:	4c 89 f0             	mov    %r14,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 c9 03 00 00    	jne    0x3ff
  36:	49 63 06             	movslq (%r14),%rax
  39:	4c                   	rex.WR
  3a:	8d                   	.byte 0x8d
  3b:	34 85                	xor    $0x85,%al
  3d:	00 00                	add    %al,(%rax)


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

