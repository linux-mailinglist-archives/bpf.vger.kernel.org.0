Return-Path: <bpf+bounces-61203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2391AE228F
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 20:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62D616C136
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F2B2EA142;
	Fri, 20 Jun 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3Vvkb73"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CA1FBEA6
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445576; cv=none; b=rTYZ3Yxg8DTPuC8k3fHtDh2HQ63xrwDJu6Xsfc2ln5aYBuniVwivgNBzRmpteZhpP4uz1w1pbkWfcdCDGbUbZ0En+F0NBShNMD8LmMhM1oKHpkW+KJtYZx3sIcYv1T/mlIKBsECi01YRP0RVwFxtGw9E55cWv06ToZUKG9Iocdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445576; c=relaxed/simple;
	bh=08yixC0y7NXL4FK5sfCom7kQTe4vWtLCJmrdk9Sk6+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxA4xh70q+rJxXG3M7OiwMq1Jh4+x+H3BuYYj1hZfTV5BSISYGBbbDxoLMOy13wrYLOX5FlJgtnBoLm2UBfJFeUnBz98L+/NRxFjDVzVOUMirby18cr0B0hBdFFR1Qf9esu7G+OoArMLr8wp7b3bcssVjI12AF10jV/txm2ikJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3Vvkb73; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so369412466b.2
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445573; x=1751050373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o56iDFQR7hs3yH9d8LmXDQqgOG8BsG15rDuoYbq5NQ=;
        b=X3Vvkb73YoJKP16WClhJa4UzEeGFzzIbA4VIqfYRFKyuPUwO3C0IYS0/amslKPb/Mk
         HbdNH3QZgj8af+mdPAhvz8U2YM3+cryIrm0X7pFzEmPhkafpKw940X5G7YAYG2XleCMc
         HcmJ6sT7GVyA9BZeNfqsaR58yFidVOCLxe62RcZeAwyZ5RuZrrqfZ2FluY0A205GgfY0
         QHtkaOKKD3GVHUzHd8MRt4/okX8EkEekBLFbZruO3MwysnolNguVYhl/oJv0RE1FDcqD
         dkNCvzBbwpfW/SsVZVB2gLgfKj8XmjKGbvCNQmPHlUtqe+yrnaLyK5ta7eOuT9i5pcAM
         zcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445573; x=1751050373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o56iDFQR7hs3yH9d8LmXDQqgOG8BsG15rDuoYbq5NQ=;
        b=RExvuXqTdLpcMOSZYGr6XDw/OKi5PeY4THLLvNhLeGcSnoIjvDLl5vYXw+LeP52Fh+
         CdFhDBrE37jLdK08GKucjil+10a2BgcpDzJXmvJF4fxQ48CncSROV2B+fphbNufrjdHM
         k0bRKFelnpnrpqDxwuDkjJGBGAryM0BwzxqWLE5McZdp4JuQGh0B1CwrTLmX1UMt6R/5
         J3Iy/iQ6Ft4GEheE6XmQ0FxFUVQ/o4aaLDy6y2jf5j5m278TxvTFHicDjQ7unzeh3x78
         zTHjM5rrXo+Q3oLI6382SR9wOiQLn0lvjtlornY4Hjp6GVVTJuJOLGuZLPiCEWPlgUIQ
         X0DA==
X-Forwarded-Encrypted: i=1; AJvYcCWqt1VH03LnGDM4sLtGC0DAr0dmpB974C9IkekQzVtpUWBwxEn02SqmOGjXV6DIZ03hU+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxORojH9SuWld+rD0TGURqjCrT94q8cjS+IKj07OlBjWGYTErKb
	YHD1PI0ZscKoRxPy9PNEKEWrPWCkFLy33eNM2wEw+7rc5qZUISZdWarJwr74m1pqHl+eHH+d5+w
	g57PP72cMH+N23WDM9DUQ/9L1XyDe+FI=
X-Gm-Gg: ASbGncuK3BQBUidokPv3lUl/rhyst0dCAQ71OSufz5lfXTRURkDDVlUaBalvQnotAf5
	RnzigQPGL8J8Pvs02Ys04Fqrd9wo2ew8en1sI2rQiHfNjVa6+5/YrMaWmiXpDWqrKO3fB2MPwYq
	J5EiBrcUCZV9Vt9zfiPt34HkvspufLNEvhIgMFhvNUsvcG
X-Google-Smtp-Source: AGHT+IFHtDdBP7TdowJEWUmCCXWa66KE0hIS4P31Kt5KVd7uy+/hVu5A2xn+RDxlQV/zmSP2IW+fMkmzjeiLWWwuWww=
X-Received: by 2002:a17:907:6d17:b0:ad8:9d41:371e with SMTP id
 a640c23a62f3a-ae057b8939bmr396722366b.36.1750445572623; Fri, 20 Jun 2025
 11:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620031118.245601-1-emil@etsalapatis.com> <20250620031118.245601-2-emil@etsalapatis.com>
 <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
In-Reply-To: <CAADnVQ+m3mRoiiFwbYsVb8rbcsTy0dgS7amYn82y7wgyv5U1Yg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 20 Jun 2025 20:52:15 +0200
X-Gm-Features: Ac12FXzEIyVq_XluXEp8sOoDRVa_qsKwWVSz2yTpVlWEgFPeyD3XSa550_BqDto
Message-ID: <CAP01T74rJKXqG5QHV=rXsou33_vfTp7vBZxHC5Qo2G_Vv3V9Dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jun 2025 at 20:44, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 19, 2025 at 8:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
> >
> > Add a new BPF arena kfunc from protecting a range of pages. These pages
> > cannot be allocated, either explicitly through bpf_arena_alloc_pages()
> > or implicitly through userspace page faults.
> >
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 92 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 0d56cea71602..2f9293eb7151 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -48,6 +48,7 @@ struct bpf_arena {
> >         u64 user_vm_end;
> >         struct vm_struct *kern_vm;
> >         struct range_tree rt;
> > +       struct range_tree rt_guard;
>
> ...
>
> >  }
> > @@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm_fault *=
vmf)
> >                 /* User space requested to segfault when page is not al=
located by bpf prog */
> >                 return VM_FAULT_SIGSEGV;
> >
> > +       /* Make sure the page is not guarded. */
> > +       ret =3D is_range_tree_set(&arena->rt_guard, vmf->pgoff, 1);
> > +       if (ret)
> > +               return VM_FAULT_SIGSEGV;
> > +
> >         ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
>
> Why complicate things with another tree ?
> The logic has to range_tree_clear(&arena->rt, ... anyway
> and here check:
> is_range_tree_set(&arena->rt, ...
>
> bpf_arena_guard_pages() won't have EALREADY errors, so be it.
> Keeping another range_tree and spending kernel memory
> just to produce an error to buggy bpf prog is imo wrong trade off.

IIUC the main requirement is reserving a region that cannot be faulted
in user space, and cannot be allocated from the BPF side.
I would instead add a flag that when set overrides the SIGSEGV/page-in
behavior (which can be set globally by a flag on the map).
That sounds more generic and potentially useful to pick the behavior
on a per-allocation basis instead of making it global.
So for specific allocations, we get SEGSEGV instead of paging in
memory, while for the rest it's the default based on map's flags.
And to prevent anybody else from allocating this range, reserve it
ahead of time in the scheduler's init() callback.
For normal programs it can be an extra prog run before the program is
attached and starts firing.
We won't need a new kfunc either.

