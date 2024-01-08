Return-Path: <bpf+bounces-19175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6840C826722
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 02:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45A61C21809
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A98F55;
	Mon,  8 Jan 2024 01:34:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593858F44
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T7c5z2GYrz4f3l1P
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 09:33:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 26A751A0281
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 09:33:49 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgC32Qz5UJtlQhe5AA--.11593S2;
	Mon, 08 Jan 2024 09:33:48 +0800 (CST)
Subject: Re: [PATCH bpf-next 0/2] bpf: Add benchmark for bpf memory allocator
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20231221141501.3588586-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f18a9b98-5afb-c008-a652-9804b3630fa9@huaweicloud.com>
Date: Mon, 8 Jan 2024 09:33:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231221141501.3588586-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgC32Qz5UJtlQhe5AA--.11593S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkXw1fXrW5Gw17Zw4Dtwb_yoW8Zw18pa
	1fKw15tr1rJF17Jw1fAa1UXFyfAws7urW5CF1ayr15Za1xXr97ZryxKrW8ZF98C3yavF13
	Zr4vvryfua15A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/21/2023 10:14 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set aims to add a benchmark for bpf memory allocator to test
> both its alloc/free ratio and the memory usage.
>
> Patch #1 is a preparatory patch which moves bench specific metrics into
> union of structs, so newly-added benchmark can add metrics which doesn't
> fit with the existing one easily. Patch #2 is the benchmark patch. It
> tests the performance through the following steps:
> 1) find the inner array by using the cpu number as key
> 2) allocate at most 64 128-bytes-sized objects through bpf_obj_new()
> 3) stash these objectes into the inner array through bpf_kptr_xchg()
> 4) account the time used in step 1)~3)
> 5) calculate the performance in M/s: alloc_cnt * 1000 / alloc_tim_ns
> 6) calculate the memory usage by reading slub field in memory.stat file
>    and get the final value after subtracting the base value.
>
> Please see individual patches for more details. And comments are always
> welcome.

Ping? It seems the patch set has been removed from PR queue of
kernel-patches/bpf, but I want to get some feedback before posting a v2
(need to update the benchmark result due to the merge of "bpf: Reduce
memory usage for bpf_global_percpu_ma​" patch set).
>
> Hou Tao (2):
>   selftests/bpf: Move bench specific metrics into union of structs
>   selftests/bpf: Add benchmark for bpf memory allocator
>
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |  13 +-
>  tools/testing/selftests/bpf/bench.h           |  22 +-
>  .../selftests/bpf/benchs/bench_bpf_ma.c       | 273 ++++++++++++++++++
>  .../selftests/bpf/benchs/bench_htab_mem.c     |  10 +-
>  .../bench_local_storage_rcu_tasks_trace.c     |  10 +-
>  .../selftests/bpf/progs/bench_bpf_ma.c        | 222 ++++++++++++++
>  7 files changed, 535 insertions(+), 17 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_ma.c
>


