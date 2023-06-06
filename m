Return-Path: <bpf+bounces-1929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4B5724222
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 14:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129AA1C20FCD
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D8E14260;
	Tue,  6 Jun 2023 12:31:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C72A9E7
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 12:31:14 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188110C6;
	Tue,  6 Jun 2023 05:31:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qb8w9262tz4f41SX;
	Tue,  6 Jun 2023 20:31:05 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXMBsCJ39kBDPNKQ--.34580S2;
	Tue, 06 Jun 2023 20:31:04 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v4 0/3] Handle immediate reuse in bpf memory
 allocator
To: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f0e77d34-7459-8375-d844-4b0c8d79eb8f@huaweicloud.com>
Date: Tue, 6 Jun 2023 20:30:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606035310.4026145-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXMBsCJ39kBDPNKQ--.34580S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyfWw4UGw43Zry7AFWrZrb_yoWxWw13pr
	WSgw43JrnrXrnF9ws7Aw1xAa4UAws3Xr43KF1S9ryDuw15Xryxurs29F4FvFy5WrWDC3s0
	qF4vy3y3Z3Z5C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/6/2023 11:53 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The implementation of v4 is mainly based on suggestions from Alexi [0].
> There are still pending problems for the current implementation as shown
> in the benchmark result in patch #3, but there was a long time from the
> posting of v3, so posting v4 here for further disscussions and more
> suggestions.
>
> The first problem is the huge memory usage compared with bpf memory
> allocator which does immediate reuse:
>
> htab-mem-benchmark (reuse-after-RCU-GP):
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
> | --                 | --        | --                  | --               |
> | no_op              | 1159.18   | 0.99                | 0.99             |
> | overwrite          | 11.00     | 2288                | 4109             |
> | batch_add_batch_del| 8.86      | 1558                | 2763             |
> | add_del_on_diff_cpu| 4.74      | 11.39               | 14.77            |
>
> htab-mem-benchmark (immediate-reuse):
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
> | --                 | --        | --                  | --               |
> | no_op              | 1160.66   | 0.99                | 1.00             |
> | overwrite          | 28.52     | 2.46                | 2.73             |
> | batch_add_batch_del| 11.50     | 2.69                | 2.95             |
> | add_del_on_diff_cpu| 3.75      | 15.85               | 24.24            |
>
> It seems the direct reason is the slow RCU grace period. During
> benchmark, the elapsed time when reuse_rcu() callback is called is about
> 100ms or even more (e.g., 2 seconds). I suspect the global per-bpf-ma
> spin-lock and the irq-work running in the contex of freeing process will
> increase the running overhead of bpf program, the running time of
> getpgid() is increased, the contex switch is slowed down and the RCU
> grace period increases [1], but I am still diggin into it.
For reuse-after-RCU-GP flavor, by removing per-bpf-ma reusable list
(namely bpf_mem_shared_cache) and using per-cpu reusable list (like v3
did) instead, the memory usage of htab-mem-benchmark will decrease a lot:

htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1165.38   | 0.97                | 1.00             |
| overwrite          | 17.25     | 626.41              | 781.82           |
| batch_add_batch_del| 11.51     | 398.56              | 500.29           |
| add_del_on_diff_cpu| 4.21      | 31.06               | 48.84            |

But the memory usage is still large compared with v3 and the elapsed
time of reuse_rcu() callback is about 90~200ms. Compared with v3, there
are still two differences:
1) v3 uses kmalloc() to allocate multiple inflight RCU callbacks to
accelerate the reuse of freed objects.
2) v3 uses kworker instead of irq_work for free procedure.

For 1), after using kmalloc() in irq_work to allocate multiple inflight
RCU callbacks (namely reuse_rcu()), the memory usage decreases a bit,
but is not enough:

htab-mem-benchmark (reuse-after-RCU-GP + per-cpu reusable list + multiple reuse_rcu() callbacks):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1247.00   | 0.97                | 1.00             |
| overwrite          | 16.56     | 490.18              | 557.17           |
| batch_add_batch_del| 11.31     | 276.32              | 360.89           |
| add_del_on_diff_cpu| 4.00      | 24.76               | 42.58            |

So it seems the large memory usage is due to irq_work (reuse_bulk) used
for free procedure. However after increasing the threshold for invoking
irq_work reuse_bulk (e.g., use 10 * c->high_watermark), but there is no
big difference in the memory usage and the delayed time for RCU
callbacks. Perhaps the reason is that although the number of  reuse_bulk
irq_work calls is reduced but the time of alloc_bulk() irq_work calls is
increased because there are no reusable objects.

>
> Another problem is the performance degradation compared with immediate
> reuse and the output from perf report shown the per-bpf-ma spin-lock is a
> top-one hotspot:
>
> map_perf_test (reuse-after-RCU-GP)
> 0:hash_map_perf kmalloc 194677 events per sec
>
> map_perf_test (immediate reuse)
> 2:hash_map_perf kmalloc 384527 events per sec
>
> Considering the purpose of introducing per-bpf-ma reusable list is to
> handle the case in which the allocation and free are done on different
> CPUs (e.g., add_del_on_diff_cpu) and a per-cpu reuse list will be enough
> for overwrite & batch_add_batch_del cases. So maybe we could implement a
> hybrid of global reusable list and per-cpu reusable list and switch
> between these two kinds of list according to the history of allocation
> and free frequency.
>
> As ususal, suggestions and comments are always welcome.
>
> [0]: https://lore.kernel.org/bpf/20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local
> [1]: https://lore.kernel.org/bpf/1b64fc4e-d92e-de2f-4895-2e0c36427425@huaweicloud.com
>
> Change Log:
> v4:
>  * no kworker (Alexei)
>  * Use a global reusable list in bpf memory allocator (Alexei)
>  * Remove BPF_MA_FREE_AFTER_RCU_GP flag and do reuse-after-rcu-gp
>    defaultly in bpf memory allocator (Alexei)
>  * add benchmark results from map_perf_test (Alexei)
>
> v3: https://lore.kernel.org/bpf/20230429101215.111262-1-houtao@huaweicloud.com/
>  * add BPF_MA_FREE_AFTER_RCU_GP bpf memory allocator
>  * Update htab memory benchmark
>    * move the benchmark patch to the last patch
>    * remove array and useless bpf_map_lookup_elem(&array, ...) in bpf
>      programs
>    * add synchronization between addition CPU and deletion CPU for
>      add_del_on_diff_cpu case to prevent unnecessary loop
>    * add the benchmark result for "extra call_rcu + bpf ma"
>
> v2: https://lore.kernel.org/bpf/20230408141846.1878768-1-houtao@huaweicloud.com/
>  * add a benchmark for bpf memory allocator to compare between different
>    flavor of bpf memory allocator.
>  * implement BPF_MA_REUSE_AFTER_RCU_GP for bpf memory allocator.
>
> v1: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
>
> Hou Tao (3):
>   bpf: Factor out a common helper free_all()
>   selftests/bpf: Add benchmark for bpf memory allocator
>   bpf: Only reuse after one RCU GP in bpf memory allocator
>
>  include/linux/bpf_mem_alloc.h                 |   4 +
>  kernel/bpf/memalloc.c                         | 385 ++++++++++++------
>  tools/testing/selftests/bpf/Makefile          |   3 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_htab_mem.c     | 352 ++++++++++++++++
>  .../bpf/benchs/run_bench_htab_mem.sh          |  42 ++
>  .../selftests/bpf/progs/htab_mem_bench.c      | 135 ++++++
>  7 files changed, 809 insertions(+), 116 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c
>


