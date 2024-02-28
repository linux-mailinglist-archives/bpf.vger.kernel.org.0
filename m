Return-Path: <bpf+bounces-22830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED9686A4FA
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913A41C22ED3
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545D2F22;
	Wed, 28 Feb 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLCIfV7e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90934405
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 01:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083476; cv=none; b=T5Eog4NzGS0pOvrhiOZ3CJ7AtC6vB+Ulzhae9a87fRPI714ZFYJtXMS7pa6/J6E7q7F0am5QuIGbMBjcFzMP46CEK0WqJlYvBK8DBIka39m8OIAs2DApBcp61RE9g16EJq+0zMy1EQX+WMFEoQY/xvfeVXCrlAj89iSvXSKuio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083476; c=relaxed/simple;
	bh=pMvvKE7FKvNA2i6vP7hkmh4Tlac6vp9ZxpaPpJX/he0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPuumLHUyvHhGY/SLuOBHCkGQHsop5ydEOlr0ykcKyj+0rR7I7VayMDoJVaiYcZdHDLmlo0Qh9lB02588OuQlQkUb4z+1qz2S8jbEnuYZq/ScXny/JMdoO7SJSmamlgZIWf6afy/9dqISFyqm4UafGg9XleNDHd+wWDpyfUdoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLCIfV7e; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so313366b3a.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 17:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709083474; x=1709688274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hPsJB1cuYhvwIOeEqMPR/afc44gQjU1H3QZ5lR2vN8=;
        b=SLCIfV7ef2FXR+8h1uWdQy/3VZpsOfygPDQKfPRRTLb+kldQeCuIPXaqcaQxxQpekR
         UnEDPpxMku3H/cC6UJvOFFRcvZCvnL7HgZgmi8n6OhUIe12QRGqtnTiCVvHLWXk2Ymqi
         jGi4+HFmwrW2HdAGbPw9j89v7F5MH1yKe/oR4gkqvRcLXooXVheEk1CkJDKOph8HUdC/
         DWlaQJ14dW462J7lpzuxdasprRldV/mf/MyIAJwPfmwKRXTiC6E2zMDDBcNufCLjdIcD
         8Ny9S1NBIA0zhznIL5LgWJ9xYZD1H2t51lRQHE8WUb42fMzrI+jBJMXaHtCf46Xn2EiK
         n1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083474; x=1709688274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hPsJB1cuYhvwIOeEqMPR/afc44gQjU1H3QZ5lR2vN8=;
        b=hxmpvfhVrpG8DKuT/JDTS0khYfXpqA9MdCDRFXoHK8sHK3HqkTUnAkdKYcHYU/wtP4
         AEl2VbDVfuEwrhh2114dnv8ulL14cHPHdIYb3JCsYdfkBeTyjVfckGDuBJGKGVZs+YpV
         EnoNTspaEluUpbIQMKwzTKhegYk9xMrzcFDh0V7fJt+LBc9k1UYfTWpiDeu/UX8gGB9D
         NNq3jBRo3fSiqnEyTY/ctMOPcD919yKxOiPFqsdVEkZILuuVOO65S9GcbtkrE3XZC6Rw
         suriMn5TdfkP1ldzVz2FOP0eaaTjiAxKmVUt8Tj9wXwpdrWwcjV0fUhjYtfJ+EX+almn
         POmA==
X-Forwarded-Encrypted: i=1; AJvYcCXYZWEbroj/WidSpo7ydMouOLmxvMGj1HsS3ZqcbB0mLwMG09OT4/dhGsBj9eYMbfzOQrmnXWjiA5YQDnfDv+42j9Un
X-Gm-Message-State: AOJu0YxtA2n26B+C+3722NbUwXDIQy1ZHniRjdfTFC/cPzSb0zC5U5kZ
	RT5qbEt4UJ08+IZoeeE6VycIABDCVpWJ49DJ+R2jUHibQga3VcjakgIk3zuhNUHFnjt9HP6TViM
	1D/9PzBrjJXpRyprpWXqKhEsXaII=
X-Google-Smtp-Source: AGHT+IFPjJKQDwpM5/nvaJqZ8PDb6ymdiFQ/zZfY0b/9ZHOgYWkOwdWSGKmWEMzmQCbnTJnfAEaol1nwZnH+sPYO5Lc=
X-Received: by 2002:a05:6a20:94c5:b0:1a0:fd3e:5339 with SMTP id
 ht5-20020a056a2094c500b001a0fd3e5339mr3871960pzb.10.1709083474237; Tue, 27
 Feb 2024 17:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225100637.48394-1-laoar.shao@gmail.com> <20240225100637.48394-2-laoar.shao@gmail.com>
In-Reply-To: <20240225100637.48394-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Feb 2024 17:24:22 -0800
Message-ID: <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add three new kfuncs for the bits iterator:
> - bpf_iter_bits_new
>   Initialize a new bits iterator for a given memory area. Due to the
>   limitation of bpf memalloc, the max number of bits that can be iterated
>   over is limited to (4096 * 8).
> - bpf_iter_bits_next
>   Get the next bit in a bpf_iter_bits
> - bpf_iter_bits_destroy
>   Destroy a bpf_iter_bits
>
> The bits iterator facilitates the iteration of the bits of a memory area,
> such as cpumask. It can be used in any context and on any address.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 93edf730d288..052f63891834 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>         WARN(1, "A call to BPF exception callback should never return\n")=
;
>  }
>
> +struct bpf_iter_bits {
> +       __u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_bits_kern {
> +       unsigned long *bits;
> +       u32 nr_bits;
> +       int bit;
> +} __aligned(8);
> +
> +/**
> + * bpf_iter_bits_new() - Initialize a new bits iterator for a given memo=
ry area
> + * @it: The new bpf_iter_bits to be created
> + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated o=
ver
> + * @nr_bits: The number of bits to be iterated over. Due to the limitati=
on of
> + * memalloc, it can't greater than (4096 * 8).
> + *
> + * This function initializes a new bpf_iter_bits structure for iterating=
 over
> + * a memory area which is specified by the @unsafe_ptr__ign and @nr_bits=
. It
> + * copy the data of the memory area to the newly created bpf_iter_bits @=
it for
> + * subsequent iteration operations.
> + *
> + * On success, 0 is returned. On failure, ERR is returned.
> + */
> +__bpf_kfunc int
> +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,=
 u32 nr_bits)
> +{
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +       u32 size =3D BITS_TO_BYTES(nr_bits);
> +       int err;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(struct=
 bpf_iter_bits));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> +                    __alignof__(struct bpf_iter_bits));
> +
> +       if (!unsafe_ptr__ign || !nr_bits) {
> +               kit->bits =3D NULL;
> +               return -EINVAL;
> +       }
> +
> +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> +       if (!kit->bits)
> +               return -ENOMEM;

it's probably going to be a pretty common case to do bits iteration
for nr_bits<=3D64, right? So as an optimization, instead of doing
bpf_mem_alloc() for this case, you can just copy up to 8 bytes and
store it in a union of `unsigned long *bits` and `unsigned long
bits_copy`. As a performance optimization (and to reduce dependency on
memory allocation). WDYT?

> +
> +       err =3D bpf_probe_read_kernel_common(kit->bits, size, unsafe_ptr_=
_ign);
> +       if (err) {
> +               bpf_mem_free(&bpf_global_ma, kit->bits);
> +               kit->bits =3D NULL;
> +               return err;
> +       }
> +
> +       kit->nr_bits =3D nr_bits;
> +       kit->bit =3D -1;
> +       return 0;
> +}
> +
> +/**
> + * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
> + * @it: The bpf_iter_bits to be checked
> + *
> + * This function returns a pointer to a number representing the value of=
 the
> + * next bit in the bits.
> + *
> + * If there are no further bit available, it returns NULL.
> + */
> +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> +{
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +       const unsigned long *bits =3D kit->bits;
> +       int bit;
> +
> +       if (!bits)
> +               return NULL;
> +
> +       bit =3D find_next_bit(bits, kit->nr_bits, kit->bit + 1);
> +       if (bit >=3D kit->nr_bits)
> +               return NULL;
> +
> +       kit->bit =3D bit;
> +       return &kit->bit;
> +}
> +
> +/**
> + * bpf_iter_bits_destroy() - Destroy a bpf_iter_bits
> + * @it: The bpf_iter_bits to be destroyed
> + *
> + * Destroy the resource associated with the bpf_iter_bits.
> + */
> +__bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
> +{
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +
> +       if (!kit->bits)
> +               return;
> +       bpf_mem_free(&bpf_global_ma, kit->bits);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -2618,6 +2715,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.39.1
>

