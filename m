Return-Path: <bpf+bounces-43976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A269BC1D8
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5212F1F225A5
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0961367;
	Tue,  5 Nov 2024 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mKBN0TWU"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3253D9E
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765465; cv=none; b=pbCMwPnBPLn/LCyA3iocs/71el3GtpXt8G1qZPLAZ1wE37ULBE3ZKyCOjJZV9ZiAkEZ7hdXb8gjjFKoo52aN5rxNEGVAPTRU4nVCOld8SeXq8s1Vx30iivvAzO7tI+/8hmr8E1ulDVo6QW0boZzeG3Q5CDSM74idamnQUGwNNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765465; c=relaxed/simple;
	bh=sWX6GWp+IeVd44w9oe6oS+dKPk9x5BRc6TfDXNXr6dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtJ+IqA3RZWNyISLkYZrG50p9Po42B48QT+/ymZrutAJYOmJiWzkT9PvT5gx59Jg31qgtoG79wcSAA6+TZ4X+5jrHWB0QgVnF/qgtuBC/jaWSlmBttiwFN9A5CHQ0cIHbU9eU0f4nY+IfTQbdgHzjANqzy1M+2u/FeYlYIMOxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mKBN0TWU; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf62c79d-cba5-49dc-9099-fc86d54ee864@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730765459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLUHNASoXi1cubQwEnJ83CylYrNF3onOml8Be0docOM=;
	b=mKBN0TWUbstpVq25m+JWAKgIyUhoc9CyH85G33VVtaGDuxpVSlpLRNGGvR4Ym/Kk/xRhfK
	0JkfydW/VeqVhePdFLSusVf3k0tyyva6BwxQDm+8kPxMrN3IgRZAd7CZdpDB7KFwX9f2kd
	2LYVWWkqCXerV1KKJqrp8/732tHLRA4=
Date: Mon, 4 Nov 2024 16:10:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops
 trampoline
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/1/24 4:19 AM, Xu Kuohai wrote:
>   static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   					   void *value, u64 flags)
>   {
> @@ -601,6 +633,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	int prog_fd, err;
>   	u32 i, trampoline_start, image_off = 0;
>   	void *cur_image = NULL, *image = NULL;
> +	struct bpf_ksym *ksym;
>   
>   	if (flags)
>   		return -EINVAL;
> @@ -640,6 +673,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	kdata = &kvalue->data;
>   
>   	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
> +	ksym = st_map->ksyms;
>   	for_each_member(i, t, member) {
>   		const struct btf_type *mtype, *ptype;
>   		struct bpf_prog *prog;
> @@ -735,6 +769,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   
>   		/* put prog_id to udata */
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
> +
> +		/* init ksym for this trampoline */
> +		bpf_struct_ops_ksym_init(prog, image + trampoline_start,
> +					 image_off - trampoline_start,
> +					 ksym++);
>   	}
>   
>   	if (st_ops->validate) {
> @@ -790,6 +829,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   unlock:
>   	kfree(tlinks);
>   	mutex_unlock(&st_map->lock);
> +	if (!err)
> +		bpf_struct_ops_map_ksyms_add(st_map);
>   	return err;
>   }
>   

>   static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   {
>   	const struct bpf_struct_ops_desc *st_ops_desc;
> @@ -905,6 +963,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	struct bpf_map *map;
>   	struct btf *btf;
>   	int ret;
> +	size_t ksyms_offset;
> +	u32 ksyms_cnt;
>   
>   	if (attr->map_flags & BPF_F_VTYPE_BTF_OBJ_FD) {
>   		/* The map holds btf for its whole life time. */
> @@ -951,6 +1011,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		 */
>   		(vt->size - sizeof(struct bpf_struct_ops_value));
>   
> +	st_map_size = round_up(st_map_size, sizeof(struct bpf_ksym));
> +	ksyms_offset = st_map_size;
> +	ksyms_cnt = count_func_ptrs(btf, t);
> +	st_map_size += ksyms_cnt * sizeof(struct bpf_ksym);
> +
>   	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
>   	if (!st_map) {
>   		ret = -ENOMEM;
> @@ -958,6 +1023,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	}
>   
>   	st_map->st_ops_desc = st_ops_desc;
> +	st_map->ksyms = (void *)st_map + ksyms_offset;

nit. The st_map->ksyms is very similar to the existing st_map->links. Can we do 
the allocation similar to the st_map->links and use another bpf_map_area_alloc() 
instead of doing the round_up() and then figuring out the ksyms_offset.

> +	st_map->ksyms_cnt = ksyms_cnt;

The same goes for ksyms_cnt. ksyms_cnt is almost the same as the 
st_map->links_cnt. st_map->links_cnt unnecessarily includes the non func ptr 
(i.e. a waste). The st_map->links[i] must be NULL if the i-th member of a struct 
is not a func ptr.

If this patch adds the count_func_ptrs(), I think at least just have one 
variable to mean funcs_cnt instead of adding another new ksyms_cnt. Both the 
existing st_map->links and the new st_map->ksyms can use the same funcs_cnt. An 
adjustment is needed for link in update_elem (probably use link++ similar to 
your ksym++ idea). bpf_struct_ops_map_put_progs() should work as is.

Also, the actual bpf_link is currently allocated during update_elem() only when 
there is a bpf prog for an ops. The new st_map->ksyms pre-allocated everything 
during map_alloc() regardless if there will be a bpf prog (e.g. 
tcp_congestion_ops has 5 optional ops). I don't have a strong opinion on 
pre-allocate everything in map_alloc() or allocate on-demand in update_elem(). 
However, considering bpf_ksym has a "char name[KSYM_NAME_LEN]", the on-demand 
allocation on bpf_link becomes not very useful. If the next respin stays with 
the pre-allocate everything way, it is useful to followup later to stay with one 
way and do the same for bpf_link.

