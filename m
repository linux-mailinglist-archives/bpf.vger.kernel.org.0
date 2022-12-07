Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E195645359
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 06:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLGFRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 00:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGFRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 00:17:22 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D64D5477F;
        Tue,  6 Dec 2022 21:17:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 124so16601457pfy.0;
        Tue, 06 Dec 2022 21:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vpkyS+CT1aMFis1/J1Z1V7/qx1ZG1VahD2s/GoKLywM=;
        b=QkIo4+KyZJQ9r49/8Y6SyKaoXQbqa+z1RfIYn+THq3WrZ20hkhxx+v41Rc6XHTAKSr
         h2o50UFDGmXirQgAjK5mxqXfXZvgJzrvVMqPnWb2ErhNzNh/XKPnhAUiuKCYJIXPZRQf
         vHP3h4iHoYk0CaViSy8Oc0PMw72yTY0+7KA35pjfgquWul24IZ03ESG5g0hx+huQ72Lo
         UYfDWouqMfnz7yIkkmnzt47avReoOVGLNR0A9cBjGKNBUlLoczIuUOVoiihgmNnA16oC
         hvbT8MMWrebEfDPcLzEaFs2oAY4v80m34NHOLwpVLu/cW2pmyNiuLA/Dcuhsc1QqqQ3w
         TIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpkyS+CT1aMFis1/J1Z1V7/qx1ZG1VahD2s/GoKLywM=;
        b=j+rrenCasHgO4VwoSTh2WJzK7EU6J3lWFeXKcj4eh82OdE6AYZajoYTa47j+aajTxZ
         lyeLTC09s4lUFp1Ltd93+93B/HFO71+nwN9pO37VobGWRNS33tJyNGjDAIhxEJ7Q1bHu
         xDIwu80FZVvPboUmnDh0r49pG/Y51Gdz/cnO2nnzbQr8p1oIiZKA636bVIdGEouT8+No
         Eqcjgt0E+cJCxF1hLfcmrxgzOWlHzxuhJ6BPzk7uR0NFQbOhzhix/V4yC+JxYTMjnru9
         qQBi/tdYWwEUuItIw7kjst4++ewmy2oHIF/dTN3PiPG7sv4FVfLkQ7uUFsPh7LAx/4Go
         2QXA==
X-Gm-Message-State: ANoB5pk/BJzTcxowdQZUVkuHoPH9vK76m+UZlDXBFykNnCKpx7K1RUAe
        Ri1FtoG1j6Jqk7XQ1PDQDj2Y9YDbr1WpahP8cVSuPY2bJA==
X-Google-Smtp-Source: AA0mqf4EKSBrLyzrCQmx2ooCr66GIPCW7v1Qcq35aKlmg+OahqJXE6LmS9tzPaU7xOMtvgKdxRRYTvNJ8RI4VmHZIoE=
X-Received: by 2002:aa7:8542:0:b0:575:3c6a:f05c with SMTP id
 y2-20020aa78542000000b005753c6af05cmr44336798pfn.25.1670390240351; Tue, 06
 Dec 2022 21:17:20 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 7 Dec 2022 13:17:09 +0800
Message-ID: <CACkBjsb3GRw5aiTT=RCUs3H5aum_QN+B0ZqZA=MvjspUP6NFMg@mail.gmail.com>
Subject: WARNING: inconsistent lock state in trace_call_bpf
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

The following warning can be triggered by attaching/detaching the prog
in the link multiple times. This is related to a previous report:
https://lore.kernel.org/bpf/Y4%2F27g8EHQ9F3bDr@google.com/T/#t

Seems hard to prevent this, especially with kprobe. This can be
reproduced on:

HEAD commit: ab0350c743d5 selftests/bpf: Fix conflicts with built-in
functions in bpf_iter_ksym
git tree: bpf-next
console log: https://pastebin.com/raw/khH3sQVG
kernel config: https://pastebin.com/raw/77bXX2Wb
BPF prog: https://pastebin.com/raw/A43uNuP1

================================
WARNING: inconsistent lock state
6.1.0-rc7-01489-gab0350c743d5 #120 Not tainted
--------------------------------
inconsistent {INITIAL USE} -> {IN-NMI} usage.
kprobe/6606 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffffffff8d41bfb8 (trace_printk_lock){....}-{2:2}, at:
____bpf_trace_printk kernel/trace/bpf_trace.c:391 [inline]
ffffffff8d41bfb8 (trace_printk_lock){....}-{2:2}, at:
bpf_trace_printk+0xd3/0x170 kernel/trace/bpf_trace.c:377
{INITIAL USE} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5668 [inline]
  lock_acquire+0x1e0/0x610 kernel/locking/lockdep.c:5633
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
  ____bpf_trace_printk kernel/trace/bpf_trace.c:391 [inline]
  bpf_trace_printk+0xd3/0x170 kernel/trace/bpf_trace.c:377
  bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk+0x2b/0x37
  bpf_dispatcher_nop_func include/linux/bpf.h:1082 [inline]
  __bpf_prog_run include/linux/filter.h:600 [inline]
  bpf_prog_run include/linux/filter.h:607 [inline]
  bpf_prog_run_array include/linux/bpf.h:1728 [inline]
  trace_call_bpf+0x280/0x660 kernel/trace/bpf_trace.c:136
  kprobe_perf_func+0x107/0x860 kernel/trace/trace_kprobe.c:1522
  kprobe_dispatcher+0xe6/0x180 kernel/trace/trace_kprobe.c:1665
  opt_pre_handler+0xd9/0x160 kernel/kprobes.c:429
  optimized_callback arch/x86/kernel/kprobes/opt.c:199 [inline]
  optimized_callback+0x221/0x2b0 arch/x86/kernel/kprobes/opt.c:176
  0xffffffffa0403034
  pgdat_kswapd_lock include/linux/memory_hotplug.h:213 [inline]
  kswapd_is_running mm/compaction.c:1987 [inline]
  should_proactive_compact_node mm/compaction.c:2060 [inline]
  kcompactd+0x2cb/0xeb0 mm/compaction.c:2979
irq event stamp: 14116
hardirqs last  enabled at (14115): [<ffffffff81d074f2>]
kasan_quarantine_put+0x102/0x230 mm/kasan/quarantine.c:242
hardirqs last disabled at (14116): [<ffffffff89f217a3>]
exc_int3+0x23/0x80 arch/x86/kernel/traps.c:843
softirqs last  enabled at (14102): [<ffffffff81917290>] spin_unlock_bh
include/linux/spinlock.h:395 [inline]
softirqs last  enabled at (14102): [<ffffffff81917290>]
bpf_link_settle kernel/bpf/syscall.c:2879 [inline]
softirqs last  enabled at (14102): [<ffffffff81917290>]
bpf_perf_link_attach+0x360/0x520 kernel/bpf/syscall.c:3283
softirqs last disabled at (14100): [<ffffffff81917253>] spin_lock_bh
include/linux/spinlock.h:355 [inline]
softirqs last disabled at (14100): [<ffffffff81917253>]
bpf_link_settle kernel/bpf/syscall.c:2877 [inline]
softirqs last disabled at (14100): [<ffffffff81917253>]
bpf_perf_link_attach+0x323/0x520 kernel/bpf/syscall.c:3283

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(trace_printk_lock);
  <Interrupt>
    lock(trace_printk_lock);

 *** DEADLOCK ***

1 lock held by kprobe/6606:
 #0: ffff8880b98412b0 (&cpuctx_mutex){+.+.}-{3:3}, at:
perf_event_ctx_lock_nested+0x227/0x480 kernel/events/core.c:1297

stack backtrace:
CPU: 0 PID: 6606 Comm: kprobe Not tainted 6.1.0-rc7-01489-gab0350c743d5 #120
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
1.16.1-1-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
 print_usage_bug include/trace/events/lock.h:24 [inline]
 verify_lock_unused kernel/locking/lockdep.c:5600 [inline]
 lock_acquire kernel/locking/lockdep.c:5659 [inline]
 lock_acquire.cold+0x3b/0x40 kernel/locking/lockdep.c:5633
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:391 [inline]
 bpf_trace_printk+0xd3/0x170 kernel/trace/bpf_trace.c:377
 bpf_prog_cf2ac6d483d8499b_trace_bpf_trace_printk+0x33/0x37
 bpf_dispatcher_nop_func include/linux/bpf.h:1082 [inline]
 __bpf_prog_run include/linux/filter.h:600 [inline]
 bpf_prog_run include/linux/filter.h:607 [inline]
 bpf_prog_run_array include/linux/bpf.h:1728 [inline]
 trace_call_bpf+0x280/0x660 kernel/trace/bpf_trace.c:136
 kprobe_perf_func+0x107/0x860 kernel/trace/trace_kprobe.c:1522
 kprobe_dispatcher+0xe6/0x180 kernel/trace/trace_kprobe.c:1665
 aggr_pre_handler+0xdd/0x180 kernel/kprobes.c:1202
 kprobe_int3_handler+0x442/0x560 arch/x86/kernel/kprobes/core.c:981
 do_int3+0xd/0x50 arch/x86/kernel/traps.c:800
 exc_int3+0x2d/0x80 arch/x86/kernel/traps.c:846
 asm_exc_int3+0x39/0x40 arch/x86/include/asm/idtentry.h:569
RIP: 0010:trace_contention_begin+0x1/0x1e0 include/trace/events/lock.h:95
Code: f5 2b 6e 00 e9 7d fe ff ff 48 89 df e8 e8 2b 6e 00 e9 ea fe ff
ff e8 fe 2b 6e 00 e9 43 ff ff ff 66 0f 1f 84 00 00 00 00 00 cc <55> 41
54 55 53 66 90 48 c7 c3 80 b7 32 8f 65 8b 2d f2 de 9f 7e 48
RSP: 0018:ffffc9000be87cb0 EFLAGS: 00000282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff11004068149 RSI: 0000000000000021 RDI: ffff8880b9841248
RBP: ffffc9000be87e10 R08: 0000000000000000 R09: ffffffff91ee6a4f
R10: fffffbfff23dcd49 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff8880b9841248 R15: ffffed10026611c0
 __mutex_lock_common kernel/locking/mutex.c:605 [inline]
 __mutex_lock+0x15a/0x12e0 kernel/locking/mutex.c:747
 perf_event_ctx_lock_nested+0x227/0x480 kernel/events/core.c:1297
 perf_event_ctx_lock kernel/events/core.c:1310 [inline]
 perf_ioctl+0x67/0xb0 kernel/events/core.c:5754
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x189/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9e448e1017
Code: 00 00 00 48 8b 05 81 7e 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff
ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 51 7e 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc65e35c48 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f9e448e1017
RDX: 0000000000000000 RSI: 0000000000002400 RDI: 0000000000000006
RBP: 0000000000000001 R08: 0000000727d65330 R09: 0000000500000000
R10: 0000000000000541 R11: 0000000000000206 R12: 0000000000000005
R13: 000055f027d65f70 R14: 0000000000000006 R15: 000055f027d65350
 </TASK>
----------------
Code disassembly (best guess):
   0: f5                    cmc
   1: 2b 6e 00              sub    0x0(%rsi),%ebp
   4: e9 7d fe ff ff        jmp    0xfffffe86
   9: 48 89 df              mov    %rbx,%rdi
   c: e8 e8 2b 6e 00        call   0x6e2bf9
  11: e9 ea fe ff ff        jmp    0xffffff00
  16: e8 fe 2b 6e 00        call   0x6e2c19
  1b: e9 43 ff ff ff        jmp    0xffffff63
  20: 66 0f 1f 84 00 00 00 nopw   0x0(%rax,%rax,1)
  27: 00 00
  29: cc                    int3
* 2a: 55                    push   %rbp <-- trapping instruction
  2b: 41 54                push   %r12
  2d: 55                    push   %rbp
  2e: 53                    push   %rbx
  2f: 66 90                xchg   %ax,%ax
  31: 48 c7 c3 80 b7 32 8f mov    $0xffffffff8f32b780,%rbx
  38: 65 8b 2d f2 de 9f 7e mov    %gs:0x7e9fdef2(%rip),%ebp        # 0x7e9fdf31
  3f: 48                    rex.W
