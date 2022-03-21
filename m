Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F16A4E2BA4
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 16:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiCUPSw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiCUPSv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 11:18:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE90EDF0B
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 08:17:25 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KMdWw6zTBz1GClf;
        Mon, 21 Mar 2022 23:17:16 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 21 Mar
 2022 23:17:22 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hou Tao <houtao1@huawei.com>, Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH -next v5 0/5] bpf, arm64: Optimize BPF store/load using arm64 str/ldr(immediate)
Date:   Mon, 21 Mar 2022 11:28:32 -0400
Message-ID: <20220321152832.2334229-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current BPF store/load instruction is translated by the JIT into two
instructions. The first instruction moves the immediate offset into a
temporary register. The second instruction uses this temporary register
to do the real store/load.

In fact, arm64 supports addressing with immediate offsets. So This series
introduces optimization that uses arm64 str/ldr instruction with immediate
offset when the offset fits.

Example of generated instuction for r2 = *(u64 *)(r1 + 0):

Without optimization:
mov x10, 0
ldr x1, [x0, x10]

With optimization:
ldr x1, [x0, 0]

For the following bpftrace command:

  bpftrace -e 'kprobe:do_sys_open { printf("opening: %s\n", str(arg1)); }'

Without this series, jited code(fragment):

   0:   bti     c
   4:   stp     x29, x30, [sp, #-16]!
   8:   mov     x29, sp
   c:   stp     x19, x20, [sp, #-16]!
  10:   stp     x21, x22, [sp, #-16]!
  14:   stp     x25, x26, [sp, #-16]!
  18:   mov     x25, sp
  1c:   mov     x26, #0x0                       // #0
  20:   bti     j
  24:   sub     sp, sp, #0x90
  28:   add     x19, x0, #0x0
  2c:   mov     x0, #0x0                        // #0
  30:   mov     x10, #0xffffffffffffff78        // #-136
  34:   str     x0, [x25, x10]
  38:   mov     x10, #0xffffffffffffff80        // #-128
  3c:   str     x0, [x25, x10]
  40:   mov     x10, #0xffffffffffffff88        // #-120
  44:   str     x0, [x25, x10]
  48:   mov     x10, #0xffffffffffffff90        // #-112
  4c:   str     x0, [x25, x10]
  50:   mov     x10, #0xffffffffffffff98        // #-104
  54:   str     x0, [x25, x10]
  58:   mov     x10, #0xffffffffffffffa0        // #-96
  5c:   str     x0, [x25, x10]
  60:   mov     x10, #0xffffffffffffffa8        // #-88
  64:   str     x0, [x25, x10]
  68:   mov     x10, #0xffffffffffffffb0        // #-80
  6c:   str     x0, [x25, x10]
  70:   mov     x10, #0xffffffffffffffb8        // #-72
  74:   str     x0, [x25, x10]
  78:   mov     x10, #0xffffffffffffffc0        // #-64
  7c:   str     x0, [x25, x10]
  80:   mov     x10, #0xffffffffffffffc8        // #-56
  84:   str     x0, [x25, x10]
  88:   mov     x10, #0xffffffffffffffd0        // #-48
  8c:   str     x0, [x25, x10]
  90:   mov     x10, #0xffffffffffffffd8        // #-40
  94:   str     x0, [x25, x10]
  98:   mov     x10, #0xffffffffffffffe0        // #-32
  9c:   str     x0, [x25, x10]
  a0:   mov     x10, #0xffffffffffffffe8        // #-24
  a4:   str     x0, [x25, x10]
  a8:   mov     x10, #0xfffffffffffffff0        // #-16
  ac:   str     x0, [x25, x10]
  b0:   mov     x10, #0xfffffffffffffff8        // #-8
  b4:   str     x0, [x25, x10]
  b8:   mov     x10, #0x8                       // #8
  bc:   ldr     x2, [x19, x10]
  [...]

With this series, jited code(fragment):

   0:   bti     c
   4:   stp     x29, x30, [sp, #-16]!
   8:   mov     x29, sp
   c:   stp     x19, x20, [sp, #-16]!
  10:   stp     x21, x22, [sp, #-16]!
  14:   stp     x25, x26, [sp, #-16]!
  18:   stp     x27, x28, [sp, #-16]!
  1c:   mov     x25, sp
  20:   sub     x27, x25, #0x88
  24:   mov     x26, #0x0                       // #0
  28:   bti     j
  2c:   sub     sp, sp, #0x90
  30:   add     x19, x0, #0x0
  34:   mov     x0, #0x0                        // #0
  38:   str     x0, [x27]
  3c:   str     x0, [x27, #8]
  40:   str     x0, [x27, #16]
  44:   str     x0, [x27, #24]
  48:   str     x0, [x27, #32]
  4c:   str     x0, [x27, #40]
  50:   str     x0, [x27, #48]
  54:   str     x0, [x27, #56]
  58:   str     x0, [x27, #64]
  5c:   str     x0, [x27, #72]
  60:   str     x0, [x27, #80]
  64:   str     x0, [x27, #88]
  68:   str     x0, [x27, #96]
  6c:   str     x0, [x27, #104]
  70:   str     x0, [x27, #112]
  74:   str     x0, [x27, #120]
  78:   str     x0, [x27, #128]
  7c:   ldr     x2, [x19, #8]
  [...]

Tested with test_bpf on both big-endian and little-endian arm64 qemu:

 test_bpf: Summary: 1026 PASSED, 0 FAILED, [1014/1014 JIT'ed]
 test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
 test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

v4->v5:
1. Fix incorrect FP offset in tail call scenario pointed out by Daniel,
   and add a tail call test case for this issue
2. Align down fpb_offset to 8 bytes to avoid unaligned offsets
3. Style and spelling fix

v3->v4:
1. Fix compile error reported by kernel test robot
2. Add one more test case for load/store in different offsets, and move
   test case to last patch
3. Fix some obvious bugs

v2 -> v3:
1. Split the v2 patch into 2 patches, one for arm64 instruction encoder,
   the other for BPF JIT
2. Add tests for BPF_LDX/BPF_STX with different offsets
3. Adjust the offset of str/ldr(immediate) to positive number

v1 -> v2:
1. Remove macro definition that causes checkpatch to fail
2. Append result to commit message

Xu Kuohai (5):
  arm64: insn: add ldr/str with immediate offset
  bpf, arm64: Optimize BPF store/load using str/ldr with immediate
    offset
  bpf, arm64: adjust the offset of str/ldr(immediate) to positive number
  bpf/tests: Add tests for BPF_LDX/BPF_STX with different offsets
  bpf, arm64: add load store test case for tail call

 arch/arm64/include/asm/insn.h |   9 +
 arch/arm64/lib/insn.c         |  67 ++++++--
 arch/arm64/net/bpf_jit.h      |  14 ++
 arch/arm64/net/bpf_jit_comp.c | 243 ++++++++++++++++++++++++--
 lib/test_bpf.c                | 315 +++++++++++++++++++++++++++++++++-
 5 files changed, 613 insertions(+), 35 deletions(-)

-- 
2.30.2

