Return-Path: <bpf+bounces-64054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26358B0DEA1
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E3CAC4F37
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD128BAB0;
	Tue, 22 Jul 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XayjMF+d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4C24467B;
	Tue, 22 Jul 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194206; cv=none; b=aeBkWNqbvLuhtFuhCWPA5W0Z1QqwQDB/+ykuw7p43kqpH7R8G2iiYFaxNc+5U5X/mG3lqyXn1nom+bWJcSbemIJ80ENg/AH49cvILgi/rOvfOFWiqbkLQE9465k12I2SiOYfp14hrU5cmYAFqw3PmwjpNiMdpVKOCiBDpGvEdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194206; c=relaxed/simple;
	bh=sw3pSkKN3opd9BvlCVElxvzm5q+G/qo5IOBTmgxgWv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEl9Tg9OR1kp6DQYTHdtmZrCssVxrG7izIDd3fkvT2IUVhOjBRMgxLMjT0s3eSJmsonBxKx/KiQcaC8EvVrgMfrGBXlEekBAOq38DgmjpDyPTqbako635jD+ue8HUoxfPmv5xYSKqxbQ5JTBkjsg38rK4PMr73mXKWFM92IiTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XayjMF+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B08C4CEEB;
	Tue, 22 Jul 2025 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753194206;
	bh=sw3pSkKN3opd9BvlCVElxvzm5q+G/qo5IOBTmgxgWv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XayjMF+d4r8mmbPdpksbSurM/2Ov3N7BUDBEOR/rLD3eNbX5H02YfgXICjMegNcD0
	 xASCZneYlmBlNaCPQCy4HSpMCQQMyGw5gz49N7QkIC6VFoONAq6SAGM3jkoYJihh7W
	 MVX4p7449JYsTgdyPY/85oRUJO0UdaaNECzwF3SUIWc0fQBe3q4ak1enYAD2ZQRrcZ
	 eZ+JdwOnwbHvBnkeun6xb2I7WeiNFP2TBzg00rwQu5SoyFevVFSmiv6LNBo3Ti7IUu
	 xBXqp8S1hkq1mxVb5H82UPT50rXCqxuv2MQVss4jPDGEIW5R10z/a8FQt00eSDvfuZ
	 eeVHE+M2vTB4Q==
Message-ID: <aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org>
Date: Tue, 22 Jul 2025 15:23:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] bpftool: Add CET-aware symbol matching for x86/x86_64
 architectures
To: chenyuan_fl@163.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Chen <chenyuan@kylinos.cn>
References: <9f233a20-6649-4796-9ef4-a499382b0006@linux.dev>
 <20250722020000.20037-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250722020000.20037-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-22 10:00 UTC+0800 ~ chenyuan_fl@163.com
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86/x86_64 systems. CET prefixes functions with
> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
> symbol + 4.
> 
> Changed in PATCH v4:
> * Refactor repeated code into a function.
> * Add detection for the x86 architecture.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/link.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index a773e05d5ade..717ca8c5ff83 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -282,6 +282,28 @@ get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
>  	return data;
>  }
>  
> +static bool
> +symbol_matches_target(__u64 sym_addr, __u64 target_addr)
> +{
> +	if (sym_addr == target_addr)
> +		return true;
> +
> +#if defined(__i386__) || defined(__x86_64__)


Do you really need it for __i386__ as well? My understanding was that
CET would apply only to 64-bit?

Thanks,
Quentin

