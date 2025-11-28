Return-Path: <bpf+bounces-75699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A9C9205F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 984B14E03C1
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 12:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A8327C05;
	Fri, 28 Nov 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT2811zP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16862D9EE4
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334344; cv=none; b=ZEhcO/K0aI/URbIsiDnMWZn6i2xzo1sIEz+duo8Tx/whUNe0RnJSohCk/pC7V8sT8yYdk6lcPAHTkOG4CV9fL2E2jR9SDvgMRGfnHBHBfl50Wk4P7pGlMdEKxc2PMYMxKMfop5mYq7MVoev3+ZYHvlJrSJ9ZvuaN46fO0wNRFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334344; c=relaxed/simple;
	bh=9e+Ti6o95Gyx1Xievxvy+clSWvoB01onskFgv6sZwSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0sIQJuW/r5QwWBg6tG0jp1qnOlJdE78MRoeBu2FljbK+VbGfbSF+ozP1uY6kzMuCIljkoaTP+so8YPAdA2dpASJzQxsrWblDHE/hRpRdbrmg+7IbZ4Kt2JEHWL91iFPx99ZXo5zCyCxWwMnNshLFXKRXvnJcq1uu0zxSfVoOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT2811zP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-789314f0920so15388387b3.1
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 04:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764334342; x=1764939142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaJqHHvEOEOyHC+8The6Gg0uY2rUdA1lvq9vEry25rg=;
        b=hT2811zP3v4c+gZ7hM/xgWs2zYx1NGBDmYH4Niabj8BAtxE2zlrvNZrQ9xRDWDp+C9
         3e+oDRNZOCRZtmTqpgu/t6UHgD14NvuwrT4OsBho3BYB8kI/pn3k4fO3p6dpo4aHj6Kz
         KaseH8oM9xkJ/vBzduzb1DI5TXYVXvQy9FARcAkCfNhmd0QxWkQIcp3XE6sZUcJ6pKHw
         /XO2dVtSWU4q734+mRa7s0x+airtvk+iC2oNyp4UA3j3au11mJr6nODy8yUcdmD72chu
         PQWTTTsq9k+8F8d7lDa4vg3Y7+4Y3zor61sRRJTRSpUiNBen0rxLK0qbGf+8iPnOUVM9
         Ax9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334342; x=1764939142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IaJqHHvEOEOyHC+8The6Gg0uY2rUdA1lvq9vEry25rg=;
        b=ASNrjVMXdGbgWIlx9mVuUQgLS7Imue7h7dnXvMkkLS018ypMlIZKhWHQD/vhigxnJj
         cOUv+Yu8HRQF6ggwgPNT2tCcYCBO8rrQtPP1ML8H8IbD9mEexAf868mL/2iXfQl5vURX
         9MOVIRZ7YnrDMBHGcTFaPAfiSlvj+IJ4vCurCO5IQAj+N8SZP/Ya36zxkRVeAxiSneOl
         nzImh4X2vohzTAwz/TluNgsTksDZ/R7hXzZLMohQpeL3X6tA1JgLQAqrNt4WzFgY6ymI
         xXKOS7g7MvsHNAJmkR4ba6Zz0vRdN60lw0em873t+Xa5aW3OOEkPvlxvVEhYmRTWsnpf
         lh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXV1MotM7bgegtWuYeV5E/Z+6mwj//Aqd74NT9d9fCri1l/f3JB1mmwbMbBnOxi4/JN48g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcn4Ji0BEQsEKha6SvdHOD5GbKqs7s/kEUaGpK8v3k4Fd53qTM
	89z4CpSiomngjdogAPAAgQhHZNuRbe//IXrL1ieNnjKUJOuuBOfEfWJZT8lnuxo6aG87Pncgw0S
	FrW2S9uVUi+6TgZIMjdlH78xVSwNnl08=
X-Gm-Gg: ASbGncv02/08jYYc7v1KEl5mskMsl9iWiI50A8AJtwCx7+kaeDgIkKSVYD2WIaQPUh+
	sU56gZP33bIbZ6AOJPw1D2cXPVvcYmT7+GSWnRymujrSoY/cQuPgqAWuoE7fVCgDIxHtgP+b1U6
	IUM5m3yTH2ShMpzl0HDOwg3deAkza50R77YyBFxmTjnBtdDzSG9pA3H936A0ba6hBiNL0PYQNxD
	hFFim3wNUyLoEuCCxW+aY5woB5jN8jLWo52anJYn6k9jhJqqE9mjZ0wLbXILr0g8D7rkyRPHIe2
	dGkuFHA=
X-Google-Smtp-Source: AGHT+IHFAwArfULn0f8hVfIIvR+szkl4hyE5JvWr5ut7aQy5zexLaRsPQvxenCpRtcJtHN+Xt1JIW24w2z0pfxej6TA=
X-Received: by 2002:a05:690c:708c:b0:786:4ed4:24f0 with SMTP id
 00721157ae682-78ab6db1675mr119567317b3.5.1764334341850; Fri, 28 Nov 2025
 04:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026100159.6103-7-laoar.shao@gmail.com> <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
 <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
 <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org> <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
 <48878c07-6e8c-47eb-bc8e-13366c06762a@lucifer.local> <CALOAHbBKxHDuGoND5xwxsScKY6aW8eiqE5QuHppd25RpYHf_pQ@mail.gmail.com>
 <f60522c2-e10f-45b1-9501-9b1e4223d8ce@lucifer.local> <CALOAHbCVGX3C6mbbH+e5bB2=Cnz-UVbEVBXZWP3fvhqGe9LSXg@mail.gmail.com>
 <600a793c-4000-444b-bb5c-2023f7198903@lucifer.local>
In-Reply-To: <600a793c-4000-444b-bb5c-2023f7198903@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 28 Nov 2025 20:51:45 +0800
X-Gm-Features: AWmQ_bmzNdWxaf5edAf5hNm2J7xYf3uPCO4yxzK9O_LWX4sRpZLLAEg74C_5rno
Message-ID: <CALOAHbDYiiv2HaTayGzCB=D_kwLPeV=xUcr_fHJckopF_pMQuw@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Barry Song <21cnbao@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 8:18=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Nov 28, 2025 at 07:56:48PM +0800, Yafang Shao wrote:
> > The CONFIG_EXPERIMENTAL_PLEASE_DO_NOT_RELY_ON_THIS flag was changed in =
v9:
> >
> >   https://lore.kernel.org/linux-mm/20250930055826.9810-1-laoar.shao@gma=
il.com/
> >
> > The change was suggested by Randy and Usama:
> >
> >   https://lwn.net/ml/all/a5015724-a799-4151-bcc4-000c2c5c7178@infradead=
.org/
> >
> > At that time, you were on holiday, so you may have missed this update.
> >
>
> It's moot because this series isn't upstreamable, but... :)
>
> To risk sounding grumpy, in future do please make sure to check about cha=
nges
> that contradict things maintainers _explicitly_ ask you to do.
>
> You can always off-list mail if people take time to come back to review.

Thanks for your suggestion :-)

--=20
Regards
Yafang

