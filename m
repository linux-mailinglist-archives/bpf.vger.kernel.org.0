Return-Path: <bpf+bounces-28754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334D8BD9C8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7484283883
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 03:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E34F887;
	Tue,  7 May 2024 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQzmIxxc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618344C9D
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053135; cv=none; b=aV98NtyPdTw/cgTxwIDFtrqs23WRbg20hit4n8kH4TUIzEjcglMyDFBJrAbR6PDA+hoTzOyP8elwUGWv/L+c8vzOFrHCW4IvGzEz9uFpsPGmkuYYZ81vfUW1qoWCK9jQW6w74OQ91wUKn9u4rzCkIhZb+8eomflXj/9ZZ0gaUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053135; c=relaxed/simple;
	bh=SzAJRUu4GiicvtSwSEYrr/CUGntQbMbSmfQTk4rvJ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyUGa6scaFIlaT4o51/OayDZkUyWbMyhL8h5l7BeGc4F6XDFrRPwJdpKuDM00aoaiOeU1x5axue/iwtfcoGCf437IJ2E+7OYZe8cCXk3pNaDY9Kwbr0G/U8skN3L6SCDXjfIhyFSL6Cur5t7SgHLVrdvhhAsciFWmD9hFT0mmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQzmIxxc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b43490e0e2so1760460a91.2
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715053133; x=1715657933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q39Yao29AsuqxH0YuaIcEjKCcBXsmkwsFGh1nOTv1cA=;
        b=IQzmIxxcTzx5rT267mGcy2ZPBkeNZjIH/CC2eLeh5FCHuV4unyQS+wY9QPn3lWY6cd
         5qdr9v9MCMcQxUiSvxEYuzrWqwsXmMZzzvSGG9T78p62wvSM467DT8xC2P72HKgeuEwB
         rCI236UKpCl6qOi/NVT9EdpofI4lqx1ARGyfikwUzyhisqUxXDBduPLH6jk4R/tre/bk
         cNAEzxCxpa978YF/Fz7MUkNgqiVhC7ol/1aP+/afOekVuDbm4rgYHj5ZCgJRNrynve6L
         j8nQr/OnwkNpvxdL8edT8rBakrgqbK8yM8MO9k0tDD9HAmUShBWQjWHNhB64Z9Y/6dd0
         PXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715053133; x=1715657933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q39Yao29AsuqxH0YuaIcEjKCcBXsmkwsFGh1nOTv1cA=;
        b=NVBgXFEDdvG5XOo9wzo66upMYAdWG1lkdEQxBMJH68ueu4K5/xarK+DtAaWDg6/2Mi
         zaefCgGkRK/zegdXLpVj11+XoB8LxSzMX2aghwd8NuoS7TZAVIFgvcAFUIcyM6Nugp+R
         uaqu8pxZ6R4LOtf6sEtAcweQS3f3KNEG4c5gTJgRHU2NY0CRvm/EibvMrMPI/epkJV0x
         g3rw7C8Yy5j7pnwqqdFpLH2rfTqmw20ZLYoE88S+CYN8HK4ycQSDwcNO54Ammq2o4iDI
         0nVbrfm4i2AMOseVURZ1ENuFDp9wsXN7O+iBSZnFSvUFnoVUCrxEMgSN1TrReQTBcPYe
         UjIw==
X-Forwarded-Encrypted: i=1; AJvYcCVHin7v8+HOG3H8M028ef9otY9FBReh7IAK/RfcFeyZv9x8lauCIStjB1axKeQzBqrv8szGzl2fGYu3Qi7/W04XkVoz
X-Gm-Message-State: AOJu0Yx+6ZmFrnT5NQO+t5gNsOcNqrqSNMfDt/1J9LIc3dsprQrRZyqF
	ZMJG62HgouSJXJ2s6KW1MUBqPU/RCw5+XAm2S2lbPrwygpnM1dNkLP+t1ImQowDX9HKjl+M3wOU
	9p5EnN8AV3lR6wRMrwa4chLuUN+Y=
X-Google-Smtp-Source: AGHT+IEzDzOkhLZlozzA91R0ro+AgmVcqT+AYaxcS8B3b4QKUguIobqAUix+1T8nEuryxnZfWKi6fOsagOrNTWlyiyI=
X-Received: by 2002:a17:90a:f40e:b0:2a6:4293:f88c with SMTP id
 ch14-20020a17090af40e00b002a64293f88cmr9693961pjb.16.1715053133551; Mon, 06
 May 2024 20:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-2-laoar.shao@gmail.com>
In-Reply-To: <20240506033353.28505-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 May 2024 20:38:41 -0700
Message-ID: <CAEf4Bzb2xZt7EUQDicty6b6GtmuvwrFnx=6L9p0Qrijg1DcsGQ@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 1/2] bpf: Add bits iterator
To: Yafang Shao <laoar.shao@gmail.com>, David Vernet <void@manifault.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
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
>  kernel/bpf/helpers.c | 140 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2a69a9a36c0f..83b2a02f795f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2744,6 +2744,143 @@ __bpf_kfunc void bpf_preempt_enable(void)
>         preempt_enable();
>  }
>
> +struct bpf_iter_bits {
> +       __u64 __opaque[2];
> +} __aligned(8);
> +
> +struct bpf_iter_bits_kern {
> +       union {
> +               unsigned long *bits;
> +               unsigned long bits_copy;
> +       };
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

typo: pointer

> + * @nr_bits: The number of bits to be iterated over. Due to the limitati=
on of
> + * memalloc, it can't greater than (4096 * 8).

typo: can't be greater

> + *
> + * This function initializes a new bpf_iter_bits structure for iterating=
 over
> + * a memory area which is specified by the @unsafe_ptr__ign and @nr_bits=
. It
> + * copy the data of the memory area to the newly created bpf_iter_bits @=
it for

s/copy/copies/

> + * subsequent iteration operations.
> + *
> + * On success, 0 is returned. On failure, ERR is returned.
> + */
> +__bpf_kfunc int
> +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,=
 u32 nr_bits)
> +{
> +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> +       u32 words =3D BITS_TO_LONGS(nr_bits);
> +       u32 size =3D BITS_TO_BYTES(nr_bits);
> +       u32 left, offset;
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
> +       kit->nr_bits =3D 0;
> +       kit->bits_copy =3D 0;
> +       /* Optimization for u64/u32 mask */
> +       if (nr_bits <=3D 64) {
> +               /* For big-endian, we must calculate the offset */
> +               offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - size :=
 0;

S390 isn't the only big-endian architecture, it's wrong to hard-code just S=
390

there is __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__ check throughout the
kernel to do this detection

> +
> +               err =3D bpf_probe_read_kernel_common(((char *)&kit->bits_=
copy) + offset,
> +                                                  size, unsafe_ptr__ign)=
;
> +               if (err)
> +                       return -EFAULT;

I'd rewrite the above to something like (not tested, but should give
the right idea):

long bits =3D 0;

err =3D bpf_probe_read_kernel_common(&bits, size, unsafe_ptr__ign);
if (err)
    return -EFAULT;

#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
bits =3D __swab64(bits);
#endif

/* deal with bit mask of weird size, ensuring upper bits are zero */
bits <<=3D 64 - nr_bits;
bits >>=3D 64 - nr_bits;

kit->bits_copy =3D bits;


This should take care of both big-endianness, and non-multiple-of-8
sized bitmasks (I think, we need tests).

pw-bot: cr


> +
> +               kit->nr_bits =3D nr_bits;
> +               kit->bit =3D -1;
> +               return 0;
> +       }
> +
> +       /* Fallback to memalloc */
> +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> +       if (!kit->bits)
> +               return -ENOMEM;
> +
> +       err =3D bpf_probe_read_kernel_common(kit->bits, words * sizeof(u6=
4), unsafe_ptr__ign);
> +       if (err) {
> +               bpf_mem_free(&bpf_global_ma, kit->bits);
> +               return err;
> +       }
> +
> +       /* long-aligned */
> +       left =3D size & (sizeof(u64) - 1);
> +       if (!left)
> +               goto out;
> +
> +       offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - left : 0;
> +       err =3D bpf_probe_read_kernel_common((char *)(kit->bits + words -=
 1) + offset, left,
> +                                          unsafe_ptr__ign + (words - 1) =
* sizeof(u64));
> +       if (err) {
> +               bpf_mem_free(&bpf_global_ma, kit->bits);
> +               return err;
> +       }

tbh, I'm not sure what's the desired behavior here is. David (cc'ed),
you were dealing with cpumasks, how is the bit mask specified there?
Is it considered to be an long[] array or byte[] array? And how is
that working on big-endian, because I think it makes a difference?
Please take a look, thanks.

> +
> +out:
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
> +       u32 nr_bits =3D kit->nr_bits;
> +       const unsigned long *bits;
> +       int bit;
> +
> +       if (nr_bits =3D=3D 0)
> +               return NULL;
> +
> +       bits =3D nr_bits <=3D 64 ? &kit->bits_copy : kit->bits;
> +       bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
> +       if (bit >=3D nr_bits) {
> +               kit->nr_bits =3D 0;
> +               return NULL;
> +       }
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
> +       if (kit->nr_bits <=3D 64)
> +               return;
> +       bpf_mem_free(&bpf_global_ma, kit->bits);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -2826,6 +2963,9 @@ BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
>  BTF_ID_FLAGS(func, bpf_wq_start)
>  BTF_ID_FLAGS(func, bpf_preempt_disable)
>  BTF_ID_FLAGS(func, bpf_preempt_enable)
> +BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.30.1 (Apple Git-130)
>

