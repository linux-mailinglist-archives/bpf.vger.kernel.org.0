Return-Path: <bpf+bounces-19191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955782706F
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D281F22CFD
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C106845976;
	Mon,  8 Jan 2024 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0usINco"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E34645A
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7c6e3c63so1674813e87.3
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 05:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704722257; x=1705327057; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dwC2+IEsdxuZpYMyuPfPXI4nc8Sboc6WOWmh07VyMF8=;
        b=B0usINcodVGyhZIlV8HDeNv4l8T33iRckxCzZkyWOJRjw2yELgTUGWXUcGVedWyZgT
         iIUG5IUSqeUKNjCpzVa7Nn18N082LaIE99JK0yqWB5FcMtGnwuXoydd+6L5UlxQPuI+G
         g/YVx6e5wfkPsFR1UBFhmzkbJ25FeOLgRmGAOZWN9PQGbVitpJuCNRVUn8KQy/LtrB0L
         WeKGzH2tGQF5Ov7Yv1ihinPGv7p3e5JHulKGpOr8M1zcVNHH1G3yXRBR/SeAOy5fDaIZ
         4qXes345uzvcz089kNO0SlbjSA/KRu2gdD+Dz6CDvt8yKJe2Vce47WhIPC/KMtVyRDBL
         JPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722257; x=1705327057;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwC2+IEsdxuZpYMyuPfPXI4nc8Sboc6WOWmh07VyMF8=;
        b=c+2XfieHzQJeWXWBU4JtFnsnCEqMv+oBCz2F/z9mI3w6bHhYJRYSCDv+xwwLPgxuA3
         CDtJuvK/66rWckBU7B35weHr73RG7CrTxF81BYD22WSUVaXMSvm6vg/gYZnTIqmACElQ
         bVKl5Bf6DusYq+FCwcIZF7ewsg2i/3oxyyNz3rxSwbBbn9v757UDQrZw66o4t8EJJcBz
         GfP1OLJL5JWhu7ki2vU+9O/cy8Nqcl/e0X3fQNAri2l4COH3asJz06buY614xod7PZR+
         RFY0KkJsFHNVYgC0mWk09dP6qyCAsnRVu3DUIegkmIt3ZkYSDSZBHBPAH/OLiEKvnUXI
         JWHg==
X-Gm-Message-State: AOJu0YySx6trKwAYAo6fPko5u+sjyi1zLbjXsBYEcpiolAwbjWfkxUos
	oeyrFK6K1fC+c4LyxnP9FAg=
X-Google-Smtp-Source: AGHT+IEKIz/4SwIh9XBbwJKrZyGvFDCwMwUK/Pm+I/mrFKS9XPKS+vNPNsgs+TwEcQG9HguEwzhTag==
X-Received: by 2002:a05:6512:3094:b0:50e:4299:de2 with SMTP id z20-20020a056512309400b0050e42990de2mr967201lfd.164.1704722256743;
        Mon, 08 Jan 2024 05:57:36 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u5-20020ac25185000000b0050eab7d397bsm1157742lfi.256.2024.01.08.05.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:57:36 -0800 (PST)
Message-ID: <c1dc9b8cf943b59396559be26706b77625fbac08.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: infer packet range for 'if pkt ==/!=
 pkt_end' comparisons
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Mon, 08 Jan 2024 15:57:35 +0200
In-Reply-To: <CAHo-OowJWNFMAEwvFhaPUevHjTYBe71NuMgYLBShtzxFcSQ3jw@mail.gmail.com>
References: <20240108132802.6103-1-eddyz87@gmail.com>
	 <20240108132802.6103-3-eddyz87@gmail.com>
	 <CAHo-OowJWNFMAEwvFhaPUevHjTYBe71NuMgYLBShtzxFcSQ3jw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 05:49 -0800, Maciej =C5=BBenczykowski wrote:
> (I've looked at all 3 patches, and they seem fine... but I don't claim
> to understand the intricacies of the verifier/registers/etc well
> enough to be certain)

Thank you.

> On Mon, Jan 8, 2024 at 5:28=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > Extend try_match_pkt_pointers() to handle =3D=3D and !=3D operations.
> > For instruction:
> >=20
> >       .--------------- pointer to packet with some range R
> >       |     .--------- pointer to packet end
> >       v     v
> >   if rA =3D=3D rB goto ...
>=20
> it's possible this would be better without the 'goto' as just 'if (rA
> =3D=3D rB) ...'

The idea was to show this as BPF asm instruction, which has syntax
'if rA =3D=3D rB goto C'. I'll wait for more feedback and submit v2
with updated commit message to make it more clear.

> > It is valid to infer that R bytes are available in packet.
> > This change should allow verification of BPF generated for
> > C code like below:
> >=20
> >   if (data + 42 !=3D data_end) { ... }
>=20
> this should probably be:
>   if (data + 42 !=3D data_end) return;
>   ...

Makes sense, will update commit message.

