Return-Path: <bpf+bounces-77126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A45F6CCE7C9
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0362D3020CED
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E412BE029;
	Fri, 19 Dec 2025 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8BQCwch"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F0283C83
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766120786; cv=none; b=a9SmdD6fm/zVLgfhb6/BpI8omzX6ngeENzM98hY1OIPR7FkrirHXdmt3llU4aai0IsSvUi+Qc/tU8pG0tdZkdfp70NCEId/IzxDO8SJ3NsGB/Xp2NmadUhq7Dz3yb79Vb9cY8QV6li5y2ldux4auX3P2lRCJCuOOZFJcqI7pRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766120786; c=relaxed/simple;
	bh=MFkXl8ml/HvWadiwoUYTVQZDTM6NwKz2odjZxH7OZdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqBKi4wAdThnsO9ycU72LqaCaGUztPqqbFlFqwXRSCQ2EGnsnw3u9mp88hzx1vnJelALuoEVq4HF1RFLOe78PEyujc0rEf5ZQmXRXlvBIRMN6Ie5jfJgJIEI4lEK3L7p65SuZP1RWzoUdkb0g7sOspWMG38/7RddqryhPxfMZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8BQCwch; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b7b737eddso1209600a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766120781; x=1766725581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zoqe/VDhHd5JoP+N5xrNIqGrwVbOLcq6mGpL625PbRk=;
        b=W8BQCwchJPJHoyf40RB5n1P25PAjzvuh+w+Mhhvw0Q2dtDF3hm8S9bLWXwvPnpwHQK
         IIzZRJMcsiHU9XKL09aYw7hWhedXW1pnyX7QI7QXkIhFO4kj7zI1DOJimDVqJSOhPzK0
         /cpoVIBBcLs4qdgwaRVSE+CXqiWjzCjjcQy8iH8cimWM02oMbCMrlf2FKUqecPrT/Huo
         LxQt8wT9VWW2KpOic9X74df3aaVVXeuUommbTn28c3wnOR3Rn1FfrxpgYv5v/XP3nn8k
         3V+uYCYUx/ASzU/yRAy7Vk987/jL5D5eTCU2sz+i1kuRJG2e0NPYuBqWwQ9x717FSOXH
         lCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766120781; x=1766725581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zoqe/VDhHd5JoP+N5xrNIqGrwVbOLcq6mGpL625PbRk=;
        b=O8pjM0Z64yvfZlldQyHP+ijGrIkh1RSO+gBBkzFC//PjkqIBuSGJKlU9e28GedfNb2
         YHN5i6fh40fZAh0JeEc3Jpw9uu/dG9CSkMk5l7saIDQ7RR2r1xqkv7U8bhEiS/rhDivE
         L+ybNkzYYDSMW8fUmz8sa54xno6JhTy5d31b840alRno8k0pxa9tXMka6hUGi9A3q2EO
         I5dYUr4fX19Za58NYigc/6ezSLyMVrGYB9aaBk61E2Pu9TPkeK+Y7v5Jp9fumjtbpZWa
         II5XnbJx2lI4DhGaL9RZrQvIAF/qxirqh+dcpRn3FQXDACys+GRRO4GTEQQBVVxLxi/Z
         /9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu1tKuvmG7Asm1EJurZzH7pLl4KXrngTUR0Yyhw8xXKD8fQ4lhCvQmqfJZ3u8kcbdLUqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPqRu9jDCVxAtA6Cq/AKA7qZ33Maj1b56AWvCt/7lO3JljmDh
	oR/6Z6U2Ht54AiTBMs1x8zoeTrYP8fzLDHArj49E6/2WRedjFpF1Z/DpXmG5rVrjaHI7HNPHS2A
	Yf1SiL0311KkLYgSgmXOobPpW8Pg/sujj9HDqA9fyaQ==
X-Gm-Gg: AY/fxX5GW1Tv0RZJbf0ThO54YB8iz5rnP6Jpkm9jQ7RUV8iI25/PKEegksrlqbD9weo
	z2c4wT3GE2ly25wNS9VCnb3jVEZzaH8lXaLPX0NhM8jgZJvM+8Vr1m6SVTBgF+0IFCD3wH+DGEZ
	mcSmrqFjpl7Gun4Fdx2oDe7crtMW292qQQjGiHpWkRB5xCnk4HXwgj6/L+bE5CZgpvGXmZkqUAn
	ts0xCrlHXYukaaMoE1Q+rKjChBRBJfTjzWPsDZx6zqEIokmr/xmc13wvBJhGNDJC1LyzGtG
X-Google-Smtp-Source: AGHT+IHPq+zxWVZcUj8ImbeI/GYWi56t1DAHKy0W/H14wKy1EwsYYYlyIJGFF7zlhWx5LGS+aPGEvopw6fV4q60ar9M=
X-Received: by 2002:a05:6402:2683:b0:64b:4624:777d with SMTP id
 4fb4d7f45d1cf-64b8eefb5a2mr1493128a12.18.1766120781346; Thu, 18 Dec 2025
 21:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-6-dolinux.peng@gmail.com> <CAEf4BzY+gnT9aET_NDOkzX2iBwLednyK4xGe4S6JmhzN0C5GoA@mail.gmail.com>
In-Reply-To: <CAEf4BzY+gnT9aET_NDOkzX2iBwLednyK4xGe4S6JmhzN0C5GoA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:06:09 +0800
X-Gm-Features: AQt7F2rjpLISYsLU-5djmaW_Ok0Cp0o_Ilm-3DUKKiUFymMGBn-78juZZM-1NRo
Message-ID: <CAErzpmusyOMQTcoWiT7nNa=gOAOHgdRYqVb+Dc24BaqjzzeRYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 05/13] libbpf: Verify BTF Sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:44=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
>
> typo in subject: "Sorting" -> "sorting", it looks weird capitalized like =
that

Thanks, I will do it.

>
> > This patch checks whether the BTF is sorted by name in ascending
> > order. If sorted, binary search will be used when looking up types.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 2facb57d7e5f..c63d46b7d74b 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -899,6 +899,46 @@ int btf__resolve_type(const struct btf *btf, __u32=
 type_id)
> >         return type_id;
> >  }
> >
> > +/*
> > + * Assuming that types are sorted by name in ascending order.
> > + */
>
> Unnecessary comment, and no, btf_compare_type_names() itself makes no
> such assumption, it just compares two provided types by name. Drop the
> comment, please.
>
> > +static int btf_compare_type_names(__u32 *a, __u32 *b, const struct btf=
 *btf)
> > +{
> > +       struct btf_type *ta =3D btf_type_by_id(btf, *a);
> > +       struct btf_type *tb =3D btf_type_by_id(btf, *b);
> > +       const char *na, *nb;
> > +
> > +       na =3D btf__str_by_offset(btf, ta->name_off);
> > +       nb =3D btf__str_by_offset(btf, tb->name_off);
> > +       return strcmp(na, nb);
> > +}
>
> you use this function only in one place, there is no real point having
> it, especially that it uses **a pointer to type ID** as an
> interface... just inline its logic in that one loop below
>
> > +
> > +static void btf_check_sorted(struct btf *btf)
> > +{
> > +       const struct btf_type *t;
> > +       __u32 i, k, n;
> > +       __u32 sorted_start_id;
> > +
> > +       if (btf->nr_types < 2)
> > +               return;
>
> why special casing? does it not work with nr_types =3D 0 or nr_types =3D =
1?

No. I just think it doesn't make any sense to check the sorting
of BTF with zero or only one type.

>
> > +
> > +       sorted_start_id =3D 0;
>
> nit: initialize in declaration

Thanks, I will do it.

>
>
> > +       n =3D btf__type_cnt(btf);
> > +       for (i =3D btf->start_id; i < n; i++) {
> > +               k =3D i + 1;
> > +               if (k < n && btf_compare_type_names(&i, &k, btf) > 0)
> > +                       return;
> > +               if (sorted_start_id =3D=3D 0) {
> > +                       t =3D btf_type_by_id(btf, i);
> > +                       if (t->name_off)
>
> I'd check actual string, not name_off. Technically, you can have empty
> string with non-zero name_off, so why assume anything here?

Thanks, I will do it.

>
> > +                               sorted_start_id =3D i;
> > +               }
> > +       }
> > +
> > +       if (sorted_start_id)
> > +               btf->sorted_start_id =3D sorted_start_id;
>
> You actually made code more complicated by extracting that
> btf_compare_type_names(). Compare to:
>
> n =3D btf__type_cnt(btf);
> btf->sorted_start_id =3D 0;
> for (i =3D btf->start_id + 1; i < n; i++) {
>    struct btf_type *t1 =3D btf_type_by_id(btf, i - 1);
>    struct btf_type *t2 =3D btf_type_by_id(btf, i);
>    const char *n1 =3D btf__str_by_offset(btf, t1->name_off);
>    const char *n2 =3D btf__str_by_offset(btf, t2->name_off);
>
>    if (strcmp(n1, n2) > 0)
>         return;
>    if (btf->sorted_start_id =3D=3D 0 && n1[0] !=3D '\0')
>         btf->sorted_start_id =3D i - 1;
> }

Thanks. I believe we shouldn't directly assign a value to
`btf->sorted_start_id` within the for loop, because
`btf->sorted_start_id` might be non-zero even when the
BTF isn't sorted.

>
>
> No extra k<n checks, no extra type_by_id lookups. It's minimalistic
> and cleaner. And if it so happens that we get single type BTF that is
> technically sorted, it doesn't matter, we always fallback to faster
> linear search anyways.
>
> Keep it simple.

Thank you. I will adopt this method in the next version.

>
> > +}
> > +
> >  static __s32 btf_find_by_name_bsearch(const struct btf *btf, const cha=
r *name,
> >                                                 __s32 start_id, __s32 e=
nd_id)
> >  {
> > @@ -1147,6 +1187,7 @@ static struct btf *btf_new(const void *data, __u3=
2 size, struct btf *base_btf, b
> >         err =3D err ?: btf_sanity_check(btf);
> >         if (err)
> >                 goto done;
> > +       btf_check_sorted(btf);
> >
> >  done:
> >         if (err) {
> > --
> > 2.34.1
> >

