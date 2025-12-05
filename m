Return-Path: <bpf+bounces-76112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E0DCA8673
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBFA53016BA8
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF52EBB8D;
	Fri,  5 Dec 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STv6bTpk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99B18C2C;
	Fri,  5 Dec 2025 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947197; cv=none; b=JO+RiKsXk/Zn3xPT5G8Ig3woJiO7BMtypleiMGEgchEg8K9DGxrdQ58zwgLIHBQ6ozaUHLZqGvofjTcVpn2Tq763wCgZp3i7za9XZG9g5gEcKYkgWGvw8Rbr4evYUA9/moPFHZz2v5InF9CZgphmCip66TQvH7NTMKuAgoQCFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947197; c=relaxed/simple;
	bh=b8y7t0HVt419GJrTdB6fe/rc/LsR80kjez6e7OYmnaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iDNDyRHo12u4wgPw4uXCFqNFgkUnk/pKN6sVv6hJyKHdOtBPTKt8TKok4NjOVSOHpfjUBFS/bD7CjfJ0NI4zsWSM2HsrchsyXFDj6jp5kyoS9znZxjdX399CiDE010cNt5bD7V7trtCd9EaSDHkWpHFPvc3LhfcWaMWs5tTqu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STv6bTpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836B3C4CEF1;
	Fri,  5 Dec 2025 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764947197;
	bh=b8y7t0HVt419GJrTdB6fe/rc/LsR80kjez6e7OYmnaw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=STv6bTpkZLNdsDqS0unxW0EdSH2sh4EMRNNWLrdekIAlOabtmcD3NcAfOErr4fwsT
	 nPI7c0HK3p5fMDB8UVtfoXpIZ4PWdY/GwjYlZf/fY5ofWoWss+CM/ooHv10EMrWWlJ
	 BB7MNKsPG3pdKstwKnzMPUBQuQReWLkgDCPyNASumdumi/QxIfsnuI6hAZwsa7GR5o
	 X1/y7kdEFH5GxOvAURZ8HiTCmnP6wYdBjFjlui9FM7e923MoYvSvEM7/C0DB1nx21D
	 RKgfmRPDNnOGG9yAqr/v9khXLD5xdGMInefWham5whQjBjrrJB5JTnTfl8XaQ41UAB
	 pYBG0I0zTBDwQ==
Message-ID: <704bea33-84f7-4e20-9298-092eb35fa1ce@kernel.org>
Date: Fri, 5 Dec 2025 15:06:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix build with OpenSSL versions older than 3.0
To: Leo Yan <leo.yan@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>
References: <20251205145506.1270248-1-leo.yan@arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20251205145506.1270248-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2025 14:55, Leo Yan wrote:
> ERR_get_error_all() exists only in OpenSSL 3.0 and later. Older versions
> lack this API, causing build failure:
> 
>   sign.c: In function 'display_openssl_errors':
>   sign.c:40:21: warning: implicit declaration of function 'ERR_get_error_all'; did you mean 'ERR_get_error_line'? [-Wimplicit-function-declaration]
>      40 |         while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
>         |                     ^~~~~~~~~~~~~~~~~
>         |                     ERR_get_error_line
>   LINK    /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/bpftool
>   /usr/lib/gcc/x86_64-alpine-linux-musl/11.2.1/../../../../x86_64-alpine-linux-musl/bin/ld: /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/sign.o: in function `display_openssl_errors.constprop.0':
>   sign.c:(.text+0x59): undefined reference to `ERR_get_error_all'
>   collect2: error: ld returned 1 exit status
> 
> Use the deprecated ERR_get_error_line_data() for OpenSSL < 3.0, and keep
> using ERR_get_error_all() when available.
> 
> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/bpftool/sign.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> index b34f74d210e9..c98edd6d1dde 100644
> --- a/tools/bpf/bpftool/sign.c
> +++ b/tools/bpf/bpftool/sign.c
> @@ -37,7 +37,11 @@ static void display_openssl_errors(int l)
>  	int flags;
>  	int line;
>  
> +#if OPENSSL_VERSION_MAJOR >= 3
>  	while ((e = ERR_get_error_all(&file, &line, NULL, &data, &flags))) {
> +#else
> +	while ((e = ERR_get_error_line_data(&file, &line, &data, &flags))) {
> +#endif
>  		ERR_error_string_n(e, buf, sizeof(buf));
>  		if (data && (flags & ERR_TXT_STRING)) {
>  			p_err("OpenSSL %s: %s:%d: %s", buf, file, line, data);


Thanks, but this should be addressed in bpf-next already, see commit
90ae54b4c7ec ("bpftool: Allow bpftool to build with openssl < 3")

Quentin

