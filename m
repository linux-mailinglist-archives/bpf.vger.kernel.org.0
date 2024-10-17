Return-Path: <bpf+bounces-42332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0A9A2DFC
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 21:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D4F1F24B65
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 19:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF315227B84;
	Thu, 17 Oct 2024 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csUlwB3l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC91DE4D3
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 19:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194182; cv=none; b=r5Sec560W/b3/oW1eCuKXHwWnYmC3cNT0r4cOrMyfztwABPFhte+ShS6SQMYqPau50E7w5bExT4IXKhCwNcB3z19IZGFmWtiSwW72POkIRSFpU6apgjwBH9ukVEUSqLr4k5VsbqTIKaPdYxAzCp33MegKXv6h5KCLutDjyWRUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194182; c=relaxed/simple;
	bh=wTYCQ5+Z6PA1QhRLYmE0aBKwBlAide4FpnY1jvy2gh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWU5D1C2qOslYwB8GuTeb/X427wy2W6+SFfXxNwqOY7gYIpLJmRyGyrZrh0hy4+FBAWgCjtpUDyEQOC/IN4+Y04/IQWvt+hQvK3R/gLvQFj6fYwtcmVRJvt6FfT8mEsa2jOmWrXv5Eo5zhuFeMResdLy0tyWJ6SRBtLB4rGWTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csUlwB3l; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4608dddaa35so62331cf.0
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729194176; x=1729798976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmPmxgsJ9wsiU3T6ESSH/Le/i/U9lbL5KdA1wgnhHYk=;
        b=csUlwB3lkKWFdn1NnCHqHy6R5xjU6/fpPNiK2Bv008wSR3D1ddS6R0luc7PiifWjdh
         Gs2hHY+VehAMEvaZPnQbUIlbJfdpjjypPSWorPEYf7jYJoRjai7OJhqDYMp+pqF3Nqkl
         fSEFZh/YIqwVsSmyhKUrs0aD/rcfvAwLx/+81S0+ub0L6RJboGcRfn6Maaf8DEinrlMb
         h+Duc3tOuscIDS3B/gH2tiodsY/rdpNON9MGtakwoTC0PEC/G93YrFsr0mAvrm8RR7Ic
         fhdI8xzI0HTjSxcoG7Rp8qHFAHjCBrengHNrv06R8U+6jCSrS8Dp6s0NYusJbAb/me7D
         lIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729194176; x=1729798976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmPmxgsJ9wsiU3T6ESSH/Le/i/U9lbL5KdA1wgnhHYk=;
        b=rhxgznYkksLRusJVMN+7r3TL6HHAp+iJAxiICN7TndsAcbehqY4R1Hl0QhWgJm7f4p
         4LLldLRVw3faCEFq5Zv7UWmwfcH0BftfBqkWCp/IgtfAQWBV7jlhF+Chwc+jIdCa57HA
         33ZyLLA57DnGfu7w67S/me7O8FFwk+761OmDhkrM4cJHTyujestAo7EEZWZ73R1K6VHY
         knt4qaFDe4ggxIqmp8z648Mc95/kY+qqZ9+yupU/5fxwDnxwj9M4oNVigJPHol89u6nD
         6Xp5G5Co5L3Z4b8fK5ac2Uo3xAeQcSRKuXGSml8lp00+ukD46+CbB5RNBIogxYR74hY7
         EbHw==
X-Forwarded-Encrypted: i=1; AJvYcCVtjXALIABlauMjhVhj3d67GNyDzm85wMi27Q/Snv5c7azzVaNVn9KECoJn5POcPfs7/ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BInjWWeacP+lXIaZWKzg2UNqlELgO1PHpoeseJtyF3RVVJan
	0NVrIjxjF4s7LlMC7Z/kqtSKhXJX2ZC2bWyOgpQ0KMHY6ZoKo/ewOYOTGwOTYVOQ91E99S3P6Es
	zCVRG/+QQXa8QKiFJWEz/B+nhcswG40JpUqkBTJAa4rRwEBPWAJjG
X-Google-Smtp-Source: AGHT+IFyzZKGqloaMJLDqC8BPSIt8wiOEv39Om9PqwGTXxDEcr6TbeLDGrSOdHvvf+bo6p+5daaGQOyTPHDjdm/zcRU=
X-Received: by 2002:ac8:58d5:0:b0:460:3f4a:40a1 with SMTP id
 d75a77b69052e-460ada02566mr447411cf.13.1729194175847; Thu, 17 Oct 2024
 12:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-3-andrii@kernel.org>
 <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
 <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com> <CAEf4BzbOXrbixQA=fpg17QPBv+4myAQrHvCX42hVye0Ww9W2Aw@mail.gmail.com>
In-Reply-To: <CAEf4BzbOXrbixQA=fpg17QPBv+4myAQrHvCX42hVye0Ww9W2Aw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 17 Oct 2024 12:42:43 -0700
Message-ID: <CAJuCfpHGjkPXMGsttb7bMVr0R1Crv8J_zw5_suj+1nCaT=1fBw@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Thu, Oct 17, 2024 at 11:55=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 16, 2024 at 7:02=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> > > > To increase mm->mm_lock_seq robustness, switch it from int to long,=
 so
> > > > that it's a 64-bit counter on 64-bit systems and we can stop worryi=
ng
> > > > about it wrapping around in just ~4 billion iterations. Same goes f=
or
> > > > VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
> >
> > vm_lock_seq does not need to be long but for consistency I guess that
>
> How come, we literally assign vm_lock_seq from mm_lock_seq and do
> direct comparisons. They have to be exactly the same type, no?

Not necessarily. vm_lock_seq is a snapshot of the mm_lock_seq but it
does not have to be a "complete" snapshot. Just something that has a
very high probability of identifying a match and a rare false positive
is not a problem (see comment in
https://elixir.bootlin.com/linux/v6.11.3/source/include/linux/mm.h#L678).
So, something like this for taking and comparing a snapshot would do:

vma->vm_lock_seq =3D (unsigned int)mm->mm_lock_seq;
if (vma->vm_lock_seq =3D=3D (unsigned int)mm->mm_lock_seq)

>
> > makes sense. While at it, can you please change these seq counters to
> > be unsigned?
>
> There is `vma->vm_lock_seq =3D -1;` in kernel/fork.c, should it be
> switched to ULONG_MAX then? In general, unless this is critical for
> correctness, I'd very much like stuff like this to be done in the mm
> tree afterwards, but it seems trivial enough, so if you insist I'll do
> it.

Yeah, ULONG_MAX should work fine here. vma->vm_lock_seq is initialized
to -1 to avoid false initial match with mm->mm_lock_seq which is
initialized to 0. As I said, a false match is not a problem but if we
can avoid it, that's better.

>
> > Also, did you check with pahole if the vm_area_struct layout change
> > pushes some members into a difference cacheline or creates new gaps?
> >
>
> Just did. We had 3 byte hole after `bool detached;`, it now grew to 7
> bytes (so +4) and then vm_lock_seq itself is now 8 bytes (so +4),
> which now does push rb and rb_subtree_last into *THE SAME* cache line
> (which sounds like an improvement to me). vm_lock_seq and vm_lock stay
> in the same cache line. vm_pgoff and vm_file are now in the same cache
> line, and given they are probably always accessed together, seems like
> a good accidental change as well. See below pahole outputs before and
> after.

Ok, sounds good to me. Looks like keeping both sequence numbers 64bit
is not an issue. Changing them to unsigned would be nice and trivial
but I don't insist. You can add:

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> That singular detached bool looks like a complete waste, tbh. Maybe it
> would be better to roll it into vm_flags and save 8 bytes? (not that I
> want to do those mm changes in this patch set, of course...).
> vm_area_struct is otherwise nicely tightly packed.
>
> tl;dr, seems fine, and detached would be best to get rid of, if
> possible (but that's a completely separate thing)

Yeah, I'll take a look at that. Thanks!

>
> BEFORE
> =3D=3D=3D=3D=3D=3D
> struct vm_area_struct {
>         union {
>                 struct {
>                         long unsigned int vm_start;      /*     0     8 *=
/
>                         long unsigned int vm_end;        /*     8     8 *=
/
>                 };                                       /*     0    16 *=
/
>                 struct callback_head vm_rcu;             /*     0    16 *=
/
>         } __attribute__((__aligned__(8)));               /*     0    16 *=
/
>         struct mm_struct *         vm_mm;                /*    16     8 *=
/
>         pgprot_t                   vm_page_prot;         /*    24     8 *=
/
>         union {
>                 const vm_flags_t   vm_flags;             /*    32     8 *=
/
>                 vm_flags_t         __vm_flags;           /*    32     8 *=
/
>         };                                               /*    32     8 *=
/
>         bool                       detached;             /*    40     1 *=
/
>
>         /* XXX 3 bytes hole, try to pack */
>
>         int                        vm_lock_seq;          /*    44     4 *=
/
>         struct vma_lock *          vm_lock;              /*    48     8 *=
/
>         struct {
>                 struct rb_node     rb;                   /*    56    24 *=
/
>                 /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago -=
-- */
>                 long unsigned int  rb_subtree_last;      /*    80     8 *=
/
>         }                                                /*    56    32 *=
/
>         struct list_head           anon_vma_chain;       /*    88    16 *=
/
>         struct anon_vma *          anon_vma;             /*   104     8 *=
/
>         const struct vm_operations_struct  * vm_ops;     /*   112     8 *=
/
>         long unsigned int          vm_pgoff;             /*   120     8 *=
/
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct file *              vm_file;              /*   128     8 *=
/
>         void *                     vm_private_data;      /*   136     8 *=
/
>         atomic_long_t              swap_readahead_info;  /*   144     8 *=
/
>         struct mempolicy *         vm_policy;            /*   152     8 *=
/
>         struct vma_numab_state *   numab_state;          /*   160     8 *=
/
>         struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     8 *=
/
>
>         /* size: 176, cachelines: 3, members: 18 */
>         /* sum members: 173, holes: 1, sum holes: 3 */
>         /* forced alignments: 2 */
>         /* last cacheline: 48 bytes */
> } __attribute__((__aligned__(8)));
>
> AFTER
> =3D=3D=3D=3D=3D
> struct vm_area_struct {
>         union {
>                 struct {
>                         long unsigned int vm_start;      /*     0     8 *=
/
>                         long unsigned int vm_end;        /*     8     8 *=
/
>                 };                                       /*     0    16 *=
/
>                 struct callback_head vm_rcu;             /*     0    16 *=
/
>         } __attribute__((__aligned__(8)));               /*     0    16 *=
/
>         struct mm_struct *         vm_mm;                /*    16     8 *=
/
>         pgprot_t                   vm_page_prot;         /*    24     8 *=
/
>         union {
>                 const vm_flags_t   vm_flags;             /*    32     8 *=
/
>                 vm_flags_t         __vm_flags;           /*    32     8 *=
/
>         };                                               /*    32     8 *=
/
>         bool                       detached;             /*    40     1 *=
/
>
>         /* XXX 7 bytes hole, try to pack */
>
>         long int                   vm_lock_seq;          /*    48     8 *=
/
>         struct vma_lock *          vm_lock;              /*    56     8 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         struct {
>                 struct rb_node     rb;                   /*    64    24 *=
/
>                 long unsigned int  rb_subtree_last;      /*    88     8 *=
/
>         }                                                /*    64    32 *=
/
>         struct list_head           anon_vma_chain;       /*    96    16 *=
/
>         struct anon_vma *          anon_vma;             /*   112     8 *=
/
>         const struct vm_operations_struct  * vm_ops;     /*   120     8 *=
/
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         long unsigned int          vm_pgoff;             /*   128     8 *=
/
>         struct file *              vm_file;              /*   136     8 *=
/
>         void *                     vm_private_data;      /*   144     8 *=
/
>         atomic_long_t              swap_readahead_info;  /*   152     8 *=
/
>         struct mempolicy *         vm_policy;            /*   160     8 *=
/
>         struct vma_numab_state *   numab_state;          /*   168     8 *=
/
>         struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     8 *=
/
>
>         /* size: 184, cachelines: 3, members: 18 */
>         /* sum members: 177, holes: 1, sum holes: 7 */
>         /* forced alignments: 2 */
>         /* last cacheline: 56 bytes */
> } __attribute__((__aligned__(8)));
>
>
> > > >
> > > > I didn't use __u64 outright to keep 32-bit architectures unaffected=
, but
> > > > if it seems important enough, I have nothing against using __u64.
> > > >
> > > > Suggested-by: Jann Horn <jannh@google.com>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >

