Return-Path: <bpf+bounces-79249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03DD3222F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3EC30693FC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0D27FD4A;
	Fri, 16 Jan 2026 13:53:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C67145348
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571598; cv=none; b=Fpk8aWw3QOqdrCxkxkuoV3SuNw8TLRG5+/lll281L13M70HJzKqdx5Ggn8EpenPGmTqURVquHbN9SWayEQ2c6a9wvFljbQnxpNp1icnTrUeHoADHOJpCx+nMK/ZQQQ4EOUkhKjOp602BGNhyypjzdB/jTkDION0jbZRoJ28amUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571598; c=relaxed/simple;
	bh=u3xtq89YOICXwJt2jC3uUz203Y5hERxKB0VFB8eigA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEPBDUsIe0H2bymCMmGvOl0p70MJve35Im3zmRqg3fPNr20SVcjG1kEMBm6jWbanCa49u4N8Hv26X6CCmRtvHmGRhtGEQ3mjAYcEC4DUfTa30OaeZ6E3PyMfat+9OuELJZMIV17CfCxGylKQc2nZYBRQOpQI8nZSudXyA2+14XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: yzo9Y39/QYKTmWNswzpDQg==
X-CSE-MsgGUID: bTL+Tsz8Qx6EXi9bq+T8JA==
X-IPAS-Result: =?us-ascii?q?A2E5BwCaQWpp/zYImYJagQmBUoUwhFiRUiIDi2SUNQYJA?=
 =?us-ascii?q?QEBAQEBAQEBWgQBAYUHAox4JzgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBA?=
 =?us-ascii?q?QUBAQEBAQEGAwEBAgKBHYYJU0kBDAGGDAEFI1YQCQILDQICJgICIAESAQUBH?=
 =?us-ascii?q?AYTCIU1AzaVbJxHgTKBAd16LVQGgSwUAYEKLog0HwGBb4QAhHhCgUtCgUqCd?=
 =?us-ascii?q?T6EGimDW4JpBIEOgRSBDoM3iFuCGYVTJgkdAwcHDg0eRg8FHANZLAETQhMXC?=
 =?us-ascii?q?wcFajkoAhkBAgGBBSNLBQMRGR2BGQohHRcTH1gbBwUTI4EaBhsGHBICAwECA?=
 =?us-ascii?q?jpTDCOBUgICBIEwY3uCAQ+HDwGBAAUubxoOIgJBTwMLYgs9NxQbSpAZR4E8a?=
 =?us-ascii?q?weBDns2gQ4fjl4HlwagIHGDHIEKhFGdITOEBJQVklIumFiCWKZYNRKBSYF/g?=
 =?us-ascii?q?QVsBoIwUhkPji0WxTVpPAIHAQoBAQMJhkiEZYY9gX8BAQ?=
IronPort-Data: A9a23:J3eMWqBYREmyfxVW/4/iw5YqxClBgxIJ4kV8jS/XYbTApGkj0zAPm
 GEaDGuFO62IYmShcoxxaY63pxsEvMLXnNJnTANkpHpgZkwRlceUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuFYTdJ5xYuajhKs/va9ks11BjPkGpwUmIWNKgjUGD2yiF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQR4/ZwGyojxE4
 I4lWapc6eseFvakdOw1C3G0GszlVEFM0OevzXOX6KR/w6BaGpdFLjoH4EweZOUlFuhL7W5m5
 O4feQFWP1e6tsGKxY2dUfZ+nugaI5y+VG8fkikIITDxCOZjTZ3HQrvH/84ewTo7wMlFW/TGD
 yYbQWM0NFKZPkYJahFKVPrSn8/x7pX7WzxDqFOErK8+y2jLx0pwy/7wPdGTc9fMR909ckOw/
 zqYoD2hXEtAXDCZ4TC51jGQnf2fpDOldbITRbehtcI6onTGkwT/DzVMDAHk/qDo4qKkYPpVM
 0I85CUjt+4x+VatQ927WAe3yENopTYZS59cHuk79gyX2/OS/guSQGEPCDxZADA7iCMobS040
 Q64xIKuPA1MjLiqb2mC5K+4lDznbED5MlQ+iTk4oRwtweGLnW3ephffC9puFK+rg8fkQHftz
 jvMpSN4ha17YS83O0eToA2vb9GE/8ahousJCuP/BD3NAuRRPd/NWmBQwQKHhcus1a7AJrRB1
 VBd8yRk0AzxMX19vHbUGrpSReDBCwetLD3RyUNpHocs7S+s52/reo4Y7TVzL1tzNYMPfjrsf
 UnSsgpN5ZhVJxOXUEK2CqrvY/kXIV/IT4u1CqmPMIITO/CctmavpUlTWKJZ5Ei1+GBErE31E
 c3znRqEZZrCNZla8Q==
IronPort-HdrOrdr: A9a23:hKK/Y6ouQzLQ+jiNEte0LNIaV5oueYIsimQD101hICG9Ffbo8P
 xG/c5rsSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5Xo3SOTUOxlHIEGgK1+KLqAEIfReOlNK1vp
 0PT0ERMqySMXFKyf/fpCmUeuxB/OW6
X-Talos-CUID: 9a23:FM2oiGxYz7UEt/GKkmO0BgUFCMd0QyaMi07hAHO9NkByV6+NZWafrfY=
X-Talos-MUID: 9a23:lXPEiQhv8oDwLQA3NiZ+3cMpPvtMoJi1GhA0gcsri8jVPzUzB2e/pWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,231,1763391600"; 
   d="scan'208";a="106710622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 16 Jan 2026 22:53:13 +0900
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 0F0A3183E387
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:53:13 +0900 (JST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78fc0f33998so19610917b3.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 05:53:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yxj/I0w/5rWB6O0i0ThhwXE1qf2ym+o5bFwYoAH72k7nUqtzf81
	XsAdO7tKzEJ9BlSzUyERfdILkohunQGy9bPJARDTbJglpHvgqFSfFUCpbZT5t0qUVWHmF0niN/B
	Wd/mPeBbV+kVN7XrQb+0iY0gGYJ/rRaw7MR2spzFpJA==
X-Received: by 2002:a05:690c:9c0c:b0:78c:2857:7e78 with SMTP id
 00721157ae682-793c52b6b6cmr51720577b3.31.1768571591405; Fri, 16 Jan 2026
 05:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
 <20260115173717.2060746-2-ishiyama@hpc.is.uec.ac.jp> <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
In-Reply-To: <46799ba9-d292-494e-b9b1-658448993538@gmail.com>
From: =?UTF-8?B?55+z5bGx57WQ5pyI?= <ishiyama@hpc.is.uec.ac.jp>
Date: Fri, 16 Jan 2026 22:53:00 +0900
X-Gmail-Original-Message-ID: <CAJjCV5HZ06NZ30ygpr8rgYZkKfvGVVUZ0Ks8MBbbjxjnLFi5XA@mail.gmail.com>
X-Gm-Features: AZwV_QjZLKa4iv7jvXOjDJn8-w-s6EQ0tTL0qvVt681h18hE2HlDp_36ILoS41U
Message-ID: <CAJjCV5HZ06NZ30ygpr8rgYZkKfvGVVUZ0Ks8MBbbjxjnLFi5XA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strncasecmp kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mykyta,

Thanks for the review!
I will update the loop as suggested.

I'll send a v2 shortly.

Best regards,
Yuzuki Ishiyama


2026=E5=B9=B41=E6=9C=8816=E6=97=A5(=E9=87=91) 21:29 Mykyta Yatsenko <mykyta=
.yatsenko5@gmail.com>:
>
> On 1/15/26 17:37, Yuzuki Ishiyama wrote:
> > bpf_strncasecmp() function performs same like bpf_strcasecmp() except
> > limiting the comparison to a specific length.
> >
> > Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> > ---
> >   kernel/bpf/helpers.c | 31 ++++++++++++++++++++++++++++---
> >   1 file changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9eaa4185e0a7..2b275eaa3cac 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
> >    * __get_kernel_nofault instead of plain dereference to make them saf=
e.
> >    */
> >
> > -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignor=
e_case)
> > +static int __bpf_strncasecmp(const char *s1, const char *s2, bool igno=
re_case, size_t len)
> >   {
> >       char c1, c2;
> >       int i;
> > @@ -3416,6 +3416,9 @@ static int __bpf_strcasecmp(const char *s1, const=
 char *s2, bool ignore_case)
> >               return -ERANGE;
> >       }
> >
> > +     if (len =3D=3D 0)
> > +             return 0;
> > +
> >       guard(pagefault)();
> >       for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> >               __get_kernel_nofault(&c1, s1, char, err_out);
> > @@ -3428,6 +3431,8 @@ static int __bpf_strcasecmp(const char *s1, const=
 char *s2, bool ignore_case)
> >                       return c1 < c2 ? -1 : 1;
> >               if (c1 =3D=3D '\0')
> >                       return 0;
> > +             if (len < XATTR_SIZE_MAX && i =3D=3D len - 1)
> > +                     return 0;
> Maybe rewrite this loop next way: u32 max_sz =3D min_t(u32,
> XATTR_SIZE_MAX, len); for (i=3D0; i < max_sz; i++) { ... } if (len <
> XATTR_SIZE_MAX) return 0; return -E2BIG; This way we eliminate that
> entire if statement from the loop body, which should be positive for
> performance.
> >               s1++;
> >               s2++;
> >       }
> > @@ -3451,7 +3456,7 @@ static int __bpf_strcasecmp(const char *s1, const=
 char *s2, bool ignore_case)
> >    */
> >   __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> >   {
> > -     return __bpf_strcasecmp(s1__ign, s2__ign, false);
> > +     return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX)=
;
> >   }
> >
> >   /**
> > @@ -3469,7 +3474,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, =
const char *s2__ign)
> >    */
> >   __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__i=
gn)
> >   {
> > -     return __bpf_strcasecmp(s1__ign, s2__ign, true);
> > +     return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
> > +}
> > +
> > +/*
> > + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
> > + * @s1__ign: One string
> > + * @s2__ign: Another string
> > + * @len: The maximum number of characters to compare
> Let's also add that len is limited by XATTR_SIZE_MAX
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
> >   }
> >
> >   /**
> > @@ -4521,6 +4545,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_IT=
ER_DESTROY | KF_SLEEPABLE)
> >   BTF_ID_FLAGS(func, __bpf_trap)
> >   BTF_ID_FLAGS(func, bpf_strcmp);
> >   BTF_ID_FLAGS(func, bpf_strcasecmp);
> > +BTF_ID_FLAGS(func, bpf_strncasecmp);
> >   BTF_ID_FLAGS(func, bpf_strchr);
> >   BTF_ID_FLAGS(func, bpf_strchrnul);
> >   BTF_ID_FLAGS(func, bpf_strnchr);
>

