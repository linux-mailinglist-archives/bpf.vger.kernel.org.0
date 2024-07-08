Return-Path: <bpf+bounces-34096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0108892A72B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232411C20E76
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3231459F1;
	Mon,  8 Jul 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="mYemVbsR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677B1419B5
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455690; cv=none; b=pUzWaA2kZ+b5/63irkwP6C35yjiEiqSP5na+qLHQemDCcMU+KZqlE3PgdAr+hsG5l8gYwq0TINBGkfN8NlZ60xWRMvKpekmS6HQS2fSODqlZKW9tkZrji9xTQxolOv5yWUxAGyBT5GkhaNG41mZWWg5Hvg8cRjWUGwimdzUBYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455690; c=relaxed/simple;
	bh=nIXeCELq+WAMEWgS4UDY4KdvxMwaGw9PnHA55LjZCSk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NRxhCTVCatkQg7bV0tQS0G9H8PEJenvXIpGxhmG6B8k01zC6aWb5UKHzmolc+2F2l2u1nFMNI7DIUDWW/8XqekRNTZ9Lh0/MRJ+OlsCFsqEszOohZjz+uRk7q7j14jc/fCtL9QTDzEaB3DXPVi2AXmj4cDXffgB/anQ9VHOT2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=mYemVbsR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so52203341fa.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1720455687; x=1721060487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zVc4dSDe/xnl0bTg0ay5gjGcIyqkRFlsJXsf+6fDdCc=;
        b=mYemVbsR5z+BN9r3rI15iUi9n69J+6rgitx/5eMDlGiDfnXAB1MsEfie8y5vCcLeIk
         joLW5ZyPYrM0VuXEdxHwoaPnWxr9HjPwBAZ6HGskgIQAFGg8ksMXaTT/mtx1Wkktt4LI
         jtMgC8REOFzWff1FSIptxfUoMVWprucnKrnIs3Jzcyoge6m58HIsZ9y4lPN5gRfe/Ae1
         +xavdzOHg3sbbhbcAbbJQHFY1r7q3idaVYazuOD4dxJzu5Qi0j0jwmUGGzkgJzAYkL0/
         P2LN+lENopvgCPxoAZQKvNuQrXk6ycB/pi8dcGjSqEqwULB/hdQhuet0ovWsgWx7DbN+
         8evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455687; x=1721060487;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVc4dSDe/xnl0bTg0ay5gjGcIyqkRFlsJXsf+6fDdCc=;
        b=p8+WfAVLrbJcDV5lz1Q3q1WMp4ALTW2rOKVNf8YP7gPS1sxsONG84QihmKLjrj/KTl
         yiLv9OEjBYhObel/x9Cm9fZmVCVm6EIkiGSdzEpezhN92HzIoS4jZp4en7YCOJyXPoPO
         PBrlKRFkOBrHDt5keSoJsH7bwOcl1jp8htJurcCIXeR5G2nqsAxBrx+TPyDnbNGz7qP3
         +/6w0AU2VTuYZ2jRG5EoWRZGdUDTEBz7FiYxqhiMfDJ4vCC750vpey8Oh+37jYw2DxZn
         zGRNqPOmXmhy5jAGLeeE40iAfNlX53gEfpM6+Zvt1rD+c2i5X4mYaUg5B7mU2giM29ca
         LFNQ==
X-Gm-Message-State: AOJu0YyNe8AkWcTBV34n300IcNMEsi5gUl3DLb07+oJ7/SXEUC3RGPIM
	oGxyGx6AUrZPMFSuVUGYSdzBD3jXz4DtisaRj5rY4T9VkENTmdNKlXNcN0QMQ5n0LXUwMykIqF+
	bElkDrpEFOJOER2EwxYCi6IFm1QmnUzbKoiivaw==
X-Google-Smtp-Source: AGHT+IFV5oPNoR2uV5xdRPdkFbS1nV9gGmcFk5xr+nTd0KyYqKaqL9r76nvGCFAMol2x3a+EN0TTz9y5GhXsVSj4Rg4=
X-Received: by 2002:a2e:9643:0:b0:2ee:811a:54a0 with SMTP id
 38308e7fff4ca-2eeb30d9d4bmr1376241fa.14.1720455686977; Mon, 08 Jul 2024
 09:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Mon, 8 Jul 2024 09:21:15 -0700
Message-ID: <CAPPBnEYv7kmVnFurrtgBzTzcpA8MiGFdWVSfD-ZAx2SK_667XQ@mail.gmail.com>
Subject: Potential deadlock in bpf_htab_percpu_lru
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool to perform static analysis on the bpf
subsystem to detect locking violations. Our tool reported the
raw_spin_lock_irqsave() in bpf_percpu_lru_pop_free(). This function is
used by htab_percpu_lru_map_update_elem() which can be called from an
NMI. A deadlock can happen if a bpf program holding the lock is
interrupted by the same program in NMI. The report was generated for
kernel version 6.6-rc4, however, we believe this should still exist in
the latest kernel.

We tried to validate the report on v6.7 by running a PoC. Below is the
lockdep splat. The PoC is attached at the end.

Thanks,
Priya

[ 1051.101034] ================================
[ 1051.101037] WARNING: inconsistent lock state
[ 1051.101040] 6.7.0-dirty #14 Not tainted
[ 1051.101048] --------------------------------
[ 1051.101051] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[ 1051.101056] lru_percpu_perf/1263 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 1051.101071] ffffe8fffc22cdd8 (&l->lock){....}-{2:2}, at:
bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101129] {INITIAL USE} state was registered at:
[ 1051.101134]   lock_acquire+0x193/0x4c0
[ 1051.101153]   _raw_spin_lock_irqsave+0x3f/0x90
[ 1051.101167]   bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101179]   __htab_lru_percpu_map_update_elem+0x177/0xa20
[ 1051.101197]   bpf_prog_47d4157ca618f90f_lru_tp+0x61/0x8a
[ 1051.101215]   trace_call_bpf+0x273/0x920
[ 1051.101229]   perf_trace_run_bpf_submit+0x8f/0x1c0
[ 1051.101243]   perf_trace_sched_switch+0x5c9/0x9c0
[ 1051.101255]   __traceiter_sched_switch+0x6f/0xc0
[ 1051.101268]   __schedule+0xae0/0x2ae0
[ 1051.101282]   schedule+0xe6/0x270
[ 1051.101295]   exit_to_user_mode_prepare+0x97/0x190
[ 1051.101314]   irqentry_exit_to_user_mode+0xa/0x30
[ 1051.101331]   asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1051.101344] irq event stamp: 39528
[ 1051.101348] hardirqs last  enabled at (39527): [<ffffffff8480144a>]
asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1051.101365] hardirqs last disabled at (39528): [<ffffffff8478ca89>]
exc_nmi+0x159/0x200
[ 1051.101380] softirqs last  enabled at (39526): [<ffffffff847b5541>]
__do_softirq+0x4e1/0x73e
[ 1051.101399] softirqs last disabled at (39519): [<ffffffff811ab473>]
irq_exit_rcu+0x93/0xc0
[ 1051.101415]
[ 1051.101415] other info that might help us debug this:
[ 1051.101418]  Possible unsafe locking scenario:
[ 1051.101418]
[ 1051.101420]        CPU0
[ 1051.101422]        ----
[ 1051.101424]   lock(&l->lock);
[ 1051.101430]   <Interrupt>
[ 1051.101432]     lock(&l->lock);
[ 1051.101438]
[ 1051.101438]  *** DEADLOCK ***
[ 1051.101438]
[ 1051.101440] no locks held by lru_percpu_perf/1263.
[ 1051.101446]
[ 1051.101446] stack backtrace:
[ 1051.101452] CPU: 1 PID: 1263 Comm: lru_percpu_perf Not tainted
6.7.0-dirty #14
[ 1051.101466] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[ 1051.101474] Call Trace:
[ 1051.101482]  <TASK>
[ 1051.101488]  dump_stack_lvl+0x91/0xf0
[ 1051.101514]  lock_acquire+0x35b/0x4c0
[ 1051.101534]  ? __pfx_lock_acquire+0x10/0x10
[ 1051.101553]  ? bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101568]  ? trace_event_raw_event_bpf_trace_printk+0x14a/0x210
[ 1051.101584]  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
[ 1051.101599]  ? bstr_printf+0x348/0xf40
[ 1051.101621]  _raw_spin_lock_irqsave+0x3f/0x90
[ 1051.101636]  ? bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101650]  bpf_lru_pop_free+0xc1/0x13a0
[ 1051.101666]  ? trace_bpf_trace_printk+0x11d/0x140
[ 1051.101679]  ? bpf_bprintf_cleanup+0x66/0xd0
[ 1051.101693]  ? htab_map_hash+0x18e/0x880
[ 1051.101709]  __htab_lru_percpu_map_update_elem+0x177/0xa20
[ 1051.101734]  bpf_prog_af2271334a1c4e36_lru_percpu_perf+0x5d/0x61
[ 1051.101750]  bpf_overflow_handler+0x184/0x4a0
[ 1051.101765]  ? __pfx_bpf_overflow_handler+0x10/0x10
[ 1051.101786]  __perf_event_overflow+0x4c2/0x9e0
[ 1051.101806]  handle_pmi_common+0x4d7/0x800
[ 1051.101823]  ? __lock_acquire+0x150a/0x3b10
[ 1051.101845]  ? __pfx_handle_pmi_common+0x10/0x10
[ 1051.101867]  ? hlock_class+0x4e/0x140
[ 1051.101881]  ? lock_release+0x587/0xaa0
[ 1051.101901]  ? __pfx_lock_release+0x10/0x10
[ 1051.101920]  ? lock_is_held_type+0xa1/0x120
[ 1051.101939]  ? rcu_gpnum_ovf+0x12d/0x180
[ 1051.101958]  ? lockdep_hardirqs_on_prepare+0x12d/0x400
[ 1051.101980]  ? look_up_lock_class+0x56/0x140
[ 1051.101998]  ? lock_acquire+0x272/0x4c0
[ 1051.102016]  ? intel_bts_interrupt+0x115/0x3e0
[ 1051.102036]  intel_pmu_handle_irq+0x246/0xd90
[ 1051.102058]  perf_event_nmi_handler+0x4c/0x70
[ 1051.102073]  nmi_handle+0x1a6/0x520
[ 1051.102096]  default_do_nmi+0x64/0x1c0
[ 1051.102112]  exc_nmi+0x187/0x200
[ 1051.102126]  asm_exc_nmi+0xb6/0xff
[ 1051.102139] RIP: 0033:0x555fd93d960b
[ 1051.102150] Code: ff ff ff ff 48 8b 05 54 9a 04 00 48 89 c1 ba 2f
00 00 00 be 01 00 00 00 48 8d 05 f8 1b 03 00 48 89 c7 e8 d8 f6 ff ff
eb 10 90 <0f> b6 05 37 9a 04 00 83 f0 01 84 c0 75 f2 90 48 83 bd 08 fe
ff ff
[ 1051.102162] RSP: 002b:00007ffe81a6f6e0 EFLAGS: 00000202
[ 1051.102178] RAX: 0000000000000001 RBX: 0000555fdac9eee8 RCX: 0000000000000000
[ 1051.102187] RDX: 0000000555fdac9e RSI: 0000555fdac9d010 RDI: 0000000000000007
[ 1051.102196] RBP: 00007ffe81a6f910 R08: 0000555fdac9ee10 R09: 00000004dac9d2e0
[ 1051.102204] R10: 0000000000000000 R11: 08e02bbb6d91ca99 R12: 00007ffe81a6fa28
[ 1051.102213] R13: 0000555fd93d9084 R14: 0000555fd94209d8 R15: 00007fad2f48a040
[ 1051.102231]  </TASK>

The lockdep warning can be triggered using the following user and bpf programs.
================================

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

==============================

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

char _license[] SEC("license") = "GPL";

