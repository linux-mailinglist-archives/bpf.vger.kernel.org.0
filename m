Return-Path: <bpf+bounces-55817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0267A86DCC
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 16:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B49A1296
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A661EBA09;
	Sat, 12 Apr 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE4TrKgK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C354A18;
	Sat, 12 Apr 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744468500; cv=none; b=SlzJyURv02c8Jxv+zLb8adXvWuF0XCY3l9rEVjlbdcCZyAhT4XO0f6dg9uy0w/zIgkjDBOG34V8f6iLpG3xpCKs0PSaPEC9X4LevvQZxbTzDhhHQudervtKPPdpfx/QdDj/OxkcxEJR4Q7AwhIzwoklme//7GaKO8hx9ShXfT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744468500; c=relaxed/simple;
	bh=GtaHQaWn63HftijtJQZQRtGv15J5tGIYYixfqXoqSX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnnbBZxMgFVl3B3jo2hss5EooXs2sjjjEcTjvriDRAgHw8amaJEoNRcy8E0WbB2UuWch/8nZBkv/Lax/59JW89CqEvWE9TyBsemoRlfmk0o5wWloPkgfXIPHOyuP9K3oNf3OkZVq4FAjdwf1oOGA3zYxHVRSbKvFAHcZJBn3HP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE4TrKgK; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6fed0620395so29347657b3.3;
        Sat, 12 Apr 2025 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744468497; x=1745073297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0CZCIBEOVv46N4HgRds9S9kaJYmoXB/KdKl2j5MQ2o=;
        b=JE4TrKgKMM1SkFzl63RS533UyNYDdpCtdMOzc86WpC3N3Rycg1wNufYaFh9ggKFJMk
         Ocbe2p2Cy/3/lXhp1ROy34KGx+kTgVY8DWyXXFxY4H72Ffss0pSCQRJ7gsw4+O7Kxvs6
         B8QBmBwTPx7hZb4AHd9b9hwG4mg7GHpGnAdZQtA7KOwsHvqQFbUXSwhOqHJJzFwBGPzg
         tqRM0x+EmeoWPzyIHVHv65SIXsfj8vtD6OYubskUpyfQW4Ij+zpOlQgJhiUg9tE1VcQp
         VVHavqgHcrmKDGiTxACvTEcF/OXn6iFIQb/8YZeUQFNNOpumsbh/DHneXB2Fpp/T8XMU
         0xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744468497; x=1745073297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0CZCIBEOVv46N4HgRds9S9kaJYmoXB/KdKl2j5MQ2o=;
        b=r+mcFFKnZkel4H955aEeF1riS1gfbvcwiLc9IhigANF10EDxTKpWTOORtTY7F5n8hJ
         n3DE/Z9fLs7tKzO3eefRqeVl2N7J9+E+gD4l5/kXfqMSmEy+7cCf6fHXwg03K/tDJgZ6
         yhdZDRRaf/Jj9WuZn28Fgplv+BGKIABTMyXqKe5u039M8rtqElVuXJE8v3Jw+/VHUAKJ
         K+ltReaQn/xjacks80OgteYvKh6NfrKlYM9yvVNy9tYMAWI6Sk0Sxmd69+eOSz6b0er8
         6hJauWuOMXLb61XNVzYesy7A2Q20/CnI0PBNhUlWPa/RVustID93wvFMJeKAKULYar+g
         yVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3TPUXOx/BSnPqAAnVnFSuQkH8rMWCWQL4fT+Oj29h3z5dtS0mwn8kCJy1wq0+yExkHF8=@vger.kernel.org, AJvYcCV6Lc8MdY95byQDMUmNdxvghQUrbwUWN9/+d0WJIuUSXyI184x0ZnaRqXAg+5FoY6O9Wujw8HYn9y5xlD0X@vger.kernel.org, AJvYcCVxjN6GstedzUHombnyXIfDF2kWF9dPQLUBTMbtUFb/h3YDS14Von0zyejzSkQXfEQ5GzAwtvmp0mfPU9wWV/DdqRVn@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjw1bFBpI7WQGzhRUK8e10ggZnfYDwG7cwNQH3Wd6l0o4PlVd
	5/ttUfMHY08Il0a3S4/BmqYgi6senoj6zF1Zx2WRTSpf5IZ3sZMzLk9LDI6fFGuN+E+C0/wdaKz
	QinUOMrksBnSbHAv/Nn4jtEn+ild48EVdNZs=
X-Gm-Gg: ASbGncsjlSKZlq8oO9+qrLkqZADXW2R24Sb469KALfizcW7zmoAD6yKgxi2I8HF+sYd
	zDRYJ4g84sxN83+QUFJAb2NzYGNzmMbY9Kj1Vkm2bob/3A9dpdhgQ73udi07yKQ6hCxGi4U1lu1
	bnqHBtk227WXoOCr2KJDmBv+3mg9v86Vxi
X-Google-Smtp-Source: AGHT+IEjTYXP78g15Cz449gkVxBBr4veE9O9WY1hHlWH3KC7fwfHd8U+3eUKk7K8AZSev+wYPtKX/a0M8u0B32RaZus=
X-Received: by 2002:a05:690c:7484:b0:703:aea2:6bbb with SMTP id
 00721157ae682-70559aaf5dcmr116376697b3.31.1744468496457; Sat, 12 Apr 2025
 07:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412133348.92718-1-dongml2@chinatelecom.cn>
 <20250412100939.7f8dbbb7@batman.local.home> <CADxym3bAy4aV=UJU9ge0vw055C2DzC=zubjhOBSay_88CkW+hQ@mail.gmail.com>
In-Reply-To: <CADxym3bAy4aV=UJU9ge0vw055C2DzC=zubjhOBSay_88CkW+hQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 12 Apr 2025 22:36:56 +0800
X-Gm-Features: ATxdqUHkNsfpxAuMx6-yaKg7lzG-nLvE1KZ2akMU7HhK7WiUXWFq0S76p30boAo
Message-ID: <CADxym3bAXpqC3awWBTm+zc4Wn348=7cYVCN_+em=b5qPimUTYQ@mail.gmail.com>
Subject: Re: [PATCH bpf] ftrace: fix incorrect hash size in register_ftrace_direct()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 10:32=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> On Sat, Apr 12, 2025 at 10:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> >
> > On Sat, 12 Apr 2025 21:33:48 +0800
> > Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > > The max ftrace hash bits is made fls(32) in register_ftrace_direct(),
> > > which seems illogical, and it seems to be a spelling mistake.
> > >
> > > Just fix it.
> > >
> > > (Do I misunderstand something?)
> >
> > I think the logic is incorrect and this patch doesn't fix it.
> >
> > >
> > > Fixes: d05cb470663a ("ftrace: Fix modification of direct_function has=
h while in use")
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  kernel/trace/ftrace.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 1a48aedb5255..7697605a41e6 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -5914,7 +5914,7 @@ int register_ftrace_direct(struct ftrace_ops *o=
ps, unsigned long addr)
> > >
> > >       /* Make a copy hash to place the new and the old entries in */
> > >       size =3D hash->count + direct_functions->count;
> > > -     if (size > 32)
> > > +     if (size < 32)
> > >               size =3D 32;
> > >       new_hash =3D alloc_ftrace_hash(fls(size));
> > >       if (!new_hash)
> >
> > The above probably should be:
> >
> >         size =3D hash->count + direct_functions->count
> >         size =3D fls(size);
> >         if (size > FTRACE_HASH_MAX_BITS)
> >                 size =3D FTRACE_HASH_MAX_BITS;
> >         new_hash =3D alloc_ftrace_hash(size);
>
> Yeah, this seems to make more sense. And I'll send a V2
> later.
>
> BTW, Should we still keep the "size =3D min(size, 32)" logic

Oops, I mean "size =3D  max(size, 32); size =3D fls(size);" here :/

> to avoid the hash bits being too small, just like the origin
> logic in "dup_hash"?
>
> Thanks!
> Menglong Dong
>
> >
> > -- Steve
> >
> >

