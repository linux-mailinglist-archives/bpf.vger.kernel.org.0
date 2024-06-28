Return-Path: <bpf+bounces-33373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038CA91C64A
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241411C230AE
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19751C5A;
	Fri, 28 Jun 2024 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="JDp4Mi4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225783CF5E
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601367; cv=none; b=rmuEdYEML1jaPGGR3XMtkXkPhdYAh503BkupcjVaHKI3H4IBelI9ckgXUSm+ra7MBteEWidfjQsme6UqqSVIn97YG0jAGaQvoopWOSqqHbsV/jVQ2QQZMavVAsbPjXh9PrgJWaKdjQV5ft4/KO+XbAlJlNIwjxwHh4DptA05/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601367; c=relaxed/simple;
	bh=6g63XaDAhZEbSALVbQmj4C9sdc5RKOryndQ6YiENh5k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tG2XlewSEnanv2ZtXyhYgMW6HgMI3xtIA5nrryBldro8MgYudU0wUmCBSwmg/e8mTWNiyDzOub5nSWxQiKDLE/Jg0fBrgbW093u1qUsIUpPrDZaqyaQf7uuGHzwefqz3pB3JhBffTY6cnu+7X7yrCd0c+XwbIqSs9+cwK5G4p+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=JDp4Mi4B; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec50d4e47bso10082621fa.2
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1719601363; x=1720206163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I+zleys4uDJE4zNkRKK8V6oi/lrC9nOWCQt0KPSpRoQ=;
        b=JDp4Mi4BJVmLFascKMvkiXYE1TExux/tnic9oNZ/1EicbAyIXzVxMwsgCao2fMqnXu
         iZxDH7PW2ysLmxc3C3fsnp/6LR8qZKybNwp7VL2HP0WR01OhVUJb5ofsXsgYcf6KRC1k
         /9b1y6TstgKcrqchzWUqjebL096jvYQ/hiTeugrDsFWQHaHxJ1ty/W+cY5KsK2On4W/s
         PSFJ4nAXAfxUsbL/O81QxCttUBxY1r4Rny2O1ytCyZXEpleYiKuU1KIBsZkYOVYYB0B5
         +QskvVf5t7vDnSlYk+pn6NS6XbxiY6Wy1/ix9UlEnKAbbnnFfSPj8Eg9/dZNHop8ThYG
         BH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601363; x=1720206163;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+zleys4uDJE4zNkRKK8V6oi/lrC9nOWCQt0KPSpRoQ=;
        b=eDdVnZOYrYpHqy6mfCCMJnIBeJSyfZmwfaMyfiCirJv2eDEOkhCFWz5uN8GtHcGeCw
         /R9ZW51EIBwWYb99MJzKvj55FMQRlhlKl4cG0t6R0R6zLXZn8MwGKhvpKckZ49E0WmFp
         58Xizp7mmaB33cjf6iAqIqdY7SOWimn5W2SHuTFRPf1wm+HUgevrGhch3QnALEYrLg2g
         6Do4gY8UBcViU3uhAKZZJtddGehMUF6ISK019Chiz5LdotNsJ24lF33KQ5AQfn5xE6Nw
         yIaEWcOjEVMHp/hZKH8F25HWfs6uxxn+kZ3/dyunAB/wrWn9l1lH50kJZqLent8oRoCc
         nhKQ==
X-Gm-Message-State: AOJu0YyCYLQpUZiBELNu1Ihk3Eo3LR+6u1aKoAcvLy2A8aM1NeICYMOS
	PwnmuwRWNTJIjT7fY2wEVdLsMZKh5MNYqXA90Nyg54/qC4OJiyTzwINYo1bIG0k5UL7783M3ByQ
	Bi5oIt6dNVCEtzmARfV3jzR08lnvqsj75iZvBeA==
X-Google-Smtp-Source: AGHT+IFVmkeKN2KvGd/YZ64dr/IBffYOvgIzPTJc81S4AdAkGcH7ykWaffAcAKFMux6IyzbuK45FIk2KdSEKWTgU8OA=
X-Received: by 2002:a2e:97d1:0:b0:2ec:5488:ccaf with SMTP id
 38308e7fff4ca-2ec5b2dd95dmr99108181fa.35.1719601363125; Fri, 28 Jun 2024
 12:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 28 Jun 2024 12:02:30 -0700
Message-ID: <CAPPBnEZBUWnRQ+mWpHXn2t7cfn=RVuWQZ_ojQte0gQpksus1Gw@mail.gmail.com>
Subject: Potential deadlock in bpf_htab_lru
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Hsin-Wei Hung <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool to perform static analysis on the bpf
subsystem to detect locking violations. Our tool reported the
raw_spin_lock_irqsave() in bpf_common_push_free(). This function is
used by htab_lru_map_update_elem() and htab_lru_map_delete_elem()
which can be called from an NMI. A deadlock can happen if a bpf
program holding the lock is interrupted by the same program in NMI.
The report was generated for kernel version 6.6-rc4, however, we
believe this should still exist in the latest kernel.

We tried to validate the report on v6.7 by running a PoC. Below is the
lockdep splat. The PoC is attached at the end.

I am also copying Hsin-Wei who is involved in developing the tool.

Thanks,
Priya


[  698.417248] ================================
[  698.417255] WARNING: inconsistent lock state
[  698.417258] 6.7.0-dirty #8 Not tainted
[  698.417265] --------------------------------
[  698.417268] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  698.417273] lru_perf/1064 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  698.417290] ffffe8fffc227ac0 (&loc_l->lock){....}-{2:2}, at:
bpf_lru_pop_free+0x2fb/0x13a0
[  698.417379] {INITIAL USE} state was registered at:
[  698.417384]   lock_acquire+0x193/0x4c0
[  698.417425]   _raw_spin_lock_irqsave+0x3f/0x90
[  698.417475]   bpf_lru_pop_free+0x2fb/0x13a0
[  698.417487]   htab_lru_map_update_elem+0x16e/0xcb0
[  698.417507]   bpf_prog_47d4157ca618f90f_lru_tp+0x61/0xa1
[  698.417522]   trace_call_bpf+0x273/0x920
[  698.417553]   perf_trace_run_bpf_submit+0x8f/0x1c0
[  698.417582]   perf_trace_sched_switch+0x5c9/0x9c0
[  698.417608]   __traceiter_sched_switch+0x6f/0xc0
[  698.417626]   __schedule+0xae0/0x2ae0
[  698.417647]   __cond_resched+0x46/0x70
[  698.417661]   down_read+0x7f/0x350
[  698.417677]   kernfs_iop_permission+0xc2/0x130
[  698.417715]   inode_permission+0x38f/0x5f0
[  698.417752]   link_path_walk.part.0.constprop.0+0x821/0xcf0
[  698.417773]   path_lookupat+0x92/0x770
[  698.417783]   path_openat+0x1cc3/0x2690
[  698.417794]   do_filp_open+0x1c9/0x420
[  698.417806]   do_sys_openat2+0x164/0x1d0
[  698.417830]   __x64_sys_openat+0x140/0x1f0
[  698.417850]   do_syscall_64+0x46/0xf0
[  698.417876]   entry_SYSCALL_64_after_hwframe+0x6f/0x77
[  698.417929] irq event stamp: 33026
[  698.417933] hardirqs last  enabled at (33025): [<ffffffff8480144a>]
asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  698.417951] hardirqs last disabled at (33026): [<ffffffff8478ca89>]
exc_nmi+0x159/0x200
[  698.417966] softirqs last  enabled at (33022): [<ffffffff847b5541>]
__do_softirq+0x4e1/0x73e
[  698.417990] softirqs last disabled at (33015): [<ffffffff811ab473>]
irq_exit_rcu+0x93/0xc0
[  698.418013]
[  698.418013] other info that might help us debug this:
[  698.418020]  Possible unsafe locking scenario:
[  698.418020]
[  698.418023]        CPU0
[  698.418025]        ----
[  698.418026]   lock(&loc_l->lock);
[  698.418034]   <Interrupt>
[  698.418035]     lock(&loc_l->lock);
[  698.418042]
[  698.418042]  *** DEADLOCK ***
[  698.418042]
[  698.418044] no locks held by lru_perf/1064.
[  698.418049]
[  698.418049] stack backtrace:
[  698.418057] CPU: 1 PID: 1064 Comm: lru_perf Not tainted 6.7.0-dirty #8
[  698.418070] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  698.418078] Call Trace:
[  698.418091]  <TASK>
[  698.418097]  dump_stack_lvl+0x91/0xf0
[  698.418129]  lock_acquire+0x35b/0x4c0
[  698.418150]  ? __pfx_lock_acquire+0x10/0x10
[  698.418169]  ? bpf_lru_pop_free+0x2fb/0x13a0
[  698.418185]  ? trace_event_raw_event_bpf_trace_printk+0x14a/0x210
[  698.418201]  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
[  698.418216]  ? bstr_printf+0x348/0xf40
[  698.418243]  _raw_spin_lock_irqsave+0x3f/0x90
[  698.418258]  ? bpf_lru_pop_free+0x2fb/0x13a0
[  698.418273]  bpf_lru_pop_free+0x2fb/0x13a0
[  698.418292]  ? __pfx_bpf_trace_printk+0x10/0x10
[  698.418308]  htab_lru_map_update_elem+0x16e/0xcb0
[  698.418324]  ? perf_prepare_sample+0x16b/0x2060
[  698.418339]  ? perf_event_update_userpage+0x4db/0x800
[  698.418370]  bpf_prog_73160903ac17fb89_lru_perf+0x61/0xa1
[  698.418387]  bpf_overflow_handler+0x184/0x4a0
[  698.418404]  ? __pfx_bpf_overflow_handler+0x10/0x10
[  698.418425]  __perf_event_overflow+0x4c2/0x9e0
[  698.418445]  handle_pmi_common+0x4d7/0x800
[  698.418481]  ? hlock_class+0x4e/0x140
[  698.418496]  ? __lock_acquire+0x150a/0x3b10
[  698.418518]  ? __pfx_handle_pmi_common+0x10/0x10
[  698.418540]  ? __hrtimer_run_queues+0x1ef/0xa00
[  698.418576]  ? hlock_class+0x4e/0x140
[  698.418591]  ? lock_release+0x587/0xaa0
[  698.418611]  ? __pfx_lock_release+0x10/0x10
[  698.418632]  ? hlock_class+0x4e/0x140
[  698.418646]  ? look_up_lock_class+0x56/0x140
[  698.418664]  ? lock_acquire+0x272/0x4c0
[  698.418682]  ? intel_bts_interrupt+0x115/0x3e0
[  698.418707]  intel_pmu_handle_irq+0x246/0xd90
[  698.418729]  perf_event_nmi_handler+0x4c/0x70
[  698.418750]  nmi_handle+0x1a6/0x520
[  698.418785]  default_do_nmi+0x64/0x1c0
[  698.418801]  exc_nmi+0x187/0x200
[  698.418815]  asm_exc_nmi+0xb6/0xff
[  698.418829] RIP: 0033:0x55f642e8460b
[  698.418840] Code: ff ff ff ff 48 8b 05 54 9a 04 00 48 89 c1 ba 2d
00 00 00 be 01 00 00 00 48 8d 05 e8 1b 03 00 48 89 c7 e8 d8 f6 ff ff
eb 10 90 <0f> b6 05 37 9a 04 00 83 f0 01 84 c0 75 f2 90 48 83 bd 08 fe
ff ff
[  698.418853] RSP: 002b:00007ffc89e99de0 EFLAGS: 00000202
[  698.418879] RAX: 0000000000000001 RBX: 000055f6439a7038 RCX: 0000000000000000
[  698.418888] RDX: 000000055f6439a6 RSI: 000055f6439a5010 RDI: 0000000000000007
[  698.418897] RBP: 00007ffc89e9a010 R08: 000055f6439a6f60 R09: 000055f6439a52e0
[  698.418906] R10: 0000000000000000 R11: b89c2540e1908856 R12: 00007ffc89e9a128
[  698.418914] R13: 000055f642e84084 R14: 000055f642ecb9d8 R15: 00007f68b8e01040
[  698.418933]  </TASK>

The lockdep warning can be triggered using the following user and bpf programs.
================================

#include <unistd.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <sys/resource.h>
#include <signal.h>
#include "lru_perf.skel.h"


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
        struct lru_perf_bpf *skel = NULL;
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


        snprintf(filename, sizeof(filename), ".output/lru_perf.bpf.o");

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


                prog = bpf_object__find_program_by_name(obj, "lru_perf");
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


        lru_perf_bpf__destroy(skel);
        free(online_mask);
        return -err;
}

==============================
#include "vmlinux.h"
#include <linux/version.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>


#define MAX_ENTRIES 1000
#define MAX_NR_CPUS 1024
#define TASK_COMM_LEN 16
#define MAX_FILENAME_LEN 512


struct {
        __uint(type, BPF_MAP_TYPE_LRU_HASH);
        __type(key, int);
        __type(value,int);
        __uint(max_entries, 255);
} pb SEC(".maps");

SEC("perf_event")
int lru_perf(void *ctx)
{
        int key = 2;
        int init_val = 1;
        long *value;

        int i;
        bpf_printk("lru_perf");
        bpf_map_update_elem(&pb, &key, &init_val, BPF_ANY);
        value = bpf_map_lookup_elem(&pb, &key);
        int ret = bpf_map_delete_elem(&pb, &key);

        return 0;
}

