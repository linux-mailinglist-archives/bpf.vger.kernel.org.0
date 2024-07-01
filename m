Return-Path: <bpf+bounces-33539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728591EABC
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2478B21867
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 22:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938585947;
	Mon,  1 Jul 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8ZFvvJd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775F17BBB;
	Mon,  1 Jul 2024 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872170; cv=none; b=d7vWtwm72l4Rh+G2SeFgxMMqivuFTf6AwDCDfodA6X+ktYMLtiYvtIvSuYQ4B6PbdiohMCTt8Q4YRprHZrnoJdAeablaS2a0XlTKc40NaLLW+UnxxscDhi3EdwFUfXIfbT12vc/wugvdGlGHtx8QzbYAgpUZSDSEP4/wVkJLt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872170; c=relaxed/simple;
	bh=PkYevu+meDcrJ4K9ZYQEViE4HnY6jmPQJ2Ah8pPTDSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UswgjUjEv5vO6IxBkmSbBHXGiH/b4+UCB7jHJEW8ozDFYKcoNg35Bejv4UPGf+Cp3/HOS/5CHgKi0CO5EBhzKMRsN0c1a9nuzqq035xoA/BczDfwrDK/ztJzviQyFxKshEJulboWvuzbVKBOKnIZdEx/8Z1NmJjNszYaQ22VzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8ZFvvJd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so2033630a91.2;
        Mon, 01 Jul 2024 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719872168; x=1720476968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP3TGZz5ID0PDfMrLLlXy5RNYFoGLYxV7gOLZK6weKE=;
        b=G8ZFvvJd+ElEzZ+lQ8Mz/jvEgFxJOHoQ/aMfLhWARBUmF9PHY1CUJrJeVrvZycrW84
         Z+T2nwOV44i4s12pR+7nr5aRkQGYXu+d2WEn1Bfz9XSUjAwoqfrI5JqY7MV868BQ6lT2
         /7IPuhcFLIsVIqJ/OaO+TAPjxzhSVBD2T8iok+yga/1v3MUteG+mjbc8357U3vLJSYfE
         nWJdTIqMm4lwqAsjcPgYVqnvjzXOUf7dOwKFxQmBwz0Mogci3vsY9GmC1EkIrLIPZxeZ
         D28MUzDdNadQtL1zm7K1lCf33GolWJ/yW+lFznbRgEp5+sa5lAv2TjWxf7KEsbAFu984
         U1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719872168; x=1720476968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP3TGZz5ID0PDfMrLLlXy5RNYFoGLYxV7gOLZK6weKE=;
        b=UZkPXCiyZtnobXSnK3FOu8RbB1vjTj6qgGRC1asFiMfzH4XjwI4h03i4Zy0RePxwnI
         l4TTT+ApEX52F+nA1hwP6zue7nkXXPSui1EvM5gw2UVZ/3Huk/NrhVVF/9x0jDg2F9Vv
         rtC/x6LZpk/cH4sOr8GwvIbsPHFuRgMZzkDcUoGp5BtbXQ0eleVhA1rI1nUGNZSSjJiy
         ZVPUcWb+sL6/khoTg0t7H3qBv9jmcslolNDma2d5xKCdkGOXeleLnwHReFEDuC/82CAP
         5I2UvB5kkqevqNrV0DByOH0il04Cn31sNLJqY0jSU2PESUMKJWbRqIyLEgJA2jA/SzsZ
         vhVw==
X-Forwarded-Encrypted: i=1; AJvYcCVVZ+VJPwdCkbXlJxIT8d2yRdXeWrAep4lIHDGaWMYMcWiYI7S247VCkzhvVKQH7w13huRDycIHKVqYdSaQHQpHVFAC8YvplzITR2hee29Btna13yW8Ew2jglDMNCtEm5q9vAASFsfa
X-Gm-Message-State: AOJu0YwwpdbeeeemSsZVUHq8T1KCQNdfTzRe2OkVeC0UwB9kD+6vFpNs
	jJ+xjhwW2a3Bg87GjvTQBkdQeH1/2BrrBfeZcNo7HGAcbkb6AiRX98DhK3xMw6lSH5SzPIZr/ZF
	JCVtCfcXO2aEH+qJwAJCGJudP4kPtVQ==
X-Google-Smtp-Source: AGHT+IERQm/9BqHDzD5JwOCIsHSSgR1HGZeUwN66JbbPoJFryJSQPnVHPfAZq05Ijra+Tdgk0Es9EOlLxFKdUlrueDo=
X-Received: by 2002:a17:90a:e386:b0:2c4:c2d3:c061 with SMTP id
 98e67ed59e1d1-2c93d6ecb38mr4004217a91.18.1719872168208; Mon, 01 Jul 2024
 15:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625002144.3485799-1-andrii@kernel.org> <20240625002144.3485799-7-andrii@kernel.org>
 <20240627220449.0d2a12e24731e4764540f8aa@kernel.org> <CAEf4BzbLNHYsUfPi3+M_WUVSaZ9Ey-r3BxqV0Zz6pPqpMCjqpg@mail.gmail.com>
 <20240628152846.ddf192c426fc6ce155044da0@kernel.org> <CAEf4Bzbr-yFv6wPJ8P=GBth7jLLj58Y7D5NwcDbX4V8nAs1QmA@mail.gmail.com>
 <20240630083010.99ff77488ec62b38bcfeaa29@kernel.org> <CAEf4BzZh4ShURvqk-QxC5h1NpN0tjWMr1db+__gsCmr-suUNOQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZh4ShURvqk-QxC5h1NpN0tjWMr1db+__gsCmr-suUNOQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 15:15:56 -0700
Message-ID: <CAEf4BzbRQjK7nnR2nnw_hgYztPPxaSC6_qFTrdADy3yCki_wEA@mail.gmail.com>
Subject: Re: [PATCH 06/12] uprobes: add batch uprobe register/unregister APIs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 10:55=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Jun 29, 2024 at 4:30=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel=
.org> wrote:
> >
> > On Fri, 28 Jun 2024 09:34:26 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > On Thu, Jun 27, 2024 at 11:28=E2=80=AFPM Masami Hiramatsu <mhiramat@k=
ernel.org> wrote:
> > > >
> > > > On Thu, 27 Jun 2024 09:47:10 -0700
> > > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > > On Thu, Jun 27, 2024 at 6:04=E2=80=AFAM Masami Hiramatsu <mhirama=
t@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, 24 Jun 2024 17:21:38 -0700
> > > > > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > >
> > > > > > > -static int __uprobe_register(struct inode *inode, loff_t off=
set,
> > > > > > > -                          loff_t ref_ctr_offset, struct upro=
be_consumer *uc)
> > > > > > > +int uprobe_register_batch(struct inode *inode, int cnt,
> > > > > > > +                       uprobe_consumer_fn get_uprobe_consume=
r, void *ctx)
> > > > > >
> > > > > > Is this interface just for avoiding memory allocation? Can't we=
 just
> > > > > > allocate a temporary array of *uprobe_consumer instead?
> > > > >
> > > > > Yes, exactly, to avoid the need for allocating another array that
> > > > > would just contain pointers to uprobe_consumer. Consumers would n=
ever
> > > > > just have an array of `struct uprobe_consumer *`, because
> > > > > uprobe_consumer struct is embedded in some other struct, so the a=
rray
> > > > > interface isn't the most convenient.
> > > >
> > > > OK, I understand it.
> > > >
> > > > >
> > > > > If you feel strongly, I can do an array, but this necessitates
> > > > > allocating an extra array *and keeping it* for the entire duratio=
n of
> > > > > BPF multi-uprobe link (attachment) existence, so it feels like a
> > > > > waste. This is because we don't want to do anything that can fail=
 in
> > > > > the detachment logic (so no temporary array allocation there).
> > > >
> > > > No need to change it, that sounds reasonable.
> > > >
> > >
> > > Great, thanks.
> > >
> > > > >
> > > > > Anyways, let me know how you feel about keeping this callback.
> > > >
> > > > IMHO, maybe the interface function is better to change to
> > > > `uprobe_consumer *next_uprobe_consumer(void **data)`. If caller
> > > > side uses a linked list of structure, index access will need to
> > > > follow the list every time.
> > >
> > > This would be problematic. Note how we call get_uprobe_consumer(i,
> > > ctx) with i going from 0 to N in multiple independent loops. So if we
> > > are only allowed to ask for the next consumer, then
> > > uprobe_register_batch and uprobe_unregister_batch would need to build
> > > its own internal index and remember ith instance. Which again means
> > > more allocations and possibly failing uprobe_unregister_batch(), whic=
h
> > > isn't great.
> >
> > No, I think we can use a cursor variable as;
> >
> > int uprobe_register_batch(struct inode *inode,
> >                  uprobe_consumer_fn get_uprobe_consumer, void *ctx)
> > {
> >         void *cur =3D ctx;
> >
> >         while ((uc =3D get_uprobe_consumer(&cur)) !=3D NULL) {
> >                 ...
> >         }
> >
> >         cur =3D ctx;
> >         while ((uc =3D get_uprobe_consumer(&cur)) !=3D NULL) {
> >                 ...
> >         }
> > }
> >
> > This can also remove the cnt.
>
> Ok, if you prefer this I'll switch. It's a bit more cumbersome to use
> for callers, but we have one right now, and might have another one, so
> not a big deal.
>

Actually, now that I started implementing this, I really-really don't
like it. In the example above you assume by storing and reusing
original ctx value you will reset iteration to the very beginning.
This is not how it works in practice though. Ctx is most probably a
pointer to some struct somewhere with iteration state (e.g., array of
all uprobes + current index), and so get_uprobe_consumer() doesn't
update `void *ctx` itself, it updates the state of that struct.

And so there is no easy and clean way to reset this iterator without
adding another callback or something. At which point it becomes quite
cumbersome and convoluted.

How about this? I'll keep the existing get_uprobe_consumer(idx, ctx)
contract, which works for the only user right now, BPF multi-uprobes.
When it's time to add another consumer that works with a linked list,
we can add another more complicated contract that would do
iterator-style callbacks. This would be used by linked list users, and
we can transparently implement existing uprobe_register_batch()
contract on top of if by implementing a trivial iterator wrapper on
top of get_uprobe_consumer(idx, ctx) approach.

Let's not add unnecessary complications right now given we have a
clear path forward to add it later, if necessary, without breaking
anything. I'll send v2 without changes to get_uprobe_consumer() for
now, hopefully my above plan makes sense to you. Thanks!

> >
> > Thank you,
> >
> > >
> > > For now this API works well, I propose to keep it as is. For linked
> > > list case consumers would need to allocate one extra array or pay the
> > > price of O(N) search (which might be ok, depending on how many uprobe=
s
> > > are being attached). But we don't have such consumers right now,
> > > thankfully.
> > >
> > > >
> > > > Thank you,
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > Thank you,
> > > > > >
> > > > > > --
> > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

