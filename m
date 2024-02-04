Return-Path: <bpf+bounces-21184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C008491BA
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 00:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FBEB21244
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F006BE65;
	Sun,  4 Feb 2024 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrBALcvN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BFBE5A;
	Sun,  4 Feb 2024 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089873; cv=none; b=mioRwusR6sgTL2SamgL4HwosnHqUfIFYA3aHfPss2+bMbEcu+f/iNX163xlbpi5iAJmneeSdqTXLwhjB9qMRkM470Xg0hWzhj28SDFpw9s/IypxzfycMHbKTgaBJblKKcweXQHJxXaTPiiYWvt8ged4257G2ePo9RnactQVGmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089873; c=relaxed/simple;
	bh=xMuEX2HhSOWhMjSoGbp5fz3b2E6nd36eVhjFe8HoL38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kfn5pBl76gXRQdLKHx/vhH5LkLBKE9tD++lxluwoRzEsmoXINpTu+ewNS8iCdXCG6BZ73diT4kjo+z3FPx5jSFG+QKwuuYal6zwhiPNgTGYR0AAhOCvm5YUpQRIeFfIZ2AfSPC3dW9tA3pXE4DENbBE0QwgCRNLWP/O/B8edqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrBALcvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F6CC43394;
	Sun,  4 Feb 2024 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707089873;
	bh=xMuEX2HhSOWhMjSoGbp5fz3b2E6nd36eVhjFe8HoL38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IrBALcvNbwMwYTt/GqUh4UnKd/8Xf54XeNhdJHVGGXCkEf6Tjuh8RjSs95BijMqsB
	 9Yip2ZsFOXHb4dAMk2aD5FEhaQ6t1572WYq4dEsNguG+gpjY5tRKNwWQw6cG1Ln7Gj
	 jhU3cyo6rtNvC9Dx5t/l1btd1NvRf5dTS5TxpgZTJo2VEb8+1iGU2kbVsUyiWii3kq
	 zLZCAgWbORD+nIAeHnQ+AYH0m+9ePTldDSimTjmgLG96A2elONzv8IN1yYjrBvSq9M
	 sfTq5t2/8dr7ZxbxOU2GZV7GjQ6uQiW/xjdaMDzAJTfE8U8pXEcV0DZAEcbDNaIBaL
	 YVAj5wNN2x5rQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51032058f17so4337893e87.3;
        Sun, 04 Feb 2024 15:37:53 -0800 (PST)
X-Gm-Message-State: AOJu0YwqODpNtKVdwRH37esJvHL8qt809oNYQdEKeWzq7z+u7Y012FwR
	djp6LjxtCgYTIpaWLy6opRwHyAHEbIPKaCILCwR0L8qoYTUxvuSidO5OZO71opv0MiELzclrJyC
	ko+3UhD3eCJXwjgAOLw7IXBDfO6Y=
X-Google-Smtp-Source: AGHT+IHtkWru/up13iHyvWFxO8oQEUipK4WnOY8CJZFPxIrVWaeLANbZx0U4CByTW3mJfdxicWs7Eevh8OSiGVnp6OA=
X-Received: by 2002:a05:6512:2384:b0:511:3489:507b with SMTP id
 c4-20020a056512238400b005113489507bmr7300367lfv.19.1707089871527; Sun, 04 Feb
 2024 15:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204075634.32969-1-masahiroy@kernel.org> <25615f41-a725-4276-bc0a-a3e7fe47b864@linux.dev>
In-Reply-To: <25615f41-a725-4276-bc0a-a3e7fe47b864@linux.dev>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 5 Feb 2024 08:37:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQiz1uMxHZ9K9=g=4goQB0TTFrdOcjgN=ZemU6BfYWqnQ@mail.gmail.com>
Message-ID: <CAK7LNAQiz1uMxHZ9K9=g=4goQB0TTFrdOcjgN=ZemU6BfYWqnQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: merge two CONFIG_BPF entries
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:11=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 2/3/24 11:56 PM, Masahiro Yamada wrote:
> > 'config BPF' exists in both init/Kconfig and kernel/bpf/Kconfig.
> >
> > Commit b24abcff918a ("bpf, kconfig: Add consolidated menu entry for bpf
> > with core options") added the second one to kernel/bpf/Kconfig instead
> > of moving the existing one.
> >
> > Merge them together.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >   init/Kconfig       | 5 -----
> >   kernel/bpf/Kconfig | 1 +
> >   2 files changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 8d4e836e1b6b..46ccad83a664 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1457,11 +1457,6 @@ config SYSCTL_ARCH_UNALIGN_ALLOW
> >   config HAVE_PCSPKR_PLATFORM
> >       bool
> >
> > -# interpreter that classic socket filters depend on
> > -config BPF
> > -     bool
> > -     select CRYPTO_LIB_SHA1
> > -
> >   menuconfig EXPERT
> >       bool "Configure standard kernel features (expert users)"
> >       # Unhide debug options, to make the on-by-default options visible
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index 6a906ff93006..bc25f5098a25 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -3,6 +3,7 @@
> >   # BPF interpreter that, for example, classic socket filters depend on=
.
> >   config BPF
> >       bool
> > +     select CRYPTO_LIB_SHA1
>
> Currently, the kernel/bpf directory is guarded with CONFIG_BPF
>    obj-$(CONFIG_BPF) +=3D bpf/
> in kernel/bpf/Makefile.


Wrong.

"in kernel/Makefile".


Why is it related to this patch?



> Your patch probably works since there are lots of some other BPF related
> configurations which requires CONFIG_BPF. But maybe we sould
> keep 'config BPF' in init/Kconfig and remove 'config BPF'
> in kernel/bpf/Kconfig. This will be less confusing?


Why?



> >
> >   # Used by archs to tell that they support BPF JIT compiler plus which
> >   # flavour. Only one of the two can be selected for a specific arch si=
nce



--=20
Best Regards
Masahiro Yamada

