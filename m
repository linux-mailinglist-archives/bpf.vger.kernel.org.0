Return-Path: <bpf+bounces-44552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE6C9C498A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 00:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706B81F23812
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D41BD4F7;
	Mon, 11 Nov 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SFnl289s"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19668224FD
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 23:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366295; cv=none; b=DPmykTWlPR0qQFTZ08D/ybWHSPerop1YjJuFGvL25sHjAbyWyvVUkYYvI92kCYfYUpzECkbMATmvpsYjnuUBxJaHKkK4txj23lj5Xk4bAxHCssjBPyycIG2wsTlY5WygGsjOxFidIJQgXNfs0xrGa2ewapqjHNi9q0d/eUDQuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366295; c=relaxed/simple;
	bh=QlFHaXoGdrdsdtsxaMNZEFvMRFaugC/uaB2aDp2fMvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=al9gQKqu85wCYH9y5GZYU8/exEK1waL2ahTSarwwm+S/a0Ul8Kwo74mYKFHOzS4ttZdjUO/hpvBWMLecBczgpzy6lYYsEDIhAAsdZO1S13VbjjzB/XKrnpcZjz3H2JII219FcdeCkZvfXdeD56+iXz1TDGTEJda6CVxk1eHGGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SFnl289s; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f35f4d0e-77df-4e52-b62e-9e1254fb4b5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731366289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEuEfLgRpLMggNTLxWl+/ldUjnJz5XMj52pXTGqAcac=;
	b=SFnl289s5f7ztp763yUfJc+/dJHQ9IYmL41SxAQxZ8sqeyPvmFwQB8VwAfAzRdokQAaqRK
	ODDSpZwyJoWI05Us9Mwe3jPfD1pPzP+JQMMsQSJ3u8FU8HRTZ/CuhW37QhaXReDcfj49OD
	6ypasCl86eZmrhQ/Ka3HE8GfMebic8M=
Date: Mon, 11 Nov 2024 15:04:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add kernel symbol for struct_ops
 trampoline
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241111121641.2679885-1-xukuohai@huaweicloud.com>
 <20241111121641.2679885-3-xukuohai@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241111121641.2679885-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/24 4:16 AM, Xu Kuohai wrote:
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index e99fce81e916..d6dd56fc80d8 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -23,7 +23,6 @@ struct bpf_struct_ops_value {
>   
>   struct bpf_struct_ops_map {
>   	struct bpf_map map;
> -	struct rcu_head rcu;

Since it needs a respin (more on it later), it will be useful to separate this 
cleanup as a separate patch in the same patch series.

>   	const struct bpf_struct_ops_desc *st_ops_desc;
>   	/* protect map_update */
>   	struct mutex lock;
> @@ -32,6 +31,8 @@ struct bpf_struct_ops_map {
>   	 * (in kvalue.data).
>   	 */
>   	struct bpf_link **links;
> +	/* ksyms for bpf trampolines */
> +	struct bpf_ksym **ksyms;
>   	u32 funcs_cnt;
>   	u32 image_pages_cnt;
>   	/* image_pages is an array of pages that has all the trampolines
> @@ -586,6 +587,49 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>   	return 0;
>   }
>   
> +static void bpf_struct_ops_ksym_init(const char *tname, const char *mname,
> +				     void *image, unsigned int size,
> +				     struct bpf_ksym *ksym)
> +{
> +	snprintf(ksym->name, KSYM_NAME_LEN, "bpf__%s_%s", tname, mname);
> +	INIT_LIST_HEAD_RCU(&ksym->lnode);
> +	bpf_image_ksym_init(image, size, ksym);
> +}
> +
> +static void bpf_struct_ops_map_ksyms_add(struct bpf_struct_ops_map *st_map)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < st_map->funcs_cnt; i++) {
> +		if (!st_map->ksyms[i])
> +			break;
> +		bpf_image_ksym_add(st_map->ksyms[i]);
> +	}
> +}
> +
> +static void bpf_struct_ops_map_del_ksyms(struct bpf_struct_ops_map *st_map)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < st_map->funcs_cnt; i++) {
> +		if (!st_map->ksyms[i])
> +			break;
> +		bpf_image_ksym_del(st_map->ksyms[i]);
> +	}
> +}
> +
> +static void bpf_struct_ops_map_free_ksyms(struct bpf_struct_ops_map *st_map)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < st_map->funcs_cnt; i++) {
> +		if (!st_map->ksyms[i])
> +			break;
> +		kfree(st_map->ksyms[i]);
> +		st_map->links[i] = NULL;

s/links/ksyms/

pw-bot: cr

> +	}
> +}
> +
>   static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   					   void *value, u64 flags)
>   {
> @@ -602,6 +646,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	u32 i, trampoline_start, image_off = 0;
>   	void *cur_image = NULL, *image = NULL;
>   	struct bpf_link **plink;
> +	struct bpf_ksym **pksym;
> +	const char *tname, *mname;
>   
>   	if (flags)
>   		return -EINVAL;
> @@ -641,14 +687,18 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	kdata = &kvalue->data;
>   
>   	plink = st_map->links;
> +	pksym = st_map->ksyms;
> +	tname = btf_name_by_offset(st_map->btf, t->name_off);
>   	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
>   	for_each_member(i, t, member) {
>   		const struct btf_type *mtype, *ptype;
>   		struct bpf_prog *prog;
>   		struct bpf_tramp_link *link;
> +		struct bpf_ksym *ksym;
>   		u32 moff;
>   
>   		moff = __btf_member_bit_offset(t, member) / 8;
> +		mname = btf_name_by_offset(st_map->btf, member->name_off);
>   		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
>   		if (ptype == module_type) {
>   			if (*(void **)(udata + moff))
> @@ -718,6 +768,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   			      &bpf_struct_ops_link_lops, prog);
>   		*plink++ = &link->link;
>   
> +		ksym = kzalloc(sizeof(*ksym), GFP_USER);

link is also using kzalloc but probably both link and ksym allocation should use 
bpf_map_kzalloc instead. This switch can be done for both together later as a 
follow up patch.

> +		if (!ksym) {
> +			bpf_prog_put(prog);

afaik, this bpf_prog_put is not needed. The bpf_link_init above took the prog 
ownership and the bpf_struct_ops_map_put_progs() at the error path will take 
care of it.

> +			err = -ENOMEM;
> +			goto reset_unlock;
> +		}
> +		*pksym = ksym;

nit. Follow the *plink++ style above and does the same *pksym++ here.

> +
>   		trampoline_start = image_off;
>   		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>   						&st_ops->func_models[i],
> @@ -737,6 +795,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   
>   		/* put prog_id to udata */
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
> +
> +		/* init ksym for this trampoline */
> +		bpf_struct_ops_ksym_init(tname, mname,
> +					 image + trampoline_start,
> +					 image_off - trampoline_start,
> +					 *pksym++);

then uses "ksym" here.

>   	}
>   
>   	if (st_ops->validate) {
> @@ -785,6 +849,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	 */
>   
>   reset_unlock:
> +	bpf_struct_ops_map_free_ksyms(st_map);
>   	bpf_struct_ops_map_free_image(st_map);
>   	bpf_struct_ops_map_put_progs(st_map);
>   	memset(uvalue, 0, map->value_size);
> @@ -792,6 +857,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   unlock:
>   	kfree(tlinks);
>   	mutex_unlock(&st_map->lock);
> +	if (!err)
> +		bpf_struct_ops_map_ksyms_add(st_map);
>   	return err;
>   }
>   
> @@ -851,7 +918,10 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   
>   	if (st_map->links)
>   		bpf_struct_ops_map_put_progs(st_map);
> +	if (st_map->ksyms)
> +		bpf_struct_ops_map_free_ksyms(st_map);
>   	bpf_map_area_free(st_map->links);
> +	bpf_map_area_free(st_map->ksyms);
>   	bpf_struct_ops_map_free_image(st_map);
>   	bpf_map_area_free(st_map->uvalue);
>   	bpf_map_area_free(st_map);
> @@ -868,6 +938,9 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>   	if (btf_is_module(st_map->btf))
>   		module_put(st_map->st_ops_desc->st_ops->owner);
>   
> +	if (st_map->ksyms)

This null test should not be needed.

> +		bpf_struct_ops_map_del_ksyms(st_map);
> +
>   	/* The struct_ops's function may switch to another struct_ops.
>   	 *
>   	 * For example, bpf_tcp_cc_x->init() may switch to
> @@ -980,7 +1053,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	st_map->links =
>   		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_links *),
>   				   NUMA_NO_NODE);
> -	if (!st_map->uvalue || !st_map->links) {
> +
> +	st_map->ksyms =
> +		bpf_map_area_alloc(st_map->funcs_cnt * sizeof(struct bpf_ksyms *),
> +				   NUMA_NO_NODE);

.map_mem_usage at least needs to include the st_map->ksyms[] pointer array. 
func_cnts should be used instead of btf_type_vlen(vt) for link also in 
.map_mem_usage.

> +	if (!st_map->uvalue || !st_map->links || !st_map->ksyms) {
>   		ret = -ENOMEM;
>   		goto errout_free;
>   	}

