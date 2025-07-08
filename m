Return-Path: <bpf+bounces-62710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE13AFD9C0
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 23:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFDA3B072D
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098624290E;
	Tue,  8 Jul 2025 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYhzDdY3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47121D5AA
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009940; cv=none; b=s2b7wnO26mwYNfaIOXl30/Dl5FKqimEvqycG1RmLKQbMOY4rDqHh6oe51QLk9xWFET33atTlI8XNZiYXUfZcgUZHfFTxF0j59kvdnCGbfD4RWff+vXOBSsGJhrib5OSTv7T5fGc6WIZI2+SwzULss93hSdFxaDkh/RtE6b4Daok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009940; c=relaxed/simple;
	bh=NySBymBFUq6onmDVC2gUMlabYKcqYRqLouKSmH544UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHtD7Xs5Pxrqaic2Nak9t8JwJGRlZoEIflTHZsKHBD/gcXpW3pxNWNLgYPu2LZH0HZy7+QUiEn2RRDUlW03dd/w+5kFYDOCk7GrBv5bqhfLhXGo6xCGmzGNixvZYxZ/3Zcvj6MxJ01ZgmdiFO2jeTG0e8IvivlHzTY4JMzQT+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYhzDdY3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so55851635e9.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752009937; x=1752614737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSwLSYo2S+iGf/urx5ujOSsIf2LGXbmHp9SlTgM4GjQ=;
        b=gYhzDdY3LhPe4NyrPG4meILpomMgDJl0nFMkRTu/CUAbqboyJ72Wdy9Wd9xlhNLtYM
         DActJOC/D2nxO+noIADurwfxUHIc1RA7vmmrWOQOZJ0fvaVddCTEFl4ueqNOchPBw08g
         iC8I4imfq/iRiOyJWje/K11RSS6FtgxXIw8+DBgSo8SeEaYIy72ZWNogbIvRkOXEk9nS
         oV6K8RbYijzY+6mMoKNXWuWD89wyAY6966u4TzW/hFE7mE8l0EWg6HM+i3J+Y9cmot+C
         FMOLG3RL5WEhnB6kLSr1WFI2/mLsQ2/n09KfQjJc+jJ5Thh2W2Z6d07wOyVEeY2aHvVu
         K3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752009937; x=1752614737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSwLSYo2S+iGf/urx5ujOSsIf2LGXbmHp9SlTgM4GjQ=;
        b=qB50EJjqyr9nNjd0C20SVBsu2rUWIbfLhLbDE2y8gwNBVOoJ8ggSG00cLvHLcaESfH
         axJE1zsMKE7AoXf/QRKo+CNwKKlsrdwt/EX0DNw386w0g2gQ/BuInd3DtUkPyyZlbRDn
         8lea8PHEDTupcCs+yRc6UlrBCXVz0GwKColT/nSefLKZVYiIRI49gQO75BfwNDoE2TLY
         kjhZnH6d5nqLvDiF5gpCEsV2UEanr85uHWzT6Y9mRKczR4s0RJL3Xh4pmMNGG6Jm4jqf
         RqnbHgniUtiK+84Tm7QP3wWbQWLwYzKj3Scsw5Gdo1c7IPFZyxbi57bBrja4M+x2gaNL
         2y7w==
X-Forwarded-Encrypted: i=1; AJvYcCUVhMiZHxb3to5hLybrWudbBuytiT3b5dM4AagSZEn1yJKH3tpzDNYtF6JEJA6L15d+Zws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrQSv61f59ziRw9XLlLwfGOdubnC1Xepp1QJKpuMQyUrxSQ/D
	ZX4BaUv/vQl5tk065D73DGsZpOdBbd0b2mMHy+86qSlUHaTTXMkYn6SlWBp7ghU+wGIgftzWTxm
	nFjWkJNF+p2Q7avub62we5mGe0mh9BQE=
X-Gm-Gg: ASbGncstAYy4G0Z/dqWLJaBBf1uACpAwb9Eh7ILXrW8TnTdSQpD5VSqck8vW31aMc06
	N3QyaQNew8CEtsWbwLj0k+V/XeeF5y6WCGLSTkdx43M3M2SWP2BTOx6oZyt2INf4SXpZadZ5nNr
	BjR1K20ALqMWK0CWmKlOGcIEAeDgo6G7ox7by2J/8vXdi8W11MBRdkoTbFabpAziqqcDVKo6Ud
X-Google-Smtp-Source: AGHT+IGzM9X/mqEzVcHeyNZaudfcX9/gJHIRQ+IwoAk6podaM3ME6E+yGRoEweeAu41OMxgjJAL5DBRAQ0yyto7Cxsk=
X-Received: by 2002:a05:600c:1396:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-454ca33d1edmr72376185e9.24.1752009936796; Tue, 08 Jul 2025
 14:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com> <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
In-Reply-To: <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 8 Jul 2025 14:25:24 -0700
X-Gm-Features: Ac12FXzaVj8fTkO-DepaG058XA_1epaxjUFuuLxHkWRQuPjLznBl1MFk3CMh_ts
Message-ID: <CAADnVQ+b=k08pj6MkfowN64TPnJ0t585egzSDyDgvd4yBdqVOw@mail.gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 1:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-06-17 at 20:22 -0700, Alexei Starovoitov wrote:
> > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > The final line generates an indirect jump. The
> > > format of the indirect jump instruction supported by BPF is
> > >
> > >     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3Dfd(M)
> > >
>
> [...]
>
> > Uglier alternatives is to redesign the gotox encoding and
> > drop ld_imm64 and *=3D8 altogether.
> > Then gotox jmp_table[R5] will be like jumbo insn that
> > does *=3D8 and load inside and JIT emits all that.
> > But it's ugly and likely has other downsides.
>
> I talked to Alexei and Yonghong off-list, and we seem to be in
> agreement that having a single gotox capturing both the map and the
> offset looks more elegant. E.g.:
>
>   gotox imm32[dst_reg];
>
> Where imm32 is an fd of the map corresponding to the jump table,
> and dst-reg is an offset inside the table (it could also be an index).
>
> So, instead of a current codegen:
>
>   0000000000000000 <foo>:
>        ...
>        1:       w1 =3D w1
>        2:       r1 <<=3D 0x3
>        3:       r2 =3D 0x0 ll
>                 0000000000000018:  R_BPF_64_64  .BPF.JT.0.0
>        5:       r2 +=3D r1
>        6:       r1 =3D *(u64 *)(r2 + 0x0)
>        7:       gotox r1
>                 0000000000000038:  R_BPF_64_64  .BPF.JT.0.0
>
> LLVM would produce:
>
>   0000000000000000 <foo>:
>        ...
>        1:       w1 =3D w1
>        2:       r1 <<=3D 0x3

If we go this route, let's drop this *8 and make it an index ?
Less checks in the verifier...

>        3:       gotox r1
>                 0000000000000038:  R_BPF_64_64  .BPF.JT.0.0
>
> This sequence leaks a bit less implementation details and avoids a
> check for correspondence between load and gotox instructions.
> It will require using REG_AX on the jit side.
> LLVM side implementation is not hard, as it directly maps to `br_jt`
> selection DAG instruction.

