Return-Path: <bpf+bounces-17697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75E4811BED
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E60B2111D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7D59E20;
	Wed, 13 Dec 2023 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2xgbaw2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C5B9
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:06:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so9186618a12.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702490813; x=1703095613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qWv0ix/rxUfUHV6MA/Aa7z1A+1uW4NG3dXQzZfWTZk=;
        b=g2xgbaw2nB8ZQquURHrfjseSxnzBUbgNLaGJ2jfJD+DfKBq/pUyy25/Z7t2cEUzxZt
         iuY8wA+LdCo3HnkfBTY0KoirSECsjyk/ZFelHXKQ0NChjaFKaX7i61Gbp7KaKtesekp3
         0/tu6/4W6WT9wzLQ3P81TphqUqnFwggiTWvAQbi7v8Xg6H6PwIi8hYvlT4bCxHUmokT9
         B2WwQVF3aHwUDnskitLCIs96K8rR6/tIhvJsh+IkYxhthsr0VunODOHGw8w+/fw/GNmz
         6gWy2ztIAlMzrGD3lNgeU3O0Q1fOXmIseg23l6vH7Hm1w9KYUxheNc7dommmhOIf7L9Q
         RLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490813; x=1703095613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qWv0ix/rxUfUHV6MA/Aa7z1A+1uW4NG3dXQzZfWTZk=;
        b=H3y8zjEk9B6eptCGaGBlb/rGycKeFK79T4N3k7n5UOvLYmtMJgTdu1TMbk0SOwXoXN
         HJwf4FLYPblnjcz8SWtsesI3sKaMD8/nzy47+lr6KHxHbeiyFWE7mbI7TJShaJlZw2f7
         tvqzOZCq3p0eVRRRdq6deL++clxr1dCK5C/WJm8K7KPa68MmzngJmcSpKqfMcVYzqjFL
         jrVDs72TrN3gryq3P4cqrKni7BjA5/OVJ6UOUx9B6Cp2BanM/xQRI6BZkMadzQFPr1VG
         829orhDbDf0DIW4OOREZdZAPSpgu7yKgdZYtsX2GY6NE0AjLph9VY6jSryyvfz6ly63X
         LC/A==
X-Gm-Message-State: AOJu0YwORG3akmKV0W6vnz9tYV/LnBHdxdj/fQLq8nIrhvnuuE6pOat/
	vC7KFaYlWVCkAz8na8OTlkC0P/BwF6C3ldIP7H0=
X-Google-Smtp-Source: AGHT+IHd1jFUwlJr1oOj6Ygrv05IB4TmYp91N7YBUX0GLPtBdt81EA+7XOJOHqWKuGjO9m+y8iIrZ5wSLqWvZK9lBlE=
X-Received: by 2002:a17:906:209a:b0:a19:720c:ed66 with SMTP id
 26-20020a170906209a00b00a19720ced66mr3306112ejq.23.1702490812691; Wed, 13 Dec
 2023 10:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212232535.1875938-1-andrii@kernel.org> <20231212232535.1875938-3-andrii@kernel.org>
 <75137376329b7afe4dae0f3ae8fe0036c790198c.camel@gmail.com>
In-Reply-To: <75137376329b7afe4dae0f3ae8fe0036c790198c.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 10:06:40 -0800
Message-ID: <CAEf4Bza2v4=nwkV8BtLd7KvANtz1+j+GahFGYJCyKW93XPqF-A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] bpf: reuse btf_prepare_func_args()
 check for main program BTF validation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 9:43=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-12-12 at 15:25 -0800, Andrii Nakryiko wrote:
> > Instead of btf_check_subprog_arg_match(), use btf_prepare_func_args()
> > logic to validate "trustworthiness" of main BPF program's BTF informati=
on,
> > if it is present.
> >
> > We ignored results of original BTF check anyway, often times producing
> > confusing and ominously-sounding "reg type unsupported for arg#0
> > function" message, which has no apparent effect on program correctness
> > and verification process.
> >
> > All the -EFAULT returning sanity checks are already performed in
> > check_btf_info_early(), so there is zero reason to have this duplicatio=
n
> > of logic between btf_check_subprog_call() and btf_check_subprog_arg_mat=
ch().
> > Dropping btf_check_subprog_arg_match() simplifies
> > btf_check_func_arg_match() further removing `bool processing_call` flag=
.
> >
> > One subtle bit that was done by btf_check_subprog_arg_match() was
> > potentially marking main program's BTF as unreliable. We do this
> > explicitly now with a dedicated simple check, preserving the original
> > behavior, but now based on well factored btf_prepare_func_args() logic.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -19944,21 +19945,19 @@ static int do_check_common(struct bpf_verifie=
r_env *env, int subprog)
> >                       }
> >               }
> >       } else {
> > +             /* if main BPF program has associated BTF info, validate =
that
> > +              * it's matching expected signature, and otherwise mark B=
TF
> > +              * info for main program as unreliable
> > +              */
> > +             if (env->prog->aux->func_info_aux) {
> > +                     ret =3D btf_prepare_func_args(env, 0);
> > +                     if (ret || sub->arg_cnt !=3D 1 || sub->args[0].ar=
g_type !=3D ARG_PTR_TO_CTX)
> > +                             env->prog->aux->func_info_aux[0].unreliab=
le =3D true;
> > +             }
>
> Nit: should this return if ret =3D=3D -EFAULT?
>
>

no, why? I think the old behavior also didn't fail in this case

