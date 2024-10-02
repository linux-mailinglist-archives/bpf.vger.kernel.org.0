Return-Path: <bpf+bounces-40788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C398E3DE
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 22:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAA9B20D47
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCBB216A17;
	Wed,  2 Oct 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnnH/Uim"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8731946B9;
	Wed,  2 Oct 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899390; cv=none; b=PtdG2JjIaRsUHlG76U8GLm41sWRxCX8fRtu3is6mD2j3dYhm+PLJAztXd78gMbZsKzHNUZ+6Na+wfGzvwarsV5KsiyB2O24wKguuVHsTg5bwHyI7g9QiSrsu9FajRI1E/KXrYq3AvxM0uitKNlIu4iU6GrK4MyA+RlmPFGCQ/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899390; c=relaxed/simple;
	bh=kVG5FiqtGznQH5mlDfqZJIZJextSvCeF6BHOUvrQN/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XK9JGQZZnOnjmZx4G0VgBiYgqHKOrkhVhQii6daCE5qgOO4gh50xAPw6qRFzjeGhgl4isPBhpYb+uNOuQe2F6NpXLctqVEKJlDvmac15lr3/ijnIABt0xl7/cPot7/DU1U/OW+5L/1tUNt87ckdyCi5Uk12pYGhtyrEGzqFobZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnnH/Uim; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b0b2528d8so1544305ad.2;
        Wed, 02 Oct 2024 13:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727899388; x=1728504188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiRp+YwmdyiMme5vt1vRR+VBvbe+ehGGnDWss9t/xgA=;
        b=EnnH/UimL1lW9ZuCWc1RKUPY3IJC5Ph8t6ZJIXgE6a0HMGUZNhVJonyiEA0K1E8GPf
         PsjqsCF/60SWwDRQdLPricVCIbDFkiImlbwj2Q8WHcCE9UCcd+yg76R0iuN63+VJqnWo
         teTjCh8agpRJEXD8EWrcFI9rLvWlAE5e9PIZ6Kva5OjlghwAwCnp0Fl5bySax6B7QZHe
         11XitfUPkhIuhZtAVjUzEJ8FUihvAbd/SThX9JUVFSGJUlicPlGp3EZSKsbNIq8k6Ywr
         lf37c93UFNyN1+XUqzOWuzoo1I0xgjAOlydyz5X4aMA6t0B4LDjUZ2kzgYYZvOfw52i2
         HM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899388; x=1728504188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiRp+YwmdyiMme5vt1vRR+VBvbe+ehGGnDWss9t/xgA=;
        b=UhuX2n7hA5eRnDcBYyk9DtdIpzgOqAyQSq/EQHCCljz7eb9+/KS/suV0n1UHbna+72
         9+IDJnyExifSmub7K1S2so1ga/8ngpCLt2ln7bWKpJIOqT0z2DMKSkrnlAA8pDAfUtz7
         R1csKVh2AHUHCk0/1NlVZ84rtcyinJRpvA4KEcvsXvGGLwJZ38llnQH2UyskvYJKIVdf
         LPZ3IAoRf+ErGoVyOlxUcdaILjwiHqe7lHixMmt7tJHS2DJHxaQMzyWP1WzC8eE0O95D
         t0SGa1e2i52P8SMF1DB7LEm2K3pDre64uEj2O2alGwJIV6ys3tiONEJKVkIc+GI7HV8V
         5o3g==
X-Forwarded-Encrypted: i=1; AJvYcCUBXvaR+lDHNkROCVnSl1Yi2DbeS/y9GWyGC3/8r6fir6ojbXsvUWUHvaEnJodYsSOoGUyFwGJGEhyMdPbtLxsvjf59@vger.kernel.org, AJvYcCWa+MuSqOqO5AgYhecS37rh20FS0mNd1+kd1iHz/reCSviEpdA8huFhegBEoT8N52F00Seihf0Gn2D4uI9n@vger.kernel.org, AJvYcCWcycHzTQ8FZkVgV+7fM9LHjjD7lO/iPpTZGtcr8qJMKW7tA8mbpUp9G2P33JVmvRcAJe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpiq347PMWbsZtoHvwbx/S41rc4P0okkbTqVU8Z/0Pz0aN4XML
	UkYH/Zz1cAUMIcQD+flSaQZC8wcdwq+fLfJdiVfcbzH96ykbXKcChd1Q8du0u0v88poWl60mS3S
	AIkKnESlD0oeHKPaDeK0n5pC5REc=
X-Google-Smtp-Source: AGHT+IEg4DbjqfRXka9aAkfSEmR+s0GKyrJw/htMlsm0Ur8gSdFunyN8Ro8pAlFUZqeVBvUpKSRHiFXvpXPYiqGxEcE=
X-Received: by 2002:a17:902:f70a:b0:20b:c1e4:2d77 with SMTP id
 d9443c01a7336-20bc5a94ec2mr72842175ad.38.1727899388225; Wed, 02 Oct 2024
 13:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001225207.2215639-1-andrii@kernel.org> <20241001225207.2215639-6-andrii@kernel.org>
 <20241002072522.GB27552@redhat.com>
In-Reply-To: <20241002072522.GB27552@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Oct 2024 13:02:56 -0700
Message-ID: <CAEf4Bzbpw-MDJFC8iNboEK02LVHcpeyzTKsQxrxt44fKm3MDRQ@mail.gmail.com>
Subject: Re: [PATCH v2 tip/perf/core 5/5] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:25=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 10/01, Andrii Nakryiko wrote:
> >
> > +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_=
vaddr)
> > +{
> > +     struct mm_struct *mm =3D current->mm;
> > +     struct uprobe *uprobe =3D NULL;
> > +     struct vm_area_struct *vma;
> > +     struct file *vm_file;
> > +     loff_t offset;
> > +     long seq;
> > +
> > +     guard(rcu)();
> > +
> > +     if (!mmap_lock_speculation_start(mm, &seq))
> > +             return NULL;
> > +
> > +     vma =3D vma_lookup(mm, bp_vaddr);
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     /* vm_file memory can be reused for another instance of struct fi=
le,
> > +      * but can't be freed from under us, so it's safe to read fields =
from
> > +      * it, even if the values are some garbage values; ultimately
> > +      * find_uprobe_rcu() + mmap_lock_speculation_end() check will ens=
ure
> > +      * that whatever we speculatively found is correct
> > +      */
> > +     vm_file =3D READ_ONCE(vma->vm_file);
> > +     if (!vm_file)
> > +             return NULL;
> > +
> > +     offset =3D (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm=
a->vm_start);
>
> LGTM. But perhaps vma->vm_pgoff and vma->vm_start need READ_ONCE() as wel=
l,
> if nothing else to shut up KCSAN if this code races with, say, __split_vm=
a() ?

We keep going back and forth between reading directly, using
READ_ONCE(), and annotating with data_race(). I don't think it matters
in terms of correctness or performance, so I'm happy to add whatever
incantations that will make everyone satisfied. Let's see what others
think, and I'll incorporate that into the next revision.

>
> > +     uprobe =3D find_uprobe_rcu(vm_file->f_inode, offset);
>
> OK, I guess vm_file->f_inode is fine without READ_ONCE...
>
> Oleg.
>

