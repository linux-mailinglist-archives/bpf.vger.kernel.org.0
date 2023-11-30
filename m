Return-Path: <bpf+bounces-16247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE97FEC31
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815E3B20F66
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2AB3A285;
	Thu, 30 Nov 2023 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBncUZil"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA7125CC;
	Thu, 30 Nov 2023 09:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819A0C433C9;
	Thu, 30 Nov 2023 09:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701337926;
	bh=LzqKrUgLw4j75yiV1txmA9X6N3k3T2OcAtPgfftmm5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WBncUZilxTdvamRsjSbeedFFX6SVJOO0yyoeehWV6Uq7n+Yax9HW3AGYHSZLRGGmW
	 UVEUD5QPFXUFQy1Q1a8yvIkf2Rv3YhF902iIpoV7iuWQu3YvjLh1cORYejUGTt5v0E
	 XUMJplcQwXd54ZCIFRk1EhTVdKKFl/Ut81Rta58b6dgUlp55aAsoF4WxvXenhnLyPl
	 pZjPYMlBOUCCFeuHpNwuTXMkBpzLMpTyl/ffV7e1Lz8deo5iP6YnUZLlxLedMAL3mT
	 FGhEo3XuKzqESIekn35qgKtATgk9B2WrX+FCgB/DRUCagDRCvyBLN/5sgslLPNFbQE
	 fQX+ndhqGgObg==
Message-ID: <b8c3196c-b1d8-493c-aff5-cfef4578559d@kernel.org>
Date: Thu, 30 Nov 2023 10:52:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] xdp: rely on skb pointer reference in
 do_xdp_generic and netif_receive_generic_xdp
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
 toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com
References: <cover.1701334869.git.lorenzo@kernel.org>
 <4c96068d965baf3ec40fdc0e98102c1077dbeb07.1701334869.git.lorenzo@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4c96068d965baf3ec40fdc0e98102c1077dbeb07.1701334869.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/30/23 10:11, Lorenzo Bianconi wrote:
> Rely on skb pointer reference instead of the skb pointer in do_xdp_generic and
> netif_receive_generic_xdp routine signatures. This is a preliminary patch to add
> multi-buff support for xdp running in generic mode.
> 
> Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> ---
>   drivers/net/tun.c         |  4 ++--
>   include/linux/netdevice.h |  2 +-
>   net/core/dev.c            | 16 +++++++++-------
>   3 files changed, 12 insertions(+), 10 deletions(-)

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

