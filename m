Return-Path: <bpf+bounces-37069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3ED950BFD
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B80C284427
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2649C1A2C1E;
	Tue, 13 Aug 2024 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkUW4vNB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259637E
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572655; cv=none; b=Uq5Wb4F/PJpXpuZS7tn5clEvMdyv6ZkmY3Mb+/E6m527czkTSYOFH+1dbAlk2ZneKjuXU2gOuksm+FjQbnbho/quVQdlroIHdcLt+VXxdegDRrHc7vLjDOFINJmphg5umWZ+sUKtK4FTtCyPc1mRdY/KOzZijB0zGgQjiDehN6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572655; c=relaxed/simple;
	bh=ZuIAuj5Y2Ld4RPAJEFqwhnVHVsS4sN7FNPeb4JHebWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ca8qkdvMG73qtEaAxdDNx045t54s+zSjJDe8DIxofRQTXxfLdIuJMx0cQuBOA4XAbpZ5m0r8zTKc4mhqvlaus6aGzmXdwJ9wDFH8X9BGEusVbWoC4GVWSQy08nUZCjH2eJs6rC1ZbrzyGsjjw2a2xjlClcsfgvOhT+h2vzL7Otw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkUW4vNB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb510cd097so4306016a91.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723572653; x=1724177453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB/E0Vt3sANXjJM678mkzDlSmkyhAc3vSEhJfR3Tabw=;
        b=AkUW4vNBylILfD1ouQbBdPNoe1w2ZtO4b35GgFdwHt64c/CSnURVo6AVX3JrV/2z+j
         pX+MINqsOkEoBJFnuApXyIX/6EOInSYKSmldF92397+BFZtR6wI6zav69ovh+zdNCVlw
         MGluErOZL40hCcSaKq1u7DfttGbvmxAzIjO4SgE74sCgxwCzAcGexRFHxglgT4pykqTe
         bpU2k5j0SZOfcVIjaODGV/hUP8lkNpzxAluOSXMmVfLk3cP2/8ZnEu1pu35N1GN4hTRO
         UKKJqMLPpvR3qnagaH51XrnFins7t1qi2Bk31TIgJv5412+Mvaqa9HSX5R9b8VkdEoWR
         ifMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723572653; x=1724177453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB/E0Vt3sANXjJM678mkzDlSmkyhAc3vSEhJfR3Tabw=;
        b=pHrpCBZS17soT6bM7wt65mLsne0Sq40Ph5Lh+X3yQrUKDpHHsnU/yMOKcdjE1CCxOC
         Mhy3tf7kxzjUeVjVThCc+64hmlgK5LukCCWckOzQtDmFaFn1HHwE7/QenoeIGutseFtT
         VYlWu4KqNwtVnhQ5ccj4z9jGkebcSi9WWrRvb7JaR98RuP2zDf2OCuMa5HpH3HFk7yG4
         rvpn6pDpDSEVJ2EQjss+4eMMANKd7ZiMfb3PotBXsiRd22VR4a8IyHAtdHQLtmxZCKdh
         IfKIax3I/C6PirUsNW+xsz4bc22pCfr6T3dOTmPpPbv2qGy3NuRGj0wmxYthEeNOMY5Z
         ngxA==
X-Forwarded-Encrypted: i=1; AJvYcCWdnoFslnW8YhToh8U+bzsbbZviwxDGnyuz1LK2UwmusFS4QLXNQVDXKCSEZVNz6wa/Mb/gBCnp9fYBpYXFwtprhebU
X-Gm-Message-State: AOJu0Yx14RdqmPq8d1geb5BmeGh8fgJgDZWhb0zOH6iJXGmH/nX7iiRu
	PLxggNe4QdZbidxCG+2IQNCWRkNxdCFoqOBRGUCy93uWk2C56Z8pLZSqNKJbBFqaioX6X1k4lED
	juYteNHFCRajcS+bb8x8mdZNRwvY=
X-Google-Smtp-Source: AGHT+IGo0iFVsSfSQIyUacjqPhg5PQSetSBj7tKdwpgTSQJ0z9LOgPLerfurd8pRq4VRAjf3cn1GOVccpTJqW7dhzpA=
X-Received: by 2002:a17:90a:9e5:b0:2cd:5d13:40ba with SMTP id
 98e67ed59e1d1-2d3aaa9934dmr416871a91.14.1723572653258; Tue, 13 Aug 2024
 11:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813012528.3566133-1-linux@jordanrome.com>
 <CAADnVQ+cfn0SMQZwnCcv5VvCCixO+=CsTcF4bfjEYTpHPWngwA@mail.gmail.com>
 <CA+QiOd6WYqBHjDdG8OpRFby7MC2jh_YoXY2kTZt3YrmoY4J2ow@mail.gmail.com>
 <CA+QiOd5q3j1x+Pvt1Tpx3s+mA0HWfcwniSg11AJCsArZLWRhGA@mail.gmail.com> <CAADnVQL5rskNLC-f6z_Rg3Tjf7khis=pzNiKzJOMzvpw-R5wKg@mail.gmail.com>
In-Reply-To: <CAADnVQL5rskNLC-f6z_Rg3Tjf7khis=pzNiKzJOMzvpw-R5wKg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Aug 2024 11:10:40 -0700
Message-ID: <CAEf4BzZVvdUYY5DRTLhmaZP7zssa1tBm1P1=96DvJWxfFP-xSw@mail.gmail.com>
Subject: Re: [bpf-next v3 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jordan Rome <linux@jordanrome.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 9:08=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 13, 2024 at 6:30=E2=80=AFAM Jordan Rome <linux@jordanrome.com=
> wrote:
> >
> > On Tue, Aug 13, 2024 at 6:27=E2=80=AFAM Jordan Rome <linux@jordanrome.c=
om> wrote:
> > >
> > > On Mon, Aug 12, 2024 at 10:10=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 12, 2024 at 6:26=E2=80=AFPM Jordan Rome <linux@jordanro=
me.com> wrote:
> > > > >
> > > > > This adds a kfunc wrapper around strncpy_from_user,
> > > > > which can be called from sleepable BPF programs.
> > > > >
> > > > > This matches the non-sleepable 'bpf_probe_read_user_str'
> > > > > helper.
> > > > >
> > > > > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > > > > ---
> > > > >  kernel/bpf/helpers.c | 36 ++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 36 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index d02ae323996b..e87d5df658cb 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -2939,6 +2939,41 @@ __bpf_kfunc void bpf_iter_bits_destroy(str=
uct bpf_iter_bits *it)
> > > > >         bpf_mem_free(&bpf_global_ma, kit->bits);
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * bpf_copy_from_user_str() - Copy a string from an unsafe user =
address
> > > > > + * @dst:             Destination address, in kernel space.  This=
 buffer must be at
> > > > > + *                   least @dst__szk bytes long.
> > > > > + * @dst__szk:        Maximum number of bytes to copy, including =
the trailing NUL.
> > > > > + * @unsafe_ptr__ign: Source address, in user space.
> > > > > + *
> > > > > + * Copies a NUL-terminated string from userspace to BPF space. I=
f user string is
> > > > > + * too long this will still ensure zero termination in the dst b=
uffer unless
> > > > > + * buffer size is 0.
> > > > > + */
> > > > > +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, =
const void __user *unsafe_ptr__ign)
> > > > > +{
> > > > > +       int ret;
> > > > > +       int count;
> > > > > +
> > > > > +       if (unlikely(!dst__szk))
> > > > > +               return 0;
> > > > > +
> > > > > +       count =3D dst__szk - 1;
> > > > > +       if (unlikely(!count)) {
> > > > > +               ((char *)dst)[0] =3D '\0';
> > > > > +               return 1;
> > > > > +       }
> > > > > +
> > > > > +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> > > > > +       if (ret >=3D 0) {
> > > > > +               if (ret =3D=3D count)
> > > > > +                       ((char *)dst)[ret] =3D '\0';
> > > > > +               ret++;
> > > > > +       }
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > >
> > > > The above will not pad the buffer and it will create instability
> > > > when the target buffer is a part of the map key. Consider:
> > > >
> > > > struct map_key {
> > > >    char str[100];
> > > > };
> > > > struct {
> > > >         __uint(type, BPF_MAP_TYPE_HASH);
> > > >         __type(key, struct map_key);
> > > > } hash SEC(".maps");
> > > >
> > > > struct map_key key;
> > > > bpf_copy_from_user_str(key.str, sizeof(key.str), user_string);
> > > >
> > > > The verifier will think that all of the 'key' is initialized,
> > > > but for short strings the key will have garbage.
> > > >
> > > > bpf_probe_read_kernel_str() has the same issue as above, but
> > > > let's fix it here first and update read_kernel_str() later.
> > > >
> > > > pw-bot: cr
> > >
> > > You're saying we should always do a memset using `dst__szk` on succes=
s
> > > of copying the string?
> >
> > Something like this?
> > ```
> > ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> >   if (ret >=3D 0) {
> >     if (ret <=3D count)
> >        memset((char *)dst + ret, 0, dst__szk - ret);
> >     ret++;
> > }
> > ```
>
> yep. something like this. I didn't check the math.

I'm a bit worried about this unconditional memset without having a way
to disable it. In practice, lots of cases won't use the destination
buffer as a map key, but rather just send it over ringbuf. So paying
the price of zeroing out seems unnecessary.

It's quite often (I do that in retsnoop, for instance; and we have
other cases in our production) that we have a pretty big buffer, but
expect that most of the time strings will be much smaller. So we can
have a 1K buffer, but get 20 bytes of string content (and we end up
sending only actual useful size of data over ringbuf/perfbuf, so not
even paying 1K memcpy() overhead). Paying for memset()'ing the entire
1K (and string reading can happen in a loop, so this memsetting will
be happening over and over, unnecessarily), seems excessive.

Given it's pretty easy to do memset(0) using bpf_prober_read(dst, sz,
NULL), maybe we shouldn't do memsetting unconditionally? We can add a
loud comment stating the danger of using the resulting buffer as map
key without clearing the unfilled part of the buffer and that should
be sufficient?

