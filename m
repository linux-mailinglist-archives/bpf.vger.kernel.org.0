Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9396EA3CC
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjDUGXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjDUGXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 02:23:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81E6181;
        Thu, 20 Apr 2023 23:23:46 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q2kwW01rQz8xDM;
        Fri, 21 Apr 2023 14:22:51 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 14:23:43 +0800
Subject: Re: [RFC bpf-next v2 0/4] Introduce BPF_MA_REUSE_AFTER_RCU_GP
To:     Hou Tao <houtao@huaweicloud.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <dcea99d1-db34-da24-55bb-f9f9200b1d12@huawei.com>
Date:   Fri, 21 Apr 2023 14:23:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230408141846.1878768-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ping ?

On 4/8/2023 10:18 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> As discussed in v1, currently the freed objects in bpf memory allocator
> may be reused immediately by the new allocation, it introduces
> use-after-bpf-ma-free problem for non-preallocated hash map and makes
> lookup procedure return incorrect result. The immediate reuse also makes
> introducing new use case more difficult (e.g. qp-trie).
>
> The patch series tries to introduce BPF_MA_REUSE_AFTER_RCU_GP to solve
> these problems. For BPF_MA_REUSE_AFTER_GP, the freed objects are reused
> only after one RCU grace period and may be freed by bpf memory allocator
> after another RCU-tasks-trace grace period. So for bpf programs which
> care about reuse problem, these programs can use
> bpf_rcu_read_{lock,unlock}() to access these freed objects safely and
> for those which doesn't care, there will be safely use-after-bpf-ma-free
> because these objects have not been freed by bpf memory allocator.
>
> The current implementation is far from perfect, but I think it is ready
> for get some feedbacks before putting in more effort. The implementation
> mainly focus on how to speed up the transition from freed elements to
> reusable elements and try to reduce the risk of OOM.
>
> To accelerate the transition, it dynamically allocates rcu_head and call
> call_rcu() in a kworker to do the transition. The frequency of call_rcu()
> invocation could be improved by calling call_rcu() in irq work, but after
> did that, I found the RCU grace period increased a lot and I still could
> not figure out why. To reduce the risk of OOM, these reusable elements need
> to be free as well, but we can not dynamically allocate rcu_head to do
> that, because compared with RCU grace period RCU-tasks-trace grace
> period is slower, so the freeing of reusable elements is just like the
> freeing in normal bpf memory allocator, but these is one difference: for
> BPF_MA_REUSE_AFTER_GP bpf ma these freeing elements are still available
> for reuse in unit_alloc(). Please see individual patches for more details.
>
> Comments and suggestions are always welcome.
>
> Change Log:
> v2:
>  * add a benchmark for bpf memory allocator to compare between different
>    flavor of bpf memory allocator.
>  * implement BPF_MA_REUSE_AFTER_RCU_GP for bpf memory allocator.
> v1: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
>
> Hou Tao (4):
>   selftests/bpf: Add benchmark for bpf memory allocator
>   bpf: Factor out a common helper free_all()
>   bpf: Pass bitwise flags to bpf_mem_alloc_init()
>   bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
>
>  include/linux/bpf_mem_alloc.h                 |   9 +-
>  kernel/bpf/core.c                             |   2 +-
>  kernel/bpf/cpumask.c                          |   2 +-
>  kernel/bpf/hashtab.c                          |   5 +-
>  kernel/bpf/memalloc.c                         | 390 ++++++++++++++++--
>  tools/testing/selftests/bpf/Makefile          |   3 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_htab_mem.c     | 273 ++++++++++++
>  .../selftests/bpf/progs/htab_mem_bench.c      | 145 +++++++
>  9 files changed, 785 insertions(+), 48 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>  create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c
>

