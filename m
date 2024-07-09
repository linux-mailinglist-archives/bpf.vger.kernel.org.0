Return-Path: <bpf+bounces-34312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513AE92C6B9
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B2E1F2302B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF11189F4C;
	Tue,  9 Jul 2024 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlN7hf/9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E682185627
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568546; cv=none; b=eouwOWu8+MYDBvKTB1AHuo1FWr28Lnh9Cm0HfLAccUSn8T4g62Mc2fa7Oav1tB8K+Yf7BPJOOEcw9Hb30krIHcy2sOEIfaAQBulrm/WQi5nx2qhqXtqUFuq2Fk/YulM1zrg33khMkZrDaLFP/9tUdHe8TrXb1VigxbfdkepEZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568546; c=relaxed/simple;
	bh=6tZXftAGMs9n47sQaEpK1Ukj4aQk8LatkxeAPtM1PVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heF9gZVhrrP2eLyzEfVhmyoIuI8vJ2tct05bpHX1yFqee1MSP89YcATUff1NIxZpXL/D0A8cN2qvl8mSItIK1RKrjGH61sYpNcbqGCanKczku6aLOvWmzgCcKBPo9A45iWhHEwSJ5xHvpQOSWKttCkjl/ik2ie5ciayOIFKAtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlN7hf/9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso3500526b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 16:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720568544; x=1721173344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOFMTSxkbyzJQ4aQo+rrqd9/xY6sYUdS7TXG/perhec=;
        b=FlN7hf/9Hm/0hAyOw2IBDcZj0Wpd2x4NQCFRBhHXB3zbku1zuoGeDu/bg+kd1a7uRX
         WvDObZ5lpCgswcNF0TeEsKYcULaSE6RShElB45oZcxA2fZB+DZigEZoYrsubJjjjl00P
         cJNfVFOrONza+JfsxL0To7MUKiFtd449AH0F9eG7qOLpI1bnvEdDdKUdLnAjF9HN9pva
         KUAWRUCi7c1nRqOE7IThqol2KXRaA4DUX6MDlG1cSQu9npafr4hrtyb3wT2joCQkvG5n
         73yVUjNt0d2Yyq/SqpYN4Pes4kWjhhcnwj/FpOd1sI8RJeYtswuag109NK8Ekhko5Th0
         nd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568544; x=1721173344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOFMTSxkbyzJQ4aQo+rrqd9/xY6sYUdS7TXG/perhec=;
        b=U+yxSP2djFfOjIrzJnJX5OmYi55GeJw/r9U90TNJA3TKpAlycZx76Ypg6dH8mMM6s8
         ajFpjrajEQkUfsxG5/HLSzHMPso3w7G3O9HGZChfPVPvkJLMjMFMb+MhvJJqtvP0EEW4
         I61QiIPBgmLpN5N5bu7ZF+0mOnRRM/ZhBgYIuqDwgINOZ9B9M1/XF7NnX64taeu6WVOZ
         W1wFW9uMh3X1pShJI0S7ASlEqaxsL6HRd8gwdDJ5HI546t/iTLG3Y2YSW8fJNyc+fTPc
         mHy+2l4UBXy4bTXTgsMoCLuxQf6FCj0Ige7t1IxPM55JMSlmmiEsf4BEI03B1TJ70jnQ
         ERDw==
X-Gm-Message-State: AOJu0YwOcWd92G/x0901EFeFxVTNg+zoHQ+Y86+Yq2HB3oC1oKh7AzK+
	KEV6jMfXjwc4KrogpnbI29t8LQJHJPfhTUlKsxZE50Laz6TbJUHkLInQZk+nCbjyNt3DrhdjwUm
	DvR5oL9Swe7MmmnO1hZW95QpNqQk=
X-Google-Smtp-Source: AGHT+IH/O/O2Bvt2ZPjggv1rquRfswEZ9hCELU1fvFr5YwpR+JsJ0bora3gmfbXC2GY8rPo2xA9TtCJsjUWVJRPtxYM=
X-Received: by 2002:a05:6a00:98f:b0:706:6384:a826 with SMTP id
 d2e1a72fcca58-70b435689d8mr5152214b3a.20.1720568543710; Tue, 09 Jul 2024
 16:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-2-eddyz87@gmail.com>
In-Reply-To: <20240704102402.1644916-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 16:42:11 -0700
Message-ID: <CAEf4BzZq5p-CgJM6y6G=EyxwRwp46RxwhSvv=vvBodGKFrpMMA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 1/9] bpf: add a get_helper_proto() utility function
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Extract the part of check_helper_call() as a utility function allowing
> to query 'struct bpf_func_proto' for a specific helper function id.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>

I'd write it differently (see below), but it's correct, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d3927d819465..4869f1fb0a42 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10261,6 +10261,24 @@ static void update_loop_inline_state(struct bpf_=
verifier_env *env, u32 subprogno
>                                  state->callback_subprogno =3D=3D subprog=
no);
>  }
>
> +static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
> +                           const struct bpf_func_proto **ptr)
> +{
> +       const struct bpf_func_proto *result =3D NULL;
> +
> +       if (func_id < 0 || func_id >=3D __BPF_FUNC_MAX_ID)
> +               return -ERANGE;
> +
> +       if (env->ops->get_func_proto)
> +               result =3D env->ops->get_func_proto(func_id, env->prog);
> +
> +       if (!result)
> +               return -EINVAL;

result is a bit unnecessary. We could do either

*ptr =3D NULL;
if (env->ops->get_func_proto)
    *ptr =3D env->ops->get_func_proto(func_id, env->prog);
return *ptr ? 0 : -EINVAL;


or just

if (!env->ops->get_func_proto)
    return -EINVAL;

*ptr =3D env->ops->get_func_proto(func_id, env->prog);

return *ptr ? 0 : -EINVAL;


> +
> +       *ptr =3D result;
> +       return 0;
> +}
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
>                              int *insn_idx_p)
>  {
> @@ -10277,18 +10295,16 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
>
>         /* find function prototype */
>         func_id =3D insn->imm;
> -       if (func_id < 0 || func_id >=3D __BPF_FUNC_MAX_ID) {
> -               verbose(env, "invalid func %s#%d\n", func_id_name(func_id=
),
> -                       func_id);
> +       err =3D get_helper_proto(env, insn->imm, &fn);
> +       if (err =3D=3D -ERANGE) {
> +               verbose(env, "invalid func %s#%d\n", func_id_name(func_id=
), func_id);
>                 return -EINVAL;
>         }
>
> -       if (env->ops->get_func_proto)
> -               fn =3D env->ops->get_func_proto(func_id, env->prog);
> -       if (!fn) {
> +       if (err) {

nit: this is one block of error handling, I'd keep it "connected":

if (err =3D=3D -ERANGE) {
} else if (err) {

}


>                 verbose(env, "program of this type cannot use helper %s#%=
d\n",
>                         func_id_name(func_id), func_id);
> -               return -EINVAL;
> +               return err;
>         }
>
>         /* eBPF programs must be GPL compatible to use GPL-ed functions *=
/
> --
> 2.45.2
>

