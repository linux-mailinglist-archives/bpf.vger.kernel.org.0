Return-Path: <bpf+bounces-37070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB5950C0E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7822A1F21E1D
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59E1A38CB;
	Tue, 13 Aug 2024 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgAJ9BL3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847C224F6;
	Tue, 13 Aug 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572962; cv=none; b=c5kye12Dm12m8T1m6+aGpm65yYPgZEDZzix5K9pKE3dbFetOvxVEStkbWEbj9ngTRd7bbWdonypvpKweZkyNJA2ey7JBteHChqAQnMKXRVB3Z+vRRChY5HsRIzGNfD51XaMIxG8aR7dePkEECEdM3XHCpj3mJxZwp6ADtsjr1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572962; c=relaxed/simple;
	bh=OLHRIqSCNNHNvCWJbrZ2arwqcjsIAigXRI9Ykx/mwvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg7XzNHIA8dfj3HVSQYKUoKBfp2pAPHSOIzFfTF7T9idU4cDDaCZ2BLS4k+m5mdZwjsUJkvRz/f5cVWyXGMnJ4O4reb7JvKj26ejR5L8w7XBbR3lTL/fRIktl2th8FLVNWjQOg6I5wfqcWC9zXDksm9T9hv/dDKOU1OSEc7CD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgAJ9BL3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d1fe3754f4so2179807a91.1;
        Tue, 13 Aug 2024 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723572960; x=1724177760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAzH8LG114tu4AipYMPHdFEY5MuOGD24M4NXf9WaOks=;
        b=AgAJ9BL3VqwicpX+fhxDr+VhKZvz3kloUwb4BUAlSZSORLzbUbO2fiU9QGybyMs5On
         1mk6WogRW51VgFTekOVTT24WFzNhJDZKGHDTic0jGd3jkJ3w5ZCnLV1yv58ZrpxsSXAa
         PqUt0CRMsaYr0e98d8G4DztuRTJ4SbyG6ug2pg1oTpZ+uTl46qnWwxWRF9Q2v6903IQo
         feN4zD7dRsGLbXgxWiJpCtz6RGPu5bDo4ka0VItFGGpJTTxewXik9xWpznKmwG/blyQM
         9Q7ZC5v1iueIWim7vzKM8p2QG1sh5Kih0PpX4s96EVGWmYBngwrFn8PUI3kErt03ety2
         GpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723572960; x=1724177760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAzH8LG114tu4AipYMPHdFEY5MuOGD24M4NXf9WaOks=;
        b=NC3QTC5RS+alliWBBSvqmf+xmrDtiARmeDOBBGMYs8P5wdKTUnRaMc7IG7EI6z1NoF
         gBoGFDDyhv9li3/pBtM+HfENkwcaHUuvVinBHrJO86ZQGLhLHpdz3BA23aELp40g1RkF
         oTYS1TUPMiqoJLdN4v8N83K2xWZSd/EWriQ6BFBxtCoVoo6IcBHoROaiz4dCit/hNnAG
         54++SGb4spMOXUJI0C6Jmq6WcKZdP6DP1PGJeQ1sia977FfBGZGzmjX3nxo5ZizSKIBG
         GOlrAH1CqsPyvQEcWW+wGPvpgaYNLGDa7qlHf5diWc0IWh78iVGLtIrjbA1D9R76zbJP
         B8jA==
X-Forwarded-Encrypted: i=1; AJvYcCVZIXVDq00SuugKd/YRpqDg1KgfTD3Sc2TwWBB4LNtw5MGinUU5AqCGX++n+CeQ4GHUuVUU7wl3L7lsSNt5@vger.kernel.org, AJvYcCVrZ1KbK3JH/NdrB/NR8ncZvS0b28uPsfeA/kjgH5FH6X8ypsv+uziYXcuQ6/bx9lsI9uM6xmNtjZS31Ak2HkSsQ0HP@vger.kernel.org, AJvYcCWfsgRKxwjgROZYjjf6nGrnY5Kh+B7lqc+9IP6S+Dm3P3Y/6lN2zrUDEj2B3PxFsGa16J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHu+kopayPWsiR121rPaVnlG/nyV88rwWvfL3V9t9tzzUtKDVb
	6h088NuKcXRjhgqtrJIvEKIDLZX2bUEd6BwPc8WJhh1R37Q28VyhpjDxXK1D/zP1gAWu0FsCtyf
	g8IintAt4LJ3A0PXpcMWGrt27bqQ=
X-Google-Smtp-Source: AGHT+IHmmIelDCrSXZO6Sr0mSmHsjSmEfcI8hr8mtmZqQMMfFDqXzwl7MXs0x3tSNM6LlixYQ72EMoidQyJzWt16YLs=
X-Received: by 2002:a17:90a:cf0e:b0:2c9:73ff:6a0c with SMTP id
 98e67ed59e1d1-2d3aaabb985mr378925a91.20.1723572959615; Tue, 13 Aug 2024
 11:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-13-andrii@kernel.org>
 <jdsuyu4ny4bzpzncyhuc54vqmnxb6wsshvnvd6eat4cknoxvqd@g4mrvwiokb2d> <CAJuCfpFrP-UpMih2j=Nxx=QSQm2k3QtJScLKniM9aXjbo5jCDw@mail.gmail.com>
In-Reply-To: <CAJuCfpFrP-UpMih2j=Nxx=QSQm2k3QtJScLKniM9aXjbo5jCDw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Aug 2024 11:15:47 -0700
Message-ID: <CAEf4BzaapUJVEwGxcmE7BBUZj2C9rrh5J3nQ8TV978mntZKu1g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 12/13] mm: add SLAB_TYPESAFE_BY_RCU to files_cache
To: Suren Baghdasaryan <surenb@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:49=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Aug 12, 2024 at 11:07=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> >
> > On Mon, Aug 12, 2024 at 09:29:16PM -0700, Andrii Nakryiko wrote:
> > > Add RCU protection for file struct's backing memory by adding
> > > SLAB_TYPESAFE_BY_RCU flag to files_cachep. This will allow to lockles=
sly
> > > access struct file's fields under RCU lock protection without having =
to
> > > take much more expensive and contended locks.
> > >
> > > This is going to be used for lockless uprobe look up in the next patc=
h.
> > >
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/fork.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 76ebafb956a6..91ecc32a491c 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -3157,8 +3157,8 @@ void __init proc_caches_init(void)
> > >                       NULL);
> > >       files_cachep =3D kmem_cache_create("files_cache",
> > >                       sizeof(struct files_struct), 0,
> > > -                     SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> > > -                     NULL);
> > > +                     SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_=
RCU|
> > > +                     SLAB_ACCOUNT, NULL);
> > >       fs_cachep =3D kmem_cache_create("fs_cache",
> > >                       sizeof(struct fs_struct), 0,
> > >                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
> >
> > Did you mean to add it to the cache backing 'struct file' allocations?

Yep, thanks for catching this!

> >
> > That cache is created in fs/file_table.c and already has the flag:
> >         filp_cachep =3D kmem_cache_create("filp", sizeof(struct file), =
0,
> >                                 SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALI=
GN |
> >                                 SLAB_PANIC | SLAB_ACCOUNT, NULL);
>
> Oh, I completely missed the SLAB_TYPESAFE_BY_RCU for this cache, and
> here I was telling Andrii that it's RCU unsafe to access
> vma->vm_file... Mea culpa.
>

Well, my bad for not double-checking and going just by the name.
filp_cachep vs files_cachep is easy to mix up.

> >
> > The cache you are modifying in this patch contains the fd array et al
> > and is of no consequence to "uprobes: add speculative lockless VMA to
> > inode resolution".
> >
> > iow this patch needs to be dropped
>
> I believe you are correct.
>

I'm happy that we already have SLAB_TYPESAFE_BY_RCU on filp_cachep,
I'll just drop this patch.

