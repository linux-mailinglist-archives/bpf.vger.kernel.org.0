Return-Path: <bpf+bounces-66783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75446B393A0
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8543A75EE
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2F6253934;
	Thu, 28 Aug 2025 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUXfCvhS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D03597C;
	Thu, 28 Aug 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361376; cv=none; b=DFZD3jcUTliSn47HkqwHXvAtB5oMEpvQBl3/bSjY001Ct8UmT25Eunr7A3NiwD/SddTlfJwE4M9Wj4Zilu33C84nsHOZdBcIYybOmgRX+sXdBxs/D7uiE8MDC77KC2va6jzpImk3Xs3qEfJPVOI7ztGty5V7N4vZRAsnMoGJVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361376; c=relaxed/simple;
	bh=TRye7ER/IIv0vGH5KBCn9DndSSIuH71N4Qjlj8YUhOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLeHJJJvY2FVLH8EqFVphm1KXnfiDwbTeqHBJxNVseQvwslw8H/rgOLEv8ILmMxe0ic+7zWSOYX24j4TdzMRT/MWMD8/qd/pdFLDLr/H7WpMJELqVNTpPXQjr/C+vQFnqbyRhYItnL61hYEuae66+8Iz7XqAn8m1zRDo0Zi8jnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUXfCvhS; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70deaa19d3cso6041666d6.3;
        Wed, 27 Aug 2025 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756361374; x=1756966174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irThEuCN+CJAqgmTRs026MQyU4oy4M2XOA9xvrhaZ+8=;
        b=UUXfCvhSPV6hAZUnvRn4pPYcb0622a/SSFydNlmIKxX2KmKqRCA/Vgf1KvsEZH9Wvd
         /RNrYfWupc4HvN3DkjYNe6CuuJFXpY/tEp/gnKSCIPh/3mvkJbkAfHGVanGt5d8PcVta
         HtE25YZT7BdrGM93tvVV5JfM/HLQ0/bvvH3onzRaYKnSXI3vOuTMKaBNSL9+ak2plFG3
         BJi0x2rfkR/pRnaQKeZA0ea1aC4cZftN3DXyCBtTRmcz6ko/fi37zYybvk37YF9qY0jh
         LUXnoMTmWW1MdmEIPJlrBSBzvg5/+ALS7or72fnWBw2+Kq6rPOePBW5rEYnfI6cNFTi2
         392Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756361374; x=1756966174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irThEuCN+CJAqgmTRs026MQyU4oy4M2XOA9xvrhaZ+8=;
        b=D3pVvYsk0eud9STEkJI2muwJgBDAm8plt/przBvo9+IczX9HRfr/HB9e/dIZqZlH2z
         FMg+4yhT3HHx/ygqduD9JMTd0hL7iN+bjIkNx5Lyb5R+xUR434GKTjLc6ZF1dUz9oc1N
         XVIj2kBxPSIkCFh+x0oTPojg1/4oAZUixOKhcIqiJ5/xASqNvxqwy0p9ECEoP+Aze5dd
         Pam/vD5PLD/kVHDvxmlNI4xiaLZHRh1xzXbh79lWYxxnzAYZH9LGtnvRFpQdc4GvGcpB
         OhlREIRF1/hhk0lijE9Jecxj4VgnWWyjKPzY8XImJ3Snk1xFMImhLx0u5zaQXSvYrkXc
         +bYA==
X-Forwarded-Encrypted: i=1; AJvYcCU5lk07yAfYC8e7OmHCUzA/gGGYdg1xAqKeb48Hs+yMwmOtjyVXoi89/hX6+Dr/h3aNzuo=@vger.kernel.org, AJvYcCWVw959jAPwd2Jr9dg0f+okj3fnSjYJGMaV4SZ5wsMh0lr6tuTSyXlSkD4oNWhvrZjGWBGGJao8lkIb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhc3fULrrNoqHVPrD2ifEQGA+mZAfaY58/06bROlj8m8nlBysB
	Vyfe4JTB93eBfJU15oXPgFK6nTOoPmZsYdKobQnFIq625VDNhTnrbfazTrBPproD7I6hp2C92jC
	gx7T2LcYlj02S8/CiKvJ/N5S3C9IJaT0=
X-Gm-Gg: ASbGncuWMFbNsrvbsb7iXQyRHvBdt6nE1tEnVjFSzGLGgK+my/3Wj0xhTgvCNTiA9x6
	kBElRGtEGAfPD+YEU3s6x2T0L0r6nY6tgPVS0i5vwPiF2W14L58yPqLUHcMNJjY+AOS2fpHggsv
	v19E62bk/iuSHaHIEnQvgnDr3OG6FZtcAONB62EJRJi4Z2LJYW4BT+mPwkp68bFIBBejk4Okccy
	isBA/S+r7/7uNKVZfl5xvA806qyM/0Ylw9Op1w=
X-Google-Smtp-Source: AGHT+IEcc1wPCV34Pnn1u/ZsU4Rb1aY5zTIXLY6XmNlFFcithgRKC2hL9mmp5Due2o1Ite+lHeZgHeo0cfSWEsXPL9A=
X-Received: by 2002:a05:6214:3005:b0:70d:cecb:17db with SMTP id
 6a1803df08f44-70dcecb19c9mr100573286d6.63.1756361373826; Wed, 27 Aug 2025
 23:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-11-laoar.shao@gmail.com>
 <6934188d-12a5-4225-aaa9-828878d8dba2@lucifer.local>
In-Reply-To: <6934188d-12a5-4225-aaa9-828878d8dba2@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 28 Aug 2025 14:08:57 +0800
X-Gm-Features: Ac12FXxzyoO7MGOQ-T37czdAMJrKQyvMPOFtYB1ymhcClovTUHLiAKI7h86q2_U
Message-ID: <CALOAHbCys+iz_8fwsPPZjqp+Y4+KMRbizPsjApX+v1JVGTy3oA@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 10/10] MAINTAINERS: add entry for BPF-based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:47=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Aug 26, 2025 at 03:19:48PM +0800, Yafang Shao wrote:
> > Add maintainership entry for the experimental BPF-driven THP adjustment
> > feature. This experimental component may be removed in future releases.
> > I will help with maintenance tasks for this feature during its developm=
ent
> > lifecycle.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 390829ae9803..71d0f7c58ce8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16239,6 +16239,7 @@ F:    Documentation/admin-guide/mm/transhuge.rs=
t
> >  F:   include/linux/huge_mm.h
> >  F:   include/linux/khugepaged.h
> >  F:   include/trace/events/huge_memory.h
> > +F:   mm/bpf_thp.c
> >  F:   mm/huge_memory.c
> >  F:   mm/khugepaged.c
> >  F:   mm/mm_slot.h
> > @@ -16246,6 +16247,15 @@ F:   tools/testing/selftests/mm/khugepaged.c
> >  F:   tools/testing/selftests/mm/split_huge_page_test.c
> >  F:   tools/testing/selftests/mm/transhuge-stress.c
> >
> > +MEMORY MANAGEMENT - THP WITH BPF SUPPORT
> > +M:   Yafang Shao <laoar.shao@gmail.com>
> > +L:   bpf@vger.kernel.org
> > +L:   linux-mm@kvack.org
> > +S:   Maintained
> > +F:   mm/bpf_thp.c
> > +F:   tools/testing/selftests/bpf/prog_tests/thp_adjust.c
> > +F:   tools/testing/selftests/bpf/progs/test_thp_adjust*
> > +
>
> Sorry but I don't agree with a separate section for this.
>
> This should form part of the THP section only, I don't think it's warrant=
ed to
> do elsewise.

I initially added it as a separate entry to ensure that
bpf@vger.kernel.org would be CCed. However, I discovered that any file
containing =E2=80=9Cbpf=E2=80=9D will automatically CC that list. Therefore=
, it=E2=80=99s fine
to include this under the THP entry instead.


--=20
Regards
Yafang

