Return-Path: <bpf+bounces-13957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588807DF57E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B865B212F6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AE21B29D;
	Thu,  2 Nov 2023 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3WQnene"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B291A282;
	Thu,  2 Nov 2023 15:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E5A0C433CA;
	Thu,  2 Nov 2023 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698937224;
	bh=/pwXL3xPFaDrTXVpsvGKDsQbN572XgEVZY6X5R/2wv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q3WQnener8mT20A0H8cb6McxoU2dvu1vrkXKZSFMhnYLH8XHSHzLrPB7dKGWPOSq+
	 Ck0+6Nw1+9v3RRv/+JJQw8Jyv31S98tgeDM/XR45xeDMCFYMEEmsTryDrQwoJi19mQ
	 ogtUzTX3ubjslziGZ3wnu77O1xFLyv77cpXzwEJi4AbVXyvv9XE0mT3flc9zJQ+f4Z
	 MT9IivVaWiVULj6OP5vW+bnjoG1vikPy8yRoaL3H5WvUjozXyujHzdne7wL0HJjBta
	 NxFn+kqeO14RGTedQOHwUsdDPmfMY0VmSCG1N4PIhPD4jlP8N4B+yA5iczAILyhW67
	 hXMBWmo42pBuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03A44C395FC;
	Thu,  2 Nov 2023 15:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Fix broken build where char is unsigned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169893722400.13991.10009432921960035904.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 15:00:24 +0000
References: <20231102103537.247336-1-bjorn@kernel.org>
In-Reply-To: <20231102103537.247336-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, bjorn@rivosinc.com,
 ast@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, larysa.zaremba@intel.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Nov 2023 11:35:37 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are architectures where char is not signed. If so, the following
> error is triggered:
> 
>   | xdp_hw_metadata.c:435:42: error: result of comparison of constant -1 \
>   |   with expression of type 'char' is always true \
>   |   [-Werror,-Wtautological-constant-out-of-range-compare]
>   |   435 |         while ((opt = getopt(argc, argv, "mh")) != -1) {
>   |       |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~
>   | 1 error generated.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Fix broken build where char is unsigned
    https://git.kernel.org/bpf/bpf/c/d84b139f53e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



