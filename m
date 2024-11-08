Return-Path: <bpf+bounces-44368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8999C247C
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12DC1F24242
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E41AA1D9;
	Fri,  8 Nov 2024 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtWceFXJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6A1AA1D5;
	Fri,  8 Nov 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088537; cv=none; b=gzVPzWc6gb49+J7YB6XDS5CPojSPLap666Q6sIYLHcwCH6tb7T6U90eOvsNcjyOKTmoxmmvWEtJX3UaWzKPq4DZ5rSsdK+Swp7yUgbdoD7VAze+0auWHw86KBaLJIrcsogL4cbAmpw904k2/QBxF5ip7JklqSn49dWzrP9dTgII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088537; c=relaxed/simple;
	bh=6Be2zZmok8+FJyIvngjK5YwbjHdQXMXGAmDpwlg5kHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMo/h2ihxBfmu+bZMq5yvu+LrrH+cydOpgstKhMWpcXDoUSnp53i/EKK8BjdaMzpuQtu16OlIv4NvtY7QqAvfHMZp03VLonyp3/EutEVVUytzzHcddtZ1tbzQ7s5PNmk1NdwOAms2SSKHkNiSK/x7b70fb0XrKGuF41fiAtnZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtWceFXJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso1776583a12.2;
        Fri, 08 Nov 2024 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731088535; x=1731693335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceiSDlz8Fam1FXwnYY+imkYK7NIk6M/pjIik182t3g0=;
        b=LtWceFXJNQnYj3vHYPMjkCsjBhGYPkJE5vXrPgx5yckuUSBUvvRenMHMRUp2xk63Uq
         J81tCpVp9eKTwjs91pzEbQaV062xSkDzNwdK4HVYZddEhWhfWT4dm+YBt2nwtoWNam8K
         ulG6ZsLNkUsLjw7megbpnVCbe4I7qeXBlmVER7qgsLNl6hOI7Ppjf06JAIAh3VFj7Hf/
         4nQVkM3Cddur3AOLqCeZ9ty35goZRZ8pY2+T2B+o2tNX6S6eVFPwNumA1IEfRrYFbuWw
         bRT45g2h5w3Fcq2WjOr1p+/z3NWElYqLxohgNnVM2D9fvr9hLLUjBV0Yvq5LLFkMKlps
         v51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088535; x=1731693335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceiSDlz8Fam1FXwnYY+imkYK7NIk6M/pjIik182t3g0=;
        b=p2AmfzmpBLLwxpAaDbCrHz4xwm9GXx0wBXoa5B98BlZ7b/MRfJIBJQ4hQ/1pjWwgZ2
         2cy3kfJZzZP5OqmgRbNF5fivIeRMDjGN9mTOMiewKHLF6E0JncksQfUypmWWudZWJo5j
         s6axhFrFHqY1devpTuG0PUdyriRUEheqheX9SM227KCQFe08exHQK1a/Hzthra+nRo1j
         dZTnglaJfj6FgYbJeH0N8fv0OPZPnJ04kRAy/0V8PPRiG8Br27rt/vl/3YmkAhuszSGk
         hfUTHSt5B0ppCSejl8+fAEoy7d+wrC51R1RSeWbUgBN6576s+4oQtqhSZGxSVzaMqZaX
         O2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXFiDawB5aWX1VT1hRTkFp04pYBbzDbVvMVthmrp7RE1p5Jz3a6fPDu2HiITNC1JXvfPCKzj2t@vger.kernel.org, AJvYcCWX6oFdDXdxAEWjyWCOG/1eUG6+dNhUazkABfn2bGD/RXsqiyrPpIAUrhUdpopUdK/xhqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGc76aLRFCezMYpBAnDO4HRoIykc183Y1JqVLCF6P/FYPtCqoN
	A0M1w8nOyvJxKXo2HXZBwWOCMQUSAG5HICrPUyGhWDyNQKiNgFCqxOozNptPhHBH33w+ueBMw14
	+wp3obQRPc9o95TJKNhQZvHLDVeI=
X-Google-Smtp-Source: AGHT+IFRIe9RCqzw4cD4O7BE9acjg0FmuHFwCXKuUCTchs3hqT2UI4LxphL9lFIDM0j9I8o88+S4SS5JUMcJ9q/E+6E=
X-Received: by 2002:a17:90b:4b11:b0:2e0:7560:9334 with SMTP id
 98e67ed59e1d1-2e9b1748a44mr4622999a91.36.1731088534759; Fri, 08 Nov 2024
 09:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104175256.2327164-1-jolsa@kernel.org> <2024110536-agonizing-campus-21f0@gregkh>
 <ZyniGMz5QLhGVWSY@krava> <2024110636-rebound-chip-f389@gregkh>
 <ZytZrt31Y1N7-hXK@krava> <Zy0dNahbYlHISjkU@telecaster>
In-Reply-To: <Zy0dNahbYlHISjkU@telecaster>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Nov 2024 09:55:22 -0800
Message-ID: <CAEf4Bzb9G6owbNapP_9tv=kK+CCL8boSmf1pGBTQ9K9U5r6=vA@mail.gmail.com>
Subject: Re: Fix build ID parsing logic in stable trees
To: Omar Sandoval <osandov@osandov.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 12:04=E2=80=AFPM Omar Sandoval <osandov@osandov.com>=
 wrote:
>
> On Wed, Nov 06, 2024 at 12:57:34PM +0100, Jiri Olsa wrote:
> > On Wed, Nov 06, 2024 at 07:12:05AM +0100, Greg KH wrote:
> > > On Tue, Nov 05, 2024 at 10:15:04AM +0100, Jiri Olsa wrote:
> > > > On Tue, Nov 05, 2024 at 07:54:48AM +0100, Greg KH wrote:
> > > > > On Mon, Nov 04, 2024 at 06:52:52PM +0100, Jiri Olsa wrote:
> > > > > > hi,
> > > > > > sending fix for buildid parsing that affects only stable trees
> > > > > > after merging upstream fix [1].
> > > > > >
> > > > > > Upstream then factored out the whole buildid parsing code, so i=
t
> > > > > > does not have the problem.
> > > > >
> > > > > Why not just take those patches instead?
> > > >
> > > > I guess we could, but I thought it's too big for stable
> > > >
> > > > we'd need following 2 changes to fix the issue:
> > > >   de3ec364c3c3 lib/buildid: add single folio-based file reader abst=
raction
> > > >   60c845b4896b lib/buildid: take into account e_phoff when fetching=
 program headers
> > > >
> > > > and there's also few other follow ups:
> > > >   5ac9b4e935df lib/buildid: Handle memfd_secret() files in build_id=
_parse()
> > > >   cdbb44f9a74f lib/buildid: don't limit .note.gnu.build-id to the f=
irst page in ELF
> > > >   ad41251c290d lib/buildid: implement sleepable build_id_parse() AP=
I
> > > >   45b8fc309654 lib/buildid: rename build_id_parse() into build_id_p=
arse_nofault()
> > > >   4e9d360c4cdf lib/buildid: remove single-page limit for PHDR searc=
h
> > > >
> > > > which I guess are not strictly needed
> > >
> > > Can you verify what exact ones are needed here?  We'll be glad to tak=
e
> > > them if you can verify that they work properly.
> >
> > ok, will check
>
> Hello,
>
> I noticed that the BUILD-ID field in vmcoreinfo is broken on
> stable/longterm kernels and found this thread. Can we please get this
> fixed soon?
>
> I tried cherry-picking the patches mentioned above ("lib/buildid: add
> single folio-based file reader abstraction" and "lib/buildid: take into
> account e_phoff when fetching program headers"), but they don't apply
> cleanly before 6.11, and they'd need to be reworked for 5.15, which was
> before folios were introduced. Jiri's minimal fix works for me and seems
> like a much safer option.

I second that. Custom fix is minimal and keeps the rest of build ID
logic the same without involving all the folio conversions. I'd just
apply that.

>
> Tested-by: Omar Sandoval <osandov@fb.com>
>
> Thanks,
> Omar

