Return-Path: <bpf+bounces-18107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A989815D08
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 02:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ADA1C2163F
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B94EDD;
	Sun, 17 Dec 2023 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFrrf7ck"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B9EA9
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 01:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3D0C433C8
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 01:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702776694;
	bh=TOZh4lNPYkhR53kGsq6NbmwZJ9jAxeKSldwiDfg6Y2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dFrrf7ck30Zp4Bjt0pPLQVDnWy3eMH7fM0J6Nmit4pmEV3QNUp4drIzpZcsLzFacf
	 OtO+2DsjN9bprZkc9ITmkmI3/77il1pj+N71dARSg5arbv5N2GVw0s0UJ6uslQH6pH
	 8lLCDBdk0rBLoXFTymLDUeipjPyQ4eyzUnHJlQxHfJ1TjT+UrUBxcEV3vtMcvo8u7b
	 IvrUo2rhn4PbauPkmCoXzhnY2nGeEYhZDZkKxIg9JCnrvX9g9j8ZRExFuAv4JwoZK5
	 lwAKcwT83Lpt6XIJsWgu10S0Ir9PwBLdXTKFFNuGJNtE9lHUhT7ctNMjoChHyqixKv
	 uWYwrp99GYPhg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so21950011fa.0
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 17:31:34 -0800 (PST)
X-Gm-Message-State: AOJu0Yxa6fYQWsJtjWRqP8lPrZebtGTCIlSvF9ULxfv8AhpEHS5foKaR
	f0wIb4y27Un6QAMfX6V3wQofa8H+Urb7Il8A4Ao=
X-Google-Smtp-Source: AGHT+IEsdNouSBv+5IAYsRcV+ywNuFA2uckuxfo0QznnwIv4ZE7mEQFW/Vwo3gEr/UmBravbJnp7PLJ5TCK3tACjJFY=
X-Received: by 2002:a2e:9b8d:0:b0:2cc:6559:ac24 with SMTP id
 z13-20020a2e9b8d000000b002cc6559ac24mr341994lji.68.1702776692841; Sat, 16 Dec
 2023 17:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215200712.17222-1-9erthalion6@gmail.com> <20231215200712.17222-2-9erthalion6@gmail.com>
In-Reply-To: <20231215200712.17222-2-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Sat, 16 Dec 2023 17:31:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>
Message-ID: <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach rules
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:11=E2=80=AFPM Dmitrii Dolgov <9erthalion6@gmail.=
com> wrote:
[...]
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eb447b0a9423..e7393674ab94 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
>         bool dev_bound; /* Program is bound to the netdev. */
>         bool offload_requested; /* Program is bound and offloaded to the =
netdev. */
>         bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp=
 */
> +       bool attach_tracing_prog; /* true if tracing another tracing prog=
ram */
>         bool func_proto_unreliable;
>         bool sleepable;
>         bool tail_call_reachable;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5e43ddd1b83f..bcc5d5ab0870 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3040,8 +3040,10 @@ static void bpf_tracing_link_release(struct bpf_li=
nk *link)
>         bpf_trampoline_put(tr_link->trampoline);
>
>         /* tgt_prog is NULL if target is a kernel function */
> -       if (tr_link->tgt_prog)
> +       if (tr_link->tgt_prog) {
>                 bpf_prog_put(tr_link->tgt_prog);
> +               link->prog->aux->attach_tracing_prog =3D false;
> +       }
>  }
>
>  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> @@ -3243,6 +3245,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>                 goto out_unlock;
>         }
>
> +       /* Bookkeeping for managing the prog attachment chain */
> +       if (tgt_prog &&
> +           prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> +           tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING)
> +               prog->aux->attach_tracing_prog =3D true;
> +
>         link->tgt_prog =3D tgt_prog;
>         link->trampoline =3D tr;
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8e7b6072e3f4..f8c15ce8fd05 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
>                             struct bpf_attach_target_info *tgt_info)
>  {
>         bool prog_extension =3D prog->type =3D=3D BPF_PROG_TYPE_EXT;
> +       bool prog_tracing =3D prog->type =3D=3D BPF_PROG_TYPE_TRACING;
>         const char prefix[] =3D "btf_trace_";
>         int ret =3D 0, subprog =3D -1, i;
>         const struct btf_type *t;
> @@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
>                         bpf_log(log, "Can attach to only JITed progs\n");
>                         return -EINVAL;
>                 }
> -               if (tgt_prog->type =3D=3D prog->type) {
> -                       /* Cannot fentry/fexit another fentry/fexit progr=
am.
> -                        * Cannot attach program extension to another ext=
ension.
> -                        * It's ok to attach fentry/fexit to extension pr=
ogram.
> +               if (prog_tracing) {
> +                       if (aux->attach_tracing_prog) {
> +                               /*
> +                                * Target program is an fentry/fexit whic=
h is already attached
> +                                * to another tracing program. More level=
s of nesting
> +                                * attachment are not allowed.
> +                                */
> +                               bpf_log(log, "Cannot nest tracing program=
 attach more than once\n");
> +                               return -EINVAL;
> +                       }

If we add

+ prog->aux->attach_tracing_prog =3D true;

here. We don't need the changes in syscall.c, right?

IOW, we set attach_tracing_prog at program load time, not attach time.

Would this work?

Thanks,
Song

> +               } else if (tgt_prog->type =3D=3D prog->type) {
> +                       /*
> +                        * To avoid potential call chain cycles, prevent =
attaching of a
> +                        * program extension to another extension. It's o=
k to attach
> +                        * fentry/fexit to extension program.

