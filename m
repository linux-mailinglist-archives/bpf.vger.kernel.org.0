Return-Path: <bpf+bounces-47721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071219FEBEF
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 01:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9171161F86
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B66B660;
	Tue, 31 Dec 2024 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap4qp1GS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5D4A21
	for <bpf@vger.kernel.org>; Tue, 31 Dec 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735605784; cv=none; b=Yn/k/ihClpzXn4VzNgQvoY685reBplBmVBfTiUUBqr2cs6sVM9sI03twUlgyW9uG+TdzmFzdKPk3t4b798Vrq1q+qe+Mj9JLVXz7qR6EinKzGngEu9fzqYDQUHDpRSm9xatdla7u3oypUL0atDMbioxE23PiL+xMPAcKeFj2Uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735605784; c=relaxed/simple;
	bh=W9GhY6ZYy/FpN08orNLCVAhNeopyIxAFwLnOkoKOzrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQtbar9ly9wCeci7y5sPnjOZaMmgDmCqrqyoWAPunvTyQTTNTH/YZ29OVQjTJnYOD15EdbkJOAxa+m1s02Ncm0tIN8H1RahNpYr1BheynWtP4+2d+i47qGao3JIir+nwzSu/FuHj0odpUczkhJYuOzpU46JFJw63yBODCj5SVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap4qp1GS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3863703258fso6277842f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 16:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735605781; x=1736210581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmpj+K2wHp0aLEuoOcnqEPYmqjoBMA0H1ajOhkq5Otw=;
        b=ap4qp1GSuH4zKNSk7abIFpVSKgw3i8Ita4Q5xPYP2yGujD5/8QCLaSyBmy2OJqiX8l
         F7Wa3wGjAjVpk6SgWo87nVGA5HWmR3g1cYX4jUdpsGgR7SEZ1M7/FxVTrjHlp3Y+vV46
         B7KeMs9MNU0zEaQVl1XsItN3MLp0JXhaMeOAhreN4cNTTf4rWzBt5fHj+1XCoDMk/tZx
         MM5sK48pjUFdE9I+ttsmBHe5NAGjf+st6XWGafIxqbIXF4jvcO/CTLgCXppXJUbnxVyj
         WiePwZQNvkN6LhejJLSODPnwB1WWZO+8AZTLNz8+66HzpYoZM09IGYwzP4cT+rG4IVCX
         vHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735605781; x=1736210581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmpj+K2wHp0aLEuoOcnqEPYmqjoBMA0H1ajOhkq5Otw=;
        b=nn28lUtquEpycZZVoC2jPz62JaNYjxRtCgfOr6J+XJApB0FR+b4JMUqetxKwxCXFm6
         tBBRAredv6CTctdIiWG4TIfkPzHP2J5Oe9Nm3yMsGkTFf3EQpqN7M1p5xJaOM8p/zWzn
         joQjAcnpCOi7lMp7qfN4upJ3Gc0aHlBX2qZfXYSK0A+cLXoDIFNgVNRSjr8AUR+sWVPr
         zeZwuqJxRtM6FORPWfb/fDzhOBmztyENNYi8eLZiQ+3QJcrh5E9n9y4XYRnBHQnfOpVy
         XWv7CA6AdecaoJ+vcublp7tdc+f2BmD58LDCxKiCbK+YCPxJCTSfdh7kAMi+hhcsEYIr
         V9OA==
X-Forwarded-Encrypted: i=1; AJvYcCV0toz7qQvsl8FBr1D2wkKcn1H5kUkVSC9qzk+tRD8W5AluMMIwb+vhbdrfPIa9HwUAlW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhcG9MOfzwU0PYp+psXVgfgvUIo/YVMnqb+6EMmR/VRevI8cQb
	ZGtAwDXLLfaRJXNwNAsLIy9AuXQoFJb+9XevmvQ5jNDqBBBAki2/pIqNH7jl21Ue4P+0OW0iWN7
	h8dbvSoqE4N3gDzULtsj6Tc/mtEM=
X-Gm-Gg: ASbGncsdEKHezTX6qX6InoONr+PrLp3h6GFmiSWhEjYeOecYoZawqpXcyBtxOztrmFX
	9k5zgxFFAxorYTFEilYxUyiKL+p2ndFyZqcSaA5rh563u/hTWz+S+fvBDTHS3Co5K0lsnBg==
X-Google-Smtp-Source: AGHT+IHzbB2PKXoMoZQRTXyPbOhOACQtshn8UC1vFzko1vdGnM0EpCuJPV9wcAEl4mgeXCr7GfxxZBkO2oMAWBoIn7k=
X-Received: by 2002:a5d:6d0f:0:b0:385:faec:d945 with SMTP id
 ffacd0b85a97d-38a22a117c4mr30322723f8f.9.1735605781178; Mon, 30 Dec 2024
 16:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
 <CA+=Sn1ktCrXZMjrC0b1TNxfz1BnQfG24XUdVuktS8kRWeEP2kA@mail.gmail.com>
 <87v7v0oqla.fsf@gentoo.org> <7ZXLMz0XIsj0YzKNHVoLZ1JrCshOqeGCldUFbX3f8F14s0opaXTpmjfzZH2E10v0b2SFXk2x-DVTN5wGuUqPJQDhA3sOcVm7GeiGzKLRhRI=@pm.me>
In-Reply-To: <7ZXLMz0XIsj0YzKNHVoLZ1JrCshOqeGCldUFbX3f8F14s0opaXTpmjfzZH2E10v0b2SFXk2x-DVTN5wGuUqPJQDhA3sOcVm7GeiGzKLRhRI=@pm.me>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 16:42:50 -0800
Message-ID: <CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3rTmi8WFcvQ@mail.gmail.com>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski <pinskia@gmail.com>, Sam James <sam@gentoo.org>, 
	Andrew Pinski via Gcc <gcc@gcc.gnu.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Manu Bretelle <chantra@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 12:59=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me=
> wrote:
>
> On Monday, December 30th, 2024 at 12:36 PM, Sam James <sam@gentoo.org> wr=
ote:
>
> >
> >
> > Andrew Pinski via Gcc gcc@gcc.gnu.org writes:
> >
> > > On Mon, Dec 30, 2024 at 12:11=E2=80=AFPM Ihor Solodrai via Gcc gcc@gc=
c.gnu.org wrote:
> > >
> > > > Hello everyone.
> > > >
> > > > I picked up the work adding GCC BPF backend to BPF CI pipeline [1],
> > > > originally done by Cupertino Miranda [2].
> > > >
> > > > I encountered issues compiling BPF objects for selftests/bpf with
> > > > recent GCC 15 snapshots. An additional test runner binary is suppos=
ed
> > > > to be generated by tools/testing/selftests/bpf/Makefile if BPF_GCC =
is
> > > > set to a directory with GCC binaries for BPF backend. The runner
> > > > binary depends on BPF binaries, which are produced by GCC.
> > > >
> > > > The first issue is compilation errors on vmlinux.h:
> > > >
> > > > In file included from progs/linked_maps1.c:4:
> > > > /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h:8=
483:9: error: expected identifier before =E2=80=98false=E2=80=99
> > > > 8483 | false =3D 0,
> > > > | ^~~~~
> > > >
> > > > A snippet from vmlinux.h:
> > > >
> > > > enum {
> > > > false =3D 0,
> > > > true =3D 1,
> > > > };
> > > >
> > > > And:
> > > >
> > > > /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h:2=
3539:15: error: two or more data types in declaration specifiers
> > > > 23539 | typedef _Bool bool;
> > > > | ^~~~
> > > >
> > > > Full log at [3], and also at [4].
> > >
> > > These are simple, the selftests/bpf programs need to compile with
> > > -std=3Dgnu17 or -std=3Dgnu11 since GCC has changed the default to C23
> > > which defines false and bool as keywords now and can't be redeclared
> > > like before.
> >
> >
> > Yes, the kernel has various issues like this:
> > https://lore.kernel.org/linux-kbuild/20241119044724.GA2246422@thelio-39=
90X/.
> >
> > Unfortunately, not all the Makefiles correctly declare that they need
> > gnu11.
> >
> > Clang will hit issues like this too when they change default to gnu23.
>
> Andrew, Sam, thank you for a swift response.
>
> vmlinux.h is generated code, so for the booleans perhaps it's more
> appropriate to generate a condition, for example:
>
>     #if __STDC_VERSION__ < 202311L
>     enum {
>         false =3D 0,
>         true =3D 1,
>     };
>     #endif
>
> Any drawbacks to this?

By special hacking this specific enum in bpftool ?
Feels like overkill when just adding -std=3Dgnu17 will do.

>
> Also if vmlinux was built with GCC C23 then I assume DWARF wouldn't
> contain the debug info for the enum, hence it wouldn't be present in
> vmlinux.h.
>
> I don't think downgrading the standard for a relatively new backend
> makes sense, especially in the context of CI testing.

I don't see why not. The flag affects the front-end while CI adds
the test coverage to gcc bpf backend.

