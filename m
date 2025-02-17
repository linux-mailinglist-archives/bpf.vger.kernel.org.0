Return-Path: <bpf+bounces-51713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85545A379D4
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0F1882E0A
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236AC84D0E;
	Mon, 17 Feb 2025 02:42:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7E46BF
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760141; cv=none; b=o9x8IHXY4nO+hvSmdpJFZVDBIuuUD6Q8Q8AQ3GKGr7yBFOuglShLmMCeo9VsgyXx1JAxj1KPkRxe0uCqWkM9HHdT3LGkD9ugHghQRrPPWm09ZGAilFQmcU79JFgKGRVgrqx1T04F1CvvYyMDYPdWRctk+/OB3pQsNye6PklbhnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760141; c=relaxed/simple;
	bh=YQ//lo9Fj8968Rqv2SEiuYvdqw6cEhz9MVt8y5eNM/w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lHiCm8QJCwC7ua96P+JJbhumlDuAfVWo68dVaksDattbGOKHycIiLwe2tzEnPbN/pcH5fdJmof6XNTaejNttvCa19El/vqTuQg7dEx8ijArbCudLJ7mFkZahAfHppXoRC02SpjnQoaF0fgr1ImZrKFHfZgm1GCL4iig72Puw0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yx6PL3yhvz4f3jqM
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:41:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF5BD1A111E
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:42:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCX+V0CorJnR_lFEA--.13582S2;
	Mon, 17 Feb 2025 10:42:14 +0800 (CST)
Subject: Re: [PATCH -next 5/5] bpf: Remove map_get_next_key callbacks with
 -EOPNOTSUPP
To: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250217014122.65645-1-zhangxiaomeng13@huawei.com>
 <20250217014122.65645-6-zhangxiaomeng13@huawei.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <55580b0a-13a6-fee8-8b6f-4560a4c10680@huaweicloud.com>
Date: Mon, 17 Feb 2025 10:42:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014122.65645-6-zhangxiaomeng13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCX+V0CorJnR_lFEA--.13582S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1kGr1kCw45ZFWkXr1rtFb_yoW5uw43pF
	45tF1kCr4Iqr4j9ay5uan5CryUCw1DCw4fGa1kGa4Fkr1DXFnrtrn29F4fXryYvry7ur4j
	g3y2g34vv3yxuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUrsqXDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/17/2025 9:41 AM, Xiaomeng Zhang wrote:
> Remove redundant map_get_next_key callbacks with return -EOPNOTSUPP. We can
> directly return -EOPNOTSUPP when calling the unimplemented callbacks.
>
> Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
> ---
>  kernel/bpf/arena.c             |  6 ------
>  kernel/bpf/bloom_filter.c      |  6 ------
>  kernel/bpf/bpf_cgrp_storage.c  |  6 ------
>  kernel/bpf/bpf_inode_storage.c |  7 -------
>  kernel/bpf/bpf_task_storage.c  |  6 ------
>  kernel/bpf/ringbuf.c           |  8 --------
>  kernel/bpf/syscall.c           | 10 ++++++++--
>  7 files changed, 8 insertions(+), 41 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 50f07bbd33fa..7f37ef1b72ce 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -62,11 +62,6 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
>  	return arena ? arena->user_vm_start : 0;
>  }
>  

SNIP
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index e2d22f10a11f..932a6c06e3e0 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -247,12 +247,6 @@ static long ringbuf_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	return -ENOTSUPP;
>  }
>  
> -static int ringbuf_map_get_next_key(struct bpf_map *map, void *key,
> -				    void *next_key)
> -{
> -	return -ENOTSUPP;
> -}
> -
>  static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma)
>  {
>  	struct bpf_ringbuf_map *rb_map;
> @@ -351,7 +345,6 @@ const struct bpf_map_ops ringbuf_map_ops = {
>  	.map_poll = ringbuf_map_poll_kern,
>  	.map_lookup_elem = ringbuf_map_lookup_elem,
>  	.map_update_elem = ringbuf_map_update_elem,
> -	.map_get_next_key = ringbuf_map_get_next_key,
>  	.map_mem_usage = ringbuf_map_mem_usage,
>  	.map_btf_id = &ringbuf_map_btf_ids[0],
>  };
> @@ -365,7 +358,6 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
>  	.map_poll = ringbuf_map_poll_user,
>  	.map_lookup_elem = ringbuf_map_lookup_elem,
>  	.map_update_elem = ringbuf_map_update_elem,
> -	.map_get_next_key = ringbuf_map_get_next_key,
>  	.map_mem_usage = ringbuf_map_mem_usage,
>  	.map_btf_id = &user_ringbuf_map_btf_ids[0],
>  };
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 36eed7016da4..087abbacbd05 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1850,7 +1850,10 @@ static int map_get_next_key(union bpf_attr *attr)
>  	}
>  
>  	rcu_read_lock();
> -	err = map->ops->map_get_next_key(map, key, next_key);
> +	if (map->ops->map_get_next_key)
> +		err = map->ops->map_get_next_key(map, key, next_key);
> +	else
> +		err = -EOPNOTSUPP;

The old return value is ENOTSUPP. For consistency, I think it is better
to still return ENOTSUPP.
>  	rcu_read_unlock();
>  out:
>  	if (err)
> @@ -2037,7 +2040,10 @@ int generic_map_lookup_batch(struct bpf_map *map,
>  
>  	for (cp = 0; cp < max_count;) {
>  		rcu_read_lock();
> -		err = map->ops->map_get_next_key(map, prev_key, key);
> +		if (map->ops->map_get_next_key)
> +			err = map->ops->map_get_next_key(map, prev_key, key);
> +		else
> +			err = -EOPNOTSUPP;
>  		rcu_read_unlock();

How about only check ->map_get_next_key() once instead of checking it
every time ? And there are another two invocations of
->map_get_next_key(), please update these invocations as well.
>  		if (err)
>  			break;


