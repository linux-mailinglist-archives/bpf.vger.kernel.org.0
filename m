Return-Path: <bpf+bounces-61591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4735FAE90E0
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 00:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6455A6587
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E477C2877F6;
	Wed, 25 Jun 2025 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS82HMPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F82080C4
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889677; cv=none; b=JtExXl8sGZZrRrxrpQr3rCk38VscuWuVSxQiQzFbBXTXMM+s1QR5FmFOcoBT8aWAkf6KaKboVe6Gb5w7wymr59l36Cc0xrfqTsaukTXjlQtvP5bCO9+iyLfybo9GFvraC0tIfK88rkKKxHkhXfZVI6Us9Wcd8uFzGVYufHwHzQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889677; c=relaxed/simple;
	bh=ggcYuE4lDup6MZ8FVsR4DD8ALnc/SKKWiJDBZ6g9iOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnOkp2cmm0HrYcQUsmrxRVdJ5jrOACsgqv1imxb3XCFtfxJaGQz8zphrGHey0RaspgBriPJhw99JYHL3Qd3CsdyhF58DqBaqMv40n/ECKbHAbieJoGaK9Zhdgrcmi9KDZa3l6p2IqgaUNlaPmbNbicVxM2F15hF7ciQsf0bGI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS82HMPM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d54214adso1831645e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750889674; x=1751494474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFHpj02e/x48vN4FywPS0RJhtFa7unM1dbdop+tDFsk=;
        b=fS82HMPMasay3h/NppxM0WM0ek/SkxiqGP0c2teRgqguqjjdJqedQ9pFVGCYwcTbi/
         gbsLdN3/2bp7tGft1MdVix9Rt2QKIZT/7fEXWZLA1lMWlk1IRicth0wETSE37/Vqkwj3
         1JE9s9993S41ljiRVabZaLlUGT45ua384lVS6U1Vce/s6BhebAZz9jFLn3Z63nLCdKRt
         i+wyzisIONRxUCNhYtXccWMyxAFsHYurS/cCCJ6rUDmTXHRlXKQ5kjhvK9yZxV8oUL5X
         etW4cvrepnMeC5+aUbwMe9u7t00ZMOl3Mb7w95YvIvgh97yvVTxgnfyZly6zsPrcHEUC
         Eraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750889674; x=1751494474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFHpj02e/x48vN4FywPS0RJhtFa7unM1dbdop+tDFsk=;
        b=oQaNlhu0bua+4DAJZrBd1hTmW1Xfa5Zj64OO7+0gSt1mgY0Qbo9C9sDXkCLC2XFScC
         tDyr6oPIhnhQJOGt6k02GstMnqs3i+F2v/xxBi1wuMncSmVFrBeLfoeftubxcSaEmjoF
         vpY2WYogOtMqiwU4bqrQBpFKLOx5Wsl+kIZ1D0Pl3186oq+ozPe5l31BDWMLuSPVQZ5L
         ksIZjLZDfUj710MQLaEoib1hob2/jr8md7bfJMl4HAC/TxaiEuTqD3S+f43iA8pcEerE
         hTyzPcHeWCQI/ygifDKgPrrJx0ZeZyBcw7SY7e66v1WqFYEc4N1epK2y7z61oDMZbKb9
         SrQg==
X-Forwarded-Encrypted: i=1; AJvYcCVm9NKAHcZKUie3mmSW7021vjv+KxhjnHSDq/KBwH2eog1rfXgPxg3tKEnOBq9C+V2iGio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhlq51MHfVddVny+Hi49eXu1wsV3sIhsyap9mjkHLvpS9XeXM
	H9kxlOeYULKCu99Keudi18TZ5irQPCsQ4RAw5FcM+HjV2TM2Uit+BshTc1WQxS30zp7mFT+sT1w
	k0+0blg7QnAaoQoaHsx5pcV0jhPoTTr2JWw==
X-Gm-Gg: ASbGnctIQVtZDIBWRIoj3EHZVbC+wvmkmv7OwgHvmzFxK/5qoLoDoJpyVGBsXjvmJgU
	Hb1J8TPU8sd7lroNvR6BOMoYmHjSR61azUk4v6mXmjcor36xv1Bagwjqw2UinQshDQZcve4r3Fj
	IgrwLVfRyT+31HxqWH6hl5ectnuKz2w3ekWYuDxWnn2CbNJYzKd0laY38SsogiS1O2ZUklakza
X-Google-Smtp-Source: AGHT+IHR+03yvGkYBhK2BdL97/XmqFvJ8NJCx+iSogTEqAST/JaC4AvmoohHUYlBFJD4Wd5XZ3wW7l6NqgW1NtO5Ut8=
X-Received: by 2002:a05:600c:1f91:b0:453:8042:ba9a with SMTP id
 5b1f17b1804b1-45381af1dc4mr40693925e9.28.1750889673865; Wed, 25 Jun 2025
 15:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625182414.30659-1-eddyz87@gmail.com> <20250625182414.30659-4-eddyz87@gmail.com>
 <CAEf4BzYv1GKz81pVsCoeBBO5pdc76bkdg-AY6vA9sbbaXE3Eew@mail.gmail.com> <8fa3ad36c2754bfa9a9b7366d47a1d2824c81ce1.camel@gmail.com>
In-Reply-To: <8fa3ad36c2754bfa9a9b7366d47a1d2824c81ce1.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Jun 2025 15:14:22 -0700
X-Gm-Features: Ac12FXxt4wzeYLod3fq1dtc8qLJLg3fu4eiMH70asWaYNZ_vrQvHGO8C3KOt8Us
Message-ID: <CAADnVQL01nd7oe=ahQy=ABmkQB2mUOLQLpjFOmWT4bbQAqQpSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: check operations on
 untrusted ro pointers to mem
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2025-06-25 at 12:38 -0700, Andrii Nakryiko wrote:
> > On Wed, Jun 25, 2025 at 11:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > The following cases are tested:
> > > - it is ok to load memory at any offset from rdonly_untrusted_mem;
> > > - rdonly_untrusted_mem offset/bounds are not tracked;
> > > - writes into rdonly_untrusted_mem are forbidden;
> > > - atomic operations on rdonly_untrusted_mem are forbidden;
> > > - rdonly_untrusted_mem can't be passed as a memory argument of a
> > >   helper of kfunc;
> > > - it is ok to use PTR_TO_MEM and PTR_TO_BTF_ID in a same load
> > >   instruction.
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  .../bpf/prog_tests/mem_rdonly_untrusted.c     |   9 ++
> > >  .../bpf/progs/mem_rdonly_untrusted.c          | 136 ++++++++++++++++=
++
> > >  2 files changed, 145 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/mem_rdonly=
_untrusted.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/mem_rdonly_untr=
usted.c
> > >
> >
> > Would be good to have a test that demonstrates loads of all
> > combinations of signed/unsigned and 1/2/4/8 bytes. Maybe as a follow
> > up?
>
> Will respin.

Applied. Pls send a follow up. Easier to review this way.

