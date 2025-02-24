Return-Path: <bpf+bounces-52340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C5A41FC7
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63131897469
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8923BCF6;
	Mon, 24 Feb 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjqkHba0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A0205AAF;
	Mon, 24 Feb 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402024; cv=none; b=T6WYaI/iZT7ysQJuhmAnq00HuOuOUcosMqeR224TUZdYoVOqdnz5fQ00sfDWfdXspCnrXqEizQtPqFtbSBawNanfZAkInuNuf6Rx5lPpQ4lpOB/Vfs+sAML5bZQuehxsM9vuBriEBe63HEr0E3b97oWG7Qa9XN5VDuqlQ60jAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402024; c=relaxed/simple;
	bh=ZkYg8riK3g+YIJUhasp+/tnIiDVINYAMP80vM8syvUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mH9durmViLEP2a9VXD5Py1EUHFnZR4+VvGSviFaJAwJOar78BGTKhHpu2gNQ18k8PqRbETISABD8tR9kKAjXIpKgqMd9Pg7YVvJBcieHJm4KE8oXlRLoqku6joLaa4P5JsdarbETIv9VAY51f90tw+Izr8P07rpbcYp8FZe+G7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjqkHba0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7240DC4CED6;
	Mon, 24 Feb 2025 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740402023;
	bh=ZkYg8riK3g+YIJUhasp+/tnIiDVINYAMP80vM8syvUI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EjqkHba0WU1jmT/H2NcmNT7qlZFOYr+PgMuGNJ6cSz7SGMl+qqQSfu5/be83sOU5l
	 J5c1alTfOsnp8FAFII+rCxK2HJsUJcWF8FtXbUcHYjvDRXZZwbFGCMnTmJkf9UDVZH
	 coiCFAWI49hV8N0X0TmjlvKPktaMXY4dIZm3o0M8pcxowUUZYWZBQKGoGTIB5xhmy5
	 ppB3ta5CtIA/t7Se2zAZPKni3Q/0Fl589D4zIe6Fpj0kqVP9w1TpZ18Tk8VJw9uJeE
	 Y7L8bxn36NecDspSKFIosnqLOSwe9mthHWu0lWWP2MrdNScZt25Z0k+pDXsL2ZR6ID
	 49lrz6VYXWMaA==
Message-ID: <870ae0a7-dc04-4ae2-8485-df9db23db697@kernel.org>
Date: Mon, 24 Feb 2025 15:00:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: ethernet: ti: am65_cpsw: move
 am65_cpsw_put_page() out of am65_cpsw_run_xdp()
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Md Danish Anwar <danishanwar@ti.com>, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
 <20250217-am65-cpsw-zc-prep-v1-4-ce450a62d64f@kernel.org>
 <20250218180340.GF1615191@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250218180340.GF1615191@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/02/2025 20:03, Simon Horman wrote:
> On Mon, Feb 17, 2025 at 09:31:49AM +0200, Roger Quadros wrote:
>> This allows us to re-use am65_cpsw_run_xdp() for zero copy
>> case. Add AM65_CPSW_XDP_TX case for successful XDP_TX so we don't
>> free the page while in flight.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> 
> ...
> 
>> @@ -1230,9 +1230,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
>>  		ndev->stats.rx_dropped++;
>>  	}
>>  
>> -	page = virt_to_head_page(xdp->data);
>> -	am65_cpsw_put_page(flow, page, true);
>> -
>>  	return ret;
> 
> It seems that before and after this patch ret is always initialised to
> AM65_CPSW_XDP_CONSUMED and never changed. So it can be removed.
> 
> Given that with this patch the function only returns after the switch
> statement, I think this would be a nice follow-up.
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 20a4fc3e579f..4052c9153632 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -1172,7 +1172,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
>  {
>  	struct am65_cpsw_common *common = flow->common;
>  	struct net_device *ndev = port->ndev;
> -	int ret = AM65_CPSW_XDP_CONSUMED;
>  	struct am65_cpsw_tx_chn *tx_chn;
>  	struct netdev_queue *netif_txq;
>  	int cpu = smp_processor_id();
> @@ -1228,9 +1227,8 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
>  		fallthrough;
>  	case XDP_DROP:
>  		ndev->stats.rx_dropped++;
> +		return AM65_CPSW_XDP_CONSUMED;
>  	}
> -
> -	return ret;
>  }
>  
>  /* RX psdata[2] word format - checksum information */
> 
> ...

Thank you for this suggestion. I will add this cleanup in my next set of patches.

-- 
cheers,
-roger


