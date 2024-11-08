Return-Path: <bpf+bounces-44383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA89C256C
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94581F23FEE
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E071C1F06;
	Fri,  8 Nov 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKtKTTgw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85221F26FA
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093092; cv=none; b=j3dM6oaNm7Q0M6nU1OrQAwYgfPGBkR7D9RERFH1HeFMcHNKWjFS4ir1BmhmfIekQ1OfXDW+C0oLAAi5kcNate2OaL/vwmAWISHG2FrHyiCPjCaHypQP21KLu0MKGtwSt/bA/P3SCHI8TiE7wQDIq9uXRwMLlSP67U78h2dAbtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093092; c=relaxed/simple;
	bh=9lqLfZwe+k8NZlBPqcS6gp07HJNi2G8rZmAnjJq8tqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHMVYcw7vjdN+E0nl4ssywdt4G827APvzxSPwdrHYDdSRhphZe/cjkGt/hnhi2xjPNB0kYp0ruZWrDIbbVEIhIq0mcUmvUODtekdr3AqjsUIq4MJGrncnrCnKLiq+AalnBCm1jfrFwsKvQhK6HJWjDh8MejoB2orOqzxdzr+1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKtKTTgw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315eac969aso14936705e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731093089; x=1731697889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5EM1HCUgbH30Iz/hfknJCZZeTYjzGrozGWcUyYl+0M=;
        b=cKtKTTgw4re9buywJirSn1ba+NlzthBqT/FP/1TdeLCoZWVDT92/InhM/y4cYgwItd
         YqIXIFvsql5tS6yuB2s16GnlWkzQn6yvF+3UQeg8EQ9rhJqBvegQiG15s+2tUztC1OYU
         42OTeShy/w8cdX1Wp+zItpJ2FzIzUBV4kermd8C4oV/Y0pNkM/R0506ZFHM+08Eq8ILO
         Air3ucYicU1qLxLA/jPlkOCqORuf5VHLbwsG4cF69/lZV1p8VcIsw7WfUUu4FLUHUbY8
         8gz77dN4D4WAjbmltuZ5nq/TWzkq0dTvcg/B/Zhji2OJH07zkUiXF+k+CSB7MeqDqvZG
         6crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093089; x=1731697889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5EM1HCUgbH30Iz/hfknJCZZeTYjzGrozGWcUyYl+0M=;
        b=Pj9082Fm0swjejVMYazEfByfzmzeeLmaXv/xX3TwKQemT74M5XZx3tDsJ129eHaemt
         YCbxk1y8b87QHESAlFnsXxGGgmyPqBFmvJ5P0y4bskbzFuUTK59HeON0VHs+u0/Vh318
         Z+zCcbbLOnu5nihx8QSHTkV7i5hfVZYbEWNR3rW0tNKGPEFVXs5G6wEEea9irLQGiEO4
         mU58fB2qGGd2GmYwASffcPT6mxur8fv7SvwFwAjgSZthB3QufwHJHEAtC5EmkPUE15k7
         BYvwF0HRP38snXrMs9QZxwdfYy7BdWbN2ZWFcYWS+aDfpuren7C8bZYyGZc41qLytbH6
         sUMg==
X-Gm-Message-State: AOJu0YysGuroO50MAaoRYw9fya4Eo2dnLogD9IIYnHK4CaiCpc+3hw+9
	GirNK0Z6Q6JWNC/Mci+/ibkDTsOwmuSbkc/ElVZ6zGhiPE+/8cgfCtLFauL+ARJ3a5eauTupT0i
	IQ1a8bX6KwtYrlZP6JwVY7RaDSVo=
X-Google-Smtp-Source: AGHT+IFwfPXNoYhhLJpm3XDsQo9oCwSTZpw8urTusURVC0NfyYuaMV6Kxlvy0DGhELSb/8IjKrVwbqyUHD4RU77qDsM=
X-Received: by 2002:a05:600c:3115:b0:432:7c30:abf3 with SMTP id
 5b1f17b1804b1-432b685c2d7mr41835265e9.7.1731093088156; Fri, 08 Nov 2024
 11:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107024138.3355687-1-yonghong.song@linux.dev> <20241107024149.3356316-1-yonghong.song@linux.dev>
In-Reply-To: <20241107024149.3356316-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Nov 2024 11:11:17 -0800
Message-ID: <CAADnVQ+Y0Gj-S43oh5MXm71e=qDdRhK7FcigctLGg2TD3n5GkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 2/7] bpf: Enable private stack for eligible subprogs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 6:42=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2284b909b499..09bb9dc939d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6278,6 +6278,10 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
>                                 return ret;
>                 }
>         }
> +

and patch 6 adds this line here:
+ env->prog->aux->priv_stack_requested =3D false;

> +       if (si[0].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
> +               env->prog->aux->priv_stack_requested =3D true;
> +

which makes the above hard to reason about.

I think the root of the problem is the dual meaning of
the priv_stack_requested flag.
On one side it's a way for sched-ext to ask bpf core to enable priv stack,
and on the other side it's a request from bpf core to bpf jit
to allocate it.

I think it's better to split these two conditions.
Extra bool is cheap.

How about 'bool priv_stack_requested' will be used by sched-ext only
and patch 6 largely stays as-is.

While patch 1 drops the introduction of priv_stack_requested flag.
Instead 'bool jits_use_priv_stack' is introduced in the patch 2
and used by JITs to allocate priv stack.

I know we use 'jit_requested' to tell JITs to jit it,
so we can bike shed on alternative ways to name these two flags.

>         return 0;
>  }
>
> @@ -20211,6 +20215,9 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>
>                 func[i]->aux->name[0] =3D 'F';
>                 func[i]->aux->stack_depth =3D env->subprog_info[i].stack_=
depth;
> +               if (env->subprog_info[i].priv_stack_mode =3D=3D PRIV_STAC=
K_ADAPTIVE)
> +                       func[i]->aux->priv_stack_requested =3D true;
> +
>                 func[i]->jit_requested =3D 1;
>                 func[i]->blinding_requested =3D prog->blinding_requested;
>                 func[i]->aux->kfunc_tab =3D prog->aux->kfunc_tab;
> --
> 2.43.5
>

