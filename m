Return-Path: <bpf+bounces-77973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF33CF96D9
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 17:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C7D30D84D1
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ABF279DB7;
	Tue,  6 Jan 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH3eLqlh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8176217723
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717413; cv=none; b=XB5q4SDeSIuT24RPibeqBxn+1Z5HkytdK93jv+yDjVy/chYCAubRKwWN86cHTUBY3LVMywxMRcm8ohwNFnTpt6CKfH2fhOqQUpi8e36tJSK/h/CMrIh/Kgb9E0dEP4MYH5pp8L1Hefm6Em0GSuR9nybDtW40unHPDkICiLixQ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717413; c=relaxed/simple;
	bh=LeN8HxGrm8LD/8IaFgqc59A7W+dZocO49Yl+7935vh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3MFmw4ckkQP4ynbEfriMYOtXyIjdx81bTKPQ+p1ESzN6IA9fGZMQb/500LiH2luRwMP7qIyho9Y6enrADHn/5xBwFhwmUhH3jGGcM/BWMcOC9OjIoQrxD2Ud/NBQnmmIVmIsawWVfaVeorACUDQ38w799kmxu69PzjiDOjpr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH3eLqlh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432777da980so610411f8f.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 08:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767717410; x=1768322210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0nyqXIU8PcQLee91DwSo1xuhqJnF6UOcgdnf9xAH4Y=;
        b=PH3eLqlhrZsiQ/RXJCKWiBQi+jGoo+ykDUTFrEvbE/++Cq7XNN/r0FjDSoYk1nbZD6
         X9tk0MY49BpQSfhv+BpocDApOINX6d7Prwwfq+EHfXsE64jY7jTOpzZHCHldvKxyeW29
         z4jryrZiiBl01HkRepOC7pW6d/wo9DeJlIwKF3Jka9fPpNptmG1tI3/QXqeqzdyGs47l
         HqIoc8u9xzW/SmfZnEL8QuYq11jKSheXhOxf3u7BeU0ZBnPOPVsQdAylyz7tRPiLB2B9
         zorKi3Qqyu+6OzOt3DKMPZIHrot4hauJuXbf1F/B9D2CJniPUbL6wg5kw0DK+GSoviUq
         b90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717410; x=1768322210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0nyqXIU8PcQLee91DwSo1xuhqJnF6UOcgdnf9xAH4Y=;
        b=YBdXW2FsORgkGCPR9CF0g2HTkRSRvkRwDhu7oSflrSrE8KXUb4uccyLAYhTttvcWVt
         c5GmRtdQ1iyVPk4lIkbqIlRVklkXvHsnTqVHI6Ci/dRnDSF1AUluvm9QFMT//XV7Q5u6
         esoPMHULjiNC30jV0fHsqUIlpvrx35aduK2g2FoVoUUJGYrCZcr6uxIQFZleDu10npxY
         SfFueIfdrMYMPzj9lgCphG9A+nBwrrEArEVno/wKNr7zgszwlDtRVIMv4w/2M+kSUd+s
         8tF0iPSmJpUpCX9Ad33HHOC+Pu7sgkyWldO6dht6jzC4QPIxZJlsXZNHt9EuTb9cVx2i
         w1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUR5/qtc61lW87adfXjj4IF7BtPCq2p5+9xxRqiyHuHyzMcDMb/Pvm+VD400u201E15K+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym90Om9hEhPA5giYX1YpavM557+gbD0PqjUE634vgV+ckw3VU+
	JrU2z1AwO1dZTClZTFUt6J4KUJhkTTBYnaZcSOFPD/Iel9rHFuk3uRyvm54WWoSSYE9j/GOJ7xG
	EoyjfjDKDJKWXFbc9vbHCT8Nzj1zn3aI=
X-Gm-Gg: AY/fxX6I6tJbKPAroptcvYJwjNg8Q4199MTrM/guoB3Au7imw100vSJRQpkkLa9XqFt
	cNrN/cvTYjzYnW2Y04iwEKXKU71p20tJ52GChKOXIMd0aCNUDfQz5pYC0d3HnyNY9/zpvaXvg3j
	/2zXOpfCQz4jv+8OsC54CtOdr46T9l68u42XHw8KbPVXCLp8TWH8KJPj5TsETMDuTndynLxBYpH
	UbvYqtKqvyEBWI57fPeku/bxDORXuSUjuaOoAyf2pvWV6EmkNj7lj6/RiHhViHMgAOqaAPZVlIJ
	pStSPRT61/o=
X-Google-Smtp-Source: AGHT+IEBSPp/MEBBJ/QEMTnd4nPbL44BU2u2Uf5PVSdgpq0DZrL/ciaaVvupHvMKp+KbBTjnYCGbw+nWSzpRcVWn1Cw=
X-Received: by 2002:a05:6000:290c:b0:432:8585:6830 with SMTP id
 ffacd0b85a97d-432bca502b8mr5125317f8f.45.1767717409303; Tue, 06 Jan 2026
 08:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106-arena-under-lock-v1-1-6ca9c121d826@etsalapatis.com>
 <853906c538414477bdd9683e918652b42b1b733498dcd95d62048180d227b5ca@mail.kernel.org>
 <CANk7y0jf0QaFbhJuNL2u7UK5NF8omFjn45X_nGAmszGd9Vd9gA@mail.gmail.com> <CAP01T74TUoURu0KzQtBBEWHi=vRdi_FuZ2PMgTUS3stNoyCdHg@mail.gmail.com>
In-Reply-To: <CAP01T74TUoURu0KzQtBBEWHi=vRdi_FuZ2PMgTUS3stNoyCdHg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 08:36:38 -0800
X-Gm-Features: AQt7F2olaAhnNm5qVBQ9k0QPNSNjUDK1MmQt3Womd4XGDeGQFy3TFHRqMHT9Ye0
Message-ID: <CAADnVQ++ZmSn3b7FmCc-uWSCsN6_v-NqE=G_O52K1xufPpnTdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf/verifier: allow calls to arena functions while
 holding spinlocks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bot+bpf-ci@kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 7:26=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Tue, 6 Jan 2026 at 10:31, Puranjay Mohan <puranjay@kernel.org> wrote:
> >
> > On Tue, Jan 6, 2026 at 6:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 9394b0de2ef0..9b3067b16507 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > >
> > > [ ... ]
> > >
> > > > @@ -12883,10 +12885,17 @@ static bool is_bpf_res_spin_lock_kfunc(u3=
2 btf_id)
> > > >              btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unloc=
k_irqrestore];
> > > >  }
> > > >
> > > > +static bool is_bpf_arena_kfunc(u32 btf_id)
> > > > +{
> > > > +     return btf_id =3D=3D special_kfunc_list[KF_bpf_arena_alloc_pa=
ges] ||
> > > > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_free_pag=
es] ||
> > > > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_reserve_=
pages];
> > > > +}
> > > > +
> > > >  static bool kfunc_spin_allowed(u32 btf_id)
> > > >  {
> > > >       return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_=
kfunc(btf_id) ||
> > > > -            is_bpf_res_spin_lock_kfunc(btf_id);
> > > > +            is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfu=
nc(btf_id);
> > > >  }
> > >
> > > Can this cause sleeping in atomic context when calling bpf_arena_free=
_pages()
> > > while holding a BPF spinlock?
> > >
> > > When bpf_spin_lock() is held, IRQs are disabled. The call path is:
> > >
> > >   bpf_arena_free_pages() [sleepable=3Dtrue]
> > >     -> arena_free_pages()
> > >        -> raw_res_spin_unlock_irqrestore() [releases arena lock]
> > >        -> zap_pages()
> > >           -> guard(mutex)(&arena->lock)  <-- mutex acquisition!
> > >
> > > The arena's rqspinlock is released before zap_pages(), but the BPF pr=
ogram's
> > > spinlock is still held with IRQs disabled (the arena lock's irqrestor=
e
> > > restores to IRQs-disabled state). The zap_pages() function then tries=
 to
> > > acquire arena->lock which is a mutex, calling might_sleep().
> > >
> > > Looking at in_sleepable_context() in verifier.c:
> > >
> > >     static inline bool in_sleepable_context(struct bpf_verifier_env *=
env)
> > >     {
> > >         return !env->cur_state->active_rcu_locks &&
> > >                !env->cur_state->active_preempt_locks &&
> > >                !env->cur_state->active_irq_id &&
> > >                in_sleepable(env);
> > >     }
> > >
> > > This does not check active_locks, so when holding a BPF spinlock the
> > > verifier won't set non_sleepable=3Dtrue, meaning bpf_arena_free_pages=
_non_sleepable()
> > > won't be selected instead of bpf_arena_free_pages().
> > >
> > > Should in_sleepable_context() also check env->cur_state->active_locks=
 to
> > > ensure the non-sleepable variant is used when calling arena kfuncs wh=
ile
> > > holding a BPF spinlock?
> >
> > This analysis looks correct, I think we should add
> > !env->cur_state->active_locks here, but we need to see if it would
> > cause any regressions.
>
> Agreed, it wasn't necessary until now since this wasn't being opened up.
> But it's surely an oversight and should be fixed.

That's one impressive code analysis by LLM!
The chain of events to set non_sleepable, and use it to select kfunc,
and chains of calls in bpf_arena_free_pages()... not trivial at all.
Wins the best review award :)

Emil,
please add the fix as a separate first patch in your series.

