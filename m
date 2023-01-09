Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02C661F67
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 08:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjAIHom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 02:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjAIHok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 02:44:40 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE265DE;
        Sun,  8 Jan 2023 23:44:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso11895622pjp.4;
        Sun, 08 Jan 2023 23:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mogBtQpq3BSgZsB+0TUqrFQwLuEgAFoeQ5Lo5JhgnfA=;
        b=FOn66NlvZXQJSlGNAvprF+Q2wbIqI/1OShWs3bMDR+CC6U9QEbr0ZHcRalM+hBMJsZ
         po1ADdGHkHMJ+3d41ky/KmgxbXMvc3YoCBi7rBGVTHRQPeZb5EdQxRRj8Wm/OxYCdicP
         Y2DcdzCkotVyx6yKuBV4POZIlQxADH2alR5pQ6YLs6WnEa9tZE8MjoaFUvxCfdt0s/gS
         AJ+l2+r+i6ztwdkzbstHERABRkDtF4agXzJIL1ZqmY7NnzeJHwcxBmaRMa+acnde00ZF
         Su7DBTUVDJp5Wy38XjnxIagsB502WVEhTRPWyYKesqSDrM9wx3Wy6xe+Q5QkgrUYWtpY
         /FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mogBtQpq3BSgZsB+0TUqrFQwLuEgAFoeQ5Lo5JhgnfA=;
        b=lsrnJAMJuveayltHjtZhcrdLsbli6G4N79qjnzFKn/ocLZpLadUm4A4d4mug0K0mdC
         mAPDc49G8UiagQhZcA9X6BOMV4paO95NipYiLE9MCP8u00zKIQ4neT/mRc7vv3eYQziJ
         J+PypSjC1m8f0iNCnGDVvV6HB+VHPJa/x1KBvmSFmEC30PkjU1jy30fX+3VkRT1fVzqr
         zVJ2muQK1g7AjIE/O5rHVYYaiysvWFIt2FlA1fAuseDxw7ikYVA4ocPKi8Ol45Pj59we
         UF8sQd9zal2XmysMAjn9Y8jRzHg4QcVWX4PbGvkaHeAnh0qUBmtHNGG219KPEUYOkqMN
         Romw==
X-Gm-Message-State: AFqh2kpl1hcQqckT5uu8gN/11GSFPBjtWRQo0VaNcV1FZhxNUWTT6qfd
        9rkYZ8X2AmSXua6IXFb+f91H2lO8ynC1
X-Google-Smtp-Source: AMrXdXsm3iLHOe/svbZ3KKMgd8UmcR7UNYYBas9TYD1WzYZdweqytRGb4wPVZKzqnek82LFYiUwmBg==
X-Received: by 2002:a17:902:b782:b0:193:3540:fce5 with SMTP id e2-20020a170902b78200b001933540fce5mr2270505pls.63.1673250278384;
        Sun, 08 Jan 2023 23:44:38 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.13])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902bd9200b00186b7443082sm5370180pls.195.2023.01.08.23.44.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Jan 2023 23:44:38 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: WARNING in debug_mutex_unlock
Date:   Mon,  9 Jan 2023 15:44:25 +0800
Message-Id: <20230109074425.12556-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The following warning can be triggered with the C reproducer in
the link. The repro starts 32 threads, each attaches a tracepoint
into `ext4_mark_inode_dirty`. The prog loads the following insns
that simply sends signal to current proc, and then wait.

Seems issues in queued irq_work with `do_bpf_send_signal`, also
I'm wondering what if the task in `send_signal_irq_work` exited,
at the time the callback invoked.

This can be reproduced on:

HEAD commit:    6d0c4b11e743 ("libbpf: Poison strlcpy()")
git tree:       bpf-next
console output: https://pastebin.com/raw/ZtVM15Jx
kernel config : https://pastebin.com/raw/nt6XW0Sz
C reproducer  : https://pastebin.com/raw/NHqy5tR6

func#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (18) r0 = 0x0                      ; R0_w=0
2: (18) r6 = 0x0                      ; R6_w=0
4: (18) r7 = 0x0                      ; R7_w=0
6: (18) r8 = 0x0                      ; R8_w=0
8: (18) r9 = 0x0                      ; R9_w=0
10: (18) r1 = 0x700000007             ; R1_w=30064771079
12: (85) call bpf_send_signal#109     ; R0_w=scalar()
13: (95) exit
processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 41309 at kernel/locking/mutex-debug.c:74 debug_mutex_unlock+0x1fc/0x250 kernel/locking/mutex-debug.c:74
Modules linked in:
CPU: 3 PID: 41309 Comm: systemd-udevd Not tainted 6.2.0-rc2-00302-g6d0c4b11e743 #153
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:debug_mutex_unlock+0x1fc/0x250 kernel/locking/mutex-debug.c:74
Code: 84 c0 75 59 8b 15 34 92 3a 11 85 d2 0f 84 c5 fe ff ff e9 e6 fe ff ff 48 c7 c6 a0 50 4c 8a 48 c7 c7 a0 4e 4c 8a e8 9e bb 5f 08 <0f> 0b eb b2 e8 bb 9d 6e 00 e9 be fe ff ff e8 b1 9d 6e 00 e9 8b fe
RSP: 0018:ffffc90012b7f6f8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88804145a2d0 RCX: 0000000000000000
RDX: ffff88803f468000 RSI: ffffffff81671400 RDI: fffff5200256fed1
RBP: ffffffff929e2a00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: ffffffff90d3f0c3 R12: ffff88804145a2d8
R13: fffffbfff253c540 R14: ffffffff929e2a00 R15: ffffc90012b7f798
FS:  00007f36a937e8c0(0000) GS:ffff888135c80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056181882c020 CR3: 000000002a9a2000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 __mutex_unlock_slowpath+0x197/0x630 kernel/locking/mutex.c:933
 devlink_compat_running_version+0x128/0x6c0 net/devlink/leftover.c:12237
 dev_ethtool+0x55f/0x53c0 net/ethtool/ioctl.c:3091
 dev_ioctl+0x29e/0x1050 net/core/dev_ioctl.c:524
 sock_do_ioctl+0x1be/0x250 net/socket.c:1183
 sock_ioctl+0x205/0x6a0 net/socket.c:1286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x189/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f36a94a55f7
Code: 00 00 00 48 8b 05 99 c8 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 c8 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd663b3d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00005618188043f0 RCX: 00007f36a94a55f7
RDX: 00007ffd663b3e60 RSI: 0000000000008946 RDI: 0000000000000006
RBP: 00007ffd663b3e90 R08: 0000561818887fa0 R09: 0000000000000000
R10: 00007f36a937e6c0 R11: 0000000000000246 R12: 0000561818887fa0
R13: 0000561818832c70 R14: 00007ffd663b3e60 R15: 0000000000000007
 </TASK>

