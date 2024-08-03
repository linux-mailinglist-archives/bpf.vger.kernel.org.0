Return-Path: <bpf+bounces-36335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF05946792
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 07:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A79281E82
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 05:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF6714B978;
	Sat,  3 Aug 2024 05:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIaghkhN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246B76410;
	Sat,  3 Aug 2024 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722664050; cv=none; b=BjkPTtvYL54lN7qDFXDLksaIOGS+FhtPfCCnXXExtxU9klyCkDteKGafwLXBa87OBZcdqg4ZL5A4mHYCbi6XJDCEKdz1TGp02QyQlyhLy5X4V4bJmKVyCjPhWwUVqtaUjAsjaXArkInKNvDSPqoCK5ogB0JFBluRg2uZDKbjpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722664050; c=relaxed/simple;
	bh=1OUkYsrr9CzydfiBthe4OYV6IZu9wZ46NABTc0L3D5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAXQ4xZ8O15+AJXCmE9Q63wehLL74kA10R+k0NZk0x+jXcDf+E/ssleH9htkx4UxoeRjeqI+ywsYryt8mgimNaj9/IRmXfvibD59HoAiozOWxx149DD/oatJkDf1OO1/H6OV4W7G1nKlCL4aio16ix6Rh/vVJI/ElwPeE6cYQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIaghkhN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so6059115a91.3;
        Fri, 02 Aug 2024 22:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722664049; x=1723268849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzzgbmFWYHJe0pTR3qJLL95tC3UrvJmxqZXyXcVi3nk=;
        b=WIaghkhNbKZDaJtatE3wxt1f1r+vFIwv3ZBHfdsDPhYlupuJ7/lA/flGGPBAUiTAfX
         M3M1RzBsJz37m/VnqNDrF8DdOZjppnOZmPfxKskgRsBAVDbfXxdFa9bZLoS/SwvSXgru
         Grvs6fsDlz3u/dh7ooCXezEGBzU/tsq4Or8QcZF3WjByP/RoQ9dyatZmyjpqyYHxwnP9
         A8xviMCOqpxPkubD+g7r9ycjLbQc3E5sthjgWF9Mc/P06MRpaj/SyCaXth+h5RnzxMoo
         OdTj+IOI2WgW6qyDLeQ57LrVzvHjNOAr+Te3kE1BHqShA3/kDnxi3mDomTjpWRcviqrd
         xM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722664049; x=1723268849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzzgbmFWYHJe0pTR3qJLL95tC3UrvJmxqZXyXcVi3nk=;
        b=ddZ4fvJTsxlNnJCn8yAZjOJ6j52zDob0j+dPlA28z+XzmCqUMW1Eh3VNFSQqCXxW7Q
         IBlE5keN/a28tH08T4Ptct0b6TAUTZbDn+Ff4wJcSaBPF7hK4mporpOpGWnvLS+UIpa4
         JjdYUfoO8BSP0qqCBHAO5gBbbuhxWk76zbxPgpO166Sqwi5uf8vnWhOAzUQYTPc5MEN2
         tqBqz8GBuuIQpT0UlFQtzw02wvjJLS2SS0NpXEpzoNaVxgZgpFIls/8vVXKg6gNEqUX0
         hFGkkDCKt0vqYQ+H4cz4OQLwzMlVAqwJQZive3BybMj9XTVBlQ/P7ruYROuXuTtNnjCd
         P5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWuKOwyN3aZRGD4O37TCE0y73NNAYyPRtOsLk4y3xNZU9hgOIX8rtf8I3DmwMhF0CuJVfWt3x4rrSFeKovDgMaPn4J9b1L9tMSU35zwVBMCAQmNjehtXpnAcg/aLJ0LHfBK
X-Gm-Message-State: AOJu0Yw3PRZpW2ukb0sZPZHsUpQc6aiIzjxNUd23osMvXomF9q4PLzeK
	NjaLVe0uyndXzgQVIPJvdqy18PRH5gDbpJRd7x2uGE2e5a+6ulZwxWZe3ox1YJiM10ieZPnHm8I
	QHAI7x2msNUGk5q3AMO7nboLdm1Q=
X-Google-Smtp-Source: AGHT+IEVAoxH60YvTM4n8cXaZgJVSITcaVG/pS743lVr2wh6jcE4AMnO/J/T/E9YCA5NZ3g3FVMKCRnAlJLkk4r8c4I=
X-Received: by 2002:a17:90b:38cd:b0:2c9:63a4:a138 with SMTP id
 98e67ed59e1d1-2cff9412bb4mr5997889a91.11.1722664048507; Fri, 02 Aug 2024
 22:47:28 -0700 (PDT)
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
 <CAJuCfpFUQFfgx0BWdkNTAiOhBpqmd02zarC0y38gyB5OPc0wRA@mail.gmail.com>
In-Reply-To: <CAJuCfpFUQFfgx0BWdkNTAiOhBpqmd02zarC0y38gyB5OPc0wRA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Aug 2024 22:47:15 -0700
Message-ID: <CAEf4BzavWOgCLQoNdmPyyqHcm7gY5USKU5f1JWfyaCbuc_zVAA@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:10=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Jul 30, 2024 at 6:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Sat, Jul 27, 2024 at 04:45:53AM +0100, Matthew Wilcox wrote:
> >
> > > Hum.  What if we added SLAB_TYPESAFE_BY_RCU to files_cachep?  That wa=
y
> > > we could do:
> > >
> > >       inode =3D NULL;
> > >       rcu_read_lock();
> > >       vma =3D find_vma(mm, address);
> > >       if (!vma)
> > >               goto unlock;
> > >       file =3D READ_ONCE(vma->vm_file);
> > >       if (!file)
> > >               goto unlock;
> > >       inode =3D file->f_inode;
> > >       if (file !=3D READ_ONCE(vma->vm_file))
> > >               inode =3D NULL;
> >
> > remove_vma() does not clear vm_file, nor do I think we ever re-assign
> > this field after it is set on creation.
>
> Quite correct and even if we clear vm_file in remove_vma() and/or
> reset it on creation I don't think that would be enough. IIUC the
> warning about SLAB_TYPESAFE_BY_RCU here:
> https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/slab.h#L98
> means that the vma object can be reused in the same RCU grace period.
>
> >
> > That is, I'm struggling to see what this would do. AFAICT this can stil=
l
> > happen:
> >
> >         rcu_read_lock();
> >         vma =3D find_vma();
> >                                         remove_vma()
> >                                           fput(vma->vm_file);
> >                                                                 dup_fd)
> >                                                                   newf =
=3D kmem_cache_alloc(...)
> >                                                                   newf-=
>f_inode =3D blah
> >
>
> Imagine that the vma got freed and reused at this point. Then
> vma->vm_file might be pointing to a valid but a completely different
> file.
>
> >         file =3D READ_ONCE(vma->vm_file);
> >         inode =3D file->f_inode; // blah
> >         if (file !=3D READ_ONCE(vma->vm_file)) // still match
>
> I think we should also check that the VMA represents the same area
> after we obtained the inode.
>
> >
> >
> > > unlock:
> > >       rcu_read_unlock();
> > >
> > >       if (inode)
> > >               return inode;
> > >       mmap_read_lock();
> > >       vma =3D find_vma(mm, address);
> > >       ...
> > >
> > > I think this would be safe because 'vma' will not be reused while we
> > > hold the read lock, and while 'file' might be reused, whatever f_inod=
e
> > > points to won't be used if vm_file is no longer what it once was.
> >
> >
> > Also, we need vaddr_to_offset() which needs additional serialization
> > against vma_lock.

Is there any reason why the approach below won't work? I basically
open-coded the logic in find_active_uprobe(), doing find_vma() under
RCU lock, then fetching vma->vm_file->f_inode. If at any point any
check fails, we fallback to mmap_read_lock-protected logic, but if
not, we just validate that vma->vm_lock_seq didn't change in between
all this.

Note that we don't need to grab inode refcount, we already keep the
reference to inodes in uprobes_tree, so if we find a match (using
find_uprobe() call), then we are good. As long as that
vma->vm_file->f_inode chain didn't change, of course.

Is vma->vm_lock_seq updated on any change to a VMA? This seems to work
fine in practice, but would be good to know for sure.


Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Fri Aug 2 22:16:40 2024 -0700

    uprobes: add speculative lockless VMA to inode resolution

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8be9e34e786a..e21b68a39f13 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2251,6 +2251,52 @@ static struct uprobe
*find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
        struct uprobe *uprobe =3D NULL;
        struct vm_area_struct *vma;

+#ifdef CONFIG_PER_VMA_LOCK
+       vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE, vm_flag=
s;
+       struct file *vm_file;
+       struct inode *vm_inode;
+       unsigned long vm_pgoff, vm_start, vm_end;
+       int vm_lock_seq;
+       loff_t offset;
+
+       rcu_read_lock();
+
+       vma =3D vma_lookup(mm, bp_vaddr);
+       if (!vma)
+               goto retry_with_lock;
+
+       vm_lock_seq =3D READ_ONCE(vma->vm_lock_seq);
+
+       vm_file =3D READ_ONCE(vma->vm_file);
+       vm_flags =3D READ_ONCE(vma->vm_flags);
+       if (!vm_file || (vm_flags & flags) !=3D VM_MAYEXEC)
+               goto retry_with_lock;
+
+       vm_inode =3D READ_ONCE(vm_file->f_inode);
+       vm_pgoff =3D READ_ONCE(vma->vm_pgoff);
+       vm_start =3D READ_ONCE(vma->vm_start);
+       vm_end =3D READ_ONCE(vma->vm_end);
+       if (bp_vaddr < vm_start || bp_vaddr >=3D vm_end)
+               goto retry_with_lock;
+
+       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_start)=
;
+       uprobe =3D find_uprobe_rcu(vm_inode, offset);
+       if (!uprobe)
+               goto retry_with_lock;
+
+       /* now double check that nothing about VMA changed */
+       if (vm_lock_seq !=3D READ_ONCE(vma->vm_lock_seq))
+               goto retry_with_lock;
+
+       /* happy case, we speculated successfully */
+       rcu_read_unlock();
+       return uprobe;
+
+retry_with_lock:
+       rcu_read_unlock();
+       uprobe =3D NULL;
+#endif
+
        mmap_read_lock(mm);
        vma =3D vma_lookup(mm, bp_vaddr);
        if (vma) {
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..211a84ee92b4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3160,7 +3160,7 @@ void __init proc_caches_init(void)
                        NULL);
        files_cachep =3D kmem_cache_create("files_cache",
                        sizeof(struct files_struct), 0,
-                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+ SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT|SLAB_TYPESAFE_BY_RCU,
                        NULL);
        fs_cachep =3D kmem_cache_create("fs_cache",
                        sizeof(struct fs_struct), 0,

