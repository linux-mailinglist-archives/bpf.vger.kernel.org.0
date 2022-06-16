Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B254E2AE
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377406AbiFPN5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiFPN5k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 09:57:40 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A610AE
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 06:57:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id l130-20020a6b3e88000000b00669dcc36db3so908181ioa.22
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 06:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TyPOt0yJwwiVzwhZL6932xCsniSIc1nJmBUoZIQlk3U=;
        b=Ryf42UDEqzaXKZiaAlR/Oe763TY2DtDHhx8AWA8oyriP2E2Jm9CDR5IPyM5M6srxi3
         vjWlXWOCBm3o0HYHV3/qdz5Iz2VazuFBVrnkVWrr8+L1fRspm2QlR91UvpFU7dcJNGam
         kQnXntTUiP3BG2CsoJ+p9iDONvHR5ZRtArkXK3pm/+FoSRAhpVBJ0IWwOL3+q+o0jg0v
         quJD6QEQg82667+pkH2YYlYLlwai9v8Hvw77ai+H2bX0R/nxvvz4k7sefURXgG+AL7mj
         mIQVRrBt0zNVvW/3lTYmfdD2Zp62ptswKpXdRpyY4AH8u9MGM5rJD7mkImRImGX6j6Uw
         F8xw==
X-Gm-Message-State: AJIora9s48EXYZ1gQAfbhN0XgHhnqM9rFdTonXWky57hFrp3MW8Fd4DW
        hdBaukpuk3v71oKSjH7mwy5BunFOuQIkyx+IhzdWfNOv2sI+
X-Google-Smtp-Source: AGRyM1sg3smBqvQULwfGQDJAxwblcUgJun7P/SxhjIWWg9NygJSkcHJwZbL2XOyt74isJ16ZElXQBUhJuDJVwnXuu5tXrRAmLPm7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:2d3:de67:9f96 with SMTP id
 i14-20020a056e0212ce00b002d3de679f96mr3018159ilm.261.1655387852665; Thu, 16
 Jun 2022 06:57:32 -0700 (PDT)
Date:   Thu, 16 Jun 2022 06:57:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec7b7d05e1910402@google.com>
Subject: [syzbot] memory leak in __register_sysctl_table
From:   syzbot <syzbot+9f160a43b2cf201cbe65@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        keescook@chromium.org, kpsingh@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com, yzaikin@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7a68065eb9cd Merge tag 'gpio-fixes-for-v5.19-rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1432d953f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8e07e4ed17ee546
dashboard link: https://syzkaller.appspot.com/bug?extid=9f160a43b2cf201cbe65
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1297ba43f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14bf34a7f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f160a43b2cf201cbe65@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881016dfa00 (size 256):
  comm "syz-executor201", pid 3662, jiffies 4294969093 (age 12.970s)
  hex dump (first 32 bytes):
    00 90 da 0d 81 88 ff ff 00 00 00 00 01 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816fe96b>] kmalloc include/linux/slab.h:605 [inline]
    [<ffffffff816fe96b>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816fe96b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
    [<ffffffff82219a5a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
    [<ffffffff822196d2>] create_ipc_ns ipc/namespace.c:63 [inline]
    [<ffffffff822196d2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
    [<ffffffff8127de6c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
    [<ffffffff8127e88b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
    [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
    [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
    [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
    [<ffffffff845abc55>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845abc55>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

BUG: memory leak
unreferenced object 0xffff88810edf7b00 (size 256):
  comm "syz-executor201", pid 3662, jiffies 4294969093 (age 12.970s)
  hex dump (first 32 bytes):
    78 7b df 0e 81 88 ff ff 00 00 00 00 01 00 00 00  x{..............
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816fee99>] kmalloc include/linux/slab.h:605 [inline]
    [<ffffffff816fee99>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816fee99>] new_dir fs/proc/proc_sysctl.c:978 [inline]
    [<ffffffff816fee99>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
    [<ffffffff816fee99>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
    [<ffffffff82219a5a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
    [<ffffffff822196d2>] create_ipc_ns ipc/namespace.c:63 [inline]
    [<ffffffff822196d2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
    [<ffffffff8127de6c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
    [<ffffffff8127e88b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
    [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
    [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
    [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
    [<ffffffff845abc55>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845abc55>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

BUG: memory leak
unreferenced object 0xffff888101926f00 (size 256):
  comm "syz-executor201", pid 3662, jiffies 4294969093 (age 12.970s)
  hex dump (first 32 bytes):
    78 6f 92 01 81 88 ff ff 00 00 00 00 01 00 00 00  xo..............
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816fee99>] kmalloc include/linux/slab.h:605 [inline]
    [<ffffffff816fee99>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816fee99>] new_dir fs/proc/proc_sysctl.c:978 [inline]
    [<ffffffff816fee99>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
    [<ffffffff816fee99>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
    [<ffffffff82219a5a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
    [<ffffffff822196d2>] create_ipc_ns ipc/namespace.c:63 [inline]
    [<ffffffff822196d2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
    [<ffffffff8127de6c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
    [<ffffffff8127e88b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
    [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
    [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
    [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
    [<ffffffff845abc55>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845abc55>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
