Return-Path: <bpf+bounces-64828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C54B175F7
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A53A6A02
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2623E325;
	Thu, 31 Jul 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpOA2Vje"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107DB644;
	Thu, 31 Jul 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985062; cv=none; b=YCpY0aapJ3EmCm9NATK+esF1mOD+lmfo6HvnHALEyaEb7ACaanC8vcEwvxEuq0ixKv7fpwAXK1BsL/FkzWMXzX0zCUNPANsTflb73DzAvdKI3T42MUFEweStCHbSW8EusO+x+B2EYO4sJ1gtWQnQxc2jX72B91WHCV0KMkY86Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985062; c=relaxed/simple;
	bh=tk2QGSbpErFtQaa/cNHStRHVBU0RFslrHXFiXqQI33E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxWPQJK2/pUfSkxP6YE0k0x9P8niWlNUxO9S3X+3Wn89okmc4hujvizvI6Ya18WRp1j0gVUaCFHA3SacLeKUPrFeDxx8y4F3GeJhrGKuByb4fhZbVzjkG0+W10Kn7ddngHCFWCfikOG6+EwsPCx8zLlaGsa74hdwuYutAWxfF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpOA2Vje; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b785a69454so880292f8f.2;
        Thu, 31 Jul 2025 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753985059; x=1754589859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbin+GZQHDGmwlTYhez++Hd6ORPDFk74NiNgP51hNRc=;
        b=GpOA2VjewWsvDsj6X+UZnQHxIs8srUH+iMWNaAN5Xgy81TBfDQnkZ5v7BYAj1ZwQfu
         pSImvel/dECwukJJO+VpSjKnoMGwfR3EDYUOSUhsXWJ9LNsOJBinzLuO1DvwcmrPhB/G
         Wm2DsRd1kBhMSho4ldFDWoxrPBIUthne97l5XVXJoQHEK4ZqHp5Mxb9gf3/P5nFNHkq0
         9IlZh2qKXPyO9CXi/5iEVK9dRYS22n90xfomahAFAfztErPAcq8Z8l5I6tKVfSEjv28u
         8KsgbzK9Kn6I+HujeztN+stiER2gV0JjSTcyCsXrjVn9uRBkfQuY9kKwR2b7JUqBJJtR
         6CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985059; x=1754589859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbin+GZQHDGmwlTYhez++Hd6ORPDFk74NiNgP51hNRc=;
        b=UUfrG59aWZP0gFro/5Xv7790bXTtQfxt/VD450ewGf3pKXN3ZkwHaJGaPT689Fmvgh
         /HQB7bWfqmea+b25MWxY/y3VGco3WBdYicORvvsNY8Mf1vpQyIBFcmwREOJORDCQI6nW
         FpSudsw08iHNDg0PR6Ot8MbKssyB5WIAazPkpOs6v+n/K2aEZqiO8BWgtJG926e8zoXr
         gCW3r6lgkpEYBYV8yxpYWumUI0E8KB1oXv6umS529Za/XPe0TdIwx5htIxCS2/72Hhku
         UCvqBuqVw+1p6KVCr5Qy7UoVgXEc8bc6MzEMVwOMiAmuKDcJr7L9Pg3GilX4ISvoRSBa
         tj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVgADn2bvo9cK/WLycMp/o83aqByedNWQX5pLOcMFTgnhzKTfuMD35+ji2L4WUjWZmURgBeR4qWIuFTBKNr++B28Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCH7FnyL8Nig7+gPbLgzWMstuG5iAbAHs0YSWka0/mcbPR0pg2
	lfoTR0VVw7BlRMZXUENgolhyrxdPqFRqQABhe+PAgPC1PfmRfYsoeKCGaEZAGZmDCl6aym/SnoB
	G89FzlpyjLXoyvR9qFeLXJk1T4h2a4rM=
X-Gm-Gg: ASbGncv4VNg2b0n+BSvpKspgrI2PfrZ/nUhKTYQsw0ZyZRn17wStJO6zMzKXuJ1A6wF
	9i09ZRhdBZeOxuYjR9qMlw9Pwcqqx5d1ZLS4Qd7kEzkcVtzcwWeoOzEz+nH2/lp4Z1v6lQ9kdre
	pe6SHHQv9Z9kfACZvSOBwvinTq+nuXFYOg7I9ByhaPBGl/VDwUm3vlIK8LzAW2na8TTsNj7phnN
	qXcJMIIUwPBm+0RTtrXCLA=
X-Google-Smtp-Source: AGHT+IEx/7pY0WKBtxFiwsFXrOayGNLGLVdna8o4FuW/Qc4fuPmjdP8DBK1bqqkcECTu7SAoPxsIlIrG8DQVcZdNSYk=
X-Received: by 2002:a05:6000:2dc5:b0:3b8:d15f:45a2 with SMTP id
 ffacd0b85a97d-3b8d15f4d83mr939771f8f.14.1753985058278; Thu, 31 Jul 2025
 11:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730172745.8480-1-James.Bottomley@HansenPartnership.com>
 <20250730172745.8480-3-James.Bottomley@HansenPartnership.com>
 <CAADnVQJd0zwSnepH=1f6mwnd-1oFF8gkuCFnEgbMVE8pZ3qz0g@mail.gmail.com> <c3460d84d40922b57d190631cb92f83533c3aba7.camel@HansenPartnership.com>
In-Reply-To: <c3460d84d40922b57d190631cb92f83533c3aba7.camel@HansenPartnership.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 31 Jul 2025 11:04:04 -0700
X-Gm-Features: Ac12FXyboMwQ7iOEIYBVDMHPvWXDuR-iovWI6-gqGFfdTME8BpIv1I3RGPWlavw
Message-ID: <CAADnVQKXpt1cvyk_NSHORZBhEJTXHmGL4mtJZVy8mKrRU-++nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] bpf: remove bpf_key reference
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 10:27=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2025-07-31 at 10:03 -0700, Alexei Starovoitov wrote:
> > On Wed, Jul 30, 2025 at 10:32=E2=80=AFAM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > bpf_key.has_ref is used to distinguish between real key pointers
> > > and
> > > the fake key pointers that are used for system keyrings (to ensure
> > > the
> > > actual pointers to system keyrings are never visible outside
> > > certs/system_keyring.c).  The keyrings subsystem has an exported
> > > function to do this, so use that in the bpf keyring code
> > > eliminating
> > > the need to store has_ref.
> > >
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > >
> > > ---
> > > v2: use unsigned long for pointer to int conversion
> > > ---
> > >  kernel/trace/bpf_trace.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index e7bf00d1cd05..c0ccd55a4d91 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1244,7 +1244,6 @@ static const struct bpf_func_proto
> > > bpf_get_func_arg_cnt_proto =3D {
> > >  #ifdef CONFIG_KEYS
> > >  struct bpf_key {
> > >         struct key *key;
> > > -       bool has_ref;
> > >  };
> > >
> > >  __bpf_kfunc_start_defs();
> > > @@ -1297,7 +1296,6 @@ __bpf_kfunc struct bpf_key
> > > *bpf_lookup_user_key(s32 serial, u64 flags)
> > >         }
> > >
> > >         bkey->key =3D key_ref_to_ptr(key_ref);
> > > -       bkey->has_ref =3D true;
> > >
> > >         return bkey;
> > >  }
> > > @@ -1335,7 +1333,6 @@ __bpf_kfunc struct bpf_key
> > > *bpf_lookup_system_key(u64 id)
> > >                 return NULL;
> > >
> > >         bkey->key =3D (struct key *)(unsigned long)id;
> > > -       bkey->has_ref =3D false;
> > >
> > >         return bkey;
> > >  }
> > > @@ -1349,7 +1346,7 @@ __bpf_kfunc struct bpf_key
> > > *bpf_lookup_system_key(u64 id)
> > >   */
> > >  __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
> > >  {
> > > -       if (bkey->has_ref)
> > > +       q
> > >                 key_put(bkey->key);
> >
> > Should be (u64) to avoid truncation ?
>
> It can't be: gcc only allows pointer to unsigned long conversion, so
> the statement
>
>   if (system_keyring_id_check((u64)bkey->key) < 0)
>
> produces a pointer to int conversion error.  Since the function
> prototype is u64 the conversion from unsigned long to u64 happens
> automatically.
>
>
> > But is it really the case that id=3D=3D1 and id=3D=3D2 are exposed to U=
API
> > already?
> >
> > As far as I can see lookup_user_key() does:
> >         default:
> >                 key_ref =3D ERR_PTR(-EINVAL);
> >                 if (id < 1)
> >                         goto error;
> >
> >                 key =3D key_lookup(id);
> >
> > so only id=3D=3D0 is invalid, but id=3D1 can be a valid user key, no?
>
> Well, remember the id as pointer trick is only used for the system_key
> lookup.  What you get back from user_key lookup is a real pointer to
> the key (regardless of what serial id you pass in) so there's no chance
> of getting 1 or 2 back for a user key.
>
> However, if you were thinking of overloading key look up, it is
> currently the case, in spite of the check in lookup above, that user
> key serial numbers begin at three thanks to this code in
> key.c:key_alloc_serial()
>
>         do {
>                 get_random_bytes(&key->serial, sizeof(key->serial));
>
>                 key->serial >>=3D 1; /* negative numbers are not permitte=
d */
>         } while (key->serial < 3);

I see. That's what I was missing.

> David said he would prefer, if we to allow system keyring lookup here,
> to use negative ids (like keyrings) for them.

Makes sense to me as well.
Do you want to do a follow up or respin this set ?

Would be great if he can ack this set too.

