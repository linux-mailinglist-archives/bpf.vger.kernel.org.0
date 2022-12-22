Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AEC653B54
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 05:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiLVEfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 23:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiLVEfm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 23:35:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8555FCE5;
        Wed, 21 Dec 2022 20:35:40 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id p4so721943pjk.2;
        Wed, 21 Dec 2022 20:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqY8aB/LUfyDhVYKT66+Nu8cgqW1FRD27QDgXDV2/og=;
        b=WX1AS4fTu8k2ucM0F8HQjqrVnqwQvjUGJs7NuYNkVUbLbYljKNtJ0E5lMn1sF2xaC9
         /aRqhwa2w0tUbdZYMzZdE8kyqqLxst5ZFykA2rZFf1OJKMHRl5nGhXv9hfG0btcFRHne
         oGnMTp5CATjQ48KtWMhJWeI9pQgD+VD/KmehHGpK1NA+AXIH3ZlCFeSIXmf0hOHoR7vI
         KMshMKyOSjEkCY4Syp9LGTr3jayEhK+vBHtlUItGHw34yvWuBxqRd8EshP0lmgDI70zE
         neWRHTd2uhuKxClhZ6oEwf3izOYdUg+8lnb6pA0trTJK48jlLAW4JmNMyOJwET8Xcycy
         NSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqY8aB/LUfyDhVYKT66+Nu8cgqW1FRD27QDgXDV2/og=;
        b=7IvrM6Q+IDcQpnGiIKkImtgIgmSc3wsO/G6KUKeE4ThXyogBzbCshXoL1wiYttA20o
         dqrfRw4q8qsT4Sn/X2Q8Enm6zH/Rryrqss0xVcVAb6GkOrEclxYY6fdege65o0FdOlRA
         r2PZPIsfgf9SCIGqbOpR+XNsiQCxKhxvwTJhWjq5gjXCqhBKsIC4wzMxbL/xFOJd8x2v
         6vnxGx344FKVsYF8Is6BLbhzQbaw4LA2khtd3xbm1yq5Ld8Ru5ZbMzEE6RdO1TBsEzi1
         YPjaslTLtrAAVYZFTG1UsGQK0fGevBCmrCIhO4r/JN/n/5vfJ4T4QrMAGb3QvVMU6Ppm
         wxGA==
X-Gm-Message-State: AFqh2kqNQhVYHnxTRa7JbK2ha3bD4DpKrTZDTjow0oFh/mhRilNvbrik
        fnRI2yK85/w0shFVK/un5w0sKG4MMg==
X-Google-Smtp-Source: AMrXdXss7M9uf5pkMQ8aqp9TDlhKYFbx3C5rG31npL32OJsKTPaR8SQRbCClaIR51760pahwS4jAJA==
X-Received: by 2002:a17:902:e903:b0:189:6191:a1b4 with SMTP id k3-20020a170902e90300b001896191a1b4mr4594681pld.55.1671683739837;
        Wed, 21 Dec 2022 20:35:39 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b0018971fba556sm12268258plh.139.2022.12.21.20.35.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Dec 2022 20:35:39 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: kernel panic: Attempted to kill init!
Date:   Thu, 22 Dec 2022 12:35:07 +0800
Message-Id: <20221222043507.33037-1-sunhao.th@gmail.com>
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

This crash can be triggered by executing the C reproducer for
multiple times, which just keep loading the following prog as
raw tracepoint into kmem_cache_free().

The prog send SIGSEGV to current via bpf_send_signal_thread(),
after load this, whoever tries to free mem would trigger this,
kernel crashed when this happens to init. 

Seems we should filter init out in bpf_send_signal_common() by
is_global_init(current), or maybe we should check this in the
verifier?

This can be reproduced on:

HEAD commit: 59fe41b5255f selftests/bpf: Add verifier test exercising jit PROBE_MEM logic
git tree: bpf-next
console output: https://pastebin.com/raw/FMgyvEnH
kernel config : https://pastebin.com/raw/XeF6jU43
C reproducer  : https://pastebin.com/raw/Tag5N893

func#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (18) r0 = 0x0                      ; R0_w=0
2: (18) r6 = 0x0                      ; R6_w=0
4: (18) r7 = 0x0                      ; R7_w=0
6: (18) r8 = 0x0                      ; R8_w=0
8: (18) r9 = 0x0                      ; R9_w=0
10: (2d) if r0 > r0 goto pc+2
last_idx 10 first_idx 0
regs=1 stack=0 before 8: (18) r9 = 0x0
regs=1 stack=0 before 6: (18) r8 = 0x0
regs=1 stack=0 before 4: (18) r7 = 0x0
regs=1 stack=0 before 2: (18) r6 = 0x0
regs=1 stack=0 before 0: (18) r0 = 0x0
last_idx 10 first_idx 0
regs=1 stack=0 before 8: (18) r9 = 0x0
regs=1 stack=0 before 6: (18) r8 = 0x0
regs=1 stack=0 before 4: (18) r7 = 0x0
regs=1 stack=0 before 2: (18) r6 = 0x0
regs=1 stack=0 before 0: (18) r0 = 0x0
11: R0_w=0
11: (b7) r1 = 11                      ; R1_w=11
12: (85) call bpf_send_signal_thread#117      ; R0=scalar()
13: (95) exit
processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 3 PID: 1 Comm: systemd Not tainted 6.1.0-09652-g59fe41b5255f #148
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
 panic+0x2c4/0x60f kernel/panic.c:275
 do_exit.cold+0x63/0xe4 kernel/exit.c:789
 do_group_exit+0xd4/0x2a0 kernel/exit.c:950
 get_signal+0x2460/0x2600 kernel/signal.c:2858
 arch_do_signal_or_restart+0x78/0x5d0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x55e738964df0
Code: 00 31 f6 89 ef 4c 8d 05 be 1b 0d 00 48 8d 15 b0 85 0c 00 31 c0 e8 f0 c3 ff ff e9 1c ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 <41> 57 41 56 41 55 41 54 41 89 fc 55 53 48 81 ec 48 01 00 00 64 48
RSP: 002b:00007ffeb8e87bb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f7
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f29dc8a6bc1
RDX: 00007ffeb8e87bc0 RSI: 00007ffeb8e87cf0 RDI: 000000000000000b
RBP: 00007ffeb90b73c0 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000004 R11: 0000000000000246 R12: 00007f29dc3f76c8
R13: 000000000000294d R14: 0000000000000000 R15: 00007ffeb9686870
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
