Return-Path: <bpf+bounces-5480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3E75B278
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C76281A99
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDE18C0E;
	Thu, 20 Jul 2023 15:24:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC151772A;
	Thu, 20 Jul 2023 15:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D0C433C7;
	Thu, 20 Jul 2023 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689866672;
	bh=pjnKekjE71gAy7Zg6XstIv+bO3ieMLEzUP4PJ4z6uOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/D6JRa9WygFmgZkTLCrBiBZQahul/3Farf9/Mx+xxESjqX4WZNkrFL4aUJpyCXVr
	 xPOxRcDdSOTQ2mp89tl79bwSUCKq98cJVJbNZjfZ3eEcIkv7NI8o9Qph3Erjn0kMUZ
	 bwd5p/mNXN0dCU7OPM4Ooo3c0Of+EqoRfmoUKmGEUguHvcGSaU3Ek5AEW5cdTTreTJ
	 KYhJaxzvDd4adlLHthh9C6y26eCXH+s8CnAa8/lzBZ88t3Em36D7hovjmVySBovTmb
	 gZMxkl+suYqa7X8ldNjGY7JCNCzmkx+U/sE/vdKlt8aZBukg7q82PU9PmEzplXY+db
	 QHCm0tGXd4Qgw==
Date: Thu, 20 Jul 2023 08:24:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
 <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: add XDP_TX feature support
Message-ID: <20230720082431.5428050e@kernel.org>
In-Reply-To: <AM5PR04MB3139D4C0F26B5768784B9CAF883EA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
	<20230719204553.46856b29@kernel.org>
	<AM5PR04MB3139D4C0F26B5768784B9CAF883EA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 07:06:05 +0000 Wei Fang wrote:
> > Are you taking budget into account? When NAPI is called with budget of 0 we
> > are *not* in napi / softirq context. You can't be processing any XDP tx under
> > such conditions (it may be a netpoll call from IRQ context).  
> 
> Actually, the fec driver never takes the budget into account for cleaning up tx BD
> ring. The budget is only valid for rx.

I know, that's what I'm complaining about. XDP can only run in normal
NAPI context, i.e. when NAPI is called with budget != 0. That works out
without any changes on Rx, if budget is zero drivers already don't
process Rx. But similar change must be done on Tx when adding XDP
support. You can still process all normal skb packets on Tx when budget
is 0 (in fact you should), but you _can't_ process any XDP Tx frame.

