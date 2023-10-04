Return-Path: <bpf+bounces-11383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3A97B8428
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B8D93281827
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B381B28D;
	Wed,  4 Oct 2023 15:50:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CE31B286
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 15:50:46 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03219E
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 08:50:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so10262f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434642; x=1697039442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu4prCRSFYx7xVoKiC9NY3fxGETVfss7YsZzsQgbM10=;
        b=DMx0v9ToxYce3BuSJGEendba25hKeVPhmyBTf3C5ip1E8epmLmYBIInERLwUAjuF85
         nMGezls9OLum6eSHW0hLhfhKtfMEp9uW57ofT0WtK2JfrD7mHNgC8L6PhiJnfpjNPH84
         BQ1ec+Po4w0dc0IyXDh/1pnDxz5XbCiVRa5m1FwDtTJi1eEfZCiwzjkSr8RioZ6Ysxf2
         SJz+CmypVxDUftwosSvK0nnJAEtqNgLvCOVIfgvTP1Ww3/XL3++jgYw3vy8OzGGxBDIM
         rJQvj5BX7plr1wftAZHDqwMQcpk9HuUfvBvb0dc1J858+ffOfnaF87OtPiYNhxYEv7Es
         Xeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434642; x=1697039442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu4prCRSFYx7xVoKiC9NY3fxGETVfss7YsZzsQgbM10=;
        b=gPleCwDZfkjt6bqoFrF1JjWzceiBvPWhfRc0KzHPeSl9tI3R1VmCQ8CttPi+qOd9Gc
         0m3n39Zk/G9mS5zaDKAU7LAWd5Do3AFA0R+18N7ln7WswcAFi2vpf50+wt08viKE4/Z6
         JTR3Xy8YxB1qAvgVox0d0HwP1jzBUMHm01V8WNgM7xoz/+XsRvZr5n1kdsyMvRUfRSZP
         ankGo6Yei7tvBqeO3XaT6Nlb64EiL3CSOfjfEMohRh+gNF5Iwm/ZKgWYmbI0xQ9RuLFV
         Kw3Dasmf4TRFfaD8sLDo51ZCrdw1sZbtBPMWnnJB2huwHSC8pmC7w2Aaa51EhaQxYjjO
         nyEg==
X-Gm-Message-State: AOJu0YxOFRR55RNdPU28/KmlnZlRGQ0muDH/1zOOJjZE/0/mcCPDYSfC
	nUWdfLw9N7NlUNui85IZicfPK8Q2K1+lJ+7rl94=
X-Google-Smtp-Source: AGHT+IELa0jmU3IXx7SvFXO8E126wql41LQW/5WBvIzLiexJ31V1Byv4k3qoVeL8CdxI2UnuFSFTfXPBKesqXTnAiqg=
X-Received: by 2002:a5d:45d1:0:b0:31f:fee5:b43e with SMTP id
 b17-20020a5d45d1000000b0031ffee5b43emr2580416wrs.18.1696434642083; Wed, 04
 Oct 2023 08:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926190020.1111575-1-song@kernel.org> <169643402844.27884.17605341056103086153.git-patchwork-notify@kernel.org>
In-Reply-To: <169643402844.27884.17605341056103086153.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Oct 2023 08:50:30 -0700
Message-ID: <CAADnVQJL49FRovimFeGmSuiL-12WdDKkLaCKsSc+agEaFnW9CQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/8] Allocate bpf trampoline on bpf_prog_pack
To: patchwork-bot+netdevbpf@kernel.org
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 8:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (main)
> by Alexei Starovoitov <ast@kernel.org>:

What is going on?
I didn't touch this commit.

> On Tue, 26 Sep 2023 12:00:12 -0700 you wrote:
> > This set enables allocating bpf trampoline from bpf_prog_pack on x86. T=
he
> > majority of this work, however, is the refactoring of trampoline code.
> > This is needed because we need to handle 4 archs and 2 users (trampolin=
e
> > and struct_ops).
> >
> > 1/8 is a dependency that is already applied to bpf tree.
> > 2/8 through 7/8 refactors trampoline code. A few helpers are added.
> > 8/8 finally let bpf trampoline on x86 use bpf_prog_pack.
> >
> > [...]
>
> Here is the summary with links:
>   - [v3,bpf-next,1/8] s390/bpf: Let arch_prepare_bpf_trampoline return pr=
ogram size
>     https://git.kernel.org/netdev/net/c/cf094baa3e0f
>   - [v3,bpf-next,2/8] bpf: Let bpf_prog_pack_free handle any pointer
>     (no matching commit)
>   - [v3,bpf-next,3/8] bpf: Adjust argument names of arch_prepare_bpf_tram=
poline()
>     (no matching commit)
>   - [v3,bpf-next,4/8] bpf: Add helpers for trampoline image management
>     (no matching commit)
>   - [v3,bpf-next,5/8] bpf, x86: Adjust arch_prepare_bpf_trampoline return=
 value
>     (no matching commit)
>   - [v3,bpf-next,6/8] bpf: Add arch_bpf_trampoline_size()
>     (no matching commit)
>   - [v3,bpf-next,7/8] bpf: Use arch_bpf_trampoline_size
>     (no matching commit)
>   - [v3,bpf-next,8/8] x86, bpf: Use bpf_prog_pack for bpf trampoline
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>

