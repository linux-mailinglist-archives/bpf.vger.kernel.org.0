Return-Path: <bpf+bounces-18173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C575C8167A8
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 08:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422FCB22989
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8ADF4A;
	Mon, 18 Dec 2023 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTYeB2IA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495A12B72
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-553032f17cfso1552896a12.0
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 23:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702885637; x=1703490437; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgr4ZrlQqSmpbmOHh9uJgvzf/0OH8hhuW50Gkw+FJqE=;
        b=WTYeB2IAP9Z3YxeBm5V0FluIh4DWs5xTKcG542+pEDJRkXzLQB01vkufGxJtL7x0IG
         eZmr9OxvogM0OgpCJSbCs9EtHioROB1DXYg8Z1sK/q6asMft1k/2nuJi11cAlVztMmUT
         XI+FykkWnFP0xw3I8m6T4VV3LmMp6Y62qA0prtbfgM9qYcn6v6saXHyjBykpKu/QoHm0
         hHheUlhYJPc2aelz0IjZlYVDzbj0BCy640CHkYCPt5+EnWltijWUcDdCx0ewqKNHww2G
         gRmv8FnP7SfoPo2U2CGddCO3EFRxboSjCpg4sL1aH5AX76KB7KH0oWhGOsySriSWliLz
         cNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702885637; x=1703490437;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgr4ZrlQqSmpbmOHh9uJgvzf/0OH8hhuW50Gkw+FJqE=;
        b=isooN3VTwfoJSblwuXFLqNufpdBFMpQhO/SLgFwIHfhfqxQvya5y+L60ImNG99eULG
         AcBmGApJB5aEIMVTzIG8Iy5CK7WoodynOt2v5FLH/mlZ/tPre+67SawIcJUDRRB5A7FV
         u/IBdR10DRfKH7nD8SjS1GLhH7UgMifSocXgDQ66QEi+YQSOQ0XfokIOsbG8MD8ZGA9z
         e33yXVO2I6MHM4a+9y+j/ngnD8RkWh5LeMDoqJtXa70VGJKjGf7GCrRyt6Bd3hPLSlb3
         xUdJllEfLPjOf+ILWSicuYwGNy3BFozycvRyIm9Iytmc4UDahl1HTn9HJN/teQQJl71h
         +h4g==
X-Gm-Message-State: AOJu0YwveVSX/eW5hBzSqCW8sT1ib9Ge1zU1bmN0RW0gqXi9G6rdiman
	iGX+NrDdxwIWr6WW1RrW2Ec=
X-Google-Smtp-Source: AGHT+IHIal5DYlIZE9W5MYV/BiYpb/g8uC+YYcEIpS4ZpkUnceT/zAZa6likcMrqrtsfr8U4CSRh3w==
X-Received: by 2002:a50:c00b:0:b0:552:2b83:30b7 with SMTP id r11-20020a50c00b000000b005522b8330b7mr4716792edb.32.1702885636718;
        Sun, 17 Dec 2023 23:47:16 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id er25-20020a056402449900b005536476bd56sm334792edb.83.2023.12.17.23.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 23:47:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Dec 2023 08:47:14 +0100
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>,
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org, asavkov@redhat.com
Subject: Re: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZX_5AhpYjcX06feL@krava>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
 <20231215200712.17222-2-9erthalion6@gmail.com>
 <CAPhsuW4VJ-wS_Jh9VCMAvLtbd9djtDikApH4NYCo9+Jgqz8eLQ@mail.gmail.com>
 <ZX9KY-uouFF1Doz3@krava>
 <CAPhsuW4SfDEPy3sxTTr2VPYCW7ysM+ACUHwzuAcniy9-cgan5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4SfDEPy3sxTTr2VPYCW7ysM+ACUHwzuAcniy9-cgan5A@mail.gmail.com>

On Sun, Dec 17, 2023 at 04:58:07PM -0800, Song Liu wrote:
> On Sun, Dec 17, 2023 at 11:22 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sat, Dec 16, 2023 at 05:31:21PM -0800, Song Liu wrote:
> > > On Fri, Dec 15, 2023 at 12:11 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> > > [...]
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index eb447b0a9423..e7393674ab94 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
> > > >         bool dev_bound; /* Program is bound to the netdev. */
> > > >         bool offload_requested; /* Program is bound and offloaded to the netdev. */
> > > >         bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
> > > > +       bool attach_tracing_prog; /* true if tracing another tracing program */
> > > >         bool func_proto_unreliable;
> > > >         bool sleepable;
> > > >         bool tail_call_reachable;
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index 5e43ddd1b83f..bcc5d5ab0870 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -3040,8 +3040,10 @@ static void bpf_tracing_link_release(struct bpf_link *link)
> > > >         bpf_trampoline_put(tr_link->trampoline);
> > > >
> > > >         /* tgt_prog is NULL if target is a kernel function */
> > > > -       if (tr_link->tgt_prog)
> > > > +       if (tr_link->tgt_prog) {
> > > >                 bpf_prog_put(tr_link->tgt_prog);
> > > > +               link->prog->aux->attach_tracing_prog = false;
> > > > +       }
> > > >  }
> > > >
> > > >  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> > > > @@ -3243,6 +3245,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> > > >                 goto out_unlock;
> > > >         }
> > > >
> > > > +       /* Bookkeeping for managing the prog attachment chain */
> > > > +       if (tgt_prog &&
> > > > +           prog->type == BPF_PROG_TYPE_TRACING &&
> > > > +           tgt_prog->type == BPF_PROG_TYPE_TRACING)
> > > > +               prog->aux->attach_tracing_prog = true;
> > > > +
> > > >         link->tgt_prog = tgt_prog;
> > > >         link->trampoline = tr;
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 8e7b6072e3f4..f8c15ce8fd05 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > > >                             struct bpf_attach_target_info *tgt_info)
> > > >  {
> > > >         bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
> > > > +       bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
> > > >         const char prefix[] = "btf_trace_";
> > > >         int ret = 0, subprog = -1, i;
> > > >         const struct btf_type *t;
> > > > @@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> > > >                         bpf_log(log, "Can attach to only JITed progs\n");
> > > >                         return -EINVAL;
> > > >                 }
> > > > -               if (tgt_prog->type == prog->type) {
> > > > -                       /* Cannot fentry/fexit another fentry/fexit program.
> > > > -                        * Cannot attach program extension to another extension.
> > > > -                        * It's ok to attach fentry/fexit to extension program.
> > > > +               if (prog_tracing) {
> > > > +                       if (aux->attach_tracing_prog) {
> > > > +                               /*
> > > > +                                * Target program is an fentry/fexit which is already attached
> > > > +                                * to another tracing program. More levels of nesting
> > > > +                                * attachment are not allowed.
> > > > +                                */
> > > > +                               bpf_log(log, "Cannot nest tracing program attach more than once\n");
> > > > +                               return -EINVAL;
> > > > +                       }
> > >
> > > If we add
> > >
> > > + prog->aux->attach_tracing_prog = true;
> > >
> > > here. We don't need the changes in syscall.c, right?
> > >
> > > IOW, we set attach_tracing_prog at program load time, not attach time.
> > >
> > > Would this work?
> >
> > I think it'd work.. I can just think of a case where we'd not allow
> > to attach fentry program (3) to another fentry (2) even if it's not
> > attached, but just loaded, like:
> >
> >
> > load (fentry1 -> kernel function)
> >
> > load (fentry2 -> fentry1)
> >   fentry2->attach_tracing_prog = true
> >
> > load (fentry3 -> fentry2)
> >   if (fentry2->aux->attach_tracing_prog)
> >     return -EINVAL
> >
> >
> > I guess it's corner case that does not make much sense, but still it
> > feels more natural to me to set it in attach time
> 
> If we set attach_tracing_prog at attach time, the following will
> succeed:
> 
>   load (fentry1 -> kernel function)
>   load (fentry2 -> fentry1)
>   load (fentry3 -> fentry2)
>   attach (fentry1)
>   attach (fentry2)
>   attach (fentry3)
> 
> We can even make attach chain longer, as long as we load
> the chain first. This is really confusing to me. So I think we should
> set the flag at load() time.
> 
> Does this make sense?

yes, I did not consider this option.. makes sense

thanks,
jirka

