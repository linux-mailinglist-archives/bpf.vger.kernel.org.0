Return-Path: <bpf+bounces-39480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84472973C6C
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66D31C249FE
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D93A1A071C;
	Tue, 10 Sep 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkxX579T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11119E80F
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982799; cv=none; b=thYQLTGEmJdvOoIQyqQYpn3LP6rSJFXhqWlytlfItSdNBg6uyjbF7bLoCfTsr/aZ3wa3Okxm/uun1dGXy1JWfeCXy/nV0RXDx/JBp2jxL/S7CB1OzFGYGKzw92JTPD5CGEIs5xjASwEoDh9zdiABvA7TcXkIA/PwJgY+P0HBQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982799; c=relaxed/simple;
	bh=Ns74kTojtvJ3PU+5k7XOrtvLmnYWyxeZra3a7dDi8iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D32p+ka9KdAMR0EeTYF1X8EFCk0fbxtNZ20SWvSz5StmQ3ytV4wL7/HsrbV+PI5NW+sgNLbpa792WI1QCIe3WRTit8b+5yA/hdaI7kmo/P9Kq9Ol+62rZp0iFG+DemwtH0aD0LSegjq/E2B6+vgjLxnT7wNu4lIzQqf/FDynEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkxX579T; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so12330a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725982796; x=1726587596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XmuAJaJABZEw22g1YelxW3d7dMoKbStEXHVKcdE10Q=;
        b=KkxX579TxaUCdpv3p/X3uPjIhH+CxHKAgcQIGs9HnpX0OOrMynUY8OtofIpDB5eUf0
         azEtEdzkTPYOxdFxS7om6lDUN2d5fa8UnQE62D8Qzwmyo7XeeLEWNL7OsDNMpov/si5P
         GcLFlkaBy143E0ZadbhJ4PNwx9TBRLldISeOvgYzeFozDNhctNN5X0HEPA7VzqRgNYft
         x3OBlWBbC4rP1JqdYu7wfcEXGI+G0lWPhDIUnClihkR2dDHKx9Ut8a+DHw493XzcnZly
         FlEPJbn5X66cJSevugWXVwdxr4s6g4bdcYd9iXP6PpzIq57wsGgyv8rv8YvlTtWkW9xa
         ekpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982796; x=1726587596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XmuAJaJABZEw22g1YelxW3d7dMoKbStEXHVKcdE10Q=;
        b=wC6fGVnBGZAMkcLYDWdYuXPI9nKBdl5b3GZgKbfFQSIR6VlP27ucooEQQVCMF9qKoL
         GuuVq1P3QaQo4Y/oYbcwqUD3H8Lezl9vnkBQg3tDhw3R65/shFbLjzsdQLnIVgNVUpxQ
         l5YRtAUyojgLGSPAh3m021lQ+GIn3vlTAG0OswJeTK+2HQYBJUXo1vApZ/EYMSxfV54A
         o3VPpmRNPYWIdV5v5NlhyjjdSfzVQVo6JhIS+bldnc0WMEwjmgq35PxuDpXyj546zyt+
         RbEp1uJqhg1dDOUj2ohOSMmJnDejy70lngMBhMPmTimn2jk/aR4/meNeLxJCaIknu14O
         JTyw==
X-Forwarded-Encrypted: i=1; AJvYcCWk4AmB+QAbAtP+WME7aRhZXANcxwTryNhdu4dxV8T7wuLzWP0+KiDd2X6Iv0LgLz73Ip0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGK0zPkUCpndzM7ut5gQSgNEaYljwG12/Sx+CHftB/3qDxBYZM
	TKSNFSdELBQZDJKGC5Ek3O8InKm4rG/Rwc5h+GQ6/GB5MWN/SWzxUPV4Gr18DI4RPkhrjQSWs2k
	G67u4faW1Nvj39WB68gdTXUlW0wpyfH0zoPE3
X-Google-Smtp-Source: AGHT+IHa5P3FNcyxK3dfRD8l0hNbFtul+gz/5r6bBqUtFkIT1a2ttnvtee4Q932fZkZ5xf7hLJPLJm4n3vKcBRhcD4g=
X-Received: by 2002:a05:6402:35d4:b0:5c3:c2fc:8de6 with SMTP id
 4fb4d7f45d1cf-5c4040d4f38mr311527a12.3.1725982795248; Tue, 10 Sep 2024
 08:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com> <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 17:39:19 +0200
Message-ID: <CAG48ez1d9tU7-QeRSjRuxovG-jjNAwJ8B_G2jd43_etYMUPV6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: surenb@google.com, Liam Howlett <liam.howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, brauner@kernel.org, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:29=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > > +static struct uprobe *find_active_uprobe_speculative(unsigned long b=
p_vaddr)
> > > +{
> > > +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSH=
ARE;
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct uprobe *uprobe;
> > > +       struct vm_area_struct *vma;
> > > +       struct file *vm_file;
> > > +       struct inode *vm_inode;
> > > +       unsigned long vm_pgoff, vm_start;
> > > +       int seq;
> > > +       loff_t offset;
> > > +
> > > +       if (!mmap_lock_speculation_start(mm, &seq))
> > > +               return NULL;
> > > +
> > > +       rcu_read_lock();
> > > +
> > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > +       if (!vma)
> > > +               goto bail;
> > > +
> > > +       vm_file =3D data_race(vma->vm_file);
> >
> > A plain "data_race()" says "I'm fine with this load tearing", but
> > you're relying on this load not tearing (since you access the vm_file
> > pointer below).
> > You're also relying on the "struct file" that vma->vm_file points to
> > being populated at this point, which means you need CONSUME semantics
> > here, which READ_ONCE() will give you, and something like RELEASE
> > semantics on any pairing store that populates vma->vm_file, which
> > means they'd all have to become something like smp_store_release()).
>
> vma->vm_file should be set in VMA before it is installed and is never
> modified afterwards, isn't that the case? So maybe no extra barrier
> are needed and READ_ONCE() would be enough.

Ah, right, I'm not sure what I was thinking there.

I... guess you only _really_ need the READ_ONCE() if something can
actually ever change the ->vm_file pointer, otherwise just a plain
load with no annotation whatsoever would be good enough? I'm fairly
sure nothing can ever change the ->vm_file pointer of a live VMA, and
I think _currently_ it looks like nothing will NULL out the ->vm_file
pointer on free either... though that last part is probably not
something you should rely on...

