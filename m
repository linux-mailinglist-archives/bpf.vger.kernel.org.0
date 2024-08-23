Return-Path: <bpf+bounces-37962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DD95D3BF
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D01F23DC5
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9C18C354;
	Fri, 23 Aug 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCYuVDEb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78718BC34
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431997; cv=none; b=lsrkqB5RxzhhayKH2S2bK8VF13eO/UNnANbR/J0nWCvpcPLU+ByPAoDXhF6hGFWbT11MTOtQsd6F+Q1sVtY6sd/a15YzaPjIec+kkdl8rATA9s9Q2sRdz2ckwwHUNm21e3EC5CuJ4IL2YG7b8oIGYhSJnlzfpXb1XZ3K6P5urjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431997; c=relaxed/simple;
	bh=LOPrgt/5fHGxoWcegx8MJpTlS+5be1+OrL5bWg2/GRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boWlrlWiLwqqZkEhEIaMj97rCDqATm7P8MrWmhMbjQgedDSOTuG+iWrb1DpNTeu0ARmE5c+bTDkwcayonczpAhWtyk0UsXhQsOcgruWnq3vNN9rSLCYG+vmsLz8SUOjcW/6gE/lw3PButtG5Zc5kM7o8bUVecGvFOihZVtf+eyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCYuVDEb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3bc043e81so1771303a91.2
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724431996; x=1725036796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tL//0+CRrFrSzqR0KS2LxkVR/zA95Rs7U7jrWvRMqWw=;
        b=dCYuVDEbamdZM/4GG9gZI1M2BBXUVMwHnGawebvXZ44aIxvc6zgE3mDJmbIZrYPSiv
         EB+TF65HeRcTL7IDXQuZIOW7BMmktnOSBEWScNrTRo+jZSeGMxrGZ4OQFbMrMJgaGrou
         x6AvALKpt8vUVNYea0sUujIZHCWoah0SA8Fg3J8Sp2JQr079Vbt+vUrDX396E7XNLoRT
         1S1ugoXJSe5ZFjNpzp/EWNnPa0VUvUd3ggwe+rXRNmuBO0Fr+7NlSPsDs0NDS6VIL2pX
         ttFgsZ3wigTvKLz7f46SFk8f/lWsjmX/P+3SrSUpI7220PEB4om/m9ZqP+QF0TT7C/nZ
         HnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431996; x=1725036796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tL//0+CRrFrSzqR0KS2LxkVR/zA95Rs7U7jrWvRMqWw=;
        b=KpLqeZhopXXXXBtlGcVyeia23bTn9AnXO41nNJIySRdurOpJ8wdWvXZ5cxE8rRrD4g
         wiKv9aISn7zmEiqrdiNm1yOr9Z+b8wL25I2tj2o0JvUt5Duh0NXrTeMdkLQqI707dgKG
         tBrUi98QqX8E4GkXXDwxGrSC+Csai0MPDQmqINB3Sa8C2wgBzZiXkKqfwID2swfjrFx5
         FQ7ShiO7M1JKUD5NlDiR6xbp7OvSDEsR+Ud2wd8BcJdYNparyhcvdFdMnJfHQ95nMOhV
         293m37aseQWgoaikree0FEMxYeeGRGAKZW18KCqHjK5Nbwka71IzJ7fdY6XEh7y7zMt9
         3T9g==
X-Forwarded-Encrypted: i=1; AJvYcCXRHCkzKay6yF9G12wIA1u7do5LnES0fVH67m0NEV+2kwRgXHlnlNuy8mg6i8AduTKjwrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4F0lkhi2As5xpdBUVaSwoke2DC97sGyUNDatuZkweH0Q73lEF
	1Cko7+UxKGVrNpnmCEOciVTi9Tm4S6FKdXtkrkEB3ub7GdXoQ7Jp+N+ob+WWcgVzG6Ap+3NJLF0
	9IEgP93GUO9hujdpwbjI7ZQ7TrtwuXg==
X-Google-Smtp-Source: AGHT+IF+FhzgyQHsk1hc2jYMC/6Dwim8Nv66UQlV/CbsTuvkCTiDfwLPmdXpj2oWKruJKQ3YnzdI3jwvVB7Gb5M9cH0=
X-Received: by 2002:a17:90a:62c9:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2d646bc9361mr3067159a91.14.1724431995627; Fri, 23 Aug 2024
 09:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806230319.869734-1-andrii@kernel.org> <ZrM5ZKXwjKiWjRk9@krava>
 <CAEf4BzZb_-Rw9miDyb8+ABT9siK7eUeigiKaLqch9DDz0EBSbQ@mail.gmail.com> <CAADnVQ+mq48x3dELpAajq+uihfGvfGjV-3kHeSwpDarovAkTKg@mail.gmail.com>
In-Reply-To: <CAADnVQ+mq48x3dELpAajq+uihfGvfGjV-3kHeSwpDarovAkTKg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Aug 2024 09:53:03 -0700
Message-ID: <CAEf4Bzb8vSYVYqcoSVicFOVkpeAdd+MmC56m7o7KipnycWbq4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: make use of PROCMAP_QUERY ioctl
 if available
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 7, 2024 at 8:17=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 2:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Tue, Aug 06, 2024 at 04:03:19PM -0700, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > >  ssize_t get_uprobe_offset(const void *addr)
> > > >  {
> > > > -     size_t start, end, base;
> > > > -     char buf[256];
> > > > -     bool found =3D false;
> > > > +     size_t start, base, end;
> > > >       FILE *f;
> > > > +     char buf[256];
> > > > +     int err, flags;
> > > >
> > > >       f =3D fopen("/proc/self/maps", "r");
> > > >       if (!f)
> > > >               return -errno;
> > > >
> > > > -     while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, bu=
f, &base) =3D=3D 4) {
> > > > -             if (buf[2] =3D=3D 'x' && (uintptr_t)addr >=3D start &=
& (uintptr_t)addr < end) {
> > > > -                     found =3D true;
> > > > -                     break;
> > > > +     /* requested executable VMA only */
> > > > +     err =3D procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXEC=
UTABLE, &start, &base, &flags);
> > > > +     if (err =3D=3D -EOPNOTSUPP) {
> > > > +             bool found =3D false;
> > > > +
> > > > +             while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, =
&end, buf, &base) =3D=3D 4) {
> > > > +                     if (buf[2] =3D=3D 'x' && (uintptr_t)addr >=3D=
 start && (uintptr_t)addr < end) {
> > > > +                             found =3D true;
> > > > +                             break;
> > > > +                     }
> > > > +             }
> > > > +             if (!found) {
> > > > +                     fclose(f);
> > > > +                     return -ESRCH;
> > > >               }
> > > > +     } else if (err) {
> > > > +             fclose(f);
> > > > +             return err;
> > >
> > > I feel like I commented on this before, so feel free to ignore me,
> > > but this seems similar to the code below, could be in one function
> >
> > Do you mean get_rel_offset()? That one is for data symbols (USDT
> > semaphores), so it a) doesn't do arch-specific adjustments and b)
> > doesn't filter by executable flag. So while the logic of parsing and
> > finding VMA is similar, conditions and adjustments are different. It
> > feels not worth combining them, tbh.
> >
> > >
> > > anyway it's good for follow up
> > >
> > > there was another selftest in the original patchset adding benchmark
> > > for the procfs query interface, is it coming in as well?
> >
> > I didn't plan to send it, given it's not really a test. But I can put
> > it on Github somewhere, probably, if it's useful.
>
> With and without this selftest applied I see:
> ./test_progs -t uprobe
> #416     uprobe:OK
> #417     uprobe_autoattach:OK
> [   47.448908] ref_ctr_offset mismatch. inode: 0x16b5f921 offset:
> 0x2d4297 ref_ctr_offset(old): 0x45e8b56 ref_ctr_offset(new): 0x45e8b54
> #418/1   uprobe_multi_test/skel_api:OK
>
> Is this a known issue?

Yeah, that's not due to my changes. It's an old warning in uprobe
internals, but I think we should remove it, because it can trivially
be triggered by a user. Which is what Jiri is doing intentionally in
one of selftests to test uprobe failure handling.

Jiri, maybe let's get rid of this warning?

>
> Applied anyway.

Thanks! I just found another auto-archived patch of mine, the one
adding multi-uprobe benchmarks (see patchworks). Please take a look
and maybe apply, when you get a chance.

