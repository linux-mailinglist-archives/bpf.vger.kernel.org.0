Return-Path: <bpf+bounces-9962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C2779F3D2
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 23:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F00B20A63
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 21:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8110B22EFC;
	Wed, 13 Sep 2023 21:30:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017429CA
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 21:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17BE8C433CA;
	Wed, 13 Sep 2023 21:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694640626;
	bh=LXThKj7Ezb5QDDo4BX4Q+8iOUjMVr0VA9vtCmpwOfwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s7lQXOxA4FR47TglrPhqnCPZFpQrMLvQEtejH4TYxBzDeZ7ioM0XvXO1oNaU635bM
	 r1aNubQgcIFMTkCqmCaQtDkFEsxJFFMoDkEnxaTVo1RBmNLJggVCjbIcT241JagML1
	 mn3NVyv0Fl0+I9B344i5G7SrJNvZjRU1CnM4liHxnYlcQquHJc+WbsoHMA9WL74TdL
	 8T+fMvgHNk6w91L2lL8DFHIh0lKH50KKJ0G+fGE9tRdnnuIzd6vVvzb9ffJhEe+CQP
	 ihqebPWLP9u83SUn3NiDQQp/Gtks6PeO/WRKesTgJvp2xwF0dwxbAq1a5DydLV95SI
	 qBMOJ5ksg5Euw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDA80C64459;
	Wed, 13 Sep 2023 21:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] docs/bpf: update out-of-date doc in BPF flow dissector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169464062596.8992.16050814156574407725.git-patchwork-notify@kernel.org>
Date: Wed, 13 Sep 2023 21:30:25 +0000
References: <20230911152353.8280-1-qtian@vmware.com>
In-Reply-To: <20230911152353.8280-1-qtian@vmware.com>
To: Quan Tian <qtian@vmware.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 11 Sep 2023 15:23:53 +0000 you wrote:
> Commit a5e2151ff9d5 ("net/ipv6: SKB symmetric hash should incorporate
> transport ports") removed the use of FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
> in __skb_get_hash_symmetric(), making the doc out-of-date.
> 
> Signed-off-by: Quan Tian <qtian@vmware.com>
> ---
>  Documentation/bpf/prog_flow_dissector.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [bpf] docs/bpf: update out-of-date doc in BPF flow dissector
    https://git.kernel.org/bpf/bpf-next/c/558c50cc3b13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



