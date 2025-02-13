Return-Path: <bpf+bounces-51458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4A8A34CA7
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD06F16B431
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36114241674;
	Thu, 13 Feb 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqANmk8O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CF28A2C3
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469609; cv=none; b=rpgg1oDniRHOTDl+Q7IOimiNRIutuIL6PDkFoVG4DyXFYrncKpTSMAsj2wRLYxcJd/rv1BrnlH6ZZxF5rSF0vDgYsUM5SVSsTRHsS1z1nch+8l2aF/Xj25Tefw1MKcAx8DeJx9VJAK76HZYQzhWk7x5LGw/Ti/iiFrhVfB05Wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469609; c=relaxed/simple;
	bh=/qauhTATitppGLUfZBLINP1wEmp9z626BZw21mAFubk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TntAUns+EScuJa++aMSeEWTUHlFRZx7+1Yblk8lmsumiqNu84Tvxs1dFIzK/Kg5iKbfdubbY27VpX6ynbuNfufpf8FnJC+AfVD34myOY0MEIOscnpKTo6c7n3D1mEYSyTkXGQB1fDmivp3NtiAfa/JtM0P8iHIKrnas7Nnt7ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqANmk8O; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so226449566b.0
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739469606; x=1740074406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aekgwP99GujUKHxuGyf4E2mlrg/mQOw8kcmNXj42cTw=;
        b=nqANmk8OU+rduMWMqtxFkOO+GeH13WUnEXQmPAXG3DD7CwloK512uGljJucXpYHUhS
         a/rU03QwBVlfu2uqvFjMwKtYlPwpHlUEoQNwXtKJcXKq8UrLYssNv4EUfONnw3RyFw5B
         7ZziP8NaTcTmHExU5FKu/FX0dKAtYAL9jhOHebLLBpGxnTKLvhZS+Pb4vVt6WStB2epT
         +8BixbZXiatOf6oh7DcMwE+KAwpNBE2vezG6vhtiMSIT+JZhQKwxEAU11K/q3hd1VW0I
         2duJayD5E2iiMIM4cHuYSFCflhWoXvELrHafMVvnJzGzr5Kjel0Stlf1l3FSSZ+0q0kU
         P7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469606; x=1740074406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aekgwP99GujUKHxuGyf4E2mlrg/mQOw8kcmNXj42cTw=;
        b=lbLvbHvHYL8GPIlE1O1tBO/VncAG4+RGQXiXPSCt0PNKbTigejLIzXu+fxGcvGMEQH
         TbOmH+te+7w1kwgze4gC+RmIf07HnCudDX7Ht/NTTdGtNi7PaRMCL1mrrRtS3ZZSlpG7
         OFO+AbMq8Y4IsvRueirG2Ha3LcskwGTIMrBvHftdzt4pLOAixNhDmRRZR7PZ4GtFGYtA
         2vU0Xhmq/locdPTO1j5aEuKByKBMklBcBRG6dPIfgO9qaQ70kXNBARFa4WmI4S7yO9wj
         QAYVcyHax2h9VWIlPXQRPUguZ07dRWimaJfP79idATuNUn2HEzp1kp1CFAJWyQTnRR2V
         TvGQ==
X-Gm-Message-State: AOJu0Yw599upa4V9QUqIGsw4A5usUhCe8zLWL462D+kRqZbSmmB8L9WH
	fkytROsNWXMyn3V2tOCrbhCQkI0fl14yCjPH4UX7dXMPLVTV17GQfWjyHVQwRqMPapFoVosR5iA
	jaAziEQcSmnJUShJTNuaLV2HASlc=
X-Gm-Gg: ASbGnctAsvatUKYirqE9gXWfTVsR7B+6aaLLDFOVKOpx6d+yq4yRqRkJz75zSSXFw24
	PsGZqymVxxFyqkH5AeULo9IJcSNBGDbp5M+zafqPY2ePiUQWycbDoRStVjzq768RmBVZRDKVVau
	n/jptcYLLbV5lclAPnNq7WvAoo35H0
X-Google-Smtp-Source: AGHT+IHPzIh0uQ9B066Uxghse7+7Naz/NuwZshPK5uW7sunuM7MYekTt0YPRNh3MkgumzWDhZDXYf1Afs4EjMD8CQzU=
X-Received: by 2002:a17:906:7807:b0:ab7:dec1:b353 with SMTP id
 a640c23a62f3a-ab7f34aeca8mr785964066b.49.1739469605300; Thu, 13 Feb 2025
 10:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com> <20250125111109.732718-3-houtao@huaweicloud.com>
In-Reply-To: <20250125111109.732718-3-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 09:59:51 -0800
X-Gm-Features: AWEUYZneVpIBRiRu7zM04_kIooNJ0wjQVS8nb1zPmhWOqUNsZkOZG3QZ958I0EQ
Message-ID: <CAADnVQLOfWZ_5U9ZN4QaQQR1-OHdgDT3GJ1bP-QNPNRZNHbn+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/20] bpf: Parse bpf_dynptr in map key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> To support variable-length key or strings in map key, use bpf_dynptr to
> represent these variable-length objects and save these bpf_dynptr
> fields in the map key. As shown in the examples below, a map key with an
> integer and a string is defined:
>
>         struct pid_name {
>                 int pid;
>                 struct bpf_dynptr name;
>         };
>
> The bpf_dynptr in the map key could also be contained indirectly in a
> struct as shown below:
>
>         struct pid_name_time {
>                 struct pid_name process;
>                 unsigned long long time;
>         };
>
> If the whole map key is a bpf_dynptr, the map could be defined as a
> struct or directly using bpf_dynptr as the map key:
>
>         struct map_key {
>                 struct bpf_dynptr name;
>         };
>
> The bpf program could use bpf_dynptr_init() to initialize the dynptr
> part in the map key, and the userspace application will use
> bpf_dynptr_user_init() or similar API to initialize the dynptr. Just
> like kptrs in map value, the bpf_dynptr field in the map key could also
> be defined in a nested struct which is contained in the map key struct.
>
> The patch updates map_create() accordingly to parse these bpf_dynptr
> fields in map key, just like it does for other special fields in map
> value. To enable bpf_dynptr support in map key, the map_type should be
> BPF_MAP_TYPE_HASH. For now, the max number of bpf_dynptr in a map key
> is limited as 1 and the limitation can be relaxed later.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/bpf.h     | 14 ++++++++++++++
>  kernel/bpf/btf.c        |  4 ++++
>  kernel/bpf/map_in_map.c | 21 +++++++++++++++++----
>  kernel/bpf/syscall.c    | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 76 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0ee14ae30100f..ed58d5dd6b34b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -271,7 +271,14 @@ struct bpf_map {
>         u64 map_extra; /* any per-map-type extra fields */
>         u32 map_flags;
>         u32 id;
> +       /* BTF record for special fields in map value. bpf_dynptr is disa=
llowed
> +        * at present.
> +        */

Maybe drop 'at present' to fit on one line.
I would also capitalize Value to make the difference more obvious...

>         struct btf_record *record;
> +       /* BTF record for special fields in map key. Only bpf_dynptr is a=
llowed
> +        * at present.

...with this line. Key.

> +        */
> +       struct btf_record *key_record;
>         int numa_node;
>         u32 btf_key_type_id;
>         u32 btf_value_type_id;
> @@ -336,6 +343,8 @@ static inline const char *btf_field_type_name(enum bt=
f_field_type type)
>                 return "bpf_rb_node";
>         case BPF_REFCOUNT:
>                 return "bpf_refcount";
> +       case BPF_DYNPTR:
> +               return "bpf_dynptr";
>         default:
>                 WARN_ON_ONCE(1);
>                 return "unknown";
> @@ -366,6 +375,8 @@ static inline u32 btf_field_type_size(enum btf_field_=
type type)
>                 return sizeof(struct bpf_rb_node);
>         case BPF_REFCOUNT:
>                 return sizeof(struct bpf_refcount);
> +       case BPF_DYNPTR:
> +               return sizeof(struct bpf_dynptr);
>         default:
>                 WARN_ON_ONCE(1);
>                 return 0;
> @@ -396,6 +407,8 @@ static inline u32 btf_field_type_align(enum btf_field=
_type type)
>                 return __alignof__(struct bpf_rb_node);
>         case BPF_REFCOUNT:
>                 return __alignof__(struct bpf_refcount);
> +       case BPF_DYNPTR:
> +               return __alignof__(struct bpf_dynptr);
>         default:
>                 WARN_ON_ONCE(1);
>                 return 0;
> @@ -426,6 +439,7 @@ static inline void bpf_obj_init_field(const struct bt=
f_field *field, void *addr)
>         case BPF_KPTR_REF:
>         case BPF_KPTR_PERCPU:
>         case BPF_UPTR:
> +       case BPF_DYNPTR:
>                 break;
>         default:
>                 WARN_ON_ONCE(1);
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index b316631b614fa..0ce5180e024a3 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3500,6 +3500,7 @@ static int btf_get_field_type(const struct btf *btf=
, const struct btf_type *var_
>         field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
>         field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
>         field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
> +       field_mask_test_name(BPF_DYNPTR,    "bpf_dynptr");
>
>         /* Only return BPF_KPTR when all other types with matchable names=
 fail */
>         if (field_mask & (BPF_KPTR | BPF_UPTR) && !__btf_type_is_struct(v=
ar_type)) {
> @@ -3538,6 +3539,7 @@ static int btf_repeat_fields(struct btf_field_info =
*info, int info_cnt,
>                 case BPF_UPTR:
>                 case BPF_LIST_HEAD:
>                 case BPF_RB_ROOT:
> +               case BPF_DYNPTR:
>                         break;
>                 default:
>                         return -EINVAL;
> @@ -3660,6 +3662,7 @@ static int btf_find_field_one(const struct btf *btf=
,
>         case BPF_LIST_NODE:
>         case BPF_RB_NODE:
>         case BPF_REFCOUNT:
> +       case BPF_DYNPTR:
>                 ret =3D btf_find_struct(btf, var_type, off, sz, field_typ=
e,
>                                       info_cnt ? &info[0] : &tmp);
>                 if (ret < 0)
> @@ -4017,6 +4020,7 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
>                         break;
>                 case BPF_LIST_NODE:
>                 case BPF_RB_NODE:
> +               case BPF_DYNPTR:
>                         break;
>                 default:
>                         ret =3D -EFAULT;
> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 645bd30bc9a9d..564ebcc857564 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c
> @@ -12,6 +12,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>         struct bpf_map *inner_map, *inner_map_meta;
>         u32 inner_map_meta_size;
>         CLASS(fd, f)(inner_map_ufd);
> +       int ret;
>
>         inner_map =3D __bpf_map_get(f);
>         if (IS_ERR(inner_map))
> @@ -45,10 +46,15 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>                  * invalid/empty/valid, but ERR_PTR in case of errors. Du=
ring
>                  * equality NULL or IS_ERR is equivalent.
>                  */
> -               struct bpf_map *ret =3D ERR_CAST(inner_map_meta->record);
> -               kfree(inner_map_meta);
> -               return ret;
> +               ret =3D PTR_ERR(inner_map_meta->record);
> +               goto free_meta;
>         }
> +       inner_map_meta->key_record =3D btf_record_dup(inner_map->key_reco=
rd);
> +       if (IS_ERR(inner_map_meta->key_record)) {
> +               ret =3D PTR_ERR(inner_map_meta->key_record);
> +               goto free_record;
> +       }
> +
>         /* Note: We must use the same BTF, as we also used btf_record_dup=
 above
>          * which relies on BTF being same for both maps, as some members =
like
>          * record->fields.list_head have pointers like value_rec pointing=
 into
> @@ -71,6 +77,12 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>                 inner_map_meta->bypass_spec_v1 =3D inner_map->bypass_spec=
_v1;
>         }
>         return inner_map_meta;
> +
> +free_record:
> +       btf_record_free(inner_map_meta->record);
> +free_meta:
> +       kfree(inner_map_meta);
> +       return ERR_PTR(ret);
>  }
>
>  void bpf_map_meta_free(struct bpf_map *map_meta)
> @@ -88,7 +100,8 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
>                 meta0->key_size =3D=3D meta1->key_size &&
>                 meta0->value_size =3D=3D meta1->value_size &&
>                 meta0->map_flags =3D=3D meta1->map_flags &&
> -               btf_record_equal(meta0->record, meta1->record);
> +               btf_record_equal(meta0->record, meta1->record) &&
> +               btf_record_equal(meta0->key_record, meta1->key_record);
>  }
>
>  void *bpf_map_fd_get_ptr(struct bpf_map *map,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0daf098e32074..6e14208cca813 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -651,6 +651,7 @@ void btf_record_free(struct btf_record *rec)
>                 case BPF_TIMER:
>                 case BPF_REFCOUNT:
>                 case BPF_WORKQUEUE:
> +               case BPF_DYNPTR:
>                         /* Nothing to release */
>                         break;
>                 default:
> @@ -664,7 +665,9 @@ void btf_record_free(struct btf_record *rec)
>  void bpf_map_free_record(struct bpf_map *map)
>  {
>         btf_record_free(map->record);
> +       btf_record_free(map->key_record);
>         map->record =3D NULL;
> +       map->key_record =3D NULL;
>  }
>
>  struct btf_record *btf_record_dup(const struct btf_record *rec)
> @@ -703,6 +706,7 @@ struct btf_record *btf_record_dup(const struct btf_re=
cord *rec)
>                 case BPF_TIMER:
>                 case BPF_REFCOUNT:
>                 case BPF_WORKQUEUE:
> +               case BPF_DYNPTR:
>                         /* Nothing to acquire */
>                         break;
>                 default:
> @@ -821,6 +825,8 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
>                 case BPF_RB_NODE:
>                 case BPF_REFCOUNT:
>                         break;
> +               case BPF_DYNPTR:
> +                       break;
>                 default:
>                         WARN_ON_ONCE(1);
>                         continue;
> @@ -830,6 +836,7 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
>
>  static void bpf_map_free(struct bpf_map *map)
>  {
> +       struct btf_record *key_rec =3D map->key_record;
>         struct btf_record *rec =3D map->record;
>         struct btf *btf =3D map->btf;
>
> @@ -850,6 +857,7 @@ static void bpf_map_free(struct bpf_map *map)
>          * eventually calls bpf_map_free_meta, since inner_map_meta is on=
ly a
>          * template bpf_map struct used during verification.
>          */
> +       btf_record_free(key_rec);
>         btf_record_free(rec);
>         /* Delay freeing of btf for maps, as map_free callback may need
>          * struct_meta info which will be freed with btf_put().
> @@ -1180,6 +1188,8 @@ int map_check_no_btf(const struct bpf_map *map,
>         return -ENOTSUPP;
>  }
>
> +#define MAX_DYNPTR_CNT_IN_MAP_KEY 1

I remember we discussed to allow 2 dynptr-s in a key.
And in patch 11 you already do:
+       record =3D map->key_record;
+       for (i =3D 0; i < record->cnt; i++) {

so the support for multiple dynptr-s is almost there?

> +
>  static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>                          const struct btf *btf, u32 btf_key_id, u32 btf_v=
alue_id)
>  {
> @@ -1202,6 +1212,37 @@ static int map_check_btf(struct bpf_map *map, stru=
ct bpf_token *token,
>         if (!value_type || value_size !=3D map->value_size)
>                 return -EINVAL;
>
> +       /* Key BTF type can't be data section */
> +       if (btf_type_is_dynptr(btf, key_type))
> +               map->key_record =3D btf_new_bpf_dynptr_record();
> +       else if (__btf_type_is_struct(key_type))
> +               map->key_record =3D btf_parse_fields(btf, key_type, BPF_D=
YNPTR, map->key_size);
> +       else
> +               map->key_record =3D NULL;
> +       if (!IS_ERR_OR_NULL(map->key_record)) {
> +               if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY) {
> +                       ret =3D -E2BIG;
> +                       goto free_map_tab;
> +               }
> +               if (map->map_type !=3D BPF_MAP_TYPE_HASH) {
> +                       ret =3D -EOPNOTSUPP;
> +                       goto free_map_tab;
> +               }
> +               if (!bpf_token_capable(token, CAP_BPF)) {
> +                       ret =3D -EPERM;
> +                       goto free_map_tab;
> +               }
> +               /* Disallow key with dynptr for special map */
> +               if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PR=
OG)) {
> +                       ret =3D -EACCES;
> +                       goto free_map_tab;
> +               }
> +       } else if (IS_ERR(map->key_record)) {
> +               /* Return an error early even the bpf program doesn't use=
 it */
> +               ret =3D PTR_ERR(map->key_record);
> +               goto free_map_tab;
> +       }
> +
>         map->record =3D btf_parse_fields(btf, value_type,
>                                        BPF_SPIN_LOCK | BPF_TIMER | BPF_KP=
TR | BPF_LIST_HEAD |
>                                        BPF_RB_ROOT | BPF_REFCOUNT | BPF_W=
ORKQUEUE | BPF_UPTR,
> --
> 2.29.2
>

