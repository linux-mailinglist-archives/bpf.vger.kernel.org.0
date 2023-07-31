Return-Path: <bpf+bounces-6462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B7A769FE8
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 20:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CB11C20C7A
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68401D31B;
	Mon, 31 Jul 2023 18:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA31DDC0;
	Mon, 31 Jul 2023 18:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DB8C433C8;
	Mon, 31 Jul 2023 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690826409;
	bh=p42uMQHbDP1vqcRr05kx8p7pGlX8j48JN338Zt/miu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jSh3v6vqFcjaHRAEmX/R0gA5iaVXX9oVz7T/uZ6U2RF2RPbQPkOHdexgQf5tgpqF2
	 1TgDCtVKUExqNXZPn5YVx5cJUyGKO/rgC4ZVWy7k0Br7Wpp1V2S5tBz9+wiGIJEfMM
	 mbuJPtqpuWX+EqXbGSPP7ljX+VqALGT7/Jx5wgIsCgZn+3KfkH0U67xeKizUPkT38R
	 OIYzBTvjSCZ5RaqLMV++RltOEmzHa0QE3wwv3Hzcc58RNkG8u8l9E65B+tEWXngwvt
	 uSS7idy2mrjqYX8hKobndYXAorVdEa9Kk3Cbir+nbJZRi7iYCndEJbTZEpQoyv3RxB
	 j/CnWapzf+EwQ==
Date: Mon, 31 Jul 2023 11:00:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 gospo@broadcom.com, bpf@vger.kernel.org, somnath.kotur@broadcom.com, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next 3/3] bnxt_en: Let the page pool manage the DMA
 mapping
Message-ID: <20230731110008.26e8ce03@kernel.org>
In-Reply-To: <2eadb48b-2991-7458-16a6-51082ff3ec2c@kernel.org>
References: <20230728231829.235716-1-michael.chan@broadcom.com>
	<20230728231829.235716-4-michael.chan@broadcom.com>
	<20230728174212.64000bdc@kernel.org>
	<2eadb48b-2991-7458-16a6-51082ff3ec2c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 19:47:08 +0200 Jesper Dangaard Brouer wrote:
> > This should be smaller than PAGE_SIZE only if you're wasting the rest
> > of the buffer, e.g. MTU is 3k so you know last 1k will never get used.
> > PAGE_SIZE is always a multiple of BNXT_RX_PAGE so you waste nothing.
> 
> Remember pp.max_len is used for dma_sync_for_device.
> If driver is smart, it can set pp.max_len according to MTU, as the (DMA
> sync for) device knows hardware will not go beyond this.
> On Intel "dma_sync_for_device" is a no-op, so most drivers done
> optimized for this. I remember is had HUGE effects on ARM EspressoBin board.

Note that (AFAIU) there is no MTU here, these are pages for LRO/GRO,
they will be filled with TCP payload start to end. page_pool_put_page()
does nothing for non-last frag, so we'll only sync for the last
(BNXT_RX_PAGE-sized) frag released, and we need to sync the entire 
host page.

