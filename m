Return-Path: <bpf+bounces-64031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DC7B0D8A2
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59FA3A84A3
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C42E2664;
	Tue, 22 Jul 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEnpt4GT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E949659
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185422; cv=none; b=TzgvrUCOUpdVaFwwK8XAsTL2TuyVRXzRHzaQ4BL3LzL6R6HzCWwzx9zeUJF8d/WI2WLyAW0GRDkQW/Nenz2/tl99zCXcaHCKjhtP+aVGGrGtbU/fVkOGDYX++4tJ4cpmSTt7cN3KAdwzMLhV+XWSNS0b+WMLbt/IyPsYy0LwLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185422; c=relaxed/simple;
	bh=y0ytaNf651uonOqQdp1de8aL1hgIee8Q+F3WsdNftL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+HgSvu6Uuxr2HN5xecChMAenmj2VHwb3hjLPNjOCjpQZTNKlnXNG7eeEag2aTqTD+fV//TNA9iOUej+yTgJHZmLfgC7m3BrqoHP6J77o4epfnmueE8+20+jcyDFOtItUbHpJdlX20gxaK7Xyys3FBOfLKcAWfoOzNVZW08so+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEnpt4GT; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-704c5464aecso48904516d6.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753185419; x=1753790219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAu9Q3wdTUMBywT15N41N2ULwt+qnhp1KmLYaWOMhuA=;
        b=GEnpt4GTXVfkPe/2M9EcYAlcRvxoKb6zbslOOjVSgG2VxGCUwFqGH9ddwGSr0RvNQC
         kGRAKag5IDwCOTOk9/pis2JOcuHm+C7L7jjxHj7w5z+rBFsLyyiQQNQo4oINwpuAr8as
         FF9piCEKdScTJVaF5Q2uuHpEV4QCr/8eGZKPZHwSCovdP6kBvazZQGH+gS/VIkDR2tOE
         l92TfYErLorO09doKdXC/VcPoYkMnLEnW589Oj0xQgKC/IyKrkoFmqFQr3WtmdOOKwPs
         FwHY4zR+sLtZVi/+/iXU0VLLPsjP0HCAgWdSaK37AtmYUxRyUlJbk6Fkc3QQiuo9D1ja
         L63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185419; x=1753790219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAu9Q3wdTUMBywT15N41N2ULwt+qnhp1KmLYaWOMhuA=;
        b=jrG10GTZXI5ZmDf8pGxDpvk/32Zl4/ZYj35GLQpFkL107qAosZME6ZyQNeSsn5L4Se
         i1bmOGb1pG7boMorSTeIEFzY1Et4B9tFafellBJbxhrF3IxVxko2YiLWNJuztI0hcsrU
         ND+xFaIub8BTIZbDcxO7BI0Gj/ROLkYGtLHN2SPmS9kUzu8SUyjw/mXOITtKETNXImtw
         OMCgWi5zt9walXPvHd7nDngReQPaL1M8rTVkbdahXT3tZi3WFcqBRLZotVIIegKfa4YO
         1eSX095Ewnu4ukoOwhXyveEWu9h6rjkXO9IYst0odeZztEASA/a89i4ttRKkRDVUO29E
         sF9A==
X-Forwarded-Encrypted: i=1; AJvYcCUNhnxja1CuAwl1GbjSVyCTV7tBW1qQLfGBkQIVEffMY7gdZBmiUOdDipB7HI6896nzCR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz068mqbQRfUPQ9QTPjWx/PRf5/nUxaS8YNalpkjtmHlw0Zh+Nj
	dCjwpu5MnP7FNvMrzUJsiFSeg+AsNaaB1eztdNdCAYJ4SnU29vZT9iqngSYCRlB/oNvteI0oabC
	KD1WzNjuMK/OIBxMKqf5ZSerouCjZpnC+q09L
X-Gm-Gg: ASbGnctFd3g7ZzPapc4BGz1r9RZSJ8eZOw8t6ZTsqczaRrZ7UujEEpOoNzZEsQuMJja
	+CGwHWuV8b+hMakN1pG/HqdN+HQDSVxiSRbjOmoHxur/RnUfXNsIfqrWbQOoLrB7pj3kv67mY8L
	mslBUKE6jvclnyfwVQedvXLhMXFNtxOzni/Y6lraU8pBmi7Z9+fHH44ir1f1hZ2hA+sBu5Xdraf
	+YU8zhV
X-Google-Smtp-Source: AGHT+IHJkX0tXmqzM7+ePtwcoHIsUI3/e7shZ1FCZbZHP0xnvUBMfX/0AXFYcMQ8BXDM5FivUtTXdMqyf13qk+kjtHI=
X-Received: by 2002:a05:6214:3d98:b0:704:8d2e:bc63 with SMTP id
 6a1803df08f44-704f6af81e4mr398867896d6.35.1753185418981; Tue, 22 Jul 2025
 04:56:58 -0700 (PDT)
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
 <404de270-6d00-4bb7-b84b-ae3b1be1dba8@redhat.com> <694a8b10-6082-44ac-8239-2c28b4ba8640@lucifer.local>
In-Reply-To: <694a8b10-6082-44ac-8239-2c28b4ba8640@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 22 Jul 2025 19:56:21 +0800
X-Gm-Features: Ac12FXw2969e8azvBtKqR8zs1YTd32pScqkTTtjLEbs3cKDdUPFnp1oztJog2k8
Message-ID: <CALOAHbBepZiORN2yLvDDQWbvom38HHvCyqAqvS7uKzQqy8zgjg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 6:09=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Jul 22, 2025 at 09:28:02AM +0200, David Hildenbrand wrote:
> > On 22.07.25 04:40, Yafang Shao wrote:
> > > On Sun, Jul 20, 2025 at 11:56=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> > > >
> > > > > >
> > > > > > We discussed this yesterday at a THP upstream meeting, and what=
 we
> > > > > > should look into is:
> > > > > >
> > > > > > (1) Having a callback like
> > > > > >
> > > > > > unsigned int (*get_suggested_order)(.., bool in_pagefault);
> > > > >
> > > > > This interface meets our needs precisely, enabling allocation ord=
ers
> > > > > of either 0 or 9 as required by our workloads.
>
> That's great to hear, and to be clear my views align with David on this -=
 I
> feel like having a _carefully chosen_ BPF interface could be valuable her=
e,
> especially in the short to medium term where it will allow us to more
> rapidly iterate on an automated [m]THP mechanism.
>
> I think one key question here is - do we want to retain a _permanent_ BPF
> hook here?
>
> In any cae, for the first experiments with this we absolutely _must_ be
> able to express that this is going away, NO, not based on whether it's
> widely used, it IS going away.

If this BPF kfunc provides clear user value with minimal maintenance
overhead, what would be the rationale for removing it? That said, if
you and David both agree it should be deprecated, I won't object -
though I'd suggest following the standard deprecation process.

>
> > > > >
> > > > > >
> > > > > > Where we can provide some information about the fault (vma
> > > > > > size/flags/anon_name), and whether we are in the page fault (or=
 in
> > > > > > khugepaged).
> > > > > >
> > > > > > Maybe we want a bitmap of orders to try (fallback), not sure ye=
t.
> > > > > >
> > > > > > (2) Having some way to tag these callbacks as "this is absolute=
ly
> > > > > > unstable for now and can be changed as we please.".
> > > > >
> > > > > BPF has already helped us complete this, so we don=E2=80=99t need=
 to implement
> > > > > this restriction.
> > > > > Note that all BPF kfuncs (including struct_ops) are currently uns=
table
> > > > > and may change in the future.
> > > >   > > Alexei, could you confirm this understanding?
> > > >
> > > > Every MM person I talked to about this was like "as soon as it's
> > > > actively used out there (e.g., a distro supports it), there is no w=
ay
> > > > you can easily change these callbacks ever again - it will just sil=
ently
> > > > become stable."
> > > >
> > > > That is actually the biggest concern from the MM side: being stuck =
with
> > > > an interface that was promised to be "unstable" but suddenly it's
> > > > not-so-unstable anymore, and we have to support something that is v=
ery
> > > > likely to be changed in the future.
> > > >
> > > > Which guarantees do we have in the regard?
> > > >
> > > > How can we make it clear to anybody using this specific interface t=
hat
> > > > "if you depend on this being stable, you should learn how to read a=
nd
> > > > you are to blame, not the MM people" ?
> > >
> > > As explained in the kernel document [0]:
> > >
> > > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
> > > of the strict stability restrictions associated with kernel <-> user
> > > UAPIs. This means they can be thought of as similar to
> > > EXPORT_SYMBOL_GPL, and can therefore be modified or removed by a
> > > maintainer of the subsystem they=E2=80=99re defined in when it=E2=80=
=99s deemed
> > > necessary.
>
> I find this documentation super contradictory. I'm sorry but you can't
> have:
>
> "...can therefore be modified or removed by a maintainer of the subsystem
>  they=E2=80=99re defined in when it=E2=80=99s deemed necessary."
>
> And:
>
> "kfuncs that are widely used or have been in the kernel for a long time
> will be more difficult to justify being changed or removed by a
> maintainer."
>
> At the same time. Let alone:
>
> "A kfunc will never have any hard stability guarantees. BPF APIs cannot a=
nd
> will not ever hard-block a change in the kernel purely for stability
> reasons"
>
> Make your mind up!!
>
> I mean the EXPORT_SYMBOL_GPL() example isn't accurate AT ALL - we can
> _absolutely_ change or remove those _at will_ as we don't care about
> external modules.
>
> Really this seems to be saying, in not so many words, that this is
> basically a kAPI and you can't change it.
>
> So this strictly violates what we need here.

The maintainers have the authority to make the final determination ;-)
>
>
> > >
> > > [0] https://docs.kernel.org/bpf/kfuncs.html#bpf-kfunc-lifecycle-expec=
tations
> > >
> > > That said, users of BPF kfuncs should treat them as inherently
> > > unstable and take responsibility for verifying their compatibility
> > > when switching kernel versions. However, this does not imply that BPF
> > > kfuncs can be modified arbitrarily.
> > >
> > > For widely adopted kfuncs that deliver substantial value, changes
> > > should be made cautiously=E2=80=94preferably through backward-compati=
ble
> > > extensions to ensure continued functionality across new kernel
> > > versions. Removal should only be considered in exceptional cases, suc=
h
> > > as:
> > > - Severe, unfixable issues within the kernel
> > > - Maintenance burdens that block new features or critical improvement=
s.
> >
> > And that is exactly what we are worried about.
> >
> > You don't know beforehand whether something will be "widely adopted".
> >
> > Even if there is the "A kfunc will never have any hard stability
> > guarantees." in there.
> >
> > The concerning bit is:
> >
> > "kfuncs that are widely used or have been in the kernel for a long time=
 will
> > be more difficult to justify being changed or removed by a maintainer. =
"
> >
> > Just no. Not going to happen for the kfuncs we know upfront (like here)=
 will
> > stand in our way in the future at some point and *will* be changed one =
way
> > or another.
>
> Yes, and the EXPORT*() example is plain wrong in that document.
>
> >
> >
> > So for these kfuncs I want a clear way of expressing "whatever the kfun=
cs
> > doc says, this here is completely unstable even if widely used"
>
> I wonder if we can use a CONFIG_xxx and put this behind that, which
> specifically says 'WE WILL REMOVE THIS'
> CONFIG_EXPERIMENTAL_DO_NOT_USE_THP_THINGY :P

That's a reasonable suggestion. We could implement this function under
CONFIG_EXPERIMENTAL to mark it as experimental infrastructure.

--=20
Regards
Yafang

