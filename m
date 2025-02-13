Return-Path: <bpf+bounces-51374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29704A33815
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 07:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B118897DD
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A870207A3A;
	Thu, 13 Feb 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMW2gz/W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4420207A06;
	Thu, 13 Feb 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428954; cv=none; b=qlArydv1RrrMOaQgnCYKaQXF59iiiYW9HBv6h7BAp/rVL83gPlzzl1hznAzQN9phfpIGsKYhAG6tATMN4hPoN3QgirqZtY/EIHtUJLVKL6wbRVoPoJgCPct+KbJUeGT2Giw9jCtrzxfltEq+I+mX3qBD/U7NZbP8D+8U+JKYa/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428954; c=relaxed/simple;
	bh=XExwgq0rMCNZ8mOkbmgMP1G6kyfh4uMQkVaMtzoD+64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqbR+u4f+vT/QQfgzA96n0Egvmko7Qs72F1S4noKv4gBqXPe1BFXWXr2DV7JTjCepWFws9gLzbgz1A9xCog52zYeuInJEBts1FHj9qjwAIHCZmGS5eUjUJgNTWCWCtkGkCN0geFw0E0uIeUGcdIZJi/mwar8DqeLgrtVV+eNac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMW2gz/W; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5deae16ab51so1058378a12.1;
        Wed, 12 Feb 2025 22:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739428951; x=1740033751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyzA7Briisr+Eb0T4txsGUK8feDh27QiFqA7IYyWowI=;
        b=iMW2gz/W6nm2gcTQlm29dyaAHD5dI3limMB2qd+q+oq/CPMNQHX1XRMKvn6pb5Luzp
         NpJzCHmvpoJ5Q5zc8Y9/vhoX8QNeTFdiir28nBnsXReY7D52bqBCla3PZNiShPtlBqdT
         3a8X36lFHqmAY0f7C3vNM05xy+e0omfdibUqhI0ZYrQCD75hZ+Rr3mJIJkCEcWVXR5s4
         b6kVXRK797WhcCVGGDcMtvAOU+JFTbGMyaoVQk/0rJQlccPbkVtIcT/SwT03bkHtwLfp
         EPVQtOWX7ufigf0xCtBoVWcSQ5qjgIwAFtKGz7lzkXbAtuzYnjOHq3PYwEYCPv02yYhb
         LoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739428951; x=1740033751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyzA7Briisr+Eb0T4txsGUK8feDh27QiFqA7IYyWowI=;
        b=gqLtNV6B6wCTg0vWAxYAfwdZ760Ne986ObYDsrs0e+rhI4dQoKXmJlssfO/DFFHaNu
         Z2Umu1joNT/Xg1uZBFAR37rF03oI8xyj4BnOy1E5JQ1gevtpmP3u/XMIrNnTtaUpGbSd
         FMBdXw8pXb1AIjFXORmR2ftqND/wI2COYe7jyvsndDtMFXYGrrEgfGYQsT/lKANTqlZK
         93MY8vd04GEvryFgIejGr/q2BP7eqwj36sZvucHRrfnDHdKpUQ/ZHUC3DeMQnLnLCkJ0
         RxmzZ5Ed53JojAL6bIdWEcCa/ZyiR6j/J7X2QcrQo2dFhFeeSMVK5Ws+i9WNxeUZskCO
         YZyA==
X-Forwarded-Encrypted: i=1; AJvYcCWCJX6k8bXMJsUIf+lunTT6+f/oGPw85g/dOVkO8CWW88NCC17SzViv6dLvf4SgPXMS14YBXHn/Yj2Fl+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HBLKGAjYwp6ETnRD8LNopyGwRNgPuMI1OmPJBhj+M4ccZpF1
	UyWwFORCJ3qS4sm/JSxEj/5jeOX0r0VhPHbtwDsoVOkVaEDHmyeKq71f2hm4OR/me2G77HkIffk
	PFWe5iQ878yy+exm1uHUaPSFJRFY=
X-Gm-Gg: ASbGnct+rpgJOkOHLQzZ7he3xbDyuIxO2pR/UjxHaqtsy6h7OakvePqSQm6citj4Lx6
	2G8CzwZmG6tBvpNLRgm7Z3WuUslfOjNAkVWiyNZKLzOXmWKpj9zvepvoomRKuQtdj8aAJ+PXYlQ
	==
X-Google-Smtp-Source: AGHT+IHRfeMzQ0Aoh2xYhp+Cojt7wbuWGTtiptGxslp7oMIdwuFGnaF7qYdJ9otu3MJ4zJT7MTKS8k5hiyeMHC9PvCA=
X-Received: by 2002:a05:6402:3708:b0:5de:a960:11ee with SMTP id
 4fb4d7f45d1cf-5dec9d2c13bmr4213243a12.5.1739428951028; Wed, 12 Feb 2025
 22:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-25-memxor@gmail.com>
 <a10a2865242dc217e71de54f75fa4289aefb2fa9.camel@gmail.com>
In-Reply-To: <a10a2865242dc217e71de54f75fa4289aefb2fa9.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 13 Feb 2025 07:41:53 +0100
X-Gm-Features: AWEUYZlfy_N9yrlNYupazWcc5kxeGZIJKXLNp7IF_SyEvvcsIVXNR_AiGEpDZc8
Message-ID: <CAP01T76VpVsKabq0cMjX07oDW2WTrQ2dW9NJfB0tvoXFEV5ZoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 24/26] bpf: Implement verifier support for rqspinlock
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 01:08, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2025-02-06 at 02:54 -0800, Kumar Kartikeya Dwivedi wrote:
> > Introduce verifier-side support for rqspinlock kfuncs. The first step is
> > allowing bpf_res_spin_lock type to be defined in map values and
> > allocated objects, so BTF-side is updated with a new BPF_RES_SPIN_LOCK
> > field to recognize and validate.
> >
> > Any object cannot have both bpf_spin_lock and bpf_res_spin_lock, only
> > one of them (and at most one of them per-object, like before) must be
> > present. The bpf_res_spin_lock can also be used to protect objects that
> > require lock protection for their kfuncs, like BPF rbtree and linked
> > list.
> >
> > The verifier plumbing to simulate success and failure cases when calling
> > the kfuncs is done by pushing a new verifier state to the verifier state
> > stack which will verify the failure case upon calling the kfunc. The
> > path where success is indicated creates all lock reference state and IRQ
> > state (if necessary for irqsave variants). In the case of failure, the
> > state clears the registers r0-r5, sets the return value, and skips kfunc
> > processing, proceeding to the next instruction.
> >
> > When marking the return value for success case, the value is marked as
> > 0, and for the failure case as [-MAX_ERRNO, -1]. Then, in the program,
> > whenever user checks the return value as 'if (ret)' or 'if (ret < 0)'
> > the verifier never traverses such branches for success cases, and would
> > be aware that the lock is not held in such cases.
> >
> > We push the kfunc state in check_kfunc_call whenever rqspinlock kfuncs
> > are invoked. We introduce a kfunc_class state to avoid mixing lock
> > irqrestore kfuncs with IRQ state created by bpf_local_irq_save.
> >
> > With all this infrastructure, these kfuncs become usable in programs
> > while satisfying all safety properties required by the kernel.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Apart from a few nits, I think this patch looks good.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>

Thanks!

> [...]
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 32c23f2a3086..ed444e44f524 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -115,6 +115,15 @@ struct bpf_reg_state {
> >                       int depth:30;
> >               } iter;
> >
> > +             /* For irq stack slots */
> > +             struct {
> > +                     enum {
> > +                             IRQ_KFUNC_IGNORE,
>
> Is this state ever used?
> mark_stack_slot_irq_flag() is always called with either NATIVE or LOCK.

Hm, no, it was just the default / invalid value, I guess it can be dropped.

>
> > +                             IRQ_NATIVE_KFUNC,
> > +                             IRQ_LOCK_KFUNC,
> > +                     } kfunc_class;
> > +             } irq;
> > +
> >               /* Max size from any of the above. */
> >               struct {
> >                       unsigned long raw1;
>
> [...]
>
> > @@ -8038,36 +8059,53 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
> >       }
> >
> >       rec = reg_btf_record(reg);
> > -     if (!btf_record_has_field(rec, BPF_SPIN_LOCK)) {
> > -             verbose(env, "%s '%s' has no valid bpf_spin_lock\n", map ? "map" : "local",
> > -                     map ? map->name : "kptr");
> > +     if (!btf_record_has_field(rec, is_res_lock ? BPF_RES_SPIN_LOCK : BPF_SPIN_LOCK)) {
> > +             verbose(env, "%s '%s' has no valid %s_lock\n", map ? "map" : "local",
> > +                     map ? map->name : "kptr", lock_str);
> >               return -EINVAL;
> >       }
> > -     if (rec->spin_lock_off != val + reg->off) {
> > -             verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
> > -                     val + reg->off, rec->spin_lock_off);
> > +     spin_lock_off = is_res_lock ? rec->res_spin_lock_off : rec->spin_lock_off;
> > +     if (spin_lock_off != val + reg->off) {
> > +             verbose(env, "off %lld doesn't point to 'struct %s_lock' that is at %d\n",
> > +                     val + reg->off, lock_str, spin_lock_off);
> >               return -EINVAL;
> >       }
> >       if (is_lock) {
> >               void *ptr;
> > +             int type;
> >
> >               if (map)
> >                       ptr = map;
> >               else
> >                       ptr = btf;
> >
> > -             if (cur->active_locks) {
> > -                     verbose(env,
> > -                             "Locking two bpf_spin_locks are not allowed\n");
> > -                     return -EINVAL;
> > +             if (!is_res_lock && cur->active_locks) {
>
> Nit: having '&& cur->active_locks' in this branch but not the one for
>      'is_res_lock' is a bit confusing. As far as I understand this is
>      just an optimization, and active_locks check could be done (or dropped)
>      in both cases.

Yeah, I can make it consistent by adding the check to both.

>
> > +                     if (find_lock_state(env->cur_state, REF_TYPE_LOCK, 0, NULL)) {
> > +                             verbose(env,
> > +                                     "Locking two bpf_spin_locks are not allowed\n");
> > +                             return -EINVAL;
> > +                     }
> > +             } else if (is_res_lock) {
> > +                     if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK, reg->id, ptr)) {
> > +                             verbose(env, "Acquiring the same lock again, AA deadlock detected\n");
> > +                             return -EINVAL;
> > +                     }
> >               }
>
> Nit: there is no branch for find_lock_state(... REF_TYPE_RES_LOCK_IRQ ...),
>      this is not a problem, as other checks catch the imbalance in
>      number of unlocks or unlock of the same lock, but verifier won't
>      report the above "AA deadlock" message for bpf_res_spin_lock_irqsave().
>

Good point, will fix.

> The above two checks make it legal to take resilient lock while
> holding regular lock and vice versa. This is probably ok, can't figure
> out an example when this causes trouble.

Yeah, that shouldn't cause a problem.


>
> > -             err = acquire_lock_state(env, env->insn_idx, REF_TYPE_LOCK, reg->id, ptr);
> > +
> > +             if (is_res_lock && is_irq)
> > +                     type = REF_TYPE_RES_LOCK_IRQ;
> > +             else if (is_res_lock)
> > +                     type = REF_TYPE_RES_LOCK;
> > +             else
> > +                     type = REF_TYPE_LOCK;
> > +             err = acquire_lock_state(env, env->insn_idx, type, reg->id, ptr);
> >               if (err < 0) {
> >                       verbose(env, "Failed to acquire lock state\n");
> >                       return err;
> >               }
> >       } else {
> >               void *ptr;
> > +             int type;
> >
> >               if (map)
> >                       ptr = map;
>
> [...]
>

