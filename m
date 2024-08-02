Return-Path: <bpf+bounces-36328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE080946632
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 01:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C68C283634
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A50F13B28D;
	Fri,  2 Aug 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="mWWpur2v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77392B67E;
	Fri,  2 Aug 2024 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641684; cv=none; b=OJ+XEbySUl8EABt0peWFEZtTVAQFGeA2TvOI45f9S8I9aZHFI3d2ZAiPONNsRk6JJBFJvphmT23P4pZYR3+rraBew5WbWEK8b6vMLSW1ljqukFOtQ9rSiToQnYJv8iulIQbJwOikWnffC7F/lsmoC/W1492ajSBXzoThknuScW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641684; c=relaxed/simple;
	bh=3Dt3rP3cBNyiNx8q6SWdzLDhWb+b6sCffZ8eBEtclM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5b2YBNrG67Oizvdr+cSkjSkyUMMHWl7PMqK6zeoCaupZhKvJT4JdqpT/k1dcrA3WnvxIySA4be/E5XI5N5YO+gM3VnfNE+owKhDq7xxhHmRv2yEGdzhdq80vwEKT7Kr4sabds+ceB8I0J1Z2JIsMjERczkkIpKm8mdURJaRa0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=mWWpur2v; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Asq92kUoORZTc3wQnPiSj6dveDoW9X+Fb+nu6DxMHzs=; b=mWWpur2vFEFFWGlnrjuEaPkCEC
	Win1kuMgBdbpZ1+xYJGzL94BaAaG3sNBI9oYxyxvnXc+pL3dczvXq7z86yIOjywAoN1SfN3cZQm2S
	oxEoDgG1Dk8IfttnRSGN40RSe/lmDXqe4Hzl41xOfAqAC/ONzaTrpGzD2GQZk5pfAlkDhQGGDu91T
	O50MrUVVDMK6SeMzbFJpLnLp8Vbp5Zi24+pSsuX8V/YmyQfF8zIKbqfXkudTQeU/Xs/exxLsmmYAc
	O5TunBRg1MyWyRMFqqmORqlqt7NVORq978w8/qI0BVdEMh+bXO/VHKcEVUlI3Jl52lcTCciSKIbM5
	/l7bhgXA==;
Received: from [2001:9e8:9c5:5401:3235:adff:fed0:37e6] (port=45440 helo=lindesnes.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1sa1my-002EZG-E9;
	Sat, 03 Aug 2024 01:34:24 +0200
Date: Sat, 3 Aug 2024 01:34:19 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH] kbuild: pahole-version: avoid errors if executing fails
Message-ID: <20240803-axiomatic-wallaby-of-courtesy-7d2ffa@lindesnes>
References: <20240728125527.690726-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728125527.690726-1-ojeda@kernel.org>

On Sun, Jul 28, 2024 at 02:55:27PM +0200, Miguel Ojeda wrote:
> Like patch "rust: suppress error messages from
> CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT" [1], do not assume the file existing
> and being executable implies executing it will succeed. Instead, bail
> out if executing it fails for any reason.
> 
> For instance, `pahole` may be built for another architecture, may be a
> program we do not expect or may be completely broken:
> 
>     $ echo 'bad' > bad-pahole
>     $ chmod u+x bad-pahole
>     $ make PAHOLE=./bad-pahole defconfig
>     ...
>     ./bad-pahole: 1: bad: not found
>     init/Kconfig:112: syntax error
>     init/Kconfig:112: invalid statement
> 
> Link: https://lore.kernel.org/rust-for-linux/20240727140302.1806011-1-masahiroy@kernel.org/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/pahole-version.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/pahole-version.sh b/scripts/pahole-version.sh
> index f8a32ab93ad1..a35b557f1901 100755
> --- a/scripts/pahole-version.sh
> +++ b/scripts/pahole-version.sh
> @@ -5,9 +5,9 @@
>  #
>  # Prints pahole's version in a 3-digit form, such as 119 for v1.19.
>  
> -if [ ! -x "$(command -v "$@")" ]; then
> +if output=$("$@" --version 2>/dev/null); then
> +	echo "$output" | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'
> +else
>  	echo 0
>  	exit 1
>  fi
> -
> -"$@" --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'
> 
> base-commit: 256abd8e550ce977b728be79a74e1729438b4948
> -- 
> 2.45.2
> 

thanks, looks good to me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

