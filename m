Return-Path: <bpf+bounces-40457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58748988D79
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 04:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F82D282E14
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BF114295;
	Sat, 28 Sep 2024 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="rEtydesI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50509125B9
	for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727488940; cv=none; b=ZWEkwk4LktJm7WaP9L8t1N2LtfZCra2/6GZQcBBh6fkTi0cWoazuN1YdHuh6x56UaqF7fXJfIkG2pmtM0tiwL/94lDeIWa+ZM/Ko+FWO2H1vjIcaU/hlndB5Byz/CtJCjPMtMhH5eIZ5PWEw7LGSDJdiFpEtAzklgPZHzMxwQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727488940; c=relaxed/simple;
	bh=4CcE84cRS5c+N2FrTFzpjJEAG0yKQw0SWvB0ezPpic4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EYS8UQQRPbCGJm5MJwfRW0d90t+0PqDwV2pQcMEXYctJBfnFrKGSUT28NJB4ztJVSY7jvIfk7dPM+YvXJvMQrTXjmpdDkyuWz3vriT9cPUOEP0THseoTwSitX0ZLVrsJOTpdD/hD2mOw8V2rCdbvCqUdEey07qclzyZfhW140Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=rEtydesI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365c512b00so3429466e87.3
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1727488936; x=1728093736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gWk7pBZ3q3bBnNJfH+dH3OOAshUWbLrIPm4l3d+wMKs=;
        b=rEtydesIFLkFMbMMT7dwXoHFL6nmJOUg/lFJ4BYHn9CsPM+i8qXEnbGI55I74T1FyX
         ayvH46KzyfR9sWF++S5p2ImvNYkKBU/UEb+RtdU9v1j5vVpTDqdHZmoYc46UvGyYndNM
         aeBHETcPsxxy2mGPWafzUkS8WKnEhc1H9J/dtopUevzfhqGEp3x/MvSOhCogJEw1a4el
         yC94+ZI+vpMBG69W3WKvLGIisGTKzUMViaH6SZVbgVP0/LpfQmT8aC0mqv2KLRhaHcOg
         LgQlz01C4tnItWBiE5QyWSuOzbg3CnNafZCYJ2zmuuOEQbdFdt9ljhROMFw3GcFxMAmt
         LgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727488936; x=1728093736;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWk7pBZ3q3bBnNJfH+dH3OOAshUWbLrIPm4l3d+wMKs=;
        b=mKeOEb0NANR/PuXaNybIzT7S9dVJ6LN4nRemvIe4OYrdtJ1dCI6qaiSh5rOuFdwMUh
         UW8kJhXx8Q/TS3pCe+aw5467o5X2B1QdSzqz+bulxrn/b1D/dEOwj+WdzfNR9Ml/jlOv
         DSlridCgx81SKJ9TZuQNuwEUORS0pHJS3FOwjuuvHY4a0wGIEc6zmf86UtlRbeeDt0DF
         jk5Y+KZZS1CDQDN1DUAH8S9IBU60eTThvEAOhaHZ7k/lzpcCFFuaKt5wYtz9A7i8PIB8
         ySyf4cVFwiJswwlTFsReoYigaaLfiNUFBBV8GKp8TWZ3yB65sI3dGNrOsgLRmICjK8aJ
         91Nw==
X-Gm-Message-State: AOJu0Yy/DUbdlaFcR7PCWdwkjvbTKy+HUDT9OM2GXibcr8qjRRjd62yY
	hSt+ZV4X6329+7YlF8R6lF9b6kp/3HYdBHypxQgOZPj13+sBe0KOF2fJS2VwNalrnUZd9iYoCCH
	mBW2wN17TKMPo1eT0Uo1m3X1l1V4zBy0bh+GgJA==
X-Google-Smtp-Source: AGHT+IHe9LETygGCX8MB9Qbwtn5c+pmAb08X3t5uR8pxJxGVK9bR18iaJNsLCW+759LGGmZMSvsCfDNanpcbrC3noyI=
X-Received: by 2002:a05:6512:3041:b0:533:ad6:8119 with SMTP id
 2adb3069b0e04-5389fc3abcfmr3216537e87.14.1727488936183; Fri, 27 Sep 2024
 19:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 27 Sep 2024 19:02:03 -0700
Message-ID: <CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OLJJYvRoSsMY_g@mail.gmail.com>
Subject: Possible deadlock in bpf_common_lru_pop_free
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool called Spinner to detect locking violations
in the bpf subsystem. Spinner reported a nested bpf locking issue with
the helper function htab_lru_map_update_elem. htab_lru_map_update_elem
calls bpf_common_lru_pop_free which takes a spin_lock. A deadlock will
occur if a bpf program calls htab_lru_map_update_elem, takes the spin
lock in bpf_common_lru_pop_free, and triggers nested execution of
another bpf program that also calls htab_lru_map_update_elem and tries
to take the same lock.

This issue was reported for kernel version 6.9. However, we believe
this should still exist in the latest kernel. We tried to validate the
report on v6.10 kernel by running a PoC. Below is the lockdep splat.
The PoC is attached at the end.

Thanks,
Priya

============================================
 WARNING: possible recursive locking detected
 6.10.0-rc7+ #69 Not tainted
 --------------------------------------------
 ping/1186 is trying to acquire lock:
 ffffe8fffde25c60 (&loc_l->lock){..-.}-{2:2}, at: bpf_lru_pop_free+0x5f3/0x2010

 but task is already holding lock:
 ffffe8fffde25c60 (&loc_l->lock){..-.}-{2:2}, at: bpf_lru_pop_free+0x5f3/0x2010

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&loc_l->lock);
   lock(&loc_l->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 5 locks held by ping/1186:
  #0: ffff888114d95d68 (sk_lock-AF_INET){+.+.}-{0:0}, at:
ping_v4_sendmsg+0xadd/0x16b0
  #1: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
ip_finish_output2+0x2e3/0x20a0
  #2: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
process_backlog+0x3a5/0x14d0
  #3: ffffe8fffde25c60 (&loc_l->lock){..-.}-{2:2}, at:
bpf_lru_pop_free+0x5f3/0x2010
  #4: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
trace_call_bpf+0xc3/0x810

 stack backtrace:
 CPU: 8 PID: 1186 Comm: ping Not tainted 6.10.0-rc7+ #69
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x9f/0xf0
  dump_stack+0x14/0x20
  print_deadlock_bug+0x3ca/0x680
  __lock_acquire+0x2ff5/0x6a60
  ? __pfx___lock_acquire+0x10/0x10
  ? __kasan_check_read+0x15/0x20
  ? rb_commit+0xec/0x960
  lock_acquire+0x1be/0x560
  ? bpf_lru_pop_free+0x5f3/0x2010
  ? __kasan_check_read+0x15/0x20
  ? __pfx_lock_acquire+0x10/0x10
  ? trace_buffer_unlock_commit_regs+0x51/0x4b0
  ? trace_event_buffer_commit+0x19c/0xb60
  _raw_spin_lock_irqsave+0x55/0xa0
  ? bpf_lru_pop_free+0x5f3/0x2010
  bpf_lru_pop_free+0x5f3/0x2010
  ? __pfx_trace_event_raw_event_bpf_trace_printk+0x10/0x10
  ? __pfx_bstr_printf+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  prealloc_lru_pop+0x24/0xd0
  htab_lru_map_update_elem+0x1a2/0x720
  ? __pfx_htab_lru_map_update_elem+0x10/0x10
  bpf_prog_2ee6c180efbc46fd_test_prog2+0x5e/0x62
  trace_call_bpf+0x24d/0x810
  ? __kasan_check_read+0x15/0x20
  ? __pfx_trace_call_bpf+0x10/0x10
  ? bpf_lru_pop_free+0x353/0x2010
  kprobe_perf_func+0x108/0x8c0
  ? __pfx_kprobe_perf_func+0x10/0x10
  kprobe_dispatcher+0xbc/0x160
  opt_pre_handler+0xd7/0x1b0
  ? bpf_lru_pop_free+0x353/0x2010
  optimized_callback+0x200/0x290
  0xffffffffa08a8039
 RIP: 0010:bpf_lru_pop_free+0x353/0x2010
 Code: 1f 44 00 00 48 8d 41 28 48 89 45 90 81 e3 00 02 00 00 0f 85 dc
02 00 00 48 8b 7d 90 e8 06 79 95 02 85 c0 0f 84 e6 02 00 00 e9 <99> ea
fe 1e 00 00 fc ff df 48 8b 55 b0 48 c1 ea 03 80 3c 02 00 0f
 RSP: 0018:ffff8881f4e09530 EFLAGS: 00000092
 RAX: 0000000000000286 RBX: 0000607e09025c20 RCX: 1ffff1103e9d0fac
 RDX: 1ffffd1fffbc4b91 RSI: ffffffff846be8a0 RDI: ffffffff848fd000
 RBP: ffff8881f4e095f8 R08: ffff8881f4e319a0 R09: 1ffffffff0a41db0
 R10: ffffffff88096967 R11: 00000000cda74fb5 R12: 0000000000000008
 R13: ffff88811366c300 R14: 1ffff1103e9c12cd R15: ffff88811366c01c
  ? __lock_acquire+0x18e5/0x6a60
  ? __kasan_check_read+0x15/0x20
  prealloc_lru_pop+0x24/0xd0
  htab_lru_map_update_elem+0x1a2/0x720
  ? __pfx_htab_lru_map_update_elem+0x10/0x10
  bpf_prog_d7a1f3cbb8717020_test_prog1+0x4a/0x62
  cls_bpf_classify+0x584/0x13d0
  tcf_classify+0x52f/0x1260
  tc_run+0x328/0x7f0
  ? __pfx_tc_run+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? rcu_lockdep_current_cpu_online+0x3f/0x160
  __netif_receive_skb_core.constprop.0+0xa3c/0x40c0
  ? __pfx_mark_lock+0x10/0x10
  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
  ? __lock_acquire+0x18e5/0x6a60
  __netif_receive_skb_one_core+0xb2/0x1c0
  ? __pfx___netif_receive_skb_one_core+0x10/0x10
  ? __pfx_lock_release+0x10/0x10
  ? mark_held_locks+0xad/0xf0
  __netif_receive_skb+0x21/0x150
  process_backlog+0x3ec/0x14d0
  ? rcu_read_lock_sched_held+0x4b/0x90
  ? process_backlog+0x3a5/0x14d0
  __napi_poll.constprop.0+0xaa/0x460
  net_rx_action+0x52a/0xe00
  ? __pfx_net_rx_action+0x10/0x10
  ? __pfx_mark_lock+0x10/0x10
  ? mark_held_locks+0xad/0xf0
  ? handle_softirqs+0x1cb/0x980
  handle_softirqs+0x215/0x980
  ? __pfx_handle_softirqs+0x10/0x10
  ? __dev_queue_xmit+0x87b/0x3cb0
  __do_softirq+0x14/0x1a
  do_softirq.part.0+0xaf/0xf0
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x127/0x150
  ? __dev_queue_xmit+0x87b/0x3cb0
  __dev_queue_xmit+0x890/0x3cb0
  ? __lock_acquire+0x18e5/0x6a60
  ? __kasan_check_read+0x15/0x20
  ? __pfx___dev_queue_xmit+0x10/0x10
  ? __lock_acquire+0x18e5/0x6a60
  ? __pfx_mark_lock+0x10/0x10
  ? check_chain_key+0x1c6/0x540
  ? __this_cpu_preempt_check+0x17/0x20
  ? ip_finish_output2+0x185a/0x20a0
  ip_finish_output2+0xaa3/0x20a0
  ? __kasan_check_read+0x15/0x20
  ? __pfx_ip_finish_output2+0x10/0x10
  ? __pfx_ip_skb_dst_mtu+0x10/0x10
  __ip_finish_output+0x16f/0x2c0
  ip_finish_output+0x2f/0x270
  ip_output+0x17c/0x500
  ? __ip_local_out+0x1f8/0x850
  ? __pfx_ip_output+0x10/0x10
  ? __kasan_check_write+0x18/0x20
  ? __pfx_ip_finish_output+0x10/0x10
  ? __ip_make_skb+0xe8c/0x2630
  ip_local_out+0x24d/0x390
  ip_push_pending_frames+0x8a/0x100
  ping_v4_sendmsg+0xd9c/0x16b0
  ? __pfx_ping_v4_sendmsg+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
  ? __might_sleep+0xb6/0x170
  ? aa_sk_perm+0x26b/0x910
  ? __kasan_check_write+0x18/0x20
  inet_sendmsg+0xd3/0xf0
  ? inet_sendmsg+0xd3/0xf0
  __sys_sendto+0x3d4/0x4c0
  ? __pfx___sys_sendto+0x10/0x10
  ? __lock_acquire+0x18e5/0x6a60
  __x64_sys_sendto+0xe4/0x1b0
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  x64_sys_call+0x1b4b/0x1f20
  do_syscall_64+0x8b/0x140
  ? debug_smp_processor_id+0x1b/0x30
  ? rcu_is_watching+0x17/0xd0
  ? __rseq_handle_notify_resume+0xa24/0xd70
  ? __this_cpu_preempt_check+0x17/0x20
  ? xfd_validate_state+0x2f/0x160
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? irqentry_exit+0x6f/0xa0
  ? exc_page_fault+0x8d/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7ff57ff27a0a
 Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41
89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
 RSP: 002b:00007ffd51bb0f48 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 00007ffd51bb25f0 RCX: 00007ff57ff27a0a
 RDX: 0000000000000040 RSI: 00005596cdeea450 RDI: 0000000000000003
 RBP: 00005596cdeea450 R08: 00007ffd51bb4870 R09: 0000000000000010
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000040
 R13: 00007ffd51bb2188 R14: 00007ffd51bb0f50 R15: 00007ffd51bb25f0
  </TASK>

==========================================

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_endian.h>

char LICENSE[] SEC("license") = "GPL";


struct {
        __uint(type, BPF_MAP_TYPE_LRU_HASH);
        __uint(max_entries, 1024);
        __type(key, __u32);
        __type(value, __u64);
} this_map SEC(".maps");


SEC("classifier")
int test_prog1(struct __sk_buff *ctx){
        __u32 key = 1;
        __u64 value = 2;
        bpf_map_update_elem(&this_map, &key, &value, BPF_ANY);

        bpf_printk("classifier");
        return 0;
}


SEC("kprobe/bpf_lru_pop_free+0x352")
int test_prog2(void *ctx){
        __u32 key = 1;
        __u64 value = 2;
        bpf_printk("kprobe");
        bpf_map_update_elem(&this_map, &key, &value, BPF_ANY);

        return 0;
}
=========================================

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <signal.h>

#define LO_IFINDEX 1

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

        DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .ifindex = LO_IFINDEX,
                            .attach_point = BPF_TC_INGRESS);
        DECLARE_LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle = 1, .priority = 1);
        bool hook_created = false;


        const char *obj_file = "recurtest2.bpf.o";
        struct bpf_object *obj = bpf_object__open_file(obj_file, NULL);
        if (!obj)
                return 1;

        err = bpf_object__load(obj);
        if (err) {
                fprintf(stderr, "Error loading BPF target object\n");
                return 1;
        }

        struct bpf_program *prog1 =
bpf_object__find_program_by_name(obj, "test_prog1");
        if (!prog1) {
                fprintf(stderr, "Error finding BPF program by title\n");
                goto cleanup;
        }


        err = bpf_tc_hook_create(&tc_hook);
        if (!err)
                hook_created = true;
        if (err && err != -EEXIST) {
                fprintf(stderr, "Failed to create TC hook: %d\n", err);
                goto cleanup;
        }

        tc_opts.prog_fd = bpf_program__fd(prog1);
        err = bpf_tc_attach(&tc_hook, &tc_opts);
        if (err) {
                fprintf(stderr, "Failed to attach TC: %d\n", err);
                goto cleanup;
        }



        struct bpf_program *prog2 =
bpf_object__find_program_by_name(obj, "test_prog2");
        if (!prog2) {
                fprintf(stderr, "Error finding BPF program by title\n");
                goto cleanup;
        }


        struct bpf_link *link2 = bpf_program__attach(prog2);
        if (!link2) {
                fprintf(stderr, "Error attaching kprobe\n");
                return 1;
        }


        printf("Started successfully");


        //for (int i=0; i<10000000; i++) printf("");
        while(!exiting) {}
        bpf_link__destroy(link2);

        tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
        err = bpf_tc_detach(&tc_hook, &tc_opts);
        if (err) {
                fprintf(stderr, "Failed to detach TC: %d\n", err);
                goto cleanup;
        }

cleanup:
        if (hook_created)
                bpf_tc_hook_destroy(&tc_hook);
        bpf_object__close(obj);
        return 0;

}

