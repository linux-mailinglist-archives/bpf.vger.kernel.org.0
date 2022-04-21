Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E205098E9
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbiDUHUW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 03:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiDUHUV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 03:20:21 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488FD167F5
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 00:17:31 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23L7H1NR090122;
        Thu, 21 Apr 2022 16:17:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Thu, 21 Apr 2022 16:17:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23L7H17D090118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Apr 2022 16:17:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e6f25385-c5d0-f56e-27e8-1e2fd2378755@I-love.SAKURA.ne.jp>
Date:   Thu, 21 Apr 2022 16:17:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: How to disassemble a BPF program?
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <4ed4a01e-3d1e-bf1e-803a-608df187bde5@I-love.SAKURA.ne.jp>
 <909c72b6-83f9-69a0-af80-d9cb3bc2bd0e@I-love.SAKURA.ne.jp>
 <CAEf4Bzbugg4dy_2J=cFKYYQEJx-irF-cRZvkkwCx4QQwXm5OpA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAEf4Bzbugg4dy_2J=cFKYYQEJx-irF-cRZvkkwCx4QQwXm5OpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/04/21 1:48, Andrii Nakryiko wrote:
> If the BPF program is loaded/verified successfully, the easiest way to
> go about this would be to prevent repro from proceeding right after
> successful validation (e.g, do scanf()) and then use bpftool to find
> that program's ID and dump disassembly while that program is in the
> kernel.

Thank you for a command line example.

As of commit b253435746d9a4a7 ("Merge tag 'xtensa-20220416' of https://github.com/jcmvbkbc/linux-xtensa")
I got the following output with "tools/bpf/bpftool/bpftool prog dump xlat id $NUM".

----------------------------------------
   0: (bf) r6 = r1
   1: (b7) r7 = -1048575
   2: (bf) r2 = r7
   3: (bf) r1 = r6
   4: (85) call bpf_skb_load_helper_8_no_cache#12742912
   5: (75) if r0 s>= 0x0 goto pc+2
   6: (ac) w0 ^= w0
   7: (95) exit
   8: (b7) r2 = 12582912
   9: (bf) r1 = r6
  10: (85) call bpf_skb_load_helper_8_no_cache#12742912
  11: (75) if r0 s>= 0x0 goto pc+2
  12: (ac) w0 ^= w0
  13: (95) exit
  14: (95) exit
----------------------------------------

I feel that amount of output above is too short for "char program[2053]".
How can TCP/IPv6 socket be created from this quite limited operations?
Since insn_cnt = 5 when bpf(BPF_PROG_LOAD) is called, am I failing to dump
some of programs in "char program[2053]" ?

        const union bpf_attr attr = {
                .prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
                .insn_cnt = 5,
                .insns = (unsigned long long) program,
                .license = (unsigned long long) license,
        };
        const int bpf_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, 72);

----------------------------------------
[   63.156414][ T2733] a.out (2733) used greatest stack depth: 11736 bytes left
[  224.313093][    C0] general protection fault, probably for non-canonical address 0x6b6af3ebe92b6cab: 0000 [#1] PREEMPT SMP
[  224.324686][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc3-00016-gb253435746d9 #761
[  224.337077][    C0] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  224.349213][    C0] RIP: 0010:tcp_retransmit_timer+0x33c/0xcc0
[  224.357069][    C0] Code: 12 02 01 e8 a0 7c 5b 00 e9 22 fd ff ff 48 c7 c7 76 52 36 83 41 bd 0c 00 00 00 e8 bf 54 66 00 48 8b 45 30 48 8b 80 c0 02 00 00 <65> 48 ff 80 40 01 00 00 0f b6 4d 12 48 8b 5d 30 41 d3 fd 41 83 e5
[  224.367728][    C0] RSP: 0018:ffffc90000003db8 EFLAGS: 00010282
[  224.371159][    C0] RAX: 6b6b6b6b6b6b6b6b RBX: 0000000000000000 RCX: 0000000000000001
[  224.376266][    C0] RDX: 0000000000000000 RSI: ffffffff83365276 RDI: ffffffff8324665e
[  224.380835][    C0] RBP: ffff88810aec9bc0 R08: ffff88800bf7c040 R09: 0000000000000001
[  224.385458][    C0] R10: 0000000000000002 R11: 0000000000000000 R12: ffff88810aec9cf0
[  224.389093][    C0] R13: 000000000000000c R14: ffff88810b5d8040 R15: ffff88810aec9e48
[  224.392236][    C0] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[  224.395757][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.397935][    C0] CR2: 00007ff7ddf6101c CR3: 0000000003e3a000 CR4: 00000000000506f0
[  224.401532][    C0] Call Trace:
[  224.402898][    C0]  <IRQ>
[  224.403963][    C0]  ? mark_held_locks+0x49/0x70
[  224.405609][    C0]  ? ktime_get+0x1cb/0x260
[  224.407147][    C0]  ? lockdep_hardirqs_on+0x79/0x100
[  224.409040][    C0]  ? tcp_write_timer_handler+0x280/0x280
[  224.410906][    C0]  tcp_write_timer_handler+0x1c2/0x280
[  224.412975][    C0]  tcp_write_timer+0xa5/0x110
[  224.414661][    C0]  ? tcp_write_timer_handler+0x280/0x280
[  224.416786][    C0]  call_timer_fn+0xa6/0x300
[  224.418609][    C0]  __run_timers.part.0+0x209/0x320
[  224.420428][    C0]  run_timer_softirq+0x2c/0x60
[  224.422104][    C0]  __do_softirq+0x174/0x53f
[  224.423762][    C0]  __irq_exit_rcu+0xcb/0x120
[  224.425402][    C0]  irq_exit_rcu+0x5/0x20
[  224.427016][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0
[  224.429080][    C0]  </IRQ>
[  224.430250][    C0]  <TASK>
[  224.431407][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  224.436669][    C0] RIP: 0010:default_idle+0xb/0x10
[  224.438742][    C0] Code: 8b 04 25 40 af 01 00 f0 80 60 02 df c3 0f ae f0 0f ae 38 0f ae f0 eb b9 0f 1f 80 00 00 00 00 eb 07 0f 00 2d e3 b6 56 00 fb f4 <c3> cc cc cc cc 53 48 89 fb e8 67 fb fe ff 48 8b 15 a0 91 4e 02 89
[  224.445032][    C0] RSP: 0018:ffffffff83e03ea8 EFLAGS: 00000206
[  224.446996][    C0] RAX: 00000000000234bb RBX: ffffffff83e61a00 RCX: 0000000000000001
[  224.450133][    C0] RDX: 0000000000000000 RSI: ffffffff832e9bc9 RDI: ffffffff8324665e
[  224.453066][    C0] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[  224.455758][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  224.458531][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  224.461234][    C0]  default_idle_call+0x54/0x90
[  224.462885][    C0]  do_idle+0x1f3/0x240
[  224.464307][    C0]  cpu_startup_entry+0x14/0x20
[  224.465970][    C0]  start_kernel+0x69c/0x6c1
[  224.467689][    C0]  secondary_startup_64_no_verify+0xc3/0xcb
[  224.470086][    C0]  </TASK>
[  224.471219][    C0] Modules linked in:
[  224.472849][    C0] ---[ end trace 0000000000000000 ]---
[  224.474935][    C0] RIP: 0010:tcp_retransmit_timer+0x33c/0xcc0
[  224.477175][    C0] Code: 12 02 01 e8 a0 7c 5b 00 e9 22 fd ff ff 48 c7 c7 76 52 36 83 41 bd 0c 00 00 00 e8 bf 54 66 00 48 8b 45 30 48 8b 80 c0 02 00 00 <65> 48 ff 80 40 01 00 00 0f b6 4d 12 48 8b 5d 30 41 d3 fd 41 83 e5
[  224.484428][    C0] RSP: 0018:ffffc90000003db8 EFLAGS: 00010282
[  224.486898][    C0] RAX: 6b6b6b6b6b6b6b6b RBX: 0000000000000000 RCX: 0000000000000001
[  224.489955][    C0] RDX: 0000000000000000 RSI: ffffffff83365276 RDI: ffffffff8324665e
[  224.493134][    C0] RBP: ffff88810aec9bc0 R08: ffff88800bf7c040 R09: 0000000000000001
[  224.496092][    C0] R10: 0000000000000002 R11: 0000000000000000 R12: ffff88810aec9cf0
[  224.499257][    C0] R13: 000000000000000c R14: ffff88810b5d8040 R15: ffff88810aec9e48
[  224.502907][    C0] FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[  224.506218][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  224.508647][    C0] CR2: 00007ff7ddf6101c CR3: 0000000003e3a000 CR4: 00000000000506f0
[  224.511437][    C0] Kernel panic - not syncing: Fatal exception in interrupt
[  224.514645][    C0] Kernel Offset: disabled
[  224.516090][    C0] Rebooting in 10 seconds..
----------------------------------------

Also, I tried to find what bpf_skb_load_helper_8_no_cache() is doing
but I couldn't find the implementation of ____bpf_skb_load_helper_8().
Where is ____bpf_skb_load_helper_8() defined?

----------------------------------------
BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
           int, offset)
{
        return ____bpf_skb_load_helper_8(skb, skb->data, skb->len - skb->data_len,
                                         offset);
}
----------------------------------------

