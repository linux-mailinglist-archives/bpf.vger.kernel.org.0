Return-Path: <bpf+bounces-38644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A7966E65
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 03:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68760B231DC
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4BF9E8;
	Sat, 31 Aug 2024 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="IfvuUk8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A173FC2
	for <bpf@vger.kernel.org>; Sat, 31 Aug 2024 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725067152; cv=none; b=qBnu8bMFozruUnrh6LCTnL+vn2CFxa6U5enqOjhOY75yjk7ZIIwLINGqaem7n5vOdbctWCrVmZrGORCQ+8/fIbPxbKhOU+ZS3ntVPeK/k58q616yBB5wyn0nHhIMKZrP88/vZobkUIXePF5UtiR4qhY9VXT7E7+vZRqdTNf1K4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725067152; c=relaxed/simple;
	bh=kjsST4ZfH4e2xp9/cfmKkJ0pWssiN+/aKT37mgaYrOo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X0cOP084Nj1R5YqzbmMA15rLSaoXjNtsezrte3RCfD4KDzZdHzr8lppjhF9nVwUczOnBJfdL4Nqdkw2J6BE4MV6kHBc9aZWeRxKyO4vAzd3vB7ZT9SSDYaBXnO675Amj2EXNuJqabZTL1H53XgytPlmYqRNbeWoU9vpRP8O75J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=IfvuUk8D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334adf7249so3245629e87.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1725067149; x=1725671949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OvNUF+ObRyaCGWr66dLQG0ToRdrL/RDtoQBxxz5I7Ho=;
        b=IfvuUk8DLyL7/Heu+g1u/8aixbg6bZNrpjz1VFlSpH28LByuIRcH+ahSYWLiCoPolj
         19U2xiulK4+uKveg1YPq3vMHGz8j+0N6vdhjiY6Lo9rqayM231nfdwbbUJRO41BnqCNS
         1bo0OTIPP2jw1JuQo9/ZalwdcGPAoSqiNE0zhQtrtIKiSjMaySku8ogqIGWSg6q/6yKk
         1EOPbBjVJGagkPqHC9Qh92gJW0m0jFAgDe7MIBH0jWmMkWbsgdEDVqnrRNPj0RD3cM0p
         neZsuV6OGg7cMloHQOLUlIP42FcF+GKNjcxdITSeL9bwZFrjWVX+eV0+54kwLQvgkzJQ
         zBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725067149; x=1725671949;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvNUF+ObRyaCGWr66dLQG0ToRdrL/RDtoQBxxz5I7Ho=;
        b=G6wZbLebMFMuswlV9lSDEoUOCm+E+9PdXx/QXK4+tUGnzL2sTbG74RXXEHTs/uz54j
         74LqDMkJ+N4Yv6PQ5i3DuSxehZcLkO2Ai3HnaZ0p8+canw65oTFcDAtImJfN7gl16LbS
         DOAIXBzF4yo3zB+HfA2edds5YHhMRIxC9GmchpMGYQNsQ6xZrFd3pIts2PKWBGipFA9+
         29Jk0tgC1mykxXUa3CbaDnLLE4sAE/Av1CfJiR0jZA9EzZ8dQq4wt8JSnUfR+n6UKY47
         n3GemwuIuPSCFJkIeDHIKgfG8YVXST5KVi8nnec5z2YoQUonLWmiFt1DWzRtP/RNv6kI
         xwvw==
X-Gm-Message-State: AOJu0YyMNKZCkdJHnY1pU0S6ulqusOcGV+KBfVgO1KCgZJja08qeOJgs
	tiUILydgd0eJQXZbvhD40lWBjIyLnn1MwJ4qvdh9HIk0/NumTHIBMz3LE+1bIP3t77S3C+l8eGU
	dQfs0oZIO2GtKchuSikRLaWW/O9OwJt8+2/cqig==
X-Google-Smtp-Source: AGHT+IFQFOqbUde6wGJExByR2z6mqTwrcWfK5vBPuuNWAGqFyzqnhso6jw7DzTQGYLYC4qltOfgGiuwZ8QXsKNPys5k=
X-Received: by 2002:a05:6512:280c:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-53546b92af7mr2935074e87.44.1725067148689; Fri, 30 Aug 2024
 18:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 30 Aug 2024 18:18:56 -0700
Message-ID: <CAPPBnEaJRP5YZTQ-xY4gt6eYxS8_WG0e4pwDYXvn5OtrjyFzaw@mail.gmail.com>
Subject: Possible deadlock in percpu_counter_add_batch
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool called Spinner to detect locking violations
in the bpf subsytem. Spinner reported the raw_spin_lock() in
percpu_counter_add_batch(). This function is used by
htab_percpu_map_update_elem() and htab_percpu_map_delete_elem(), both
of which can be called from NMI. A deadlock can happen if a bpf
program holding the lock is interrupted by another program in NMI that
tries to acquire the same lock. The report was generated for kernel
version 6.6-rc4, however, we believe this should still exist in the
latest kernel.

We tried to validate the report on v6.10 by running a PoC. Below is
the lockdep splat. The PoC is attached at the end.

While executing the PoC, lockdep makes another report for the
spin_lock used in htab_lock_bucket() which we believe to be a false
positive.

Thanks,
Priya


[  113.618910] ================================
[  113.618912] WARNING: inconsistent lock state
[  113.618914] 6.10.0-rc7+ #35 Not tainted
[  113.618916] --------------------------------
[  113.618917] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  113.618919] percpu_perf/1140 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  113.618923] ffff888113274460 (key#18){....}-{2:2}, at:
percpu_counter_add_batch+0xd4/0x180
[  113.618939] {INITIAL USE} state was registered at:
[  113.618941]   lock_acquire+0x1be/0x560
[  113.618946]   _raw_spin_lock+0x3b/0x80
[  113.618952]   percpu_counter_add_batch+0xd4/0x180
[  113.618955]   alloc_htab_elem+0x452/0x820
[  113.618959]   __htab_percpu_map_update_elem+0x2bb/0x430
[  113.618963]   htab_percpu_map_update_elem+0x15/0x20
[  113.618966]   bpf_prog_67104ba9eab51b63_callback+0x88/0xf9
[  113.618970]   bpf_prog_18ed4d80ded39420_tp+0x82/0xa3
[  113.618972]   trace_call_bpf+0x24d/0x810
[  113.618976]   kprobe_perf_func+0x108/0x8c0
[  113.618979]   kprobe_dispatcher+0xbc/0x160
[  113.618981]   kprobe_ftrace_handler+0x2f3/0x4d0
[  113.618985]   e1000_init_module+0xe9/0xff0 [e1000]
[  113.618990]   do_nanosleep+0x1/0x470
[  113.618993]   common_nsleep+0x81/0xc0
[  113.618997]   __x64_sys_clock_nanosleep+0x2c5/0x4b0
[  113.619000]   x64_sys_call+0xf8d/0x1f20
[  113.619004]   do_syscall_64+0x8b/0x140
[  113.619007]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  113.619013] irq event stamp: 30488
[  113.619014] hardirqs last  enabled at (30487): [<ffffffff841ce30f>]
irqentry_exit+0x6f/0xa0
[  113.619019] hardirqs last disabled at (30488): [<ffffffff841c9a46>]
exc_nmi+0x106/0x2a0
[  113.619023] softirqs last  enabled at (30486): [<ffffffff8124b209>]
__irq_exit_rcu+0xa9/0x120
[  113.619027] softirqs last disabled at (30479): [<ffffffff8124b209>]
__irq_exit_rcu+0xa9/0x120
[  113.619030]
               other info that might help us debug this:
[  113.619032]  Possible unsafe locking scenario:

[  113.619033]        CPU0
[  113.619034]        ----
[  113.619034]   lock(key#18);
[  113.619037]   <Interrupt>
[  113.619038]     lock(key#18);
[  113.619040]
                *** DEADLOCK ***

[  113.619041] no locks held by percpu_perf/1140.
[  113.619043]
               stack backtrace:
[  113.619045] CPU: 2 PID: 1140 Comm: percpu_perf Not tainted 6.10.0-rc7+ #35
[  113.619048] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  113.619057] Call Trace:
[  113.619059]  <TASK>
[  113.619062]  dump_stack_lvl+0x9f/0xf0
[  113.619067]  dump_stack+0x14/0x20
[  113.619069]  print_usage_bug.part.0+0x408/0x690
[  113.619074]  lock_acquire+0x3ab/0x560
[  113.619077]  ? llist_add_batch+0xd6/0x160
[  113.619081]  ? __pfx_lock_acquire+0x10/0x10
[  113.619084]  ? percpu_counter_add_batch+0xd4/0x180
[  113.619088]  ? lock_acquire+0x48c/0x560
[  113.619090]  ? rcu_is_watching+0x17/0xd0
[  113.619096]  ? __pfx_lock_acquire+0x10/0x10
[  113.619100]  _raw_spin_lock+0x3b/0x80
[  113.619102]  ? percpu_counter_add_batch+0xd4/0x180
[  113.619106]  percpu_counter_add_batch+0xd4/0x180
[  113.619111]  alloc_htab_elem+0x452/0x820
[  113.619117]  __htab_percpu_map_update_elem+0x2bb/0x430
[  113.619122]  ? __pfx___htab_percpu_map_update_elem+0x10/0x10
[  113.619128]  htab_percpu_map_update_elem+0x15/0x20
[  113.619132]  bpf_prog_67104ba9eab51b63_callback+0x88/0xf9
[  113.619136]  bpf_prog_72e9553d3d58c8e4_percpu_perf+0x82/0xa3
[  113.619140]  __perf_event_overflow+0x232/0xe40
[  113.619144]  ? x86_perf_event_set_period+0x268/0x560
[  113.619148]  ? __pfx___perf_event_overflow+0x10/0x10
[  113.619155]  perf_event_overflow+0x1d/0x30
[  113.619158]  handle_pmi_common+0x38a/0x9f0
[  113.619165]  ? __pfx_handle_pmi_common+0x10/0x10
[  113.619177]  ? __this_cpu_preempt_check+0x17/0x20
[  113.619182]  ? __pfx_intel_bts_interrupt+0x10/0x10
[  113.619186]  ? debug_smp_processor_id+0x1b/0x30
[  113.619190]  intel_pmu_handle_irq+0x24a/0xb20
[  113.619195]  ? __this_cpu_preempt_check+0x17/0x20
[  113.619200]  perf_event_nmi_handler+0x40/0x60
[  113.619204]  nmi_handle+0x168/0x4a0
[  113.619209]  ? rcu_is_watching+0x17/0xd0
[  113.619214]  default_do_nmi+0x6e/0x180
[  113.619218]  exc_nmi+0x1cd/0x2a0
[  113.619222]  asm_exc_nmi+0xbc/0x105
[  113.619225] RIP: 0033:0x5580d124f606
[  113.619238] Code: ff ff ff ff 48 8b 05 59 9a 04 00 48 89 c1 ba 2a
00 00 00 be 01 00 00 00 48 8d 05 e5 1b 03 00 48 89 c7 e8 dd f6 ff ff
eb 10 90 <0f> b6 05 3c 9a 04 00 83 f0 01 84 c0 75 f2 90 48 83 bd 08 fe
ff ff
[  113.619241] RSP: 002b:00007fff1b3d6ff0 EFLAGS: 00000202
[  113.619244] RAX: 0000000000000001 RBX: 00005580feb35920 RCX: 0000000000000000
[  113.619246] RDX: 0000000000000000 RSI: 00005580feb35010 RDI: 0000000000000007
[  113.619248] RBP: 00007fff1b3d7220 R08: 00005580feb35860 R09: 00000004feb359f0
[  113.619250] R10: 0000000000000000 R11: a43a236fd00a0e7c R12: 00007fff1b3d7338
[  113.619252] R13: 00005580d124f084 R14: 00005580d12969d8 R15: 00007f26cec79040
[  113.619259]  </TASK>

The lockdep warning can be triggered using the following bpf and user programs.
============================================================
#include "vmlinux.h"
#include <linux/version.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>

struct {
        __uint(type, BPF_MAP_TYPE_PERCPU_HASH);
        __type(key, int);
        __type(value,int);
        __uint(max_entries, 2048);
        __uint(map_flags, BPF_F_NO_PREALLOC);
} pb SEC(".maps");

struct callback_ctx {
        int output;
};
__u32 stop_index = -1;
int i = 0;
int j = 0;

static int callback(__u32 index, void *data)
{
        struct callback_ctx *ctx = data;
        int value = 2;

        bpf_map_update_elem(&pb, &i, &value, BPF_ANY);
        i+=1;
        if (index >= stop_index)
                return 1;

        ctx->output += index;

        return 0;
}

static int callback_tp(__u32 index, void *data)
{
        struct callback_ctx *ctx = data;
        int value = 2;
        bpf_map_update_elem(&pb, &i, &value, BPF_ANY);

        i+=1;
        if (index >= stop_index)
                return 1;

        ctx->output += index;

        return 0;
}

SEC("perf_event")
int percpu_perf(void *ctx)
{
        bpf_printk("perf event");

        struct callback_ctx data = {};
        int nr_loops = bpf_loop(10, callback, &data, 0);
        return 0;
}

SEC("kprobe/do_nanosleep")
int tp(void *ctx)
{
        int i;
        bpf_printk("tp");
        struct callback_ctx data = {};
        int nr_loops = bpf_loop(10, callback, &data, 0);

        return 0;
}

char _license[] SEC("license") = "GPL";
============================================================

#include <unistd.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <sys/resource.h>
#include <signal.h>
#include "percpu_perf.skel.h"


static volatile bool exiting = false;

static void sig_handler(int sig)
{
        exiting = true;
        return;
}
extern int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);

static long perf_event_open(struct perf_event_attr *hw_event, pid_t
pid, int cpu, int group_fd,
                            unsigned long flags)
{
        int ret;

        ret = syscall(__NR_perf_event_open, hw_event, pid, cpu,
group_fd, flags);
        return ret;
}

void bump_memlock_rlimit(void)
{
        struct rlimit rlim_new = {
                .rlim_cur       = RLIM_INFINITY,
                .rlim_max       = RLIM_INFINITY,
        };

        if (setrlimit(RLIMIT_MEMLOCK, &rlim_new)) {
                fprintf(stderr, "Failed to increase RLIMIT_MEMLOCK limit!\n");
                exit(1);
        }
        return;
}

int main(int argc, char *const argv[])
{
        const char *online_cpus_file = "/sys/devices/system/cpu/online";
        int cpu;
        struct percpu_perf_bpf *skel = NULL;
        struct perf_event_attr attr;
        struct bpf_link **links = NULL;
        int num_cpus, num_online_cpus;
        int *pefds = NULL, pefd;
        int i, err = 0;
        bool *online_mask = NULL;

        struct bpf_program *prog;
        struct bpf_object *obj;
        struct bpf_map *map;
        char filename[256];


        bump_memlock_rlimit();

        signal(SIGINT, sig_handler);
        signal(SIGTERM, sig_handler);

        err = parse_cpu_mask_file(online_cpus_file, &online_mask,
&num_online_cpus);
        if (err) {
                fprintf(stderr, "Fail to get online CPU numbers: %d\n", err);
                goto cleanup;
        }


        num_cpus = libbpf_num_possible_cpus();
        if (num_cpus <= 0) {
                fprintf(stderr, "Fail to get the number of processors\n");
                err = -1;
                goto cleanup;
        }


        snprintf(filename, sizeof(filename), ".output/percpu_perf.bpf.o");
        obj = bpf_object__open_file(filename, NULL);

        if (libbpf_get_error(obj)) {
                fprintf(stderr, "ERROR: opening BPF object file failed\n");
                goto cleanup;
        }

        map = bpf_object__find_map_by_name(obj, "pb");
        if (libbpf_get_error(map)) {
                fprintf(stderr, "ERROR: finding a map in obj file failed\n");
                goto cleanup;
        }


        if (bpf_object__load(obj)) {
                fprintf(stderr, "ERROR: loading BPF object file failed\n");
                goto cleanup;
        }

        pefds = malloc(num_cpus * sizeof(int));
        for (i = 0; i < 1; i++) {
                pefds[i] = -1;
        }

        links = calloc(num_cpus, sizeof(struct bpf_link *));


        memset(&attr, 0, sizeof(attr));


        attr.type = PERF_TYPE_HARDWARE;
        attr.config = PERF_COUNT_HW_CPU_CYCLES;
        attr.sample_freq = 10;
        attr.inherit = 1;
        attr.freq = 1;
        for (cpu = 0; cpu < 1; cpu++) {
                //skip offline/not present CPUs
                if (cpu >= num_online_cpus || !online_mask[cpu])
                        continue;

                // Set up performance monitoring on a CPU/Core
                pefd = perf_event_open(&attr, 0, -1, -1, 0);
                if (pefd < 0) {
                        fprintf(stderr, "Fail to set up performance
monitor on a CPU/Core\n");
                        err = -1;
                        goto cleanup;
                }
                pefds[cpu] = pefd;


                prog = bpf_object__find_program_by_name(obj, "percpu_perf");
                if (!prog) {
                        fprintf(stderr, "ERROR: finding a prog in obj
file failed\n");
                        goto cleanup;
                }

                links[cpu] = bpf_program__attach_perf_event(prog, pefds[cpu]);
                if (!links[cpu]) {
                        err = -1;
                        fprintf(stderr, "ERROR: bpf_program__attach failed\n");

                        goto cleanup;
                }

        }


        struct bpf_program *prog2;
        struct bpf_link *link_tp;
        prog2 = bpf_object__find_program_by_name(obj, "tp");
        if (!prog2) {
                fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
                goto cleanup;
        }
        link_tp = bpf_program__attach(prog2);
        if (!link_tp) {
                err = -1;
                fprintf(stderr, "ERROR: bpf_program__attach failed\n");
                goto cleanup;
        }



        while(!exiting){
        }

cleanup:
        if (links) {
                for (cpu = 0; cpu < num_cpus; cpu++)
                        bpf_link__destroy(links[cpu]);
                free(links);
        }

        if (pefds) {
                for (i = 0; i < num_cpus; i++) {
                        if (pefds[i] >= 0)
                                close(pefds[i]);
                }
                free(pefds);
        }


        percpu_perf_bpf__destroy(skel);
        free(online_mask);
        return -err;
}

