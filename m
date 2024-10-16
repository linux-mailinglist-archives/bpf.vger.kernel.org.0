Return-Path: <bpf+bounces-42235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C079A13A5
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 22:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801B6282329
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D41CBA1D;
	Wed, 16 Oct 2024 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt42y9xd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AB21E3C2
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109776; cv=none; b=EbX9nCMjcHTaRhnq6ZbS4QYm6EWXTVfGxnC87yDwEw7ByVrPWBrZ+maw5Xm98DQkh1Vkmd7VrtCBIW+REaAFRJIkd4t8ia8hCFNR0ELQUL+SFRppQQmoOx1+WwYDyJQ/PJlpI0wVMb/7nH5waeloPJh67O5NPzPOfEHF/r15q6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109776; c=relaxed/simple;
	bh=/+NxUvcq6eHekHc0utIuH0Enlt0+sglCAZuWlqHgjJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NN9RAEXccBA5CfPljR67psye2fyX26xtxTQf6ZN9Lx5A2yeM7JCDi4q81Z2mlS3LKFN68+q9sx6BNYK8GveC4k/YUR3YG1JvleUOhKbKo+gufTqEG7wvpT00zODyIQ8Lr2MCbfdE48FZRo5pK21UwxQXM1g45ITN2PJxBhHasug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt42y9xd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e91ae607aso73661b3a.3
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109774; x=1729714574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLW4f32y74RxqiA8sG9UR+S8J6Fhk18pyx4l4J7Yyrg=;
        b=Mt42y9xde3NLvdvgdzj7pXvzcGmCvGeZSyHWyXxOUZO9gO/xcXKjL7jp+PLAByqkHA
         yZX8dRViOTduig0IPyKTdI29DjohVnwFPldOT9pzWw3I2ECxmCsP7gfE/wKJjRdh6FVP
         S7jlrzp/p15qMajcqkoXd1VdxEcMq7FcKUZmby8J1kTTxMfOxzOnvqk+G5IM7HLksVZ0
         qEg5xtBTqj6F5v9W1a4zn2izdErTDvQa8go3BGysnr9OdTV8RNuVhCZrDR/c45vdK9Bc
         +v8bYwi9CnJlKwUiSFGCQwk4XLSHM3veUFL+aTXUVoZjWPA+wvGYojybrqPDWxrpPpWc
         qBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109774; x=1729714574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLW4f32y74RxqiA8sG9UR+S8J6Fhk18pyx4l4J7Yyrg=;
        b=ELYAcGpL1x0iJanNOvGTtm+bp+Lit0zX7sA10vOKi+szAiDgO8JRl9rHmpsQsiVQiU
         QURSJuVY76aOAgFI+BqlYf6eFmq6kipmhHnUXh495XR44wFX+GH8L6BUjLRNhCcA9e+v
         Z3lFYFWjvBg4u7d3/xZvAc1E6QxThg8i4yqjuB7ZFSGyGhhBQTw+S6LayI6NDAqTRQx3
         mdg0pJOQoiJo1TviDd8kKc6bicyUnseMNlc+HqJDMUJBNHS7Q/T5xPu3rrLIyCyMG/TF
         uJhzGMUVWmGGWti+UWRbnGVfVvyYiSZ+ywL9dEGPUDrk+FU+rRfZSkz4VIDjjIwBGPXb
         14zw==
X-Gm-Message-State: AOJu0Yym5yn/7shFOLhBTlirHDjrwCLw+8jvxW4hy50B/Vo7DNjlm46T
	Y+MEt/mj46EQYqz4YrWkClRBoONNb1Dnb4Dp+9dLH8IpvxNgYGK9joxDFm3WTMXcoUvf4QTcFyi
	vXVsJOEfJEOusD9/SMSc62cK2du5IrXi4
X-Google-Smtp-Source: AGHT+IH9rEgKznhdOlPBA7X9DrhYxPWW42Buzogysg/iVtbsw2a5nSL3HN9MRS9reEDJXzK+1fsdtZuMq15tNqHefck=
X-Received: by 2002:a05:6a00:23d1:b0:71e:3b51:e856 with SMTP id
 d2e1a72fcca58-71e4c13dd24mr23981330b3a.1.1729109774185; Wed, 16 Oct 2024
 13:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016134913.32249-1-daniel@iogearbox.net> <20241016134913.32249-2-daniel@iogearbox.net>
In-Reply-To: <20241016134913.32249-2-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Oct 2024 13:16:01 -0700
Message-ID: <CAEf4BzbYec+RuHz8FhrHFP4U95TcsW1ybKM4R0E42vzX3cCMrA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/3] bpf: Fix print_reg_state's constant scalar dump
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, nathaniel.theis@nccgroup.com, ast@kernel.org, 
	eddyz87@gmail.com, andrii@kernel.org, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 6:49=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> print_reg_state() should not consider adding reg->off to reg->var_off.val=
ue
> when dumping scalars. Scalars can be produced with reg->off !=3D 0 throug=
h
> BPF_ADD_CONST, and thus as-is this can skew the register log dump.
>
> Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
> Reported-by: Nathaniel Theis <nathaniel.theis@nccgroup.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  kernel/bpf/log.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 5aebfc3051e3..4a858fdb6476 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -688,8 +688,7 @@ static void print_reg_state(struct bpf_verifier_env *=
env,
>         if (t =3D=3D SCALAR_VALUE && reg->precise)
>                 verbose(env, "P");
>         if (t =3D=3D SCALAR_VALUE && tnum_is_const(reg->var_off)) {
> -               /* reg->off should be 0 for SCALAR_VALUE */
> -               verbose_snum(env, reg->var_off.value + reg->off);
> +               verbose_snum(env, reg->var_off.value);
>                 return;

The original code was handling SCALAR_VALUE and PTR_TO_STACK cases, so
`+ reg->off` under assumption of reg->off being zero for SCALAR_VALUE
case made sense. Now this is a SCALAR_VALUE-only code path, so there
is no point in doing this.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>         }
>
> --
> 2.43.0
>

