Return-Path: <bpf+bounces-7878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB577DAAB
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 08:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE26F1C20EE2
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 06:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1E1C8D0;
	Wed, 16 Aug 2023 06:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28AC2CA9;
	Wed, 16 Aug 2023 06:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59A7CC433C9;
	Wed, 16 Aug 2023 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692168621;
	bh=FUbf49Z1DaFu1nEyYQOltWC9yOa/+ECxD8Bpe8XOnmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pI5RpLZHu06vW3blTjo1t/UreW8Qtauu/bRS/v/gvoEXB5mdyiRTqWlItMvKZndi5
	 YvUinX3Zo8AoXy5Y/tzBv/XCGC42r4AC25xNSfi4PlBdQ8zlMzoZn4tDuonOc8byJb
	 6A+Ew5cRmaLaGZGhh3wliRPE4pxxvtRWPsv4PdfjdRDquToaML44DNm+7eYRqQeWxe
	 p4bygPXME9as7XDDGsxFPY2/YchyBltoqvXSR6y3pxYD63XOCGC7sZzI1bTM35SOGO
	 sA220q4Df76wk6oak4XHPRI8fQ+KurZUQ8VTJVJoZoavUEYtlU+EyvS9QshQMKUPPD
	 qI5tnW/hKJsWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40C23C43168;
	Wed, 16 Aug 2023 06:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V6 net-next 0/2] net: fec: add XDP_TX feature support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169216862126.27729.5054786076620361678.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 06:50:21 +0000
References: <20230815051955.150298-1-wei.fang@nxp.com>
In-Reply-To: <20230815051955.150298-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, larysa.zaremba@intel.com,
 aleksander.lobakin@intel.com, jbrouer@redhat.com, netdev@vger.kernel.org,
 linux-imx@nxp.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 13:19:53 +0800 you wrote:
> This patch set is to support the XDP_TX feature of FEC driver, the first
> patch is add initial XDP_TX support, and the second patch improves the
> performance of XDP_TX by not using xdp_convert_buff_to_frame(). Please
> refer to the commit message of each patch for more details.
> 
> Wei Fang (2):
>   net: fec: add XDP_TX feature support
>   net: fec: improve XDP_TX performance
> 
> [...]

Here is the summary with links:
  - [V6,net-next,1/2] net: fec: add XDP_TX feature support
    https://git.kernel.org/netdev/net-next/c/f601899e4321
  - [V6,net-next,2/2] net: fec: improve XDP_TX performance
    https://git.kernel.org/netdev/net-next/c/af6f4791380c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



