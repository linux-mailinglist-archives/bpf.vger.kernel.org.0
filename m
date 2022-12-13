Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300B664B7DC
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiLMOyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 09:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiLMOxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 09:53:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591E1260B;
        Tue, 13 Dec 2022 06:53:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a16so18054013edb.9;
        Tue, 13 Dec 2022 06:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QJPUCdsTiJ63FDYInN9GX2ZTI4d35s7lni79WzV7P08=;
        b=Ri7fAyn9oKYgobcwH4LhAMeoBpsXeYh7fhHDLB5i8Q25WskjnYVCNjbfTUI3a2wIDj
         pVcLErX8WZCa1zKjwSd5NU0vpISF9zvPa9f5JcGd3armz267F7a1kHGoZ/S/7utZVw7N
         P7pW5fUJe726gaZklEbhWm8CtsNup1T4GRRpPkLcVFP6eeqZ42FUvtwsec8gJejl+h4i
         nTon7OJqQvYoMBgscxa2d/KQnU/J/E3aEjnbQDneCyFjp3E6YklGz4GquwNYHrmL5xFH
         NerAnXr8WDO3PRzQShOulIOxj3hkBQgQD2mUqXCymEMTY2GZE83sFtio0zEmYf4ZvZRu
         NrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJPUCdsTiJ63FDYInN9GX2ZTI4d35s7lni79WzV7P08=;
        b=Z4MwT+MGfy+uLPrFce7LG869uJGypEAeqOgvjHpx+DvUNxaxl70hZmk9n6LHI2TIfa
         qkEToZSAt7ioSx32OpRBB49H3c6+4j5GshpKJJV6kGmxcsWnw5OG+dmIPLG1qXI6zePK
         0O3C25/x+dMCCiP8KGBzNU3t/LB64jd0GChJSz7G10uysGLsRrCymlbpIqafq9WVEDRu
         eQzphWhuGlAaN81kdqj18FAG/lDMCGgxKTb6Fl2EeKJEV+Cn98J83caa6C8d9YW4NPId
         HvQOGETP3fmlHe6bqVYfcp3xVTmKJh8UB34dC1gMoVWtSoCxqZuEmZWGQC2X9RcPnqL6
         ZeiQ==
X-Gm-Message-State: ANoB5pm+9MRaetsr4wfCYS5S174SBcfJGo4Tes/0VrJ1B81sm05jsadZ
        JktoRf102nT/KdMW+w3XRKu/60esaKOOeMKo7C/MrgLGLdOEj8s2
X-Google-Smtp-Source: AA0mqf6C6tly2+O3ZAB2Mwxh1s7fOkA5jR+jYwc1MtgPqqJy3FMdWVhOVkuVD0v+a7zt73QcL+f/aQXch8zQoCv5+aU=
X-Received: by 2002:aa7:cd4d:0:b0:46a:832a:b851 with SMTP id
 v13-20020aa7cd4d000000b0046a832ab851mr59050462edw.127.1670943231359; Tue, 13
 Dec 2022 06:53:51 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Tue, 13 Dec 2022 22:53:15 +0800
Message-ID: <CAO4mrffr3H7UmOtgeJZ1dW4-7m2UL3CyHJRbPk3D_Fz5WnTAkw@mail.gmail.com>
Subject: KCSAN: data-race in __perf_event_overflow / perf_pending_irq
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>
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

Dear Linux Developers,

Recently, when using our tool to fuzz kernel, the following crash was
triggered. This crash is similar to the following two crashes:

KCSAN: data-race in perf_event_update_userpage /
perf_event_update_userpage
https://syzkaller.appspot.com/bug?extid=df838a721c117d596976.

KCSAN: data-race in arch_perf_update_userpage /
arch_perf_update_userpage
https://www.syzkaller.appspot.com/bug?id=36fce67cc4d62492fcd304c249d18178ac64bcf1

HEAD commit: 76dcd734eca
git tree: linux-next
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1Co5Pm4RrmekuREcxFtb-d5n6pOWe8zyh/view?usp=share_link
kernel config: https://drive.google.com/file/d/1jH4qV5XblPADvMDUlvS7DwtW0FroMoVB/view?usp=share_link
reproduce log: https://drive.google.com/file/d/1e08n4G8sI8IjeWJo4N8Beqze2K6UblSX/view?usp=share_link

Unfortunately, I do not have a stable reproducer for this crash. A
possible syz reproducer for this crash is listed below.

r0 = perf_event_open(&(0x7f0000000100)={0x0, 0x80, 0x0, 0x0, 0x0, 0x0,
0x0, 0x4000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, @perf_config_ext, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x2}, 0x0, 0x0, 0xffffffffffffffff, 0x0)
r1 = dup(r0)
mmap$IORING_OFF_SQ_RING(&(0x7f0000ffc000/0x3000)=nil, 0x3000, 0x0,
0x2011, r1, 0x0)
perf_event_open(&(0x7f0000001400)={0x2, 0x80, 0xfd, 0x0, 0x0, 0x0,
0x0, 0x6, 0x2053b, 0xa, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, @perf_bp={0x0}}, 0x0, 0x0, r1, 0xa)
clone3(&(0x7f0000000300)={0x44020000, 0x0, 0x0, 0x0, {}, 0x0, 0x0,
0x0, 0x0}, 0x58)

The crash can be reproduced with the following configuration:
{Threaded:true Collide:true Repeat:true RepeatTimes:0 Procs:1
Slowdown:1 Sandbox:none Fault:false FaultCall:-1 FaultNth:0 Leak:false
NetInjection:true NetDevices:true NetReset:true Cgroups:true
BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkPCI:true USB:true
VhciInjection:true Wifi:true IEEE802154:true Sysctl:true
UseTmpDir:true HandleSegv:true Repro:true Trace:false}

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

==================================================================
BUG: KCSAN: data-race in __perf_event_overflow / perf_pending_irq

write to 0xffff88805daa1a04 of 4 bytes by interrupt on cpu 0:
 __perf_event_overflow+0x7f/0x3d0 kernel/events/core.c:9323
 perf_event_overflow+0x26/0x30 kernel/events/core.c:9381
 handle_pmi_common+0x454/0x5d0 arch/x86/events/intel/core.c:3034
 intel_pmu_handle_irq+0x1d3/0x410 arch/x86/events/intel/core.c:3095
 perf_event_nmi_handler+0x42/0x70 arch/x86/events/core.c:1745
 nmi_handle+0x64/0x150 arch/x86/kernel/nmi.c:140
 default_do_nmi+0x66/0x2c0 arch/x86/kernel/nmi.c:337
 exc_nmi+0xbc/0x130 arch/x86/kernel/nmi.c:513
 end_repeat_nmi+0x16/0x31
 rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
 delay_tsc+0x67/0xe0 arch/x86/lib/delay.c:78
 delay_access kernel/kcsan/core.c:329 [inline]
 kcsan_setup_watchpoint+0x292/0x460 kernel/kcsan/core.c:604
 perf_event_wakeup kernel/events/core.c:6460 [inline]
 perf_pending_irq+0x1a5/0x3f0 kernel/events/core.c:6557
 irq_work_single kernel/irq_work.c:211 [inline]
 irq_work_run_list kernel/irq_work.c:242 [inline]
 irq_work_run+0xf1/0x2f0 kernel/irq_work.c:251
 __sysvec_irq_work+0x1e/0xb0 arch/x86/kernel/irq_work.c:22
 sysvec_irq_work+0x39/0xb0 arch/x86/kernel/irq_work.c:17
 asm_sysvec_irq_work+0x16/0x20 arch/x86/include/asm/idtentry.h:675
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x37/0x60 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
 dsp_cmx_send+0xdbc/0xdd0 drivers/isdn/mISDN/dsp_cmx.c:1853
 call_timer_fn+0x2e/0x240 kernel/time/timer.c:1474
 expire_timers+0x116/0x240 kernel/time/timer.c:1519
 __run_timers+0x368/0x410 kernel/time/timer.c:1790
 run_timer_softirq+0x2e/0x60 kernel/time/timer.c:1803
 __do_softirq+0xf2/0x2c9 kernel/softirq.c:571
 __irq_exit_rcu kernel/softirq.c:650 [inline]
 irq_exit_rcu+0x41/0x70 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x8d/0xb0 arch/x86/kernel/apic/apic.c:1107
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
 perf_prepare_sample+0x2fe/0xfc0 kernel/events/core.c:7422
 __perf_event_output kernel/events/core.c:7599 [inline]
 perf_event_output_forward+0x66/0xe0 kernel/events/core.c:7619
 __perf_event_overflow+0x320/0x3d0 kernel/events/core.c:9367
 perf_swevent_overflow kernel/events/core.c:9443 [inline]
 perf_swevent_event+0x118/0x3c0 kernel/events/core.c:9471
 perf_tp_event+0x1b2/0x540 kernel/events/core.c:9900
 perf_trace_run_bpf_submit+0xb3/0x120 kernel/events/core.c:9873
 perf_trace_kmalloc+0xe9/0x110 include/trace/events/kmem.h:54
 trace_kmalloc include/trace/events/kmem.h:54 [inline]
 __do_kmalloc_node mm/slab_common.c:956 [inline]
 __kmalloc+0x1b9/0x1e0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 __register_sysctl_table+0x91/0xca0 fs/proc/proc_sysctl.c:1337
 register_net_sysctl+0x1b1/0x1c0 net/sysctl_net.c:169
 neigh_sysctl_register+0x36c/0x3e0 net/core/neighbour.c:3854
 addrconf_sysctl_register+0x7a/0x110 net/ipv6/addrconf.c:7126
 ipv6_add_dev+0x85f/0xa60 net/ipv6/addrconf.c:450
 addrconf_notify+0x516/0x1bb0 net/ipv6/addrconf.c:3528
 notifier_call_chain kernel/notifier.c:87 [inline]
 raw_notifier_call_chain+0x53/0xb0 kernel/notifier.c:455
 call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 register_netdevice+0xd93/0x1040 net/core/dev.c:10090
 __ip_tunnel_create+0x1c5/0x260 net/ipv4/ip_tunnel.c:267
 ip_tunnel_init_net+0x18e/0x3d0 net/ipv4/ip_tunnel.c:1073
 ipgre_tap_init_net+0x31/0x40 net/ipv4/ip_gre.c:1682
 ops_init+0x215/0x2d0 net/core/net_namespace.c:135
 setup_net+0x2cb/0x810 net/core/net_namespace.c:332
 copy_net_ns+0x2ae/0x450 net/core/net_namespace.c:478
 create_new_namespaces+0x231/0x560 kernel/nsproxy.c:110
 copy_namespaces+0x116/0x160 kernel/nsproxy.c:178
 copy_process+0x16ca/0x30f0 kernel/fork.c:2256
 kernel_clone+0x15c/0x600 kernel/fork.c:2671
 __do_sys_clone3 kernel/fork.c:2970 [inline]
 __se_sys_clone3+0x1b5/0x1f0 kernel/fork.c:2954
 __x64_sys_clone3+0x2d/0x40 kernel/fork.c:2954
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88805daa1a04 of 4 bytes by interrupt on cpu 0:
 perf_event_wakeup kernel/events/core.c:6460 [inline]
 perf_pending_irq+0x1a5/0x3f0 kernel/events/core.c:6557
 irq_work_single kernel/irq_work.c:211 [inline]
 irq_work_run_list kernel/irq_work.c:242 [inline]
 irq_work_run+0xf1/0x2f0 kernel/irq_work.c:251
 __sysvec_irq_work+0x1e/0xb0 arch/x86/kernel/irq_work.c:22
 sysvec_irq_work+0x39/0xb0 arch/x86/kernel/irq_work.c:17
 asm_sysvec_irq_work+0x16/0x20 arch/x86/include/asm/idtentry.h:675
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x37/0x60 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
 dsp_cmx_send+0xdbc/0xdd0 drivers/isdn/mISDN/dsp_cmx.c:1853
 call_timer_fn+0x2e/0x240 kernel/time/timer.c:1474
 expire_timers+0x116/0x240 kernel/time/timer.c:1519
 __run_timers+0x368/0x410 kernel/time/timer.c:1790
 run_timer_softirq+0x2e/0x60 kernel/time/timer.c:1803
 __do_softirq+0xf2/0x2c9 kernel/softirq.c:571
 __irq_exit_rcu kernel/softirq.c:650 [inline]
 irq_exit_rcu+0x41/0x70 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x8d/0xb0 arch/x86/kernel/apic/apic.c:1107
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
 perf_prepare_sample+0x2fe/0xfc0 kernel/events/core.c:7422
 __perf_event_output kernel/events/core.c:7599 [inline]
 perf_event_output_forward+0x66/0xe0 kernel/events/core.c:7619
 __perf_event_overflow+0x320/0x3d0 kernel/events/core.c:9367
 perf_swevent_overflow kernel/events/core.c:9443 [inline]
 perf_swevent_event+0x118/0x3c0 kernel/events/core.c:9471
 perf_tp_event+0x1b2/0x540 kernel/events/core.c:9900
 perf_trace_run_bpf_submit+0xb3/0x120 kernel/events/core.c:9873
 perf_trace_kmalloc+0xe9/0x110 include/trace/events/kmem.h:54
 trace_kmalloc include/trace/events/kmem.h:54 [inline]
 __do_kmalloc_node mm/slab_common.c:956 [inline]
 __kmalloc+0x1b9/0x1e0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 __register_sysctl_table+0x91/0xca0 fs/proc/proc_sysctl.c:1337
 register_net_sysctl+0x1b1/0x1c0 net/sysctl_net.c:169
 neigh_sysctl_register+0x36c/0x3e0 net/core/neighbour.c:3854
 addrconf_sysctl_register+0x7a/0x110 net/ipv6/addrconf.c:7126
 ipv6_add_dev+0x85f/0xa60 net/ipv6/addrconf.c:450
 addrconf_notify+0x516/0x1bb0 net/ipv6/addrconf.c:3528
 notifier_call_chain kernel/notifier.c:87 [inline]
 raw_notifier_call_chain+0x53/0xb0 kernel/notifier.c:455
 call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 register_netdevice+0xd93/0x1040 net/core/dev.c:10090
 __ip_tunnel_create+0x1c5/0x260 net/ipv4/ip_tunnel.c:267
 ip_tunnel_init_net+0x18e/0x3d0 net/ipv4/ip_tunnel.c:1073
 ipgre_tap_init_net+0x31/0x40 net/ipv4/ip_gre.c:1682
 ops_init+0x215/0x2d0 net/core/net_namespace.c:135
 setup_net+0x2cb/0x810 net/core/net_namespace.c:332
 copy_net_ns+0x2ae/0x450 net/core/net_namespace.c:478
 create_new_namespaces+0x231/0x560 kernel/nsproxy.c:110
 copy_namespaces+0x116/0x160 kernel/nsproxy.c:178
 copy_process+0x16ca/0x30f0 kernel/fork.c:2256
 kernel_clone+0x15c/0x600 kernel/fork.c:2671
 __do_sys_clone3 kernel/fork.c:2970 [inline]
 __se_sys_clone3+0x1b5/0x1f0 kernel/fork.c:2954
 __x64_sys_clone3+0x2d/0x40 kernel/fork.c:2954
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 23079 Comm: syz-executor.0 Not tainted 6.1.0-rc8 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
==================================================================

Best,
Wei
