Return-Path: <bpf+bounces-60729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD47ADB3CE
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9103F3BCB2F
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8C1DF991;
	Mon, 16 Jun 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USzhiD1y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F251C1F05;
	Mon, 16 Jun 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083892; cv=none; b=lwzNwWd8LSUGc2Qk3gi+6yM9Y5X8XOFa8bfSEMp0NjwnsSMC5kJNSHnYWJ9glEBZA2mHZOv8yAQZ2yVbMFzgBtCypqmum/CHliparf87nn59zV2/Tia4S3U50x+jz1lMPQm1ZpHgIEzSn7bBXTs4TjBoeHjruXiCQ/wC/qMjTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083892; c=relaxed/simple;
	bh=K551WMibwyNCc1XsYLdjvF/RQZ0HcqwJOBhxtwqpzS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r44JrFHi4cyOQIHDBqHgmGgM+RT+YRHC5oxlnpfgFtc6sFm/4Nxu54bvybQLEr92cZq+UEFK0eQbkr+l4SzailOAy86ZjfEePMAGC3p8VW+6faF68TZiU0P/VyKt1V+iHItZMTf38Q2Mcwg/nNfsXbcFFUsvQ75gCUJpMj5wV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USzhiD1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08BBC4CEEA;
	Mon, 16 Jun 2025 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750083891;
	bh=K551WMibwyNCc1XsYLdjvF/RQZ0HcqwJOBhxtwqpzS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=USzhiD1yDs73eMFsIUx8vpRR+wg8bzJxiQAB9C3xehUkgYzqXC7YBpiR/HdtrHzt/
	 qF7zBZtWpb4tAMlIHbmfOMWQtBQVZZ2Zrcf8Vo+5MqTTHspphrqCC2HAl6g6SBMMYN
	 CDRvHv35qncpguqzpmXvLyIW6pcsTHYFYrE5gZhkW6+yVADHKI81F8WqcNhpQ/wmHc
	 ow0BgGLrWrmU41xu6bnwpdxBDpb7xAswQxNgkZmeSVFAdmHgHUFWdlyG4A96EsWj4I
	 j3yzuFQBSAEwOcbQEXirQRtdODPD2pC1Owtw+tOaNZbl3qxS/bDanSHC8Zj1o9A3H/
	 CBXbCzxPcMUuQ==
Message-ID: <47585e99-062b-4745-bbd9-b48e734bc631@kernel.org>
Date: Mon, 16 Jun 2025 15:24:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Fix JSON writer resource leak in version command
To: Yuan Chen <chenyuan_fl@163.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenyuan <chenyuan@kylinos.cn>
References: <20250616135014.12327-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250616135014.12327-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-06-16 09:50 UTC-0400 ~ Yuan Chen <chenyuan_fl@163.com>
> From: chenyuan <chenyuan@kylinos.cn>
> 
> When using `bpftool --version -j/-p`, the JSON writer object
> created in do_version() was not properly destroyed after use.
> This caused a memory leak each time the version command was
> executed with JSON output.
> 
> Fix: 004b45c0e51a (tools: bpftool: provide JSON output for all possible commands)
> Signed-off-by: chenyuan <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index cd5963cb6058..c8838196a3bd 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -164,6 +164,7 @@ static int do_version(int argc, char **argv)
>  		jsonw_end_object(json_wtr);	/* features */
>  
>  		jsonw_end_object(json_wtr);	/* root object */
> +		jsonw_destroy(&json_wtr);
>  	} else {
>  		unsigned int nb_features = 0;
>  


Good catch, but the fix is not correct:

	$ ./bpftool version -j >/dev/null
	zsh: segmentation fault (core dumped)

This is because we already run jsonw_destroy() at the end of the main()
function when printing the version with "bpftool version", the command
(and not the -V or --version options).

One option would be to add a call at the end of main(), when we call
do_version() because "version_requested" is set:

	if (version_requested) {
		do_version(argc, argv);
		if (json_output)
			jsonw_destroy(&json_wtr);
		return 0;
	}

Thanks,
Quentin

pw-bot: cr

