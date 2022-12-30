Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7C659495
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 05:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiL3EML (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 23:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiL3EMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 23:12:09 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C15B18397;
        Thu, 29 Dec 2022 20:12:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NjsKB35M3z4f3mLG;
        Fri, 30 Dec 2022 12:11:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMPZa5j3H4SAw--.35465S4;
        Fri, 30 Dec 2022 12:12:01 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Date:   Fri, 30 Dec 2022 12:11:45 +0800
Message-Id: <20221230041151.1231169-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMPZa5j3H4SAw--.35465S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4UGw18urWxKw4kAr4ruFg_yoWrJw1fpa
        yS9w15JFyv9ryfKw1xZws7WF1rCws3GFW7GF12qryUuw4rWrn7Ar1Ika1YvFWrCFs3JF90
        qrn0vwn3Z3s8C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset tries to fix the problems found when checking how htab map
handles element reuse in bpf memory allocator. The immediate reuse of
freed elements may lead to two problems in htab map:

(1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
    htab map value and it may corrupt lookup procedure with BFP_F_LOCK
    flag which acquires bpf-spin-lock during value copying. The
    corruption of bpf-spin-lock may result in hard lock-up.
(2) lookup procedure may get incorrect map value if the found element is
    freed and then reused.

Because the type of htab map elements are the same, so problem #1 can be
fixed by supporting ctor in bpf memory allocator. The ctor initializes
these special fields in map element only when the map element is newly
allocated. If it is just a reused element, there will be no
reinitialization.

Problem #2 exists for both non-preallocated and preallocated htab map.
By adding seq in htab element, doing reuse check and retrying the
lookup procedure may be a feasible solution, but it will make the
lookup API being hard to use, because the user needs to check whether
the found element is reused or not and repeat the lookup procedure if it
is reused. A simpler solution would be just disabling freed elements
reuse and freeing these elements after lookup procedure ends.

In order to reduce the overhead of call_rcu_tasks_trace() for each freed
elements, freeing these elements in batch by moving these freed elements
into a global per-cpu free list firstly, then after the number of freed
elements reaches the threshold, these freed elements will be moved into
a dymaically allocated object and being freed by a global per-cpu worker
by calling call_rcu_tasks_trace().

Because the solution frees memory by allocating new memory, so if there
is no memory available, the global per-cpu worker will call
rcu_barrier_tasks_trace() to wait for the expiration of RCU grace period
and free these free elements which have been spliced into a temporary
list. And the newly freed elements will be freed after another round of
rcu_barrier_tasks_trace() if there is still no memory. Maybe need to
reserve some bpf_ma_free_batch to speed up the free. Now also doesn't
consider the scenario when RCU grace period is slow. Because these
newly-allocated memory (aka bpf_ma_free_batch) will be freed after the
expiration of RCU grace period, so if grace period is slow, there may be
too much bpf_ma_free_batch being allocated.

Aftering applying BPF_MA_NO_REUSE in htab map, the performance of
"./map_perf_test 4 18 8192" drops from 520K to 330K events per sec on
one CPU. It is a big performance degradation, so hope to get some
feedbacks on whether or not it is necessary and how to better fixing the
reuse problem in htab map (global allocated object may have the same
problems as htab map). Comments are always welcome.

Regards,
Hou

Hou Tao (6):
  bpf: Support ctor in bpf memory allocator
  bpf: Factor out a common helper free_llist()
  bpf: Pass bitwise flags to bpf_mem_alloc_init()
  bpf: Introduce BPF_MA_NO_REUSE for bpf memory allocator
  bpf: Use BPF_MA_NO_REUSE in htab map
  selftests/bpf: Add test case for element reuse in htab map

 include/linux/bpf_mem_alloc.h                 |  12 +-
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/hashtab.c                          |  17 +-
 kernel/bpf/memalloc.c                         | 218 ++++++++++++++++--
 .../selftests/bpf/prog_tests/htab_reuse.c     | 111 +++++++++
 .../testing/selftests/bpf/progs/htab_reuse.c  |  19 ++
 6 files changed, 353 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_reuse.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_reuse.c

-- 
2.29.2

