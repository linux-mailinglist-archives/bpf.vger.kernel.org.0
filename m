Return-Path: <bpf+bounces-2485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343DB72DB19
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7974A1C2096B
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDBA568E;
	Tue, 13 Jun 2023 07:37:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EDB5669
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 07:37:17 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3A91713;
	Tue, 13 Jun 2023 00:37:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgL3h6w4Xz4f3jHv;
	Tue, 13 Jun 2023 15:37:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3X7OdHIhkfcdhLg--.52188S4;
	Tue, 13 Jun 2023 15:37:03 +0800 (CST)
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
Subject: [PATCH bpf-next v6 0/5] Add benchmark for bpf memory allocator
Date: Tue, 13 Jun 2023 16:09:16 +0800
Message-Id: <20230613080921.1623219-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3X7OdHIhkfcdhLg--.52188S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4xGF1xJr4UuF4xGFy8Zrb_yoW5tFWxpa
	n7Kw1Yyr13JFn7tw4xC34UtFWfAw1DWry5WrnIyr1UZ3W7JryFvr1xKrWrXFZ8ta4rtr1r
	ZrZFqr1fW3WFy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Hi,

This patchset includes some trivial fixes for benchmark framework and
a new benchmark for bpf memory allocator originated from handle-reuse
patchset. Because htab-mem benchmark depends the fixes, so I post these
patches together.

Patch #1 fixes the allocation of local counter. Patch #2 fixes the
outputted error code in error message when using pthead APIs. Patch #3
makes the benchmark run successfuly when the number of consumers and
producers are greater than the number of online CPUs. Patch #4 sets the
default value of consumer_cnt as 0, so all online CPUs could be used by
producer threads. Patch #5 adds a new bpf memory allocator benchmark to
measure the performance and memory usage of bpf hash table map.

Please see individual patches for more details. Comments and suggestions
are always welcome.

Change Log:
v6:
  * add fix patches for benchmark framework
  * updates for htab-mem benchmark (Most of updates are suggested by Alexei)
    * remove --full and --max-entries and use a fixed 8k size for htab
    * remove op_factor and increase op_cnt correctly
    * use -a instead of --prod-affinity in run_bench_htab_mem.sh
    * use $RUN_BENCH in run_bench_htab_mem.sh
    * call cleanup_cgroup_environment() at the end of htab_mem_report_final()

v5: https://lore.kernel.org/bpf/ff4b2396-48aa-28f1-c91b-7c8a4b9510bb@huaweicloud.com/
 * send the benchmark patch alone (suggested by Alexei)
 * limit the max number of touched elements per-bpf-program call to 64 (from Alexei)
 * show per-producer performance (from Alexei)
 * handle the return value of read() (from BPF CI)
 * do cleanup_cgroup_environment() in htab_mem_report_final()

v4: https://lore.kernel.org/bpf/20230606035310.4026145-1-houtao@huaweicloud.com/

Hou Tao (5):
  selftests/bpf: Use producer_cnt to allocate local counter array
  selftests/bpf: Output the correct error code for pthread APIs
  selftests/bpf: Ensure that next_cpu() returns a valid CPU number
  selftests/bpf: Set the default value of consumer_cnt as 0
  selftests/bpf: Add benchmark for bpf memory allocator

 tools/testing/selftests/bpf/Makefile          |   3 +
 tools/testing/selftests/bpf/bench.c           |  19 +-
 tools/testing/selftests/bpf/bench.h           |   1 +
 .../bpf/benchs/bench_bloom_filter_map.c       |  14 +-
 .../benchs/bench_bpf_hashmap_full_update.c    |  10 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c     |  10 +-
 .../selftests/bpf/benchs/bench_bpf_loop.c     |  10 +-
 .../selftests/bpf/benchs/bench_count.c        |  14 +-
 .../selftests/bpf/benchs/bench_htab_mem.c     | 303 ++++++++++++++++++
 .../bpf/benchs/bench_local_storage.c          |  12 +-
 .../bpf/benchs/bench_local_storage_create.c   |   8 +-
 .../bench_local_storage_rcu_tasks_trace.c     |  10 +-
 .../selftests/bpf/benchs/bench_rename.c       |  15 +-
 .../selftests/bpf/benchs/bench_ringbufs.c     |   2 +-
 .../selftests/bpf/benchs/bench_strncmp.c      |  11 +-
 .../selftests/bpf/benchs/bench_trigger.c      |  21 +-
 .../bpf/benchs/run_bench_htab_mem.sh          |  40 +++
 .../bpf/benchs/run_bench_ringbufs.sh          |  26 +-
 .../selftests/bpf/progs/htab_mem_bench.c      | 107 +++++++
 19 files changed, 502 insertions(+), 134 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c

-- 
2.29.2


