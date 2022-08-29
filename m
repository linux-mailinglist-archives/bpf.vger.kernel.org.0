Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6015A5696
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiH2V7j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiH2V7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 17:59:38 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E08C032
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 14:59:36 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmn4-0009ZZ-Ck; Mon, 29 Aug 2022 23:59:30 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSmn4-0004QQ-3v; Mon, 29 Aug 2022 23:59:30 +0200
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF specific
 memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     andrii@kernel.org, tj@kernel.org, memxor@gmail.com, delyank@fb.com,
        linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <181cb6ae-9d98-8986-4419-5013662b0189@iogearbox.net>
Date:   Mon, 29 Aug 2022 23:59:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220826024430.84565-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs can attach to kprobe and fentry. Hence they
> run in unknown context where calling plain kmalloc() might not be safe.
> 
> Front-end kmalloc() with minimal per-cpu cache of free elements.
> Refill this cache asynchronously from irq_work.
> 
> BPF programs always run with migration disabled.
> It's safe to allocate from cache of the current cpu with irqs disabled.
> Free-ing is always done into bucket of the current cpu as well.
> irq_work trims extra free elements from buckets with kfree
> and refills them with kmalloc, so global kmalloc logic takes care
> of freeing objects allocated by one cpu and freed on another.
> 
> struct bpf_mem_alloc supports two modes:
> - When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
>    This is typical bpf hash map use case when all elements have equal size.
> - When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
>    kmalloc/kfree. Max allocation size is 4096 in this case.
>    This is bpf_dynptr and bpf_kptr use case.
> 
> bpf_mem_alloc/bpf_mem_free are bpf specific 'wrappers' of kmalloc/kfree.
> bpf_mem_cache_alloc/bpf_mem_cache_free are 'wrappers' of kmem_cache_alloc/kmem_cache_free.
> 
> The allocators are NMI-safe from bpf programs only. They are not NMI-safe in general.
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   include/linux/bpf_mem_alloc.h |  26 ++
>   kernel/bpf/Makefile           |   2 +-
>   kernel/bpf/memalloc.c         | 476 ++++++++++++++++++++++++++++++++++
>   3 files changed, 503 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/bpf_mem_alloc.h
>   create mode 100644 kernel/bpf/memalloc.c
> 
[...]
> +#define NUM_CACHES 11
> +
> +struct bpf_mem_cache {
> +	/* per-cpu list of free objects of size 'unit_size'.
> +	 * All accesses are done with interrupts disabled and 'active' counter
> +	 * protection with __llist_add() and __llist_del_first().
> +	 */
> +	struct llist_head free_llist;
> +	local_t active;
> +
> +	/* Operations on the free_list from unit_alloc/unit_free/bpf_mem_refill
> +	 * are sequenced by per-cpu 'active' counter. But unit_free() cannot
> +	 * fail. When 'active' is busy the unit_free() will add an object to
> +	 * free_llist_extra.
> +	 */
> +	struct llist_head free_llist_extra;
> +
> +	/* kmem_cache != NULL when bpf_mem_alloc was created for specific
> +	 * element size.
> +	 */
> +	struct kmem_cache *kmem_cache;
> +	struct irq_work refill_work;
> +	struct obj_cgroup *objcg;
> +	int unit_size;
> +	/* count of objects in free_llist */
> +	int free_cnt;
> +};
> +
> +struct bpf_mem_caches {
> +	struct bpf_mem_cache cache[NUM_CACHES];
> +};
> +

Could we now also completely get rid of the current map prealloc infra (pcpu_freelist*
I mean), and replace it with above variant altogether? Would be nice to make it work
for this case, too, and then get rid of percpu_freelist.{h,c} .. it's essentially a
superset wrt functionality iiuc?

Thanks,
Daniel
