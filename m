Return-Path: <bpf+bounces-61351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17041AE5C4F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 08:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A971BC0CCE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 06:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24922417F0;
	Tue, 24 Jun 2025 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoCXzdw1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2A2376EF;
	Tue, 24 Jun 2025 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744774; cv=none; b=ULSy8eH7C4EI3BvYXEx6z1hzgfEfb6wlvKWrePmZsgXLQaMfJWl4jH49BzKIw3f+7Z0bKwFtkETsGSmyh3VzKHYwtdYIRVLIwwcILqZf9LuVjldxng6R5jUL1FSOhliNnWqihMc564yga2oKY3rYLOXuL6imH7yEE3Fm+pqbflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744774; c=relaxed/simple;
	bh=V9eow4rBKvmgqVvTRxHC9LaJnc5DBz8bNExDpZiS8+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxaxHDhCSr8dEHLnkGQQAwF24YdRplRPxUAT0bIzZ8GchkXZnsolYJMqKdV/G7EEU1ZzpJBQ9eLsoE9axMCSIz3C1aasi8/jD5RGXN0aC8m7/3ghoz/McxZYFz97CYydA1fKgEZqeaKiRLXHB+Ot+uDvNXWkTUCWlyI+HkBQRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoCXzdw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD622C4CEE3;
	Tue, 24 Jun 2025 05:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750744773;
	bh=V9eow4rBKvmgqVvTRxHC9LaJnc5DBz8bNExDpZiS8+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hoCXzdw1wg+urhSr5H9B1oP20Moe14xmC7aZ9Zbbo90AtuE9Geb0fhoD6trNcFjah
	 2J+jVba5gKMFH1Zm3uN7uJyTMVIBDsKk5BYyiuqbal5Jh8Ar1nN2+VbZntI3nD8/ug
	 zKn6pTixuAwHcNnO9eVdpotgfkejSD0QN3aaWpORFczsh1FwrantZz3eD65LBmHLJv
	 NtK4KeeQQlFhsrmls5bZFmO9nTmDCRPUwxnqiAypEqF2qVaRvjECos10U5IAq7wNVm
	 lAKYkNV6LbFYNI27n/MO5JZ8fVBASXerVIld7bBZfZl4Q46/OQxMO3XgzBIiwcUuHc
	 Xsaw5e+MsSJaw==
Message-ID: <633986ae-75c4-44fa-96f8-2dde00e17530@kernel.org>
Date: Tue, 24 Jun 2025 07:59:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnxt: properly flush XDP redirect lists
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com
References: <aFl7jpCNzscumuN2@debian.debian>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aFl7jpCNzscumuN2@debian.debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/06/2025 18.06, Yan Zhai wrote:
> We encountered following crash when testing a XDP_REDIRECT feature
> in production:
> 
[...]
> 
>  From the crash dump, we found that the cpu_map_flush_list inside
> redirect info is partially corrupted: its list_head->next points to
> itself, but list_head->prev points to a valid list of unflushed bq
> entries.
> 
> This turned out to be a result of missed XDP flush on redirect lists. By
> digging in the actual source code, we found that
> commit 7f0a168b0441 ("bnxt_en: Add completion ring pointer in TX and RX
> ring structures") incorrectly overwrites the event mask for XDP_REDIRECT
> in bnxt_rx_xdp.

(To Andy + Michael:)
The initial bug was introduced in [1] commit a7559bc8c17c ("bnxt:
support transmit and free of aggregation buffers") in bnxt_rx_xdp()
where case XDP_TX zeros the *event, that also carries the XDP-redirect
indication.
I'm wondering if the driver should not reset the *event value?
(all other drive code paths doesn't)


> We can stably reproduce this crash by returning XDP_TX
> and XDP_REDIRECT randomly for incoming packets in a naive XDP program.
> Properly propagate the XDP_REDIRECT events back fixes the crash.
> 
> Fixes: 7f0a168b0441 ("bnxt_en: Add completion ring pointer in TX and RX ring structures")

We should also add:

Fixes: a7559bc8c17c ("bnxt: support transmit and free of aggregation 
buffers")

  [0] https://git.kernel.org/torvalds/c/7f0a168b0441 - v6.8-rc1
  [1] https://git.kernel.org/torvalds/c/a7559bc8c17c - v5.19-rc1

> Tested-by: Andrew Rzeznik <arzeznik@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 2cb3185c442c..ae89a981e052 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2989,6 +2989,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>   {
>   	struct bnxt_napi *bnapi = cpr->bnapi;
>   	u32 raw_cons = cpr->cp_raw_cons;
> +	bool flush_xdp = false;
>   	u32 cons;
>   	int rx_pkts = 0;
>   	u8 event = 0;
> @@ -3042,6 +3043,8 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>   			else
>   				rc = bnxt_force_rx_discard(bp, cpr, &raw_cons,
>   							   &event);
> +			if (event & BNXT_REDIRECT_EVENT)
> +				flush_xdp = true;
>   			if (likely(rc >= 0))
>   				rx_pkts += rc;
>   			/* Increment rx_pkts when rc is -ENOMEM to count towards
> @@ -3066,7 +3069,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>   		}
>   	}
>   
> -	if (event & BNXT_REDIRECT_EVENT) {
> +	if (flush_xdp) {
>   		xdp_do_flush();
>   		event &= ~BNXT_REDIRECT_EVENT;
>   	}

