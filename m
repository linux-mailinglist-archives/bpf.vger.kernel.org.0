Return-Path: <bpf+bounces-22191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37BD858875
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 23:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06FE1C22962
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43941482FE;
	Fri, 16 Feb 2024 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F47QOLrP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6D12FF9B
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122324; cv=none; b=WdzHy9DmVfIo/spAMsmRl+Yz8XIWX6HmCbDXTTuh+MuGJCCztrFRzNz2MoODpTuUHk6JsE+GIITveNTYd2uc/ox2LUeUdR4EYGyKABKqKuUFe2jbb2S6zjqLOn79Z8Rg/uHQFlkS+HVPvtxd3MqCplia5Weq6mhV6M5HrXUGoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122324; c=relaxed/simple;
	bh=HPuIHYngSCI+L8UkXMAx/Hle/UAmvyYaziDhXf7daV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6c92d6WmkaKRsBczTOoIvmOzSIo2WOl9iZb2vhZYJ9YY/MBYJFquT/wMiKshBtZQ/J5O8nY6WJN2i6HODYJd5XZYjGywzz/R9Nd2TRQArdJqqb2VhXbrQ6uizXBo4LHneBAKk8cHEuWjLe+72xonBK8Abx67MZECrrls/9g41E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F47QOLrP; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so347249866b.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708122320; x=1708727120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V0yW84qIxDAA3pT0eQ1bXo/OMXtB81FgqaUiGlsxCKA=;
        b=F47QOLrP1B3I4Vt5iCOQTfUbkJCZP3Zy4+DIiFG/oH/DE3BmmUNowNf36/MLyC1S21
         4YjCDdTMqM8Lb+jgVlvs0IcUpwr0ZPgZk4MwniqJ67BUqYfRD6nH4RqCEQQJZAZ/omso
         qlX1DLCF+d+FD+ZLJ/EPN/1xsot4CjQqhHTSMjDmCGzV41fXKEWS7+71XxgjpV+w6Bww
         qtKjQYLtlbwxzifvtEegMK+KRjZLyDtLEjxF72m9BCbywKvlSC7NEIx+MjdtHhcmMq0K
         WVCZx10KPODQwzq/twMoatYvcCqcxo4yLlsgj8qKFmaxBaq8IT4Pzf6Z4rbWOodEzkn5
         DXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122320; x=1708727120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0yW84qIxDAA3pT0eQ1bXo/OMXtB81FgqaUiGlsxCKA=;
        b=w97qyIdAtOLBdXDTwUP+8ce5lzryZV3FRbAhQ6pKqfaR2xcYlNkBGzafReSOok4a12
         qI+AFHVbuQlZ8e+JDUTA+VbBWVmOQqgynXi/fbyGnuOsMBLPXrP94Ay9FlsyVc1x31K6
         uGLs15QYf9cSBw/qVdZQHGB48TwB4YNj5mxzQqt+b7Ub5UGBIeEdDBuFcOTfVvDz+xQE
         G4esxhA3kXMiV/VBPsoC2ayz+zs3hn30rSqaY6wkKhypCsCYckm5CG3spaBrFWoM+OOQ
         uta80Cxkk+NgqNLdb9u7ugUCyKeDWG5bdL+OX4Wa2JCbNG5DyJj6xBHBaiJcxDmJwrl1
         Vb6g==
X-Gm-Message-State: AOJu0YyvJ5/Gx3wpopnGJN1WpIMMxEVASQpDJgW47BUmjhRv/f0pPlmG
	1kctVnpv8I4zYCNqvsnkjj0sqxabSlV0oO4Zn6+1DoxMX0uJblh3H0r6e/gT7B/3wbhgRXKLbZ6
	sUtnE5s+9xONaypVhtGCAYv7XI5I=
X-Google-Smtp-Source: AGHT+IE5gd0OvLTftbF8WUG7P+Y8Zf4eUKALlbHy7r2jW7CnDwciKqaJzUoMbIYOKvDUSPYxDwT9t8hphZJSaNcOl9U=
X-Received: by 2002:a17:906:ae54:b0:a3d:bccb:a202 with SMTP id
 lf20-20020a170906ae5400b00a3dbccba202mr2993995ejb.40.1708122320395; Fri, 16
 Feb 2024 14:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-6-memxor@gmail.com>
 <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com>
In-Reply-To: <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 23:24:43 +0100
Message-ID: <CAP01T771G_K-LUHT8YKAk62OXwgzk0C1g2jEiTGXdS7nyPMYFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/14] bpf: Implement BPF exception frame
 descriptor generation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 19:24, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:
>
> Question: are there any real-life programs adapted to use exceptions
> with cleanup feature? It would be interesting to see how robust
> one-descriptor-per-pc is in practice, and also how it affects memory
> consumption during verification.
>

I tried it on sched-ext schedulers with this series with some helper
macros and it worked well.
I can post stats on memory consumption with the next version (or make
it part of veristat, whichever is more desirable).

I think the downside of this approach is when you have different
resources in the same register/slot from two different paths which
then hit the same bpf_throw. Surely, it will not work in that case the
way things are set up right now. But there are ways to address that
(ranging from compiler passes that hoist the throw call to the
predecessor basic blocks of separate paths when we detect such a
pattern, to emitting path hints of resource types during JIT which
bpf_throw can pick up), but I didn't encounter any examples so far
where this came up, and when it does, mostly you can rewrite things a
bit differently to make it work.

One of the changes though that I plan to make in the next posting is
keeping duplicate entries for the same resource around when the first
frame descriptor is created for a pc. This increases the chances of
merging correctly in case the second path intersects with us in some
slots, but for the purposes of releasing resources, that intersection
is sufficient.

Like you could have the same resource in R8 and R9, the second path
may only have it in R9 and not R8, both can merge, if we erase R8 (or
any other duplicates) in the original frame desc.

Right now, we simply do a release_resource so whenever we encounter
R8, we release its ref_obj_id and mark everything sharing the same id
invalid, so we never encounter R9 in the verifier state. In the above
case, these frame descs would not match but they could have if we had
discovered R9 before R8.

If you think this is not sufficient, please let me know. It is
certainly tricky and I might be underestimating the difficulty of
getting this right.

> The algorithm makes sense to me, a few comments/nits below.
>
> [...]
>
> > +static int find_and_merge_frame_desc(struct bpf_verifier_env *env, struct bpf_exception_frame_desc_tab *fdtab, u64 pc, struct bpf_frame_desc_reg_entry *fd)
> > +{
> > +     struct bpf_exception_frame_desc **descs = NULL, *desc = NULL, *p;
> > +     int ret = 0;
> > +
> > +     for (int i = 0; i < fdtab->cnt; i++) {
> > +             if (pc != fdtab->desc[i]->pc)
> > +                     continue;
> > +             descs = &fdtab->desc[i];
> > +             desc = fdtab->desc[i];
> > +             break;
> > +     }
> > +
> > +     if (!desc) {
> > +             verbose(env, "frame_desc: find_and_merge: cannot find frame descriptor for pc=%llu, creating new entry\n", pc);
> > +             return -ENOENT;
> > +     }
> > +
> > +     if (fd->off < 0)
> > +             goto stack;
>
> Nit: maybe write it down as
>
>         if (fd->off >= 0)
>                 return merge_frame_desc(...);
>
>      and avoid goto?
>

Ack, will fix.

> [...]
>
> > +static int gen_exception_frame_desc_stack_entry(struct bpf_verifier_env *env, struct bpf_func_state *frame, int stack_off)
> > +{
> > +     int spi = stack_off / BPF_REG_SIZE, off = -stack_off - 1;
> > +     struct bpf_reg_state *reg, not_init_reg, null_reg;
> > +     int slot_type, ret;
> > +
> > +     __mark_reg_not_init(env, &not_init_reg);
> > +     __mark_reg_known_zero(&null_reg);
>
> __mark_reg_known_zero() does not set .type field,
> thus null_reg.type value is undefined.
>

Hmm, good catch, will fix it.

> > +
> > +     slot_type = frame->stack[spi].slot_type[BPF_REG_SIZE - 1];
> > +     reg = &frame->stack[spi].spilled_ptr;
> > +
> > +     switch (slot_type) {
> > +     case STACK_SPILL:
> > +             /* We skip all kinds of scalar registers, except NULL values, which consume a slot. */
> > +             if (is_spilled_scalar_reg(&frame->stack[spi]) && !register_is_null(&frame->stack[spi].spilled_ptr))
> > +                     break;
> > +             ret = gen_exception_frame_desc_reg_entry(env, reg, off, frame->frameno);
> > +             if (ret < 0)
> > +                     return ret;
> > +             break;
> > +     case STACK_DYNPTR:
> > +             /* Keep iterating until we find the first slot. */
> > +             if (!reg->dynptr.first_slot)
> > +                     break;
> > +             ret = gen_exception_frame_desc_dynptr_entry(env, reg, off, frame->frameno);
> > +             if (ret < 0)
> > +                     return ret;
> > +             break;
> > +     case STACK_ITER:
> > +             /* Keep iterating until we find the first slot. */
> > +             if (!reg->ref_obj_id)
> > +                     break;
> > +             ret = gen_exception_frame_desc_iter_entry(env, reg, off, frame->frameno);
> > +             if (ret < 0)
> > +                     return ret;
> > +             break;
> > +     case STACK_MISC:
> > +     case STACK_INVALID:
> > +             /* Create an invalid entry for MISC and INVALID */
> > +             ret = gen_exception_frame_desc_reg_entry(env, &not_init_reg, off, frame->frameno);
> > +             if (ret < 0)
> > +                     return 0;
>
> No tests are failing if I comment out this block.
> Looking at the merge_frame_desc() logic it appears to me that fd
> entries with fd->type == NOT_INIT would only be merged with other
> NOT_INIT entries. What is the point of having such entries at all?
>

Assume you figured it out based on the other email.
Basically, creating entries so that no merge can occur for the slot.

> > +             break;
> > +     case STACK_ZERO:
> > +             reg = &null_reg;
> > +             for (int i = BPF_REG_SIZE - 1; i >= 0; i--) {
> > +                     if (frame->stack[spi].slot_type[i] != STACK_ZERO)
> > +                             reg = &not_init_reg;
> > +             }
> > +             ret = gen_exception_frame_desc_reg_entry(env, &null_reg, off, frame->frameno);
> > +             if (ret < 0)
> > +                     return ret;
>
> Same here, no tests are failing if STACK_ZERO block is commented.
> In general, what is the point of adding STACK_ZERO entries?
> There is a logic in place to merge NULL and non-NULL entries,
> but how is it different from not adding NULL entries in a first place?
> find_and_merge_frame_desc() does a linear scan over bpf_exception_frame_desc->stack
> and does not rely on entries being sorted by .off field.
>

Answered on the other email as well. I will add more tests for this case.
STACK_ZERO also creates NULL entries, we just treat them the same as
NULL reg and insert an entry using a fake reg initialized to zero.
Also I think we need to pass reg, not &null_reg in this case. Will fix
this part of the code and add tests.

While it does not rely on entries being sorted, we still find the one
with the same offset.
I can sort for a binary search at runtime, I was mostly worried that
constant re-sorting during verification may end up costing more when
the number of frame descriptors is low, but I think it makes sense
atleast for runtime when the array is only searched.

> > +             break;
> > +     default:
> > +             verbose(env, "verifier internal error: frame%d stack off=%d slot_type=%d missing handling for exception frame generation\n",
> > +                     frame->frameno, off, slot_type);
> > +             return -EFAULT;
> > +     }
> > +     return 0;
> > +}

