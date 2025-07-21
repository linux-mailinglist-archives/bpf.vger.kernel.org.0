Return-Path: <bpf+bounces-63889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9DB0BF91
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57FF3BBF94
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BC288C05;
	Mon, 21 Jul 2025 09:02:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC91D63E8;
	Mon, 21 Jul 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088576; cv=none; b=dhwArgvP+OiHlH2gqWhgzCCECk5kCF+5unn3nHHQkO1V3m3a/M2o8nQnYFQKARMQq78M9QLSBTykja33/XsIfQMr7V7UFN3PCc8IhOpy3mle1jI9F4X1M/4EzbxvO3c4K1Vth3IPchUirnSFrSUFP055/Xzc9/DQgQ8Kr0269E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088576; c=relaxed/simple;
	bh=ZdThKZSm+1hzPQTXdTtWibDdW5Gde4dZ7oXUpmiIEl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EA7YIOZy5VzqqmOEOl4KoD0oraighhnsn/V8rs2wXpkHLQcZB6wVneFv0ET7OYLa3r/cPEoUz4H/YiygppbATutr/f3NkY7vYoB1UR2AwNZAekCL4cm1Dkdg9eF/pm5sTmEc5+p5hPZHao5wrIohynAWsP7Av1zL5H9FPs6i7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc55eaf.dip0.t-ipconnect.de [93.197.94.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9118D61E64844;
	Mon, 21 Jul 2025 10:56:34 +0200 (CEST)
Message-ID: <8c9e97e4-3590-49a8-940b-717deac0078d@molgen.mpg.de>
Date: Mon, 21 Jul 2025 10:56:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] stmmac: xsk: fix underflow
 of budget in zerocopy mode
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20250721083343.16482-1-kerneljasonxing@gmail.com>
 <20250721083343.16482-2-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250721083343.16482-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jason,


Thank you for your patch.

Am 21.07.25 um 10:33 schrieb Jason Xing:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The issue can happen when the budget number of descs are consumed. As

Instead of “The issue”, I’d use “An underflow …”.

> long as the budget is decreased to zero, it will again go into
> while (budget-- > 0) statement and get decreased by one, so the
> underflow issue can happen. It will lead to returning true whereas the
> expected value should be false.

What is “it”?

> In this case where all the budget are used up, it means zc function

*is* used?

> should return false to let the poll run again because normally we
> might have more data to process.

Do you have a reproducer, you could add to the commit message?

> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f350a6662880..ea5541f9e9a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2596,7 +2596,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>   
>   	budget = min(budget, stmmac_tx_avail(priv, queue));
>   
> -	while (budget-- > 0) {
> +	while (budget > 0) {

So, if the while loop should not be entered with budget being 0, then 
the line could  be changed to `while (--budget > 0) {`? But then it 
wouldn’t be called for budget being 1.

A for loop might be the better choice for a loop with budget as counting 
variable?

>   		struct stmmac_metadata_request meta_req;
>   		struct xsk_tx_metadata *meta = NULL;
>   		dma_addr_t dma_addr;
> @@ -2681,6 +2681,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>   
>   		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
>   		entry = tx_q->cur_tx;
> +
> +		budget--;
>   	}
>   	u64_stats_update_begin(&txq_stats->napi_syncp);
>   	u64_stats_add(&txq_stats->napi.tx_set_ic_bit, tx_set_ic_bit);

Excuse my ignorance, but I do not yet see the problem that the while 
loop is entered and buffer is set to 0. Is it later the return condition?

     return !!budget && work_done;


Kind regards,

Paul

