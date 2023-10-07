Return-Path: <bpf+bounces-11632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076F7BC844
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD92821A7
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB5286B1;
	Sat,  7 Oct 2023 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xc948M9j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0C27EFD
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 14:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222D1C433C7;
	Sat,  7 Oct 2023 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1696687504;
	bh=TXOjA+Agd74J8rmdkEBR95cIiet2rNUu8041DrQChKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xc948M9jX9aKrqVhVnqDtgcXkAk/ihHXD0NAgceg6QK/2XjNsrBsDvGsQv+793RYd
	 Ff/MB0NV5Gm9F3yZooF3TqRuSLavDNp358VtYbJsZ3W+GpoRuWjuqHPhJF6SNQWvT1
	 Ok33UEBMlSrFRR/Jm33uXyZFwolpK61pDIBf7TVc=
Date: Sat, 7 Oct 2023 07:04:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, houtao1@huawei.com, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@linux.com>
Subject: Re: [PATCH bpf-next 1/6] mm/percpu.c: introduce alloc_size_percpu()
Message-Id: <20231007070458.dcd3dbc7ebb63d1a89d09325@linux-foundation.org>
In-Reply-To: <20231007135106.3031284-2-houtao@huaweicloud.com>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
	<20231007135106.3031284-2-houtao@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Oct 2023 21:51:01 +0800 Hou Tao <houtao@huaweicloud.com> wrote:

> From: Hou Tao <houtao1@huawei.com>
> 
> Introduce alloc_size_percpu() to get the size of the dynamic per-cpu
> area. It will be used by bpf memory allocator in the following patches.
> BPF memory allocator maintains multiple per-cpu area caches for multiple
> area sizes and it needs the size of dynamic per-cpu area to select the
> corresponding cache when bpf program frees the dynamic per-cpu area.
> 
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2244,6 +2244,35 @@ static void pcpu_balance_workfn(struct work_struct *work)
>  	mutex_unlock(&pcpu_alloc_mutex);
>  }
>  
> +/**
> + * alloc_size_percpu - the size of the dynamic percpu area
> + * @ptr: pointer to the dynamic percpu area
> + *
> + * Return the size of the dynamic percpu area @ptr.
> + *
> + * RETURNS:
> + * The size of the dynamic percpu area.
> + *
> + * CONTEXT:
> + * Can be called from atomic context.
> + */
> +size_t alloc_size_percpu(void __percpu *ptr)
> +{
> +	struct pcpu_chunk *chunk;
> +	int bit_off, end;

It's minor, but I'd suggest unsigned long for both.

> +	void *addr;
> +
> +	if (!ptr)
> +		return 0;
> +
> +	addr = __pcpu_ptr_to_addr(ptr);
> +	/* No pcpu_lock here: ptr has not been freed, so chunk is still alive */
> +	chunk = pcpu_chunk_addr_search(addr);
> +	bit_off = (addr - chunk->base_addr) / PCPU_MIN_ALLOC_SIZE;

void* - void* is a ptrdiff_t, which is long or int.

> +	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk), bit_off + 1);

find_next_bit takes an unsigned long

> +	return (end - bit_off) * PCPU_MIN_ALLOC_SIZE;

And then we don't need to worry about signedness issues.

> +}
> +


