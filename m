Return-Path: <bpf+bounces-52930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46738A4A682
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46EB97AAC68
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB771DED69;
	Fri, 28 Feb 2025 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3OgbYOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D111CAA64;
	Fri, 28 Feb 2025 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784007; cv=none; b=kZdwfD2U2s/9E8zPRtlYeyWNgPrsFIpVPlDKdp8dxr0gDiu/jeNAd8mzIQipLgN4r5ezl7HxMy9RQNqDHyf9+rAzLv9XqClNCGgNe00UVV2G6VrP3u5G2GmNntVXfXjntLTYXFiLl0sKaE5VGEdDo45awR1aD9SE79/c5yf2ibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784007; c=relaxed/simple;
	bh=ha9Lqc9uu2OiYFwfdXlhHPoBzpGPSxKHTionUtjg+QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUg20qtfOJc82A9quiVzLgpjuu1OmMVFlYuz6UzCMpeXq1Fw6qTpswwczz3PcuP5RuB4RGB7HRA4PVzUuPFlQMuHMveAiSL8PAM5xSh2e8xxV697rdAIhDJaQDPtTvEyNTTTSOPtvZDXAwQmF8i81CouVJjgNTpmSX33Y/Jf+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3OgbYOC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so3094115f8f.0;
        Fri, 28 Feb 2025 15:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740784004; x=1741388804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcXFzlXi0nNGqFNVWBVnchEgBVXyNmXQMOEcMJisjfs=;
        b=H3OgbYOCnCfazkiERITtxDZ/Dko4s03h77OEtoNcUjGydcZt19qSoOzwOmcqAV4u7y
         4WQvtpHeno7qW1NwYvcbpzyxXVzIVnU9AWWltRd4+LM7hs7qDeMW8WpNO7PEPoQr+t1x
         p/+DJ+rPcYevWYOV+o1wQyVefnW6mxkPbO0m+WAKpgeKRrRChwBA9j/Vq7H3fZjSsabd
         Dt05QBYYjXNsfkweNZwutyE5UvVi+I/iqzYhNfbTgMhjF21vSQzRZgwjB08/wOQTdzdd
         5Fj2iOu2CsP94QxTf3RwbC+lxkWnUhKdQsMqhlFy5eqZA1s0s2fBrS1PZZ70U7wfErVk
         U45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784004; x=1741388804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcXFzlXi0nNGqFNVWBVnchEgBVXyNmXQMOEcMJisjfs=;
        b=XM6ozCKVOHLR3PLasHmhgOObfb6+Ds3ucJQJha8BvoXNDX4CcIYoHElHSRYl8SBhjG
         t31XQq9UOjeqx02JO5CZn4Jg2HYQg8EkSFvpdVDI7HNRdWOwNIUa3tkm7mGFCCmzRZjk
         Zg7orHOKYDWDx1nG+QN6+ShykvlZBadhFe8yOocEiQC8toGHvCc7rJ8oyb/0uFN524vS
         pKhTV1t/AzWuFhnV4SVrrf1jZKRS5O8cZMHwRp2Pt5mGYchWpSKTiZjkx6CSOq7p7cnd
         4pF6e2D5L/WrI3arGF650pHcyB/YQQrmRtkriDjec/+o8IAKQ0lY11aUyOjZSBbsk9KC
         Lijw==
X-Forwarded-Encrypted: i=1; AJvYcCUw16btX+vinpTnD8DwqS6ayWD22ALN/WJjqYSbT1sLxoPybSeyiCPJsMCpeRtq9Liln+8=@vger.kernel.org, AJvYcCXdGDGF++me8V5cucq0OjE4xQKTq5f+AABPyliBZvN59MLe/ChQ/Y/7p589vT/oBVWcvTFdkz9FVaAaEEk5@vger.kernel.org
X-Gm-Message-State: AOJu0YyQg7q9iQomJhN3M9k6ShVzHfUwM+1dL8E6/U1tyat1cKu+4Mea
	EeZk/Ze3QDtJ4MN3Eo0JekoYm/xOAu7Ue4VvN9CB7tyALVATL4YJauTatFMwdwyM8tCCz3r7FSA
	bD9WaiRZPBTpgmnzz2rlXzh0aMkU=
X-Gm-Gg: ASbGnctqRLYV7QWyjkR8RqNQF6AheUFcHlgvfQ1H29zp6ew4rb6cV/ifCMAo2eed2S2
	C1yAY1HpUD5QQ5+HAuEqjoA4QsbI2r7L48Sj5a4Svyx8GMMZAICPRxAkNub21xEqFHiQSLtYQ3v
	MkSDeGsQ9+rULkRijKNIlrc5dgrIj7tK4FIELUv+GbQ10kIc10gG68hfnweg==
X-Google-Smtp-Source: AGHT+IGQBscwxZSd8a5RobKJ9o7dODcG2nH0kmu6hVFa9SDrJeh8zV30kK7XWJkB6dCJwG+sNLbB2sJAwsjkJicieBs=
X-Received: by 2002:a5d:47c3:0:b0:38d:d371:e01d with SMTP id
 ffacd0b85a97d-390eca25f7fmr4821747f8f.49.1740784003714; Fri, 28 Feb 2025
 15:06:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080648369E8A4508220133E99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DKSgzZB5HZgYN8@slm.duckdns.org> <AM6PR03MB5080C1F0E0F10BCE67101F6F99CD2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <Z8DZ9pqlWim8EIwk@slm.duckdns.org> <CAADnVQ+bXk3qTekjVZ7NU0TpCh4zNg1GNFL-zdW++f2=t_BT8Q@mail.gmail.com>
 <Z8IrGagRhkHlUejz@slm.duckdns.org>
In-Reply-To: <Z8IrGagRhkHlUejz@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Feb 2025 15:06:32 -0800
X-Gm-Features: AQ5f1Jqncos-iHCLYHCuP9wYmyWCo0iBWXaI2EA8M47pPRENSjJX80JHhbSCMDs
Message-ID: <CAADnVQLkzX8dN9+Uk34idgxcD1rK639hnd8aZsz=0HJibpAwag@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.15 v3 3/5] sched_ext: Add
 scx_kfunc_ids_ops_context_sensitive for unified filtering of
 context-sensitive SCX kfuncs
To: Tejun Heo <tj@kernel.org>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:31=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Feb 27, 2025 at 06:34:37PM -0800, Alexei Starovoitov wrote:
> > > Hmm... would that mean a non-sched_ext bpf prog would be able to call=
 e.g.
> > > scx_bpf_dsq_insert()?
> >
> > Not as far as I can tell.
> > scx_kfunc_ids_unlocked[] doesn't include scx_bpf_dsq_insert.
> > It's part of scx_kfunc_ids_enqueue_dispatch[].
> >
> > So this bit in patch 3 enables it:
> > +       if ((flags & SCX_OPS_KF_ENQUEUE) &&
> > +           btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc=
_id))
> >
> > and in patch 2:
> > +       [SCX_OP_IDX(enqueue)]                   =3D SCX_OPS_KF_ENQUEUE,
> >
> > So scx_bpf_dsq_insert() kfunc can only be called out
> > of enqueue() sched-ext hook.
> >
> > So the restriction is still the same. afaict.
>
> Hmm... maybe I'm missing something:
>
>   static int scx_kfunc_ids_ops_context_sensitive_filter(const struct bpf_=
prog *prog, u32 kfunc_id)
>   {
>          u32 moff, flags;
>
>          // allow non-context sensitive kfuncs
>          if (!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive, =
kfunc_id))
>                  return 0;
>
>          // allow unlocked to be called form all SYSCALL progs
>          if (prog->type =3D=3D BPF_PROG_TYPE_SYSCALL &&
>              btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id))
>                  return 0;
>
>          // *** HERE, allow if the prog is not SCX ***
>          if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
>              prog->aux->st_ops !=3D &bpf_sched_ext_ops)

Ohh. You're right. My bad.
Here it probably needs
&& !!btf_id_set8_contains(&scx_kfunc_ids_ops_context_sensitive

since later scx_kfunc_set_ops_context_sensitive
is registered for all of struct-ops.

