Return-Path: <bpf+bounces-44538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A639C4536
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 19:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B51283E78
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D6155327;
	Mon, 11 Nov 2024 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw4uzGRQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034F156991
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350801; cv=none; b=uHJ1cob+AGdmQRzFlzqg6gJQH0f34p4P+LlC8i1UrpJK4Y58C07MgrPVs1jHZmU5l6BdrXIfgMaUuNFlSLz/cyMzpoFXA6uVVFk0Q74NgCRGZKEEBJzjhY54stAlDJIie6Dg9JfmlukUbropUPGA4D/qh7zrb0q3wfdp2JDBz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350801; c=relaxed/simple;
	bh=8PbZth9NIXorg2drK62+wujTNHU98t3J8e34n+WpwYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZZNJdM6+obNaaO23+WA8I/pzKGYVKxaEbL3Mv80KpIqhRuVAxBCtz8ET+VE4yIlc4PHy36VPKxv9PGH5n5jE1gurciRI43k9WUpuAxr1j/HEF8XkBkmQ5z/M/8EUxut/e4C5H7Vm8ZQ9nUkUWQX9jQWvlyALiDAO6OUjftimrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw4uzGRQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43152b79d25so39570225e9.1
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350798; x=1731955598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fCMmEWjHigyfwouJczQnIcxprSbaet9Dz55j4+1q3Q=;
        b=Cw4uzGRQpP9b8jgKW0jKr1kq7bNTC848Yu8LrhverwqiOSGj2FgXOerhvtpLbmcibC
         wIhF9+/GJQkJvwrJCBYdyXP4LYRsV7VQHgQSOBBR7mPhoTSQEdL/Bzj+7vl46/f3AioG
         qF7IX1+UajF4ino3xMxTAX3hYs9PxkQsb058jAdNeKGCepWzQJLVSXngiq1jTeeI+ued
         xjy8SIa4O0+TMnxQZxZQEeNK8DOfHQpW6IOnOQIFzE0ABRCRruincubBGSYwNUFJn6qU
         r09lSSRwCS3D8soJr92WRb6gF8mfOo2x5hRC7zlg/9HJ9bHYSfwiNX+UVSCrxCZKt0Ya
         +Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350798; x=1731955598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fCMmEWjHigyfwouJczQnIcxprSbaet9Dz55j4+1q3Q=;
        b=QvBStAAf3R3UhPEvKWiRGCZBxlGsH9oYM0IUwJE9fpjVUDpfjOvOD+5f/XPO11CYNx
         4Ko3N8nMoO5HicWXCWi4ngFCXNKFO3vuW51MzxapjxLGyw7As/1hssB1t4/NuARgUp0W
         amRumM1VcRv1pfRJotJg79Vwe8NzXM+PgazjresRegiKesdSdRZ61zOBJd/TLvweq5av
         HLMcGSs09OOfd3NG65/zkmKNKmlb7+Xv0VRVwKDw2ZbHozLqLYgNgUtIIPqerf3j39Qm
         HagrJCB8mNRlsg9fcR2UHTyev6nVVvHqKo0uhuIBKj/TB3Masl7VlsQdQYNQL9rF2Ha0
         gqqA==
X-Gm-Message-State: AOJu0YzZOeGfGvo/81WXd+Re+bMGHKcFjMtO09YEqGpJC4hJRUK/JSbc
	A910Hgu0XAtmFqQBtrL2mkVD6Ctk62dgxpFeaNzigY5DPj3GVdO1xx5+QK1+xAsd250exye6LFX
	SCo8xPwchtv6Dap1Kab0Vl8lvGtc=
X-Google-Smtp-Source: AGHT+IFh7ZOMncTNC1ot84dV4T3RvK6GM2OG1pbyJKZ0JqjofoemB+DDd+72+VmcWZMy5PgaKa1ghZ/8RrLgjdxTz9I=
X-Received: by 2002:a05:600c:35cf:b0:431:5957:27e8 with SMTP id
 5b1f17b1804b1-432b751cda8mr102926945e9.28.1731350798055; Mon, 11 Nov 2024
 10:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030235057.1984848-1-andrii@kernel.org>
In-Reply-To: <20241030235057.1984848-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Nov 2024 10:46:26 -0800
Message-ID: <CAADnVQ+pShXOS9WnDSA5CjrGvNRC7NS-MQrgr_X_Obo5zLs8yA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use common instruction history across all states
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:51=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Async callback state enqueing, while logically detached from parent

typo. enqueuing

> -static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
> -                            u32 *history)
> +static int get_prev_insn_idx(const struct bpf_verifier_env *env,
> +                            struct bpf_verifier_state *st,
> +                            int insn_idx, u32 hist_start, u32 *hist_endp=
)
>  {
> -       u32 cnt =3D *history;
> +       u32 hist_end =3D *hist_endp;
> +       u32 cnt =3D hist_end - hist_start;
>
> -       if (i =3D=3D st->first_insn_idx) {
> +       if (insn_idx =3D=3D st->first_insn_idx) {
>                 if (cnt =3D=3D 0)
>                         return -ENOENT;
> -               if (cnt =3D=3D 1 && st->jmp_history[0].idx =3D=3D i)
> +               if (cnt =3D=3D 1 && env->insn_hist[hist_end - 1].idx =3D=
=3D insn_idx)
>                         return -ENOENT;
>         }

I think the above bit would be easier to understand if it was
env->insn_hist[hist_start].

When cnt=3D=3D1 it's the same as hist_end-1, but it took me more time
to grok that part. With [hist_start] would have been easier.
Not a big deal.

Another minor suggestion...
wouldn't it be cleaner to take hist_start/end from 'st' both
in get_prev_insn_idx() and in get_insn_hist_entry() ?

So that __mark_chain_precision() doesn't need to reach out into
details of 'st' just to pass hist_start/end values into other helpers.

