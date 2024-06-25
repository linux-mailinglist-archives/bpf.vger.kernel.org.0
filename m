Return-Path: <bpf+bounces-33078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34E916F48
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DD1C230AC
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA9176248;
	Tue, 25 Jun 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbgy5K6g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11F145320;
	Tue, 25 Jun 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336674; cv=none; b=hZweenxdgFtWmqsS+viokod21V29F3Twc1C7IIzkZ6qZe+Oez3mQwmEiu1EGJH90rEgWrEh3ecEyKBP+NNPSmGuoDkyRDkFHZjnfXGc8FgyfFGwvXjJdvRXzm/xDlLvWUEUzoMqg67U+zpb2BYeDVNJ97MO4Y9vPL8sOyczL814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336674; c=relaxed/simple;
	bh=g9QS/ehG4Xk/Y8AH65W2lg0e/h61wJgf+NH/CzdVGys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppXVA2FpPHv5QHJIAGGh9CvMoXPrZvqxHXnwNIduSy6B4zQph30LsCYhc7KRqCHjgpDI57c0lX9xkEScpRCQMwlQPGwxGB0rENBsPYvcXoLop3lu7PltAyVrjkIjhJ33jTRsgxyuciW8bFkrwvG/NvjCqXpH13eQ6tLhkERwk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbgy5K6g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa3bdd91c1so20019535ad.2;
        Tue, 25 Jun 2024 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336672; x=1719941472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPnk4Pf4uBWBcDb7dcN6WpRMINwXFv4I3KD89X3EyRg=;
        b=nbgy5K6gbil1/MELqzgkOftQDysakhmH8RFbu+4pUHj6hLJJBOgampEExVZvYb/adq
         FmogGIndS6wlzgZX8J4Uvd24BnYBftPoKkDk3Uf4oExWl3TF2sh2x3BIgaUAEg5dzEdl
         tyDYH/iF947ros7cutKdar63X4foURLdbUrAh8ifwouu9M/0niVdUKsGYQ2Pr6nr9cRh
         th9uKE5C5fVBu516fTijlfSAKZvynpQbETwYNid+ctVmsf2ZP12kqbD81+twLaBNS9k9
         FibJspWk66iqG5UFrH/7Pk4UvgGElCmI0ermofgRrUH7EGn9yHx8Zp9Cyy46ZbvO1aho
         TLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336672; x=1719941472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPnk4Pf4uBWBcDb7dcN6WpRMINwXFv4I3KD89X3EyRg=;
        b=YJ2C0NNuPbcbm9xIsE0qu1zBLd9f45XqlC+s+UVt09Lixv03qBc/WTuCXi8XBQYY3y
         86ZmLZWZwHoHdmMt/M/BePqR+5DIeV1NycAXUZmHvhxoo0L8EsQ0u/2nF4MyFPsJpsc0
         DHsuK/5775GlVx18DzhajmyoB1OFacAxREmuvs9Y4i2/mDRC+H4tQMApIVi9GNDYADwh
         vGXU0tq0ftOFpMKTEtqhmxDWwSRRIjOnijGxBLuP6weNvVY+XQusWwLvf74nfqWTKfWU
         5t1moYqVMlQsai9v38V6PdKb+4Ozo1/+I/frivDuGnxBcgsJeJ0M7LtS/9F4i6Cy0eTn
         88aw==
X-Forwarded-Encrypted: i=1; AJvYcCVmPtewXhGWWA1E0bFs0co/1ptPdyiF8WpSwnk9lc7jhnhc5j1rMA54PH9psjsTFzD+FNWuF676ywnu1fDGFLs6706qiPZiNAhHPxCeIdj5MGLNh8Ocz+UCTETtSm1tFqoIUIcZHfAt
X-Gm-Message-State: AOJu0YwH9MImR24meWcYVvelK4oxEoaE3DL9z72Asvdmjg6zP93eq3V3
	WxrG9O6tmY9RbcCWuVRryMlF1PtvQtVhLTceK6DKb0uLn8DFhdS6kLXpkG/HTEMsZm7ixBFhQBB
	rGWtgdiRKehNq3x4aKome/feLSns=
X-Google-Smtp-Source: AGHT+IHqN2pNIw2sB0v0KWHt2GnrRoyPD5OMoNaBKgLlYYVMv2yfXdQlfZFUSpcD5yNeWQFcIBrYUfbPqlwnJQvou0M=
X-Received: by 2002:a17:90b:180b:b0:2c8:716f:b47f with SMTP id
 98e67ed59e1d1-2c8716fbb29mr7038896a91.14.1719336671987; Tue, 25 Jun 2024
 10:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-5-andrii@kernel.org>
 <20240625144409.GA21366@redhat.com>
In-Reply-To: <20240625144409.GA21366@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Jun 2024 10:30:59 -0700
Message-ID: <CAEf4Bzbi9G_sJXZLdsX=qe8pNVrAp6mgByv9fPbwwyzy9x-jhw@mail.gmail.com>
Subject: Re: [PATCH 04/12] uprobes: revamp uprobe refcounting and lifetime management
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 7:45=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Again, I'll try to read (at least this) patch later this week,
> just one cosmetic nit for now...

Thanks, and yep, please take your time. I understand that this is not
a trivial change to a code base that has been sitting untouched for
many years now. But I'd really appreciate if you can give it a through
review anyways!

>
> On 06/24, Andrii Nakryiko wrote:
> >
> > + * UPROBE_REFCNT_GET constant is chosen such that it will *increment b=
oth*
> > + * epoch and refcnt parts atomically with one atomic_add().
> > + * UPROBE_REFCNT_PUT is chosen such that it will *decrement* refcnt pa=
rt and
> > + * *increment* epoch part.
> > + */
> > +#define UPROBE_REFCNT_GET ((1LL << 32) | 1LL)
> > +#define UPROBE_REFCNT_PUT (0xffffffffLL)
>
> How about
>
>         #define UPROBE_REFCNT_GET ((1ULL << 32) + 1ULL)
>         #define UPROBE_REFCNT_PUT ((1ULL << 32) - 1ULL)

It's cute, I'll change to that. But I'll probably also add a comment
with the final value in hex for someone like me (because I can reason
about 0xffffffff and its effect on refcount, not so much with `(1LL <<
32) - 1`.

>
> ? this makes them symmetrical and makes it clear why
> atomic64_add(UPROBE_REFCNT_PUT) works as described in the comment.
>
> Feel free to ignore if you don't like it.
>
> Oleg.
>

