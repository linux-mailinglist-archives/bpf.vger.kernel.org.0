Return-Path: <bpf+bounces-79164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF6D295B9
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 01:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDBE430873BC
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 00:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441564C97;
	Fri, 16 Jan 2026 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2oAKhI8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48714A8B
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521709; cv=none; b=DORG7r0IScR4nLZ5CP4UhHtdjj1O7Aedyw6vH7xoXZOt2alTliz36n/XxbgdxYjP8kVVIgqVT+K/mp8pxF+uiW+ZZ7DtXrNOEqipvw4cIZZjzzf2kf7QJpE2N/zM5VNwPYRpV0QxCRpbJH1lCbDMQ2NkFqtNkUjAR2Zx7sMhl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521709; c=relaxed/simple;
	bh=tGh7LKiKy6u1mKMmdHB6QNNxsgutnTpaqrh6qsuryXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2dsjacYRlyKxx+UNTzIMsFJghnvSxWY05+37P1KDZKLiiLhY2mWN8ENRRZTXuIzTFn751tmqfbvDHR0Ze1mOOSHa4MvCeVMl49n/tzf5epN2nblt1b2PobF1u5vlwIgXbYjJ8V4hjFDmvDFX3hidP9pcpwdZuA3HK/kYTptnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2oAKhI8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b553412a19bso632329a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 16:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768521708; x=1769126508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik/a7qLjiex+0HIUcHSHAAjSfeoJ51UfgjQPluah8iY=;
        b=I2oAKhI8VTGplR7WPslFMB7F1mf1lWmRGTU22HGrwkd8cBJ6N6LuZbw5r+Pf/SiBQg
         Aj+4WLZHRUhOpa6omBrRN+eBZxAp8VD2ziBzo5kz6e1MOcYoUaI5xwyPF8DLtv1tiJ9/
         dHECXVZctDoj/DxbKVY+s5IJAnCTwJnFrAHbs2JNbYEr7zFZ37SAwGhXlW0FvkciywKQ
         SSr6/lESKWNHILq4KtgBYrFo/eu7jGA0sClOhnMQRteD7pdQN5fdRfWmRcWCIyBRDFg0
         RBpjpHBzfFBn8eTXTzpDBLzkIPd4LgEJCFleElc3/WrUHvWnaqRmfZIm+/R7FMsjXUcI
         x5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521708; x=1769126508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ik/a7qLjiex+0HIUcHSHAAjSfeoJ51UfgjQPluah8iY=;
        b=Opsv9CelBdRwWyxW2tBWdYfgaWx1a6nkJkyFMQKhUSilqaHYLrqu8TY53tCNi2W0dc
         V8y9S19Pf6cJxEjGFYRPxW/FffbWlOaDl1zjb5BsU76q3ppaR/0qRhBCZiB87X4SVZhg
         XNDbtTbpaMn3Tgc9Q70hL0+0j/iCk3TlUz5Sx3pQF2xuxm3/ruLu2S72/oWPC/eVHvFN
         7s3f+59MVR3chsapeEGK1M1ORN+PGbyhJxtEk3o9pB0DnuBgpLnTgIirroy0nYyIW/9j
         d1urM0u+wmGUYzmrdneaOVyFDNmwTtfhncKP1qQNNrZla5rpBOD5Qqv05MqObFlNxKm2
         4ROQ==
X-Gm-Message-State: AOJu0YxaPeqZJJ0f9p8MVSN5/tjXhgv/b03yLX54wrp/IV6ejfKd5goI
	BqptHv6W1nCkNb8W0Y/4aFFhQl2wby7095AlCMX6eN874JGfV2o2Psw2Vpex/ULJjR2v0egB5Us
	DTQB2BolkcMPblepPckXaBLxH82XXYRs=
X-Gm-Gg: AY/fxX6eB3QwK6ufJxDIcvwLDKUYmeKw6EMUN5P0HavOSLr6mUHDvNR2ai5i0lGWo6r
	bM3UxY7eDBufz9i77yCG5EPRA5avgbZYw1CIatrrVvnkDKqpDdo02K+dgPV7q1tESq85IuETFKL
	iTRHqXKoq4KSOBphoudtqXzUgtvaWcXoehsancKwJXBuotZ0142TzG+y44lFzSsdYjRGF/oq75Z
	Dnuv4gOeVOR1e3H8aQ/QjgdsDvnpyka2BGub6bj2OXvx21Z/vFY9IZdVez2nVpp98CHd7Ok5kaT
	up07mvIG
X-Received: by 2002:a17:90b:564c:b0:341:8b2b:43c with SMTP id
 98e67ed59e1d1-35272fa47f2mr820093a91.18.1768521707677; Thu, 15 Jan 2026
 16:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com> <20260115-timer_nolock-v5-3-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-3-15e3aef2703d@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 16:01:35 -0800
X-Gm-Features: AZwV_Qjghy87F6Jc7tcI6NAXPwbbVlIqqBf76dY1guFMwFl841lZkMKiLuzOVYw
Message-ID: <CAEf4BzZ3p8kQb65fq_Retr127vQdGx0zDPW8c5P0NUH=pzTnhA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 03/10] bpf: Introduce lock-free bpf_async_update_prog_callback()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:29=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introduce bpf_async_update_prog_callback(): lock-free update of cb->prog
> and cb->callback_fn. This function allows updating prog and callback_fn
> fields of the struct bpf_async_cb without holding lock.
> For now use it under the lock from __bpf_async_set_callback(), in the
> next patches that lock will be removed.
>
> Lock-free algorithm:
>  * Acquire a guard reference on prog to prevent it from being freed
>    during the retry loop.
>  * Retry loop:
>     1. Each iteration acquires a new prog reference and stores it
>        in cb->prog via xchg. The previous prog is released.
>     2. The loop condition checks if both cb->prog and cb->callback_fn
>        match what we just wrote. If either differs, a concurrent writer
>        overwrote our value, and we must retry.
>     3. When we retry, our previously-stored prog was already released by
>        the concurrent writer or will be released by us after
>        overwriting.
>  * Release guard reference.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c | 67 +++++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 37 insertions(+), 30 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

