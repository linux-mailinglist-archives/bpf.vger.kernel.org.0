Return-Path: <bpf+bounces-37400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43529552BD
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 23:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A928224A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908D1C57AE;
	Fri, 16 Aug 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="nUPQL2HT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD91C3F23
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845186; cv=none; b=O5Zk9EgtEkESmFRAFSZyCzCavrqLIaq6UIUUEBUljKwzq/3ZXC4lQaMQVFDFyTnyxstB3sSC2oq59zN75koS8SB84hL4hyW3RxuyY5Zkag/t4gmfR+WuvTVH+N0e+DQ4WFw8TeBIEAyn+UCdH4hIFCFG30E/7zmtqkN4R/uBnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845186; c=relaxed/simple;
	bh=CeV6BO4jDC0jFsJykYYH8Z4JGmBNmoRglMoXyTL+W9g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h1ZxaVAAJO/BfdHfGxSpO4aMzZBmBMDOnozEZtXhb9f6wTZASjOnJ/SPCWHFhuyGzlKGj/dpShOD137t36UzZfBn5Ywlqbe+ndh0IUw6/e2f5Fr2GmAyfxanl/tBRfttbLsNRrXhflJu2IhV3iG6HivGeLsXX0GjRuzKWafgChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=nUPQL2HT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso27686301fa.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1723845181; x=1724449981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AumvJOh2LJuR19mqkZHzHJzPdJWlA7JaI6AsZJJwS5s=;
        b=nUPQL2HT83ugVr6k1oPsayfC3aHhRXJIKN7HZ9tSkYnk0RLSbCfTntymmkyPbpZQ/T
         NxR+9+Y+kiMR/AORrrzVDt5dyRiEC/Z/R8zQlVvrFXLsf0Y288TCntqTHH6o0FffMHOC
         j/WtC/pdlrfPMLTB1a5HRB7s7ctFBrhjiWe3mgPgZ8dQvNGxS/YWa69ALhor2dryuPh0
         TwICFulUd4DOKa5rtmxkJSeijt6WmBtifD/YnTPtSnFEQ0jgv/zWCPm+MPGJEakcq2AY
         r3Pu9SLjocTHzo8IvJmFUnxfOa5bynsLYqgW3eiZ7gLQ/3kHagl8JiF1BwxSfk5Dzioo
         8Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723845181; x=1724449981;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AumvJOh2LJuR19mqkZHzHJzPdJWlA7JaI6AsZJJwS5s=;
        b=IqPTH5r+O57Cae9St3HjvWQXWq0Rn7W36IQpYqkAbIoH2wAUhm5vXZ4RA9dd4wkKzg
         5ACKy61hYkJEzQ7LYh2fuZQhSmP2GVVxu+xJruW46Kzf2C9knr5pO9ZCGIa3172Vvn37
         xh8wIZAXMXHGr6bjV2tsgAhNrai6SSU0qltmnx4i0rKsPtvUroOkTcUAUPjxreBrxuWK
         LF5skz1AZ12SXBuMnhNIOrpmKW6+mDAIHWLMlPK9A81vCVROv4e1pJDyxEnQX6alBnz9
         wQU75tJ9BRtv9fb5CqYSeU3tCBhHJydbBk0ajzZLBfYcvKiDL7OkKxLQHLTuMLowClel
         aPYQ==
X-Gm-Message-State: AOJu0Yyx/5DEXFGYhXAlqoFkEcfN8t2ZxT7U1yHL3AizcfH8nn23Or9S
	pIfW8LWtfQbxxkKseVFeVVSNQdNKTQrM/dytzAr/E/gNG4muMb5KkXXke599lFbLNUYylpOxAsb
	y+lkVgjSK1yoJ/ix9eunyR2XKPNvB8Y/LObYc0w==
X-Google-Smtp-Source: AGHT+IEydYN2MDwaQZnGZAUsPy87CPL5j6MLOw2f48LScqw8pNuOYDU6KNUoFoNVI2JRwTaptEw19KaoFOrKoAoMV2k=
X-Received: by 2002:a05:651c:542:b0:2ef:2ef5:ae98 with SMTP id
 38308e7fff4ca-2f3c8f259b7mr4922531fa.34.1723845180657; Fri, 16 Aug 2024
 14:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 16 Aug 2024 14:52:49 -0700
Message-ID: <CAPPBnEYgDtaOWYkk1rrMraZ4x3W-BQdi5nf2hURX8=xGxwr-1Q@mail.gmail.com>
Subject: Potential deadlock in bpf lru hash map
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Ardalan Amiri Sani <ardalan@uci.edu>, 
	Hsin-Wei Hung <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool to perform static analysis on the bpf
subsystem to detect locking violations. Our tool reported the
raw_spin_lock_irqsave() in bpf_common_lru_push_free(). This function
is used by htab_lru_map_update_elem() and htab_lru_map_delete_elem(),
both of which can be called from NMI. A deadlock can happen if a bpf
program holding the lock is interrupted by the same program in NMI.
The report was generated for kernel version 6.6-rc4, however, we
believe this should still exist in the latest kernel.

We tried to validate the report on v6.10 by running a PoC. Below is
the lockdep splat. The PoC is attached at the end.

While executing the PoC lockdep makes two other reports. The first one
is for the raw_spin_lock_irqsave() usage in bpf_common_lru_pop_free()
for similar reasons to the above issue. The second report is on the
spin_lock used in htab_lock_bucket() which we believe to be a false
positive.

Thanks,
Priya

[ 3796.222898] ================================
[ 3796.222904] WARNING: inconsistent lock state
[ 3796.222906] 6.10.0-rc7+ #14 Not tainted
[ 3796.222909] --------------------------------
[ 3796.222914] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[ 3796.222917] lru_perf/1458 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 3796.222923] ffffe8fffee26ab0 (&loc_l->lock){....}-{2:2}, at:
bpf_lru_push_free+0x241/0x510
[ 3796.222997] {INITIAL USE} state was registered at:
[ 3796.223000]   lock_acquire+0x1cf/0x5a0
[ 3796.223024]   _raw_spin_lock_irqsave+0x57/0xa0
[ 3796.223058]   bpf_lru_pop_free+0x5e5/0x1e00
[ 3796.223063]   prealloc_lru_pop+0x24/0xd0
[ 3796.223073]   htab_lru_map_update_elem+0x18d/0x810
[ 3796.223078]   bpf_prog_47d4157ca618f90f_lru_tp+0x61/0xa1
[ 3796.223087]   trace_call_bpf+0x235/0x820
[ 3796.223097]   perf_trace_run_bpf_submit+0x8a/0x230
[ 3796.223122]   perf_trace_sched_switch+0x4c6/0x760
[ 3796.223142]   __traceiter_sched_switch+0x77/0xe0
[ 3796.223155]   __schedule+0x2109/0x6090
[ 3796.223171]   schedule+0xf6/0x410
[ 3796.223175]   irqentry_exit_to_user_mode+0xdb/0x210
[ 3796.223190]   irqentry_exit+0x6f/0xa0
[ 3796.223195]   sysvec_apic_timer_interrupt+0x5b/0xc0
[ 3796.223199]   asm_sysvec_apic_timer_interrupt+0x1f/0x30
[ 3796.223212] irq event stamp: 20004
[ 3796.223214] hardirqs last  enabled at (20003): [<ffffffff8410631f>]
irqentry_exit+0x6f/0xa0
[ 3796.223220] hardirqs last disabled at (20004): [<ffffffff84101a76>]
exc_nmi+0x106/0x2a0
[ 3796.223226] softirqs last  enabled at (19984): [<ffffffff817c8c0c>]
bpf_perf_link_attach+0x33c/0x540
[ 3796.223235] softirqs last disabled at (19982): [<ffffffff817c8bcf>]
bpf_perf_link_attach+0x2ff/0x540
[ 3796.223239]
               other info that might help us debug this:
[ 3796.223244]  Possible unsafe locking scenario:

[ 3796.223246]        CPU0
[ 3796.223248]        ----
[ 3796.223249]   lock(&loc_l->lock);
[ 3796.223253]   <Interrupt>
[ 3796.223254]     lock(&loc_l->lock);
[ 3796.223257]
                *** DEADLOCK ***

[ 3796.223259] no locks held by lru_perf/1458.
[ 3796.223261]
               stack backtrace:
[ 3796.223268] CPU: 12 PID: 1458 Comm: lru_perf Not tainted 6.10.0-rc7+ #14
[ 3796.223273] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[ 3796.223277] Call Trace:
[ 3796.223283]  <TASK>
[ 3796.223287]  dump_stack_lvl+0x9f/0xf0
[ 3796.223313]  dump_stack+0x14/0x20
[ 3796.223318]  print_usage_bug.part.0+0x3ff/0x680
[ 3796.223326]  lock_acquire+0x4e1/0x5a0
[ 3796.223331]  ? __pfx_lock_acquire+0x10/0x10
[ 3796.223336]  ? bpf_lru_push_free+0x241/0x510
[ 3796.223343]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[ 3796.223353]  _raw_spin_lock_irqsave+0x57/0xa0
[ 3796.223358]  ? bpf_lru_push_free+0x241/0x510
[ 3796.223364]  bpf_lru_push_free+0x241/0x510
[ 3796.223368]  ? htab_unlock_bucket+0xcd/0x140
[ 3796.223375]  htab_lru_map_delete_elem+0x2f9/0x480
[ 3796.223382]  ? __pfx_htab_lru_map_delete_elem+0x10/0x10
[ 3796.223392]  bpf_prog_73160903ac17fb89_lru_perf+0x9c/0xa1
[ 3796.223397]  __perf_event_overflow+0x239/0xb30
[ 3796.223401]  ? x86_perf_event_set_period+0x289/0x5c0
[ 3796.223428]  ? __pfx___perf_event_overflow+0x10/0x10
[ 3796.223439]  perf_event_overflow+0x1d/0x30
[ 3796.223444]  handle_pmi_common+0x540/0xa10
[ 3796.223459]  ? __lock_acquire+0x17f3/0x6630
[ 3796.223467]  ? __pfx_handle_pmi_common+0x10/0x10
[ 3796.223475]  ? __pfx___lock_acquire+0x10/0x10
[ 3796.223483]  ? kvm_sched_clock_read+0x15/0x30
[ 3796.223488]  ? sched_clock_noinstr+0xd/0x20
[ 3796.223494]  ? __this_cpu_preempt_check+0x17/0x20
[ 3796.223503]  ? __pfx_lock_release+0x10/0x10
[ 3796.223508]  ? debug_smp_processor_id+0x1b/0x30
[ 3796.223514]  ? intel_bts_interrupt+0xf0/0x590
[ 3796.223519]  ? __pfx_intel_bts_interrupt+0x10/0x10
[ 3796.223526]  ? debug_smp_processor_id+0x1b/0x30
[ 3796.223533]  intel_pmu_handle_irq+0x23f/0xb10
[ 3796.223543]  perf_event_nmi_handler+0x42/0x70
[ 3796.223549]  nmi_handle+0x165/0x490
[ 3796.223571]  default_do_nmi+0x71/0x190
[ 3796.223577]  exc_nmi+0x1cd/0x2a0
[ 3796.223582]  asm_exc_nmi+0xbc/0x105
[ 3796.223587] RIP: 0033:0x55d6a3668601
[ 3796.223606] Code: ff 00 75 25 48 8b 05 5e 9a 04 00 48 89 c1 ba 1a
00 00 00 be 01 00 00 00 48 8d 05 1d 1c 03 00 48 89 c7 e8 e2 f6 ff ff
eb 10 90 <0f> b6 05 41 9a 04 00 83 f0 01 84 c0 75 f2 90 48 83 bd 08 fe
ff ff
[ 3796.223611] RSP: 002b:00007fff330b1790 EFLAGS: 00000202
[ 3796.223623] RAX: 0000000000000001 RBX: 000055d6da67e038 RCX: 0000000000000000
[ 3796.223626] RDX: 000000055d6da67d RSI: 000055d6da67c010 RDI: 0000000000000007
[ 3796.223630] RBP: 00007fff330b19c0 R08: 000055d6da67df60 R09: 000055d6da67c2e0
[ 3796.223633] R10: 0000000000000000 R11: 835347dc077a8333 R12: 00007fff330b1ad8
[ 3796.223636] R13: 000055d6a3668084 R14: 000055d6a36af9d8 R15: 00007f9020938040
[ 3796.223646]  </TASK>

The lockdep warning can be triggered using the following bpf and
userspace programs:
==========================================================
#include "vmlinux.h"
#include <linux/version.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>


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

SEC("tp/sched/sched_switch")
int lru_tp(void *ctx)
{
        int key = 2;
        int init_val = 1;
        long *value;

        int i;
        bpf_printk("lru_tp");
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

        struct bpf_program *prog_tp =
bpf_object__find_program_by_name(obj, "lru_tp");
        if (!prog_tp) {
                        fprintf(stderr, "ERROR: finding tp prog in obj
file failed\n");
                        goto cleanup;
        }

        struct bpf_link *link_tp = bpf_program__attach(prog_tp);
        if (!link_tp) {
                fprintf(stderr, "ERROR: failed to attach tp");
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


        lru_perf_bpf__destroy(skel);
        free(online_mask);
        return -err;
}

