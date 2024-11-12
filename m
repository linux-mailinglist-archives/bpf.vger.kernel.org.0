Return-Path: <bpf+bounces-44661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4659C6351
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E60DB3B9D9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050DC21502C;
	Tue, 12 Nov 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoBG5WAJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D785B201270;
	Tue, 12 Nov 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435013; cv=none; b=YdD4b7HoGXWyIn44x4twoGwOo1bvuBcNTigZFPCNGvs5NMbBtFH39y0bSasypSnDoYmw8jCMFb2zLtUPcVBk2n9OEb3AXKNvnsof3hO2NV+gnOvDcvZTq6RMaUoyaO23dUYcTtyYEqZEWebiSy4HsH6Bpq/Ok4E0KiXGIYLj7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435013; c=relaxed/simple;
	bh=GGzoUqoXMI+EqsY+/Dk0p6y19AtBPLDir4gWMkKJLFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXYtW5HdZza3Q6mjhi+BErhNhqTJaa2DCrfFqgGR1XfYLoA8yvKMORySS4wc63n2pyl3R5qWbKS5L0zWRqW8xhaW5K7b3qWChsMa1yfuUb0wDH2fPulMjoAexhX9sqXspwzkJc/bSn/PsJh4eXVGpZNVnl4WoaTCKMmnick2+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoBG5WAJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7f3f1849849so4138310a12.1;
        Tue, 12 Nov 2024 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731435011; x=1732039811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6RgqeDH1wVQOoWDzTtohzRu8Xfe2E7upOTxZntw7p0=;
        b=FoBG5WAJ46rhpjFMquy294lzriMWAqhKu6cLos5VBKX3gZ49HRWNKMljVGWRAa8iBf
         0iv//uEiyM5sd4iP8fUyR0X+8qYFAo7zlNSLLdfQfNJWASwbLB3IwUXZZNwnmK3dhUtf
         ZS7dSUIXUe+pefq5mfrs27TZ9DL1ZEWUzne4sgdwIy/DF1GP67danqAVDpdt7udiWJKS
         uEbmRgTi2w21UigNFCNRHIssgoSurfiauCiAFmCse0w392n529DiP6CiOT5FG4hcBUtd
         4ZRYaWIaOTEveu8PFDT2lJpU7UTVNLlubTpVKLX5+LkrTk/EIvcP2eeI/yaCt097TT58
         3Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435011; x=1732039811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6RgqeDH1wVQOoWDzTtohzRu8Xfe2E7upOTxZntw7p0=;
        b=euw+ehuQ/lxylrbKrUihNAuHul/rLUR6FYUGsDV8VhunOxcazKQ9vp8ULvgj7i5VJ0
         VZ/BRw/6JoUSgsa532uocira3DoDYjYqDknGX6ionWk5v3WINjmSXv03sDpGXelfx3AI
         JDckxM6R/t8a5WnaBmdxFP7hEvX1/wiePA8RTm+COzL+6qY1HOT3WIHqdR0fAYmXpvAT
         Qrar+qYRNDfV+SeVMG7+YJWgVlYlVzdOvjg/MoN8buZmCJfQxnOVxrdZPI+mJHDE0751
         8pvpt9eDEPqfmJJ+3lZ6ahmWwKTL+C9hCkrvz+7qmQkkKSLzt4c3kOsFnmiRyX4QxVTD
         EPsw==
X-Forwarded-Encrypted: i=1; AJvYcCUoXldK80/tyAqoxFePPo4ylHvSL5kWsAttHx/qPfjS0Ij/f3X3yZ1OXTnV6nLVRWHb4tYGyAUEv9zPbRLb@vger.kernel.org, AJvYcCVzZY21RaVqnwzQNyhPuJQ4qhUYH2ga0RxLWcx3aarqe6iXVj0i0U+B+Wj3I8WANpPzCzQ=@vger.kernel.org, AJvYcCX8WXXNmrbLM47w8SLbwCoOD5CiQBKEXdUv0CzLVQMuAvtWw9vLLlYSn3yDcNpH9z8HblPRroV2BZc9v3oUy2dkTCWB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Xr8SHQGGA68HEcsYyHwcdd8ybA6g9OD95NySDjKLNCKTKq4q
	g4OJ1THYWZQ6zgh3hAHJU/m3eJe7Y/7Z4lt6BkUTQ+Ytf64LMb/hUr8BqDDgeiJK1oE2KZ/aZVJ
	wcBdLsz2n2Lr7YCcXCcqX9hnUnog=
X-Google-Smtp-Source: AGHT+IFl6MFFzHYffblN+GvtzC1b0S3nhKK4UXwxyrJe3p27dCMFRGYiwzk6JTdRx/iUsGAyUyP+x/dM/zCVqV+Dbtk=
X-Received: by 2002:a17:90b:350b:b0:2e8:f58e:27bb with SMTP id
 98e67ed59e1d1-2e9e4aa8cadmr4501330a91.8.1731435010936; Tue, 12 Nov 2024
 10:10:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-5-andrii@kernel.org>
 <20241112092816.cf5b0aa1ef10f50ce872892f@kernel.org> <CAJuCfpFPFRWrrMOQL2wbeTS0Y7eTc81TV3MX0cHaCuQ85foiag@mail.gmail.com>
In-Reply-To: <CAJuCfpFPFRWrrMOQL2wbeTS0Y7eTc81TV3MX0cHaCuQ85foiag@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Nov 2024 10:09:58 -0800
Message-ID: <CAEf4BzZEvHzDFryW52Em8gdVZJJDByM+1eVukOJn-ZUf8ukxiA@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 4/4] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
To: Suren Baghdasaryan <surenb@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, arnd@arndb.de, 
	richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, linmiaohe@huawei.com, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 5:05=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Nov 11, 2024 at 4:28=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel=
.org> wrote:
> >
> > On Sun, 27 Oct 2024 18:08:18 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > Given filp_cachep is marked SLAB_TYPESAFE_BY_RCU (and FMODE_BACKING
> > > files, a special case, now goes through RCU-delated freeing), we can
> > > safely access vma->vm_file->f_inode field locklessly under just
> > > rcu_read_lock() protection, which enables looking up uprobe from
> > > uprobes_tree completely locklessly and speculatively without the need=
 to
> > > acquire mmap_lock for reads. In most cases, anyway, assuming that the=
re
> > > are no parallel mm and/or VMA modifications. The underlying struct
> > > file's memory won't go away from under us (even if struct file can be
> > > reused in the meantime).
> > >
> > > We rely on newly added mmap_lock_speculation_{begin,end}() helpers to
> > > validate that mm_struct stays intact for entire duration of this
> > > speculation. If not, we fall back to mmap_lock-protected lookup.
> > > The speculative logic is written in such a way that it will safely
> > > handle any garbage values that might be read from vma or file structs=
.
> > >
> > > Benchmarking results speak for themselves.
> > >
> > > BEFORE (latest tip/perf/core)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > uprobe-nop            ( 1 cpus):    3.384 =C2=B1 0.004M/s  (  3.384M/=
s/cpu)
> > > uprobe-nop            ( 2 cpus):    5.456 =C2=B1 0.005M/s  (  2.728M/=
s/cpu)
> > > uprobe-nop            ( 3 cpus):    7.863 =C2=B1 0.015M/s  (  2.621M/=
s/cpu)
> > > uprobe-nop            ( 4 cpus):    9.442 =C2=B1 0.008M/s  (  2.360M/=
s/cpu)
> > > uprobe-nop            ( 5 cpus):   11.036 =C2=B1 0.013M/s  (  2.207M/=
s/cpu)
> > > uprobe-nop            ( 6 cpus):   10.884 =C2=B1 0.019M/s  (  1.814M/=
s/cpu)
> > > uprobe-nop            ( 7 cpus):    7.897 =C2=B1 0.145M/s  (  1.128M/=
s/cpu)
> > > uprobe-nop            ( 8 cpus):   10.021 =C2=B1 0.128M/s  (  1.253M/=
s/cpu)
> > > uprobe-nop            (10 cpus):    9.932 =C2=B1 0.170M/s  (  0.993M/=
s/cpu)
> > > uprobe-nop            (12 cpus):    8.369 =C2=B1 0.056M/s  (  0.697M/=
s/cpu)
> > > uprobe-nop            (14 cpus):    8.678 =C2=B1 0.017M/s  (  0.620M/=
s/cpu)
> > > uprobe-nop            (16 cpus):    7.392 =C2=B1 0.003M/s  (  0.462M/=
s/cpu)
> > > uprobe-nop            (24 cpus):    5.326 =C2=B1 0.178M/s  (  0.222M/=
s/cpu)
> > > uprobe-nop            (32 cpus):    5.426 =C2=B1 0.059M/s  (  0.170M/=
s/cpu)
> > > uprobe-nop            (40 cpus):    5.262 =C2=B1 0.070M/s  (  0.132M/=
s/cpu)
> > > uprobe-nop            (48 cpus):    6.121 =C2=B1 0.010M/s  (  0.128M/=
s/cpu)
> > > uprobe-nop            (56 cpus):    6.252 =C2=B1 0.035M/s  (  0.112M/=
s/cpu)
> > > uprobe-nop            (64 cpus):    7.644 =C2=B1 0.023M/s  (  0.119M/=
s/cpu)
> > > uprobe-nop            (72 cpus):    7.781 =C2=B1 0.001M/s  (  0.108M/=
s/cpu)
> > > uprobe-nop            (80 cpus):    8.992 =C2=B1 0.048M/s  (  0.112M/=
s/cpu)
> > >
> > > AFTER
> > > =3D=3D=3D=3D=3D
> > > uprobe-nop            ( 1 cpus):    3.534 =C2=B1 0.033M/s  (  3.534M/=
s/cpu)
> > > uprobe-nop            ( 2 cpus):    6.701 =C2=B1 0.007M/s  (  3.351M/=
s/cpu)
> > > uprobe-nop            ( 3 cpus):   10.031 =C2=B1 0.007M/s  (  3.344M/=
s/cpu)
> > > uprobe-nop            ( 4 cpus):   13.003 =C2=B1 0.012M/s  (  3.251M/=
s/cpu)
> > > uprobe-nop            ( 5 cpus):   16.274 =C2=B1 0.006M/s  (  3.255M/=
s/cpu)
> > > uprobe-nop            ( 6 cpus):   19.563 =C2=B1 0.024M/s  (  3.261M/=
s/cpu)
> > > uprobe-nop            ( 7 cpus):   22.696 =C2=B1 0.054M/s  (  3.242M/=
s/cpu)
> > > uprobe-nop            ( 8 cpus):   24.534 =C2=B1 0.010M/s  (  3.067M/=
s/cpu)
> > > uprobe-nop            (10 cpus):   30.475 =C2=B1 0.117M/s  (  3.047M/=
s/cpu)
> > > uprobe-nop            (12 cpus):   33.371 =C2=B1 0.017M/s  (  2.781M/=
s/cpu)
> > > uprobe-nop            (14 cpus):   38.864 =C2=B1 0.004M/s  (  2.776M/=
s/cpu)
> > > uprobe-nop            (16 cpus):   41.476 =C2=B1 0.020M/s  (  2.592M/=
s/cpu)
> > > uprobe-nop            (24 cpus):   64.696 =C2=B1 0.021M/s  (  2.696M/=
s/cpu)
> > > uprobe-nop            (32 cpus):   85.054 =C2=B1 0.027M/s  (  2.658M/=
s/cpu)
> > > uprobe-nop            (40 cpus):  101.979 =C2=B1 0.032M/s  (  2.549M/=
s/cpu)
> > > uprobe-nop            (48 cpus):  110.518 =C2=B1 0.056M/s  (  2.302M/=
s/cpu)
> > > uprobe-nop            (56 cpus):  117.737 =C2=B1 0.020M/s  (  2.102M/=
s/cpu)
> > > uprobe-nop            (64 cpus):  124.613 =C2=B1 0.079M/s  (  1.947M/=
s/cpu)
> > > uprobe-nop            (72 cpus):  133.239 =C2=B1 0.032M/s  (  1.851M/=
s/cpu)
> > > uprobe-nop            (80 cpus):  142.037 =C2=B1 0.138M/s  (  1.775M/=
s/cpu)
> > >
> > > Previously total throughput was maxing out at 11mln/s, and gradually
> > > declining past 8 cores. With this change, it now keeps growing with e=
ach
> > > added CPU, reaching 142mln/s at 80 CPUs (this was measured on a 80-co=
re
> > > Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz).
> > >
> >
> > Looks good to me, except one question below.
> >
> > > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/events/uprobes.c | 45 +++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 290c445768fa..efcd62f7051d 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -2074,6 +2074,47 @@ static int is_trap_at_addr(struct mm_struct *m=
m, unsigned long vaddr)
> > >       return is_trap_insn(&opcode);
> > >  }
> > >
> > > +static struct uprobe *find_active_uprobe_speculative(unsigned long b=
p_vaddr)
> > > +{
> > > +     struct mm_struct *mm =3D current->mm;
> > > +     struct uprobe *uprobe =3D NULL;
> > > +     struct vm_area_struct *vma;
> > > +     struct file *vm_file;
> > > +     loff_t offset;
> > > +     unsigned int seq;
> > > +
> > > +     guard(rcu)();
> > > +
> > > +     if (!mmap_lock_speculation_begin(mm, &seq))
> > > +             return NULL;
> > > +
> > > +     vma =3D vma_lookup(mm, bp_vaddr);
> > > +     if (!vma)
> > > +             return NULL;
> > > +
> > > +     /*
> > > +      * vm_file memory can be reused for another instance of struct =
file,
> > > +      * but can't be freed from under us, so it's safe to read field=
s from
> > > +      * it, even if the values are some garbage values; ultimately
> > > +      * find_uprobe_rcu() + mmap_lock_speculation_end() check will e=
nsure
> > > +      * that whatever we speculatively found is correct
> >
> > If vm_file is a garbage value, may `vm_file->f_inode` access be dangero=
us?
> >
> > > +      */
> > > +     vm_file =3D READ_ONCE(vma->vm_file);
> > > +     if (!vm_file)
> > > +             return NULL;
> > > +
> > > +     offset =3D (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - =
vma->vm_start);
> > > +     uprobe =3D find_uprobe_rcu(vm_file->f_inode, offset);
> >                                        ^^^^ Here
> >
> > if it only stores vm_file or NULL, there's no problem.
>
> IIRC correctly, vma->vm_file is RCU-safe and we are in the read RCU
> section, so it should not contain a garbage value.

Correct. vm_file itself can be either TYPESAFE_BY_RCU for normal
files, or properly RCU protected for FMODE_BACKING ones. Either way,
there is some correct struct file pointed to, and so all this is valid
and won't dereference invalid memory.

>
> >
> > Thank you,
> >
> > > +     if (!uprobe)
> > > +             return NULL;
> > > +
> > > +     /* now double check that nothing about MM changed */
> > > +     if (!mmap_lock_speculation_end(mm, seq))
> > > +             return NULL;
> > > +
> > > +     return uprobe;
> > > +}
> > > +
> > >  /* assumes being inside RCU protected region */
> > >  static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr,=
 int *is_swbp)
> > >  {
> > > @@ -2081,6 +2122,10 @@ static struct uprobe *find_active_uprobe_rcu(u=
nsigned long bp_vaddr, int *is_swb
> > >       struct uprobe *uprobe =3D NULL;
> > >       struct vm_area_struct *vma;
> > >
> > > +     uprobe =3D find_active_uprobe_speculative(bp_vaddr);
> > > +     if (uprobe)
> > > +             return uprobe;
> > > +
> > >       mmap_read_lock(mm);
> > >       vma =3D vma_lookup(mm, bp_vaddr);
> > >       if (vma) {
> > > --
> > > 2.43.5
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

