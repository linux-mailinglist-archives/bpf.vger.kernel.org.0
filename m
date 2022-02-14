Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552F44B5A2C
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiBNSrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 13:47:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiBNSrB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 13:47:01 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93B670F40
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 10:46:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a3-20020a92d103000000b002bdfc5108dfso11877780ilb.9
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 10:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qMoLJBAbF6b15k+JxV0FF5gwlXjQrey2dRuI3+dpzKE=;
        b=b55OEnoOPJ3AakdZqG5WI3gpILIHhHlif6npdaea+Nv31yICokp/UP4wZ+qO0/IDfa
         UYVoMSPwpUTuwHDWIZfG9aNBP8Qcf+GEftwC6KWSf2KgJJq4XHmlRp5jSJWhtlDazkx7
         NZ2kTF9Vrf4NgEgaE2xmMSo+3NnB/aeqUc2UsGLqU3rQ3RyIL0rxEsu6N+BFbjX753ea
         HO6Kz6rE33ZYys/OEoep9FzGv7xtllPW7VaPMW7MH8PDPGeCLKcAhkRaXzjRgMgy8mv4
         I/XuqlABuDFWXyRpHAMwgSJzYs1Q0jK/x4JxZB6I72da5sw/kKvdvc60rUidpzt4QxA+
         uTgw==
X-Gm-Message-State: AOAM530uxlxr5iKA3PRF4fD/+/izdcqjUHuv9X8m4tfnKmhYlfLX+Ruq
        h5d+hCcV0cPLm7rDMmd77NSQgOs1HEtuwZkYqf4oMM/NisST
X-Google-Smtp-Source: ABdhPJwr8DWPrO5HIF0EfWDSQp/4Hswh9YS6I9drsyxbeZ4K29bwe92mTlOZljIfSHNojoENzUFgRY+/bLTcDqG9Ym4p46X8WNmx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1586:: with SMTP id m6mr120117ilu.233.1644864319237;
 Mon, 14 Feb 2022 10:45:19 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:45:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073b3e805d7fed17e@google.com>
Subject: [syzbot] KASAN: vmalloc-out-of-bounds Read in bpf_jit_free
From:   syzbot <syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
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

HEAD commit:    e5313968c41b Merge branch 'Split bpf_sk_lookup remote_port..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10baced8700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c40b67275bfe2a58
dashboard link: https://syzkaller.appspot.com/bug?extid=2f649ec6d2eea1495a8f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f649ec6d2eea1495a8f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in bpf_jit_binary_pack_free kernel/bpf/core.c:1120 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bpf_jit_free+0x2b5/0x2e0 kernel/bpf/core.c:1151
Read of size 4 at addr ffffffffa0001a80 by task kworker/0:18/13642

CPU: 0 PID: 13642 Comm: kworker/0:18 Not tainted 5.16.0-syzkaller-11655-ge5313968c41b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x336 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 bpf_jit_binary_pack_free kernel/bpf/core.c:1120 [inline]
 bpf_jit_free+0x2b5/0x2e0 kernel/bpf/core.c:1151
 bpf_prog_free_deferred+0x5c1/0x790 kernel/bpf/core.c:2524
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


Memory state around the buggy address:
 ffffffffa0001980: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffffffa0001a00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffffffa0001a80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffffffa0001b00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffffffa0001b80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
