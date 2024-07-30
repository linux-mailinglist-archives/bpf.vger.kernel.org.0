Return-Path: <bpf+bounces-36076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD1B941F3F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33301284B75
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B4318B465;
	Tue, 30 Jul 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NexlgKzE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55A189539
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363053; cv=none; b=ZPsdATht6VlCMPX4e55uEig7tdJJKDYctU5s1YOKf3Z5ke7l68ceTgvImKwNGd/gNb3Z4rFX3y+dunNCSenldjWxzn0uX8S9sWBU4jcAaDQ8Nn1VOMoVVA6LUp8KVFhWqi7Sq+iwwqjjJ4OsUImPyTyDmW2hDv3vGqh7teSs1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363053; c=relaxed/simple;
	bh=0lQBP4rNXainoXcVHBwi0kr7juVCuFLU2P22XfYpVXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2wiQFRsyDCEAtqiy5pp4Q0mKkcSM6WxWTaUoAM60mY+vliSVf6PDLjPTTXx0ymxisb6p5Hlzuix4a8zxtaHjA+dGJU6p9TUuonq4CZNUikhFqUruL/hnOR76O2jqk/fCs0bbtO61AHcSMtOgnWzBJsT5eiBfY3iArmL3f45ZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NexlgKzE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-369f68f63b1so2189238f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722363050; x=1722967850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGhH0uDu93FhhsJCvkGO3qe3hVA/MLfA5YSAYjGjOxo=;
        b=NexlgKzEeaB1GfnYP99TTke1OA2/qt89esPeNPwYqAOV8MaYFO7U9yaXrqRlbBRhJl
         +ruaaVpwRWEZfJZwGYZ85sTaSHS8mQDkTmEKSqhFpAPFBs5ra5jqk2rOx2+4f2LfJ/du
         8VQuBpysPpjJ1Ssw0SU3yeDw1kPqpaPWHYX4jJ2Nch1JbSjjpEzMnouk/uC69gT5M93P
         I85CHMDWpllu98UWe4KLBxDeA6XBtsHvcOyh975AaWzmbVfwN174HeD3vfTDTpuy/0ab
         cj7vvQOeazh7j771ckSDlyRCB3LvDsYpISSNiK6qiMu0y0lYJUobrkAt7Wrowda0fbOE
         cceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363050; x=1722967850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGhH0uDu93FhhsJCvkGO3qe3hVA/MLfA5YSAYjGjOxo=;
        b=HG7kV0tM7FxqmJdOtQp3RttI/rhzUR0TcNlt7Ufeas2vG9ytcPNxwDdFQlT/5xUgaS
         1EMSDrqe5gXkNZuoW9iQqOyE68nzDW8Tdqb9uozpghhwSkcylqjuuPqGKp0JRcyFWydx
         xBC76JuT2Nm28O7IgnGlbBi0aNeCOhMiKbvjQSrEMY4C/iXdbtXi3c4SONoYr0ajeVbV
         PZg5vqqKWyiz3pi7atBT1RJxOgOh4QquaN83u54HTfbwv30aIjkStL+Rek0X7xi7HRSr
         0vqy74INpiO5W43wK2iyGvNrKZOWtvfwRITT6wRmfaOlNoT4c+w+pj6HRo+WQmbrLs+K
         cqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5HttBNOpCaM0hD4piuserLb8QyD4NRpy9hYXNxB9SHs8xqteMnMR3NWu+j8C6HRqqivDWKntNTne9hKllrpT4yDgF
X-Gm-Message-State: AOJu0YzCquVoppfvZ26mr2KyhVuro3DnLtukir7fFPp9Zuk7NlLoI4Fn
	WSmPrMLFhMzA4FylQbOWV833ahjHoSmouuoPEDDWpd8W6txjRjQXgV1HK95pzDv7mn94nOZF9dv
	fTvW5uvFwArSUtPX6g3ZA8U8IDKBXiBn4GNM8
X-Google-Smtp-Source: AGHT+IG+L+Znba43C1ffV6KA4A7+WOi+BlM2lo3Auff1W58sTDTBioUK+SAO84Ba+RWhR3G1Sa+lkO/IbAs3/uCgDps=
X-Received: by 2002:a5d:670f:0:b0:367:f104:d9e8 with SMTP id
 ffacd0b85a97d-36b5d08b9c4mr6609846f8f.47.1722363050078; Tue, 30 Jul 2024
 11:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop> <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org> <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net> <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
 <ZqRtcZHWFfUf6dfi@casper.infradead.org> <20240730131058.GN33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730131058.GN33588@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 30 Jul 2024 11:10:33 -0700
Message-ID: <CAJuCfpFUQFfgx0BWdkNTAiOhBpqmd02zarC0y38gyB5OPc0wRA@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sat, Jul 27, 2024 at 04:45:53AM +0100, Matthew Wilcox wrote:
>
> > Hum.  What if we added SLAB_TYPESAFE_BY_RCU to files_cachep?  That way
> > we could do:
> >
> >       inode =3D NULL;
> >       rcu_read_lock();
> >       vma =3D find_vma(mm, address);
> >       if (!vma)
> >               goto unlock;
> >       file =3D READ_ONCE(vma->vm_file);
> >       if (!file)
> >               goto unlock;
> >       inode =3D file->f_inode;
> >       if (file !=3D READ_ONCE(vma->vm_file))
> >               inode =3D NULL;
>
> remove_vma() does not clear vm_file, nor do I think we ever re-assign
> this field after it is set on creation.

Quite correct and even if we clear vm_file in remove_vma() and/or
reset it on creation I don't think that would be enough. IIUC the
warning about SLAB_TYPESAFE_BY_RCU here:
https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/slab.h#L98
means that the vma object can be reused in the same RCU grace period.

>
> That is, I'm struggling to see what this would do. AFAICT this can still
> happen:
>
>         rcu_read_lock();
>         vma =3D find_vma();
>                                         remove_vma()
>                                           fput(vma->vm_file);
>                                                                 dup_fd)
>                                                                   newf =
=3D kmem_cache_alloc(...)
>                                                                   newf->f=
_inode =3D blah
>

Imagine that the vma got freed and reused at this point. Then
vma->vm_file might be pointing to a valid but a completely different
file.

>         file =3D READ_ONCE(vma->vm_file);
>         inode =3D file->f_inode; // blah
>         if (file !=3D READ_ONCE(vma->vm_file)) // still match

I think we should also check that the VMA represents the same area
after we obtained the inode.

>
>
> > unlock:
> >       rcu_read_unlock();
> >
> >       if (inode)
> >               return inode;
> >       mmap_read_lock();
> >       vma =3D find_vma(mm, address);
> >       ...
> >
> > I think this would be safe because 'vma' will not be reused while we
> > hold the read lock, and while 'file' might be reused, whatever f_inode
> > points to won't be used if vm_file is no longer what it once was.
>
>
> Also, we need vaddr_to_offset() which needs additional serialization
> against vma_lock.

