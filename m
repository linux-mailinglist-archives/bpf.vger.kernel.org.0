Return-Path: <bpf+bounces-37294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F691953B56
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D273E1F25A84
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B66146016;
	Thu, 15 Aug 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+65usFr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51138DF2;
	Thu, 15 Aug 2024 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753040; cv=none; b=Z60V/Fe4dam74BErtYpll5H94sIhU8g+aMb2WTRt197lrprJHQToxY27EhjNS6iiO1lRaPXo3RYIn47z16nIR24JdctjOu1fcncFJu0YYeeg7RH+TQfrvta0lCQuNpHeX6iXajmL2wLxezESuGr9tNJyeimqJK1RZapDUgHwhkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753040; c=relaxed/simple;
	bh=lQ+EvvnnqRtmWrFJp3Xd9Te12DStmE4knki2NE8OWrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWWFuJUbqAib6H1J1nrWr2KfMLvV7XvDuBvA3SLbsphUJSuDyZp6N4NdC89gCikt4GLfLvdxBbRt/cbbPIgJRiLSdzqhCZPZMR9hZ4m8Fj2gQfHy4NMfQDjWQHOaj4tHY+YUJX2tw8epRszI3CXEdxNGhC4Cckf5byKBUOEGCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+65usFr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so991868a12.3;
        Thu, 15 Aug 2024 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723753038; x=1724357838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cdTKPtoN4CzKbsNc3MnpYWSX4bpB5XCY/L4ADgd1ls=;
        b=K+65usFrR6AZrlMOdxoVXUam9O9KRNXAmZnebswswFWSHgbdhbuyaBdcVi1L+RF4v1
         KckBCI2FZ4tHFVogDwXe/To//fDN5bwkW935UhIMvegXM5DH5jnvUgM2ytJyJQV4j5KJ
         VyINrW1GgetCOXSJuGtcs3OlLfj/7rCCMs6FOI6OIqRuHSAIat5aS7UXFDW7Z3irvXvP
         iiEYGrf960+0/EuxrU0gzREA+C7DJ1M6pshWj7BLloFUNs2FmITMqYm97t5eztF/1/V2
         Y4eFVbGGimd3qH/51KJM42v8qqPHrPrPsmk4Yz0A4E92eK/M04LO4bxkkUFEm3IeVAkn
         DQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723753038; x=1724357838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cdTKPtoN4CzKbsNc3MnpYWSX4bpB5XCY/L4ADgd1ls=;
        b=Mm0ZvsojByyVJ8pPoBFIdSXswxxCRMf+MyvqGh9Ij79JCn8De73bJasH0DTfhe93AO
         AdP2Hq71s2DSY3XJSkopyhjBoMT3/Sb+htZmyV/rmdaC5Ux1+59yyMEFPAxRdwFNPNrK
         V+l2ih8QQlVYElUgh0x98cQDnNeHIOekZMdFTtSNJyEQxLxlo5vvgWTC+PBnb5xZG5Ps
         xIeT2OzmZnCT4ypXieZlABcuvIwBms2o4Rn+lZF2WRN2F3yIvWznR3N804m3lJq41Oml
         keULO4hEFVNXe7G9JrBhucRksR5JGvFZQfvRGOP5ZSBTg8ZLPrwNZNb509EuGYXEbuSU
         7DTA==
X-Forwarded-Encrypted: i=1; AJvYcCUZjizrBGAD5+U8OJ3Qr4Fh+oXQQWe5/5Fh0CXHMRvK5bvq6gHflBhjYVF7198Drkm92hs7M3eJe3REliVSNr6eC5dnFmXSri0lzXHe2UGhgFqIy1Lls1jLO0cuX9gCW8gLL2cRtks/k8+ZA9b80gbuM2ZEYodigIaV3Ja/iZli3hQYJRHc
X-Gm-Message-State: AOJu0YzkwoOGpZlV80So9JhITwrG2kQqOdoq03ab/6zkAXvgsexQgFPW
	YK8rpwOK0BlZjgKdHEOBFR9mTIpmIHiDL5tmiGS70L2QCzi5IPz5etCtr/0MXOFWZJA9kk3o6sA
	y1Zruh9MmEtro6Wtgy1vafFxtVgw=
X-Google-Smtp-Source: AGHT+IG/3Oe6f9E+qWnqbNQJ7WtZ8Qle8wXpUdO9SOJikgKPAM96ccSiRAJmaUC3x7vChs7vGIIh2bwQVsa4vRL1h70=
X-Received: by 2002:a17:90b:1247:b0:2cd:5d13:40ba with SMTP id
 98e67ed59e1d1-2d3dffc8f3bmr928532a91.14.1723753037724; Thu, 15 Aug 2024
 13:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813042917.506057-1-andrii@kernel.org> <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
 <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
 <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5>
 <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com>
 <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com> <CAG48ez2VwmFU7ubongD1AnYJDf2-RrFod33Zvbjy1NwRj4-Y1A@mail.gmail.com>
In-Reply-To: <CAG48ez2VwmFU7ubongD1AnYJDf2-RrFod33Zvbjy1NwRj4-Y1A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 13:17:05 -0700
Message-ID: <CAEf4BzY6zSe_u4vtCBDwZp4R_hVsE3weZ+-UpXJsohrUeJeE4Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
To: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:58=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> +brauner for "struct file" lifetime
>
> On Thu, Aug 15, 2024 at 7:45=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > On Thu, Aug 15, 2024 at 9:47=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Aug 15, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.=
com> wrote:
> > > >
> > > > On Tue, Aug 13, 2024 at 08:36:03AM -0700, Suren Baghdasaryan wrote:
> > > > > On Mon, Aug 12, 2024 at 11:18=E2=80=AFPM Mateusz Guzik <mjguzik@g=
mail.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote=
:
> > > > > > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely =
access
> > > > > > > vma->vm_file->f_inode lockless only under rcu_read_lock() pro=
tection,
> > > > > > > attempting uprobe look up speculatively.
>
> Stupid question: Is this uprobe stuff actually such a hot codepath
> that it makes sense to optimize it to be faster than the page fault
> path?

Not a stupid question, but yes, generally speaking uprobe performance
is critical for a bunch of tracing use cases. And having independent
threads implicitly contending with each other just because of uprobe's
internal implementation detail (while conceptually there should be no
dependencies for triggering uprobe from multiple parallel threads) is
a big surprise to users and affects production use cases beyond just
uprobe-handling BPF logic overhead ("useful overhead") they assume.

>
> (Sidenote: I find it kinda interesting that this is sort of going back
> in the direction of the old Speculative Page Faults design.)
>
> > > > > > > We rely on newly added mmap_lock_speculation_{start,end}() he=
lpers to
> > > > > > > validate that mm_struct stays intact for entire duration of t=
his
> > > > > > > speculation. If not, we fall back to mmap_lock-protected look=
up.
> > > > > > >
> > > > > > > This allows to avoid contention on mmap_lock in absolutely ma=
jority of
> > > > > > > cases, nicely improving uprobe/uretprobe scalability.
> > > > > > >
> > > > > >

[...]

> > Note: up_write(&vma->vm_lock->lock) in the vma_start_write() is not
> > enough because it's one-way permeable (it's a "RELEASE operation") and
> > later vma->vm_file store (or any other VMA modification) can move
> > before our vma->vm_lock_seq store.
> >
> > This makes vma_start_write() heavier but again, it's write-locking, so
> > should not be considered a fast path.
> > With this change we can use the code suggested by Andrii in
> > https://lore.kernel.org/all/CAEf4BzZeLg0WsYw2M7KFy0+APrPaPVBY7FbawB9vjc=
A2+6k69Q@mail.gmail.com/
> > with an additional smp_rmb():
> >
> > rcu_read_lock()
> > vma =3D find_vma(...)
> > if (!vma) /* bail */
>
> And maybe add some comments like:
>
> /*
>  * Load the current VMA lock sequence - we will detect if anyone concurre=
ntly
>  * locks the VMA after this point.
>  * Pairs with smp_wmb() in vma_start_write().
>  */
> > vm_lock_seq =3D smp_load_acquire(&vma->vm_lock_seq);
> /*
>  * Now we just have to detect if the VMA is already locked with its curre=
nt
>  * sequence count.
>  *
>  * The following load is ordered against the vm_lock_seq load above (usin=
g
>  * smp_load_acquire() for the load above), and pairs with implicit memory
>  * ordering between the mm_lock_seq write in mmap_write_unlock() and the
>  * vm_lock_seq write in the next vma_start_write() after that (which can =
only
>  * occur after an mmap_write_lock()).
>  */
> > mm_lock_seq =3D smp_load_acquire(&vma->mm->mm_lock_seq);
> > /* I think vm_lock has to be acquired first to avoid the race */
> > if (mm_lock_seq =3D=3D vm_lock_seq)
> >         /* bail, vma is write-locked */
> > ... perform uprobe lookup logic based on vma->vm_file->f_inode ...
> /*
>  * Order the speculative accesses above against the following vm_lock_seq
>  * recheck.
>  */
> > smp_rmb();
> > if (vma->vm_lock_seq !=3D vm_lock_seq)
>

thanks, will incorporate these comments into the next revision

> (As I said on the other thread: Since this now relies on
> vma->vm_lock_seq not wrapping back to the same value for correctness,
> I'd like to see vma->vm_lock_seq being at least an "unsigned long", or
> even better, an atomic64_t... though I realize we don't currently do
> that for seqlocks either.)
>
> >         /* bail, VMA might have changed */
> >
> > The smp_rmb() is needed so that vma->vm_lock_seq load does not get
> > reordered and moved up before speculation.
> >
> > I'm CC'ing Jann since he understands memory barriers way better than
> > me and will keep me honest.

