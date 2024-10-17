Return-Path: <bpf+bounces-42330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C459A2CC8
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 20:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46662B22037
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF50219C86;
	Thu, 17 Oct 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz0Tk4Ny"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504C1FC7E9;
	Thu, 17 Oct 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191353; cv=none; b=rGvkdjVR+YY2MzLc/rZKBpzYapQq2TxJRfF0D15SES072s1mMC3NaTpvbyr6hQvsySY8QM3rmoZMxixivCGxkPuyJUa3u945HOeTlfxpE/VMFVUDAd5viiSVdMKatLuZ1iUpIBSZ+3GE+iEFzsKHElWanQQk87pQAf+K4M8Jgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191353; c=relaxed/simple;
	bh=qMyss1VcsCqXR3v2FJfORrVe+pGagFza/3h51H/c8gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMNTS3ETdte8g6tW7THro+i89VZ7+/nkAj3xVOwjY53NLpr7RiuS4kRqjSylcu5L66FG8yqQguGUfaXQ/c0YfQ7au8wG/ETQj9xH4+Tcx/K/Aou0NJnsJt7KADZYXNNfubzsbF/bqII8qfqwimSrPl8fMWLAloVMyYpCEeAAsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz0Tk4Ny; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e6f085715so1024373b3a.2;
        Thu, 17 Oct 2024 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729191348; x=1729796148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCbiAckxU+1LrXu7YNeHArlba++n1QiAkjUcgAqY7TM=;
        b=Rz0Tk4NyHPEH2AH+whr2p0xPWN28ghw03rXRAYWF2kYUpJxq6snR2jnIgCkJxVcKaF
         ENSlHAhKdLGOZEvzbPnuH4BGN4hOCRUd3pHCMTyEoAja3Tj/Gp8AeuhsaKQah1rYnZjI
         eZtKWtAkqW+p/iJQsvD5dS946Va9Ab4tPjzBPSo8cUKETw45snMBORXqjVG7GOrJv5Tb
         QWXS6iARrEI7uxaPVv74c1spBR5IV3IJksbzc7N2nIMDI2fdnNsUb7LWOfzslUtSri/K
         jcufxSCkNKBNBNBq0/xcGOHNpriO39n+VAcw0p28ZaZ8LKe6L2Ws8lXr5CW1BO2Lz/JP
         ms/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191348; x=1729796148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCbiAckxU+1LrXu7YNeHArlba++n1QiAkjUcgAqY7TM=;
        b=f/uliCe4/jsJIZ5gNxMlhvu+skIjpt/re3xmfWFWfqEe3RBPQJhcczMThYrYLTdbgG
         jqwAbSv4ELACrxjIT89Ri/RvXiZ7OItxxt2qqXxOwplrt4/E1XKMSaKp1fpK8xTESQ2q
         qyGejGRK2GHJiSr7KoEmcDDBHq33WBKmUeigmx88LDvVEfEEslSgah5SbJLqnCR6Av67
         2PqB1h85TB07hZ4Njad76dVeEudup4TdWxU/Nj44ZKdWHgam/fe02SrtB2wu5kRmrUus
         h3tBgB06ggk87cAkqjWi52/nY3aPJ+nAETTDzNfj/pQ1MfWs+hbQFq0X7gDMYd1sc05v
         psOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBKjvhszFbFM2Obzs/cjkw0ptnHaS0jFOzQdlyDOav4ej3TGjqzoHjt7mkFNtFfrTOiHgrI24DhhMc8c1X@vger.kernel.org, AJvYcCW14dkOm3QHWpli/i7Dzyhm9kiy47qyBwLHQfJa+I+0WIZwVflpVjOv9skE7PLJHo1BHUU=@vger.kernel.org, AJvYcCXQnHjrGkef7VnSZdeC6CNLjbdmiFq0QrM5RtbXBguejvGbdPp1QWJUsaUALI/1qEQuxWT9SdMPAVT21QhQbHHkejQs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmo1auM8UciaMw0hiI3OBch37zIVFvXWEAEznWmzNWCY1912tV
	nQmTD+uegX1+dwicZR0zchqh7BgK61uHgp3G6nA1i8GpMbi18GSMTgY9Q/AlMnAePQl9+9tQ4Qt
	GGVDRsv1wKGQEDw0pJOQJlGiXnc0=
X-Google-Smtp-Source: AGHT+IGCdpUfDxA6zAdi5OINLOxawquAP3ymgOYackxEhc10GVlIEJPFiB03uSJkD6QlvJghlEnn0pw9AdKdAXMwGgo=
X-Received: by 2002:a05:6a00:1250:b0:71e:fb4:6c98 with SMTP id
 d2e1a72fcca58-71e4c1cfc05mr35446834b3a.23.1729191347929; Thu, 17 Oct 2024
 11:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-3-andrii@kernel.org>
 <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy> <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFpPvBLgZNxwHuT-kLsvBABWyK9H6tFCmsTCtVpOxET6Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Oct 2024 11:55:35 -0700
Message-ID: <CAEf4BzbOXrbixQA=fpg17QPBv+4myAQrHvCX42hVye0Ww9W2Aw@mail.gmail.com>
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

On Wed, Oct 16, 2024 at 7:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> >
> > On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> > > To increase mm->mm_lock_seq robustness, switch it from int to long, s=
o
> > > that it's a 64-bit counter on 64-bit systems and we can stop worrying
> > > about it wrapping around in just ~4 billion iterations. Same goes for
> > > VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
>
> vm_lock_seq does not need to be long but for consistency I guess that

How come, we literally assign vm_lock_seq from mm_lock_seq and do
direct comparisons. They have to be exactly the same type, no?

> makes sense. While at it, can you please change these seq counters to
> be unsigned?

There is `vma->vm_lock_seq =3D -1;` in kernel/fork.c, should it be
switched to ULONG_MAX then? In general, unless this is critical for
correctness, I'd very much like stuff like this to be done in the mm
tree afterwards, but it seems trivial enough, so if you insist I'll do
it.

> Also, did you check with pahole if the vm_area_struct layout change
> pushes some members into a difference cacheline or creates new gaps?
>

Just did. We had 3 byte hole after `bool detached;`, it now grew to 7
bytes (so +4) and then vm_lock_seq itself is now 8 bytes (so +4),
which now does push rb and rb_subtree_last into *THE SAME* cache line
(which sounds like an improvement to me). vm_lock_seq and vm_lock stay
in the same cache line. vm_pgoff and vm_file are now in the same cache
line, and given they are probably always accessed together, seems like
a good accidental change as well. See below pahole outputs before and
after.

That singular detached bool looks like a complete waste, tbh. Maybe it
would be better to roll it into vm_flags and save 8 bytes? (not that I
want to do those mm changes in this patch set, of course...).
vm_area_struct is otherwise nicely tightly packed.

tl;dr, seems fine, and detached would be best to get rid of, if
possible (but that's a completely separate thing)

BEFORE
=3D=3D=3D=3D=3D=3D
struct vm_area_struct {
        union {
                struct {
                        long unsigned int vm_start;      /*     0     8 */
                        long unsigned int vm_end;        /*     8     8 */
                };                                       /*     0    16 */
                struct callback_head vm_rcu;             /*     0    16 */
        } __attribute__((__aligned__(8)));               /*     0    16 */
        struct mm_struct *         vm_mm;                /*    16     8 */
        pgprot_t                   vm_page_prot;         /*    24     8 */
        union {
                const vm_flags_t   vm_flags;             /*    32     8 */
                vm_flags_t         __vm_flags;           /*    32     8 */
        };                                               /*    32     8 */
        bool                       detached;             /*    40     1 */

        /* XXX 3 bytes hole, try to pack */

        int                        vm_lock_seq;          /*    44     4 */
        struct vma_lock *          vm_lock;              /*    48     8 */
        struct {
                struct rb_node     rb;                   /*    56    24 */
                /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago ---=
 */
                long unsigned int  rb_subtree_last;      /*    80     8 */
        }                                                /*    56    32 */
        struct list_head           anon_vma_chain;       /*    88    16 */
        struct anon_vma *          anon_vma;             /*   104     8 */
        const struct vm_operations_struct  * vm_ops;     /*   112     8 */
        long unsigned int          vm_pgoff;             /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        struct file *              vm_file;              /*   128     8 */
        void *                     vm_private_data;      /*   136     8 */
        atomic_long_t              swap_readahead_info;  /*   144     8 */
        struct mempolicy *         vm_policy;            /*   152     8 */
        struct vma_numab_state *   numab_state;          /*   160     8 */
        struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     8 */

        /* size: 176, cachelines: 3, members: 18 */
        /* sum members: 173, holes: 1, sum holes: 3 */
        /* forced alignments: 2 */
        /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

AFTER
=3D=3D=3D=3D=3D
struct vm_area_struct {
        union {
                struct {
                        long unsigned int vm_start;      /*     0     8 */
                        long unsigned int vm_end;        /*     8     8 */
                };                                       /*     0    16 */
                struct callback_head vm_rcu;             /*     0    16 */
        } __attribute__((__aligned__(8)));               /*     0    16 */
        struct mm_struct *         vm_mm;                /*    16     8 */
        pgprot_t                   vm_page_prot;         /*    24     8 */
        union {
                const vm_flags_t   vm_flags;             /*    32     8 */
                vm_flags_t         __vm_flags;           /*    32     8 */
        };                                               /*    32     8 */
        bool                       detached;             /*    40     1 */

        /* XXX 7 bytes hole, try to pack */

        long int                   vm_lock_seq;          /*    48     8 */
        struct vma_lock *          vm_lock;              /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct {
                struct rb_node     rb;                   /*    64    24 */
                long unsigned int  rb_subtree_last;      /*    88     8 */
        }                                                /*    64    32 */
        struct list_head           anon_vma_chain;       /*    96    16 */
        struct anon_vma *          anon_vma;             /*   112     8 */
        const struct vm_operations_struct  * vm_ops;     /*   120     8 */
        /* --- cacheline 2 boundary (128 bytes) --- */
        long unsigned int          vm_pgoff;             /*   128     8 */
        struct file *              vm_file;              /*   136     8 */
        void *                     vm_private_data;      /*   144     8 */
        atomic_long_t              swap_readahead_info;  /*   152     8 */
        struct mempolicy *         vm_policy;            /*   160     8 */
        struct vma_numab_state *   numab_state;          /*   168     8 */
        struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     8 */

        /* size: 184, cachelines: 3, members: 18 */
        /* sum members: 177, holes: 1, sum holes: 7 */
        /* forced alignments: 2 */
        /* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));


> > >
> > > I didn't use __u64 outright to keep 32-bit architectures unaffected, =
but
> > > if it seems important enough, I have nothing against using __u64.
> > >
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>

