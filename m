Return-Path: <bpf+bounces-61320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521C1AE5584
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8F24A2D67
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F66229B36;
	Mon, 23 Jun 2025 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjBI7lV6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920721FF2B
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716634; cv=none; b=JEoW7iHHgzCTZTzr2brGXjg5+hAd3tke92KiaHOGTJtzN0sr9g0iKeeIFtzhYfk1/40qT73fPYnoMvB1jpusWuLm9OOQOUVzYF1d3L7ii7nb6cjvldofutrXO72z4GDMvSe/KvGVWJGFT6OHFNPbTLgHTxrMRix8GZ7WjhAjG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716634; c=relaxed/simple;
	bh=+17byxG599vib2rHVD/toQtEM3gv/jtC+zlvWLRjm7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cp7X0wy2ul46EWkjweLlpNapD4Qi2BIGE+YM3sxsXDxGh5SZqiiiAF9HSZP7fAK074iiShBajkgyDTUijmKslY90FZbYXjZnQz+OYLMlxhX6GnDtatbW8JdjGkw9LXz3HAPOVmt0I/yZTLExskqhfdF2JT7Z7NjxWklPIKjbGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjBI7lV6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237311f5a54so46524575ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750716631; x=1751321431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWYb62ZAznK2fZJN3XTJfIonxm09kQ2v9WQutmOpMDM=;
        b=bjBI7lV6zPgCt/XO6L6jpjIqDNmYHdu5k/ktNcJam5tHKOJMC/QGCiiSHJQRQwMORb
         P+x7jvMP6Mpl9B430MeCsAZIdMQBnZUTsQ351Zv2ToCTCbZROATolv+M3mbTx9n3UBhm
         3imCdjWgPUT2iH/ilskb+OanY5k/iVsyXtyFOcQUDasoeojqXUzXjSSNGQ4X4QMKEBMM
         MYeigBpzx3e4sCjcv2AtIrytVpDbTpqFuz3laQrQD6Fagveb15w/Zyz9SbRW/GjP8lQL
         dQJ2B9PuhXButqRTacmzi5cMJi/zNE64Au2BvVk512owBMfDvQ6aoFiXbBDatYyrVdM3
         AmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750716631; x=1751321431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWYb62ZAznK2fZJN3XTJfIonxm09kQ2v9WQutmOpMDM=;
        b=d2WdlvP9U7i8afUGPgZCNPoyZmf7soaYO7g2jo9A8bOk70kR49uGfk6+Yu4bOM2rtz
         W6FgyU8tONsADDNm9h1qloa1zXhxp9dmxdAmCORO9B3Bw9QdsZrtECZi122t11aW0Jnx
         tELpXZqis6u+CGS1M3MjHHmi2rCzlcJ5AdSkUTgON27Dns2SiL3lEHt17kmJW5TqWhnh
         tiHRmCNGiAvXk4TfWpPvEpee8Iyc5qMmN70xEeuM8C7jLld4pJyDzFxoHi3rZdOYRj1N
         e5g6K75IJcVyattRSwlvw34BCTVpnw7b9eXEqODoDKSr0qAajoeqeXRzxNp9TkuM6FA0
         vdew==
X-Gm-Message-State: AOJu0Ywyrm0xjiUetHvOCfpBzoDf3Dje4dKNoy2T9844rUW7ZqWSLJVY
	Kho19k+6WslllHBFlJy1cRE7sI5PeRfFtxD3gyAxdoiN3r1peBebwRU5ocm/oLIhPFCOz2AeAdc
	ZYYcZMtJAEW3eDO+kvN4eEOF0cs6yXBQ=
X-Gm-Gg: ASbGncudEPGsOgGdrI8hHo7Pyk5TpaMjVL0ebSFG64rL5KKbe82uF82Q7TNe1CR6KWK
	/I50O479p2wBJRu+aRbwqp46GOC+M50R6XE7rrd/XW2ndegG4KYqXzDjGk/WVcqSwQRuW+5MG/n
	Xdad3oHraUeUrn8n5zyjNwS4YxbbalkBSOvnfEHQJ9svdd0zqHC4WfKN/c5s8=
X-Google-Smtp-Source: AGHT+IEP0z6NIC8YaPB/E6cAJc4HoT2n5BjkeRqUq9Jv88c/OtmHzBhQ2MsWesNx9xsZcsjLgDyNk4wwnk6mEX2FOn4=
X-Received: by 2002:a17:903:2a87:b0:234:9375:e081 with SMTP id
 d9443c01a7336-237d9b8ccdbmr205059455ad.42.1750716631443; Mon, 23 Jun 2025
 15:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com> <20250618203903.539270-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250618203903.539270-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Jun 2025 15:10:19 -0700
X-Gm-Features: AX0GCFu8sjos4xyOYOWwtU1MyQlws4WRKmwOxfC0nxS80KifN4BhHVE71y4HxCk
Message-ID: <CAEf4BzY8zDf4oZL=manmc_KsZpL8meC_m1jvp4EZ8MKnpkvFgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: support array presets in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:39=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Implement support for presetting values for array elements in veristat.
> For example:
> ```
> sudo ./veristat set_global_vars.bpf.o -G "arr[3] =3D 1"
> ```
> Arrays of structures and structure of arrays work, but each individual
> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 226 ++++++++++++++++++++-----
>  1 file changed, 180 insertions(+), 46 deletions(-)
>

[...]

> +static int resolve_rvalue(struct btf *btf, const struct rvalue *rvalue, =
long long *result)
> +{
> +       int err =3D 0;
> +
> +       switch (rvalue->type) {
> +       case INTEGRAL:
> +               *result =3D rvalue->ivalue;

return 0;

> +               break;
> +       case ENUMERATOR:
> +               err =3D find_enum_value(btf, rvalue->svalue, result);
> +               if (err)
> +                       fprintf(stderr, "Can't resolve enum value %s\n", =
rvalue->svalue);

if (err) {
    fprintf(...);
    return err;
}

return 0;

?

> +               break;

default: fprintf("unknown blah"); return -EOPNOTSUPP;


I think I had a similar argument with Eduard before, so I'll explain
my logic here again. Whenever you have some branching in your code and
you know that branch's processing is effectively done and the only
thing left is to return success/failure signal, *do return early* and
explicitly ASAP (unless there is non-trivial clean up for error path,
in which case not duplicating and spreading clean up logic outweighs
the simplicity of early return code). Otherwise it takes *unnecessary*
extra mental effort to trace through the rest of the code to make sure
there is no extra common post-processing logic after that
branch/switch/for loop.

So if we know the INTEGRAL case is a success, then have `return 0;`
right there, don't make anyone read through the rest of the function
just to make sure we don't do anything extra.

> +       }
> +       return err;
> +}
> +
> +/* Returns number of consumed atoms from preset, negative error if faile=
d */
> +static int adjust_var_secinfo_array(struct btf *btf, int tid, struct var=
_preset *preset,
> +                                   int atom_idx, struct btf_var_secinfo =
*sinfo)
> +{
> +       struct btf_array *barr;
> +       int i =3D atom_idx, err;
> +       const struct btf_type *t;
> +       long long off =3D 0, idx;
> +
> +       if (atom_idx < 1) /* Array index can't be the first atom */

can atom_idx be -1 or negative? If not, then do `if (atom_idx =3D=3D 0)`.
It's another small mental overhead that we can easily avoid, and so we
should.

> +               return -EINVAL;
> +
> +       tid =3D btf__resolve_type(btf, tid);
> +       t =3D btf__type_by_id(btf, tid);
> +       if (!btf_is_array(t)) {
> +               fprintf(stderr, "Array index is not expected for %s\n",
> +                       preset->atoms[atom_idx - 1].name);
> +               return -EINVAL;
> +       }

[...]

> @@ -1815,26 +1938,29 @@ const int btf_find_member(const struct btf *btf,
>  static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
>                               struct btf_var_secinfo *sinfo, struct var_p=
reset *preset)
>  {
> -       const struct btf_type *base_type, *member_type;
> -       int err, member_tid, i;
> -       __u32 member_offset =3D 0;
> -
> -       base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type=
));
> -
> -       for (i =3D 1; i < preset->atom_count; ++i) {
> -               err =3D btf_find_member(btf, base_type, 0, preset->atoms[=
i].name,
> -                                     &member_tid, &member_offset);
> -               if (err) {
> -                       fprintf(stderr, "Could not find member %s for var=
iable %s\n",
> -                               preset->atoms[i].name, preset->atoms[i - =
1].name);
> -                       return err;
> +       const struct btf_type *base_type;
> +       int err, i =3D 1, n;
> +       int tid;
> +
> +       tid =3D btf__resolve_type(btf, t->type);
> +       base_type =3D btf__type_by_id(btf, tid);
> +
> +       while (i < preset->atom_count) {
> +               if (preset->atoms[i].type =3D=3D ARRAY_INDEX) {
> +                       n =3D adjust_var_secinfo_array(btf, tid, preset, =
i, sinfo);
> +                       if (n < 0)
> +                               return n;
> +                       i +=3D n;
> +               } else {
> +                       err =3D btf_find_member(btf, base_type, 0, preset=
->atoms[i].name, sinfo);
> +                       if (err)
> +                               return err;
> +                       i++;
>                 }
> -               member_type =3D btf__type_by_id(btf, member_tid);
> -               sinfo->offset +=3D member_offset / 8;
> -               sinfo->size =3D member_type->size;
> -               sinfo->type =3D member_tid;
> -               base_type =3D member_type;
> +               base_type =3D btf__type_by_id(btf, sinfo->type);
> +               tid =3D sinfo->type;
>         }
> +
>         return 0;
>  }

Is there a good reason to have adjust_var_secinfo() separate from
adjust_var_secinfo_array(). I won't know if I didn't miss anything
non-obvious, but in my mind this whole adjust_var_sec_info() should
look roughly like this:

cur_type =3D /* resolve from original var */
cur_off =3D 0;

for (i =3D 0; i < preset->atom_count; i++) {
    if (preset->atoms[i].type =3D=3D ARRAY_INDEX) {
        /* a) error checking: cur_type should be array */
        /* b) resolve index (if it's enum)
        /* c) error checking: index should be within bounds of
cur_type (which is ARRAY)
        /* d) adjust cur_off +=3D cur_type's elem_size * index_value
        /* e) cur_type =3D btf__resolve_type(cur_type->type) */
    } else {
        /* a) error checking: cur_type should be struct/union */
        /* b) find field by name with btf_find_member */
        /* c) cur_off +=3D member_offset */
        /* d) cur_type =3D btf__resolve_type(field->type) */
    }
}

It seems inelegant that we have an outer loop over FIELD references
(one at a time), but for ARRAY_INDEX we do N items skipping. Why? We
have a set of "instructions", just execute them one at a time, and
keep track of the current type and current offset we are at.

Is there anything I am missing that would prevent this simple and more
uniform approach?

[...]

