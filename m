Return-Path: <bpf+bounces-31673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6649014C5
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 09:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20E61C20B28
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBE199B0;
	Sun,  9 Jun 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBtyIfAW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E1DCA40;
	Sun,  9 Jun 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717917812; cv=none; b=bcz3kOoBzg5rRnmD3Bv+SEWXbv6Cb5jjAtOk8DUokZ4M/iCWhTsinluhKiV+V+Fv2egWF4BvdP9ncKNkXVuvfsTGlxbOZnjGYTJSIaCEnUlpOf/9S+TasRxJ5ggXp1jOKnNdyLIZQm8uwLTsrMqYSbKgMuyHYg48IHOeinuBgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717917812; c=relaxed/simple;
	bh=x+QWxybe5hc1Ylss7auBafDum+fZKKjDzNcsfa8iarE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GDwtrOL3ckyDCEUam6lozg3jqmJl0gLY4nZveqIcAH8cBaU533rp4m81iDHZ3rW3lVKv+X58FCXHyWTBNIZb8b49z9UlSQsQX2ptRBiwrJstgHUIGOzrkBpt7AFDBxaFMvxszaydk2iimPa1mBPcG8d3Se4ddb4QLrXuZRBSD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBtyIfAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDF5C2BD10;
	Sun,  9 Jun 2024 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717917811;
	bh=x+QWxybe5hc1Ylss7auBafDum+fZKKjDzNcsfa8iarE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QBtyIfAWRHKc1FG5ZIlp0/n3WdTxw2VI6SpTigFmWeZOTXOixu/QXgpT4OgrptVdL
	 hoaN8oRi37W/0x5I+n0XzzVxbypKj5HTuXoZ56dzSMsDORd7Z4HdxwVfdRRCtL4ya/
	 SAYxJCVkTio9dl0dHOQ2It1jrVMAfK0y1kjAkkYXQUqMv5GJTq/cskpsxWHH66X4gL
	 1effNdFMHnHGqVlJg3L+Jo/ochg6PLP0HpO1Crco9FvCMt3+JFBG0eXYs9EIY5ywoV
	 H6U7gN1LaLd+iMmlInnbJtTvGSTScV4WNH/V6lhd4oBoTBSl0dh0GNKJuUvs0DsGEl
	 /FgiuR1iKLvMw==
Date: Sun, 9 Jun 2024 16:23:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, mhiramat@kernel.org,
 song@kernel.org, andrii@kernel.org, eddyz87@gmail.com, haoluo@google.com,
 yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
Message-Id: <20240609162327.ce8bd5fdfffd6b01ad92d8c5@kernel.org>
In-Reply-To: <20240608140835.965949-1-dolinux.peng@gmail.com>
References: <20240608140835.965949-1-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi

On Sat,  8 Jun 2024 07:08:35 -0700
Donglin Peng <dolinux.peng@gmail.com> wrote:

> Currently, we are only using the linear search method to find the type id
> by the name, which has a time complexity of O(n). This change involves
> sorting the names of btf types in ascending order and using binary search,
> which has a time complexity of O(log(n)). This idea was inspired by the
> following patch:
> 
> 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name()").
> 
> At present, this improvement is only for searching in vmlinux's and
> module's BTFs.
> 
> Another change is the search direction, where we search the BTF first and
> then its base, the type id of the first matched btf_type will be returned.
> 
> Here is a time-consuming result that finding 87590 type ids by their names in
> vmlinux's BTF.
> 
> Before: 158426 ms
> After:     114 ms
> 
> The average lookup performance has improved more than 1000x in the above scenario.

This looks great improvement! so searching function entry in ~2us?
BTW, I have some comments below, but basically it looks good to me and
it passed my ftracetest.

Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
> Changes in RFC v3:
>  - Sort the btf types during the build process in order to reduce memory usage
>    and decrease boot time.
> 
> RFC v2:
>  - https://lore.kernel.org/all/20230909091646.420163-1-pengdonglin@sangfor.com.cn
> ---
>  include/linux/btf.h |   1 +
>  kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++---
>  tools/lib/bpf/btf.c | 195 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f9e56fd12a9f..1dc1000a7dc9 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -214,6 +214,7 @@ bool btf_is_kernel(const struct btf *btf);
>  bool btf_is_module(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
> +u32 btf_type_cnt(const struct btf *btf);
>  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>  			   const struct btf_member *m,
>  			   u32 expected_offset, u32 expected_size);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 821063660d9f..5b7b464204bf 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -262,6 +262,7 @@ struct btf {
>  	u32 data_size;
>  	refcount_t refcnt;
>  	u32 id;
> +	u32 nr_types_sorted;
>  	struct rcu_head rcu;
>  	struct btf_kfunc_set_tab *kfunc_set_tab;
>  	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
> @@ -542,23 +543,102 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
>  
> -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
> +u32 btf_type_cnt(const struct btf *btf)
> +{
> +	return btf->start_id + btf->nr_types;
> +}
> +
> +static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *name,
> +				    int *start, int *end)
>  {
>  	const struct btf_type *t;
> -	const char *tname;
> -	u32 i, total;
> +	const char *name_buf;
> +	int low, low_start, mid, high, high_end;
> +	int ret, start_id;
> +
> +	start_id = btf->base_btf ? btf->start_id : 1;
> +	low_start = low = start_id;
> +	high_end = high = start_id + btf->nr_types_sorted - 1;
> +
> +	while (low <= high) {
> +		mid = low + (high - low) / 2;
> +		t = btf_type_by_id(btf, mid);
> +		name_buf = btf_name_by_offset(btf, t->name_off);
> +		ret = strcmp(name, name_buf);
> +		if (ret > 0)
> +			low = mid + 1;
> +		else if (ret < 0)
> +			high = mid - 1;
> +		else
> +			break;
> +	}
>  
> -	total = btf_nr_types(btf);
> -	for (i = 1; i < total; i++) {
> -		t = btf_type_by_id(btf, i);
> -		if (BTF_INFO_KIND(t->info) != kind)
> -			continue;
> +	if (low > high)
> +		return -ESRCH;

nit: -ENOENT ?

>  
> -		tname = btf_name_by_offset(btf, t->name_off);
> -		if (!strcmp(tname, name))
> -			return i;
> +	if (start) {
> +		low = mid;
> +		while (low > low_start) {
> +			t = btf_type_by_id(btf, low-1);
> +			name_buf = btf_name_by_offset(btf, t->name_off);
> +			if (strcmp(name, name_buf))
> +				break;
> +			low--;
> +		}
> +		*start = low;
>  	}
>  
> +	if (end) {
> +		high = mid;
> +		while (high < high_end) {
> +			t = btf_type_by_id(btf, high+1);
> +			name_buf = btf_name_by_offset(btf, t->name_off);
> +			if (strcmp(name, name_buf))
> +				break;
> +			high++;
> +		}
> +		*end = high;
> +	}
> +
> +	return mid;
> +}
> +
> +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
> +{
> +	const struct btf_type *t;
> +	const char *tname;
> +	int start, end;
> +	s32 id, total;
> +
> +	do {
> +		if (btf->nr_types_sorted) {
> +			/* binary search */
> +			id = btf_find_by_name_bsearch(btf, name, &start, &end);
> +			if (id > 0) {
> +				while (start <= end) {
> +					t = btf_type_by_id(btf, start);
> +					if (BTF_INFO_KIND(t->info) == kind)
> +						return start;
> +					start++;
> +				}
> +			}
> +		} else {
> +			/* linear search */
> +			total = btf_type_cnt(btf);
> +			for (id = btf->base_btf ? btf->start_id : 1;
> +				id < total; id++) {
> +				t = btf_type_by_id(btf, id);
> +				if (BTF_INFO_KIND(t->info) != kind)
> +					continue;
> +
> +				tname = btf_name_by_offset(btf, t->name_off);
> +				if (!strcmp(tname, name))
> +					return id;
> +			}
> +		}
> +		btf = btf->base_btf;
> +	} while (btf);
> +
>  	return -ENOENT;
>  }
>  
> @@ -5979,6 +6059,56 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
>  	return kctx_type_id;
>  }
>  
> +static int btf_check_sort(struct btf *btf, int start_id)
> +{
> +	int i, n, nr_names = 0;
> +
> +	n = btf_nr_types(btf);
> +	for (i = start_id; i < n; i++) {
> +		const struct btf_type *t;
> +		const char *name;
> +
> +		t = btf_type_by_id(btf, i);
> +		if (!t)
> +			return -EINVAL;
> +
> +		name = btf_str_by_offset(btf, t->name_off);
> +		if (!str_is_empty(name))
> +			nr_names++;

else {
	goto out; 
}
? (*)

> +	}
> +
> +	if (nr_names < 3)
> +		goto out;

What does this `3` mean?

> +
> +	for (i = 0; i < nr_names - 1; i++) {
> +		const struct btf_type *t1, *t2;
> +		const char *s1, *s2;
> +
> +		t1 = btf_type_by_id(btf, start_id + i);
> +		if (!t1)
> +			return -EINVAL;
> +
> +		s1 = btf_str_by_offset(btf, t1->name_off);
> +		if (str_is_empty(s1))
> +			goto out;

Why not continue? This case is expected, or the previous block (*)
must go `out` at that point.

> +
> +		t2 = btf_type_by_id(btf, start_id + i + 1);
> +		if (!t2)
> +			return -EINVAL;
> +
> +		s2 = btf_str_by_offset(btf, t2->name_off);
> +		if (str_is_empty(s2))
> +			goto out;

Ditto.

> +
> +		if (strcmp(s1, s2) > 0)
> +			goto out;
> +	}
> +
> +	btf->nr_types_sorted = nr_names;
> +out:
> +	return 0;
> +}
> +
>  BTF_ID_LIST(bpf_ctx_convert_btf_id)
>  BTF_ID(struct, bpf_ctx_convert)
>  
> @@ -6029,6 +6159,10 @@ struct btf *btf_parse_vmlinux(void)
>  	if (err)
>  		goto errout;
>  
> +	err = btf_check_sort(btf, 1);

Why `1`?

> +	if (err)
> +		goto errout;
> +
>  	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
>  	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
>  
> @@ -6111,6 +6245,10 @@ static struct btf *btf_parse_module(const char *module_name, const void *data, u
>  	if (err)
>  		goto errout;
>  
> +	err = btf_check_sort(btf, btf_nr_types(base_btf));
> +	if (err)
> +		goto errout;
> +
>  	btf_verifier_env_free(env);
>  	refcount_set(&btf->refcnt, 1);
>  	return btf;
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d0840ef599a..93c1ab677bfa 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1,6 +1,9 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  /* Copyright (c) 2018 Facebook */
>  
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <byteswap.h>
>  #include <endian.h>
>  #include <stdio.h>
> @@ -3072,6 +3075,7 @@ static int btf_dedup_ref_types(struct btf_dedup *d);
>  static int btf_dedup_resolve_fwds(struct btf_dedup *d);
>  static int btf_dedup_compact_types(struct btf_dedup *d);
>  static int btf_dedup_remap_types(struct btf_dedup *d);
> +static int btf_sort_type_by_name(struct btf *btf);
>  
>  /*
>   * Deduplicate BTF types and strings.
> @@ -3270,6 +3274,11 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
>  		pr_debug("btf_dedup_remap_types failed:%d\n", err);
>  		goto done;
>  	}
> +	err = btf_sort_type_by_name(btf);
> +	if (err < 0) {
> +		pr_debug("btf_sort_type_by_name failed:%d\n", err);
> +		goto done;
> +	}
>  
>  done:
>  	btf_dedup_free(d);
> @@ -5212,3 +5221,189 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
>  
>  	return 0;
>  }
> +
> +static int btf_compare_type_name(const void *a, const void *b, void *priv)
> +{
> +	struct btf *btf = (struct btf *)priv;
> +	__u32 ta = *(const __u32 *)a;
> +	__u32 tb = *(const __u32 *)b;
> +	struct btf_type *bta, *btb;
> +	const char *na, *nb;
> +
> +	bta = (struct btf_type *)(btf->types_data + ta);
> +	btb = (struct btf_type *)(btf->types_data + tb);
> +	na = btf__str_by_offset(btf, bta->name_off);
> +	nb = btf__str_by_offset(btf, btb->name_off);
> +
> +	return strcmp(na, nb);
> +}
> +
> +static int btf_compare_offs(const void *o1, const void *o2)
> +{
> +	__u32 *offs1 = (__u32 *)o1;
> +	__u32 *offs2 = (__u32 *)o2;
> +
> +	return *offs1 - *offs2;
> +}
> +
> +static inline __u32 btf_get_mapped_type(struct btf *btf, __u32 *maps, __u32 type)
> +{
> +	if (type < btf->start_id)
> +		return type;
> +	return maps[type - btf->start_id] + btf->start_id;
> +}
> +
> +/*
> + * Collect and move the btf_types with names to the start location, and
> + * sort them in ascending order by name, so we can use the binary search
> + * method.
> + */
> +static int btf_sort_type_by_name(struct btf *btf)
> +{
> +	struct btf_type *bt;
> +	__u32 *new_type_offs = NULL, *new_type_offs_noname = NULL;
> +	__u32 *maps = NULL, *found_offs;
> +	void *new_types_data = NULL, *loc_data;
> +	int i, j, k, type_cnt, ret = 0, type_size;
> +	__u32 data_size;
> +
> +	if (btf_ensure_modifiable(btf))
> +		return libbpf_err(-ENOMEM);
> +
> +	type_cnt = btf->nr_types;
> +	data_size = btf->type_offs_cap * sizeof(*new_type_offs);
> +
> +	maps = (__u32 *)malloc(type_cnt * sizeof(__u32));
> +	if (!maps) {
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	new_type_offs = (__u32 *)malloc(data_size);

nit:
new_type_offs = (__u32 *)calloc(btf->type_offs_cap, sizeof(*new_type_offs))

> +	if (!new_type_offs) {
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	new_type_offs_noname = (__u32 *)malloc(data_size);
> +	if (!new_type_offs_noname) {
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	new_types_data = malloc(btf->types_data_cap);
> +	if (!new_types_data) {
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	memset(new_type_offs, 0, data_size);

Then this memset is not required.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

