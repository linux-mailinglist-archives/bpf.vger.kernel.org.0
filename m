Return-Path: <bpf+bounces-14552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB87E63F4
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 07:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B755D1C20A16
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294ED524;
	Thu,  9 Nov 2023 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Knsk2FZN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613794C7F
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 06:36:20 +0000 (UTC)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B381326B0
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 22:36:19 -0800 (PST)
Message-ID: <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699511777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICVEYfnNgGy9vxtKj3QeCNP+EarIDdX8hEsb4xbm+qg=;
	b=Knsk2FZNdFZqwnfwJlS+IePFB2e8RkxfWetdvOerR/UA8ZrBgBPT1IPNNEBb2jYKmMPqlx
	NEavvUCHV7V6KI8nKO9XeTqtoYUXbiVLEE7yFBb50MV63KClHeFkkrgxkqy+ph/SkfJI/b
	xaSppLe23Iy6qS1RjTnplYSXWKGTFgI=
Date: Wed, 8 Nov 2023 22:36:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr()
 helpers
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 bpf@vger.kernel.org
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-6-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231107140702.1891778-6-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/7/23 6:06 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> bpf_map_of_map_fd_get_ptr() will convert the map fd to the pointer
> saved in map-in-map. bpf_map_of_map_fd_put_ptr() will release the
> pointer saved in map-in-map. These two helpers will be used by the
> following patches to fix the use-after-free problems for map-in-map.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   kernel/bpf/map_in_map.c | 51 +++++++++++++++++++++++++++++++++++++++++
>   kernel/bpf/map_in_map.h | 11 +++++++--
>   2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 8323ce201159d..96e32f4167c4e 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -4,6 +4,7 @@
>   #include <linux/slab.h>
>   #include <linux/bpf.h>
>   #include <linux/btf.h>
> +#include <linux/rcupdate.h>
>   
>   #include "map_in_map.h"
>   
> @@ -139,3 +140,53 @@ u32 bpf_map_fd_sys_lookup_elem(void *ptr)
>   {
>   	return ((struct bpf_map *)ptr)->id;
>   }
> +
> +void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
> +			       int ufd)
> +{
> +	struct bpf_inner_map_element *element;
> +	struct bpf_map *inner_map;
> +
> +	element = kmalloc(sizeof(*element), GFP_KERNEL);
> +	if (!element)
> +		return ERR_PTR(-ENOMEM);
> +
> +	inner_map = bpf_map_fd_get_ptr(map, map_file, ufd);
> +	if (IS_ERR(inner_map)) {
> +		kfree(element);
> +		return inner_map;
> +	}
> +
> +	element->map = inner_map;
> +	return element;
> +}
> +
> +static void bpf_inner_map_element_free_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_inner_map_element *elem = container_of(rcu, struct bpf_inner_map_element, rcu);
> +
> +	bpf_map_put(elem->map);
> +	kfree(elem);
> +}
> +
> +static void bpf_inner_map_element_free_tt_rcu(struct rcu_head *rcu)
> +{
> +	if (rcu_trace_implies_rcu_gp())
> +		bpf_inner_map_element_free_rcu(rcu);
> +	else
> +		call_rcu(rcu, bpf_inner_map_element_free_rcu);
> +}
> +
> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
> +{
> +	struct bpf_inner_map_element *element = ptr;
> +
> +	/* Do bpf_map_put() after a RCU grace period and a tasks trace
> +	 * RCU grace period, so it is certain that the bpf program which is
> +	 * manipulating the map now has exited when bpf_map_put() is called.
> +	 */
> +	if (need_defer)

"need_defer" should only happen from the syscall cmd? Instead of adding rcu_head 
to each element, how about "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?

> +		call_rcu_tasks_trace(&element->rcu, bpf_inner_map_element_free_tt_rcu);
> +	else
> +		bpf_inner_map_element_free_rcu(&element->rcu);
> +}
> diff --git a/kernel/bpf/map_in_map.h b/kernel/bpf/map_in_map.h
> index 63872bffd9b3c..8d38496e5179b 100644
> --- a/kernel/bpf/map_in_map.h
> +++ b/kernel/bpf/map_in_map.h
> @@ -9,11 +9,18 @@
>   struct file;
>   struct bpf_map;
>   
> +struct bpf_inner_map_element {
> +	struct bpf_map *map;
> +	struct rcu_head rcu;
> +};
> +
>   struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd);
>   void bpf_map_meta_free(struct bpf_map *map_meta);
> -void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file,
> -			 int ufd);
> +void *bpf_map_fd_get_ptr(struct bpf_map *map, struct file *map_file, int ufd);
>   void bpf_map_fd_put_ptr(void *ptr, bool need_defer);
>   u32 bpf_map_fd_sys_lookup_elem(void *ptr);
>   
> +void *bpf_map_of_map_fd_get_ptr(struct bpf_map *map, struct file *map_file, int ufd);
> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer);
> +
>   #endif


