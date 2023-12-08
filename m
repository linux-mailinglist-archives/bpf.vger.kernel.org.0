Return-Path: <bpf+bounces-17265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DE80AFF4
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93918B20BDC
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725655A0E6;
	Fri,  8 Dec 2023 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IciT/WQG"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA810D2
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 14:55:51 -0800 (PST)
Message-ID: <35510021-8c55-455b-894f-6b7656f8b8d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702076150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYZ6wUpAA2diajEV+4wVlpbop/QH8EhfTAWtI/yI1M0=;
	b=IciT/WQGN12cl3mzUMYuhUrJQTp1IOr+UCv4AdWowNSJJBmKLnOOEnhQRf+8Cdd4lP7zvl
	WK/ZZIvBsYcNKKVeIq34J0kwE20P3s5HuTmgIz/7EN8Qxn48lBNYafIH7+WfuOOCVEZISQ
	cHKYXQdhOoj6DAlZk+uBSZ1XcKt4ZJE=
Date: Fri, 8 Dec 2023 14:55:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/7] bpf: Only call maybe_wait_bpf_programs()
 when at least one map operation succeeds
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
 <20231208102355.2628918-7-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231208102355.2628918-7-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/8/23 2:23 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> There is no need to call maybe_wait_bpf_programs() if all operations in
> batched update, deletion, or lookup_and_deletion fail. So only call
> maybe_wait_bpf_programs() if at least one map operation succeeds.
>
> Similar with uattr->batch.count which is used to return the number of
> succeeded map operations to userspace application, use attr->batch.count
> to record the number of succeeded map operations in kernel. Sometimes
> these two number may be different. For example, in
> __htab_map_lookup_and_delete_batch(do_delete=true), it is possible that
> 10 items in current bucket have been successfully deleted, but copying
> the deleted keys to userspace application fails, attr->batch.count will
> be 10 but uattr->batch.count will be 0 instead.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   include/linux/bpf.h  | 14 +++++++-------
>   kernel/bpf/hashtab.c | 20 +++++++++++---------
>   kernel/bpf/syscall.c | 21 ++++++++++++++-------
>   3 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f7aa255c634f..a0c4d696a231 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -81,17 +81,17 @@ struct bpf_map_ops {
>   	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
>   	void (*map_release_uref)(struct bpf_map *map);
>   	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
> -	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
> +	int (*map_lookup_batch)(struct bpf_map *map, union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
>   	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
>   					  void *value, u64 flags);
>   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
> -					   const union bpf_attr *attr,
> +					   union bpf_attr *attr,
>   					   union bpf_attr __user *uattr);
>   	int (*map_update_batch)(struct bpf_map *map, struct file *map_file,
> -				const union bpf_attr *attr,
> +				union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
> -	int (*map_delete_batch)(struct bpf_map *map, const union bpf_attr *attr,
> +	int (*map_delete_batch)(struct bpf_map *map, union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
>   
>   	/* funcs callable from userspace and from eBPF programs */
> @@ -2095,13 +2095,13 @@ void bpf_map_area_free(void *base);
>   bool bpf_map_write_active(const struct bpf_map *map);
>   void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr);
>   int  generic_map_lookup_batch(struct bpf_map *map,
> -			      const union bpf_attr *attr,
> +			      union bpf_attr *attr,
>   			      union bpf_attr __user *uattr);
>   int  generic_map_update_batch(struct bpf_map *map, struct file *map_file,
> -			      const union bpf_attr *attr,
> +			      union bpf_attr *attr,
>   			      union bpf_attr __user *uattr);
>   int  generic_map_delete_batch(struct bpf_map *map,
> -			      const union bpf_attr *attr,
> +			      union bpf_attr *attr,
>   			      union bpf_attr __user *uattr);
>   struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
>   struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5b9146fa825f..b777bd8d4f8d 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1673,7 +1673,7 @@ static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
>   
>   static int
>   __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> -				   const union bpf_attr *attr,
> +				   union bpf_attr *attr,
>   				   union bpf_attr __user *uattr,
>   				   bool do_delete, bool is_lru_map,
>   				   bool is_percpu)
> @@ -1708,6 +1708,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>   	if (!max_count)
>   		return 0;
>   
> +	attr->batch.count = 0;
>   	if (put_user(0, &uattr->batch.count))
>   		return -EFAULT;
>   
> @@ -1845,6 +1846,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>   		}
>   		dst_key += key_size;
>   		dst_val += value_size;
> +		attr->batch.count++;
>   	}
>   
>   	htab_unlock_bucket(htab, b, batch, flags);

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index efda2353a7d5..d2641e51a1a7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1695,7 +1695,7 @@ static int map_get_next_key(union bpf_attr *attr)
>   }
>   
>   int generic_map_delete_batch(struct bpf_map *map,
> -			     const union bpf_attr *attr,
> +			     union bpf_attr *attr,
>   			     union bpf_attr __user *uattr)
>   {
>   	void __user *keys = u64_to_user_ptr(attr->batch.keys);
> @@ -1715,6 +1715,7 @@ int generic_map_delete_batch(struct bpf_map *map,
>   	if (!max_count)
>   		return 0;
>   
> +	attr->batch.count = 0;
>   	if (put_user(0, &uattr->batch.count))
>   		return -EFAULT;
>   
> @@ -1742,6 +1743,8 @@ int generic_map_delete_batch(struct bpf_map *map,
>   			break;
>   		cond_resched();
>   	}
> +
> +	attr->batch.count = cp;
>   	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
>   		err = -EFAULT;
>   
> @@ -1751,7 +1754,7 @@ int generic_map_delete_batch(struct bpf_map *map,
>   }
>   
>   int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
> -			     const union bpf_attr *attr,
> +			     union bpf_attr *attr,
>   			     union bpf_attr __user *uattr)
>   {
>   	void __user *values = u64_to_user_ptr(attr->batch.values);
> @@ -1774,6 +1777,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   	if (!max_count)
>   		return 0;
>   
> +	attr->batch.count = 0;
>   	if (put_user(0, &uattr->batch.count))
>   		return -EFAULT;
>   
> @@ -1802,6 +1806,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   		cond_resched();
>   	}
>   
> +	attr->batch.count = cp;
>   	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
>   		err = -EFAULT;
>   
> @@ -1813,9 +1818,8 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   
>   #define MAP_LOOKUP_RETRIES 3
>   
> -int generic_map_lookup_batch(struct bpf_map *map,
> -				    const union bpf_attr *attr,
> -				    union bpf_attr __user *uattr)
> +int generic_map_lookup_batch(struct bpf_map *map, union bpf_attr *attr,
> +			     union bpf_attr __user *uattr)
>   {
>   	void __user *uobatch = u64_to_user_ptr(attr->batch.out_batch);
>   	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
> @@ -1838,6 +1842,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>   	if (!max_count)
>   		return 0;
>   
> +	attr->batch.count = 0;
>   	if (put_user(0, &uattr->batch.count))
>   		return -EFAULT;
>   
> @@ -1903,6 +1908,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>   	if (err == -EFAULT)
>   		goto free_buf;
>   
> +	attr->batch.count = cp;

You don't need to change generic_map_lookup_batch() here. It won't trigger
maybe_wait_bpf_programs().

>   	if ((copy_to_user(&uattr->batch.count, &cp, sizeof(cp)) ||
>   		    (cp && copy_to_user(uobatch, prev_key, map->key_size))))
>   		err = -EFAULT;
> @@ -4926,7 +4932,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>   		err = fn(__VA_ARGS__);		\
>   	} while (0)
>   
> -static int bpf_map_do_batch(const union bpf_attr *attr,
> +static int bpf_map_do_batch(union bpf_attr *attr,
>   			    union bpf_attr __user *uattr,
>   			    int cmd)
>   {
> @@ -4966,7 +4972,8 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
>   		BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr);
>   err_put:
>   	if (has_write) {
> -		maybe_wait_bpf_programs(map);
> +		if (attr->batch.count)
> +			maybe_wait_bpf_programs(map);

Your code logic sounds correct but I feel you are optimizing for extreme
corner cases. In really esp production environment, a fault with something
like copy_to_user() should be extremely rare. So in my opinion, this optimization
is not needed.

>   		bpf_map_write_active_dec(map);
>   	}
>   	fdput(f);

