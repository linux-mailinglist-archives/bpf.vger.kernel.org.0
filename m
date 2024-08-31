Return-Path: <bpf+bounces-38643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D4966E64
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 03:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A51BB23294
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B320326;
	Sat, 31 Aug 2024 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="SZ/topFM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C76AB8
	for <bpf@vger.kernel.org>; Sat, 31 Aug 2024 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725067063; cv=none; b=WY4lJ8iT75JLRCchhVapZGYQya4CrUTvxpClyftgxUaL/AdEcIFSxrr/BbghDInu07TQnHkd5YE9bCu0kF+SjNsJbPVDaLVprj6/bpwxl5zVCCO2aO44zbpdPbQWDeNS0DJcTAkJYxzLC60btUvcaWBS7OmTI2MXs7UTOF9yjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725067063; c=relaxed/simple;
	bh=qahCoxrN5KKXEREUJ/K5zCBSOc8Ahf5AFuCO3FhYzpg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ey5Y/wStX40G6USXPfiQ12RIt4aLJ4JP2FbiTIrzjphfTTKCyu+8ceplch217nLcnVFrPiSqZMNs/+naC18Mgi0h0AfdDcAXgTK7HPe+bBF+kdTnEpBCZvJZXVr9WswgUhZUPjMipDZU4IC/pW/8ehvr81Q2HvuVuqVSg3laQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=SZ/topFM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso28537761fa.2
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1725067060; x=1725671860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wci12u5GwCvBYTWjfXcQmv/peV8J2K2K8uLvwG2D1SM=;
        b=SZ/topFMmyXxwxY11hdWwnBmekd0nbW+NAsCB1/UbQX7m0w/28gYev0FQmshCRVrNy
         04XcCZCDpOV8BBlLYGACs60yucJhhsqeCJLunk7UXtL9q/gAG7qq98PO6PV/mUVX3m4k
         P8/TDhQQzN+RvU+Swq1+sp69S0KGh0g1inyjSP3WWii7DeYtydgJMGSHLelYDnMBW6AT
         dRMT1bEBKZTI7eARiALSneJDmmTf43NMo2efucrBsB0WrwdHF0yYNZ1kmfCoMJBjbFwF
         Mic/enQ2D0QcOTJIA9QoQ82WQ3BJ4TzCu4D1GS8GHl+iFXwNvr6e8ZkIZVeV3SwyjTaQ
         x2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725067060; x=1725671860;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wci12u5GwCvBYTWjfXcQmv/peV8J2K2K8uLvwG2D1SM=;
        b=mOhq1v36/3uwuJoTLwj1vSb//F1t6RGAnE/RY8hdTbMtv4h6ewQjtBJRWNxwHij3J/
         9Oub8h98pqkauoNbGr2RmiTwt6nZhVMNdFYwGLerfU7yj9ORjUuaYBGLxtNWtvWoeB6d
         oqPI+ittGibqro7eZAS5CsAOndwvTBZgNTWDffTy66iAEPeNMbp6GVsYMP6Qm5bT+7dJ
         razOB3LZh/tys4xdHBTNIgDAUKjq1CtIDlJG1BSH9UqALlEwL5p96GNa2fQrqFtplByp
         cEXI2LyuVCXUM8g7fHI9f3PyVl5PvOqa216sY2dCi5GiAbenboNQ8P5cxXvA5FPg2EAG
         hmng==
X-Gm-Message-State: AOJu0YxNT35AfLyD1BjWgjk/2UtBNU1zSvVpmMg0jwxq7fE/ogmRCGZ7
	VFgV4R68oh31PSvHrzrBpApY++19R1D1WLQN0z764hP5j61kcsPyYEkLEgrwi60lsQRGjsS/KNE
	K7bLMxPizGMOv4w9cBnutlXdG+jmB70bhp24Pew==
X-Google-Smtp-Source: AGHT+IEGLKoycI9KubQ9HK/eIrr5GCgg3Ds4Mzm95RZ4Jiu/U0jSVnFA/FOpgQfWV2WczMXCrmj1ts60qGGW3Ar+sVI=
X-Received: by 2002:a05:651c:2226:b0:2f4:fc55:e514 with SMTP id
 38308e7fff4ca-2f6105c497bmr67338151fa.1.1725067059365; Fri, 30 Aug 2024
 18:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 30 Aug 2024 18:17:26 -0700
Message-ID: <CAPPBnEZQOVp19ESv35wZpmXzcrJmcCdt-H_0KirAtA6SCdMqoA@mail.gmail.com>
Subject: Possible deadlock in __percpu_counter_sum
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool called Spinner to detect locking violations
in the bpf subsytem. Spinner reported the raw_spin_lock_irqsave() in
__percpu_counter_sum(). This function is used by
htab_percpu_map_update_elem() which can be called from NMI. A deadlock
can happen if a bpf program holding the lock is interrupted by another
program in NMI that tries to acquire the same lock. The report was
generated for kernel version 6.6-rc4, however, we believe this should
still exist in the latest kernel.

We tried to validate the report on v6.10 by running a PoC. Below is
the lockdep splat. The PoC is attached at the end.

While executing the PoC, lockdep makes another report for the
spin_lock used in htab_lock_bucket() which we believe to be a false
positive.

Thanks,
Priya

[  160.926882] ================================
[  160.926885] WARNING: inconsistent lock state
[  160.926888] 6.10.0-rc7+ #62 Not tainted
[  160.926891] --------------------------------
[  160.926892] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  160.926894] percpu_perf/891 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  160.926897] ffff88811bef3460 (key#18){....}-{2:2}, at:
__percpu_counter_sum+0x1d/0x240
[  160.926933] {INITIAL USE} state was registered at:
[  160.926934]   lock_acquire+0x1be/0x560
[  160.926950]   _raw_spin_lock+0x3b/0x80
[  160.926953]   percpu_counter_add_batch+0xd4/0x180
[  160.926957]   alloc_htab_elem+0x452/0x820
[  160.926971]   __htab_percpu_map_update_elem+0x2bb/0x430
[  160.926974]   htab_percpu_map_update_elem+0x15/0x20
[  160.926977]   bpf_prog_07f21a982d6deb75_callback+0x88/0xf9
[  160.926981]   bpf_prog_18ed4d80ded39420_tp+0x82/0xa3
[  160.926983]   trace_call_bpf+0x24d/0x810
[  160.926988]   kprobe_perf_func+0x108/0x8c0
[  160.926991]   kprobe_dispatcher+0xbc/0x160
[  160.926994]   kprobe_ftrace_handler+0x2f3/0x4d0
[  160.927005]   e1000_init_module+0xe9/0xff0 [e1000]
[  160.927012]   do_nanosleep+0x1/0x470
[  160.927015]   common_nsleep+0x81/0xc0
[  160.927027]   __x64_sys_clock_nanosleep+0x2c5/0x4b0
[  160.927032]   x64_sys_call+0xf8d/0x1f20
[  160.927043]   do_syscall_64+0x8b/0x140
[  160.927052]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  160.927064] irq event stamp: 30332
[  160.927066] hardirqs last  enabled at (30331): [<ffffffff841cf30f>]
irqentry_exit+0x6f/0xa0
[  160.927074] hardirqs last disabled at (30332): [<ffffffff841caa46>]
exc_nmi+0x106/0x2a0
[  160.927077] softirqs last  enabled at (30300): [<ffffffff8124b309>]
__irq_exit_rcu+0xa9/0x120
[  160.927090] softirqs last disabled at (30285): [<ffffffff8124b309>]
__irq_exit_rcu+0xa9/0x120
[  160.927093]
               other info that might help us debug this:
[  160.927094]  Possible unsafe locking scenario:

[  160.927097]        CPU0
[  160.927098]        ----
[  160.927098]   lock(key#18);
[  160.927101]   <Interrupt>
[  160.927102]     lock(key#18);
[  160.927105]
                *** DEADLOCK ***

[  160.927106] no locks held by percpu_perf/891.
[  160.927107]
               stack backtrace:
[  160.927111] CPU: 0 PID: 891 Comm: percpu_perf Not tainted 6.10.0-rc7+ #62
[  160.927117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  160.927123] Call Trace:
[  160.927127]  <TASK>
[  160.927130]  dump_stack_lvl+0x9f/0xf0
[  160.927146]  dump_stack+0x14/0x20
[  160.927149]  print_usage_bug.part.0+0x408/0x690
[  160.927154]  lock_acquire+0x3ab/0x560
[  160.927157]  ? __pfx_lock_acquire+0x10/0x10
[  160.927160]  ? __percpu_counter_sum+0x1d/0x240
[  160.927166]  ? debug_smp_processor_id+0x1b/0x30
[  160.927170]  _raw_spin_lock_irqsave+0x55/0xa0
[  160.927174]  ? __percpu_counter_sum+0x1d/0x240
[  160.927178]  __percpu_counter_sum+0x1d/0x240
[  160.927182]  ? __kasan_check_write+0x18/0x20
[  160.927198]  ? do_raw_spin_trylock+0xbd/0x190
[  160.927203]  __percpu_counter_compare+0xaa/0xe0
[  160.927208]  alloc_htab_elem+0x5cf/0x820
[  160.927214]  __htab_percpu_map_update_elem+0x2bb/0x430
[  160.927219]  ? __pfx___htab_percpu_map_update_elem+0x10/0x10
[  160.927226]  htab_percpu_map_update_elem+0x15/0x20
[  160.927230]  bpf_prog_07f21a982d6deb75_callback+0x5e/0xf9
[  160.927234]  bpf_prog_72e9553d3d58c8e4_percpu_perf+0x82/0xa3
[  160.927237]  __perf_event_overflow+0x232/0xe40
[  160.927248]  ? x86_perf_event_set_period+0x268/0x560
[  160.927253]  ? __pfx___perf_event_overflow+0x10/0x10
[  160.927260]  perf_event_overflow+0x1d/0x30
[  160.927263]  handle_pmi_common+0x38a/0x9f0
[  160.927275]  ? __pfx_handle_pmi_common+0x10/0x10
[  160.927278]  ? __pfx___lock_acquire+0x10/0x10
[  160.927290]  ? __this_cpu_preempt_check+0x17/0x20
[  160.927293]  ? __pfx_intel_bts_interrupt+0x10/0x10
[  160.927298]  ? debug_smp_processor_id+0x1b/0x30
[  160.927302]  intel_pmu_handle_irq+0x24a/0xb20
[  160.927308]  perf_event_nmi_handler+0x40/0x60
[  160.927313]  nmi_handle+0x168/0x4a0
[  160.927325]  ? rcu_is_watching+0x17/0xd0
[  160.927336]  default_do_nmi+0x6e/0x180
[  160.927339]  exc_nmi+0x1cd/0x2a0
[  160.927343]  asm_exc_nmi+0xbc/0x105
[  160.927349] RIP: 0033:0x55b2aa57b606
[  160.927374] Code: ff ff ff ff 48 8b 05 59 9a 04 00 48 89 c1 ba 2a
00 00 00 be 01 00 00 00 48 8d 05 e5 1b 03 00 48 89 c7 e8 dd f6 ff ff
eb 10 90 <0f> b6 05 3c 9a 04 00 83 f0 01 84 c0 75 f2 90 48 83 bd 08 fe
ff ff
[  160.927376] RSP: 002b:00007ffed6967280 EFLAGS: 00000202
[  160.927384] RAX: 0000000000000001 RBX: 000055b2e3120920 RCX: 0000000000000000
[  160.927386] RDX: 0000000000000000 RSI: 000055b2e3120010 RDI: 0000000000000007
[  160.927388] RBP: 00007ffed69674b0 R08: 000055b2e3120860 R09: 00000004e31209f0
[  160.927390] R10: 0000000000000000 R11: c6adc1486b287952 R12: 00007ffed69675c8
[  160.927391] R13: 000055b2aa57b084 R14: 000055b2aa5c29d8 R15: 00007f5564e04040
[  160.927400]  </TASK>

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
        __uint(max_entries, 66);
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

        bpf_map_update_elem(&pb, &i, &value, BPF_ANY);
        i+=1;


        bpf_map_delete_elem(&pb, &j);
                j+=1;

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
        bpf_printk("kprobe");
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
                fprintf(stderr, "ERROR: bpf_program__attach failed\nn");
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

