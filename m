Return-Path: <bpf+bounces-36826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D8A94DB73
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9611C20DB5
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593614A4F0;
	Sat, 10 Aug 2024 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9An1Vfo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD124B2F
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723278965; cv=none; b=WzX7+VAkgo/DK/9zq8EfA/c2GDCNNWvKNS0YOh6UGHEUluUO6AE9nhKxmAqspeKSgQFLqRbHAL8zGRl5PLKQwl4PJgVIBs/OUARIqJjguT0xVFMPZXlLxBUaM3kbtq9W90SkEnCs2I+FnJoUn27oHrtYk2MdJ4LdhFWNT9Xem9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723278965; c=relaxed/simple;
	bh=HqqAyMitOit9KMFLmGi1r8xxC9RNxq3lWEneTEXPUkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT2MGVpGKic2fBzj5TCR4O3lUL8neeMf3hMor2+UFkiUuXDzFzlqnrESHaseJHUNRvEDlAxnhFmQqbhwH5BMXZvvl96QB8//WDAlWx++oBErVLSJPpUYUWXDOq3RWqKvqJzVBvdfMyEYmMxgcCjv8Ro99BI4EnNQnmi0ow+ObAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9An1Vfo; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso28056311fa.0
        for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723278961; x=1723883761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hmyAMkignPIiVL3gWEocxTQXhBmZR/R9ZpbnB8gU9M=;
        b=C9An1VfoeNJHeWUtKwjm2+3kdpgk+0zF173fTbWUCKjUZhbxVEVWXhyKliSCwj17Ku
         KxApkQfLn4gpJtZ6uERIAd4ax+STFUtIwi19SK0svKhcj9fGl7sKdpJNHcgrx2H1ah3Z
         hDnpttjBi9/ksH4xOP98lhEqRr0hFts4N2w5D47fSvH+NXn48WIqjZUD2UlkuvQ6o29+
         bf8MmjXUs3hfn2i9g3HVCuhO2IvtSoa/NWfqpV7TW8qcsKHP3kT/4AUz7j/ZjlHmucvQ
         B60ZpGiZuSDrMjYEcWNypLij6ndqP6FAHKp01u8san1Js4vepftpd/Aul+hNOMruswXJ
         kxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723278961; x=1723883761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hmyAMkignPIiVL3gWEocxTQXhBmZR/R9ZpbnB8gU9M=;
        b=Rfl4lYWSIXYCy4KIvyRqT1W7VH66CSWBYRDdYOVi/ylt6LPd9OZRUDjLDfPBJJj9hO
         Vz8oupGZ9qo9sUZWkFQjpHBqNWZ2MXFtoUGziNEBWWmJJZnxaGGOG4pu2sQp9Zp7pDTT
         eYby2DXNvHcSotwHcEUsNvUdcs4wh30/grAm2/wtOASW6wv3Yf2GNDrc/+WlL77EXTsH
         xkPlgns1B6cdPT/mFd+tdwDRNIGYZS0wYYEPn7zzqBMYnynIk2snTp1/8+S0FfmDBL9i
         eKqJMSYTVMC332NTSgEXXgTXA5/WmQDYQjO3r/UpHbllVeaDAk5bGVg2iOWTXFvzRWLM
         FlYg==
X-Gm-Message-State: AOJu0YzZExG80XcvMj8DC8Wzcq3Is+rSUfxG8lLEOBpDBwNGqKeEo5yc
	obGs6mA69TXSIIQdCwsZ+9gRMMw8o+KxVIkjR7P+WshsiSvLaTDXiFB29XNSLKmtzsHCALrZkjR
	PeSzX3q8dwqTH3qHCX/Tbg99K6d4=
X-Google-Smtp-Source: AGHT+IGx5o1F7FtGsoD2OLA2AE3q2LVU5e7TrN951fA/CwU6YxDjjKZFAly3PvvdfBHVMCDwFh6nLyPiUIubpW8d6/U=
X-Received: by 2002:a2e:5159:0:b0:2ef:2b44:9977 with SMTP id
 38308e7fff4ca-2f1a6d0d5e0mr24427931fa.18.1723278960826; Sat, 10 Aug 2024
 01:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804185604.54770-1-ubizjak@gmail.com> <cbdf9051a35e8aa16478a2adc821403f53b4f4c0.camel@gmail.com>
 <CAFULd4b3BinvWTuHCAZvTeLjfuThAenK0G9V0yYN-LiHMzto3w@mail.gmail.com> <12302b09b8410132a6c6f761bee342fabd8bc1cf.camel@gmail.com>
In-Reply-To: <12302b09b8410132a6c6f761bee342fabd8bc1cf.camel@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 10 Aug 2024 10:35:54 +0200
Message-ID: <CAFULd4aDAsUWb_qzwAkfij4MWW-_woAV-kfN9=nOLZOUdJYyfA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix percpu address space issues
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 10:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-08-09 at 12:15 +0200, Uros Bizjak wrote:
> > On Fri, Aug 9, 2024 at 10:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Sun, 2024-08-04 at 20:55 +0200, Uros Bizjak wrote:
> > >
> > > [...]
> > >
> > > > Found by GCC's named address space checks.
> > >
> > > Please provide some additional details.
> > > I assume that the definition of __percpu was changed from
> > > __attribute__((btf_type_tag(percpu))) to
> > > __attribute__((address_space(??)), is that correct?
> >
> > This is correct. The fixes in the patch are based on the patch series
> > [1] that enable strict percpu check via GCC's x86 named address space
> > qualifiers, and in its RFC state hacks __seg_gs into the __percpu
> > qualifier (as can be seen in the 3/3 patch). The compiler will detect
> > pointer address space mismatches for e.g.:
> >
> > --cut here--
> > int __seg_gs m;
> >
> > int *foo (void) { return &m; }
> > --cut here--
> >
> > v.c: In function =E2=80=98foo=E2=80=99:
> > v.c:5:26: error: return from pointer to non-enclosed address space
> >    5 | int *foo (void) { return &m; }
> >      |                          ^~
> > v.c:5:26: note: expected =E2=80=98int *=E2=80=99 but pointer is of type=
 =E2=80=98__seg_gs int *=E2=80=99
> >
> > and expects explicit casts via uintptr_t when these casts are really
> > intended ([2], please also see [3] for similar sparse requirement):
> >
> > int *foo (void) { return (int *)(uintptr_t)&m; }
> >
> > [1] https://lore.kernel.org/lkml/20240805184012.358023-1-ubizjak@gmail.=
com/
> > [2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Na=
med-Address-Spaces
> > [3] https://sparse.docs.kernel.org/en/latest/annotations.html#address-s=
pace-name
>
> Understood, thank you for the details.
> Interestingly, clang does not require (uintptr_t) intermediate cast, e.g.=
:
>
>     $ cat test.c
>     #define __as(N) __attribute__((address_space(N)))
>
>     void *foo(void __as(1)* x) { return x; }         // error
>     void *bar(void __as(1)* x) { return (void *)x; } // fine
>
>     $ clang -o /dev/null -c test.c
>     test.c:3:37: error: returning '__as(1) void *' from a function with r=
esult type 'void *' changes address space of pointer
>         3 | void *foo(void __as(1)* x) { return x; }         // error
>           |                                     ^
>     1 error generated.

This is probably a deficiency in clang, sparse nicely explains the
reason for intermediate cast:

-q-
Sparse treats pointers with different address spaces as distinct types
and will warn on casts (implicit or explicit) mixing the address
spaces. An exception to this is when the destination type is uintptr_t
or unsigned long since the resulting integer value is independent of
the address space and can=E2=80=99t be dereferenced without first casting i=
t
back to a pointer type.
-/q-

>
>
> [...]
>
> > > > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > > > index 188e3c2effb2..544ca433275e 100644
> > > > --- a/kernel/bpf/arraymap.c
> > > > +++ b/kernel/bpf/arraymap.c
> > > > @@ -600,7 +600,7 @@ static void *bpf_array_map_seq_start(struct seq=
_file *seq, loff_t *pos)
> > > >       array =3D container_of(map, struct bpf_array, map);
> > > >       index =3D info->index & array->index_mask;
> > > >       if (info->percpu_value_buf)
> > > > -            return array->pptrs[index];
> > > > +            return array->ptrs[index];
> > >
> > > I disagree with this change.
> > > One might say that indeed the address space is cast away here,
> > > however, value returned by this function is only used in functions
> > > bpf_array_map_seq_{next,show,stop}(), where it is guarded by the same
> > > 'if (info->percpu_value_buf)' condition to identify if per_cpu_ptr()
> > > is necessary.
> >
> > If this is the case, you have to inform the compiler that address
> > space is cast away with explicit (void *)(uintptr_t) cast, placed
> > before return. But looking at the union with ptrs and pptrs members,
> > it looked to me that it is just the case of wrong union member
> > accessed.
>
> I'd say it's better to use pptr and add a cast in this case.

OK, will do in a v2 patch, together with your other suggestion.

Thanks,
Uros.

