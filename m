Return-Path: <bpf+bounces-6592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFC176BAC0
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C58281A55
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638352151D;
	Tue,  1 Aug 2023 17:06:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7431ADE8;
	Tue,  1 Aug 2023 17:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E3FC433C8;
	Tue,  1 Aug 2023 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690909568;
	bh=sZ4PzHpJoI/vSl/ha/rvsLNwNMuvQLxCY3MZ1zjQXV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RidzZ20MXOo0ugw9/gaLsBUWbGrZd2KOyUXBSIdPCivryKHUJ6xanX+r8iabkjmjM
	 QDtIgvsGAJqBQra9h4PtAD5CDLIQXGZLjfyDwMkJLrVYJ3MtZMlHYY56tt39e3KUgy
	 /NWTL5Fxza5ymtZT+asmuHkAB4PmVj9s7HYjooYWb0ufXorcrAmxE3uvyGamYSBywK
	 eb+kw8wFXhPThqnvUFHd2xTKA9mD/483MPk2DaxuwSxyvgc/v1zqDSZLCHV6pvg5mB
	 lnh9WiTczGCvQX/1VW+/f2cxoRi2BNI9ZUCqmw4w3MTMVt6GH6pSNMf1lHrn4smxrx
	 US9/KLqiM16TA==
Message-ID: <a2cf25cd-eb38-b282-a81a-dd9ac1806662@kernel.org>
Date: Tue, 1 Aug 2023 19:06:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 3/3] bnxt_en: Let the page pool manage the DMA
 mapping
To: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, bpf@vger.kernel.org,
 somnath.kotur@broadcom.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230728231829.235716-1-michael.chan@broadcom.com>
 <20230728231829.235716-4-michael.chan@broadcom.com>
 <20230728174212.64000bdc@kernel.org>
 <2eadb48b-2991-7458-16a6-51082ff3ec2c@kernel.org>
 <20230731110008.26e8ce03@kernel.org>
 <CACKFLinHWLMScGbYKZ+zNAn2iV1zqLkNVWDMQwJRZYd-yRiY7g@mail.gmail.com>
 <20230731114427.0da1f73b@kernel.org>
 <CACKFLimJO7Wt90O_F3Nk375rABpAQvKBZhNmBkNzzehYHbk_jA@mail.gmail.com>
 <20230731134430.5e7f9960@kernel.org>
 <CACKFLinG2n1FUiwncVJrWpSLRPvOnaeoBxjfKdgX1kVRHpwXVw@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CACKFLinG2n1FUiwncVJrWpSLRPvOnaeoBxjfKdgX1kVRHpwXVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31/07/2023 23.11, Michael Chan wrote:
> On Mon, Jul 31, 2023 at 1:44 PM Jakub Kicinski <kuba@kernel.org> wrote:
>> tl;dr just set .max_len = PAGE_SIZE and all will be right.
> 
> OK I think I got it now.  The page is only recycled when all the
> fragments are recycled and so we can let page pool DMA sync the whole
> page at that time.

Yes, Jakub is right, I see that now.

When using page_pool "frag" API (e.g. page_pool_dev_alloc_frag) then the
optimization I talked about isn't valid.  We simply have to DMA sync the
entire page, when it gets back to the recycle stage.

--Jesper

