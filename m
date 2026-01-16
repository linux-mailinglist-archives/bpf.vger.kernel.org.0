Return-Path: <bpf+bounces-79319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B30D37B10
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A513A30F88C5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A6338594;
	Fri, 16 Jan 2026 17:54:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0931335067
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586080; cv=none; b=TfgB9p0hvgeSi4GUFsfMZyFWb3NfmHjB9AplrOUcMOgI68MwO8G/aEQMmpeEnjX0NvAGzy4qKP2NPeEOndI+WfTwzVSvOwin4GEo9sTbkVB4J3fj2JYd2c0H4+tfOIu/hKtjFuOI+quQoSLjC074XlVJRu7JQzTUG6jjotRhxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586080; c=relaxed/simple;
	bh=gpppr0r1382tgKlTneOrxjW8U25YKqVPhUmWxo6iyLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTNezr3n3vPFeua0m8z5ZMF4cMDSqGeJb2NqVF2YJs8UppMaXzmu1Id8FHj4me325qftLjAZCIoMmtvIVEoEwCPacZXlhYRxa9cxqEQdKaPO1OPzkGpAVpRe0eyOaFnNbuB6yADjodQFsXPvq6unal2s/1nFOdXwIqZTZwYc9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: FgtyROwWRN69RCghx9fexg==
X-CSE-MsgGUID: i+rjShnvQe6JtEZFalBVfg==
X-IPAS-Result: =?us-ascii?q?A2HyBAAXempp/zcImYJagQmHAoRYkXQDoBkGCQEBAQEBA?=
 =?us-ascii?q?QEBAVoEAQGFBwKMeic4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEFAQEBA?=
 =?us-ascii?q?QEBBgMBAQICgR2GCVOGYwEFI1YQCQILAwoCAiYCAiESAQUBHAYThXaWdJxHg?=
 =?us-ascii?q?TKBAd16LVSBMhQBgQouiFMBgW+EAIR4QoINgUqCdT6EGimDW4JpBIIigQ6ME?=
 =?us-ascii?q?odwJgkdAwcHDg0eRg8FHANZLAETQhMXCwcFajkoAhkBAgGBBSNLBQMRGR2BG?=
 =?us-ascii?q?QohHRcTH1gbBwUTI4EaBhsGHBICAwECAjpTDCOBUgICBIEwY3uCAQ+HDwGBA?=
 =?us-ascii?q?AUubxoOIgJBUwMLYgs9NxQbSpAaR4E8awcBgQ17NoEOH45eB4d3jw+hEYQmh?=
 =?us-ascii?q?FEfnQIzhASUFZJSLphYqTA1EoFJgX9NOGwGgjBSGQ+OLRbGN2k8AgcBCgEBA?=
 =?us-ascii?q?wmRaoF/AQE?=
IronPort-Data: A9a23:J578d67FQS0feEZlwoD1XQxRtJ/GchMFZxGqfqrLsTDasY5as4F+v
 mdNW26PPvrZMGXze951OY2xoR9S75DVmtNiSAdupSszEysa+MHILOrCEkqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9Cc6jefTAOKgVIYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE0
 T/Ii5S31GSNhXguawr414rZ8Ekx5K2r5mtC1rADTakjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbJLwW28O49m6t4kZJ
 OF2iHCFYVxB0psgOAgqe0Iw/ylWZcWq8VJcSJS1mZT7I0buKhMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lQB+fltiR342BbLc9vO8sLNm6Mo4PtSQ1pd3ZJa5OrZHrRrWP6dJc3Sk9nNEIAPvVI
 cMSLzh3BPjCS0QUYhFOVcl4zKH12xETcBUBwL6Rjass42nCxQl4+Lj1O5zUYZqXSM4Tl03ep
 HquE2HRW0lEa4XCk2rbmp6qru6MhyHAWIQMLbDm1OJHsnOawkYtBhJDADNXptHj0xThBIsOQ
 6AOwQIktaYa6kOmVJ/+Uge+rXrCuQQTM+e8CMU/+ESBx67V/QuDFzJCUzNKLtUt8s0uLdA36
 rOXt/3mGS1Vl6Kqc1TDp42/ojOiaCYYPWBXMEfoUjA5D8/fTJYbrCqnczqOOKuly9H4HTDuz
 iqb9m4jir5VhMVN1b3TEbH7b9CE+8ahou0dv1u/soeZAuVRPtLNi2uAsAmz0Bq4BNzFJmRtR
 VBd8yVehchXZX13qMByfAn9NOvwvanaaWy0ba9HA5ksvymr+mCuZ5tR/CA2I0khP8IJciPzZ
 wrYvgZU+ZlSN3K2bKhxeOqMNinrpIC+fenYugf8P4USO8UtKlTflMysDGbJt13QfIEXuflXE
 f+mnQyEUR721YwPIOKKetog
IronPort-HdrOrdr: A9a23:weBanqs/kQ5RZ2bEq8492lBH7skDv9V00zEX/kB9WHVpmwKj5r
 mTdZMgpGTJYVcqKQkdcL+7Scq9qB/nlaKdpLNxAV7AZmbbUQmTXeVfBOLZqlWKcREWtNQy6U
 4KSdkYNDSfNykdse/KpCe9V/ktyMSa66yz7N2uqkuFjjsGV4hQqyl8AgafVmtsRAdHApI9UL
 6R/NBOqTblWVl/VLXYOpDNZYT+m+E=
X-Talos-CUID: 9a23:v29Bxm0gPkMkeAJmwqPMsLxfNM85Y0f600jqBRHpM01mSK3ER1KA9/Yx
X-Talos-MUID: 9a23:1KpJeAYVORym0OBTtnz2hgpiMtlR7vqMFG0/v5wCkfeKOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,231,1763391600"; 
   d="scan'208";a="106715286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery2.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.55])
  by esa1.cc.uec.ac.jp with ESMTP; 17 Jan 2026 02:54:27 +0900
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 543701839FAB
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 02:54:27 +0900 (JST)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6466d8fd383so2206221d50.2
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 09:54:27 -0800 (PST)
X-Gm-Message-State: AOJu0YyLJ5kC0CkD3nYPUIWm8JHUw8I0tkTzrQwwzKIbEtsy1/GqNhUD
	oAGNcS934z61oFeUzuyNXgJ+FWacTCWwoylAvZAQEpFszSY2qVR0w+RLTlzfIns2vBjXj/6flFY
	HSlQGXZZa2JoXWVcBgPU8vKFhRCKj8k+KLFptjt4vRQ==
X-Received: by 2002:a53:c94a:0:b0:63f:9796:39b7 with SMTP id
 956f58d0204a3-649164cdc75mr2370474d50.49.1768586065577; Fri, 16 Jan 2026
 09:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
 <20260116142455.3526150-2-ishiyama@hpc.is.uec.ac.jp> <54e3bcd7-be63-4604-9935-028da6a1216a@redhat.com>
In-Reply-To: <54e3bcd7-be63-4604-9935-028da6a1216a@redhat.com>
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Date: Sat, 17 Jan 2026 02:54:14 +0900
X-Gmail-Original-Message-ID: <CAJjCV5H+zvns_Yu8phFcQfwVhfxrSH0OCEV33vDD0tiLMi6-pQ@mail.gmail.com>
X-Gm-Features: AZwV_QgIvwdUXTk4TK2grJH7TKWUyBmZ3d0Ll3TaXUWWGFLW-A5463tnBoVJ02s
Message-ID: <CAJjCV5H+zvns_Yu8phFcQfwVhfxrSH0OCEV33vDD0tiLMi6-pQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strncasecmp kfunc
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review!
I will fix and send v3 later.

Yuzuki

2026=E5=B9=B41=E6=9C=8817=E6=97=A5(=E5=9C=9F) 1:01 Viktor Malik <vmalik@red=
hat.com>:
>
> On 1/16/26 15:24, Yuzuki Ishiyama wrote:
> > bpf_strncasecmp() function performs same like bpf_strcasecmp() except
> > limiting the comparison to a specific length.
> >
> > Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> > ---
> >  kernel/bpf/helpers.c | 37 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 32 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9eaa4185e0a7..bdd76209cfcf 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3406,18 +3406,23 @@ __bpf_kfunc void __bpf_trap(void)
> >   * __get_kernel_nofault instead of plain dereference to make them safe=
.
> >   */
> >
> > -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignor=
e_case)
> > +static int __bpf_strncasecmp(const char *s1, const char *s2, bool igno=
re_case, size_t len)
> >  {
> >       char c1, c2;
> > -     int i;
> > +     int i, max_sz;
> >
> >       if (!copy_from_kernel_nofault_allowed(s1, 1) ||
> >           !copy_from_kernel_nofault_allowed(s2, 1)) {
> >               return -ERANGE;
> >       }
> >
> > +     if (len =3D=3D 0)
> > +             return 0;
>
> This check is not necessary since for len =3D=3D 0, max_sz =3D=3D 0 and t=
he
> below loop will not run.
>
> > +
> > +     max_sz =3D min_t(int, len, XATTR_SIZE_MAX);
> > +
> >       guard(pagefault)();
> > -     for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> > +     for (i =3D 0; i < max_sz; i++) {
> >               __get_kernel_nofault(&c1, s1, char, err_out);
> >               __get_kernel_nofault(&c2, s2, char, err_out);
> >               if (ignore_case) {
> > @@ -3431,6 +3436,8 @@ static int __bpf_strcasecmp(const char *s1, const=
 char *s2, bool ignore_case)
> >               s1++;
> >               s2++;
> >       }
> > +     if (len < XATTR_SIZE_MAX)
> > +             return 0;
> >       return -E2BIG;
>
> Nit: we could respect the style of the other string kfuncs and do
>
>     return i =3D=3D XATTR_SIZE_MAX ? -E2BIG : 0;
>
> >  err_out:
> >       return -EFAULT;
> > @@ -3451,7 +3458,7 @@ static int __bpf_strcasecmp(const char *s1, const=
 char *s2, bool ignore_case)
> >   */
> >  __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> >  {
> > -     return __bpf_strcasecmp(s1__ign, s2__ign, false);
> > +     return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX)=
;
> >  }
> >
> >  /**
> > @@ -3469,7 +3476,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, =
const char *s2__ign)
> >   */
> >  __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ig=
n)
> >  {
> > -     return __bpf_strcasecmp(s1__ign, s2__ign, true);
> > +     return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
> > +}
> > +
> > +/*
> > + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
> > + * @s1__ign: One string
> > + * @s2__ign: Another string
> > + * @len: The maximum number of characters to compare (limited by XATTR=
_SIZE_MAX)
> > +
> > + * Return:
> > + * * %0       - Strings are equal
> > + * * %-1      - @s1__ign is smaller
> > + * * %1       - @s2__ign is smaller
> > + * * %-EFAULT - Cannot read one of the strings
> > + * * %-E2BIG  - One of strings is too large
> > + * * %-ERANGE - One of strings is outside of kernel address space
> > + */
> > +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__i=
gn, size_t len)
> > +{
> > +     return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
> >  }
> >
> >  /**
> > @@ -4521,6 +4547,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_IT=
ER_DESTROY | KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, __bpf_trap)
> >  BTF_ID_FLAGS(func, bpf_strcmp);
> >  BTF_ID_FLAGS(func, bpf_strcasecmp);
> > +BTF_ID_FLAGS(func, bpf_strncasecmp);
> >  BTF_ID_FLAGS(func, bpf_strchr);
> >  BTF_ID_FLAGS(func, bpf_strchrnul);
> >  BTF_ID_FLAGS(func, bpf_strnchr);
>

