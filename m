Return-Path: <bpf+bounces-74354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15255C561B2
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E588B3BB550
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A132BF38;
	Thu, 13 Nov 2025 07:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE563329E52
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019701; cv=none; b=n1P8/BOMljttsTCWJ6KyqLlZwQq2mTeo+u2ln0DnCs4rX8ci2I4GAnLxFxPs5DSuLdMZkoKxFpxpqeDbYXUxOiKMHtr0gqRPOI0bhjkQGmsOexzI5nwUHP3UN5HTuaVma2JUSixmcibQxJvwC4ABnGJUeHdMltpCaepusehl2mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019701; c=relaxed/simple;
	bh=wL3ajtIbhIl7uczCpuXPKbOTU1CBaLDkdZK72JB/MnQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HBAkZIwJreoqwKey75RVoNXiD/cfIyjA9/uJSf2/RE4rEruYNUeFwZvFKL3pkuKDcNPdGNdvcuit/FejpemJ8CGqMzLIuYkNLHb3uwAOkDw0+hNDcIwdFpjRXHqJVFqu8t+ieIrQanTpFl6S28goAKibYEEvJ5wU2HC4PkiCDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4337e3aca0cso8399675ab.1
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 23:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763019697; x=1763624497;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWzdKl7vgdIGJfdYX6z8A/NZowwAqQ9vSHhm0lIHqaA=;
        b=EA6fPDX2b/y/KwVG00TUSf5wpLg2EZYxpt4ylbV71XBBL5MdOiYHsOtq15kw5xIjVO
         9uhZDxaJPFl9PMpVTc3oqqMZsYa2QztvUeJ9GTtLPdyoMqV9vBnDWSzNoce79ia3MpgA
         nbDGcK/PV1ssMLRsBbxryHQmUhhLaX9MFGW7oQB2QKqYV03+uN7NlzNJxRalDUqjZ6IA
         KxDt6OoV2lZ8c9Cq8jPZf2PHVn1TyhQC/F3FMsClGiZyLOiROCeRHhlHgsKUjgaH3zDe
         ckZt3/N1B6w3D1HvV0doio5zUTuzHvh+UYtWeGs1OrQVhtF08W2v51U7gjj2A39ijiy4
         A19A==
X-Forwarded-Encrypted: i=1; AJvYcCVDBm9FANbAwavq7ejmGqCp+xs7Uc6SXz8HLdelpQwm0tNhnTRaZdi+r+6PGhHt+yDD8gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiHE6hO8dmhHxpBo4cgcojsEMctiunNcP5EF4B906pm2JY7L6
	UtB6t9F0DnwarOferVO0AGKjdbXDafHx/RR70nMDD89F2WMFpHvdxepnTWhm/bEPtT/i9MG6WWE
	bVqZVvQJpnyboIo+G6yl2NfyM2riglNNZ4kJbe7cTS5ClPVfB2vCP2Ir1uHk=
X-Google-Smtp-Source: AGHT+IG3FVRXoV3IJYse4nKZ7YA6tLNSXRmqIqWo6eFJ4/fcr5tzXzRXuvajfRcvKmFz7PDAabk2bViR8Eeqb1Oz5r5xzHzojmQl
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2283:b0:433:2812:8066 with SMTP id
 e9e14a558f8ab-43473ddd4edmr74082945ab.23.1763019697635; Wed, 12 Nov 2025
 23:41:37 -0800 (PST)
Date: Wed, 12 Nov 2025 23:41:37 -0800
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69158bb1.a70a0220.3124cb.001e.GAE@google.com>
Subject: [syzbot ci] Re: make vmalloc gfp flags usage more apparent
From: syzbot ci <syzbot+cicff749feae9a145a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bpf@vger.kernel.org, hch@infradead.org, 
	hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	urezki@gmail.com, vishal.moola@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] make vmalloc gfp flags usage more apparent
https://lore.kernel.org/all/20251112185834.32487-1-vishal.moola@gmail.com
* [PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
* [PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
* [PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
* [PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()

and found the following issue:
WARNING: kmalloc bug in bpf_prog_alloc_no_stats

Full report is available here:
https://ci.syzbot.org/series/46d6cb1a-188d-4ff5-8fab-9c58465d74d3

***

WARNING: kmalloc bug in bpf_prog_alloc_no_stats

tree:      linux-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
base:      b179ce312bafcb8c68dc718e015aee79b7939ff0
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/3449e2a5-35e0-4eac-86c6-97ca0ec741d7/config

------------[ cut here ]------------
Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
WARNING: mm/vmalloc.c:3938 at vmalloc_fix_flags+0x9c/0xe0, CPU#1: syz-executor/6079
Modules linked in:
CPU: 1 UID: 0 PID: 6079 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:vmalloc_fix_flags+0x9c/0xe0
Code: 81 e6 1f 52 ee ff 89 74 24 30 81 e3 e0 ad 11 00 89 5c 24 20 90 48 c7 c7 40 c3 76 8b 4c 89 fa 89 d9 4d 89 f0 e8 a5 a1 6c ff 90 <0f> 0b 90 90 8b 44 24 20 48 c7 04 24 0e 36 e0 45 4b c7 04 2c 00 00
RSP: 0018:ffffc90005557b00 EFLAGS: 00010246
RAX: a6bff5ae8e950700 RBX: 0000000000000dc0 RCX: ffff888173b29d40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc90005557b98 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba6ec R12: 1ffff92000aaaf60
R13: dffffc0000000000 R14: ffffc90005557b20 R15: ffffc90005557b30
FS:  000055557c070500(0000) GS:ffff8882a9ec0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86f6df0000 CR3: 0000000113d64000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __vmalloc_noprof+0xf2/0x120
 bpf_prog_alloc_no_stats+0x4a/0x4d0
 bpf_prog_alloc+0x3c/0x1a0
 bpf_prog_create_from_user+0xa7/0x440
 do_seccomp+0x7b1/0xd90
 __se_sys_prctl+0xc3c/0x1830
 do_syscall_64+0xfa/0xfa0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbe2f90b0d
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007ffed4000b80 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 00007fcbe302cf80 RCX: 00007fcbe2f90b0d
RDX: 00007ffed4000be0 RSI: 0000000000000002 RDI: 0000000000000016
RBP: 00007ffed4000bf0 R08: 0000000000000006 R09: 0000000000000071
R10: 0000000000000071 R11: 0000000000000246 R12: 000000000000006d
R13: 00007ffed4001018 R14: 00007ffed4001298 R15: 0000000000000000
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

