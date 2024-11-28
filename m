Return-Path: <bpf+bounces-45809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95969DB22E
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20940B22D05
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74C137742;
	Thu, 28 Nov 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjnGnabA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492702745C
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768267; cv=none; b=UykLflNVJ99xWh54WLO1xPGr7Eg9oOPTISYnCFRLH94kvTufkxWt3AqpIzvfXQfE390tUIER4BbarFvV844GL86I6gyfT5qJk19jD8Kw1WhfGZ5jkXZyutzOFBGvTe1/2c13IQ98SwaUmn6hciPGD56+04UMZZ7WEH1J1YzeWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768267; c=relaxed/simple;
	bh=CK53KRHG+2Mlkxo0cFwkdOIqW1mSgBfUu/3qnSsI+sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzJkz5TBTEcGhCc0YNFie2gyqblxUGrAgLCEzYai6CB8AtVKChXM2XD1wNer+L9H7pZhOzD6TD6+5npMZGCKz/zlJbTS3BfRk4bzemMfB2PPX3C/10V7cfegVp/Mh7x2YDtJxkMiGyBdWx4+pyjKLveQ0a5P7o58TiXqBu8qiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjnGnabA; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso517424a12.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 20:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732768264; x=1733373064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wiH81K4MmG1H6/XcGqxD8VR/2uhnDXx4rJbwp8slP+g=;
        b=gjnGnabAEk46XekqB7KifGiW7VJjH55MTRdlvLYKL8GHiVBduOuhWFmBeSVrtLIMs2
         QNtBZjN3svroZLZXypaQHLAudBoB1BiOy31HQn390cvyeNoFLrNN09hEjQPUNG/TQM2Y
         k70yl0Nzo8NuCVnQBni0MKl5mJtMw32FZca+qTUcRp0n7Q67qQ86dBeE/EdSBmuG3ajs
         Prdz0meKuaQq/s1++daYCDmPAQMnf2YGT9eOC1Dz3WZVghxnanhQSgYaGqLDw1HH7the
         UyfyOhuoLf+78AdhWUUPa9xPVkHx29u2Cg6g3GRFtk60eJ9HqqVBOm+sNnGRU8OhN/ES
         nbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732768264; x=1733373064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiH81K4MmG1H6/XcGqxD8VR/2uhnDXx4rJbwp8slP+g=;
        b=F8j+RgiL3JqmfCHOePJjWtgs+MNNe008IpSb8TJBXttidiVnB/xeLK+qF0bw+HS305
         ODdNVLCTTpmJs6pkD143BHuLqERuMDPnGOe9gIgVrTMJ4Sr4/WAwzD7J1iEU/Y9pPGMQ
         vXoMlm3crZ97XjTKSbftjHRXzjC+guqApxDwUUY1oiGzAgyl0WPS0dilnuXRhhiapYVM
         C0KV5/1dTDmLeqnFbxd5YgRhliMUxos5BatVOS1Bi1H2rnoNMr0yIuYvdjjZdQFIdoF+
         CXC6Fni1xp/hgCbA2pXnl5nZLn5OOhhom+HHE+nxWwGhleDOaoBLhfiGrn7QaFIjkI9C
         JJZw==
X-Gm-Message-State: AOJu0YxPCeRJXd1nZZ+c2Db18rBxs6gGH3mepHhzQHKPGRSNQ49ETrHb
	CE2FEJ7XJ5p5t4zbYkXI3qe5i7Af4PgWaTpB5BETgRibEv4mjH9fMEzZe0LIVbI6ernEQdpaBGc
	0HKYa5Tl3b9zXWAvDuVkWgslx4Is=
X-Gm-Gg: ASbGncty+XQlqekL+QL1psSdmBmBpc/u/lAUGgT3zMaVZIODFNoz+0r7qKr+x9M83gq
	YRbTl0PIGznGJ3faNCJ/f/uk2Z+/FQyPQsVy9iB1wZG5fUkqOgHIG
X-Google-Smtp-Source: AGHT+IG1Bd/oe9pSqwUhNxwEMFXHEByOuQWoh00awFJ75VGQnCucntsLH7L1TIzjXXajmdb/0DQcOWvj5ELPd9Ey98c=
X-Received: by 2002:a05:6402:2116:b0:5cf:e3cf:38af with SMTP id
 4fb4d7f45d1cf-5d080b8d46fmr5143721a12.2.1732768263503; Wed, 27 Nov 2024
 20:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127165846.2001009-1-memxor@gmail.com> <20241127165846.2001009-3-memxor@gmail.com>
 <0b2e84f96227c62ef4da7eda44ee31d42800fccd.camel@gmail.com>
In-Reply-To: <0b2e84f96227c62ef4da7eda44ee31d42800fccd.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 05:30:27 +0100
Message-ID: <CAP01T779EKX=GCPYUyihey=1Sw+1ht4f6C07PnzVEko+JgYk5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Refactor {acquire,release}_reference_state
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 05:13, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-27 at 08:58 -0800, Kumar Kartikeya Dwivedi wrote:
>
> Overall looks good, but please take a look at a few notes below.
>
> [...]
>
> > @@ -1349,77 +1350,69 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
> >   * On success, returns a valid pointer id to associate with the register
> >   * On failure, returns a negative errno.
> >   */
> > -static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
> > +static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env, int insn_idx, bool gen_id)
> >  {
> >       struct bpf_verifier_state *state = env->cur_state;
> >       int new_ofs = state->acquired_refs;
> > -     int id, err;
> > +     int err;
> >
> >       err = resize_reference_state(state, state->acquired_refs + 1);
> >       if (err)
> > -             return err;
> > -     id = ++env->id_gen;
> > -     state->refs[new_ofs].type = REF_TYPE_PTR;
> > -     state->refs[new_ofs].id = id;
> > +             return NULL;
> > +     if (gen_id)
> > +             state->refs[new_ofs].id = ++env->id_gen;
>
> Nit: state->refs[new_ods].id might end up with garbage value if 'gen_id' is false.
>      The resize_reference_state() uses realloc_array(),
>      which allocates memory with GFP_KERNEL, but without __GFP_ZERO flag.
>      This is not a problem with current patch, as you always check
>      reference type before checking id, but most of the data strucures
>      in verifier are zero initialized just in case.

We end up assigning to s->id if gen_id is false, e.g.
acquire_lock_state, so I think we'll be fine without __GFP_ZERO.

>
> >       state->refs[new_ofs].insn_idx = insn_idx;
> >
> > -     return id;
> > +     return &state->refs[new_ofs];
> > +}
>
> [...]
>
> > -/* release function corresponding to acquire_reference_state(). Idempotent. */
> > -static int release_reference_state(struct bpf_verifier_state *state, int ptr_id)
> > +static void release_reference_state(struct bpf_verifier_state *state, int idx)
> >  {
> > -     int i, last_idx;
> > +     int last_idx;
> >
> >       last_idx = state->acquired_refs - 1;
> > -     for (i = 0; i < state->acquired_refs; i++) {
> > -             if (state->refs[i].type != REF_TYPE_PTR)
> > -                     continue;
> > -             if (state->refs[i].id == ptr_id) {
> > -                     if (last_idx && i != last_idx)
> > -                             memcpy(&state->refs[i], &state->refs[last_idx],
> > -                                    sizeof(*state->refs));
> > -                     memset(&state->refs[last_idx], 0, sizeof(*state->refs));
> > -                     state->acquired_refs--;
> > -                     return 0;
> > -             }
> > -     }
> > -     return -EINVAL;
> > +     if (last_idx && idx != last_idx)
> > +             memcpy(&state->refs[idx], &state->refs[last_idx], sizeof(*state->refs));
> > +     memset(&state->refs[last_idx], 0, sizeof(*state->refs));
> > +     state->acquired_refs--;
> > +     return;
> >  }
>
> Such implementation replaces element at 'idx' with element at 'last_idx'.
> If the intention is to use 'state->refs' as a stack of acquired irq flags,
> the stack property would be broken by this trick.
> E.g. consider array [a, b, c, d] where 'idx' points to 'b',
> after release_reference_state() the array would become [a, d, c].
> You need to do 'memmove' instead.
>

Wow, great catch. Thanks for spotting this. I'll fix this and let me
see if I can add a selftest that would've triggered this particular
pattern.

> [...]
>
> > @@ -9666,21 +9659,41 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
> >               reg->range = AT_PKT_END;
> >  }
> >
> > +static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < state->acquired_refs; i++) {
> > +             if (state->refs[i].type != REF_TYPE_PTR)
> > +                     continue;
> > +             if (state->refs[i].id == ref_obj_id) {
> > +                     release_reference_state(state, i);
> > +                     return 0;
> > +             }
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> >  /* The pointer with the specified id has released its reference to kernel
> >   * resources. Identify all copies of the same pointer and clear the reference.
> > + *
> > + * This is the release function corresponding to acquire_reference(). Idempotent.
> > + * The 'mark' boolean is used to optionally skip scrubbing registers matching
>           ^^^^^^
> Nit: this is probably a remnant of some older patch revision,
>      function no longer takes 'mark' parameter.

Yeah, this is a leftover. Sorry about that. Will fix.

>
> > + * the ref_obj_id, in case they need to be switched to some other type instead
> > + * of havoc scalar value.
> >   */
> > -static int release_reference(struct bpf_verifier_env *env,
> > -                          int ref_obj_id)
> > +static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
> >  {
>
> [...]
>

