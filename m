Return-Path: <bpf+bounces-79554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4BD3BF50
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8E2B3A075D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7A35CB84;
	Tue, 20 Jan 2026 06:30:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140B2BE043
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890644; cv=none; b=T6bUjkIJKVtmdAYQ7BE6jS9sPxdc0pfZtEw44HJJZ0VWe5Qm66G+XWsGDLrEMdnNYjU+aZau8yFnFTo6NMCFFl8zW7tILimZddVgcfD2uY1t2Uwwgvx6y7IimlQ4i8Z688f8b2TTZpbuBkIxqIl15lFu8j2K78NOnp+SRnQQLuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890644; c=relaxed/simple;
	bh=Ya4dwBntPHV5+1wHgKN8dBUIXmvS2tFV73g+tofQOEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoUCndDeJXMWV+KI1uGuI/rD1WsXyBAtaivZyJaj+NC3465M5DVDraoCy6ZXkgegKdcL5LqWoSDWpCVzZ5sN199B481TgyznzbSlyk6/rwSfnjQJJEP1/xGwja0KZLpthKpasH6BuwKg+PACWPoXimFlDKhkDCGAHYurp16GQJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: rZcDgvaRS62ukofSEAKfbg==
X-CSE-MsgGUID: GUTYSISGSTGJZIYR4SAJBA==
X-IPAS-Result: =?us-ascii?q?A2HyBACjIG9p/zYImYJagQmHAoRYkXQDi2SUNQYJAQEBA?=
 =?us-ascii?q?QEBAQEBWgQBAYUHAox6JzgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQUBA?=
 =?us-ascii?q?QEBAQEGAwEBAgKBHYYJU4ZjAQUjVhAJAgsNAgImAgIgARIBBQEcBhOFPQM2k?=
 =?us-ascii?q?0ecR4EygQHdQg0rLVSBMhQBgQouiDQfAYFvhACEeEKCDYFKgnU+gh+BeymDW?=
 =?us-ascii?q?4JpBIINFYEOgmIEOYEZhy4Uh24mCR0DBwcODR5GDwUcA1ksARNCExcLBwVqO?=
 =?us-ascii?q?SgCGQECAYEFI0sFAxEZHYEZCiEdFxMfWBsHBRMjbAYbBhwSAgMBAgI6Uwwkg?=
 =?us-ascii?q?VICAgSBLWN7ggEPhw0BgQAFLm8aDiICQVIDC2ILPTcUG0qPe0eBPGIJB2ECK?=
 =?us-ascii?q?3s2kAsHlwagIHGEJoRRH5ZshhYzhASUFZJSLphYgliPOpceNRKBSYF/TThsB?=
 =?us-ascii?q?oIwUhkPji0Wy3lpPAIHAQoBAQMJkWqBfwEB?=
IronPort-Data: A9a23:b8o40qz88kYkIel51O16t+esxyrEfRIJ4+MujC+fZmUNrF6WrkUDn
 WMfWmyCOvneZzD2KdF2aoy08UJXuZ/Rn9QySlM4pC00HyNBpOP7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6jufQGuaU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgWcc3l48sfrZ9ks25qyq4Vv0g3RnDRx1lA6G/5UqJM9HTU2BByOQapVZGOe8W
 9HCwNmRlkvF/w0gA8+Sib3ydEsHWNb6ZWBiXVIPBsBOKjAbzsAD+v5T2Mg0MC+7uB3Q9zxF8
 +ihgLTrIesf0g0gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xSun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXACo/ZTyMmeuM++zhV+priP8OBerlNoxK7xmMzRmBZRonaZXTBqnH4d5G0S0hwN1DFrDXb
 IwbcVKDbjyZOEUJYwpMTsJ4wbvAanrXKlW0rHqUvqo28mHWxSRxyLOrMcGTZ9GBA8xe2ESAz
 o7D1z2hXEBCbIHAmFJp9FqDu9P+pgLAd7kuO5+K189Q3Ga65EY6XUh+uVyT+6Dj1RHnCrqzM
 Xc88DIghbY9+VbtTdTnWRC85nmesXYht8F4Fv1/5AyJy7TZ+RfAQHUJRXhIY5okrKfaWADGy
 HeTrdjFCiJmiobLE2+e8bmvgBqRNyIaeDpqiTA/cecT3zX0iKML5i8jo/5mAOu5g9n0Bzzq0
 mnMsSU1wbwYy8wTv0lawbwlq2/yznQqZldqjukyYo5CxlklDLNJn6TytTDmAQ9ode50jjCp5
 RDoYfRyE9zi/bnXzXbSH7xcdF1Yz+qFPXXBh19xEoM69ii8s3mtNY1U7TpiPkAsOcEBfCLvY
 UTapQJW4oQ7AUZHrMZfPeqMNijd5fG8To6/B6+FMIsmj1oYXFbvwRyCrHW4hwjF+HXAW4liY
 /93re7E4a4mNJla
IronPort-HdrOrdr: A9a23:5kXK4auDNVxMhNz414SZJQ1P7skDgtV00zEX/kB9WHVpmwKj5r
 iTdZMgpGXJYVcqKQodcL+7Scu9qB/nhP1ICMwqXYtKPzOJhILLFvAE0WKK+VSJcEfDH6xmtJ
 uIGJIObuEYY2IK9PrS0U2WFc0/yMKL/K3tqeDV1Gd1UA1mApsM0y5JTiieVmJ7TBRbHpYifa
 DsgvavZADNRV0nKuq+DnkBG87Zp9PKk5riJToLHQQu5gXLrR7A0s+eL/FQ5Hgjbw8=
X-Talos-CUID: 9a23:KpUx3GFBPKhdzdIAqmJ9xkU4Fd4sSEaDlmrTJEGDJE9KRreaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ARYCnzA0X2yogFW8UWxxo8wQdqzUjzJmSOXssqro?=
 =?us-ascii?q?9h+amBw1BAWumpRada9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106900579"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 15:30:20 +0900
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 9FC19183E3B2
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:30:20 +0900 (JST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7926d5dbdf7so38505707b3.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 22:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpEG5PiIUwAj5+/iOgW4wsxbQeq6vuf2FuCYCi1NuIigFVfPttzMM0DhQMFvRAfV4vJzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPuHzBOue9IjKig8pnl0hemTcGtUS0Wd8Awf7sg9lVRKAXKRpf
	62fqplT5aovBoikuRGvIrhvjAo3Uw26lBQqbq3i3hMjUhlcg6tT5AEd0Cedp/zI6Uu1vHvXCMJF
	jqqb1yzbFCsVGgTpNSGFAHQlhDmXYS01WYI1ECieMnw==
X-Received: by 2002:a05:690c:d0f:b0:78f:bede:57e5 with SMTP id
 00721157ae682-793c5393b7bmr120216327b3.44.1768890619069; Mon, 19 Jan 2026
 22:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
 <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp> <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
 <bcce0d61-e7ae-4268-a6ec-a82f1329cc6d@redhat.com> <CAJjCV5Hr_WqmMrA8SKJNVKtUOVjhWAcMS1iu7sFDgLr+bm=Nvw@mail.gmail.com>
 <1cfe2f61-811f-4ae1-924a-07b1e4ff53d1@gmail.com>
In-Reply-To: <1cfe2f61-811f-4ae1-924a-07b1e4ff53d1@gmail.com>
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Date: Tue, 20 Jan 2026 15:30:07 +0900
X-Gmail-Original-Message-ID: <CAJjCV5EMUBjLwLiwt9qZ=az3s5HUjwx8c=kPWULjBgmbjnM7Pw@mail.gmail.com>
X-Gm-Features: AZwV_QhwXpqa-6-kgZ0ttfUT-rbTxDqXRmwID4sXG0D5-ISGf57J88XyK2jPEY0
Message-ID: <CAJjCV5EMUBjLwLiwt9qZ=az3s5HUjwx8c=kPWULjBgmbjnM7Pw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strncasecmp kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I will cancel the document update.

2026=E5=B9=B41=E6=9C=8820=E6=97=A5(=E7=81=AB) 0:02 Mykyta Yatsenko <mykyta.=
yatsenko5@gmail.com>:
>
> On 1/17/26 09:06, Yuzuki Ishiyama wrote:
> > I think it would be clearer to document the other string functions as
> > well. What do you think, Mykyta? If you'd like, I can take care of it
> > after I'm done with this patch.
> >
> > Yuzuki
> Viktor is right, probably
>
> -E2BIG - One of strings is too large
>
> is clear enough.
> >
> > 2026=E5=B9=B41=E6=9C=8817=E6=97=A5(=E5=9C=9F) 1:03 Viktor Malik <vmalik=
@redhat.com>:
> >> On 1/16/26 13:28, Mykyta Yatsenko wrote:
> >>> On 1/15/26 17:37, Yuzuki Ishiyama wrote:
> >>>> bpf_strncasecmp() function performs same like bpf_strcasecmp() excep=
t
> >>>> limiting the comparison to a specific length.
> >>>>
> >>>> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> >>>> ---
> >>>>    kernel/bpf/helpers.c | 31 ++++++++++++++++++++++++++++---
> >>>>    1 file changed, 28 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>>> index 9eaa4185e0a7..2b275eaa3cac 100644
> >>>> --- a/kernel/bpf/helpers.c
> >>>> +++ b/kernel/bpf/helpers.c
> >>>> @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
> >>>>     * __get_kernel_nofault instead of plain dereference to make them=
 safe.
> >>>>     */
> >>>>
> >>>> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ig=
nore_case)
> >>>> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool i=
gnore_case, size_t len)
> >>>>    {
> >>>>       char c1, c2;
> >>>>       int i;
> >>>> @@ -3416,6 +3416,9 @@ static int __bpf_strcasecmp(const char *s1, co=
nst char *s2, bool ignore_case)
> >>>>               return -ERANGE;
> >>>>       }
> >>>>
> >>>> +    if (len =3D=3D 0)
> >>>> +            return 0;
> >>>> +
> >>>>       guard(pagefault)();
> >>>>       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> >>>>               __get_kernel_nofault(&c1, s1, char, err_out);
> >>>> @@ -3428,6 +3431,8 @@ static int __bpf_strcasecmp(const char *s1, co=
nst char *s2, bool ignore_case)
> >>>>                       return c1 < c2 ? -1 : 1;
> >>>>               if (c1 =3D=3D '\0')
> >>>>                       return 0;
> >>>> +            if (len < XATTR_SIZE_MAX && i =3D=3D len - 1)
> >>>> +                    return 0;
> >>> Maybe rewrite this loop next way: u32 max_sz =3D min_t(u32,
> >>> XATTR_SIZE_MAX, len); for (i=3D0; i < max_sz; i++) { ... } if (len <
> >>> XATTR_SIZE_MAX) return 0; return -E2BIG; This way we eliminate that
> >>> entire if statement from the loop body, which should be positive for
> >>> performance.
> >>>>               s1++;
> >>>>               s2++;
> >>>>       }
> >>>> @@ -3451,7 +3456,7 @@ static int __bpf_strcasecmp(const char *s1, co=
nst char *s2, bool ignore_case)
> >>>>     */
> >>>>    __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__i=
gn)
> >>>>    {
> >>>> -    return __bpf_strcasecmp(s1__ign, s2__ign, false);
> >>>> +    return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MA=
X);
> >>>>    }
> >>>>
> >>>>    /**
> >>>> @@ -3469,7 +3474,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ig=
n, const char *s2__ign)
> >>>>     */
> >>>>    __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s=
2__ign)
> >>>>    {
> >>>> -    return __bpf_strcasecmp(s1__ign, s2__ign, true);
> >>>> +    return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX=
);
> >>>> +}
> >>>> +
> >>>> +/*
> >>>> + * bpf_strncasecmp - Compare two length-limited strings, ignoring c=
ase
> >>>> + * @s1__ign: One string
> >>>> + * @s2__ign: Another string
> >>>> + * @len: The maximum number of characters to compare
> >>> Let's also add that len is limited by XATTR_SIZE_MAX
> >> This applies for other string kfuncs, too, but we never mention it in
> >> the docs comments. Does it make sense to have it just for one? Or shou=
ld
> >> we add it to the rest as well?
> >>
> >> Viktor
> >>
> >>>> +
> >>>> + * Return:
> >>>> + * * %0       - Strings are equal
> >>>> + * * %-1      - @s1__ign is smaller
> >>>> + * * %1       - @s2__ign is smaller
> >>>> + * * %-EFAULT - Cannot read one of the strings
> >>>> + * * %-E2BIG  - One of strings is too large
> >>>> + * * %-ERANGE - One of strings is outside of kernel address space
> >>>> + */
> >>>> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2=
__ign, size_t len)
> >>>> +{
> >>>> +    return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
> >>>>    }
> >>>>
> >>>>    /**
> >>>> @@ -4521,6 +4545,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF=
_ITER_DESTROY | KF_SLEEPABLE)
> >>>>    BTF_ID_FLAGS(func, __bpf_trap)
> >>>>    BTF_ID_FLAGS(func, bpf_strcmp);
> >>>>    BTF_ID_FLAGS(func, bpf_strcasecmp);
> >>>> +BTF_ID_FLAGS(func, bpf_strncasecmp);
> >>>>    BTF_ID_FLAGS(func, bpf_strchr);
> >>>>    BTF_ID_FLAGS(func, bpf_strchrnul);
> >>>>    BTF_ID_FLAGS(func, bpf_strnchr);
> >>>
>

