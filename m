Return-Path: <bpf+bounces-13355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3757D8A13
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BCDB212C4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8183D3A2;
	Thu, 26 Oct 2023 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSqfGeWU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31A4426
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:12:01 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC710E
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:11:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso2154039a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698354718; x=1698959518; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fENJ348xXS1YMqiltKwdANufG+gAwaeTeZk8tTjpfDk=;
        b=VSqfGeWUFhI2o3yxsTMHtfBQ//wj4J0PHl1d0QWFOkFX5tWtNSz5DJCw1Aedf/p7jo
         SnxxDJctEAWPX45YDSC+G5VmOk/fbUONnMK2K1xwPj72At9Jm+phOxjifLnLiX42/Ppx
         GN0n3gV8jNbGZu6k+iDGexDp3lEWClYEV5TiN1sCTg+CRianfZI5LZTiN7UXUt8GNvll
         nrC7X0oN7lPIG8T0t6MDl4FH7KroX4FqXEZy0zi4TadjvPy2v7mHDkV/DzFDnx7ofivB
         G+oDwN6pM2r2gAYEwO3CHOJ7LeyZL1ceK+2L5OmfQDIyyW031P+ER4L/GNF5CCyN1Efv
         vmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698354718; x=1698959518;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fENJ348xXS1YMqiltKwdANufG+gAwaeTeZk8tTjpfDk=;
        b=XLl4WkrbnVAX9yCzD2iDPEifY8UNoAyjnRMaEgtIQ2d9x3aHDLG7ZevhTl1j6xEe5I
         kA1ZJpeTrWyF+0Jh/6Btntodqn8s+v+cmUctxAUknvS2Urzdq3+3KzJBG0fF8yc3ZtTa
         5oGZx6qHqi4fGYXuUddf84polKYRD/ierz20UCL3eQfacVbR6eL/XIuKWf47b8SLjrlV
         yqKE+a0+zJMTO1VAWOYcfNueyE7kVuqr7Py2r83KV/iYqakRGNl49xa5RCbsqGtn3zOZ
         uUgXcVJU5dZQgE5Uf6L09tXKrtigZ1Mf58ce0chA4oCbzvPyEaUX+GueLDP0o7MknfHT
         d4DQ==
X-Gm-Message-State: AOJu0YwH1xizuBE/5Z6dsmlL37bolknFps5dbc6w/m5GL8ig2SJw61xr
	jaHVvql84NzxsphhEvyefkI=
X-Google-Smtp-Source: AGHT+IH5ceglIxndotCK2yrXvxGxHtOu3H0gSrptoWEmPFo0Ix0VPqvBZWTo1XLJCI5p/upe+IDMWg==
X-Received: by 2002:a17:907:6e91:b0:9b2:babb:5fe9 with SMTP id sh17-20020a1709076e9100b009b2babb5fe9mr953517ejc.23.1698354717769;
        Thu, 26 Oct 2023 14:11:57 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709060f0600b009944e955e19sm164854eji.30.2023.10.26.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:11:57 -0700 (PDT)
Message-ID: <fe10e843372f3100419da42a047e0b8ae6967fb6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 04/10] bpf: hold module for
 bpf_struct_ops_map.
From: Eduard Zingerman <eddyz87@gmail.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org,  drosen@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Fri, 27 Oct 2023 00:11:56 +0300
In-Reply-To: <20231022050335.2579051-5-thinker.li@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
	 <20231022050335.2579051-5-thinker.li@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-10-21 at 22:03 -0700, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
>=20
> To ensure that a module remains accessible whenever a struct_ops object o=
f
> a struct_ops type provided by the module is still in use.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/bpf.h         |  1 +
>  include/linux/btf.h         |  2 +-
>  kernel/bpf/bpf_struct_ops.c | 70 ++++++++++++++++++++++++++++++-------
>  3 files changed, 60 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4f3b67932ded..26feb8a2da4f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1626,6 +1626,7 @@ struct bpf_struct_ops {
>  	void (*unreg)(void *kdata);
>  	int (*update)(void *kdata, void *old_kdata);
>  	int (*validate)(void *kdata);
> +	struct module *owner;
>  	const char *name;
>  	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
>  };
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 8e37f7eb02c7..6a64b372b7a0 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -575,7 +575,7 @@ struct bpf_struct_ops;
>  struct bpf_struct_ops_desc;
> =20
>  struct bpf_struct_ops_desc *
> -btf_add_struct_ops(struct bpf_struct_ops *st_ops);
> +btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops);
>  const struct bpf_struct_ops_desc *
>  btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
> =20
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 0bc21a39257d..413a3f8b26ba 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -388,6 +388,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>  	const struct btf_member *member;
>  	const struct btf_type *t =3D st_ops_desc->type;
>  	struct bpf_tramp_links *tlinks;
> +	struct module *mod =3D NULL;
>  	void *udata, *kdata;
>  	int prog_fd, err;
>  	void *image, *image_end;
> @@ -425,6 +426,14 @@ static long bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
>  		goto unlock;
>  	}
> =20
> +	if (st_ops_desc->btf !=3D btf_vmlinux) {
> +		mod =3D btf_try_get_module(st_ops_desc->btf);
> +		if (!mod) {
> +			err =3D -EBUSY;

Nit: there is a disagreement about error code returned for
     failing btf_try_get_module() across verifier code base:
     - EINVAL is used 2 times;
     - ENXIO is used 3 times;
     - ENOTSUPP is used once.
     Are you sure EBUSY is a good choice here?

> +			goto unlock;
> +		}
> +	}
> +
>  	memcpy(uvalue, value, map->value_size);
> =20
>  	udata =3D &uvalue->data;
> @@ -552,6 +561,10 @@ static long bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
>  		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
>  		 */
>  		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
> +		/* Hold the owner module until the struct_ops is
> +		 * unregistered
> +		 */
> +		mod =3D NULL;
>  		goto unlock;
>  	}
> =20
> @@ -568,6 +581,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>  	memset(uvalue, 0, map->value_size);
>  	memset(kvalue, 0, map->value_size);
>  unlock:
> +	module_put(mod);
>  	kfree(tlinks);
>  	mutex_unlock(&st_map->lock);
>  	return err;
> @@ -588,6 +602,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf=
_map *map, void *key)
>  	switch (prev_state) {
>  	case BPF_STRUCT_OPS_STATE_INUSE:
>  		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
> +		module_put(st_map->st_ops_desc->st_ops->owner);
>  		bpf_map_put(map);
>  		return 0;
>  	case BPF_STRUCT_OPS_STATE_TOBEFREE:
> @@ -674,6 +689,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
>  	size_t st_map_size;
>  	struct bpf_struct_ops_map *st_map;
>  	const struct btf_type *t, *vt;
> +	struct module *mod =3D NULL;
>  	struct bpf_map *map;
>  	int ret;
> =20
> @@ -681,9 +697,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(unio=
n bpf_attr *attr)
>  	if (!st_ops_desc)
>  		return ERR_PTR(-ENOTSUPP);
> =20
> +	if (st_ops_desc->btf !=3D btf_vmlinux) {
> +		mod =3D btf_try_get_module(st_ops_desc->btf);
> +		if (!mod)
> +			return ERR_PTR(-EINVAL);
> +	}
> +
>  	vt =3D st_ops_desc->value_type;
> -	if (attr->value_size !=3D vt->size)
> -		return ERR_PTR(-EINVAL);
> +	if (attr->value_size !=3D vt->size) {
> +		ret =3D -EINVAL;
> +		goto errout;
> +	}
> =20
>  	t =3D st_ops_desc->type;
> =20
> @@ -694,17 +718,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
>  		(vt->size - sizeof(struct bpf_struct_ops_value));
> =20
>  	st_map =3D bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
> -	if (!st_map)
> -		return ERR_PTR(-ENOMEM);
> +	if (!st_map) {
> +		ret =3D -ENOMEM;
> +		goto errout;
> +	}
> =20
>  	st_map->st_ops_desc =3D st_ops_desc;
>  	map =3D &st_map->map;
> =20
>  	ret =3D bpf_jit_charge_modmem(PAGE_SIZE);
> -	if (ret) {
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(ret);
> -	}
> +	if (ret)
> +		goto errout_free;
> =20
>  	st_map->image =3D bpf_jit_alloc_exec(PAGE_SIZE);
>  	if (!st_map->image) {
> @@ -713,23 +737,32 @@ static struct bpf_map *bpf_struct_ops_map_alloc(uni=
on bpf_attr *attr)
>  		 * here.
>  		 */
>  		bpf_jit_uncharge_modmem(PAGE_SIZE);
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(-ENOMEM);
> +		ret =3D -ENOMEM;
> +		goto errout_free;
>  	}
>  	st_map->uvalue =3D bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>  	st_map->links =3D
>  		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
>  				   NUMA_NO_NODE);
>  	if (!st_map->uvalue || !st_map->links) {
> -		__bpf_struct_ops_map_free(map);
> -		return ERR_PTR(-ENOMEM);
> +		ret =3D -ENOMEM;
> +		goto errout_free;
>  	}
> =20
>  	mutex_init(&st_map->lock);
>  	set_vm_flush_reset_perms(st_map->image);
>  	bpf_map_init_from_attr(map, attr);
> =20
> +	module_put(mod);
> +
>  	return map;
> +
> +errout_free:
> +	__bpf_struct_ops_map_free(map);
> +	btf =3D NULL;		/* has been released */
> +errout:
> +	module_put(mod);
> +	return ERR_PTR(ret);
>  }
> =20
>  static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
> @@ -811,6 +844,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bp=
f_link *link)
>  		 * bpf_struct_ops_link_create() fails to register.
>  		 */
>  		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
> +		module_put(st_map->st_ops_desc->st_ops->owner);
>  		bpf_map_put(&st_map->map);
>  	}
>  	kfree(st_link);
> @@ -857,6 +891,10 @@ static int bpf_struct_ops_map_link_update(struct bpf=
_link *link, struct bpf_map
>  	if (!bpf_struct_ops_valid_to_reg(new_map))
>  		return -EINVAL;
> =20
> +	/* The old map is holding the refcount for the owner module.  The
> +	 * ownership of the owner module refcount is going to be
> +	 * transferred from the old map to the new map.
> +	 */
>  	if (!st_map->st_ops_desc->st_ops->update)
>  		return -EOPNOTSUPP;
> =20
> @@ -902,6 +940,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	struct bpf_link_primer link_primer;
>  	struct bpf_struct_ops_map *st_map;
>  	struct bpf_map *map;
> +	struct btf *btf;
>  	int err;
> =20
>  	map =3D bpf_map_get(attr->link_create.map_fd);
> @@ -926,8 +965,15 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	if (err)
>  		goto err_out;
> =20
> +	/* Hold the owner module until the struct_ops is unregistered. */
> +	btf =3D st_map->st_ops_desc->btf;
> +	if (btf !=3D btf_vmlinux && !btf_try_get_module(btf)) {
> +		err =3D -EINVAL;
> +		goto err_out;
> +	}
>  	err =3D st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
>  	if (err) {
> +		module_put(st_map->st_ops_desc->st_ops->owner);
>  		bpf_link_cleanup(&link_primer);
>  		link =3D NULL;
>  		goto err_out;


