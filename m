Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238F75BB8FE
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 17:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIQPN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIQPN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 11:13:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73B201A7
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:13:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MVDt609z4zKLG0
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 23:11:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnenMO5CVjskryAw--.61987S4;
        Sat, 17 Sep 2022 23:13:20 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next 00/10] Add support for qp-trie map
Date:   Sat, 17 Sep 2022 23:31:15 +0800
Message-Id: <20220917153125.2001645-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnenMO5CVjskryAw--.61987S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AFyrtFWfCFW3Gr4xZr4fXwb_yoW3Kw4kp3
        y8WF15Krn7tFnxXr92ya18urW3Xa1kXFy5Ga43t345Z34DWwnIq3yxKayUWasxt345Jr1f
        Zr93try3u34kJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The initial motivation for qp-trie map is to reduce memory usage for
string keys special those with large differencies in length as
discussed in [0]. And as a big-endian lexicographical ordered map, it
can also be used for any binary data with fixed or variable length.

Now the basic functionality of qp-trie is ready, so posting it to get
more feedback or suggestions about qp-trie. Specially feedback
about the following questions:

(1) Use bpf_dynptr in map key
Now qp-trie uses bpf_dynptr as map key. For simplicity a new map flags
BPF_F_DYNPTR_KEY is introduced, but it is not usable for map key in
which a bpf_dynptr is embedded. So maybe a better and generic way is to
check the offset of bpf_dynptr in map key during map creation and use
the offset when initializing or verifying map key ?

(2) Use cases for qp-trie
Andrii had proposed to re-implement lpm-trie by using qp-trie. The
advantage would be the speed up of lookup operations due to lower tree
depth of qp-trie and the performance of update may also increase.
But is there any other use cases for qp-trie ? Specially those cases
which need both ordering and memory efficiency or cases in which qp-trie
will have high branch factor and its lookup performance will be much
better than hash-table as shown below:

  Randomly-generated binary data (key size=255, max entries=16K, key length range:[1, 255])
  htab lookup      (1  thread)    4.968 ± 0.009M/s (drops 0.002 ± 0.000M/s mem 8.169 MiB)
  htab lookup      (2  thread)   10.118 ± 0.010M/s (drops 0.007 ± 0.000M/s mem 8.169 MiB)
  htab lookup      (4  thread)   20.084 ± 0.022M/s (drops 0.007 ± 0.000M/s mem 8.168 MiB)
  htab lookup      (8  thread)   39.866 ± 0.047M/s (drops 0.010 ± 0.000M/s mem 8.168 MiB)
  htab lookup      (16 thread)   79.412 ± 0.065M/s (drops 0.049 ± 0.000M/s mem 8.169 MiB)
  
  qp-trie lookup   (1  thread)   10.291 ± 0.007M/s (drops 0.004 ± 0.000M/s mem 4.899 MiB)
  qp-trie lookup   (2  thread)   20.797 ± 0.009M/s (drops 0.006 ± 0.000M/s mem 4.879 MiB)
  qp-trie lookup   (4  thread)   41.943 ± 0.019M/s (drops 0.015 ± 0.000M/s mem 4.262 MiB)
  qp-trie lookup   (8  thread)   81.985 ± 0.032M/s (drops 0.025 ± 0.000M/s mem 4.215 MiB)
  qp-trie lookup   (16 thread)  164.681 ± 0.051M/s (drops 0.050 ± 0.000M/s mem 4.261 MiB)

  * non-zero drops is due to duplicated keys in generated keys.

(3) Improve update performance for qp-trie
Now qp-trie is divided into 256 sub-trees by using the first byte as the
key and one sub-tree is protected one spinlock. I also had tried the
hierarchical lock by using hand-over-hand lock scheme [1], but it
doesn't scale well. Update performance of hash-table has been optimized
a lot by "bpf: BPF specific memory allocator", but because qp-trie
allocates memory for a variable-length key and bpf_mem_alloc() only
support <=4KB memory, so it doesn't fill well for qp-trie.

  Strings in /proc/kallsyms (key size=83, max entries=170958)
  htab update      (1  thread)    3.135 ± 0.355M/s (drops 0.000 ± 0.000M/s mem 30.842 MiB)
  htab update      (2  thread)    6.269 ± 0.686M/s (drops 0.000 ± 0.000M/s mem 30.841 MiB)
  htab update      (4  thread)   11.607 ± 1.632M/s (drops 0.000 ± 0.000M/s mem 30.840 MiB)
  htab update      (8  thread)   23.041 ± 0.806M/s (drops 0.000 ± 0.000M/s mem 30.842 MiB)
  htab update      (16 thread)   31.393 ± 0.307M/s (drops 0.000 ± 0.000M/s mem 30.835 MiB)
  
  qp-trie update   (1  thread)    1.191 ± 0.093M/s (drops 0.000 ± 0.000M/s mem 17.170 MiB)
  qp-trie update   (2  thread)    2.057 ± 0.041M/s (drops 0.000 ± 0.000M/s mem 17.058 MiB)
  qp-trie update   (4  thread)    2.975 ± 0.035M/s (drops 0.000 ± 0.000M/s mem 17.411 MiB)
  qp-trie update   (8  thread)    3.596 ± 0.031M/s (drops 0.000 ± 0.000M/s mem 17.110 MiB)
  qp-trie update   (16 thread)    4.200 ± 0.048M/s (drops 0.000 ± 0.000M/s mem 17.228 MiB)
  
(4) Improve memory efficiency further
When using strings in BTF string section as a data set for qp-trie, the
slab memory usage showed in cgroup memory.stats file is about 11MB for
qp-trie and 22MB for hash table as shown below. However the theoretical
memory usage for qp-trie is ~6.8MB (is ~4.9MB if removing "parent" & "rcu"
fields from qp_trie_branch) and the extra memory usage (about 38% of total
usage) mainly comes from internal fragment in slab (namely 2^n alignment
for allocation) and overhead in kmem-cgroup accounting. We can reduce the
internal fragment by creating separated kmem_cache for qp_trie_branch with
different child nodes, but not sure whether it is worthy or not.

And in order to prevent allocating a rcu_head for each leaf node, now only
branch node is RCU-freed, so when replacing a leaf node, a new branch node
and a new leaf node will be allocated instead of replacing the old leaf
node and RCU-freed the old leaf node. Also it seems rcu_head can be
replaced by a pointer as BPF specific memory allocator does, so 8-bytes
can be saved for each node, and again not sure it's worth it.

  Sorted strings in BTF string sections (entries=115980)
  htab lookup      (1  thread)    6.915 ± 0.029M/s (drops 0.000 ± 0.000M/s mem 22.216 MiB)
  qp-trie lookup   (1  thread)    6.791 ± 0.005M/s (drops 0.000 ± 0.000M/s mem 11.273 MiB)
  
  All files under linux kernel source directory (entries=74359)
  htab lookup      (1  thread)    7.978 ± 0.009M/s (drops 0.000 ± 0.000M/s mem 14.272 MiB)
  qp-trie lookup   (1  thread)    5.521 ± 0.003M/s (drops 0.000 ± 0.000M/s mem 9.367 MiB)
  
  Domain names for Alexa top million web site (entries=1000000)
  htab lookup      (1  thread)    3.148 ± 0.039M/s (drops 0.000 ± 0.000M/s mem 190.831 MiB)
  qp-trie lookup   (1  thread)    2.374 ± 0.026M/s (drops 0.000 ± 0.000M/s mem 83.733 MiB)

Comments and suggestions are always welcome.

Change Log:
v1:
 * Use bpf_dynptr as map key type instead of bpf_lpm_trie_key-styled key (Suggested by Andrii)
 * Fix build error and RCU related sparse errors reported by lkp robot
 * Copy the passed key firstly in qp_trie_update_elem(), because the content of passed key may
   change and may break the assumption in two-round lookup process during update.
 * Add the missing rcu_barrier in qp_trie_free()

RFC: https://lore.kernel.org/bpf/20220726130005.3102470-1-houtao1@huawei.com/

[0]: https://lore.kernel.org/bpf/CAEf4Bzb7keBS8vXgV5JZzwgNGgMV0X3_guQ_m9JW3X6fJBDpPQ@mail.gmail.com/
[1]: https://lore.kernel.org/bpf/db34696a-cbfe-16e8-6dd5-8174b97dcf1d@huawei.com/

Hou Tao (10):
  bpf: Export bpf_dynptr_{get|set}_size
  bpf: Add helper btf_type_is_bpf_dynptr()
  bpf: Support bpf_dynptr-typed map key for bpf syscall
  bpf: Support bpf_dynptr-typed map key for bpf program
  libbpf: Add helpers for bpf_dynptr_user
  bpf: Add support for qp-trie map
  selftests/bpf: Add two new dynptr_fail cases for map key
  selftests/bpf: Add test case for basic qp-trie map operations
  selftests/bpf: Add benchmark for qp-trie map
  selftests/bpf: Add tests for qp-trie map by using bpf syscalls

 include/linux/bpf.h                           |    4 +
 include/linux/bpf_types.h                     |    1 +
 include/linux/btf.h                           |    1 +
 include/uapi/linux/bpf.h                      |   10 +
 kernel/bpf/Makefile                           |    1 +
 kernel/bpf/bpf_qp_trie.c                      | 1055 +++++++++++++++
 kernel/bpf/btf.c                              |    7 +
 kernel/bpf/helpers.c                          |    9 +-
 kernel/bpf/syscall.c                          |  108 +-
 kernel/bpf/verifier.c                         |   18 +-
 tools/include/uapi/linux/bpf.h                |    9 +
 tools/lib/bpf/bpf.h                           |   19 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |    1 +
 tools/testing/selftests/bpf/Makefile          |    5 +-
 tools/testing/selftests/bpf/bench.c           |   10 +
 .../selftests/bpf/benchs/bench_qp_trie.c      |  511 ++++++++
 .../selftests/bpf/benchs/run_bench_qp_trie.sh |   55 +
 .../selftests/bpf/map_tests/qp_trie_map.c     | 1165 +++++++++++++++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |    2 +
 .../selftests/bpf/prog_tests/qp_trie_test.c   |   91 ++
 .../testing/selftests/bpf/progs/dynptr_fail.c |   43 +
 .../selftests/bpf/progs/qp_trie_bench.c       |  236 ++++
 .../selftests/bpf/progs/qp_trie_test.c        |  110 ++
 23 files changed, 3452 insertions(+), 19 deletions(-)
 create mode 100644 kernel/bpf/bpf_qp_trie.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
 create mode 100644 tools/testing/selftests/bpf/map_tests/qp_trie_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_test.c

-- 
2.29.2

