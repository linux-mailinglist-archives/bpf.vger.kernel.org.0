Return-Path: <bpf+bounces-9107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E478FC35
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45757281778
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B43A95E;
	Fri,  1 Sep 2023 11:20:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453FA943
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 11:20:04 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37301A8
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 04:20:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RcbCz2xynz4f3jMB
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 19:19:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDHoqXcyPFkv5VoCA--.40782S4;
	Fri, 01 Sep 2023 19:19:58 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf v2 0/3] bpf: Enable IRQ after irq_work_raise() completes
Date: Fri,  1 Sep 2023 19:19:51 +0800
Message-Id: <20230901111954.1804721-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHoqXcyPFkv5VoCA--.40782S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWUJFW5JFW3Wr17AF4xZwb_yoWrGw1rpF
	4xJayfKr1UGa9FvwsIy3ZrJFy3X3ySgr1kWw1Sqa15ZFs8XFyfXrs7Kr42qF98Wr4xGF1F
	krn2yr1xG34UJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset aims to fix the problem that bpf_mem_alloc() may return
NULL unexpectedly when multiple bpf_mem_alloc() are invoked concurrently
under process context and there is still free memory available. The
problem was found when doing stress test for qp-trie but the same
problem also exists for bpf_obj_new() as demonstrated in patch #3.

As pointed out by Alexei, the patchset can only fix ENOMEM problem for
normal process context and can not fix the problem for irq-disabled
context or RT-enabled kernel.

Patch #1 fixes the race between unit_alloc() and unit_alloc(). Patch #2
fixes the race between unit_alloc() and unit_free(). And patch #3 adds
a selftest for the problem. The major change compared with v1 is using
local_irq_{save,restore)() pair to disable and enable preemption
instead of preempt_{disable,enable}_notrace pair. The main reason is to
prevent potential overhead from __preempt_schedule_notrace(). I also
run htab_mem benchmark and hash_map_perf on a 8-CPUs KVM VM to compare
the performance between local_irq_{save,restore} and
preempt_{disable,enable}_notrace(), but the results are similar as shown
below:

(1) use preempt_{disable,enable}_notrace()

[root@hello bpf]# ./map_perf_test 4 8
0:hash_map_perf kmalloc 652179 events per sec
1:hash_map_perf kmalloc 651880 events per sec
2:hash_map_perf kmalloc 651382 events per sec
3:hash_map_perf kmalloc 650791 events per sec
5:hash_map_perf kmalloc 650140 events per sec
6:hash_map_perf kmalloc 652773 events per sec
7:hash_map_perf kmalloc 652751 events per sec
4:hash_map_perf kmalloc 648199 events per sec

[root@hello bpf]# ./benchs/run_bench_htab_mem.sh
normal bpf ma
=============
overwrite            per-prod-op: 110.82 ± 0.02k/s, avg mem: 2.00 ± 0.00MiB, peak mem: 2.73MiB
batch_add_batch_del  per-prod-op: 89.79 ± 0.75k/s, avg mem: 1.68 ± 0.38MiB, peak mem: 2.73MiB
add_del_on_diff_cpu  per-prod-op: 17.83 ± 0.07k/s, avg mem: 25.68 ± 2.92MiB, peak mem: 35.10MiB

(2) use local_irq_{save,restore}

[root@hello bpf]# ./map_perf_test 4 8
0:hash_map_perf kmalloc 656299 events per sec
1:hash_map_perf kmalloc 656397 events per sec
2:hash_map_perf kmalloc 656046 events per sec
3:hash_map_perf kmalloc 655723 events per sec
5:hash_map_perf kmalloc 655221 events per sec
4:hash_map_perf kmalloc 654617 events per sec
6:hash_map_perf kmalloc 650269 events per sec
7:hash_map_perf kmalloc 653665 events per sec

[root@hello bpf]# ./benchs/run_bench_htab_mem.sh
normal bpf ma
=============
overwrite            per-prod-op: 116.10 ± 0.02k/s, avg mem: 2.00 ± 0.00MiB, peak mem: 2.74MiB
batch_add_batch_del  per-prod-op: 88.76 ± 0.61k/s, avg mem: 1.94 ± 0.33MiB, peak mem: 2.74MiB
add_del_on_diff_cpu  per-prod-op: 18.12 ± 0.08k/s, avg mem: 25.10 ± 2.70MiB, peak mem: 34.78MiB

As ususal comments are always welcome.

Change Log:
v2:
  * Use local_irq_save to disable preemption instead of using
    preempt_{disable,enable}_notrace pair to prevent potential overhead

v1: https://lore.kernel.org/bpf/20230822133807.3198625-1-houtao@huaweicloud.com/

Hou Tao (3):
  bpf: Enable IRQ after irq_work_raise() completes in unit_alloc()
  bpf: Enable IRQ after irq_work_raise() completes in unit_free{_rcu}()
  selftests/bpf: Test preemption between bpf_obj_new() and
    bpf_obj_drop()

 kernel/bpf/memalloc.c                         |  16 ++-
 .../bpf/prog_tests/preempted_bpf_ma_op.c      |  89 +++++++++++++++
 .../selftests/bpf/progs/preempted_bpf_ma_op.c | 106 ++++++++++++++++++
 3 files changed, 208 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c

-- 
2.29.2


