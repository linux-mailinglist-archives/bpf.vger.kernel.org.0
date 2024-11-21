Return-Path: <bpf+bounces-45417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FCE9D552B
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863AB283839
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA381DC054;
	Thu, 21 Nov 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnKVKvcw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663F176AC7
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226823; cv=none; b=Q1xNvqLpl457Ry8RiZauZMzfQS72tTxT9NoJfz+1L6+vZIK2luNGUuWX3kn2slJbC2aWL/VnMHu6yGxP7EAZa6hMDI4CJwE+tbPKx5IJEM/ykQFMAWeaxpk59o7N19Pevvv/VqY2ITHThxDRV08jHs49M/rOZnbwihsJm26IA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226823; c=relaxed/simple;
	bh=ahy+yBU4dMzY+25VBJr8cWPjOs5Bsmkj+0bpMGJvXSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJklAfoebh8uggWdNP8jiCicKmXrPlYwYcsXN6uuzL0ZI3mocrxIYi3+tM7lemCjz4ZP1Zwhsq0cdDzLOUYSDY2fzVaNHgS8GbcGxBolClYd4PxX9xS6Hkpdf5fmGJVoo3XjDYIZxZyeI8qP15TJHT7nt7ZGhB/hrUWEYutQP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnKVKvcw; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso4431967a12.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 14:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732226820; x=1732831620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqpaqv4MAji4EzBHx5rLDApluUmIduIaNGKpaEGxGZ8=;
        b=bnKVKvcwd6+/ZTgP5lz5Pctod6mbTWtjCDsLfl1zLH+zhEgnIil505cUbR/1ELTqPa
         GwUiq+pAHDsBBbfUOtnK5AWFDw7NlcXtO96Y0LWjYKVZMbFpX732Kupg3f4bRuMBy2wB
         g5VTASB9CB6y9BuhPSLhGfrsJZp6zacpqfMnCxu9gmAXyJYefwgyF4bZAj91rh6t7/dJ
         AYLliNC+y8X1wHl3MxWYs8BR7rIwi0pifvxKdWKpd7YIkFXaBlJhlJJ8qzzue17DWnRH
         dXzH8DqGNYXhG8mpNPO5HTs7xvQqg9ThOzu6jR0U7BnTF2+vfPsvj1VXY6UeKcCKfmx0
         qqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226820; x=1732831620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uqpaqv4MAji4EzBHx5rLDApluUmIduIaNGKpaEGxGZ8=;
        b=KHC7jRA7TZsJroBk7mRVZz4//oNczB8j5grsvYMg2pC9vxNLz6a0MhXDUeAl3lv3dZ
         OHuqrTmiYyWIrTaZAjj8ixDXDC0HJ7y+wSXXDtTLXmXU/ba5V1y2eqsShpzHxS3pZgcy
         ZL4+kCB6M3gURzdRDgJ41/Sy5EqMz6jLxo1JwUACjkTmgQgSJmDoT2/Es310eGkgZBU0
         wQOJhxQ0nw/LMUvawa2xdLFArrsdRhxu14ET6/Yj5w/3KqF+LVmuRn2b+9Ai9+su9/K3
         L12cLYEi18nsRksWqRzu17D5zexOQjtIGbVxnMFI29ruH/i119KnvJjpap+Oxe2CysfV
         TKSw==
X-Gm-Message-State: AOJu0Yy1lmoqCVJMd0hlc1QlQPCaa51xP8IqYUqItSPRCBKKYJ5A+HlI
	DydD0O6xHWemiryD4T7chPBWAAhQewUOOrE2jDNOb8nSO7NlBRT+G9a1tfHWdZBXk417nYj1RGM
	f16PK/x7Sy66XnrLQLFJ5Oms11I8=
X-Gm-Gg: ASbGncvEJlSPA2Jd3BrxEA4xNSJMKWCADRs6rQW+mTB8CVzFkyaYsT5iPunaPOKZrcS
	PKit/yMuALxJ9OH/IikzRUDmDcpnZZuun4w==
X-Google-Smtp-Source: AGHT+IHZOp0y1yk24CgrQLzKMIVyl9inhYP4KCb7SxnygyNaSNQcyTan1lHdaDl+21SmxToihtOMNeyhutRDmJWZXeU=
X-Received: by 2002:a05:6402:2548:b0:5cf:74c0:b4af with SMTP id
 4fb4d7f45d1cf-5d007ca45fcmr5182165a12.13.1732226820249; Thu, 21 Nov 2024
 14:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-6-memxor@gmail.com>
 <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com>
In-Reply-To: <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Nov 2024 23:06:23 +0100
Message-ID: <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 21:21, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > Teach the verifier about IRQ-disabled sections through the introduction
> > of two new kfuncs, bpf_local_irq_save, to save IRQ state and disable
> > them, and bpf_local_irq_restore, to restore IRQ state and enable them
> > back again.
> >
> > For the purposes of tracking the saved IRQ state, the verifier is taught
> > about a new special object on the stack of type STACK_IRQ_FLAG. This is
> > a 8 byte value which saves the IRQ flags which are to be passed back to
> > the IRQ restore kfunc.
> >
> > To track a dynamic number of IRQ-disabled regions and their associated
> > saved states, a new resource type RES_TYPE_IRQ is introduced, which its
> > state management functions: acquire_irq_state and release_irq_state,
> > taking advantage of the refactoring and clean ups made in earlier
> > commits.
> >
> > One notable requirement of the kernel's IRQ save and restore API is that
> > they cannot happen out of order. For this purpose, resource state is
> > extended with a new type-specific member 'prev_id'. This is used to
> > remember the ordering of acquisitions of IRQ saved states, so that we
> > maintain a logical stack in acquisition order of resource identities,
> > and can enforce LIFO ordering when restoring IRQ state. The top of the
> > stack is maintained using bpf_func_state's active_irq_id.
> >
> > The logic to detect initialized and unitialized irq flag slots, marking
> > and unmarking is similar to how it's done for iterators. We do need to
> > update ressafe to perform check_ids based satisfiability check, and
> > additionally match prev_id for RES_TYPE_IRQ entries in the resource
> > array.
> >
> > The kfuncs themselves are plain wrappers over local_irq_save and
> > local_irq_restore macros.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> I think this matches what is done for iterators and dynptrs.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -263,10 +267,16 @@ struct bpf_resource_state {
> >        * is used purely to inform the user of a resource leak.
> >        */
> >       int insn_idx;
> > -     /* Use to keep track of the source object of a lock, to ensure
> > -      * it matches on unlock.
> > -      */
> > -     void *ptr;
> > +     union {
> > +             /* Use to keep track of the source object of a lock, to ensure
> > +              * it matches on unlock.
> > +              */
> > +             void *ptr;
> > +             /* Track the reference id preceding the IRQ entry in acquisition
> > +              * order, to enforce an ordering on the release.
> > +              */
> > +             int prev_id;
> > +     };
>
> Nit:  Do we anticipate any other resource kinds that would need LIFO acquire/release?
>       If we do, an alternative to prev_id would be to organize bpf_func_state->res as
>       a stack (by changing erase_resource_state() implementation).

I don't think so, this was the weird case requiring such an ordering,
so I tried to find the least intrusive way.

>
> [...]
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 751c150f9e1c..302f0d5976be 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3057,6 +3057,28 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
> >       return ret + 1;
> >  }
> >
> > +/* Keep unsinged long in prototype so that kfunc is usable when emitted to
> > + * vmlinux.h in BPF programs directly, but since unsigned long may potentially
> > + * be 4 byte, always cast to u64 when reading/writing from this pointer as it
> > + * always points to an 8-byte memory region in BPF stack.
> > + */
> > +__bpf_kfunc void bpf_local_irq_save(unsigned long *flags__irq_flag)
>
> Nit: 'unsigned long long' is guaranteed to be at-least 64 bit.
>      What would go wrong if 'u64' is used here?

It goes like this:
If I make this unsigned long long * or u64 *, the kfunc emitted to
vmlinux.h expects a pointer of that type.
Typically, kernel code is always passing unsigned long flags to these
functions, and that's what people are used to.
Given for --target=bpf unsigned long * is always a 8-byte value, I
just did this, so that in kernels that are 32-bit,
we don't end up relying on unsigned long still being 8 when
fetching/storing flags on BPF stack.

>
> > +{
> > +     u64 *ptr = (u64 *)flags__irq_flag;
> > +     unsigned long flags;
> > +
> > +     local_irq_save(flags);
> > +     *ptr = flags;
> > +}
>
> [...]
>
> > @@ -1447,7 +1607,7 @@ static struct bpf_resource_state *find_lock_state(struct bpf_func_state *state,
> >       for (i = 0; i < state->acquired_res; i++) {
> >               struct bpf_resource_state *s = &state->res[i];
> >
> > -             if (s->type == RES_TYPE_PTR || s->type != type)
> > +             if (s->type < __RES_TYPE_LOCK_BEGIN || s->type != type)
>
> Nit: I think this would be easier to read if there was a bitmask
>      associated with lock types.

Ack, will fix.

>
> >                       continue;
> >
> >               if (s->id == id && s->ptr == ptr)
>
> [...]
>

