Return-Path: <bpf+bounces-67096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E948B3DFDB
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A311018999FD
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E089C30DD0D;
	Mon,  1 Sep 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2zTsCzn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990225BF13
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721630; cv=none; b=UDxveFp5ZtaSl4EOkQP9cpgPxIWvqyMNEX0l53FQvfnzSrFmC1XPgA9Y1qaYVGKmxzfdlnw54JkOP96sZ9TSlGSPl2NZiYD52G7WxFQl1JlE1XN+IfwmJTQP0PvxH4IIAJHJ0pktz+CUZZonER2GtbQ6PhjtsN5WweB6RvZWVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721630; c=relaxed/simple;
	bh=6ig6aoqp0iKRAHo/L1Oxu9tI0SR60pc/w8TsTlaI/uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVNqVDmzLCu87N6GTnVsucR8nxv9PtdHZOsVU9wgQTrt7vUS9zNakfKgEWmvMT2oaT78FglFJK7sNEQN1idkuArAS+aeru++HyorSs5Q/g7KvIilyp5UxU9EaacmC2ZYiDJiBy1uq6Hb3uy0PREdhZKu+J8Yu2wwzYfJ4nHd834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2zTsCzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE83FC4CEF0;
	Mon,  1 Sep 2025 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756721630;
	bh=6ig6aoqp0iKRAHo/L1Oxu9tI0SR60pc/w8TsTlaI/uU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G2zTsCznYo/2Mhsxqr5P06YYcRZCDHri99Qej1LDDWIalxbscdg4KfhUw9e7/9mqC
	 voETXi6f0eojQz8Hm8cJaUeviykBYgSD0Yx/ztp9vcfnQSnxevfByyWk+3wrbMVsn7
	 hYVQb8VZ35joj+RkVQlh0lf+ct4tY9EsntBFKDvEXyTw/zx5I3nK63R1TRFBNPRrhM
	 u9FbpLBxZCzIMYAa/R8EqWRXJVLiagufQy4061SFvBa1e/9iA9ZMX8CtK6fJ4RWgh3
	 w8d9QIBUMbsfe9lZZRMgi1Efy17s1iJSNOtYT6Kg5OxiUU2J7lOoKZ7l+UjgplndUV
	 kHn1czFCrqGdw==
Message-ID: <3035adbe-926f-45dc-a424-ef42b12c1067@kernel.org>
Date: Mon, 1 Sep 2025 11:13:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/bpf/bpftool: fix buffer handling in get_fd_type()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev
Cc: bpf@vger.kernel.org
References: <20250901092234.3974937-1-kaushlendra.kumar@intel.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250901092234.3974937-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2025 10:22, Kaushlendra Kumar wrote:
> The current check "if (n == sizeof(buf))" is incorrect for detecting
> buffer overflow from readlink(). When readlink() fills the entire
> buffer, it returns sizeof(buf) but does not null-terminate the string,
> leading to potential buffer overrun in subsequent string operations.
> 
> Fix by changing the condition to "n >= sizeof(buf)" to properly detect
> when the buffer is completely filled, ensuring space is reserved for
> null termination.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  tools/bpf/bpftool/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index b07317d2842f..eebaa6896bd1 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -464,7 +464,7 @@ int get_fd_type(int fd)
>  		p_err("can't read link type: %s", strerror(errno));
>  		return -1;
>  	}
> -	if (n == sizeof(buf)) {
> +	if (n >= sizeof(buf)) {
>  		p_err("can't read link type: path too long!");
>  		return -1;
>  	}


Hi and thanks, but I don't understand the change. On success, readlink()
returns the number of bytes placed in the buffer, which is at most
sizeof(buf) in our case, given that it silently truncates the string if
the buffer is too small. So we can never have "n > sizeof(buf)" here?
The current code looks correct to me.

Did you actually hit the buffer overflow you describe?

Quentin

