Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBF581342
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiGZMl7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiGZMl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 08:41:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21A4255AA
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 05:41:56 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lsc0k4bY9z1M87k;
        Tue, 26 Jul 2022 20:39:02 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 20:41:53 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, <bpf@vger.kernel.org>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, <houtao1@huawei.com>
Subject: [RFC PATCH bpf-next 0/3] Add support for qp-trie map
Date:   Tue, 26 Jul 2022 21:00:02 +0800
Message-ID: <20220726130005.3102470-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The initial motivation for qp-trie map is to reduce memory usage for
string keys special those with large differencies in length as
discussed in [0]. And as a big-endian lexicographical ordered map, it
can also be used for any binary data with fixed or variable length.

Now the basic functionality of qp-trie is ready, so posting a RFC version
to get more feedback or suggestions about qp-trie. Specially feedback
about the following questions:

(1) Application scenario for qp-trie
Andrii had proposed to re-implement lpm-trie by using qp-trie. The
advantage would be the speed up of lookup operations due to lower tree
depth of qp-trie. Maybe the performance of update could also be improved
although in cillium there is a big lock during lpm-trie update [1]. Is
there any other use cases for qp-trie ? Specially those cases which need
both ordering and memory efficiency or cases in which jhash() of htab
creates too much collisions and qp-trie lookup performances better than
hash-table lookup as shown below:

  Randomly-generated binary data with variable length (length range=[1, 256] entries=16K)

  htab lookup      (1  thread)    5.062 ± 0.004M/s (drops 0.002 ± 0.000M/s mem 8.125 MiB)
  htab lookup      (2  thread)   10.256 ± 0.017M/s (drops 0.006 ± 0.000M/s mem 8.114 MiB)
  htab lookup      (4  thread)   20.383 ± 0.006M/s (drops 0.009 ± 0.000M/s mem 8.117 MiB)
  htab lookup      (8  thread)   40.727 ± 0.093M/s (drops 0.010 ± 0.000M/s mem 8.123 MiB)
  htab lookup      (16 thread)   81.333 ± 0.311M/s (drops 0.020 ± 0.000M/s mem 8.122 MiB)
  
  qp-trie lookup   (1  thread)   10.161 ± 0.008M/s (drops 0.006 ± 0.000M/s mem 4.847 MiB)
  qp-trie lookup   (2  thread)   20.287 ± 0.024M/s (drops 0.007 ± 0.000M/s mem 4.828 MiB)
  qp-trie lookup   (4  thread)   40.784 ± 0.020M/s (drops 0.015 ± 0.000M/s mem 4.071 MiB)
  qp-trie lookup   (8  thread)   81.165 ± 0.013M/s (drops 0.040 ± 0.000M/s mem 4.045 MiB)
  qp-trie lookup   (16 thread)  159.955 ± 0.014M/s (drops 0.108 ± 0.000M/s mem 4.495 MiB)

  * non-zero drops is due to duplicated keys in generated keys.

(2) more fine-grained lock in qp-trie
Now qp-trie is divided into 256 sub-trees by using the first character of
key and one sub-tree is protected one spinlock. From the data below,
although the update/delete speed of qp-trie is slower compare with hash
table, but it scales similar with hash table. So maybe 256-locks is a
good enough solution ?

  Strings in /proc/kallsyms
  htab update      (1  thread)    2.850 ± 0.129M/s (drops 0.000 ± 0.000M/s mem 33.564 MiB)
  htab update      (2  thread)    4.363 ± 0.031M/s (drops 0.000 ± 0.000M/s mem 33.563 MiB)
  htab update      (4  thread)    6.306 ± 0.096M/s (drops 0.000 ± 0.000M/s mem 33.718 MiB)
  htab update      (8  thread)    6.611 ± 0.026M/s (drops 0.000 ± 0.000M/s mem 33.627 MiB)
  htab update      (16 thread)    6.390 ± 0.015M/s (drops 0.000 ± 0.000M/s mem 33.564 MiB)
  qp-trie update   (1  thread)    1.157 ± 0.099M/s (drops 0.000 ± 0.000M/s mem 18.333 MiB)
  qp-trie update   (2  thread)    1.920 ± 0.062M/s (drops 0.000 ± 0.000M/s mem 18.293 MiB)
  qp-trie update   (4  thread)    2.630 ± 0.050M/s (drops 0.000 ± 0.000M/s mem 18.472 MiB)
  qp-trie update   (8  thread)    3.171 ± 0.027M/s (drops 0.000 ± 0.000M/s mem 18.301 MiB)
  qp-trie update   (16 thread)    3.782 ± 0.036M/s (drops 0.000 ± 0.000M/s mem 19.040 MiB)

(3) Improve memory efficiency further
When using strings in BTF string section as a data set for qp-trie, the
slab memory usage showed in cgroup memory.stats file is about 11MB for
qp-trie and 15MB for hash table as shown below. However the theoretical
memory usage for qp-trie is ~6.8MB (is ~4.9MB if removing "parent" & "rcu"
fields from qp_trie_branch) and the extra memory usage (about 38% of total
usage) mainly comes from internal fragment in slab (namely 2^n alignment
for allocation) and overhead in kmem-cgroup accounting. We can reduce the
internal fragment by creating separated kmem_cache for qp_trie_branch with
different child nodes, but not sure whether it is worthy or not.

And in order to prevent allocating a rcu_head for each leaf node, now only
branch node is RCU-freed, so when replacing a leaf node, a new branch node
and a new leaf node will be allocated instead of replacing the old leaf
node and RCU-freed the old leaf node. Also not sure whether or not it is
worthy.

  Strings in BTF string section (entries=115980):
  htab lookup      (1  thread)    9.889 ± 0.006M/s (drops 0.000 ± 0.000M/s mem 15.069 MiB)
  qp-trie lookup   (1  thread)    5.132 ± 0.002M/s (drops 0.000 ± 0.000M/s mem 10.721 MiB)

  All files under linux kernel source directory (entries=74359):
  htab lookup      (1  thread)    8.418 ± 0.077M/s (drops 0.000 ± 0.000M/s mem 14.207 MiB)
  qp-trie lookup   (1  thread)    4.966 ± 0.003M/s (drops 0.000 ± 0.000M/s mem 9.355 MiB)

  Domain names for Alexa top million web site (entries=1000000):
  htab lookup      (1  thread)    4.551 ± 0.043M/s (drops 0.000 ± 0.000M/s mem 190.761 MiB)
  qp-trie lookup   (1  thread)    2.804 ± 0.017M/s (drops 0.000 ± 0.000M/s mem 83.194 MiB)

Comments and suggestions are always welcome.

Regards,
Tao

[0]: https://lore.kernel.org/bpf/CAEf4Bzb7keBS8vXgV5JZzwgNGgMV0X3_guQ_m9JW3X6fJBDpPQ@mail.gmail.com/
[1]: https://github.com/cilium/cilium/blob/5145e31cd65db3361f6538d5f5f899440b769070/pkg/datapath/prefilter/prefilter.go#L123

Hou Tao (3):
  bpf: Add support for qp-trie map
  selftests/bpf: add a simple test for qp-trie
  selftests/bpf: add benchmark for qp-trie map

 include/linux/bpf_types.h                     |    1 +
 include/uapi/linux/bpf.h                      |    8 +
 kernel/bpf/Makefile                           |    1 +
 kernel/bpf/bpf_qp_trie.c                      | 1064 +++++++++++++++++
 tools/include/uapi/linux/bpf.h                |    8 +
 tools/testing/selftests/bpf/Makefile          |    5 +-
 tools/testing/selftests/bpf/bench.c           |   10 +
 .../selftests/bpf/benchs/bench_qp_trie.c      |  499 ++++++++
 .../selftests/bpf/benchs/run_bench_qp_trie.sh |   55 +
 .../selftests/bpf/prog_tests/str_key.c        |   69 ++
 .../selftests/bpf/progs/qp_trie_bench.c       |  218 ++++
 tools/testing/selftests/bpf/progs/str_key.c   |   85 ++
 12 files changed, 2022 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/bpf_qp_trie.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_qp_trie.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_qp_trie.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/str_key.c
 create mode 100644 tools/testing/selftests/bpf/progs/qp_trie_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/str_key.c

-- 
2.29.2

