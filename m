Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4D647ED6
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 08:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLIH5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 02:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiLIH5I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 02:57:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBA5216C;
        Thu,  8 Dec 2022 23:57:05 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 130so3116498pfu.8;
        Thu, 08 Dec 2022 23:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cll4/Q/Z5rgIqA+AwInzEmI1wMkzOscWcMV2zekRaiU=;
        b=WmvtCHw6fDBo4bavZjlcyAHlrnpLq1Rvh30I3/To5QGQnOa8fGX4lI3KK5aH5PUl9D
         g3IgnZ6hrafbpuKyKunSPirzvcTsW9llOREBEd9NCB9CmSz+Y3UR4rE05qHZ31NTOa7f
         oTo69U9aNlA9j7kYjCVmBGSveYOtPgF+0x82swSQIGUBYtDr1Rea+xa9vgYfVFApBBg3
         4PGhdHvtd4jDp/ZGpVQfs0VQeYSkDP8cY797c+V6ttQCP4Xer3H6Z7NOZNn6wWqL9Uam
         C/iRpB7GTWwmdFHmFa9P6q+x8gcWhpoBV6xj5n9d4P1GPWlVdxjPUcQLnzhImOg6L0db
         xzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cll4/Q/Z5rgIqA+AwInzEmI1wMkzOscWcMV2zekRaiU=;
        b=EUhEGAmCu9ZJ7zgf2n9Z9mLf25rj735hc+t7UIwP2nHoB7Q+Q4cWI1a+ZFZsv2N9ZL
         2Bz5U3mGu7Y0HakkJ6iMSmi0OUwHnBKlcocISDdbMqFbzcCUum75Scd+ezEpMV8PyFyn
         eTIpKQJl+U30CNOhXmk95DEIjW9j57i9/mqBvAjT2UMTwokTT6KZsjVDxrobTIFBXDxF
         zppEq3iQiddFR0H360b2Oulqi/RLYLtFTvjuyR935K6dsPQ4WllqqKI1zvTkm5nmC3l1
         fSlIYivQ0xvsUx3EBnhfGNT/1O2/usLV1TjiTf6i+YxR0jJc7wQ1a3RhX7g3lH4yPQs7
         MMUg==
X-Gm-Message-State: ANoB5plcYYdduzMj/7vrvGeYM9/SObO2G9qSFCs5NlrFBC8tGcJy+pmD
        E1AcbHnqLIURWQ1aJmLMwWFHkQc/CAuwbRPgCA+0AxZGbg==
X-Google-Smtp-Source: AA0mqf5V50POnlK7RVnvpT90m0T4wUMGKE71kUHbMZxvr97uT/tF5euu0N6LZW45+0qRylN6Hts/CHou470bc/R8gVA=
X-Received: by 2002:a63:6ce:0:b0:478:99ce:9f2b with SMTP id
 197-20020a6306ce000000b0047899ce9f2bmr21704638pgg.203.1670572624113; Thu, 08
 Dec 2022 23:57:04 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 9 Dec 2022 15:56:53 +0800
Message-ID: <CACkBjsaFJwjC5oiw-1KXvcazywodwXo4zGYsRHwbr2gSG9WcSw@mail.gmail.com>
Subject: BUG: missing null marking in PTR_TO_BTF_ID leads to null-ptr-deref in
 BPF prog
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
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

I constructed a BPF prog that can pass the verifier but contains null-ptr-deref.
This is achieved by exploiting the following behavior in the verifier:
1. verifier allows direct struct bpf_map access but does not mark the
pointer (PTR_TO_BTF_ID) as maybe_null
2. verifier allows pointer CMP in JMP, and marks reg as non-null
if one of the pointers is not null in the corresponding path.

The following crash can be reproduced on:

HEAD commit: 2d14123617f9 Merge branch 'Document some recent core
kfunc additions'
git tree: bpf-next
console log: https://pastebin.com/raw/UkZXqdqs
kernel config: https://pastebin.com/raw/BbzHXhkV
POC: https://pastebin.com/raw/XFHVa3xV

Essentially, the program in POC creates a MAP_HASH, then loads and run
the following BPF prog:

BPF_LD_MAP_FD(BPF_REG_1, map_fd),
// verifier believe R6 is ptr_to_btf_id, after this ldx
// but R6 = bpf_map->inner_map_meta, which is NULL,
// because we don't have inner map
BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 8),
BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
BPF_CALL_FUNC(BPF_FUNC_map_lookup_elem),
// verifier think R0 is map_value_or_null, R6 is ptr_btf_id
// at runtime, they all equal to NULL
BPF_JMP_REG(BPF_JEQ, BPF_REG_6, BPF_REG_0, 1),
BPF_EXIT_INSN(),
// here, verifier think R0 this map_value, but it is NULL
BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
BPF_EXIT_INSN(),

After loading and running prog, the following is reported:

general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 7 PID: 6781 Comm: a.out Not tainted 6.1.0-rc7-01517-g2d14123617f9 #125
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
1.16.1-1-1 04/01/2014
RIP: 0010:___bpf_prog_run+0x66d/0x8fd0 kernel/bpf/core.c:1937
Code: e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e6 78 00 00 48 b8 00 00
00 00 00 fc ff df 4d 0f bf 66 02 4d 01 ec 4c 89 e2 48 c1 ea 03 <0f> b6
14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 a7
RSP: 0018:ffffc900043377e8 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff818efa7c RDI: ffffc90001146092
RBP: ffffc900043378a0 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90001146090 R15: 0000000000000000
FS:  00007f68c01f6440(0000) GS:ffff88823bd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563424ffa008 CR3: 000000001fd2a000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
<TASK>
__bpf_prog_run32+0x9d/0xe0 kernel/bpf/core.c:2045
bpf_dispatcher_nop_func include/linux/bpf.h:1082 [inline]
__bpf_prog_run include/linux/filter.h:600 [inline]
bpf_prog_run include/linux/filter.h:607 [inline]
bpf_test_run+0x38e/0x980 net/bpf/test_run.c:402
bpf_prog_test_run_skb+0xb69/0x1dd0 net/bpf/test_run.c:1187
bpf_prog_test_run kernel/bpf/syscall.c:3644 [inline]
__sys_bpf+0x1293/0x5840 kernel/bpf/syscall.c:4997
__do_sys_bpf kernel/bpf/syscall.c:5083 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5081 [inline]
__x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5081
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f68bfae4469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff992ab838 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f68bfae4469
RDX: 0000000000000090 RSI: 00007fff992ac940 RDI: 000000000000000a
RBP: 00007fff992ac9e0 R08: 000000000000000a R09: 0000000300001118
R10: 0000000000000001 R11: 0000000000000246 R12: 00005634238006f0
R13: 00007fff992acac0 R14: 0000000000000000 R15: 0000000000000000
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:___bpf_prog_run+0x66d/0x8fd0 kernel/bpf/core.c:1937
Code: e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 e6 78 00 00 48 b8 00 00
00 00 00 fc ff df 4d 0f bf 66 02 4d 01 ec 4c 89 e2 48 c1 ea 03 <0f> b6
14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 a7
RSP: 0018:ffffc900043377e8 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff818efa7c RDI: ffffc90001146092
RBP: ffffc900043378a0 R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90001146090 R15: 0000000000000000
FS:  00007f68c01f6440(0000) GS:ffff88823bd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563424ffa008 CR3: 000000001fd2a000 CR4: 0000000000750ee0
PKRU: 55555554
----------------
Code disassembly (best guess):
  0: e0 07                loopne 0x9
  2: 83 c0 01              add    $0x1,%eax
  5: 38 d0                cmp    %dl,%al
  7: 7c 08                jl     0x11
  9: 84 d2                test   %dl,%dl
  b: 0f 85 e6 78 00 00    jne    0x78f7
  11: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  18: fc ff df
  1b: 4d 0f bf 66 02        movswq 0x2(%r14),%r12
  20: 4d 01 ec              add    %r13,%r12
  23: 4c 89 e2              mov    %r12,%rdx
  26: 48 c1 ea 03          shr    $0x3,%rdx
* 2a: 0f b6 14 02          movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e: 4c 89 e0              mov    %r12,%rax
  31: 83 e0 07              and    $0x7,%eax
  34: 83 c0 03              add    $0x3,%eax
  37: 38 d0                cmp    %dl,%al
  39: 7c 08                jl     0x43
  3b: 84 d2                test   %dl,%dl
  3d: 0f                    .byte 0xf
  3e: 85                    .byte 0x85
  3f: a7                    cmpsl  %es:(%rdi),%ds:(%rsi)
