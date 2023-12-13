Return-Path: <bpf+bounces-17700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87472811C4C
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BB9B2117B
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4CC59E41;
	Wed, 13 Dec 2023 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlktrFDl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8D11B
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:23:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso1165425666b.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702491815; x=1703096615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEnRyRwSBbxwPKplOtD+Uf5pw4b0erP9gu1xZc4HyVg=;
        b=NlktrFDlgE6kFcAgR8wZdXtC6RunjMF0p7XhlUpo5ilizm6qB7t9NaW7Jxtf18I9bu
         6Lt0RcWOPZMguXGbLyzAaEejw9XnRRNW506qLF4D1FrIwutCRMakDYflBowwGWSxJeTV
         f3ZoCFFeF79cseu7UVYpxzajL4MbfqFpSZ6utlXBmBs8KBAVt2dS2lysxClWkbnzPUH9
         XCDhuMaVokzv2GtilHWahumBMOx4HtsiIfW+jWRmHe5SvFrIj9P8DmjfZ0P5CWNjbJqh
         JFMLEbpETripkXue4SLoEPy3h0JZKokmKcaQGJPmu+U7vSwO27P/AUPWKvsXRpzTmRgu
         rpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491815; x=1703096615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEnRyRwSBbxwPKplOtD+Uf5pw4b0erP9gu1xZc4HyVg=;
        b=PO+LgOVoWrjTz/35QIXqcSFvAB/JXlTBPlwWO5FpKITVt2dRBIrSqrb/8Q4TENhttf
         lRccoDABS0wdu1TWC6jyRJhN/AJQruQxHjOB4Kjc/0fZEWAlIZRMDjdHFaRyzeRhrA7u
         ovnS5F3Qwp1R7c91UOSRzdNr6kzmKo4JFj/3pYg0VqntQ7hUW6qcP6rTWh8UwgYBedc7
         d8yJgjqUVmehjqW2WM4o4KTCMr/MaWdSuZIodfU5qJFGW1WJC78VlaWlnoq5Cn7CuD+n
         xNW5kZ2HtODQntK/usNB853Kk+gCFBWAlEqmvEoGYj3e6Cez9cEJVJMT4CphDAdg8lR/
         X1mA==
X-Gm-Message-State: AOJu0YxytbNqm7pR/E5NlA2iFWwIinEFQH+X3F7Q13GOy2Xi6dr3b8Ho
	W1sAaxFFuOVMJQWo5JDEqQ4qcEssbpjti6eCOfs=
X-Google-Smtp-Source: AGHT+IFmVs/pa8WYNDYNgpMCGhUeRrHgUhLFxHc9wVNiBuUSH4clfe+6swynLMOigqKmnl8o8LtXVdyzUxdBeF+25B0=
X-Received: by 2002:a17:906:48d:b0:9a5:dc2b:6a5 with SMTP id
 f13-20020a170906048d00b009a5dc2b06a5mr9420030eja.35.1702491815084; Wed, 13
 Dec 2023 10:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212232535.1875938-1-andrii@kernel.org> <20231212232535.1875938-3-andrii@kernel.org>
 <75137376329b7afe4dae0f3ae8fe0036c790198c.camel@gmail.com>
 <CAEf4Bza2v4=nwkV8BtLd7KvANtz1+j+GahFGYJCyKW93XPqF-A@mail.gmail.com> <a23e5753192f152fbb09b98137fd0ecd8932efe5.camel@gmail.com>
In-Reply-To: <a23e5753192f152fbb09b98137fd0ecd8932efe5.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 10:23:23 -0800
Message-ID: <CAEf4Bzbbi3kqMtt5QARD76N0FM6S0avgZjXHm9o=o4Bv4G+kYA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/10] bpf: reuse btf_prepare_func_args()
 check for main program BTF validation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2023-12-13 at 10:06 -0800, Andrii Nakryiko wrote:
> [...]
>
> > > > @@ -19944,21 +19945,19 @@ static int do_check_common(struct bpf_ver=
ifier_env *env, int subprog)
> > > >                       }
> > > >               }
> > > >       } else {
> > > > +             /* if main BPF program has associated BTF info, valid=
ate that
> > > > +              * it's matching expected signature, and otherwise ma=
rk BTF
> > > > +              * info for main program as unreliable
> > > > +              */
> > > > +             if (env->prog->aux->func_info_aux) {
> > > > +                     ret =3D btf_prepare_func_args(env, 0);
> > > > +                     if (ret || sub->arg_cnt !=3D 1 || sub->args[0=
].arg_type !=3D ARG_PTR_TO_CTX)
> > > > +                             env->prog->aux->func_info_aux[0].unre=
liable =3D true;
> > > > +             }
> > >
> > > Nit: should this return if ret =3D=3D -EFAULT?
> > >
> > >
> >
> > no, why? I think the old behavior also didn't fail in this case
>
> I think it did, here is an excerpt from the current patch:

Ah, sorry, you meant exit if -EFAULT is returned, not on any error.
Yes, that was old behavior, but I don't think those conditions can
ever happen because if func_info_aux is non-null, then we successfully
passed check_btf_func_early() and check_btf_func() checks, which will
fail early if those conditions are not satisfied.

So instead of a scary-looking check, I figured it's simpler to just
mark BTF unreliable and move on with the rest of the logic. The whole
idea of this check is to do basically optional BTF check, but
otherwise ignore BTF if it doesn't match our expectation.


>
> -               ret =3D btf_check_subprog_arg_match(env, subprog, regs);
> -               if (ret =3D=3D -EFAULT)
> -                       /* unlikely verifier bug. abort.
> -                        * ret =3D=3D 0 and ret < 0 are sadly acceptable =
for
> -                        * main() function due to backward compatibility.
> -                        * Like socket filter program may be written as:
> -                        * int bpf_prog(struct pt_regs *ctx)
> -                        * and never dereference that ctx in the program.
> -                        * 'struct pt_regs' is a type mismatch for socket
> -                        * filter that should be using 'struct __sk_buff'=
.
> -                        */
> -                       goto out;

