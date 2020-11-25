Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1732C44B3
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgKYQKK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 11:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgKYQKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 11:10:09 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DCCC0613D4
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 08:10:09 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id j19so2827296pgg.5
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=z0ix7dY6jKPcQ60mCCu4+4JPhZlqgAZ2zyr8rIjf3mg=;
        b=AIgoI0Ev9bB3x6+Pkb66tJM8H//KlD6j6hzu58CklGYFxL4advj9Kyzms99c8pEwhb
         rQhAs7wJBqBQCBDb7pE+jfGJudHMNQwUiUGdxpupYG91Cl2cOnBWA09tlCxK2hmqgGxk
         FiGQhbfYPTjRnfQ/tbro43+uDuBF/3UQLSfjU9gwiBnGveA0wdyChR0dDy9gpZSap3h8
         pN14rD5UgAlIkvimFtgyoIb6YdROjhqT3VkwJSCUkI+M4uxyOlugxNy5eHYPj6dgAEYq
         +/Fwjs5lH6lziLJHWkziXEYIc+txV8acVzfmdFkE616sAmjMXu29nV3RAwx/grFd9VAS
         LVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z0ix7dY6jKPcQ60mCCu4+4JPhZlqgAZ2zyr8rIjf3mg=;
        b=c4EtmNi8yzPLHKUnjSgW5SkzXcJZMx9wt/JxOBseGZxVMXOyEMDBCpQsFYOJFst+v8
         H7mxcm+gGdgWOu/DZdwxD6yleKkVcORm4gFhBtKLc5IbW+YPoAEuYo3xCF1ugfpaB/ZM
         wFSXj3subPVU70Lmi0bR2Q3f1Qx0M9bnvjaClfPaW0IMzaqe3JiGr2PZGBmRDqEKr9t4
         /QS5kmY+VOo0kkKeq3u51pyWJgLW9OjtDgfepXBAOSty8ZzhNxYaO96feKmiIbUJ9yBj
         xQZYkd8eIK0EvmwOdIZalDUQbK/dUa8KHndszA2fp4SVVuWsj4aCPIwFFkCQTQ6JU+S0
         84dg==
X-Gm-Message-State: AOAM532jXQmsVxcCvxpRKt2EKRhA8kl21fhlG33+f9JGAOeCIwshg5fW
        5ZzCOJNtM/U/Ltk71mb8osYPhikYBTYoK3vAs5Duy3DaSSG1lznR
X-Google-Smtp-Source: ABdhPJwt4aT1xd13p7rXHiQST78OudgSLoBkQ/Lvis96/pw/BoqyNz+hMGfsvjGAgAxsM1Pt7Qe40sVCtiYe/02+H/k=
X-Received: by 2002:a62:768b:0:b029:197:dea6:586e with SMTP id
 r133-20020a62768b0000b0290197dea6586emr358162pfc.44.1606320608663; Wed, 25
 Nov 2020 08:10:08 -0800 (PST)
MIME-Version: 1.0
From:   Srivats P <pstavirs@gmail.com>
Date:   Wed, 25 Nov 2020 21:39:57 +0530
Message-ID: <CANzUK58dwpX9HjfCZTyZa4oJX2iAczYEfQe5ojW1N_0NrYW7mw@mail.gmail.com>
Subject: How to read from pkt_end?
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

How do I read from the end of the packet in a XDP program? I tried the
below ebpf program to read the last 4 bytes of the packet, but the
verifier rejects it.

Program
=======
__section("prog")
int xdp_prog(struct xdp_md *ctx)
{
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;

    __u16 len = ((long)ctx->data_end - (long)ctx->data);
    __u16 ofs = len - 4;
    __u32 *mgc = (__u32*)(data+ofs);

    if ((data + len) > data_end)
        return XDP_ABORTED;

    if (*mgc == 0x1d10c0da)
        return XDP_DROP;

    return XDP_PASS;
}

llvm-objdump generated disassembly
==================================
Disassembly of section prog:
xdp_prog:
; {
       0:       r0 = 0
; void *data = (void *)(long)ctx->data;
       1:       r2 = *(u32 *)(r1 + 0)
; void *data_end = (void *)(long)ctx->data_end;
       2:       r3 = *(u32 *)(r1 + 4)
; __u16 len = ((long)ctx->data_end - (long)ctx->data);
       3:       r1 = r3
       4:       r1 -= r2
; __u16 ofs = len - 4;
       5:       r4 = r1
       6:       r4 &= 65535
; if ((data + len) > data_end)
       7:       r5 = r2
       8:       r5 += r4
       9:       if r5 > r3 goto +7 <LBB0_3>
; __u16 ofs = len - 4;
      10:       r1 += 65532
; __u32 *mgc = (__u32*)(data+ofs);
      11:       r1 &= 65535
      12:       r2 += r1
; if (*mgc == 0x1d10c0da)
      13:       r1 = *(u32 *)(r2 + 0)
      14:       r0 = 1
; return XDP_DROP;
      15:       if r1 == 487637210 goto +1 <LBB0_3>
      16:       r0 = 2

LBB0_3:
; }
      17:       exit


Verifier output (via ip link)
=============================
Prog section 'prog' rejected: Permission denied (13)!
 - Type:         6
 - Instructions: 18 (0 over limit)
 - License:

Verifier analysis:

0: (b7) r0 = 0
1: (61) r2 = *(u32 *)(r1 +0)
2: (61) r3 = *(u32 *)(r1 +4)
3: (bf) r1 = r3
4: (1f) r1 -= r2
5: (bf) r4 = r1
6: (57) r4 &= 65535
7: (bf) r5 = r2
8: (0f) r5 += r4
last_idx 8 first_idx 0
regs=10 stack=0 before 7: (bf) r5 = r2
regs=10 stack=0 before 6: (57) r4 &= 65535
regs=10 stack=0 before 5: (bf) r4 = r1
regs=2 stack=0 before 4: (1f) r1 -= r2
regs=6 stack=0 before 3: (bf) r1 = r3
regs=c stack=0 before 2: (61) r3 = *(u32 *)(r1 +4)
regs=4 stack=0 before 1: (61) r2 = *(u32 *)(r1 +0)
9: (2d) if r5 > r3 goto pc+7
 R0_w=inv0 R1_w=inv(id=0) R2_w=pkt(id=0,off=0,r=0,imm=0)
R3_w=pkt_end(id=0,off=0,imm=0)
R4_w=invP(id=0,umax_value=65535,var_off=(0x0; 0xffff))
R5_w=pkt(id=1,off=0,r=0,umax_value=65535,var_off=(0x0; 0xffff))
R10=fp0
10: (07) r1 += 65532
11: (57) r1 &= 65535
12: (0f) r2 += r1
last_idx 12 first_idx 0
regs=2 stack=0 before 11: (57) r1 &= 65535
regs=2 stack=0 before 10: (07) r1 += 65532
regs=2 stack=0 before 9: (2d) if r5 > r3 goto pc+7
regs=2 stack=0 before 8: (0f) r5 += r4
regs=2 stack=0 before 7: (bf) r5 = r2
regs=2 stack=0 before 6: (57) r4 &= 65535
regs=2 stack=0 before 5: (bf) r4 = r1
regs=2 stack=0 before 4: (1f) r1 -= r2
regs=6 stack=0 before 3: (bf) r1 = r3
regs=c stack=0 before 2: (61) r3 = *(u32 *)(r1 +4)
regs=4 stack=0 before 1: (61) r2 = *(u32 *)(r1 +0)
13: (61) r1 = *(u32 *)(r2 +0)
invalid access to packet, off=0 size=4, R2(id=2,off=0,r=0)
R2 offset is outside of the packet
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states
0 peak_states 0 mark_read 0

Error fetching program/map!

I did read the filter.txt documentation, but couldn't find anything
pertinent to this case where instead of adding fixed (literal value)
offsets to pkt, we want to work backwards from pkt_end - the above
program will always read within packet boundaries, but the length of
the packet can of course vary with each packet.

I also searched the list archives but couldn't find anything related.

I'm using Kernel version 5.3 (stock kernel with Ubuntu 18.04 LTS)

Srivats
