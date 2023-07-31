Return-Path: <bpf+bounces-6461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5DE769FAD
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 19:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85FB1C20C59
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 17:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF21D308;
	Mon, 31 Jul 2023 17:47:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3B1D2F9;
	Mon, 31 Jul 2023 17:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB72FC433C8;
	Mon, 31 Jul 2023 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690825633;
	bh=ZBua9lJdWc6cRzSkeHjDZtU6jeZysro2OPdsPkDUhW4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=scFXoNgZMkLZPc/j6GIm15p0xNd9xRGNfm7tYJreVEkXAYyTR1Lc1qAl1s2O7inFU
	 lVGnhqzM6YDqlwcJ6kXdTN4lYX1U9tOFLlbWhcr1lq2mykn0orFP1Zki9lS0K6JMCE
	 aeLFmMLYyZ2OGZCMxYydt2EQ/7zfL/0GO+04VUb0ngWW3VAKXnNfJA2XxzNARQfxLY
	 EnSVU1yChPwYA8/SuyNZAXjA4MaZBTyFH3nZAo4Kj/85kFmiujTMTiVcu7ud9VOLoi
	 mO5T/9Ey0blIDHm56Sbp6zSswrvzQV3ga5eDdrQwsv5ZNJ2/qqrpBwMET4H/VsmKHQ
	 qodAPo+zYUW7Q==
Message-ID: <2eadb48b-2991-7458-16a6-51082ff3ec2c@kernel.org>
Date: Mon, 31 Jul 2023 19:47:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next 3/3] bnxt_en: Let the page pool manage the DMA
 mapping
To: Jakub Kicinski <kuba@kernel.org>, Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, bpf@vger.kernel.org,
 somnath.kotur@broadcom.com, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230728231829.235716-1-michael.chan@broadcom.com>
 <20230728231829.235716-4-michael.chan@broadcom.com>
 <20230728174212.64000bdc@kernel.org>
Content-Language: en-US
In-Reply-To: <20230728174212.64000bdc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/07/2023 02.42, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 16:18:29 -0700 Michael Chan wrote:
>> +	pp.dma_dir = bp->rx_dir;
>> +	pp.max_len = BNXT_RX_PAGE_SIZE;
> 
> I _think_ you need PAGE_SIZE here.
> 

I actually think pp.max_len = BNXT_RX_PAGE_SIZE is correct here.
(Although it can be optimized, see below)

> This should be smaller than PAGE_SIZE only if you're wasting the rest
> of the buffer, e.g. MTU is 3k so you know last 1k will never get used.
> PAGE_SIZE is always a multiple of BNXT_RX_PAGE so you waste nothing.
> 

Remember pp.max_len is used for dma_sync_for_device.
If driver is smart, it can set pp.max_len according to MTU, as the (DMA
sync for) device knows hardware will not go beyond this.
On Intel "dma_sync_for_device" is a no-op, so most drivers done
optimized for this. I remember is had HUGE effects on ARM EspressoBin board.


> Adding Jesper to CC to keep me honest.

Adding Ilias to keep me honest ;-)

To follow/understand these changes, reviewers need to keep the context
of patch 1/3 in mind [1].

[1] 
https://lore.kernel.org/all/20230728231829.235716-2-michael.chan@broadcom.com/


> 
>> +	pp.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> 

--Jesper



