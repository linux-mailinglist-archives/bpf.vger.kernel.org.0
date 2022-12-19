Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E963650831
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 08:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiLSHuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 02:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiLSHuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 02:50:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A00AE41;
        Sun, 18 Dec 2022 23:50:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id js9so8237697pjb.2;
        Sun, 18 Dec 2022 23:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mt1vg5pdrs14PfvXGYOnr9zM4H3I7al2uApPMpQNZJg=;
        b=XRRkncXJ+AbudTaYJpPObE7f4yMt8TH2Syh2Km3/ZBEjDvAtwptbqr63+dAYkwYQOY
         v92HeRrxrqRwLh2fn410ZWTiZ9yt5mKMDutApepgQFGP75Q0mGtY1oRhF23w55GoWS7I
         DfzQVcUAdxGW4e4KUvPe00SeDL3orQuMp2hUZRjyEQpyeKbZ5nuA8GNKl42lvF+Viyk9
         aPq3hsOQ1twNJpgEdQK5pPW1mxWbeUqUFb21k6DflzFHX8ZXNWscd0fsKV3mUI6lX0On
         x7tJAU9LHLp9HP8xtDSUfH5oiJ0Gz/0u+XCAFMqWjhEpGdQ/iGo4j9TbciMNbPsT6G1J
         DsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mt1vg5pdrs14PfvXGYOnr9zM4H3I7al2uApPMpQNZJg=;
        b=WIdYxSRPcX/PYCRWJ563r9e2N7XYi+87KYTMTApyuqNYhBpKgT9rhunumhDxCl+Wua
         Bg7BVS56npC1bEhNEqgvX4PeF9Eiikj3myfN5F5H7NIr+fytZuSDAnNhwOzt/1h1cbdr
         pO/zuIM68u0nLywQadIIzPPsZxhAw2N2jFf85Qv43bTppP2nAmj5pqPiEApO5Qweq/ah
         420LUUn9d21wRjg0usoqhJSlhuSNU99ailTyePXxUUtCSs/qvuomivG1bicv9lc2WjV+
         yvqaP8IEQjRCXdWReuUn+Za/kA37PJNNCWZQNbDr9dICxbtjDqGs04Yyzs/5Gf+JFE3J
         /R9Q==
X-Gm-Message-State: ANoB5pmNQL8kAV+qz0fwKvUdrnnDPtk0LFo2WDtC1fDvvDJpo/YSZUYj
        MKhuJXLV4os5Y0EsjI/GtRnHPx9tqLseMc/XcECI01O5xg==
X-Google-Smtp-Source: AA0mqf59d1ZanEvjs9CtTlpUm8+CazBoZlLdMslwdXsAcUDnDjp6/MtwtAsDuocV+jv+jD+jxFQbJIT94wpAKCSi5bg=
X-Received: by 2002:a17:902:bb10:b0:189:6292:827e with SMTP id
 im16-20020a170902bb1000b001896292827emr68357621plb.97.1671436221461; Sun, 18
 Dec 2022 23:50:21 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 19 Dec 2022 15:50:10 +0800
Message-ID: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
Subject: WARNING in __mark_chain_precision
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

The following backtracking bug can be triggered on the latest bpf-next and
Linux 6.1 with the C prog provided. I don't have enough knowledge about
this part in the verifier, don't know how to fix this.

This can be reproduced on:

HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to locate libelf
git tree: bpf-next
console log: https://pastebin.com/raw/45hZ7iqm
kernel config: https://pastebin.com/raw/0pu1CHRm
C reproducer: https://pastebin.com/raw/tqsiezvT

func#0 @0
0: R1=ctx(off=0,imm=0) R10=fp0
0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
2: (18) r6 = 0xffff888027358000       ;
R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
4: (18) r7 = 0xffff88802735a000       ; R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
6: (18) r8 = 0xffff88802735e000       ; R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
10: (36) if w9 >= 0xffffffe3 goto pc+1
last_idx 10 first_idx 0
regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
11: R9_w=156779191205888
11: (85) call #0
12: (cc) w2 s>>= w7
last_idx 12 first_idx 12
parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0)
R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0)
R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0) R9_w=156779191205888 R10=fp0
last_idx 11 first_idx 0
regs=4 stack=0 before 11: (85) call #0
BUG regs 4
processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1
peak_states 1 mark_read 1

------------[ cut here ]------------
verifier backtracking bug
WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756 backtrack_insn
kernel/bpf/verifier.c:2756 [inline]
WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756
__mark_chain_precision+0x1baf/0x1d70 kernel/bpf/verifier.c:3065
Modules linked in:
CPU: 6 PID: 8646 Comm: a.out Not tainted 6.1.0-09634-g0e43662e61f2 #146
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
1.16.1-1-1 04/01/2014
RIP: 0010:backtrack_insn kernel/bpf/verifier.c:2756 [inline]
RIP: 0010:__mark_chain_precision+0x1baf/0x1d70 kernel/bpf/verifier.c:3065
Code: 0d 31 ff 89 de e8 91 ec ed ff 84 db 0f 85 ef fe ff ff e8 b4 f0
ed ff 48 c7 c7 e0 8f 53 8a c6 05 28 71 ab 0d 01 e8 83 b3 1e 08 <0f> 0b
e9 50 f8 ff ff 48 8b 74 24 38 48 c7 c7 80 d0 63 8d e8 49 46
RSP: 0018:ffffc9001463f1a0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888020470000 RSI: ffffffff816662c0 RDI: fffff520028c7e26
RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000020
R13: dffffc0000000000 R14: 000000000000000b R15: ffff88802be74000
FS: 00007fd3daeb8440(0000) GS:ffff888063980000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000240 CR3: 0000000017394000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
<TASK>
mark_chain_precision kernel/bpf/verifier.c:3165 [inline]
adjust_reg_min_max_vals+0x981/0x58d0 kernel/bpf/verifier.c:10715
check_alu_op+0x380/0x1820 kernel/bpf/verifier.c:10928
do_check kernel/bpf/verifier.c:13821 [inline]
do_check_common+0x1c3b/0xe520 kernel/bpf/verifier.c:16289
do_check_main kernel/bpf/verifier.c:16352 [inline]
bpf_check+0x83b4/0xb310 kernel/bpf/verifier.c:16936
bpf_prog_load+0xf7a/0x21a0 kernel/bpf/syscall.c:2619
__sys_bpf+0xf03/0x5840 kernel/bpf/syscall.c:4979
__do_sys_bpf kernel/bpf/syscall.c:5083 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5081 [inline]
__x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5081
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd3da8e4469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff090c1a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd3da8e4469
RDX: 0000000000000080 RSI: 0000000020000840 RDI: 0000000000000005
RBP: 00007fff090c2a90 R08: 00007fd3da92e160 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000561aefc006c0
R13: 00007fff090c2b70 R14: 0000000000000000 R15: 0000000000000000
</TASK>
