Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F437741004
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjF1L1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 07:27:07 -0400
Received: from dggsgout12.his.huawei.com ([45.249.212.56]:11136 "EHLO
        dggsgout12.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjF1L1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 07:27:03 -0400
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QrfS16RqMz4f3tCg;
        Wed, 28 Jun 2023 19:26:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LP_GJxk+A_oMg--.17043S4;
        Wed, 28 Jun 2023 19:26:57 +0800 (CST)
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
Subject: [PATCH bpf-next v7 0/2] Add benchmark for bpf memory allocator
Date:   Wed, 28 Jun 2023 19:59:08 +0800
Message-Id: <20230628115910.3817966-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LP_GJxk+A_oMg--.17043S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4fGF45AF4UWF1UCr1DGFg_yoW8tr4Dpa
        y8Ww15Gr17tFnrtr47CayjqaySywn7Wr15Xrn3Xry5ZF1UJrW8Zr1IgFW5XF9xuFZYgr4r
        ZrnFgF13uw1rA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

Beside adding a simple prepare patch, v7 mainly addresses suggestions
from Alexei. As ususal, comments and suggestions are always welcome.

Change Log:
v7:
 * Rename name of producer threads to avoid confusion
 * Make the comments in producer threads more clear
 * Remove unnecessary check of ctx->from in bpf program
 * Split add_del_on_diff bpf program to two bpf program for clarity

v6: https://lore.kernel.org/bpf/20230613080921.1623219-1-houtao@huaweicloud.com/
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

Hou Tao (2):
  selftests/bpf: Add min() and max() macros in bpf_util.h
  selftests/bpf: Add benchmark for bpf memory allocator

 tools/testing/selftests/bpf/Makefile          |   3 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_htab_mem.c     | 345 ++++++++++++++++++
 .../bpf/benchs/run_bench_htab_mem.sh          |  40 ++
 tools/testing/selftests/bpf/bpf_util.h        |   7 +
 .../selftests/bpf/progs/htab_mem_bench.c      | 105 ++++++
 6 files changed, 504 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
 create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c

-- 
2.29.2

