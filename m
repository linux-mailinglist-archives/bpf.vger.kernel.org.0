Return-Path: <bpf+bounces-14788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8307E7F53
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 18:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A35281325
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D468938F96;
	Fri, 10 Nov 2023 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzZTxHbX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744838F90
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 17:52:44 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9377739D
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:50:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso3728121a12.1
        for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699638564; x=1700243364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkMAB4YVokGeGTxb43Rwt1oILLIE/sypDaAWpbOjiRs=;
        b=hzZTxHbXWGt3idL3AZ/4bJK3S9G9xjr6rqF7waIWvyuIT9kFrz2YWkOTVA8GG7f8bR
         RqhBChWPlw9Bj5kYEPtJh7Z97+DjbAS8QWNGCHZJmb2bxqIsk7h92uhD+bOz4nYHQYJF
         2qlOf+32jDirVSaLwikXRfGf4goWPZ1bc/C9WPlecEtsvy8WrKj8qen3uNruiYjuUcvT
         51pExRcP9wVPvIPuMJORLLvkyZmRw58TUxmLAhAJ2VfoHydDpTzTevO8UJ/9qSxrEJQ4
         n7nUUP862oLo4uySjC4G5IolO5ZImTwQCF5AmHCfsP9QFShU+crEjLgvop3+1/sF9HlN
         bqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638564; x=1700243364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkMAB4YVokGeGTxb43Rwt1oILLIE/sypDaAWpbOjiRs=;
        b=WuM9vyJ2lpsipt8BOBmMYqS7Lizc1XfcZteS91Mcz4BvkpjeEcUfYsck/UCH0Jvel6
         2y/kXIP24x0zDVaaCa4OCMqlzN6q5BQPB9gG+6SaF9OwL4lzLtGc5a40S8YHuQ5mFXY2
         yrQdfJJaLjX+mKBXkBLQgL/E+3wx6OlojbKKOp0j6U+zIjyzNCNyzB+YWXjYfyewPxt/
         MgRb4EFOiI4NrNlqOrDxAQrwBWxY4nvMopJXEo+XU0K41ZQrX+mcvFf9aLNHhIj3q127
         sWVICS+GmVo2emRPAJBedxTc8egbGYRxSwAc9oX4WTEhfWJmsjAO4ZKCWd+ooE1E2XdL
         TkLg==
X-Gm-Message-State: AOJu0YxLy609IgK4hekH85XHxEy3r3bzfg94nMoXzepysxw3ta4bBSEJ
	fXZW+/+ESelKSHlNKvn06HWhaeZVJt4VlTZWPF7hEWRt
X-Google-Smtp-Source: AGHT+IGVYuySdpLymVG5RmOMH5tB2DLK2dnJvlgEIthQNP8yAWSJdPybqA/9Gr23wLxg7Mu0eR6IknOOPkvcM+dPD5w=
X-Received: by 2002:a05:6402:518e:b0:543:5c2f:e0e6 with SMTP id
 q14-20020a056402518e00b005435c2fe0e6mr73157edd.17.1699638564331; Fri, 10 Nov
 2023 09:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110161057.1943534-1-andrii@kernel.org> <20231110161057.1943534-3-andrii@kernel.org>
 <ZU5qWjVoe--qY_Ja@google.com>
In-Reply-To: <ZU5qWjVoe--qY_Ja@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Nov 2023 09:49:12 -0800
Message-ID: <CAEf4BzZc7KMxu252cdmbDUk7J3CfFH2Z7juQYqww1Vc2SGYdkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: move verifier state printing code to kernel/bpf/log.c
To: Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 9:37=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 11/10, Andrii Nakryiko wrote:
> > Move a good chunk of code from verifier.c to log.c: verifier state
> > verbose printing logic. This is an important and very much
> > logging/debugging oriented code. It fits the overlall log.c's focus on
> > verifier logging, and moving it allows to keep growing it without
> > unnecessarily adding to verifier.c code that otherwise contains a core
> > verification logic.
> >
> > There are not many shared dependencies between this code and the rest o=
f
> > verifier.c code, except a few single-line helpers for various register
> > type checks and a bit of state "scratching" helpers. We move all such
> > trivial helpers into include/bpf/bpf_verifier.h as static inlines.
> >
> > No functional changes in this patch.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h |  72 +++++++
> >  kernel/bpf/log.c             | 342 +++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c        | 403 -----------------------------------
> >  3 files changed, 414 insertions(+), 403 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index d7898f636929..22f56f1eb27d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -782,4 +782,76 @@ static inline bool bpf_type_has_unsafe_modifiers(u=
32 type)
> >       return type_flag(type) & ~BPF_REG_TRUSTED_MODIFIERS;
> >  }
>
> Does it make sense to have a new bpf_log.h and move these in there?
> We can then include it from verifier.c only. Looks like bpf_verifier.h
> is included in a bunch of places and those symbols don't have a prefix
> and might (potentially) clash with something else in the future.
>
> Or is not a super clear cut?


bpf_verifier.h should be used in very BPF-specific portions of code,
so I think this shouldn't be a big problem. Doesn't feel justified to
add a new small header for 4-5 functions, but I don't feel very
strongly about this.

