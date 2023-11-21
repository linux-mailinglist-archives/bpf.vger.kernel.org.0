Return-Path: <bpf+bounces-15590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54E7F36F0
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2732282A30
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624242063;
	Tue, 21 Nov 2023 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmjXhru9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F48A19E
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:50:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507962561adso8751020e87.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 11:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700596243; x=1701201043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggGTkOO+fgrU/vFFxihurBT+GKQyCiV72PrTBO2Kpm4=;
        b=XmjXhru9fLvEsH/2y5jzOKQ2CLtsjNRAv6/iJU2SaGc24bM2H1YI3uP71y/7GC+ciZ
         IJ+LEKGyUjZd787vAgoapdq1TLWzUtrjbnmhpXdNnG57yuxWgmGk6rlncAKpNoMqmgbm
         apN5zoD4+HfNuXtDVnvrx70XBtmOKHj/dX6Oq0YULx5D1FnbLImPgAAgTVqqE4aBWyXv
         6x/cnn9NuKjAPgYamYrLBmc9T4ywbSucRgRC3PN/vmtXsO0WzAfDvd8pbYFPD7OjwOmH
         /KZb+ULyllSxd/DKkE3c9qkONZNQAOgiSU8efcODTh1E6yRloAzLJZ11n2dkn4VjY0Iv
         WddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596243; x=1701201043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggGTkOO+fgrU/vFFxihurBT+GKQyCiV72PrTBO2Kpm4=;
        b=kj3zmXnjxSJx9VdkmxfKH8IbcGNw6qumr+KCDz5jhsKB680y2foLlHxgv+a1yZLH4T
         RsoWmdWqxYd20UNBF2GZVEmn4Bi03oSO/2g1DOQVV6Nlx2rF4PhqLBnaDMZ63rGeOlgS
         8CUBbt79f5cou6exIPfOXtLHeZyHYaLLweaIE78SrYWsaHttNQL0K1NyaH09oFKFBQcN
         tGn2IfXJAwVze5krxwFy8SetiWHoFUxNG9Lz9fRGd9HrI1LDh6cro/Fn0IIQhKpIwdel
         A1Z8+nfvJE0jdVcLkuo4W4l5KZSyeIl8GiHgmIxVdPYGpYw3MxVon8f3vp7jOz8LK5Jq
         /MRw==
X-Gm-Message-State: AOJu0YzilwnE4ipPEwbs2sD7ZELoEOLyF3Bt9jMCYhdo7jHpQY392JhA
	OTHNzQo/qTgR0fxDOaRXlbITyKjZztiuf++P+7E=
X-Google-Smtp-Source: AGHT+IExRKb0xhA4GkLOlPKTmMBRgY/HZRP91NoZaDI87Jpfr4qBg+Nj8huodVm4vKTIq1ODYT9LyT+J7r/yFPpfy1s=
X-Received: by 2002:a05:6512:53b:b0:507:a04c:1bcf with SMTP id
 o27-20020a056512053b00b00507a04c1bcfmr183699lfc.58.1700596243339; Tue, 21 Nov
 2023 11:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116194236.1345035-1-chantr4@gmail.com> <20231116194236.1345035-2-chantr4@gmail.com>
 <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
 <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com> <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
In-Reply-To: <CAADnVQ+f80KNBcjYRzBJw4zhYfhYa=Cw9bdQEe+Z1=CnQaa9Gw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Nov 2023 11:50:31 -0800
Message-ID: <CAEf4BzZMDfBao58ynxAKys3bB=A+SRLORz65Ce4ron60m=NojQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>, Manu Bretelle <chantr4@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 21, 2023 at 8:26=E2=80=AFAM Quentin Monnet <quentin@isovalent=
.com> wrote:
> >
> > >
> > > Does it have to leave in the kernel tree?
> > > We have bpftool on github, maybe it can be there?
> > > Do you want to run bpftool tester as part of BPF CI and that's why
> > > you want it to be in the kernel tree?
> >
> > It doesn't _have_ to be in the kernel tree, although it's a nice place
> > where to have it. We have bpftool on GitHub, but the CI that runs there
> > is triggered only when syncing the mirror to check that mirroring is no=
t
> > broken, so after new patches are applied to bpf-next. If we want this o=
n
> > GitHub, we would rather target the BPF CI infra.
> >
> > A nice point of having it in the repo would be the ability to add tests
> > at the same time as we add features in bpftool, of course.
>
> Sounds nice in theory, but in practice that would mean that
> every bpftool developer adding a new feature would need to learn rust
> to add a corresponding test?
> I suspect devs might object to such a requirement.
> If tester and bpftool are not sync then they can be in separate repos.

I'm also wondering what Rust and libbpf-rs dependency adds here? It
feels like bash+jq or Python script should be able to "drive" bpftool
CLI and validate output, no?

