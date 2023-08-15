Return-Path: <bpf+bounces-7797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79277C8A8
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 09:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091751C20C7A
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B788FAD5A;
	Tue, 15 Aug 2023 07:39:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E96613B;
	Tue, 15 Aug 2023 07:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D60C433C7;
	Tue, 15 Aug 2023 07:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692085150;
	bh=rCqZCoD8GYMxT8ghf9mzmgtDV/HSiAPVnrB3VXhlAKE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EfdJgRsFIx3k3dwgPMxxbHsQDD10+6Ar94HLm00OuQCYEn62QTJri0eQIfU9cYPms
	 f2rMg0tga9PhT7McysLTv/NMF4nMLESuQxoD0SXjr/6AHOl6TUX2sgPqfOHlvNFiDR
	 +0GL6rHnJb223wTjNTs9gXcAbj/jH8pUXBf0PWHHWrsL+Sk43WNKyC+pWqKHm/GwYm
	 B2Ju9d9DmOuKriwJPHwXRX0mMzAg85S4f1ZecBQAXXT7QPqrMqP/lJi8qyS37ZFmxr
	 OMpol2yhjOfJgAxE/tKE5mL3IXpIRcW1sfAuARxF+PHLCJ965BY5Mv7jiXYsrHKKKm
	 S5pIbRa3oPE5w==
Message-ID: <b2ce9811-b001-d235-d74f-7db8b052b9cd@kernel.org>
Date: Tue, 15 Aug 2023 09:39:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: linux-imx@nxp.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V6 net-next 0/2] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, larysa.zaremba@intel.com,
 aleksander.lobakin@intel.com, jbrouer@redhat.com, netdev@vger.kernel.org
References: <20230815051955.150298-1-wei.fang@nxp.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230815051955.150298-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/08/2023 07.19, Wei Fang wrote:
> This patch set is to support the XDP_TX feature of FEC driver, the first
> patch is add initial XDP_TX support, and the second patch improves the
> performance of XDP_TX by not using xdp_convert_buff_to_frame(). Please
> refer to the commit message of each patch for more details.
> 
> Wei Fang (2):
>    net: fec: add XDP_TX feature support
>    net: fec: improve XDP_TX performance
> 
>   drivers/net/ethernet/freescale/fec.h      |   6 +-
>   drivers/net/ethernet/freescale/fec_main.c | 187 +++++++++++++++-------
>   2 files changed, 132 insertions(+), 61 deletions(-)
> 

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

