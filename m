Return-Path: <bpf+bounces-77981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED013CF99D0
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 18:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8764B310AB87
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA233EAE6;
	Tue,  6 Jan 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="zFNCkXUc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC0733D6F5
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719039; cv=none; b=bOOa0f+rWa+gqt+CfWCfF6yWdGzXQKmDIZ/HWCvA9WO4C5LXpZHpETF75KTrFQyJY4Z12GrN2gf0n5NL6eexnzyO5Rt6R/z+NJj6IeBon+WyhXY84L+dxrV5lDOqzZvrCmfuKTT4DfGG3aDhLHd7LS3VLmymV5gMaB35X/a/EI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719039; c=relaxed/simple;
	bh=aGI5WeO7SEZvcXW+ydarFc1VyBSejFA3GhZZEelRvPE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=STulnSV7jgt8yOXRjJko3FkngAMmIVV/qHiFPTvy8OolToM0iLFwR9otp5QvnbSSVowKMlAHxvOdc9aG9JmbhZydiSttKFYYG6GK7Mcr4ZliCHwDGhaK2FrhWXLRgKlG+3A4SpjXL3WuUL0fVtQ2lPfzfG35ghHK2U43GqWAKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=zFNCkXUc; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c15e8b2f1aso103109385a.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 09:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767719036; x=1768323836; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hL5ti5R4NBGjkAFeF/WqOAh2oqdwOkZ3eTDIF5WGAQ=;
        b=zFNCkXUccf1l9pd4OY90suRsjXFf0p0QBRQT0yIw+5JMiieT2WcUqumwePH2hYCjNG
         Cu3qPwXZQsLZ/C3p9ejdnaC+Fl8U8mbBvZhMKzYFEybRefRyqb8McLadp5VFDOI7jMGM
         ZgCmeYlHcNj/Mc9VYDSxc0eIRZdMLhOyxS/Drjyew4u2yknApXRtwTDDPwKTELueF2xy
         rllYtBXZOd7rmFtJiepJqEi9UWgRTIp/nzrZkdyMEmUd7bI+oP6tcVSZtobkovtTUgGB
         RvC1lz4k/IMpETYe2cshPUrmixTPIK3PVYwlyaGsZXpyyocFTQP7VmTrukPpzYLEkhjG
         kKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719036; x=1768323836;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hL5ti5R4NBGjkAFeF/WqOAh2oqdwOkZ3eTDIF5WGAQ=;
        b=IBckLm8apo6bje1+f3W7KQayhTvNxkw0Xkubns/W3ihll2WF3Io++kFJjAFb7KrFPn
         qGPvoZiiYd30Tdfixirxyk91cAsERyJU/r4bTouT6DCspM4NKDiHZcVmGZBgYCbJ87ZG
         0gJ3LFBcyOmUOnguBFmZuwzjWzD9stXi138zu6AAfGLMc1yTYSZcOruDNb2YY2T/nJ/X
         1tjrXi5cqHDxWKiH/C8h72fU4s3PGncxrEupvieFx4dpawCUFkt+suvOFGT5bdPPt9pt
         k/SZ3W7K3UEO7C0B6FHLQQ43sknxymmuyl0l8gpaJbcmnWsuK/4SH2MvT6Se5396XBrQ
         xpTw==
X-Forwarded-Encrypted: i=1; AJvYcCWjhX30bgI9eOea9S8qrJFTU9JAEzBAMvnjPuu4eG7QYng9ieLWtePn8b+obxapmOJupos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QtJx+vAWsOK88EOVTgEQH9EOeuIpwhqIF+z3EAr8u2f3+HDr
	E1UQHfiIcZDSgo+bZTJ2o158CdOu9aU7pMU85omqnC/3QGGGztfaixGY7LntKO4Iw6Q=
X-Gm-Gg: AY/fxX5/rvb9ZDhrd6UnSFDAVyItnckJF0LTXiYchhuSaWi+yQsEOd89SVwH2lkDY0y
	1g3AU9/TfYYJOs1THlJwpyvtqY2sw/tOX7x6tUAEVr25SoM1uUdoC9+YxpBZN5noqxRctY6PopY
	mUCRIRowO8M6J7L+ZS4qHJh3JEaAT0//5kWL34mTVCJyYHvh9IgQFLPMi3jDLxWpgz7uXUwGKcx
	FS1JVk9Phz20MaECX0f+NbQZnDKHAFLprYSUa9x8z3wb67kmMBYEVslIQux9Zx12IBfsaWBd8Bc
	5rKocKxD3Vd0XL7RJpgsNA6TH8x6XIP/1paXDiCfjsmUVAgcVedcxrsZgTd8AHxfNdDqVK82Hyo
	8kXBEZLX+9lkQxU+xLyzcG6QLPWI9bhMtxJjSK7aYfOPZW+HJrolE1tLtw1RA5ZHBYP+oEcqU5Y
	8985j74DCuuW34rFCOgWMO5w==
X-Google-Smtp-Source: AGHT+IFq1IeBHUQXb7DqAofeXlDum6gvP/uhD3UOpMgp8OV/0IpFAKsqsQDRKv5dwK1JWcF3d51Spw==
X-Received: by 2002:a05:620a:6a0e:b0:8c3:8794:917 with SMTP id af79cd13be357-8c387941677mr61934085a.85.1767719036126;
        Tue, 06 Jan 2026 09:03:56 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm198599685a.26.2026.01.06.09.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 09:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 12:03:53 -0500
Message-Id: <DFHO3L0N5VLG.1R5C2MOI03WKD@etsalapatis.com>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, <bot+bpf-ci@kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Martin KaFai Lau" <martin.lau@kernel.org>, "Chris Mason" <clm@meta.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH 1/2] bpf/verifier: allow calls to arena functions while
 holding spinlocks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260106-arena-under-lock-v1-1-6ca9c121d826@etsalapatis.com>
 <853906c538414477bdd9683e918652b42b1b733498dcd95d62048180d227b5ca@mail.kernel.org> <CANk7y0jf0QaFbhJuNL2u7UK5NF8omFjn45X_nGAmszGd9Vd9gA@mail.gmail.com> <CAP01T74TUoURu0KzQtBBEWHi=vRdi_FuZ2PMgTUS3stNoyCdHg@mail.gmail.com> <CAADnVQ++ZmSn3b7FmCc-uWSCsN6_v-NqE=G_O52K1xufPpnTdw@mail.gmail.com>
In-Reply-To: <CAADnVQ++ZmSn3b7FmCc-uWSCsN6_v-NqE=G_O52K1xufPpnTdw@mail.gmail.com>

On Tue Jan 6, 2026 at 11:36 AM EST, Alexei Starovoitov wrote:
> On Tue, Jan 6, 2026 at 7:26=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
>>
>> On Tue, 6 Jan 2026 at 10:31, Puranjay Mohan <puranjay@kernel.org> wrote:
>> >
>> > On Tue, Jan 6, 2026 at 6:45=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>> > >
>> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> > > > index 9394b0de2ef0..9b3067b16507 100644
>> > > > --- a/kernel/bpf/verifier.c
>> > > > +++ b/kernel/bpf/verifier.c
>> > >
>> > > [ ... ]
>> > >
>> > > > @@ -12883,10 +12885,17 @@ static bool is_bpf_res_spin_lock_kfunc(u=
32 btf_id)
>> > > >              btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlo=
ck_irqrestore];
>> > > >  }
>> > > >
>> > > > +static bool is_bpf_arena_kfunc(u32 btf_id)
>> > > > +{
>> > > > +     return btf_id =3D=3D special_kfunc_list[KF_bpf_arena_alloc_p=
ages] ||
>> > > > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_free_pa=
ges] ||
>> > > > +            btf_id =3D=3D special_kfunc_list[KF_bpf_arena_reserve=
_pages];
>> > > > +}
>> > > > +
>> > > >  static bool kfunc_spin_allowed(u32 btf_id)
>> > > >  {
>> > > >       return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api=
_kfunc(btf_id) ||
>> > > > -            is_bpf_res_spin_lock_kfunc(btf_id);
>> > > > +            is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kf=
unc(btf_id);
>> > > >  }
>> > >
>> > > Can this cause sleeping in atomic context when calling bpf_arena_fre=
e_pages()
>> > > while holding a BPF spinlock?
>> > >
>> > > When bpf_spin_lock() is held, IRQs are disabled. The call path is:
>> > >
>> > >   bpf_arena_free_pages() [sleepable=3Dtrue]
>> > >     -> arena_free_pages()
>> > >        -> raw_res_spin_unlock_irqrestore() [releases arena lock]
>> > >        -> zap_pages()
>> > >           -> guard(mutex)(&arena->lock)  <-- mutex acquisition!
>> > >
>> > > The arena's rqspinlock is released before zap_pages(), but the BPF p=
rogram's
>> > > spinlock is still held with IRQs disabled (the arena lock's irqresto=
re
>> > > restores to IRQs-disabled state). The zap_pages() function then trie=
s to
>> > > acquire arena->lock which is a mutex, calling might_sleep().
>> > >
>> > > Looking at in_sleepable_context() in verifier.c:
>> > >
>> > >     static inline bool in_sleepable_context(struct bpf_verifier_env =
*env)
>> > >     {
>> > >         return !env->cur_state->active_rcu_locks &&
>> > >                !env->cur_state->active_preempt_locks &&
>> > >                !env->cur_state->active_irq_id &&
>> > >                in_sleepable(env);
>> > >     }
>> > >
>> > > This does not check active_locks, so when holding a BPF spinlock the
>> > > verifier won't set non_sleepable=3Dtrue, meaning bpf_arena_free_page=
s_non_sleepable()
>> > > won't be selected instead of bpf_arena_free_pages().
>> > >
>> > > Should in_sleepable_context() also check env->cur_state->active_lock=
s to
>> > > ensure the non-sleepable variant is used when calling arena kfuncs w=
hile
>> > > holding a BPF spinlock?
>> >
>> > This analysis looks correct, I think we should add
>> > !env->cur_state->active_locks here, but we need to see if it would
>> > cause any regressions.
>>
>> Agreed, it wasn't necessary until now since this wasn't being opened up.
>> But it's surely an oversight and should be fixed.
>
> That's one impressive code analysis by LLM!
> The chain of events to set non_sleepable, and use it to select kfunc,
> and chains of calls in bpf_arena_free_pages()... not trivial at all.
> Wins the best review award :)
>
> Emil,
> please add the fix as a separate first patch in your series.

Sounds good, I will add the extra patch and respin.

