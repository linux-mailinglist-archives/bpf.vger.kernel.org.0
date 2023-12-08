Return-Path: <bpf+bounces-17258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8380AF8B
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1326D1C20D3D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978A59B76;
	Fri,  8 Dec 2023 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfQfAdRm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88335171C
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 14:15:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a196f84d217so306487066b.3
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702073721; x=1702678521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNna4pkM07NReL6l6rsRVqeLyz/BZmyvhYteo5vDFqY=;
        b=QfQfAdRma3ZG1CoCF5Nnngf+J/tVVA4UvsU5lBhRVpgryq+B57f8VnTJrWlQNi5/pO
         BHyhGPqFk1QLEMET/d79DkVcBflCNVyIBEGmH31xmHpt/DxlbxTdAKL0/CsJgc5Mq5tu
         MSt/AIPQl25Efc0lwB2sx3gZW/It/A7azPZFyTpDV6XBB7df3F0yNustzz3fYkSODNDT
         XsUgcKJRFqkUCNyJrq38RN8ar9z+5SR1M7s0dt3RnjZouU04JaJEzKkmKrELj/LBqcGF
         CbVk+WWxenF2PUOeqFuIxvfJTjKMpzfA/nwsb1QF5JpPp1mwqX2kQlAA28Cutot1EYn+
         ZNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073721; x=1702678521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNna4pkM07NReL6l6rsRVqeLyz/BZmyvhYteo5vDFqY=;
        b=UgHFsm2S3s9Bp2dnpXOZG70yQqn442LSkWiVg7iNg7S/bNqk8rD42BgldKWmUghxbg
         upWzg4yOuk1FihGQumvATgRTYyKNb/uWfxe6CekRcdDWis0Nc9BeZMDUoV+hnJzuSuRJ
         DCAGpBk0VN90+tE09Yj793/zw8iwQ6FYJdJfZaBXSAVOIiVnkAJOdf1jRKvEZJINAJMn
         /99giWo5IUV2fDUpdfdU6Axwa7I/jWwcGuCC3gdWbcy5vkZ4uGTyT3oG1T2TWiGHdX65
         GisFEAFoPgleqYkxqi1xOtlDnP9zIpRNAAqN5Xx5yEHv5WO6DL8lI7G2qphba/AFwKXk
         SLiQ==
X-Gm-Message-State: AOJu0YwNSZcOVVwiT1r5eVo+rX2SFimuhWpfG5GG165TxnfyqaUsywff
	n3xNcGoIdrrGjE/tev5GJPKT8xWgEZgmzh0x2wEkQXgc
X-Google-Smtp-Source: AGHT+IFtDnPD8wsOKfWqQwSIvV0EdbU/d+Fqyz19rnkP98f73e7pkP4FX1ItkGGmlsybfjDNXiBwCCUtGKK1ioMU0GA=
X-Received: by 2002:a17:907:968c:b0:9fd:9439:c9f5 with SMTP id
 hd12-20020a170907968c00b009fd9439c9f5mr322001ejc.63.1702073720663; Fri, 08
 Dec 2023 14:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204153919.11967-1-andreimatei1@gmail.com>
 <CAEf4BzZ57kAWYDBwpxxAsWRyo5fvnHf5-R+OZuPSd1L-viQDig@mail.gmail.com>
 <CABWLsetTu3fBcJaVhC8D-ZDBR0n4HM5xkhk1pA9KA+_-nZy9cw@mail.gmail.com>
 <CAEf4BzYhn7wD102_5E0jqiP4yH7prb-RyTTHaF_3fuVPVN--Og@mail.gmail.com>
 <CABWLses4A1W4kMAqiEd8drL6PKiK7egk_btT7OH3C=LxC4vefQ@mail.gmail.com>
 <CAEf4Bzb6+dF5r4rvcPakoVS_+GOXVs=3wgPEvFMoiGxwB0evqA@mail.gmail.com> <CABWLseupmKtmQX4SnRF0r9taU4QNwQunU+f79QFQ1V4KXo=TKA@mail.gmail.com>
In-Reply-To: <CABWLseupmKtmQX4SnRF0r9taU4QNwQunU+f79QFQ1V4KXo=TKA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Dec 2023 14:15:08 -0800
Message-ID: <CAEf4Bzac94=uum2ORYWR2i_qYpmyde2xTLucDf_+EtFE9vCw9Q@mail.gmail.com>
Subject: Re: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off
 stack access
To: Andrei Matei <andreimatei1@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 7:23=E2=80=AFPM Andrei Matei <andreimatei1@gmail.com=
> wrote:
>
> [...]
>
> > >
> > > Ack. Still, if you don't mind entertaining me further, two more quest=
ions:
> > >
> > > 1. What do you make of the code in check_mem_size_reg() [1] where we =
do
> > >
> > > if (reg->umin_value =3D=3D 0) {
> > >   err =3D check_helper_mem_access(env, regno - 1, 0,
> > >         zero_size_allowed,
> > >         meta);
> > >
> > > followed by
> > >
> > > err =3D check_helper_mem_access(env, regno - 1,
> > >       reg->umax_value,
> > >       zero_size_allowed, meta);
> > >
> > > [1] https://github.com/torvalds/linux/blob/bee0e7762ad2c6025b9f5245c0=
40fcc36ef2bde8/kernel/bpf/verifier.c#L7486-L7489
> > >
> > > What's the point of the first check_helper_mem_access() call - the
> > > zero-sized one
> > > (given that we also have the second, broader, check)? Could it be
> > > simply replaced by a
> > >
> > > if (reg->umin_value =3D=3D 0 && !zero_sized_allowed)
> > >     err =3D no_bueno;
> > >
> >
> > Maybe Kumar (cc'ed) can chime in as well, but I suspect that's exactly
> > this, and kind of similar to the min_off/max_off discussion we had. So
> > yes, I suspect the above simple and straightforward check would be
> > much more meaningful and targeted.
>
> I plan on trying this in a bit; sounds like you're encouraging it.
>
> >
> > I gotta say that the reg->smin_value < 0 check is confusing, though,
> > I'm not sure why we are mixing smin and umin/umax in this change...
>
> When you say "in this change", you mean in the existing code, yeah?  I'm =
not

Yeah, sorry, words are hard. It's clearly a question about pre-existing cod=
e.

> familiar enough with the smin/umin tracking to tell if `reg->smin_value >=
=3D 0`
> (the condition that the function tests first) implies that
> `reg->smin_value =3D=3D reg->umin_value` (i.e. the fact that we're curren=
tly mixing

this is probably true most of the time, but knowing how tricky this
range tracking is, there is non-zero chance that this is not always
true. Which is why I'm a bit confused why we are freely intermixing
signed/unsigned range in this code.

> smin/umin in check_mem_size_reg() is confusing, but benign).  Is that tru=
e? If
> so, are you saying that check_mem_size_reg() should exclusively use smin/=
smax?
>

I'd like to hear from Kumar on what was the intent before suggesting
changing anything.

>
> [...]

