Return-Path: <bpf+bounces-39395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5D972702
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 04:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7851F24AF7
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 02:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCAC143866;
	Tue, 10 Sep 2024 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/OocnOb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F31DFE8
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934172; cv=none; b=t2DOu3dtHKu0M8Z8EwDKuR+HuUzll6AdoKvKLm/vpBCOo4PmyTe0xtvnYcBvRjt3BDkG3BF8HHBCc18QJK6ofWjaXEsw2wes6ZCLRTbYk4nCMdAKIF08Je2e1Z25XL84u9cVCqUdgm+teTasSMhVcKPULHjrWeBfN9D6loX3xuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934172; c=relaxed/simple;
	bh=4QJVMCIR33jQXFT3WVOFZtJfYYiJkb86XBp+aRFY/ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItSUDMVp1ZTZjXlYyMsuvyx5uqtvOMYxSexX0scLcPBrSmlNMP/AoTi+zmtAb+/qMiFAgitJOzw0tIwzONV3yl9w5IDNK3bsvt5VLs/d6RxI+185G1M47JI1Wu0jt2XNN1m5josP98Au4bPIZG0Wia4rAcbG0ra1zZlw7Bmn5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/OocnOb; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso75825ab.1
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 19:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725934170; x=1726538970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DsQQhszRT2ef6P8hGH8RSEvant5C9m/wASSqO7/oIY=;
        b=V/OocnObVLe0gNU5HrQo8QrA6QbcHoEUr8hAT6+gDF6SWFz8WAskvkS8PKT8bV7hA/
         fPM6dpXvq///KYIMCrtrffGGI9Lq/hU0L1kwly+cZ2DAygi3N3hxkf5GP9L9U/vC58ry
         WdTdJBeWEKuIkjZGtT7ijkRaO+Aa8ev6QV71MLQ6HiciyAalOhlgcdoyDCUTMiGoOCag
         NyPgKoIU/bzaa68D/eCIJ7NpTvbq2wP3teLxNZtuWqNr4VnSMV4sbPQHs9mdozUup/M9
         443qr8VNyeTE3jTGRas4bjCzR8ZJULCWeuadvn4jVcuqV3RB06krz1LWAVj+rQ9ZS+0c
         6Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725934170; x=1726538970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DsQQhszRT2ef6P8hGH8RSEvant5C9m/wASSqO7/oIY=;
        b=VD8KawPHu3O4igoYhE2tMe8BXgtEdgJ7CXG1CgW6pnjvJyLvR2h7PDYbavOR/EmBb0
         MCeLf2FYeeiBZiRVWjwPSkWhg/6IQleVT1bV79NCnb8+Njgl4jkQlfkh0oyZhN1emr1+
         7nm4+QE4lWqGZGaAu3zAyMlcT5y0oVJXInu9QZRQIWDiqiNG3SibEHXdYTqAbaLPKVbL
         tVl5s8xC7A2aR4qMPsrHFqgZCbP7My5SNIh2wkjJmx97wcKAARJ/RTm8Q03IPncDnw7A
         06mQx5ltYT0eMexhMP1yXiUMPBRG+HkqlFUM/Ie+gZvTdesZaCtCPU1Yd21r3KTN/+Wl
         TNhw==
X-Forwarded-Encrypted: i=1; AJvYcCVHMkGCXRnY39BSWU5bg9VdG4ImpbxbDRfoPVbaKkx2urbfdSIifb+Nr+yRAPv0j0j29+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgjglknIJSjmNHRdnHnb3lHAtVyWZoO/v755rDRpkHZFgc115
	n8xrrEvex/EihXantVp8bvMsJcfouNb5gXTJ6ScKG5XUyMjN+CwoUKnUssF3u8J93QuKQjUzOvZ
	FDBDNFPGDXCSZMYrXcpgE/rs3PuvVZDdAd7LX
X-Google-Smtp-Source: AGHT+IGXDcSXioesg5+maD/YfxW9DxpNZWUOGcMd1XOPIFq3h8PpbcDkNkfD0lh+z2VUtMYBl1WO+LDOgNGnRPwmiRg=
X-Received: by 2002:a05:6e02:1c45:b0:377:14ab:42ea with SMTP id
 e9e14a558f8ab-3a06bae3ad1mr1954975ab.16.1725934169925; Mon, 09 Sep 2024
 19:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-2-andrii@kernel.org>
 <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com>
In-Reply-To: <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 9 Sep 2024 19:09:15 -0700
Message-ID: <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
To: Jann Horn <jannh@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:35=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int=
 seq)
> > +{
> > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> > +}
>
> A load-acquire can't provide "end of locked section" semantics - a
> load-acquire is a one-way barrier, you can basically use it for
> "acquire lock" semantics but not for "release lock" semantics, because
> the CPU will prevent reordering the load with *later* loads but not
> with *earlier* loads. So if you do:
>
> mmap_lock_speculation_start()
> [locked reads go here]
> mmap_lock_speculation_end()
>
> then the CPU is allowed to reorder your instructions like this:
>
> mmap_lock_speculation_start()
> mmap_lock_speculation_end()
> [locked reads go here]
>
> so the lock is broken.

Hi Jann,
Thanks for the review!
Yeah, you are right, we do need an smp_rmb() before we compare
mm->mm_lock_seq with the stored seq.

Otherwise reads might get reordered this way:

CPU1                        CPU2
mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
reloaded_seq =3D mm->mm_lock_seq; // reordered read
                                 mmap_write_lock() // inc_mm_lock_seq(mm)
                                 vma->vm_file =3D ...;
                                 mmap_write_unlock() // inc_mm_lock_seq(mm)
<speculate>
mmap_lock_speculation_end() // return (reloaded_seq =3D=3D seq)

>
> >  static inline void mmap_write_lock(struct mm_struct *mm)
> >  {
> >         __mmap_lock_trace_start_locking(mm, true);
> >         down_write(&mm->mmap_lock);
> > +       inc_mm_lock_seq(mm);
> >         __mmap_lock_trace_acquire_returned(mm, true, true);
> >  }
>
> Similarly, inc_mm_lock_seq(), which does a store-release, can only
> provide "release lock" semantics, not "take lock" semantics, because
> the CPU can reorder it with later stores; for example, this code:
>
> inc_mm_lock_seq()
> [locked stuff goes here]
> inc_mm_lock_seq()
>
> can be reordered into this:
>
> [locked stuff goes here]
> inc_mm_lock_seq()
> inc_mm_lock_seq()
>
> so the lock is broken.

Ugh, yes. We do need smp_wmb() AFTER the inc_mm_lock_seq(). Whenever
we use inc_mm_lock_seq() for "take lock" semantics, it's preceded by a
down_write(&mm->mmap_lock) with implied ACQUIRE ordering. So I thought
we can use it but I realize now that this reordering is still
possible:
CPU1                        CPU2
                                 mmap_write_lock()
                                       down_write(&mm->mmap_lock);
                                       vma->vm_file =3D ...;

mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
<speculate>
mmap_lock_speculation_end() // return (mm->mm_lock_seq =3D=3D seq)

                                       inc_mm_lock_seq(mm);
                                 mmap_write_unlock() // inc_mm_lock_seq(mm)

Is that what you were describing?
Thanks,
Suren.

>
> For "taking a lock" with a memory store, or "dropping a lock" with a
> memory load, you need heavier memory barriers, see
> Documentation/memory-barriers.txt.

