Return-Path: <bpf+bounces-42231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F39A12F4
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 21:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CEC1F260B5
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04D2144D2;
	Wed, 16 Oct 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGJb5wVc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECB125B9;
	Wed, 16 Oct 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108417; cv=none; b=AXpjAYjNmQm7vrD6KEHkJcgj4+6cUovnYdzl1uWNl83Ukmv1y0AumzAkYTbFPMuduuMuadPjeFCJf9EpmU5RDN0OzhRiIj1nRy2j2yLPLKCOt8XW1wPV89lb7NJIZKHIU8cwvH4r+fmNvPkGk3wh80ZiznsIHnTZ9c1Ef6UnoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108417; c=relaxed/simple;
	bh=2+LdI34hBdYlXaQ3acoyHsBvL7UYd0RqfsteMAH5VTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aompUwGaV288LSREj4qRDiZVMRiiDwUPnYoFDPpYCuWG15qRzfHuKyyhJvTzAbQ7wAlBK8ZDvcamZGJFUHs0QjH73S0XmFDQXrqO7kkB/1fwPxVCdHLefNDHRvYMpi7HI3bzRikTt8nMLn2FHi5XYqlJEKmrpD3v8FeuXnoeT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGJb5wVc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so116943b3a.0;
        Wed, 16 Oct 2024 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729108416; x=1729713216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3jo1qjlqrmtPNv7P6ZuR6I8CHs+OVI/opjK1poh7Wk=;
        b=AGJb5wVcqxBqzZP9K8vZJuNT/j1x/mVY7NCVluE6Cf0tlhtcGXIG6RxRift5LeqNpZ
         FzM+qBHeIwglZmFVV8op/NPZBaUgTHnUb4zF2viGMop4zsNtl7a6zNyXUljpJ2m4pXD0
         ivI3QMGCK3znugzALRTbXqjw9RhLCtpPtZxE03MuNrBKkWNRHxz8QAQHoWuOEV7RrzlV
         G+jmuraPvCyxld20H3SOVpo7tG50SuYw434xEAoYJb/ee9X/n2tQ+iF/PVO67wAL3d1M
         NE60r0pTDNWQBh9LOIcC6l6tn8d6+UZFCWqQY2xo9awxeOCAzqRZ+HeGY1Nw+UtE/tjV
         W3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108416; x=1729713216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3jo1qjlqrmtPNv7P6ZuR6I8CHs+OVI/opjK1poh7Wk=;
        b=xP++3fK5v2aUnjwjmyGZrVLSBwjD4LicCo+RJY2jfhoMGTyP78xP97h3kFSoxSTR3c
         vi5H8dDKXyP71VOUriOgeXeuZsacSRk7CPURLWd+7kFhnPch0cv6aiZTRGOyfZNu2G/d
         ZHMVBXZq2aYj5lrOG+ccT9SlMmiGiNFZoABvtP7vS+gZBSOLRGDLbK4bsmvjK77sCLrt
         KQuYEjFI1BoQHH5RR34UoioylP/48SK3Wxe9S9hchNPxwMYfu7erzh6rNswmeVgjREEK
         8W85par4nZSrD+CP5WHoSxqnEb6cRCFgdvYlkRkXxAlda64Bj2gS/W+yVf1BMAGt8kYT
         5MEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf+40mLBaUv8/4s57kASVnUMirvgI/uZsPXobda8Ga2Hk2M3ZaFe/cuYBCB47UosfxBJ8=@vger.kernel.org, AJvYcCXYks1qGU4zvz6LJJ98U6sJ98tI0lOW5d1pQ98wfxlOjDqzgTzHuYQj72B3hFZqi6gF3looOl4DwQRi8GWxe2WHshnY@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSenp1nbtad6CENmF2Ufyw8m9CHqpsfxmvXTKVbJUzmDKbBAL
	Wac4pGhkyPTP1ley7NzP0w9nuvH+Vvs55LyYaleeeJeAJGmMEkT8Ok1CaWookwZTk8vvKhY4D/5
	xOOoDo5bMpxSmYe9IFRXcB+vAb/GgCQ==
X-Google-Smtp-Source: AGHT+IHYhzGBu+iHmgEu/gy3l3AsayNdvFNZsusa1SUdCo+0trKIr3bJ7xJ9XAhfan03ZGNCMb3PJqlisAVsYE/5grM=
X-Received: by 2002:aa7:88d6:0:b0:71e:786c:3fa9 with SMTP id
 d2e1a72fcca58-71e7d8b6477mr7199001b3a.0.1729108415809; Wed, 16 Oct 2024
 12:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425000211.708557-1-andrii@kernel.org> <CAEf4Bza9X_yp84ujDMwGengK1wTPjwZhtH7aXtPfXj6eT1M5Eg@mail.gmail.com>
 <20241016095324.6277c64a744af80c704c3636@kernel.org>
In-Reply-To: <20241016095324.6277c64a744af80c704c3636@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Oct 2024 12:53:23 -0700
Message-ID: <CAEf4Bzb+bTzcRpJVQC4o-hOG5BSavvdfTiQjg1YhfqA7spr7cQ@mail.gmail.com>
Subject: Re: [PATCH RFC] rethook: inline arch_rethook_trampoline_callback() in
 assembly code
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:53=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> Hi Andrii,
>
> Sorry I excavated this from patchwork.
>
> On Mon, 29 Apr 2024 15:38:08 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Wed, Apr 24, 2024 at 5:02=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > At the lowest level, rethook-based kretprobes on x86-64 architecture =
go
> > > through arch_rethoook_trampoline() function, manually written in
> > > assembly, which calls into a simple arch_rethook_trampoline_callback(=
)
> > > function, written in C, and only doing a few straightforward field
> > > assignments, before calling further into rethook_trampoline_handler()=
,
> > > which handles kretprobe callbacks generically.
> > >
> > > Looking at simplicity of arch_rethook_trampoline_callback(), it seems
> > > not really worthwhile to spend an extra function call just to do 4 or
> > > 5 assignments. As such, this patch proposes to "inline"
> > > arch_rethook_trampoline_callback() into arch_rethook_trampoline() by
> > > manually implementing it in an assembly code.
>
> Yeah, I think it is possible, but this makes code ugly, that is
> trade-off. As you say, we should move this with other ugly inline
> assembly code into kprobe.S or something like it. With my current
> fprobe-on-fgraph, rethook is only required for kretprobes, so it
> is natual and simple to have kprobe.S.
>

Alright, I'll wait for fprobe-on-fgraph work to land, and will look at
the LBR "wastage" and see what can be done to minimize it. If at that
point something like this is still needed, I'll follow up separately.
Thanks.

> Thank you,
>
> > >
> > > This has two motivations. First, we do get a bit of runtime speed up =
by
> > > avoiding function calls. Using BPF selftests's bench tool, we see
> > > 0.6%-0.8% throughput improvement for kretprobe/multi-kretprobe
> > > triggering code path:
> > >
> > > BEFORE (latest probes/for-next)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > kretprobe      :   10.455 =C2=B1 0.024M/s
> > > kretprobe-multi:   11.150 =C2=B1 0.012M/s
> > >
> > > AFTER (probes/for-next + this patch)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > kretprobe      :   10.540 =C2=B1 0.009M/s (+0.8%)
> > > kretprobe-multi:   11.219 =C2=B1 0.042M/s (+0.6%)
> > >
> > > Second, and no less importantly for some specialized use cases, this
> > > avoids unnecessarily "polluting" LBR records with an extra function c=
all
> > > (recorded as a jump by CPU). This is the case for the retsnoop ([0])
> > > tool, which relies havily on capturing LBR records to provide users w=
ith
> > > lots of insight into kernel internals.
> > >
> > > This RFC patch is only inlining this function for x86-64, but it's
> > > possible to do that for 32-bit x86 arch as well and then remove
> > > arch_rethook_trampoline_callback() implementation altogether. Please =
let
> > > me know if this change is acceptable and whether I should complete it
> > > with 32-bit "inlining" as well. Thanks!
> > >
> > >   [0] https://nakryiko.com/posts/retsnoop-intro/#peering-deep-into-fu=
nctions-with-lbr
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  arch/x86/kernel/asm-offsets_64.c |  4 ++++
> > >  arch/x86/kernel/rethook.c        | 37 +++++++++++++++++++++++++++---=
--
> > >  2 files changed, 36 insertions(+), 5 deletions(-)
> > >

[...]

