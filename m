Return-Path: <bpf+bounces-8548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38378818F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9262816B1
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8B5CBD;
	Fri, 25 Aug 2023 08:06:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7E1FD3
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:06:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7A1FDA;
	Fri, 25 Aug 2023 01:06:48 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXCDS2ycpzrSCZ;
	Fri, 25 Aug 2023 16:05:12 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 16:06:44 +0800
Message-ID: <ad5ef9ee-7fa7-b945-a303-2bdcdeb0e740@huawei.com>
Date: Fri, 25 Aug 2023 16:06:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v2 0/3] bpf, riscv: use BPF prog pack allocator
 in BPF JIT
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
CC: <bjorn@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<conor.dooley@microchip.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230824133135.1176709-1-puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/24 21:31, Puranjay Mohan wrote:
> Changes in v1 -> v2:
> 1. Implement a new function patch_text_set_nosync() to be used in bpf_arch_text_invalidate().
>     The implementation in v1 called patch_text_nosync() in a loop and it was bad as it would
>     call flush_icache_range() for every word making it really slow. This was found by running
>     the test_tag selftest which would take forever to complete.
> 
> Here is some data to prove the V2 fixes the problem:
> 
> Without this series:
> root@rv-selftester:~/src/kselftest/bpf# time ./test_tag
> test_tag: OK (40945 tests)
> 
> real    7m47.562s
> user    0m24.145s
> sys     6m37.064s
> 
> With this series applied:
> root@rv-selftester:~/src/selftest/bpf# time ./test_tag
> test_tag: OK (40945 tests)
> 
> real    7m29.472s
> user    0m25.865s
> sys     6m18.401s
> 
> BPF programs currently consume a page each on RISCV. For systems with many BPF
> programs, this adds significant pressure to instruction TLB. High iTLB pressure
> usually causes slow down for the whole system.
> 
> Song Liu introduced the BPF prog pack allocator[1] to mitigate the above issue.
> It packs multiple BPF programs into a single huge page. It is currently only
> enabled for the x86_64 BPF JIT.
> 
> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed now.
> 
> This patch series enables the BPF prog pack allocator for the RISCV BPF JIT.
> This series needs a patch[3] from the ARM64 series to work.

Is there a new version for arm64 currently? Maybe we could submit this 
patch first as a separate patch to avoid dependencies.

> 
> ======================================================
> Performance Analysis of prog pack allocator on RISCV64
> ======================================================
> 
> Test setup:
> ===========
> 
> Host machine: Debian GNU/Linux 11 (bullseye)
> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
> u-boot-qemu Version: 2023.07+dfsg-1
> opensbi Version: 1.3-1
> 
> To test the performance of the BPF prog pack allocator on RV, a stresser
> tool[4] linked below was built. This tool loads 8 BPF programs on the system and
> triggers 5 of them in an infinite loop by doing system calls.
> 
> The runner script starts 20 instances of the above which loads 8*20=160 BPF
> programs on the system, 5*20=100 of which are being constantly triggered.
> The script is passed a command which would be run in the above environment.
> 
> The script was run with following perf command:
> ./run.sh "perf stat -a \
>          -e iTLB-load-misses \
>          -e dTLB-load-misses  \
>          -e dTLB-store-misses \
>          -e instructions \
>          --timeout 60000"
> 
> The output of the above command is discussed below before and after enabling the
> BPF prog pack allocator.
> 
> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The rootfs
> was created using Bjorn's riscv-cross-builder[5] docker container linked below.
> 
> Results
> =======
> 
> Before enabling prog pack allocator:
> ------------------------------------
> 
> Performance counter stats for 'system wide':
> 
>             4939048      iTLB-load-misses
>             5468689      dTLB-load-misses
>              465234      dTLB-store-misses
>       1441082097998      instructions
> 
>        60.045791200 seconds time elapsed
> 
> After enabling prog pack allocator:
> -----------------------------------
> 
> Performance counter stats for 'system wide':
> 
>             3430035      iTLB-load-misses
>             5008745      dTLB-load-misses
>              409944      dTLB-store-misses
>       1441535637988      instructions
> 
>        60.046296600 seconds time elapsed
> 
> Improvements in metrics
> =======================
> 
> It was expected that the iTLB-load-misses would decrease as now a single huge
> page is used to keep all the BPF programs compared to a single page for each
> program earlier.
> 
> --------------------------------------------
> The improvement in iTLB-load-misses: -30.5 %
> --------------------------------------------
> 
> I repeated this expriment more than 100 times in different setups and the
> improvement was always greater than 30%.
> 
> This patch series is boot tested on the Starfive VisionFive 2 board[6].
> The performance analysis was not done on the board because it doesn't
> expose iTLB-load-misses, etc. The stresser program was run on the board to test
> the loading and unloading of BPF programs
> 
> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.org/
> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gmail.com/
> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gmail.com/
> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
> [5] https://github.com/bjoto/riscv-cross-builder
> [6] https://www.starfivetech.com/en/site/boards
> 
> Puranjay Mohan (3):
>    riscv: extend patch_text_nosync() for multiple pages
>    riscv: implement a memset like function for text
>    bpf, riscv: use prog pack allocator in the BPF JIT
> 
>   arch/riscv/include/asm/patch.h  |   1 +
>   arch/riscv/kernel/patch.c       | 113 ++++++++++++++++++++++++++++++--
>   arch/riscv/net/bpf_jit.h        |   3 +
>   arch/riscv/net/bpf_jit_comp64.c |  56 +++++++++++++---
>   arch/riscv/net/bpf_jit_core.c   | 113 +++++++++++++++++++++++++++-----
>   5 files changed, 255 insertions(+), 31 deletions(-)
> 

