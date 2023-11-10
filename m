Return-Path: <bpf+bounces-14680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564297E76FE
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0DF281445
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DF15C5;
	Fri, 10 Nov 2023 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EOIeXlpi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355241374
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 02:04:30 +0000 (UTC)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [IPv6:2001:41d0:203:375::af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC14680
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:04:30 -0800 (PST)
Message-ID: <5cbae302-7fa6-5625-921a-c6f548bcc3a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699581868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0sxEe2kaC2ETyOT6O+HME00RCj83b0CIVuf7k90LJc=;
	b=EOIeXlpiuE13KPLpWdcGJ57zBJoKsGrsk6qKTdyeCykGjUjpqNnV9M+8PH4N5e4FVfwLCu
	MbWGzHhWJWd9+3LBGWkjLYT7wO4wP6VGC8PIKJc9XHqO7SMG2IUn/fhtbXIbgztskfdb0Y
	byplySjsnyuREm31l6iAeDjcmgl9IyY=
Date: Thu, 9 Nov 2023 18:04:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v11 07/13] bpf: pass attached BTF to the
 bpf_struct_ops subsystem
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-8-thinker.li@gmail.com>
Content-Language: en-US
In-Reply-To: <20231106201252.1568931-8-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Every kernel module has its BTF, comprising information on types defined in
> the module. The BTF fd (attr->value_type_btf_obj_fd) passed from userspace

I would highlight this patch (adds) value_type_btf_obj_fd.

> helps the bpf_struct_ops to lookup type information and description of the
> struct_ops type, which is necessary for parsing the layout of map element
> values and registering maps. The descriptions are looked up by matching a
> type id (attr->btf_vmlinux_value_type_id) against bpf_struct_ops_desc(s)
> defined in a BTF. If the struct_ops type is defined in a module, the
> bpf_struct_ops needs to know the module BTF to lookup the
> bpf_struct_ops_desc.
> 
> The bpf_prog includes attach_btf in aux which is passed along with the
> bpf_attr when loading the program. The purpose of attach_btf is to

I read it as "attach_btf" is passed in the bpf_attr. This has been in my head 
for a while. I sort of know what is the actual uapi, so didn't get to it yet.

We have already discussed a bit of this offline. I think it meant 
attr->attach_btf_obj_fd here.

This patch is mainly about how the userspace passing kmod's btf to the kernel 
during map creation and prog load and also what uapi does it use. The commit 
message should mention this patch is reusing the existing 
attr->attach_btf_obj_fd for the userspace to pass the kmod's btf when loading 
the struct_ops prog. I need to go back to the syscall.c code to figure out and 
also leap forward to the later libbpf patch to confirm it.

I depend on the commit message to help the review. It is much appreciated if the 
commit message is clear and accurate on things like: what it wants to do, how it 
does it (addition/deletion/changes), and what are the major changes.

> determine the btf type of attach_btf_id. The attach_btf_id is then used to
> identify the traced function for a trace program. In the case of struct_ops
> programs, it is used to identify the struct_ops type of the struct_ops
> object that a program is attached to.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/uapi/linux/bpf.h       |  5 +++
>   kernel/bpf/bpf_struct_ops.c    | 57 ++++++++++++++++++++++++----------
>   kernel/bpf/syscall.c           |  2 +-
>   kernel/bpf/verifier.c          |  9 ++++--
>   tools/include/uapi/linux/bpf.h |  5 +++
>   5 files changed, 57 insertions(+), 21 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..fd20c52606b2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1398,6 +1398,11 @@ union bpf_attr {
>   		 * to using 5 hash functions).
>   		 */
>   		__u64	map_extra;
> +
> +		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
> +						 * type data for
> +						 * btf_vmlinux_value_type_id.
> +						 */
>   	};
>   
>   	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 4ba6181ed1c4..2fb1b21f989a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -635,6 +635,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
>   	}
>   	bpf_map_area_free(st_map->uvalue);
> +	btf_put(st_map->btf);
>   	bpf_map_area_free(st_map);
>   }
>   
> @@ -675,15 +676,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	struct bpf_struct_ops_map *st_map;
>   	const struct btf_type *t, *vt;
>   	struct bpf_map *map;
> +	struct btf *btf;
>   	int ret;
>   
> -	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
> -	if (!st_ops_desc)
> -		return ERR_PTR(-ENOTSUPP);
> +	if (attr->value_type_btf_obj_fd) {
> +		/* The map holds btf for its whole life time. */
> +		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
> +		if (IS_ERR(btf))
> +			return ERR_PTR(PTR_ERR(btf));
> +	} else {
> +		btf = btf_vmlinux;
> +		btf_get(btf);
> +	}
> +
> +	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
> +	if (!st_ops_desc) {
> +		ret = -ENOTSUPP;
> +		goto errout;
> +	}
>   
>   	vt = st_ops_desc->value_type;
> -	if (attr->value_size != vt->size)
> -		return ERR_PTR(-EINVAL);
> +	if (attr->value_size != vt->size) {
> +		ret = -EINVAL;
> +		goto errout;
> +	}
>   
>   	t = st_ops_desc->type;
>   
> @@ -694,17 +710,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		(vt->size - sizeof(struct bpf_struct_ops_value));
>   
>   	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
> -	if (!st_map)
> -		return ERR_PTR(-ENOMEM);
> +	if (!st_map) {
> +		ret = -ENOMEM;
> +		goto errout;
> +	}
>   
> +	st_map->btf = btf;

How about do the "st_map->btf = btf;" assignment the same as where the current 
code is doing (a few lines below). Would it avoid the new "btf = NULL;" dance 
during the error case?

nit, if moving a line, I would move the following "st_map->st_ops_desc = 
st_ops_desc;" to the later and close to where "st_map->btf = btf;" is.

>   	st_map->st_ops_desc = st_ops_desc;
>   	map = &st_map->map;
>   
>   	ret = bpf_jit_charge_modmem(PAGE_SIZE);
> -	if (ret) {
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(ret);
> -	}
> +	if (ret)
> +		goto errout_free;
>   
>   	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
>   	if (!st_map->image) {
> @@ -713,25 +730,31 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		 * here.
>   		 */
>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(-ENOMEM);
> +		ret = -ENOMEM;
> +		goto errout_free;
>   	}
>   	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>   	st_map->links =
>   		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
>   				   NUMA_NO_NODE);
>   	if (!st_map->uvalue || !st_map->links) {
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(-ENOMEM);
> +		ret = -ENOMEM;
> +		goto errout_free;
>   	}
>   
> -	st_map->btf = btf_vmlinux;

The old code initializes "st_map->btf" here.

> -
>   	mutex_init(&st_map->lock);
>   	set_vm_flush_reset_perms(st_map->image);
>   	bpf_map_init_from_attr(map, attr);
>   
>   	return map;
> +
> +errout_free:
> +	__bpf_struct_ops_map_free(map);
> +	btf = NULL;		/* has been released */
> +errout:
> +	btf_put(btf);
> +
> +	return ERR_PTR(ret);
>   }
>   
>   static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ed286b8a0f0..974651fe2bee 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1096,7 +1096,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>   	return ret;
>   }
>   
> -#define BPF_MAP_CREATE_LAST_FIELD map_extra
> +#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
>   /* called via syscall */
>   static int map_create(union bpf_attr *attr)
>   {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bdd166cab977..3f446f76d4bf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20086,6 +20086,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   	const struct btf_member *member;
>   	struct bpf_prog *prog = env->prog;
>   	u32 btf_id, member_idx;
> +	struct btf *btf;
>   	const char *mname;
>   
>   	if (!prog->gpl_compatible) {
> @@ -20093,8 +20094,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   		return -EINVAL;
>   	}
>   
> +	btf = prog->aux->attach_btf;
> +
>   	btf_id = prog->aux->attach_btf_id;
> -	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
> +	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
>   	if (!st_ops_desc) {
>   		verbose(env, "attach_btf_id %u is not a supported struct\n",
>   			btf_id);
> @@ -20111,8 +20114,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>   	}
>   
>   	member = &btf_type_member(t)[member_idx];
> -	mname = btf_name_by_offset(btf_vmlinux, member->name_off);
> -	func_proto = btf_type_resolve_func_ptr(btf_vmlinux, member->type,
> +	mname = btf_name_by_offset(btf, member->name_off);
> +	func_proto = btf_type_resolve_func_ptr(btf, member->type,
>   					       NULL);
>   	if (!func_proto) {
>   		verbose(env, "attach to invalid member %s(@idx %u) of struct %s\n",
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..fd20c52606b2 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1398,6 +1398,11 @@ union bpf_attr {
>   		 * to using 5 hash functions).
>   		 */
>   		__u64	map_extra;
> +
> +		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
> +						 * type data for
> +						 * btf_vmlinux_value_type_id.
> +						 */
>   	};
>   
>   	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */


