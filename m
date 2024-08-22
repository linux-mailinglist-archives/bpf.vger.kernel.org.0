Return-Path: <bpf+bounces-37889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BC95BDBD
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588E11F24B3D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A09176AA5;
	Thu, 22 Aug 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekeVrC3m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DE15ACA;
	Thu, 22 Aug 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349129; cv=none; b=uc/5x7EJtkluZWuAppTJetMUGmQDEZuPWp9DoyR3MPumT7L+68IBejldjcc2TvPS8TNipoRdGjfWy1kn3XS6yKCIgo1JVVHbBraM7i+pvT/0/zftYhS7GNHreUhAjYcgaZOnaa0dn0IoRmnNEx5VxvIBqD+Q7bt8BzQDIajrVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349129; c=relaxed/simple;
	bh=Gj5Koluh95p+c/vgpBqDLm1Ruabq+Htz4HNcGWNDX/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el/IEiaHAkrCq86kHYb6HffzYYyuUrMDpS0DFziHMqnLMkYlIDhILnFP1PWLiqLirrvj90jZh0ZkaQJYRoTJvkGY2T0e22T5gdDUKh89/Pn1sB6XS+ht5Z2yiTJILwAsPJcf5XfO+Zk/1MWfK9a7OYRBd8TU+hHZmxQmwEPgqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekeVrC3m; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso886212a91.1;
        Thu, 22 Aug 2024 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349127; x=1724953927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSMdvcvti+RWCtYMd+FEZT5Ru/ACmw+rmYf/bGB23eI=;
        b=ekeVrC3m5Be+Du1jzMwT6gVYPJzV0QKDDuG5BdrGk9kUElmlG8Xt/cANm3uUZmBw0Q
         KqaD3CQpmh8axQ02G5pMeWeG79WKfE5I92vTSiM2bYHDoNoGHREZ0sxL+6TYK9fhi5ty
         10l8ufk22OsQBhCKz4Kk8b8zaD489lkacdKabojChgMWsrzucT2ymV50Tjx1GmW+EFX/
         rYhKA5ZGSTWYzx+Y8t0aGtdCWP+fLy9MTUujzpYRgjLEugcW1jiT4duKqKXlKTMtw19J
         RQxE5l0f4LnBK66AJ/viq4jjC1n7GmAlsskW0vQiQsUF+Co8yT5hkble5RCF0br5dBWu
         cBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349127; x=1724953927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSMdvcvti+RWCtYMd+FEZT5Ru/ACmw+rmYf/bGB23eI=;
        b=v4VoiERPiZHJPMAEbxHm6RjmshCkBLH0C++lYi2FhAJxDEKdbVtT3KYXebr7oKnilt
         06Vo1suqCpAUXzU42ehRfWtskSpU9qu2wFn2koFYfNiAfZNO1p1NeR9GFZXgEuXdY3sx
         Y2LyQCdDGWvWmqEfp919BxmN0e4JTPKmh33x8f06TcGMwETX02hMz2WfUpqGy8wzZ58N
         4NAgn2Jm+91OJ9p5Ovv+jm2k+oc5QP0AR5AdUtkV7aeV4VYEIB4RcZnYtZcz5HSsYN8L
         CXipBpoorXbYLCWi8JJ2i4D9qIh1hceTl0WFFnj82qgPUOKah+f+gjrwVULYtgGJCSBz
         TtJA==
X-Forwarded-Encrypted: i=1; AJvYcCUxjj5cog9KPU4O/huDshuk69PuAUdarQ+jB9O4HXZ4Y5a0O2kwqVBp5MCj3gI1nIivqBKt7J63NBXWqAJl@vger.kernel.org, AJvYcCVDSG8Q0yh+9IjoMcM9wC9flYrSk7QI61NJQb4kjmHxBeCCWIqXTbgEwEPmoDLozPsJf+s=@vger.kernel.org, AJvYcCW6jHb77fwnaFrFg+uWq7LwNxDLHPUTThcrRV1MCe7z4yUgvcHyiEEHc8UhRVrtR6IQzlNsC46al6DSwR0IgyNuFhbN@vger.kernel.org
X-Gm-Message-State: AOJu0YySYrkE/zRyfZIYFECBGO/kv/g2JWIew9hWHuIewz4RGWmLY3iZ
	ttJotWSaynXAvhjgteH8S1gilttLcWMrxWAqBBkVO4+xv1rOpFyxvt4rWSbpHUrBX5ANMAzfgvn
	PlTwSWRP1ghP9k/WHpButtTABuIg=
X-Google-Smtp-Source: AGHT+IFbNA+AYoJwPKkug+4J4dkzuWlv61LePE1OdqmnnD6GiBA+gHzMQMKHafS8xgKroO9gkSs966LHnR+mMgns4Bo=
X-Received: by 2002:a17:90a:9a4:b0:2c4:ee14:94a2 with SMTP id
 98e67ed59e1d1-2d5e9ec9953mr7556078a91.27.1724349127031; Thu, 22 Aug 2024
 10:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-5-andrii@kernel.org>
 <ZsdJuwIuJ-KFA6Rz@krava> <CAEf4Bzb-1na=S9+XVpEpmtDE4mJLQRywZJ6wB8JyN++2Si6Pgw@mail.gmail.com>
 <Zsd28aEHBLkRpUQs@krava>
In-Reply-To: <Zsd28aEHBLkRpUQs@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 10:51:54 -0700
Message-ID: <CAEf4Bza43g4O-OP2ZTvri2+rnUVzKcV6LCRugzt7AcFqmkSP4g@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Thu, Aug 22, 2024 at 09:59:29AM -0700, Andrii Nakryiko wrote:
> > On Thu, Aug 22, 2024 at 7:22=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Mon, Aug 12, 2024 at 09:29:08PM -0700, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > > @@ -1125,18 +1103,31 @@ void uprobe_unregister(struct uprobe *uprob=
e, struct uprobe_consumer *uc)
> > > >       int err;
> > > >
> > > >       down_write(&uprobe->register_rwsem);
> > > > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > > > -             err =3D -ENOENT;
> > > > -     } else {
> > > > -             err =3D register_for_each_vma(uprobe, NULL);
> > > > -             /* TODO : cant unregister? schedule a worker thread *=
/
> > > > -             if (unlikely(err))
> > > > -                     uprobe_warn(current, "unregister, leaking upr=
obe");
> > > > -     }
> > > > +
> > > > +     list_del_rcu(&uc->cons_node);
> > >
> > > hi,
> > > I'm using this patchset as base for my changes and stumbled on this t=
oday,
> > > I'm probably missing something, but should we keep the 'uprobe->consu=
mer_rwsem'
> > > lock around the list_del_rcu?
> > >
> >
> > Note that original code also didn't take consumer_rwsem, but rather
> > kept register_rwsem (which we still use).
>
> humm, consumer_del took consumer_rwsem, right?
>

Ah, it was inside consume_del(), sorry, my bad. I can add nested
consumer_rwsem back, but what I mentioned earlier, regiser_rwsem is
sort of interchangeable and sufficient enough for working with
consumer list, it seems. There are a bunch of places where we iterated
this list without holding consumer_rwsem lock and that doesn't break
anything.

Also, consumer_add() and consumer_del() are always called with
register_rwsem, so that consumer_rwsem isn't necessary.

We also have prepare_uprobe() holding consumer_rwsem and there is a
comment about abuse of that rwsem and suggestion to move it to
registration, I never completely understood that. But prepare_uprobe()
doesn't seem to modify consumers list at all.

And the one remaining use of consumer_rwsem is filter_chain(), which
for handler_chain() will be also called under register_rwsem, if
purely lockless traversal is not enough.

There are two other calls to filter_chain() that are not protected by
register_rwsem, so just because of those two maybe we should keep
consumer_rwsem, but so far all the stress testing never caught any
problem.


> jirka
>
> >
> > There is a bit of mix of using register_rwsem and consumer_rwsem for
> > working with consumer list. Code hints at this as being undesirable
> > and "temporary", but you know, it's not broken :)
> >
> > Anyways, my point is that we didn't change the behavior, this should
> > be fine. That _rcu() in list_del_rcu() is not about lockless
> > modification of the list, but rather modification in such a way as to
> > keep lockless RCU-protected *readers* correct. It just does some more
> > memory barrier/release operations more carefully.
> >
> > > jirka
> > >
> > >
> > > > +     err =3D register_for_each_vma(uprobe, NULL);
> > > > +
> > > >       up_write(&uprobe->register_rwsem);
> > > >
> > > > -     if (!err)
> > > > -             put_uprobe(uprobe);
> > > > +     /* TODO : cant unregister? schedule a worker thread */
> > > > +     if (unlikely(err)) {
> > > > +             uprobe_warn(current, "unregister, leaking uprobe");
> > > > +             goto out_sync;
> > > > +     }
> > > > +
> > > > +     put_uprobe(uprobe);
> > > > +

