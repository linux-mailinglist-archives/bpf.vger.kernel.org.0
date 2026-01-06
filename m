Return-Path: <bpf+bounces-77967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B1CF90CF
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03E5F3024E56
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EA345749;
	Tue,  6 Jan 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODaXCWV/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EB314A8E
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713177; cv=none; b=daAKmS9visGJ0bU7H0rWcLO4jyhdXHsHCLo/V50AsmAGTxhYKmPpWYUskXbBDks90MQI+4Qrf71j6OltcCxSYyJrykGhmmgwXwkIsjqK3FNRi1sdgTaiVCtu7ufu3oUK3GfLJMfX1nl7kR3m9qy/90+WS33WJtyLeP7G3a5cwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713177; c=relaxed/simple;
	bh=4rCuyA1e9gHd3X6alPbkqzym9QeDCAIFLBZ1O49iXwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE0J1ek0sg9P6XnJ76QZQnYamoSI7GdEKN0wGAlVsisO0lpt0VmYrPdnbOz6wHh10E9QjNHZFIhkeK9Z5I1APl8BiBrUcVfVP1sygEWzNhHLsfP9yeMaKVgK5v/uoQf23OXKb4i/2IHa7YIkZ9RDiz3U+WU3GrpSCP7XtXEBr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODaXCWV/; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47755de027eso6650785e9.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767713174; x=1768317974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MITQe71jZa+v4hk9sNJ9/Fkg+l9R3Kro2yeSx8TAJC4=;
        b=ODaXCWV/tzfCrs3eAXfoMj8HlbubcLELpQL+bJZ7VtmzD8n1BAELSmqjtGRgaegPB7
         gOt47TIKUQ73mYFzLHJthZIfxSzHT4GeOF3ELnCp3LugLRwuE8smEM2gnG87dqSZkub0
         GSNzQsfUL+qXhfN5ptfYWK3AMXmD5Tu4j2rd/3khAxJIhc/KdlUHL0iTbhZ+M8DNIcy9
         i8jP4Dryw6NkVsXSfs9MuUITxrO7IS4oA/5yXsdj9v/tVm7VB/g60lpJNLKE/hTPubFA
         RyLY311v+/3ouOQRYVvVOTd2di5fNtm3M1PuA5+GMWLGg0I3yq2q3hHhRkBjj18gfCPv
         NuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713174; x=1768317974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MITQe71jZa+v4hk9sNJ9/Fkg+l9R3Kro2yeSx8TAJC4=;
        b=ma6y+RXk6pIHO/KGDnMjyYaLMoEzCyGUHD/NbkNRKBv9BVNupIKm1+EB9suGXU4xRS
         Qwug7DjdJ2BcpVm02wu6cPv/39OMyJ2eBTlSBDhKtdpifKFKwbQDFAiPJRAm6TmV05mG
         0E/NQFA+hgnsXp/XuG4Oybf/RpiHZgo/fRqzzPMfC1J8qpAi5HNPGD2tjTsdgDwaGNrC
         MiEhm2TkJLx/p8EhgafKEMKtlaltgJoCT6KS2UcTDUIlcVSU5can4RF3XR92evX2nuDS
         dE7dBccrUhKvV1TaFfqPFd50vL17U2pkiRrdnxywRyd+G5uX2KgePDv9FmrdthVoMUsb
         DuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0yGclY2RGjlDnpqPzRpl6iW5Lp/SD+UcGvRj5hgD4U3yOM7mQzgkD6K0VLy1KK5Bl8mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6HcfQMJWh8nAJKO8e8DI6qpRxJrkUEYvhBTxWCALvFtt9Zw6
	NRfYiksmDL0CIrNNl1DeTERcnctYFLMbbbwY8ttg9MU44ZxFZ61lORuerxk48vQfH5NE8s0nqvI
	il58Y+nlmbRWA34obRs3v5zo2qXDD4kk=
X-Gm-Gg: AY/fxX7UQVT5107J4TjJyqZUEo8geYgntl8xdAiUbY9zn/QEH8iCHMElRlWOsvsEaIe
	kjDBEakSz7ZbzpehmYi4+ryjOLbDhUZVJ7trtSmQMC2x0rCfO/9ZQQpVw9fycI145K3VoItINK1
	z8Hi7Jou98H0ZvHw759Jbgicjvanf3GzJr4WCdICRRMXlgy1qYhDN0/Xf9GKD0YuvsAvPRthwrg
	c/hPpSuWUKPOh/8STHQexeiKchVAmJKvyiAItUFfgK3T8L8+sxNcLTRfiWVUTiONRw6sjgBblMb
	BtPrFXRclgzsKA6DvgKBF/igi5el
X-Google-Smtp-Source: AGHT+IFlyemfuJ99OVTVr8ssDZ+rGjc7U3Kao5byuaw1Mp/nQBV8b5cbYVfI8hvAn1tjiquAuzMcm8GKltcYogOIu6U=
X-Received: by 2002:a05:6000:200f:b0:430:f3ab:56af with SMTP id
 ffacd0b85a97d-432bc9f65e5mr4875504f8f.48.1767713173730; Tue, 06 Jan 2026
 07:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106-arena-under-lock-v1-1-6ca9c121d826@etsalapatis.com>
 <853906c538414477bdd9683e918652b42b1b733498dcd95d62048180d227b5ca@mail.kernel.org>
 <CANk7y0jf0QaFbhJuNL2u7UK5NF8omFjn45X_nGAmszGd9Vd9gA@mail.gmail.com>
In-Reply-To: <CANk7y0jf0QaFbhJuNL2u7UK5NF8omFjn45X_nGAmszGd9Vd9gA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 6 Jan 2026 16:25:37 +0100
X-Gm-Features: AQt7F2pWfbJ6o6bTf_RS77SUzZG3llXyinfPXRSOEBFgInR_TOHS4_cQby2Ih-M
Message-ID: <CAP01T74TUoURu0KzQtBBEWHi=vRdi_FuZ2PMgTUS3stNoyCdHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf/verifier: allow calls to arena functions while
 holding spinlocks
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bot+bpf-ci@kernel.org, emil@etsalapatis.com, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2026 at 10:31, Puranjay Mohan <puranjay@kernel.org> wrote:
>
> On Tue, Jan 6, 2026 at 6:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 9394b0de2ef0..9b3067b16507 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> >
> > [ ... ]
> >
> > > @@ -12883,10 +12885,17 @@ static bool is_bpf_res_spin_lock_kfunc(u32 =
btf_id)
> > >              btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock_=
irqrestore];
> > >  }
> > >
> > > +static bool is_bpf_arena_kfunc(u32 btf_id)
> > > +{
> > > +     return btf_id =3D=3D special_kfunc_list[KF_bpf_arena_alloc_page=
s] ||
> > > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_free_pages=
] ||
> > > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_reserve_pa=
ges];
> > > +}
> > > +
> > >  static bool kfunc_spin_allowed(u32 btf_id)
> > >  {
> > >       return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kf=
unc(btf_id) ||
> > > -            is_bpf_res_spin_lock_kfunc(btf_id);
> > > +            is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc=
(btf_id);
> > >  }
> >
> > Can this cause sleeping in atomic context when calling bpf_arena_free_p=
ages()
> > while holding a BPF spinlock?
> >
> > When bpf_spin_lock() is held, IRQs are disabled. The call path is:
> >
> >   bpf_arena_free_pages() [sleepable=3Dtrue]
> >     -> arena_free_pages()
> >        -> raw_res_spin_unlock_irqrestore() [releases arena lock]
> >        -> zap_pages()
> >           -> guard(mutex)(&arena->lock)  <-- mutex acquisition!
> >
> > The arena's rqspinlock is released before zap_pages(), but the BPF prog=
ram's
> > spinlock is still held with IRQs disabled (the arena lock's irqrestore
> > restores to IRQs-disabled state). The zap_pages() function then tries t=
o
> > acquire arena->lock which is a mutex, calling might_sleep().
> >
> > Looking at in_sleepable_context() in verifier.c:
> >
> >     static inline bool in_sleepable_context(struct bpf_verifier_env *en=
v)
> >     {
> >         return !env->cur_state->active_rcu_locks &&
> >                !env->cur_state->active_preempt_locks &&
> >                !env->cur_state->active_irq_id &&
> >                in_sleepable(env);
> >     }
> >
> > This does not check active_locks, so when holding a BPF spinlock the
> > verifier won't set non_sleepable=3Dtrue, meaning bpf_arena_free_pages_n=
on_sleepable()
> > won't be selected instead of bpf_arena_free_pages().
> >
> > Should in_sleepable_context() also check env->cur_state->active_locks t=
o
> > ensure the non-sleepable variant is used when calling arena kfuncs whil=
e
> > holding a BPF spinlock?
>
> This analysis looks correct, I think we should add
> !env->cur_state->active_locks here, but we need to see if it would
> cause any regressions.

Agreed, it wasn't necessary until now since this wasn't being opened up.
But it's surely an oversight and should be fixed.

