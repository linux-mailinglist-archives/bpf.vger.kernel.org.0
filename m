Return-Path: <bpf+bounces-78429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CED0C91A
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 511E830285B7
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748A3385B1;
	Fri,  9 Jan 2026 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2KjQrR7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E121C9EA
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002675; cv=none; b=MSY815ep++vhdCzI4Cgv1wwwcGsWPIZ7KX7z4kHYf6+JkoWY7XKsttPIlDowe9X1Nif903ZOGgIuXnZNT3HGT8jJ0Lz36LhT+Lewo+I5+Q1qNV3ikRIMFuvb+Yf8Cwq70SVR9xPgLfvWsdx1gpcdKtI512UNVQsYKOJJkDQOJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002675; c=relaxed/simple;
	bh=CoU7L7Dvw78UvQ3b8Y4jyHMTXf6htmudeyV9RZlTR/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhfjBW+M+65ErgHZhs+Dwg8cDINJjsC0KanAqsAZzcCLZjuUukphJzH3ipE7up6F1HsXyFdL8ECGjbwLh6vCjHDsZT27mo20YZ9JVFAtDxym9OTiDM14+/OuxyTvBCuKiSoNCv/m+OmHlsvyZDt3YrVW88D9I9c5Uw8op8Dv/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2KjQrR7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so2684988f8f.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 15:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768002672; x=1768607472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkEPmXZ96f0x8Jxg6AU3HOhNZWflSboslqCovElBuNA=;
        b=I2KjQrR77553x6nLzJlHvLyrnctHMAINn072HWUzvE4ipF8pQxbdZvIoh8El+rL8FA
         9CwpU3S9oi9b63Q+qdJrP9wp4112iBf3PfmhX7KKNOCTQPtwKgWlhwvfSJVVyE1bd4QS
         lgzgZ0XyLL0mB78HgfTSHXQrPdQMLGnxAeqYOFuP19+N732vyheaRvANohTd/YRnfT3z
         sE3NG4pLGKE2NprU+TJ1NrBD3SGHHQ/86k7SSn42fmTdeT/Uj7gRVHLka/d/Gxz8KsPc
         KdrW1GJ3nKTJE56jOf+9eU13QwwTj8uVahpsZveOynqBRpte5Iejhg41h/OKzGWYydhV
         f0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768002672; x=1768607472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkEPmXZ96f0x8Jxg6AU3HOhNZWflSboslqCovElBuNA=;
        b=q1xuDkmsk3OKR/ykeJ23atX5GV6njqKwBxW/jMdKlRbP0bUFGRKqhW07PqHnDe40qy
         XFup2+VHTh2i5B5sjPp6ctA6Y7G0fonJiFfwxYw5LRmjdgx2ykgKikWuQAuyiHaLM2Eq
         db243B32J0GjIQwAC5CjbwDXH4U1Ldpe1b7MhqbL/GadqtY7oPD6WRE7buYWIXzW9alg
         ctCOIFAfcqzYzlBsyujiGTAexic+cMlehFxLwYITHw5syC9WBXE5vqH7ZLz+yH0Th7Xr
         dS22443tTHgl5pFUZl8xPYZgPUoqDbNYj/UuPsGksqgosYQ3aPuNpg0tzus170v5XGpS
         5MHg==
X-Forwarded-Encrypted: i=1; AJvYcCXMeWn6uPrKcE51v3REuupaBhhzQSNOx4y/9ikePvTOa1rBif/w1pCrYc1wcnUzHLwTApc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLi803bmhrrokznHRy1yHbhDC6Bq6W0ca/WPBITLuurXsl1DOZ
	79SgoK6nBUCm+Kek8GDo7Hs8B27rr1QlcdQE4CE9Bk7GvXlWQnPQsCkVpBUYFHl9hSmHi3XVA2v
	uizh+o0OZ/m/PB0LvIXXijLe17Q/xdIE=
X-Gm-Gg: AY/fxX7PL0PwTJmpF7C5r3zMjBe0r7BaeARb2GLYH+57GGHz/xK9O2Fx24/J36cL6hB
	NIcnBLmTGvX2EglCOZqkjYECR3LZWuzhyHzCjUxpyGqNIWI03VrrQxZxamnd+8Q57T1lIvGv2SX
	48okBY8jCux7L6bq00XZk2xeQVZc/20Q+OqmmXmHTfJrmr8q7VcJTghgb7pFh4t0HIxYeRdOziX
	uj9ApQ/PCDW8LTS0+IMxwBXVaCQvwzBGJtCdY608GNEDfBe1n1/PHOp9LVQcEgS/X1Djheqra6A
	mH5mFBQs9HFCWBYayTTnF5OTPgkB
X-Google-Smtp-Source: AGHT+IEHMFuGHCKj+vRbTXKdqJQpbRYfDhPrfKyBL+akJ05GMYMtZ0LCEEsLwGA8WhNrkeap8RgSWBnOKNLWNkdP7SQ=
X-Received: by 2002:a5d:5850:0:b0:42f:bb08:d1f0 with SMTP id
 ffacd0b85a97d-432c3779051mr13318642f8f.60.1768002672266; Fri, 09 Jan 2026
 15:51:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com> <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
 <e4eee776-e9c7-4186-b239-733f81a9ae4a@gmail.com> <CAEf4BzYY0s6yF8JACTENANzJXd6abZctiB1iP+jYARq_xPDm0A@mail.gmail.com>
 <c5269858-7285-4e44-a5ef-72e69e9c00a2@gmail.com> <CAEf4BzZNGnufqerj=FY8K+oj3hpZ_xwzvOG5kPZN3UATACU_Dg@mail.gmail.com>
In-Reply-To: <CAEf4BzZNGnufqerj=FY8K+oj3hpZ_xwzvOG5kPZN3UATACU_Dg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 15:51:01 -0800
X-Gm-Features: AZwV_QhU289X5pT0oqDdIQ7Hal1FOZi_SxRFqQgTLIywYSp7SR1s9undmsYVN2Q
Message-ID: <CAADnVQLwDqcKSRHKy+F-mtOn85_QiBvwe+-=Zj2W6r-pbu=LPQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async operations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:47=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 9, 2026 at 10:22=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > On 1/9/26 01:18, Andrii Nakryiko wrote:
> > > On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Mykyta Yatsenko
> > > <mykyta.yatsenko5@gmail.com> wrote:
> > >> On 1/7/26 18:30, Kumar Kartikeya Dwivedi wrote:
> > >>> On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmai=
l.com> wrote:
> > >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> > >>>>
> > >>>> Introduce mpmc_cell, a lock-free cell primitive designed to suppor=
t
> > >>>> concurrent writes to struct in NMI context (only one writer advanc=
es),
> > >>>> allowing readers to consume consistent snapshot.
> > >>>>
> > >>>> Implementation details:
> > >>>>    Double buffering allows writers run concurrently with readers (=
read
> > >>>>    from one cell, write to another)
> > >>>>
> > >>>>    The implementation uses a sequence-number-based protocol to ena=
ble
> > >>>>    exclusive writes.
> > >>>>     * Bit 0 of seq indicates an active writer
> > >>>>     * Bits 1+ form a generation counter
> > >>>>     * (seq & 2) >> 1 selects the read cell, write cell is opposite
> > >>>>     * Writers atomically set bit 0, write to the inactive cell, th=
en
> > >>>>       increment seq to publish
> > >>>>     * Readers snapshot seq, read from the active cell, then valida=
te
> > >>>>       that seq hasn't changed
> > >>>>
> > >>>> mpmc_cell expects users to pre-allocate double buffers.
> > >>>>
> > >>>> Key properties:
> > >>>>    * Writers never block (fail if lost the race to another writer)
> > >>>>    * Readers never block writers (double buffering), but may requi=
re
> > >>>>    retries if write updates the snapshot concurrently.
> > >>>>
> > >>>> This will be used by BPF timer and workqueue helpers to defer NMI-=
unsafe
> > >>>> operations (like hrtimer_start()) to irq_work effectively allowing=
 BPF
> > >>>> programs to initiate timers and workqueues from NMI context.
> > >>>>
> > >>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > >>>> ---
> > >>> We already have a dual-versioned concurrency control primitive in t=
he
> > >>> kernel (seqcount_latch_t). I would just use that instead of
> > >>> reinventing it here. I don't see much of a difference except writer
> > >>> serialization, which can be done on top of it. If it was already
> > >>> considered and discarded for some reason, please add that reason to
> > >>> the commit message.
> > >> yes, multiple concurrent  writers support would is the main differen=
ce
> > >> between seqcount_latch_t and my implementation. I'll switch to
> > >> seqcount_latch_t and external synchronization for writers.
> > > One advantage of custom primitive is that we don't need a second
> > > atomic counter for writers. Here we combine the reader latch counter
> > > (it's just scaled 2x for custom implementation) and "writer is active=
"
> > > bit (even/odd counter).
> > >
> > > With potentially millions of timer activations per second for some
> > > extreme cases, would performance be enough reason to have custom
> > > "seqlock latch"? (I'm not sure myself, trying to get opinions)
> > >
> > Actually seqcount_latch_t variant may be faster (correct me if I'm wron=
g),
> > because mpmc_cell requires 2 lock prefixed instructions to enter the wr=
ite
> > critical section and seqcount_latch_t just 1.
> >
> > mpmc_cell:
> >
> > if (1&atomic_fetch_or_acquire(1, &ctl->seq)) // first lock prefixed ins=
n
> > return;
> > ...
> >        atomic_fetch_add_release(1, &ctl->seq);     // second lock
> > prefixed insn
> >
> > seqcount_latch_t based:
> >
> >      if (atomic_cmpxchg(&ctl->lock, 0, 1))        // first lock prefixe=
d
> > insn
> >          return;
> > write_seqcount_latch_begin(&ctl->seq);       // inc with barriers
> >      ...
> >      write_seqcount_latch(&ctl->seq);            // inc with barriers
> >      atomic_set(&ctl->lock, 0);            // plain mov on x86_64
> >
> > Does it look right?
>
> So I think you are overpivoting on atomic vs non-atomic differences
> here: when uncontended, atomic is almost as fast as non-atomic
> (difference is irrelevant). But under contention, those four writes
> due to separate latch is four cache line bounces (potentially) between
> competing CPUs, while with custom sequence logic it's just two.
>
> I'm not dead set on one approach or the other, but I don't think that
> latch adds that match value. But if Kumar or others insist on latch, I
> don't mind, in the end both will work.

I think it's worth writing a micro benchmark for it.
Intuitively I feel seqcount_latch_t approach will be faster
and it has all the kcsan annotation around it,
while this new primitive still needs work to teach kcsan
about it.

