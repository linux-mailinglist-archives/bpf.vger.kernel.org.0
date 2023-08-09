Return-Path: <bpf+bounces-7277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7434774FA3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 02:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F58D2819E6
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4717A1C9F8;
	Wed,  9 Aug 2023 00:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB71C9F7
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ADAEC433C9;
	Wed,  9 Aug 2023 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691539221;
	bh=h55yguMQ1wZb0p1bZTcCvBVra0FVTIWr0k7O1wUFqwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RBE74BJOiuN2sz7GlWRuuU4nWuBmgjuhRbpjnr9vn1PoTOaBS7UdixiUs5xrwPJFF
	 JI0PVSbzYD9czWzjtwekUc9Rty2SsnGFEQgEat/Y0xFYnFxoCRaRVZAvf5GWXkFgHH
	 Tu/2rljYgmBgmWoeycOORnhD7O2qXFfk/6fQf6BOhMMccJAzg0Qg/OdaenbOP6heFw
	 43Vfpm/wE3XX4cD6w+u1dBpTUP7mBW7cJEdEVWGsDp8c3rg6aYReLJ+ENb9gLPfTUl
	 uOws5vmQgK2Oqh5gneQH+k9A/afTcR9XIk5TdB5ya1pGXv5AQ78vp/5xflGlmY3QE0
	 Rd/zBeCFhXZ5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50E59C395C5;
	Wed,  9 Aug 2023 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: remove duplicated functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153922132.6015.12356699036650946655.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 00:00:21 +0000
References: <20230808162858.326871-1-thinker.li@gmail.com>
In-Reply-To: <20230808162858.326871-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  8 Aug 2023 09:28:58 -0700 you wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The file cgroup_tcp_skb.c contains redundant implementations of the similar
> functions (create_server_sock_v6(), connect_client_server_v6() and
> get_sock_port_v6()) found in network_helpers.c. Let's eliminate these
> duplicated functions.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: remove duplicated functions
    https://git.kernel.org/bpf/bpf-next/c/61e4c165fb8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



