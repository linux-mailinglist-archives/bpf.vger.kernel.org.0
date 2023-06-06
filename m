Return-Path: <bpf+bounces-1910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE787235B5
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 05:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043541C20DFC
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D95F7FE;
	Tue,  6 Jun 2023 03:20:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965162E
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 03:20:58 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105D1B5;
	Mon,  5 Jun 2023 20:20:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QZwjG45N4z4f3jXW;
	Tue,  6 Jun 2023 11:20:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBn0LMRpn5kcOYrLA--.7742S4;
	Tue, 06 Jun 2023 11:20:51 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org,
	houtao1@huawei.com
Subject: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory allocator
Date: Tue,  6 Jun 2023 11:53:07 +0800
Message-Id: <20230606035310.4026145-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn0LMRpn5kcOYrLA--.7742S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW8Gr4rXw43Jw4UtF1kXwb_yoWrur47pa
	yfKw43JrnrXrnF9w4xJw42qa48Zws3Wr45Gr1a9ry5ur45Xr97ur4IgF4rZry5urWUK3s0
	vrs2vr43ua4Fv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Hi,

The implementation of v4 is mainly based on suggestions from Alexi [0].
There are still pending problems for the current implementation as shown
in the benchmark result in patch #3, but there was a long time from the
posting of v3, so posting v4 here for further disscussions and more
suggestions.

The first problem is the huge memory usage compared with bpf memory
allocator which does immediate reuse:

htab-mem-benchmark (reuse-after-RCU-GP):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1159.18   | 0.99                | 0.99             |
| overwrite          | 11.00     | 2288                | 4109             |
| batch_add_batch_del| 8.86      | 1558                | 2763             |
| add_del_on_diff_cpu| 4.74      | 11.39               | 14.77            |

htab-mem-benchmark (immediate-reuse):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1160.66   | 0.99                | 1.00             |
| overwrite          | 28.52     | 2.46                | 2.73             |
| batch_add_batch_del| 11.50     | 2.69                | 2.95             |
| add_del_on_diff_cpu| 3.75      | 15.85               | 24.24            |

It seems the direct reason is the slow RCU grace period. During
benchmark, the elapsed time when reuse_rcu() callback is called is about
100ms or even more (e.g., 2 seconds). I suspect the global per-bpf-ma
spin-lock and the irq-work running in the contex of freeing process will
increase the running overhead of bpf program, the running time of
getpgid() is increased, the contex switch is slowed down and the RCU
grace period increases [1], but I am still diggin into it.

Another problem is the performance degradation compared with immediate
reuse and the output from perf report shown the per-bpf-ma spin-lock is a
top-one hotspot:

map_perf_test (reuse-after-RCU-GP)
0:hash_map_perf kmalloc 194677 events per sec

map_perf_test (immediate reuse)
2:hash_map_perf kmalloc 384527 events per sec

Considering the purpose of introducing per-bpf-ma reusable list is to
handle the case in which the allocation and free are done on different
CPUs (e.g., add_del_on_diff_cpu) and a per-cpu reuse list will be enough
for overwrite & batch_add_batch_del cases. So maybe we could implement a
hybrid of global reusable list and per-cpu reusable list and switch
between these two kinds of list according to the history of allocation
and free frequency.

As ususal, suggestions and comments are always welcome.

[0]: https://lore.kernel.org/bpf/20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local
[1]: https://lore.kernel.org/bpf/1b64fc4e-d92e-de2f-4895-2e0c36427425@huaweicloud.com

Change Log:
v4:
 * no kworker (Alexei)
 * Use a global reusable list in bpf memory allocator (Alexei)
 * Remove BPF_MA_FREE_AFTER_RCU_GP flag and do reuse-after-rcu-gp
   defaultly in bpf memory allocator (Alexei)
 * add benchmark results from map_perf_test (Alexei)

v3: https://lore.kernel.org/bpf/20230429101215.111262-1-houtao@huaweicloud.com/
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

Hou Tao (3):
  bpf: Factor out a common helper free_all()
  selftests/bpf: Add benchmark for bpf memory allocator
  bpf: Only reuse after one RCU GP in bpf memory allocator

 include/linux/bpf_mem_alloc.h                 |   4 +
 kernel/bpf/memalloc.c                         | 385 ++++++++++++------
 tools/testing/selftests/bpf/Makefile          |   3 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_htab_mem.c     | 352 ++++++++++++++++
 .../bpf/benchs/run_bench_htab_mem.sh          |  42 ++
 .../selftests/bpf/progs/htab_mem_bench.c      | 135 ++++++
 7 files changed, 809 insertions(+), 116 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c

-- 
2.29.2


