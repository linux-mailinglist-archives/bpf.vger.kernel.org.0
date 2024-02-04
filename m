Return-Path: <bpf+bounces-21176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA2849113
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A93EB218B6
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADBB2C69D;
	Sun,  4 Feb 2024 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amKbZdS4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857312C699
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084604; cv=none; b=FQW7d6lxANA1hLDqELaa6DrxmD9p1QLedGQhf6Nro3uYei81fl65NwQEEQBHsOaUrYKxlx/8abTKQ2PTJNAxobJZlmVbe0eJyE8JyAd6x80Orelwi3QveMxaWpEeeDqmzNtAOMvQR/a8VEjXotqtsHvW/HpLE5m05jYKIX9tPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084604; c=relaxed/simple;
	bh=iikEy6QrqjoRKn4Vri5vpqyinynoq/xh/W8VTOmMEws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFECaMOvhBjHFu/w5CE6E49qpcib8mi/qTMpUrXOet19XzkP78rvhSjdv/vVcRcLzVxZHUfnCBC9+s8Cw5vAeRgTX3MU5QIp5I3H28eUDfhCOX6q2ox7mehEFmJIxcVWPA/qKEgWHE1FQ3BQHHTx3z9I2exTLAxB3o9C6CF1FZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amKbZdS4; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-56025fcaebaso1223442a12.0
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707084601; x=1707689401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yiFgdXvwB7kezSOIGseEsv41is/5oi8GK9IVu4cIm7E=;
        b=amKbZdS466hH4q1tayHvs0wNn/ktG5xaiv66ot0CC5OYn7SRIhzFzcxyTmyjDV4sWd
         JZ5XRaGQSuN1EZALWnFzoxe3/hzuRYAZewyYept06lydGFv1AQqq3okzXq+jvlzZyE0O
         qCuq8+f6r4QalwZ7JzPd0sRHzxgi0zz6kECI9Q+fi9jW+LwYRgxpiNbZmfDn/xfUgDXf
         KOmj6suyhPxGwKwuQKq73gP2RcpYDFAocdEW5TnMAvSmd3ip7A0vmmmysqtuvTYvPgvC
         xCnf7SRrlWGkC9ISIS+240GAjWIo73AP5nJF9tg5HhFU4QmJH5rGc8mYoWHYsxeFYv+c
         fltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707084601; x=1707689401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiFgdXvwB7kezSOIGseEsv41is/5oi8GK9IVu4cIm7E=;
        b=vBR1eIn2YGokeF5l+xml/P23MfF+yu6g9Txhr+nk4F5zkCBxBoAsJw4ccFRCWDUVjg
         hmqchRqwd9v2De7SJlNwIm+n5evfEL1CAm70DIq5n68nC0/tcFtoylebl1JeFeaU06m+
         qYivpNpKTIR+di8VDNp1ABI+I3M4blNOOf2+mg5RvcI6esYKPkZdKLmR2w2l3PY7vvRR
         fqNG+Rbov+giljsUl9xvZsuxLyPS5Rk4i1HOJw6GaGc8Yxz7Fwfm1L0Efr4pebkBs4+D
         1GgRbxrIOMdmKBH2aHNcZmTTzmRUXs+y/TZZ/oOPMCQa3AsTwiSoQD9P6mU05thjRr7A
         YUjQ==
X-Gm-Message-State: AOJu0YwHl13eJ4l71EC1L+Ubx7VJaeYKtsjFyk2mv1ZLKQ8tzNOkzGwH
	dQ1mlBfOatVwuUYoAgG2TJ52lgffgWuszPB+Ki7L2XMT+X9lE8uG7N5KcGorIE1urho7xEM83Xb
	xDAMreDtc4PBS1+MUMEsJEgsm7EDvyyehKno=
X-Google-Smtp-Source: AGHT+IEOSOBJxBRFEYfVPqmqLTAv0g8W1j9zKWu/s5Wzoz8OGsoVusEkxc2sf6oHqAXHQFz+LzM6a3kkYqnldpU5e/s=
X-Received: by 2002:a05:6402:1acc:b0:560:5e66:694e with SMTP id
 ba12-20020a0564021acc00b005605e66694emr1092652edb.23.1707084600527; Sun, 04
 Feb 2024 14:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204120206.796412-1-memxor@gmail.com> <20240204120206.796412-2-memxor@gmail.com>
 <2e008ab1-44b8-4d1b-a86d-1f347d7630e6@linux.dev>
In-Reply-To: <2e008ab1-44b8-4d1b-a86d-1f347d7630e6@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 4 Feb 2024 23:09:24 +0100
Message-ID: <CAP01T74w+fHSL48=GXMtS+d9Jk9zF4RfnTH89mSCcFsbnd=jjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow calling static subprogs while
 holding a bpf_spin_lock
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Barret Rhoden <brho@google.com>, 
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 22:23, Yonghong Song <yonghong.song@linux.dev> wrote:
>
>
> On 2/4/24 4:02 AM, Kumar Kartikeya Dwivedi wrote:
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
> SGTM with a small nit below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > ---
> >   kernel/bpf/verifier.c                                  | 10 +++++++---
> >   tools/testing/selftests/bpf/progs/verifier_spin_lock.c |  2 +-
> >   2 files changed, 8 insertions(+), 4 deletions(-)
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
>
> Maybe explicit to mention "global function calls are not allowed ..."?
>

Ack, I made this change, and also extended the last part with "use a
static function instead" to make it more helpful.
Thanks for the review.

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
> >   process_bpf_exit_full:
> > -                             if (env->cur_state->active_lock.ptr &&
> > -                                 !in_rbtree_lock_required_cb(env)) {
> > +                             if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {
> >                                       verbose(env, "bpf_spin_unlock is missing\n");
> >                                       return -EINVAL;
> >                               }
>
> [...]
>

