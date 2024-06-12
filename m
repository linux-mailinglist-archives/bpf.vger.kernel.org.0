Return-Path: <bpf+bounces-31967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E6905A58
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 20:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C65284702
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62C1822FE;
	Wed, 12 Jun 2024 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOcF6+Ys"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC9181312;
	Wed, 12 Jun 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215681; cv=none; b=H0p1twHCsX02vc7otRFook1JXJsvkyq/SfWv0VMbNGeR2JNsDE59iD9Vngp9nVmjbpSOiT+SiLyXPSIM8wo3Y0mIhabGaBbcdm4AzFjGozF1kK1fT/eOb7vG5Rm1Ihybx7p0BvRspvYvX1nqbjuTsq1yTNkNPhcQINSomTSI8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215681; c=relaxed/simple;
	bh=UvHxczzQg4EGAxqN7YDDFJiegaC39sY8/1yzi4kLlVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8gIlH5sjxxwkxeGCHhzezaMGUEz3p5wEC2wH43TXSAsQFI+Fq5hUaPiLHDZo+XYJhyAO1EPvzpUOyVgHBgLCPj8+5VTY971telrbDtyM7MM0fgcliL8NiKzV5GxsM9PGIGGFP4sf7gt/TnFI5WpqqhDPfSQdRvUBA3SFp9xGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOcF6+Ys; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35f225ac23bso184764f8f.0;
        Wed, 12 Jun 2024 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718215678; x=1718820478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2KvIJWno4Stgu8w7sh9JsxW4Akq08TY0yFh2XkaJLI=;
        b=OOcF6+YsiTr/1sFCIQFd6D4FgwMkZxOCpBSyT5HdiiROAOavGUsxlr1UNW7j4vHQf2
         QN9ZHQ81fR4tBqYjDVK84wC619MHXL29O94LHQPLrH20L2Jbfma144pQqP50N78qeAyA
         hJ6aTjdjsT83bM2rbDA6XrqHXk+TdzLmOqR72cTBr+Bj2TtmOGm0XLAokrvAeg7SKt4n
         yU0CdLDPanBXmxeSgm660thoK7WESKxmnHV48ynXYa7RbabYC/KAfoZGQCaylr8/l4df
         4srOaLadqrGyz5t5TO7RMxVWOJ9NuXmRGqRSGDsXjuwkaLxeY9KYlH4LSvvy23pRnu4R
         m/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718215678; x=1718820478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2KvIJWno4Stgu8w7sh9JsxW4Akq08TY0yFh2XkaJLI=;
        b=rKs/iozrhoW1R6eRcamFp784sNA76k6eTIdVD8tjazCulUTkrWOfNYPfPdlU6HfmyK
         SK/eiHEcfbIbYP65IPWmGUkmqIUJQfpIdrv9dbUrmcYsmiTEt0tkSPV1NvqFJA+j0VYh
         3vhkEK9m4lyMLXZjZlYRS6MPpeYp2WFENoZEzNhcQLiy87qlieCp90akmPfXklBVqw/i
         lk7ks6DhFA3t+HDFameLWtTzoces2/FYltmlCd5EhD1sUhS+uIA9qC2p1TvHnrllKs89
         ANpzdrN9btSTl5crbESGTEGC7Be+jgZihOcrjnkTfLe7Sh8jlzyuTcoTP6/5HduzPocf
         w6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7UVJiMZpyi93Q8kWRPn9mB7jDcHOHsUNgcmLjBmEdMuBOVrNeZGV6zKsaY+/ktUzg8/YOzpdO3LeQbQB3T7Bq8G9YLY0wBpagvT2qwP1lehdVk/v1PQw9aAi2a2DvnOIopK0N3+dVTlb1NGs/jgNVXn90lWn4f05D
X-Gm-Message-State: AOJu0YxoOfuUWQKk3y0VHMYPoT1pBdTADoUzuVbDx/4JwT6DPVMC0oWp
	pDz1E0QmJL1N5MojVShDi8p32mtecwcB1RDdw90nNNB9IpoNxXFGuBidL5jzwL2jmQjVIK0XUpW
	eU8kbeA3R1vrAqC2pRJg1SPX5A/Y=
X-Google-Smtp-Source: AGHT+IFagaa3094jY436YOqfT/9pajpP6WHk7dIsYvtAxQJkEJx4qhjJqT33Ynz5duEVjwU+cavBJQtRxGSDQ4sDvkU=
X-Received: by 2002:adf:ecd1:0:b0:360:7280:9cbd with SMTP id
 ffacd0b85a97d-36072809e11mr54163f8f.34.1718215678437; Wed, 12 Jun 2024
 11:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612085823.28133-1-kunyu@nfschina.com>
In-Reply-To: <20240612085823.28133-1-kunyu@nfschina.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jun 2024 11:07:46 -0700
Message-ID: <CAADnVQLcT3dqtapsYYFAtY9rU8A7RB4aoUvbOweobOGZkbj9+A@mail.gmail.com>
Subject: Re: [PATCH] x86: net: bpf_jit_comp32: Remove unused 'cnt' variables
 from most functions
To: kunyu <kunyu@nfschina.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 1:59=E2=80=AFAM kunyu <kunyu@nfschina.com> wrote:
>
> In these functions, the 'cnt' variable is not used or does not require
> value checking, so these 'cnt' variables can be removed.
>
> Signed-off-by: kunyu <kunyu@nfschina.com>
> ---
>  arch/x86/net/bpf_jit_comp32.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c
> index de0f9e5f9f73..30f9b8a3faed 100644
> --- a/arch/x86/net/bpf_jit_comp32.c
> +++ b/arch/x86/net/bpf_jit_comp32.c
> @@ -207,7 +207,6 @@ static inline void emit_ia32_mov_i(const u8 dst, cons=
t u32 val, bool dstk,
>                                    u8 **pprog)
>  {
>         u8 *prog =3D *pprog;
> -       int cnt =3D 0;

I don't think you bothered to compile it.

pw-bot: cr

