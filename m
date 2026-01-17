Return-Path: <bpf+bounces-79362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 013BED38D4C
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE2B301B4A7
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0446301717;
	Sat, 17 Jan 2026 09:07:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1410FD
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768640829; cv=none; b=UHIp8PblAWPFDq1H1VmZ3Qo79Y47pU5OhhrJA6lW+lwW2kTbInD+n5dxgg/3SFVv2GWNQd+8EhlkLgyCeGc7cm++nGwX+fcW7xVuF8/c3+/YlPjHujK6jgxR92n3GJPKIrTBzGw+ozr6teDe0UaVlzeOqBG9Jx3p5tXJoiN85Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768640829; c=relaxed/simple;
	bh=yvMVnQM+GChfG9IU5BHRvEuwHtyFzoyFuNHWGCfHLxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXh/eZ/tR0C//MObB6ub40dzLLdrDl3pLd/etAkIUBfdaogPtt3DsIR+M7qufktjKo++3Od45t8zmDLwYlfNAqdPdnaL6uFHBr0IoF4Q60f5eEoRyKBA7pnFT3Dlizr9WtmyG9tmal1z898lViIuruldAYCKJMoNvpCTnSEwivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: ULgnA9ATSwGPUpMVyyGYxQ==
X-CSE-MsgGUID: vh08R/aIT7y62I+VyS0Skw==
X-IPAS-Result: =?us-ascii?q?A2HyBAB7UGtp/zYImYJagQmHAoRYkXQDoBkGCQEBAQEBA?=
 =?us-ascii?q?QEBAVoEAQGFBwKMeic4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBA?=
 =?us-ascii?q?QEBBgMBAQICgR2GCVOGYwEFI1YQCQILAwoCAiYCAiESAQUBHAYThXaVfpxHg?=
 =?us-ascii?q?TKBAd16LVSBMhQBgQouiFMBgW+EAIR4QoINgUqCdT6EGimDW4JpBIINFYEOg?=
 =?us-ascii?q?zeIW4dvJgkdAwcHDg0eRg8FHANZLAETQhMXCwcFajkoAhkBAgGBBSNLBQMRG?=
 =?us-ascii?q?R2BGQohHRcTH1gbBwUTI4EaBhsGHBICAwECAjpTDCSBUgICBIEtY3uCAQ+HD?=
 =?us-ascii?q?QGBAAUubxoOIgJBUgMLYgs9NxQbSpAWR4E8awdhAit7NpALB4d3jw+hEYQmh?=
 =?us-ascii?q?FEfnQIzhASUFZJSLphYqTA1EoFJgX9NOGwGgjBSGQ+OLRbHVmk8AgcBCgEBA?=
 =?us-ascii?q?wmRaoF/AQE?=
IronPort-Data: A9a23:koYODagZGSFzOzKTow+XfxhhX161xhEKZh0ujC45NGQN5FlHY01je
 htvCzrUa/yJNzP3Kd50OYW0o04BupWGytNhHAVurXg1HnwW8JqUDtmwEBzMMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEli+fQAOG6ULKYUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDhNg06/gEk35qqq4WpH5gVWic1j5TcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJEAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi9vy5wSEmSNYUekFPOzOPWXca7lyUqeFO1qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTi+o+2w6eOSdtJzqfweNOzVLZIwi2FZmGSx4fYOGfgvQo3P9ZpU0TMxmM1UDLDDa
 sFfYDEpbgyojx9nYwxPTstjx6H4wCSjG9FbgAv9Sa4f4nPTzR141bHFMMLePN2RA9hYlQCRr
 STE5wwVBzlDbILAkmTZriPEaunngyOjCLhVHZyEqe802nzQ+H0oUCYVSg7uyRW+ohTnAY0Ac
 h18FjAVhaIq+mS1QdTnGR61uniJulgbQdU4LgEhwASdj6bZ5weHC3IVF3hcZddgvcRwRyRCO
 kK1c83BOBhgtpTEYE6m6ZiskCuXBzkEAl4SXHpRJeca2OUPtr3fmTrtdr5e/EOdi82wFTz0w
 i6HtjlnwagehogC3OO55TgrYg5ARLCUE2bZBS2OAQpJCz+Vgqb+OOREDnCBtZ59wH6xFAXpg
 ZT9s5H2ASBnJcjleNaxrBox8EGBva/fb2KF0DaD7rE99znl5niiY41K+zBiNQ9uPI4JfTLif
 FXU/AhW4ZpOOnqhZLN2ZISqY/kXIGmJPYqNa804mfIXP8MhLlLdrHkyDaNStki0+HURfWgEE
 c/zWa6R4bwyUMyLEBLeqz8h7IIW
IronPort-HdrOrdr: A9a23:NJoPT6sG3ZwqDw4Q3879yg3N7skDgtV00zEX/kB9WHVpmwKj5r
 iTdZMgpGXJYVcqKQodcL+7Scu9qB/nhP1ICMwqXYtKPzOJhILLFvAE0WKK+VSJcEfDH6xmtJ
 uIGJIObuEYY2IK9PrS0U2WFc0/yMKL/K3tqeDV1Gd1UA1mApsM0y5JTiieVmJ7TBRbHpYifa
 DsgvavZADNRV0nKuq+DnkBG87Zp9PKk5riJToLHQQu5gXLrR7A0s+eL/FQ5Hgjbw8=
X-Talos-CUID: 9a23:Fy2bDWCKglxXAAr6ExRD+0g9S+kZSWLy9ErIBnGpGElYWITAHA==
X-Talos-MUID: 9a23:8R/bDQZNq7hokeBTqT+01AslPeZUvLXwUmFOr4Q94/KHKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,233,1763391600"; 
   d="scan'208";a="106736449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 17 Jan 2026 18:07:05 +0900
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 44268183E388
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 18:07:04 +0900 (JST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7927541abfaso26745587b3.3
        for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 01:07:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvmQdMn9mNqr+DuRKBeJkHZhy5w4YmS3czY8omh0NlBnnFYWBTM0chafpIUtUkntF+Kzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+OvllHLexNJZuM59d38tV/8qdZ98iOyJosCjp+5YGbecyILJF
	DNmtnzrPIj4SY5ntm+5u+JUPjEgrGv+czt3uTkvIhZo+tYewhkujK0XsBVdOUgLOCet7AWqgYSS
	Sb+oqJb6Q960BpH7jsjnAU+5TDjDqCtdcfPOq5lO6qA==
X-Received: by 2002:a05:690c:399:b0:786:4ed4:24f0 with SMTP id
 00721157ae682-793c52f60b0mr45925757b3.5.1768640822742; Sat, 17 Jan 2026
 01:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
 <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp> <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
 <bcce0d61-e7ae-4268-a6ec-a82f1329cc6d@redhat.com>
In-Reply-To: <bcce0d61-e7ae-4268-a6ec-a82f1329cc6d@redhat.com>
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Date: Sat, 17 Jan 2026 18:06:51 +0900
X-Gmail-Original-Message-ID: <CAJjCV5Hr_WqmMrA8SKJNVKtUOVjhWAcMS1iu7sFDgLr+bm=Nvw@mail.gmail.com>
X-Gm-Features: AZwV_QibMlzy60R_ZvEu45Gc2mpl5TdR8Ypnld4CcoM0E9BcIRKDeTDSyASRyIg
Message-ID: <CAJjCV5Hr_WqmMrA8SKJNVKtUOVjhWAcMS1iu7sFDgLr+bm=Nvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strncasecmp kfunc
To: Viktor Malik <vmalik@redhat.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think it would be clearer to document the other string functions as
well. What do you think, Mykyta? If you'd like, I can take care of it
after I'm done with this patch.

Yuzuki

2026=E5=B9=B41=E6=9C=8817=E6=97=A5(=E5=9C=9F) 1:03 Viktor Malik <vmalik@red=
hat.com>:
>
> On 1/16/26 13:28, Mykyta Yatsenko wrote:
> > On 1/15/26 17:37, Yuzuki Ishiyama wrote:
> >> bpf_strncasecmp() function performs same like bpf_strcasecmp() except
> >> limiting the comparison to a specific length.
> >>
> >> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> >> ---
> >>   kernel/bpf/helpers.c | 31 ++++++++++++++++++++++++++++---
> >>   1 file changed, 28 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 9eaa4185e0a7..2b275eaa3cac 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
> >>    * __get_kernel_nofault instead of plain dereference to make them sa=
fe.
> >>    */
> >>
> >> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool igno=
re_case)
> >> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ign=
ore_case, size_t len)
> >>   {
> >>      char c1, c2;
> >>      int i;
> >> @@ -3416,6 +3416,9 @@ static int __bpf_strcasecmp(const char *s1, cons=
t char *s2, bool ignore_case)
> >>              return -ERANGE;
> >>      }
> >>
> >> +    if (len =3D=3D 0)
> >> +            return 0;
> >> +
> >>      guard(pagefault)();
> >>      for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> >>              __get_kernel_nofault(&c1, s1, char, err_out);
> >> @@ -3428,6 +3431,8 @@ static int __bpf_strcasecmp(const char *s1, cons=
t char *s2, bool ignore_case)
> >>                      return c1 < c2 ? -1 : 1;
> >>              if (c1 =3D=3D '\0')
> >>                      return 0;
> >> +            if (len < XATTR_SIZE_MAX && i =3D=3D len - 1)
> >> +                    return 0;
> > Maybe rewrite this loop next way: u32 max_sz =3D min_t(u32,
> > XATTR_SIZE_MAX, len); for (i=3D0; i < max_sz; i++) { ... } if (len <
> > XATTR_SIZE_MAX) return 0; return -E2BIG; This way we eliminate that
> > entire if statement from the loop body, which should be positive for
> > performance.
> >>              s1++;
> >>              s2++;
> >>      }
> >> @@ -3451,7 +3456,7 @@ static int __bpf_strcasecmp(const char *s1, cons=
t char *s2, bool ignore_case)
> >>    */
> >>   __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> >>   {
> >> -    return __bpf_strcasecmp(s1__ign, s2__ign, false);
> >> +    return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX)=
;
> >>   }
> >>
> >>   /**
> >> @@ -3469,7 +3474,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign,=
 const char *s2__ign)
> >>    */
> >>   __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__=
ign)
> >>   {
> >> -    return __bpf_strcasecmp(s1__ign, s2__ign, true);
> >> +    return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
> >> +}
> >> +
> >> +/*
> >> + * bpf_strncasecmp - Compare two length-limited strings, ignoring cas=
e
> >> + * @s1__ign: One string
> >> + * @s2__ign: Another string
> >> + * @len: The maximum number of characters to compare
> > Let's also add that len is limited by XATTR_SIZE_MAX
>
> This applies for other string kfuncs, too, but we never mention it in
> the docs comments. Does it make sense to have it just for one? Or should
> we add it to the rest as well?
>
> Viktor
>
> >> +
> >> + * Return:
> >> + * * %0       - Strings are equal
> >> + * * %-1      - @s1__ign is smaller
> >> + * * %1       - @s2__ign is smaller
> >> + * * %-EFAULT - Cannot read one of the strings
> >> + * * %-E2BIG  - One of strings is too large
> >> + * * %-ERANGE - One of strings is outside of kernel address space
> >> + */
> >> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__=
ign, size_t len)
> >> +{
> >> +    return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
> >>   }
> >>
> >>   /**
> >> @@ -4521,6 +4545,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_I=
TER_DESTROY | KF_SLEEPABLE)
> >>   BTF_ID_FLAGS(func, __bpf_trap)
> >>   BTF_ID_FLAGS(func, bpf_strcmp);
> >>   BTF_ID_FLAGS(func, bpf_strcasecmp);
> >> +BTF_ID_FLAGS(func, bpf_strncasecmp);
> >>   BTF_ID_FLAGS(func, bpf_strchr);
> >>   BTF_ID_FLAGS(func, bpf_strchrnul);
> >>   BTF_ID_FLAGS(func, bpf_strnchr);
> >
> >
>

