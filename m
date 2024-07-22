Return-Path: <bpf+bounces-35261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C51C939402
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7261F220EF
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E4E171071;
	Mon, 22 Jul 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0FoBv22a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BE16EC1E
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675378; cv=none; b=fGb/3i5fTxib5TCJedyFI6R79g+szaeBZBJi3ji1dfeSV4EyVnkmTZ5RbEEDJ7rlxvu+pJ8RFD2ulU8eLdrw7P3/SwkPstNSY9YLDI4ddCsycoH3Uqqu78/2Hl1NGzmpfaaugrqoCQ5Ba0FN8WGC5fkCbPZqzK6NNu5AZE+9do8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675378; c=relaxed/simple;
	bh=qnmq/qlub6NkMVHjk1bCk3gy0V19lvngDxVc6kTkowE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itKt24da+eDJaeTVXSF77SKs78Z7CFrZTdjyRziGlMrn91EOTEOBbC5uUkiG83o8lL3Et+ZVdJLCUXV9nH6FX+5OoPOmKz40KwB+uoAmJ1U64bw7yr8EVISdXUUEafzPm3X5NLbLNXYQJzwssPb4aomfIJ8r5vT4NPBWnYTmtU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0FoBv22a; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66ca536621cso14651307b3.3
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721675374; x=1722280174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H46wDgBqFw0ZNrcJfr4LFF2KtCEo/8CP1rPHZLFS0ZQ=;
        b=0FoBv22ag6FE5tccQyQHh8SxqWF/2OI9XrmvnFJa5F2xUsWjKYCw+noANCiNcxuDO3
         qvIRW4i27oeJxbK0tAbYR5obb4Ar/xWRPLrh+dgoqJwrhhieESWFiB9Z5O5eVh8r/lt/
         6JVNG21krNXNYSdCUMeDayc61uFisTI2zu9EYBOHwo7AILLCYLqPa8cQ0AjqnroZhqqi
         kUW2iv8aoBzJ5BfwR955Z4ncdvXvMBIMrPiKl39SYRtI5OCqAQsPQE3NJsehGK/cLZPg
         J8Y9040ager+/k56MGuy3hFbEEBG9ycVPyoCL0EyARXQA+nfHq9bvEVdEBGyadV3MGuN
         nQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675374; x=1722280174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H46wDgBqFw0ZNrcJfr4LFF2KtCEo/8CP1rPHZLFS0ZQ=;
        b=ZQ9nwE+wtzY+g32Bk/7dXvi6H+B1tPVrcxi9SULhInv5NjrhbinlpWdlaTIsmD7qyI
         E7zhTss9ueFv9jpW8snIEa9eudsqNomy2oE1BrAELuPvdmh7imdF/b4Uw4a98V/3PWVy
         aAFG052FSA6h8FLXXhyi8xW6pw1iwP8zKF4CydTgtO+x6HPW48o0ERbNC4sCa8GjIhEC
         Cx0fsfbkx+Sghk0YAYIZgwkC+7aAh+TsNgvcPqrZrn9lYVtZ2R8BNVcY3gn4+2o53DdO
         awEz8Zsl8vHcwtHzNslhelu/3QVuilbeevf6pgkUHDXc2Kq9TaCOWblsjRDBiLIpL8Q7
         CCZw==
X-Forwarded-Encrypted: i=1; AJvYcCUzr5NjhCFRW2Yb2tM889yR+B/UeG3JaCaxgE8+euT4sB/N1NEngicVmjp2mnHWhDVn/W1pqSyUCGPHBJ87NlkFZe4g
X-Gm-Message-State: AOJu0YwYOcGugl+oRqsH+7ChPn9Fl4S0h7xxeCPsv2RX7cb/6bRi4wXH
	80a3L7NvIzJF5ui8HkvdnDekClZAc7Xq/NcAD5M+xmGaWy4jMDf9tmCCeaovWWXiN+nI3u1aTsS
	IUv7bbE0ytOuek+UOZx5YWsCBp7X0z9EWXlaV
X-Google-Smtp-Source: AGHT+IHXDOYsKUgQNN+roGNoixtNmwmKEfv7H/r1voZOIiCRIGLdVfRhpTyNt8Q2yiz380ODwN0e5+knFVjhH0Z38U8=
X-Received: by 2002:a81:8a44:0:b0:62c:dcb2:a75b with SMTP id
 00721157ae682-66e4dcdb25amr6041807b3.38.1721675374203; Mon, 22 Jul 2024
 12:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708091241.544262971@infradead.org> <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net> <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net> <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
 <20240710091631.GT27299@noisy.programming.kicks-ass.net> <20240710094013.GF28838@noisy.programming.kicks-ass.net>
In-Reply-To: <20240710094013.GF28838@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Jul 2024 12:09:21 -0700
Message-ID: <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Jul 10, 2024 at 11:16:31AM +0200, Peter Zijlstra wrote:
>
> > If it were an actual sequence count, I could make it work, but sadly,
> > not. Also, vma_end_write() seems to be missing :-( If anything it could
> > be used to lockdep annotate the thing.

Thanks Matthew for forwarding me this discussion!

> >
> > Mooo.. I need to stare more at this to see if perhaps it can be made to
> > work, but so far, no joy :/
>
> See, this is what I want, except I can't close the race against VMA
> modification because of that crazy locking scheme :/

Happy to explain more about this crazy locking scheme. The catch is
that we can write-lock a VMA only while holding mmap_lock for write
and we unlock all write-locked VMAs together when we drop that
mmap_lock:

mmap_write_lock(mm);
vma_start_write(vma1);
vma_start_write(vma2);
...
mmap_write_unlock(mm); -> vma_end_write_all(mm); // unlocks all locked vmas

This is done because oftentimes we need to lock multiple VMAs when
modifying the address space (vma merge/split) and unlocking them
individually would be more expensive than unlocking them in bulk by
incrementing mm->mm_lock_seq.

>
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2146,11 +2146,58 @@ static int is_trap_at_addr(struct mm_str
>         return is_trap_insn(&opcode);
>  }
>
> -static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is=
_swbp)
> +#ifndef CONFIG_PER_VMA_LOCK
> +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
> +{
> +       return NULL;
> +}
> +#else

IIUC your code below, you want to get vma->vm_file without locking the
VMA. I think under RCU that would have been possible if vma->vm_file
were RCU-safe, which it's not (we had discussions with Paul and
Matthew about that in
https://lore.kernel.org/all/CAJuCfpHW2=3DZu+CHXL+5fjWxGk=3DCVix=3DC66ra+DmX=
gn6r3+fsXg@mail.gmail.com/).
Otherwise you could store the value of vma->vm_lock_seq before
comparing it with mm->mm_lock_seq, then do get_file(vma->file) and
then compare your locally stored vm_lock_seq against vma->vm_lock_seq
to see if VMA got locked for modification after we got the file. So,
unless I miss some other race, I think the VMA locking sequence does
not preclude you from implementing __find_active_uprobe() but
accessing vma->vm_file would be unsafe without some kind of locking.

> +static struct uprobe *__find_active_uprobe(unsigned long bp_vaddr)
>  {
>         struct mm_struct *mm =3D current->mm;
>         struct uprobe *uprobe =3D NULL;
>         struct vm_area_struct *vma;
> +       MA_STATE(mas, &mm->mm_mt, bp_vaddr, bp_vaddr);
> +
> +       guard(rcu)();
> +
> +again:
> +       vma =3D mas_walk(&mas);
> +       if (!vma)
> +               return NULL;
> +
> +       /* vma_write_start() -- in progress */
> +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq))
> +               return NULL;
> +
> +       /*
> +        * Completely broken, because of the crazy vma locking scheme you
> +        * cannot avoid the per-vma rwlock and doing so means you're racy
> +        * against modifications.
> +        *
> +        * A simple actual seqcount would'be been cheaper and more useful=
l.
> +        */
> +
> +       if (!valid_vma(vma, false))
> +               return NULL;
> +
> +       struct inode =3D file_inode(vma->vm_file);
> +       loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
> +
> +       // XXX: if (vma_seq_retry(...)) goto again;
> +
> +       return find_uprobe(inode, offset);
> +}
> +#endif
> +
> +static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is=
_swbp)
> +{
> +       struct uprobe *uprobe =3D __find_active_uprobe(bp_vaddr)
> +       struct mm_struct *mm =3D current->mm;
> +       struct vm_area_struct *vma;
> +
> +       if (uprobe)
> +               return uprobe;
>
>         mmap_read_lock(mm);
>         vma =3D vma_lookup(mm, bp_vaddr);
>

