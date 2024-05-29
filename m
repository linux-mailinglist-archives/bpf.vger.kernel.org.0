Return-Path: <bpf+bounces-30848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB0D8D3B79
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1E9B27674
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E627181D1D;
	Wed, 29 May 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNCxfDIy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43803180A92
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998033; cv=none; b=aGdDefckNAu4/EWzAY2wt7rfM4JiChJUv6DSZWpBAauCZSdWwSJW8KRzpD5EY8xeFVf6vV7ZODZIa7srdu6EQ8lGQwvuVAeCrcuGcXVuJj4eWKYHr+qwuvldPSgh78Lf9JXttZmLb43g3I7ICaeNND2ol2gB/Xpdr2Qtjjbk8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998033; c=relaxed/simple;
	bh=hc+Ru3V6pFQMLzJDflChoi6bCAfmhV9ItfUvAIPqD/I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dVudbKa05HmWG1JrIVylR51cQ8wygoh8yShi+y0XwSQJoDfSsJJYhlJQ478D2e3D8qgXbXUp9VATqtqXmVEfcS20kmvHNbVtZ7O/UT7lWGTZcETDEgByuSNVdkDprWsiWJgFywFNdZtX0HMTDMz35B2G/bunp/LQTm74dc8n3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNCxfDIy; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a052f74c1so960807b3.1
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716998031; x=1717602831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FilTeUxjUEyp2GMUt7QzBYSV8PtAyS8ZTNEDfUbrojM=;
        b=MNCxfDIyddkNgDi1I2VxVNvuiZ65jdfeJIWUF/TksqQHwSdFK5vaXrpJ7mEiveYU7H
         Z6SMCDvCuZTu1gAlrd3cOvhkqsncQc1eg7Q7+VW9KON8hoB+5QkOs5k2eq561PDE8lLO
         cOJ/FmiEr3ApuEbkBj1m3wX8dElz6HrbQ53+7zIE/2WQ08d4v5whVqFOD/1qQ6NPUX+T
         CPhuUH91Yhu5L8JtpLEKm4sfVqGGm2zA5QKdT1ab0TZuQWo27oBXGKeiizfE8wK9Zrvk
         xDfGezOiBerDZsZc34EKCto+8FG2GPaXncYW2oNFfYLm7Bf1Sp33Hwblt7r8QdqlFJt1
         NPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716998031; x=1717602831;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FilTeUxjUEyp2GMUt7QzBYSV8PtAyS8ZTNEDfUbrojM=;
        b=epncIKiC4fuPzEauwcNnOzSZRz4SUwrkJkRpbwIu4QfQyoaztIN5PXXFgaNNnK+tHQ
         L8RXKXXLE936HPozfGzoU8/kkImwYl+mMmRCg9Ci8KaS5MoXuSGc6xcHaEk1eN2SVLBk
         BCIfLfpafop3s63nrrg3+x2jM7PlMhrvwGU2zpn+GBQBQfps+YAYmnkqfTvfEoVj0daH
         xVBrYkUqW/JIbwsXoOyU12DFRnjdoj8cawG3q7JV7dNNzn2DS2fQfRj794L5MawsURgl
         L/efcerAd2YIeLEZJVqfn3CbcKgn+1Yae6PpKeyYQuj25jKazXPySmKtzlMOfFycafrj
         ZRWQ==
X-Gm-Message-State: AOJu0YzwtsM98tUFTXjIUPQ5lW556/2YX7iTZF2+EgD8HkMmEjDAooqu
	dC+zty2FcOGdyQPWpYagjGys2VbkOjzpGCjJgiWBpNXQMASqtb2eCWegtx448XWr0BQ/871Yyy2
	XYRPe1ZJxHmmszlJEzYkb8a4dijw=
X-Google-Smtp-Source: AGHT+IG6GgmSiYB7jSKKDv3WQ81t1KHFPgipJDw6Q0T+6NeS5jroadSMLkYm+XEFFx8SDOke1Xp0bxP60QOQedB+cEk=
X-Received: by 2002:a05:690c:a91:b0:627:dde4:6338 with SMTP id
 00721157ae682-62c5d2a1d4emr17510397b3.6.1716998031232; Wed, 29 May 2024
 08:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 29 May 2024 08:53:39 -0700
Message-ID: <CAMB2axP3gGsdQC+CYXjBCxk++9U5upfmBAK2g9=ZNnD7N8tY3A@mail.gmail.com>
Subject: Potential deadlock in bpf_lpm_trie
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, pgovind2@uci.edu, 
	"hsinweih@uci.edu" <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"

Hello,

We are developing a tool to perform static analysis on the bpf
subsystem to detect locking violations. Our tool reported the
spin_lock_irqsave() in trie_delete_elem() and trie_update_elem() that
could be called from an NMI. If a bpf program holding the lock is
interrupted by the same program in NMI, a deadlock can happen. The
report was generated for kernel version 6.6-rc4, however, we believe
this should still exist in the latest kernel.

We tried to validate the report on v6.7 and v5.15 kernels by running a
PoC and found that trie->lock is not the only problematic lock.
Lockdep also complained about memcg_stock.stock_lock used in
lpm_trie_node_alloc() and krc.lock used in kfree_rcu(). Therefore, I
wonder if we should just return error when in NMI for
trie_delete_elem() and trie_update_elem() assuming there is no such
use case.

Below is one of the splats and the PoC is attached at the end.

I am also copying Priya who is developing the tool.

Thanks,
Amery

================================
WARNING: inconsistent lock state
5.15.26+ #42 Not tainted
--------------------------------
inconsistent {INITIAL USE} -> {IN-NMI} usage.
test_prog_user/262 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff9ec37dc20fb0 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x6d/0x330
{INITIAL USE} state was registered at:
  lock_acquire+0xc8/0x2d0
  _raw_spin_lock_irqsave+0x48/0x60
  kfree_rcu_scheduler_running+0x4c/0xa6
  rcu_set_runtime_mode+0x1e/0x2b
  do_one_initcall+0x5b/0x2d0
  kernel_init_freeable+0x28e/0x2f5
  kernel_init+0x16/0x110
  ret_from_fork+0x22/0x30
irq event stamp: 6852
hardirqs last  enabled at (6851): [<ffffffffa3600d82>]
asm_sysvec_apic_timer_interrupt+0x12/0x20
hardirqs last disabled at (6852): [<ffffffffa35d1e4b>] exc_nmi+0xab/0x180
softirqs last  enabled at (6850): [<ffffffffa2a9afc9>] __irq_exit_rcu+0xb9/0xe0
softirqs last disabled at (6845): [<ffffffffa2a9afc9>] __irq_exit_rcu+0xb9/0xe0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(krc.lock);
  <Interrupt>
    lock(krc.lock);

 *** DEADLOCK ***

no locks held by test_prog_user/262.

stack backtrace:
CPU: 0 PID: 262 Comm: test_prog_user Not tainted 5.15.26+ #42
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x72
 lock_acquire.cold+0x43/0x48
 ? kvfree_call_rcu+0x6d/0x330
 _raw_spin_lock+0x2c/0x40
 ? kvfree_call_rcu+0x6d/0x330
 kvfree_call_rcu+0x6d/0x330
 trie_delete_elem+0x198/0x200
 bpf_prog_e10e7f0a82b8b6d9_trie_perf+0x70/0xefc
 bpf_overflow_handler+0xb3/0x1f0
 __perf_event_overflow+0x52/0x100
 handle_pmi_common+0x1f7/0x350
 ? lock_acquire+0xc8/0x2d0
 ? __lock_acquire+0x393/0x1d80
 ? lock_is_held_type+0xa5/0x120
 ? find_held_lock+0x2b/0x80
 intel_pmu_handle_irq+0x119/0x2d0
 ? nmi_handle+0x5/0x250
 perf_event_nmi_handler+0x28/0x50
 nmi_handle+0xce/0x250
 default_do_nmi+0x40/0x120
 exc_nmi+0x160/0x180
 asm_exc_nmi+0x8e/0xd7
RIP: 0033:0x56257e1be3e8
Code: fd ff ff 48 89 85 68 ff ff ff 48 83 bd 68 ff ff ff 00 75 16 48
8d 05 7f 0c 00 00 48 89 c7 e8 1f fd ff ff b8 01 00 00 00 eb 02 <eb> fe
48 8b 55 f8 64 48 2b 14 25 28 00 00 00 74 05 e8 c2 fc ff ff
RSP: 002b:00007ffd8b296f10 EFLAGS: 00000206
RAX: 000056257ff9a730 RBX: 00007ffd8b2970e8 RCX: 00007f6b04fe6b3b
RDX: 0000000000000000 RSI: 0000000000002400 RDI: 0000000000000006
RBP: 00007ffd8b296fd0 R08: 0000000000000028 R09: 0000000600000005
R10: 0000000000000029 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd8b297100 R14: 000056257e1c0d80 R15: 00007f6b05159020
 </TASK>


The lockdep warning can be triggered using the following user and bpf programs.
================================

#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <linux/perf_event.h>
#include <sys/syscall.h>
#include <unistd.h>

long perf_event_open(struct perf_event_attr* event_attr, pid_t pid, int cpu,
                     int group_fd, unsigned long flags)
{
    return syscall(__NR_perf_event_open, event_attr, pid, cpu, group_fd, flags);
}

int main(int argc, char **argv)
{
        struct bpf_program* prog;
        struct bpf_object* obj;
        struct bpf_link* link;
        int ret, pfd;

        obj = bpf_object__open(argv[1]);
        if (!obj) {
                perror("bpf_object__open");
                return 1;
        }

        ret = bpf_object__load(obj);
        if (ret) {
                perror("bpf_object__load");
                return 1;
        }

        struct perf_event_attr attr_type_hw = {
                .type = PERF_TYPE_HARDWARE,
                .config = PERF_COUNT_HW_CPU_CYCLES,
                .sample_freq = 50,
                .inherit = 1,
                .freq = 1,
        };
        pfd = perf_event_open(&attr_type_hw, 0, -1, -1, 0);
        if (!pfd) {
                perror("perf_event_open");
                return 1;
        }

        prog = bpf_object__next_program(obj, NULL);
        if (!prog) {
                perror("bpf_object__next_program");
                return 1;
        }

        link = bpf_program__attach_perf_event(prog, pfd);
        if (!link) {
                perror("bpf_program__attach_perf_event");
                return 1;
        }

        while (true) {};
        return 0;
}

==============================

struct ipv4_lpm_key {
        __u32 prefixlen;
        __u32 data;
};

struct {
        __uint(type, BPF_MAP_TYPE_LPM_TRIE);
        __type(key, struct ipv4_lpm_key);
        __type(value, __u32);
        __uint(map_flags, BPF_F_NO_PREALLOC);
        __uint(max_entries, 255);
} pb SEC(".maps");

SEC("perf_event")
int trie_perf(void *ctx)
{
        struct ipv4_lpm_key key = { .prefixlen=2 , .data=2};
        long init_val = 1;
        long *value;

        bpf_map_update_elem(&pb, &key, &init_val, BPF_ANY);
        value = bpf_map_lookup_elem(&pb, &key);
        int ret = bpf_map_delete_elem(&pb, &key);
        return 0;
}

