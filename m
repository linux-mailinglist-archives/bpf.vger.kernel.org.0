Return-Path: <bpf+bounces-40001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5C97A306
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4DA1C2223A
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 13:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC2C15624D;
	Mon, 16 Sep 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqL6fg5f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDE153BC1
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494074; cv=none; b=CpXzBbLbWw8iI6oGSpohdjoF2Pfq3Lha8ucBzmzQ7BeySgazWYPTR0nrs1m6qqbr65Dw/gCPtl7aDf2H2QncaWPXgsUd4agW0RSN4C1gfRa/SoZK422Q8L/jMlYvxDnDnjFqLOIIeBHcMiACMI0FUrKUDd5DYd/CAsy7NtzDzH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494074; c=relaxed/simple;
	bh=7zffz6f9+9dTXuU7HF30nwxvwdmDiNFzFtwvqDSpArI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgo7KW8Jk3U8FSoW8+wKdrxGrKrVuxlMjr2e1qv4XW09Or68eO2l99Y2gMdlDEVP2dr3mV/tJSgYuHm6kaVflWDiAc31TmTVqN0nztKwJeCthP5AAyBSBjcDxwvz9Cx0ubjFdR72CMfZsqilI19JyZeyj/hoDB/iBjNkmT/X4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqL6fg5f; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f75c205e4aso47386841fa.0
        for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726494071; x=1727098871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7zffz6f9+9dTXuU7HF30nwxvwdmDiNFzFtwvqDSpArI=;
        b=vqL6fg5fX9xskL+ICEsoxzww5oooOp3/j95Wm5OUZq2Uyb1Hm9hL6UBeTnnnuFT/FK
         5zArrpiMG+lY2SgpvyNi/hskZKiUZD4VdbG2HR+uhOe9q1/nJNV6t0yHZHpUpuJOcpuX
         17XF8OjvHG/EmDozbcM64DLR28Fy37ixdyZc3qtHTiwlrmZXNnrS/+AwnTp4ohO864nu
         rT+lLhu7Iok/0ypm90KkS6w7cv89DA3+EjR1VvP9ALKZrYMhy+2BKCZSRjMlCf1STtp4
         IWjQ/zYuX8PNgU8SEdZXgNAHDGuUnkaCiLMYCxlZta0cdN1PGCVMt4MhJ5xOti/PYl0j
         c4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726494071; x=1727098871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zffz6f9+9dTXuU7HF30nwxvwdmDiNFzFtwvqDSpArI=;
        b=peCeHSVkLCGgkJY6VqQdD7maCfIcyoffhkZrmFMFrpmxenEBpxZkDKtlXXPUo7YB9W
         MpI3Az4iCsWiVKYdyLC1231wtftaBpDI4frSz+6+HhJIW0nsdZGChEOInBTlTUBgbnhW
         ass/rOd4/qfsQfiKM90JydsXrHk4MAR5Q3klbrJTzPeSAEccasY4ahe2/MePCdobjNqQ
         NpsdWGfewvz2iwy5ZGeEAsycW+i3TYi+heX8aq3ZbgBOV6rOJ35jr3NHlON6a8ZD++iW
         C7ydW1IT9fVjrXWSfAumIq7v5/Uh+uPnzE7TNtXWNqKo+EXiQl9l24i39juQBYxTCiBf
         BX9A==
X-Forwarded-Encrypted: i=1; AJvYcCWf/Ny51wC3eo1Ra97y5sTkl4sH75O9ealC0N/RWHvinutWFCPfxuZGH/vOMXzshP1oJpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkNngFMI8CRGQPWs1goDn/L77tT6JLwhIA7ctKtXjXxPRzp1U
	mG5mt9PRWX/2cSKy64K8CUvik00tqKuU3lN5fQEE1ke1K1DvKKrrfCKco8B2j80IuR13jbMkHjv
	LxSD+sfPYYeUrYl/Ry+MxSVsQ6n9hpOwyOynL
X-Google-Smtp-Source: AGHT+IGTuz1T5cFsX11jGTdj9wC64zoFaE8zfr1y1SF9nXJUH8c6kxf77d2bSRijJg6lfnRABIn/50xST1PXnkCH4TM=
X-Received: by 2002:a05:651c:1501:b0:2f7:65b0:ff29 with SMTP id
 38308e7fff4ca-2f787f431demr69122171fa.38.1726494070387; Mon, 16 Sep 2024
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
 <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com>
 <CANiq72nm2dU2o_x_GQ5SdsXaK6yZiDXG2hXEYMykViEAZvuMqQ@mail.gmail.com>
 <CACT4Y+YyYnwg4a1zjTnBU=t0x5Brt1rGuzz-5pXf2Fz3cKf4FQ@mail.gmail.com>
 <CANiq72=vMydenfkxQx4X7kYvHD0cHzNK19xxxqow3WcLStsdRA@mail.gmail.com>
 <CACT4Y+ZrwXB1W31Rr7rUUOoW15YbKfnC0khY9KnNk8FTf5uQnA@mail.gmail.com> <CANiq72=pZy6RzomqbKtM5Ky43+Y0y3c1HQkbwrpS-1FHcEqYqg@mail.gmail.com>
In-Reply-To: <CANiq72=pZy6RzomqbKtM5Ky43+Y0y3c1HQkbwrpS-1FHcEqYqg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Sep 2024 15:40:58 +0200
Message-ID: <CACT4Y+aJ4VX5j_Lz7QDb8ynz6vAn_n8d2AM1M5=NUc0ZBUp-dA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: syzkaller@googlegroups.com, alex.gaynor@gmail.com, 
	andriy.shevchenko@linux.intel.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, bpf@vger.kernel.org, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, ojeda@kernel.org, 
	pmladek@suse.com, rostedt@goodmis.org, rust-for-linux@vger.kernel.org, 
	senozhatsky@chromium.org, syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com, 
	Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Apr 2023 at 13:37, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> > I understand your intentions and they make sense.
>
> Thanks! I am glad you agree it may have some value -- please see below
> for details.
>
> > But adding this logic to syzbot won't help thousands of users of
> > get_maintainer.pl and dozens of other testing systems. There also will
>
> I haven't said otherwise -- as I said, I think it would be nice to
> have this be part of the kernel itself. :)
>
> > be a bit of get_maintainer.pl inside of syzbot code, so now all kernel
> > developers will need to be aware of it and also submit changes to
> > syzbot when they want to change maintainers logic.
> >
> > I think this also equally applies to all other users of K:.
> > And a number of them had similar complaints re how K; works.
>
> Yeah, I would imagine so.
>
> > I am thinking if K: should actually apply just to patches and be
> > ignored for source files?
>
> I considered that -- for things like Rust, it could make sense, but
> perhaps somebody is already using `K:` to match files they do care
> about, rather than `F:`. So we would need to ask others, but I think
> it is fine.
>
> > If there are files that belong to "rust" (or "bpf" or any other user
> > of K:), then I think these should be just listed explicitly in the
> > subsystem (that should be a limited set of files that can be
> > enumerated with wildcards).
>
> Yes, at least for Rust, modulo omissions, we match files explicitly
> with `F:`. We have a couple unimportant omissions, e.g.
> `.rustfmt.toml`, but I can send a patch.
>
> Personally, I have always seen `F:` files (and `N:`-matched ones) as
> having more weight than `K:`-matched ones, i.e. I saw `K:` as more of
> a "it depends on what it matches -- discretion needed".
>
> From a quick look, most `K:`-using subsystems seem to list `F:` and
> `N:` as I would expect.
>
> > It's also reasonable to apply K: to patches.
>
> Yes, definitely, for Rust, that is our main use case, i.e. it is
> mainly why we wanted to have the `K:` entry: to catch changes to
> things that are tagged with "Rust" in C files (early on, at least).
>
> It is particularly important for us, since we are also considering
> having more of these annotations in the future.
>
> > But if a random source file happened to mention "rust" somewhere once,
> > I am not sure you want to be CCed on all issues in that file.
> > Does it sound reasonable?
>
> For Rust, yes, that would probably work for us. Not sure for all
> subsystems using `K:`, though.
>
> Having said that, I suggested including the kernel config too in this
> decision (i.e. not for the patches case, but for testers finding
> runtime issues), because it adds information: it leaves reports out
> when something is not even enabled but matched via `K:`, but still
> allows a Cc when matched via `K:` and enabled. It is, of course, still
> potentially a false positive, but some subsystems may want to hear
> about those.
>
> For instance, for Rust, this would be fine early on, since we don't
> expect many to have `RUST=y` to begin with, and thus the odd false
> positive report via `K:` is fine. Later on, this heuristic may change,
> and we may not change those matches anymore (especially since, by
> then, the goal is that subsystems would be taking care of their own
> Rust bits).
>
> This is what I was suggesting to then put in `get_maintainer.pl`, e.g.
> a `--bot` option (or `--runtime`, or `--config-based-filtering`, or
> similar) option. Then the bots can add that option on their side.
>
> Thanks again for considering this!

Was looking at what's the status of this, and if we need to file a
feature request for syzbot.
Turns out Joe Perches fixed this a bit ago by adding
--keywords-in-file flag (off by default):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71ca5ee18708c1f9f086e20ac0a657009bcfe43a

I think that's the right thing to do. syzbot won't be confused by
widely matched K: patterns with sending reports (since it runs
get_maintainers.pl on files).

