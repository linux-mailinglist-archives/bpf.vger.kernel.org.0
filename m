Return-Path: <bpf+bounces-68679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577AB81051
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DC46207F6
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89492F9DAF;
	Wed, 17 Sep 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0dw17rv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2E2BEFEE;
	Wed, 17 Sep 2025 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126652; cv=none; b=aFNdMPMDjuKYs8DCHqnAwzgP6e0kirb2rRsZY9v6dz2s/6A6VgqLmLeqBQQxDwOnlzE8Zz9PqL6m0drkCVn/mQJoyWsYtiy16d9gO/YYp9qAnUg0hVMaewKpXOWF8UrR4sPKEwo9/Cp+djPKFkVSy+ATn1roLibiGryiukhD06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126652; c=relaxed/simple;
	bh=oOv57jTdltw0sx1ngov9VpNZ74f8UyQQx61xBP+Hduk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuPpb7vkeACTI8/w0wKGNxjUc/rYcnPYZEjfvlz9JJje6NKT/w3O7wD1FxPQRRiDRZrlN1QfBcupSk/ybppfY2LhQzcaUHXLMXmIOILUYbxKeRCQxLCm88aydAdxKZmkRAlrVymS3iyRFmrIS/CXYJoeXAFZ1fYS0UIV/6UqsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0dw17rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0489C4CEE7;
	Wed, 17 Sep 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758126651;
	bh=oOv57jTdltw0sx1ngov9VpNZ74f8UyQQx61xBP+Hduk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J0dw17rv74MsGTy8yPkd6qr20W+bPxZu0waVLSWfNvJDCq6OQXroRt1jFVyNrZCz+
	 GFkRIyP+ChzAUd+6mzhmEh8wIECLTzI5QnlmCqdClyTA8/f4XNmEFmS/lbNqjis7Sb
	 CnO61sYqaSBsprm8AEvESkgiSY5CFn/vQCOe4K3gk23It7GiP7Sn5FM6gK3ly5biZ5
	 gNlkXMSFonqJWX0Id7H0zBfooxpkP2THKzyxhFvsGG/CCuWrWT8q+WAlVJ0z0a2ruD
	 OGNX4frZ7IdUOaextLqhEF99CmuJ0tyuLIAnttOxpU0SUq09z7A6WS3O1PEe7vZgEW
	 F++PasY0q5Jxw==
Message-ID: <523d8d6c-de99-435f-a01b-1bac72810d53@kernel.org>
Date: Wed, 17 Sep 2025 17:30:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Fix UAF in get_delegate_value
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917034732.1185429-1-chen.dylane@linux.dev>
 <20250917034732.1185429-2-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250917034732.1185429-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-17 11:47 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> The return value ret pointer is pointing opts_copy, but opts_copy
> gets freed in get_delegate_value before return, fix this by free
> the mntent->mnt_opts strdup memory after show delegate value.
> 
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/token.c | 75 +++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> index 82b829e44c8..05bc76c7276 100644
> --- a/tools/bpf/bpftool/token.c
> +++ b/tools/bpf/bpftool/token.c
> @@ -28,15 +28,14 @@ static bool has_delegate_options(const char *mnt_ops)
>  	       strstr(mnt_ops, "delegate_attachs");
>  }
>  
> -static char *get_delegate_value(const char *opts, const char *key)
> +static char *get_delegate_value(char *opts, const char *key)
>  {
>  	char *token, *rest, *ret = NULL;
> -	char *opts_copy = strdup(opts);
>  
> -	if (!opts_copy)
> +	if (!opts)
>  		return NULL;
>  
> -	for (token = strtok_r(opts_copy, ",", &rest); token;
> +	for (token = strtok_r(opts, ",", &rest); token;
>  			token = strtok_r(NULL, ",", &rest)) {
>  		if (strncmp(token, key, strlen(key)) == 0 &&
>  		    token[strlen(key)] == '=') {
> @@ -44,24 +43,19 @@ static char *get_delegate_value(const char *opts, const char *key)
>  			break;
>  		}
>  	}
> -	free(opts_copy);
>  
>  	return ret;
>  }
>  
> -static void print_items_per_line(const char *input, int items_per_line)
> +static void print_items_per_line(char *input, int items_per_line)
>  {
> -	char *str, *rest, *strs;
> +	char *str, *rest;
>  	int cnt = 0;
>  
>  	if (!input)
>  		return;
>  
> -	strs = strdup(input);
> -	if (!strs)
> -		return;
> -
> -	for (str = strtok_r(strs, ":", &rest); str;
> +	for (str = strtok_r(input, ":", &rest); str;
>  			str = strtok_r(NULL, ":", &rest)) {
>  		if (cnt % items_per_line == 0)
>  			printf("\n\t  ");
> @@ -69,38 +63,39 @@ static void print_items_per_line(const char *input, int items_per_line)
>  		printf("%-20s", str);
>  		cnt++;
>  	}
> -
> -	free(strs);
>  }
>  
> +#define PRINT_DELEGATE_OPT(opt_name) do {		\
> +	char *opts, *value;				\
> +	opts = strdup(mntent->mnt_opts);		\
> +	value = get_delegate_value(opts, opt_name);	\
> +	print_items_per_line(value, ITEMS_PER_LINE);	\
> +	free(opts);					\
> +} while (0)


Thanks! The fix looks OK to me, but why do you need to have
PRINT_DELEGATE_OPT*() as macros? Can't you just use functions instead?

Quentin

