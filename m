Return-Path: <bpf+bounces-71496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4EBF5892
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 11:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8A334FF0C9
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B022E7BD9;
	Tue, 21 Oct 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRGFgEvG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75C7D07D;
	Tue, 21 Oct 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039430; cv=none; b=BwSRFcejENYEb8xVQttuDn2BcrY7Aue18HWP6r2SiI/c9ctr+QB4oR0nD+NxLnAALI4NqiO7RCrvJ3Abh78KN5TRPHNZ+fzqjjaE9evEFPKEdSsg5/Njih/7x9XcalZELdlBXBhFpbsm8KiJ3x2uxeL2Eep2bSBBKHOiM4Bv0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039430; c=relaxed/simple;
	bh=vROLQ/huaW8/CmioOws1Snjr2nLyqHBL1ATXlL1hhH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPfdsirZOwrJb/eJfzendjQ0lJQdYY1+7adHGm4vwEivla/9H9DESrnS8oLEVjzHkzlxGaYMYZ0Ts/VnGdNDodxq7IbSH4VtVKtt0q78iOvROEqzSER1SOk+woUk9Nnv0vdmvKzfW/wfyGcd39wCyv1nuV3XNG3iiepLFC+l5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRGFgEvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2211C4CEF1;
	Tue, 21 Oct 2025 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761039427;
	bh=vROLQ/huaW8/CmioOws1Snjr2nLyqHBL1ATXlL1hhH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GRGFgEvG7nDjyoNfr+98OUc31cYs1vcfeJ1lZ19J39hKo6KNETy4lLfe8i1yrFd2z
	 AEWh7m8gQ3Q0A0brHYhNsr966m+eGOBlduSiyN9Qf+I4zLSYE+dSz9SSC8fuMMS2Bo
	 oAq7+wMNBvMpwh9p9bqypFSReeSKxBwk+l95Ea2CasiTlpqOPT1GYOQiHxaTxXoVy6
	 3PajPbL4ITGPJ1ixgTR6dz8UDX7wKWfJ0qAxIqgbFW6RHjFGPEt9Lx3a0la+alcc5o
	 UwwmcsDehn+kIvOFLk/h/tiGAZnY6BN0qVow27leRxghJGOBkuOSzGBC1UUJcOfZ/n
	 hulvUWugCRQ4Q==
Message-ID: <e0901356-ef48-4652-9ad4-ff85ae07d83a@kernel.org>
Date: Tue, 21 Oct 2025 11:37:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf/cpumap.c: Remove unnecessary TODO comment
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/10/2025 19.02, Mehdi Ben Hadj Khelifa wrote:
> After discussion with bpf maintainers[1], queue_index could
> be propagated to the remote XDP program by the xdp_md struct[2]
> which makes this todo a misguide for future effort.
> 
> [1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
> [2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
> Changelog:
> 
> Changes from v1:
> 
> -Added a comment to clarify that RX queue_index is lost after the frame
> redirection.
> 
> Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706
>   kernel/bpf/cpumap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 703e5df1f4ef..6856a4a67840 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -195,7 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>   
>   		rxq.dev = xdpf->dev_rx;
>   		rxq.mem.type = xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		/* The NIC RX queue_index is lost after the frame redirection
> +		 * but in case of need, it can be passed as a custom XDP
> +		 * metadata via xdp_md struct to the remote XDP program

Argh, saying XDP metadata is accessed via the xdp_md struct is just wrong.

Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> +		 */
>   
>   		xdp_convert_frame_to_buff(xdpf, &xdp);
>   


