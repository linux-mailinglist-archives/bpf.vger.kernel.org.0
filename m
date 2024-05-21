Return-Path: <bpf+bounces-30170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B1D8CB60C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE642828E4
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60B149C65;
	Tue, 21 May 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMZgOruN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23DF58AC1
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331036; cv=none; b=iE5CHTl1memOXof7i4IzJFtNmLyWqdD2o2L0/eWh2R9rX/X0wmaN+0wuMY7/8OUKPiVywxlX3IbBuiUzhkMCYvFaC07pxiUZ2D1phVdFBcuglURI4wAo1t7eZYQHug/geZu9dwW+zT2O0AyqDmkQrY+68iL1oMMLr4zwODGd5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331036; c=relaxed/simple;
	bh=j7y9QYXVE7mNh63y1+xS3zSPnmIFL7OS5uANizmB4e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgVbKYcOD3+13Fw4AN+9hBcMpbWTXhEsvFdVTD8T2T1zU3iwwrxqrNS+LBN2rgzXhDVGl3UObvqiJIU2RAVZLKfHkI/xxnf12mQn1LbMaSmF+8OiU+ZVRF0/aqKL3s6wdqwpDKADtFIBQbUZiQQLUEXFrY4XlkcM6hntbkvJ1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMZgOruN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a609dd3fso60334766b.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331033; x=1716935833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7y9QYXVE7mNh63y1+xS3zSPnmIFL7OS5uANizmB4e0=;
        b=MMZgOruNTQRJkTqT0P//Tc5Pl2e5Pfg6kZYeEc/1ikI/ltg9Y5sJxBYB/1gsKxjifd
         UZUKBIpWdAezcYEEaZh4354WmdCERo21K3/kVzvonDINNNF3InR9mXhyKRSLXMzZil0i
         uNmzGVsH3H1+06Qypq62Iw+6NcOC3M9YLVQERWych7PHXD++iM69ZtoTu8673AF8Mg2O
         K96zqgiVatJxYQeVazHfmyhxb2+ThJRE3mPbAwTWN1rFfzAW4MWBh2ZffEAaymmMBd04
         IYIOArubZc/eCzQDdgP7KK7GArwsnVVzpYR7ZKWjcZHN2MqEVPJoMta13o2zWqOkdY+h
         6nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331033; x=1716935833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7y9QYXVE7mNh63y1+xS3zSPnmIFL7OS5uANizmB4e0=;
        b=Gc0R0nzTpPEM55hYH9ctCg5eQoDFqxdjasf7s/5Gn9uEbO5U7LX0Q/A2YPhD+V+xHG
         +7SVqSsHfcONneGpvfZHFRt3osIi2FS+64n38x1f4lEGO/NVE7F8NxJooB0f3JviKHsZ
         W48M2Tx93jL9OvplA26RTpTK+KpbPSNmOj36DXCX2y4dwKJAZOcx/3V7NC2YA5ubu60O
         XxEXsKK+YtqLgEh5eNRNWWy3lNNyezWt18kI4bsIX/63aS+6u9xoUcMsNBh1RPV7RPvD
         /cyHkFJe8KzfRbwVAh532eGKm4rybKD7hwHWL9p0+X/CyCM+9h4cQsLQaFApSNYvkjni
         hG+g==
X-Forwarded-Encrypted: i=1; AJvYcCUyjtcgbt2NSdskQrosyfGR+eRCAPVDjLIcj3vYhQJYpZZTSjAZyelntgeT/U2tlpX0LmHU6BIVm5SzKk7SRiTDbSs3
X-Gm-Message-State: AOJu0YwKGnT4PeJ+r5Kg5DsNZf11MywIMlrz1AgK0ChqDpGca7MzTCQr
	xssBZkZh9kggUM4gmLK29bt8Xkq4hf47asx137+TbDM/3VAk1vwJN4sZ5w+8ogdz++1FgOdvY1R
	5mlprvVgUiDtYHfnvg1zFZWqyQgj7kw==
X-Google-Smtp-Source: AGHT+IH0I4GsSqgXU7iPsYPOxFWaEeSyOBywcmxM2I4DVVUaprCR7XwqNF8s6ORgU+UwtiY3/D37ksEKSDMQ3cgI6Iw=
X-Received: by 2002:a17:906:7c53:b0:a5a:3908:f4ad with SMTP id
 a640c23a62f3a-a62230f84a1mr30010366b.10.1716331033027; Tue, 21 May 2024
 15:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
 <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com> <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
 <CAEf4BzbdoXTeTSx-1Vu+sA6MKphQq91p1TwnSkK3Yv3msa7h9Q@mail.gmail.com>
 <eda720142ac52a9bd9599f5444a2c2897255b5c4.camel@gmail.com>
 <CAEf4BzbghAqpTSfWH_v10uK4ynXqG5Nm2e-_xTWFOF=bmLqd_Q@mail.gmail.com> <9cf02a374ab97ceaaed04a8d4148be93877555dd.camel@gmail.com>
In-Reply-To: <9cf02a374ab97ceaaed04a8d4148be93877555dd.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 15:36:56 -0700
Message-ID: <CAEf4BzYicrfnfM32V3fLgCCQJesedX9guiY0VDgFReUEywm3AA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, jolsa@kernel.org, 
	acme@redhat.com, quentin@isovalent.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:15=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-21 at 15:01 -0700, Andrii Nakryiko wrote:
> > On Tue, May 21, 2024 at 12:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Tue, 2024-05-21 at 11:54 -0700, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > I'm probably leaning towards not doing automatic relocations in
> > > > btf__parse(), tbh. Distilled BTF is a rather special kernel-specifi=
c
> > > > feature, if we need to teach resolve_btfids and bpftool to do
> > > > something extra for that case (i.e., call another API for relocatio=
n,
> > > > if necessary), then it's fine, doesn't seems like a problem.
> > >
> > > My point is that with current implementation it does not even make
> > > sense to call btf__parse() for an ELF with distilled base,
> > > because it would fail.
> >
> > True (unless application loaded .BTF.base as stand-alone BTF first,
> > but it's pretty advanced scenario)
>
> In this scenario .BTF.base would be relocated against .BTF.base,
> which is useless but not a failure.
> Maybe having the _opts() variant with additional degree of control
> (e.g. whether to ignore .BTF.base) is interesting as well.
> On the other hand, for such use-cases libbpf provides btf__parse()
> that accepts raw binary input, and application can extract ELF
> contents by itself.

I was just being pedantic :) We can always add a new _opts() variant
later, if necessary. I don't think this scenario is going to be a real
scenario, so no need to worry about it too much.

>
> [...]
>
> > I see what you are saying about resolve_btfids needing the changes
> > either way, and that's true. But instead of adding (unnecessary, IMO)
> > -R argument, resolve_btfids should be able to detect .BTF.base section
> > presence and infer that this is distilled BTF case, and thus proceed
> > with ignoring `-B <vmlinux>` argument (we can even complain that `-B
> > vmlinux` is specified if distilled BTF is used, not sure.
>
> +1 for complaining about -B vmlinux when .BTF.base should be used.

ok, let's

