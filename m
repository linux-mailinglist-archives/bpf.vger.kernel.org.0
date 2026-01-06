Return-Path: <bpf+bounces-77935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF5CF78B1
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 10:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06969301EFF9
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC52D979F;
	Tue,  6 Jan 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBrzmVp8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D32D0C79
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691905; cv=none; b=Q+rlVICEVdQq6jD/R/CSpXWfEqroL9yFw+xdUSvLTaK0PYs5npPUgVbDYyKIfDUl63ljgKfkwfV7We+BM7B9EtKDDqmP4Kv3W8WIzuLGIF2T4KOWfEXydmovsgTio2tqN61sAijuqJRpe9lJgmihGNHY1YdnZ6wQbMmLOFU/9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691905; c=relaxed/simple;
	bh=YsowPEgwooASUlD4nsmz72Nrf1pDkEEMoZsDQ/xqosM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cg+grcMCUMKYcts7bHXp7fDX6XzGGa9GffendXQfXvk6ilvkwhNx+q8fHLbL/d45hdmWXLMBzI+L6ISuEZLZ/HzHGEP2D8HiNObYzHsv44zzoJzprg8+8wgruZspZztsHadSQdga5cd5wu9Seu+ixu/3rmCrvvbQvOl+W8x/ZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBrzmVp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1A1C19425
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 09:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767691905;
	bh=YsowPEgwooASUlD4nsmz72Nrf1pDkEEMoZsDQ/xqosM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YBrzmVp8i128KKzOcPQj0EQN8/he+aDWnGXWzSEY9T1YVYjzka+Xj2MAVltzvUl/9
	 a59TglNTqRBQoChcS4fPugt0EImKVOeW7wx6aqC09AdxfFJgpHpqe4XXx8tIQY8DqC
	 zYlvQpx09S/VxijtT7YQ+GBfq9x8l1g5pQMFuEQxQ7wP/n22gaBEV7TiNdssJgmIXZ
	 WPtK4BPqYEY6MY1kc86akDfIVofeGpZC4eOmtX0so0yuO8iej5souKswyfxDYRWoz0
	 +skqgjxtqmwKAruNHpX6BKepk23QkTiaI7NbM11N6B+WAHYjDCzyiFJpiMXrbUi1eE
	 Vxi0MMfXMZiXQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7633027cb2so145689366b.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 01:31:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk6dQxLYBrvQ7yBvyz06LAzr9SruYZ+te1NN1aPysPgrr7FRCmV8BG37ILrzQgNY4lZBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvKgX/7EpMw/cWisWMj7zXQTAWMS6v72QKGH+ljvX4HbgIhAAq
	XbMUgid9AGnxf+S6xfuzWBjv/Poktf9UIAzH2gH7SB82vuaCvSrtFtWMursFaWIuAYyLCJZZr0w
	aruHaB+sstlFNgSWPUx0rzzN8bo/2fPg=
X-Google-Smtp-Source: AGHT+IE84QGQrMFrth0dA+y/SDrBj9dQvyLK/Ov52rohFrdVrllydO96D4kI1YyiLjckjehV6Zci2+xBHAOZctaNEaU=
X-Received: by 2002:a17:907:944d:b0:b84:206f:a650 with SMTP id
 a640c23a62f3a-b8426c54569mr300572366b.56.1767691903604; Tue, 06 Jan 2026
 01:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106-arena-under-lock-v1-1-6ca9c121d826@etsalapatis.com> <853906c538414477bdd9683e918652b42b1b733498dcd95d62048180d227b5ca@mail.kernel.org>
In-Reply-To: <853906c538414477bdd9683e918652b42b1b733498dcd95d62048180d227b5ca@mail.kernel.org>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Tue, 6 Jan 2026 09:31:30 +0000
X-Gmail-Original-Message-ID: <CANk7y0jf0QaFbhJuNL2u7UK5NF8omFjn45X_nGAmszGd9Vd9gA@mail.gmail.com>
X-Gm-Features: AQt7F2o6Aoy7ACJCP_2R_OHREYIsBEAwEgr36PeNUPsPmNlh6o7Zp6GvX6TxdIc
Message-ID: <CANk7y0jf0QaFbhJuNL2u7UK5NF8omFjn45X_nGAmszGd9Vd9gA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf/verifier: allow calls to arena functions while
 holding spinlocks
To: bot+bpf-ci@kernel.org
Cc: emil@etsalapatis.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, memxor@gmail.com, yonghong.song@linux.dev, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 6:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9394b0de2ef0..9b3067b16507 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -12883,10 +12885,17 @@ static bool is_bpf_res_spin_lock_kfunc(u32 bt=
f_id)
> >              btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock_ir=
qrestore];
> >  }
> >
> > +static bool is_bpf_arena_kfunc(u32 btf_id)
> > +{
> > +     return btf_id =3D=3D special_kfunc_list[KF_bpf_arena_alloc_pages]=
 ||
> > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_free_pages] =
||
> > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_reserve_page=
s];
> > +}
> > +
> >  static bool kfunc_spin_allowed(u32 btf_id)
> >  {
> >       return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfun=
c(btf_id) ||
> > -            is_bpf_res_spin_lock_kfunc(btf_id);
> > +            is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(b=
tf_id);
> >  }
>
> Can this cause sleeping in atomic context when calling bpf_arena_free_pag=
es()
> while holding a BPF spinlock?
>
> When bpf_spin_lock() is held, IRQs are disabled. The call path is:
>
>   bpf_arena_free_pages() [sleepable=3Dtrue]
>     -> arena_free_pages()
>        -> raw_res_spin_unlock_irqrestore() [releases arena lock]
>        -> zap_pages()
>           -> guard(mutex)(&arena->lock)  <-- mutex acquisition!
>
> The arena's rqspinlock is released before zap_pages(), but the BPF progra=
m's
> spinlock is still held with IRQs disabled (the arena lock's irqrestore
> restores to IRQs-disabled state). The zap_pages() function then tries to
> acquire arena->lock which is a mutex, calling might_sleep().
>
> Looking at in_sleepable_context() in verifier.c:
>
>     static inline bool in_sleepable_context(struct bpf_verifier_env *env)
>     {
>         return !env->cur_state->active_rcu_locks &&
>                !env->cur_state->active_preempt_locks &&
>                !env->cur_state->active_irq_id &&
>                in_sleepable(env);
>     }
>
> This does not check active_locks, so when holding a BPF spinlock the
> verifier won't set non_sleepable=3Dtrue, meaning bpf_arena_free_pages_non=
_sleepable()
> won't be selected instead of bpf_arena_free_pages().
>
> Should in_sleepable_context() also check env->cur_state->active_locks to
> ensure the non-sleepable variant is used when calling arena kfuncs while
> holding a BPF spinlock?

This analysis looks correct, I think we should add
!env->cur_state->active_locks here, but we need to see if it would
cause any regressions.

