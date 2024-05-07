Return-Path: <bpf+bounces-28828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA18BE462
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7510F1F2857D
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5E15EFB7;
	Tue,  7 May 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6gzCrwY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084E15E5CA
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088780; cv=none; b=syGQkZe83+VbZ7xcY0e74XUycxrwfksPXJlhFLDyNoDrcM3SP/LPPr3Ls0G5goe8sXv9klP/0zN2NQ774AtWog2aa1MXiPdMYyYUZ8Yhx4aFpOj1EA2gTYqcSgT5nccYJ28VWZTTkNSXbM9e74StTjZeXfZVVYlMz4yc310q4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088780; c=relaxed/simple;
	bh=8povReG7gJj/4QhkrzM3S9ut9lGf4FtHhstuwAiGfvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bn8n0WfJcbMzE51Si5XgcpOVvzAPO3plRco7ACLUFGSXzh0Hgp4vSTEnkG3MJqxikUvcpNSCDESChPnoKt8KkIG/wCHnzO+EaFbCkMrlZcRjjU/b2p5B9pCVFYb9qRoi/6ubiomgQvf1TDJNuR7SK+fA+zlBy1quADVzePGvt0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6gzCrwY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a0ce3e823fso19462336d6.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715088778; x=1715693578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gFMfjCeddS+J1g/Ua3zCZ1QKRrwRNm5sLeDtsIcTtE=;
        b=A6gzCrwYbqO/QHj3S8O0ONuhzcvDRTxTplUTlDav2+3p6YZ4Tq+GSYK0CitB/arlCy
         fjo5RVFmm9yLvT4cxrUCy/6NdPxdT2w+CdAxCupjUzuCUTpYDBRmlCPkTsKwvfGeFwec
         irCfXF0VlWrHiaACzwzoIYTjMdEDA9yNbs46jET9KeaKCGJuPCJZLuOrwi6HLFRJAqOK
         kc+MCVQw8jLx2VhYGNIiV6TKInvN8KU23htnwJGRGAtDVFo6hrRvySqIi+HU1ckohKVu
         DnJ95xqUhio/jPwvzL1Lf22UpM0QnyDkHHxb9psdQyiivJPQamnWYVGidqvPtuMfcVZT
         YpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088778; x=1715693578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gFMfjCeddS+J1g/Ua3zCZ1QKRrwRNm5sLeDtsIcTtE=;
        b=EKIQCPKLsqGLwzvbL4eCKEN/iTdMe+OWzwqlQ2b80jJoa7NmeO8qHiRKJaPARKTA9b
         /i9Ug0g1Ejc/ob4gAQzP1DW+WIIxWUFOH+TnLimnyk/K5BbibYGo499FBkn1eVM9rmex
         3691U+JLL3BLQkxsTZD2kod07yidQZzuq9TmmVyt32heDJGw3Gmdw9ML+ZOHuIBfsB8H
         rsII+t1EvB5Y2PKAiO8q/JLNlasZR3YuH3UuvsJk/EHSTk2i2lpNqncq0+XpeCltWdLt
         mxZC3qvCnp26RXmyEuQgmgEg6m3Skt6pWoBOGTQyVYFv0NnYkB3+C6zdz5PS7NC4Mhgo
         VExg==
X-Forwarded-Encrypted: i=1; AJvYcCXDv1CaGaYfvVaJz46z15eUxh3nQ3uZWsXUHkyPWh+7XEKK3StvWbWRn8r+Jfw9PQxT/Nic0Lb8jAyt70vLuRmnlAUU
X-Gm-Message-State: AOJu0Yzktw/HsdpJ1f0py712ElV8IpYGYIKALbjJOr2ivzTdVM5m3QLr
	6SHM0utHmlGRwZAe7l/ITwDDIwrS/DlVxiyM9qkepv0fbHKb16W5/QH13sbhYapt+UOmufh1ynj
	yL5X9wbFzFiH4Y6eJioIgFAx2VfE=
X-Google-Smtp-Source: AGHT+IG2xGhDMFp+Hdv5iBhDJfDnAnQgnaLUV6ewtgZUT4Vht67rtPhSFuKJxHdyZoWaV0IyHej6qHIB1niP5K5NUBg=
X-Received: by 2002:ad4:5c42:0:b0:6a0:a55b:9539 with SMTP id
 a2-20020ad45c42000000b006a0a55b9539mr17287281qva.60.1715088777767; Tue, 07
 May 2024 06:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-2-laoar.shao@gmail.com>
 <CAEf4Bzb2xZt7EUQDicty6b6GtmuvwrFnx=6L9p0Qrijg1DcsGQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb2xZt7EUQDicty6b6GtmuvwrFnx=6L9p0Qrijg1DcsGQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 May 2024 21:32:20 +0800
Message-ID: <CALOAHbBg4GhEe7aozfsGATk2wWNzv1u76inb_AWHkWHvP0yufw@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 1/2] bpf: Add bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Vernet <void@manifault.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:38=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Add three new kfuncs for the bits iterator:
> > - bpf_iter_bits_new
> >   Initialize a new bits iterator for a given memory area. Due to the
> >   limitation of bpf memalloc, the max number of bits that can be iterat=
ed
> >   over is limited to (4096 * 8).
> > - bpf_iter_bits_next
> >   Get the next bit in a bpf_iter_bits
> > - bpf_iter_bits_destroy
> >   Destroy a bpf_iter_bits
> >
> > The bits iterator facilitates the iteration of the bits of a memory are=
a,
> > such as cpumask. It can be used in any context and on any address.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 140 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2a69a9a36c0f..83b2a02f795f 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2744,6 +2744,143 @@ __bpf_kfunc void bpf_preempt_enable(void)
> >         preempt_enable();
> >  }
> >
> > +struct bpf_iter_bits {
> > +       __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_bits_kern {
> > +       union {
> > +               unsigned long *bits;
> > +               unsigned long bits_copy;
> > +       };
> > +       u32 nr_bits;
> > +       int bit;
> > +} __aligned(8);
> > +
> > +/**
> > + * bpf_iter_bits_new() - Initialize a new bits iterator for a given me=
mory area
> > + * @it: The new bpf_iter_bits to be created
> > + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated=
 over
>
> typo: pointer

Thanks for the fix and the other fixes.

>
> > + * @nr_bits: The number of bits to be iterated over. Due to the limita=
tion of
> > + * memalloc, it can't greater than (4096 * 8).
>
> typo: can't be greater
>
> > + *
> > + * This function initializes a new bpf_iter_bits structure for iterati=
ng over
> > + * a memory area which is specified by the @unsafe_ptr__ign and @nr_bi=
ts. It
> > + * copy the data of the memory area to the newly created bpf_iter_bits=
 @it for
>
> s/copy/copies/
>
> > + * subsequent iteration operations.
> > + *
> > + * On success, 0 is returned. On failure, ERR is returned.
> > + */
> > +__bpf_kfunc int
> > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ig=
n, u32 nr_bits)
> > +{
> > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > +       u32 words =3D BITS_TO_LONGS(nr_bits);
> > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > +       u32 left, offset;
> > +       int err;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(stru=
ct bpf_iter_bits));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> > +                    __alignof__(struct bpf_iter_bits));
> > +
> > +       if (!unsafe_ptr__ign || !nr_bits) {
> > +               kit->bits =3D NULL;
> > +               return -EINVAL;
> > +       }
> > +
> > +       kit->nr_bits =3D 0;
> > +       kit->bits_copy =3D 0;
> > +       /* Optimization for u64/u32 mask */
> > +       if (nr_bits <=3D 64) {
> > +               /* For big-endian, we must calculate the offset */
> > +               offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - size=
 : 0;
>
> S390 isn't the only big-endian architecture, it's wrong to hard-code just=
 S390
>
> there is __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__ check throughout the
> kernel to do this detection

I missed that. will check it.

>
> > +
> > +               err =3D bpf_probe_read_kernel_common(((char *)&kit->bit=
s_copy) + offset,
> > +                                                  size, unsafe_ptr__ig=
n);
> > +               if (err)
> > +                       return -EFAULT;
>
> I'd rewrite the above to something like (not tested, but should give
> the right idea):
>
> long bits =3D 0;
>
> err =3D bpf_probe_read_kernel_common(&bits, size, unsafe_ptr__ign);
> if (err)
>     return -EFAULT;
>
> #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> bits =3D __swab64(bits);
> #endif
>
> /* deal with bit mask of weird size, ensuring upper bits are zero */
> bits <<=3D 64 - nr_bits;
> bits >>=3D 64 - nr_bits;
>
> kit->bits_copy =3D bits;
>
>
> This should take care of both big-endianness, and non-multiple-of-8
> sized bitmasks (I think, we need tests).

looks good, will change it.

>
> pw-bot: cr
>
>
> > +
> > +               kit->nr_bits =3D nr_bits;
> > +               kit->bit =3D -1;
> > +               return 0;
> > +       }
> > +
> > +       /* Fallback to memalloc */
> > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > +       if (!kit->bits)
> > +               return -ENOMEM;
> > +
> > +       err =3D bpf_probe_read_kernel_common(kit->bits, words * sizeof(=
u64), unsafe_ptr__ign);
> > +       if (err) {
> > +               bpf_mem_free(&bpf_global_ma, kit->bits);
> > +               return err;
> > +       }
> > +
> > +       /* long-aligned */
> > +       left =3D size & (sizeof(u64) - 1);
> > +       if (!left)
> > +               goto out;
> > +
> > +       offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - left : 0;
> > +       err =3D bpf_probe_read_kernel_common((char *)(kit->bits + words=
 - 1) + offset, left,
> > +                                          unsafe_ptr__ign + (words - 1=
) * sizeof(u64));
> > +       if (err) {
> > +               bpf_mem_free(&bpf_global_ma, kit->bits);
> > +               return err;
> > +       }
>
> tbh, I'm not sure what's the desired behavior here is. David (cc'ed),
> you were dealing with cpumasks, how is the bit mask specified there?
> Is it considered to be an long[] array or byte[] array? And how is
> that working on big-endian, because I think it makes a difference?
> Please take a look, thanks.

The function find_next_bit() requires the pointer to be of type
"unsigned long *", hence, we must ensure consistency by converting it
here as well. As cpumask represents a bitmap and is always of type
"unsigned long *", it remains unaffected by endianness considerations.

>
> > +
> > +out:
> > +       kit->nr_bits =3D nr_bits;
> > +       kit->bit =3D -1;
> > +       return 0;
> > +}
> > +
> > +/**
> > + * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
> > + * @it: The bpf_iter_bits to be checked
> > + *
> > + * This function returns a pointer to a number representing the value =
of the
> > + * next bit in the bits.
> > + *
> > + * If there are no further bit available, it returns NULL.
> > + */
> > +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> > +{
> > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > +       u32 nr_bits =3D kit->nr_bits;
> > +       const unsigned long *bits;
> > +       int bit;
> > +
> > +       if (nr_bits =3D=3D 0)
> > +               return NULL;
> > +
> > +       bits =3D nr_bits <=3D 64 ? &kit->bits_copy : kit->bits;
> > +       bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
> > +       if (bit >=3D nr_bits) {
> > +               kit->nr_bits =3D 0;
> > +               return NULL;
> > +       }
> > +
> > +       kit->bit =3D bit;
> > +       return &kit->bit;
> > +}
> > +
> > +/**
> > + * bpf_iter_bits_destroy() - Destroy a bpf_iter_bits
> > + * @it: The bpf_iter_bits to be destroyed
> > + *
> > + * Destroy the resource associated with the bpf_iter_bits.
> > + */
> > +__bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
> > +{
> > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > +
> > +       if (kit->nr_bits <=3D 64)
> > +               return;
> > +       bpf_mem_free(&bpf_global_ma, kit->bits);
> > +}
> > +
> >  __bpf_kfunc_end_defs();
> >
> >  BTF_KFUNCS_START(generic_btf_ids)
> > @@ -2826,6 +2963,9 @@ BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> >  BTF_ID_FLAGS(func, bpf_wq_start)
> >  BTF_ID_FLAGS(func, bpf_preempt_disable)
> >  BTF_ID_FLAGS(func, bpf_preempt_enable)
> > +BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> > +BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >  BTF_KFUNCS_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > --
> > 2.30.1 (Apple Git-130)
> >



--=20
Regards
Yafang

