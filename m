Return-Path: <bpf+bounces-51712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3090A379C3
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFB1188FA29
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAD14D2B7;
	Mon, 17 Feb 2025 02:36:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF920328
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739759773; cv=none; b=ZHt9tUnsXA/l7vvlpilN7U8AOUM3EXLMJfmpFfLpP6iHcS2dxeocOMwkKULSWVLgTRb5XQ5+8elxi74msiS5FeejUZwDTbyqj1MQfNmn0wnwnmqIXYqfFAaeTfSYP7ExPXZDW9xMAf4HviHmEO44sZuATOkFh+7l+/PPEQbkbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739759773; c=relaxed/simple;
	bh=7xjsonZlM5pXx4rXprqpb+ucSO92nFRHgzyC5Luminc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ujfTOwyKNCaZc357U3QkUwgrvx6uHDvo7WWkeNQep+HFZQtyo12JV6R7tugR8qyK/nRZFp3zn/1OVdur4pxJOp1VyhkBAK36gz9PuKHxRvH8Bwyc5K1n1TSP6JCuch0mlz5QIYK3sAsGjqsc2AYSOw0sn9pUX639tkiH1xqHbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Yx6GB2rXbz4f3jXS
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:35:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF42D1A17C7
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 10:36:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgCH6V2UoLJnH5RFEA--.46212S2;
	Mon, 17 Feb 2025 10:36:07 +0800 (CST)
Subject: Re: [PATCH -next 4/5] bpf: Remove map_delete_elem callbacks with
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
 <20250217014122.65645-5-zhangxiaomeng13@huawei.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ccb06134-669a-502e-7370-586ecc5fafae@huaweicloud.com>
Date: Mon, 17 Feb 2025 10:36:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014122.65645-5-zhangxiaomeng13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgCH6V2UoLJnH5RFEA--.46212S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4fGF13CF1kCry8JFW5ZFb_yoW7Xw1xpa
	yrKF18Cr4IqF42vayjgws5urWUZrn8Gw47Ga1kG34rAryDWFnrtr18uF1xXr1YvFy29r40
	grWIv34xt34xurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU10PfPUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 2/17/2025 9:41 AM, Xiaomeng Zhang wrote:
> Remove redundant map_delete_elem callbacks with return -EOPNOTSUPP. We can
> directly return -EOPNOTSUPP when calling the unimplemented callbacks.
>
> Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
> ---
>  kernel/bpf/arena.c        | 6 ------
>  kernel/bpf/bloom_filter.c | 6 ------
>  kernel/bpf/helpers.c      | 5 ++++-
>  kernel/bpf/ringbuf.c      | 7 -------
>  kernel/bpf/syscall.c      | 5 ++++-
>  5 files changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 2c95baa8ece2..50f07bbd33fa 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -62,11 +62,6 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
>  	return arena ? arena->user_vm_start : 0;
>  }
>  
> -static long arena_map_delete_elem(struct bpf_map *map, void *value)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
>  static int arena_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  {
>  	return -EOPNOTSUPP;
> @@ -390,7 +385,6 @@ const struct bpf_map_ops arena_map_ops = {
>  	.map_get_next_key = arena_map_get_next_key,
>  	.map_lookup_elem = arena_map_lookup_elem,
>  	.map_update_elem = arena_map_update_elem,
> -	.map_delete_elem = arena_map_delete_elem,
>  	.map_check_btf = arena_map_check_btf,
>  	.map_mem_usage = arena_map_mem_usage,
>  	.map_btf_id = &bpf_arena_map_btf_ids[0],
> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> index d8d4dd7b711d..f3bba8ac2532 100644
> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -65,11 +65,6 @@ static long bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
>  	return 0;
>  }
>  
> -static long bloom_map_delete_elem(struct bpf_map *map, void *value)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
>  static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  {
>  	return -EOPNOTSUPP;
> @@ -206,7 +201,6 @@ const struct bpf_map_ops bloom_filter_map_ops = {
>  	.map_peek_elem = bloom_map_peek_elem,
>  	.map_lookup_elem = bloom_map_lookup_elem,
>  	.map_update_elem = bloom_map_update_elem,
> -	.map_delete_elem = bloom_map_delete_elem,
>  	.map_check_btf = bloom_map_check_btf,
>  	.map_mem_usage = bloom_map_mem_usage,
>  	.map_btf_id = &bpf_bloom_map_btf_ids[0],
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cb61c06155c8..132c2830c758 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -74,7 +74,10 @@ BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
>  {
>  	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
>  		     !rcu_read_lock_bh_held());
> -	return map->ops->map_delete_elem(map, key);
> +	if (map->ops->map_delete_elem)
> +		return map->ops->map_delete_elem(map, key);
> +	else
> +		return -EOPNOTSUPP;
>  }
>  

It will be better to add the check for arena in
check_map_func_compatibility() statically, instead of adding an extra
branch for each invocation of bpf_map_delete_elem.

>  const struct bpf_func_proto bpf_map_delete_elem_proto = {
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 1499d8caa9a3..e2d22f10a11f 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -247,11 +247,6 @@ static long ringbuf_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	return -ENOTSUPP;
>  }
>  
> -static long ringbuf_map_delete_elem(struct bpf_map *map, void *key)
> -{
> -	return -ENOTSUPP;
> -}
> -
>  static int ringbuf_map_get_next_key(struct bpf_map *map, void *key,
>  				    void *next_key)
>  {
> @@ -356,7 +351,6 @@ const struct bpf_map_ops ringbuf_map_ops = {
>  	.map_poll = ringbuf_map_poll_kern,
>  	.map_lookup_elem = ringbuf_map_lookup_elem,
>  	.map_update_elem = ringbuf_map_update_elem,
> -	.map_delete_elem = ringbuf_map_delete_elem,
>  	.map_get_next_key = ringbuf_map_get_next_key,
>  	.map_mem_usage = ringbuf_map_mem_usage,
>  	.map_btf_id = &ringbuf_map_btf_ids[0],
> @@ -371,7 +365,6 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
>  	.map_poll = ringbuf_map_poll_user,
>  	.map_lookup_elem = ringbuf_map_lookup_elem,
>  	.map_update_elem = ringbuf_map_update_elem,
> -	.map_delete_elem = ringbuf_map_delete_elem,
>  	.map_get_next_key = ringbuf_map_get_next_key,
>  	.map_mem_usage = ringbuf_map_mem_usage,
>  	.map_btf_id = &user_ringbuf_map_btf_ids[0],
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c6f55283f4ff..36eed7016da4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1789,7 +1789,10 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
>  	} else if (IS_FD_PROG_ARRAY(map) ||
>  		   map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
>  		/* These maps require sleepable context */
> -		err = map->ops->map_delete_elem(map, key);
> +		if (map->ops->map_delete_elem)
> +			err = map->ops->map_delete_elem(map, key);
> +		else
> +			err = -EOPNOTSUPP;
>  		goto out;

The invocation has already checked the map type, the extra checking of
->map_delete_elem is unnecessary.
>  	}
>  


