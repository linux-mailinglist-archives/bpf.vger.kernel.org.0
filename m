Return-Path: <bpf+bounces-6467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C158B76A096
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13BD1C20CCF
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BA19BD5;
	Mon, 31 Jul 2023 18:44:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEB5182C1;
	Mon, 31 Jul 2023 18:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5DAC433C8;
	Mon, 31 Jul 2023 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690829069;
	bh=qHV4en2bRV/oFxzC7wQlH0/1Wep1z8Fl7NZMhJ9TsGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcBCQ3HXh8KcR5L+N8PZO14hhw+0yfKb4XQV7lsBTAmJtcwIat/cCDwYWgc8jn/E3
	 i/DRc8x5t8d2eCUt1XX9JlfaTrR4+ohPGKgZ/GBqGrmTrTyfro58d73AhFFyVq7pDO
	 WGqYSmmzHYBaGntyCmhKBf1hHTgMWxdrqJ8G5U0hC86wmYZKuK4n7mNHpo8rAg2RrD
	 dDb+F7cHdhjzUcUqLQh+PTn9JOmEZ8+gq/rj1Bf3cYJ2uRJQY4b09AKTiQnxbbxX9M
	 wOqjeUToMjhp+py99Ia8F6ihNdbeeXncJe7qlWZo2R+2GDubP0clBlLRUB5FK49Qi6
	 4Hvy9hKxoAm3w==
Date: Mon, 31 Jul 2023 11:44:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 gospo@broadcom.com, bpf@vger.kernel.org, somnath.kotur@broadcom.com, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next 3/3] bnxt_en: Let the page pool manage the DMA
 mapping
Message-ID: <20230731114427.0da1f73b@kernel.org>
In-Reply-To: <CACKFLinHWLMScGbYKZ+zNAn2iV1zqLkNVWDMQwJRZYd-yRiY7g@mail.gmail.com>
References: <20230728231829.235716-1-michael.chan@broadcom.com>
	<20230728231829.235716-4-michael.chan@broadcom.com>
	<20230728174212.64000bdc@kernel.org>
	<2eadb48b-2991-7458-16a6-51082ff3ec2c@kernel.org>
	<20230731110008.26e8ce03@kernel.org>
	<CACKFLinHWLMScGbYKZ+zNAn2iV1zqLkNVWDMQwJRZYd-yRiY7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 11:16:55 -0700 Michael Chan wrote:
> > > Remember pp.max_len is used for dma_sync_for_device.
> > > If driver is smart, it can set pp.max_len according to MTU, as the (DMA
> > > sync for) device knows hardware will not go beyond this.
> > > On Intel "dma_sync_for_device" is a no-op, so most drivers done
> > > optimized for this. I remember is had HUGE effects on ARM EspressoBin board.  
> >
> > Note that (AFAIU) there is no MTU here, these are pages for LRO/GRO,
> > they will be filled with TCP payload start to end. page_pool_put_page()
> > does nothing for non-last frag, so we'll only sync for the last
> > (BNXT_RX_PAGE-sized) frag released, and we need to sync the entire
> > host page.  
> 
> Correct, there is no MTU here.  Remember this matters only when
> PAGE_SIZE > BNXT_RX_PAGE_SIZE (e.g. 64K PAGE_SIZE and 32K
> BNXT_RX_PAGE_SIZE).  I think we want to dma_sync_for_device for 32K in
> this case.

Maybe I'm misunderstanding. Let me tell you how I think this works and
perhaps we should update the docs based on this discussion.

Note that the max_len is applied to the full host page when the full
host page is returned. Not to fragments, and not at allocation.

The .max_len is the max offset within the host page that the HW may
access. For page-per-packet, 1500B MTU this could matter quite a bit,
because we only have to sync ~1500B rather than 4096B.

      some wasted headroom/padding, pp.offset can be used to skip
    /        device may touch this section
   /        /                     device will not touch, sync not needed
  /        /                     /
|**| ===== MTU 1500B ====== | - skb_shinfo and unused --- |
   <------ .max_len -------->

For fragmented pages it becomes:

                         middle skb_shinfo
                        /                         remainder
                       /                               |
|**| == MTU == | - shinfo- |**| == MTU == | - shinfo- |+++|
   <------------ .max_len ---------------->

So max_len will only exclude the _last_ shinfo and the wasted space
(reminder of dividing page by buffer size). We must sync _all_ packet
sections ("== MTU ==") within the packet.

In bnxt's case - the page is fragmented (latter diagram), and there is
no start offset or wasted space. Ergo .max_len = PAGE_SIZE.

Where did I get off the track?

