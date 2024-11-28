Return-Path: <bpf+bounces-45813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1B9DB23D
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B127282849
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6683E13A24D;
	Thu, 28 Nov 2024 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOg+Mjnq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EE13D891
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768787; cv=none; b=roWjlT9AK0RGu2WrIwG+Dn1srgoLqa4zDvjIHJqRfDkQFae4Vi4ej+d647PwbhPW+2mbGQxQUA8M/6ougXGPKYWHncNAmnCXQVXjNXa/0GkzSfPjXg2BncHV6fdEvARCkCQZ5H8zb7r/NFdBXuWELz5k9MPVxNrMxFeOY4zBBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768787; c=relaxed/simple;
	bh=u2rrDWmtwgB69JXD3aUyzvYXhUyyQ8Qxj7DoT4YhCb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1XoxYFhaWQL6rm04SRjqF/Hc91LJAGIHXNvamIvS3wSufBD9nkI6BWuv0WMTS8kZjlnZkcL9109NYLCOlZboGFYMj2OEk5bXH70giiUO+WQbAcHPXXirbIQKFDXUGDVlKBJJ0/XKtgW9pZ0ice9zoZEjBJsNO9ZRIRcgg33d/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOg+Mjnq; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so836475a12.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 20:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732768783; x=1733373583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKaXhonmEqlC20xjjv/K6Quz7bX3O199fw6F7Nkn+4s=;
        b=VOg+MjnqKi3u/575PEybCrud/GPo1Aw3DkORoJygmej20JtHR7VRRu+Pkgljj85WZQ
         bI281efUwt/6E8EnOn6ZWDiAsB21omhbr3BKaaqVV/HyXxbhpeWixNNqge41Mq/af02d
         ke8je42B8TCKEHeYEefdJMWB8MwUS5jnlI+iMZzXwaBGP+q+mRN90LlW4EvLg8PMPN6N
         IBPZTnsufWnko6Yr7i65tZhy41usByIafSWDc4avL5UbYiS/e3AhjRSEwGqavhCT8Whz
         d4k5PuN5EIZU1hqGJYds004k8orEYmSHGwmcmyvNjjDVbF3kfRbJ78++c+rSUkaVuXjt
         fbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732768783; x=1733373583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKaXhonmEqlC20xjjv/K6Quz7bX3O199fw6F7Nkn+4s=;
        b=KxEZRTvl0U6AnTOvq4y7ZnIlZRc4tetna7hqn7l0eC250GvWZBLDgNPceoWu9B0q1s
         zY20QWIoqIcIaYsxtt8WD9FSXcpy/D7MZ5xEweYkkAMs5WMZufb3wfuy5XWOa3qQrSEa
         iMPCpkMaSdDSMy1uQx9KVQjUjvjLQDufDiXq03Zvs20PtzCLjTiwq7SKs6rv9wb/FGoa
         5S1bNistP/1LCBz/DASLnP9A++dg61TJ0J7ZHNOsbTu4xC0qdCjUnrxJ/aC3XUCpVNlC
         BtWxDNVLhEJ6Xv6L2TLSp9Cjl4b5aMz7cI9CeyiRvCYSv+E5Mka1v2Kz0RnHmYLXm7Ts
         CC6Q==
X-Gm-Message-State: AOJu0YxDAkJpfDTGzwqnL2mTWfgixtH8Jdhkh6Zad0H9dcfiHiuYbhiS
	dRV+etkKTfyiBw6+zEiXjl5dPmjt0TKtkHzDA5lRUPEaMkCcgVJZAOYao48ZdgFte46Wmd2+r6s
	hK3w0/+Egtikn2HWOycKj7mW3pzk=
X-Gm-Gg: ASbGncuc5MeLVWJhTEf15c/KLKK62Wn4mxGQbbUhbzCVEQGndeelqvDfsbaPlqvdNxv
	+OQt7pWtSIGo8aGUmKHfUsCTG+klY7WGkX1ezunE3o1f9gPXuGD08
X-Google-Smtp-Source: AGHT+IEVefjACMKEbo3j5pHHAkT2+GZ7ZO4DiYcrATE6DROjFy1ilcWf9nd6gUgy7t84xWXYbp4KcXjG7hBWcAjYMy0=
X-Received: by 2002:a05:6402:2348:b0:5d0:9ac3:deba with SMTP id
 4fb4d7f45d1cf-5d09ac3e0d1mr311286a12.16.1732768783405; Wed, 27 Nov 2024
 20:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165846.2001009-1-memxor@gmail.com> <20241127165846.2001009-5-memxor@gmail.com>
 <8559a9a9892311772778268eb9cee7c533a576d0.camel@gmail.com>
In-Reply-To: <8559a9a9892311772778268eb9cee7c533a576d0.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 05:39:07 +0100
Message-ID: <CAP01T75nGn+sXDoa6N8yj_prtaYZemdCZtm_sNOzE7KvZzzpOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 05:31, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-27 at 08:58 -0800, Kumar Kartikeya Dwivedi wrote:
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
> > Renumber the enums for REF_TYPE_* to simplify the check in
> > find_lock_state, filtering out non-lock types as they grow will become
> > cumbersome and is unecessary.
> >
> > To track a dynamic number of IRQ-disabled regions and their associated
> > saved states, a new resource type RES_TYPE_IRQ is introduced, which its
> > state management functions: acquire_irq_state and release_irq_state,
> > taking advantage of the refactoring and clean ups made in earlier
> > commits.
> >
> > One notable requirement of the kernel's IRQ save and restore API is that
> > they cannot happen out of order. For this purpose, when releasing reference
> > we keep track of the prev_id we saw with REF_TYPE_IRQ. Since reference
> > states are inserted in increasing order of the index, this is used to
> > remember the ordering of acquisitions of IRQ saved states, so that we
> > maintain a logical stack in acquisition order of resource identities,
> > and can enforce LIFO ordering when restoring IRQ state. The top of the
> > stack is maintained using bpf_verifier_state's active_irq_id.
> >
> > The logic to detect initialized and unitialized irq flag slots, marking
> > and unmarking is similar to how it's done for iterators. No additional
> > checks are needed in refsafe for REF_TYPE_IRQ, apart from the usual
> > check_id satisfiability check on the ref[i].id. We have to perform the
> > same check_ids check on state->active_irq_id as well.
> >
> > The kfuncs themselves are plain wrappers over local_irq_save and
> > local_irq_restore macros.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Sorry, two more nits below.
>
> [...]
>
> > +static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +     struct bpf_func_state *state = func(env, reg);
> > +     struct bpf_stack_state *slot;
> > +     struct bpf_reg_state *st;
> > +     int spi, i, err;
> > +
> > +     spi = irq_flag_get_spi(env, reg);
> > +     if (spi < 0)
> > +             return spi;
> > +
> > +     slot = &state->stack[spi];
> > +     st = &slot->spilled_ptr;
> > +
> > +     err = release_irq_state(env->cur_state, st->ref_obj_id);
> > +     WARN_ON_ONCE(err && err != -EACCES);
> > +     if (err) {
> > +             verbose(env, "cannot restore irq state out of order\n");
>
> Nit: maybe also print acquire_irq_id and an instruction where it was acquired?

Ack. For printing the insn_idx, I guess just search in the refs array?

>
> > +             return err;
> > +     }
> > +
> > +     __mark_reg_not_init(env, st);
> > +
> > +     /* see unmark_stack_slots_dynptr() for why we need to set REG_LIVE_WRITTEN */
> > +     st->live |= REG_LIVE_WRITTEN;
> > +
> > +     for (i = 0; i < BPF_REG_SIZE; i++)
> > +             slot->slot_type[i] = STACK_INVALID;
> > +
> > +     mark_stack_slot_scratched(env, spi);
> > +     return 0;
> > +}
> > +
> > +static bool is_irq_flag_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +     struct bpf_func_state *state = func(env, reg);
> > +     struct bpf_stack_state *slot;
> > +     int spi, i;
> > +
> > +     /* For -ERANGE (i.e. spi not falling into allocated stack slots), we
> > +      * will do check_mem_access to check and update stack bounds later, so
> > +      * return true for that case.
> > +      */
> > +     spi = irq_flag_get_spi(env, reg);
> > +     if (spi == -ERANGE)
> > +             return true;
>
> Nit: is it possible to swap is_irq_flag_reg_valid_uninit() and
>      check_mem_access(), so that ERANGE special case would be not needed?
>

I don't think so. For dynptr, iter, irq, ERANGE indicates stack needs
to be grown, so check_mem_access will naturally do that when writing.
When not ERANGE, we need to catch cases where we have a bad slot_type.
If we overwrote it with check_mem_access, then it would scrub the slot
type as well.

When I fixed this stuff for dynptr, we had to additionally
destroy_if_dynptr_stack_slot because it wasn't required to 'release' a
dynptr when overwriting it.
Andrii made sure this was necessary for iters so now slot_type ==
STACK_ITER is just rejected instead of overwrite without a destroy
operation.
Similar idea is followed for irq flag.

Just paging in context for all this, but I may be missing if you have
something in mind.

> > +     if (spi < 0)
> > +             return false;
> > +
> > +     slot = &state->stack[spi];
> > +
> > +     for (i = 0; i < BPF_REG_SIZE; i++)
> > +             if (slot->slot_type[i] == STACK_IRQ_FLAG)
> > +                     return false;
> > +     return true;
> > +}
>
> [...]
>

