Return-Path: <bpf+bounces-39050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB4D96E20E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07FDB23CC7
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367A17C9AB;
	Thu,  5 Sep 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="UqA+SFG4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE9158D66
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561165; cv=none; b=FZdkuAVIEWI/GqPSMTkuGhjk5mIoibxL/dTRXx8kyyM6V48HeGJeO4UjHlGgHsE4l+W3dSwsX6AwVlzQjQRt48q1/KKlzyJy38sRIbx+bi3FGRoWHYqo6AxqRDxKQtmQ//2x/KnCEzA6Shi8XjVLlQsMaFKvUXSQfO/PVQwIO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561165; c=relaxed/simple;
	bh=M+Ch6RKGMD72TAErRaVMrhT+r3FsRAAQyVObSh8NesA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Dv24g497fpZmNx7mdC0O8TDpNTUxK0+YnwXt/OwWYGftTuqfrVjZ/gmF71brKiDItMHFicX+k7FNCfeOcXnjNq+gErbCcBq+A7LqOnw3cpXG6ZQ9ERWLKmKgmq3iaHaq+6EYUPJ4EE+TVTtkRK5aS3vDMR5LBj5Okkdn30uwAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=UqA+SFG4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53343bf5eddso1292417e87.1
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1725561161; x=1726165961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m5wlU2iiq2lcgtWUUwF1wOfjjTjL2OBdMa1zsTFUhU8=;
        b=UqA+SFG48wINQ/gUfFYjcrIlQ+++FS/I7sN+Sh3M7IqTn+vOAB1t8S0ffuFXny6qff
         ueNwEXf2njdMzsL/sPhLCQWwMZdXomJxIzwzlL8SxRpfQNtdmaWdYGXPOiITuEJc8SaW
         hwkSvb5HbPIOfHVFapZqfv/qXxcGS+kfo9EjavFP7r3m6zK2boWQ1CwJx2EpSipcKkol
         eNh6qlScgES3ZJfACpp8tioQMfIkNRs1vjrFVhpdHz9S58lOXULNxkLpusJBbpru2V4t
         qwFjdXLv9TgSDpJ6Re7t4O2miHy/YoEMkUiBm1MbqbKfHsUda/Dhb3/uMaUTF8Fr6WAB
         5JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725561161; x=1726165961;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5wlU2iiq2lcgtWUUwF1wOfjjTjL2OBdMa1zsTFUhU8=;
        b=D1neyB2HoOK7x2e0H1a8Mz6Lms6baPSwQaoAxXnLaBdGCxjuKNV+HfQ9IEfZsXP21s
         6JbHs4hg97LJa0HzKiGQZVsji6KPlLgU1lOPLarJys90dVRsr3o3OdLgBu0saK30njxc
         rsPcnMp3+72KhMqDNfYOIqsHWFdAhGGMmyUmI55FfUs9UkP1syLWKv37pZUnHI9ZSSIB
         yOLKa3VKe/VE8z7ZNIcdmVt+nySw2A7E6mMV8jyUN1T2Qq7GneukQoX2+senAkp+uCa9
         v944UgQNC2upeGye4Ch83wBYYegQKFqS2RAv6LzUgceJYy7szqXf20GY5dVTYslr9xtI
         ZgvQ==
X-Gm-Message-State: AOJu0YxhIUe9DIb/GrbNX94V94TOQjcnIaGXc8yBNRLhegEnZsAOklzW
	RBi/mwC7EmQnOO/y4rtZbt8Qk/Uyj4IVitc7e/bsQl91M1Uezuo2heVeLHKtSqGiN0K3R4GCcSJ
	xwAv19JlaE05b4bRavo6/k1MUk7gZ4bK8js6xlw==
X-Google-Smtp-Source: AGHT+IG4nJCaGZAdT2GcrP9pfsPYHv2FI8DYBcvl8tkHmFaKDV52HJPUhjvEPM0Eido1sNFy+UeTBFCwDWLZpe5s5SE=
X-Received: by 2002:a05:6512:3b99:b0:535:3ca5:daa with SMTP id
 2adb3069b0e04-53546b167famr15530244e87.7.1725561161069; Thu, 05 Sep 2024
 11:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Thu, 5 Sep 2024 11:32:27 -0700
Message-ID: <CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy0MuL8LCXmCrQ@mail.gmail.com>
Subject: Possible deadlock in __pcpu_freelist_push
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool called Spinner to detect locking violations
in the bpf subsystem. Spinner reported a nested bpf locking issue with
the helper function bpf_get_stackid. bpf_get_stackid calls
pcpu_freelist_push which takes a spin_lock. A deadlock will occur if a
bpf program calls bpf_get_stackid, takes the spin lock in
pcpu_freelist_push, and triggers nested execution of another bpf
program that also calls bpf_get_stackid and tries to take the same
lock.

This issue was reported for kernel v6.9. However, we believe this
should still exist in the latest kernel. We tried to validate the
report on v6.10 kernel by running a PoC. Below is the lockdep splat.
The PoC is attached at the end.

Thanks,
Priya

============================================
 WARNING: possible recursive locking detected
 6.10.0-rc7+ #69 Not tainted
 --------------------------------------------
 sshd/1125 is trying to acquire lock:
 ffffe8fffbe1fd80 (&head->lock){....}-{2:2}, at: __pcpu_freelist_pop+0x1c5/0x820

 but task is already holding lock:
 ffffe8fffbe1fd80 (&head->lock){....}-{2:2}, at:
__pcpu_freelist_push+0x2ee/0x4f0

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&head->lock);
   lock(&head->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 3 locks held by sshd/1125:
  #0: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
__bpf_prog_enter+0x24/0x190
  #1: ffffe8fffbe1fd80 (&head->lock){....}-{2:2}, at:
__pcpu_freelist_push+0x2ee/0x4f0
  #2: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
trace_call_bpf+0xc3/0x810

 stack backtrace:
 CPU: 0 PID: 1125 Comm: sshd Not tainted 6.10.0-rc7+ #69
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x9f/0xf0
  dump_stack+0x14/0x20
  print_deadlock_bug+0x3ca/0x680
  __lock_acquire+0x2ff5/0x6a60
  ? __pfx___lock_acquire+0x10/0x10
  ? kernel_text_address+0x15b/0x180
  ? unwind_next_frame+0x18f/0xa60
  ? __kernel_text_address+0x16/0x50
  lock_acquire+0x1be/0x560
  ? __pcpu_freelist_pop+0x1c5/0x820
  ? __pfx_perf_callchain_kernel+0x10/0x10
  ? __pfx_lock_acquire+0x10/0x10
  _raw_spin_lock+0x3b/0x80
  ? __pcpu_freelist_pop+0x1c5/0x820
  __pcpu_freelist_pop+0x1c5/0x820
  pcpu_freelist_pop+0x31/0x80
  __bpf_get_stackid+0x515/0x960
  ? __pfx_mark_lock+0x10/0x10
  bpf_get_stackid+0x10b/0x180
  bpf_prog_b4f8da3e125c426b_test_prog2+0x42/0x47
  trace_call_bpf+0x24d/0x810
  ? __pfx_trace_call_bpf+0x10/0x10
  ? __pcpu_freelist_push+0x2ef/0x4f0
  kprobe_perf_func+0x108/0x8c0
  ? __pfx_kprobe_perf_func+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  ? kernel_text_address+0x15b/0x180
  ? unwind_next_frame+0x18f/0xa60
  kprobe_dispatcher+0xbc/0x160
  opt_pre_handler+0xd7/0x1b0
  ? __pcpu_freelist_push+0x2ef/0x4f0
  optimized_callback+0x200/0x290
  0xffffffffa0958039
 RIP: 0010:__pcpu_freelist_push+0x2ef/0x4f0
 Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fe 01 00 00
4a 03 1c e5 40 ed 20 85 4c 8d 63 08 4c 89 e7 e8 12 9a 95 02 e9 <0d> 10
0a 1f 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85
 RSP: 0018:ffff88811acf77f8 EFLAGS: 00000096
 RAX: 0000000000000000 RBX: ffffe8fffbe1fd60 RCX: 0000000000000000
 RDX: 1ffffd1fff7c3fb5 RSI: ffffffff846be8a0 RDI: ffffffff848fd000
 RBP: ffff88811acf7848 R08: ffff8881f2e319a0 R09: 1ffffffff0a41da8
 R10: ffffffff88096967 R11: 00000000cda74fb5 R12: ffffe8fffbe1fd68
 R13: 00000000000036d7 R14: ffffc90001b90900 R15: ffffc90001b9090c
  ? trace_irq_disable+0xe1/0x130
  pcpu_freelist_push+0x68/0x80
  __bpf_get_stackid+0x3a6/0x960
  ? bpf_trace_printk+0x109/0x160
  bpf_get_stackid+0x10b/0x180
  bpf_get_stackid_raw_tp+0x1a4/0x260
  bpf_prog_bd94480187a43af0_test_prog1+0x42/0x5b
  bpf_trampoline_6442487319+0x5c/0xfd
  bpf_lsm_task_alloc+0x9/0x20
  ? security_task_alloc+0xbf/0x230
  copy_process+0x2027/0x8390
  ? __this_cpu_preempt_check+0x17/0x20
  ? kvm_sched_clock_read+0x15/0x30
  ? __pfx_copy_process+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? do_syscall_64+0x97/0x140
  ? do_fcntl+0x93e/0x12a0
  kernel_clone+0xd7/0x710
  ? __pfx_kernel_clone+0x10/0x10
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  __do_sys_clone+0xbe/0xf0
  ? __pfx___do_sys_clone+0x10/0x10
  ? __pfx___sys_socketpair+0x10/0x10
  __x64_sys_clone+0xc2/0x150
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  x64_sys_call+0x1951/0x1f20
  do_syscall_64+0x8b/0x140
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? irqentry_exit+0x6f/0xa0
  ? exc_page_fault+0x8d/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f19ba8eab57
 Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2
31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
 RSP: 002b:00007ffce70b84e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
 RAX: ffffffffffffffda RBX: 00007f19bb37f040 RCX: 00007f19ba8eab57
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
 RBP: 0000000000000000 R08: 0000000000000000 R09: 000056121bfe5730
 R10: 00007f19baa39450 R11: 0000000000000246 R12: 0000000000000001
 R13: 000056121bfe5950 R14: 00000000ffffffff R15: 0000561214b5d004
  </TASK>

The deadlock can be triggered using the following bpf and user programs.
============================================================

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_endian.h>

char LICENSE[] SEC("license") = "GPL";

struct {
        __uint(type, BPF_MAP_TYPE_STACK_TRACE);
        __uint(key_size, sizeof(u32));
        __uint(value_size, 127 * sizeof(struct bpf_stack_build_id));
        __uint(max_entries, 10000);
        __uint(map_flags, BPF_F_STACK_BUILD_ID);
} stackmap SEC(".maps");


#define KERN_STACKID_FLAGS (0 |  BPF_F_REUSE_STACKID)

SEC("lsm/task_alloc")
int test_prog1(void *ctx){
        bpf_printk("lsm0");
        __u32 stack =  bpf_get_stackid(ctx, &stackmap, KERN_STACKID_FLAGS);
        bpf_printk("lsm1");
        return 0;

}


SEC("kprobe/__pcpu_freelist_push+0x2ee")
int test_prog2(void *ctx){
        bpf_printk("kprobe");
        __u32 stack =  bpf_get_stackid(ctx, &stackmap, KERN_STACKID_FLAGS);
        return 0;

}
============================================================

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include <sys/resource.h>
#include <linux/bpf.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <execinfo.h>
#include <signal.h>


static int libbpf_print_fn(enum libbpf_print_level level, const char
*format, va_list args)
{
        return vfprintf(stderr, format, args);
}

static volatile bool exiting = false;

static void sig_handler(int sig)
{
        exiting = true;
}


int main(int argc, char **argv)
{
        int err;

        libbpf_set_print(libbpf_print_fn);

        //handling ctrl+c
        signal(SIGINT, sig_handler);
        signal(SIGTERM, sig_handler);

const char *obj_file1 = "cp_user.bpf.o";
        struct bpf_object *obj1 = bpf_object__open_file(obj_file1, NULL);
        if (!obj1)
                return 1;


        err = bpf_object__load(obj1);
        if (err) {
                fprintf(stderr, "Error loading BPF target object\n");
                return 1;
        }

        struct bpf_program *prog1 =
bpf_object__find_program_by_name(obj1, "test_prog1");
        if (!prog1) {
                fprintf(stderr, "Error finding BPF program by title\n");
                goto cleanup;
        }

        struct bpf_program *prog2 =
bpf_object__find_program_by_name(obj1, "test_prog2");
        if (!prog2) {
                fprintf(stderr, "Error finding BPF program by title\n");
                goto cleanup;
        }

        struct bpf_link *link1 = bpf_program__attach_lsm(prog1);
        if (!link1) {
                fprintf(stderr, "Error attaching lsm\n");
                goto cleanup;
        }

        struct bpf_link *link2 = bpf_program__attach(prog2);
        if (!link2) {
                fprintf(stderr, "Error attaching kprobe\n");
                goto cleanup;
        }


        printf("Started successfully");

        while(!exiting) {
        }
        bpf_link__destroy(link1);
        bpf_link__destroy(link2);

cleanup:

        bpf_object__close(obj1);
        return 0;

}

