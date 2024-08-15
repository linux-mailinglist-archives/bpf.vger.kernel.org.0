Return-Path: <bpf+bounces-37287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40839539DE
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED1AB23C9E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E1605BA;
	Thu, 15 Aug 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuw16Ahz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788345B1E0;
	Thu, 15 Aug 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746272; cv=none; b=qOZwAHJs/ZuIDzW77R2EFFRfkECEZibrYcQBXPf9a1Rb9TASel6yL1+EM+0LVg/29devfT0gFuD466cVZF+MrmHumPnimhqm6z/ikNL/y8ofB18Th9DZoeuM+ES3HyxLNpAr0S6H3LiiVMQj8NFCdnyYrAduzz903KGywV1stw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746272; c=relaxed/simple;
	bh=HhpX9mFHejliR5elf1NsnfmL/ghUHSWa6TNyQGH0IYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5ZPp8JCXw4u5StYC7+KQwbgE8aDAU2tsClvGnRLeMDBLP6ONXG8qN09lIXsJCixjVEmiYdFFxxHQJKISV+xonEUipMBP4sbB57Ue8BWltYSJvhuKOwjyb891MV3D2X70X1slNLaZqbwd6L2QQKp3caIcBcOH5NlgRKI0Nnm7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cuw16Ahz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371893dd249so519198f8f.2;
        Thu, 15 Aug 2024 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746269; x=1724351069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KTOckrbLosoH+MqatNzZ6gxaYF4DiO7VwZNlqNUG40=;
        b=Cuw16Ahz6I4pncNyAGEqAg/sFlTTlYBYmwIR4v7LIYq6PPIJLe19JCu57nLG5Infr6
         HRDcmY71tjaKBx5CGiQgFS09ol+wf2MYp3w/1e1+wHEipw4EVF3nF9zseDA/Xq3m6wyB
         of3uEwmIhaKi7SSeobFz6kGVltLth5H6QnC5lJs4PzChem2z/Lgd9MitSdlbVhiBrpzg
         lG/PS1U1K/I3pFSUrXcsIUEpAfydusr4CBWbaimW6lchzuEOB21CMwin/A4JD/YI4CW6
         wfaYZ7kskz85AG1y1jAdeqQ/ngkjixQiTkvPz1p3RrxJ/W8HkS13ZaGuUqxPfbMyi9Nm
         wE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746269; x=1724351069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KTOckrbLosoH+MqatNzZ6gxaYF4DiO7VwZNlqNUG40=;
        b=Vn9lgFhD0duRw3ktxsuYvU7j7XmiDLFD+r3b4cOhVshOLvaIPuaaToh+KhM0yLRYor
         eXj9HniRphHdi/Bc3X0pCwO+3Cmw+DbASSI0hEC5fpQVx4QyjMJQriD8UpKxnna34Ohf
         9j6Fi2cZWnczygRnaBPWuqYSnrnVHCYyf7HCBbIwcxL75i5mmGlmVC6w7+I2Tj/1X2if
         q1bShGJVckMszUaUiqaJ40QI3k3P8MtabvGRhIuCbrlbDI3alx2yz8GzZtiQUICNPiGH
         d63QQC2xWXxKR/pF541f/kfs4za/JgqHovWV97arugIrkQEQQ/iCJVyNvywNmcwxAljo
         pZqA==
X-Forwarded-Encrypted: i=1; AJvYcCVmREJYubFkfOWExDJ2wpyd+vHTc7i1tqKVy6rDRUl2w0ZnVTPylc61UjufHjZnDJG766MJ65qQpJaWs0A/w0uL8uRw+8FkRRzUSTQ42Q3rYUjhFcmMO57pU+2cYTBc+m/yujOSxTPFBLeIPUCJ06Zg8OoA4NV6858ExD7ftjdXyELrAJZb
X-Gm-Message-State: AOJu0YxYd3Wa9Rw/y17nA2+dc29bKyjhLRw0otvk1HMmd/siCeVrWk+b
	Ous5TK4yIFOCh6QbtbtrHCVewbP1JpWOiDNeXfB3ITLClTowViomdFrDaCVl
X-Google-Smtp-Source: AGHT+IGQoj9gJ04NKNoIhlq7hwLmGKYPEgKnWxl/ceBsbuCi0I8Bo3zXwbffCScibD2/t+fV1OTjvQ==
X-Received: by 2002:adf:cc8c:0:b0:368:633c:a341 with SMTP id ffacd0b85a97d-3719445210fmr202041f8f.22.1723746268336;
        Thu, 15 Aug 2024 11:24:28 -0700 (PDT)
Received: from f (cst-prg-76-86.cust.vodafone.cz. [46.135.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a6ddsm2101099f8f.58.2024.08.15.11.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:24:27 -0700 (PDT)
Date: Thu, 15 Aug 2024 20:24:15 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to
 inode resolution
Message-ID: <guxwr4wzs5yt5ajrpwwpjdv6lbjf4dhgmjh7edrbc7lvevnh2o@joquw2jf6s4i>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-14-andrii@kernel.org>
 <7byqni7pmnufzjj73eqee2hvpk47tzgwot32gez3lb2u5lucs2@5m7dvjrvtmv2>
 <CAJuCfpG8hCNjqmttb91yq5kPaSGaYLL1ozkHKqUjD7X3n_60+w@mail.gmail.com>
 <o46u6b2w4b2ijrh3yzj7rc4c3outqmmtzbgbnzhscfuqsu4i4u@uhv65maza2d5>
 <CAEf4BzZ6jSFr_75cWQdxZOHzR-MyJS1xUY-TkG0=2A8Z1gP42g@mail.gmail.com>
 <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpGZT+ci0eDfTuLvo-3=jtEfMLYswnDJ0CQHfittou0GZQ@mail.gmail.com>

On Thu, Aug 15, 2024 at 10:45:45AM -0700, Suren Baghdasaryan wrote:
> >From all the above, my understanding of your objection is that
> checking mmap_lock during our speculation is too coarse-grained and
> you would prefer to use the VMA seq counter to check that the VMA we
> are working on is unchanged. I agree, that would be ideal. I had a
> quick chat with Jann about this and the conclusion we came to is that
> we would need to add an additional smp_wmb() barrier inside
> vma_start_write() and a smp_rmb() in the speculation code:
> 
> static inline void vma_start_write(struct vm_area_struct *vma)
> {
>         int mm_lock_seq;
> 
>         if (__is_vma_write_locked(vma, &mm_lock_seq))
>                 return;
> 
>         down_write(&vma->vm_lock->lock);
>         /*
>          * We should use WRITE_ONCE() here because we can have concurrent reads
>          * from the early lockless pessimistic check in vma_start_read().
>          * We don't really care about the correctness of that early check, but
>          * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
>          */
>         WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> +        smp_wmb();
>         up_write(&vma->vm_lock->lock);
> }
> 
> Note: up_write(&vma->vm_lock->lock) in the vma_start_write() is not
> enough because it's one-way permeable (it's a "RELEASE operation") and
> later vma->vm_file store (or any other VMA modification) can move
> before our vma->vm_lock_seq store.
> 
> This makes vma_start_write() heavier but again, it's write-locking, so
> should not be considered a fast path.
> With this change we can use the code suggested by Andrii in
> https://lore.kernel.org/all/CAEf4BzZeLg0WsYw2M7KFy0+APrPaPVBY7FbawB9vjcA2+6k69Q@mail.gmail.com/
> with an additional smp_rmb():
> 
> rcu_read_lock()
> vma = find_vma(...)
> if (!vma) /* bail */
> 
> vm_lock_seq = smp_load_acquire(&vma->vm_lock_seq);
> mm_lock_seq = smp_load_acquire(&vma->mm->mm_lock_seq);
> /* I think vm_lock has to be acquired first to avoid the race */
> if (mm_lock_seq == vm_lock_seq)
>         /* bail, vma is write-locked */
> ... perform uprobe lookup logic based on vma->vm_file->f_inode ...
> smp_rmb();
> if (vma->vm_lock_seq != vm_lock_seq)
>         /* bail, VMA might have changed */
> 
> The smp_rmb() is needed so that vma->vm_lock_seq load does not get
> reordered and moved up before speculation.
> 
> I'm CC'ing Jann since he understands memory barriers way better than
> me and will keep me honest.
> 

So I briefly noted that maybe down_read on the vma would do it, but per
Andrii parallel lookups on the same vma on multiple CPUs are expected,
which whacks that out.

When I initially mentioned per-vma sequence counters I blindly assumed
they worked the usual way. I don't believe any fancy rework here is
warranted especially given that the per-mm counter thing is expected to
have other uses.

However, chances are decent this can still be worked out with per-vma
granualarity all while avoiding any stores on lookup and without
invasive (or complicated) changes. The lockless uprobe code claims to
guarantee only false negatives and the miss always falls back to the
mmap semaphore lookup. There may be something here, I'm going to chew on
it.

That said, thank you both for writeup so far.

