Return-Path: <bpf+bounces-37271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08B953095
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8D028312A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6819E825;
	Thu, 15 Aug 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltjCduHH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5A176ADE;
	Thu, 15 Aug 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729460; cv=none; b=c0XfK8WhEhT0rkWBEPccC+6M4xJK2KveztS9TYNd162QDk/1yBp7QsLVcNTlYrFE8rC3aA82k0BQFf/szHzUGTnccqneCkUWStQVzn9zgsOqfPg1NM2bFunDcNS0ZgJXy+2o7fcxhlNJgAMehVS2i2SRqmpHSIVqV7DR1hyfQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729460; c=relaxed/simple;
	bh=JUNPZHjm8v/nuaFJIljwv0sgnsRj7CmxSLSveG/QhwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQqnTqZxG9ZTjhbxBvIRRZfL1FeohLmvfa1hzHilFCdty8vpDlmaInKX0CzDYik0lS/VrDrCv24F+r5FspR0Cud5YhGxjIzSLYH9fJE/IQAeuVKf0bbreTUtfdzUSrzcxaTZnmDcqAuhc8EAA1RzotjyAAnhxhC+hHqiEXVZZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltjCduHH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1271921a12.2;
        Thu, 15 Aug 2024 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723729457; x=1724334257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEWVOSOkejG3Jox0hqATz/vxP68NCLIvNT+z/Tsv/XM=;
        b=ltjCduHHgAzppF22e70u2BjEaIps8pXmBhuLcUu/JrBWWR4+Fj+LrCifK98cL1xZEO
         idlClixSFVEFr+SGASOJmkpqGhoaNY/xm1xHVPrel/uOecJtM9aHlEeb4dyCDymp8vPv
         dsUqJiunjcGWNn4BBJRs8EetsAbvQQFxcPxbkixJa/72whCe49vTqWsCQg3QoDeuR5lO
         1td9YWAQ88HoyQsVT6pfWZTQqObWdDmuYigMmn8o785WvGDWMm/mDH4VPL+zzqN7ZL33
         IG3dMq4Tp6NyVypqqB33Dz0Ib8DEKhnWc7Urnkv547nd4RSSRuB+4PFuXq+9zgLuqzJ9
         P2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729457; x=1724334257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEWVOSOkejG3Jox0hqATz/vxP68NCLIvNT+z/Tsv/XM=;
        b=GCV53worLsKA5agzZqMjMPgaJuor5hI/9ShOP/y7n/vmLI7FFazAj2qyNRRn1B4FjR
         +HuC1Pi5TYqxhHS/w/Xh3VgbiaTDnSQqSXwPNGUEIUZyfSNzoqj8shKRnbCSgwHfKFwf
         3nkd6V/MDXXfgaOTirz6A8oYW74qWMB34ZTXWi+rezNeWQBfFZIkLpShbg4YUlc0VXhn
         7VvPIKDiVRLdNFVeCLvzkKapCcMVJ/IWcaePWM7u+9AHru3C3PA32D5t2I4+XO8bYC1c
         IYfByXllTI8hd9oS4xeD5+vo/e3asZbMKhzsJNsMLR0GZBNCzS64w19FyQdzYk6UoRx9
         x3eA==
X-Forwarded-Encrypted: i=1; AJvYcCWzH40mSkoLpOtbU6pqD24P8nXBq4CgufWWRkyx1S7IYdd3LHNx8X3e7JmdYDPBA0Y5oJrj4LaV8kU9ZUjKBr8mnsCfNdrFsMbUnQDLbxY5KIXNJqL1OcSsOe22I8F4qHQ9RxbXvw9VomdZ9ftYyXMBEBwUPierWyE84YErf67OdLo0lnNa
X-Gm-Message-State: AOJu0Yy3LaL2Dsp9pFayxTNMKvkxbjC9VZHmTwd2wXJYBP0PfJaYi0O/
	SLQoGpXlGXbGxadPvx4DT5+CLlmiWxlijj9XXIyMQeajdwQjXwEt
X-Google-Smtp-Source: AGHT+IHXmPnNO1BQhxO6MMFT6/TIgWYHu9VHKbep57A+dn6tZDRSYYtt+JQEDnN+t7z56GsriXVnxw==
X-Received: by 2002:a05:6402:1913:b0:5be:c852:433d with SMTP id 4fb4d7f45d1cf-5bec8524614mr211111a12.15.1723729456450;
        Thu, 15 Aug 2024 06:44:16 -0700 (PDT)
Received: from f (cst-prg-76-86.cust.vodafone.cz. [46.135.76.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7ecc7sm913742a12.62.2024.08.15.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:44:15 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:44:05 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
Message-ID: <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
 <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>

On Tue, Aug 13, 2024 at 08:36:03AM -0700, Suren Baghdasaryan wrote:
> On Mon, Aug 12, 2024 at 11:18 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Mon, Aug 12, 2024 at 09:29:17PM -0700, Andrii Nakryiko wrote:
> > > Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> > > vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
> > > attempting uprobe look up speculatively.
> > >
> > > We rely on newly added mmap_lock_speculation_{start,end}() helpers to
> > > validate that mm_struct stays intact for entire duration of this
> > > speculation. If not, we fall back to mmap_lock-protected lookup.
> > >
> > > This allows to avoid contention on mmap_lock in absolutely majority of
> > > cases, nicely improving uprobe/uretprobe scalability.
> > >
> >
> > Here I have to admit to being mostly ignorant about the mm, so bear with
> > me. :>
> >
> > I note the result of find_active_uprobe_speculative is immediately stale
> > in face of modifications.
> >
> > The thing I'm after is that the mmap_lock_speculation business adds
> > overhead on archs where a release fence is not a de facto nop and I
> > don't believe the commit message justifies it. Definitely a bummer to
> > add merely it for uprobes. If there are bigger plans concerning it
> > that's a different story of course.
> >
> > With this in mind I have to ask if instead you could perhaps get away
> > with the already present per-vma sequence counter?
> 
> per-vma sequence counter does not implement acquire/release logic, it
> relies on vma->vm_lock for synchronization. So if we want to use it,
> we would have to add additional memory barriers here. This is likely
> possible but as I mentioned before we would need to ensure the
> pagefault path does not regress. OTOH mm->mm_lock_seq already halfway
> there (it implements acquire/release logic), we just had to ensure
> mmap_write_lock() increments mm->mm_lock_seq.
> 
> So, from the release fence overhead POV I think whether we use
> mm->mm_lock_seq or vma->vm_lock, we would still need a proper fence
> here.
> 

Per my previous e-mail I'm not particularly familiar with mm internals,
so I'm going to handwave a little bit with my $0,03 concerning multicore
in general and if you disagree with it that's your business. For the
time being I have no interest in digging into any of this.

Before I do, to prevent this thread from being a total waste, here are
some remarks concerning the patch with the assumption that the core idea
lands.

From the commit message:
> Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
> vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
> attempting uprobe look up speculatively.

Just in case I'll note a nit that this paragraph will need to be removed
since the patch adding the flag is getting dropped.

A non-nit which may or may not end up mattering is that the flag (which
*is* set on the filep slab cache) makes things more difficult to
validate. Normal RCU usage guarantees that the object itself wont be
freed as long you follow the rules. However, the SLAB_TYPESAFE_BY_RCU
flag weakens it significantly -- the thing at hand will always be a
'struct file', but it may get reallocated to *another* file from under
you. Whether this aspect plays a role here I don't know.

> +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> +{
> +	const vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
> +	struct mm_struct *mm = current->mm;
> +	struct uprobe *uprobe;
> +	struct vm_area_struct *vma;
> +	struct file *vm_file;
> +	struct inode *vm_inode;
> +	unsigned long vm_pgoff, vm_start;
> +	int seq;
> +	loff_t offset;
> +
> +	if (!mmap_lock_speculation_start(mm, &seq))
> +		return NULL;
> +
> +	rcu_read_lock();
> +

I don't think there is a correctness problem here, but entering rcu
*after* deciding to speculatively do the lookup feels backwards.

> +	vma = vma_lookup(mm, bp_vaddr);
> +	if (!vma)
> +		goto bail;
> +
> +	vm_file = data_race(vma->vm_file);
> +	if (!vm_file || (vma->vm_flags & flags) != VM_MAYEXEC)
> +		goto bail;
> +

If vma teardown is allowed to progress and the file got fput'ed...

> +	vm_inode = data_race(vm_file->f_inode);

... the inode can be NULL, I don't know if that's handled.

More importantly though, per my previous description of
SLAB_TYPESAFE_BY_RCU, by now the file could have been reallocated and
the inode you did find is completely unrelated.

I understand the intent is to backpedal from everything should the mm
seqc change, but the above may happen to matter.

> +	vm_pgoff = data_race(vma->vm_pgoff);
> +	vm_start = data_race(vma->vm_start);
> +
> +	offset = (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_start);
> +	uprobe = find_uprobe_rcu(vm_inode, offset);
> +	if (!uprobe)
> +		goto bail;
> +
> +	/* now double check that nothing about MM changed */
> +	if (!mmap_lock_speculation_end(mm, seq))
> +		goto bail;

This leaks the reference obtained by find_uprobe_rcu().

> +
> +	rcu_read_unlock();
> +
> +	/* happy case, we speculated successfully */
> +	return uprobe;
> +bail:
> +	rcu_read_unlock();
> +	return NULL;
> +}

Now to some handwaving, here it is:

The core of my concern is that adding more work to down_write on the
mmap semaphore comes with certain side-effects and plausibly more than a
sufficient speed up can be achieved without doing it.

An mm-wide mechanism is just incredibly coarse-grained and it may happen
to perform poorly when faced with a program which likes to mess with its
address space -- the fast path is going to keep failing and only
inducing *more* overhead as the code decides to down_read the mmap
semaphore.

Furthermore there may be work currently synchronized with down_write
which perhaps can transition to "merely" down_read, but by the time it
happens this and possibly other consumers expect a change in the
sequence counter, messing with it.

To my understanding the kernel supports parallel faults with per-vma
locking. I would find it surprising if the same machinery could not be
used to sort out uprobe handling above.

I presume a down_read on vma around all the work would also sort out any
issues concerning stability of the file or inode objects.

Of course single-threaded performance would take a hit due to atomic
stemming from down/up_read and parallel uprobe lookups on the same vma
would also get slower, but I don't know if that's a problem for a real
workload.

I would not have any comments if all speed ups were achieved without
modifying non-uprobe code.

