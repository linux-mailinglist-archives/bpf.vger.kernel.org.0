Return-Path: <bpf+bounces-39316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927FB971A83
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E26281316
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ABA1B86D3;
	Mon,  9 Sep 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEvvt16K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AB17A5B2
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887618; cv=none; b=ZaKJXQ6C48/JY0NW+VwxoaeI/FF3Lx54Xc3TmHPVY18bP+ff/cfyuPTgI4sXS03hZ7JveP4A7BuuZExoejHH2ZzQUPyio8RxLnKpuCni7wRVko91JsCByje6hpq5vvTgoTjYV4IQZr3irIdZ4uPdALLr3fGqInqb58/ccWbUfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887618; c=relaxed/simple;
	bh=sfvrALdN5FFNHEGRIBlpYy+rvir+GbG4FzfOtxBw2Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuJjTldLNiNWj5To/gzocC7Ryu/1zMdgSGqFR+3h7C8BLmAw59cywSfArvMMJ+UK0raj1zsedlxt2xd9kk6s/csgqd0fhRWOthfJc1ShQWJubcxiNtaqKVJdQVGRd9xgfInYEum5Pa/Q84J0rq5XllRXvex+xM8FaNIrX5We5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEvvt16K; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5356a2460ceso9071e87.0
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725887615; x=1726492415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0Qpk+x67S20AfnP0HkE2Lz8EGrKLhCwgTYyWP4OIYE=;
        b=NEvvt16KONuQcrPZwT2k3VvvH2cEiHi0GedsrZstMWZaCnhovdz6r8ThG9z1hGWE4K
         Gs06DKjfQis5DlYSgTl+rD5xoAroAJKjaQKaNUAw2KsL72+tGypwgRNgEWe7g8mD6lzP
         vbFAFE52ZoXE8kNYgzAgP4caI1+4Mjp0B3EHtnfA7f3/XsBFb/oNt2b4X8DF+oeQaZuL
         bwWYN44hGxopRkBpQ96bkZBTzYNjoDQMed5RqOZ0DTnRxo4ImysVg2ykqBnTAm7zI0Q+
         m4H0OS90rpzjqGYYKL1CiTu5bZ4YbL9ZWfzr2AW6gy/g7ByeQXPeezGQcMSiTKdJbRrR
         NT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887615; x=1726492415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0Qpk+x67S20AfnP0HkE2Lz8EGrKLhCwgTYyWP4OIYE=;
        b=kS5DTBOXLmNMPKcrsjz/kwb4gaovYO3IfyTkbmacvNpwGqxFAsUnX8hgWXWgPv+lF2
         xuw65iBW8R0BoqgNJA+CgKfStjSsGYQFECEkp84qXDogbDIHeGE410878wakD284L0Wh
         5BC2cqlvVonJ1KeWylGqw5bNOI/SYYZC5r8n4Og8KHWXuuriFenlReiPx2/7Z5Weop/S
         uXu/ipIgM14cR5vTk5VWI4lnp219IsdEOyV9mg2Qg3STRKqFg/078ieFak3r0CxaHqdn
         w4t6HVmAE76tTvIZoVCZhYc9GHTPxMkdQ0tC2rMr6cNd0XBfCP6ZDmsu85DkO/+7C5EK
         n8fg==
X-Forwarded-Encrypted: i=1; AJvYcCW6bECWtNUQWGDVDIfaBXwpqVznvsFk9eX7mmWdQxafgSLd/CRZDsq/EafK5raYTZUFwt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqdYap8qS2GdRnKkd3mFG144ilrTUHQTiyz+h2cBHocAP3Eeh
	Q5XyxIFmzVqeS9q3i2RE0MdREKCwN9Xs1uurZW+MqTX7iIG2ujmg+SXny87TJCvR17MSPDiEHC0
	dj2DoryLF+YhpJ5wlH13DUNVoNn6v6O4QzdPl
X-Google-Smtp-Source: AGHT+IGbHTgjUP9n9e0Je4tUVw4yQi27pYfPz7pOzFc9OB1SgZi153AKL0qkRB1p9AOL0pdG0v4kJX60dSJe2NNaGII=
X-Received: by 2002:a05:6512:b05:b0:52e:8a42:f152 with SMTP id
 2adb3069b0e04-5365eb6fa31mr222153e87.5.1725887614987; Mon, 09 Sep 2024
 06:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
In-Reply-To: <20240906051205.530219-3-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Sep 2024 15:12:57 +0200
Message-ID: <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Andrii Nakryiko <andrii@kernel.org>, brauner@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
> Given filp_cachep is already marked SLAB_TYPESAFE_BY_RCU, we can safely
> access vma->vm_file->f_inode field locklessly under just rcu_read_lock()

No, not every file is SLAB_TYPESAFE_BY_RCU - see for example
ovl_mmap(), which uses backing_file_mmap(), which does
vma_set_file(vma, file) where "file" comes from ovl_mmap()'s
"realfile", which comes from file->private_data, which is set in
ovl_open() to the return value of ovl_open_realfile(), which comes
from backing_file_open(), which allocates a file with
alloc_empty_backing_file(), which uses a normal kzalloc() without any
RCU stuff, with this comment:

 * This is only for kernel internal use, and the allocate file must not be
 * installed into file tables or such.

And when a backing_file is freed, you can see on the path
__fput() -> file_free()
that files with FMODE_BACKING are directly freed with kfree(), no RCU delay=
.

So the RCU-ness of "struct file" is an implementation detail of the
VFS, and you can't rely on it for ->vm_file unless you get the VFS to
change how backing file lifetimes work, which might slow down some
other workload, or you find a way to figure out whether you're dealing
with a backing file without actually accessing the file.

> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_va=
ddr)
> +{
> +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
> +       struct mm_struct *mm =3D current->mm;
> +       struct uprobe *uprobe;
> +       struct vm_area_struct *vma;
> +       struct file *vm_file;
> +       struct inode *vm_inode;
> +       unsigned long vm_pgoff, vm_start;
> +       int seq;
> +       loff_t offset;
> +
> +       if (!mmap_lock_speculation_start(mm, &seq))
> +               return NULL;
> +
> +       rcu_read_lock();
> +
> +       vma =3D vma_lookup(mm, bp_vaddr);
> +       if (!vma)
> +               goto bail;
> +
> +       vm_file =3D data_race(vma->vm_file);

A plain "data_race()" says "I'm fine with this load tearing", but
you're relying on this load not tearing (since you access the vm_file
pointer below).
You're also relying on the "struct file" that vma->vm_file points to
being populated at this point, which means you need CONSUME semantics
here, which READ_ONCE() will give you, and something like RELEASE
semantics on any pairing store that populates vma->vm_file, which
means they'd all have to become something like smp_store_release()).

You might want to instead add another recheck of the sequence count
(which would involve at least a read memory barrier after the
preceding patch is fixed) after loading the ->vm_file pointer to
ensure that no one was concurrently changing the ->vm_file pointer
before you do memory accesses through it.

> +       if (!vm_file || (vma->vm_flags & flags) !=3D VM_MAYEXEC)
> +               goto bail;

missing data_race() annotation on the vma->vm_flags access

> +       vm_inode =3D data_race(vm_file->f_inode);

As noted above, this doesn't work because you can't rely on having RCU
lifetime for the file. One *very* ugly hack you could do, if you think
this code is so performance-sensitive that you're willing to do fairly
atrocious things here, would be to do a "yes I am intentionally doing
a UAF read and I know the address might not even be mapped at this
point, it's fine, trust me" pattern, where you use
copy_from_kernel_nofault(), kind of like in prepend_copy() in
fs/d_path.c, and then immediately recheck the sequence count before
doing *anything* with this vm_inode pointer you just loaded.



> +       vm_pgoff =3D data_race(vma->vm_pgoff);
> +       vm_start =3D data_race(vma->vm_start);
> +
> +       offset =3D (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_star=
t);
> +       uprobe =3D find_uprobe_rcu(vm_inode, offset);
> +       if (!uprobe)
> +               goto bail;
> +
> +       /* now double check that nothing about MM changed */
> +       if (!mmap_lock_speculation_end(mm, seq))
> +               goto bail;
> +
> +       rcu_read_unlock();
> +
> +       /* happy case, we speculated successfully */
> +       return uprobe;
> +bail:
> +       rcu_read_unlock();
> +       return NULL;
> +}

