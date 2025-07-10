Return-Path: <bpf+bounces-62977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718ACB00BE2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 21:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE96764B73
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E10D2FD5B5;
	Thu, 10 Jul 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiLgLxFe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD92FD581
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174816; cv=none; b=rmBAM/unkj3U7XFjies+kOUlKFrZSacc9W6b0r5GeaxT6sq2plnstlFMJOtNZYOnLKrSK5kZVFad8FxLEnqPPyBpx/r9/4nFC6TRZDW8reD8AAitZz5uFWzlFkGmbJ/9j2+eXWgqvqk54QHa8zcZ4KWAtMffTm9iFGASW3Q/JgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174816; c=relaxed/simple;
	bh=CFGrmKZ8DZFd3SI2Y2wbGbPZazEyJrzASjGG9KbPiT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6Qyd4F4CnmSh/cUJLAeJ/MezrXXRDt8J+kYJZCSS+tI4QAqAMiSLw2SJJkx1UJeHAL4PHqib3M06STU7kXQulhds+z+NCXkNQm1Hw7pHIXm+/X3ug1zncu4Ak078pTqzjkY45k1okgr0yOSSYSxPy5ywhbFliy538zVd36quIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiLgLxFe; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so978930f8f.0
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752174813; x=1752779613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSDipaTmyknuW2BzZpjf/e/oOZz6aMCp5qK19qTSz6M=;
        b=LiLgLxFeL0gYLCESMGqtAhu1M/2Rg+2Pn813HboxcUsIh+DGQwDkNIhqGtYi0KFMr5
         ThN64IjhRQFZ8FkWskl5yHos1GxNr0LbvvjTIB21DzRzhNjpquh6xg+EBQBrYo4w0ANZ
         5XEjlZjU8TBsXXNZrTcR1/gZ7OiJ2iCDU6Hr9CeYb3bDHd2XUiXrAKxIH3wYBIOQ2fsn
         +RoSn5aW50SXws0quuADYs/a5x+n6KrPPHyWKUGVFwl6f3Omtj6LfA1GZ13XZHCYLjtZ
         0ek2R4gPjQJoC1H0QksC0Mc6TtTHfS7bELfxm7YLXXPS875/HDXbUj1jsG4qW0/5r9dR
         Nd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752174813; x=1752779613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSDipaTmyknuW2BzZpjf/e/oOZz6aMCp5qK19qTSz6M=;
        b=skNsMpaKw7KA1drB0/byK1dgzh4VPxNw/Jdl/6XyTKDqQ74TJBRyjRsnhioNxQcizA
         shdhPRNvGhyFcWMOfw2dxZ8rtGssK4TBP6/H2vC04vYIT2F0gvZodzwu+LqSn3Z4tOBI
         3q3pRgkAq1qtSIU812/6om3B8v3eaLnNV7qxfabcUJqlggj5bFAZBosGm24WW4prKc+2
         WR9zP916+/gOQKQbXHEHMCDvOg4dTl+UZBkm3XBK940mniuqaxOHBUDxN44KnSpfEkmV
         7ZZgRcQw7ZgAhIw830a2wDa9wlDMUVFHrbw73hdKx90LaUX6Di00m/yiZW0QxWqvoZaO
         RDUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4c8DWT0fPHHXQK1RQQvpQK4H9tyWnJ2l3DoAlvzgfOIcWSG9PExp6WJt0cKnfnfKNV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwcz0I1PCCB4LgoymsyFUlfP4uQFELNCcwtbrQ8BbqUtEa7Hvi
	TnaDPdhTlCUb2JT1REutfsxHkgXXr63Eg42OKUFImFEbmMLnE4cRHTGWGc3iQJhQPsr9Y/2/v7F
	jz/0mi0h/Z5anksIc6geQrtoiggt00A8=
X-Gm-Gg: ASbGncu+uzHQcSB1+zk7LHs9WaC7fSaFHRYQGTBsWONVWHF4PDkarul1LK8UWQ0GwKI
	FUbfy4Szg7SEq3F47Hohn6YQdlGYyRJJ1Ynw+daUtAbYj527Wq4XnnZWtGe/03cxBMh6sVhCX10
	dpEUXDQTfXc59MVuI/M8pNxuGkmN0h4Pn5lsv5lPs0ml3ujdT+89Le364kr71T7cXAquIkOjq8
X-Google-Smtp-Source: AGHT+IGKE5Z771xbAvcCin6dH8cGHgjDHQcZF4e1IpfkK6WQQFkYdH1IJv69raJtJDWm7Ml9hcjqfz/jV8pohpsh7ao=
X-Received: by 2002:a05:6000:2b07:b0:3b4:9909:6fbd with SMTP id
 ffacd0b85a97d-3b5f1eb13a9mr242203f8f.29.1752174813061; Thu, 10 Jul 2025
 12:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com> <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
 <aG-UMkt-AQpu8mKq@hyeyoo> <e9bab147-5b36-4f9a-85b0-64740b84e826@suse.cz>
In-Reply-To: <e9bab147-5b36-4f9a-85b0-64740b84e826@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Jul 2025 12:13:20 -0700
X-Gm-Features: Ac12FXxmDklC5eyMf7HqxCceF1R9DFZLy2SVv-PFIEAVwNax10vLZ23Y2MZ3YFQ
Message-ID: <CAADnVQ+G340va8h2B7nNO00mWxbP_chx3oHW2PYrKt2AfOZS8w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 8:05=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/10/25 12:21, Harry Yoo wrote:
> > On Thu, Jul 10, 2025 at 11:36:02AM +0200, Vlastimil Babka wrote:
> >> On 7/9/25 03:53, Alexei Starovoitov wrote:
> >>
> >> Hm but this is leaking the slab we allocated and have in the "slab"
> >> variable, we need to free it back in that case.

ohh. sorry for the silly mistake.
Re-reading the diff again I realized that I made a similar mistake in
alloc_single_from_new_slab().
It has this bit:
if (!alloc_debug_processing(...))
  return NULL;

so I assumed that doing:
if (!spin_trylock_irqsave(&n->list_lock,..))
   return NULL;

is ok too. Now I see that !alloc_debug is purposefully leaking memory.

Should we add:
@@ -2841,6 +2841,7 @@ static void *alloc_single_from_new_slab(struct
kmem_cache *s, struct slab *slab,
                 * It's not really expected that this would fail on a
                 * freshly allocated slab, but a concurrent memory
                 * corruption in theory could cause that.
+                * Leak newly allocated slab.
                 */
                return NULL;

so the next person doesn't make the same mistake?

Also help me understand...
slab->objects is never equal to 1, right?
/proc/slabinfo agrees, but I cannot decipher it through slab init code.
Logically it makes sense.
If that's the case why alloc_single_from_new_slab()
has this part:
        if (slab->inuse =3D=3D slab->objects)
                add_full(s, n, slab);
        else
                add_partial(n, slab, DEACTIVATE_TO_HEAD);

Shouldn't it call add_partial() only ?
since slab->inuse =3D=3D 1 and slab->objects !=3D 1

> >
> > But it might be a partial slab taken from the list?
>
> True.
>
> > Then we need to trylock n->list_lock and if that fails, oh...
>
> So... since we succeeded taking it from the list and thus the spin_tryloc=
k,
> it means it's safe to spinlock n->list_lock again - we might be waiting o=
n
> other cpu to unlock it but we know we didn't NMI on our own cpu having th=
e
> lock, right? But we'd probably need to convince lockdep about this someho=
w,
> and also remember if we allocated a new slab or taken on from the partial
> list... or just deal with this unlikely situation in another irq work :/

irq_work might be the least mind bending.
Good point about partial vs new slab.
For partial we can indeed proceed with deactivate_slab() and if
I'm reading the code correctly, it won't have new.inuse =3D=3D 0,
so it won't go to discard_slab() (which won't be safe in this path)
But teaching lockdep that below bit in deactivate_slab() is safe:
        } else if (new.freelist) {
                spin_lock_irqsave(&n->list_lock, flags);
                add_partial(n, slab, tail);
is a challenge.

Since defer_free_work is there, I'm leaning to reuse it for
deactive_slab too. It will process
static DEFINE_PER_CPU(struct llist_head, defer_free_objects);
and
static DEFINE_PER_CPU(struct llist_head, defer_deactivate_slabs);

Shouldn't be too ugly. Better ideas?

