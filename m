Return-Path: <bpf+bounces-27980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365778B40CC
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52DB282E2C
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF422F02;
	Fri, 26 Apr 2024 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXN3cOMh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4D23758;
	Fri, 26 Apr 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163215; cv=none; b=a71BKdQ8sEilZq77qvs1/l/oiQg59IbrzvCtAYilRwTlD3k9EUHGW/6h6UoYsPRFLfyL/6IQPjgbB7N2PbbMe9ayZPdXCh4Yw4HjaTR43yhcEjDbwNjRb03FuDc6RndhoXpCszTvlGRgLqTct3H6vEdDNkP5ZaeKoH4Jeitytg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163215; c=relaxed/simple;
	bh=sBL0lHa/6TxOBgAj88VqXwSY9DXfZG/N6Owp9d6kwKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hdp0KmmXULMHR0BHpWKLCLxT/lvWZgvkKHx6ZyL+h/+Ve7taexxVTzATacPy0ycogJi81oy4znMU3m+1qAwch9X1VpmeJoaVlxf8KJguKYf4f0xv2Ye2RC5+oPiPW5ukPqGMC5xmmIKW7GUX/n9T3sMt0b7rPBBDWyoswMKN2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXN3cOMh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1515861a12.2;
        Fri, 26 Apr 2024 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714163213; x=1714768013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLAP3onENSZmeADJpTAKc8XaP1Ji/omSoZg9Du9ItUc=;
        b=WXN3cOMhE74ObpZypixaQFfSeZIBNvr7LyhtyyAQj5OR9dmZK+dSEk+Biao5TbMCad
         H5KIq/lpnTJzakynYKDg7bG28ejgLsb/jIvXiencNQ5WIwNzyyob+iUa3V2QsJuMU2p9
         TEtJnedSpKKan43Xc2ILkNkecVG58bu+dOMeq7yEtbdZHJva7tF1G7BB0kaNNkIxBJ8I
         xWe13eEFIg5zv6vsdAQYB7Oz3JYX9rHk41o99CQo5cioPwBE3Bjiv9vqVehYgxVKFL7a
         Ijir+2m6NaYFQHpkQnooJtUo/ubkSw8sIT16i3mooKo3Niib/Lz8GHJKzVO1P/HT0ABB
         3GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714163213; x=1714768013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLAP3onENSZmeADJpTAKc8XaP1Ji/omSoZg9Du9ItUc=;
        b=uTtippTkzd4TPtwhoUbv8RVl1ZA27OfhWqPqe8KilbUdtSRd8znOLxa/W/rPv8k3Vw
         3Brmg1d1VqKKiut3MO0Ul0RGtb8i0nY0uutaRctBTFVSv105MFw4pziy+RZmVg5gLnUI
         V3V8bqJlVxDpup4sgBA03foUpC8qYKEqAX1RoYniN1S/Rc6ILs7rb95j4FXCF1Z51Ajn
         sQqVNkh2U2bf1F+4ZFjAFE+ryQ9oHreu9zujAPKXGYmyzHwN9QzwZNH6b3KsK7tJuFaO
         3ShHKHLr5Bjrp6JS9/6u8B+2YBk1SNocvMoFhr4EyE5DEuCvVURPH88XXe56CayX3o9h
         QQVw==
X-Forwarded-Encrypted: i=1; AJvYcCWDvvClOTlUdlh24E2k0FpzTxlGsh76suO7+/eOxwOqrKpd6puphkN2pqh8DsrVv8lC+jPQu3+2z3fX8NOAkbQRzdyg
X-Gm-Message-State: AOJu0YwW4ly0JY18qDoiJGrct3Kg+ZwfkbNHM4h9ji+RzGgrVVLFrOkw
	WKRxoOYfLkj6OALjefwtZALvXCGOMOpfDskM/9GmJ87kB8rXvhQ/7f732uQaKB38kMNqUGa+LRW
	DtXnDNKT/SYQ3IQbDDXjD3pcz/Xc=
X-Google-Smtp-Source: AGHT+IGkZopnjXMdXeNoDwsAAih0OjIRrltqd608cKvuvsN/ZG4zEtGsxB24AcySLoVSL6CTGwXlWRyuT9seudRabvs=
X-Received: by 2002:a17:90a:e646:b0:2a2:4192:dfc1 with SMTP id
 ep6-20020a17090ae64600b002a24192dfc1mr4004350pjb.14.1714163213482; Fri, 26
 Apr 2024 13:26:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419205747.1102933-1-acme@kernel.org> <20240419205747.1102933-3-acme@kernel.org>
In-Reply-To: <20240419205747.1102933-3-acme@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 13:26:40 -0700
Message-ID: <CAEf4Bzb0pyc_0AuP3O6wekpR3YcfEkk5bPGOOmS6_yJ3G5bKwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pahole: Allow asking for extra features using the '+'
 prefix in --btf_features
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alan Maguire <alan.maguire@oracle.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 1:58=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Instead of the somewhat confusing:
>
>   --btf_features=3Dall,reproducible_build
>
> That means "'all' the standard BTF features plus the 'reproducible_build'
> extra BTF feature", use + directly, making it more compact:
>
>   --btf_features=3D+reproducible_build
>

for older paholes that don't yet know about + syntax, but support
--btf_features, will this effectively disable all features or how will
it work?

I'm thinking from the perspective of using +reproducible_build
unconditionally in kernel's build scripts, will it regress something
for current pahole versions?

> In the future we may want the '-' counterpart as a way to _remove_ some
> of the standard set of BTF features.
>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Daniel Xu <dxu@dxuuu.xyz>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  man-pages/pahole.1          | 6 ++++++
>  pahole.c                    | 6 ++++++
>  tests/reproducible_build.sh | 2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>

[...]

