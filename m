Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0A3435C4
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 00:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCUXcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Mar 2021 19:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231441AbhCUXcJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Mar 2021 19:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616369528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kZUnaNUg4mxD1ZV1ixmoD3yRNeDbe5cGS1hH1q4CVb8=;
        b=YnUNCpysYv6BBFtCoaaPTA7MWmCo3ffAc9lmwUfVMXmuEgGoV4eQs3eVMO8Q5KvqU3WQ04
        ZQxi6Qppqt8V7xgsQWMXiUE26VopEv7LuC3ulNkk3XSqS5DnJH0s+7NEDuLwXN37r1h14a
        pe1KJhfiGzOy+ON2mv2+RJ4qm5RAXkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-1qJ1mJqROBqrCfdCnUeQ_g-1; Sun, 21 Mar 2021 19:32:06 -0400
X-MC-Unique: 1qJ1mJqROBqrCfdCnUeQ_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1285F801984;
        Sun, 21 Mar 2021 23:32:05 +0000 (UTC)
Received: from krava (unknown [10.40.192.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1DE5550DDE;
        Sun, 21 Mar 2021 23:32:02 +0000 (UTC)
Date:   Mon, 22 Mar 2021 00:32:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf] bpf: Fix fexit trampoline.
Message-ID: <YFfXcqnksPsSe0Bv@krava>
References: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 02:00:07PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The fexit/fmod_ret programs can be attached to kernel functions that can sleep.
> The synchronize_rcu_tasks() will not wait for such tasks to complete.
> In such case the trampoline image will be freed and when the task
> wakes up the return IP will point to freed memory causing the crash.
> Solve this by adding percpu_ref_get/put for the duration of trampoline
> and separate trampoline vs its image life times.
> The "half page" optimization has to be removed, since
> first_half->second_half->first_half transition cannot be guaranteed to
> complete in deterministic time. Every trampoline update becomes a new image.
> The image with fmod_ret or fexit progs will be freed via percpu_ref_kill and
> call_rcu_tasks. Together they will wait for the original function and
> trampoline asm to complete. The trampoline is patched from nop to jmp to skip
> fexit progs. They are freed independently from the trampoline. The image with
> fentry progs only will be freed via call_rcu_tasks_trace+call_rcu_tasks which
> will wait for both sleepable and non-sleepable progs to complete.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>  # for RCU
> ---
> Without ftrace fix:
> https://patchwork.kernel.org/project/netdevbpf/patch/20210316195815.34714-1-alexei.starovoitov@gmail.com/
> this patch will trigger warn in ftrace.
> 
>  arch/x86/net/bpf_jit_comp.c |  26 ++++-
>  include/linux/bpf.h         |  24 +++-
>  kernel/bpf/bpf_struct_ops.c |   2 +-
>  kernel/bpf/core.c           |   4 +-
>  kernel/bpf/trampoline.c     | 218 +++++++++++++++++++++++++++---------
>  5 files changed, 213 insertions(+), 61 deletions(-)
> 

hi,
I'm on bpf/master and I'm triggering warnings below when running together:

  # while :; do ./test_progs -t fentry_test ; done
  # while :; do ./test_progs -t module_attach ; done

when I revert this patch (plus b90829704780) it seems ok

jirka


---
[  548.594548] bpf_testmod: loading out-of-tree module taints kernel.
[  548.600787] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
[  558.353423] ------------[ cut here ]------------
[  558.358064] WARNING: CPU: 35 PID: 1572 at kernel/bpf/syscall.c:2516 bpf_tracing_link_release+0x3b/0x40
[  558.367399] Modules linked in: intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass rapl mei_me iTCO_wdt intel_cstate wmi_bmof iTCO_ve]
[  558.409989] CPU: 35 PID: 1572 Comm: test-66 Tainted: G          IOE     5.12.0-rc2+ #25
[  558.418005] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 12/14/2018
[  558.425492] RIP: 0010:bpf_tracing_link_release+0x3b/0x40
[  558.430829] Code: 48 8b 7f 18 e8 26 5c 02 00 85 c0 75 1d 48 8b 7b 48 e8 29 53 02 00 48 8b 7b 50 48 85 ff 74 05 e8 bb f4 ff ff 48 8b 5d f8 c9 c3 <0f> 0b eb df 90 0f 1f 44 00 00 55 48 89 e5 41 54 4f
[  558.449588] RSP: 0018:ffffc90002107e40 EFLAGS: 00010286
[  558.454828] RAX: 00000000ffffffed RBX: ffff888105982300 RCX: 0000000000000000
[  558.461969] RDX: ffff8881132c2540 RSI: 4c376cb4fcbc233e RDI: ffff8881058595d0
[  558.469110] RBP: ffffc90002107e48 R08: 0000000000000000 R09: 00000000ffff850f
[  558.476250] R10: 000000000000000a R11: 0000000000000008 R12: ffff888105982300
[  558.483391] R13: ffff8881040743f8 R14: ffff8881039465a0 R15: ffff888141359440
[  558.490532] FS:  00007f4232341740(0000) GS:ffff8897e10c0000(0000) knlGS:0000000000000000
[  558.498625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  558.504371] CR2: 0000000001ef164d CR3: 000000014b23a002 CR4: 00000000007706e0
[  558.511505] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  558.518645] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  558.525778] PKRU: 55555554
[  558.528492] Call Trace:
[  558.530956]  bpf_link_free+0x55/0x80
[  558.534539]  bpf_link_release+0x29/0x70
[  558.538389]  __fput+0x9f/0x250
[  558.541457]  ____fput+0xe/0x10
[  558.544525]  task_work_run+0x64/0xa0
[  558.548112]  exit_to_user_mode_prepare+0x11c/0x120
[  558.552914]  syscall_exit_to_user_mode+0x21/0x40
[  558.557543]  ? __x64_sys_close+0x12/0x40
[  558.561476]  do_syscall_64+0x45/0x50
[  558.565065]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  558.570125] RIP: 0033:0x7f4232524167
[  558.573713] Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0f
[  558.592470] RSP: 002b:00007ffd76f88ec8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  558.600047] RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f4232524167
[  558.607187] RDX: 0000000005824950 RSI: 000000000582ec50 RDI: 0000000000000009
[  558.614326] RBP: 000000000582ec80 R08: 0000000000000000 R09: 00007ffd76f88df7
[  558.621466] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  558.628600] R13: 00000000000001c8 R14: 00000000fffffffb R15: 000000000000000b
[  558.635741] ---[ end trace 878f3b01fdcfe925 ]---
[  563.521703] ------------[ cut here ]------------
[  563.526335] WARNING: CPU: 37 PID: 1586 at kernel/trace/ftrace.c:6321 ftrace_module_enable+0x33d/0x370
[  563.535559] Modules linked in: bpf_testmod(OE+) intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass rapl mei_me iTCO_wdt intel_cstate]
[  563.579581] CPU: 37 PID: 1586 Comm: test_progs Tainted: G        W IOE     5.12.0-rc2+ #25
[  563.587862] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 12/14/2018
[  563.595348] RIP: 0010:ftrace_module_enable+0x33d/0x370
[  563.600495] Code: 74 99 48 81 ca 00 00 00 10 49 89 54 24 08 e9 dc fe ff ff 8b 8b 98 01 00 00 48 01 ca 48 39 d0 0f 83 2e fd ff ff e9 65 fd ff ff <0f> 0b e9 be fe ff ff 0f 0b e9 b7 fe ff ff 48 83 7d
[  563.619249] RSP: 0018:ffffc90002137d18 EFLAGS: 00010206
[  563.624483] RAX: 0000000000031045 RBX: ffffffffa06793c0 RCX: 000000000000003d
[  563.631617] RDX: ffff888108eb2080 RSI: ffffffffa06763c0 RDI: 0000000000000000
[  563.638757] RBP: ffffc90002137d40 R08: ffffffff82b32ea0 R09: 0000000000000000
[  563.645890] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88810abd2030
[  563.653027] R13: 61c8864680b583eb R14: 0000000000000003 R15: ffff888115d7d080
[  563.660166] FS:  00007fcf8c7cb740(0000) GS:ffff8897e1140000(0000) knlGS:0000000000000000
[  563.668259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  563.674005] CR2: 000000000159d3d8 CR3: 000000010aad6001 CR4: 00000000007706e0
[  563.681136] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  563.688270] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  563.695403] PKRU: 55555554
[  563.698116] Call Trace:
[  563.700573]  load_module+0x2142/0x2610
[  563.704333]  __do_sys_finit_module+0xc2/0x120
[  563.708700]  __x64_sys_finit_module+0x1a/0x20
[  563.713064]  do_syscall_64+0x38/0x50
[  563.716656]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  563.721715] RIP: 0033:0x7fcf8c8cc55d
[  563.725302] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d eb 78 0c 00 f8
[  563.744050] RSP: 002b:00007fffc6d14f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  563.751625] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcf8c8cc55d
[  563.758764] RDX: 0000000000000000 RSI: 000000000159d3da RDI: 0000000000000004
[  563.765899] RBP: 0000000000000004 R08: 0000000000000000 R09: 00007fffc6d83000
[  563.773039] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[  563.780174] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  563.787316] ---[ end trace 878f3b01fdcfe926 ]---
[  563.903431] ------------[ cut here ]------------
[  563.908057] WARNING: CPU: 32 PID: 1584 at kernel/trace/ftrace.c:1748 __ftrace_hash_rec_update.part.0+0x326/0x430
[  563.918243] Modules linked in: bpf_testmod(OE) intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass rapl mei_me iTCO_wdt intel_cstate ]
[  563.962163] CPU: 32 PID: 1584 Comm: test-38 Tainted: G        W IOE     5.12.0-rc2+ #25
[  563.970172] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 12/14/2018
[  563.977658] RIP: 0010:__ftrace_hash_rec_update.part.0+0x326/0x430
[  563.983757] Code: e7 c4 82 75 ca 49 8b 41 08 e9 30 ff ff ff 49 8b 41 08 4d 85 d2 0f 84 23 ff ff ff 48 0d 00 00 00 10 49 89 41 08 e9 63 fe ff ff <0f> 0b c7 05 2e fa aa 01 01 00 00 00 c7 05 34 fa a0
[  564.002503] RSP: 0018:ffffc9000212fc48 EFLAGS: 00010246
[  564.007731] RAX: 0000000000000000 RBX: ffff888115d7d080 RCX: 0000000000000001
[  564.014873] RDX: 0000000000000003 RSI: ffffffffa06763c0 RDI: 0000000000000000
[  564.022015] RBP: ffffc9000212fcc0 R08: 0000000000000001 R09: ffff88810abd2030
[  564.029154] R10: ffff888108eb2080 R11: 0000000000000000 R12: 0000000000000000
[  564.036288] R13: 0000000000000007 R14: 0000000000000000 R15: 0000000000000003
[  564.043418] FS:  00007ff79bdeb740(0000) GS:ffff8897e1000000(0000) knlGS:0000000000000000
[  564.051503] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  564.057250] CR2: 00007ff79c039000 CR3: 000000010baee002 CR4: 00000000007706e0
[  564.064383] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  564.071515] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  564.078649] PKRU: 55555554
[  564.081361] Call Trace:
[  564.083821]  ? udp_destruct_sock+0x140/0x140
[  564.088107]  ftrace_hash_rec_update_modify+0x1f/0x80
[  564.093081]  ftrace_hash_move_and_update_ops+0xcf/0x240
[  564.098314]  ? bpf_fentry_test1+0x10/0x10
[  564.102336]  ftrace_set_hash+0x121/0x1d0
[  564.106275]  ? 0xffffffffa052e000
[  564.109599]  ? bpf_fentry_test1+0x10/0x10
[  564.113620]  unregister_ftrace_direct+0x7a/0x200
[  564.118247]  ? bpf_fentry_test1+0x10/0x10
[  564.122271]  bpf_trampoline_update+0x31e/0x3f0
[  564.126726]  ? __radix_tree_delete+0x87/0xf0
[  564.131005]  bpf_trampoline_unlink_prog+0x9c/0x140
[  564.135808]  bpf_tracing_link_release+0x1a/0x40
[  564.140347]  bpf_link_free+0x55/0x80
[  564.143935]  bpf_link_release+0x29/0x70
[  564.147784]  __fput+0x9f/0x250
[  564.150851]  ____fput+0xe/0x10
[  564.153911]  task_work_run+0x64/0xa0
[  564.157498]  exit_to_user_mode_prepare+0x11c/0x120
[  564.162299]  syscall_exit_to_user_mode+0x21/0x40
[  564.166928]  ? __x64_sys_close+0x12/0x40
[  564.170863]  do_syscall_64+0x45/0x50
[  564.174451]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  564.179510] RIP: 0033:0x7ff79bfce167
[  564.183090] Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0f
[  564.201836] RSP: 002b:00007ffd8a9d85a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  564.209403] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00007ff79bfce167
[  564.216536] RDX: 0000000007274970 RSI: 0000000007276370 RDI: 000000000000000f
[  564.223669] RBP: 00000000072763a0 R08: 0000000000000000 R09: 00007ffd8a9d84d7
[  564.230801] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  564.237936] R13: 00007ff79c039030 R14: 0000000000000002 R15: 0000000000000000
[  564.245077] ---[ end trace 878f3b01fdcfe927 ]---
[  564.467617] ------------[ cut here ]------------
[  564.472245] WARNING: CPU: 32 PID: 1584 at kernel/trace/ftrace.c:5228 unregister_ftrace_direct+0x1df/0x200
[  564.481814] Modules linked in: bpf_testmod(OE) intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass rapl mei_me iTCO_wdt intel_cstate ]
[  564.525736] CPU: 32 PID: 1584 Comm: test-38 Tainted: G        W IOE     5.12.0-rc2+ #25
[  564.533745] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 12/14/2018
[  564.541233] RIP: 0010:unregister_ftrace_direct+0x1df/0x200
[  564.546726] Code: 85 c0 75 0e 31 f6 48 c7 c7 a0 2e b3 82 e8 79 e4 ff ff 48 c7 c7 60 30 b3 82 e8 5d b1 94 00 e9 73 fe ff ff 0f 0b e9 1a ff ff ff <0f> 0b e9 a1 fe ff ff 0f 0b e9 0c ff ff ff 41 be e1
[  564.565480] RSP: 0018:ffffc9000212fd90 EFLAGS: 00010286
[  564.570716] RAX: 0000000000000001 RBX: ffffffffa0503000 RCX: ffffffff81954730
[  564.577860] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff82b32ea0
[  564.584996] RBP: ffffc9000212fdb8 R08: 0000000000000001 R09: 0000000000000000
[  564.592128] R10: 0000000000000002 R11: ffff8881067cc790 R12: ffffffff81954730
[  564.599261] R13: ffff888103ac18e0 R14: 00000000ffffffed R15: ffff888106251140
[  564.606396] FS:  00007ff79bdeb740(0000) GS:ffff8897e1000000(0000) knlGS:0000000000000000
[  564.614488] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  564.620235] CR2: 00007ff79c039000 CR3: 000000010baee002 CR4: 00000000007706e0
[  564.627368] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  564.634500] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  564.641633] PKRU: 55555554
[  564.644345] Call Trace:
[  564.646800]  ? bpf_fentry_test2+0x10/0x10
[  564.650821]  bpf_trampoline_update+0x31e/0x3f0
[  564.655275]  ? __radix_tree_delete+0x87/0xf0
[  564.659558]  bpf_trampoline_unlink_prog+0x9c/0x140
[  564.664359]  bpf_tracing_link_release+0x1a/0x40
[  564.668900]  bpf_link_free+0x55/0x80
[  564.672486]  bpf_link_release+0x29/0x70
[  564.676333]  __fput+0x9f/0x250
[  564.679395]  ____fput+0xe/0x10
[  564.682462]  task_work_run+0x64/0xa0
[  564.686051]  exit_to_user_mode_prepare+0x11c/0x120
[  564.690869]  syscall_exit_to_user_mode+0x21/0x40
[  564.695502]  ? __x64_sys_close+0x12/0x40
[  564.699442]  do_syscall_64+0x45/0x50
[  564.703029]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  564.708089] RIP: 0033:0x7ff79bfce167
[  564.711669] Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0f
[  564.730422] RSP: 002b:00007ffd8a9d85a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  564.737989] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00007ff79bfce167
[  564.745121] RDX: 0000000007274970 RSI: 00000000072763a0 RDI: 0000000000000010
[  564.752254] RBP: 00000000072763d0 R08: 0000000000000000 R09: 00007ffd8a9d84d7
[  564.759387] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  564.766520] R13: 00007ff79c039030 R14: 0000000000000002 R15: 0000000000000000
[  564.773655] ---[ end trace 878f3b01fdcfe928 ]---
[  565.117608] ------------[ cut here ]------------

