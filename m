Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240C061296E
	for <lists+bpf@lfdr.de>; Sun, 30 Oct 2022 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ3J3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Oct 2022 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJ3J25 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Oct 2022 05:28:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0472C06;
        Sun, 30 Oct 2022 02:28:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id 13so22761064ejn.3;
        Sun, 30 Oct 2022 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hDKGMCpj76LglQyCjAd4gwCw0ksLmiMkut2VbUcz/SY=;
        b=o7mfKfrPxwVahtVT9rvYK46TIQu4TAFiTdOv7Z9Ainvp2RaJH/oYOtW0YU/9pbRmOd
         nATPAoPQTzFkRzb/1jLje1nUhMwZODX9GZ7ZIqCynUtaqfwtdRjU7vUQrRu/iKKwVUrR
         4DV2ToGCakaGDvsX4Chz9cD5eLWhUnsP5/i3P0xWV2V4BABrNW+PnwKXNvaNRrkXysYi
         LK0kSOcMgRfiYHICJNXrF+X/o8jw4Dfg6IzHcu63JSnNhgKf37MeLhR43L8OsWGlqJpg
         jDCmhdmROseeCsK/gA1TkCxyge2yo9DdN5zNxplmLcSS9a+mm+8xo+F/uB5zi+wJ0MKh
         sBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDKGMCpj76LglQyCjAd4gwCw0ksLmiMkut2VbUcz/SY=;
        b=rmYXhI4YfTyY7VShY2HdvFK//K2FUQDimJQl8WF+tk0JydlVOtpMVfyqeiuHuawD/O
         2LupmDh6ZHRpqrtgglDwznHJPkFK6H7OhiPqtQbebuqsestr8XDhV/QKSPzx2ZB6SwZ4
         NeMKFA4t09jHPQ5BbJ8JKCEg9FqcslL2FVW7CBN41Wtc4xfDN9mdxbrlXBOX4OjLVqmy
         Y76F5Nm2TSFVvK78oMzhjhRqci3e0lgzMm0yK2bMoljBzJNkhnFMDXxiuImiZv3FsbQH
         SWvuvcuQztym07BPWNKOdHY1ZnOgtKHp53tnUc1n4dPoxAlelJyBdMhrboNqasD8HJLJ
         J4Qw==
X-Gm-Message-State: ACrzQf2IsQUsBBIfSX/qjoILkqoSR6D0SmUAtm9MfoZ2DM5oi5vWGiiM
        3mSgy9O5dmAyMUUiQ19tLQq8XHz7DmAF6nfGaPhykPJSurxwZg==
X-Google-Smtp-Source: AMsMyM6ju7m2x+MPHl6QDls0jqNOzAEPHFBvoOaZwEyOcBz7f6HDN+HZRE0549bK5t7dq5OiJjUC1NuvTjzRCJ1RexQ=
X-Received: by 2002:a17:907:2c75:b0:78d:c201:e9aa with SMTP id
 ib21-20020a1709072c7500b0078dc201e9aamr7470691ejc.235.1667122134192; Sun, 30
 Oct 2022 02:28:54 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:28:18 +0800
Message-ID: <CAO4mrfdifWvUdi7s30yHsbZkavjLuKF_=snSXUo_DtPX9ONjKQ@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in tcp_retransmit_timer
To:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1wVTAdDoOo8KqTaGm1v8SaKuv1V8Pt9qs/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: unable to handle page fault for address: ffffe8ff3fa5f268
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 983f067 P4D 983f067 PUD afce067 PMD 4e244067 PTE 0
Oops: 0002 [#1] PREEMPT SMP
CPU: 0 PID: 6544 Comm: syz-fuzzer Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:tcp_retransmit_timer+0x4c5/0x1540
Code: 31 e7 ff ff e9 65 fd ff ff e8 b7 75 3c fd 48 c7 c7 26 1c ee 85
e8 8b fa bc 00 48 8b 43 30 bf 1f 00 00 00 48 8b 80 58 02 00 00 <65> 48
ff 80 40 01 00 00 44 0f b6 73 12 48 8b 43 30 44 89 f6 48 89
RSP: 0000:ffffc90000807cc0 EFLAGS: 00010202
RAX: 0000607ec1e5f128 RBX: ffff8880156c0000 RCX: ffff888011480000
RDX: 0000000000000000 RSI: 0000000000000101 RDI: 000000000000001f
RBP: ffff8880156c0120 R08: ffffffff8400fda9 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000080000001 R12: 0000000080000001
R13: ffff88810cd1b280 R14: ffff888029b5f400 R15: ffff8880156c0278
FS:  000000c000030c90(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe8ff3fa5f268 CR3: 0000000015c0b000 CR4: 00000000003506f0
Call Trace:
 tcp_write_timer_handler+0x132/0x420
 tcp_write_timer+0x179/0x230
 call_timer_fn+0xe8/0x510
 run_timer_softirq+0x423/0xa40
 __do_softirq+0xe2/0x56b
 irq_exit_rcu+0xb6/0xf0
 sysvec_apic_timer_interrupt+0x52/0xc0
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0033:0x415543
Code: 48 8b 1d a0 e8 76 01 84 03 48 8b 14 d3 48 85 d2 74 1d 48 89 c3
48 c1 e8 0d 48 25 ff 1f 00 00 48 8b 8c c2 00 00 20 00 48 89 d8 <e9> 6c
fe ff ff 31 c9 e9 65 fe ff ff cc cc cc cc cc cc cc cc cc cc
RSP: 002b:000000c00003de70 EFLAGS: 00000202
RAX: 000000c004cc8600 RBX: 000000c004cc8600 RCX: 00007f27b2e23400
RDX: 00007f27b2e3b000 RSI: 0000000000000001 RDI: 00000000000dcf40
RBP: 000000c00003de98 R08: 00007f27b303afff R09: 000000c004beb6c0
R10: 000000c000021e98 R11: 0000000000000008 R12: 000000c004cc8600
R13: 000000c000001200 R14: 0000000000c4de75 R15: 0000000000000000
Modules linked in:
CR2: ffffe8ff3fa5f268
---[ end trace 8795388675688c1b ]---
RIP: 0010:tcp_retransmit_timer+0x4c5/0x1540
Code: 31 e7 ff ff e9 65 fd ff ff e8 b7 75 3c fd 48 c7 c7 26 1c ee 85
e8 8b fa bc 00 48 8b 43 30 bf 1f 00 00 00 48 8b 80 58 02 00 00 <65> 48
ff 80 40 01 00 00 44 0f b6 73 12 48 8b 43 30 44 89 f6 48 89
RSP: 0000:ffffc90000807cc0 EFLAGS: 00010202
RAX: 0000607ec1e5f128 RBX: ffff8880156c0000 RCX: ffff888011480000
RDX: 0000000000000000 RSI: 0000000000000101 RDI: 000000000000001f
RBP: ffff8880156c0120 R08: ffffffff8400fda9 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000080000001 R12: 0000000080000001
R13: ffff88810cd1b280 R14: ffff888029b5f400 R15: ffff8880156c0278
FS:  000000c000030c90(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe8ff3fa5f268 CR3: 0000000015c0b000 CR4: 00000000003506f0
----------------
Code disassembly (best guess), 4 bytes skipped:
   0: e9 65 fd ff ff        jmpq   0xfffffd6a
   5: e8 b7 75 3c fd        callq  0xfd3c75c1
   a: 48 c7 c7 26 1c ee 85 mov    $0xffffffff85ee1c26,%rdi
  11: e8 8b fa bc 00        callq  0xbcfaa1
  16: 48 8b 43 30          mov    0x30(%rbx),%rax
  1a: bf 1f 00 00 00        mov    $0x1f,%edi
  1f: 48 8b 80 58 02 00 00 mov    0x258(%rax),%rax
* 26: 65 48 ff 80 40 01 00 incq   %gs:0x140(%rax) <-- trapping instruction
  2d: 00
  2e: 44 0f b6 73 12        movzbl 0x12(%rbx),%r14d
  33: 48 8b 43 30          mov    0x30(%rbx),%rax
  37: 44 89 f6              mov    %r14d,%esi
  3a: 48                    rex.W
  3b: 89                    .byte 0x89

Best,
Wei
