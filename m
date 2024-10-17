Return-Path: <bpf+bounces-42333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B819A2E47
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0A5281211
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88241227BAF;
	Thu, 17 Oct 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0N1J/R/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335C219CAF;
	Thu, 17 Oct 2024 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195992; cv=none; b=PzNx0xl6/BSh7qCDrYnypMyNL8moMtGJJUstxkvT7ubhkyi90iahsGj17MpExxCTxdThyyto0ESjlvaLHZrx4FaWumKuM3VsIBQZ5ga838On/tPshoGczm+naY5SAr9pwdrXxYxI6hL2FYTuQs6RKjRskYEnnNO8KqxM0WOeL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195992; c=relaxed/simple;
	bh=KUuaRfcFiN6JnYO5+GesldgjncPM1A2jg50nVWwg760=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTgO3wN9KOpK0bPXLSmyZlyondKaDkrDZfuh2p9vd6f0GtqCC8YltCpnsJhXZXPml5yua4oWaFHCcFjIpN5MWJH9oBWIMgtJ7a7sVEo1wf39NOn51gak6Earrd0LCKKswwjFu2gEqWXyQIRnYB38AI8e0lANpM0XzOoUkf4aPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0N1J/R/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5130832aso960718b3a.0;
        Thu, 17 Oct 2024 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729195986; x=1729800786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja6Fh9/kqcvQYixmRlkAxQv+Z2SX3C04BQvu9t30ons=;
        b=Q0N1J/R/efZy5WBc5Wu8fR+I4Yi+IHaTs6etblDR6FF1qiAF+1CQd78wIDO7/H0YML
         nM9oQsYrnSl7GqNApSsynZUlUmeZpMIBviHLclfPBEmV/xiyD7X4tfu8v+cdI0D/q/Ag
         i/mEpqpO+Bt0nzYLet8eeRBEdCrTMZuOB0U1dyEHOYAYbG0I++bNLzSuh1+BQqEqkp8S
         a7kC5PMnUVZ0ii8+AsuZzJyX7X/tQGJFb2yJ/extpyROI8mgabwshDnTTCjJsXognjgJ
         tUsFM236WkqpGRFqDD6hnDjSNLzyrWSHYqKz2Plorp6VOl1L5WTYe+fZDKSDXtnbbmNb
         EhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729195986; x=1729800786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja6Fh9/kqcvQYixmRlkAxQv+Z2SX3C04BQvu9t30ons=;
        b=gl+6dN7akE3LB95SL2GuIP9IqbaE7Xj6AC3c2G338UUjPVMpZaL1u2No/QA5eF74kh
         WSCj9dMJrRNSpWdF8yEPpa/fFahG4DQFDp++Ro9Vf28o36NhCI6Cn6G2e3WPcbiTvD4i
         ZkopeozXiD1rdkxjGEZfInhjI6ZmMPXenTwkvXq2BDiBFmApCApT5TRsboCSGQlfAxlU
         JXGHCkqSJlk6zMlfMYxqNebimLHbVzmYb3+ID3dxwVb7vKfi2wBqjMp0rn7N7xjF0Krv
         mJpKuip8e9dnxEigGr+LDn97dYX+Wdiv8/KexTYFq5CuAMtmOBloEBLL0Si1IaXb8uK4
         4MXg==
X-Forwarded-Encrypted: i=1; AJvYcCVKe2UqBnJQKeNVqcOQUwMBj8GbCCwOVUHszdXG6r4fXnMrh1AvAoqhmssO3a9P7lcabMu+QFtWRCFV2huP@vger.kernel.org, AJvYcCVScGeGVBDSJJoFq3UrZNNMFpYC3UzI7DeYEhxcZpOfF5FA4zi5g+TQ1kYsx2OJmcWs8Ns=@vger.kernel.org, AJvYcCWRXL/IHlUGeIrXdNw6ob0A72AxKowpKl8sEPtD1lKfRdlgQ7aLYRWni/ij6kGGwpp+VqYw7TBhhoyQzF69e8YzO2FA@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDAjGTqzMwCRHH68jxD7rJY39PzL5W9X56bB0x+XD1ZVNfoGM
	pOBYu+LAy9NgxygEssW9bIRqqV6CkMFLf/MfmpkQdcBQm9+Qrx3QPXh8OeFSkQST3u/BDDLqOV7
	LS4VcFMOrUFebVZ7caWA+rAk4WpA=
X-Google-Smtp-Source: AGHT+IEuqSjPzyt42X54W6LXGj8i0fvc5Tl87DgX/uq7AMOSYMFpeKD+1oEd6pxVlSDusiJ6RH5KvAGANmecM7W8NS4=
X-Received: by 2002:a05:6a00:4b14:b0:71e:e4f:3e58 with SMTP id
 d2e1a72fcca58-71ea31e5553mr235117b3a.17.1729195986174; Thu, 17 Oct 2024
 13:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-3-andrii@kernel.org>
 <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
 <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com>
 <CAEf4BzbOXrbixQA=fpg17QPBv+4myAQrHvCX42hVye0Ww9W2Aw@mail.gmail.com> <CAJuCfpHGjkPXMGsttb7bMVr0R1Crv8J_zw5_suj+1nCaT=1fBw@mail.gmail.com>
In-Reply-To: <CAJuCfpHGjkPXMGsttb7bMVr0R1Crv8J_zw5_suj+1nCaT=1fBw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Oct 2024 13:12:53 -0700
Message-ID: <CAEf4BzatVr=70EH9AcHbEwSLy1asJ2x_NKZKsqiAYnkpFpihJg@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
To: Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 12:42=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Oct 17, 2024 at 11:55=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 16, 2024 at 7:02=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@l=
inux.dev> wrote:
> > > >
> > > > On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> > > > > To increase mm->mm_lock_seq robustness, switch it from int to lon=
g, so
> > > > > that it's a 64-bit counter on 64-bit systems and we can stop worr=
ying
> > > > > about it wrapping around in just ~4 billion iterations. Same goes=
 for
> > > > > VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
> > >
> > > vm_lock_seq does not need to be long but for consistency I guess that
> >
> > How come, we literally assign vm_lock_seq from mm_lock_seq and do
> > direct comparisons. They have to be exactly the same type, no?
>
> Not necessarily. vm_lock_seq is a snapshot of the mm_lock_seq but it
> does not have to be a "complete" snapshot. Just something that has a
> very high probability of identifying a match and a rare false positive
> is not a problem (see comment in
> https://elixir.bootlin.com/linux/v6.11.3/source/include/linux/mm.h#L678).
> So, something like this for taking and comparing a snapshot would do:
>
> vma->vm_lock_seq =3D (unsigned int)mm->mm_lock_seq;
> if (vma->vm_lock_seq =3D=3D (unsigned int)mm->mm_lock_seq)

Ah, ok, I see what's the idea behind it, makes sense.

>
> >
> > > makes sense. While at it, can you please change these seq counters to
> > > be unsigned?
> >
> > There is `vma->vm_lock_seq =3D -1;` in kernel/fork.c, should it be
> > switched to ULONG_MAX then? In general, unless this is critical for
> > correctness, I'd very much like stuff like this to be done in the mm
> > tree afterwards, but it seems trivial enough, so if you insist I'll do
> > it.
>
> Yeah, ULONG_MAX should work fine here. vma->vm_lock_seq is initialized
> to -1 to avoid false initial match with mm->mm_lock_seq which is
> initialized to 0. As I said, a false match is not a problem but if we
> can avoid it, that's better.

ok, ULONG_MAX and unsigned long it is, will update

>
> >
> > > Also, did you check with pahole if the vm_area_struct layout change
> > > pushes some members into a difference cacheline or creates new gaps?
> > >
> >
> > Just did. We had 3 byte hole after `bool detached;`, it now grew to 7
> > bytes (so +4) and then vm_lock_seq itself is now 8 bytes (so +4),
> > which now does push rb and rb_subtree_last into *THE SAME* cache line
> > (which sounds like an improvement to me). vm_lock_seq and vm_lock stay
> > in the same cache line. vm_pgoff and vm_file are now in the same cache
> > line, and given they are probably always accessed together, seems like
> > a good accidental change as well. See below pahole outputs before and
> > after.
>
> Ok, sounds good to me. Looks like keeping both sequence numbers 64bit
> is not an issue. Changing them to unsigned would be nice and trivial
> but I don't insist. You can add:
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

thanks, will switch to unsigned in the next revision (next week,
probably, to let some of the pending patches land)

>
> >
> > That singular detached bool looks like a complete waste, tbh. Maybe it
> > would be better to roll it into vm_flags and save 8 bytes? (not that I
> > want to do those mm changes in this patch set, of course...).
> > vm_area_struct is otherwise nicely tightly packed.
> >
> > tl;dr, seems fine, and detached would be best to get rid of, if
> > possible (but that's a completely separate thing)
>
> Yeah, I'll take a look at that. Thanks!
>
> >
> > BEFORE
> > =3D=3D=3D=3D=3D=3D
> > struct vm_area_struct {
> >         union {
> >                 struct {
> >                         long unsigned int vm_start;      /*     0     8=
 */
> >                         long unsigned int vm_end;        /*     8     8=
 */
> >                 };                                       /*     0    16=
 */
> >                 struct callback_head vm_rcu;             /*     0    16=
 */
> >         } __attribute__((__aligned__(8)));               /*     0    16=
 */
> >         struct mm_struct *         vm_mm;                /*    16     8=
 */
> >         pgprot_t                   vm_page_prot;         /*    24     8=
 */
> >         union {
> >                 const vm_flags_t   vm_flags;             /*    32     8=
 */
> >                 vm_flags_t         __vm_flags;           /*    32     8=
 */
> >         };                                               /*    32     8=
 */
> >         bool                       detached;             /*    40     1=
 */
> >
> >         /* XXX 3 bytes hole, try to pack */
> >
> >         int                        vm_lock_seq;          /*    44     4=
 */
> >         struct vma_lock *          vm_lock;              /*    48     8=
 */
> >         struct {
> >                 struct rb_node     rb;                   /*    56    24=
 */
> >                 /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago=
 --- */
> >                 long unsigned int  rb_subtree_last;      /*    80     8=
 */
> >         }                                                /*    56    32=
 */
> >         struct list_head           anon_vma_chain;       /*    88    16=
 */
> >         struct anon_vma *          anon_vma;             /*   104     8=
 */
> >         const struct vm_operations_struct  * vm_ops;     /*   112     8=
 */
> >         long unsigned int          vm_pgoff;             /*   120     8=
 */
> >         /* --- cacheline 2 boundary (128 bytes) --- */
> >         struct file *              vm_file;              /*   128     8=
 */
> >         void *                     vm_private_data;      /*   136     8=
 */
> >         atomic_long_t              swap_readahead_info;  /*   144     8=
 */
> >         struct mempolicy *         vm_policy;            /*   152     8=
 */
> >         struct vma_numab_state *   numab_state;          /*   160     8=
 */
> >         struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     8=
 */
> >
> >         /* size: 176, cachelines: 3, members: 18 */
> >         /* sum members: 173, holes: 1, sum holes: 3 */
> >         /* forced alignments: 2 */
> >         /* last cacheline: 48 bytes */
> > } __attribute__((__aligned__(8)));
> >
> > AFTER
> > =3D=3D=3D=3D=3D
> > struct vm_area_struct {
> >         union {
> >                 struct {
> >                         long unsigned int vm_start;      /*     0     8=
 */
> >                         long unsigned int vm_end;        /*     8     8=
 */
> >                 };                                       /*     0    16=
 */
> >                 struct callback_head vm_rcu;             /*     0    16=
 */
> >         } __attribute__((__aligned__(8)));               /*     0    16=
 */
> >         struct mm_struct *         vm_mm;                /*    16     8=
 */
> >         pgprot_t                   vm_page_prot;         /*    24     8=
 */
> >         union {
> >                 const vm_flags_t   vm_flags;             /*    32     8=
 */
> >                 vm_flags_t         __vm_flags;           /*    32     8=
 */
> >         };                                               /*    32     8=
 */
> >         bool                       detached;             /*    40     1=
 */
> >
> >         /* XXX 7 bytes hole, try to pack */
> >
> >         long int                   vm_lock_seq;          /*    48     8=
 */
> >         struct vma_lock *          vm_lock;              /*    56     8=
 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         struct {
> >                 struct rb_node     rb;                   /*    64    24=
 */
> >                 long unsigned int  rb_subtree_last;      /*    88     8=
 */
> >         }                                                /*    64    32=
 */
> >         struct list_head           anon_vma_chain;       /*    96    16=
 */
> >         struct anon_vma *          anon_vma;             /*   112     8=
 */
> >         const struct vm_operations_struct  * vm_ops;     /*   120     8=
 */
> >         /* --- cacheline 2 boundary (128 bytes) --- */
> >         long unsigned int          vm_pgoff;             /*   128     8=
 */
> >         struct file *              vm_file;              /*   136     8=
 */
> >         void *                     vm_private_data;      /*   144     8=
 */
> >         atomic_long_t              swap_readahead_info;  /*   152     8=
 */
> >         struct mempolicy *         vm_policy;            /*   160     8=
 */
> >         struct vma_numab_state *   numab_state;          /*   168     8=
 */
> >         struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     8=
 */
> >
> >         /* size: 184, cachelines: 3, members: 18 */
> >         /* sum members: 177, holes: 1, sum holes: 7 */
> >         /* forced alignments: 2 */
> >         /* last cacheline: 56 bytes */
> > } __attribute__((__aligned__(8)));
> >
> >
> > > > >
> > > > > I didn't use __u64 outright to keep 32-bit architectures unaffect=
ed, but
> > > > > if it seems important enough, I have nothing against using __u64.
> > > > >
> > > > > Suggested-by: Jann Horn <jannh@google.com>
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > >
> > > > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >

