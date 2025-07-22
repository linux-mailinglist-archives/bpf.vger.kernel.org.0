Return-Path: <bpf+bounces-63992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F5B0CFCF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 04:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6FD6C1D3C
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043211DE4D2;
	Tue, 22 Jul 2025 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw3GPzNR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009601537DA
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152054; cv=none; b=mJrLQUkwdjB23TNq+wyuxmbqbPo5ccx7rBLLL/gAppdvbSZpQUqeXi1fo6JS7tMfGFlOv9S0SHbks4KSvaT3ARBP8FX6Z0ydn5qFZiufz+BCnh9EW2aYAFzzc0MXaR4nYfnwAeMMjRcsp68F5KwU4XHJXS9wIa5OMmVsHg3dvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152054; c=relaxed/simple;
	bh=KsPSj/xRUpj3SHXspK9YNHuG/ej0KmBUTM+N8NCDDec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOp7UK89SRefy7VGZ3ffX+vJY+SaKebmH8hqSVw6Hjsf+DQSzX0zIIAC7gMCL8YA4Vbd1tBfLwyKSC+bsH5tee5ztpMkt3iLTaNFtsf3+O77LeKjQ9cTkqRfepuWH2aBGRasG60uSP8WXM1/CVvJim/89qOAjASmfLKi255Ypj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw3GPzNR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so54121396d6.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753152052; x=1753756852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W8/b7p/THTjwlcU+35tCprs1mFDM/79Tl9WX9u/Ei0=;
        b=Gw3GPzNRwADtan2QGTSx8IyCN52TeNTslhDBSZAqjVXa1nDkDAIbWZGPJ/sZwKqiwp
         ok9MbPzm0fdbAHhWe1p8Y7zzVUr1qKmp5xC24BBg6u/SL/SngiGTtztd6lKnN20X4rAW
         YIXiTzL+q+ytuB9RjDk2ruS6vsTpTmKNtPqMJSd0ISqGIQpjeFJkOp2Eu1CRYV4ngJl2
         8B/9QuH2l0N+3x/D8Wk6oA0YE7SnNd3rsecztYUMmYpbbG83FdO9AB7pAOWy1hnvsEGo
         0xsCLK9T5hGsJArOxEboS8k110yaZNly+pMuGVvkygoC8IrbZT1Uga5SKhwNnjPADcUG
         glEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753152052; x=1753756852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W8/b7p/THTjwlcU+35tCprs1mFDM/79Tl9WX9u/Ei0=;
        b=m7E9WVqT1RoIdJi/CY8BtYFc79wmG6uWcclDw0hFMVvHfQusPyDTKUmRcmhZsQNFw9
         sHZxNCzEM+6n+0Qr22G9M3jZOC1bTAM+6Y0m95GE7sMQtt3ZhMZcK95BkJUa1xjiQEXT
         NnkvZQWhaUyRVAJl/bmOCOuYK48Hu0ZpgSbzBH2cy1wObRr4YDd9qmj7ewQHVXT0Zds2
         l+a1YbItGGC3yyCxzU/dAURg6KgKRPoEB/hbr4RE0MDhqqyUaeZ1pKvPyQtUl3CUYpRf
         eF90kwgBcJ6R2aiyK9AkayWxZBNuINJF8tejidtiY2awguG7jJaZ1kLWkiY1Uokb1/X0
         /Adw==
X-Forwarded-Encrypted: i=1; AJvYcCUr0/7ZZ9YArmSJc/P7FCc4m474VpYfSkU9ZbvX3OcqJUTEPieQBd996Dn4Mqf/XwLozyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEt4GdOjVdndvtK/CCDKMb0qoax6djrtWqiT+lgFfNPoT6gATk
	Hcm44VTYGEjxsZM8z+lKvRfvMnLaHTjW8LwJWUnWldc5Q0Ne+svo1N7NoGXizIPahtOQIi4aGIi
	eQ4MbLchsIfhXTWo/n6W0DPkxy5E+8tg=
X-Gm-Gg: ASbGncvLUbUmnFOnzF++D5iuVx1NBfGgJ2+C7yXJL5h1NC48s5+IQa/bo6oQ0t5y2Nn
	AB+3Y65jumUP/PbVmGwRA43Y4zlJCmuV5lDfeBclhN74xSMhyyNmxGwAfjG7+RpSZ5/Lb/T6Cnh
	knP1dW/eiDG/vGfOiEkaG73JDkItZ/diooxMK+jm6tkcg6LwczeyYyQQEWx9R1PDwaRxBhU/9l7
	6KcqwE2
X-Google-Smtp-Source: AGHT+IEGWFc201OyQh04zD480T7nLL8ld9y00onwVtnc0nArBfd69dvJsFvqfwm8DoluqHOeJey2scLqr/2WpdHRZh0=
X-Received: by 2002:a05:6214:c6e:b0:6fb:4e82:6e8 with SMTP id
 6a1803df08f44-704f6afc20fmr297088226d6.14.1753152051717; Mon, 21 Jul 2025
 19:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com> <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
 <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com>
In-Reply-To: <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 22 Jul 2025 10:40:15 +0800
X-Gm-Features: Ac12FXzqG_f9FxqCQ-Us7PIuGLnDR8UZt_AhkecL3qH3UEIRbE2I6E5e2BFtxm0
Message-ID: <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 11:56=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >>
> >> We discussed this yesterday at a THP upstream meeting, and what we
> >> should look into is:
> >>
> >> (1) Having a callback like
> >>
> >> unsigned int (*get_suggested_order)(.., bool in_pagefault);
> >
> > This interface meets our needs precisely, enabling allocation orders
> > of either 0 or 9 as required by our workloads.
> >
> >>
> >> Where we can provide some information about the fault (vma
> >> size/flags/anon_name), and whether we are in the page fault (or in
> >> khugepaged).
> >>
> >> Maybe we want a bitmap of orders to try (fallback), not sure yet.
> >>
> >> (2) Having some way to tag these callbacks as "this is absolutely
> >> unstable for now and can be changed as we please.".
> >
> > BPF has already helped us complete this, so we don=E2=80=99t need to im=
plement
> > this restriction.
> > Note that all BPF kfuncs (including struct_ops) are currently unstable
> > and may change in the future.
>  > > Alexei, could you confirm this understanding?
>
> Every MM person I talked to about this was like "as soon as it's
> actively used out there (e.g., a distro supports it), there is no way
> you can easily change these callbacks ever again - it will just silently
> become stable."
>
> That is actually the biggest concern from the MM side: being stuck with
> an interface that was promised to be "unstable" but suddenly it's
> not-so-unstable anymore, and we have to support something that is very
> likely to be changed in the future.
>
> Which guarantees do we have in the regard?
>
> How can we make it clear to anybody using this specific interface that
> "if you depend on this being stable, you should learn how to read and
> you are to blame, not the MM people" ?

As explained in the kernel document [0]:

kfuncs provide a kernel <-> kernel API, and thus are not bound by any
of the strict stability restrictions associated with kernel <-> user
UAPIs. This means they can be thought of as similar to
EXPORT_SYMBOL_GPL, and can therefore be modified or removed by a
maintainer of the subsystem they=E2=80=99re defined in when it=E2=80=99s de=
emed
necessary.

[0] https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expectation=
s

That said, users of BPF kfuncs should treat them as inherently
unstable and take responsibility for verifying their compatibility
when switching kernel versions. However, this does not imply that BPF
kfuncs can be modified arbitrarily.

For widely adopted kfuncs that deliver substantial value, changes
should be made cautiously=E2=80=94preferably through backward-compatible
extensions to ensure continued functionality across new kernel
versions. Removal should only be considered in exceptional cases, such
as:
- Severe, unfixable issues within the kernel
- Maintenance burdens that block new features or critical improvements.

--=20
Regards
Yafang

