Return-Path: <bpf+bounces-21177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09EA849114
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C551C21D7E
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E482C695;
	Sun,  4 Feb 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAesBbq7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F432C8B
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084643; cv=none; b=WeDH6v6uBvVvBZqCSCTLnDCJLHjoYPgVLZT/OZiG9Kozb5RvKdPMeTe3EKYj2G43L9DtQJXmAEkySyQaz0Roaf1VUOGyZntFHjBG4yXedk4tkMp+BrCDA1hIG1AYoxrPndvchFAmhBupRoFLjtUgkAazHgM2Ci0Al9JBBhjFxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084643; c=relaxed/simple;
	bh=jJzFeI/38fEPq+EXUxQH0vueuJNjwZY6mWbVQ1w3PE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ryph+hFapcCbh3sKrYYLp3nO+aR2xb+I4rmgsON7d045MQeEAahw71QwtYdQUhka8sw5HXLsxyjSn7zaTtPEdb5iPV6IU8jxxyhpspordTqx2HBXkYWgbCHdaGIfjPe+xfexu6M2F41Vgjfxq69hkT7BLG9bOpx3s5Qobnyu1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAesBbq7; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a3566c0309fso474102966b.1
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 14:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707084639; x=1707689439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/yW+W3zwBDmvCvoV0KCyLjhsg9k8UNEpiwoe5UjejE=;
        b=ZAesBbq7n+jRv6uVywXwfWEmmc9aFJ1EwX8QiRqqswtqZ4ihPXi5Eb1Ha709KtjCq/
         Lu4esLvWVWGnlJvnP1fvLzhRr/YUlPJG50IBTc//qs1WCI/Cn23keiI+JL37lVq4+z40
         CcnqiLQljR79OwAPXVDtSBV6URsDg7T4NfQ4Jm7X1o6C3DJwf/+VhR/+bWbz9xzTVQPc
         gFs823Wodkbnrl+5LLRMlaeT/F7LwNZ+4wGilJ/fH63pR6mfxUf+Qa4MGT7lR8Mq6ww/
         hfxCvUJaoMmtvr9O176l8V6T+RrPkFqiWnzqos5yEQKeRauZ++J8Ya5F4DEmViNKUOOq
         qPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707084639; x=1707689439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/yW+W3zwBDmvCvoV0KCyLjhsg9k8UNEpiwoe5UjejE=;
        b=iOkz428Rw1U6CCXySniH2GFs6XtVbfosTB9WiT/qnhCUnz8sDgRmI/xF8PpBkbw8oo
         ACglPAnioGz6cxyUCTsCkjeHceIVNtlGTrZSeSbA9iuM4aFdXCCGGAVEvtCQSfpTUWFJ
         3fOG43il4D5EvzKRHRPo3DMe6pnOv5DkB2CQq4Xj56/yd2Gf3S63X5xoKKBr1KXwKb9H
         XID1xV5fKJ23ShqTsylJsrclfEYdbPoSkVj3KSqLRgAe/oA6ppYf1Jz7+8P2shWqvAC1
         kKzqYjfIvIJZ1jn9kvAx7475D4kPGZpFvSLWuldVlMEnQBM21uBR7TMnWu7hbwA527di
         jaKg==
X-Gm-Message-State: AOJu0YxNoYVvZPOQ8m6zrExQ2/zrwPX5+hdPaUslZwJjk6tkiCyoSG6Y
	IWiHVsM+cQH0VLnwi0faBUjyDuqNb2zC/Cn1edCwqqp3OK3sg834r/taNf358wEB2HHckF82bXn
	/1fQfkIREiuVThGeHibPLP8VQNf8=
X-Google-Smtp-Source: AGHT+IFJH5dP26btGxHNSAlkwH1RIuD8VyqQriwmuihqVKeUCU5UGBH377cSm2220Uv0qi0ElSkg2kSaxCj0xvztATA=
X-Received: by 2002:a17:906:4746:b0:a36:927e:cc0 with SMTP id
 j6-20020a170906474600b00a36927e0cc0mr8717026ejs.9.1707084639475; Sun, 04 Feb
 2024 14:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204120206.796412-1-memxor@gmail.com> <20240204120206.796412-2-memxor@gmail.com>
 <20240204213313.GB120243@maniforge>
In-Reply-To: <20240204213313.GB120243@maniforge>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 4 Feb 2024 23:10:03 +0100
Message-ID: <CAP01T75Qq8DN=A0uxF4F5hNm6igLRLnGWQFXst=DAO95Lrzsvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow calling static subprogs while
 holding a bpf_spin_lock
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Barret Rhoden <brho@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 22:33, David Vernet <void@manifault.com> wrote:
>
> On Sun, Feb 04, 2024 at 12:02:05PM +0000, Kumar Kartikeya Dwivedi wrote:
> > Currently, calling any helpers, kfuncs, or subprogs except the graph
> > data structure (lists, rbtrees) API kfuncs while holding a bpf_spin_lock
> > is not allowed. One of the original motivations of this decision was to
> > force the BPF programmer's hand into keeping the bpf_spin_lock critical
> > section small, and to ensure the execution time of the program does not
> > increase due to lock waiting times. In addition to this, some of the
> > helpers and kfuncs may be unsafe to call while holding a bpf_spin_lock.
> >
> > However, when it comes to subprog calls, atleast for static subprogs,
> > the verifier is able to explore their instructions during verification.
> > Therefore, it is similar in effect to having the same code inlined into
> > the critical section. Hence, not allowing static subprog calls in the
> > bpf_spin_lock critical section is mostly an annoyance that needs to be
> > worked around, without providing any tangible benefit.
> >
> > Unlike static subprog calls, global subprog calls are not safe to permit
> > within the critical section, as the verifier does not explore them
> > during verification, therefore whether the same lock will be taken
> > again, or unlocked, cannot be ascertained.
> >
> > Therefore, allow calling static subprogs within a bpf_spin_lock critical
> > section, and only reject it in case the subprog linkage is global.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Looks good, thanks for this improvement. I had the same suggestion as
> Yonghong in [0], and also left a question below.
>
> [0]: https://lore.kernel.org/all/2e008ab1-44b8-4d1b-a86d-1f347d7630e6@linux.dev/
>
> Acked-by: David Vernet <void@manifault.com>
>
> > ---
> >  kernel/bpf/verifier.c                                  | 10 +++++++---
> >  tools/testing/selftests/bpf/progs/verifier_spin_lock.c |  2 +-
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 64fa188d00ad..f858c959753b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9493,6 +9493,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >       if (subprog_is_global(env, subprog)) {
> >               const char *sub_name = subprog_name(env, subprog);
> >
> > +             /* Only global subprogs cannot be called with a lock held. */
> > +             if (env->cur_state->active_lock.ptr) {
> > +                     verbose(env, "function calls are not allowed while holding a lock\n");
> > +                     return -EINVAL;
> > +             }
> > +
> >               if (err) {
> >                       verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
> >                               subprog, sub_name);
> > @@ -17644,7 +17650,6 @@ static int do_check(struct bpf_verifier_env *env)
> >
> >                               if (env->cur_state->active_lock.ptr) {
> >                                       if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
> > -                                         (insn->src_reg == BPF_PSEUDO_CALL) ||
> >                                           (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
> >                                            (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
> >                                               verbose(env, "function calls are not allowed while holding a lock\n");
> > @@ -17692,8 +17697,7 @@ static int do_check(struct bpf_verifier_env *env)
> >                                       return -EINVAL;
> >                               }
> >  process_bpf_exit_full:
> > -                             if (env->cur_state->active_lock.ptr &&
> > -                                 !in_rbtree_lock_required_cb(env)) {
> > +                             if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {
>
> Can we do the same thing here for the RCU check below? It seems like the
> exact same issue, as we're already allowed to call subprogs from within
> an RCU read region, but the verifier will get confused and think we
> haven't unlocked by the time we return to the caller.
>
> Assuming that's the case, we can take care of it in a separate patch
> set.

Makes sense, I'll send a separate patch for the RCU fix.
Thanks for the review.

