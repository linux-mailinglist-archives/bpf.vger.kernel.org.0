Return-Path: <bpf+bounces-18783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD65822110
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD855B222FF
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF0A15AC0;
	Tue,  2 Jan 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Urhtao4B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3F9156EC
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-555936e7018so4123029a12.2
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704220267; x=1704825067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzfksP4hQEHF3DkBpH1nJe/BXx/wW0BmeMrIuhvmwps=;
        b=Urhtao4BMy6vu/lTxMhVDbs1aZxewWRNU63rJPv47qgcSV84hZb2tCRLFDUpYmlgjN
         /gam8NBalP96X3Et+SLvow0uxnJLGnwObcQasUg6zY+KoI9Ze41YEUSPabld0ME65Rvq
         OlUrvbVoHXaGbkOJqFlpOoVmfH8JjmYdVsh43T/WEDb9rqHdvCOY/PpLvOuv5BXvcCC4
         XoctcXT+FHSOWnRGj9rzH7zMCg9tNBx+k6t8xpq/vAdLrO+nVBjyRJqKnfjQx+B32eX6
         AkYiKSx0nrLuJyMftcAg62XszQwhXuFElZO3Ez7SCnwDGvUedetUsb5oUPsGjQHNwRhx
         WiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220267; x=1704825067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzfksP4hQEHF3DkBpH1nJe/BXx/wW0BmeMrIuhvmwps=;
        b=lxPPFq16z1HQXeznf3kUYpYHuQjFJUn35I4ITZgQfXk04kalLi4y7HIPI/Iq2n7X/r
         RDn5zvd2x7AT5p6KB/JYblhOr3QVeHHStXYgmASKMxFaeVKubVOxIE542nJAz59Gbv/Y
         W4yRw+70pvwUFPYykvnzTCoBmuC0cZtQ+Zmkndvu6cC5faN5UCeaUkChHo/SrPdGoKtB
         ouSaFTxyi/fizk9vK7kdC9Ymo4FnDUk61y0m4WspH5CS9tA2Zuo63ktQ+QPp1gTnM1vC
         6iAZFgr4NBgCi3s490Xnr0hQWQEWott/SuhhGQ7HYdT+DT236oMz1aPeqjP/OjHZJcu7
         5q2g==
X-Gm-Message-State: AOJu0YzZat9G8ILvTbU/lU9h2q8Vbl/4uYMDQgr5Hj/CbWVxe5qnRGxU
	lkP/0EJWliRYtuQKCfFVf1QhiYnB60xp0G49wmqw5SAeSNFmPw==
X-Google-Smtp-Source: AGHT+IHrssm3kMGnVxCRELvgk/Wb1fLou1NiLGVjNOGQGIs3gs/2Z/iN3w90BDQRfyA7sv5WSQgspwFjzwy651VZSZE=
X-Received: by 2002:a17:906:fc11:b0:a28:7cea:c68 with SMTP id
 ov17-20020a170906fc1100b00a287cea0c68mr170627ejb.130.1704220266459; Tue, 02
 Jan 2024 10:31:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
 <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
In-Reply-To: <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Tue, 2 Jan 2024 10:30:55 -0800
Message-ID: <CAHo-OowjLmtEPmoo2rQ3i4_3mO0Uy6Sr9+pdcv2qCbahdVVgxg@mail.gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 8:40=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2023-12-29 at 17:31 -0800, Maciej =C5=BBenczykowski wrote:
> > I have a relatively complex program that fails to load on 6.5.6 with a
> >
> > if (data + 98 !=3D data_end) return TC_ACT_SHOT;
> >
> > check, that loads fine if I change the above !=3D to (a you would think
> > weaker) > check.
> >
> > It's not important, hit this while debugging, and I don't know if the
> > cause is the verifier treating !=3D differently than > or the compiler
> > optimizing !=3D somehow... but my gut feeling is on the former: some
> > verifier logic special cases > without doing something similar for the
> > stronger !=3D comparison.
>
> Please note the following comment in verifier.c:find_good_pkt_pointers():
>
>     /* Examples for register markings:
>      *
>      * pkt_data in dst register:
>      *
>      *   r2 =3D r3;
>      *   r2 +=3D 8;
>      *   if (r2 > pkt_end) goto <handle exception>
>      *   <access okay>
>      *
>      *   r2 =3D r3;
>      *   r2 +=3D 8;
>      *   if (r2 < pkt_end) goto <access okay>
>      *   <handle exception>
>      *
>      *   Where:
>      *     r2 =3D=3D dst_reg, pkt_end =3D=3D src_reg
>      *     r2=3Dpkt(id=3Dn,off=3D8,r=3D0)
>      *     r3=3Dpkt(id=3Dn,off=3D0,r=3D0)
>      *
>        ... a few lines skipped ...
>      *
>      * Find register r3 and mark its range as r3=3Dpkt(id=3Dn,off=3D0,r=
=3D8)
>      * or r3=3Dpkt(id=3Dn,off=3D0,r=3D8-1), so that range of bytes [r3, r=
3 + 8)
>      * and [r3, r3 + 8-1) respectively is safe to access depending on
>      * the check.
>      */
>
> In other words, from 'data + 98 > data_end' follows that 'data + 98 <=3D =
data_end',
> which means that accessible range for 'data' pointer could be incremented=
 by 97 bytes.
> However, the 'data + 98 !=3D data_end' is not sufficient to conclude that=
 98 more bytes
> are available, as e.g. the following: 'data + 42 =3D=3D data_end' could b=
e true at the same time.
> Does this makes sense?

Nope, you got your logic reversed.

The check is:
  if (data + 98 !=3D data_end) return;
so now (after this check) you *know* that 'data + 98 =3D=3D data_end' and
thus you know there are *exactly* 98 valid bytes.

> Thanks,
> Eduard

