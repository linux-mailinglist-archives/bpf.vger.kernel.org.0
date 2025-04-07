Return-Path: <bpf+bounces-55411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6306A7E2B1
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEE3A5831
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC231DE4FE;
	Mon,  7 Apr 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwwYeR7t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DBF1D63E3;
	Mon,  7 Apr 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037275; cv=none; b=BN9kTlfMwPkeEnghiq6FRXq9LqDoQF8LjoFTBfIS2hOjDXjjY5m1cbSqAkwTr2WgO3Z2ROht27kPsk00vQNnQvYEZ/IU7AgEIy2LD1V91JssS7WYKL2vL+PJmkRgJGBBCBQqsuQ6R4lUeahabjj+Y2dcLLEgS/Ny+3ycnYwFu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037275; c=relaxed/simple;
	bh=jMQok4bI/T4dhLvUWRdv1DnEVtFmsxjwBAn6siWlnEA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NAJg5LpSL6zNh0bACpL5IJQDGfQM5oB6RIL3i1YlbOkR2qCUXjjEtCXYttoAzn3W2OhxZQh1hcTTftO04iUhzgC1vPpiKaoI1+xGnmFoWRaN1mfWawvP8M/GUt1NsuVujkzwZSorCQMIP2C3ELxRYiArwtP6UXorISHlDeuQNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwwYeR7t; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c55500d08cso421732485a.0;
        Mon, 07 Apr 2025 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744037271; x=1744642071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X767fjj47FPwYyXKcTrgC1NJknM42/VvvzcA6XsLN0U=;
        b=cwwYeR7t947ki4HuCogZ279igVyFN+VqlUvRvzU7zNoNLIHUhTaYYZZHdbqVA5iDT7
         gy8Af8bTdh8qRj7+hXlwoegz7oqPpN74QZ9Xn6ZccehB7vDkGLawUhXwu0WOThu7Jjvp
         Fe4fyIfbIptcFiHO0yGYDLTpMAKiIIkafIInj7H/dQDQH34nxr1vqpA1FDRKjKEGeBuS
         IXn5jcqzxIaxueI6xg1qy3jTsiyIiidhhZff5zFrnqZ48gq2rDTH/FUeafE5kYCuG8b5
         BQBz8RZ6/i7JlK6pQoajUcO3u8jLarEbv7kwnEDB/dJw7Vg6QYw/i8XN+CK6SAM1/3uu
         d5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037271; x=1744642071;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X767fjj47FPwYyXKcTrgC1NJknM42/VvvzcA6XsLN0U=;
        b=bK+om1HtlXT7a/D0stkwBbYSU9J/4ROdxjn9jiab0xPSJ1wH0Nh/8/PJsNbOkx3eli
         XBXFV6O5Uq7FK3y/62DbT+2UX/ka1sqTzHGlAQmLIarbk9a9VWU44mXBYgufpyLb4iKC
         +G+n5FylECm8LD4BaIQN+/EeAyUznQw8VJSVzMKLDPLPPtbOGco78yYgfx6mMQg7fpY+
         eHoh8TF4MBVwEwAC+91Vvvdx4TwUP1T2zi/aw0aJAzL6lOvu+cH/ORk7RV+3iVSt5Vzq
         f3O4QP+8OoEPxwOtL2wjM4CYmVo/3NzXsdJ0rljwY6Y/VHC2Evb8rYb40E4cVGdjovgK
         i1QA==
X-Forwarded-Encrypted: i=1; AJvYcCXi/e8ymJSsz6HhtpQfw1JwS0AhzxvpsJ/Quu98YAYfhqJqwLhU4E831+gjvaXYOPY2NAyfxWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3HJHqwI7cajpilWEdwLXdX1TQv3+gQX2dJFC+RaZ2RYynEn5W
	bwwgGR1xmL7N2Y+kT1Vmc4yPmuklp89ReU450jHHQTEXOgK9EDmd
X-Gm-Gg: ASbGncsj7c5MFF8mH1MxhVmY2Es9gKJFtGGBZkJrXPDfTiXUtKajPSQrRwQWiOAhs/N
	IhhsnFdNnapfdaEx8X53aYSALEZEPNcfIstab5rR4x6B5QsHPM0mPd1BqAAbD+u//33MMx8Nscj
	oRfwLPlkJXtL79uQO5GD6to0r8I3Hz44WBNx0e6Btak/cNBnvzQCrlPj40qSgcUO0GDlP/DgNeH
	4ZrTq1qmPXrMGGdvQFMwcTtkZFD70oLEz8BOQMjViUFXh/uOUzrexFnpFiYw8v8DhrmJhUT56Jt
	c5pOLYS5B4oYNL5lUR/G0viOIqOY98NMER5zuYxLS6jd7BMko4r8R8SJT3jt9c56E2Dt+eciis6
	xgiVBDlIQGKZtCL/LihVhDg==
X-Google-Smtp-Source: AGHT+IGMGOsQYFoVCy+52vIhT3YVFRKSZf1Q+J0v5pK2L+x6izt+zc3CtZ1x6xUiYrSt4o3ZoxKDhg==
X-Received: by 2002:a05:620a:4549:b0:7c5:a575:75da with SMTP id af79cd13be357-7c77dd441aemr1320460785a.6.1744037271089;
        Mon, 07 Apr 2025 07:47:51 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e7354bdsm605792985a.20.2025.04.07.07.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:47:50 -0700 (PDT)
Date: Mon, 07 Apr 2025 10:47:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 ast@kernel.org, 
 john.fastabend@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 Matt Moeller <moeller.matt@gmail.com>
Message-ID: <67f3e596284c9_38ecd329498@willemb.c.googlers.com.notmuch>
In-Reply-To: <98b2c012-dcbe-4abf-8b22-2ab37604ccc8@iogearbox.net>
References: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
 <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com>
 <584071a3-10df-443a-ad8c-1fa7bc82d821@iogearbox.net>
 <CAF=yD-+ccY58AAneA7tLokuUahrj=8cdDtPPopGH0h8mK-hMbQ@mail.gmail.com>
 <CANP3RGdQNt5Qn9APrUh7V+r2RKoBx9KtzpDfres0wf+UZMeedg@mail.gmail.com>
 <98b2c012-dcbe-4abf-8b22-2ab37604ccc8@iogearbox.net>
Subject: Re: [PATCH bpf v2 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb
 frags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann wrote:
> On 4/4/25 7:56 PM, Maciej =C5=BBenczykowski wrote:
> > On Fri, Apr 4, 2025 at 9:34=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> >> On Fri, Apr 4, 2025 at 12:11=E2=80=AFPM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> >>>
> >>> Hi Willem,
> >>>
> >>> On 4/4/25 4:23 PM, Willem de Bruijn wrote:
> >>> [...]
> >>>> v1->v2
> >>>>     - introduce bfp_skb_load_helper_convert_offset to avoid open c=
oding
> >>>> ---
> >>>>    include/linux/filter.h |  3 --
> >>>>    kernel/bpf/core.c      | 21 -----------
> >>>>    net/core/filter.c      | 80 +++++++++++++++++++++++------------=
-------
> >>>>    3 files changed, 44 insertions(+), 60 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
> >>>> index f5cf4d35d83e..708ac7e0cd36 100644
> >>>> --- a/include/linux/filter.h
> >>>> +++ b/include/linux/filter.h
> >>>> @@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struc=
t sock_filter *ftest)
> >>>>        }
> >>>>    }
> >>>>
> >>>> -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *=
skb,
> >>>> -                                        int k, unsigned int size)=
;
> >>>> -
> >>>>    static inline int bpf_tell_extensions(void)
> >>>>    {
> >>>>        return SKF_AD_MAX;
> >>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >>>> index ba6b6118cf50..0e836b5ac9a0 100644
> >>>> --- a/kernel/bpf/core.c
> >>>> +++ b/kernel/bpf/core.c
> >>>> @@ -68,27 +68,6 @@
> >>>>    struct bpf_mem_alloc bpf_global_ma;
> >>>>    bool bpf_global_ma_set;
> >>>>
> >>>> -/* No hurry in this branch
> >>>> - *
> >>>> - * Exported for the bpf jit load helper.
> >>>> - */
> >>>> -void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *=
skb, int k, unsigned int size)
> >>>> -{
> >>>> -     u8 *ptr =3D NULL;
> >>>> -
> >>>> -     if (k >=3D SKF_NET_OFF) {
> >>>> -             ptr =3D skb_network_header(skb) + k - SKF_NET_OFF;
> >>>> -     } else if (k >=3D SKF_LL_OFF) {
> >>>> -             if (unlikely(!skb_mac_header_was_set(skb)))
> >>>> -                     return NULL;
> >>>> -             ptr =3D skb_mac_header(skb) + k - SKF_LL_OFF;
> >>>> -     }
> >>>> -     if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(s=
kb))
> >>>> -             return ptr;
> >>>> -
> >>>> -     return NULL;
> >>>> -}
> >>>
> >>> Wouldn't this break sparc 32bit JIT which still calls into this?
> >>>
> >>> arch/sparc/net/bpf_jit_asm_32.S :
> >>>
> >>> #define bpf_negative_common(LEN)                        \
> >>>           save    %sp, -SAVE_SZ, %sp;                     \
> >>>           mov     %i0, %o0;                               \
> >>>           mov     r_OFF, %o1;                             \
> >>>           SIGN_EXTEND(%o1);                               \
> >>>           call    bpf_internal_load_pointer_neg_helper;   \
> >>>            mov    (LEN), %o2;                             \
> >>>           mov     %o0, r_TMP;                             \
> >>>           cmp     %o0, 0;                                 \
> >>>           BE_PTR(bpf_error);                              \
> >>>            restore;
> >>
> >> Argh, good catch. Thanks Daniel.
> >>
> >> I'll drop the removal of bpf_internal_load_pointer_neg_helper from t=
he patch.
> > =

> > add a 'deprecated only used by sparc32 comment'
> > =

> > hopefully someone that knows sparc32 assembly can fix it
> =

> Alternatively, the bpf_internal_load_pointer_neg_helper() could be move=
d entirely
> over into arch/sparc/net/ so that others won't be tempted to reuse.

I'd prefer to keep it as is.

I took a stab, but my Debian has no sparc32 gcc cross compiler anymore,
and I was unable to cross compile with clang either.=

