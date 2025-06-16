Return-Path: <bpf+bounces-60737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A8ADB5E3
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 17:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E577ABA76
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC31262FE5;
	Mon, 16 Jun 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABlsFso4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB120DD54;
	Mon, 16 Jun 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089073; cv=none; b=MW/glM35z+PNe3y3ifa+6slltq4pabPFXwDCZiVXHjfyIkCG6lPKkCdCfKvhwaEHoD8rCeje6fgXKVOIttsGl12/kfUuz4wR3a+870maf40OXT4grNng+tF9TiLThSQocn9Y13eFeNBkxHFD4MNEP/+Re3UI8N4HjMbTbCTgiJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089073; c=relaxed/simple;
	bh=1IQ346zNYVuM6lRx+3Lxg56eImhlMLA0oHvWP0r94kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfYCesVanDafqvApQSgmRgdlPHoeHAH89fRgrwABS0eXPx4O4KF69Y0GK7ubMPOjm+O/C+pipCRJYrEYXMWPrlbZJ+GlfsM4UJxkCDmszjQ7aQbwNCoGgEewW5KQ4r+bjiVPOjhp7zHLgoQX2EjVHXcTZuQyaz+e2r+KmISSrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABlsFso4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8169DC4CEF8;
	Mon, 16 Jun 2025 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750089072;
	bh=1IQ346zNYVuM6lRx+3Lxg56eImhlMLA0oHvWP0r94kA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ABlsFso4LatrwE13U8Tbb+tm5+R3hqaDkMZM6jlcXooiAVtTO1wRpYqVzfSEyciGe
	 TRJ2F+/c2VgzaAQilK21b5eKaidhYqGsVQWYK1kJHTdXOKYpoOitgFnLcrbNcfTHBL
	 Wipbje2urmd/GAlqADLbBaMS45343VrXJN2iU+Ilu+lgcnGQLt3lsUWKsJG6atp/NV
	 3pU2cdk7ejq0WMKO6YbaI6WQDPdP2kgsilKtfZcf2aCDwS7ujkjH38wPYRPP7C27oV
	 JpXqQC4iPJDgJYeq32FkDI/5hn1Biz+SyzI2NghJQ8ssjQj8gWAHSJEEXcsJcm9jVI
	 sfvIsBjmiR14Q==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a44b3526e6so62870291cf.0;
        Mon, 16 Jun 2025 08:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIU7rKKEHXLNVbppDKsEZPOxpjKxMOYiWMb2DVvkH8gnWOibqfbtNPaRH20Ip9XeLQJcQ=@vger.kernel.org, AJvYcCXBEV8ukEhD0aoj25ZO/lGy15CHNv7B2qTxIjKCBkUAkcsLB8akJ1ykGLR2myWac8dRQnM6WAZVT7zz5Cxa@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEZo3uwx0m6QqZfzP0i8e30UsThki1fI3VjS6vaOsRAOXQ9H2
	7+MqB1YHh+TMcgBkWKZ7uj/iYIySSqlnNyehWPOY1GIdDn/0uf8tN1gfKcdZWapbtt/b2Wm6B01
	3pw61wWCaYcNs0Ek9iVmE9Q0imw1FGlQ=
X-Google-Smtp-Source: AGHT+IEruSD9QNTjLoQwJZZefnA/4WRHh7lO5AJIHFCUDpHpP+t8W6jXHMulp+dSHEV0ihSgIt6cozsKO9xdrVpRX+k=
X-Received: by 2002:ac8:7fcb:0:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-4a73c5c3447mr162424511cf.52.1750089071562; Mon, 16 Jun 2025
 08:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616095532.47020-1-matt@readmodwrite.com>
In-Reply-To: <20250616095532.47020-1-matt@readmodwrite.com>
From: Song Liu <song@kernel.org>
Date: Mon, 16 Jun 2025 08:50:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
X-Gm-Features: AX0GCFvUaE9dttZdJBdvpTmPqrf3iG2pJ0W7olm9JHra97Bg2gJGxgUnrlZedhk
Message-ID: <CAPhsuW4ie=vvDSc97pk5qH+faoKjz+b51MDYGA3shaJwNd677Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
To: Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 2:55=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> From: Matt Fleming <mfleming@cloudflare.com>
>
> Calls to kfree() in trie_free() can be expensive for KASAN-enabled
> kernels. This can cause soft lockup warnings when traversing large maps,

I think this could also happen to KASAN-disabled kernels, so the commit log
is a bit misleading.

>
>   watchdog: BUG: soft lockup - CPU#41 stuck for 76s! [kworker/u518:14:115=
8211]
>
> Avoid an unbounded loop and periodically check whether we should reschedu=
le.
>
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>

Other than that:

Acked-by: Song Liu <song@kernel.org>

> ---
>  kernel/bpf/lpm_trie.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index be66d7e520e0..a35619cd99f6 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -646,6 +646,8 @@ static void trie_free(struct bpf_map *map)
>                         RCU_INIT_POINTER(*slot, NULL);
>                         break;
>                 }
> +
> +               cond_resched();
>         }
>
>  out:
> --
> 2.34.1
>

