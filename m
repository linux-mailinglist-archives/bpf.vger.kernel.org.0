Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F352DC06B
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 13:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgLPMlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 07:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLPMlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 07:41:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC5EC061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 04:40:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so24639637edt.7
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3+24FVm7G2PdFINSVK5bgqGfot8W8NytzB+t5EcpvgI=;
        b=g2ZP2SDRah5nbddZopUeIRBXFfz17l7NpXpnm68Safqk4rWhv2AP78YWl7kxMoW8TN
         l9dKQpYTOUEuz+TMSeX1xzrGljoUtfzplIaBlzxo2TEsjFfsG0wG0iZP14ijzNcs26kT
         Km1DzLG0gAG6Kgf4Gu2npNc6I8dsxYYuQXhPbBwHOaQXtyVWjTbBOsEBiQ6PEGuaVARp
         e7zZVPrShngVgQz7XOx+cktjlBZpr86PFIzzYmJIzI0ocmRH0q4GggW/kUeuZVqXiIjW
         VhTevQr9p2W8Qs6smfYqVHE/BN/8CVNvI2n/Y54iwlJ/G7Xdk5vhqjp+R/5I/BIP4lY7
         p4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3+24FVm7G2PdFINSVK5bgqGfot8W8NytzB+t5EcpvgI=;
        b=CM7n876zKIWdWxyC7IrW4DzaGA284a0zLPogQiEZDg6d+fXYd+FqVKcLJDQ7StGSxx
         8VuY1H0TDy+iWJZJEAhgt3hVGoMyfynU9eK+cZFRVfcDsp8TruPSGzR3mfLNqKrNQj2Y
         dzataGkBTMG6O+DQHoli96sSfvfK17WGG44Xf+ytDfcWz4QLr0LI058HYlsRGay1R6v7
         /Pm49KxNzfpYD3S4BSXIfJPjhQNDZzA4coFugMqykMcZd5TpZh7ZiSZRMeyKPCvEdcwy
         6Nyz0jd/dqLyGnbZo3/uT33OreaDpVxN50yZCnM1R88VV964zGhuzaM7GmdUpc1Wi1iX
         PKgg==
X-Gm-Message-State: AOAM530qnwMQkBX9pfEAazywB47PX83HpU2eGHxlICwF0ueEw7BHk9dB
        pER64X0kS0D+fn5JUUcKVQfIvnJMpQdl1O1dEHDINjgZJ7qqiw==
X-Google-Smtp-Source: ABdhPJy7CZeKxnVXo6cTvPVsBzYLTk/UOe9PxHl5qXDTR2OSOhvRG8qMVAFcHsrxl1WNyIFDeNL3H79kPsQxHMgNBQM=
X-Received: by 2002:a50:fc96:: with SMTP id f22mr34994419edq.162.1608122438524;
 Wed, 16 Dec 2020 04:40:38 -0800 (PST)
MIME-Version: 1.0
From:   Gilad Reti <gilad.reti@gmail.com>
Date:   Wed, 16 Dec 2020 14:40:02 +0200
Message-ID: <CANaYP3Fo3eHCxs-3Dpurnf0Q3HhCcaJ4rD5JjQG-VPzYnfKchw@mail.gmail.com>
Subject: verifier fails after register spill
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello there,

I am having an issue with passing bpf programs through the verifier.

For a minimal example, I took andrii's examples from libbpf-bootstrap
(bootstrap.bpf.c) and added the following lines (to forcibly claim all
available registers in order to cause register spilling):

int a, b, c, d, e_, f, g, h, i;

a = b = c = d = e_ = f = g = h = i = 0;
asm volatile(""
            : "=r"(a), "=r"(b), "=r"(c), "=r"(d), "=r"(e_), "=r"(f),
"=r"(g), "=r"(h), "=r"(i)
            : "0"(a), "1"(b), "2"(c), "3"(d), "4"(e_), "5"(f), "6"(g),
"7"(h), "8"(i));

This causes r7 (the register pointing to the ringbuf reserved memory)
to spill out to the stack, and later when it is returned to the
registers it is marked as "inv" which causes the verifier to reject
loading the program.

My setup is Linux 5.10.0, clang 11.0.0-2.

For a reference, here is the complete bpf program (userspace program
is the same as andrii's):


// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
/* Copyright (c) 2020 Facebook */
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <bpf/bpf_core_read.h>
#include "bootstrap.h"

char LICENSE[] SEC("license") = "Dual BSD/GPL";

struct
{
    __uint(type, BPF_MAP_TYPE_HASH);
    __uint(max_entries, 8192);
    __type(key, pid_t);
    __type(value, u64);
} exec_start SEC(".maps");

struct
{
    __uint(type, BPF_MAP_TYPE_RINGBUF);
    __uint(max_entries, 256 * 1024);
} rb SEC(".maps");

const volatile unsigned long long min_duration_ns = 0;

SEC("tp/sched/sched_process_exec")
int handle_exec(struct trace_event_raw_sched_process_exec *ctx)
{
    struct task_struct *task;
    unsigned fname_off;
    struct event *e;
    pid_t pid;
    u64 ts;

    /* remember time exec() was executed for this PID */
    pid = bpf_get_current_pid_tgid() >> 32;
    ts = bpf_ktime_get_ns();
    bpf_map_update_elem(&exec_start, &pid, &ts, BPF_ANY);

    /* don't emit exec events when minimum duration is specified */
    if (min_duration_ns)
        return 0;

    /* reserve sample from BPF ringbuf */
    e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
    if (!e)
        return 0;

    /* fill out the sample with data */
    task = (struct task_struct *)bpf_get_current_task();

    e->exit_event = false;
    e->pid = pid;
    e->ppid = BPF_CORE_READ(task, real_parent, tgid);
    bpf_get_current_comm(&e->comm, sizeof(e->comm));

    int a, b, c, d, e_, f, g, h, i;

    a = b = c = d = e_ = f = g = h = i = 0;
    asm volatile(""
                 : "=r"(a), "=r"(b), "=r"(c), "=r"(d), "=r"(e_),
"=r"(f), "=r"(g), "=r"(h), "=r"(i)
                 : "0"(a), "1"(b), "2"(c), "3"(d), "4"(e_), "5"(f),
"6"(g), "7"(h), "8"(i));

    fname_off = ctx->__data_loc_filename & 0xFFFF;
    bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx
+ fname_off);

    /* successfully submit it to user-space for post-processing */
    bpf_ringbuf_submit(e, 0);
    return 0;
}

SEC("tp/sched/sched_process_exit")
int handle_exit(struct trace_event_raw_sched_process_template *ctx)
{
    struct task_struct *task;
    struct event *e;
    pid_t pid, tid;
    u64 id, ts, *start_ts, duration_ns = 0;

    /* get PID and TID of exiting thread/process */
    id = bpf_get_current_pid_tgid();
    pid = id >> 32;
    tid = (u32)id;

    /* ignore thread exits */
    if (pid != tid)
        return 0;

    /* if we recorded start of the process, calculate lifetime duration */
    start_ts = bpf_map_lookup_elem(&exec_start, &pid);
    if (start_ts)
        duration_ns = bpf_ktime_get_ns() - *start_ts;
    else if (min_duration_ns)
        return 0;
    bpf_map_delete_elem(&exec_start, &pid);

    /* if process didn't live long enough, return early */
    if (min_duration_ns && duration_ns < min_duration_ns)
        return 0;

    /* reserve sample from BPF ringbuf */
    e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
    if (!e)
        return 0;

    /* fill out the sample with data */
    task = (struct task_struct *)bpf_get_current_task();

    e->exit_event = true;
    e->duration_ns = duration_ns;
    e->pid = pid;
    e->ppid = BPF_CORE_READ(task, real_parent, tgid);
    e->exit_code = (BPF_CORE_READ(task, exit_code) >> 8) & 0xff;
    bpf_get_current_comm(&e->comm, sizeof(e->comm));

    /* send data to user-space for post-processing */
    bpf_ringbuf_submit(e, 0);
    return 0;
}




And libbpf's output:

libbpf: load bpf program failed: Permission denied
libbpf: -- BEGIN DUMP LOG ---
libbpf:
Unrecognized arg#0 type PTR
; int handle_exec(struct trace_event_raw_sched_process_exec *ctx)
0: (bf) r6 = r1
; pid = bpf_get_current_pid_tgid() >> 32;
1: (85) call bpf_get_current_pid_tgid#14
; pid = bpf_get_current_pid_tgid() >> 32;
2: (77) r0 >>= 32
; pid = bpf_get_current_pid_tgid() >> 32;
3: (63) *(u32 *)(r10 -4) = r0
; ts = bpf_ktime_get_ns();
4: (85) call bpf_ktime_get_ns#5
; ts = bpf_ktime_get_ns();
5: (7b) *(u64 *)(r10 -16) = r0
6: (bf) r2 = r10
;
7: (07) r2 += -4
8: (bf) r3 = r10
9: (07) r3 += -16
; bpf_map_update_elem(&exec_start, &pid, &ts, BPF_ANY);
10: (18) r1 = 0xffff8bf45ddd1400
12: (b7) r4 = 0
13: (85) call bpf_map_update_elem#2
; if (min_duration_ns)
14: (18) r1 = 0xffffa1b980644000
16: (79) r1 = *(u64 *)(r1 +0)
 R0=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=8,imm=0)
R6=ctx(id=0,off=0,imm=0) R10=fp0 fp-8=mmmm???? fp-16=mmmmmmmm
; if (min_duration_ns)
17: (55) if r1 != 0x0 goto pc+60
last_idx 17 first_idx 14
regs=2 stack=0 before 16: (79) r1 = *(u64 *)(r1 +0)
18: (b7) r8 = 0
; e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
19: (18) r1 = 0xffff8bf461b60600
21: (b7) r2 = 168
22: (b7) r3 = 0
23: (85) call bpf_ringbuf_reserve#131
24: (bf) r7 = r0
; if (!e)
25: (15) if r7 == 0x0 goto pc+52
 R0=mem(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0)
R7_w=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
fp-16=mmmmmmmm refs=2
; task = (struct task_struct *)bpf_get_current_task();
26: (85) call bpf_get_current_task#35
; e->exit_event = false;
27: (73) *(u8 *)(r7 +167) = r8
 R0_w=inv(id=0) R6=ctx(id=0,off=0,imm=0)
R7_w=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
fp-16=mmmmmmmm refs=2
; e->pid = pid;
28: (61) r1 = *(u32 *)(r10 -4)
; e->pid = pid;
29: (63) *(u32 *)(r7 +0) = r1
 R0_w=inv(id=0) R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
0xffffffff)) R6=ctx(id=0,off=0,imm=0)
R7_w=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
fp-16=mmmmmmmm refs=2
30: (b7) r1 = 2264
31: (0f) r0 += r1
32: (bf) r1 = r10
;
33: (07) r1 += -32
; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
34: (b7) r2 = 8
35: (bf) r3 = r0
36: (85) call bpf_probe_read_kernel#113
last_idx 36 first_idx 24
regs=4 stack=0 before 35: (bf) r3 = r0
regs=4 stack=0 before 34: (b7) r2 = 8
37: (b7) r1 = 2252
38: (79) r3 = *(u64 *)(r10 -32)
39: (0f) r3 += r1
40: (bf) r1 = r10
;
41: (07) r1 += -20
; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
42: (b7) r2 = 4
43: (85) call bpf_probe_read_kernel#113
last_idx 43 first_idx 37
regs=4 stack=0 before 42: (b7) r2 = 4
; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
44: (61) r1 = *(u32 *)(r10 -20)
; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
45: (63) *(u32 *)(r7 +4) = r1
 R0_w=inv(id=0) R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
0xffffffff)) R6=ctx(id=0,off=0,imm=0)
R7=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
fp-16=mmmmmmmm fp-24=mmmm???? fp-32=mmmmmmmm refs=2
; bpf_get_current_comm(&e->comm, sizeof(e->comm));
46: (bf) r1 = r7
47: (07) r1 += 24
; bpf_get_current_comm(&e->comm, sizeof(e->comm));
48: (b7) r2 = 16
49: (85) call bpf_get_current_comm#16
 R0_w=inv(id=0) R1_w=mem(id=0,ref_obj_id=2,off=24,imm=0) R2_w=inv16
R6=ctx(id=0,off=0,imm=0) R7=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0
R10=fp0 fp-8=mmmm???? fp-16=mmmmmmmm fp-24=mmmm???? fp-32=mmmmmmmm
refs=2
last_idx 49 first_idx 37
regs=4 stack=0 before 48: (b7) r2 = 16
; asm volatile(""
50: (b7) r1 = 0
51: (7b) *(u64 *)(r10 -40) = r1
last_idx 51 first_idx 50
regs=2 stack=0 before 50: (b7) r1 = 0
52: (b7) r1 = 0
53: (7b) *(u64 *)(r10 -48) = r1
last_idx 53 first_idx 50
regs=2 stack=0 before 52: (b7) r1 = 0
54: (b7) r1 = 0
55: (7b) *(u64 *)(r10 -56) = r1
last_idx 55 first_idx 50
regs=2 stack=0 before 54: (b7) r1 = 0
56: (b7) r4 = 0
57: (b7) r5 = 0
58: (b7) r0 = 0
59: (b7) r8 = 0
60: (b7) r9 = 0
61: (bf) r3 = r6
62: (b7) r6 = 0
63: (79) r2 = *(u64 *)(r10 -40)
64: (79) r1 = *(u64 *)(r10 -48)
65: (7b) *(u64 *)(r10 -64) = r7
66: (79) r7 = *(u64 *)(r10 -56)
; fname_off = ctx->__data_loc_filename & 0xFFFF;
67: (61) r1 = *(u32 *)(r3 +8)
; bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx +
fname_off);
68: (57) r1 &= 65535
69: (0f) r3 += r1
last_idx 69 first_idx 50
regs=2 stack=0 before 68: (57) r1 &= 65535
regs=2 stack=0 before 67: (61) r1 = *(u32 *)(r3 +8)
70: (79) r6 = *(u64 *)(r10 -64)
; bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx +
fname_off);
71: (bf) r1 = r6
72: (07) r1 += 40
; bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx +
fname_off);
73: (b7) r2 = 127
74: (85) call bpf_probe_read_str#45
R1 type=inv expected=fp, pkt, pkt_meta, map_value, mem, rdonly_buf, rdwr_buf
processed 72 insns (limit 1000000) max_states_per_insn 0 total_states
4 peak_states 4 mark_read 4

libbpf: -- END LOG --
libbpf: failed to load program 'handle_exec'
libbpf: failed to load object 'bootstrap_bpf'
libbpf: failed to load BPF skeleton 'bootstrap_bpf': -4007
Failed to load and verify BPF skeleton



Thanks for your time,

Gilad Reti
