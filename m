Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DFA40EECE
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 03:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhIQBgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 21:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhIQBgr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Sep 2021 21:36:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C434C061574;
        Thu, 16 Sep 2021 18:35:26 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o8so5123422pll.1;
        Thu, 16 Sep 2021 18:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3PHfIvxqqcUrWS5Hx2bdHPDtXJMbFVG7saaT8lldtnc=;
        b=dMK12HTMtxz4oC4z/SGk42LqbeoqQ7XOHiJ8YXA/lopRQ/A3Fm0ieD8duCuDCsKild
         n7r9HIlubC3M/mtAPQ19T7GGX2NAe4H89EczAnpK4oIaU/lD1B9/Uv1ng2EFQu8kwiaE
         jBaTXSNwBxJsf1bEFRiIubNAxiH4OG27GJuikhb/ZfiO2W7Cdl2fuSEftjzxUMO1zmEI
         U/uy529bBWxVypPbczAtTXmuY/aQPHZhjwZmxw7hOTOfLi6KO207vnbOvgdFviEYnWqc
         sWDe8s17FG2ZbH1v4ktRHCZyOUzDBHFLBiBvyV2XxpGWV4DFjEtVW1B/ARr4AdTffclT
         XFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3PHfIvxqqcUrWS5Hx2bdHPDtXJMbFVG7saaT8lldtnc=;
        b=38ieLU+Oq3OzcfrfBBzEo1TbM9CC/qjwon0ncsKEZzTnxRIcutMYCnI62D5031oHO0
         P7Oj56cSi1plCmiVi/f9RAojo+2LHzwJAvWIBdowoQj8PoQADBxf3E1NYK2KVUncfM7F
         WhPyS+sDS836ahx93S3EY+s51POeMADX1Pos2U1YDFhajTRSWpThmu2LL19haKV0Ru4s
         Smc352/cCbo4sEdWMtX1WIO/8IvXcoM5OBFtljCnNAd6QJ1rKG5Z8OaxFPx4KUIiz+RD
         E/y8Uz2GUCguJotIT3D6VXcojOmJtOuVOXSziUPmBkYoe2zFzA2t+K4OOT441lpCsQXn
         OPsA==
X-Gm-Message-State: AOAM530qKNbGHV8dAT1VFzaAstu9oCjhr9SvVrPoqJ7vAQt8rwNiRl9t
        QeebWY/0I1fwJ6+ARlZbLUybtvdXVy+6fkPR6Zv19K22EJdN+gY=
X-Google-Smtp-Source: ABdhPJxkuLYlKBC8KVn5ZypMYxjRnaO0B4mrf9WKt9j+zodYxyf+u03gR2ATpo/jYKBe/zDop7+jmGMGJzYa5vjeNNQ=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr9559206pjr.178.1631842525785;
 Thu, 16 Sep 2021 18:35:25 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 17 Sep 2021 09:35:14 +0800
Message-ID: <CACkBjsb5gtv5q8XdvL0QkK19GmifydqZ9MrvaAjG7m0YveWKOQ@mail.gmail.com>
Subject: WARNING in skb_try_coalesce
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org, yoshfuji@linux-ipv6.org
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        songliubraving@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915
git tree: upstream
console output:
https://drive.google.com/file/d/108QvdldUg5-0Gc1q1OiJA4HqGmTTFK7a/view?usp=sharing
kernel config: https://drive.google.com/file/d/1zXpDhs-IdE7tX17B7MhaYP0VGUfP6m9B/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 3 PID: 0 at net/core/skbuff.c:5412
skb_try_coalesce+0x11c6/0x1570 net/core/skbuff.c:5412
Modules linked in:
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.15.0-rc1+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:skb_try_coalesce+0x11c6/0x1570 net/core/skbuff.c:5412
Code: 00 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 0f 85 50 01 00 00 49 8b
84 24 c8 00 00 00 48 89 44 24 50 e9 4f f5 ff ff e8 4a b6 62 fa <0f> 0b
e9 6c f9 ff ff e8 3e b6 62 fa 48 8b 44 24 78 48 8d 70 ff 48
RSP: 0018:ffffc900008a0368 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000fffffea8 RCX: ffff888100159c80
RDX: 0000000000000000 RSI: ffff888100159c80 RDI: 0000000000000002
RBP: ffff88801a2b3400 R08: ffffffff87139896 R09: 00000000fffffea8
R10: 0000000000000004 R11: ffffed1002fdfa89 R12: ffff88802be90780
R13: ffff888017595ac0 R14: ffff88802be907fe R15: 0000000000000028
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b9f8f7c488 CR3: 0000000111612000 CR4: 0000000000350ee0
DR0: 00000000200002c0 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 tcp_try_coalesce net/ipv4/tcp_input.c:4642 [inline]
 tcp_try_coalesce+0x393/0x920 net/ipv4/tcp_input.c:4621
 tcp_queue_rcv+0x8a/0x710 net/ipv4/tcp_input.c:4905
 tcp_data_queue+0xb78/0x49e0 net/ipv4/tcp_input.c:5016
 tcp_rcv_established+0x944/0x2040 net/ipv4/tcp_input.c:5928
 tcp_v4_do_rcv+0x65e/0xb20 net/ipv4/tcp_ipv4.c:1694
 tcp_v4_rcv+0x37b4/0x4580 net/ipv4/tcp_ipv4.c:2087
 ip_protocol_deliver_rcu+0xa7/0xed0 net/ipv4/ip_input.c:204
 ip_local_deliver_finish+0x207/0x370 net/ipv4/ip_input.c:231
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip_local_deliver+0x1c5/0x4e0 net/ipv4/ip_input.c:252
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x1da/0x2f0 net/ipv4/ip_input.c:429
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip_rcv+0xcd/0x3b0 net/ipv4/ip_input.c:540
 deliver_skb net/core/dev.c:2212 [inline]
 deliver_ptype_list_skb net/core/dev.c:2227 [inline]
 __netif_receive_skb_core+0x179d/0x3940 net/core/dev.c:5392
 __netif_receive_skb_one_core+0xae/0x180 net/core/dev.c:5434
 __netif_receive_skb+0x24/0x1c0 net/core/dev.c:5550
 process_backlog+0x223/0x770 net/core/dev.c:6427
 __napi_poll+0xb3/0x630 net/core/dev.c:6982
 napi_poll net/core/dev.c:7049 [inline]
 net_rx_action+0x823/0xbc0 net/core/dev.c:7136
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:636 [inline]
 irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:717
Code: 3b 5f 88 f8 e9 6f fe ff ff e8 31 5f 88 f8 e9 3d fe ff ff e8 f7
30 fd ff cc cc cc cc cc cc cc eb 07 0f 00 2d a7 bf 50 00 fb f4 <c3> 0f
1f 40 00 41 54 be 08 00 00 00 53 65 48 8b 1c 25 40 f0 01 00
RSP: 0018:ffffc90000777de0 EFLAGS: 00000206
RAX: 000000000090b2d1 RBX: 0000000000000003 RCX: ffffffff8932aef2
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed1026ba6542
R10: ffff888135d32a0b R11: ffffed1026ba6541 R12: 0000000000000003
R13: 0000000000000003 R14: ffffffff8d6dbbd0 R15: 0000000000000000
 default_idle_call+0xc4/0x420 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x3f9/0x570 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_secondary+0x227/0x2f0 arch/x86/kernel/smpboot.c:270
 secondary_startup_64_no_verify+0xb0/0xbb
----------------
Code disassembly (best guess):
   0: 3b 5f 88              cmp    -0x78(%rdi),%ebx
   3: f8                    clc
   4: e9 6f fe ff ff        jmpq   0xfffffe78
   9: e8 31 5f 88 f8        callq  0xf8885f3f
   e: e9 3d fe ff ff        jmpq   0xfffffe50
  13: e8 f7 30 fd ff        callq  0xfffd310f
  18: cc                    int3
  19: cc                    int3
  1a: cc                    int3
  1b: cc                    int3
  1c: cc                    int3
  1d: cc                    int3
  1e: cc                    int3
  1f: eb 07                jmp    0x28
  21: 0f 00 2d a7 bf 50 00 verw   0x50bfa7(%rip)        # 0x50bfcf
  28: fb                    sti
  29: f4                    hlt
* 2a: c3                    retq <-- trapping instruction
  2b: 0f 1f 40 00          nopl   0x0(%rax)
  2f: 41 54                push   %r12
  31: be 08 00 00 00        mov    $0x8,%esi
  36: 53                    push   %rbx
  37: 65 48 8b 1c 25 40 f0 mov    %gs:0x1f040,%rbx
  3e: 01 00
