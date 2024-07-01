Return-Path: <bpf+bounces-33524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E691E6FF
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 19:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6861C21A52
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69CD16EB72;
	Mon,  1 Jul 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECvwmUWL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31716D4F0;
	Mon,  1 Jul 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856538; cv=none; b=hW8uVOp/WLBUh4f0QTbdBQ89df9eBZWGvgG/geCaq5stK/lc2WbH460+1gdk5yPcPU+hPG2XMrFpn+uAHCKa7T4OFVsEjJgfAszBUT8WQuyxWVKvLhRICkpj14ZtyjTPoHn+rLOIyFkMR2BK6QrjSEDdC1fjktRTY3jA1/viAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856538; c=relaxed/simple;
	bh=H9zQHTToPy683u6wy+JXXZbw437JqeagRl3yCPuGLHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQuJNB1FWaU/8STy1hukyRsB8fE4qIH2t3jZv7zrIuCYVODtp4Rp5HYgvx4Qe0PyHhr3aOiUo1kua2JtKmaVXx+BLej7tWtK0Z1T8g0jFf8fUBHO6Hkl/2jKsTQ2ziac91ShFTWaO21d+9YEdP8LNQJs4Mm2Z45hdoEtNT+b3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECvwmUWL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7067a2e9607so2667628b3a.3;
        Mon, 01 Jul 2024 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719856536; x=1720461336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8sEXp5ETA5eWTDjhAviBRNAnZt7AgSAUC2plW88wnc=;
        b=ECvwmUWLmm43yBqFBSS/gkSUtTozpdEoskIVsuEUXQfyfKsVJ1LMI1sEdc339k5DSG
         8Mrp+Z1t8f25FSY0lrG0KgSanfVRK4XpV2m14MUwbd1Wa7jA/InYE4U0TAZ9q47Dq2Zr
         Qjc6q82PZ0qNQGOhQ9lqTZFuKTyHFuNCvGDp128IXejDhyjJhARM67eJncJks3OMlcED
         xnwoBrDLQSFrDt+oeOEkcR5kRf4D4bM6ex48fTY07BhO55qZ1yfooP0hJsSH0uBCkie9
         89dzKpgLtM1ZDVZhGnwx6pkI06IHa0HKFbrhrBhkA5KwSk62Y3jszK+KwKWJspjYAjY7
         0RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719856536; x=1720461336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8sEXp5ETA5eWTDjhAviBRNAnZt7AgSAUC2plW88wnc=;
        b=f8/v2rPDVZfKo2FEL/EtqQ599hyxp+UvTCfPse4AZKe3lYpxtNwPfdpYexG/B0cNUN
         rPH/UvG8LZiyQlmUciTQ5Me/pgNRrV+xnlwemyUC0cT9OfBJG+e2vRuWElbjgTHSrDTt
         a9LZ9P+G9oHrxPpJK+CPsq440iCkbSJyJ97855BoNRFBLaV28YGW+mXL1eOZDM6ZDeBJ
         3FWR6ZveZRoeJrggyeod3kzXexE+bdUSe1OksrA4d3RoTCURjMZlx9zqXKR5xQPWaF/3
         M7AurCJ6XFx3DqMWfBqII37uH7J+ik7v2nP3xxdsYN0Exss9/qzy5pU6Q77kSCYXkIFP
         SjMw==
X-Forwarded-Encrypted: i=1; AJvYcCWr/isHykmHZDwbhlPRYBrNIbbLwXspg8Ujh9f4CtoHR2kqUWUmqWNUdg8FBsPMgEr3CVBl7qGcCdIzk0ocrdcvUpcyPkD/rlM6fgKdDfA9adfeHzYsguUwsr6bgh+urrQ6+RFpc687
X-Gm-Message-State: AOJu0YwBgo2kt+20PbmfGyXp5Cwl9fCiuXgfYbmKuHUX53EORLeHlOW2
	o4h7U2ApaUcbX4xDmmj3KwHoZVXC8G/gQEX5IrHrlmX2Gmrcyv5JwNuU6aw9LtgMkVVZUm2/f8h
	HyuBrH1uQmTSHACYhYosUBrEo1C4=
X-Google-Smtp-Source: AGHT+IEIMn1evVZt0EVal2TrVU/wKvy/Vh5e+/ePQD0xkfyMWD40LZr6vL+QTD3qJ6GaDq7QHb9zbQDnMA42eQNlZ/8=
X-Received: by 2002:a05:6a00:1ca8:b0:704:1ed3:5a19 with SMTP id
 d2e1a72fcca58-70aaaf203femr7922962b3a.32.1719856535950; Mon, 01 Jul 2024
 10:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-7-andrii@kernel.org>
 <20240627220449.0d2a12e24731e4764540f8aa@kernel.org> <CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
 <20240628152846.ddf192c426fc6ce155044da0@kernel.org> <CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
 <20240630083010.99ff77488ec62b38bcfeaa29@kernel.org>
In-Reply-To: <20240630083010.99ff77488ec62b38bcfeaa29@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 10:55:24 -0700
Message-ID: <CAEf4BzZh4ShURvqk-QxC5h1NpN0tjWMr1db+__gsCmr-suUNOQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 4:30=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 28 Jun 2024 09:34:26 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Thu, Jun 27, 2024 at 11:28=E2=80=AFPM Masami Hiramatsu <mhiramat@ker=
nel.org> wrote:
> > >
> > > On Thu, 27 Jun 2024 09:47:10 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > On Thu, Jun 27, 2024 at 6:04=E2=80=AFAM Masami Hiramatsu <mhiramat@=
kernel.org> wrote:
> > > > >
> > > > > On Mon, 24 Jun 2024 17:21:38 -0700
> > > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > >
> > > > > > -static int __uprobe_register(struct inode *inode, loff_t offse=
t,
> > > > > > -                          loff_t ref_ctr_offset, struct uprobe=
_consumer *uc)
> > > > > > +int uprobe_register_batch(struct inode *inode, int cnt,
> > > > > > +                       uprobe_consumer_fn get_uprobe_consumer,=
 void *ctx)
> > > > >
> > > > > Is this interface just for avoiding memory allocation? Can't we j=
ust
> > > > > allocate a temporary array of *uprobe_consumer instead?
> > > >
> > > > Yes, exactly, to avoid the need for allocating another array that
> > > > would just contain pointers to uprobe_consumer. Consumers would nev=
er
> > > > just have an array of `struct uprobe_consumer *`, because
> > > > uprobe_consumer struct is embedded in some other struct, so the arr=
ay
> > > > interface isn't the most convenient.
> > >
> > > OK, I understand it.
> > >
> > > >
> > > > If you feel strongly, I can do an array, but this necessitates
> > > > allocating an extra array *and keeping it* for the entire duration =
of
> > > > BPF multi-uprobe link (attachment) existence, so it feels like a
> > > > waste. This is because we don't want to do anything that can fail i=
n
> > > > the detachment logic (so no temporary array allocation there).
> > >
> > > No need to change it, that sounds reasonable.
> > >
> >
> > Great, thanks.
> >
> > > >
> > > > Anyways, let me know how you feel about keeping this callback.
> > >
> > > IMHO, maybe the interface function is better to change to
> > > `uprobe_consumer *next_uprobe_consumer(void **data)`. If caller
> > > side uses a linked list of structure, index access will need to
> > > follow the list every time.
> >
> > This would be problematic. Note how we call get_uprobe_consumer(i,
> > ctx) with i going from 0 to N in multiple independent loops. So if we
> > are only allowed to ask for the next consumer, then
> > uprobe_register_batch and uprobe_unregister_batch would need to build
> > its own internal index and remember ith instance. Which again means
> > more allocations and possibly failing uprobe_unregister_batch(), which
> > isn't great.
>
> No, I think we can use a cursor variable as;
>
> int uprobe_register_batch(struct inode *inode,
>                  uprobe_consumer_fn get_uprobe_consumer, void *ctx)
> {
>         void *cur =3D ctx;
>
>         while ((uc =3D get_uprobe_consumer(&cur)) !=3D NULL) {
>                 ...
>         }
>
>         cur =3D ctx;
>         while ((uc =3D get_uprobe_consumer(&cur)) !=3D NULL) {
>                 ...
>         }
> }
>
> This can also remove the cnt.

Ok, if you prefer this I'll switch. It's a bit more cumbersome to use
for callers, but we have one right now, and might have another one, so
not a big deal.

>
> Thank you,
>
> >
> > For now this API works well, I propose to keep it as is. For linked
> > list case consumers would need to allocate one extra array or pay the
> > price of O(N) search (which might be ok, depending on how many uprobes
> > are being attached). But we don't have such consumers right now,
> > thankfully.
> >
> > >
> > > Thank you,
> > >
> > >
> > > >
> > > > >
> > > > > Thank you,
> > > > >
> > > > > --
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

