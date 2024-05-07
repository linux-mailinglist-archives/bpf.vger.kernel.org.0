Return-Path: <bpf+bounces-28902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D98BEA19
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C67C1C216BB
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92142D796;
	Tue,  7 May 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jakanab7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D44B672
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101765; cv=none; b=KE7OtoR+dZJxQN8kw1yGZZOo4Y2pik1PPKHDoAM7ONbwkL5sIHycBlgpndwOYT17IgFHLBlz7CfphR/2EaGzN03ggN7pDuQRsb9q5o5dLrR2B8CHv9FmQsp7W+ZJ666kZfaecUtmpbpNpXdSxq5G1D4r5xNy/wUrIT/V6H+p/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101765; c=relaxed/simple;
	bh=Wc0ABuLnDiwlEmFfUj7Xe04RKVsjqSBN+tIbY+yfeqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyBUrF+qgzatOP9lEJDuM1zsc3mST1eJZ3hJ/hH05dzny/7wfcrlM4dhUJhwx8TmmXMtVfb2Nx6hIZZrxigk5ZizzwG44lFGuKV44vAVd+ou7aUEzHn9SMW1yPTAXrpFWipqCYJRt3efJfneDEq2X8Yf8njQv51TL2YGWIoxSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jakanab7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b27c660174so2273602a91.1
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715101763; x=1715706563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdH7GXybWHWyPQwUEBUugYsY0e947AW+cVPmw77Aot4=;
        b=Jakanab7Z9lPkSEq08OhZSRi9XbkWZDbej/bNTytZd3qOzRqZbcXUjIf1iy0Jh5byH
         ucoab47wPL7GljGW4A2GuISagq4At1Qq81UTeSDUP6trltbWCiIRBX4ZK9lBPATsSftn
         BLfGaOJLLy+P0l4mmgSX/LEJYJP6crp/wzZBYy5lRZM1n5MXqUGt8B1lFpG37sJjfvPu
         J1jkeruYMXedi9uRxjTDyZ1Gmix3hgNvLwqFICEiN8T5HBbq1za2JgrNJDYWnPwrZhlt
         uuN6Ny7UJLvsPS5+yqJ7WjEinjRnrMA364IAi0zfbr8bfjcOv1AQw/S5lA8whERss+2W
         iX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101763; x=1715706563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdH7GXybWHWyPQwUEBUugYsY0e947AW+cVPmw77Aot4=;
        b=tdMUGnKPZjgnp+kvRY2f/GzyjA/2kzZdsuMejU59PBwCxEAZC9HNviS+Rueklz18/o
         oZWVmGL9jWSh42cma01uEU96kAUxtdNV+b1T0Lc1vrYHv1uaf0qW1qi9nxvTJpd+GBol
         P9epp74b0bSnmrDlVC/FRU/C8rsV5AtcFBrTx8jZFeamOssxpT9gw+KN1Q6xY7fc4DSy
         WwLc/hVZ5KjOIpR4cwkPQGH65sgRe3KjJlnShb2BK6SGmdYO35sBgiDwDOtnuXpDetmg
         lKaSfcwSwi/hy11oNUbKLOr8gYDYQ8vXaFwskTkC4ADwhnffSfCpVh7IHKIy4ktKmvJA
         +1kA==
X-Forwarded-Encrypted: i=1; AJvYcCX+hwYKe7P0THG0vyrPsATiAWSVZGLTX7hWLTKYyZ1X0vNHv00dbDpo2SdXN/R0PTbGbX6NL0A5f0nxeKXp6hilHL7l
X-Gm-Message-State: AOJu0Yw4H2Xp9WSUFTR57uJphyljkYsDjhNWAoqQJcVOZ/xqJMVRvalu
	dJMCDyz4KosQsZi+sSQXJLj8z/2pIbnKT444PQ1ClPZEidK+nMDcvuNv1r98QKm0tUgZ2PzBVo+
	zRqE4ky8+oTumIOcyRkrkQdy8Giw=
X-Google-Smtp-Source: AGHT+IHUdSdShiOuLFezVZb+HeTA7oiQzg+PumnrbL7BLJtg1QKimlO5jA2X21JCdL+w3qozVngjxhS9LA+TpYMThb0=
X-Received: by 2002:a17:90b:19d3:b0:2b0:e3b3:78c2 with SMTP id
 98e67ed59e1d1-2b616be5544mr163419a91.48.1715101762836; Tue, 07 May 2024
 10:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506033353.28505-1-laoar.shao@gmail.com> <20240506033353.28505-2-laoar.shao@gmail.com>
 <CAEf4Bzb2xZt7EUQDicty6b6GtmuvwrFnx=6L9p0Qrijg1DcsGQ@mail.gmail.com> <CALOAHbBg4GhEe7aozfsGATk2wWNzv1u76inb_AWHkWHvP0yufw@mail.gmail.com>
In-Reply-To: <CALOAHbBg4GhEe7aozfsGATk2wWNzv1u76inb_AWHkWHvP0yufw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 10:09:10 -0700
Message-ID: <CAEf4BzY9-P2ecU5mVrf6L9iNLtY_3JBdfwBPAsV6F6+ymwWfvA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 1/2] bpf: Add bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Vernet <void@manifault.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:32=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Tue, May 7, 2024 at 11:38=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, May 5, 2024 at 8:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > Add three new kfuncs for the bits iterator:
> > > - bpf_iter_bits_new
> > >   Initialize a new bits iterator for a given memory area. Due to the
> > >   limitation of bpf memalloc, the max number of bits that can be iter=
ated
> > >   over is limited to (4096 * 8).
> > > - bpf_iter_bits_next
> > >   Get the next bit in a bpf_iter_bits
> > > - bpf_iter_bits_destroy
> > >   Destroy a bpf_iter_bits
> > >
> > > The bits iterator facilitates the iteration of the bits of a memory a=
rea,
> > > such as cpumask. It can be used in any context and on any address.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  kernel/bpf/helpers.c | 140 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 140 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 2a69a9a36c0f..83b2a02f795f 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -2744,6 +2744,143 @@ __bpf_kfunc void bpf_preempt_enable(void)
> > >         preempt_enable();
> > >  }
> > >
> > > +struct bpf_iter_bits {
> > > +       __u64 __opaque[2];
> > > +} __aligned(8);
> > > +
> > > +struct bpf_iter_bits_kern {
> > > +       union {
> > > +               unsigned long *bits;
> > > +               unsigned long bits_copy;
> > > +       };
> > > +       u32 nr_bits;
> > > +       int bit;
> > > +} __aligned(8);
> > > +
> > > +/**
> > > + * bpf_iter_bits_new() - Initialize a new bits iterator for a given =
memory area
> > > + * @it: The new bpf_iter_bits to be created
> > > + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterat=
ed over
> >
> > typo: pointer
>
> Thanks for the fix and the other fixes.
>
> >
> > > + * @nr_bits: The number of bits to be iterated over. Due to the limi=
tation of
> > > + * memalloc, it can't greater than (4096 * 8).
> >
> > typo: can't be greater
> >
> > > + *
> > > + * This function initializes a new bpf_iter_bits structure for itera=
ting over
> > > + * a memory area which is specified by the @unsafe_ptr__ign and @nr_=
bits. It
> > > + * copy the data of the memory area to the newly created bpf_iter_bi=
ts @it for
> >
> > s/copy/copies/
> >
> > > + * subsequent iteration operations.
> > > + *
> > > + * On success, 0 is returned. On failure, ERR is returned.
> > > + */
> > > +__bpf_kfunc int
> > > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__=
ign, u32 nr_bits)
> > > +{
> > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > +       u32 words =3D BITS_TO_LONGS(nr_bits);
> > > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > > +       u32 left, offset;
> > > +       int err;
> > > +
> > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(st=
ruct bpf_iter_bits));
> > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> > > +                    __alignof__(struct bpf_iter_bits));
> > > +
> > > +       if (!unsafe_ptr__ign || !nr_bits) {
> > > +               kit->bits =3D NULL;
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       kit->nr_bits =3D 0;
> > > +       kit->bits_copy =3D 0;
> > > +       /* Optimization for u64/u32 mask */
> > > +       if (nr_bits <=3D 64) {
> > > +               /* For big-endian, we must calculate the offset */
> > > +               offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - si=
ze : 0;
> >
> > S390 isn't the only big-endian architecture, it's wrong to hard-code ju=
st S390
> >
> > there is __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__ check throughout th=
e
> > kernel to do this detection
>
> I missed that. will check it.
>
> >
> > > +
> > > +               err =3D bpf_probe_read_kernel_common(((char *)&kit->b=
its_copy) + offset,
> > > +                                                  size, unsafe_ptr__=
ign);
> > > +               if (err)
> > > +                       return -EFAULT;
> >
> > I'd rewrite the above to something like (not tested, but should give
> > the right idea):
> >
> > long bits =3D 0;
> >
> > err =3D bpf_probe_read_kernel_common(&bits, size, unsafe_ptr__ign);
> > if (err)
> >     return -EFAULT;
> >
> > #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> > bits =3D __swab64(bits);
> > #endif
> >
> > /* deal with bit mask of weird size, ensuring upper bits are zero */
> > bits <<=3D 64 - nr_bits;
> > bits >>=3D 64 - nr_bits;
> >
> > kit->bits_copy =3D bits;
> >
> >
> > This should take care of both big-endianness, and non-multiple-of-8
> > sized bitmasks (I think, we need tests).
>
> looks good, will change it.
>
> >
> > pw-bot: cr
> >
> >
> > > +
> > > +               kit->nr_bits =3D nr_bits;
> > > +               kit->bit =3D -1;
> > > +               return 0;
> > > +       }
> > > +
> > > +       /* Fallback to memalloc */
> > > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > > +       if (!kit->bits)
> > > +               return -ENOMEM;
> > > +
> > > +       err =3D bpf_probe_read_kernel_common(kit->bits, words * sizeo=
f(u64), unsafe_ptr__ign);
> > > +       if (err) {
> > > +               bpf_mem_free(&bpf_global_ma, kit->bits);
> > > +               return err;
> > > +       }
> > > +
> > > +       /* long-aligned */
> > > +       left =3D size & (sizeof(u64) - 1);
> > > +       if (!left)
> > > +               goto out;
> > > +
> > > +       offset =3D IS_ENABLED(CONFIG_S390) ? sizeof(u64) - left : 0;
> > > +       err =3D bpf_probe_read_kernel_common((char *)(kit->bits + wor=
ds - 1) + offset, left,
> > > +                                          unsafe_ptr__ign + (words -=
 1) * sizeof(u64));
> > > +       if (err) {
> > > +               bpf_mem_free(&bpf_global_ma, kit->bits);
> > > +               return err;
> > > +       }
> >
> > tbh, I'm not sure what's the desired behavior here is. David (cc'ed),
> > you were dealing with cpumasks, how is the bit mask specified there?
> > Is it considered to be an long[] array or byte[] array? And how is
> > that working on big-endian, because I think it makes a difference?
> > Please take a look, thanks.
>
> The function find_next_bit() requires the pointer to be of type
> "unsigned long *", hence, we must ensure consistency by converting it
> here as well. As cpumask represents a bitmap and is always of type
> "unsigned long *", it remains unaffected by endianness considerations.
>

Right, but the question is whether this iterator should make the same
simplifying assumption or not? I think the motivation for this
iterator was the ability to iterate over CPU masks, so I'm asking (and
that's why I cc'ed David) what we should do to make it work well for
CPU masks.

> >
> > > +
> > > +out:
> > > +       kit->nr_bits =3D nr_bits;
> > > +       kit->bit =3D -1;
> > > +       return 0;
> > > +}
> > > +
> > > +/**
> > > + * bpf_iter_bits_next() - Get the next bit in a bpf_iter_bits
> > > + * @it: The bpf_iter_bits to be checked
> > > + *
> > > + * This function returns a pointer to a number representing the valu=
e of the
> > > + * next bit in the bits.
> > > + *
> > > + * If there are no further bit available, it returns NULL.
> > > + */
> > > +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> > > +{
> > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > +       u32 nr_bits =3D kit->nr_bits;
> > > +       const unsigned long *bits;
> > > +       int bit;
> > > +
> > > +       if (nr_bits =3D=3D 0)
> > > +               return NULL;
> > > +
> > > +       bits =3D nr_bits <=3D 64 ? &kit->bits_copy : kit->bits;
> > > +       bit =3D find_next_bit(bits, nr_bits, kit->bit + 1);
> > > +       if (bit >=3D nr_bits) {
> > > +               kit->nr_bits =3D 0;
> > > +               return NULL;
> > > +       }
> > > +
> > > +       kit->bit =3D bit;
> > > +       return &kit->bit;
> > > +}
> > > +
> > > +/**
> > > + * bpf_iter_bits_destroy() - Destroy a bpf_iter_bits
> > > + * @it: The bpf_iter_bits to be destroyed
> > > + *
> > > + * Destroy the resource associated with the bpf_iter_bits.
> > > + */
> > > +__bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
> > > +{
> > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > +
> > > +       if (kit->nr_bits <=3D 64)
> > > +               return;
> > > +       bpf_mem_free(&bpf_global_ma, kit->bits);
> > > +}
> > > +
> > >  __bpf_kfunc_end_defs();
> > >
> > >  BTF_KFUNCS_START(generic_btf_ids)
> > > @@ -2826,6 +2963,9 @@ BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > >  BTF_ID_FLAGS(func, bpf_wq_start)
> > >  BTF_ID_FLAGS(func, bpf_preempt_disable)
> > >  BTF_ID_FLAGS(func, bpf_preempt_enable)
> > > +BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> > > +BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> > > +BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> > >  BTF_KFUNCS_END(common_btf_ids)
> > >
> > >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> > > --
> > > 2.30.1 (Apple Git-130)
> > >
>
>
>
> --
> Regards
> Yafang

