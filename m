Return-Path: <bpf+bounces-39051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E096E220
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 20:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2911F24526
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D71865F5;
	Thu,  5 Sep 2024 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="ZPoCYaTC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38515F3FB
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561451; cv=none; b=Yew7PfadaLC6HtnXJUvcUfeGjcKpccuU7GwlwQbEJQesE+zUG3yfHlD8OJY39J68LPvmXuk1giSVLAh94sqzgWpl7gf9Y1KlukdoQmSHReLs7Jp4BQZ4Msdqn1lMZHUTpe/ht+tjV6FSVR8vZ7FjOcdmM0+SsdFnTIti8ETd+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561451; c=relaxed/simple;
	bh=sqY/z56HoVOuZbki7p3gYgzIUQjpXAr3COMkM5CAvE4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RAKiXXQP/+MNIf8w6u0Jc+e+Gb5ctYI80V1e+6ZyWe0bT/uxwLOoU0ipoHAisUPe+gOFQwPL0x27Ep3TLHRexEKQi9fab8h4Jh7c+d1FtSV0oDSFwMllGnI1hZgdMIKicVNG2sYTCd3fRaTXxUbA1csronjZqyc+mSRasWq91HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=ZPoCYaTC; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533521cd1c3so1496086e87.1
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1725561447; x=1726166247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VqZt69cM2CPflHwwnyfdOTu/P1gSxi+H6kzZG207svg=;
        b=ZPoCYaTChH5Zuqokg09NVXYdNHfMljyfzYBDMEEz0LcA2UqeYX5j1b8cGKmzxaT5l4
         fgot+4h0nRFu3S4+kbqiJUYQquj1IkfIMfd0P71UTnlahlVQfvk502W1VuXwyzGmyuQQ
         vhkfG7m6oAD4hrZr2J8x9YQEhxkMrGkqQrIupla3ebyjQP4e7Jk0GmsdHihoJSEoProh
         T9txcS3lLycJ3I445EoYkkvzfGiRF9sXv9nbfRXk+McFTBhU5XeYc9Bk/9g31767bRhi
         jyltcrJUhqwkd7fOoce4wqBtIuPLjf7Z5GUQ8LmO52+/SFJoo5BYe9hHvhN/96HyMXC4
         PUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725561447; x=1726166247;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqZt69cM2CPflHwwnyfdOTu/P1gSxi+H6kzZG207svg=;
        b=ZX04MBiS4lp6eZ2oOwUly7IvzWXQv4z7izmkyxfXl0bdGL1WjAFF2x+xRvzzWFy4Lq
         1nuxqhucVlsY8h+zJPaRfvl+kO5+LyOE9vHmF/eHv8YDa3PpxTyaQUlZVZw6nxwun5nT
         790n5CN+/Fc+BUL7OI+ilIWsILQnIQTpY2AgkBFYu1KQBAVDKmpZq8jDcT65iuEcPJM2
         4i24waKGBObCIMD8xi/XyIMBYSh+7plW71pUxLKlRnL8EOo4K0k7qAFZ0DOi1SuiKoEU
         sCKwoGmrZujb1xfFXJAelLvgse9ZiE2maBAlLlLJZ1QZ5BfJaH+G3VWOlp7IproyMbSt
         rRfw==
X-Gm-Message-State: AOJu0YxUXZx63lN5ADmfaPLrZTWbHDwJuNb3YGLqnWR5/QKxQEea8XXF
	24EmimfQ/vXCjtQ7JeZ22XiXMmlrebQwr0FdYFtAvx0o8pIW8lSwFXkx8zdvuUNH8Swc22wOBEM
	pwLy3qmk3OpvcQpGtyxH9fQ9naFe64V77rDvIZg==
X-Google-Smtp-Source: AGHT+IEQ9OhVO3c+neRnB87wFi5tjldsq051QRvwk2aeWBNNbY6MExGuiWoaBjxZN7sdyWE+ZMP1nFTsmEDvQvealj4=
X-Received: by 2002:a05:6512:1386:b0:536:5625:511f with SMTP id
 2adb3069b0e04-536562551f9mr844998e87.45.1725561447298; Thu, 05 Sep 2024
 11:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Thu, 5 Sep 2024 11:37:14 -0700
Message-ID: <CAPPBnEa1_pZ6W24+WwtcNFvTUHTHO7KUmzEbOcMqxp+m2o15qQ@mail.gmail.com>
Subject: Possible deadlock in pcpu_freelist_pop
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool called Spinner to detect locking violations
in the bpf subsystem. Spinner reported a nested bpf locking issue with
the helper function bpf_get_stackid. bpf_get_stackid calls
pcpu_freelist_pop which takes a spin_lock. A deadlock will occur if a
bpf program calls bpf_get_stackid, takes the spin lock in
pcpu_freelist_pop, and triggers nested execution of another bpf
program that also calls bpf_get_stackid and tries to take the same
lock.

This issue was reported for kernel version 6.9. However, we believe
this should still exist in the latest kernel. We tried to validate the
report on v6.10 kernel by running a PoC. Below is the lockdep splat.
The PoC is attached at the end.

Thanks,
Priya
============================================
 WARNING: possible recursive locking detected
 6.10.0-rc7+ #65 Not tainted
 --------------------------------------------
 bash/1211 is trying to acquire lock:
 ffffe8fffc61a460 (&head->lock){....}-{2:2}, at: __pcpu_freelist_pop+0x1c5/0x820

 but task is already holding lock:
 ffffe8fffc61a460 (&head->lock){....}-{2:2}, at: __pcpu_freelist_pop+0x1c5/0x820

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&head->lock);
   lock(&head->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 3 locks held by bash/1211:
  #0: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
__bpf_prog_enter+0x24/0x190
  #1: ffffe8fffc61a460 (&head->lock){....}-{2:2}, at:
__pcpu_freelist_pop+0x1c5/0x820
  #2: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
trace_call_bpf+0xc3/0x810

 stack backtrace:
 CPU: 2 PID: 1211 Comm: bash Not tainted 6.10.0-rc7+ #65
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
  __bpf_get_stackid+0x303/0x960
  ? __kasan_check_read+0x15/0x20
  ? mark_lock+0xfb/0x17b0
  bpf_get_stackid+0x10b/0x180
  bpf_prog_b4f8da3e125c426b_test_prog2+0x42/0x47
  trace_call_bpf+0x24d/0x810
  ? __pfx_trace_call_bpf+0x10/0x10
  ? __pcpu_freelist_pop+0x58d/0x820
  kprobe_perf_func+0x108/0x8c0
  ? __pfx_kprobe_perf_func+0x10/0x10
  ? __pfx___lock_acquire+0x10/0x10
  ? unwind_next_frame+0x18f/0xa60
  kprobe_dispatcher+0xbc/0x160
  opt_pre_handler+0xd7/0x1b0
  ? __pcpu_freelist_pop+0x58d/0x820
  optimized_callback+0x200/0x290
  0xffffffffa08a8039
 RIP: 0010:__pcpu_freelist_pop+0x58d/0x820
 Code: fc ff df 48 89 f2 48 c1 ea 03 80 3c 02 00 0f 84 62 fd ff ff 48
89 f7 48 89 75 d0 e8 cd b0 37 00 48 8b 75 d0 e9 4d fd ff ff e9 <bf> 04
ff 1e 00 00 fc ff df 48 89 f7 48 c1 ef 03 80 3c 0f 00 0f 85
 RSP: 0018:ffff88810d217668 EFLAGS: 00000086
 RAX: ffffe8fffc61a440 RBX: 0000000000000002 RCX: 1ffffd1fff8c3488
 RDX: 1ffffd1fff8c3491 RSI: ffffc90001b56290 RDI: ffffffff848fd000
 RBP: ffff88810d2176a8 R08: ffff8881f36319a0 R09: 1ffffffff0a41daa
 R10: ffffffff88096967 R11: 00000000cda74fb5 R12: dffffc0000000000
 R13: ffffc9000195c1e8 R14: 0000000000000002 R15: ffffe8fffc61a448
  pcpu_freelist_pop+0x6c/0x80
  __bpf_get_stackid+0x303/0x960
  ? bpf_trace_printk+0x109/0x160
  ? __pfx_bpf_trace_printk+0x10/0x10
  bpf_get_stackid+0x10b/0x180
  bpf_get_stackid_raw_tp+0x1a4/0x260
  bpf_prog_bd94480187a43af0_test_prog1+0x42/0x5b
  bpf_trampoline_6442487349+0x5c/0xfd
  bpf_lsm_task_alloc+0x9/0x20
  ? security_task_alloc+0xbf/0x230
  copy_process+0x2027/0x8390
  ? __lock_acquire+0x18e5/0x6a60
  ? __pfx_copy_process+0x10/0x10
  ? kvm_sched_clock_read+0x15/0x30
  ? sched_clock_noinstr+0xd/0x20
  ? __this_cpu_preempt_check+0x17/0x20
  ? __pfx_lock_release+0x10/0x10
  kernel_clone+0xd7/0x710
  ? __pfx_kernel_clone+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  __do_sys_clone+0xbe/0xf0
  ? __pfx___do_sys_clone+0x10/0x10
  __x64_sys_clone+0xc2/0x150
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  x64_sys_call+0x1951/0x1f20
  do_syscall_64+0x8b/0x140
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? __pfx_lock_release+0x10/0x10
  ? __pfx___up_read+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? irqentry_exit+0x6f/0xa0
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? irqentry_exit_to_user_mode+0xcb/0x210
  ? irqentry_exit+0x6f/0xa0
  ? exc_page_fault+0x8d/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7ffae4ceab57
 Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2
31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
 RSP: 002b:00007fff71d900e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
 RAX: ffffffffffffffda RBX: 00007ffae503c040 RCX: 00007ffae4ceab57
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007ffae4fbea10 R11: 0000000000000246 R12: 0000000000000001
 R13: 00007fff71d90240 R14: 000056337cf57bcf R15: 0000000000000000
  </TASK>


The deadlock can be triggered using the following bpf and user programs.
========================================================================

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_endian.h>

char LICENSE[] SEC("license") = "GPL";

struct {
        __uint(type, BPF_MAP_TYPE_STACK_TRACE);
        __uint(key_size, sizeof(u32));
        __uint(value_size, 127 * sizeof(u64));
        __uint(max_entries, 10000);
} stackmap SEC(".maps");

#define KERN_STACKID_FLAGS (0 | BPF_F_REUSE_STACKID)

SEC("lsm/task_alloc")
int test_prog1(void *ctx){
        bpf_printk("lsm0");
        __u32 stack =  bpf_get_stackid(ctx, &stackmap, KERN_STACKID_FLAGS);
        bpf_printk("lsm1");
        return 0;

}


SEC("kprobe/__pcpu_freelist_pop+0x58c")
int test_prog2(void *ctx){
        bpf_printk("kprobe");
        __u32 stack =  bpf_get_stackid(ctx, &stackmap, KERN_STACKID_FLAGS);
        return 0;

}
============================================================================
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

