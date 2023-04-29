Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939356F23E3
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 11:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjD2Jlc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Apr 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjD2Jlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Apr 2023 05:41:31 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77741981;
        Sat, 29 Apr 2023 02:41:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q7kxv2mY8z4f3kpN;
        Sat, 29 Apr 2023 17:41:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBA5kxkK36NIQ--.13426S4;
        Sat, 29 Apr 2023 17:41:22 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v3 0/6] Handle immediate reuse in bpf memory allocator
Date:   Sat, 29 Apr 2023 18:12:09 +0800
Message-Id: <20230429101215.111262-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBA5kxkK36NIQ--.13426S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4DXrWktF1ktFW8AF1fJFb_yoW5tFyxpa
        1fGw13Jr1qqrnrJwn7Arnrt3WrJw4kWry5KF4avr1Uu3yfXryxZrn2kF4FvF9xWFWxtFn8
        Xr1v9wnxWa4rZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

As discussed in v1, currently the freed objects in bpf memory allocator
may be reused immediately by the new allocation, it introduces
use-after-bpf-ma-free problem for non-preallocated hash map and makes
lookup procedure return incorrect result. The immediate reuse also makes
introducing new use case more difficult (e.g. qp-trie).

The patch series tries to solve these problems by introducing
BPF_MA_{REUSE|FREE}_AFTER_RCU_GP in bpf memory allocator. For
REUSE_AFTER_GP, the freed objects are reused only after one RCU grace
period and may be freed by bpf memory allocator after another
RCU-tasks-trace grace period. So for bpf programs which care about reuse
problem, these programs can use bpf_rcu_read_{lock,unlock}() to access
these objects safely and for those which doesn't care, there will be
safely use-after-bpf-ma-free because these objects have not been freed
by bpf memory allocator. FREE_AFTER_GP behavior differently. Instead of
making the freed elements being reusable after one RCU GP, it directly
freed these elements back to slab after one RCU GP, so sleepable bpf
program must use bpf_rcu_read_{lock,unlock}() to access elements
allocated from FREE_AFTER_GP bpf memory allocator.

Personally I prefer FREE_AFTER_RCU_GP because its implementation is much
simpler compared with REUSE_AFTER_RCU and its memory usage is also better
than REUSE_AFTER_GP. But its shortcoming is also obvious, so I want to get
some feedback before putting in more effort. As usual, comments and
suggestions are always welcome.

Change Log:
v3:
 * add BPF_MA_FREE_AFTER_RCU_GP bpf memory allocator
 * Update htab memory benchmark
   * move the benchmark patch to the last patch
   * remove array and useless bpf_map_lookup_elem(&array, ...) in bpf
     programs
   * add synchronization between addition CPU and deletion CPU for
     add_del_on_diff_cpu case to prevent unnecessary loop
   * add the benchmark result for "extra call_rcu + bpf ma"

v2: https://lore.kernel.org/bpf/20230408141846.1878768-1-houtao@huaweicloud.com/
 * add a benchmark for bpf memory allocator to compare between different
   flavor of bpf memory allocator.
 * implement BPF_MA_REUSE_AFTER_RCU_GP for bpf memory allocator.
v1: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/

Hou Tao (6):
  bpf: Factor out a common helper free_all()
  bpf: Pass bitwise flags to bpf_mem_alloc_init()
  bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
  bpf: Introduce BPF_MA_FREE_AFTER_RCU_GP
  bpf: Add two module parameters in htab for memory benchmark
  selftests/bpf: Add benchmark for bpf memory allocator

 include/linux/bpf_mem_alloc.h                 |  10 +-
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/cpumask.c                          |   2 +-
 kernel/bpf/hashtab.c                          |  43 +-
 kernel/bpf/memalloc.c                         | 529 ++++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |   3 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_htab_mem.c     | 352 ++++++++++++
 .../bpf/benchs/run_bench_htab_mem.sh          |  64 +++
 .../selftests/bpf/progs/htab_mem_bench.c      | 135 +++++
 10 files changed, 1090 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c

-- 
2.29.2

