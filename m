Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0094CCD72
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 07:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbiCDGBP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 01:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiCDGBM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 01:01:12 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49617EDBA
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 22:00:22 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id r191-20020a6b8fc8000000b0063de0033ee7so4903470iod.3
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 22:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TFMJ4ukGQs86fCBCLXSygly6TsLRzd9XxdIZL+vlrCk=;
        b=aQ8T0JdnktQWGTGsrN6aV+c7zNemaAxjg43mifAnh85F2jBUZ3CoLZJTMgx18sKM6r
         tP1D8VEfNFguaE2L24yEazIBmnaHib3yiysDs4THanqyIiv2xDuC9CsrWgDeoA24hweL
         Wp+ve/i2MTspqRh7AcEjjnuOZaJ1SZepqAluBJd/3rUH4k1dsp4SxtFy0RqDzazeJmzJ
         cmrShWI8ejKbh+G/pur38VxsS7G8fut8eSEUq35bgSxymyBA3U9PeVIcooKjCddPqbvv
         7IgtYXt3lpL/yrxHGCN73vXcHA+ninohnVQDmqOLK45ADnAMJj9RnTUl4N1z/9i4cbnq
         DMFg==
X-Gm-Message-State: AOAM532BwG6Y8VOF5R4W5BNBOZWlebN02ZRW6WShJzUF5sxrL/zAjhTW
        g+x+djetvdrK3i3Vv6RURWG+oFaMN7Kg/vIDX3cf1TM9jZhH
X-Google-Smtp-Source: ABdhPJwvs1Gwblkb+0NmkA7Nm/FwFs9iyFV004XGZhv8GUUS9AEhXvdAnPYOPs2Ja36Z4dKoofYFWXQr6oO4lsZVAhDSm2GVn8tr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1024:b0:314:9d7e:47f6 with SMTP id
 n4-20020a056638102400b003149d7e47f6mr32954073jan.8.1646373621601; Thu, 03 Mar
 2022 22:00:21 -0800 (PST)
Date:   Thu, 03 Mar 2022 22:00:21 -0800
In-Reply-To: <0000000000002da23a05d9299019@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2192405d95e3a37@google.com>
Subject: Re: [syzbot] WARNING in submit_bio_noacct
From:   syzbot <syzbot+7fdd158f9797accbebfc@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, axboe@kernel.dk,
        bpf@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    91265a6da44d Add linux-next specific files for 20220303
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c23e1a700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
dashboard link: https://syzkaller.appspot.com/bug?extid=7fdd158f9797accbebfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7f36e700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbfb9700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fdd158f9797accbebfc@syzkaller.appspotmail.com

------------[ cut here ]------------
Trying to write to read-only block-device sda1 (partno 1)
WARNING: CPU: 1 PID: 2927 at block/blk-core.c:581 bio_check_ro block/blk-core.c:581 [inline]
WARNING: CPU: 1 PID: 2927 at block/blk-core.c:581 submit_bio_noacct+0x16f3/0x1be0 block/blk-core.c:810
Modules linked in:
CPU: 1 PID: 2927 Comm: jbd2/sda1-8 Not tainted 5.17.0-rc6-next-20220303-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:bio_check_ro block/blk-core.c:581 [inline]
RIP: 0010:submit_bio_noacct+0x16f3/0x1be0 block/blk-core.c:810
Code: 00 00 45 0f b6 a4 24 50 05 00 00 48 8d 74 24 60 48 89 ef e8 cf 1f fe ff 48 c7 c7 e0 93 24 8a 48 89 c6 44 89 e2 e8 c9 6e 41 05 <0f> 0b e9 91 f3 ff ff e8 41 96 a1 fd e8 6c bf 85 05 31 ff 89 c3 89
RSP: 0018:ffffc9000c25f900 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88801bdaa250 RCX: 0000000000000000
RDX: ffff88807f5a9d40 RSI: ffffffff81602878 RDI: fffff5200184bf12
RBP: ffff88801f184000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815fd23e R11: 0000000000000000 R12: 0000000000000001
R13: ffff88801f184010 R14: ffff888018355080 R15: 1ffff9200184bf28
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200066d0 CR3: 000000002432e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 submit_bio block/blk-core.c:941 [inline]
 submit_bio+0x1a0/0x350 block/blk-core.c:905
 submit_bh_wbc+0x4e9/0x6b0 fs/buffer.c:3090
 jbd2_journal_commit_transaction+0x1fd9/0x6d80 fs/jbd2/commit.c:762
 kjournald2+0x1d0/0x930 fs/jbd2/journal.c:213
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

