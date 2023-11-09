Return-Path: <bpf+bounces-14627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61B7E7267
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB51C1C20C70
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696FB36B11;
	Thu,  9 Nov 2023 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQD3WmuJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9836AFC
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:34:56 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C13ABA
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:34:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a6190af24aso220952666b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699558494; x=1700163294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zTG9pyzTD4k3oF/KuXh9kMDDgA7z4bnPoJ1cudevEy8=;
        b=bQD3WmuJSrrLAxMCHDQGh10u7CaBJrpainQwHVPHUT0DmPd+hKeNrOGai/UaNLq6Vc
         Wd0WXiBIp2VE0s2qC6T7vemgS+hPcFgx3Ubgd8ttjJTB6RKaPi5Nc3EFxO82+N3W9Txv
         KoctuiDLcdqqlhy7nFNXLcryNudSU4nbVR6D597Zu4NRWYoGzc1uzK1gG1/0kkPDSxiK
         aySpyYstXCuLUb8hVojJ5zrBtIaXKeJsxRNfobn3gt7ebefOt17LPG+LivrqBoCh4jEn
         6dMkaDHqGMoYJ0RF6XEkv9f8vdoYBzlad5TmjNNtJKNKCLezXhY4xxL8LrpBc/kSef3G
         iLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699558494; x=1700163294;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTG9pyzTD4k3oF/KuXh9kMDDgA7z4bnPoJ1cudevEy8=;
        b=DzZkoBNm2PvHBOlSbmhfJv3yBsirejIqu+L2ZPwVgoCrQAoz/ElztwEXqVIUPDsETc
         cepow5YqwmwY/3qYhmRQlkFFvpZNYGsStbBZ6x61Xm8zOdCwRAkP+idZ0GTyek/Yp958
         I8kJf8WQftplwwDKLTxwahx5/yyw0TFGDSWD93bbhHf+YUeiGjxeQn28bD8wqKTZwS8f
         72fTRP+ihPcZZp8gz8WMfmNUI3o0f/imA2zoan+v3/K5SZag8qcKonG09Ni34Ra2JMyo
         XWnLPOqKS7mMu2vNMhHCXDPYlJZQIAAnfg9b5N+wz+DpHAy/LbKSJBEBchKZF0YxN10w
         L1hg==
X-Gm-Message-State: AOJu0YzyFzn0GNZ7ogqOeHEUNjkHzfjkrRayALfWyTMlv74zKRvbQeMq
	KyI0zOlXvTt/oeW9ms9eOfncyz5ETpI=
X-Google-Smtp-Source: AGHT+IFvK8rJqa6qtEFZD8LYKKw/ys2gPHbLjJfaYW18BbGwEjtHPq6e1LoONY1iy77GTxnZ2Jh5lA==
X-Received: by 2002:a17:907:1c0a:b0:9bf:b5bc:6c4b with SMTP id nc10-20020a1709071c0a00b009bfb5bc6c4bmr5470162ejc.62.1699558493406;
        Thu, 09 Nov 2023 11:34:53 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id th7-20020a1709078e0700b009e3b532689bsm2721223ejc.209.2023.11.09.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:34:52 -0800 (PST)
Message-ID: <fa3ad5ba2a36de906cab33e1f1b2ce39b37c06c2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: preserve constant zero when doing
 partial register restore
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Thu, 09 Nov 2023 21:34:51 +0200
In-Reply-To: <CAEf4BzbmCngJeThcwUt52f7nNqOUtfOury3KfCrr+QiYKVX74w@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-7-andrii@kernel.org>
	 <891df9e42aee4ce7c46010cd93744e2b90819502.camel@gmail.com>
	 <CAEf4BzbmCngJeThcwUt52f7nNqOUtfOury3KfCrr+QiYKVX74w@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 09:41 -0800, Andrii Nakryiko wrote:
> On Thu, Nov 9, 2023 at 7:21=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> > > Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes f=
rom
> > > stack from slot that has register spilled into it and that register h=
as
> > > a constant value zero, preserve that zero and mark spilled register a=
s
> > > precise for that. This makes spilled const zero register and STACK_ZE=
RO
> > > cases equivalent in their behavior.
> > >=20
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > Could you please add a test case?
> >=20
>=20
> There is already at least one test case that relies on this behavior
> :) But yep, I'll add a dedicated test.

Thank you. Having a dedicated test always helps with debugging, should
something go wrong.

[...]

> > Condition for this branch is (off % BPF_REG_SIZE !=3D 0) || size !=3D s=
pill_size,
> > is it necessary to check for some unusual offsets, e.g. off % BPF_REG_S=
IZE =3D=3D 7
> > or something like that?
>=20
> I don't think so. We rely on all bytes we are reading to be either
> spills (and thus spill_cnt =3D=3D size), in which case verifier logic
> makes sure we have spill at slot boundary (off % BPF_REG_SIZE =3D=3D 0).
> Or it's all STACK_ZERO, and then zero_cnt =3D=3D size, in which case we
> know it's zero.
>=20
> Unless I missed something else?

False alarm, 'slot' is derived from 'off' and the loop checks
'type =3D stype[(slot - i) % BPF_REG_SIZE];', sorry for the noise.

