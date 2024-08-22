Return-Path: <bpf+bounces-37821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD3A95ACEB
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 07:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D772816F9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 05:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D7F61FCF;
	Thu, 22 Aug 2024 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XVS3x+Gq"
X-Original-To: bpf@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-65.smtpout.orange.fr [80.12.242.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14A2E3EE;
	Thu, 22 Aug 2024 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304948; cv=none; b=d+dKlwkYOutUSsd7HucrZuxxL5uh1wxUZxyOHjkJD1QJi6GyV0nlrQdhuuAajU3lm1RE/a2uYO3IrFShdNbCY0p+NANb7/4BuTzkGuRvJpe1XqqfWuhdDTdueM3RCk+44bq1bmCAf95u2URWrsB8xY4TPcU8jqHRGftkBbLWRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304948; c=relaxed/simple;
	bh=XdvD1KyMTUI1+9GAfEn02LHXODNszkiZ2XbS5NvGUqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/3fNyxYUXdgNEGvcoeYzZRKnLNDWtrQvunDOTqaHSSZ6QX0qZkc2Zbb2duHZy6VcL3QBP3CR73BWVD3SzPWa+FL50kx5tU18MYP8DLEefjQUnN6ndgaEkSsEx2ajbQ0XF/EuzCStq26RImnWsc3pV8bqgqB3ezkAIK/vBCUBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XVS3x+Gq; arc=none smtp.client-ip=80.12.242.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id h0Sesc5R58iG0h0Sfsuo75; Thu, 22 Aug 2024 07:34:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724304874;
	bh=BmQSPiNuluw12WlvUYDCD0UY6O2GPBeyKleY3PHQSBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XVS3x+Gqr0Umk1fLe69p3azBWSp7OIVtY5YHyJNxNu1dJSO61RJp8dcKsElv+GbYF
	 TwBhBsmCh8HeTNa34OXkw3rtMtAKRPVvJaeMdI7yanvsk/0480JZvCLdv5xUtB+W1K
	 VIAZOa2lX+eHsKnoZV2nVK3PriXSOSuLRPofDa8THYd3fq6oYkJj79UXGD8ibFfORJ
	 Bm70SDhwdP6Wv/lAvy1C5sQW2x+qP6IVUO/1QIHsVSzi4cQbsBGx9gwdH8/yIPHMUm
	 YkEZf5jix0ElLNeYUXTD7T3bgekagtN1gaKbeO2l4ahUvOyoRw0bMKPaBtrh2VmUNr
	 MOdFJBuAcJkjA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 22 Aug 2024 07:34:34 +0200
X-ME-IP: 90.11.132.44
Message-ID: <1fe20e5e-1c90-4029-9d40-625ec3bb3248@wanadoo.fr>
Date: Thu, 22 Aug 2024 07:34:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mana: Fix race of mana_hwc_post_rx_wqe and new
 hwc response
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, decui@microsoft.com, edumazet@google.com,
 hawk@kernel.org, jesse.brandeburg@intel.com, john.fastabend@gmail.com,
 kuba@kernel.org, kys@microsoft.com, leon@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, longli@microsoft.com, netdev@vger.kernel.org,
 olaf@aepfle.de, pabeni@redhat.com, paulros@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 stable@vger.kernel.org, stephen@networkplumber.org, tglx@linutronix.de,
 vkuznets@redhat.com, wei.liu@kernel.org
References: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1724272949-2044-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 22:42, Haiyang Zhang a écrit :
> The mana_hwc_rx_event_handler() / mana_hwc_handle_resp() calls
> complete(&ctx->comp_event) before posting the wqe back. It's
> possible that other callers, like mana_create_txq(), start the
> next round of mana_hwc_send_request() before the posting of wqe.
> And if the HW is fast enough to respond, it can hit no_wqe error
> on the HW channel, then the response message is lost. The mana
> driver may fail to create queues and open, because of waiting for
> the HW response and timed out.
> Sample dmesg:
> [  528.610840] mana 39d4:00:02.0: HWC: Request timed out!
> [  528.614452] mana 39d4:00:02.0: Failed to send mana message: -110, 0x0
> [  528.618326] mana 39d4:00:02.0 enP14804s2: Failed to create WQ object: -110
> 
> To fix it, move posting of rx wqe before complete(&ctx->comp_event).
> 
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
> ---
>   .../net/ethernet/microsoft/mana/hw_channel.c  | 62 ++++++++++---------
>   1 file changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index cafded2f9382..a00f915c5188 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -52,9 +52,33 @@ static int mana_hwc_verify_resp_msg(const struct hwc_caller_ctx *caller_ctx,
>   	return 0;
>   }
>   
> +static int mana_hwc_post_rx_wqe(const struct hwc_wq *hwc_rxq,
> +				struct hwc_work_request *req)
> +{
> +	struct device *dev = hwc_rxq->hwc->dev;
> +	struct gdma_sge *sge;
> +	int err;
> +
> +	sge = &req->sge;
> +	sge->address = (u64)req->buf_sge_addr;
> +	sge->mem_key = hwc_rxq->msg_buf->gpa_mkey;
> +	sge->size = req->buf_len;
> +
> +	memset(&req->wqe_req, 0, sizeof(struct gdma_wqe_request));
> +	req->wqe_req.sgl = sge;
> +	req->wqe_req.num_sge = 1;
> +	req->wqe_req.client_data_unit = 0;

Hi,

unrelated to your patch, but this initialization is useless, it is 
already memset(0)'ed a few lines above.
So why client_data_unit and not some other fields?

> +
> +	err = mana_gd_post_and_ring(hwc_rxq->gdma_wq, &req->wqe_req, NULL);
> +	if (err)
> +		dev_err(dev, "Failed to post WQE on HWC RQ: %d\n", err);
> +	return err;
> +}

...

Just my 2c.

CJ



