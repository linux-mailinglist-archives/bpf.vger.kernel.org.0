Return-Path: <bpf+bounces-63347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC32FB0650B
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E168567B56
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE85283121;
	Tue, 15 Jul 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPg5KNHq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30883283FF2;
	Tue, 15 Jul 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600067; cv=none; b=ibQrs9xwwjM/QrGBcT9VfBsOljiLfZC96DqEdts0qZjV0/SjHiFaTmPlvcmvhAgD/CJkzCl3Hzvn7uwMKsYL5cMS12uGzKskvL5IGnF3DCvZeRFmNYZ/6Xo/O9Y4Nue52L4u0zJsC1zTkI807q2ZT26lHRDqUJSDUeM67+VItBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600067; c=relaxed/simple;
	bh=PC1C1GWJWmASfyzEgwSyIitCe3PS0JdsA8GKO/XwKiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=av61XZf6Ar1LtfYIXC39AkEjKq+5PqX5VT0ECGUaNz3IZ3eG/MmQoTWgPbUoYWG2KTims/d4bjXhbe7pDcMKJDlQciDNEp5JxYXbZhHqiUZoThX96e3PnjTnjGJiIhbibV4S+RwLZpjHFggBO0NJSVuvcDi32DmAvbL6pnn7lTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPg5KNHq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31c84b8052so6624198a12.1;
        Tue, 15 Jul 2025 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752600064; x=1753204864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqm8/q8UocxlxtANI1zNTfyh+AvK1KlyxG9VxsCT0bs=;
        b=KPg5KNHqW73CeikW5Q2/RuC1hqwJOBqISEhyBlgaq2eQ0V9AWZ+/9G3zyWOJQsxXU0
         A4ZqPGD2zZkleCVGrMY7QjmfJXIr0hIukeSldtYybnbahJGfw61s7VfW/jpTAY0xMcXm
         bCIlBYxsXZVx4qzqIkr8SaHdD4TP9kFTyqCBIMzRn7Uj6/ujQ9tuMoflqZg0QiIRsLht
         616K029XmzsT5oVV92vzwDkitBodpKXfQqiwiHc66AkAvqFhgYiK0KzHb7qcO4/ns6up
         1ppaxBXboyymKmKXMeLAEe67IBIvQuZ1W34M5osysclcSUtKeQ/gLLjziTmohcj1dFNB
         hqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600064; x=1753204864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqm8/q8UocxlxtANI1zNTfyh+AvK1KlyxG9VxsCT0bs=;
        b=OZC696+I3NrURrt7RHX2VDTQvFBTf5CJUoUMYebwTBApEZwM1RF+1awxP7EWXkl2re
         QZXZnHmGQR8ZtJvUHHLzBUG1zbxsBdBzF56slsZ0kx/hyLDvLK8s5geCEjBDmUGQtIwt
         HXM/fnW3KlQ8f4ZbJqWuI5pak7rM7JF3E5g6GdWXcTG+IUhZVCqkeEWsAWKjI8DEJcRf
         GwSwu+lRPyFZLxyk099g4SFztVKn8si5BFBI8MbYPbrCYVqkiQ58Yup5rW1il+pSJ1q9
         lDNwDvpZVFkTLcWMNc3iIXi9pK0RXuhSKrtwdsIDptiYn+tDilrBLrZg6vb1FQ9ENlKb
         Fq9g==
X-Forwarded-Encrypted: i=1; AJvYcCWoDeaM/MecB7gfJMWoBHoHwLBBKsVo/AW/roPBTFcRhjjCCSCkdG9AjF5q7Ym/ruKu5f8=@vger.kernel.org, AJvYcCWpbd5evQrL+fySxpICLG+jqD8FK/d5V9h1D/aK4qetaChyJ9o7FIPnhF+LIm2ID2hBoZOZcCV+Rd5WK/Mi@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnPysBmNCcmSE2c1o1PxSZOjeMOVQV3LEst1XdjELoBoVxvBZ
	SXbG6bvr8Yf7hObCutp0NiV/efxeiZTbDatWAO4xSDn7WiMjM9h9c6l3FGH0YoJ3Tc6UL6IhswS
	APSZ/yKUkrbegZ3XTHwOz56dtYx9E4BM=
X-Gm-Gg: ASbGncsF2GCgt0URESHVeEQZntOGawfb4UsfyDJyAEitLU/Sz12PvIDttmp5oU5ice0
	tqWDgzPREcJ/GzT+d3i1CVMAa0wFe5n/j/hF30HDUo/xlxAHihjkRChDBSSxDhAD6jsww6KVOwM
	lP40n7G0kuZesFrxPP/FVEiywPaGeZ+4tbi7LVuyNpVQl8YXTj6AWWDYkEeJn6ufYsUM+5Lisnc
	fleWNa4QP5gsCTtqb5FEHw=
X-Google-Smtp-Source: AGHT+IGwjUqVmdtiIjw6Nu5S75iJkbIMSYxh8t6Cmh5xK8Z+09Ys1siXbokXDsIzEcC7MMmkO1oUlhUHxljztOXh0gs=
X-Received: by 2002:a17:90a:d610:b0:313:fb08:4261 with SMTP id
 98e67ed59e1d1-31c4cd55c4cmr25773490a91.32.1752600064291; Tue, 15 Jul 2025
 10:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-15-dongml2@chinatelecom.cn> <CAEf4BzaoKNNf5pr4z8vEokj3AyLNZYyjYQUOoEMMZHN6ETUg4g@mail.gmail.com>
 <22e15dd2-8564-4e71-ab77-8b436870850d@linux.dev>
In-Reply-To: <22e15dd2-8564-4e71-ab77-8b436870850d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 10:20:52 -0700
X-Gm-Features: Ac12FXwVpBVFHaybltYf_upP5_ZJM3qFhvAiy1VHP8HIn1lXWK9s3dTCf3Q_IVU
Message-ID: <CAEf4BzZCPcq0eo=1SN-r=k5QF1XE5hihEYHYYdi37aiV7VXwVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 14/18] libbpf: add btf type hash lookup support
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:41=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> On 7/15/25 06:07, Andrii Nakryiko wrote:
> > On Thu, Jul 3, 2025 at 5:22=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >> For now, the libbpf find the btf type id by loop all the btf types and
> >> compare its name, which is inefficient if we have many functions to
> >> lookup.
> >>
> >> We add the "use_hash" to the function args of find_kernel_btf_id() to
> >> indicate if we should lookup the btf type id by hash. The hash table w=
ill
> >> be initialized if it has not yet.
> > Or we could build hashtable-based index outside of struct btf for a
> > specific use case, because there is no one perfect hashtable-based
> > indexing that can be done generically (e.g., just by name, or
> > name+kind, or kind+name, or some more complicated lookup key) and
> > cover all potential use cases. I'd prefer not to get into a problem of
> > defining and building indexes and leave it to callers (even if the
> > caller is other part of libbpf itself).
>
>
> I think that works. We can define a global hash table in libbpf.c,
> and add all the btf type to it. I'll redesign this part, and make it
> separate with the btf.

No global things, please. It can be held per-bpf_object, or even
constructed on demand during attachment and then freed. No need for
anything global.

>
> Thanks!
> Menglong Dong
>
> >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >> ---
> >>   tools/lib/bpf/btf.c      | 102 +++++++++++++++++++++++++++++++++++++=
++
> >>   tools/lib/bpf/btf.h      |   6 +++
> >>   tools/lib/bpf/libbpf.c   |  37 +++++++++++---
> >>   tools/lib/bpf/libbpf.map |   3 ++
> >>   4 files changed, 140 insertions(+), 8 deletions(-)
> >>
> > [...]
> >

