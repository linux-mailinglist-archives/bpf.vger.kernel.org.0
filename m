Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE55E8D01
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiIXNSZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 24 Sep 2022 09:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiIXNSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Sep 2022 09:18:23 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940F92F3AB
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 06:18:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MZV012SLxz6S2nN
        for <bpf@vger.kernel.org>; Sat, 24 Sep 2022 21:16:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOXAy9jXzpPBQ--.3282S4;
        Sat, 24 Sep 2022 21:18:16 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
Subject: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
Date:   Sat, 24 Sep 2022 21:36:07 +0800
Message-Id: <20220924133620.4147153-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOXAy9jXzpPBQ--.3282S4
X-Coremail-Antispam: 1UD129KBjvJXoWfGw4xGr1kAry5uF1fCFyUKFg_yoWDCrWDpa
        y8WFy5Krn7JF13Xwn7AayruFW3Xa18XrW5Gasaq345Z348Wr9aqryIkay7Xasxta4rJr1S
        vwnxtry3u34kA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

(1) Use cases for qp-trie
Andrii had proposed to re-implement lpm-trie by using qp-trie. The
advantage would be the speed up of lookup operations due to lower tree
depth of qp-trie and the performance of update may also increase.
But is there any other use cases for qp-trie ? Specially those cases
which need both ordering and memory efficiency or cases in which qp-trie
will have high fan-out and its lookup performance will be much better than
hash-table as shown below:

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

(2) Improve update/delete performance for qp-trie
Now top-5 overheads in update/delete operations are:

    21.23%  bench    [kernel.vmlinux]    [k] qp_trie_update_elem
    13.98%  bench    [kernel.vmlinux]    [k] qp_trie_delete_elem
     7.96%  bench    [kernel.vmlinux]    [k] native_queued_spin_lock_slowpath
     5.16%  bench    [kernel.vmlinux]    [k] memcpy_erms
     5.00%  bench    [kernel.vmlinux]    [k] __kmalloc_node

The top-2 overheads are due to memory access and atomic ops on
max_entries. I had tried memory prefetch but it didn't work out, maybe
I did it wrong. For subtree spinlock overhead, I also had tried the
hierarchical lock by using hand-over-hand lock scheme, but it didn't
scale well [1]. I will try to increase the number of subtrees from 256
to 1024, 4096 or bigger and check whether it makes any difference.

For atomic ops and kmalloc overhead, I think I can reuse the idea from
patchset "bpf: BPF specific memory allocator". I have given bpf_mem_alloc
a simple try and encounter some problems. One problem is that
immediate reuse of freed object in bpf memory allocator. Because qp-trie
uses bpf memory allocator to allocate and free qp_trie_branch, if
qp_trie_branch is reused immediately, the lookup procedure may oops due
to the incorrect content in qp_trie_branch. And another problem is the
size limitation in bpf_mem_alloc() is 4096. It may be a little small for
the total size of key size and value size, but maybe I can use two
separated bpf_mem_alloc for key and value.

String in BTF string sections (entries=115980, max size=71, threads=4)

On hash-table
Iter   0 ( 21.872us): hits   11.496M/s (  2.874M/prod), drops    0.000M/s, total operations   11.496M/s
Iter   1 (  4.816us): hits   12.701M/s (  3.175M/prod), drops    0.000M/s, total operations   12.701M/s
Iter   2 (-11.006us): hits   12.443M/s (  3.111M/prod), drops    0.000M/s, total operations   12.443M/s
Iter   3 (  2.628us): hits   11.223M/s (  2.806M/prod), drops    0.000M/s, total operations   11.223M/s
Slab: 22.225 MiB

On qp-trie:
Iter   0 ( 24.388us): hits    4.062M/s (  1.016M/prod), drops    0.000M/s, total operations    4.062M/s
Iter   1 ( 20.612us): hits    3.884M/s (  0.971M/prod), drops    0.000M/s, total operations    3.884M/s
Iter   2 (-21.533us): hits    4.046M/s (  1.012M/prod), drops    0.000M/s, total operations    4.046M/s
Iter   3 (  2.090us): hits    3.971M/s (  0.993M/prod), drops    0.000M/s, total operations    3.971M/s
Slab: 10.849 MiB

(3) Improve memory efficiency further
When using strings in BTF string section as a data set for qp-trie, the
slab memory usage showed in cgroup memory.stats file is about 11MB for
qp-trie and 22MB for hash table as shown above. However the theoretical
memory usage for qp-trie is ~6.8MB (is ~4.9MB if removing "parent" & "rcu"
fields from qp_trie_branch) and the extra memory usage (about 38% of total
usage) mainly comes from internal fragment in slab (namely 2^n alignment
for allocation) and overhead in kmem-cgroup accounting. We can reduce the
internal fragment by creating separated kmem_cache for qp_trie_branch with
different child nodes, but not sure whether it is worth it.

And in order to prevent allocating a rcu_head for each leaf node, now only
branch node is RCU-freed, so when replacing a leaf node, a new branch node
and a new leaf node will be allocated instead of replacing the old leaf
node and RCU-freed the old leaf node.

No sure whether or not there are ways to remove rcu_head completely from
qp_trie_branch node. Headless kfree_rcu() doesn't need rcu_head but it
might sleeps. It seems BPF memory allocator is a better choice as for
now because it replaces rcu_read by llist_node.

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

[0]: https://lore.kernel.org/bpf/CAEf4Bzb7keBS8vXgV5JZzwgNGgMV0X3_guQ_m9JW3X6fJBDpPQ@mail.gmail.com/
[1]: https://lore.kernel.org/bpf/db34696a-cbfe-16e8-6dd5-8174b97dcf1d@huawei.com/

Change Log:
v2:
 * Always use copy_to_user() in bpf_copy_to_dynptr_ukey() (from kernel test robot <lkp@intel.com>)
   No-MMU ARM32 host doesn't support 8-bytes get_user().
 * Remove BPF_F_DYNPTR_KEY and use the more extensible dynptr_key_off
 * Remove the unnecessary rcu_barrier in qp_trie_free()
 * Add a new helper bpf_dynptr_user_trim() for bpftool in libbpf
 * Support qp-trie map in bpftool
 * Add 2 more test_progs test cases for qp-trie map
 * Fix test_progs-no_alu32 failure for test_progs test case
 * Add tests for not-supported operations in test_maps

v1: https://lore.kernel.org/bpf/20220917153125.2001645-1-houtao@huaweicloud.com/
 * Use bpf_dynptr as map key type instead of bpf_lpm_trie_key-styled key (Suggested by Andrii)
 * Fix build error and RCU related sparse errors reported by lkp robot
 * Copy the passed key firstly in qp_trie_update_elem(), because the content of passed key may
   change and may break the assumption in two-round lookup process during update.
 * Add the missing rcu_barrier in qp_trie_free()

RFC: https://lore.kernel.org/bpf/20220726130005.3102470-1-houtao1@huawei.com/

Hou Tao (13):
  bpf: Export bpf_dynptr_set_size()
  bpf: Add helper btf_find_dynptr()
  bpf: Support bpf_dynptr-typed map key in bpf syscall
  bpf: Support bpf_dynptr-typed map key in verifier
  libbpf: Add helpers for bpf_dynptr_user
  bpf: Add support for qp-trie map with dynptr key
  libbpf: Add probe support for BPF_MAP_TYPE_QP_TRIE
  bpftool: Add support for qp-trie map
  selftests/bpf: Add two new dynptr_fail cases for map key
  selftests/bpf: Move ENOTSUPP into bpf_util.h
  selftests/bpf: Add prog tests for qp-trie map
  selftests/bpf: Add benchmark for qp-trie map
  selftests/bpf: Add map tests for qp-trie by using bpf syscall

 include/linux/bpf.h                           |   11 +-
 include/linux/bpf_types.h                     |    1 +
 include/linux/btf.h                           |    1 +
 include/uapi/linux/bpf.h                      |    7 +
 kernel/bpf/Makefile                           |    1 +
 kernel/bpf/bpf_qp_trie.c                      | 1057 ++++++++++++++
 kernel/bpf/btf.c                              |   13 +
 kernel/bpf/helpers.c                          |    9 +-
 kernel/bpf/map_in_map.c                       |    3 +
 kernel/bpf/syscall.c                          |  121 +-
 kernel/bpf/verifier.c                         |   17 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |    4 +-
 tools/bpf/bpftool/btf_dumper.c                |   33 +
 tools/bpf/bpftool/map.c                       |  149 +-
 tools/include/uapi/linux/bpf.h                |    7 +
 tools/lib/bpf/bpf.h                           |   29 +
 tools/lib/bpf/libbpf.c                        |    1 +
 tools/lib/bpf/libbpf_probes.c                 |   25 +
 tools/testing/selftests/bpf/Makefile          |    5 +-
 tools/testing/selftests/bpf/bench.c           |   10 +
 .../selftests/bpf/benchs/bench_qp_trie.c      |  511 +++++++
 .../selftests/bpf/benchs/run_bench_qp_trie.sh |   55 +
 tools/testing/selftests/bpf/bpf_util.h        |    4 +
 .../selftests/bpf/map_tests/qp_trie_map.c     | 1209 +++++++++++++++++
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |    4 -
 .../testing/selftests/bpf/prog_tests/dynptr.c |    2 +
 .../selftests/bpf/prog_tests/lsm_cgroup.c     |    4 -
 .../selftests/bpf/prog_tests/qp_trie_test.c   |  214 +++
 .../testing/selftests/bpf/progs/dynptr_fail.c |   43 +
 .../selftests/bpf/progs/qp_trie_bench.c       |  236 ++++
 .../selftests/bpf/progs/qp_trie_test.c        |  200 +++
 tools/testing/selftests/bpf/test_maps.c       |    4 -
 32 files changed, 3931 insertions(+), 59 deletions(-)
 create mode 100644 kernel/bpf/bpf_qp_trie.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
 create mode 100644 tools/testing/selftests/bpf/map_tests/qp_trie_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/qp_trie_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_test.c

-- 
2.29.2

