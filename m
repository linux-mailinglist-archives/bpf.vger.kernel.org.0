Return-Path: <bpf+bounces-38598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D667966AB7
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B841EB216A2
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3EE1BF7F8;
	Fri, 30 Aug 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="LxK5mvj/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CF15B117
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050181; cv=none; b=th8Gce5myq5UK237qRUxGb6iDQNqnFFiWXo5XWUiawUKAPBaQouRiy5e+b9usL8Ig3OFPDtVPnWRyfAPxYCXQQrHmXMhEAzk1RGt/NIWkjVkQwnmuhvbHaA2+tgNrZk+WsEH3FmGjWV6LTvwrHrcGb3HG9+z6A7DtiMdXtjxTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050181; c=relaxed/simple;
	bh=nLwFqML6tVnRVlhGeJXMaS9GVIIafwGYz/c0l7nuvGA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q0mrZWYpjldwQUUlU7MlbomKmvU4df7eRH9YIfPMhq9RTtuRNWzzFIRm3cgb0B0hry8y+4jRtvJ9y/A5EALTd7VrBLZInag/vRpCwBRks5XwaXifOgZEvFrxgMZRBMlJ5T5Y7UduWA4NmBn3ho7/31YSYD47uVmOhDRof6K5jFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=LxK5mvj/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334adf7249so3045806e87.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1725050178; x=1725654978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wwnhtRSdC8EDI/rK05pJQ44LtsbVX7sceOJw5sfInxc=;
        b=LxK5mvj///GKsp0VM1N3q4aIPgMGUSayF6L6SybH5GZwg/10BcDfZq32AUTFdruNTC
         dclF6B+kfYgpQTx6PQeEq9jVa29/RiW1s1J6h2eyszH1QwAKqQ+QVgUKna2tl3u4ShAN
         Cw8EYxtN/Z6ObG9KrSfqo0SKmUPKSdNTJYEwxiZ8ae7HmlaIaDaTJD79oq8zUMLM3tYc
         JYxgme5QokzxZM9/JGHVHe742EkIMVkaP1KhpxUhn/lghdo3CwqHuA0m+EIU/Mju38Qk
         bIJdyDgcmUtoDiTpDY6MxgMBWW0yrORLv77OzWK2R4+4CDan/xWK/cjiFvIpaAriiLFi
         m4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725050178; x=1725654978;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwnhtRSdC8EDI/rK05pJQ44LtsbVX7sceOJw5sfInxc=;
        b=d0HxSFjpK58YwJ+z/j46pUxDxblN0rdPyKZy7ElyoA40ooZYITclWI3lNLwD0MXK+E
         xslFkC8LZd0C+JPU4S5S1SCN5oSyBxzrdNjNz4UIHenoSBXvtj9OW6/4WjlJy1pRlq5g
         AaBxHW8nyRr51v2IUHaUatjeSpk5uSEzB1B0Ww2MUaZJEd/ZO3mgqNhr4Z53VGJBU4Xq
         +1Ac0J2UjDb1u/gZZ3rSG/3PhgCnXTDxhmPgPbdoX7h3ht3KWyBSNiKEDLqXgjTd6M4i
         KhYekKaP/88mcZn/FcCcaYZ79pu3ikCAWZRjRTZ9JXpWHf9zIBQplWoSaPU21AC1HNWP
         cjZw==
X-Gm-Message-State: AOJu0YxepQRk5Lx2nzM1TI2a2Jy29l+hdR7iJEuRx6UOf4HIFBm1htGC
	sRUZKGYAycZNdqR0kAB/tIHE88V5oNeCR1i6GPOpBvxGUEHmUU5Jf0h1CbFyVUEaf1K1BXNYkdU
	tfIlHZzQ6ne/Wp/PmmiwzN3GACP4/ZWvXcPIciA==
X-Google-Smtp-Source: AGHT+IECt+dt2Ziy/PTM+EArHkx1Bvs4Gzq7CEnrp1Zn/kQYVRsrW8esA7yZaLsgXKVslR5Ce+G4lZxydQo0kTj9bTU=
X-Received: by 2002:a05:6512:132a:b0:530:b871:eb9a with SMTP id
 2adb3069b0e04-53546b9648fmr2225279e87.47.1725050177356; Fri, 30 Aug 2024
 13:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 30 Aug 2024 13:36:04 -0700
Message-ID: <CAPPBnEaQ0fsEUScKRrsB52KVw-1E6LRtTX6B6TYyAh3zygEqmQ@mail.gmail.com>
Subject: Potential deadlock in bpf lru percpu hash map
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool to perform static analysis on the bpf
subsystem to detect locking violations. Our tool reported the
raw_spin_lock_irqsave() in bpf_percpu_lru_push_free(). This function
is used by htab_lru_percpu_map_update_elem() and
htab_lru_percpu_map_delete_elem(),
both of which can be called from NMI. A deadlock can happen if a bpf
program holding the lock is interrupted by the same program in NMI.
The report was generated for kernel version 6.6-rc4, however, we
believe this should still exist in the latest kernel.

We tried to validate the report on v6.10 by running a PoC. Below is
the lockdep splat. The PoC is attached at the end.

While executing the PoC, lockdep makes two other reports. The first one
is for the raw_spin_lock_irqsave() usage in bpf_percpu_lru_pop_free()
for similar reasons to the above issue. The second report is on the
spin_lock used in htab_lock_bucket() which we believe to be a false
positive.

Thanks,
Priya

[  141.668340] ================================
[  141.668343] WARNING: inconsistent lock state
[  141.668345] 6.10.0-rc6+ #5 Not tainted
[  141.668349] --------------------------------
[  141.668355] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  141.668358] lru_percpu_perf/1176 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  141.668363] ffffe8fffc631e98 (&l->lock){....}-{2:2}, at:
bpf_lru_push_free+0xf7/0x510
[  141.668410] {INITIAL USE} state was registered at:
[  141.668413]   lock_acquire+0x1cf/0x5a0
[  141.668427]   _raw_spin_lock_irqsave+0x57/0xa0
[  141.668448]   bpf_lru_pop_free+0x5a3/0x1ef0
[  141.668452]   prealloc_lru_pop+0x24/0xd0
[  141.668459]   __htab_lru_percpu_map_update_elem+0x192/0x5c0
[  141.668466]   htab_lru_percpu_map_update_elem+0x15/0x20
[  141.668471]   bpf_prog_47d4157ca618f90f_lru_tp+0x61/0x8a
[  141.668476]   trace_call_bpf+0x235/0x820
[  141.668490]   perf_trace_run_bpf_submit+0x8a/0x230
[  141.668507]   perf_trace_kmalloc+0xee/0x140
[  141.668515]   trace_kmalloc+0x71/0xc0
[  141.668523]   kmalloc_trace_noprof+0x1ab/0x350
[  141.668529]   kernfs_iop_get_link+0x67/0x6c0
[  141.668540]   vfs_readlink+0x1c4/0x440
[  141.668550]   do_readlinkat+0x1e9/0x2d0
[  141.668561]   __x64_sys_readlinkat+0x9a/0x100
[  141.668565]   x64_sys_call+0x1b3d/0x20d0
[  141.668571]   do_syscall_64+0x8b/0x140
[  141.668578]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  141.668590] irq event stamp: 24434
[  141.668593] hardirqs last  enabled at (24433): [<ffffffff840d831f>]
irqentry_exit+0x6f/0xa0
[  141.668602] hardirqs last disabled at (24434): [<ffffffff840d3a76>]
exc_nmi+0x106/0x2a0
[  141.668606] softirqs last  enabled at (24430): [<ffffffff81245219>]
__irq_exit_rcu+0xa9/0x120
[  141.668619] softirqs last disabled at (24423): [<ffffffff81245219>]
__irq_exit_rcu+0xa9/0x120
[  141.668623]
               other info that might help us debug this:
[  141.668625]  Possible unsafe locking scenario:

[  141.668627]        CPU0
[  141.668628]        ----
[  141.668630]   lock(&l->lock);
[  141.668633]   <Interrupt>
[  141.668635]     lock(&l->lock);
[  141.668638]
                *** DEADLOCK ***

[  141.668640] no locks held by lru_percpu_perf/1176.
[  141.668642]
               stack backtrace:
[  141.668645] CPU: 2 PID: 1176 Comm: lru_percpu_perf Not tainted 6.10.0-rc6+ #5
[  141.668650] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  141.668654] Call Trace:
[  141.668660]  <TASK>
[  141.668665]  dump_stack_lvl+0x9f/0xf0
[  141.668681]  dump_stack+0x14/0x20
[  141.668686]  print_usage_bug.part.0+0x3ff/0x680
[  141.668694]  lock_acquire+0x4e1/0x5a0
[  141.668700]  ? __pfx_lock_acquire+0x10/0x10
[  141.668705]  ? bpf_lru_push_free+0xf7/0x510
[  141.668712]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[  141.668722]  _raw_spin_lock_irqsave+0x57/0xa0
[  141.668727]  ? bpf_lru_push_free+0xf7/0x510
[  141.668733]  bpf_lru_push_free+0xf7/0x510
[  141.668740]  htab_lru_map_delete_elem+0x2f9/0x480
[  141.668751]  ? __pfx_htab_lru_map_delete_elem+0x10/0x10
[  141.668757]  ? __htab_map_lookup_elem+0x10a/0x180
[  141.668767]  bpf_prog_e20cb5f08e2ddbdc_lru_percpu_perf+0x71/0x97
[  141.668771]  __perf_event_overflow+0x239/0xb30
[  141.668776]  ? x86_perf_event_set_period+0x289/0x5c0
[  141.668787]  ? __pfx___perf_event_overflow+0x10/0x10
[  141.668798]  perf_event_overflow+0x1d/0x30
[  141.668803]  handle_pmi_common+0x540/0xa10
[  141.668813]  ? __lock_acquire+0x17f3/0x6630
[  141.668821]  ? __pfx_handle_pmi_common+0x10/0x10
[  141.668828]  ? __pfx___lock_acquire+0x10/0x10
[  141.668837]  ? kvm_sched_clock_read+0x15/0x30
[  141.668842]  ? sched_clock_noinstr+0xd/0x20
[  141.668847]  ? __this_cpu_preempt_check+0x17/0x20
[  141.668856]  ? __pfx_lock_release+0x10/0x10
[  141.668861]  ? debug_smp_processor_id+0x1b/0x30
[  141.668866]  ? intel_bts_interrupt+0xf0/0x590
[  141.668872]  ? __pfx_intel_bts_interrupt+0x10/0x10
[  141.668878]  ? debug_smp_processor_id+0x1b/0x30
[  141.668885]  intel_pmu_handle_irq+0x23f/0xb10
[  141.668896]  perf_event_nmi_handler+0x42/0x70
[  141.668902]  nmi_handle+0x165/0x490
[  141.668916]  default_do_nmi+0x71/0x190
[  141.668922]  exc_nmi+0x1cd/0x2a0
[  141.668927]  asm_exc_nmi+0xbc/0x105
[  141.668932] RIP: 0033:0x564aaa53661f
[  141.669024] Code: 01 00 00 00 48 8d 05 f8 1b 03 00 48 89 c7 e8 d8
f6 ff ff eb 24 c7 85 f4 fd ff ff 01 00 00 00 c7 85 f8 fd ff ff 02 00
00 00 90 <0f> b6 05 23 9a 04 00 83 f0 01 84 c0 75 f2 90 48 83 bd 08 fe
ff ff
[  141.669029] RSP: 002b:00007fffa0cf2530 EFLAGS: 00000202
[  141.669037] RAX: 0000000000000001 RBX: 0000564aaa9cf0b8 RCX: 0000000000000000
[  141.669040] RDX: 0000000564aaa9ce RSI: 0000564aaa9cd010 RDI: 0000000000000007
[  141.669043] RBP: 00007fffa0cf2760 R08: 0000564aaa9cefe0 R09: 00000004aa9cd2e0
[  141.669046] R10: 0000000000000000 R11: 81ed7ccfaa334020 R12: 00007fffa0cf2878
[  141.669049] R13: 0000564aaa536084 R14: 0000564aaa57d9d8 R15: 00007fda3ab2d040
[  141.669060]  </TASK>

The lockdep warning can be triggered using the following bpf and user programs.
============================================================

#include "vmlinux.h"
#include <linux/version.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>

struct {
        __uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
        __type(key, int);
        __type(value,int);
        __uint(max_entries, 255);
        __uint(map_flags, 2);
} pb SEC(".maps");

SEC("perf_event")
int lru_percpu_perf(void *ctx)
{
        int key = 2;
        int init_val = 1;
        long *value;

        int i;
        bpf_map_update_elem(&pb, &key, &init_val, BPF_ANY);
        value = bpf_map_lookup_elem(&pb, &key);
        int ret = bpf_map_delete_elem(&pb, &key);

        return 0;
}

SEC("kprobe/do_nanosleep")
int lru_kprobe(void *ctx)
{
        int key = 2;
        int init_val = 1;
        long *value;

        int i;
        bpf_map_update_elem(&pb, &key, &init_val, BPF_ANY);
        value = bpf_map_lookup_elem(&pb, &key);
        int ret = bpf_map_delete_elem(&pb, &key);
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
#include "lru_percpu_perf.skel.h"


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
        struct lru_percpu_perf_bpf *skel = NULL;
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


        snprintf(filename, sizeof(filename), ".output/lru_percpu_perf.bpf.o");
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
        for (i = 0; i < num_cpus; i++) {
                pefds[i] = -1;
        }

        links = calloc(num_cpus, sizeof(struct bpf_link *));


        memset(&attr, 0, sizeof(attr));


        attr.type = PERF_TYPE_HARDWARE;
        attr.config = PERF_COUNT_HW_CPU_CYCLES;
        attr.sample_freq = 10;
        attr.inherit = 1;
        attr.freq = 1;
        for (cpu = 0; cpu < 2; cpu++) {
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


                prog = bpf_object__find_program_by_name(obj, "lru_percpu_perf");
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
        struct bpf_link *link_kprobe;
        prog2 = bpf_object__find_program_by_name(obj, "lru_kprobe");
        if (!prog2) {
                fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
                goto cleanup;
        }
        link_kprobe = bpf_program__attach(prog2);
        if (!link_kprobe) {
                err = -1;
                fprintf(stderr, "ERROR: bpf_program__attach failed for
lru_percpu_perf_kprobe\nn");
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


        lru_percpu_perf_bpf__destroy(skel);
        free(online_mask);
        return -err;
}

