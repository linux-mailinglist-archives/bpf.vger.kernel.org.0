Return-Path: <bpf+bounces-8894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5792C78C1A5
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133EF281016
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2114F87;
	Tue, 29 Aug 2023 09:39:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF014F82
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 09:39:55 +0000 (UTC)
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3DB113
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 02:39:54 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1c08a6763b3so52022925ad.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 02:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301994; x=1693906794;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnAtP1aZZWHUth6zJwSWbwkUuNeahcFCzK9nRGeZZTo=;
        b=QjkXxHPRwvob/qbDBXK9SMivJ2bn8Qt5W52ohRY017wKof6pUfL4b9rSCXBYvpeAB4
         1W1AIGL8H1JQAN39GBmoighnbBdNSM2uRtCICOCUmJNZFKFjQjFYNYxC5ow3D5KqQbbU
         oUSDoeCyaNww7Xu2Pt1gyxmWlVOwQgD74ynw1sMHhZd+d3cKg1BA7fuRQJKRm4DOg2Q0
         b04D0JjpFlbFs+1lx3EjIjTAuHEoXDATNwcDvWXhhEf4cGzyUB7XvgKqOa3GXdgffcGp
         eQWicYBgyg7RqmEmGA7RDZRNhYHMadWxW5HjATzoVkYjCUfV+hS2HhbCESoKB5mSFqPG
         ShSQ==
X-Gm-Message-State: AOJu0YypvfSVbcE5P9wABOw/FbfM7oI3FAzbH/5YCeOb9wBW0+G9ia4U
	/HFx9e6AkV/JBgb1XvQQFrE8DCDmwrKpu0UNn8QkGAdWaY+3
X-Google-Smtp-Source: AGHT+IHV/i9lnyr2VOinyBuKVM5stvWJjOLu1kw4w5lCLKNaRzlspvJOQMADtR/M/sNK6hlILay+wDZax3nQ1tNeC3PTlb22Oh7e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:234e:b0:1bb:a13a:c21e with SMTP id
 c14-20020a170903234e00b001bba13ac21emr9497452plh.10.1693301993926; Tue, 29
 Aug 2023 02:39:53 -0700 (PDT)
Date: Tue, 29 Aug 2023 02:39:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d87a7f06040c970c@google.com>
Subject: [syzbot] [bpf?] KCSAN: data-race in bpf_percpu_array_update /
 bpf_percpu_array_update (2)
From: syzbot <syzbot+97522333291430dd277f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136f39dfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dea9c2ce3f646a25
dashboard link: https://syzkaller.appspot.com/bug?extid=97522333291430dd277f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9923a023ab11/disk-727dbda1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/650dbc695d77/vmlinux-727dbda1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/361da71276bf/bzImage-727dbda1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update

write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
 bpf_long_memcpy include/linux/bpf.h:428 [inline]
 bpf_obj_memcpy include/linux/bpf.h:441 [inline]
 copy_map_value_long include/linux/bpf.h:464 [inline]
 bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
 bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
 generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
 bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
 __sys_bpf+0x28a/0x780
 __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
 bpf_long_memcpy include/linux/bpf.h:428 [inline]
 bpf_obj_memcpy include/linux/bpf.h:441 [inline]
 copy_map_value_long include/linux/bpf.h:464 [inline]
 bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
 bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
 generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
 bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
 __sys_bpf+0x28a/0x780
 __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
 __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000000000 -> 0xfffffff000002788

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 8268 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

