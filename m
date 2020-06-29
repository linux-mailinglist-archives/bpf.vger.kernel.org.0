Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240E120D5F0
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgF2TPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbgF2TOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:22 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0115C08E85B
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2020 22:25:48 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k7so7202577vso.2
        for <bpf@vger.kernel.org>; Sun, 28 Jun 2020 22:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qerzVf53hxGZF4Zi2z24Iv6v2VUVeFZxGTfRESWTNUA=;
        b=J9n5R9W0uCfpIfyihhG7KUPVz1ObVhJ1h42vrwy55IDvPh5m3/2gvU7IfWmH6GVYEY
         XVrAzMprdvb4RB9SmAnz4qeG3J14RqnqoQUHcdenyWgp7L5TwFFucH/QXaGltvavEs/o
         xjvvWhGafax5pDNTf7MDj3wQ7DjIMximBD3uRPqsfPbzOsCMeHHzm0j71XM07/KL6UPR
         ZBQ4wZg5toRiltDQYwY9gz5DfGAxDmp8jvpLxKpcfAnVMl4+6V5c7zB3hdxzhsxSbiVl
         uxeR8gjz41GRuEMzDX/uJnhK2VubT2oTehjzBokQm4mdxUgvNYh7BsLwqTQmJxT+FJRF
         HBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qerzVf53hxGZF4Zi2z24Iv6v2VUVeFZxGTfRESWTNUA=;
        b=ijGdlbngNj+mHNdTOnMCeuYTyPdby3qJIkRl9dazYymOKJVNDRBVrYB6/KabCUyHuQ
         FtEtXNaglI3WVEG4KBNMQ0MnvwwDxNkevPwqVi4a9S1b5b+i8xFxDNMj+4DyPZmsUU1n
         a6pOC0quh6FqnokXJRe/AKpL92WkGTL1R3LGS5oCSIXZFSWbdte1WP4jhCcLIG6vJ5uI
         QF8o2Rc5w2hOLl8Gmf1uOpZeglf1l5QeQKWumtKnirDTbKPLmXQjzwx0d4BHGjebWjhJ
         A3QxW5hHYwQSP9uiKy3l5V6T7sbzG9x21NrgivSxJFYYfn7h/Cb0YYCrA3HxulFl3qP2
         rCHQ==
X-Gm-Message-State: AOAM532Qy+F7VazXPHch67mdqK3Yvlph/w4wzpN0C0TFq/cJyXQnN+mL
        5uQ4jgJoMPY5i/z+qryOgPkf5GDG2byCABYtIGpxL0i9GVs=
X-Google-Smtp-Source: ABdhPJxpnaYhJ6cmhbh3WRWXp73R8o2/n8a5GkCkdHXbjo7ORhsCbNspHoivcmeNL5z5mb8sGn9wpFSAFB1r+s/TLkM=
X-Received: by 2002:a67:c894:: with SMTP id v20mr3897019vsk.145.1593408344856;
 Sun, 28 Jun 2020 22:25:44 -0700 (PDT)
MIME-Version: 1.0
From:   Wenbo Zhang <ethercflow@gmail.com>
Date:   Mon, 29 Jun 2020 13:25:33 +0800
Message-ID: <CABtjQmYObfTxZ_mZdhDBw_mmShJMofR3VeCH+GgATLrWD1x9+g@mail.gmail.com>
Subject: tp_btf: if (!struct->pointer_member) always actually false although
 pointer_member == NULL
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Zwb <ethercflow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I found in tp_btf program, direct access struct's pointer member's
behaviour isn't consistent with
BPF_CORE_READ. for example:

SEC("tp_btf/block_rq_issue")
int BPF_PROG(tp_btf__block_rq_issue, struct request_queue *q,
    struct request *rq)
{
        /* After echo none > /sys/block/$dev/queue/scheduler,
         * the $dev's q->elevator will be set to NULL.
         */
        if (!q->elevator)
                bpf_printk("direct access: noop\n");
        if (!BPF_CORE_READ(q, elevator))
                bpf_printk("FROM CORE READ: noop\n");
        return 0;
}

Although its value is NULL, from trace_pipe I can only see

> FROM CORE READ: noop

So it seems  `if (!q->elevator)` always return false.

I tested it with kernel 5.7.0-rc7+ and 5.8.0-rc1+, both have this problem.
clang version: clang version 10.0.0-4ubuntu1~18.04.1

Reproduce step:
1. Run this bpf prog;
2. Run `cat /sys/kernel/debug/tracing/trace_pipe` in other window;
3. Run `echo none > /sys/block/sdc/queue/scheduler`;  # please replace
sdc to your device;
4. Run `dd if=/dev/zero of=/dev/sdc  bs=1MiB count=200 oflag=direct`;


The output of  `llvm-objdump-10 -D bio.bpf.o` is:


bio.bpf.o:      file format ELF64-BPF


Disassembly of section tp_btf/block_rq_issue:

0000000000000000 tp_btf__block_rq_issue:
       0:       b7 02 00 00 08 00 00 00 r2 = 8
       1:       79 11 00 00 00 00 00 00 r1 = *(u64 *)(r1 + 0)
       2:       bf 16 00 00 00 00 00 00 r6 = r1
       3:       0f 26 00 00 00 00 00 00 r6 += r2
       4:       79 11 08 00 00 00 00 00 r1 = *(u64 *)(r1 + 8)
       5:       55 01 0e 00 00 00 00 00 if r1 != 0 goto +14 <LBB0_2>
       6:       b7 01 00 00 00 00 00 00 r1 = 0
       7:       73 1a fc ff 00 00 00 00 *(u8 *)(r10 - 4) = r1
       8:       b7 01 00 00 6f 6f 70 0a r1 = 175140719
       9:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r1
      10:       18 01 00 00 63 63 65 73 00 00 00 00 73 3a 20 6e r1 =
7935406810958488419 ll
      12:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
      13:       18 01 00 00 64 69 72 65 00 00 00 00 63 74 20 61 r1 =
6998721791186332004 ll
      15:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
      16:       bf a1 00 00 00 00 00 00 r1 = r10
      17:       07 01 00 00 e8 ff ff ff r1 += -24
      18:       b7 02 00 00 15 00 00 00 r2 = 21
      19:       85 00 00 00 06 00 00 00 call 6

00000000000000a0 LBB0_2:
      20:       bf a1 00 00 00 00 00 00 r1 = r10
      21:       07 01 00 00 e8 ff ff ff r1 += -24
      22:       b7 02 00 00 08 00 00 00 r2 = 8
      23:       bf 63 00 00 00 00 00 00 r3 = r6
      24:       85 00 00 00 04 00 00 00 call 4
      25:       79 a1 e8 ff 00 00 00 00 r1 = *(u64 *)(r10 - 24)
      26:       55 01 0e 00 00 00 00 00 if r1 != 0 goto +14 <LBB0_4>
      27:       b7 01 00 00 0a 00 00 00 r1 = 10
      28:       6b 1a fc ff 00 00 00 00 *(u16 *)(r10 - 4) = r1
      29:       b7 01 00 00 6e 6f 6f 70 r1 = 1886351214
      30:       63 1a f8 ff 00 00 00 00 *(u32 *)(r10 - 8) = r1
      31:       18 01 00 00 45 20 52 45 00 00 00 00 41 44 3a 20 r1 =
2322243604989485125 ll
      33:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
      34:       18 01 00 00 46 52 4f 4d 00 00 00 00 20 43 4f 52 r1 =
5931033040285291078 ll
      36:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
      37:       bf a1 00 00 00 00 00 00 r1 = r10
      38:       07 01 00 00 e8 ff ff ff r1 += -24
      39:       b7 02 00 00 16 00 00 00 r2 = 22
      40:       85 00 00 00 06 00 00 00 call 6

0000000000000148 LBB0_4:
      41:       b7 00 00 00 00 00 00 00 r0 = 0
      42:       95 00 00 00 00 00 00 00 exit

Disassembly of section license:

0000000000000000 LICENSE:
       0:       47      <unknown>
       0:       50      <unknown>
       0:       4c      <unknown>
       0:       00      <unknown>

Disassembly of section .rodata.str1.1:

0000000000000000 .rodata.str1.1:
       0:       64 69 72 65 63 74 20 61 w9 <<= 1629516899
       1:       63 63 65 73 73 3a 20 6e *(u32 *)(r3 + 29541) = r6
       2:       6f 6f 70 0a 00 46 52 4f <unknown>
       3:       4d 20 43 4f 52 45 20 52 <unknown>
       4:       45 41 44 3a 20 6e 6f 6f <unknown>
       5:       70      <unknown>
       5:       0a      <unknown>
       5:       00      <unknown>

Disassembly of section .BTF:

0000000000000000 .BTF:
       0:       9f eb 01 00 18 00 00 00 <unknown>
       1:       00 00 00 00 40 12 00 00 <unknown>
       2:       40 12 00 00 2c 0d 00 00 r0 = *(u32 *)skb[r1]
       3:       00 00 00 00 00 00 00 02 <unknown>
       4:       02 00 00 00 01 00 00 00 <unknown>
       5:       00 00 00 01 08 00 00 00 <unknown>
       6:       40 00 00 00 00 00 00 00 r0 = *(u32 *)skb[r0]
       7:       01 00 00 0d 04 00 00 00 <unknown>
       8:       18 00 00 00 01 00 00 00 1c 00 00 00 00 00 00 01 r0 =
72057594037927937 ll
      10:       04 00 00 00 20 00 00 01 w0 += 16777248
      11:       20 00 00 00 01 00 00 0c r0 = *(u32 *)skb[201326593]
      12:       03 00 00 00 4d 00 00 00 <unknown>
      13:       42 00 00 04 58 07 00 00 <unknown>
      14:       5b 00 00 00 07 00 00 00 <unknown>
      15:       00 00 00 00 66 00 00 00 <unknown>
      16:       08 00 00 00 40 00 00 00 <unknown>
      17:       6f 00 00 00 09 00 00 00 r0 <<= r0
      18:       80 00 00 00 75 00 00 00 <unknown>
      19:       0a 00 00 00 c0 00 00 00 <unknown>
      20:       7c 00 00 00 0b 00 00 00 w0 >>= w0
      21:       00 01 00 00 8c 00 00 00 <unknown>
      22:       2a 00 00 00 40 01 00 00 <unknown>
      23:       9d 00 00 00 2d 00 00 00 <unknown>
      24:       80 01 00 00 a4 00 00 00 <unknown>
      25:       2f 00 00 00 c0 01 00 00 r0 *= r0
      26:       ae 00 00 00 0f 00 00 00 if w0 < w0 goto +0 <.BTF+0xd8>
      27:       00 02 00 00 ba 00 00 00 <unknown>
      28:       30 00 00 00 40 02 00 00 r0 = *(u8 *)skb[576]
      29:       c7 00 00 00 0f 00 00 00 r0 s>>= 15
      30:       80 02 00 00 d4 00 00 00 <unknown>
      31:       32 00 00 00 c0 02 00 00 <unknown>
      32:       e5 00 00 00 22 00 00 00 <unknown>
      33:       00 03 00 00 ef 00 00 00 <unknown>
      34:       33 00 00 00 40 03 00 00 <unknown>
      35:       fb 00 00 00 19 00 00 00 <unknown>
      36:       80 03 00 00 03 01 00 00 <unknown>
      37:       04 00 00 00 a0 03 00 00 w0 += 928
      38:       06 01 00 00 34 00 00 00 <unknown>
      39:       c0 03 00 00 11 01 00 00 <unknown>
      40:       35 00 00 00 e0 03 00 00 if r0 >= 992 goto +0 <.BTF+0x148>
      41:       1c 01 00 00 40 00 00 00 w1 -= w0
      42:       00 04 00 00 21 01 00 00 <unknown>
      43:       46 00 00 00 00 06 00 00 <unknown>
      44:       29 01 00 00 4d 00 00 00 <unknown>
      45:       40 06 00 00 2d 01 00 00 r0 = *(u32 *)skb[r0]
      46:       04 00 00 00 80 06 00 00 w0 += 1664
      47:       38 01 00 00 0f 00 00 00 <unknown>
      48:       a0 06 00 00 43 01 00 00 <unknown>
      49:       33 00 00 00 c0 06 00 00 <unknown>
      50:       4f 01 00 00 0f 00 00 00 r1 |= r0
      51:       00 07 00 00 5e 01 00 00 <unknown>
      52:       22 00 00 00 40 07 00 00 <unknown>
      53:       6f 01 00 00 0f 00 00 00 r1 <<= r0
      54:       80 07 00 00 7c 01 00 00 <unknown>
      55:       0f 00 00 00 a0 07 00 00 r0 += r0
      56:       8a 01 00 00 0f 00 00 00 <unknown>
      57:       c0 07 00 00 95 01 00 00 <unknown>
      58:       04 00 00 00 e0 07 00 00 w0 += 2016
      59:       9f 01 00 00 4e 00 00 00 <unknown>
      60:       00 08 00 00 a7 01 00 00 <unknown>
      61:       52 00 00 00 40 08 00 00 <unknown>
      62:       b1 01 00 00 53 00 00 00 <unknown>
      63:       40 1c 00 00 b9 01 00 00 r0 = *(u32 *)skb[r1]
      64:       5a 00 00 00 80 1d 00 00 <unknown>
      65:       c6 01 00 00 44 00 00 00 if w1 s< 68 goto +0 <.BTF+0x210>
      66:       80 1e 00 00 cf 01 00 00 <unknown>
      67:       65 00 00 00 00 1f 00 00 if r0 s> 7936 goto +0 <.BTF+0x220>
      68:       d6 01 00 00 0f 00 00 00 if w1 s<= 15 goto +0 <.BTF+0x228>
      69:       40 22 00 00 f1 01 00 00 r0 = *(u32 *)skb[r2]
      70:       0f 00 00 00 60 22 00 00 r0 += r0
      71:       fc 01 00 00 0f 00 00 00 <unknown>
      72:       80 22 00 00 0d 02 00 00 <unknown>
      73:       04 00 00 00 a0 22 00 00 w0 += 8864
      74:       12 02 00 00 67 00 00 00 <unknown>
      75:       c0 22 00 00 1c 02 00 00 <unknown>
      76:       68 00 00 00 00 23 00 00 <unknown>
      77:       2c 02 00 00 6a 00 00 00 w2 *= w0
      78:       00 24 00 00 2f 02 00 00 <unknown>
      79:       44 00 00 00 40 24 00 00 w0 |= 9280
      80:       3c 02 00 00 35 00 00 00 w2 /= w0
      81:       c0 24 00 00 49 02 00 00 <unknown>
      82:       6b 00 00 00 00 25 00 00 *(u16 *)(r0 + 0) = r0
      83:       56 02 00 00 68 00 00 00 if w2 != 104 goto +0 <.BTF+0x2a0>
      84:       c0 27 00 00 61 02 00 00 <unknown>
      85:       68 00 00 00 c0 28 00 00 <unknown>
      86:       70 02 00 00 44 00 00 00 <unknown>
      87:       c0 29 00 00 81 02 00 00 <unknown>
      88:       35 00 00 00 40 2a 00 00 if r0 >= 10816 goto +0 <.BTF+0x2c8>
      89:       92 02 00 00 04 00 00 00 <unknown>
      90:       60 2a 00 00 a2 02 00 00 <unknown>
      91:       6d 00 00 00 80 2a 00 00 if r0 s> r0 goto +0 <.BTF+0x2e0>
      92:       aa 02 00 00 70 00 00 00 <unknown>
      93:       80 2b 00 00 b8 02 00 00 <unknown>
      94:       74 00 00 00 00 2c 00 00 w0 >>= 11264
      95:       c5 02 00 00 68 00 00 00 if r2 s< 104 goto +0 <.BTF+0x300>
      96:       c0 2c 00 00 d4 02 00 00 <unknown>
      97:       76 00 00 00 c0 2d 00 00 if w0 s>= 11712 goto +0 <.BTF+0x310>
      98:       e4 02 00 00 7d 00 00 00 <unknown>
      99:       80 2f 00 00 ec 02 00 00 <unknown>
     100:       44 00 00 00 c0 2f 00 00 w0 |= 12224
     101:       f9 02 00 00 7e 00 00 00 <unknown>
     102:       40 30 00 00 03 03 00 00 r0 = *(u32 *)skb[r3]
     103:       8a 00 00 00 40 37 00 00 <unknown>
     104:       0f 03 00 00 8a 00 00 00 r3 += r0
     105:       80 37 00 00 21 03 00 00 <unknown>
     106:       8a 00 00 00 c0 37 00 00 <unknown>
     107:       32 03 00 00 7b 00 00 00 <unknown>
     108:       00 38 00 00 45 03 00 00 <unknown>
     109:       8b 00 00 00 40 38 00 00 <unknown>
     110:       4e 03 00 00 5a 00 00 00 <unknown>
     111:       80 38 00 00 5b 03 00 00 <unknown>
     112:       8e 00 00 00 80 39 00 00 <unknown>
     113:       00 00 00 00 00 00 00 02 <unknown>
     114:       a5 00 00 00 00 00 00 00 if r0 < 0 goto +0 <.BTF+0x398>
     115:       00 00 00 02 9e 00 00 00 <unknown>
     116:       00 00 00 00 00 00 00 02 <unknown>
     117:       98 00 00 00 00 00 00 00 <unknown>
     118:       00 00 00 02 a6 00 00 00 <unknown>
     119:       00 00 00 00 00 00 00 02 <unknown>
     120:       0c 00 00 00 7c 00 00 00 w0 += w0
     121:       00 00 00 08 0d 00 00 00 <unknown>
     122:       00 00 00 00 02 00 00 0d <unknown>
     123:       0e 00 00 00 00 00 00 00 <unknown>
     124:       10 00 00 00 00 00 00 00 <unknown>
     125:       11 00 00 00 67 03 00 00 <unknown>
     126:       00 00 00 08 0f 00 00 00 <unknown>
     127:       70 03 00 00 00 00 00 01 <unknown>
     128:       04 00 00 00 20 00 00 00 w0 += 32
     129:       00 00 00 00 00 00 00 02 <unknown>
     130:       06 00 00 00 00 00 00 00 <unknown>
     131:       00 00 00 02 12 00 00 00 <unknown>
     132:       7d 03 00 00 13 00 00 04 if r3 s>= r0 goto +0 <.BTF+0x428>
     133:       60 00 00 00 81 03 00 00 <unknown>
     134:       11 00 00 00 00 00 00 00 <unknown>
     135:       89 03 00 00 13 00 00 00 <unknown>
     136:       40 00 00 00 91 03 00 00 r0 = *(u32 *)skb[r0]
     137:       0f 00 00 00 80 00 00 00 r0 += r0
     138:       98 03 00 00 14 00 00 00 <unknown>
     139:       a0 00 00 00 a1 03 00 00 <unknown>
     140:       14 00 00 00 b0 00 00 00 w0 -= 176
     141:       ab 03 00 00 14 00 00 00 <unknown>
     142:       c0 00 00 00 b9 03 00 00 <unknown>
     143:       15 00 00 00 d0 00 00 00 if r0 == 208 goto +0 <.BTF+0x480>
     144:       c3 03 00 00 16 00 00 00 lock *(u32 *)(r3 + 0) += r0
     145:       d8 00 00 00 cd 03 00 00 <unknown>
     146:       19 00 00 00 e0 00 00 00 <unknown>
     147:       dc 03 00 00 1b 00 00 00 <unknown>
     148:       00 01 00 00 e4 03 00 00 <unknown>
     149:       1f 00 00 00 c0 01 00 00 r0 -= r0
     150:       ee 03 00 00 22 00 00 00 <unknown>
     151:       00 02 00 00 00 00 00 00 <unknown>
     152:       23 00 00 00 40 02 00 00 <unknown>
     153:       f9 03 00 00 14 00 00 00 <unknown>
     154:       40 02 00 00 01 04 00 00 r0 = *(u32 *)skb[r0]
     155:       14 00 00 00 50 02 00 00 w0 -= 592
     156:       0d 04 00 00 19 00 00 00 <unknown>
     157:       60 02 00 00 16 04 00 00 <unknown>
     158:       24 00 00 00 80 02 00 00 w0 *= 640
     159:       20 04 00 00 25 00 00 00 r0 = *(u32 *)skb[37]
     160:       c0 02 00 00 28 04 00 00 <unknown>
     161:       28 00 00 00 00 03 00 00 r0 = *(u16 *)skb[768]
     162:       00 00 00 00 00 00 00 02 <unknown>
     163:       9f 00 00 00 37 04 00 00 <unknown>
     164:       00 00 00 01 02 00 00 00 <unknown>
     165:       10 00 00 00 46 04 00 00 <unknown>
     166:       00 00 00 08 16 00 00 00 <unknown>
     167:       53 04 00 00 00 00 00 08 <unknown>
     168:       17 00 00 00 56 04 00 00 r0 -= 1110
     169:       00 00 00 08 18 00 00 00 <unknown>
     170:       5b 04 00 00 00 00 00 01 <unknown>
     171:       01 00 00 00 08 00 00 00 <unknown>
     172:       69 04 00 00 00 00 00 08 r4 = *(u16 *)(r0 + 0)
     173:       1a 00 00 00 00 00 00 00 <unknown>
     174:       01 00 00 04 04 00 00 00 <unknown>
     175:       72 04 00 00 04 00 00 00 <unknown>
     176:       00 00 00 00 7a 04 00 00 <unknown>
     177:       04 00 00 04 18 00 00 00 w0 += 24
     178:       84 04 00 00 1c 00 00 00 w4 = -w4
     179:       00 00 00 00 8e 04 00 00 <unknown>
     180:       0f 00 00 00 40 00 00 00 r0 += r0
     181:       96 04 00 00 0f 00 00 00 <unknown>
     182:       60 00 00 00 9d 04 00 00 <unknown>
     183:       0f 00 00 00 80 00 00 00 r0 += r0
     184:       aa 04 00 00 00 00 00 08 <unknown>
     185:       1d 00 00 00 b3 04 00 00 if r0 == r0 goto +0 <.BTF+0x5d0>
     186:       00 00 00 08 1e 00 00 00 <unknown>
     187:       b7 04 00 00 00 00 00 08 r4 = 134217728
     188:       02 00 00 00 00 00 00 00 <unknown>
     189:       00 00 00 02 20 00 00 00 <unknown>
     190:       bd 04 00 00 00 00 00 08 if r4 <= r0 goto +0 <.BTF+0x5f8>
     191:       21 00 00 00 00 00 00 00 <unknown>
     192:       01 00 00 0d 00 00 00 00 <unknown>
     193:       00 00 00 00 11 00 00 00 <unknown>
     194:       00 00 00 00 00 00 00 02 <unknown>
                ...
     196:       00 00 00 05 00 00 00 00 <unknown>
     197:       00 00 00 00 00 00 00 02 <unknown>
     198:       26 00 00 00 00 00 00 00 if w0 > 0 goto +0 <.BTF+0x638>
     199:       00 00 00 02 7e 00 00 00 <unknown>
     200:       ca 04 00 00 03 00 00 04 <unknown>
     201:       10 00 00 00 d2 04 00 00 <unknown>
     202:       27 00 00 00 00 00 00 00 r0 *= 0
     203:       da 04 00 00 0f 00 00 00 <unknown>
     204:       40 00 00 00 e1 04 00 00 r0 = *(u32 *)skb[r0]
     205:       0f 00 00 00 60 00 00 00 r0 += r0
     206:       00 00 00 00 00 00 00 02 <unknown>
     207:       a4 00 00 00 00 00 00 00 w0 ^= 0
     208:       00 00 00 03 00 00 00 00 <unknown>
     209:       26 00 00 00 29 00 00 00 if w0 > 41 goto +0 <.BTF+0x690>
     210:       00 00 00 00 eb 04 00 00 <unknown>
     211:       00 00 00 01 04 00 00 00 <unknown>
     212:       20 00 00 00 00 00 00 00 r0 = *(u32 *)skb[0]
     213:       00 00 00 02 2b 00 00 00 <unknown>
     214:       ff 04 00 00 00 00 00 08 <unknown>
     215:       2c 00 00 00 00 00 00 00 w0 *= w0
     216:       01 00 00 0d 04 00 00 00 <unknown>
     217:       00 00 00 00 07 00 00 00 <unknown>
     218:       00 00 00 00 00 00 00 02 <unknown>
     219:       2e 00 00 00 00 00 00 00 if w0 > w0 goto +0 <.BTF+0x6e0>
     220:       00 00 00 0a 96 00 00 00 <unknown>
     221:       00 00 00 00 00 00 00 02 <unknown>
     222:       94 00 00 00 00 00 00 00 <unknown>
     223:       00 00 00 02 31 00 00 00 <unknown>
     224:       00 00 00 00 00 00 00 02 <unknown>
     225:       95 00 00 00 00 00 00 00 exit
     226:       00 00 00 02 92 00 00 00 <unknown>
     227:       13 05 00 00 00 00 00 01 <unknown>
     228:       08 00 00 00 40 00 00 00 <unknown>
     229:       25 05 00 00 00 00 00 08 if r5 > 134217728 goto +0 <.BTF+0x730>
     230:       0f 00 00 00 2b 05 00 00 r0 += r0
     231:       00 00 00 08 36 00 00 00 <unknown>
     232:       36 05 00 00 01 00 00 04 if w5 >= 67108865 goto +0 <.BTF+0x748>
     233:       04 00 00 00 00 00 00 00 w0 += 0
     234:       37 00 00 00 00 00 00 00 r0 /= 0
     235:       00 00 00 00 01 00 00 05 <unknown>
     236:       04 00 00 00 3f 05 00 00 w0 += 1343
     237:       38 00 00 00 00 00 00 00 <unknown>
     238:       45 05 00 00 01 00 00 04 <unknown>
     239:       04 00 00 00 52 05 00 00 w0 += 1362
     240:       39 00 00 00 00 00 00 00 <unknown>
     241:       5b 05 00 00 00 00 00 08 <unknown>
     242:       3a 00 00 00 6b 05 00 00 <unknown>
     243:       01 00 00 04 04 00 00 00 <unknown>
     244:       00 00 00 00 3b 00 00 00 <unknown>
                ...
     246:       03 00 00 05 04 00 00 00 <unknown>
     247:       75 05 00 00 19 00 00 00 if r5 s>= 25 goto +0 <.BTF+0x7c0>
                ...
     249:       3c 00 00 00 00 00 00 00 w0 /= w0
     250:       00 00 00 00 3d 00 00 00 <unknown>
                ...
     252:       02 00 00 04 02 00 00 00 <unknown>
     253:       79 05 00 00 16 00 00 00 r5 = *(u64 *)(r0 + 0)
     254:       00 00 00 00 80 05 00 00 <unknown>
     255:       16 00 00 00 08 00 00 00 if w0 == 8 goto +0 <.BTF+0x800>
     256:       00 00 00 00 02 00 00 04 <unknown>
     257:       04 00 00 00 88 05 00 00 w0 += 1416
     258:       3e 00 00 00 00 00 00 00 if w0 >= w0 goto +0 <.BTF+0x818>
     259:       97 05 00 00 3e 00 00 00 <unknown>
     260:       10 00 00 00 9c 05 00 00 <unknown>
     261:       00 00 00 08 3f 00 00 00 <unknown>
     262:       a0 05 00 00 00 00 00 08 <unknown>
     263:       14 00 00 00 a6 05 00 00 w0 -= 1446
     264:       0c 00 00 84 40 00 00 00 w0 += w0
     265:       ae 05 00 00 41 00 00 00 if w5 < w0 goto +0 <.BTF+0x850>
     266:       00 00 00 00 b3 05 00 00 <unknown>
     267:       44 00 00 00 40 00 00 00 w0 |= 64
     268:       b9 05 00 00 46 00 00 00 <unknown>
     269:       c0 00 00 00 c0 05 00 00 <unknown>
     270:       47 00 00 00 00 01 00 00 r0 |= 256
     271:       c5 05 00 00 48 00 00 00 if r5 s< 72 goto +0 <.BTF+0x880>
     272:       40 01 00 00 cb 05 00 00 r0 = *(u32 *)skb[r0]
     273:       49 00 00 00 80 01 00 00 <unknown>
     274:       ce 05 00 00 4a 00 00 00 if w5 s< w0 goto +0 <.BTF+0x898>
     275:       c0 01 00 00 d3 05 00 00 <unknown>
     276:       0f 00 00 00 e0 01 00 01 r0 += r0
     277:       e5 05 00 00 0f 00 00 00 <unknown>
     278:       e1 01 00 01 f4 05 00 00 <unknown>
     279:       0f 00 00 00 e2 01 00 01 r0 += r0
     280:       0a 06 00 00 0f 00 00 00 <unknown>
     281:       e3 01 00 01 23 06 00 00 <unknown>
     282:       0f 00 00 00 e4 01 00 01 r0 += r0
     283:       00 00 00 00 00 00 00 02 <unknown>
     284:       42 00 00 00 00 00 00 00 <unknown>
     285:       00 00 00 0a 43 00 00 00 <unknown>
     286:       33 06 00 00 00 00 00 01 <unknown>
     287:       01 00 00 00 08 00 00 01 <unknown>
     288:       38 06 00 00 02 00 00 04 <unknown>
     289:       10 00 00 00 42 06 00 00 <unknown>
     290:       45 00 00 00 00 00 00 00 <unknown>
     291:       47 06 00 00 45 00 00 00 r6 |= 69
     292:       40 00 00 00 00 00 00 00 r0 = *(u32 *)skb[r0]
     293:       00 00 00 02 44 00 00 00 <unknown>
     294:       00 00 00 00 00 00 00 02 <unknown>
     295:       40 00 00 00 00 00 00 00 r0 = *(u32 *)skb[r0]
     296:       00 00 00 02 a3 00 00 00 <unknown>
     297:       00 00 00 00 00 00 00 02 <unknown>
     298:       a2 00 00 00 00 00 00 00 <unknown>
     299:       00 00 00 02 a0 00 00 00 <unknown>
     300:       ce 05 00 00 01 00 00 04 if w5 s< w0 goto +0 <.BTF+0x968>
     301:       04 00 00 00 4c 06 00 00 w0 += 1612
     302:       4b 00 00 00 00 00 00 00 <unknown>
     303:       55 06 00 00 00 00 00 08 if r6 != 134217728 goto +0 <.BTF+0x980>
     304:       4c 00 00 00 60 06 00 00 w0 |= w0
     305:       01 00 00 04 04 00 00 00 <unknown>
     306:       70 06 00 00 19 00 00 00 <unknown>
                ...
     308:       00 00 00 02 9d 00 00 00 <unknown>
     309:       00 00 00 00 00 00 00 02 <unknown>
     310:       99 00 00 00 75 06 00 00 <unknown>
     311:       05 00 00 04 28 00 00 00 goto +1024 <.BTF+0x29c0>
     312:       81 06 00 00 1d 00 00 00 <unknown>
     313:       00 00 00 00 86 06 00 00 <unknown>
     314:       1d 00 00 00 40 00 00 00 if r0 == r0 goto +0 <.BTF+0x9d8>
     315:       8a 06 00 00 1d 00 00 00 <unknown>
     316:       80 00 00 00 8e 06 00 00 <unknown>
     317:       50 00 00 00 c0 00 00 00 r0 = *(u8 *)skb[r0]
     318:       99 06 00 00 1d 00 00 00 <unknown>
     319:       00 01 00 00 9f 06 00 00 <unknown>
     320:       00 00 00 08 51 00 00 00 <unknown>
     321:       a3 06 00 00 00 00 00 08 <unknown>
     322:       0f 00 00 00 00 00 00 00 r0 += r0
     323:       00 00 00 03 00 00 00 00 <unknown>
     324:       4f 00 00 00 29 00 00 00 r0 |= r0
     325:       10 00 00 00 a9 06 00 00 <unknown>
     326:       04 00 00 04 28 00 00 00 w0 += 40
     327:       b3 05 00 00 54 00 00 00 <unknown>
     328:       00 00 00 00 b4 06 00 00 <unknown>
     329:       33 00 00 00 80 00 00 00 <unknown>
     330:       bc 06 00 00 57 00 00 00 w6 = w0
     331:       c0 00 00 00 c5 06 00 00 <unknown>
     332:       50 00 00 00 00 01 00 00 r0 = *(u8 *)skb[r0]
     333:       cb 06 00 00 02 00 00 04 <unknown>
     334:       10 00 00 00 42 06 00 00 <unknown>
     335:       55 00 00 00 00 00 00 00 if r0 != 0 goto +0 <.BTF+0xa80>
     336:       d6 06 00 00 56 00 00 00 if w6 s<= 86 goto +0 <.BTF+0xa88>
     337:       40 00 00 00 00 00 00 00 r0 = *(u32 *)skb[r0]
     338:       00 00 00 02 54 00 00 00 <unknown>
     339:       00 00 00 00 00 00 00 02 <unknown>
     340:       55 00 00 00 00 00 00 00 if r0 != 0 goto +0 <.BTF+0xaa8>
     341:       00 00 00 02 58 00 00 00 <unknown>
     342:       00 00 00 00 01 00 00 0d <unknown>
                ...
     344:       59 00 00 00 00 00 00 00 <unknown>
     345:       00 00 00 02 53 00 00 00 <unknown>
     346:       dc 06 00 00 03 00 00 04 <unknown>
     347:       20 00 00 00 e8 06 00 00 r0 = *(u32 *)skb[1768]
     348:       5b 00 00 00 00 00 00 00 <unknown>
     349:       b3 05 00 00 44 00 00 00 <unknown>
     350:       40 00 00 00 ed 06 00 00 r0 = *(u32 *)skb[r0]
     351:       61 00 00 00 c0 00 00 00 r0 = *(u32 *)(r0 + 0)
     352:       f2 06 00 00 00 00 00 08 <unknown>
     353:       5c 00 00 00 00 07 00 00 w0 &= w0
     354:       00 00 00 08 5d 00 00 00 <unknown>
     355:       00 00 00 00 01 00 00 04 <unknown>
     356:       08 00 00 00 72 04 00 00 <unknown>
     357:       5e 00 00 00 00 00 00 00 if w0 != w0 goto +0 <.BTF+0xb30>
     358:       0b 07 00 00 00 00 00 08 <unknown>
     359:       5f 00 00 00 0f 07 00 00 r0 &= r0
     360:       00 00 00 08 60 00 00 00 <unknown>
     361:       15 07 00 00 00 00 00 01 if r7 == 16777216 goto +0 <.BTF+0xb50>
     362:       08 00 00 00 40 00 00 01 <unknown>
     363:       23 07 00 00 00 00 00 08 <unknown>
     364:       62 00 00 00 00 00 00 00 <unknown>
     365:       00 00 00 02 63 00 00 00 <unknown>
     366:       00 00 00 00 01 00 00 0d <unknown>
            ...
     368:       64 00 00 00 00 00 00 00 w0 <<= 0
     369:       00 00 00 02 5a 00 00 00 <unknown>
     370:       2f 07 00 00 1a 00 00 04 r7 *= r0
     371:       68 00 00 00 3c 07 00 00 <unknown>
     372:       33 00 00 00 00 00 00 00 <unknown>
     373:       47 07 00 00 33 00 00 00 r7 |= 51
     374:       40 00 00 00 59 07 00 00 r0 = *(u32 *)skb[r0]
     375:       33 00 00 00 80 00 00 00 <unknown>
     376:       6c 07 00 00 0f 00 00 00 w7 <<= w0
     377:       c0 00 00 00 7b 07 00 00 <unknown>
     378:       0f 00 00 00 e0 00 00 00 r0 += r0
     379:       8b 07 00 00 0f 00 00 00 <unknown>
     380:       00 01 00 00 99 07 00 00 <unknown>
     381:       0f 00 00 00 20 01 00 00 r0 += r0
     382:       a5 07 00 00 0f 00 00 00 if r7 < 15 goto +0 <.BTF+0xbf8>
     383:       40 01 00 00 b6 07 00 00 r0 = *(u32 *)skb[r0]
     384:       0f 00 00 00 60 01 00 00 r0 += r0
     385:       ca 07 00 00 0f 00 00 00 <unknown>
     386:       80 01 00 00 dd 07 00 00 <unknown>
     387:       0f 00 00 00 a0 01 00 00 r0 += r0
     388:       ee 07 00 00 0f 00 00 00 <unknown>
     389:       c0 01 00 00 f5 07 00 00 <unknown>
     390:       0f 00 00 00 e0 01 00 00 r0 += r0
     391:       fc 07 00 00 0f 00 00 00 <unknown>
     392:       00 02 00 00 10 08 00 00 <unknown>
     393:       0f 00 00 00 20 02 00 00 r0 += r0
     394:       27 08 00 00 0f 00 00 00 r8 *= 15
     395:       40 02 00 00 3e 08 00 00 r0 = *(u32 *)skb[r0]
     396:       0f 00 00 00 60 02 00 00 r0 += r0
     397:       57 08 00 00 0f 00 00 00 r8 &= 15
     398:       80 02 00 00 6b 08 00 00 <unknown>
     399:       0f 00 00 00 a0 02 00 00 r0 += r0
     400:       7d 08 00 00 14 00 00 00 if r8 s>= r0 goto +0 <.BTF+0xc88>
     401:       c0 02 00 00 8a 08 00 00 <unknown>
     402:       14 00 00 00 d0 02 00 00 w0 -= 720
     403:       a1 08 00 00 14 00 00 00 <unknown>
     404:       e0 02 00 00 b6 08 00 00 <unknown>
     405:       18 00 00 00 f0 02 00 00 c1 08 00 00 18 00 00 00 r0 =
103079215856 ll
     407:       f8 02 00 00 d4 08 00 00 <unknown>
     408:       18 00 00 00 00 03 00 00 f3 08 00 00 66 00 00 00 r0 =
438086664960 ll
     410:       20 03 00 00 f9 08 00 00 r0 = *(u32 *)skb[2297]
     411:       03 00 00 06 04 00 00 00 <unknown>
     412:       09 09 00 00 00 00 00 00 <unknown>
     413:       18 09 00 00 01 00 00 00 25 09 00 00 02 00 00 00 r9 =
8589934593 ll
     415:       00 00 00 00 00 00 00 02 <unknown>
     416:       9a 00 00 00 32 09 00 00 <unknown>
     417:       04 00 00 04 20 00 00 00 w0 += 32
     418:       38 09 00 00 5b 00 00 00 <unknown>
     419:       00 00 00 00 3e 09 00 00 <unknown>
     420:       35 00 00 00 40 00 00 00 if r0 >= 64 goto +0 <.BTF+0xd28>
     421:       48 09 00 00 69 00 00 00 r0 = *(u16 *)skb[r0]
     422:       60 00 00 00 4c 09 00 00 <unknown>
     423:       44 00 00 00 80 00 00 00 w0 |= 128
     424:       56 09 00 00 01 00 00 04 if w9 != 67108865 goto +0 <.BTF+0xd48>
     425:       04 00 00 00 97 05 00 00 w0 += 1431
     426:       19 00 00 00 00 00 00 00 <unknown>
     427:       00 00 00 00 00 00 00 02 <unknown>
     428:       93 00 00 00 6c 09 00 00 <unknown>
     429:       04 00 00 04 58 00 00 00 w0 += 88
     430:       79 09 00 00 5a 00 00 00 r9 = *(u64 *)(r0 + 0)
     431:       00 00 00 00 7e 09 00 00 <unknown>
     432:       53 00 00 00 00 01 00 00 <unknown>
     433:       84 09 00 00 6c 00 00 00 w9 = -w9
     434:       40 02 00 00 87 09 00 00 r0 = *(u32 *)skb[r0]
     435:       04 00 00 00 80 02 00 00 w0 += 640
     436:       00 00 00 00 00 00 00 02 <unknown>
     437:       a7 00 00 00 8b 09 00 00 r0 ^= 2443
     438:       04 00 00 04 20 00 00 00 w0 += 32
     439:       9c 09 00 00 4d 00 00 00 <unknown>
     440:       00 00 00 00 a6 09 00 00 <unknown>
     441:       04 00 00 00 40 00 00 00 w0 += 64
     442:       ac 09 00 00 10 00 00 00 w9 ^= w0
     443:       80 00 00 00 b2 09 00 00 <unknown>
     444:       6e 00 00 00 c0 00 00 00 if w0 s> w0 goto +0 <.BTF+0xde8>
     445:       00 00 00 00 00 00 00 02 <unknown>
     446:       6f 00 00 00 00 00 00 00 r0 <<= r0
     447:       00 00 00 0a 9b 00 00 00 <unknown>
     448:       aa 02 00 00 02 00 00 04 <unknown>
     449:       10 00 00 00 42 06 00 00 <unknown>
     450:       71 00 00 00 00 00 00 00 r0 = *(u8 *)(r0 + 0)
     451:       ed 06 00 00 72 00 00 00 <unknown>
     452:       40 00 00 00 00 00 00 00 r0 = *(u32 *)skb[r0]
     453:       00 00 00 02 70 00 00 00 <unknown>
     454:       00 00 00 00 00 00 00 02 <unknown>
     455:       73 00 00 00 00 00 00 00 *(u8 *)(r0 + 0) = r0
     456:       01 00 00 0d 00 00 00 00 <unknown>
     457:       00 00 00 00 71 00 00 00 <unknown>
     458:       b6 09 00 00 00 00 00 08 if w9 <= 134217728 goto +0 <.BTF+0xe58>
     459:       75 00 00 00 c8 09 00 00 if r0 s>= 2504 goto +0 <.BTF+0xe60>
     460:       02 00 00 04 18 00 00 00 <unknown>
     461:       d8 09 00 00 35 00 00 00 <unknown>
     462:       00 00 00 00 dd 09 00 00 <unknown>
     463:       44 00 00 00 40 00 00 00 w0 |= 64
     464:       e2 09 00 00 07 00 00 84 <unknown>
     465:       38 00 00 00 ed 09 00 00 <unknown>
     466:       5b 00 00 00 00 00 00 00 <unknown>
     467:       f3 09 00 00 33 00 00 00 <unknown>
     468:       40 00 00 00 04 0a 00 00 r0 = *(u32 *)skb[r0]
     469:       77 00 00 00 80 00 00 00 r0 >>= 128
     470:       0c 0a 00 00 77 00 00 00 w10 += w0
     471:       c0 00 00 00 1b 0a 00 00 <unknown>
     472:       7b 00 00 00 00 01 00 01 *(u64 *)(r0 + 0) = r0
     473:       28 0a 00 00 7b 00 00 00 r0 = *(u16 *)skb[123]
     474:       01 01 00 01 35 0a 00 00 <unknown>
     475:       70 00 00 00 40 01 00 00 <unknown>
     476:       00 00 00 00 00 00 00 02 <unknown>
     477:       78 00 00 00 39 0a 00 00 <unknown>
     478:       00 00 00 08 79 00 00 00 <unknown>
     479:       00 00 00 00 01 00 00 0d <unknown>
                ...
     481:       7a 00 00 00 00 00 00 00 <unknown>
     482:       00 00 00 02 76 00 00 00 <unknown>
     483:       4b 0a 00 00 00 00 00 08 <unknown>
     484:       7c 00 00 00 50 0a 00 00 w0 >>= w0
     485:       00 00 00 01 01 00 00 00 <unknown>
     486:       08 00 00 04 00 00 00 00 <unknown>
     487:       00 00 00 02 97 00 00 00 <unknown>
     488:       56 0a 00 00 08 00 00 04 if w10 != 67108872 goto +0 <.BTF+0xf48>
     489:       e0 00 00 00 5e 0a 00 00 <unknown>
     490:       7f 00 00 00 00 00 00 00 r0 >>= r0
     491:       67 0a 00 00 0f 00 00 00 r10 <<= 15
     492:       40 00 00 00 71 0a 00 00 r0 = *(u32 *)skb[r0]
     493:       80 00 00 00 80 00 00 00 <unknown>
     494:       7a 0a 00 00 80 00 00 00 <unknown>
     495:       c0 02 00 00 84 0a 00 00 <unknown>
     496:       35 00 00 00 00 05 00 00 if r0 >= 1280 goto +0 <.BTF+0xf88>
     497:       90 0a 00 00 89 00 00 00 <unknown>
     498:       40 05 00 00 9c 0a 00 00 r0 = *(u32 *)skb[r0]
     499:       5a 00 00 00 c0 05 00 00 <unknown>
     500:       a8 0a 00 00 6c 00 00 00 <unknown>
     501:       c0 06 00 00 00 00 00 00 <unknown>
     502:       00 00 00 02 a1 00 00 00 <unknown>
     503:       b9 0a 00 00 00 00 00 08 <unknown>
     504:       81 00 00 00 c3 0a 00 00 <unknown>
     505:       08 00 00 04 48 00 00 00 <unknown>
     506:       d8 09 00 00 35 00 00 00 <unknown>
     507:       00 00 00 00 cd 0a 00 00 <unknown>
     508:       04 00 00 00 20 00 00 00 w0 += 32
     509:       d4 0a 00 00 04 00 00 00 <unknown>
     510:       40 00 00 00 dc 0a 00 00 r0 = *(u32 *)skb[r0]
     511:       82 00 00 00 80 00 00 00 <unknown>
     512:       e5 0a 00 00 22 00 00 00 <unknown>
     513:       c0 00 00 00 ef 0a 00 00 <unknown>
     514:       83 00 00 00 00 01 00 00 <unknown>
     515:       f5 0a 00 00 86 00 00 00 <unknown>
     516:       40 01 00 00 fa 0a 00 00 r0 = *(u32 *)skb[r0]
     517:       74 00 00 00 80 01 00 00 w0 >>= 384
     518:       00 00 00 00 00 00 00 02 <unknown>
     519:       22 00 00 00 00 00 00 00 <unknown>
     520:       00 00 00 02 84 00 00 00 <unknown>
     521:       ff 0a 00 00 00 00 00 08 <unknown>
     522:       85 00 00 00 00 00 00 00 call 0
     523:       02 00 00 0d 22 00 00 00 <unknown>
     524:       00 00 00 00 34 00 00 00 <unknown>
     525:       00 00 00 00 22 00 00 00 <unknown>
     526:       00 00 00 00 00 00 00 02 <unknown>
     527:       87 00 00 00 0f 0b 00 00 r0 = -r0
     528:       00 00 00 08 88 00 00 00 <unknown>
     529:       00 00 00 00 02 00 00 0d <unknown>
                ...
     531:       22 00 00 00 00 00 00 00 <unknown>
     532:       22 00 00 00 1e 0b 00 00 <unknown>
     533:       02 00 00 04 10 00 00 00 <unknown>
     534:       dd 09 00 00 11 00 00 00 if r9 s<= r0 goto +0 <.BTF+0x10b8>
     535:       00 00 00 00 97 05 00 00 <unknown>
     536:       11 00 00 00 40 00 00 00 <unknown>
     537:       00 00 00 00 00 00 00 02 <unknown>
     538:       9c 00 00 00 27 0b 00 00 <unknown>
     539:       00 00 00 08 8c 00 00 00 <unknown>
     540:       2e 0b 00 00 00 00 00 08 if w11 > w0 goto +0 <.BTF+0x10e8>
     541:       8d 00 00 00 3e 0b 00 00 <unknown>
     542:       00 00 00 08 33 00 00 00 <unknown>
     543:       00 00 00 00 00 00 00 03 <unknown>
     544:       00 00 00 00 1d 00 00 00 <unknown>
     545:       29 00 00 00 05 00 00 00 <unknown>
     546:       00 00 00 00 00 00 00 03 <unknown>
     547:       00 00 00 00 43 00 00 00 <unknown>
     548:       29 00 00 00 04 00 00 00 <unknown>
     549:       4b 0c 00 00 00 00 00 0e <unknown>
     550:       8f 00 00 00 01 00 00 00 <unknown>
     551:       53 0c 00 00 01 00 00 0f <unknown>
     552:       00 00 00 00 90 00 00 00 <unknown>
     553:       00 00 00 00 04 00 00 00 <unknown>
     554:       d4 00 00 00 00 00 00 07 <unknown>
     555:       00 00 00 00 5b 0c 00 00 <unknown>
     556:       00 00 00 07 00 00 00 00 <unknown>
     557:       6b 0c 00 00 00 00 00 07 *(u16 *)(r10 + 0) = r0
     558:       00 00 00 00 76 0c 00 00 <unknown>
     559:       00 00 00 07 00 00 00 00 <unknown>
     560:       84 0c 00 00 00 00 00 07 <unknown>
     561:       00 00 00 00 8f 0c 00 00 <unknown>
     562:       00 00 00 07 00 00 00 00 <unknown>
     563:       9e 0c 00 00 00 00 00 07 <unknown>
     564:       00 00 00 00 ae 0c 00 00 <unknown>
     565:       00 00 00 07 00 00 00 00 <unknown>
     566:       12 02 00 00 00 00 00 07 <unknown>
     567:       00 00 00 00 c0 0c 00 00 <unknown>
     568:       00 00 00 07 00 00 00 00 <unknown>
     569:       c8 0c 00 00 00 00 00 07 <unknown>
     570:       00 00 00 00 cf 0c 00 00 <unknown>
     571:       00 00 00 07 00 00 00 00 <unknown>
     572:       d6 0c 00 00 00 00 00 07 <unknown> <.BTF+0x11e8>
     573:       00 00 00 00 e5 0c 00 00 <unknown>
     574:       00 00 00 07 00 00 00 00 <unknown>
     575:       ed 0c 00 00 00 00 00 07 <unknown>
     576:       00 00 00 00 f9 0c 00 00 <unknown>
     577:       00 00 00 07 00 00 00 00 <unknown>
     578:       04 0d 00 00 00 00 00 07 <unknown>
     579:       00 00 00 00 c0 05 00 00 <unknown>
     580:       00 00 00 07 00 00 00 00 <unknown>
     581:       0e 0d 00 00 00 00 00 07 <unknown>
     582:       00 00 00 00 13 0d 00 00 <unknown>
     583:       00 00 00 07 00 00 00 00 <unknown>
     584:       75 00 00 00 00 00 00 07 if r0 s>= 117440512 goto +0
<.BTF+0x1248>
     585:       00 00 00 00 1b 0d 00 00 <unknown>
     586:       00 00 00 07 00 00 00 00 <unknown>
     587:       00 6c 6f 6e 67 20 6c 6f <unknown>
     588:       6e 67 20 75 6e 73 69 67 if w7 s> w6 goto +29984 <.BTF+0x3bb68>
     589:       6e 65 64 20 69 6e 74 00 if w5 s> w6 goto +8292 <.BTF+0x11590>
     590:       63 74 78 00 69 6e 74 00 *(u32 *)(r4 + 120) = r7
     591:       74 70 5f 62 74 66 5f 5f w0 >>= 1600087668
     592:       62 6c 6f 63 6b 5f 72 71 <unknown>
     593:       5f 69 73 73 75 65 00 74 r9 &= r6
     594:       70 5f 62 74 66 2f 62 6c <unknown>
     595:       6f 63 6b 5f 72 71 5f 69 r3 <<= r6
     596:       73 73 75 65 00 72 65 71 *(u8 *)(r3 + 25973) = r7
     597:       75 65 73 74 5f 71 75 65 if r5 s>= 1702195551 goto
+29811 <.BTF+0x3b648>
     598:       75 65 00 6c 61 73 74 5f if r5 s>= 1601467233 goto
+27648 <.BTF+0x372b8>
     599:       6d 65 72 67 65 00 65 6c if r5 s> r6 goto +26482 <.BTF+0x34e50>
     600:       65 76 61 74 6f 72 00 73 if r6 s> 1929409135 goto
+29793 <.BTF+0x3b5d0>
     601:       74 61 74 73 00 72 71 5f w1 >>= 1601270272
     602:       71 6f 73 00 6d 61 6b 65 <unknown>
     603:       5f 72 65 71 75 65 73 74 r2 &= r7
     604:       5f 66 6e 00 64 6d 61 5f r6 &= r6
     605:       64 72 61 69 6e 5f 6e 65 w2 <<= 1701732206
     606:       65 64 65 64 00 6d 71 5f if r4 s> 1601268992 goto
+25701 <.BTF+0x33620>
     607:       6f 70 73 00 71 75 65 75 r0 <<= r7
     608:       65 5f 63 74 78 00 71 75 <unknown> <.BTF+0x1348>
     609:       65 75 65 5f 64 65 70 74 if r5 s> 1953523044 goto
+24421 <.BTF+0x30e38>
     610:       68 00 71 75 65 75 65 5f <unknown>
     611:       68 77 5f 63 74 78 00 6e <unknown>
     612:       72 5f 68 77 5f 71 75 65 <unknown>
     613:       75 65 73 00 62 61 63 6b if r5 s>= 1801675106 goto +115
<.BTF+0x16c8>
     614:       69 6e 67 5f 64 65 76 5f <unknown>
     615:       69 6e 66 6f 00 71 75 65 <unknown>
     616:       75 65 64 61 74 61 00 71 if r5 s>= 1895850356 goto
+24932 <.BTF+0x31e68>
     617:       75 65 75 65 5f 66 6c 61 if r5 s>= 1634494047 goto
+25973 <.BTF+0x33ef8>
     618:       67 73 00 70 6d 5f 6f 6e r3 <<= 1852792685
     619:       6c 79 00 69 64 00 62 6f w9 <<= w7
     620:       75 6e 63 65 5f 67 66 70 <unknown> <.BTF+0x1408>
     621:       00 71 75 65 75 65 5f 6c <unknown>
     622:       6f 63 6b 00 6b 6f 62 6a r3 <<= r6
     623:       00 6d 71 5f 6b 6f 62 6a <unknown>
     624:       00 64 65 76 00 72 70 6d <unknown>
     625:       5f 73 74 61 74 75 73 00 r3 &= r7
     626:       6e 72 5f 70 65 6e 64 69 if w2 s> w7 goto +28767 <.BTF+0x39690>
     627:       6e 67 00 6e 72 5f 72 65 if w7 s> w6 goto +28160 <.BTF+0x383a0>
     628:       71 75 65 73 74 73 00 64 r5 = *(u8 *)(r7 + 29541)
     629:       6d 61 5f 64 72 61 69 6e if r1 s> r6 goto +25695 <.BTF+0x336a8>
     630:       5f 73 69 7a 65 00 64 6d r3 &= r7
     631:       61 5f 64 72 61 69 6e 5f <unknown>
     632:       62 75 66 66 65 72 00 64 <unknown>
     633:       6d 61 5f 70 61 64 5f 6d if r1 s> r6 goto +28767 <.BTF+0x396c8>
     634:       61 73 6b 00 64 6d 61 5f r3 = *(u32 *)(r7 + 107)
     635:       61 6c 69 67 6e 6d 65 6e <unknown>
     636:       74 00 72 71 5f 74 69 6d w0 >>= 1835627615
     637:       65 6f 75 74 00 70 6f 6c <unknown> <.BTF+0x3b6e8>
     638:       6c 5f 6e 73 65 63 00 70 <unknown>
     639:       6f 6c 6c 5f 63 62 00 70 <unknown>
     640:       6f 6c 6c 5f 73 74 61 74 <unknown>
     641:       00 74 69 6d 65 6f 75 74 <unknown>
     642:       00 74 69 6d 65 6f 75 74 <unknown>
     643:       5f 77 6f 72 6b 00 69 63 r7 &= r7
     644:       71 5f 6c 69 73 74 00 6c <unknown>
     645:       69 6d 69 74 73 00 72 65 <unknown>
     646:       71 75 69 72 65 64 5f 65 r5 = *(u8 *)(r7 + 29289)
     647:       6c 65 76 61 74 6f 72 5f w5 <<= w6
     648:       66 65 61 74 75 72 65 73 if w5 s> 1936028277 goto
+29793 <.BTF+0x3b750>
     649:       00 73 67 5f 74 69 6d 65 <unknown>
     650:       6f 75 74 00 73 67 5f 72 r5 <<= r7
     651:       65 73 65 72 76 65 64 5f if r3 s> 1600415094 goto
+29285 <.BTF+0x3a788>
     652:       73 69 7a 65 00 6e 6f 64 *(u8 *)(r9 + 25978) = r6
     653:       65 00 62 6c 6b 5f 74 72 if r0 s> 1920229227 goto
+27746 <.BTF+0x37780>
     654:       61 63 65 00 62 6c 6b 5f r3 = *(u32 *)(r6 + 101)
     655:       74 72 61 63 65 5f 6d 75 w2 >>= 1970102117
     656:       74 65 78 00 66 71 00 72 w5 >>= 1912631654
     657:       65 71 75 65 75 65 5f 6c if r1 s> 1818191221 goto
+25973 <.BTF+0x34038>
     658:       69 73 74 00 72 65 71 75 r3 = *(u16 *)(r7 + 116)
     659:       65 75 65 5f 6c 6f 63 6b if r5 s> 1801678700 goto
+24421 <.BTF+0x30fc8>
     660:       00 72 65 71 75 65 75 65 <unknown>
     661:       5f 77 6f 72 6b 00 73 79 r7 &= r7
     662:       73 66 73 5f 6c 6f 63 6b *(u8 *)(r6 + 24435) = r6
     663:       00 73 79 73 66 73 5f 64 <unknown>
     664:       69 72 5f 6c 6f 63 6b 00 r2 = *(u16 *)(r7 + 27743)
     665:       75 6e 75 73 65 64 5f 68 <unknown> <.BTF+0x377c8>
     666:       63 74 78 5f 6c 69 73 74 *(u32 *)(r4 + 24440) = r7
     667:       00 75 6e 75 73 65 64 5f <unknown>
     668:       68 63 74 78 5f 6c 6f 63 <unknown>
     669:       6b 00 6d 71 5f 66 72 65 *(u16 *)(r0 + 29037) = r0
     670:       65 7a 65 5f 64 65 70 74 if r10 s> 1953523044 goto
+24421 <.BTF+0x31020>
     671:       68 00 62 73 67 5f 64 65 <unknown>
     672:       76 00 63 61 6c 6c 62 61 if w0 s>= 1633840236 goto
+24931 <.BTF+0x32020>
     673:       63 6b 5f 68 65 61 64 00 *(u32 *)(r11 + 26719) = r6
     674:       6d 71 5f 66 72 65 65 7a if r1 s> r7 goto +26207 <.BTF+0x34810>
     675:       65 5f 77 71 00 6d 71 5f <unknown> <.BTF+0x34818>
     676:       66 72 65 65 7a 65 5f 6c if w2 s> 1818191226 goto
+25957 <.BTF+0x34050>
     677:       6f 63 6b 00 71 5f 75 73 r3 <<= r6
     678:       61 67 65 5f 63 6f 75 6e r7 = *(u32 *)(r6 + 24421)
     679:       74 65 72 00 74 61 67 5f w5 >>= 1600610676
     680:       73 65 74 00 74 61 67 5f *(u8 *)(r5 + 116) = r6
     681:       73 65 74 5f 6c 69 73 74 *(u8 *)(r5 + 24436) = r6
     682:       00 62 69 6f 5f 73 70 6c <unknown>
     683:       69 74 00 64 65 62 75 67 r4 = *(u16 *)(r7 + 25600)
     684:       66 73 5f 64 69 72 00 73 if w3 s> 1929409129 goto
+25695 <.BTF+0x33860>
     685:       63 68 65 64 5f 64 65 62 *(u32 *)(r8 + 25701) = r6
     686:       75 67 66 73 5f 64 69 72 if r7 s>= 1919509599 goto
+29542 <.BTF+0x3b0a8>
     687:       00 72 71 6f 73 5f 64 65 <unknown>
     688:       62 75 67 66 73 5f 64 69 <unknown>
     689:       72 00 6d 71 5f 73 79 73 <unknown>
     690:       66 73 5f 69 6e 69 74 5f if w3 s> 1601464686 goto
+26975 <.BTF+0x36090>
     691:       64 6f 6e 65 00 63 6d 64 <unknown>
     692:       5f 73 69 7a 65 00 72 65 r3 &= r7
     693:       6c 65 61 73 65 5f 77 6f w5 <<= w6
     694:       72 6b 00 77 72 69 74 65 <unknown>
     695:       5f 68 69 6e 74 73 00 62 r8 &= r6
     696:       6c 6b 5f 71 63 5f 74 00 w11 <<= w6
     697:       75 6e 73 69 67 6e 65 64 <unknown> <.BTF+0x1668>
     698:       20 69 6e 74 00 62 69 6f r0 = *(u32 *)skb[1869177344]
     699:       00 62 69 5f 6e 65 78 74 <unknown>
     700:       00 62 69 5f 64 69 73 6b <unknown>
     701:       00 62 69 5f 6f 70 66 00 <unknown>
     702:       62 69 5f 66 6c 61 67 73 <unknown>
     703:       00 62 69 5f 69 6f 70 72 <unknown>
     704:       69 6f 00 62 69 5f 77 72 <unknown>
     705:       69 74 65 5f 68 69 6e 74 r4 = *(u16 *)(r7 + 24421)
     706:       00 62 69 5f 73 74 61 74 <unknown>
     707:       75 73 00 62 69 5f 70 61 if r3 s>= 1634754409 goto
+25088 <.BTF+0x32620>
     708:       72 74 6e 6f 00 5f 5f 62 <unknown>
     709:       69 5f 72 65 6d 61 69 6e <unknown>
     710:       69 6e 67 00 62 69 5f 69 <unknown>
     711:       74 65 72 00 62 69 5f 65 w5 >>= 1700751714
     712:       6e 64 5f 69 6f 00 62 69 if


BTW, the llvm-objdump will core dump after output the above info:

Stack dump:
0. Program arguments: llvm-objdump-10 -D bio.bpf.o
/usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys15PrintStackTraceERNS_11raw_ostreamE+0x1f)[0x7f7636d5dc3f]
/usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(_ZN4llvm3sys17RunSignalHandlersEv+0x50)[0x7f7636d5bf00]
/usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x978205)[0x7f7636d5e205]
/lib/x86_64-linux-gnu/libpthread.so.0(+0x12890)[0x7f76361d9890]
/usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bbed3)[0x7f76385a1ed3]
/usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21baefb)[0x7f76385a0efb]
/usr/lib/x86_64-linux-gnu/libLLVM-10.so.1(+0x21bc0ce)[0x7f76385a20ce]
llvm-objdump-10[0x41b78c]
llvm-objdump-10[0x425278]
llvm-objdump-10[0x41f502]
llvm-objdump-10[0x41a473]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xe7)[0x7f763546db97]
llvm-objdump-10[0x41542a]
[1]    21636 segmentation fault (core dumped)

llvm-objdump-10 --version
LLVM (http://llvm.org/):
  LLVM version 10.0.0

  Optimized build.
  Default target: x86_64-pc-linux-gnu
  Host CPU: broadwell

  Registered Targets:
    aarch64    - AArch64 (little endian)
    aarch64_32 - AArch64 (little endian ILP32)
    aarch64_be - AArch64 (big endian)
    amdgcn     - AMD GCN GPUs
    arm        - ARM
    arm64      - ARM64 (little endian)
    arm64_32   - ARM64 (little endian ILP32)
    armeb      - ARM (big endian)
    avr        - Atmel AVR Microcontroller
    bpf        - BPF (host endian)
    bpfeb      - BPF (big endian)
    bpfel      - BPF (little endian)
    hexagon    - Hexagon
    lanai      - Lanai
    mips       - MIPS (32-bit big endian)
    mips64     - MIPS (64-bit big endian)
    mips64el   - MIPS (64-bit little endian)
    mipsel     - MIPS (32-bit little endian)
    msp430     - MSP430 [experimental]
    nvptx      - NVIDIA PTX 32-bit
    nvptx64    - NVIDIA PTX 64-bit
    ppc32      - PowerPC 32
    ppc64      - PowerPC 64
    ppc64le    - PowerPC 64 LE
    r600       - AMD GPUs HD2XXX-HD6XXX
    riscv32    - 32-bit RISC-V
    riscv64    - 64-bit RISC-V
    sparc      - Sparc
    sparcel    - Sparc LE
    sparcv9    - Sparc V9
    systemz    - SystemZ
    thumb      - Thumb
    thumbeb    - Thumb (big endian)
    wasm32     - WebAssembly 32-bit
    wasm64     - WebAssembly 64-bit
    x86        - 32-bit X86: Pentium-Pro and above
    x86-64     - 64-bit X86: EM64T and AMD64
    xcore      - XCore
