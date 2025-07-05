Return-Path: <bpf+bounces-62463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9658AF9E4E
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 06:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380904A6582
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 04:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD0253359;
	Sat,  5 Jul 2025 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7JDE41k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A17081E;
	Sat,  5 Jul 2025 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751690728; cv=none; b=YN2IkMKpUvP3EU9KzjxsJIkB0x94iKLSphR5A8Pvky8sb27Ej0/g0xnhswSS6oV+gpCS7tnLRpI7ZtDaw9r/aNtkmpg8dTCHacg49eeD7w+ungiqcUIr7R52+uFs4Jz/Lrd0DP2+xtG3M6AGqv+ntz/++5GTlxHrmV0yaMFRmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751690728; c=relaxed/simple;
	bh=+LgmxPJug/ZMfRJJAXY9BTE5ceOlfIcG0V2Desxf2lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q66JlJ18H1zCQDKMojIgmYCWCLXxz6hbtXB2tOFPsbA0i3qDD/8igecmIHvtjHDqNse8TdRw2r9vMe5nGgyFoseztPCKhZxfZdPXc/eqRDYGMxtndkmys/LJ8k2K6Nz9bynR2TbjYdH7sHKSQFSfb/2Upn9TDdnLTfrElxzDr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7JDE41k; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso271906866b.0;
        Fri, 04 Jul 2025 21:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751690725; x=1752295525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjj/jZLsZSifoS0zOauLkis0FW9X6ZiGBGlGlt7CtiA=;
        b=V7JDE41kYJR++dxYJDgAfQJBeKGZuQTS2nhT0ADrv/vJPJt3hUItPGktHWGdpaX0cO
         AfPrS6DIn5H22kEgc9htQLeI8yrHeKK+UmHdM2PrOPDpR5KOcBPlPA+b6s7Qe5u0l527
         QvjIQHI42ygpDZwOANKrVJ1qrLnV8bEzcDDpmaTCqtcMMUv0KTfoWadBmReRlqcOqqkc
         8Uf/m+85MZOAF2DS+TKw+jIOczXJQWZ+TMVdekaJ/HiLwdtYRGl1ACkWuc7TWtYBZcDQ
         8qEBiGQsIWxZNmhv0mvTP08G22EuXPGuVaghW+TITt/12BrLDrnwWdQmdz0Sv5XzRbGX
         bHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751690725; x=1752295525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjj/jZLsZSifoS0zOauLkis0FW9X6ZiGBGlGlt7CtiA=;
        b=ExYae0P79H9uPaX8HpxhZDyRIHgn+ELPn3AbgvHKbVojnKAKIJyearmdlU8vB8hZob
         YOxPqIxh9f6DIipy5hTmjjSms5eNwKu30PLt43GXVl0rCNcovFsyt5l5Znas8/kTTYb8
         v3gZ6TEU6hsZR1EWi+gPml/nZMxb4Fk1q3LzqSo7JPr0iSCZbNvpZvzspLWjB89BtMXf
         29mMNbXXRFUkovdzsjX2C0nj7aQUWxJ+uN4bHY1gY+pt9YhU9hzsYanbmESeu5kSZSLC
         kwkDHTqDYzweZLfQNuS6WPdcBqCjSATnv39DOm6VdBLY/zqH4WSkj+0hjr6/8sDqb2sL
         bDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5pfVTfwpDu2sgAOgqvrtx2DYWgxJmIvs1sZAXn5s7N03/R0PQ7fcdBgjHgXIE+Fe4Pr8=@vger.kernel.org, AJvYcCWQJNlgtZc5QX6gm7LJQ8Tq+Jy6hPzWEhPbnAOTFwKKC9LSWzJywEuE/ZxCcJgtLbVpsHTDLryA6/Gx82Kw@vger.kernel.org, AJvYcCWxQmZvJ9omLgCSbO5pccZRIHoV8HmgRCxMs9u4ziSYI0yqMEGAhqvlvAuXWfglJrAvjiQKdPaOJeDXvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOP6zrr6GB4dWEmtO52bmlH/98cGIxEAFObsOkrqdGVdEL0s26
	SiRg32ahjR8r7odhQZ3uDZUGHLrYwLU6ZBauhv5qti0UJ7YP+fJAP8ce/uVZwJUEEy9rIuvtLHI
	W6tciysSDEIqO/uR1dcaOegysbVJQFMOtEQ5M
X-Gm-Gg: ASbGncurrFjW/O7b5EgIWR15pPRAh+El8q5Yby6XpAp1f/+U/1fesi3m3VNwkVZFFRy
	xdiZ54wcX31/GY1SKZcrPnhUJT8UqAwy9ytya4EfJgPB8HQGS4W3cqVzGiF6UKjnvfpzuw7PGr1
	IBhiIyIEtBtZLl7wkbJrK6lY0kC4YExFR2Wr6fhgju/OxwC/T4Ht8IodvASTCIibMIOF2CMvLxH
	74S0gbMFbtKCw==
X-Google-Smtp-Source: AGHT+IFN5Yu9VsTs6d7pFgGL7TlWc3IIq2eYqoLfmhZT7CqjvIRMjJZzHXkbe3phOjme4fS53VyK7gupKShE5l9v854=
X-Received: by 2002:a17:907:d2e3:b0:ae0:b8c5:6142 with SMTP id
 a640c23a62f3a-ae3f8060d15mr542496366b.7.1751690724154; Fri, 04 Jul 2025
 21:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704205116.551577e4@canb.auug.org.au> <5496b723-440f-451b-b101-f0c7c971fc9b@infradead.org>
 <f06082bf-27b5-488d-b484-fecc100014a1@infradead.org>
In-Reply-To: <f06082bf-27b5-488d-b484-fecc100014a1@infradead.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 5 Jul 2025 06:44:46 +0200
X-Gm-Features: Ac12FXxXOgDJGS0ERRDM-CJnacaVoNRzr1APIsFwQr6NDAvYV7zBbMaEc2uBTjs
Message-ID: <CAP01T77AWoBqDgOPpmmcL5tQFqNa8W3rxBDB+Er0J5rxogCrVA@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 4 (kernel/bpf/stream.c)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Jul 2025 at 01:38, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 7/4/25 4:35 PM, Randy Dunlap wrote:
> >
> >
> > On 7/4/25 3:51 AM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20250703:
> >>
> >
> > on i386:
> >
> > kernel/bpf/stream.c: In function 'dump_stack_cb':
> > kernel/bpf/stream.c:501:53: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   501 |                                                     (void *)ip, line, file, num);
> >       |                                                     ^
> > ../kernel/bpf/stream.c:505:64: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   505 |         ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
> >       |
> >
> >
>
> Also reported (earlier) here:
>
>   https://lore.kernel.org/linux-next/CACo-S-16Ry4Gn33k4zygRKwjE116h1t--DSqJpQfodeVb0ssGA@mail.gmail.com/T/#u
>

Thanks, I will share a fix soon. Could the bot also Cc the author of
the commit using git blame?

>
> --
> ~Randy
>

