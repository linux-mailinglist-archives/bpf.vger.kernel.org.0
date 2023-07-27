Return-Path: <bpf+bounces-6106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CBE765E93
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D2B2824D4
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4183A1DA41;
	Thu, 27 Jul 2023 21:59:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9F17AC4
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 21:59:05 +0000 (UTC)
Received: from out-95.mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E87100
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 14:59:03 -0700 (PDT)
Message-ID: <faf7fbeb-b35f-5b38-2be2-c863f939acb8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690495142; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neMfnNCWwYTixT1gu8nJPFzj8qQ+Y0KTTQJ3nrjy/nM=;
	b=xwan2njnEM0F9iK6B7sibK3yxeF88Qbl+GBFXboA/w689MgQSGxliaKyOz6I1J0wzbuSJw
	yt5hWXHExgZr7QpsbB1k4jrPujhsEx/0Qf08T9KSwTcgOYynUL2iNDxVjNb2+YOfDF6jJf
	wnriW+cvhXpusPXPxAs3emR+pb6n4K8=
Date: Thu, 27 Jul 2023 14:58:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next] bpf/memalloc: Non-atomically allocate
 freelist during prefill
Content-Language: en-US
To: YiFei Zhu <zhuyifei@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@google.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Hou Tao <houtao@huaweicloud.com>
References: <20230727201809.3232201-1-zhuyifei@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230727201809.3232201-1-zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 1:18 PM, YiFei Zhu wrote:
> In internal testing of test_maps, we sometimes observed failures like:
>    test_maps: test_maps.c:173: void test_hashmap_percpu(unsigned int, void *):
>      Assertion `bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0' failed.
> where the errno is ENOMEM. After some troubleshooting and enabling
> the warnings, we saw:
>    [   91.304708] percpu: allocation failed, size=8 align=8 atomic=1, atomic alloc failed, no space left
>    [   91.304716] CPU: 51 PID: 24145 Comm: test_maps Kdump: loaded Tainted: G                 N 6.1.38-smp-DEV #7
>    [   91.304719] Hardware name: Google Astoria/astoria, BIOS 0.20230627.0-0 06/27/2023
>    [   91.304721] Call Trace:
>    [   91.304724]  <TASK>
>    [   91.304730]  [<ffffffffa7ef83b9>] dump_stack_lvl+0x59/0x88
>    [   91.304737]  [<ffffffffa7ef83f8>] dump_stack+0x10/0x18
>    [   91.304738]  [<ffffffffa75caa0c>] pcpu_alloc+0x6fc/0x870
>    [   91.304741]  [<ffffffffa75ca302>] __alloc_percpu_gfp+0x12/0x20
>    [   91.304743]  [<ffffffffa756785e>] alloc_bulk+0xde/0x1e0
>    [   91.304746]  [<ffffffffa7566c02>] bpf_mem_alloc_init+0xd2/0x2f0
>    [   91.304747]  [<ffffffffa7547c69>] htab_map_alloc+0x479/0x650
>    [   91.304750]  [<ffffffffa751d6e0>] map_create+0x140/0x2e0
>    [   91.304752]  [<ffffffffa751d413>] __sys_bpf+0x5a3/0x6c0
>    [   91.304753]  [<ffffffffa751c3ec>] __x64_sys_bpf+0x1c/0x30
>    [   91.304754]  [<ffffffffa7ef847a>] do_syscall_64+0x5a/0x80
>    [   91.304756]  [<ffffffffa800009b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
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
> Unfortunately unit_alloc runs in atomic context, even from map
> item allocation in syscalls, due to rcu_read_lock, so we can't do
> non-atomic workarounds in unit_alloc.

The above description is not clear to me. Do you mean
   GFP_NOWAIT has to be used in unit_alloc when bpf program runs
   in atomic context. Even if bpf program runs in non-atomic context,
   in most cases, rcu read lock is enabled for the program so
   GFP_NOWAIT is still needed.

The exception is sleepable bpf program in non-atomic context,
e.g., sleepable bpf_iter program, sleepable fentry program
in non-atomic context, and the unit_alloc is not inside
bpf_rcu_read_lock kfunc. But this is too complicated and
probably not worthwhile to special-case it.

> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Acked-by: Yonghong Song <yhs@fb.com>

> ---
> v1->v2:
> - Rebase from bpf to bpf-next
> - Dropped second patch and edited commit message to include parts
>    of original cover letter, and dropped Fixes tag
> ---
>   kernel/bpf/memalloc.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 14d9b1a9a4ca..9c49ae53deaf 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -201,12 +201,16 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
>   }
>   
>   /* Mostly runs from irq_work except __init phase. */
> -static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>   {
>   	struct mem_cgroup *memcg = NULL, *old_memcg;
> +	gfp_t gfp;
>   	void *obj;
>   	int i;
>   
> +	gfp = __GFP_NOWARN | __GFP_ACCOUNT;
> +	gfp |= atomic ? GFP_NOWAIT : GFP_KERNEL;
> +
>   	for (i = 0; i < cnt; i++) {
>   		/*
>   		 * For every 'c' llist_del_first(&c->free_by_rcu_ttrace); is
> @@ -238,7 +242,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
>   		 * will allocate from the current numa node which is what we
>   		 * want here.
>   		 */
> -		obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
> +		obj = __alloc(c, node, gfp);
>   		if (!obj)
>   			break;
>   		add_obj_to_free_list(c, obj);
> @@ -429,7 +433,7 @@ static void bpf_mem_refill(struct irq_work *work)
>   		/* irq_work runs on this cpu and kmalloc will allocate
>   		 * from the current numa node which is what we want here.
>   		 */
> -		alloc_bulk(c, c->batch, NUMA_NO_NODE);
> +		alloc_bulk(c, c->batch, NUMA_NO_NODE, true);
>   	else if (cnt > c->high_watermark)
>   		free_bulk(c);
>   
> @@ -477,7 +481,7 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>   	 * prog won't be doing more than 4 map_update_elem from
>   	 * irq disabled region
>   	 */
> -	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
> +	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
>   }
>   
>   /* When size != 0 bpf_mem_cache for each cpu.

