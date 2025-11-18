Return-Path: <bpf+bounces-75002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A83C6B6EC
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 20:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34CB84E5CA2
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 19:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708BE2E9ECE;
	Tue, 18 Nov 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTgOVNUF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195E2E88B7
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494082; cv=none; b=Phff/xza+dXgqIxaZ1bsCOF95bhTVf1XHVTiLFOeYjW32BQ9MJGU+TiiPQBz9AMLhE30Ai/mgN88r+qNtGLuHhkYhHBRii0YTt0WvmnXgwpT5B7617/pugRRBNtqaUvrzRQ+s4LlBbAyO6zq63P6Oz+KMOmvdh/oShWYKlQlV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494082; c=relaxed/simple;
	bh=CEu2HX49eMyL/fkGI6RcH7NRGSH9WLfbLJE7zmZxVOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqlyMkrZ3jdBmZYH5udpcVyNQyDYlJcftDY1zojeUtlP/jZ3z9LCPMGge8K1V6Vkckgp5DMfwY55jNw7tORSKJ08CxmqErqAm0uw4AUHz2jYn0AjEzoILRQ/tZ/oAR6wT+40vF75Mh2aKSh+754ceetkf3idIq3OsI2N59lWgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTgOVNUF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso5085891a91.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 11:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763494080; x=1764098880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doC9uXNUqoKejMIunGd/jGTKolDii5Qguk+TBihyyxM=;
        b=UTgOVNUF4YpJm2RoWUs9xUzFoRdfh2RjAWltGH57IvYSvOV7+I5TuIb6aznu4BoBRR
         s+QA87jnQshVZlnbenmKM/axYdPIO8ir/M3xZcUCbQ2uSLc7tIkimBYhskv5nL3gnfHr
         NAbt0XxmQG2lZzxG04m6IPu/M/Zvh/TEYMQ3f2IqPZHpg0xy7WnKMJcySH63KutG4RSO
         x82lTJiHBmo/zQLyHz9TvwDJApxu4V/lkwKXkCDC0QlgZ0Guwy3j+QyeK02oWnAjHWbC
         q7QgDNWiovhrvKh0ZMCdja1GKRu61rbec99GOTg13PbXmHnfuISeP7FK9xCm7cMeit6a
         Bizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763494080; x=1764098880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doC9uXNUqoKejMIunGd/jGTKolDii5Qguk+TBihyyxM=;
        b=CREC3b6OogelPaAX4VF2l1lc9OHflR/TiN2eO8cJEsk7SykPgzftHGi9N7zsrFm4aS
         plk2sfw9Ovt/3inat8zYCFn7KVhjPVfCV3JE15U4UAow/0SNL6qZ7A2xYvCO/WNpHi+a
         S9w0akTNQNZTUui0rTpxkhU9YITkaobnx4aJlxssZcUSSONnWB01ZzzuKtKNl/kcTPzC
         aYJ5UfZvAMdz9sNT+Fwu6U/VCREb9sy6fyxolsM8EH4yJTi8YOuLmECwMdbQBj4bCcep
         xmriMdM8yQzs0JR8Af86KILSfLxKssDMwGdoPE3ATlOLACWLvgYK0X40QtVNtn74wfsG
         +A6A==
X-Forwarded-Encrypted: i=1; AJvYcCXGERiiTVJ9Lo+G995ChtlEImL3n0gpA+U253kafHdG5EqtCMjH7Uoa3MfCQvuslL5LEH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhK7pci1ILLYELxb9mxChIDGRxyiO+FPK0f616znpciby1imDW
	Wk9RlIekgB66zV6XjdToa7XCFiPKq87maIpU86r/ZCfCqGgwVg+g9lhYY4OZNFkCsB9VQkhSXfG
	nOHsFk7SemtzxDBGl6YvbNpmktjjYsAo=
X-Gm-Gg: ASbGncsFM2CabokdanH0E6I2bHwNfUqqdxprmiKC7yepSDC4GoUGb1Aczh3SSupkR5k
	opIIrJtytaaePfJCldXD6MNnLCiqM49e2NOegXDCo2XC11Gc4OZnGTVfDh3dmBYhtqThq3rXI4M
	IglwcAKcDF/cB4MW1MFBZ9jRRZ7hpbIIeQm01Ex7lbbNpy4ahgRR7Z2zVyhDqtgZdYaCcJwAeZZ
	v3kjsvlMQUKtmYwT4F8ds4UR7v18vWA1mX9ZKt0xr8ksdVJTG8mN6Z+KcWXg/1P5TMErgT/3zct
	9NxUn/VqWfcO3FjmFJQdXQ==
X-Google-Smtp-Source: AGHT+IG58zG+XluUaIiZAZv9m1uRF7fwmOmXIq4KeWpc40NILlovsL0nA2fYLe6y5JHtEDDylDzt5ytVO+jnJ5EKrZo=
X-Received: by 2002:a17:90b:2788:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-343f9eaa41dmr17041894a91.8.1763494079727; Tue, 18 Nov 2025
 11:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114193729.251892-1-ssranevjti@gmail.com> <aReUv1kVACh3UKv-@casper.infradead.org>
 <CANNWa07Y_GPKuYNQ0ncWHGa4KX91QFosz6WGJ9P6-AJQniD3zw@mail.gmail.com>
 <aRpQ7LTZDP-Xz-Sr@casper.infradead.org> <20251117164155.GB196362@frogsfrogsfrogs>
 <aRtjfN7sC6_Bv4bx@casper.infradead.org> <CAEf4BzZu+u-F9SjhcY5GN5vumOi6X=3AwUom+KJXeCpvC+-ppQ@mail.gmail.com>
 <aRxunCkc4VomEUdo@infradead.org> <aRySpQbNuw3Y5DN-@casper.infradead.org>
In-Reply-To: <aRySpQbNuw3Y5DN-@casper.infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Nov 2025 11:27:47 -0800
X-Gm-Features: AWmQ_bn356VQg7AFLndJgLd27HF_zQfgIMoqrhbk6mAt-2PXr32Xi9lJz8Nh9GM
Message-ID: <CAEf4BzY1fu+7pqotaW6DxH_vvwCY8rTuX=+0RO96-baKJDeB_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: fix NULL pointer dereference in do_read_cache_folio()
To: Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>, akpm@linux-foundation.org, 
	shakeel.butt@linux.dev, eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:37=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Nov 18, 2025 at 05:03:24AM -0800, Christoph Hellwig wrote:
> > On Mon, Nov 17, 2025 at 10:45:31AM -0800, Andrii Nakryiko wrote:
> > > As I replied on another email, ideally we'd have some low-level file
> > > reading interface where we wouldn't have to know about secretmem, or
> > > XFS+DAX, or whatever other unusual combination of conditions where
> > > exposed internal APIs like filemap_get_folio() + read_cache_folio()
> > > can crash.
> >
> > The problem is that you did something totally insane and it kinda works
> > most of the time.
>
> ... on 64-bit systems.  The HIGHMEM handling is screwed up too.
>
> > But bpf or any other file system consumer has
> > absolutely not business poking into the page cache to start with.
>
> Agreed.

Then please help make it better, give us interfaces you think are
appropriate. People do use this functionality in production, it's
important and we are not going to drop it. In non-sleepable mode it's
best-effort, if the requested part of the file is paged in, we'll
successfully read data (such as ELF's build ID), and if not, we'll
report that to the BPF program as -EFAULT. In sleepable mode, we'll
wait for that part of the file to be paged in before proceeding.
PROCMAP_QUERY ioctl() is always in sleepable mode, so it will wait for
file data to be read.

If you don't like the implementation, please help improve it, don't
just request dropping it "because BPF folks" or anything like that.

>
> > And I'm really pissed off that you wrote and merged this code without
> > ever bothering to talk to a FS or MM person who have immediately told
> > you so.  Let's just rip out this buildid junk for now and restart
> > because the problem isn't actually that easy.
>
> Oh, they did talk to fs & mm people originally and were told NO, so they
> sneaked it in through the BPF tree.

This patch set was never landed and has *NO* relation to the
lib/buildid.c stuff we are discussing. There was no sneaking anything
in. The patch set in question that added folio-based reading logic was
developed in the open with both mm and fsdevel in CC. Matthew himself
looked at it, he NAKed page-based initial implementation but suggested
folio-based one ([0]). Shakeel did review this (the patch set went
through 10 revisions, plenty of time to object).

  [0] https://lore.kernel.org/bpf/ZrOStYOrlFr21jRc@casper.infradead.org/

>
> https://lore.kernel.org/all/20230316170149.4106586-1-jolsa@kernel.org/
>
> > > The only real limitation is that we'd like to be able to control
> > > whether we are ok sleeping or not, as this code can be called from
> > > pretty much anywhere BPF might run, which includes NMI context.
> > >
> > > Would this kiocb_read() approach work under those circumstances?
> >
> > No.  IOCB_NOWAIT is just a hint to avoid blocking function calls.
> > It is not guarantee and a guarantee is basically impossible.
>
> I'm not sure I'd go that far -- I think we're pretty good about not
> sleeping when IOCB_NOWAIT is specified and any remaining places can
> be fixed up.
>
> But I am inclined to rip out the buildid code, just because the
> authors have been so rude.

Can you please elaborate on "authors have been so rude" a bit more?
Besides that link to an absolutely unrelated patch set?..

