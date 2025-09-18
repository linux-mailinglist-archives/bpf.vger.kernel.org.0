Return-Path: <bpf+bounces-68858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA6B86D5A
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 22:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D07BA875
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE230DEDC;
	Thu, 18 Sep 2025 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej9xJCeB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BA2D3732;
	Thu, 18 Sep 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226083; cv=none; b=qr9wl9cA50Lf11OGn317t+VKJblzvr3FU9TOLwAbG0U4LgH4iDU72BspsiMp5bF17YCbm09qAp5dkbbWVrneAs6/ZotckfFv2H/E/EB7maT46ecLMyiYxAX8RbM1snzICELj23QmoLrBibxuj99fe27UrGnq+aLirOlc6lYqGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226083; c=relaxed/simple;
	bh=CJRyTJIRPIX0eh440mEW1jpFJXr/Iju/cx81g5d1C30=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IxAJV6BFR+MD1I9rgWa4FG5W/c1P4MZBPztFDDht0fKOoR4l0033t3SDA+PEs1H4Xzg+2NCxaNIgvbXblpH+u+aohYQlfv9hl4dSQQ9+Ahp+m4M2EPLB+JnRNtoUx0uhS/PyStApgt5h/3Kx170kgPL5QTLhia30Y82i8Xsx8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej9xJCeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCABC4CEE7;
	Thu, 18 Sep 2025 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226082;
	bh=CJRyTJIRPIX0eh440mEW1jpFJXr/Iju/cx81g5d1C30=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ej9xJCeBs6ClvjwIP9iH/tAS6gRbaowVApM9Foi1h0U+6WpQcPTNUfhLDAKYjMqmM
	 DP/rLqwtMJL6BDjJRayI2FwqzS67DeoDcuvMGJVdIdKIbfZFQRjb3xpXSp6j50zAEm
	 5tbwIQKQ121YNfCWxIstNF6xXdo/nJFhfmFTxHUnPygDuNH72U1ZnvcRt8kWO01Z9F
	 7j3iAR3q6FOWKFTTAZO/eiAddO9vreeAgpvo+pyWFjFIHkSKYbSZQpQKwE7zqeeXsM
	 CvgaFQ6tl9PQSRiwy+1c4arJtfoUYm6k6CyU+t+asdY/wnX/hc0H3xm2W8KBm7dMWG
	 d6+1xNUyt5P+w==
Message-ID: <226947cd-a28d-4c09-81cb-0fa0a21c7075@kernel.org>
Date: Thu, 18 Sep 2025 21:07:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: Fix UAF in get_delegate_value
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918120908.1255263-1-chen.dylane@linux.dev>
 <20250918120908.1255263-2-chen.dylane@linux.dev>
Content-Language: en-GB
In-Reply-To: <20250918120908.1255263-2-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-18 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> The return value ret pointer is pointing opts_copy, but opts_copy
> gets freed in get_delegate_value before return, fix this by free
> the mntent->mnt_opts strdup memory after show delegate value.
> 
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/token.c | 90 +++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 55 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> index 82b829e44c8..20c4c78a8a8 100644
> --- a/tools/bpf/bpftool/token.c
> +++ b/tools/bpf/bpftool/token.c


> @@ -69,38 +73,29 @@ static void print_items_per_line(const char *input, int items_per_line)
>  		printf("%-20s", str);
>  		cnt++;
>  	}
> -
> -	free(strs);
>  }
>  
>  #define ITEMS_PER_LINE 4
>  static void show_token_info_plain(struct mntent *mntent)
>  {
> -	char *value;
> +	char *opts, *value;


Thank you! I just have style nits: can you move the declaration of
"opts" and "value" inside of the for loop, please? They're not used
outside of it.


>  
>  	printf("token_info  %s", mntent->mnt_dir);
>  
> -	printf("\n\tallowed_cmds:");
> -	value = get_delegate_value(mntent->mnt_opts, "delegate_cmds");
> -	print_items_per_line(value, ITEMS_PER_LINE);
> -
> -	printf("\n\tallowed_maps:");
> -	value = get_delegate_value(mntent->mnt_opts, "delegate_maps");
> -	print_items_per_line(value, ITEMS_PER_LINE);
> -
> -	printf("\n\tallowed_progs:");
> -	value = get_delegate_value(mntent->mnt_opts, "delegate_progs");
> -	print_items_per_line(value, ITEMS_PER_LINE);
> +	for (size_t i = 0; i < ARRAY_SIZE(sets); i++) {


And could you please move the declaration of variable "i" to the top of
the function, for consistency with the rest of the code?

Same comments for the JSON function.

Thanks,
Quentin

