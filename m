Return-Path: <bpf+bounces-6165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A87663F6
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 08:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FB0282630
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 06:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857EBA22;
	Fri, 28 Jul 2023 06:16:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411F3D86
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 06:16:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6A272D
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 23:16:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RBy7y2mNXz4f3jHw
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 14:16:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgD3FTA9XcNkwaPSOA--.23293S2;
	Fri, 28 Jul 2023 14:16:33 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next] bpf/memalloc: Non-atomically allocate
 freelist during prefill
To: YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
References: <20230728043359.3324347-1-zhuyifei@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <3c79f818-9d8e-6f6e-bdf6-1916ebb1f015@huaweicloud.com>
Date: Fri, 28 Jul 2023 14:16:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230728043359.3324347-1-zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgD3FTA9XcNkwaPSOA--.23293S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3Gr1xCw15ZrWxur18uFg_yoW8KF4rpF
	4xWr4DAF1qvr95Zw1vkw1rZr15Kr4kZ347JF95Krn8ZF4fGrn5Cr1xJF4qgF98urn8AFy7
	AFyqyrsrG34DtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/2023 12:33 PM, YiFei Zhu wrote:
> In internal testing of test_maps, we sometimes observed failures like:
>   test_maps: test_maps.c:173: void test_hashmap_percpu(unsigned int, void *):
>     Assertion `bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0' failed.
> where the errno is ENOMEM. After some troubleshooting and enabling
> the warnings, we saw:
>   [   91.304708] percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
>   [   91.304716] CPU: 51 PID: 24145 Comm: test_maps Kdump: loaded Tainted: G                 N 6.1.38-smp-DEV #7
>   [   91.304719] Hardware name: Google Astoria/astoria, BIOS 0.20230627.0-0 06/27/2023
>   [   91.304721] Call Trace:
>   [   91.304724]  <TASK>
>   [   91.304730]  [<ffffffffa7ef83b9>] dump_stack_lvl+0x59/0x88
>   [   91.304737]  [<ffffffffa7ef83f8>] dump_stack+0x10/0x18
>   [   91.304738]  [<ffffffffa75caa0c>] pcpu_alloc+0x6fc/0x870
>   [   91.304741]  [<ffffffffa75ca302>] __alloc_percpu_gfp+0x12/0x20
>   [   91.304743]  [<ffffffffa756785e>] alloc_bulk+0xde/0x1e0
>   [   91.304746]  [<ffffffffa7566c02>] bpf_mem_alloc_init+0xd2/0x2f0
>   [   91.304747]  [<ffffffffa7547c69>] htab_map_alloc+0x479/0x650
>   [   91.304750]  [<ffffffffa751d6e0>] map_create+0x140/0x2e0
>   [   91.304752]  [<ffffffffa751d413>] __sys_bpf+0x5a3/0x6c0
>   [   91.304753]  [<ffffffffa751c3ec>] __x64_sys_bpf+0x1c/0x30
>   [   91.304754]  [<ffffffffa7ef847a>] do_syscall_64+0x5a/0x80
>   [   91.304756]  [<ffffffffa800009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> This makes sense, because in atomic context, percpu allocation would
> not create new chunks; it would only create in non-atomic contexts.
> And if during prefill all precpu chunks are full, -ENOMEM would
> happen immediately upon next unit_alloc.
>
> Prefill phase does not actually run in atomic context, so we can
> use this fact to allocate non-atomically with GFP_KERNEL instead
> of GFP_NOWAIT. This avoids the immediate -ENOMEM.
>
> GFP_NOWAIT has to be used in unit_alloc when bpf program runs
> in atomic context. Even if bpf program runs in non-atomic context,
> in most cases, rcu read lock is enabled for the program so
> GFP_NOWAIT is still needed. This is often also the case for
> BPF_MAP_UPDATE_ELEM syscalls.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Acked-by: Hou Tao <houtao1@huawei.com>


