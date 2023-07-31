Return-Path: <bpf+bounces-6418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08EE768F48
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960841C20B50
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D198485;
	Mon, 31 Jul 2023 07:58:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAFA79C5
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:58:00 +0000 (UTC)
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1842F130
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 00:57:59 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6bc9bb5019dso2565660a34.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 00:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790278; x=1691395078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9+VUaldm7srtJcVZXUNQKNnqsDQpFaLcwIyNuXU2UM=;
        b=SI5jstFN6uKKO3P4kgpUe3obgsvYJqSxsmpoJ3mHwpLA6XW7iZjz1FpQb0w5xwjsdf
         Wa0FS553BWbxacFr/Z3HM1ahkwsn3jWmMDpaclJlEkae7QYlxs5C3Dyvg7AgfTaFYaq6
         Af2I/nfPO+rl9ra4OrfCjyOP+Bjje16cTGBKth5FNDvB41SWg/uVdX9eVrXb80jRiiue
         bZyKtBHByvlbZLVr0Zo3tYnWOZ1cRMnEcm2BAjFjxKeZUfj4lEmI3KW2J1rs5Rm4eckt
         Vd6TfltaZ+OZxzNzqB1eE0I93twDKobcAJUb0B864EgIqC7T6g6H0gkOd8g6lUdUvk6f
         BMkg==
X-Gm-Message-State: ABy/qLa3qNf3S6vw4Jhv1KGmxxHR87BVj+hom6PVoCjgWMuqiTdgr07h
	Grw5SLBxPMIH2lkN42s3GoryYg6CUaDJhH/hCrluxLXqEl4V
X-Google-Smtp-Source: APBJJlEXPTW9MRKR++b3IEXkEBCHplyOqX6lMoctQvTSmNkA3dPw4D7fay9DmH0X8f7omvBsXfLqmwAh4TEiwD78T2Ny7st0ne0z
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:772c:b0:1bb:55f5:bca5 with SMTP id
 dw44-20020a056870772c00b001bb55f5bca5mr11998303oab.8.1690790278491; Mon, 31
 Jul 2023 00:57:58 -0700 (PDT)
Date: Mon, 31 Jul 2023 00:57:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f077910601c3c95e@google.com>
Subject: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in print_bpf_insn
From: syzbot <syzbot+3758842a6c01012aa73b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	quentin@isovalent.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    f7e6bd33d1d4 Merge branch 'bpf-support-new-insns-from-cpu-..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=114d3019a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8acaeb93ad7c6aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=3758842a6c01012aa73b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15165dbea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12259911a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f17904bb7ff9/disk-f7e6bd33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d3ac62bba3c/vmlinux-f7e6bd33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62e7226b925f/bzImage-f7e6bd33.xz

The issue was bisected to:

commit f835bb6222998c8655bc4e85287d42b57c17b208
Author: Yonghong Song <yonghong.song@linux.dev>
Date:   Wed Jun 28 22:29:51 2023 +0000

    bpf: Add kernel/bpftool asm support for new instructions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fe5779a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fe5779a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe5779a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3758842a6c01012aa73b@syzkaller.appspotmail.com
Fixes: f835bb622299 ("bpf: Add kernel/bpftool asm support for new instructions")

================================================================================
UBSAN: array-index-out-of-bounds in kernel/bpf/disasm.c:192:38
index -1 is out of range for type 'char *[4]'
CPU: 1 PID: 5026 Comm: syz-executor300 Not tainted 6.5.0-rc2-syzkaller-00599-gf7e6bd33d1d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 print_bpf_insn+0x22d9/0x23c0 kernel/bpf/disasm.c:192
 do_check kernel/bpf/verifier.c:16505 [inline]
 do_check_common+0x1402/0xd370 kernel/bpf/verifier.c:19061
 do_check_main kernel/bpf/verifier.c:19124 [inline]
 bpf_check+0x8436/0xac50 kernel/bpf/verifier.c:19748
 bpf_prog_load+0x153a/0x2270 kernel/bpf/syscall.c:2709
 __sys_bpf+0xeed/0x4ec0 kernel/bpf/syscall.c:5345
 __do_sys_bpf kernel/bpf/syscall.c:5449 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5447 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5447
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6f30a1b3a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee3c35308 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffee3c354e8 RCX: 00007f6f30a1b3a9
RDX: 0000000000000048 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 00007f6f30a8e610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffee3c354d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

