Return-Path: <bpf+bounces-15076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D917EB70E
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16CE1C20AF3
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 19:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A426AEE;
	Tue, 14 Nov 2023 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="fOWsnsVq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D426AE2
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 19:56:38 +0000 (UTC)
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3958AB7
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fdowuEcvAykrFJkQAGLBg3j2hSRDYUesyy5fVvsNf+4=; b=fOWsnsVq0grLXCL+xW7M/JFLUU
	y6lRlBtazw86Rtnc0vqf62o34xsXUBNDEHjII5aWGPnVzV8sOJJoefsAwoeLE3yZrhuxI+kqkz8B/
	ui2yL0rnKnBCapt8FsolygppV2G3KDiDjgqDAxBByi1V8TdDxF9Pf13Y/+bngJ2q4DD4=;
Received: from [88.117.50.201] (helo=[10.0.0.160])
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1r2yu1-0003aI-2j;
	Tue, 14 Nov 2023 20:16:49 +0100
Message-ID: <520ef11d-6433-465e-867b-13f8f571828e@engleder-embedded.com>
Date: Tue, 14 Nov 2023 20:16:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] igc: Simplify setting flags in the TX data
 descriptor
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, sasha.neftin@intel.com,
 richardcochran@gmail.com, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20231114183640.1303163-1-anthony.l.nguyen@intel.com>
 <20231114183640.1303163-2-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20231114183640.1303163-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 14.11.23 19:36, Tony Nguyen wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> We can re-use the IGC_SET_FLAG() macro to simplify setting some values
> in the TX data descriptor. With the macro it's easier to get the
> meaning of the operations.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index e9bb403bbacf..7059710154eb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1299,14 +1299,12 @@ static void igc_tx_olinfo_status(struct igc_ring *tx_ring,
>   	u32 olinfo_status = paylen << IGC_ADVTXD_PAYLEN_SHIFT;
>   
>   	/* insert L4 checksum */
> -	olinfo_status |= (tx_flags & IGC_TX_FLAGS_CSUM) *
> -			  ((IGC_TXD_POPTS_TXSM << 8) /
> -			  IGC_TX_FLAGS_CSUM);
> +	olinfo_status |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_CSUM,
> +				      (IGC_TXD_POPTS_TXSM << 8));
>   
>   	/* insert IPv4 checksum */
> -	olinfo_status |= (tx_flags & IGC_TX_FLAGS_IPV4) *
> -			  (((IGC_TXD_POPTS_IXSM << 8)) /
> -			  IGC_TX_FLAGS_IPV4);
> +	olinfo_status |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_IPV4,
> +				      (IGC_TXD_POPTS_IXSM << 8));
>   
>   	tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
>   }

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

