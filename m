Return-Path: <bpf+bounces-55609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D0A834EA
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 02:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62854666FD
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444B33F6;
	Thu, 10 Apr 2025 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV6PXXqn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D33FE4
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243391; cv=none; b=KaJEp/Do1M2EgvaPj6H55mco+8BLUzy9debnkXyNN5MpDqPpaaAiqAubbfERGihoJ5k4tigDAqbDa2u3NyYo+/dlMdQsicbzsq4zr2D7QvEyx8vDAgmzdNOu7t9TqJT00LxnPj9/vvGm8MF92g++Y/A6U82jw5IZQT7FnRMWi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243391; c=relaxed/simple;
	bh=SyMOxw/WHeigrck0iii2XWsasu7ua/rLotma+YpCp9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F02OXaBRz/PP6fxom0/0kGu0jiLr/UROHsVI9wTGs4bDRcrD+If9Yw7SSUGdjgaPjx8eSZhyxzvNLcOmJSSxkY17sM3dAkHKQlIogrwTCH/qjujt5kuAnXqMe62Gg5RzoyxAn2nL01qDrc+Xq/YXkNuAD92JfBn/hf01vkf7W7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV6PXXqn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224171d6826so2914175ad.3
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744243389; x=1744848189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJ9Yd+9gpx8nWVX3I8Si2fb0vMs7JmMvFgwn4vxgBY4=;
        b=OV6PXXqncwhIR0tCbGMUR8MTCSu467Id8wynxYV4LATBINV8MlZzXNEdw8xDixS0tO
         m6gOwhC3n4Af1wULOf02HtR6VyiXfKp4/wMvYsiYVn9IDBoPR2ux+8i+m6GMK5E6onMq
         aeY6R2A/uNxWireKGJ03Fg1hSFrFRAUGO5QUjo5zrSF8Ejl8O91Accc4ARR1b3vvOZDh
         8kLygnEt3X2J3Olo1MLaLsYTmhTCZzGCoVS5iiFCkKRhatGN3fSw2fcayN83Ig/jhVgh
         ygABUeIaylM7vcnzVnGR2/W6QTaxCFJgQ9DrBRAh7Xu456VmEEysOubgnl4gvARl2IyQ
         JN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744243389; x=1744848189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJ9Yd+9gpx8nWVX3I8Si2fb0vMs7JmMvFgwn4vxgBY4=;
        b=Zk0V+OetvGRW1eY5ihnwg/l7uoHUG0inO+y0j/s54iJVsNfoeCvH404i+NhHJwfLig
         5pDu42WkJRIVTjRxTsLMg67WnUyMtyeb66kZGYRks9+OtBnD987JXq4WV8IsmIxVQk0j
         J6PjDsqQk+nwz8q29kFd/iigernJVZNZSBXxHqb5mQLOyqVaQRvAWeEU7xB03V30Clvd
         m8sJlyveJ+rl6DK5zlJi8SRRMOJPpvD6JQdGRkQwbNo7IQdoJmsPeQRd/VOKy8fsxlnI
         UauaLdM06HuDzkbX02abqZZFU5lQCg1jxAGFMCzqOaSGnvZRGoxfcYifIZzGDGHHpTAY
         HuqA==
X-Gm-Message-State: AOJu0YykLjrr/BaqC4zs/IxGbHHoM5/Nd4C9EXXpNsqN0xkSR7wUvaUL
	x7Q4O/4RCszSsNS2W4k7uyTAGTfSTTXp8vRLmXZ4YZr2sdbHoP/KoehON4axB1vOagU4OIrctZr
	/ktiAcpXY4k7kSw/m/4ZfhbFNXnaAUg==
X-Gm-Gg: ASbGnctwS4elVfjpCWZ4N2Tz4R0aD2IHQjduYTmpFSSyWjjAOxD18Z9ekUzGGF469mA
	0fi7QrdmKnv/le2bW21txoyRghj8I01kZMulM12Ph4EmgQf+mDNKEndEFqFc3FFWuTlAwZ+ykbH
	k1hqL5DLu2HtksWj7JMhOQZvkPMhCS5GUtChA78g==
X-Google-Smtp-Source: AGHT+IGNjVvzXwYmBx5jryS3ksWFUnixDMY3fg/Vv/NNvqoqHuhm4/8wOkg1N3aIvJPExSqPjvWfyWJmA7FRqFqfd2E=
X-Received: by 2002:a17:902:ce8e:b0:220:e1e6:4472 with SMTP id
 d9443c01a7336-22b2edd201bmr10176705ad.13.1744243388170; Wed, 09 Apr 2025
 17:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407190158.351783-1-tim.cherry.co@gmail.com> <20250407190158.351783-3-tim.cherry.co@gmail.com>
In-Reply-To: <20250407190158.351783-3-tim.cherry.co@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Apr 2025 17:02:56 -0700
X-Gm-Features: ATxdqUG0EXpBtisUvdfBkqBOIcRXFmz9Flh7zU1KnLHvkNse5_lfdjaCMkI5fDo
Message-ID: <CAEf4BzbRS6sw_mXoE5jUVa79XE9Xmud8ZZW6nuET7KSwcG7p+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libbpf: add kind flag sanitizing
To: 20250331201016.345704-1-tim.cherry.co@gmail.com
Cc: bpf@vger.kernel.org, mykyta.yatsenko5@gmail.com, 
	Timur Chernykh <tim.cherry.co@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 12:25=E2=80=AFPM Timur Chernykh <tim.cherry.co@gmail=
.com> wrote:
>
> Fix missed check whether kernel supports the kind flag or not.
> The fix includes:
> - The feature check whether kernel supports the kind flag or not
> - Kind flag sanitizing if kernel doesn't support one
> - Struct/enum bitfield members sanitizing by generation a proper
>   replacement for the type of bitfield with corresponding integer
>   type with same bit size
>
> Signed-off-by: Timur Chernykh <tim.cherry.co@gmail.com>
> ---
>  tools/lib/bpf/features.c        | 30 +++++++++++++
>  tools/lib/bpf/libbpf.c          | 74 ++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf_internal.h |  2 +
>  3 files changed, 105 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 760657f5224c..b40a3fadb68b 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -507,6 +507,33 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +static int probe_kern_btf_type_kind_flag(int token_fd)
> +{
> +       static const char strs[] =3D "\0bpf_spin_lock\0val\0cnt\0l";
> +       /* struct bpf_spin_lock {
> +        *   int val;
> +        * };
> +        * struct val {
> +        *   int cnt;
> +        *   struct bpf_spin_lock l;
> +        * };
> +        */
> +       __u32 types[] =3D {
> +               /* int */
> +               BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
> +               /* struct bpf_spin_lock */                      /* [2] */
> +               BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_STRUCT, 1 /* kind b=
it */, 1), 4),
> +               BTF_MEMBER_ENC(15, 1, 0), /* int val; */
> +               /* struct val */                                /* [3] */
> +               BTF_TYPE_ENC(15, BTF_INFO_ENC(BTF_KIND_STRUCT, 1 /* kind =
bit */, 2), 8),
> +               BTF_MEMBER_ENC(19, 1, 0), /* int cnt; */
> +               BTF_MEMBER_ENC(23, 2, 32),/* struct bpf_spin_lock l; */
> +       };

this is a feature probe, no need to use "real" type names, there is
nothing special about bpf_spin_lock, so it can be just "s", for
example

also, why do you have two structs here? one with kflag=3D1 wouldn't be enou=
gh?

> +
> +       return probe_fd(libbpf__load_raw_btf((char *)types, sizeof(types)=
,
> +                                            strs, sizeof(strs), token_fd=
));
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -582,6 +609,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_BTF_TYPE_KIND_FLAG] =3D {
> +               "BTF btf_type can have the kind flags set", probe_kern_bt=
f_type_kind_flag,

"BTF struct kflag support" ?

> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c2369b6f3260..b1d4530bd9ed 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3113,9 +3113,11 @@ static bool btf_needs_sanitization(struct bpf_obje=
ct *obj)
>         bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>         bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
>         bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DA=
TASEC);
> +       bool has_kind_bit_support =3D kernel_supports(obj, FEAT_BTF_TYPE_=
KIND_FLAG);

has_kind_flag, no _support. Do you see "_support" in any other similar vari=
able?

>
>         return !has_func || !has_datasec || !has_func_global || !has_floa=
t ||
> -              !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmar=
k_datasec;
> +              !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmar=
k_datasec ||
> +                  !has_kind_bit_support;

looks like something is off with indentation, please check

>  }
>
>  static int bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *=
btf)
> @@ -3128,6 +3130,7 @@ static int bpf_object__sanitize_btf(struct bpf_obje=
ct *obj, struct btf *btf)
>         bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>         bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
>         bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DA=
TASEC);
> +       bool has_kind_bit_support =3D kernel_supports(obj, FEAT_BTF_TYPE_=
KIND_FLAG);
>
>         char name_gen_buff[32] =3D {0};
>         int enum64_placeholder_id =3D 0;
> @@ -3263,6 +3266,75 @@ static int bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *btf)
>                                 m->type =3D enum64_placeholder_id;
>                                 m->offset =3D 0;
>                         }
> +               } else if (!has_kind_bit_support &&
> +                          (btf_is_composite(t) || btf_is_fwd(t) || btf_i=
s_enum(t) || btf_is_enum64(t))) {

hm... kflag for structs, fwds, and enums I think were added at
different times, so they'd need to be detected separately, I think...

> +                       vlen =3D btf_vlen(t);
> +
> +                       /* type encoded with a kind flag */
> +                       if (btf_kflag(t))
> +                               continue;
> +
> +                   /* unset kind flag anyway */
> +                   t->info =3D BTF_INFO_ENC(btf_kind(t), 0, btf_vlen(t))=
;
> +
> +                   /* compisite types has a different bitfield processin=
g if kind flag is set */

indentation is off

typo: composite

> +                       if (btf_is_composite(t)) {
> +                               struct btf_member *members =3D btf_member=
s(t);
> +

no empty line here

> +                               struct btf_type *curr_type =3D NULL; /* c=
urrent member type */

curr -> cur, there is barely any "curr" usage in libbpf code base (one
straggler in ringbuf.c, sigh)

> +                               struct btf_type *new_type =3D NULL; /* re=
placement for current member type */
> +                               int curr_tid =3D 0;
> +                               int new_tid =3D 0;
> +                               __u32 *new_type_data =3D NULL;
> +                               int encoding =3D 0;
> +
> +                               for (j =3D 0; j < vlen; j++) {
> +                                       struct btf_member *member =3D &me=
mbers[j];
> +
> +                                        /* unwrap typedefs, volatiles, e=
tc. */
> +                                       curr_tid =3D btf__resolve_type(bt=
f, member->type);
> +
> +                                       if (curr_tid < 0) {
> +                                               pr_warn("Error resolving =
type [%d] for member %d of [%d]\n",
> +                                                               member->t=
ype, j, i);
> +                                               return curr_tid;
> +                                       }
> +
> +                                       curr_type =3D btf_type_by_id(btf,=
 curr_tid);
> +
> +                                       /* bitfields can be only int or e=
num values */
> +                                       if (!(btf_is_int(curr_type) || bt=
f_is_enum(curr_type)))
> +                                               continue;
> +
> +                                       encoding =3D btf_int_encoding(cur=
r_type);
> +
> +                                       /* enum value encodes integer sig=
ned/unsigned info in the kind flag */
> +                                       if (btf_is_enum(curr_type) && btf=
_kflag(curr_type))
> +                                               encoding =3D BTF_INT_SIGN=
ED;
> +
> +                                       /* create new integral type with =
the same info */
> +                                       snprintf(name_gen_buff, sizeof(na=
me_gen_buff), "__int_%d_%d", i, j);
> +                                       new_tid =3D btf__add_int(btf, nam=
e_gen_buff, curr_type->size, encoding);
> +
> +                                       if (new_tid < 0) {
> +                                               pr_warn("Error adding int=
eger type for a bitfield %d of [%d]\n", j, i);
> +                                               return new_tid;
> +                                       }
> +
> +                                       new_type =3D btf_type_by_id(btf, =
new_tid);
> +
> +                                       /* encode int in legacy way,
> +                                        * keep offset 0 and specify bit =
size as set in the member
> +                                        */
> +                                       new_type_data =3D (__u32 *)(new_t=
ype + 1);
> +                                       *new_type_data =3D BTF_INT_ENC(en=
coding, 0,
> +                                                                    BTF_=
MEMBER_BITFIELD_SIZE(member->offset));
> +
> +                                       /* old kernels looks only on offs=
et */
> +                                       member->offset =3D BTF_MEMBER_BIT=
_OFFSET(member->offset);
> +                                       member->type =3D new_tid;

this seems like a huge overkill, tbh... can't we do something
much-much simpler? e.g., just reset all offsets to their byte-aligned
equivalent? or reset them all to zero? Worst case, we can turn STRUCT
into UNION.

> +                               }
> +                       }
>                 }
>         }
>
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 76669c73dcd1..6369c5520fce 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -380,6 +380,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports kind flag */
> +       FEAT_BTF_TYPE_KIND_FLAG,
>         __FEAT_CNT,
>  };
>
> --
> 2.49.0
>
>

