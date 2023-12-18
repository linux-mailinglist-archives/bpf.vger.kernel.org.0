Return-Path: <bpf+bounces-18141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDFD8163E6
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 01:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B825828286A
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F11220E4;
	Mon, 18 Dec 2023 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSqtRgTw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AAD1FD7
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 00:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8831FC43397
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702861100;
	bh=fOI3BiCt8uwT0WOr8rKALYU77T6HThc6I2xxa3e+vbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hSqtRgTwsiGmN9SLky8UXh0qAPPO9dZvwQ/umdrkzFaCV+3kbWXjt25M5gf8qDwuE
	 h52jQEqwfxYwDwtDNObiOaMp9A8qyS2Sn9JO8bc0jltoschnmyifmNAtrgPXGEOwml
	 A41DciclwSKw58WNhXHqc331bq5MMdDKWV9mCvsEwtWu2LlONY4y7jFEkPokhG0yTl
	 QjM4D/w/9xMA34s4FhL1ijs+Eh75wc5/v9To6CaccMzd5Ete2IgRXg5MZX0y6+hgTZ
	 I3yujqXxb5CIsJj4omDW7AoIp+VLfULdt8fMMldeo0qG/dM3LljKBW700AegpduTyn
	 ELxnAnEj6zLFQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cc690a3712so9628741fa.3
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 16:58:20 -0800 (PST)
X-Gm-Message-State: AOJu0YzYrUn8EkScbU0r3BLnYXeA4+o91MLFDAStrqHdhfV6pHdi0G9i
	TNzUuR9OHPA+7i4uqrCq4xlKcfz19ZdcWQC66rE=
X-Google-Smtp-Source: AGHT+IE+GYDkPrGJmzjPdtDiRpEdrFZKcMl8YptpUQIeKBIGbqyvj6L2s0lz6hGUTM9uIj3CTBnuNZ8N3C/DpAe4ZLg=
X-Received: by 2002:a2e:9ec4:0:b0:2ca:1615:bc40 with SMTP id
 h4-20020a2e9ec4000000b002ca1615bc40mr6450570ljk.22.1702861098630; Sun, 17 Dec
 2023 16:58:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215200712.17222-1-9erthalion6@gmail.com> <20231215200712.17222-2-9erthalion6@gmail.com>
 <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com> <ZX9KY-uouFF1Doz3@krava>
In-Reply-To: <ZX9KY-uouFF1Doz3@krava>
From: Song Liu <song@kernel.org>
Date: Sun, 17 Dec 2023 16:58:07 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4SfDEPy3sxTTr2VPYCW7ysM+ACUHwzuAcniy9-cgan5A@mail.gmail.com>
Message-ID: <CAPhsuW4SfDEPy3sxTTr2VPYCW7ysM+ACUHwzuAcniy9-cgan5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach rules
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	yonghong.song@linux.dev, dan.carpenter@linaro.org, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 11:22=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Sat, Dec 16, 2023 at 05:31:21PM -0800, Song Liu wrote:
> > On Fri, Dec 15, 2023 at 12:11=E2=80=AFPM Dmitrii Dolgov <9erthalion6@gm=
ail.com> wrote:
> > [...]
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index eb447b0a9423..e7393674ab94 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
> > >         bool dev_bound; /* Program is bound to the netdev. */
> > >         bool offload_requested; /* Program is bound and offloaded to =
the netdev. */
> > >         bool attach_btf_trace; /* true if attaching to BTF-enabled ra=
w tp */
> > > +       bool attach_tracing_prog; /* true if tracing another tracing =
program */
> > >         bool func_proto_unreliable;
> > >         bool sleepable;
> > >         bool tail_call_reachable;
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 5e43ddd1b83f..bcc5d5ab0870 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -3040,8 +3040,10 @@ static void bpf_tracing_link_release(struct bp=
f_link *link)
> > >         bpf_trampoline_put(tr_link->trampoline);
> > >
> > >         /* tgt_prog is NULL if target is a kernel function */
> > > -       if (tr_link->tgt_prog)
> > > +       if (tr_link->tgt_prog) {
> > >                 bpf_prog_put(tr_link->tgt_prog);
> > > +               link->prog->aux->attach_tracing_prog =3D false;
> > > +       }
> > >  }
> > >
> > >  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> > > @@ -3243,6 +3245,12 @@ static int bpf_tracing_prog_attach(struct bpf_=
prog *prog,
> > >                 goto out_unlock;
> > >         }
> > >
> > > +       /* Bookkeeping for managing the prog attachment chain */
> > > +       if (tgt_prog &&
> > > +           prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> > > +           tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING)
> > > +               prog->aux->attach_tracing_prog =3D true;
> > > +
> > >         link->tgt_prog =3D tgt_prog;
> > >         link->trampoline =3D tr;
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 8e7b6072e3f4..f8c15ce8fd05 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifi=
er_log *log,
> > >                             struct bpf_attach_target_info *tgt_info)
> > >  {
> > >         bool prog_extension =3D prog->type =3D=3D BPF_PROG_TYPE_EXT;
> > > +       bool prog_tracing =3D prog->type =3D=3D BPF_PROG_TYPE_TRACING=
;
> > >         const char prefix[] =3D "btf_trace_";
> > >         int ret =3D 0, subprog =3D -1, i;
> > >         const struct btf_type *t;
> > > @@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_veri=
fier_log *log,
> > >                         bpf_log(log, "Can attach to only JITed progs\=
n");
> > >                         return -EINVAL;
> > >                 }
> > > -               if (tgt_prog->type =3D=3D prog->type) {
> > > -                       /* Cannot fentry/fexit another fentry/fexit p=
rogram.
> > > -                        * Cannot attach program extension to another=
 extension.
> > > -                        * It's ok to attach fentry/fexit to extensio=
n program.
> > > +               if (prog_tracing) {
> > > +                       if (aux->attach_tracing_prog) {
> > > +                               /*
> > > +                                * Target program is an fentry/fexit =
which is already attached
> > > +                                * to another tracing program. More l=
evels of nesting
> > > +                                * attachment are not allowed.
> > > +                                */
> > > +                               bpf_log(log, "Cannot nest tracing pro=
gram attach more than once\n");
> > > +                               return -EINVAL;
> > > +                       }
> >
> > If we add
> >
> > + prog->aux->attach_tracing_prog =3D true;
> >
> > here. We don't need the changes in syscall.c, right?
> >
> > IOW, we set attach_tracing_prog at program load time, not attach time.
> >
> > Would this work?
>
> I think it'd work.. I can just think of a case where we'd not allow
> to attach fentry program (3) to another fentry (2) even if it's not
> attached, but just loaded, like:
>
>
> load (fentry1 -> kernel function)
>
> load (fentry2 -> fentry1)
>   fentry2->attach_tracing_prog =3D true
>
> load (fentry3 -> fentry2)
>   if (fentry2->aux->attach_tracing_prog)
>     return -EINVAL
>
>
> I guess it's corner case that does not make much sense, but still it
> feels more natural to me to set it in attach time

If we set attach_tracing_prog at attach time, the following will
succeed:

  load (fentry1 -> kernel function)
  load (fentry2 -> fentry1)
  load (fentry3 -> fentry2)
  attach (fentry1)
  attach (fentry2)
  attach (fentry3)

We can even make attach chain longer, as long as we load
the chain first. This is really confusing to me. So I think we should
set the flag at load() time.

Does this make sense?

Thanks,
Song

