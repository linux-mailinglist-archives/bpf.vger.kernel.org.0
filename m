Return-Path: <bpf+bounces-31520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7F8FF36A
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50761C2127D
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC62198E98;
	Thu,  6 Jun 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkdUd5PI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96C1E495
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693956; cv=none; b=MA5PV1sZiO7T84pt3VFV+LNSKp7Bu6+9iEC/n6mdL9MXdFWldmaIOSt1YTJj9CcmESv2+kTeMVRLZXrbBysATzP74Xna3mJNft0W61y8TJTffxv9DO5JjX4FpxcqygoCpZtBNFD849bkf9AMxL9VaUIPM5Qt23wntg3LlAj1RhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693956; c=relaxed/simple;
	bh=i6UeZoIGf5MzZQ1BZ0IkgNMzgsE2gNY0H16mgMu9QUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxeVCe3r2TXd3I282o2Oq8tQcwpRqAzTTeZ+CbQTxyiFXQ/3UJz9ypsuCIGawTwDep9KL0CvG74oCXAXAgQHW333ga0V2KdSMhi/Uv5PRBjHyuFXOEmYfvDLsQRZ51IxJ0cS/cpykTKQE2omH6i4V4yV2k/erIx3NspblKjDFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkdUd5PI; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfa65af5367so1515741276.1
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717693954; x=1718298754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZKE81qoxM89lbOangpx2QgEODfNB1onCrSNSnUNWZg=;
        b=wkdUd5PItyL2KdV18tUOU6FG7JRahfnlT7Pj9u0+vc0NdMTGWV4OVRJFBiAqQMeL/R
         I7kCUrwseWFr2GpZaJZbXtQZWPw7fOcFoaW7ubvMZ/JZqMXVW8v/yaUYnrXXYEahBNZI
         iqa21RElU9dq5zMzmckEZzrSP/lGhYqvPqzTFX5AWdhljrfDKAHhi6KSGwpMwL2rcBnr
         eJ+qaFL3uMjjsxRvsorHIZPoOiX3HNEeCyPe3Qpz5yVSdqn5d6yz/OLD8s1fYSSIb+DH
         3cN/a9hSOOepZJwrDLe+7oiK30AVHUbtNbaq8hPulTOqIsDci+WsDe2F/qlHtoyh+08c
         2VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693954; x=1718298754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZKE81qoxM89lbOangpx2QgEODfNB1onCrSNSnUNWZg=;
        b=g40n1JRJom0atHpMaVsL/284WAnXQV/MKHPrf1tehYvbaTl1far/P6QqIIkbPj/UOb
         JPKUPmvI/Vh9CIy9K6y4Ja/bdAyjVMciZ4kwkpPAeSxjURV+NIxmo1ZmrABSQ+sjyVo/
         6ySoFAgyGGpm7arQDf39tn3F9N3xriuuUypWjMRxh+wYIwY+/nP6QgYqdwxOmm3EOJJt
         TEERdEyegPcCkscaBECFM3SltWWBQndGlpL4T/shzYsEZBiRBrVHG/MDAxFEWBgzqfjk
         2ViMfxXyWWXWv//aVcnfidQuFrwdA1AXIAiZKq0hA8Jf7fm9229UNpXPGnoRy6Y838kN
         pxkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXxJiXONilSgkhqiNCLITWZ4rwUH6tQhAY3uPGLnP9OqRM+3bLdznwsP2+pxv7nqfangJeR9jDFpylv0S7nO0UvXJc
X-Gm-Message-State: AOJu0Yyz3b++EK5TyBDasr9e8+9NE30+U4fj1CAsrEV8B0MA04QhSyGu
	V9hMGNgkQEdfJ6b661nqfSUsVzTsRf8tUMn6sWJAoSxcumYlUOuIJtOtmXlCJJlCPi30FcVJBtc
	MMbHRqh6ci1OAbHLrin5xeaAMudsG62RKHc9f
X-Google-Smtp-Source: AGHT+IH1cpi2LYBIddbBM2tFPkjXrGUnnuJw36AgrAa/4/yXidELcXd58akGUTBX9aNDWCS+xMYyUK+XSoCTEqGqMzk=
X-Received: by 2002:a25:c744:0:b0:dfa:49f9:d334 with SMTP id
 3f1490d57ef6-dfaf6645fd6mr6214276.48.1717693953710; Thu, 06 Jun 2024 10:12:33
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-5-andrii@kernel.org>
 <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com> <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 6 Jun 2024 10:12:19 -0700
Message-ID: <CAJuCfpG1vSHmdPFvZSryHd+5pMZayKL9AJwgw1syRSBHnW-WHQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 5, 2024 at 4:16=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Tue, Jun 4, 2024 at 5:25=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > Attempt to use RCU-protected per-VMA lock when looking up requested V=
MA
> > > as much as possible, only falling back to mmap_lock if per-VMA lock
> > > failed. This is done so that querying of VMAs doesn't interfere with
> > > other critical tasks, like page fault handling.
> > >
> > > This has been suggested by mm folks, and we make use of a newly added
> > > internal API that works like find_vma(), but tries to use per-VMA loc=
k.
> > >
> > > We have two sets of setup/query/teardown helper functions with differ=
ent
> > > implementations depending on availability of per-VMA lock (conditione=
d
> > > on CONFIG_PER_VMA_LOCK) to abstract per-VMA lock subtleties.
> > >
> > > When per-VMA lock is available, lookup is done under RCU, attempting =
to
> > > take a per-VMA lock. If that fails, we fallback to mmap_lock, but the=
n
> > > proceed to unconditionally grab per-VMA lock again, dropping mmap_loc=
k
> > > immediately. In this configuration mmap_lock is never helf for long,
> > > minimizing disruptions while querying.
> > >
> > > When per-VMA lock is compiled out, we take mmap_lock once, query VMAs
> > > using find_vma() API, and then unlock mmap_lock at the very end once =
as
> > > well. In this setup we avoid locking/unlocking mmap_lock on every loo=
ked
> > > up VMA (depending on query parameters we might need to iterate a few =
of
> > > them).
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  fs/proc/task_mmu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 614fbe5d0667..140032ffc551 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -388,6 +388,49 @@ static int pid_maps_open(struct inode *inode, st=
ruct file *file)
> > >                 PROCMAP_QUERY_VMA_FLAGS                         \
> > >  )
> > >
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +static int query_vma_setup(struct mm_struct *mm)
> > > +{
> > > +       /* in the presence of per-VMA lock we don't need any setup/te=
ardown */
> > > +       return 0;
> > > +}
> > > +
> > > +static void query_vma_teardown(struct mm_struct *mm, struct vm_area_=
struct *vma)
> > > +{
> > > +       /* in the presence of per-VMA lock we need to unlock vma, if =
present */
> > > +       if (vma)
> > > +               vma_end_read(vma);
> > > +}
> > > +
> > > +static struct vm_area_struct *query_vma_find_by_addr(struct mm_struc=
t *mm, unsigned long addr)
> > > +{
> > > +       struct vm_area_struct *vma;
> > > +
> > > +       /* try to use less disruptive per-VMA lock */
> > > +       vma =3D find_and_lock_vma_rcu(mm, addr);
> > > +       if (IS_ERR(vma)) {
> > > +               /* failed to take per-VMA lock, fallback to mmap_lock=
 */
> > > +               if (mmap_read_lock_killable(mm))
> > > +                       return ERR_PTR(-EINTR);
> > > +
> > > +               vma =3D find_vma(mm, addr);
> > > +               if (vma) {
> > > +                       /*
> > > +                        * We cannot use vma_start_read() as it may f=
ail due to
> > > +                        * false locked (see comment in vma_start_rea=
d()). We
> > > +                        * can avoid that by directly locking vm_lock=
 under
> > > +                        * mmap_lock, which guarantees that nobody ca=
n lock the
> > > +                        * vma for write (vma_start_write()) under us=
.
> > > +                        */
> > > +                       down_read(&vma->vm_lock->lock);
> >
> > Hi Andrii,
> > The above pattern of locking VMA under mmap_lock and then dropping
> > mmap_lock is becoming more common. Matthew had an RFC proposal for an
> > API to do this here:
> > https://lore.kernel.org/all/ZivhG0yrbpFqORDw@casper.infradead.org/. It
> > might be worth reviving that discussion.
>
> Sure, it would be nice to have generic and blessed primitives to use
> here. But the good news is that once this is all figured out by you mm
> folks, it should be easy to make use of those primitives here, right?
>
> >
> > > +               }
> > > +
> > > +               mmap_read_unlock(mm);
> >
> > Later on in your code you are calling get_vma_name() which might call
> > anon_vma_name() to retrieve user-defined VMA name. After this patch
> > this operation will be done without holding mmap_lock, however per
> > https://elixir.bootlin.com/linux/latest/source/include/linux/mm_types.h=
#L582
> > this function has to be called with mmap_lock held for read. Indeed
> > with debug flags enabled you should hit this assertion:
> > https://elixir.bootlin.com/linux/latest/source/mm/madvise.c#L96.
>
> Sigh... Ok, what's the suggestion then? Should it be some variant of
> mmap_assert_locked() || vma_assert_locked() logic, or it's not so
> simple?
>
> Maybe I should just drop the CONFIG_PER_VMA_LOCK changes for now until
> all these gotchas are figured out for /proc/<pid>/maps anyway, and
> then we can adapt both text-based and ioctl-based /proc/<pid>/maps
> APIs on top of whatever the final approach will end up being the right
> one?
>
> Liam, any objections to this? The whole point of this patch set is to
> add a new API, not all the CONFIG_PER_VMA_LOCK gotchas. My
> implementation is structured in a way that should be easily amenable
> to CONFIG_PER_VMA_LOCK changes, but if there are a few more subtle
> things that need to be figured for existing text-based
> /proc/<pid>/maps anyways, I think it would be best to use mmap_lock
> for now for this new API, and then adopt the same final
> CONFIG_PER_VMA_LOCK-aware solution.

I agree that you should start simple, using mmap_lock first and then
work on improvements. Would the proposed solution become useless with
coarse mmap_lock'ing?

>
> >
> > > +       }
> > > +
> > > +       return vma;
> > > +}
> > > +#else
> > >  static int query_vma_setup(struct mm_struct *mm)
> > >  {
> > >         return mmap_read_lock_killable(mm);
> > > @@ -402,6 +445,7 @@ static struct vm_area_struct *query_vma_find_by_a=
ddr(struct mm_struct *mm, unsig
> > >  {
> > >         return find_vma(mm, addr);
> > >  }
> > > +#endif
> > >
> > >  static struct vm_area_struct *query_matching_vma(struct mm_struct *m=
m,
> > >                                                  unsigned long addr, =
u32 flags)
> > > @@ -441,8 +485,10 @@ static struct vm_area_struct *query_matching_vma=
(struct mm_struct *mm,
> > >  skip_vma:
> > >         /*
> > >          * If the user needs closest matching VMA, keep iterating.
> > > +        * But before we proceed we might need to unlock current VMA.
> > >          */
> > >         addr =3D vma->vm_end;
> > > +       vma_end_read(vma); /* no-op under !CONFIG_PER_VMA_LOCK */
> > >         if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
> > >                 goto next_vma;
> > >  no_vma:
> > > --
> > > 2.43.0
> > >

