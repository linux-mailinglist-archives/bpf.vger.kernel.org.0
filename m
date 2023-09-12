Return-Path: <bpf+bounces-9751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5079D2D4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1133281D8E
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64313182D5;
	Tue, 12 Sep 2023 13:51:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D88F49
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 13:51:51 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B59710D7;
	Tue, 12 Sep 2023 06:51:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c93638322so1215658366b.1;
        Tue, 12 Sep 2023 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694526709; x=1695131509; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ukE7m/BQdIG6VuN9dgMVA9eFsWsScwAg+NRan99x15s=;
        b=ZRDK3JOqEmrVXvkeZtOenRIoeyVBwHb1XnNQ+H8LnYl8jbFVPuaM5HTudvz7V/GM+t
         /DIZWkrGu7yh353jyGuzij80huDDu47PImExX9Pf5/YHTt+h0r487B94KXgEHXG8nsI9
         xpOlLRj3OrNrDU5NkjaIkU4u0OZWPOZkTceNSMEVLdbYqUgca2ec21Gz1QzAcInW+PqJ
         W2/w691+41VUE/mvWx7at2ncRHy7v0IGvn9ps/MUWMnK4OPGJtlli8FUnbKMQZP0lu79
         ZnMh/JR2KsGda1dTkqkw61swW94iW2axLrnvY0v83Oitm1QPDU6nHABdafBzFC9CiGmx
         4JAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526709; x=1695131509;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukE7m/BQdIG6VuN9dgMVA9eFsWsScwAg+NRan99x15s=;
        b=BIt9Pojt9i5BMkR+B7mQPZ6N/O32grQI8vl+lhsZ/NkFuHv10J0z7HR1Tt1bfD2SDQ
         NVmgxlwkNSr2Zv0M51S0W3jeYZ/B5as581r5yno/+kt+G9yRw84g14SbvW22e3sPHO7v
         KHzT5NNaGVuqTZpz90ZxBCnBdtNfHNiLWER7T2B1780mgzWihc9tFhoyR9wmbZwWK/B1
         rPLRZphVAaEhIN++kFcgTr2XpleR3jfobx+ljaxJLiZd7HuXnYDZV2PF520TyPg3ypRf
         VQNZD+Ooic9FRcF5S5j0c1F1jh89icenbu4oPqJzGkq414weE60bkN5afNb0hYHVwe4y
         ZBWQ==
X-Gm-Message-State: AOJu0YwEQPAMh+U2cdfvjK1UfaZuZPH4PswSItfXZdb7C8gP5GeJw7mF
	POk1fGeK6zbLG6dY2KEE8zU=
X-Google-Smtp-Source: AGHT+IHLgwZrJa7qrz9bDI9LfV1mJCLNffMLs1OWanfLTLExrLpTaN2Boe4x7/6aayoZRnQhXOVc/g==
X-Received: by 2002:a17:906:3006:b0:9ad:7f8b:2b0a with SMTP id 6-20020a170906300600b009ad7f8b2b0amr3378573ejz.22.1694526709237;
        Tue, 12 Sep 2023 06:51:49 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rp26-20020a170906d97a00b00988be3c1d87sm6844180ejb.116.2023.09.12.06.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:51:48 -0700 (PDT)
Message-ID: <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <pengdonglin@sangfor.com.cn>, martin.lau@linux.dev, 
	ast@kernel.org
Cc: song@kernel.org, yhs@fb.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	dinghui@sangfor.com.cn, huangcun@sangfor.com.cn, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 12 Sep 2023 16:51:47 +0300
In-Reply-To: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
> Currently, we are only using the linear search method to find the type id
> by the name, which has a time complexity of O(n). This change involves
> sorting the names of btf types in ascending order and using binary search=
,
> which has a time complexity of O(log(n)). This idea was inspired by the
> following patch:
>=20
> 60443c88f3a8 ("kallsyms: Improve the performance of kallsyms_lookup_name(=
)").
>=20
> At present, this improvement is only for searching in vmlinux's and
> module's BTFs, and the kind should only be BTF_KIND_FUNC or BTF_KIND_STRU=
CT.
>=20
> Another change is the search direction, where we search the BTF first and
> then its base, the type id of the first matched btf_type will be returned=
.
>=20
> Here is a time-consuming result that finding all the type ids of 67,819 k=
ernel
> functions in vmlinux's BTF by their names:
>=20
> Before: 17000 ms
> After:     10 ms
>=20
> The average lookup performance has improved about 1700x at the above scen=
ario.
>=20
> However, this change will consume more memory, for example, 67,819 kernel
> functions will allocate about 530KB memory.

Hi Donglin,

I think this is a good improvement. However, I wonder, why did you
choose to have a separate name map for each BTF kind?

I did some analysis for my local testing kernel config and got such numbers=
:
- total number of BTF objects: 97350
- number of FUNC and STRUCT objects: 51597
- number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC objects: 56=
817
  (these are all kinds for which lookup by name might make sense)
- number of named objects: 54246
- number of name collisions:
  - unique names: 53985 counts
  - 2 objects with the same name: 129 counts
  - 3 objects with the same name: 3 counts

So, it appears that having a single map for all named objects makes
sense and would also simplify the implementation, what do you think?

Thanks,
Eduard

>=20
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
> Changes in RFC v2:
>  - Fix the build issue reported by kernel test robot <lkp@intel.com>
> ---
>  include/linux/btf.h |   1 +
>  kernel/bpf/btf.c    | 300 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 291 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cac9f304e27a..6260a0668773 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -201,6 +201,7 @@ bool btf_is_kernel(const struct btf *btf);
>  bool btf_is_module(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
> +u32 btf_type_cnt(const struct btf *btf);
>  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type =
*s,
>  			   const struct btf_member *m,
>  			   u32 expected_offset, u32 expected_size);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 817204d53372..51aa9f27853b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -240,6 +240,26 @@ struct btf_id_dtor_kfunc_tab {
>  	struct btf_id_dtor_kfunc dtors[];
>  };
> =20
> +enum {
> +	BTF_ID_NAME_FUNC,	/* function */
> +	BTF_ID_NAME_STRUCT,	/* struct */
> +	BTF_ID_NAME_MAX
> +};
> +
> +struct btf_id_name {
> +	int id;
> +	u32 name_off;
> +};
> +
> +struct btf_id_name_map {
> +	struct btf_id_name *id_name;
> +	u32 count;
> +};
> +
> +struct btf_id_name_maps {
> +	struct btf_id_name_map map[BTF_ID_NAME_MAX];
> +};
> +
>  struct btf {
>  	void *data;
>  	struct btf_type **types;
> @@ -257,6 +277,7 @@ struct btf {
>  	struct btf_kfunc_set_tab *kfunc_set_tab;
>  	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
>  	struct btf_struct_metas *struct_meta_tab;
> +	struct btf_id_name_maps *id_name_maps;
> =20
>  	/* split BTF support */
>  	struct btf *base_btf;
> @@ -532,22 +553,142 @@ u32 btf_nr_types(const struct btf *btf)
>  	return total;
>  }
> =20
> +u32 btf_type_cnt(const struct btf *btf)
> +{
> +	return btf->start_id + btf->nr_types;
> +}
> +
> +static inline u8 btf_id_name_idx_to_kind(int index)
> +{
> +	u8 kind;
> +
> +	switch (index) {
> +	case BTF_ID_NAME_FUNC:
> +		kind =3D BTF_KIND_FUNC;
> +		break;
> +	case BTF_ID_NAME_STRUCT:
> +		kind =3D BTF_KIND_STRUCT;
> +		break;
> +	default:
> +		kind =3D BTF_KIND_UNKN;
> +		break;
> +	}
> +
> +	return kind;
> +}
> +
> +static inline int btf_id_name_kind_to_idx(u8 kind)
> +{
> +	int index;
> +
> +	switch (kind) {
> +	case BTF_KIND_FUNC:
> +		index =3D BTF_ID_NAME_FUNC;
> +		break;
> +	case BTF_KIND_STRUCT:
> +		index =3D BTF_ID_NAME_STRUCT;
> +		break;
> +	default:
> +		index =3D -1;
> +		break;
> +	}
> +
> +	return index;
> +}
> +
> +static s32 btf_find_by_name_bsearch(struct btf_id_name *id_name,
> +				    u32 size, const char *name,
> +				    struct btf_id_name **start,
> +				    struct btf_id_name **end,
> +				    const struct btf *btf)
> +{
> +	int ret;
> +	int low, mid, high;
> +	const char *name_buf;
> +
> +	low =3D 0;
> +	high =3D size - 1;
> +
> +	while (low <=3D high) {
> +		mid =3D low + (high - low) / 2;
> +		name_buf =3D btf_name_by_offset(btf, id_name[mid].name_off);
> +		ret =3D strcmp(name, name_buf);
> +		if (ret > 0)
> +			low =3D mid + 1;
> +		else if (ret < 0)
> +			high =3D mid - 1;
> +		else
> +			break;
> +	}
> +
> +	if (low > high)
> +		return -ESRCH;
> +
> +	if (start) {
> +		low =3D mid;
> +		while (low) {
> +			name_buf =3D btf_name_by_offset(btf, id_name[low-1].name_off);
> +			if (strcmp(name, name_buf))
> +				break;
> +			low--;
> +		}
> +		*start =3D &id_name[low];
> +	}
> +
> +	if (end) {
> +		high =3D mid;
> +		while (high < size - 1) {
> +			name_buf =3D btf_name_by_offset(btf, id_name[high+1].name_off);
> +			if (strcmp(name, name_buf))
> +				break;
> +			high++;
> +		}
> +		*end =3D &id_name[high];
> +	}
> +
> +	return id_name[mid].id;
> +}
> +
>  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
>  {
> +	const struct btf_id_name_maps *maps;
> +	const struct btf_id_name_map *map;
> +	struct btf_id_name *start;
>  	const struct btf_type *t;
>  	const char *tname;
> -	u32 i, total;
> +	int index =3D btf_id_name_kind_to_idx(kind);
> +	s32 id, total;
> =20
> -	total =3D btf_nr_types(btf);
> -	for (i =3D 1; i < total; i++) {
> -		t =3D btf_type_by_id(btf, i);
> -		if (BTF_INFO_KIND(t->info) !=3D kind)
> -			continue;
> +	do {
> +		maps =3D btf->id_name_maps;
> +		if (index >=3D 0 && maps && maps->map[index].id_name) {
> +			/* binary search */
> +			map =3D &maps->map[index];
> +			id =3D btf_find_by_name_bsearch(map->id_name,
> +				map->count, name, &start, NULL, btf);
> +			if (id > 0) {
> +				/*
> +				 * Return the first one that
> +				 * matched
> +				 */
> +				return start->id;
> +			}
> +		} else {
> +			/* linear search */
> +			total =3D btf_type_cnt(btf);
> +			for (id =3D btf->start_id; id < total; id++) {
> +				t =3D btf_type_by_id(btf, id);
> +				if (BTF_INFO_KIND(t->info) !=3D kind)
> +					continue;
> +
> +				tname =3D btf_name_by_offset(btf, t->name_off);
> +				if (!strcmp(tname, name))
> +					return id;
> +			}
> +		}
> =20
> -		tname =3D btf_name_by_offset(btf, t->name_off);
> -		if (!strcmp(tname, name))
> -			return i;
> -	}
> +		btf =3D btf->base_btf;
> +	} while (btf);
> =20
>  	return -ENOENT;
>  }
> @@ -1639,6 +1780,32 @@ static void btf_free_id(struct btf *btf)
>  	spin_unlock_irqrestore(&btf_idr_lock, flags);
>  }
> =20
> +static void btf_destroy_id_name(struct btf *btf, int index)
> +{
> +	struct btf_id_name_maps *maps =3D btf->id_name_maps;
> +	struct btf_id_name_map *map =3D &maps->map[index];
> +
> +	if (map->id_name) {
> +		kvfree(map->id_name);
> +		map->id_name =3D NULL;
> +		map->count =3D 0;
> +	}
> +}
> +
> +static void btf_destroy_id_name_map(struct btf *btf)
> +{
> +	int i;
> +
> +	if (!btf->id_name_maps)
> +		return;
> +
> +	for (i =3D 0; i < BTF_ID_NAME_MAX; i++)
> +		btf_destroy_id_name(btf, i);
> +
> +	kfree(btf->id_name_maps);
> +	btf->id_name_maps =3D NULL;
> +}
> +
>  static void btf_free_kfunc_set_tab(struct btf *btf)
>  {
>  	struct btf_kfunc_set_tab *tab =3D btf->kfunc_set_tab;
> @@ -1689,6 +1856,7 @@ static void btf_free_struct_meta_tab(struct btf *bt=
f)
> =20
>  static void btf_free(struct btf *btf)
>  {
> +	btf_destroy_id_name_map(btf);
>  	btf_free_struct_meta_tab(btf);
>  	btf_free_dtor_kfunc_tab(btf);
>  	btf_free_kfunc_set_tab(btf);
> @@ -5713,6 +5881,107 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *=
log, enum bpf_prog_type prog_ty
>  	return kctx_type_id;
>  }
> =20
> +static int btf_compare_id_name(const void *a, const void *b, const void =
*priv)
> +{
> +	const struct btf_id_name *ia =3D (const struct btf_id_name *)a;
> +	const struct btf_id_name *ib =3D (const struct btf_id_name *)b;
> +	const struct btf *btf =3D priv;
> +	int ret;
> +
> +	/*
> +	 * Sort names in ascending order, if the name is same, sort ids in
> +	 * ascending order.
> +	 */
> +	ret =3D strcmp(btf_name_by_offset(btf, ia->name_off),
> +		     btf_name_by_offset(btf, ib->name_off));
> +	if (!ret)
> +		ret =3D ia->id - ib->id;
> +
> +	return ret;
> +}
> +
> +static int btf_create_id_name(struct btf *btf, int index)
> +{
> +	struct btf_id_name_maps *maps =3D btf->id_name_maps;
> +	struct btf_id_name_map *map =3D &maps->map[index];
> +	const struct btf_type *t;
> +	struct btf_id_name *id_name;
> +	const char *name;
> +	int i, j =3D 0;
> +	u32 total, count =3D 0;
> +	u8 kind;
> +
> +	kind =3D btf_id_name_idx_to_kind(index);
> +	if (kind =3D=3D BTF_KIND_UNKN)
> +		return -EINVAL;
> +
> +	if (map->id_name || map->count !=3D 0)
> +		return -EINVAL;
> +
> +	total =3D btf_type_cnt(btf);
> +	for (i =3D btf->start_id; i < total; i++) {
> +		t =3D btf_type_by_id(btf, i);
> +		if (BTF_INFO_KIND(t->info) !=3D kind)
> +			continue;
> +		name =3D btf_name_by_offset(btf, t->name_off);
> +		if (str_is_empty(name))
> +			continue;
> +		count++;
> +	}
> +
> +	if (count =3D=3D 0)
> +		return 0;
> +
> +	id_name =3D kvcalloc(count, sizeof(struct btf_id_name),
> +			   GFP_KERNEL);
> +	if (!id_name)
> +		return -ENOMEM;
> +
> +	for (i =3D btf->start_id; i < total; i++) {
> +		t =3D btf_type_by_id(btf, i);
> +		if (BTF_INFO_KIND(t->info) !=3D kind)
> +			continue;
> +		name =3D btf_name_by_offset(btf, t->name_off);
> +		if (str_is_empty(name))
> +			continue;
> +
> +		id_name[j].id =3D i;
> +		id_name[j].name_off =3D t->name_off;
> +		j++;
> +	}
> +
> +	sort_r(id_name, count, sizeof(id_name[0]), btf_compare_id_name,
> +	       NULL, btf);
> +
> +	map->id_name =3D id_name;
> +	map->count =3D count;
> +
> +	return 0;
> +}
> +
> +static int btf_create_id_name_map(struct btf *btf)
> +{
> +	int err, i;
> +	struct btf_id_name_maps *maps;
> +
> +	if (btf->id_name_maps)
> +		return -EBUSY;
> +
> +	maps =3D kzalloc(sizeof(struct btf_id_name_maps), GFP_KERNEL);
> +	if (!maps)
> +		return -ENOMEM;
> +
> +	btf->id_name_maps =3D maps;
> +
> +	for (i =3D 0; i < BTF_ID_NAME_MAX; i++) {
> +		err =3D btf_create_id_name(btf, i);
> +		if (err < 0)
> +			break;
> +	}
> +
> +	return err;
> +}
> +
>  BTF_ID_LIST(bpf_ctx_convert_btf_id)
>  BTF_ID(struct, bpf_ctx_convert)
> =20
> @@ -5760,6 +6029,10 @@ struct btf *btf_parse_vmlinux(void)
>  	if (err)
>  		goto errout;
> =20
> +	err =3D btf_create_id_name_map(btf);
> +	if (err)
> +		goto errout;
> +
>  	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
>  	bpf_ctx_convert.t =3D btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
> =20
> @@ -5777,6 +6050,7 @@ struct btf *btf_parse_vmlinux(void)
>  errout:
>  	btf_verifier_env_free(env);
>  	if (btf) {
> +		btf_destroy_id_name_map(btf);
>  		kvfree(btf->types);
>  		kfree(btf);
>  	}
> @@ -5844,13 +6118,19 @@ static struct btf *btf_parse_module(const char *m=
odule_name, const void *data, u
>  	if (err)
>  		goto errout;
> =20
> +	err =3D btf_create_id_name_map(btf);
> +	if (err)
> +		goto errout;
> +
>  	btf_verifier_env_free(env);
>  	refcount_set(&btf->refcnt, 1);
> +
>  	return btf;
> =20
>  errout:
>  	btf_verifier_env_free(env);
>  	if (btf) {
> +		btf_destroy_id_name_map(btf);
>  		kvfree(btf->data);
>  		kvfree(btf->types);
>  		kfree(btf);


