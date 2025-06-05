Return-Path: <bpf+bounces-59770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDCEACF455
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D10D7A53F4
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3C205ABB;
	Thu,  5 Jun 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px+Fvknc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEE1EFFB8
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140995; cv=none; b=EdtrLYHdEQPY7/u+zY7whryTxT8U0VHZM0ItN/vxGiX8EZZUOFokPFM6y4oD5Z1yT+nJVUUayypFAShaifUaqq7YHKoLKsNLS7aesd7cy2b+sGPaJ4qhOQvh8aNskqxWqHOkjQnhNreXpKJPtRhGKZqg0g9XLGuJ49sz6w1d5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140995; c=relaxed/simple;
	bh=iNaVm8JZH6WIYEzgh1nONnDGn2Snl76ecvHCUjn4cbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti395JWOMuAwKilrF6uRnexT2t6h+UZD0LDnbqx54fTBZ/Xro0EeN/A6HSyM4G5PZq9wfOW+mPkICvfbOoBeoezoLQf5FnpZI2nnBt4NnIa1TsX2KBubLcJ1DGSD/jNC5KnpXGJR2nmJ5t/YIQPTZHqyC8QhH4FJ+8j3RFPHfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px+Fvknc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3114c943367so1353993a91.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140993; x=1749745793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWboKgQmyvEny+YPSz0HyPkdBIN7LfL0ALc97sPUpmY=;
        b=Px+Fvknca84y3/UrYGW3zKK72U4iQcWbYsYdVsk3Stn8awWm4KW4e+OpllWsCPT23h
         o0pABKcpYfaDqh0VNHydJjlL0wpQQHD/8ZdyLtzZ21/cAb3uc+5fX/J9wy6QWG71zf6v
         vobTxcWVl6QaNZzyEfNh3PQbC+2T7CrLROh6qa12MB6S0S/liPOPcCseKgjtNVQked2K
         MwkFcyF6oM85vHBvPyU+siAF8QMrygJf7lzn930IKoR0Kuw/eN0sDsimnmW+FGgVRPM2
         pWDReJ78khUghmTYfgL1R5/shZk2R1SYYpBVVeN6VyVOvocJBVxq6/L0EZfzbTUQu1sJ
         IAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140993; x=1749745793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWboKgQmyvEny+YPSz0HyPkdBIN7LfL0ALc97sPUpmY=;
        b=PR9mqpvmM0Zai0KGPW9xwccTxuPDoIBc9qLW0M6DcTQMinFwWAg8lIfhL3CUtiWJQQ
         FR0TwhlTBXMWo+8czOxvxyyOSLjDD0YFGYzGD8e6X3dFZN9ok34zAffxnY02oSSRwkDg
         rx1kh4QJdXPvWblKRdJMCWsZF4iQxNx7TjhHeHxMnWap+blZHWidAOYQK8r9mTQ31Rkc
         W9oiHTRVmE4Cg7I+lxFNgmyDmDUEHQyRyNy9mgt1XxEA95Lr+XgMtEjAIKYlP75pVqNJ
         vzdcU2LaS9TRfvI8mYzFD9iz63r/U85E5vO/yzubDL5QjkpsKZoVWbnzykDmGcZ9JCb/
         KP+g==
X-Forwarded-Encrypted: i=1; AJvYcCVBtFgduSei04f7DtJQBUAaoT+ZCixRaygsMgCOaNZys8eI3nzU5eVNiopgtyPvz2yaAto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcI2Jzq9zBUwA/I2G9sKz/KOdPeIgH9Ur2mbamJ9XlH62QHAM
	bXM8VcXbfV27006wyHoilykT3HozUTchxsAwO1CSUVE28LSblcyjtgl0xFBso1p1kUS9iudEAnh
	Q04A1WwTO65pu7tMSx4e1OLSiEGWBEJeb1Q==
X-Gm-Gg: ASbGnct9n8Dti1HGeVMBmYoh0sBYZkpGluc4jLc3i34N8/pG85Og4ymo85JF2RAHYQ8
	Qt0gJQiF7FTq++1O2Gnz8ZGamqOg3xpWykimZxX2exFl25fCknN145r6m/Gf9WiMeIeKeuFenvA
	IFDdzKQ0EncgqeUk9M1uKR8Eh6iawdULKdEAjwGr2kt7fVfXZ1
X-Google-Smtp-Source: AGHT+IF7UIlmo5LXi4kHR49aeoH/VQ9Z8vewHuWt9590Ytu4lTxyPC81TJgJy+NS0myey0hy/aa9xKwIb/X4PVNvP80=
X-Received: by 2002:a17:90b:1b51:b0:311:b0ec:135b with SMTP id
 98e67ed59e1d1-3134768152amr464614a91.24.1749140993346; Thu, 05 Jun 2025
 09:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
 <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com>
 <CAADnVQLxzJMAYymtWMFZb6eAK+ha_shRfh+m3W3yFO4dLn-YeA@mail.gmail.com>
 <CAEf4BzYUW4oAm4JJ-Kh4HhtfP4GXuQFx+tJ3p7vjMpPYoVv5GQ@mail.gmail.com>
 <d6f9ca33-977f-4486-9d62-8f497858764b@linux.dev> <CAEf4BzZ1A6+uhX5gvCKSZUjvj_TG00-13jEWKbmqfXYEQ5fEZA@mail.gmail.com>
 <5e8a00cb-a5ac-4e5e-b157-62215933fb7e@linux.dev>
In-Reply-To: <5e8a00cb-a5ac-4e5e-b157-62215933fb7e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 09:29:40 -0700
X-Gm-Features: AX0GCFuIFUHRCfYslb1wTaFPnTTARHKpJRAnFTMf7qKbCwo8f7A3OYl8t-VJDBE
Message-ID: <CAEf4BzarBUTmbtPg2_q8jwAGdXdfrDwUuj2+0c86_wwD+DbEsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 7:45=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 3/6/25 07:50, Andrii Nakryiko wrote:
> > On Wed, May 28, 2025 at 7:44=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>
> >>
> >> On 29/5/25 00:05, Andrii Nakryiko wrote:
> >>> On Tue, May 27, 2025 at 7:35=E2=80=AFPM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>
> >> [...]
> >>
> >>>>
> >>>> I guess this can be a follow up.
> >>>> With extra flag lookup/update/delete can look into a new field
> >>>> in that anonymous struct:
> >>>>         struct { /* anonymous struct used by BPF_MAP_*_ELEM and
> >>>> BPF_MAP_FREEZE commands */
> >>>>                 __u32           map_fd;
> >>>>                 __aligned_u64   key;
> >>>>                 union {
> >>>>                         __aligned_u64 value;
> >>>>                         __aligned_u64 next_key;
> >>>>                 };
> >>>>                 __u64           flags;
> >>>>         };
> >>>>
> >>>
> >>> Yep, we'd have two flags: one for "apply across all CPUs", and anothe=
r
> >>> meaning "apply for specified CPU" + new CPU number field. Or the same
> >>> flag with a special CPU number value (0xffffffff?).
> >>>
> >>>> There is also "batch" version of lookup/update/delete.
> >>>> They probably will need to be extended as well for consistency ?
> >>>> So I'd only go with the "use data to update all CPUs" flag for now.
> >>>
> >>> Agreed. But also looking at generic_map_update_batch() it seems like
> >>> it just routes everything through single-element updates, so it
> >>> shouldn't be hard to add batch support for all this either.
> >>
> >> Regarding BPF_MAP_UPDATE_{ELEM,BATCH} support for percpu_array maps =
=E2=80=94
> >> would it make sense to split the flags field as [cpu | flags]?
> >
> > We coul;d encode CPU number as part of flags, but I'm not sure what we
> > are trying to achieve here. Adding a dedicated field for cpu number
> > would be in line of what we did for BPF_PROG_TEST_RUN, so I don't see
> > a big problem.
> >
>
> It's to avoid breaking existing APIs, such as libbpf's
> bpf_map_update_elem() and bpf_map__update_elem(). Otherwise, we would
> need to introduce new percpu-specific versions, like
> bpf_map_update_percpu_elem() and bpf_map__update_percpu_elem().

Ok, makes sense. I don't think I have a strong preference, but if we
did go with a separate field, we'd just introduce
bpf_map_{update,delete}_elem_opts() and pass that CPU and flags
through opts struct. It's not too bad either way.

>
> Thanks,
> Leon
>

