Return-Path: <bpf+bounces-13151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E527D5A5D
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 20:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A1E281A72
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332C83CCEB;
	Tue, 24 Oct 2023 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GoBMniGd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49303C68D
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 18:23:38 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8910A
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:23:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da043b5b6c9so809038276.2
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698171813; x=1698776613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhPdOnDAT6+PH0Vz8+OhielyBKDSwn2hQuYPBjz8d74=;
        b=GoBMniGdumoQamnCW981sYPNKX4w3n07WuWq2knVER51Gc5Y7j/PQkY1mforczzlua
         t/H+c1wmbpIVoX6Bl5WjQKy3UDWumv22J8txGIMAYH4lsxAfrdEG1MHKxyW/bwFcW7zZ
         efy0cilMUzI+bke3LuELpoNSzX/pjD9AzGa8J3eL4+ZJ71cGIaGJTZHiz6vDuBvvmh+K
         ke8VL+eBHQAXdnOf3n9/aReOaw4Gcw53UkMnkLEx+4bQ4skHqn86sfnagYJiX3E4LkGI
         1XX8pY+sAXDhetrHi/U9Ii22D8cbB7i6MWLDC4w1bZCkVsaIQBw5XMdIHwK1Mj8qx/cL
         oC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171813; x=1698776613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhPdOnDAT6+PH0Vz8+OhielyBKDSwn2hQuYPBjz8d74=;
        b=I9O/wqkJRMtKSDs3DYqZvuapjYiyg1FNY1/fKXc+f0GUjf5sWMELmBI091em1bgOyo
         ByroB9OH/OMwT74WrFI3j39mbDJZFZI0mnnUBIj5eyInhbmDpv1e8rrQkDfi/VrNUEw5
         8LCdOJqp8FD8q1/wh8uj8Gd1cvoTbjS5TmR13Qq8rrOjxCcZO2C/DR1s1A9UxQT69SQM
         Yg7PHVtmfIFirICT/GRzu6qJboLl/ES4/21pK0c2CpTQyI2GGU7Ted0qPEBP1BbrnL4K
         a85mMlx3FJmEYNCSaBt562Z1Ug1JPV/R1Pv6Ux0Z1PwS5zL+AZivikm+gRzeTx/M7k8K
         BlCg==
X-Gm-Message-State: AOJu0YyindbIEuhitNMhg8s0Ul27GKPPSIUzjLYjF/yYxWlvPi5pJjEo
	CxT4xamQuH7xxHLDSJ2wgqncYaPEvfmlBQSSQTjo
X-Google-Smtp-Source: AGHT+IGYicwo5fgU8AO29MEj/Hqf7OL3O4Fu0oZpB1YjJyeL4usUQIL7t8AbMBYxOoSYtknsoEYzmYx0zZzWthpg+eM=
X-Received: by 2002:a25:b322:0:b0:d9b:4c61:26f1 with SMTP id
 l34-20020a25b322000000b00d9b4c6126f1mr12961292ybj.24.1698171812890; Tue, 24
 Oct 2023 11:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org> <CAEf4BzaMLg31g6Jm9LmFM9UYUjm1Eq7P6Y-KnoiDoh7Sbj_RWg@mail.gmail.com>
In-Reply-To: <CAEf4BzaMLg31g6Jm9LmFM9UYUjm1Eq7P6Y-KnoiDoh7Sbj_RWg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Oct 2023 14:23:21 -0400
Message-ID: <CAHC9VhRxR3ygxskpfbukHeM5wmX0=SifvLny2eiezWvwAyB9tw@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 1:52=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Oct 16, 2023 at 11:04=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:

...

> > v7->v8:
> >   - add bpf_token_allow_cmd and bpf_token_capable hooks (Paul);
> >   - inline bpf_token_alloc() into bpf_token_create() to prevent acciden=
tal
> >     divergence with security_bpf_token_create() hook (Paul);
>
> Hi Paul,
>
> I believe I addressed all the concerns you had in this revision. Can
> you please take a look and confirm that all things look good to you
> from LSM perspective? Thanks!

Yes, thanks for that, this patchset is near the top of my list, there
just happen to be a lot of things vying for my time at the moment.  My
apologies on the delay.

--=20
paul-moore.com

