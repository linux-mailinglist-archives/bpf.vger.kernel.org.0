Return-Path: <bpf+bounces-61090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4216FAE0A31
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1D01673B1
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B278221F2E;
	Thu, 19 Jun 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Cge1br"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87C21E094;
	Thu, 19 Jun 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346427; cv=none; b=c3K8/RE04FxZLQF3kU7kkyfaGHfW6MzhX4tby+4rjtPszl1wpEbDbnYLH3V6ViWZo83MAyD+kK/L3qVINAqN/skTl2qLSotB01u8p+cj/q4jLodyihiX1v96viihAOgId/HXStj8fG3SL3Xwu1bE370mf8LtZnm1w6zGoUp9Ef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346427; c=relaxed/simple;
	bh=YYemg1DZbLYuOwEnTxXkp/8rM6iO4piNRQwhWzEsPyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFdhpm63dj67/58Y12jv2pQcJsLcT4SEGtMx/K+BEq1P+KaAcdS92mO2zxwBBtjzuRv73eDdwei/0dhFqlBpAVU+yfwSV6GJeyJl3BnTN1CXcuD5hk9NJuv1ZegaHdzK8IvWFetf0XoaQsGBmmTib86ew7uVTvF4IjFbjuKHbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Cge1br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6860AC4CEEF;
	Thu, 19 Jun 2025 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346427;
	bh=YYemg1DZbLYuOwEnTxXkp/8rM6iO4piNRQwhWzEsPyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g6Cge1br7gh3z3g/7NXWP+pIDxR0Y07FlnMCprV04fnZlHl9ztfOZ7Jed23XO+PwA
	 YKPnTdVXfe+jqS/5fRxzvFGJJgXelgyJyVPUgCGoumCwvVLgHGPA8qgNLv6Eoal+zP
	 naFQmYU3q55b/A1KPYDO9DinE2sCg6tp8GBI6xOGYK53wyYiyAKPi/TbZDFdA5sA+K
	 5DARdyi30SsSAuDzSYgwrQ6XWpuBJ1SxBOTnpuHacevnZWf6yj22aubGWyIbeoY94O
	 F8PiwN52uVLJIHJ+Hn8e8vGLdx773W+r7ou/e94Uly9UHLiiWJa2WjqPBDGPBa6lnp
	 PmzFLFWpFV5IQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso1475280a12.1;
        Thu, 19 Jun 2025 08:20:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9bjSYnosEb+D3de2oYgsG+JMYngzk/EcpkIN9FTRkikDWPy7sYLwS+ADc9Oaa49/bWjPleUd3j+4OJR6x@vger.kernel.org, AJvYcCWFLUD3Y3/v2Pp6VpyBYlzSWtSiTfvaTkEJBvRwSFksUbI6+XhU2yXkzs0CI18jZ1easX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV98ijHzXTpcqhPKmT6gpEjPGRS6uuV9Vtq7LIJGvCGouyuB+m
	8x8MYn/r65P31a8C/1XjVPsS99X2Iq6b4dwkGNeESbTZ8DhUWmL68lDJsEvfkjmVNyeRsNLSRwm
	HExuATNgRfXSM2QvjcFsQnKEzgbmCw1o=
X-Google-Smtp-Source: AGHT+IFXK+Qw9NgGm0hee492d8UUku0ecCMsOIPbbPeNge5/EfHtOghCJ2WTuf5yJT7m69zgr05or7oou+dMn0UFtOc=
X-Received: by 2002:a50:d00a:0:b0:609:b5e0:598a with SMTP id
 4fb4d7f45d1cf-609b5efa3c2mr5938805a12.24.1750346425944; Thu, 19 Jun 2025
 08:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617063206.24733-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250617063206.24733-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 23:20:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6TeZpLyY19xBhVwZbQeH5gQyZZqw_xP2P9rgTyFOiHUw@mail.gmail.com>
X-Gm-Features: AX0GCFuKQYqo1n7IN8eZ9SnbFz0JRivAai9Ek3n9r7iBcKd8_Yvi2GKDfv2Nfps
Message-ID: <CAAhV-H6TeZpLyY19xBhVwZbQeH5gQyZZqw_xP2P9rgTyFOiHUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] LoongArch, bpf: Set bpf_jit_bypass_spec_v1/v4()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued for loongarch-next, thanks.


Huacai

On Tue, Jun 17, 2025 at 2:32=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> JITs can set bpf_jit_bypass_spec_v1/v4() if they want the verifier
> to skip analysis/patching for the respective vulnerability, it is
> safe to set both bpf_jit_bypass_spec_v1/v4(), because there is no
> speculation barrier instruction for LoongArch.
>
> Suggested-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> This is based on the latest bpf-next tree which contains the
> prototype and caller for bpf_jit_bypass_spec_v1/v4().
>
> By the way, it needs to update bpf-next tree before building
> on LoongArch:
>
> [Build Error Report] Implicit Function declaration for bpf-next tree
> https://lore.kernel.org/bpf/d602ae87-8bed-1633-d5b6-41c5bd8bbcdc@loongson=
.cn/
>
>  arch/loongarch/net/bpf_jit.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index fa1500d4aa3e..5de8f4c44700 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1359,3 +1359,13 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>         return true;
>  }
> +
> +bool bpf_jit_bypass_spec_v1(void)
> +{
> +       return true;
> +}
> +
> +bool bpf_jit_bypass_spec_v4(void)
> +{
> +       return true;
> +}
> --
> 2.42.0
>
>

