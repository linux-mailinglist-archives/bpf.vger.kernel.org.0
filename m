Return-Path: <bpf+bounces-54084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30FEA6232C
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 01:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B113BDCD4
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 00:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FFF4A06;
	Sat, 15 Mar 2025 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2YS6Eo/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74D10F9
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741998863; cv=none; b=FAWtIwRV3zWC3oElvqpnjl8xqJ/WmV8/9P0HpfPtwSsdmK2wNOGPvn8BxcC7oES74gGU/XsKTvNQpD9CwkLnN85/dOlmn/m5C/6R30hVNClkv6TiRcRBavdQuycmnnD0l49hfItsh2oSFZuWAfnsjbLWEVCjI4NOo6DIa95Wb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741998863; c=relaxed/simple;
	bh=6iiflZ4de4w92IEmzHPrTo59KKlbBy2rGME6jB91mdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQzgyDsYd5RyWkdzzqGu8ifxkA2S7GqWEw1jCfjrAkizHdY+E9IZBlfTpYN6sc8/85a8cEQbKans253VWPXYVQ3nN/UpcPUb3faE4VrCcE4nEVZvflOjge7FJE60iR9+wtdZ9gI8DGV+sQh7vu5Azv10I5E60DPcA06RaBc8TW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2YS6Eo/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so1561888f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741998860; x=1742603660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGLTlaUNAQGNRgFcp7B7w74lXcxE7FcMiChs3RZNW/k=;
        b=K2YS6Eo/CSOuGQoYQbVIRMZV82LEGsLHWTGI9J3B6JckvYSsFedCNPAWaPjC8WCyJh
         ael6P8YVqnntfr0DgK3r+W1Khj2K0IZTceil6gPdzDk97NYFTqsHCwMBmiBaLj0bxXMf
         GoZ3Hztja4CevgeK/ssJFxLusP9Go8vMThIXevPr3XZk3KiwAQE+gnlniyQ2g756we8A
         hPGZHftKZoA6uU4gRwIqv+EffQo6qGxUIBXqiNJRzQWDc2E7jrlz4uXRaOd5LB37syfw
         iJ9zTEyarf7KgjgNUkHtdevDSZbjhkj1DisP3VmDASAkBwgfpltyf1RnC+g8PdD3e7Z8
         WP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741998860; x=1742603660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGLTlaUNAQGNRgFcp7B7w74lXcxE7FcMiChs3RZNW/k=;
        b=FUUXL5lkTRJhsptxQRwoxR0mt7qV9IB6fxP/iwnHPgPBDoPEukOkW/j+6sSEDP3rai
         wOfBPhd4TQ2hn7tx72/yxSbN6g/cgYb1KPH8qPrK5ffO4hdmtbSOU4mlC6roCBjJVc7n
         VnuNlljhWIBc8fL+I6Hkfd1KOgxEULJzhF8HIqNIlZYJs6B6w2GjTLPaZX8LRAqVNWCk
         9VdRTJMhl518uvqdhIJsAqx3jDOJpiCFLXQEoAkRE52okNrn7uscIkewsOJHb06vPM6N
         NrjIe95GKv45d8jJAL3THvl5QulFsfmi4pnwyKNUY0NE+j3XjVHrsJAMF1Fry6gHGQdv
         WgNA==
X-Forwarded-Encrypted: i=1; AJvYcCXauiyTEIz8GbetsdiZ04c6Dcry6fOAIZP6DiqIJb/w9LMwiWGRYz+89bhQisRQi0E4mmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMslptAJngsgjjn5OqcfoihVOs9Ch28IPLnfmWF4KUNYPtjwB
	cAiBv7MeqrbS52+rZ1SNHautmSir6Ser6aUm8OQBfniVwZrWcv0lQBXBUYhZW9+G2Xb1VLHcNUg
	vpOytinAEWK6uUqgbx2G1cnfwBtg=
X-Gm-Gg: ASbGncuwqKI+xF7S42F3VCsYz2SuEI+xThD6xMneaDnqEfWvEby6Auvkm7JHRSaf+qe
	kRXc46F21mYLzg4AiQkOGs+c+w7iuEFkMUc1gyqGV7CP1TiaeIrTxksgFSkhhrqzRUOt1rCyBkd
	1v3ih9oAnjDsEsDJWWrzGDVOevWbXK2vrRaUm3znDngQ==
X-Google-Smtp-Source: AGHT+IFsW4WwR/5hLucAOv60jvN7cIlIU5EYY9RLmRUSbV0nGZaDBUl96EggwZ7aPaaWgn0kBmhU7AzjYy8x8NJs88k=
X-Received: by 2002:a05:6000:1884:b0:391:31c8:ba6b with SMTP id
 ffacd0b85a97d-3971d03d345mr5580362f8f.10.1741998859888; Fri, 14 Mar 2025
 17:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com> <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com> <rbfpuj6kmbwbzyd25tjhlrf4aytmhmegn5ez54rpb2mue3cxyk@ok46lkhvvfjt>
In-Reply-To: <rbfpuj6kmbwbzyd25tjhlrf4aytmhmegn5ez54rpb2mue3cxyk@ok46lkhvvfjt>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Mar 2025 17:34:08 -0700
X-Gm-Features: AQ5f1JrNWO3fSZJO1zPwFJbgMywZJwL6VfHigqxS-tSZP78BuN9thxzpBtBiIhE
Message-ID: <CAADnVQ+Epu=s=Zu3OsrsDcbSGiLB0T-VXtdhQyTd3bpdV5PDOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, 
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:04=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Tue, Mar 11, 2025 at 02:32:24PM +0100, Alexei Starovoitov wrote:
> > On Tue, Mar 11, 2025 at 3:04=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Fri, 21 Feb 2025 18:44:23 -0800 Alexei Starovoitov <alexei.starovo=
itov@gmail.com> wrote:
> > >
> > > > Tracing BPF programs execute from tracepoints and kprobes where
> > > > running context is unknown, but they need to request additional
> > > > memory. The prior workarounds were using pre-allocated memory and
> > > > BPF specific freelists to satisfy such allocation requests.
> > >
> > > The "prior workarounds" sound entirely appropriate.  Because the
> > > performance and maintainability of Linux's page allocator is about
> > > 1,000,040 times more important than relieving BPF of having to carry =
a
> > > "workaround".
> >
> > Please explain where performance and maintainability is affected?
> >
>
> I have some related questions below. Note I'm a bystander, not claiming
> to have any (N)ACK power.
>
> A small bit before that:
>        if (!spin_trylock_irqsave(&zone->lock, flags)) {
>                if (unlikely(alloc_flags & ALLOC_TRYLOCK))
>                        return NULL;
>                spin_lock_irqsave(&zone->lock, flags);
>        }
>
> This is going to perform worse when contested due to an extra access to
> the lock. I presume it was done this way to avoid suffering another
> branch, with the assumption the trylock is normally going to succeed.

Steven already explained that extra trylock is a noise from performance pov=
.
Also notice that it's indeed not written as
if (unlikely(alloc_flags & ALLOC_TRYLOCK))
    spin_trylock_irqsave(...);
else
    spin_lock_irqsave(...);

because this way it will suffer an extra branch.
Even with this extra branch it would have been in the noise
considering all the prior branches rmqueue*() does.
With unconditional trylock first the performance noise is even less
noticeable.

> I think it would help to outline why these are doing any memory
> allocation from something like NMI to begin with. Perhaps you could have
> carved out a very small piece of memory as a reserve just for that? It
> would be refilled as needed from process context.

It's not about NMI. It's about an unknown context.
bpf and other subsystems will not be calling it from NMI on purpose.
It can happen by accident.
See netpoll_send_udp().
It's using alloc_skb(GFP_ATOMIC) which is the same as GFP_WISH_ME_LUCK.
netpoll is called from an arbitrary context where accessing slab is not ok.

> If non-task memory allocs got beaten to the curb, or at least got heavily
> limited, then a small allocator just for that purpose would do the
> trick and the two variants would likely be simpler than one thing which
> supports everyone.

Try diff stat of this patch vs diff of bpf_mem_alloc and other hacks
to see what it takes to build "small allocator".
Also notice how "small allocator" doesn't work for netpoll.
It needs an skb in an unknown context and currently pretends
that GFP_ATOMIC isn't going to crash.
Any context kmalloc will finally fix it.

