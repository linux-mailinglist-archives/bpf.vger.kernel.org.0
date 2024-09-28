Return-Path: <bpf+bounces-40458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48CF988D7F
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 04:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB921F22194
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 02:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8217740;
	Sat, 28 Sep 2024 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="d8arHPaJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE512B64
	for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489452; cv=none; b=XV3DPVKIZOx+9CUXkTvtIW/JiQ7Vxi1fERfYO6dFIRraSRzUJeVfSFeC7H8uS9lLw5ne5quZJ8VkXjxBLf14NNQtWcSaVDleXXdpBNTe14CX+IRWOougB+KfMd6hKyS9XAEq5KlcMVvRe8jsfgzc6btLcu1rxGph6onFV6oW3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489452; c=relaxed/simple;
	bh=u0AZNZA10slhN0Y8SYzPWNnzPU0zc5EVp3jyUINJsdk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=U3YiAKDZkDD580h3d8JlzEf7u0OQseKxmUOZPjR8iH9JEKfq/ZbkM5EwrJBxk+R81lNMoHeYigGHYpmMP1d31wgbLHhZ1jKSJHt5M63Q0X4BWyU+e/Ux23taN2DXfoasGfORrF0jJ8W6Cc3xvmswvO9D+Rris52S1+738Cb+XrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=d8arHPaJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso3278615e87.2
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 19:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1727489448; x=1728094248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9pZwCyQRQHqOP6sAVBWnugKHjQwukcQeHUbXufUsUk=;
        b=d8arHPaJvWmTIti//KvD7lwwrNiCDTfngmlqNwQxQH2UFhP9lG2uRmyDQfuTi9prW4
         wPhc1MjI/dL050DZed311BVojacU5kWIqFviDUfgBRSXyJVtDNwQepl8EnI59B2is0Ny
         DfISt06IbAgqv8m2miiXGKQuVcEyhd8z8DLUie5FxxpUgzZROwRZ7hfT1znK8l0dlEad
         jxMvmJFQ7GmHylb2QDOZAeDJ9ZA1o6+BkEDIUBPhLbNQ9m/kdjN6hhH56J+sI5Uw+W21
         pmwml4QM78XCHIDG947Uxg/+8jhjElQTd/tC6gNJ1faBU8BTAX8UClfK+gpWBxjXCsN3
         Y8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727489448; x=1728094248;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9pZwCyQRQHqOP6sAVBWnugKHjQwukcQeHUbXufUsUk=;
        b=XvCjUVWTpXUJzdCyBfHhN7ZI/U3aJSR9FIRsVaF0DqbB8t+4N4/04h52dzMxN9l71N
         SskyvanKbtpQdV3HmaLkqiG5hi7YMQFmIZ3FXazJ1sqY5CT+A7roN0FZb78+b5ylZN66
         Pn0tgReNL6CiUDzj5SBnacCtIcdX2kPVYTyPU+/8nerOc/NjOsKyO85AGCxk5QnYsI6f
         TM8St60cseQY12ZcS0hEDqeq2P8LG0+V7vamOZeKvKplvwPxn3FjgtiYaVo3n3UEkIAz
         a0rwgbz5S4S4GbuYf7t/1Bd5inxkeHZxslMjFt0lTqFNc+SMsIT/MR/rFPjSugUmuhgO
         +diQ==
X-Gm-Message-State: AOJu0YxO8FFB+rcheF9m6cvm2h+aO9ZX1lOX/P1HM/VI83cRHbz6mv/9
	n0UW10tNAHQJoHgFMUS2E3z+LCj7roP6Cf51a70SVT2ipvxyayIOk01lJaBeZr2w04HBkMJHAwM
	y/Ag0RQGsgPsx8kJ9dcy9IJBnPjN7qNjVG9p3YQ==
X-Google-Smtp-Source: AGHT+IFS7I+cvN0r95UjSCqlq0EvnnNkuYekBGdaxVU2CimNBuyQ6T5aBDwirmqduLnsnZ/yvNJocljp/W+eOX+8bXw=
X-Received: by 2002:a05:6512:1293:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-5389fc8422bmr3352245e87.57.1727489448322; Fri, 27 Sep 2024
 19:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 27 Sep 2024 19:10:35 -0700
Message-ID: <CAPPBnEajj+DMfiR_WRWU5=6A7KKULdB5Rob_NJopFLWF+i9gCA@mail.gmail.com>
Subject: Possible deadlock in bpf_common_lru_push_free
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool called Spinner to detect locking violations
in the bpf subsystem. Spinner reported a nested bpf locking issue with
the helper functions htab_lru_map_update_elem and
htab_lru_map_delete_elem. These helpers may call
bpf_common_lru_push_free which takes a spin_lock for the LRU list. A
deadlock will occur if a bpf program calls one of these helpers, takes
the spin lock in bpf_common_lru_push_free, and triggers nested
execution of another bpf program that also calls one of these helpers
and tries to take the lock for the LRU list.

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
 ping/1143 is trying to acquire lock:
 ffffe8fffee18080 (&loc_l->lock){..-.}-{2:2}, at: bpf_lru_pop_free+0x5f3/0x2010

 but task is already holding lock:
 ffffe8fffee18080 (&loc_l->lock){..-.}-{2:2}, at: bpf_lru_push_free+0x23e/0x510

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&loc_l->lock);
   lock(&loc_l->lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 5 locks held by ping/1143:
  #0: ffff88811a5fe3e8 (sk_lock-AF_INET){+.+.}-{0:0}, at:
ping_v4_sendmsg+0xadd/0x16b0
  #1: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
ip_finish_output2+0x2e3/0x20a0
  #2: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
process_backlog+0x3a5/0x14d0
  #3: ffffe8fffee18080 (&loc_l->lock){..-.}-{2:2}, at:
bpf_lru_push_free+0x23e/0x510
  #4: ffffffff85d5cbc0 (rcu_read_lock){....}-{1:3}, at:
trace_call_bpf+0xc3/0x810

 stack backtrace:
 CPU: 12 PID: 1143 Comm: ping Not tainted 6.10.0-rc7+ #69
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
  bpf_prog_f158eb129a767c60_test_prog2+0x62/0x79
  trace_call_bpf+0x24d/0x810
  ? __kasan_check_read+0x15/0x20
  ? __pfx_trace_call_bpf+0x10/0x10
  ? bpf_lru_push_free+0x2a2/0x510
  kprobe_perf_func+0x108/0x8c0
  ? __pfx_kprobe_perf_func+0x10/0x10
  ? mark_lock+0xfb/0x17b0
  kprobe_dispatcher+0xbc/0x160
  opt_pre_handler+0xd7/0x1b0
  ? bpf_lru_push_free+0x2a2/0x510
  optimized_callback+0x200/0x290
  0xffffffffa08d0039
 RIP: 0010:bpf_lru_push_free+0x2a2/0x510
 Code: 12 03 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6
04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 4f 02 00 00 e9 <2a> 4b
01 1f 13 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c
 RSP: 0018:ffff8881f5e09608 EFLAGS: 00000046
 RAX: 0000000000000000 RBX: ffffc9000197c010 RCX: 0000000000000000
 RDX: 0000000000000003 RSI: 0000000000000282 RDI: ffffc9000197c023
 RBP: ffff8881f5e09638 R08: ffff8881f5e319a0 R09: 1ffffffff0a41db4
 R10: ffffffff88096967 R11: 00000000cda74fb5 R12: ffff88811dac5300
 R13: ffffc9000197c022 R14: ffffe8fffee18040 R15: ffffe8fffee18068
  ? htab_unlock_bucket+0xcd/0x140
  htab_lru_map_delete_elem+0x2e6/0x450
  ? __pfx_htab_lru_map_delete_elem+0x10/0x10
  ? mark_lock+0xfb/0x17b0
  bpf_prog_059a41f3ceb578d1_test_prog1+0x60/0x79
  cls_bpf_classify+0x584/0x13d0
  tcf_classify+0x52f/0x1260
  tc_run+0x328/0x7f0
  ? __pfx_tc_run+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? rcu_lockdep_current_cpu_online+0x3f/0x160
  __netif_receive_skb_core.constprop.0+0xa3c/0x40c0
  ? __pfx_mark_lock+0x10/0x10
  ? __lock_acquire+0x18e5/0x6a60
  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
  ? __lock_acquire+0x18e5/0x6a60
  __netif_receive_skb_one_core+0xb2/0x1c0
  ? __pfx___netif_receive_skb_one_core+0x10/0x10
  ? __pfx_lock_release+0x10/0x10
  ? mark_held_locks+0xad/0xf0
  __netif_receive_skb+0x21/0x150
  process_backlog+0x3ec/0x14d0
  ? process_backlog+0x3a5/0x14d0
  __napi_poll.constprop.0+0xaa/0x460
  net_rx_action+0x52a/0xe00
  ? __pfx_net_rx_action+0x10/0x10
  ? __pfx_mark_lock+0x10/0x10
  ? __this_cpu_preempt_check+0x17/0x20
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
  ? __pfx_do_sys_poll+0x10/0x10
  ? __might_sleep+0xb6/0x170
  ? aa_sk_perm+0x26b/0x910
  ? __kasan_check_write+0x18/0x20
  inet_sendmsg+0xd3/0xf0
  ? inet_sendmsg+0xd3/0xf0
  __sys_sendto+0x3d4/0x4c0
  ? __pfx___sys_sendto+0x10/0x10
  ? kvm_sched_clock_read+0x15/0x30
  ? __pfx___might_resched+0x10/0x10
  __x64_sys_sendto+0xe4/0x1b0
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  x64_sys_call+0x1b4b/0x1f20
  do_syscall_64+0x8b/0x140
  ? __pfx___sys_recvmsg+0x10/0x10
  ? __pfx___rseq_handle_notify_resume+0x10/0x10
  ? debug_smp_processor_id+0x1b/0x30
  ? do_syscall_64+0x97/0x140
  ? __this_cpu_preempt_check+0x17/0x20
  ? lockdep_hardirqs_on+0xcf/0x150
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? syscall_exit_to_user_mode+0xd5/0x220
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? do_syscall_64+0x97/0x140
  ? irqentry_exit+0x6f/0xa0
  ? exc_page_fault+0x8d/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f17e8f27a0a
 Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41
89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
 RSP: 002b:00007ffd19d133c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
 RAX: ffffffffffffffda RBX: 00007ffd19d14a70 RCX: 00007f17e8f27a0a
 RDX: 0000000000000040 RSI: 000055a1f4aaa450 RDI: 0000000000000003
 RBP: 000055a1f4aaa450 R08: 00007ffd19d16cf0 R09: 0000000000000010
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000040
 R13: 00007ffd19d14608 R14: 00007ffd19d133d0 R15: 00007ffd19d14a70
  </TASK>

==========================================================

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
        int ret = bpf_map_delete_elem(&this_map, &key);
        bpf_printk("classifier");
        return 0;
}


SEC("kprobe/bpf_lru_push_free+0x2a1")
int test_prog2(void *ctx){
        __u32 key = 1;
        __u64 value = 2;
        bpf_printk("kprobe");
        bpf_map_update_elem(&this_map, &key, &value, BPF_ANY);
        int ret = bpf_map_delete_elem(&this_map, &key);
        return 0;
}

================================================================
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

