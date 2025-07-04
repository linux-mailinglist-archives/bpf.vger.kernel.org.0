Return-Path: <bpf+bounces-62443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9FAF9BB5
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 22:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E4F3A5623
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AEA239E75;
	Fri,  4 Jul 2025 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFf51J1Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EA2E36F3
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661247; cv=none; b=hI2U6Fa97PK+hc6sSJYxkZRHsqMb13USFvM2FTTEaXUwScICa5r+8hY6jCh8DDqqLPrX4T5fju/rS4C6YkDEdQ137SYERR4YGjdWQFzdZ4IdxsCX2xrwS6OGSoxGQnOVaZmsgViU+i9gaxagUwxCdb0tGfWVrLdwcm3WOZiq+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661247; c=relaxed/simple;
	bh=M8pCevBIGEJkMKGBMidFdoO2zcbUAymQXmy7tIf+1bo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3l/gU8b0cgpVADPxOgcan+H1mKZd5oFZPNaUg4yGomGSGu1HIpHXnQAYdKqK4rnGa29inm7EJKj8tBt+IcdLIG5pIVGl2mZXLHJ3FlGBweMm0JyRECgA7TO0/jXTFAkOM452Fd2WNbDhbI5kMOXlXjccVmbe0lZrNBd9itxF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFf51J1Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235d6de331fso16914445ad.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751661245; x=1752266045; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fgAhmTCiMeunb0AzVKNgReQf62yLWa2PrINSn/q+ETk=;
        b=lFf51J1Yn6hKIbDWuc6q7ti0t+ltQsSzx3+0NDO16gEcFlF41FAfJZ5f2L978/sj7Y
         BSygROE0EixrXMsPQN0eGfsIpqjONGnPY848UNcs7+XmqZEjCne1UuwXjgma24UyzE1f
         SqJ4kmUL6g2OFJCY+SlDHbX7vRJqrLuKWG03D2s0VjMK/7rx5o5jvjCZWxMuXO2vUuko
         Bm33QRFhRGUaZhbOCwUkuEtCXsgBnswcDTp9N1/G6i9mF67quitGVko5oADwBSGQlbj6
         svL9y3ihEzQ0B4jQRHLZzbdhmXJ/0M9L6F2re/dbLCJUf6ErvAr0lyLjSnSP8Gf/M8PK
         AwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751661245; x=1752266045;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgAhmTCiMeunb0AzVKNgReQf62yLWa2PrINSn/q+ETk=;
        b=bZo0YZpPiww7AtRxtNvh3Bb5vp87AVK7s/oDLnzWDs5KtO70SVnvRWYTXU+IEcF32T
         n4s0gYRB1zUO51w6xt8hi4qN5wOfbTc0x2yxG9BNGIjZf2bbH+V/mL/5FeZPXQsfnmBY
         ILQlqLF5WeSgfkY3qThcC/Rv9Q9LPOaAd+ljpDmhMv2s1di+hkJ0ACRljExaFniO5KCX
         gjxfj3XDiCpV/CUv+QiCvz/ubv4G3siOnT0y8cJgS2sdNgH95SbtGWDJ9gAQhUOCpXJq
         tSNvKp94uK/uxlotxOOCLRNy6EHDza1kq7OgCbjdhZIltV4srf9xQ0ya2PRFZYJ6zpS9
         X7Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVPRq0PDmlQHHXhJaMtFEEFD744XQ7bN5IAWGF6NrOubxnu3e06fVdZ3CdXM7X8d31LYvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkHtw5AyraxehhHeKkt2FKEs4HVtAzBTq5UM7CXMb9AlBLF5t
	WMazardmshaMOBc9zHOKzYn53/T9+vuFgH3BaMtrh2p+rtKkwrNjSu8d
X-Gm-Gg: ASbGnctihcBrp6frglb/iKyVO6nJvbAgp1h+LgHturEzNRgAZNfNkbdCouWQgOHBLGH
	0xGpno/HhYEn3tXw7uYy35hWpYU7VFpgFWhRk9OXWY1TTOIzJYL1lUUw2y2SJwvj7AAf5V641p3
	VSOsaq6UYByLHdzfuhaXe5NPYkWJFPF1IFAwkzKRUNjmNeBjnUGoGbIGBLcEp70/mBmQpS0n6TA
	haAMzKtEitGTbEuTIwCs1QFvHMkkJWOJ75nUFh/0yvPJ79srl38RhsNrb6mU2WlBc6lIrVbZcaB
	w6FfIpxTAbw5SAwmeRo5IFPd8ybK9HIAKNUm2ZQQ8TRPRzhDH4rN8AtQ+A==
X-Google-Smtp-Source: AGHT+IECXCd3fmiNSgLG0yvmbSK1SLU/uSOrnFeMazFR4U+kMBeAXe+0u3RdI1x70G40sGFNSdNHlQ==
X-Received: by 2002:a17:902:ce0d:b0:234:ed31:fca7 with SMTP id d9443c01a7336-23c85ec9f87mr65835035ad.48.1751661244949;
        Fri, 04 Jul 2025 13:34:04 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ed76sm27848745ad.13.2025.07.04.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:34:04 -0700 (PDT)
Message-ID: <f61674e3d16bee41b35acaac70285f673259d023.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for
 global function parameters
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kernel Team	 <kernel-team@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Fri, 04 Jul 2025 13:34:02 -0700
In-Reply-To: <CAP01T76tXJVMk_Yy1USRNity5rA=DXe9BgS7OOa0G960UsVPcg@mail.gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
	 <20250702224209.3300396-5-eddyz87@gmail.com>
	 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
	 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
	 <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
	 <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
	 <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
	 <CAP01T74_diwrEB0D=LOqVGQTGjiETm65cqh3zZEL5S5EkTYaZQ@mail.gmail.com>
	 <e5acf74c70f6aa01ca7be4c0afce9dd6a20a910e.camel@gmail.com>
	 <CAADnVQKh9pAaAcJp_bSFjz5=K-6XPgb_Jdo8yhv3VYQhb-6=xA@mail.gmail.com>
	 <CAP01T76tXJVMk_Yy1USRNity5rA=DXe9BgS7OOa0G960UsVPcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 22:20 +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, 4 Jul 2025 at 22:06, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Fri, Jul 4, 2025 at 12:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >=20
> > > On Fri, 2025-07-04 at 21:15 +0200, Kumar Kartikeya Dwivedi wrote:
> > >=20
> > > [...]
> > >=20
> > > > Yeah, so if the user specifies a type and has co-re enabled, they'r=
e
> > > > accessing a kernel struct.
> > > > If they're doing it without co-re, it's broken today already, or th=
ey
> > > > know the struct is fixed in layout somehow so it's ok.
> > > > If not, they want to access things at fixed offsets. So we can just
> > > > use the type they're using to model untrusted derefs.
> > > >=20
> > > > So always using prog BTF makes sense to me.
> > >=20
> > > Ok, I'm switching to always using prog BTF.
> >=20
> > Hold on. The concept of ptr_to_btf_id|untrusted that points to
> > prog type doesn't exist today. We should be careful when introducing
> > such things.
> > I prefer to keep btf_get_ptr_to_btf_id() in this patch
> > and think through untrusted|ptr_to prog type later,
> > since the use case of untrusted local type doesn't quite resonate with =
me.
>=20
> Yeah, we can add it separately from this set, but otherwise I don't
> see the problem with the idea.
> There is no reason to restrict ourselves to kernel types.
> All accesses will be untrusted, it's like probe_read so it should be
> well-formed for any type.
> It's the same reason why pointers to non-struct makes sense. Ideally
> any type should be allowed.
>=20
> Otherwise to reconstruct a walk of untrusted pointer chains the user
> will do it by hand.
> Showing the structure types to the verifier allows it to be inserted
> automatically.

I agree with Kumar, it's an expansion of the idea behind
bpf_rdonly_cast(...,0). Having some untrusted pointer source
(e.g. value from a program stack trace) one can already write:

  struct foo {
    struct bar *bar;
  };

  struct foo *foo =3D bpf_rdonly_cast(magic_value, 0);
  struct bar *bar =3D bpf_rdonly_cast(foo->bar, 0);

We can make it more convenient by introducing an additional kfunc:

  struct foo {
    struct bar *bar;
  };

  struct foo *foo =3D bpf_rdonly_cast_local(magic_value, bpf_core_type_id_l=
ocal(struct foo));
  ... just use foo->bar ...

As for global function parameters. Discussed this with Kumar off-list
a bit. There are types with generic names in vmlinux.h, like "region",
"regex", "hash", "key". So, imo, the above bpf_rdonly_cast_local()
should be accompanied by its own tag: __arg_untrusted_local.

