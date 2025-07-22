Return-Path: <bpf+bounces-64029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BCCB0D886
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F5256047A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C79289811;
	Tue, 22 Jul 2025 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTryDRHb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D532E3B09
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184856; cv=none; b=gaR328Zu48yn1TFZh4KX1BrFc9cQqB8I6Tn7I25AG/s1120u+ZcLpsoNcH6na23qNESXPjfLb7uP2+DbwsF72vATwp3BxTIHGHuThAF4zvK8BCI5JSnW5daWhdiAnlmZF8ekfr+moYhjAVdTSUMF7ydZ+mT6zFO9PAfCeAiq/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184856; c=relaxed/simple;
	bh=IYd2SVQO/88yZZDYLARly/OQimi/YXd+JziGESCzFGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIps/s+NfMwhyDC06x3dip6YFVCyloOfoHZ/t4QfbNjV/JXRqiwI/73ZVk3fExeRkLl8pFP4EzTTXm7ZaZvtv91Cp7gIob1VCWpkajghHFe5EjCbfi6zi+jxuHumjYjk49Ga5pMccTHlUmsZ9wijl1SL70QtvhNReo2n8mXsHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTryDRHb; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so26928656d6.1
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184854; x=1753789654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHMdnk+Wpd6f3kSGFKIIMTs7gzct/9V5bz3hnN7QYxg=;
        b=LTryDRHbWbw74KBCJzIr/WpTEJk1R47+PZX7Evj9yYkWIJVa4yvB4KefJ6jpN40Fvz
         OkNCIt5WQX5Gd1pnaAN0JMd0dp4xedOcZY/t8vo6tcOpn8ipdPXH4k+8Tw/1E/G3E4Bq
         fmFw2gX26x/FT4MC2b8qxjCS7JiBQYreaP6pumXwSucNpOw/TkB4YbvuI4+ce1VLJvZf
         TpCpKPHTVkQln2vVIRuk/V4yIhU5PYF4GaF92DyyXj4VT7QoY+Y+/dRVMfegsbSEk+WY
         v/x7MAc+4VL2IZg7Y9puOKmRWSrMGkKDbTHn4aJLBAeWSSm1cJuo5bLwr4STCFGOr2lQ
         dzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184854; x=1753789654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHMdnk+Wpd6f3kSGFKIIMTs7gzct/9V5bz3hnN7QYxg=;
        b=mA2L8UYMtft45nxZSrBGTblngx2pQXB9/1KWYKmW/87VU/Ggu3YoqfkdeXrdiN+7+v
         OA/08wFcrR7tiyq4OvZ3dlId+nbpUNjVC+PkHiF/5u5zp644LOABPj98Fg2ZYMUDNz6c
         JUu49H47tha9XSD7TZ7VrES5xdAKjo2QCfYxo+C2yWoZ9lwm+X+kltDAI0PrKAUrHm7z
         +vqwXV8m42i32vgtlyj4KsDETMa5coKXds3HC+pm6HSQff2cwyvrd5aiYN+E03dBhRfb
         JvBP+s9zou1YMV2PkZqiroWd/ELMuAhJ3yDw7hM3D9iHar47nu/qcnP4c/ZXOF7gZIIi
         pfWw==
X-Forwarded-Encrypted: i=1; AJvYcCUmgc7dmmYFvV0KQ563Pbf6NbRmBhgT1gzfX5XV5KIixgUtWwTIZ3zTdghGxqtndFlS9go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoal4hFN7p9MMvD0OIjfb4ReOPO/32CjYcY64ycOef6S9E/xDz
	/yGXvxnVLK7WLpLjI3URN0P0TN7U78B0Gt1McgJunKQlXoO+WFFWPxxviu0hGX/WgZY81hVBn9e
	TypBT3ZanNoAJb9kWipP3R427zykZ6a4=
X-Gm-Gg: ASbGncutsC81NXlZ1PNq00nEpPOhps8E7NFBRDbZZigrMDQmWgraZUj5hIKo4U48QAE
	61e59ZWA7jnjqAN0fpzETgCg06f7+A/rVqMyOha7hRelxVOfqV6LcP/jXzkzNKRVJQFaDyW+q1t
	QtoQIAUnRhi9WNSnIOpwhZ9+z9kA4e8szeCGdibGOidjThFigY81bLjECnopr0mgHz8ScjBxG24
	wD8GN5jVu3HS1yAS+U=
X-Google-Smtp-Source: AGHT+IHMsfJpOeMbShkuBIEq7YspBbQUww6KaCi2GGNbFFrWA5JDg3RbIc56D8Yebt1J1J2lKqY2ZNgLOPy5QC3Dtzg=
X-Received: by 2002:a05:6214:248f:b0:700:c179:f57c with SMTP id
 6a1803df08f44-704f6aebc0cmr396330066d6.38.1753184853948; Tue, 22 Jul 2025
 04:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
 <CALOAHbD2-f5CRXJy6wpXuCC5P9gqqsbVbjBzgAF4e+PqWv0xNg@mail.gmail.com>
 <9bc57721-5287-416c-aa30-46932d605f63@redhat.com> <CALOAHbBoZpAartkb-HEwxJZ90Zgn+u6G4fCC0_Wq-shKqnb6iQ@mail.gmail.com>
 <87a54cdb-1e13-4f6f-9603-14fb1210ae8a@redhat.com> <CALOAHbA5NUHXPs+DbQWaKUfMeMWY3SLCxHWK_dda9K1Orqi=WA@mail.gmail.com>
 <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com>
In-Reply-To: <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 22 Jul 2025 19:46:57 +0800
X-Gm-Features: Ac12FXxSR7-gHde2KyZLRLKo9WLpXSMnnby4hUqghVR5k92W9pAaQcWWQqjIMEY
Message-ID: <CALOAHbDMxVe6Q1iadqDnxrXaMbh8OG7rFTg0G7R8nP+BKZ9v6g@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 3:28=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.07.25 04:40, Yafang Shao wrote:
> > On Sun, Jul 20, 2025 at 11:56=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >>>>
> >>>> We discussed this yesterday at a THP upstream meeting, and what we
> >>>> should look into is:
> >>>>
> >>>> (1) Having a callback like
> >>>>
> >>>> unsigned int (*get_suggested_order)(.., bool in_pagefault);
> >>>
> >>> This interface meets our needs precisely, enabling allocation orders
> >>> of either 0 or 9 as required by our workloads.
> >>>
> >>>>
> >>>> Where we can provide some information about the fault (vma
> >>>> size/flags/anon_name), and whether we are in the page fault (or in
> >>>> khugepaged).
> >>>>
> >>>> Maybe we want a bitmap of orders to try (fallback), not sure yet.
> >>>>
> >>>> (2) Having some way to tag these callbacks as "this is absolutely
> >>>> unstable for now and can be changed as we please.".
> >>>
> >>> BPF has already helped us complete this, so we don=E2=80=99t need to =
implement
> >>> this restriction.
> >>> Note that all BPF kfuncs (including struct_ops) are currently unstabl=
e
> >>> and may change in the future.
> >>   > > Alexei, could you confirm this understanding?
> >>
> >> Every MM person I talked to about this was like "as soon as it's
> >> actively used out there (e.g., a distro supports it), there is no way
> >> you can easily change these callbacks ever again - it will just silent=
ly
> >> become stable."
> >>
> >> That is actually the biggest concern from the MM side: being stuck wit=
h
> >> an interface that was promised to be "unstable" but suddenly it's
> >> not-so-unstable anymore, and we have to support something that is very
> >> likely to be changed in the future.
> >>
> >> Which guarantees do we have in the regard?
> >>
> >> How can we make it clear to anybody using this specific interface that
> >> "if you depend on this being stable, you should learn how to read and
> >> you are to blame, not the MM people" ?
> >
> > As explained in the kernel document [0]:
> >
> > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
> > of the strict stability restrictions associated with kernel <-> user
> > UAPIs. This means they can be thought of as similar to
> > EXPORT_SYMBOL_GPL, and can therefore be modified or removed by a
> > maintainer of the subsystem they=E2=80=99re defined in when it=E2=80=99=
s deemed
> > necessary.
> >
> > [0] https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expecta=
tions
> >
> > That said, users of BPF kfuncs should treat them as inherently
> > unstable and take responsibility for verifying their compatibility
> > when switching kernel versions. However, this does not imply that BPF
> > kfuncs can be modified arbitrarily.
> >
> > For widely adopted kfuncs that deliver substantial value, changes
> > should be made cautiously=E2=80=94preferably through backward-compatibl=
e
> > extensions to ensure continued functionality across new kernel
> > versions. Removal should only be considered in exceptional cases, such
> > as:
> > - Severe, unfixable issues within the kernel
> > - Maintenance burdens that block new features or critical improvements.
>
> And that is exactly what we are worried about.
>
> You don't know beforehand whether something will be "widely adopted".
>
> Even if there is the "A kfunc will never have any hard stability
> guarantees." in there.
>
> The concerning bit is:
>
> "kfuncs that are widely used or have been in the kernel for a long time
> will be more difficult to justify being changed or removed by a
> maintainer. "
>
> Just no. Not going to happen for the kfuncs we know upfront (like here)
> will stand in our way in the future at some point and *will* be changed
> one way or another.
>
>
> So for these kfuncs I want a clear way of expressing "whatever the
> kfuncs doc says, this here is completely unstable even if widely used"

This statement does not conflict with the BPF kfuncs documentation, as
it explicitly states:
"This means they can be thought of as similar to EXPORT_SYMBOL_GPL,
and can therefore be modified or removed by a maintainer of the
subsystem they're defined in when deemed necessary."

There is no question that subsystem maintainers have the authority to
remove kfuncs. However, the reason I raised the issue of removing
widely used kfuncs is to highlight the recommended practice:
- First mark the kfunc as KF_DEPRECATED.
- Remove it in the next development cycle.

While this is not a strict requirement=E2=80=94maintainers can remove kfunc=
s
immediately without deprecation=E2=80=94following this guideline helps avoi=
d
unnecessary disruptions for users.

--=20
Regards
Yafang

