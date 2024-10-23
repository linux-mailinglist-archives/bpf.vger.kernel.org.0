Return-Path: <bpf+bounces-42951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B41809AD549
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 22:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20A4B22234
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2861B1CEEA5;
	Wed, 23 Oct 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1zNNvqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE01E51D;
	Wed, 23 Oct 2024 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713788; cv=none; b=c4qx1f3POeShVOKRQ7S5C0D52ECOMceh11yrXeY4Z9i1w9N7ut5jj96TDa+MgeA6m/hnx+6YZ0q3Bv5GT2o1AqQ3w8seFbRQ8fQOXTR4ZXPhTZVU9Ah8zYmW+KOyA6bxnIxfqfKkbV0ufz32u3AiRXstTWugjIynTtK+DVywqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713788; c=relaxed/simple;
	bh=+n3/X2amTerW3fqY2GcOe7zHBtBJhaA4xOYypQ1YvLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9ujsf7QuBaxf3yB4Q5xOALAO/DniGz3w7sQpfTCUkP8dKm8kdvDMEQ5p3HP1K7zV3guWe9Bti580cDtk2bO1w+rRdZS05CbvwXNpWgpisBwpsd8I/IwlgIz+JqKVFGy+rYpgmqmxFeqqRX9u+0gZPk+3oWFDBuXX4hz8B5b4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1zNNvqw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso108333a12.1;
        Wed, 23 Oct 2024 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729713786; x=1730318586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP73v8SKOj9OMtC9FJHv9JWI9rQlYgH+l/YZtxHOFuU=;
        b=P1zNNvqwlL2reiHM3TGFgb32dMje3Z1e8JP0cXbi7kP6g/F7WVikajkRMDOxrBABk4
         ZOk7QLTR75hJPlRuCP/DKZTfNn4OYPjbZwlpkuB9f9vvq0MHeXfHE8OaZPuS3kkQPq4i
         hMUnC8ZDBDUJbBDqUIb5UAKFrG1NQ2h4UbwPTXLdhDcHCFv6adshoufp47L8NzTxT108
         GFFscbuHw0HmOLxUwQezcOQJ1nVMDpwEGN6fWt6yF35rNhMJ2lvVqzthi62Y/Am1PIL6
         NK9WbCZJnuXYt1Gj+IhR6ARxrACm9gz0c5raR6WLOHzUd9bzHC8KXSugTcpd3O0i/lQN
         hiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729713786; x=1730318586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP73v8SKOj9OMtC9FJHv9JWI9rQlYgH+l/YZtxHOFuU=;
        b=Ug7oyWoPmr0duzjfYlExA6BshG3qdg6q8gcS72eorw3BZC7c+weLOEhEHNicDMv0Zc
         eMBqb6uqyUh7eaW+ZpI8CukS2YURJDLtPMproW9A2INT0/vwkXKq7qp0U7Yr0Zgzd1vP
         l4hLVvEYaM0UBl/frBy6AdZPYZOSO1eubjd7Ol7yTmq/TzMuHsgASgIZmns0MClq3M+n
         ANwpfejxDbVHpHYubd0bPV1P7TxnLAmzuBE4rvLbNTsCTZn41ZZzqs8stRiqva6qbM12
         q4wVfaFIe4+C+4cXJv8qBON9F4tchjggth2Hh7qljlo8sXXTI8g9qhLtFp8BaynGdfRE
         NTkg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Pjds1AkRIwOu2KmOsCreUzYVIRiuaLoQF5NnO3Aj3hHv/Z6K6ZFXHC8i0REMblgEJmZ53DJQExy8sFqB@vger.kernel.org, AJvYcCX5dKb+Wi9FEcVAoAmzbYic+tc1mIE53UBI3TyDiciMCBKznz8JMdrjFO8fijrrtSt0Dik=@vger.kernel.org, AJvYcCXF9vMeflityulKMrhqklPFe8t73i0k1WQBmdIczoPYxuVPTZrP7fKjpvjGp/GZTU+s7+SN5lBxF64d5VqQ311z7W9n@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+wcuX9d1oCzMAKSmy/cZXdYosuxSEiB39TdT29CHlmhXQpuH
	Zo6ES71szQ9NBl8kv6FrwGudoUYDUcBMg2erZsm7WWa6jBEt/hZFTz+E+u7vaMBRuGAyOUdw2DS
	I0c1HPQ6KH4iROEtSBzEu4rO9kWY=
X-Google-Smtp-Source: AGHT+IHwR2GYCMNX76w7QATFiO6JTAScsQkOxdJ6G3+ZLHIRRdkUSVzlfRDByZGqrvy1PYzkVT4QRkJbMz+6KJX32Cc=
X-Received: by 2002:a05:6a21:1646:b0:1d7:2249:689 with SMTP id
 adf61e73a8af0-1d978b990ecmr4164984637.33.1729713786360; Wed, 23 Oct 2024
 13:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-5-andrii@kernel.org>
 <20241023192236.GB11151@noisy.programming.kicks-ass.net>
In-Reply-To: <20241023192236.GB11151@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 13:02:53 -0700
Message-ID: <CAEf4Bza7+DraKrNoG3ebUaZUvmk3HN+cT8TgtnThkp_XGPf6AA@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 4/4] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, mjguzik@gmail.com, brauner@kernel.org, 
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:22=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, Oct 10, 2024 at 01:56:44PM -0700, Andrii Nakryiko wrote:
>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
>
> I'm fairly sure I've suggested much the same :-)

I'll add another Suggested-by, didn't mean to rob anyone of credits :)

>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 50 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index fa1024aad6c4..9dc6e78975c9 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2047,6 +2047,52 @@ static int is_trap_at_addr(struct mm_struct *mm,=
 unsigned long vaddr)
> >       return is_trap_insn(&opcode);
> >  }
> >
> > +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_=
vaddr)
> > +{
> > +     struct mm_struct *mm =3D current->mm;
> > +     struct uprobe *uprobe =3D NULL;
> > +     struct vm_area_struct *vma;
> > +     struct file *vm_file;
> > +     struct inode *vm_inode;
> > +     unsigned long vm_pgoff, vm_start;
> > +     loff_t offset;
> > +     long seq;
> > +
> > +     guard(rcu)();
> > +
> > +     if (!mmap_lock_speculation_start(mm, &seq))
> > +             return NULL;
>
> So traditional seqcount assumed non-preemptible lock sides and would
> spin-wait for the LSB to clear, but for PREEMPT_RT we added preemptible
> seqcount support and that takes the lock to wait, which in this case is
> exactly the same as returning NULL and doing the lookup holding
> mmap_lock, so yeah.
>

yep, and on configurations with CONFIG_PER_VMA_LOCK=3Dn this will always
return false


> > +
> > +     vma =3D vma_lookup(mm, bp_vaddr);
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     /* vm_file memory can be reused for another instance of struct fi=
le,
>
> Comment style nit.

mechanical memory, sorry, missed this one

>
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
> > +     vm_pgoff =3D data_race(vma->vm_pgoff);
> > +     vm_start =3D data_race(vma->vm_start);
> > +     vm_inode =3D data_race(vm_file->f_inode);
>
> So... seqcount has kcsan annotations other than data_race(). I suppose
> this works, but it all feels like a bad copy with random changes.

I'm not sure what this means... Do I need to change anything? Drop
data_race()? Use READ_ONCE()? Do nothing?

>
> > +
> > +     offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_star=
t);
> > +     uprobe =3D find_uprobe_rcu(vm_inode, offset);
> > +     if (!uprobe)
> > +             return NULL;
> > +
> > +     /* now double check that nothing about MM changed */
> > +     if (!mmap_lock_speculation_end(mm, seq))
> > +             return NULL;
>
> Typically seqcount does a re-try here.

I'd like to keep it simple, we have fallback to locked version in case of a=
 race

>
> > +
> > +     return uprobe;
> > +}

