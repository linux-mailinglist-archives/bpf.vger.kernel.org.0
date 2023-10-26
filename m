Return-Path: <bpf+bounces-13354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199597D89F9
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 23:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E21C20FD4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63A3D3A0;
	Thu, 26 Oct 2023 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGscTICT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC33AC04;
	Thu, 26 Oct 2023 21:03:01 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98541AA;
	Thu, 26 Oct 2023 14:02:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso2134636a12.1;
        Thu, 26 Oct 2023 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698354177; x=1698958977; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSS5pifBSzbKtIG4YyyK9JlnI4cwUbgeyW1UKjSqsxw=;
        b=IGscTICTAi7cu0nUUCHpE4azhaT1okMeiPfRHzYNjoK57jQxGG7QdGApbTB3A7xaLh
         0U9sTDHNWXAhAnceOZz5JsQ7paCwv/RCfdFvI6zW0/LYCBrYC/Z6CZKbmpidClMtqtf7
         KafL9ffgwVc65qJtQ4jWNs8Rpz9yzyEqGLj3oZZltdjBzIB+vmvhJSwnu7s7ZULbFrRl
         Gnakm3TENkoT6JPZ9NZt67v6IgqEKDmWvSv1ZmAqztsf4CQeTWlZV78pPjGmZH+CJBUu
         0ECHYTEbgKG5KcH2PaMAo1XL8uiiZUD55yUs/O0II3KBeU2kCj27LF9lasGIULNjQxL6
         TBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698354177; x=1698958977;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSS5pifBSzbKtIG4YyyK9JlnI4cwUbgeyW1UKjSqsxw=;
        b=YMM5QBbIdu6vU3WOlQViAxwhkLsjj+iRKZy4GojyvZF7Lhsgj9vaTe8pf3V8TJN3S7
         fwVE/u5j+726hCSsZFarMEv0FHSPT/uP6Q385u69yaABJpzW2vgpP39Yw0ui9YXROm7t
         1qB6asWj+FiIJzLuMawNVAkHthm5XQ+XIIu7HbtBw6UktLPjKZ2sOlNnocWlISPpDMTN
         4V5Z3nGy0fA5WeKPH4E/Jp09llWNryJx1einYn3napkAHoXWyEuBCzqBsXPWzuBcv3gr
         K27LzR43NRECBm3soGswJGO83iEb52hAHPnhnxkHyt7/uuQnqqFkFgSjEZeYvh9cVbBu
         KV4w==
X-Gm-Message-State: AOJu0Yz4yQHv9LkX33WA+xpNfs3aC/oobpaqEtrPCGSHsBQAb/24v0zN
	4mMT/K7yDTYtx8nNHS/SaRP1AjWDFQDqBYxk
X-Google-Smtp-Source: AGHT+IGcBg+uOvQy4+IVJz/mQ7BCJsCbj1wE9kL+U/topiDPe5TgEFDwJCzU6vCfRHdvrP+IsPAe4w==
X-Received: by 2002:aa7:d296:0:b0:53e:58fd:9600 with SMTP id w22-20020aa7d296000000b0053e58fd9600mr747716edq.36.1698354176919;
        Thu, 26 Oct 2023 14:02:56 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a25-20020aa7cf19000000b00540f4715289sm146650edy.61.2023.10.26.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 14:02:56 -0700 (PDT)
Message-ID: <7b143dd306cdb3a94c995bf807596fb1f88a02f9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 07/10] bpf, net: switch to dynamic
 registration
From: Eduard Zingerman <eddyz87@gmail.com>
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org,  drosen@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org
Date: Fri, 27 Oct 2023 00:02:55 +0300
In-Reply-To: <20231022050335.2579051-8-thinker.li@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
	 <20231022050335.2579051-8-thinker.li@gmail.com>
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
> Replace the static list of struct_ops types with per-btf struct_ops_tab t=
o
> enable dynamic registration.
>=20
> Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
> instead of being listed in bpf_struct_ops_types.h.
>=20
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Hello,=20

I left two nitpicks below, feel free to ignore if you think is good as-is.

> ---
>  include/linux/bpf.h               |  36 +++++++--
>  include/linux/btf.h               |   5 +-
>  kernel/bpf/bpf_struct_ops.c       | 123 ++++++++----------------------
>  kernel/bpf/bpf_struct_ops_types.h |  12 ---
>  kernel/bpf/btf.c                  |  41 +++++++++-
>  net/bpf/bpf_dummy_struct_ops.c    |  14 +++-
>  net/ipv4/bpf_tcp_ca.c             |  16 +++-
>  7 files changed, 130 insertions(+), 117 deletions(-)
>  delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
>=20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 26feb8a2da4f..a53b2181c845 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1644,7 +1644,6 @@ struct bpf_struct_ops_desc {
>  #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>  #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELT=
A))
>  const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u=
32 type_id);
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>  bool bpf_struct_ops_get(const void *kdata);
>  void bpf_struct_ops_put(const void *kdata);
>  int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
> @@ -1690,10 +1689,6 @@ static inline const struct bpf_struct_ops_desc *bp=
f_struct_ops_find(struct btf *
>  {
>  	return NULL;
>  }
> -static inline void bpf_struct_ops_init(struct btf *btf,
> -				       struct bpf_verifier_log *log)
> -{
> -}
>  static inline bool bpf_try_module_get(const void *data, struct module *o=
wner)
>  {
>  	return try_module_get(owner);
> @@ -3212,4 +3207,35 @@ static inline bool bpf_is_subprog(const struct bpf=
_prog *prog)
>  	return prog->aux->func_idx !=3D 0;
>  }
> =20
> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
> +
> +enum bpf_struct_ops_state {
> +	BPF_STRUCT_OPS_STATE_INIT,
> +	BPF_STRUCT_OPS_STATE_INUSE,
> +	BPF_STRUCT_OPS_STATE_TOBEFREE,
> +	BPF_STRUCT_OPS_STATE_READY,
> +};
> +
> +struct bpf_struct_ops_common_value {
> +	refcount_t refcnt;
> +	enum bpf_struct_ops_state state;
> +};
> +
> +/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
> + * the map's value exposed to the userspace and its btf-type-id is
> + * stored at the map->btf_vmlinux_value_type_id.
> + *
> + */
> +#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)			\
> +extern struct bpf_struct_ops bpf_##_name;			\
> +								\
> +struct bpf_struct_ops_##_name {					\
> +	struct bpf_struct_ops_common_value common;		\
> +	struct _name data ____cacheline_aligned_in_smp;		\
> +}
> +
> +extern void bpf_struct_ops_init(struct bpf_struct_ops_desc *st_ops_desc,
> +				struct btf *btf,
> +				struct bpf_verifier_log *log);
> +
>  #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 6a64b372b7a0..533db3f406b3 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -12,6 +12,8 @@
>  #include <uapi/linux/bpf.h>
> =20
>  #define BTF_TYPE_EMIT(type) ((void)(type *)0)
> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);	\
> +		((void)(struct bpf_struct_ops_##type *)0); }
>  #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
> =20
>  /* These need to be macros, as the expressions are used in assembler inp=
ut */
> @@ -200,6 +202,7 @@ u32 btf_obj_id(const struct btf *btf);
>  bool btf_is_kernel(const struct btf *btf);
>  bool btf_is_module(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
> +struct btf *btf_get_module_btf(const struct module *module);
>  u32 btf_nr_types(const struct btf *btf);
>  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type =
*s,
>  			   const struct btf_member *m,
> @@ -574,8 +577,6 @@ static inline bool btf_type_is_struct_ptr(struct btf =
*btf, const struct btf_type
>  struct bpf_struct_ops;
>  struct bpf_struct_ops_desc;
> =20
> -struct bpf_struct_ops_desc *
> -btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops);
>  const struct bpf_struct_ops_desc *
>  btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
> =20
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 99ab61cc6cad..44412f95bc32 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -13,21 +13,8 @@
>  #include <linux/btf_ids.h>
>  #include <linux/rcupdate_wait.h>
> =20
> -enum bpf_struct_ops_state {
> -	BPF_STRUCT_OPS_STATE_INIT,
> -	BPF_STRUCT_OPS_STATE_INUSE,
> -	BPF_STRUCT_OPS_STATE_TOBEFREE,
> -	BPF_STRUCT_OPS_STATE_READY,
> -};
> -
> -struct bpf_struct_ops_common_value {
> -	refcount_t refcnt;
> -	enum bpf_struct_ops_state state;
> -};
> -#define BPF_STRUCT_OPS_COMMON_VALUE struct bpf_struct_ops_common_value c=
ommon
> -
>  struct bpf_struct_ops_value {
> -	BPF_STRUCT_OPS_COMMON_VALUE;
> +	struct bpf_struct_ops_common_value common;
>  	char data[] ____cacheline_aligned_in_smp;
>  };
> =20
> @@ -72,35 +59,6 @@ static DEFINE_MUTEX(update_mutex);
>  #define VALUE_PREFIX "bpf_struct_ops_"
>  #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
> =20
> -/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
> - * the map's value exposed to the userspace and its btf-type-id is
> - * stored at the map->btf_vmlinux_value_type_id.
> - *
> - */
> -#define BPF_STRUCT_OPS_TYPE(_name)				\
> -extern struct bpf_struct_ops bpf_##_name;			\
> -								\
> -struct bpf_struct_ops_##_name {						\
> -	BPF_STRUCT_OPS_COMMON_VALUE;				\
> -	struct _name data ____cacheline_aligned_in_smp;		\
> -};
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -
> -enum {
> -#define BPF_STRUCT_OPS_TYPE(_name) BPF_STRUCT_OPS_TYPE_##_name,
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -	__NR_BPF_STRUCT_OPS_TYPE,
> -};
> -
> -static struct bpf_struct_ops_desc bpf_struct_ops[] =3D {
> -#define BPF_STRUCT_OPS_TYPE(_name)				\
> -	[BPF_STRUCT_OPS_TYPE_##_name] =3D { .st_ops =3D &bpf_##_name },
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -};
> -
>  const struct bpf_verifier_ops bpf_struct_ops_verifier_ops =3D {
>  };
> =20
> @@ -110,13 +68,22 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops =
=3D {
>  #endif
>  };
> =20
> -static const struct btf_type *module_type;
> -static const struct btf_type *common_value_type;
> +BTF_ID_LIST(st_ops_ids)
> +BTF_ID(struct, module)
> +BTF_ID(struct, bpf_struct_ops_common_value)
> +
> +enum {
> +	idx_module_id,
> +	idx_st_ops_common_value_id,
> +};
> +
> +extern struct btf *btf_vmlinux;
> =20
>  static bool is_valid_value_type(struct btf *btf, s32 value_id,
>  				const struct btf_type *type,
>  				const char *value_name)
>  {
> +	const struct btf_type *common_value_type;
>  	const struct btf_member *member;
>  	const struct btf_type *vt, *mt;
> =20
> @@ -128,6 +95,8 @@ static bool is_valid_value_type(struct btf *btf, s32 v=
alue_id,
>  	}
>  	member =3D btf_type_member(vt);
>  	mt =3D btf_type_by_id(btf, member->type);
> +	common_value_type =3D btf_type_by_id(btf_vmlinux,
> +					   st_ops_ids[idx_st_ops_common_value_id]);
>  	if (mt !=3D common_value_type) {
>  		pr_warn("The first member of %s should be bpf_struct_ops_common_value\=
n",
>  			value_name);
> @@ -144,9 +113,9 @@ static bool is_valid_value_type(struct btf *btf, s32 =
value_id,
>  	return true;
>  }
> =20
> -static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_d=
esc,
> -				    struct btf *btf,
> -				    struct bpf_verifier_log *log)
> +void bpf_struct_ops_init(struct bpf_struct_ops_desc *st_ops_desc,
> +			 struct btf *btf,
> +			 struct bpf_verifier_log *log)
>  {
>  	struct bpf_struct_ops *st_ops =3D st_ops_desc->st_ops;
>  	const struct btf_member *member;
> @@ -232,51 +201,20 @@ static void bpf_struct_ops_init_one(struct bpf_stru=
ct_ops_desc *st_ops_desc,
>  	}
>  }
> =20
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> -{
> -	struct bpf_struct_ops_desc *st_ops_desc;
> -	s32 module_id, common_value_id;
> -	u32 i;
> -
> -	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_#=
#_name);
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -
> -	module_id =3D btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
> -	if (module_id < 0) {
> -		pr_warn("Cannot find struct module in btf_vmlinux\n");
> -		return;
> -	}
> -	module_type =3D btf_type_by_id(btf, module_id);
> -	common_value_id =3D btf_find_by_name_kind(btf,
> -						"bpf_struct_ops_common_value",
> -						BTF_KIND_STRUCT);
> -	if (common_value_id < 0) {
> -		pr_warn("Cannot find struct common_value in btf_vmlinux\n");
> -		return;
> -	}
> -	common_value_type =3D btf_type_by_id(btf, common_value_id);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		st_ops_desc =3D &bpf_struct_ops[i];
> -		bpf_struct_ops_init_one(st_ops_desc, btf, log);
> -	}
> -}
> -
> -extern struct btf *btf_vmlinux;
> -
>  static const struct bpf_struct_ops_desc *
>  bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>  {
> +	const struct bpf_struct_ops_desc *st_ops_list;
>  	unsigned int i;
> +	u32 cnt =3D 0;
> =20
> -	if (!value_id || !btf_vmlinux)
> +	if (!value_id)
>  		return NULL;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i].value_id =3D=3D value_id)
> -			return &bpf_struct_ops[i];
> +	st_ops_list =3D btf_get_struct_ops(btf, &cnt);
> +	for (i =3D 0; i < cnt; i++) {
> +		if (st_ops_list[i].value_id =3D=3D value_id)
> +			return &st_ops_list[i];
>  	}
> =20
>  	return NULL;
> @@ -285,14 +223,17 @@ bpf_struct_ops_find_value(struct btf *btf, u32 valu=
e_id)
>  const struct bpf_struct_ops_desc *
>  bpf_struct_ops_find(struct btf *btf, u32 type_id)
>  {
> +	const struct bpf_struct_ops_desc *st_ops_list;
>  	unsigned int i;
> +	u32 cnt;
> =20
> -	if (!type_id || !btf_vmlinux)
> +	if (!type_id)
>  		return NULL;
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i].type_id =3D=3D type_id)
> -			return &bpf_struct_ops[i];
> +	st_ops_list =3D btf_get_struct_ops(btf, &cnt);
> +	for (i =3D 0; i < cnt; i++) {
> +		if (st_ops_list[i].type_id =3D=3D type_id)
> +			return &st_ops_list[i];
>  	}
> =20
>  	return NULL;
> @@ -429,6 +370,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>  	const struct bpf_struct_ops_desc *st_ops_desc =3D st_map->st_ops_desc;
>  	const struct bpf_struct_ops *st_ops =3D st_ops_desc->st_ops;
>  	struct bpf_struct_ops_value *uvalue, *kvalue;
> +	const struct btf_type *module_type;
>  	const struct btf_member *member;
>  	const struct btf_type *t =3D st_ops_desc->type;
>  	struct bpf_tramp_links *tlinks;
> @@ -485,6 +427,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
>  	image =3D st_map->image;
>  	image_end =3D st_map->image + PAGE_SIZE;
> =20
> +	module_type =3D btf_type_by_id(btf_vmlinux, st_ops_ids[idx_module_id]);
>  	for_each_member(i, t, member) {
>  		const struct btf_type *mtype, *ptype;
>  		struct bpf_prog *prog;
> diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_op=
s_types.h
> deleted file mode 100644
> index 5678a9ddf817..000000000000
> --- a/kernel/bpf/bpf_struct_ops_types.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* internal file - do not include directly */
> -
> -#ifdef CONFIG_BPF_JIT
> -#ifdef CONFIG_NET
> -BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
> -#endif
> -#ifdef CONFIG_INET
> -#include <net/tcp.h>
> -BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
> -#endif
> -#endif
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c1e2ed6c972e..c53888e8dddb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5790,8 +5790,6 @@ struct btf *btf_parse_vmlinux(void)
>  	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
>  	bpf_ctx_convert.t =3D btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
> =20
> -	bpf_struct_ops_init(btf, log);
> -
>  	refcount_set(&btf->refcnt, 1);
> =20
>  	err =3D btf_alloc_id(btf);
> @@ -7532,7 +7530,7 @@ struct module *btf_try_get_module(const struct btf =
*btf)
>  /* Returns struct btf corresponding to the struct module.
>   * This function can return NULL or ERR_PTR.
>   */
> -static struct btf *btf_get_module_btf(const struct module *module)
> +struct btf *btf_get_module_btf(const struct module *module)
>  {
>  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	struct btf_module *btf_mod, *tmp;
> @@ -8672,3 +8670,40 @@ const struct bpf_struct_ops_desc *btf_get_struct_o=
ps(struct btf *btf, u32 *ret_c
>  	return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
>  }
> =20
> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
> +{
> +	struct bpf_struct_ops_desc *desc;
> +	struct bpf_verifier_log *log;
> +	struct btf *btf;
> +	int err =3D 0;
> +
> +	if (st_ops =3D=3D NULL)
> +		return -EINVAL;
> +
> +	btf =3D btf_get_module_btf(st_ops->owner);
> +	if (!btf)
> +		return -EINVAL;
> +
> +	log =3D kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
> +	if (!log) {
> +		err =3D -ENOMEM;
> +		goto errout;
> +	}
> +
> +	log->level =3D BPF_LOG_KERNEL;

Nit: maybe use bpf_vlog_init() here to avoid breaking encapsulation?

> +
> +	desc =3D btf_add_struct_ops(btf, st_ops);
> +	if (IS_ERR(desc)) {
> +		err =3D PTR_ERR(desc);
> +		goto errout;
> +	}
> +
> +	bpf_struct_ops_init(desc, btf, log);

Nit: I think bpf_struct_ops_init() could be changed to return 'int',
     then register_bpf_struct_ops() could report to calling module if
     something went wrong on the last phase, wdyt?

> +
> +errout:
> +	kfree(log);
> +	btf_put(btf);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_op=
s.c
> index ffa224053a6c..148a5851c4fa 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -7,7 +7,7 @@
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> =20
> -extern struct bpf_struct_ops bpf_bpf_dummy_ops;
> +static struct bpf_struct_ops bpf_bpf_dummy_ops;
> =20
>  /* A common type for test_N with return value in bpf_dummy_ops */
>  typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, =
...);
> @@ -223,11 +223,13 @@ static int bpf_dummy_reg(void *kdata)
>  	return -EOPNOTSUPP;
>  }
> =20
> +DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_dummy_ops);
> +
>  static void bpf_dummy_unreg(void *kdata)
>  {
>  }
> =20
> -struct bpf_struct_ops bpf_bpf_dummy_ops =3D {
> +static struct bpf_struct_ops bpf_bpf_dummy_ops =3D {
>  	.verifier_ops =3D &bpf_dummy_verifier_ops,
>  	.init =3D bpf_dummy_init,
>  	.check_member =3D bpf_dummy_ops_check_member,
> @@ -235,4 +237,12 @@ struct bpf_struct_ops bpf_bpf_dummy_ops =3D {
>  	.reg =3D bpf_dummy_reg,
>  	.unreg =3D bpf_dummy_unreg,
>  	.name =3D "bpf_dummy_ops",
> +	.owner =3D THIS_MODULE,
>  };
> +
> +static int __init bpf_dummy_struct_ops_init(void)
> +{
> +	BTF_STRUCT_OPS_TYPE_EMIT(bpf_dummy_ops);
> +	return register_bpf_struct_ops(&bpf_bpf_dummy_ops);
> +}
> +late_initcall(bpf_dummy_struct_ops_init);
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 3c8b76578a2a..b36a19274e5b 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -12,7 +12,7 @@
>  #include <net/bpf_sk_storage.h>
> =20
>  /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_o=
ps.c. */
> -extern struct bpf_struct_ops bpf_tcp_congestion_ops;
> +static struct bpf_struct_ops bpf_tcp_congestion_ops;
> =20
>  static u32 unsupported_ops[] =3D {
>  	offsetof(struct tcp_congestion_ops, get_info),
> @@ -277,7 +277,9 @@ static int bpf_tcp_ca_validate(void *kdata)
>  	return tcp_validate_congestion_control(kdata);
>  }
> =20
> -struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
> +DEFINE_STRUCT_OPS_VALUE_TYPE(tcp_congestion_ops);
> +
> +static struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
>  	.verifier_ops =3D &bpf_tcp_ca_verifier_ops,
>  	.reg =3D bpf_tcp_ca_reg,
>  	.unreg =3D bpf_tcp_ca_unreg,
> @@ -287,10 +289,18 @@ struct bpf_struct_ops bpf_tcp_congestion_ops =3D {
>  	.init =3D bpf_tcp_ca_init,
>  	.validate =3D bpf_tcp_ca_validate,
>  	.name =3D "tcp_congestion_ops",
> +	.owner =3D THIS_MODULE,
>  };
> =20
>  static int __init bpf_tcp_ca_kfunc_init(void)
>  {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_=
kfunc_set);
> +	int ret;
> +
> +	BTF_STRUCT_OPS_TYPE_EMIT(tcp_congestion_ops);
> +
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca=
_kfunc_set);
> +	ret =3D ret ?: register_bpf_struct_ops(&bpf_tcp_congestion_ops);
> +
> +	return ret;
>  }
>  late_initcall(bpf_tcp_ca_kfunc_init);


