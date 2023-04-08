Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6B6DBB39
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDHNry (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 09:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDHNrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 09:47:53 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32DACA03;
        Sat,  8 Apr 2023 06:47:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PtxPt40n5z4f3xbq;
        Sat,  8 Apr 2023 21:47:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J_cDFk6gboGw--.47910S4;
        Sat, 08 Apr 2023 21:47:45 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v2 0/4] Introduce BPF_MA_REUSE_AFTER_RCU_GP
Date:   Sat,  8 Apr 2023 22:18:42 +0800
Message-Id: <20230408141846.1878768-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J_cDFk6gboGw--.47910S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4DXrWktFW8Ww1rArykGrg_yoW5ZrWkpF
        WfGw45Jr1kXrnFkwn7Aw17Ga4rJws5W345GF4Svr1Duw4fXry29r1IyF4YvFy3CrW8JFyY
        qrykKwn3Wa4kZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=KHOP_HELO_FCRDNS,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

The patch series tries to introduce BPF_MA_REUSE_AFTER_RCU_GP to solve
these problems. For BPF_MA_REUSE_AFTER_GP, the freed objects are reused
only after one RCU grace period and may be freed by bpf memory allocator
after another RCU-tasks-trace grace period. So for bpf programs which
care about reuse problem, these programs can use
bpf_rcu_read_{lock,unlock}() to access these freed objects safely and
for those which doesn't care, there will be safely use-after-bpf-ma-free
because these objects have not been freed by bpf memory allocator.

The current implementation is far from perfect, but I think it is ready
for get some feedbacks before putting in more effort. The implementation
mainly focus on how to speed up the transition from freed elements to
reusable elements and try to reduce the risk of OOM.

To accelerate the transition, it dynamically allocates rcu_head and call
call_rcu() in a kworker to do the transition. The frequency of call_rcu()
invocation could be improved by calling call_rcu() in irq work, but after
did that, I found the RCU grace period increased a lot and I still could
not figure out why. To reduce the risk of OOM, these reusable elements need
to be free as well, but we can not dynamically allocate rcu_head to do
that, because compared with RCU grace period RCU-tasks-trace grace
period is slower, so the freeing of reusable elements is just like the
freeing in normal bpf memory allocator, but these is one difference: for
BPF_MA_REUSE_AFTER_GP bpf ma these freeing elements are still available
for reuse in unit_alloc(). Please see individual patches for more details.

Comments and suggestions are always welcome.

Change Log:
v2:
 * add a benchmark for bpf memory allocator to compare between different
   flavor of bpf memory allocator.
 * implement BPF_MA_REUSE_AFTER_RCU_GP for bpf memory allocator.
v1: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/

Hou Tao (4):
  selftests/bpf: Add benchmark for bpf memory allocator
  bpf: Factor out a common helper free_all()
  bpf: Pass bitwise flags to bpf_mem_alloc_init()
  bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP

 include/linux/bpf_mem_alloc.h                 |   9 +-
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/cpumask.c                          |   2 +-
 kernel/bpf/hashtab.c                          |   5 +-
 kernel/bpf/memalloc.c                         | 390 ++++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |   3 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_htab_mem.c     | 273 ++++++++++++
 .../selftests/bpf/progs/htab_mem_bench.c      | 145 +++++++
 9 files changed, 785 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c

-- 
2.29.2

